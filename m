Return-Path: <linux-kernel+bounces-98169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 404378775FB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 10:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637D21C20D4E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 09:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35131EA71;
	Sun, 10 Mar 2024 09:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GAascpdI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BE416FF43
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 09:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710063366; cv=none; b=dLtJcg7PKX7PAthq2yMpeIbYcOnhbXe8SGkFWjmm5cm7XFau8lFoL2tq/EshcmprEYMVT0+R/Hwh0T7XJ9BB/m5Vj5HqfO7kUAvgvaZYvWMUFcC4WHiVhE846S2E7S0Q32GINmwkvfARfDUBdfIlBjHynom2He61GvdWzgEVt4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710063366; c=relaxed/simple;
	bh=++KjARGJ8nOD8jfz8bqml8G9vV6c0LtPQdkxRUz48aI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VbijmUnOPB/0wTt+2DuVegH8FxgkivQAVAGXznjqZ6mNYXVXQCotnjK2P2YBMOO9wMp06VJRJqzDk5jIMqND35mlrK7jRzkCYBI8EasaKqJuZZj4WlqOQCZiUwTTUbDyxdQwE/irFo71WXivk8YDH3XnjuLy7JRJv9lKhIMvgzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GAascpdI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710063361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ewYyqZGEFtGRF9uF/AbyS4xwOgMo8zaoUtbs4DsxlK8=;
	b=GAascpdImZoYD3gz3OMJwZngatvAzQYIdPqpoI12R/nNkOGhzag7Xv/ukaUjUVg5Z15e99
	tx8bb2gEjb2c4szHejy7bPZ1JcgaqgWweAJbDUdVVY9CKUqkRaMGOLB4wNANULXfTH0UCV
	bcVvDawa17XZJXdTnmXkLKUgLZUqFyg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-iAb5GYG2O_G5X5HMZUkzdg-1; Sun, 10 Mar 2024 05:35:59 -0400
X-MC-Unique: iAb5GYG2O_G5X5HMZUkzdg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a456c9d0717so164508366b.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 01:35:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710063358; x=1710668158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ewYyqZGEFtGRF9uF/AbyS4xwOgMo8zaoUtbs4DsxlK8=;
        b=NxOx0SqtBn7pdR64JvSnUcrIKwqm7Q4eweMvv/sjvl4PNaSS+WYkXE2fQuFurywhGn
         1KvXDsYd+IL9v/xJV2Fp9/IeZhumQh+ZvyFvyqYYDPJ4bdu++A1XfCsNLoAkajX9mtqC
         zu8NkjxhEZFchw224ztJ28bI3Ap0CfRPVIKyIbo11bNwgKayUHr9NUMtx5lc21GebdFa
         1HNG6VaPkMwwEgvfVEdAYfBy4u5AqjtFuVqJ9dCpKrF++JhZV0oAPcogipGto0eEA9dB
         DivkYxTPD7RPSCGN1Mf5cjViWnN9eBZ+vigOcG22T7j2mrb0i/RVo+hQ6HAkZMWo4Qmo
         5peQ==
X-Gm-Message-State: AOJu0YykLPBNJk/bd23sVGQ6NrHpvkrcFhIS2WWaRkYteLU7H2JmXHhS
	Fsb8lIDxy0CJNL5SUbDeZLEGSJ03COtTVY1vuDs2he2mOa89fqt6bJlJFsG/gE7Eedp1UL9Vfbi
	Ft+LZldaG7kQiRPzr06YO3QvQ+9Nb1SYlYV5xbbHoAjs8vF4ekAKwZtwu/Odq3Q==
X-Received: by 2002:a17:906:cd1a:b0:a45:89f3:3947 with SMTP id oz26-20020a170906cd1a00b00a4589f33947mr1827716ejb.74.1710063358416;
        Sun, 10 Mar 2024 01:35:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/WyEABvZUnrPc97sKvwmUZLhFb/bAv1V7yyBIgS32g7raZF+WotMm1ZkrzHppYH5DoGd5Tw==
X-Received: by 2002:a17:906:cd1a:b0:a45:89f3:3947 with SMTP id oz26-20020a170906cd1a00b00a4589f33947mr1827710ejb.74.1710063357981;
        Sun, 10 Mar 2024 01:35:57 -0800 (PST)
