Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C967C8081FA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 08:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjLGHbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 02:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjLGHbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 02:31:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D09F11F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 23:31:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E745C433CA;
        Thu,  7 Dec 2023 07:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701934307;
        bh=AQ3zRaWsxl12kZ8IbNOLzKipBmlx9MwTy7N5XYMJexA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DfhrW129VGKpUM3TCX2gNqhQjeGfTNPP0SAxtinRm24SLzTOlmXfo800Ka24OTXpr
         87dvSP087+Z3Z2U65zg19ilH9Aj/9G9DRZhpw2R/Wz2nN/Rc8t+a0ia1SQfRIhjNS0
         yxed0pwSEub43xZZYv2Wy0FozCrcInu2zwI2iOEA=
Date:   Thu, 7 Dec 2023 08:31:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        Sourav Panda <souravpanda@google.com>, corbet@lwn.net,
        rafael@kernel.org, mike.kravetz@oracle.com, muchun.song@linux.dev,
        rppt@kernel.org, david@redhat.com, rdunlap@infradead.org,
        chenlinxuan@uniontech.com, yang.yang29@zte.com.cn,
        tomas.mudrunka@gmail.com, bhelgaas@google.com, ivan@cloudflare.com,
        yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com,
        kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com,
        adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, weixugc@google.com
Subject: Re: [PATCH v6 0/1] mm: report per-page metadata information
Message-ID: <2023120731-deception-handmade-8d49@gregkh>
References: <20231205223118.3575485-1-souravpanda@google.com>
 <2023120648-droplet-slit-0e31@gregkh>
 <CA+CK2bARjZgnMBL9bOD7p1u=02-fGgWwfiGvsFVpsJWL-VR2ng@mail.gmail.com>
 <2023120645-survey-puppet-4ae0@gregkh>
 <20231206075913.fa2633991bf257f5ffe5f3f8@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206075913.fa2633991bf257f5ffe5f3f8@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 07:59:13AM -0800, Andrew Morton wrote:
> On Wed, 6 Dec 2023 12:12:10 +0900 Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Tue, Dec 05, 2023 at 09:57:36PM -0500, Pasha Tatashin wrote:
> > > Hi Greg,
> > > 
> > > Sourav removed the new field from sys/device../nodeN/meminfo as you
> > > requested; however, in nodeN/vmstat fields still get appended, as
> > > there is code that displays every item in zone_stat_item,
> > > node_stat_item without option to opt-out. I mentioned it to you at
> > > LPC.
> > 
> > Sorry, I thought that was a proc file, not a sysfs file.  Don't grow
> > that file please, it should not be that way and adding to it will just
> > cause others to also want to add to it and we end up with the whole proc
> > file mess...
> > 
> > > In my IOMMU [1] series, there are also fields that are added to
> > > node_stat_item that as result are appended to nodeN/vmstat.
> > 
> > I missed that, that too shouldn't be done please.
> > 
> > Again, sysfs is "one value per file" for a reason, don't abuse the fact
> > that we missed this abuse of the rules for that file by adding more
> > things to it.
> 
> I'm afraid that horse has bolted.
> 
> hp2:/usr/src/25> wc /sys/devices/system/node/node0/vmstat 
>   61  122 1309 /sys/devices/system/node/node0/vmstat
> 
> We're never going to unpick this into 61 separate files so adding new
> files at this stage is pointless.

But if it keeps growing, it will eventually overflow and start crashing
the kernel and you will then have to do the horrid thing of turning it
into a binary sysfs file.

So I can please ask that no new entries be added to the file please,
let's not keep making things worse.  For new items, just add new files,
don't add to the existing mess.

thanks,

greg k-h
