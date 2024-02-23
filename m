Return-Path: <linux-kernel+bounces-77634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C162860850
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A9691F21D34
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D529ED2FF;
	Fri, 23 Feb 2024 01:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vaa17W59"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47256FA8
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708652169; cv=none; b=Vt3MChX3gd+9J6egLP7zOzN08X+quqDKTf83n4wgIlKCdbvOtpfmAUkfUaRxr+QB6bnRqcb0DCEiVm6ZfrNsEWNJd1gmxXoqmoUudMnOL1px/V3a08f+yIuLH+9R7Z/MwMBUEfBpvkurGc+UhyKPoZCPGihJ6fr92FsfK/v5+34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708652169; c=relaxed/simple;
	bh=Sq/4yJBd9ML0c0fLMROZQYqcV34f5yTAEpAVQYIXi7E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a8yTmlssMwlyzbp5jLLjkcKc+7wwMwP1Ymf4Ocp2xMtcpgasUqkG4xS7RqaeZsONxeKnHVvC8uXJEKDd4tErUn4H6gqD2nrWOjz4mEsRuLEfVtycwcndhnvMLLEPAhLXYOcQVcZeH+NCB7n9Q0vTp3ebRnQ0kYFwf4IM9LdFrkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vaa17W59; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-299727c3e8bso297186a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 17:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708652167; x=1709256967; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZmbV2p8JhGrv8njDEn0OfasK7J8Wpatj2TP35lEcZo=;
        b=Vaa17W59YeH+XJQrQvNCSwyHTC5c/yazPpK1wXo/e5dnLkECAdX+Qpc9qAYikFypvL
         FZm8uyGDKJ35mxbe/GxcE590eBHk5OkNd0bPHEYugQC9YOk1yYwsDWvgHDUvE8m9/pYF
         FiHLGk9FD1oZCiMp3N6/XgHWhSUHUS6YGnvc7m0zgnfszpEYFetBELH7uGjK/cmWpAk9
         wcY9G1tQnRFNBtP/u5H7V+BPOrZ8DLY+pV4Ldvh4UVfNX+85zNM8uhGgNgZft3FD7tf7
         mlyKfoZzWIlz0rlqpHTJHAM7jHSPu6pA3XtaMqwlSRlnHMC7EIBNLU3pP1hupJTg+/kn
         Xw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708652167; x=1709256967;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZmbV2p8JhGrv8njDEn0OfasK7J8Wpatj2TP35lEcZo=;
        b=KCYvBtjAlKWJP24cl4xwBOaX34zFnrohYaKn6XCOxhb+MGYwFLOu3dkJFmc8M+v0no
         YpLoSlAjvvA8IameM6OPL73vOtP8scXZliH3MStynBmK2mN1+skkiC0Gfz+gBgc0JRt/
         FA1uoa5JDXsLy4doUZ7YA5eT4ByGmj1qRXDkIur2YzajfQM5OUmDX/nsaqyRWu1gwZ1k
         5+99HzbkADMeYqZySX0In/tlc7KqHuPGEtUd50U9i7TAWAkBxcsfVd5ISIOtQMqXfiGf
         mZhOqs0N6vrN2KynuLXdF28hCr01NgQPL7UOrxwIjsEvs0oE4C8ADDQy3iJkzfS8TW+U
         TQwg==
X-Forwarded-Encrypted: i=1; AJvYcCVqX+22eH1Jv3zkPRLWmPljHMI0sruDHdxLo3NMLtapJGPQG5g/v8DMAAgFHgAeCmn0dPIU9Rb0IlP1CLkRIe9mfnx6UMKtzPymX6HH
X-Gm-Message-State: AOJu0Yyiv4FwUTWyTDFIdTeiuPPJx/AlzrLA+/7MGW6VhizODQanSaFg
	7/jt9GJ/KvOzToDRdD7YIsuW44oheMVD9w7+TkT1ilODOV2WHgq32ld+dIsfRE3MWzeZ2lpK31w
	YsQ==
X-Google-Smtp-Source: AGHT+IFIRlJSSVNfaZIh1D4Tx2tEKRHkKjKJlAmofoumEeaMvCyMdcX2UmTyxR+F+By67hFGIjPatd/z0EQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:524a:b0:299:5139:49d6 with SMTP id
 sh10-20020a17090b524a00b00299513949d6mr1657pjb.0.1708652167068; Thu, 22 Feb
 2024 17:36:07 -0800 (PST)
Date: Thu, 22 Feb 2024 17:35:36 -0800
In-Reply-To: <20240222190612.2942589-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240222190612.2942589-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <170865047682.3113211.8370189842632253595.b4-ty@google.com>
Subject: Re: [PATCH 0/5] KVM: GUEST_MEMFD fixes/restrictions
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <tabba@google.com>, Michael Roth <michael.roth@amd.com>, 
	Isaku Yamahata <isaku.yamahata@gmail.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset="utf-8"

On Thu, 22 Feb 2024 11:06:07 -0800, Sean Christopherson wrote:
> A few minor-ish fixes related to GUEST_MEMFD that I am hoping to squeeze
> into 6.8 as the they affect KVM's ABI (especially patch 1).
> 
> Sean Christopherson (5):
>   KVM: Make KVM_MEM_GUEST_MEMFD mutually exclusive with KVM_MEM_READONLY
>   KVM: x86: Update KVM_SW_PROTECTED_VM docs to make it clear they're a
>     WIP
>   KVM: x86/mmu: Restrict KVM_SW_PROTECTED_VM to the TDP MMU
>   KVM: selftests: Create GUEST_MEMFD for relevant invalid flags
>     testcases
>   KVM: selftests: Add a testcase to verify GUEST_MEMFD and READONLY are
>     exclusive
> 
> [...]

Applied ridiculously quickly to kvm-x86 guest_memfd_fixes, so as to get these
into -next before the weekend.  I purposely put these in a separate branch so
that I can squash fixes, reviews, etc., or drop the branch outright if Paolo
swoops in and grabs 'em.

[1/5] KVM: Make KVM_MEM_GUEST_MEMFD mutually exclusive with KVM_MEM_READONLY
      https://github.com/kvm-x86/linux/commit/e563592224e0
[2/5] KVM: x86: Update KVM_SW_PROTECTED_VM docs to make it clear they're a WIP
      https://github.com/kvm-x86/linux/commit/422692098c4c
[3/5] KVM: x86/mmu: Restrict KVM_SW_PROTECTED_VM to the TDP MMU
      https://github.com/kvm-x86/linux/commit/a1176ef5c92a
[4/5] KVM: selftests: Create GUEST_MEMFD for relevant invalid flags testcases
      https://github.com/kvm-x86/linux/commit/63e5c5a10559
[5/5] KVM: selftests: Add a testcase to verify GUEST_MEMFD and READONLY are exclusive
      https://github.com/kvm-x86/linux/commit/2dfd23830344

--
https://github.com/kvm-x86/linux/tree/next

