Return-Path: <linux-kernel+bounces-23241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9BD82A956
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B9C11C23F42
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5217510A03;
	Thu, 11 Jan 2024 08:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="e4m9cSu+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lW37eauM"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC0C10940
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 237BB1FB8D;
	Thu, 11 Jan 2024 08:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704962678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IdRbXT6KWpUzahecRbqmMLz9QYgtWWSOiBuKfzahGm4=;
	b=e4m9cSu+JtjkKXBsa/A8ayGBh/KZsh+30cjHUIaGPv4RGg/99sP8YbSWDzHTA9ZUScXEdf
	S4I2cmqrF9SCcF/3h4GiNkaBFvUJeArqaQMICR+GO08pQAvTSLMKbm2rUt1FxWV3AnzAWh
	nk2iN8sT6cMWx/v18I5a5Fn7R3Zrgd8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704962754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IdRbXT6KWpUzahecRbqmMLz9QYgtWWSOiBuKfzahGm4=;
	b=lW37eauMFxGqcxJ5l1Qy3X5TVFa5XvZzxj7ajhxTiqQa3hJHQeW+2LkT/aXoJQ3skpEKJ7
	pJCu8CDZx6QDMag1fR0KR7ZP+JZDxAuZID7dwdqJJX9ySUuOK6aYmzjNTsnFjQ3tahEETS
	Wo7fcYNDFemMdH5BjxKSQ0k91iX5qps=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 413C513635;
	Thu, 11 Jan 2024 08:44:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id afVYDHaqn2VFbwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Thu, 11 Jan 2024 08:44:38 +0000
Date: Thu, 11 Jan 2024 09:46:08 +0100
From: Michal Hocko <mhocko@suse.com>
To: Jianfeng Wang <jianfeng.w.wang@oracle.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, oom: Add lru_add_drain() in __oom_reap_task_mm()
Message-ID: <ZZ-q0PZ-XCDwA4oG@tiehlicka>
References: <20240109091511.8299-1-jianfeng.w.wang@oracle.com>
 <ZZ5Zb3FYqY8FZgB3@tiehlicka>
 <1d866f1b-94b3-43ec-8f4c-2de31b82d3d1@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d866f1b-94b3-43ec-8f4c-2de31b82d3d1@oracle.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

On Wed 10-01-24 11:02:03, Jianfeng Wang wrote:
> On 1/10/24 12:46 AM, Michal Hocko wrote:
> > On Tue 09-01-24 01:15:11, Jianfeng Wang wrote:
> >> The oom_reaper tries to reclaim additional memory owned by the oom
> >> victim. In __oom_reap_task_mm(), it uses mmu_gather for batched page
> >> free. After oom_reaper was added, mmu_gather feature introduced
> >> CONFIG_MMU_GATHER_NO_GATHER (in 'commit 952a31c9e6fa ("asm-generic/tlb:
> >> Introduce CONFIG_HAVE_MMU_GATHER_NO_GATHER=y")', an option to skip batched
> >> page free. If set, tlb_batch_pages_flush(), which is responsible for
> >> calling lru_add_drain(), is skipped during tlb_finish_mmu(). Without it,
> >> pages could still be held by per-cpu fbatches rather than be freed.
> >>
> >> This fix adds lru_add_drain() prior to mmu_gather. This makes the code
> >> consistent with other cases where mmu_gather is used for freeing pages.
> > 
> > Does this fix any actual problem or is this pure code consistency thing?
> > I am asking because it doesn't make much sense to me TBH, LRU cache
> > draining is usually important when we want to ensure that cached pages
> > are put to LRU to be dealt with because otherwise the MM code wouldn't
> > be able to deal with them. OOM reaper doesn't necessarily run on the
> > same CPU as the oom victim so draining on a local CPU doesn't
> > necessarily do anything for the victim's pages.
> > 
> > While this patch is not harmful I really do not see much point in adding
> > the local draining here. Could you clarify please?
> > 
> It targets the case described in the patch's commit message: oom_killer
> thinks that it 'reclaims' pages while pages are still held by per-cpu
> fbatches with a ref count.
> 
> I admit that pages may sit on a different core(s). Given that
> doing remote calls to all CPUs with lru_add_drain_all() is expensive,
> this line of code can be helpful if it happens to give back a few pages
> to the system right away without the overhead, especially when oom is
> involved. Plus, it also makes the code consistent with other places
> using mmu_gather feature to free pages in batch.

I would argue that consistency the biggest problem of this patch. It
tries to follow a pattern that is just not really correct. First it
operates on a random CPU from the oom victim perspective and second it
doesn't really block any unmapping operation and that is the main
purpose of the reaper. Sure it frees a lot of unmapped memory but if
there are couple of pages that cannot be freed imeediately because they
are sitting on a per-cpu LRU caches then this is not a deal breaker. As
you have noted those pages might be sitting on any per-cpu cache.

So I do not really see that as a good justification. People will follow
that pattern even more and spread lru_add_drain to other random places.

Unless you can show any actual runtime effect of this patch then I think
it shouldn't be merged.

-- 
Michal Hocko
SUSE Labs

