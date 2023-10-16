Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFD17CB69C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 00:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbjJPWez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 18:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjJPWey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 18:34:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1507EA1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 15:34:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BC3C433C7;
        Mon, 16 Oct 2023 22:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1697495692;
        bh=FZ9FRkz2iD/S2s21JwYAKU+5RDYOBoUlW8pmKTtVfBo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xyXnGZd4VcZnn6u+N+V0mFtKNz3+M9q4gWHqqW76DgX/RfQ1UT1s49a3cKyEip/Zp
         4KYRRS9gUrhhWi+os8H2Z6J0JyEfIpgljxyHRfepVyXsoL+qUJGFC1GPwit3V5Uqc4
         cRZCStbG9cmgfBaDnVTnFLGQqYimrZS04FdJGxQQ=
Date:   Mon, 16 Oct 2023 15:34:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     David Hildenbrand <david@redhat.com>, <osalvador@suse.de>,
        <dan.j.williams@intel.com>, <vbabka@suse.cz>,
        <mgorman@techsingularity.net>, <aneesh.kumar@linux.ibm.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/sparsemem: fix race in accessing
 memory_section->usage
Message-Id: <20231016153451.09f3677496bd6cc8b1f95daa@linux-foundation.org>
In-Reply-To: <994410bb-89aa-d987-1f50-f514903c55aa@quicinc.com>
References: <1697202267-23600-1-git-send-email-quic_charante@quicinc.com>
        <20231014152532.5f3dca7838c2567a1a9ca9c6@linux-foundation.org>
        <a46cf10b-d852-c671-ee20-40f39bdbceac@redhat.com>
        <994410bb-89aa-d987-1f50-f514903c55aa@quicinc.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 19:08:00 +0530 Charan Teja Kalla <quic_charante@quicinc.com> wrote:

> > From the description, it's not quite clear to me if this was actually
> > hit -- usually people include the dmesg bug/crash info.
> 
> On Snapdragon SoC,  with the mentioned memory configuration of PFN's as
> [ZONE_NORMAL ZONE_DEVICE  ZONE_NORMAL],  we are able to see bunch of
> issues daily while testing on a device farm.
> 
> I note that from next time on wards will send the demsg bug/crash info
> for these type of issues. For this particular issue below is the log.
> Though the below log is not directly pointing to the
> pfn_section_valid(){ ms->usage;}, when we loaded this dump on T32
> lauterbach tool, it is pointing.
> 
> [  540.578056] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000000
> [  540.578068] Mem abort info:
> [  540.578070]   ESR = 0x0000000096000005
> [  540.578073]   EC = 0x25: DABT (current EL), IL = 32 bits
> [  540.578077]   SET = 0, FnV = 0
> [  540.578080]   EA = 0, S1PTW = 0
> [  540.578082]   FSC = 0x05: level 1 translation fault
> [  540.578085] Data abort info:
> [  540.578086]   ISV = 0, ISS = 0x00000005
> [  540.578088]   CM = 0, WnR = 0
> [  540.579431] pstate: 82400005 (Nzcv daif +PAN -UAO +TCO -DIT -SSBS
> BTYPE=--)
> [  540.579436] pc : __pageblock_pfn_to_page+0x6c/0x14c
> [  540.579454] lr : compact_zone+0x994/0x1058
> [  540.579460] sp : ffffffc03579b510
> [  540.579463] x29: ffffffc03579b510 x28: 0000000000235800 x27:
> 000000000000000c
> [  540.579470] x26: 0000000000235c00 x25: 0000000000000068 x24:
> ffffffc03579b640
> [  540.579477] x23: 0000000000000001 x22: ffffffc03579b660 x21:
> 0000000000000000
> [  540.579483] x20: 0000000000235bff x19: ffffffdebf7e3940 x18:
> ffffffdebf66d140
> [  540.579489] x17: 00000000739ba063 x16: 00000000739ba063 x15:
> 00000000009f4bff
> [  540.579495] x14: 0000008000000000 x13: 0000000000000000 x12:
> 0000000000000001
> [  540.579501] x11: 0000000000000000 x10: 0000000000000000 x9 :
> ffffff897d2cd440
> [  540.579507] x8 : 0000000000000000 x7 : 0000000000000000 x6 :
> ffffffc03579b5b4
> [  540.579512] x5 : 0000000000027f25 x4 : ffffffc03579b5b8 x3 :
> 0000000000000001
> [  540.579518] x2 : ffffffdebf7e3940 x1 : 0000000000235c00 x0 :
> 0000000000235800
> [  540.579524] Call trace:
> [  540.579527]  __pageblock_pfn_to_page+0x6c/0x14c
> [  540.579533]  compact_zone+0x994/0x1058
> [  540.579536]  try_to_compact_pages+0x128/0x378
> [  540.579540]  __alloc_pages_direct_compact+0x80/0x2b0
> [  540.579544]  __alloc_pages_slowpath+0x5c0/0xe10
> [  540.579547]  __alloc_pages+0x250/0x2d0
> [  540.579550]  __iommu_dma_alloc_noncontiguous+0x13c/0x3fc
> [  540.579561]  iommu_dma_alloc+0xa0/0x320
> [  540.579565]  dma_alloc_attrs+0xd4/0x108

Thanks.  I added the above info to the changelog, added a cc:stable and
I added a note-to-myself that a new version of the fix may be
forthcoming.

