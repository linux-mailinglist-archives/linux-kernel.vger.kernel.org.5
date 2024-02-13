Return-Path: <linux-kernel+bounces-62920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 263D78527DB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 04:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55ABB1C222A7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 03:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F180C8CE;
	Tue, 13 Feb 2024 03:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jmV9wS3c"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FABBE4E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 03:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707795875; cv=none; b=DiMrrHyEeqZNfl/FWxwBSAVx3u3IbGxj2KEjh7yfhqhq8SVq/JsOIjZvKrtwwFmuKwhO3PT+mz/mf26yZfdUsCCFGcJZcX7sy8TsEWAR87H055HfcA6Trh0VPzQAqZUwEuHXB/oOPU95dFWp7WyBS5bN6DhdfoKVXc+dBOvDECQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707795875; c=relaxed/simple;
	bh=NFft8955xc//JP+9tYos6q1H02OG2foIYqmN54xxgZs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sBP6NqZXVWXX40YSlzcqpOftcELy1ky8PWfeyKcwIDp96l/F8MQMMrhj0vnkObgihy79rekXrspPWPHRTWtO1WqfxW6wknZDsklIFXqx6RUz1vFTJVz1uGFDBny+xPaavrTslxQ8dPPDimzhX0wI6+XG9k/o5v+oVXJUwaCeK9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jmV9wS3c; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf618042daso793772276.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 19:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707795873; x=1708400673; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N11MwErRtXmGthDZPoYyY2IrTS7HYLtHkfcLyWP+24I=;
        b=jmV9wS3c+R97fKEA4U4Xy8b+qrf0orV+GrmxHRgFdk5iPsADgIVKkj07oiGurqjuXk
         GNwFB62bnQDumccI+RjxsPeKiozB7UWJ9VoE2i0ia2sGiQB9dMyW02BeHAj9GRvdhxbp
         2IVZQxgErBH9aRo1zAm4vBTghMnWvznNH4UomlesCJYf1MyEN/nbwNxzUwbqj2ZDgZ5x
         uCAWQYgYFwBiA3Jjv0pDW035ymhQ1tQsBRs5VQucMFLOSymQTaFnnW8v2AMQY1X02SFQ
         +kqGoXLE6ZIdWx7GGwx58wn3IDDeSbH5ZTBz4VcIoBeIRnVp8UQTOs4PieE5tCwJJ2fP
         KjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707795873; x=1708400673;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N11MwErRtXmGthDZPoYyY2IrTS7HYLtHkfcLyWP+24I=;
        b=WbpYWsVI7MDgCv8Z2juKGJKIhAww6atNqV8Rhdk6Zh/Eb97jgYiHk2Q9LFUf5crn3v
         eCRoOGtmZ1B7kaZ3Rb323dLAWZhJOQ9Bcc0KRbWEPws/wkw98KJ2EUAZXpHpC0zZGO1w
         rKL4fHY6v96FK1HwVw6oREep+isc7LUuoaU+PuDlgaSXX3GivGuy+/tn93xLxZkOL5rD
         j5v971LW9ySZ92bHPK8zdGe51//+G3JGS8njuV23YdBvaG9SKr1s/FGyYAWabEjNbEhn
         r+ES0xXCkbuB0C2Q7KVomj8NUq62v/Ng8+SXgim/xw7kIv7S6Re/Y+Ix//XFVNrxL1Ns
         5LMA==
X-Gm-Message-State: AOJu0YyFg48q7chQrNkcWALVk+XjrK93x1gGaAic748W4+A/qGVNT4gS
	dmPlZQShqtSV/aZMBPwd+8q2AJMWjyBFdapOgHFAgbewWktC2A3CAmAwFoyvOqetlXiVI1UDkMv
	EfA==
X-Google-Smtp-Source: AGHT+IEATzkUDO8bqX//dpXzQGggLSlUu4TYjcCX/zo6GFWt5HMja8XHztRX4j6U/QY9m+38GBoTvYSjlMY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:ae15:0:b0:dc1:f6f0:1708 with SMTP id
 a21-20020a25ae15000000b00dc1f6f01708mr312479ybj.7.1707795873299; Mon, 12 Feb
 2024 19:44:33 -0800 (PST)
Date: Mon, 12 Feb 2024 19:44:31 -0800
In-Reply-To: <20230911021637.1941096-4-stevensd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230911021637.1941096-1-stevensd@google.com> <20230911021637.1941096-4-stevensd@google.com>
Message-ID: <Zcrln-uslzS6x-wS@google.com>
Subject: Re: [PATCH v9 3/6] KVM: mmu: Improve handling of non-refcounted pfns
From: Sean Christopherson <seanjc@google.com>
To: David Stevens <stevensd@chromium.org>
Cc: Yu Zhang <yu.c.zhang@linux.intel.com>, Isaku Yamahata <isaku.yamahata@gmail.com>, 
	Zhi Wang <zhi.wang.linux@gmail.com>, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 11, 2023, David Stevens wrote:
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index c2e0ddf14dba..2ed08ae1a9be 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1185,10 +1185,31 @@ struct kvm_follow_pfn {
>  	bool atomic;
>  	/* Try to create a writable mapping even for a read fault */
>  	bool try_map_writable;
> +	/* Usage of the returned pfn will be guared by a mmu notifier. */
> +	bool guarded_by_mmu_notifier;
> +	/*
> +	 * When false, do not return pfns for non-refcounted struct pages.
> +	 *
> +	 * TODO: This allows callers to use kvm_release_pfn on the pfns
> +	 * returned by gfn_to_pfn without worrying about corrupting the
> +	 * refcounted of non-refcounted pages. Once all callers respect
> +	 * is_refcounted_page, this flag should be removed.
> +	 */
> +	bool allow_non_refcounted_struct_page;
>  
>  	/* Outputs of __kvm_follow_pfn */
>  	hva_t hva;
>  	bool writable;
> +	/*
> +	 * True if the returned pfn is for a page with a valid refcount. False
> +	 * if the returned pfn has no struct page or if the struct page is not
> +	 * being refcounted (e.g. tail pages of non-compound higher order
> +	 * allocations from IO/PFNMAP mappings).
> +	 *
> +	 * When this output flag is false, callers should not try to convert
> +	 * the pfn to a struct page.
> +	 */
> +	bool is_refcounted_page;

Idea.  Hopefully a good one.  Rather than tracking a bool, what if we track:

	struct page *refcounted_page;

and then make kvm_xxx_page_clean() wrappers around inner helpers that play nice
with NULL pages, e.g.

  static inline void kvm_release_page_clean(struct page *page)
  {
  	if (!page)
		return

  	__kvm_release_page_clean(page);
  }

Then callers of __kvm_follow_pfn() can do:

	kvm_release_page_clean(fault->refcounted_page);

instead of

 	if (fault->is_refcounted_page)
		kvm_release_page_clean(pfn_to_page(fault->pfn));

