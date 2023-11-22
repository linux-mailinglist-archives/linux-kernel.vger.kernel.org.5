Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439DD7F5461
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjKVXS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKVXS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:18:57 -0500
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47370D8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:18:53 -0800 (PST)
Date:   Wed, 22 Nov 2023 23:18:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700695131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JxXGMR68Ffnug5d1GsuemuN3GA7Qv3hraWikP3Qedyg=;
        b=EKGjeETg1FstPJI4IUIF9cjjTbqw4SiOzQYBToAG/PRyaM3apZI2VzkUQzsX64VhacLKYU
        McFbkQwAgzMlNjIHOG6MJ+5w7jqYHy/LCciVJ3Mit2qHGpRdkTGOSOpKVOycUXo7qdZXMC
        OhzwgUxs+eWT7kYTCw1de2PfeRGitOE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Sebastian Ene <sebastianene@google.com>
Cc:     will@kernel.org, James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>, catalin.marinas@arm.com,
        mark.rutland@arm.com, akpm@linux-foundation.org, maz@kernel.org,
        kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        vdonnefort@google.com, qperret@google.com, smostafa@google.com
Subject: Re: [PATCH v3 00/10] arm64: ptdump: View the second stage page-tables
Message-ID: <ZV6MVYI8J6NFS9Wl@linux.dev>
References: <20231115171639.2852644-2-sebastianene@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115171639.2852644-2-sebastianene@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Seb,

On Wed, Nov 15, 2023 at 05:16:30PM +0000, Sebastian Ene wrote:
> Hi,
> 
> This can be used as a debugging tool for dumping the second stage
> page-tables.
> 
> When CONFIG_PTDUMP_STAGE2_DEBUGFS is enabled, ptdump registers 
> '/sys/debug/kvm/<guest_id>/stage2_page_tables' entry with debugfs
> upon guest creation. This allows userspace tools (eg. cat) to dump the
> stage-2 pagetables by reading the registered file.
> 
> Reading the debugfs file shows stage-2 memory ranges in following format:
> <IPA range> <size> <descriptor type> <access permissions> <mem_attributes>
> 
> Under pKVM configuration(kvm-arm.mode=protected) ptdump registers an entry
> for the host stage-2 pagetables in the following path:
> /sys/debug/kvm/host_stage2_page_tables/
> 
> The tool interprets the pKVM ownership annotation stored in the invalid
> entries and dumps to the console the ownership information. To be able
> to access the host stage-2 page-tables from the kernel, a new hypervisor
> call was introduced which allows us to snapshot the page-tables in a host
> provided buffer. The hypervisor call is hidden behind CONFIG_NVHE_EL2_DEBUG
> as this should be used under debugging environment.

While I think the value of the feature you're proposing is great, I'm
not a fan of the current shape of this series.

Reusing note_page() for the stage-2 dump is somewhat convenient, but the
series pulls a **massive** amount of KVM details outside of KVM:

 - Open-coding the whole snapshotting interface with EL2 outside of KVM.
   This is a complete non-starter for me; the kernel<->EL2 interface
   needs to be owned by the EL1 portions of KVM.

 - Building page-table walkers using the KVM pgtable library outside of
   KVM.

 - Copying (rather than directly calling) the logic responsible for
   things like FWB and PGD concatenation.

 - Hoisting the definition of _software bits_ outside of KVM. I'm less
   concerned about hardware bits since they have an unambiguous meaning.

I think exporting the necessary stuff from ptdump into KVM will lead to
a much cleaner implementation.

-- 
Thanks,
Oliver
