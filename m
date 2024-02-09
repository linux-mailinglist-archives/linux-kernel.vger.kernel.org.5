Return-Path: <linux-kernel+bounces-60104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA8384FFE7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1CF11F2333A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38F224A18;
	Fri,  9 Feb 2024 22:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SIscm1Td"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FF22E3E4
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 22:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707517743; cv=none; b=nQi+zgAi4vKHckp3QEmrCIiC/f8rqunSgtZLxzV67u+et0qU9yHspZj46QZhOgtJcRHGk1AQLD7MCpltfbWYZ8xYhWxynJH2uVHGOpThKOrcBLlDHLswuXJMqVg7IoRZ3NLHT8zUIdTOcUun4b8RBWrQVjjrolVpMtbo/BdZZeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707517743; c=relaxed/simple;
	bh=fIqYvORhxAkyZm48va/2ujkvGA7C8gveY8KxKZlfit8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=C9dcoiuI9sIkUNnH4nzQvL+SwwveoERyrN2XsnuSyti3tL2ZTR5Nj8//9RbZ+z31Z8Jy92yoUEUDCV/+vlifiY9HK9dPqSXB/za0/vPeogUGouGvx/hywIJs1Lu5AJQsOYAq1UfvjxwwDaKfPDba+tkX3/n25rU90jyOCV/ki00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SIscm1Td; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5c670f70a37so1466765a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 14:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707517741; x=1708122541; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5hQFyPpf+rydxjBfMUUkTUJgr64hFiwgdcvFQinuS0=;
        b=SIscm1Tdv48XiEjz2aULMyi6MQ2rnjaJt5Fwnz4t1rR2ImKXv1n3e/fvvp62YQr79b
         0mLDKp1cJ8wilJVvw3JnI0V2Whdwai95C/Wzv/+qTkjtCFN0dBDqcdPv2ltLMJnMSUlw
         qJtNzqknyiVBq2hlElFG+aMUJZVeNiCrSBahIp++bADTzPs2R+36tSW1HQTJedLWK4+u
         oQbctEz9n7rJwrUW/y9/0dkbEBDEPH4/FGeynSggChs29A12dqT+RUxOQrX536SoWIPM
         bRazaiSeqGXMODYPwEC3fQpSvU67iZkem4e8wR0l0j0Ie+qSceiYz/piiIw+HVd1/kTQ
         3f6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707517741; x=1708122541;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H5hQFyPpf+rydxjBfMUUkTUJgr64hFiwgdcvFQinuS0=;
        b=B1SY4BN6StV8R91B+s1DJZF90msZ5jtRohGNzajqYRvfzPS4vzDwtME+fzzlDHQCFd
         pZ3SRwVqrgn+qtqke/sYdUef1RUWrbNl7AYH9oooOq8v/FlEW0sKygn9oq3BnvNId7EN
         Ut2iiQN03mmlAAT1N+XwDmICDxMP67q4OhiPm5VrVcWrUAFpLI54N7ggqFjHbhCV37Mw
         f9mjlTONMvIbhP9nfRVNDOn60kyfzm5rCAYYVklB6av+4xZkMWyPWmL1ht2bRbxyqgxa
         R1L/6dMVn1iQCxtugNVyXX/m2xjgnC00isHZX7S0TwpyApVBAP2KBagy7SZK7A6wLtNj
         NhRA==
X-Gm-Message-State: AOJu0Yxw4XT9YnbAJek38nyASs52KiQdh2276J11/12kigG7W/03RAL1
	/uxm7375yeig45LMSI3jAjrwjVO0p+FbLFCyv1DkrFIbe47+/U23zRzPWjXrJHLDIra1arovbNu
	xYA==
X-Google-Smtp-Source: AGHT+IH4XFzuF2DKPAkh093CaHpAAUCLEz9Un/+UQsFkngrgKl6K7U6HxZSJmwZ1mrguGsAZTnMEI+Kpv+o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:6d07:0:b0:5dc:5111:d8b1 with SMTP id
 bf7-20020a656d07000000b005dc5111d8b1mr936pgb.5.1707517740545; Fri, 09 Feb
 2024 14:29:00 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  9 Feb 2024 14:28:54 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209222858.396696-1-seanjc@google.com>
Subject: [PATCH v4 0/4] KVM: x86/mmu: Pre-check for mmu_notifier retry
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Friedrich Weber <f.weber@proxmox.com>, 
	Kai Huang <kai.huang@intel.com>, Yuan Yao <yuan.yao@linux.intel.com>, 
	Xu Yilun <yilun.xu@linux.intel.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Fuad Tabba <tabba@google.com>, 
	Michael Roth <michael.roth@amd.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Retry page faults without acquiring mmu_lock, and potentially even without
resolving a pfn, if the gfn is covered by an active invalidation.  This
avoids resource and lock contention, which can be especially beneficial
for preemptible kernels as KVM can get stuck bouncing mmu_lock between a
vCPU and the invalidation task the vCPU is waiting on to finish.

v4: 
 - Pre-check for retry before resolving the pfn, too. [Yan]
 - Add a patch to fix a private/shared vs. memslot validity check
   priority inversion bug.
 - Refactor kvm_faultin_pfn() to clean up the handling of noslot faults.

v3:
 - https://lkml.kernel.org/r/20240203003518.387220-1-seanjc%40google.com
 - Release the pfn, i.e. put the struct page reference if one was held,
   as the caller doesn't expect to get a reference on "failure". [Yuan]
 - Fix a typo in the comment.

v2:
 - Introduce a dedicated helper and collapse to a single patch (because
   adding an unused helper would be quite silly).
 - Add a comment to explain the "unsafe" check in kvm_faultin_pfn(). [Kai]
 - Add Kai's Ack.

v1: https://lore.kernel.org/all/20230825020733.2849862-1-seanjc@google.com

Sean Christopherson (4):
  KVM: x86/mmu: Retry fault before acquiring mmu_lock if mapping is
    changing
  KVM: x86/mmu: Move private vs. shared check above slot validity checks
  KVM: x86/mmu: Move slot checks from __kvm_faultin_pfn() to
    kvm_faultin_pfn()
  KVM: x86/mmu: Handle no-slot faults at the beginning of
    kvm_faultin_pfn()

 arch/x86/kvm/mmu/mmu.c          | 134 ++++++++++++++++++++++----------
 arch/x86/kvm/mmu/mmu_internal.h |   5 +-
 include/linux/kvm_host.h        |  26 +++++++
 3 files changed, 122 insertions(+), 43 deletions(-)


base-commit: 60eedcfceda9db46f1b333e5e1aa9359793f04fb
-- 
2.43.0.687.g38aa6559b0-goog


