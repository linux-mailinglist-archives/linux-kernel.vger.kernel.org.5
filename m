Return-Path: <linux-kernel+bounces-21860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF11829558
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D331BB25FAA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAA73B198;
	Wed, 10 Jan 2024 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rbRHB8TW";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rbRHB8TW"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CCB3B190
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 08:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B6AB421C56;
	Wed, 10 Jan 2024 08:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704876399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dAMBtYxlnvekwyaz5hr/7HwB3du2CWI3iMgQMYoSubo=;
	b=rbRHB8TWWTkXJMRrgKyAZpxrf8arJY85UXcKVMHZKx7eChVd0m6TdKbHFIB4qQO1h3LB2N
	MVnWx7DLNNSy+BzPPoYdylwOCQbJ5wU5eHe7wvjCQNdwAbGaNGbdCfcJ1ypMKkc2Z3oRuQ
	xF6hZWpzS62/V9mI32lqHnr6cqn+XyI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704876399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dAMBtYxlnvekwyaz5hr/7HwB3du2CWI3iMgQMYoSubo=;
	b=rbRHB8TWWTkXJMRrgKyAZpxrf8arJY85UXcKVMHZKx7eChVd0m6TdKbHFIB4qQO1h3LB2N
	MVnWx7DLNNSy+BzPPoYdylwOCQbJ5wU5eHe7wvjCQNdwAbGaNGbdCfcJ1ypMKkc2Z3oRuQ
	xF6hZWpzS62/V9mI32lqHnr6cqn+XyI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 930B613786;
	Wed, 10 Jan 2024 08:46:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aIINIm9ZnmUDcQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 10 Jan 2024 08:46:39 +0000
Date: Wed, 10 Jan 2024 09:46:39 +0100
From: Michal Hocko <mhocko@suse.com>
To: Jianfeng Wang <jianfeng.w.wang@oracle.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, oom: Add lru_add_drain() in __oom_reap_task_mm()
Message-ID: <ZZ5Zb3FYqY8FZgB3@tiehlicka>
References: <20240109091511.8299-1-jianfeng.w.wang@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109091511.8299-1-jianfeng.w.wang@oracle.com>
X-Spam-Level: **
X-Spamd-Bar: ++
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=rbRHB8TW
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [2.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.20)[89.15%]
X-Spam-Score: 2.29
X-Rspamd-Queue-Id: B6AB421C56
X-Spam-Flag: NO

On Tue 09-01-24 01:15:11, Jianfeng Wang wrote:
> The oom_reaper tries to reclaim additional memory owned by the oom
> victim. In __oom_reap_task_mm(), it uses mmu_gather for batched page
> free. After oom_reaper was added, mmu_gather feature introduced
> CONFIG_MMU_GATHER_NO_GATHER (in 'commit 952a31c9e6fa ("asm-generic/tlb:
> Introduce CONFIG_HAVE_MMU_GATHER_NO_GATHER=y")', an option to skip batched
> page free. If set, tlb_batch_pages_flush(), which is responsible for
> calling lru_add_drain(), is skipped during tlb_finish_mmu(). Without it,
> pages could still be held by per-cpu fbatches rather than be freed.
> 
> This fix adds lru_add_drain() prior to mmu_gather. This makes the code
> consistent with other cases where mmu_gather is used for freeing pages.

Does this fix any actual problem or is this pure code consistency thing?
I am asking because it doesn't make much sense to me TBH, LRU cache
draining is usually important when we want to ensure that cached pages
are put to LRU to be dealt with because otherwise the MM code wouldn't
be able to deal with them. OOM reaper doesn't necessarily run on the
same CPU as the oom victim so draining on a local CPU doesn't
necessarily do anything for the victim's pages.

While this patch is not harmful I really do not see much point in adding
the local draining here. Could you clarify please?
 
> Signed-off-by: Jianfeng Wang <jianfeng.w.wang@oracle.com>
> ---
>  mm/oom_kill.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 9e6071fde34a..e2fcf4f062ea 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -537,6 +537,7 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
>  			struct mmu_notifier_range range;
>  			struct mmu_gather tlb;
>  
> +			lru_add_drain();
>  			mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0,
>  						mm, vma->vm_start,
>  						vma->vm_end);
> -- 
> 2.42.1
> 

-- 
Michal Hocko
SUSE Labs

