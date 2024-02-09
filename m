Return-Path: <linux-kernel+bounces-60087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF9784FFB0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5271C220EA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E730E3984B;
	Fri,  9 Feb 2024 22:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kzb/vOQV"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07163AC0C
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 22:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707517025; cv=none; b=Xd1sVZPiTOVrAHHYRS775IQE0htGdZoG0kORv4tWJT0MVQQuXNrnAiR3qMHhzVg3+uLY1yVlzMU/8R4FznVqCiRtyb8Q7hwQa6FMShYVXTuoycrNBXi3O5yJkBhqq3aFAw0TIPvLvEFPIl4iO7egfZt2ktFnFzWBBhRYsh5xevk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707517025; c=relaxed/simple;
	bh=9JikdSipvdk4CPkQDRKibPhnWzuH+2gXV7H2wPj8RH0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PvDLzHXiZw/sNY2Yrd+d9UJ8HU8r0scnmpoFYAwSzIMTxHXitF6Xlk3WfQ/F+IMygQHkuYTDVsE7qnj0+0hBb5Bh8x7P5Zr2qtTJvryUhcvrBOICr5UB+u/zB9rRLG/TGBZ/3UD0N56xFSXY7q2u9kwRUZLPrHGxm9Gm1i9pBgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kzb/vOQV; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26ce0bbso2663335276.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 14:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707517022; x=1708121822; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzYnSOsBsYlPOE5QaqJSJoUlPUKgrEZB23Y9jp7yz4E=;
        b=Kzb/vOQVGXFxluQMdzApSmKU5C8iNVCugLYOVQ0mSgFiVT4NQa+Wf8xBORmt6wTERy
         gi/LVyr7tgEzZJK7CbBEY8Uj8Qg0jK+AIglt5zwYwrgvajkfrSRfrbxrNRMJqL9g4PeV
         pz/axuu/Hfa8gQ9K9gwwU9rT6BxOGeVW82DLfUKNnX6TgcjAjOqMei5gX+FzyqKGiQiZ
         bsnL3b05G/OMziKHcS6629Dm3OUy2vPRrUoDyqG9AnWOQSif0CR/dZdRdJiduje9zNai
         8Ww/HSDGoFIaZfB5OzQ2udhQ0H1hVSZCxHjhmLfm77AJn4SSa73B2GVizJ6iooj3WtH2
         owMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707517022; x=1708121822;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fzYnSOsBsYlPOE5QaqJSJoUlPUKgrEZB23Y9jp7yz4E=;
        b=YEPrGYa86Y9tFmNIQl4xykUefNwJOijkuaqFL9PmdsIAX65M+qxhSaj42DGVw4+x3z
         YT8+DCkd0yPfdr4fjo7haKCHSK3MJHwXPMJrXNfStXuNANb3P7kBGrCVyT8uKnXpxNSD
         B8RrLRgrJ/+xNSnUJD9SbSNnCgG1j8dIj+ol9qzAGbtHG0AKBKFSF6R7dJ2cttVgFa0n
         Bmsx1XZcF5zLdMemXM5E7ZTfVaIri5iVCRx5BqiDTVFWA5/ONP/Xgp4/vF3TxwAVIZBf
         jWPjiaSgR9sQOvCJwA1p1xQlZ4UZcOEjWvxMvx1E6uS4s8y5TZbG+KOP4zjUpCf1MydR
         UeUw==
X-Forwarded-Encrypted: i=1; AJvYcCVjbJcaWSz0X/atf2eUaeMMgEA53BtZRgAD1ZO62QKC7MnvMObSjfusevtq94C0tFsFBG3tBNDNpnMF4wI7pCOHkluyJu8UowONW8Vm
X-Gm-Message-State: AOJu0YydplpkkxMw1XGtO6mv1Jjd4m4e9n1m9X7XnaCBT3oWq9YC1eD3
	yEUkEW6RaZtm0p/DsQUYFWZ/beN26/KpRBfxBwkY97Zz5u+Dz+RFyyWZwEpzmAiFECr0dxK0IeW
	kag==
X-Google-Smtp-Source: AGHT+IHExzOLXjqk5W09HFGU0N3HogH1FlA2vbZl2LsJoAYfDp5YoIc4PNXhQ+D89mwjLt0oMsjj7Ak3igY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:100b:b0:dc6:fa35:b42 with SMTP id
 w11-20020a056902100b00b00dc6fa350b42mr111020ybt.2.1707517022804; Fri, 09 Feb
 2024 14:17:02 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  9 Feb 2024 14:16:57 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209221700.393189-1-seanjc@google.com>
Subject: [PATCH 0/3] KVM: nVMX: nEPT injection fixes and cleanups
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fix a minor bug where KVM doesn't clear EXIT_QUALIFICATION when injecting
an EPT Misconfig into L1, and then move exit_qualification out of
kvm_vcpu_arch to avoid recurrences of the bug fixed by commit d7f0a00e438d
("KVM: VMX: Report up-to-date exit qualification to userspace").

Sean Christopherson (3):
  KVM: nVMX: Clear EXIT_QUALIFICATION when injecting an EPT Misconfig
  KVM: x86: Move nEPT exit_qualification field from kvm_vcpu_arch to
    x86_exception
  KVM: nVMX: Add a sanity check that nested PML Full stems from EPT
    Violations

 arch/x86/include/asm/kvm_host.h |  3 ---
 arch/x86/kvm/kvm_emulate.h      |  1 +
 arch/x86/kvm/mmu/paging_tmpl.h  | 14 +++++++-------
 arch/x86/kvm/vmx/nested.c       | 30 ++++++++++++++++++++++++++----
 arch/x86/kvm/vmx/vmx.c          |  2 --
 5 files changed, 34 insertions(+), 16 deletions(-)


base-commit: 7455665a3521aa7b56245c0a2810f748adc5fdd4
-- 
2.43.0.687.g38aa6559b0-goog