Received: from [192.168.10.118] ([151.49.77.21])
        by smtp.gmail.com with ESMTPSA id c6-20020a056402100600b0056850d5ee00sm530799edu.15.2024.03.10.01.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 01:35:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [GIT PULL] Final set of KVM fixes for Linux 6.8
Date: Sun, 10 Mar 2024 10:35:56 +0100
Message-ID: <20240310093556.653127-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit c48617fbbe831d4c80fe84056033f17b70a31136:

  Merge tag 'kvmarm-fixes-6.8-3' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD (2024-02-21 05:18:56 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 5abf6dceb066f2b02b225fd561440c98a8062681:

  SEV: disable SEV-ES DebugSwap by default (2024-03-09 11:42:25 -0500)

Sorry that this comes in a bit late.

It's a bunch of fixes mostly involving confidential VMs; in particular,
many of the commits constrain the new guest_memfd API a bit more, so
that we're not stuck supporting more than it's necessary.  However,
there's also a rare failure to mark a guest page as dirty and a fix
for awful startup performance with preemptible kernels (including
CONFIG_PREEMPT_DYNAMIC in non-preemptible mode) of guests with many vCPUs.

----------------------------------------------------------------
KVM GUEST_MEMFD fixes for 6.8:

- Make KVM_MEM_GUEST_MEMFD mutually exclusive with KVM_MEM_READONLY to
  avoid creating an inconsistent ABI (KVM_MEM_GUEST_MEMFD is not writable
  from userspace, so there would be no way to write to a read-only
  guest_memfd).

- Update documentation for KVM_SW_PROTECTED_VM to make it abundantly
  clear that such VMs are purely for development and testing.

- Limit KVM_SW_PROTECTED_VM guests to the TDP MMU, as the long term plan
  is to support confidential VMs with deterministic private memory (SNP
  and TDX) only in the TDP MMU.

- Fix a bug in a GUEST_MEMFD dirty logging test that caused false passes.

x86 fixes:

- Fix missing marking of a guest page as dirty when emulating an atomic access.

- Check for mmu_notifier invalidation events before faulting in the pfn,
  and before acquiring mmu_lock, to avoid unnecessary work and lock
  contention with preemptible kernels (including CONFIG_PREEMPT_DYNAMIC
  in non-preemptible mode).

- Disable AMD DebugSwap by default, it breaks VMSA signing and will be
  re-enabled with a better VM creation API in 6.10.

- Do the cache flush of converted pages in svm_register_enc_region() before
  dropping kvm->lock, to avoid a race with unregistering of the same region
  and the consequent use-after-free issue.

----------------------------------------------------------------
Paolo Bonzini (3):
      Merge tag 'kvm-x86-fixes-6.8-2' of https://github.com/kvm-x86/linux into HEAD
      Merge tag 'kvm-x86-guest_memfd_fixes-6.8' of https://github.com/kvm-x86/linux into HEAD
      SEV: disable SEV-ES DebugSwap by default

Sean Christopherson (8):
      KVM: x86: Mark target gfn of emulated atomic instruction as dirty
      KVM: Make KVM_MEM_GUEST_MEMFD mutually exclusive with KVM_MEM_READONLY
      KVM: x86: Update KVM_SW_PROTECTED_VM docs to make it clear they're a WIP
      KVM: x86/mmu: Restrict KVM_SW_PROTECTED_VM to the TDP MMU
      KVM: selftests: Create GUEST_MEMFD for relevant invalid flags testcases
      KVM: selftests: Add a testcase to verify GUEST_MEMFD and READONLY are exclusive
      KVM: SVM: Flush pages under kvm->lock to fix UAF in svm_register_enc_region()
      KVM: x86/mmu: Retry fault before acquiring mmu_lock if mapping is changing

 Documentation/virt/kvm/api.rst                     |  5 +++
 arch/x86/kvm/Kconfig                               |  7 ++--
 arch/x86/kvm/mmu/mmu.c                             | 42 ++++++++++++++++++++++
 arch/x86/kvm/svm/sev.c                             | 25 +++++++------
 arch/x86/kvm/x86.c                                 | 12 ++++++-
 include/linux/kvm_host.h                           | 26 ++++++++++++++
 .../testing/selftests/kvm/set_memory_region_test.c | 12 ++++++-
 virt/kvm/kvm_main.c                                |  8 ++++-
 8 files changed, 121 insertions(+), 16 deletions(-)


