Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FAD7FF1F6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346006AbjK3Odb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjK3Od3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:33:29 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6EDE93;
        Thu, 30 Nov 2023 06:33:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 357001042;
        Thu, 30 Nov 2023 06:34:22 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC1633F5A1;
        Thu, 30 Nov 2023 06:33:30 -0800 (PST)
Date:   Thu, 30 Nov 2023 14:33:28 +0000
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Hyesoo Yu <hyesoo.yu@samsung.com>, catalin.marinas@arm.com,
        will@kernel.org, oliver.upton@linux.dev, maz@kernel.org,
        james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
        arnd@arndb.de, akpm@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
        rppt@kernel.org, hughd@google.com, pcc@google.com,
        steven.price@arm.com, anshuman.khandual@arm.com,
        vincenzo.frascino@arm.com, eugenis@google.com, kcc@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 19/27] mm: mprotect: Introduce
 PAGE_FAULT_ON_ACCESS for mprotect(PROT_MTE)
Message-ID: <ZWidOFYNjd7xM0c7@raptor>
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
 <CGME20231119165921epcas2p3dce0532847d59a9c3973b4e41102e27d@epcas2p3.samsung.com>
 <20231119165721.9849-20-alexandru.elisei@arm.com>
 <20231129092725.GD2988384@tiffany>
 <ZWh6vl8DfXQbKo9O@raptor>
 <4e7a4054-092c-4e34-ae00-0105d7c9343c@redhat.com>
 <ZWiO4PWfK2gKDLGr@raptor>
 <d7e0574d-c74d-4e91-bf60-aa6691df78e3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7e0574d-c74d-4e91-bf60-aa6691df78e3@redhat.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 02:43:48PM +0100, David Hildenbrand wrote:
> On 30.11.23 14:32, Alexandru Elisei wrote:
> > Hi,
> > 
> > On Thu, Nov 30, 2023 at 01:49:34PM +0100, David Hildenbrand wrote:
> > > > > > +
> > > > > > +out_retry:
> > > > > > +	put_page(page);
> > > > > > +	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
> > > > > > +		vma_end_read(vma);
> > > > > > +	if (fault_flag_allow_retry_first(vmf->flags)) {
> > > > > > +		err = VM_FAULT_RETRY;
> > > > > > +	} else {
> > > > > > +		/* Replay the fault. */
> > > > > > +		err = 0;
> > > > > 
> > > > > Hello!
> > > > > 
> > > > > Unfortunately, if the page continues to be pinned, it seems like fault will continue to occur.
> > > > > I guess it makes system stability issue. (but I'm not familiar with that, so please let me know if I'm mistaken!)
> > > > > 
> > > > > How about migrating the page when migration problem repeats.
> > > > 
> > > > Yes, I had the same though in the previous iteration of the series, the
> > > > page was migrated out of the VMA if tag storage couldn't be reserved.
> > > > 
> > > > Only short term pins are allowed on MIGRATE_CMA pages, so I expect that the
> > > > pin will be released before the fault is replayed. Because of this, and
> > > > because it makes the code simpler, I chose not to migrate the page if tag
> > > > storage couldn't be reserved.
> > > 
> > > There are still some cases that are theoretically problematic: vmsplice()
> > > can pin pages forever and doesn't use FOLL_LONGTERM yet.
> > > 
> > > All these things also affect other users that rely on movability (e.g., CMA,
> > > memory hotunplug).
> > 
> > I wasn't aware of that, thank you for the information. Then to ensure that the
> > process doesn't hang by replying the loop indefinitely, I'll migrate the page if
> > tag storage cannot be reserved. Looking over the code again, I think I can reuse
> > the same function that migrates tag storage pages out of the MTE VMA (added in
> > patch #21), so no major changes needed.
> 
> It's going to be interesting if migrating that page fails because it is
> pinned :/

I imagine that having both the page **and** its tag storage pinned longterm
without FOLL_LONGTERM is going to be exceedingly rare.

Am I mistaken in believing that the problematic vmsplice() behaviour is
recognized as something that needs to be fixed?

Thanks,
Alex

> 
> -- 
> Cheers,
> 
> David / dhildenb
> 
