Return-Path: <linux-kernel+bounces-39682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 284E883D4F6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B51B71F29893
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 08:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F4421A10;
	Fri, 26 Jan 2024 07:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ya96dtn2"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C0818035
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 07:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706252426; cv=none; b=g3+WECB49pbcOW0SnrWqW2umww9y2pPg5ScGC9s1feZ72OYGd/dBK5a8kuqhcV9XfnJrhVJNGHRUl2RQM2ChMdp76Hxpj3YyZz+rF4scHgA2U4yNg9A46HCZxSAlHwvUVrriqTThkSHXCEv5i+o+GnrgJHyZy2HatvkE7cA4mTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706252426; c=relaxed/simple;
	bh=h9Xbnp41TcXaVOuPJbaZAjj1zavL9QQaF5Q3FFE2lsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r493ZtKIVmG7ANKY+N2X8xnS/zeAfFTrELVf0fZcq2JxEKdN2D6wcazjCdiCf5Tt4GT8E8jp4/+0AFQJzNrgfuWTlK93sHUpk3BS8NsAUh1umtoxD2yZQKSrYAVdIJgVleN7beck9KXF2AWpeqgWTS14xaeJiV1fgmrkrNF4kcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ya96dtn2; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5957ede4deaso70760eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 23:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706252422; x=1706857222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xb6T+Rm32ycbDoAgSUxsRyhNv4ZvA5Ga3kFWEo8h53w=;
        b=Ya96dtn2QiWJSzZ5EXqnwXOK7Qi5tzLnXc8nBBN2FdQ7sKTgMYB/xfFZp/JepgqYMf
         rRTy1fIu1fi4Y0c0yNrzc3IUkt7CDDvZJQnUdTe4mlT5AxKGMol6TQRU8w/+v6gpG+xR
         BpDzKWGUpgJNL/sRF7Wbt/ZzObAeoF1vkLMC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706252422; x=1706857222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xb6T+Rm32ycbDoAgSUxsRyhNv4ZvA5Ga3kFWEo8h53w=;
        b=DiRsihn/n/q0kFZgFdN3dKK/0dRRFjkdbP9asYs7M15nrbPJQfzITGwPdErDp1v+YH
         Pla2pYYLV/+m9MPLqe3GJCjfaBpTcN3XvLysaCdhfUXbTUlWGmtyq6Erf2odHRW2Wd7V
         ZUVJCatBRb4rGiZbYmm6s626rrh184DFEsEdHKBtgYFv1SqIL8+WRV4RCnpZkOR46NxK
         PghewUltbzfvIlhvk3Jkezh3fDZcQkPcVpOLe4ZOzm3dP4Icaxl0BoaYPScZ15fKwYKx
         m6Zc309YKpbYhJI4lue/MkG5v6USTLLa58zG9b9auC9XlzldrBsP7CjejNVWAqkm7Fl+
         TpFQ==
X-Gm-Message-State: AOJu0YzA9jH3q6vUytRZxDVl8nzARVFs6dKdmMjbp84+qP3WjakI2DEE
	jVQV0ZQLliwWVSpAO3x4IGhKAUK5SQXNXS1pXeyZh+MNOqGs+6YHiDEaBQ9cGw==
X-Google-Smtp-Source: AGHT+IF0SU5MN9q62FrP08/sHSCs3EbXGIsFyPvbbrN21ihOqKQEiRDoUPp5SBGlZhdmxVq04X2vpA==
X-Received: by 2002:a05:6358:7253:b0:176:91cd:1a94 with SMTP id i19-20020a056358725300b0017691cd1a94mr1356572rwa.33.1706252421480;
        Thu, 25 Jan 2024 23:00:21 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:c4a9:6453:1d67:60e8])
        by smtp.gmail.com with ESMTPSA id e12-20020aa78c4c000000b006dde0df3a7esm531772pfd.101.2024.01.25.23.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 23:00:21 -0800 (PST)
Date: Fri, 26 Jan 2024 16:00:17 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jiexun Wang <wangjiexun@tinylab.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/madvise: don't forget to leave lazy MMU mode in
 madvise_cold_or_pageout_pte_range()
Message-ID: <20240126070017.GB329333@google.com>
References: <20230921174101.8e6271422a857af5414ce0a0@linux-foundation.org>
 <20240126032608.355899-1-senozhatsky@chromium.org>
 <20240125225336.6a444c01d9d9812a23a6890b@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125225336.6a444c01d9d9812a23a6890b@linux-foundation.org>

On (24/01/25 22:53), Andrew Morton wrote:
> Date: Thu, 25 Jan 2024 22:53:36 -0800
> From: Andrew Morton <akpm@linux-foundation.org>
> To: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Jiexun Wang <wangjiexun@tinylab.org>, linux-kernel@vger.kernel.org,
>  linux-mm@kvack.org
> Subject: Re: [PATCH] mm/madvise: don't forget to leave lazy MMU mode in
>  madvise_cold_or_pageout_pte_range()
> Message-Id: <20240125225336.6a444c01d9d9812a23a6890b@linux-foundation.org>
> X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
> 
> On Fri, 26 Jan 2024 12:25:48 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> 
> > We need to leave lazy MMU mode before unlocking.

It depends on the arch, as far as I understand it.
We can enter lazy MMU mode (on each goto restart) more times than leave
it, and, for isntance, on powerpc that means that we can preempt_disable()
more times than preempt_enable(). That's how enter/leave lazy MMU mode is
implemented there:

static inline void arch_enter_lazy_mmu_mode(void)
{
        struct ppc64_tlb_batch *batch;

        if (radix_enabled())
                return;
        /*
         * apply_to_page_range can call us this preempt enabled when
         * operating on kernel page tables.
         */
        preempt_disable();
        batch = this_cpu_ptr(&ppc64_tlb_batch);
        batch->active = 1;
}

static inline void arch_leave_lazy_mmu_mode(void)
{
        struct ppc64_tlb_batch *batch;

        if (radix_enabled())
                return;
        batch = this_cpu_ptr(&ppc64_tlb_batch);

        if (batch->index)
                __flush_tlb_pending(batch);
        batch->active = 0;
        preempt_enable();
}

> What might be the userspace-visible effects of this?
> 
> > Fixes: b2f557a21bc8 ("mm/madvise: add cond_resched() in madvise_cold_or_pageout_pte_range()"
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> 
> I'll add a cc:stable.

Thanks.

