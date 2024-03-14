Return-Path: <linux-kernel+bounces-103892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C75087C64E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5337E282D1F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FBD17579;
	Thu, 14 Mar 2024 23:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IUfp/yck"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB06D14A8E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 23:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458802; cv=none; b=tu//hjW0YIyEjyRT64wbMe1q3X6ueP+n92KDIu413Qh6HuApzu9Ez4seE/e9oHU7yUNZkbBCx+5btiS9CybTVN05V9d+yMnEJER/Ima56D1IuTW6oR90pAJCteFLKqz88+6fKwbj/RV7aNVgGJgjerGw5NQzcavTxf8Ea+Tq+2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458802; c=relaxed/simple;
	bh=rHlVStDEOKpOujnyeMUdLxN9RPKooIOT8Uf7Wm0+6SM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=svRolHz79Via0BZlqZg2ftKErSABCTJiNeSIs0uBVfXtJ/jlaNEFtb9HFs8ZMp9hVRrkVs1bOd1LX720BgvgmthsyFT4CAQHwkiXJ9NQOK++s06H9hFV5YD2WjmW7PNgnXuudQRiIoDf7B+8+s4yYN3qCtst02aAeGg9nZBmOfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IUfp/yck; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-609fe93b5cfso27435337b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710458800; x=1711063600; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7s5Hb/mvTE7PCNAe2dunBDM+z2TyWomMuHISUh3bYw=;
        b=IUfp/yckBMOevaTR/EYIH+mSAnNCqKkyTHkRmc5zlC+7sqk8CPZXQYUtpsRPymGY+e
         2SuDr7ClmVmJ3TGPBhD6aDX2+UZ0EWuO8O7dWluoTyHOgP9PCAsFe3RIwX5zT5LtTRwt
         dtizexqvEcI48rj3GfbQyc0DlmWFnhYBkB2wQ2NFIkNft9qg/vybBt2yFowy9/jSt/Tg
         3lgSw0YikYmwyBwc4xzz1LLZ5JDjDYy7EMWHjTufEV4zaXk7SQTY9BuhXEl9JthnBSNc
         vmERERizPs4XNLCDBfZ1KPFbteE99SZefi9TaoFD0g0fYIlDRPUPioddvhCL0d6lBqET
         k7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710458800; x=1711063600;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7s5Hb/mvTE7PCNAe2dunBDM+z2TyWomMuHISUh3bYw=;
        b=OCOkpcK5hSIqDqOdvwZ219sefurfA7J3PQ8pNMaoZxhDoCC/jZOMqXFCVMSBIjJ5zZ
         7WeXB9m7egincWzwKaLfeTttO4ystSvfi5CZuOzpuBckVX3Tbf3ds3mHdUKUqJQxRcHg
         SyWPcihZyIAyYrQfml/Q+EV9P9dueYNI92fHk1qVGzqPZBNcr9iG2IQGmsOzKRhel9jf
         jx6YMokM6PMTB4FtXtEof0xNc2QmeOZtgCZ6hpZXTv5blDPgAO/VvkqoGCUnz35qOLJT
         PDO4hQLjPoPxLpXfC5ybP1m5kkqf58fo7QRhBbmkSazjXwsAKTPeQMbxtuBpEBn9WwEr
         jefA==
X-Forwarded-Encrypted: i=1; AJvYcCXqbJ+CqKFTY5uktSF/a0zUKfy0aFjvCJrmHsgRDHCRWCoKII6rSayYl5MT2jRCZCfmebvOfDI7c4dZo6KczB74qMypGvr/cotEX21v
X-Gm-Message-State: AOJu0Ywuc0Y4RYafiiR7DbK2Dd/fBeR4ipXO6/J4YJzpH+rMjHrmwwPH
	q6JKraWRDkSU/d44V1P4nCqXoe7GEaTqg9TwVEBIXVz5tINil6ITJ3SKu4JypZESCIoD//ZvJWl
	w1Q==
