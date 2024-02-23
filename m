Return-Path: <linux-kernel+bounces-77633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FE286084E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2CA1F23EA0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E3CBA30;
	Fri, 23 Feb 2024 01:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r1UvbqFP"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2664B946C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708652159; cv=none; b=K7nf8FeApAnW/2Dx1tmi70NfD0L7YBoHRoTglzL53Pxa/4DuGU8FcciUhEFEopFYqpRBBFc6VX+EnO927cvQQJDx9LvLXHodHJQ18pxWHhgEVdMxTyQl0OYP59rv6xf9Oj+ooJAHP/WDt+6HpjSGUSCVCcGjye7kFlX8qulQ1sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708652159; c=relaxed/simple;
	bh=XI8lNrFhvMQirXSnyXakzolgwa58LFd9y3miKZB8zvA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u05Om//Ic8VzV5sXgrs+UBAqU5UhI8/RY2s+06vnNu9gSI9wb2LJElzRgRPJTja5gwfNqtB40rse9p3UpQwKrNXbofvKRezrv/jjpaJZFf1JBTt8mmuNt1F1S3y/6DLsPwnKBIBPMViC+rgxDi26vrIpmMFX6V7jMOqV/phIMa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r1UvbqFP; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6087e575573so7952887b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 17:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708652157; x=1709256957; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wUGMc3zyFlAHSNtVJp8fsioa2PQdVv3KdI3cpwnlM1A=;
        b=r1UvbqFPV2ZHWLUXUXLjp3aam9MWt//QX+nQnrZU7yRHbP0oU7Aqm+kRQL6VvunbgR
         1dDX6F40/QbOVNlvpor0GDtSy5v1UKd28KwoPFrFOJI+DkxS4+jkJmcO7kznIKjrBxRq
         VWMqInh2jRKHvG1++q+fLVgstKPQSp+QLMklccsLI/2dicWBzLSvYxwqHKHN21oytSib
         6t2sfAwbbdRMji8IJMP9x12blXsy8JwlFqO3OKa0WpqRF2QTRg/O6hJD4fiaPMeXlh5a
         HVa63enqBf32C3YPAxVhrPC+fstgR2mFCAUGKZBxKzI8+9qKqTntp8aa6Q5/wmhoaMtP
         cADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708652157; x=1709256957;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wUGMc3zyFlAHSNtVJp8fsioa2PQdVv3KdI3cpwnlM1A=;
        b=cVMpBkYFw51i85ZsVbDLwtx909b3h92ubxPGKggEA76djcVR4yQzMwG0wFM/BqbmUX
         upwc5lbYRY5czCHj0LZvNgmc5f0mlqpI0zPBwi3fLjdsAGoVqEveknyGnoxaqPxtg8LL
         LzK9Rm8qvRtevxCuBqmY8U99T6rpL5kIZKI4Z0E6Xya1kyVbvu4bJwZXUXF/B5P5AdUO
         fFrcmmA4mp1dTCOkkWI94N05AFiS4eHu5XzhkGjN2GudU+/sGMrwyb1CB30rbjTBlF8C
         xS3DgVKzHbvwcbEe9VwVar5ehNaO/FXjkfhbmzeAnW/Ah+3lMCtxB3eziLaI8O6Cr+dq
         R0Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWOvNXWWg3RuiANiPA6NU1hqNRiv/3tRJw8EttklRtaZgkUcZohdozdSYHfN4Ep7l7hleHAnBw67LzSvxxv7LAtJC9UMF5I0kfbuPMH
X-Gm-Message-State: AOJu0YyTHxlb0NFjyTg23eBpS9A8RqENPMw7rNA4D27nFDxAsjinz5ty
	DTmBj6W+MdtvHZ1f/McGUOuw8GvFLVeFVcvGcEQ3zNQ223lq8VZyrNkfwa8JlE+PA1W88VDhGB6
	r9w==
X-Google-Smtp-Source: AGHT+IFHk8Ijx/zzzqenZjDsxjYu34JPGEKDbza0rYmYk9VAU6A7x3UggJVyIYF/f06he3HKUlQdPZqWBQA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:f88:b0:604:42a3:3adc with SMTP id
 df8-20020a05690c0f8800b0060442a33adcmr242260ywb.10.1708652157288; Thu, 22 Feb
 2024 17:35:57 -0800 (PST)
Date: Thu, 22 Feb 2024 17:35:34 -0800
In-Reply-To: <20240212112419.1186065-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212112419.1186065-1-arnd@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <170865015209.3110909.14828918936602185476.b4-ty@google.com>
Subject: Re: [PATCH] KVM: fix kvm_mmu_memory_cache allocation warning
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Marc Zyngier <maz@kernel.org>, David Matlack <dmatlack@google.com>, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Fuad Tabba <tabba@google.com>, Shaoqin Huang <shahuang@redhat.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, 12 Feb 2024 12:24:10 +0100, Arnd Bergmann wrote:
> gcc-14 notices that the arguments to kvmalloc_array() are mixed up:
> 
> arch/x86/kvm/../../../virt/kvm/kvm_main.c: In function '__kvm_mmu_topup_memory_cache':
> arch/x86/kvm/../../../virt/kvm/kvm_main.c:424:53: error: 'kvmalloc_array' sizes specified with 'sizeof' in the earlier argument and not in the later argument [-Werror=calloc-transposed-args]
>   424 |                 mc->objects = kvmalloc_array(sizeof(void *), capacity, gfp);
>       |                                                     ^~~~
> arch/x86/kvm/../../../virt/kvm/kvm_main.c:424:53: note: earlier argument should specify number of elements, later size of each element
> 
> [...]

Applied to kvm-x86 generic, so that this doesn't languish with everyone looking
at each other.

[1/1] KVM: fix kvm_mmu_memory_cache allocation warning
      https://github.com/kvm-x86/linux/commit/ea3689d9df50

--
https://github.com/kvm-x86/linux/tree/next

