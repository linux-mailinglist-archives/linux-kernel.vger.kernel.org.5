Return-Path: <linux-kernel+bounces-55634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4030C84BF4B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F10AF2892BA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242C91C28B;
	Tue,  6 Feb 2024 21:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rc2xTV7Q"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02A51BF3C
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 21:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707255403; cv=none; b=d2sbyx6nrZm1pW1TvoBEtfUux5E0Itdew9B6Kkbh15AV0NBdYA2cq7CFmUdzg6hmNDXby2GwCxQpUqg37dwfbGDk+0QwFvxEW5hE48p9qQvEVyVmX/xMfEu46P+cVCIJmuo7W0LcZGXV3x0R6/kk3mGem5bqHFgjulIhNUUiJJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707255403; c=relaxed/simple;
	bh=kD/YJvVFMz2zfoPqiBiePE4hKWb4qezxebG1wZUrWko=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aFYEUVpKkiPGbc5e6xVSaEQSA6ChmP7W7HAcetj+ln46VRtvbTQCPt9Bk3hXpIoOBpTEfbM1XNQ/qD5/hj5w4I0pHU7gaQWda7zyXAt6HzjtZZCU1uLNQOxZMzkJ3hD/7U1X3WbUdFQhMAG3L4tECAmMeH9OjwxrYYu5ZgtCq3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rc2xTV7Q; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6ade10cb8so2125938276.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 13:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707255401; x=1707860201; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o7+bVQHJaRyecFmR/al20pTpulDAHGo9wRV2MgKbGD4=;
        b=Rc2xTV7QAlOR9CsieAQb/x9Yv4kogUwKWkSwI5FMML+AfGvEgbHiqcB5vZQnvgb0X6
         mPFO8zt7wjizzRt44wrcyG4l3rZ3CyyUKgrF4f48PiwhLWkLKLYUipXMHIvwyrjIkLCH
         Ewc9W3G5z86mruPv2bmZ/2uBhQD3pzXWj7IQlPfv/+l4epRD7cz2UOnSeSI8bV/1wKr8
         5jndmIGw3/ogkCoxCTuG3gJqSS7Xo/QI40S5CaDv8bVTW7TFnSrB8u8+1mblNlMdjiyi
         o4roNurBzZo1t5LGYcfMbiClSCkIGDLaDKQd1Wyx/OH737FPePJDKJpkmD6umGF6dtTi
         XWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707255401; x=1707860201;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o7+bVQHJaRyecFmR/al20pTpulDAHGo9wRV2MgKbGD4=;
        b=Cf10XKIMCDZCAU4b3cLY9SJ0rYm6/dupYSzDfuLvw2YvESkXzRB0VcI0/4G5PIVHZq
         qDOe4mSYFKYC+IjGZc35dPcmbem6RV0MJQtlYdatHA3Nd5RU1RABaYjsPaE8ZIP1YQvQ
         PPltQcIWjicowBSPsepjI1sOdtvRiiPfuwnbz/v83V6UDZeaWgULmSues2i3xcXjxweS
         KFogAeNFTTTqgHuZ6P7F8nhRITN7G2UWiOwSIMmMLLL/1yXKJCyD0dG/bWxaN/AE0MXA
         Y/P/32/x3Bw/yDa9TcV4FY2es+9eBSdz3QvHlCQH7JoIocxbbW2jjvT1LfKwLJ2TUpqk
         bs5Q==
X-Gm-Message-State: AOJu0YzKnwjxkdiaoDbwg5+zsbgOyDvp0lsM4I7j9TL1S+aG3oi5S9iN
	f/lWxgNv5ll3UtSp6bD8Tj/0FcjKQIf8K4NTHzREIGkwxVtYAL9OWD4GUisVdADLWuCGMN7rplN
	sig==
X-Google-Smtp-Source: AGHT+IGWXwnwt4WJBoRQ26tceTKjhBD33lBIwzUADqGoiwxg68ljWZSRTfP3sFs6yF+ZLaYS1zEv+kewPvQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:f12:b0:dc6:deca:8122 with SMTP id
 et18-20020a0569020f1200b00dc6deca8122mr508282ybb.5.1707255401032; Tue, 06 Feb
 2024 13:36:41 -0800 (PST)
Date: Tue,  6 Feb 2024 13:36:13 -0800
In-Reply-To: <20240110011533.503302-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240110011533.503302-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <170724643076.390683.15757663236296481465.b4-ty@google.com>
Subject: Re: [PATCH 0/4] KVM: Async #PF fixes and cleanups
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Xu Yilun <yilun.xu@linux.intel.com>
Content-Type: text/plain; charset="utf-8"

On Tue, 09 Jan 2024 17:15:29 -0800, Sean Christopherson wrote:
> Fix a use-after-module-unload bug in the async #PF code by ensuring all
> workqueue items fully complete before tearing down vCPUs.  Do a bit of
> cleanup to try and make the code slightly more readable.
> 
> Side topic, I'm pretty s390's flic_set_attr() is broken/racy.  The async #PF
> code assumes that only the vCPU can invoke
> kvm_clear_async_pf_completion_queue(), as there are multiple assets that
> are effectively protected by vcpu->mutex.  I don't any real world VMMs
> trigger the race(s), but AFAICT it's a bug.  I think/assume taking all
> vCPUs' mutexes would plug the hole?
> 
> [...]

Applied to kvm-x86 asyncpf, with comment tweaks as per Vitaly.  Thanks!

[1/4] KVM: Always flush async #PF workqueue when vCPU is being destroyed
      https://github.com/kvm-x86/linux/commit/3d75b8aa5c29
[2/4] KVM: Put mm immediately after async #PF worker completes remote gup()
      https://github.com/kvm-x86/linux/commit/422eeb543ac9
[3/4] KVM: Get reference to VM's address space in the async #PF worker
      https://github.com/kvm-x86/linux/commit/8284765f03b7
[4/4] KVM: Nullify async #PF worker's "apf" pointer as soon as it might be freed
      https://github.com/kvm-x86/linux/commit/c2744ed2230a

--
https://github.com/kvm-x86/linux/tree/next

