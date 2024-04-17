Return-Path: <linux-kernel+bounces-148813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 182008A87B9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497A41C22013
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0CA147C9D;
	Wed, 17 Apr 2024 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EUhYrhoj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E9F38DEC
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 15:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713368097; cv=none; b=bfvck+GBMxs8fl8B4KBpd4rKlfIbyotZTAEpcDuZRVM3GQz409wq9TC0G2HdPSvjx7yJz8WjC8ggiAvo384OXQcpTNehJG60Vn24kJ9+JzEYbtX/S6kT7HBFpz9wgb5/bH6fCsrNf5qZ4bCcp3DUqlHD4fmATaFQitcq/OqeqL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713368097; c=relaxed/simple;
	bh=IIC0tv+BlGf2j2KouQ1UALpmzmBHpO+o54MA5HqOx1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jDffPUrH1F7SHiB9chZr627rcd5loPWgZZUribBNjG34icgazJKs7/Bg1H3eRkv/NBawUuTdD4CF7D/FTo8QD9X2JCzgRqtMw2Ej/ciypvc25TaoFW94grY0vyRX4/zR/y6Pyoup/XPTM2OIKThoQY4sS6LkDxxb0oXvhsFEiss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EUhYrhoj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713368094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zkI3ZLRBrGPOfJ8o6Nqq7OH9pPAJcd5NKdBOupoX3ag=;
	b=EUhYrhojZgzBFEGc2Jpz2EMelZ29VDuSAQyASapJPIsAM53pLeA+Z+3FQq3f5PxxV5nfBa
	mznmY1z6PN+fxAS75bP5A/nuYiSswx4H7llAefmDKcZrFFqUd5AIrqX7JqzAks7PtR64CA
	OMH33F79wRw9kTVme9nfe0leWxVpJ0w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-kB9JEOLDMIS0hKF8_j0S9A-1; Wed, 17 Apr 2024 11:34:51 -0400
X-MC-Unique: kB9JEOLDMIS0hKF8_j0S9A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 47A1881B561;
	Wed, 17 Apr 2024 15:34:51 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0530C581D3;
	Wed, 17 Apr 2024 15:34:51 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: isaku.yamahata@intel.com,
	xiaoyao.li@intel.com,
	binbin.wu@linux.intel.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com
Subject: [PATCH v3 0/7] KVM: Guest Memory Pre-Population API
Date: Wed, 17 Apr 2024 11:34:43 -0400
Message-ID: <20240417153450.3608097-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Pre-population has been requested several times to mitigate KVM page faults
during guest boot or after live migration.  It is also required by TDX
before filling in the initial guest memory with measured contents; while
I am not yet sure that userspace will use this ioctl, if not the code
will be used by a TDX-specific ioctl---to pre-populate the SEPT before
invoking TDH.MEM.PAGE.ADD or TDH.MR.EXTEND.

Compared to Isaku's v2, I have reduced the scope as much as possible:

- no vendor-specific hooks

- just fail if pre-population is invoked while nested virt is access

- just populate page tables for the SMM address space if invoked while
  SMM is active


There are however other changes that affect the userspace API:

- struct name changed to `kvm_map_memory`

- added support for KVM_CHECK_EXTENSION(KVM_MAP_MEMORY) on the VM
  file descriptor, which allows to make this ioctl supported only
  on a subset of VM types

vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
- **important**: if EINTR or EAGAIN happens on
  the first page, it is returned.  Otherwise, the ioctl *succeeds*
  but mapping->size is left nonzero.  While this drops the detail
  as to why the system call was interrupted, it is consistent with
  other interruptible system calls such as read().
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Implementation changes:

- the test is not x86-specific anymore (though for now only compiled
  on x86 because no other architectures supports the feature)

- instead of using __weak symbols, the code is conditional on a new
  Kconfig CONFIG_KVM_GENERIC_MAP_MEMORY.


This patch series depends on the other pieces that have been applied
to the kvm-coco-queue branch (and is present on the branch).

Paolo


Isaku Yamahata (7):
  KVM: Document KVM_MAP_MEMORY ioctl
  KVM: Add KVM_MAP_MEMORY vcpu ioctl to pre-populate guest memory
  KVM: x86/mmu: Extract __kvm_mmu_do_page_fault()
  KVM: x86/mmu: Make __kvm_mmu_do_page_fault() return mapped level
  KVM: x86/mmu: Introduce kvm_tdp_map_page() to populate guest memory
  KVM: x86: Implement kvm_arch_vcpu_map_memory()
  KVM: selftests: x86: Add test for KVM_MAP_MEMORY

 Documentation/virt/kvm/api.rst                |  54 +++++++
 arch/x86/kvm/Kconfig                          |   1 +
 arch/x86/kvm/mmu.h                            |   3 +
 arch/x86/kvm/mmu/mmu.c                        |  32 +++++
 arch/x86/kvm/mmu/mmu_internal.h               |  42 ++++--
 arch/x86/kvm/x86.c                            |  43 ++++++
 include/linux/kvm_host.h                      |   5 +
 include/uapi/linux/kvm.h                      |  10 ++
 tools/include/uapi/linux/kvm.h                |   8 ++
 tools/testing/selftests/kvm/Makefile          |   1 +
 tools/testing/selftests/kvm/map_memory_test.c | 135 ++++++++++++++++++
 virt/kvm/Kconfig                              |   3 +
 virt/kvm/kvm_main.c                           |  61 ++++++++
 13 files changed, 384 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/map_memory_test.c

-- 
2.43.0