X-Google-Smtp-Source: AGHT+IHgAdumMdpyEXTw01m4vqKLDoztLrdIMo9Notb2dmLotdpfdICdJ17nIIZegdAzzB6H1KgUKYmEItw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:f10f:0:b0:60d:47bf:235a with SMTP id
 h15-20020a81f10f000000b0060d47bf235amr173723ywm.5.1710458799770; Thu, 14 Mar
 2024 16:26:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Mar 2024 16:26:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240314232637.2538648-1-seanjc@google.com>
Subject: [PATCH 00/18] KVM: selftests: Clean up x86's DT initialization
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

The vast majority of this series is x86 specific, and aims to clean up the
core library's handling of descriptor tables and segments.  Currently, the
library (a) waits until vCPUs are created to allocate per-VM assets, and
(b) forces tests to opt-in to allocate the structures needed to handler
exceptions, which has result in some rather odd tests, and makes it
unnecessarily difficult to debug unexpected exceptions.

By the end of this series, the descriptor tables, segments, and exception
handlers are allocated and installed when non-barebones VMs are created.

Patch 1 is a selftests-tree-wide change to drop kvm_util_base.h.  The
existence of that file has baffled (and annoyed) me for quite a long time.
After rereading its initial changelog multiple times, I realized that the
_only_ reason it exists is so that files don't need to manually #include
ucall_common.h.

Patch 1 will obviously create conflicts all over the place, though with
the help of meld, I've found them all trivially easy to resolve.  If no
objects to the removal of kvm_util_base.h, I will try to bribe Paolo into
grabbing it early in the 6.10 cycle so that everyone can bring it into
the arch trees.

Ackerley Tng (1):
  KVM: selftests: Fix off-by-one initialization of GDT limit

