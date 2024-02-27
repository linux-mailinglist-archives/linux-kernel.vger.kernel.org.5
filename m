Return-Path: <linux-kernel+bounces-84193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFE986A3A6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 821FFB2C974
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDEE58AA5;
	Tue, 27 Feb 2024 23:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ayta7RT7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5376956761
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 23:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709076069; cv=none; b=PsrUjoygigk82cQfN5LFXgMMbVGpj2Ah+PxU3G0e3HxnPQlVSPPGTQkWkz2BObV17dcPPEe+9Hhn/YySA6sGB7lalFhrUuKF3alRI3lxfEnjOzgQ3173WrMAqisupivg0065ujglTEaKcwMb8aDhF0gom3czumbNqfVQXsZtOA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709076069; c=relaxed/simple;
	bh=QCp8fssqozpREH0/GM40/N41O/fW2f5g/ulgGgPurUs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=TiAbofyWwEdjkA5asiYxmIGqqUiQcJ89QEK+4pRKkHRpV4z/pphABThYr0pGa0AzVGf/kyBIgWy8rYr/oXpxByCNmdCElQkMuIVc/1vBgK8LOHcN+x02TeQfQ2+TlgDpMQozZzU8kIOdppVO5kpb/Q00eO+jqOfwqEE/KLgcVU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ayta7RT7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709076066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/9tvf0ukdK/65q6QJ8uVY1EjS0BigmDVs+pwzfdZXjw=;
	b=Ayta7RT7Cr+55JdiPMZOx8bisMy6sWTNC7JuPEx5gJMiUbK7CEPlxOUfdGNUoOKOEiXkZr
	uQLUcT/ZNBo4UJI+XlGdCnXGtcezGNOINSfsjUfiM9wmkN9h/vNw1vL7sA1+O6DtO0gPch
	le6LcS7F4fBGrHo783QmkRtQilVLt0Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-1U9ZG1NANvWG5xuNo8j4mw-1; Tue,
 27 Feb 2024 18:21:01 -0500
X-MC-Unique: 1U9ZG1NANvWG5xuNo8j4mw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DACB03806709;
	Tue, 27 Feb 2024 23:21:00 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A91304EA55;
	Tue, 27 Feb 2024 23:21:00 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	michael.roth@amd.com,
	isaku.yamahata@intel.com,
	thomas.lendacky@amd.com
Subject: [PATCH 00/21] TDX/SNP part 1 of n, for 6.9
Date: Tue, 27 Feb 2024 18:20:39 -0500
Message-Id: <20240227232100.478238-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

This is a first set of, hopefully non-controversial patches from the
SNP and TDX series.  They cover mostly changes to generic code and new
gmem APIs, and in general have already been reviewed when posted by
Isaku and Michael.

One important change is that the gmem hook for initializing memory
is designed to return -EEXIST if the page already exists in the
guestmemfd filemap.  The idea is that the special case of
KVM_SEV_SNP_LAUNCH_UPDATE, where __kvm_gmem_get_pfn() is used to
return an uninitialized page and make it guest-owned, can be be done at
most once per page unless the ioctl fails.

Of course these patches add a bunch of dead code.  This is intentional
because it's the only way to trim the large TDX (and to some extent SNP)
series to the point that it's possible to discuss them.  The next step is
probably going to be the private<->shared page logic from the TDX series.

Paolo

Isaku Yamahata (5):
  KVM: x86/mmu: Add Suppress VE bit to EPT
    shadow_mmio_mask/shadow_present_mask
  KVM: VMX: Introduce test mode related to EPT violation VE
  KVM: x86/tdp_mmu: Init role member of struct kvm_mmu_page at
    allocation
  KVM: x86/tdp_mmu: Sprinkle __must_check
  KVM: x86/mmu: Pass around full 64-bit error code for KVM page faults

Michael Roth (2):
  KVM: x86: Add gmem hook for invalidating memory
  KVM: x86: Add gmem hook for determining max NPT mapping level

Paolo Bonzini (6):
  KVM: x86/mmu: pass error code back to MMU when async pf is ready
  KVM: x86/mmu: Use PFERR_GUEST_ENC_MASK to indicate fault is private
  KVM: guest_memfd: pass error up from filemap_grab_folio
  filemap: add FGP_CREAT_ONLY
  KVM: x86: Add gmem hook for initializing memory
  KVM: guest_memfd: add API to undo kvm_gmem_get_uninit_pfn

Sean Christopherson (7):
  KVM: x86: Split core of hypercall emulation to helper function
  KVM: Allow page-sized MMU caches to be initialized with custom 64-bit
    values
  KVM: x86/mmu: Replace hardcoded value 0 for the initial value for SPTE
  KVM: x86/mmu: Track shadow MMIO value on a per-VM basis
  KVM: x86/mmu: Allow non-zero value for non-present SPTE and removed
    SPTE
  KVM: VMX: Move out vmx_x86_ops to 'main.c' to wrap VMX and TDX
  KVM: VMX: Modify NMI and INTR handlers to take intr_info as function
    argument

Tom Lendacky (1):
  KVM: SEV: Use a VMSA physical address variable for populating VMCB

 arch/x86/include/asm/kvm-x86-ops.h |   3 +
 arch/x86/include/asm/kvm_host.h    |  12 +
 arch/x86/include/asm/vmx.h         |  13 +
 arch/x86/kvm/Makefile              |   2 +-
 arch/x86/kvm/mmu.h                 |   1 +
 arch/x86/kvm/mmu/mmu.c             |  55 ++--
 arch/x86/kvm/mmu/mmu_internal.h    |   6 +-
 arch/x86/kvm/mmu/mmutrace.h        |   2 +-
 arch/x86/kvm/mmu/paging_tmpl.h     |   4 +-
 arch/x86/kvm/mmu/spte.c            |  16 +-
 arch/x86/kvm/mmu/spte.h            |  21 +-
 arch/x86/kvm/mmu/tdp_iter.h        |  12 +
 arch/x86/kvm/mmu/tdp_mmu.c         |  74 +++--
 arch/x86/kvm/svm/sev.c             |   3 +-
 arch/x86/kvm/svm/svm.c             |   9 +-
 arch/x86/kvm/svm/svm.h             |   1 +
 arch/x86/kvm/vmx/main.c            | 168 +++++++++++
 arch/x86/kvm/vmx/vmcs.h            |   5 +
 arch/x86/kvm/vmx/vmx.c             | 460 +++++++++++------------------
 arch/x86/kvm/vmx/vmx.h             |   6 +-
 arch/x86/kvm/vmx/x86_ops.h         | 124 ++++++++
 arch/x86/kvm/x86.c                 |  69 +++--
 include/linux/kvm_host.h           |  25 ++
 include/linux/kvm_types.h          |   1 +
 include/linux/pagemap.h            |   2 +
 mm/filemap.c                       |   4 +
 virt/kvm/Kconfig                   |   8 +
 virt/kvm/guest_memfd.c             | 120 +++++++-
 virt/kvm/kvm_main.c                |  16 +-
 29 files changed, 855 insertions(+), 387 deletions(-)
 create mode 100644 arch/x86/kvm/vmx/main.c
 create mode 100644 arch/x86/kvm/vmx/x86_ops.h

-- 
2.39.0


