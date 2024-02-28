Return-Path: <linux-kernel+bounces-84426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A6F86A6B1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C5B828921E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758D61D522;
	Wed, 28 Feb 2024 02:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BXnfxW/5"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3181CD24
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 02:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709088112; cv=none; b=ZhX28ciAV7H6z2doynU+glv851GmAZtTf5AY8gI6YbWm57JQqjEHOpuuEy1Y0eLpZ8FJskwxd9g5UtijQ6ll1oqPsfHnkxLpw2m/w6k08NXfs/TPHxlEsyx/Qhf5bnCyq2VuCs3L2Rp6NtK9mPbF1h6Win6MqutXg+BUixbTITg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709088112; c=relaxed/simple;
	bh=fot6IvGX0Wk467Q0o26GAtryVO620eXI+SwQAgkJhw4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gyLBmmjeSVIbQhuKn74Xo0c/yLG5p40iab8rTGjPtAgUPRxh2UqKBzjk2OVOeMh9KR2FGRMC6O4k+ZyDSCzUVeApq2/4urqFa9wJ5skxxpvYH1gq/3kUGITLkpen0tUmKHglBI/5VQE/FAsZMNZzuVY0YesjWY81dcPRKbBhnSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BXnfxW/5; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6e43ee3f5e5so3580585b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 18:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709088110; x=1709692910; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53SE99VtRIFLP8URa2ZR5LBSPMEfB4F4A0x9UaRfSO4=;
        b=BXnfxW/5Ti/KVtGUF1bYLpxgYQafnUxhSHuXCrBX5jth1S9eBE+7jHTwIHq4L+P0it
         ZyPcJOxbyxl0J9GHSrsz3c38F2HVtCJR3QBPKIglvTR8aKTmSVGabXIGeRI6LBbTzinX
         p7KAU9Quw7hK65IsR7/x4Nh3pnieDPK04ZXxGrrtuIYxxOrkBPQIbsLgxYNk8n76JYb4
         7s3fJmpxEMFLe4hoqUR5K9+gQGM28AFMxQm+FYzRtj7tLf+7T2GUScOh49znt58R77q7
         3q/MIVaUKr14mKCerriQRNwa+8a5wb3GY8dkvYcQB1JS9HM7/j+ulujS5eEdjbrQHq4m
         Znsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709088110; x=1709692910;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=53SE99VtRIFLP8URa2ZR5LBSPMEfB4F4A0x9UaRfSO4=;
        b=vsZjMlayrEH++iA547/y507sTy5aOwGIT7sLAHHhS8bobLVfEOOJ833lb9+haIsqKq
         b+xK1txHipDw3PY3P1CM7ZlekKi1+jKVFdE04wzfNvLTiw25iXXsyVVZ/RQQjFxWix6Z
         BuHlwakd6y1QMq4jtTQFzUbJZREyKIAtH86qcs1TGDVz0AvwaFNBLdIwWVYZ16jPfcjF
         HCUigX7/iyCr/Xrje2v/s+9Bq9anAFLlQgP7MdNvh3AbwyAqMu4gJadX7ktNghKufuXP
         rTYOamUuqglVCdLL6Mz6wIr0E4OsWNVLRAm6OJdiJK65wZTBvI2nwlbGcdWMyYUBDUlA
         cjhw==
X-Forwarded-Encrypted: i=1; AJvYcCX6hYwUIjH9pmIn7LCjp5MW9xmcfiL0SC+G0XFiwtsdMfDg6IjN0U4lSf6Hop4aRakC6j5M3gcihSZXXibi2pyOuHS59Q+N/jrkwfeW
X-Gm-Message-State: AOJu0YwToGtpKKy3KbS2xZmOowXLRQ5t2gVmcRp0SGp47SvGNPtdXpa6
	J/BTCkVW2w7NKRsoDCJdFSBUBjWaqe7YV6FGYbU97hNESjG3ydPpcZLgrSuTYjpEiVAc9aS6HF9
	Njg==
X-Google-Smtp-Source: AGHT+IHqZjnLQfoLDlb6615ZXQrJj6R337tVGFLkL2HvBVrbR39vItpyAICXZjZm9RQUXtmJjHxJl3bAMQQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:92a6:b0:6e5:44d3:5865 with SMTP id
 jw38-20020a056a0092a600b006e544d35865mr136678pfb.2.1709088110637; Tue, 27 Feb
 2024 18:41:50 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Feb 2024 18:41:31 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240228024147.41573-1-seanjc@google.com>
Subject: [PATCH 00/16] KVM: x86/mmu: Page fault and MMIO cleanups
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Fuad Tabba <tabba@google.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

This is a combination of prep work for TDX and SNP, and a clean up of the
page fault path to (hopefully) make it easier to follow the rules for
private memory, noslot faults, writes to read-only slots, etc.

Paolo, this is the series I mentioned in your TDX/SNP prep work series.
Stating the obvious, these

  KVM: x86/mmu: Pass full 64-bit error code when handling page faults
  KVM: x86: Move synthetic PFERR_* sanity checks to SVM's #NPF handler

are the drop-in replacements.

Isaku Yamahata (1):
  KVM: x86/mmu: Pass full 64-bit error code when handling page faults

Sean Christopherson (15):
  KVM: x86/mmu: Exit to userspace with -EFAULT if private fault hits
    emulation
  KVM: x86: Remove separate "bit" defines for page fault error code
    masks
  KVM: x86: Define more SEV+ page fault error bits/flags for #NPF
  KVM: x86/mmu: Use synthetic page fault error code to indicate private
    faults
  KVM: x86/mmu: WARN if upper 32 bits of legacy #PF error code are
    non-zero
  KVM: x86: Move synthetic PFERR_* sanity checks to SVM's #NPF handler
  KVM: x86/mmu: WARN and skip MMIO cache on private, reserved page
    faults
  KVM: x86/mmu: Move private vs. shared check above slot validity checks
  KVM: x86/mmu: Don't force emulation of L2 accesses to non-APIC
    internal slots
  KVM: x86/mmu: Explicitly disallow private accesses to emulated MMIO
  KVM: x86/mmu: Move slot checks from __kvm_faultin_pfn() to
    kvm_faultin_pfn()
  KVM: x86/mmu: Handle no-slot faults at the beginning of
    kvm_faultin_pfn()
  KVM: x86/mmu: Set kvm_page_fault.hva to KVM_HVA_ERR_BAD for "no slot"
    faults
  KVM: x86/mmu: Initialize kvm_page_fault's pfn and hva to error values
  KVM: x86/mmu: Sanity check that __kvm_faultin_pfn() doesn't create
    noslot pfns

 arch/x86/include/asm/kvm_host.h |  45 ++++-----
 arch/x86/kvm/mmu.h              |   4 +-
 arch/x86/kvm/mmu/mmu.c          | 159 +++++++++++++++++++-------------
 arch/x86/kvm/mmu/mmu_internal.h |  24 ++++-
 arch/x86/kvm/mmu/mmutrace.h     |   2 +-
 arch/x86/kvm/svm/svm.c          |   9 ++
 6 files changed, 151 insertions(+), 92 deletions(-)


base-commit: ec1e3d33557babed2c2c2c7da6e84293c2f56f58
-- 
2.44.0.278.ge034bb2e1d-goog