Sean Christopherson (17):
  Revert "kvm: selftests: move base kvm_util.h declarations to
    kvm_util_base.h"
  KVM: sefltests: Add kvm_util_types.h to hold common types, e.g.
    vm_vaddr_t
  KVM: selftests: Move GDT, IDT, and TSS fields to x86's kvm_vm_arch
  KVM: selftests: Move platform_info_test's main assert into guest code
  KVM: selftests: Rework platform_info_test to actually verify #GP
  KVM: selftests: Explicitly clobber the IDT in the "delete memslot"
    testcase
  KVM: selftests: Move x86's descriptor table helpers "up" in
    processor.c
  KVM: selftests: Rename x86's vcpu_setup() to vcpu_init_sregs()
  KVM: selftests: Init IDT and exception handlers for all VMs/vCPUs on
    x86
  KVM: selftests: Map x86's exception_handlers at VM creation, not vCPU
    setup
  KVM: selftests: Allocate x86's GDT during VM creation
  KVM: selftests: Drop superfluous switch() on vm->mode in
    vcpu_init_sregs()
  KVM: selftests: Fold x86's descriptor tables helpers into
    vcpu_init_sregs()
  KVM: selftests: Allocate x86's TSS at VM creation
  KVM: selftests: Add macro for TSS selector, rename up code/data macros
  KVM: selftests: Init x86's segments during VM creation
  KVM: selftests: Drop @selector from segment helpers

 .../selftests/kvm/aarch64/arch_timer.c        |    1 +
 tools/testing/selftests/kvm/arch_timer.c      |    1 +
 .../selftests/kvm/demand_paging_test.c        |    1 +
 .../selftests/kvm/dirty_log_perf_test.c       |    1 +
 tools/testing/selftests/kvm/dirty_log_test.c  |    1 +
 .../testing/selftests/kvm/guest_memfd_test.c  |    2 +-
 .../testing/selftests/kvm/guest_print_test.c  |    1 +
 .../selftests/kvm/include/aarch64/processor.h |    2 +
 .../selftests/kvm/include/aarch64/ucall.h     |    2 +-
 .../testing/selftests/kvm/include/kvm_util.h  | 1111 +++++++++++++++-
 .../selftests/kvm/include/kvm_util_base.h     | 1135 -----------------
 .../selftests/kvm/include/kvm_util_types.h    |   20 +
 .../selftests/kvm/include/s390x/ucall.h       |    2 +-
 .../kvm/include/x86_64/kvm_util_arch.h        |    6 +
 .../selftests/kvm/include/x86_64/processor.h  |    5 +-
 .../selftests/kvm/include/x86_64/ucall.h      |    2 +-
 .../selftests/kvm/kvm_page_table_test.c       |    1 +
 .../selftests/kvm/lib/aarch64/processor.c     |    2 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |    1 +
 tools/testing/selftests/kvm/lib/memstress.c   |    1 +
 .../selftests/kvm/lib/riscv/processor.c       |    1 +
 .../testing/selftests/kvm/lib/ucall_common.c  |    5 +-
 .../selftests/kvm/lib/x86_64/processor.c      |  305 ++---
 .../testing/selftests/kvm/riscv/arch_timer.c  |    1 +
 tools/testing/selftests/kvm/rseq_test.c       |    1 +
 tools/testing/selftests/kvm/s390x/cmma_test.c |    1 +
 tools/testing/selftests/kvm/s390x/memop.c     |    1 +
 tools/testing/selftests/kvm/s390x/tprot.c     |    1 +
 .../selftests/kvm/set_memory_region_test.c    |   12 +
 tools/testing/selftests/kvm/steal_time.c      |    1 +
 tools/testing/selftests/kvm/x86_64/amx_test.c |    2 -
 .../x86_64/dirty_log_page_splitting_test.c    |    1 +
 .../x86_64/exit_on_emulation_failure_test.c   |    2 +-
 .../selftests/kvm/x86_64/fix_hypercall_test.c |    2 -
 .../selftests/kvm/x86_64/hyperv_evmcs.c       |    2 -
 .../selftests/kvm/x86_64/hyperv_features.c    |    6 -
 .../testing/selftests/kvm/x86_64/hyperv_ipi.c |    3 -
 .../selftests/kvm/x86_64/kvm_pv_test.c        |    3 -
 .../selftests/kvm/x86_64/monitor_mwait_test.c |    3 -
 .../selftests/kvm/x86_64/platform_info_test.c |   59 +-
 .../selftests/kvm/x86_64/pmu_counters_test.c  |    3 -
 .../kvm/x86_64/pmu_event_filter_test.c        |    6 -
 .../smaller_maxphyaddr_emulation_test.c       |    3 -
 .../selftests/kvm/x86_64/svm_int_ctl_test.c   |    3 -
 .../kvm/x86_64/svm_nested_shutdown_test.c     |    5 +-
 .../kvm/x86_64/svm_nested_soft_inject_test.c  |    5 +-
 .../kvm/x86_64/ucna_injection_test.c          |    5 -
 .../kvm/x86_64/userspace_msr_exit_test.c      |    3 -
 .../vmx_exception_with_invalid_guest_state.c  |    3 -
 .../selftests/kvm/x86_64/vmx_pmu_caps_test.c  |    3 -
 .../selftests/kvm/x86_64/xapic_ipi_test.c     |    2 -
 .../selftests/kvm/x86_64/xcr0_cpuid_test.c    |    3 -
 .../selftests/kvm/x86_64/xen_shinfo_test.c    |    2 -
 53 files changed, 1335 insertions(+), 1421 deletions(-)
 delete mode 100644 tools/testing/selftests/kvm/include/kvm_util_base.h
 create mode 100644 tools/testing/selftests/kvm/include/kvm_util_types.h


base-commit: e9a2bba476c8332ed547fce485c158d03b0b9659
-- 
2.44.0.291.gc1ea87d7ee-goog


