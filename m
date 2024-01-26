Return-Path: <linux-kernel+bounces-39563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5434E83D2DF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 04:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56E4A1C242C7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8991DA944;
	Fri, 26 Jan 2024 03:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fJjKNNd2"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D84946C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 03:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706238764; cv=none; b=C9lCNM/ucI+YiiKnvo2UsPDQ2CKfG+6NcTEEqSBOTSUuxqJVDWJtAKZyOSU93Akx381dzPTD8x9mp4Khf6NjP3DQ8h+wynlTEYPgpD/vx4wtG8zdLnb+xs3ke/wsUXc+JtFQRnUDgwCyakH+6GhnxPmxgpI/mcRe8dV+KgVPlkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706238764; c=relaxed/simple;
	bh=aOlge4a9dRLJy15ghZGST1N4LsIB5jd2eBzLdEJjB5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T05wFt5S7+mGm7C3v/V+zWPp3k900DLCnvNRKv5KCiri1hC/9c0gnFK+PaI0t++UEKHP3A+/6w5Me/nQQLRtzKI0UUF9swEm14pitXC7eC/qMpBsK7rb7LLZSXwvE2uQDJpyWAmsgT+nnN7M42MGZT4s9j6jKmVMI2MvwCpMdpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fJjKNNd2; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6dbce74f917so121503b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 19:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706238762; x=1706843562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lBA+mhnxqJOP4m7joWy+QwgY4c+lF7vio24SpkEJ2hc=;
        b=fJjKNNd24E/0hWxuSIAfeMnUZuvESPNWG3HzeVUObeP4bxg12+BEzu4U5GWaUIoNP1
         1+vzqffNQUWktMR70OFhb22tNf063po/2/1drjQCDcneWl8HEcwuoUEFzdUiZotL4bII
         xxGpJZMSBFCcETaqaEejUQCV1qNBUa/7juRKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706238762; x=1706843562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBA+mhnxqJOP4m7joWy+QwgY4c+lF7vio24SpkEJ2hc=;
        b=RI17cD7CgViWUjbO2XW+VCdysfd9KBmiV69+5JTkbJEk5aW35koQOekRvgVjeIIxTa
         I4Jl0LqADKHratjsltsENkUwNFoE/ExUXKbotaLoagmrtIYpWV5JOKrkdessMCcqvTAa
         0H/7kOuM9lKSCNOnS6sDeHWBT7Mane5c8S0Q+DTS+Lcg53wT2vu3yQy1TCTPe6LZum49
         0dhAGZm3NIT0MZi3zzeLOrMnsy5wA8tEDnoxZX9e6xpFvuexVGUtE7KtfG5jyBPfRz2d
         hA5IWilgQobMYcz0V8yQsODsiYQ0N4fgI5uJFmrHjLAgC74iAxNso+rptP5vGLvwTa0X
         kHcw==
X-Gm-Message-State: AOJu0Ywbl/0StH4CFndWn/Qgfvwu3vKcT43L7hPvIqpqXSWL9ZZk7lnu
	FToyPALabmZgN59GXNTPkoDHRCIUI/1IUdyvZjUcpTCt26Zuvj2CF99a61ZG0A==
X-Google-Smtp-Source: AGHT+IF7R5606JWlYyzGGYDw0xQhCwb6MA5uJ4SwQAz4AExlZePc90aPQ/D4Yri9Mba2zBHAiX77ow==
X-Received: by 2002:a05:6a20:918f:b0:19c:841b:35d2 with SMTP id v15-20020a056a20918f00b0019c841b35d2mr355738pzd.38.1706238762648;
        Thu, 25 Jan 2024 19:12:42 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:c4a9:6453:1d67:60e8])
        by smtp.gmail.com with ESMTPSA id jx14-20020a170903138e00b001d749017955sm199151plb.267.2024.01.25.19.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 19:12:42 -0800 (PST)
Date: Fri, 26 Jan 2024 12:12:38 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jiexun Wang <wangjiexun@tinylab.org>
Cc: brauner@kernel.org, falcon@tinylab.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, tangjinyu@tinylab.org
Subject: Re: [PATCH v2 1/1] mm/madvise: add cond_resched() in
 madvise_cold_or_pageout_pte_range()
Message-ID: <20240126031238.GA329333@google.com>
References: <cover.1695291046.git.wangjiexun@tinylab.org>
 <85363861af65fac66c7a98c251906afc0d9c8098.1695291046.git.wangjiexun@tinylab.org>
 <20230921174101.8e6271422a857af5414ce0a0@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921174101.8e6271422a857af5414ce0a0@linux-foundation.org>

On (23/09/21 17:41), Andrew Morton wrote:
> > Currently the madvise_cold_or_pageout_pte_range() function exhibits 
> > significant latency under memory pressure, which can be effectively 
> > reduced by adding cond_resched() within the loop.
> > 
> > When the batch_count reaches SWAP_CLUSTER_MAX, we reschedule 
> > the task to ensure fairness and avoid long lock holding times.
> > 
> > ...
> >
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -354,6 +354,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
> >  	struct folio *folio = NULL;
> >  	LIST_HEAD(folio_list);
> >  	bool pageout_anon_only_filter;
> > +	unsigned int batch_count = 0;
> >  
> >  	if (fatal_signal_pending(current))
> >  		return -EINTR;
> > @@ -433,6 +434,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
> >  regular_folio:
> >  #endif
> >  	tlb_change_page_size(tlb, PAGE_SIZE);
> > +restart:
> >  	start_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> 
> The handling of start_pte looks OK.
> 
> >  	if (!start_pte)
> >  		return 0;
> > @@ -441,6 +443,15 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
> >  	for (; addr < end; pte++, addr += PAGE_SIZE) {
> >  		ptent = ptep_get(pte);
> >  
> > +		if (++batch_count == SWAP_CLUSTER_MAX) {
> > +			batch_count = 0;
> > +			if (need_resched()) {
> > +				pte_unmap_unlock(start_pte, ptl);

Shouldn't it leave lazy MMU mode here?

---

diff --git a/mm/madvise.c b/mm/madvise.c
index 0f222d464254..127f0c7b69ac 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -451,6 +451,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		if (++batch_count == SWAP_CLUSTER_MAX) {
 			batch_count = 0;
 			if (need_resched()) {
+				arch_leave_lazy_mmu_mode();
 				pte_unmap_unlock(start_pte, ptl);
 				cond_resched();
 				goto restart;

