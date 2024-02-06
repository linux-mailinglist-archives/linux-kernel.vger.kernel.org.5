Return-Path: <linux-kernel+bounces-54244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB94A84ACC3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5821C229BA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238EB7316E;
	Tue,  6 Feb 2024 03:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vUavr3tV"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065DB1E86D
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 03:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707189397; cv=none; b=QqmeG+9GjiTD8eO/70fRr3myyCINL8+MqADu15rBQadXvgIqryPVVTovXppUs4QD0hJCnWa07B78KMfbwJmshhxZUdtJaQggCB8ku4O2BobGyIZ3FDHxd32aJ3K3jyGCiVCI8T43aNnLZnk+HkAD+Xpf8RbItcxA3kyXPrh6ufs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707189397; c=relaxed/simple;
	bh=CDLsR1ZUUpDk/9u8x2Knc8vzwibGd3+lwfgVYBEFEPQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qh+stXnQYZLWVTHFtfYsqCHnzRtPMVpaJ0Q4xTiOnMmQmpHvvI2U1za8b5bZW/gXK2TNuosT7PHnjzPLj1yKAeIRZiWs3I/iGhn895s+NNrdkv1bJ+2/hR+2kkqI0c4fNPt9LindtyEvwfP4S5VGLtdYC53WD6vUi8/U+hla+Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vUavr3tV; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26eef6cso7017195276.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 19:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707189395; x=1707794195; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MvC3MRJutUaxpyhNW1LkFy2eJ5hLYgf9cMf+Ks5GEgE=;
        b=vUavr3tV+No65lsAJa26yWK+Qz5vpPaEMNSeWKxLPfCDCkw8u3aipxIQFkFFRePSu3
         1daTHeRuS5kL8MBc5yBA16ppZamJA7xlSg7lJxQBSH9O4UmIaJQGNihugMrb0o42di8y
         OFm3DlwxNRLtMVwl8RivTLOBTNizIxYECuozibXtIB0opN+7WJ91YFLvAO3vBgUt1sV9
         N5VASVL3SMBWYcy47Fr30DQO1Sk2wnZ6Cz8TdN4rq7/dEaM72V22HlKS7qZ3Mq30Ual4
         vszwWg0jycpvVtQ3K2QRauRKyIjL2+00LyoqdJrz+dzHVqx2HBidbt7KKQecgk1vuVTK
         KjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707189395; x=1707794195;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MvC3MRJutUaxpyhNW1LkFy2eJ5hLYgf9cMf+Ks5GEgE=;
        b=hQMkeW5RwyyZgwv/g0br5AEDfrZec88/02XRNUF3aOIBe9SNNliGtlXM2+W8AQRniv
         Md6zUqNTkekcBk+9/xDV0C34bVBh3VG6joJubr5NumUMGDLVAVtQX/7ZXrGRWqpq/YEX
         BFoKCD/Us3ik6Di25xBfoQUv40IIbt9PYZSCN4OK6rDdhk7p1DsajgZC5sFYjxfAvUST
         VgYTbSoFBYLGX1Kr1R674iT2nm94HtTylNYH2cFF/qV2LK7RIdZ0hsHSyl/CW81Wrr7Z
         y4LRdUepQ27y0Jyejek0ogglV6FZgpB5/VCnJ2opUSkqiPbfMP6iyUxb9PoRROWJO669
         4dug==
X-Gm-Message-State: AOJu0YxdLhtXMnCaxFLa4trcfmjm52phENnmD7gSEs8nNfwmA96ZoScN
	LpvSoETCe8tWUFaQoE9cKWJRuJ30EEWIw2rvFiBliHsk/K8vtTRfvkAcfTUevGBYKxIskaaFfgc
	1fg==
X-Google-Smtp-Source: AGHT+IGm+xDF5ifX2TC/Wxist3sFnZeSnqNK6H+2R746GyxgyO5yCoDonpYAqmwboZsm2R0fmqQgQqI4SF8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:cc6:b0:dc2:23db:1bc8 with SMTP id
 cq6-20020a0569020cc600b00dc223db1bc8mr18446ybb.3.1707189394995; Mon, 05 Feb
 2024 19:16:34 -0800 (PST)
Date: Mon, 5 Feb 2024 19:16:33 -0800
In-Reply-To: <20230911021637.1941096-3-stevensd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230911021637.1941096-1-stevensd@google.com> <20230911021637.1941096-3-stevensd@google.com>
Message-ID: <ZcGkkVAaT_Lz_ZVQ@google.com>
Subject: Re: [PATCH v9 2/6] KVM: mmu: Introduce __kvm_follow_pfn function
From: Sean Christopherson <seanjc@google.com>
To: David Stevens <stevensd@chromium.org>
Cc: Yu Zhang <yu.c.zhang@linux.intel.com>, Isaku Yamahata <isaku.yamahata@gmail.com>, 
	Zhi Wang <zhi.wang.linux@gmail.com>, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 11, 2023, David Stevens wrote:
> @@ -2681,24 +2668,22 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
>   * 2): @write_fault = false && @writable, @writable will tell the caller
>   *     whether the mapping is writable.
>   */
> -kvm_pfn_t hva_to_pfn(unsigned long addr, bool atomic, bool interruptible,
> -		     bool *async, bool write_fault, bool *writable)
> +kvm_pfn_t hva_to_pfn(struct kvm_follow_pfn *foll)
>  {
>  	struct vm_area_struct *vma;
>  	kvm_pfn_t pfn;
>  	int npages, r;
>  
>  	/* we can do it either atomically or asynchronously, not both */

Can you change this comment?  Not your fault, as it's already wierd, but it ends
being really confusing after the conversion to FOLL_NOWAIT, because not waiting
in atomic context seems completely sane.

> -	BUG_ON(atomic && async);
> +	BUG_ON(foll->atomic && (foll->flags & FOLL_NOWAIT));

Side topic, a BUG_ON() here is ridiculous overkill.  Can you add a patch somewhere
in the series to convert this to a WARN_ON_ONCE()?  The check is there purely to
guard against incorrect usage in KVM, the absolutely worst case scenario is that
KVM simply doesn't go down the slow path when it should and effectively DoS's the
guest.

