Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393F17FA44F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbjK0PKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbjK0PKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:10:36 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77703D6;
        Mon, 27 Nov 2023 07:10:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAC2F2F4;
        Mon, 27 Nov 2023 07:11:28 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC8E23F6C4;
        Mon, 27 Nov 2023 07:10:35 -0800 (PST)
Date:   Mon, 27 Nov 2023 15:10:33 +0000
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
        maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
        rppt@kernel.org, hughd@google.com, pcc@google.com,
        steven.price@arm.com, anshuman.khandual@arm.com,
        vincenzo.frascino@arm.com, eugenis@google.com, kcc@google.com,
        hyesoo.yu@samsung.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 15/27] arm64: mte: Check that tag storage blocks
 are in the same zone
Message-ID: <ZWSxaYGJSkyMj-bE@raptor>
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
 <20231119165721.9849-16-alexandru.elisei@arm.com>
 <eb28b2fb-1480-4db0-a7e6-792716421f3d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb28b2fb-1480-4db0-a7e6-792716421f3d@redhat.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 24, 2023 at 08:56:59PM +0100, David Hildenbrand wrote:
> On 19.11.23 17:57, Alexandru Elisei wrote:
> > alloc_contig_range() requires that the requested pages are in the same
> > zone. Check that this is indeed the case before initializing the tag
> > storage blocks.
> > 
> > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > ---
> >   arch/arm64/kernel/mte_tag_storage.c | 33 +++++++++++++++++++++++++++++
> >   1 file changed, 33 insertions(+)
> > 
> > diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
> > index 8b9bedf7575d..fd63430d4dc0 100644
> > --- a/arch/arm64/kernel/mte_tag_storage.c
> > +++ b/arch/arm64/kernel/mte_tag_storage.c
> > @@ -265,6 +265,35 @@ void __init mte_tag_storage_init(void)
> >   	}
> >   }
> > +/* alloc_contig_range() requires all pages to be in the same zone. */
> > +static int __init mte_tag_storage_check_zone(void)
> > +{
> > +	struct range *tag_range;
> > +	struct zone *zone;
> > +	unsigned long pfn;
> > +	u32 block_size;
> > +	int i, j;
> > +
> > +	for (i = 0; i < num_tag_regions; i++) {
> > +		block_size = tag_regions[i].block_size;
> > +		if (block_size == 1)
> > +			continue;
> > +
> > +		tag_range = &tag_regions[i].tag_range;
> > +		for (pfn = tag_range->start; pfn <= tag_range->end; pfn += block_size) {
> > +			zone = page_zone(pfn_to_page(pfn));
> > +			for (j = 1; j < block_size; j++) {
> > +				if (page_zone(pfn_to_page(pfn + j)) != zone) {
> > +					pr_err("Tag storage block pages in different zones");
> > +					return -EINVAL;
> > +				}
> > +			}
> > +		}
> > +	}
> > +
> > +	 return 0;
> > +}
> > +
> 
> Looks like something that ordinary CMA provides. See cma_activate_area().

Indeed.

> 
> Can't we find a way to let CMA do CMA thingies and only be a user of that?
> What would be required to make the performance issue you spelled out in the
> cover letter be gone and not have to open-code that in arch code?

I've replied with a possible solution here [1].

[1] https://lore.kernel.org/all/ZWSvMYMjFLFZ-abv@raptor/

Thanks,
Alex

> 
> -- 
> Cheers,
> 
> David / dhildenb
> 
