Return-Path: <linux-kernel+bounces-66843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1884185624D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8A14288E72
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DEA12BE9F;
	Thu, 15 Feb 2024 11:56:37 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7F412B14C
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707998197; cv=none; b=f7aj3DWPUnsM3FOXZzwXpiQdSUhWrUJ3mytEEesgS6cOD9QcHl5JiGNfEtUGQjABaEMP3gF+NpsF04LeIrJ4/TrwUEl7iRvEBLCofOjOwW2xlkDGpgFTSDKebIhST6xdawm4lttLaXt5Bw8uc2frLqEWVDLOnPDYSSNRBcn7kEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707998197; c=relaxed/simple;
	bh=iQTZVfX1cNJJ5WOHk+XpvjTf0FitnxvY81VtHXx2k8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZPurUgRpsF7F9Gq89xH6MFWmL06TpAPMv56uffpZy2raQ4TtNpXqfe6KdTmklHwvDUyFH613xl1zHMgzgxZSrsDx3bD+1e9eC4Ql365UYWz9pmpJw72/Ux3Hu5uUFS+b0wp4D7/xFDqOC+dSu9HcYUBs12Wiq6rIw/hq2iw0Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2A4A422205;
	Thu, 15 Feb 2024 11:56:33 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A3AD91346A;
	Thu, 15 Feb 2024 11:56:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id IP28JPD7zWUrBwAAn2gu4w
	(envelope-from <osalvador@suse.de>); Thu, 15 Feb 2024 11:56:32 +0000
Date: Thu, 15 Feb 2024 12:57:39 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v9 4/7] mm,page_owner: Implement the tracking of the
 stacks count
Message-ID: <Zc38M2CR2coppMFH@localhost.localdomain>
References: <20240214170157.17530-1-osalvador@suse.de>
 <20240214170157.17530-5-osalvador@suse.de>
 <9fc95f61-827f-40ee-a823-576cdcad7939@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fc95f61-827f-40ee-a823-576cdcad7939@suse.cz>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2A4A422205
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Thu, Feb 15, 2024 at 12:08:53PM +0100, Vlastimil Babka wrote:
> On 2/14/24 18:01, Oscar Salvador wrote:
> > Implement {inc,dec}_stack_record_count() which increments or
> > decrements on respective allocation and free operations, via
> > __reset_page_owner() (free operation) and __set_page_owner() (alloc
> > operation).
> > Newly allocated stack_record structs will be added to the list stack_list
> > via add_stack_record_to_list().
> > Modifications on the list are protected via a spinlock with irqs
> > disabled, since this code can also be reached from IRQ context.
> > 
> > Signed-off-by: Oscar Salvador <osalvador@suse.de>
> > Reviewed-by: Marco Elver <elver@google.com>
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!


> > +		if (atomic_try_cmpxchg_relaxed(&stack_record->count.refs, &old, 1))
> > +			/* Add the new stack_record to our list */
> > +			add_stack_record_to_list(stack_record, gfp_mask);
> 			
> 			Not returning here...
> 
> > +	}
> > +	refcount_inc(&stack_record->count);
> 
> ... means we'll increase the count to 2 on the first store, so there's a
> bias. Which would be consistent with the failure and dummy stacks that also
> start with a refcount of 1. But then the stack count reporting should
> decrement by 1 to prevent confusion? (in the following patch). Imagine
> somebody debugging an allocation stack where there are not so many of them,
> but the allocation is large, and being sidetracked by an off-by-one error.

Good catch Vlastimil!
Yes, we should substract one from the total count in stack_print.

-- 
Oscar Salvador
SUSE Labs

