Return-Path: <linux-kernel+bounces-79189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57315861E9D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9F5A2886FF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05411149003;
	Fri, 23 Feb 2024 21:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ztmZdLIw"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DCA148FF7
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 21:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708723035; cv=none; b=edQ0a50XHXowJoGLhU7r9RCpVtnhUe5ICdctDDrFEab7+dIMhw9nUcPD8bf+gUfzRrAemWcxg81aMzm7yv6821mGzqLNG4A/aiwwhL2oQUvL/SWe+q+Vdi6sRlfhOvAke4IqOjhJvbE/RKnk2blUjk5sztchmmMpmC1IbGkmMys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708723035; c=relaxed/simple;
	bh=LxisIv95tuvftO3gGiQktt0Eq+u0gN9VsyqvSkXAJe4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nD5GhQYaoTFHG19Q/wsyyPZQIUUkZgUJsujIc5gz0n2Bywvek4X+FLU3/7I9Z0yJ5AGaNYNwmY2idc6cf0s4u57Zi4apeWvtsfYfrzyXKw6svWh8XbLFvew82lRNfull7sVxrT50rZA+ea6ChyzXJo0Oj41RSAXu74Iz22mKC/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ztmZdLIw; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608b648044fso22026897b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 13:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708723033; x=1709327833; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XDFyxdBjQUJNu4zRViJQEh+44N1On/mabiEHEUEPoU=;
        b=ztmZdLIwg8YfpJMxhAUzfJZEnwUFV3y9sE0uhfEM8JcMQDcCq9rbEoElyjEXx8N3BR
         l4BaSZX+enW8V+Xxr2mkAGKAQxy/4K4lWJ+XwQaPWx+z7ynEIsfYlwJdClc12Iy62fdX
         s1FVvnmmmuFLrmtpASan9HvF7bi8HCJEsy8KLUezdEcATeWdjiQompLMyD/pPKVyxfWB
         RWmuX0U1dvp/4OzpjVphNbbmbsIBsKlNgtQev0W81GnAwWpHr+ttgdTyuGTAlaQr4mlC
         IT/wxzDTSuZSY3L6B+tkNHqqouEC2yedGCAFDMnz5vmJs9QReBJjscuU7HBOvBPHDMYB
         df/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708723033; x=1709327833;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2XDFyxdBjQUJNu4zRViJQEh+44N1On/mabiEHEUEPoU=;
        b=e1XOMcjnz8MGjSYzSzxbgigTsZ8NmW2BBtYVUw1mB7gUkh1II9eT/DzrN7SvweMT+Z
         6Ep/mSHTsUH5rBnLBcxfAxyMYqZEVv81NteF/43yahbpJ9gyLvYnE1kKYa+r108jj08t
         JAs8sM5igtzSVF3cb5crvw4GdYZMsuS35e9Fl33lh8OdRVHSMnV/M/pR6JTOxZ0VkkXT
         DLth/gQuTi9XoXaz/cw3QNf32KYFtojH3lTJZRKIxyhysKwKgVHf7z4CFvi1YNOyE5ph
         l7hOnfIdCRj2cwJMQX4v2PJBHsVf1mT4KmS0+l81wej1nJC32LoPCFfQgOgKzkQ5Ooct
         FIUw==
X-Forwarded-Encrypted: i=1; AJvYcCV+ZUQM81MhacSaEK9bnqc3WoAP/0nfJi+gWay8xY80i+Fmt9Sz0H1nuwcwTjm8hFJjeL5rDTHIgH/LYpIt+/0qyQmHQ0ZYNqnJDyB1
X-Gm-Message-State: AOJu0YyMBbwx5ZGFjFtxjHyS9BVwniYvlPJmLFelgmSIxJu+BtsMbxxh
	aRn2yEDwZHfeqq7cNpBZcztV1Dx2ombJqwF9YdXxj5irx8g4Sb95wlc3LkEYJiD72kaePGm+96I
	6fw==
X-Google-Smtp-Source: AGHT+IE34KxuSlwnjSNuZi+Gwb2PGg40d6LuI8hIXoHS9JKYn1aVmeC4NARWu4Wm4ebK2/qBz6VielbkT6E=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:914b:0:b0:608:b3e0:3edd with SMTP id
 i72-20020a81914b000000b00608b3e03eddmr232170ywg.3.1708723032945; Fri, 23 Feb
 2024 13:17:12 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 23 Feb 2024 13:16:23 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240223211621.3348855-3-seanjc@google.com>
Subject: [GIT PULL] x86/kvm: Clean up KVM's guest/host async #PF ABI, for 6.9
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

An early(ish) pull request for 6.9 (not 6.8!) to clean up KVM's async #PF
guest/host ABI.  Due to a goof many years ago, the structure shared between
the guest and host was expanded to 68 bytes, not the intended 64 bytes (to
fit in a cache line).

Rather than document the goof, just drop the problematic 4 bytes from the
ABI as KVM-the-host never actually used them.

The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-asyncpf_abi-6.9

for you to fetch changes up to df01f0a1165c35e95b5f52c7ba25c19020352ff9:

  KVM: x86: Improve documentation of MSR_KVM_ASYNC_PF_EN (2024-02-06 10:59:52 -0800)

----------------------------------------------------------------
Guest-side KVM async #PF ABI cleanup for 6.9

Delete kvm_vcpu_pv_apf_data.enabled to fix a goof in KVM's async #PF ABI where
the enabled field pushes the size of "struct kvm_vcpu_pv_apf_data" from 64 to
68 bytes, i.e. beyond a single cache line.

The enabled field is purely a guest-side flag that Linux-as-a-guest uses to
track whether or not the guest has enabled async #PF support.  The actual flag
that is passed to the host, i.e. to KVM proper, is a single bit in a synthetic
MSR, MSR_KVM_ASYNC_PF_EN, i.e. is in a location completely unrelated to the
shared kvm_vcpu_pv_apf_data structure.

Simply drop the the field and use a dedicated guest-side per-CPU variable to
fix the ABI, as opposed to fixing the documentation to match reality.  KVM has
never consumed kvm_vcpu_pv_apf_data.enabled, so the odds of the ABI change
breaking anything are extremely low.

----------------------------------------------------------------
Xiaoyao Li (2):
      x86/kvm: Use separate percpu variable to track the enabling of asyncpf
      KVM: x86: Improve documentation of MSR_KVM_ASYNC_PF_EN

 Documentation/virt/kvm/x86/msr.rst   | 19 +++++++++----------
 arch/x86/include/uapi/asm/kvm_para.h |  1 -
 arch/x86/kernel/kvm.c                | 11 ++++++-----
 3 files changed, 15 insertions(+), 16 deletions(-)

