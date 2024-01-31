Return-Path: <linux-kernel+bounces-45558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F3D84325F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C52C01C258BE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5813FDF70;
	Wed, 31 Jan 2024 00:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VUfHScXT"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A28CA68
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706662779; cv=none; b=MPCCfPU59aYYliS3oryyu1pgIJExvoDhNmFpf0H0q7a3YfJSug6Qef3cqg6kBq9B9RcBqNnRdRgUPXrpaQxeuq/RztMvuzgFZrhiuqVi6kdlgPB9iLs7jlDBnBOjSsvNopRX3J7bE0U9/81lFmh6NfV7covx3hd5vVwEHnyow2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706662779; c=relaxed/simple;
	bh=a3e/knvwUFk/+6p5cl7jRlVgDjdA27E0WtmF3pWVYY4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iQMJDYqoRFhif8Nc/C63EyzQjUZL2DTd48dbMZJpISJ9xShv20xp41fI2Ob6HnqzJFWMVC4gH1xBr8MaymH61fx1VKwHKR5hq7Ju9cQ9VpveFDbd10kDtaB4zBCinOX9o48rkZKYKJhi5yqGXwCMWRBOjYZrASRb5Cu+T2DEy1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VUfHScXT; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b9f4a513so547780276.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 16:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706662777; x=1707267577; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=90q1CdG4fldsEQKSI5ABvCuyjkkZoVa1ihGQCUX71GE=;
        b=VUfHScXT3+I0J12CRw46xSJD004xfPga3yr91FA3yXgQ/LPMniW6CvjVqG6Lw3QPo7
         6a3ED77HNLVgnOBQA2rv2VjPEuyYM/SAkZxHF5y5TKbrAwICpFYKMomHvWM+NnHL2/bE
         It8wb1monj9TviHsJFB/MXn/OQb2hroqsdnhaI8J5u+PaHtw3JS/JVLVxJ1lwYuOJ6uh
         94PA9/IscSa4r0s3ZIdq5LsjGIFybx7VdO4LpKIl8RdNeUpdJkx/ihFrGBhG9VXu2WhN
         UhONZfHn11pychJPEQaTESAjEm2TyaB0EL1tj/649lI3aeonW5xDZstxtmWIToezwcwz
         WNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706662777; x=1707267577;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=90q1CdG4fldsEQKSI5ABvCuyjkkZoVa1ihGQCUX71GE=;
        b=YHlcz5i8zv8PfCzuOfTzgNgHcR16G5hN0Ivj7DyUTDqgpgIh5icg+Vs/urEiNLCw7Q
         bGJjd2KsTc5Xrr2eVUtWnT/7zbfeeGKXlbgkuNrF0L7zNdLMPwbVQeaaZ8thKNx4X6Lj
         TlPHKV8i0QoGrspNqEJPYGcmfsYWextmRWjt6oA49a2+Zh59Ql8/7Em4PggrcvjpqTeX
         90oOmpIOFOJvuVlZI0eZcM3HUNbiNDS32IBAabDWYCTHjbqmWZ5IoAolD3oh19mWHO+F
         dBAzcjNLCiGxxY3Lq3eJxvgtFl+M3YcIbOKlsqR8DMHLMjDJ3CSMIaAeTXVEBJOxdc4i
         8ZXQ==
X-Gm-Message-State: AOJu0YyxpVMisciN1ybwAdcaJzWxRhfvD/hOnoSAtfif64U70OOk7SXq
	EdgwT6Xrtkde+uqkG2msG8W696rSiaWHlqLYeNdwqcZmcqdJ+o9hR/c0yf20C7UJKJvDm4D6Yx7
	wvA==
X-Google-Smtp-Source: AGHT+IHhehnaZ+PJDYlxfoOUSUPsYKa2to+EQTN7X63j1zwisjsEvbZ6WBMrgf0oBHzbx414Rt/VF5JY9Sk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2687:b0:dc6:2054:fc89 with SMTP id
 dx7-20020a056902268700b00dc62054fc89mr66813ybb.0.1706662777130; Tue, 30 Jan
 2024 16:59:37 -0800 (PST)
Date: Tue, 30 Jan 2024 16:59:17 -0800
In-Reply-To: <20231030141728.1406118-1-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231030141728.1406118-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <170629109916.3097852.3849458152684678421.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: User mutex guards to eliminate __kvm_x86_vendor_init()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Nikolay Borisov <nik.borisov@suse.com>
Cc: pbonzini@redhat.com, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, 30 Oct 2023 16:17:28 +0200, Nikolay Borisov wrote:
> Current separation between (__){0,1}kvm_x86_vendor_init() is superfluos as
> the the underscore version doesn't have any other callers.
> 
> Instead, use the newly added cleanup infrastructure to ensure that
> kvm_x86_vendor_init() holds the vendor_module_lock throughout its
> exectuion and that in case of error in the middle it's released. No
> functional changes.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: Use mutex guards to eliminate __kvm_x86_vendor_init()
      https://github.com/kvm-x86/linux/commit/955997e88017

--
https://github.com/kvm-x86/linux/tree/next

