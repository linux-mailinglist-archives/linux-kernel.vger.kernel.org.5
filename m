Return-Path: <linux-kernel+bounces-59807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7D184FBFD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF4C1C23787
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F7A7F491;
	Fri,  9 Feb 2024 18:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WbncxAm/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351C857325
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 18:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707503869; cv=none; b=DUUhSTTXtvaEpsCfvwPheBujdqYpyRE4o+PTNtJ11TZ4wNkJTN3e7PZd+Fsb7bb0wo1t4fK5yMm2smYQoe475WU+is3MM3U84cevmMzMumkcq9Kk3pi5en3rsKLH7F/6Q7Buta2fPxYJwKw2lm9apHl/z8RaX3voDRGnNy7TaFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707503869; c=relaxed/simple;
	bh=L3jqclo0i9bH7DKaPal2eN/2Uf1+sDtL1jhCISxamCo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=JUHwfQjpnk2hxSxN/ugVfdz+qlyC1D0ZgWqfNp3xvRYQg1FY3OoybQZ5xh7ARHwWsmrG8CQ9ebsX9yv1pF44sJjvEWE2D40FVT7Q+4rr5Ahi6i5L2aSf6fPkSoJvLaFRfFcJFyWWr3UeP8tlwFTvN58YAKlAaF9+GI6QRVz7s0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WbncxAm/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707503866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ql8NRVLUrfLSlW92JE+TglekoXsViOImgOkMVK8/eUc=;
	b=WbncxAm/vDSxXtb4hDPs7mUVd6cVQkiks1BzzoYRWjy3ja1w6gAIMCx8kPO1FTkethD1Oo
	5CXtHBTBgDbQRDX+Q9gcdZmUvdlympklcsh0prkx5+y9+MfMgR8bY3hSvIruamrffasLpz
	1Ug4APBXwJzC08e6w/D7m5h2HREiVEk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-vO884ImCMQWVY9YqEvVoxA-1; Fri, 09 Feb 2024 13:37:44 -0500
X-MC-Unique: vO884ImCMQWVY9YqEvVoxA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4F79185A787;
	Fri,  9 Feb 2024 18:37:43 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B37E2492BC6;
	Fri,  9 Feb 2024 18:37:43 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	michael.roth@amd.com,
	aik@amd.com,
	isaku.yamahata@intel.com
Subject: [PATCH 00/10] KVM: SEV: allow customizing VMSA features
Date: Fri,  9 Feb 2024 13:37:32 -0500
Message-Id: <20240209183743.22030-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

The idea that no parameter would ever be necessary when enabling SEV or
SEV-ES for a VM was decidedly optimistic.  The first source of variability
that was encountered is the desired set of VMSA features, as that affects
the measurement of the VM's initial state and cannot be changed
arbitrarily by the hypervisor.

This series adds all the APIs that are needed to customize the features,
with room for future enhancements:

- a new /dev/kvm device attribute to retrieve the set of supported
  features (right now, only debug swap)

- a new sub-operation for KVM_MEM_ENCRYPT_OP that can take a struct,
  replacing the existing KVM_SEV_INIT and KVM_SEV_ES_INIT

It then puts the new op to work by including the VMSA features as a field
of the The existing KVM_SEV_INIT and KVM_SEV_ES_INIT use the full set of
supported VMSA features for backwards compatibility; but I am considering
also making them use zero as the feature mask, and will gladly adjust the
patches if so requested.

In order to avoid creating *two* new KVM_MEM_ENCRYPT_OPs, I decided that
I could as well make SEV and SEV-ES use VM types.  And then, why not make
a SEV-ES VM, when created with the new VM type instead of KVM_SEV_ES_INIT,
reject KVM_GET_REGS/KVM_SET_REGS and friends on the vCPU file descriptor
once the VMSA has been encrypted...  Which is how the API should have
always behaved.

The series is defined as follows:

- patches 1 and 2 are unrelated fixes and improvements for the SEV API

- patches 3 to 5 introduce the new device attribute to retrieve supported
  VMSA features

- patches 6 to 7 introduce new infrastructure for VM types, partly lifted
  out of the TDX patches

- patches 8 and 9 introduce respectively the new VM types for SEV and
  SEV-ES, and KVM_SEV_INIT2 as a new sub-operation for KVM_MEM_ENCRYPT_OP.

- patches 10 and 11 are tests.  The last patch is not intended to be applied
  in order to keep some coverage of KVM_SEV_INIT and KVM_SEV_ES_INIT in
  self tests; but it is there as "proof" that migration can be made to
  work with the new API as well.


The idea is that SEV SNP will only ever support KVM_SEV_INIT2.  I have
patches in progress for QEMU to support this new API.

Thanks,

Paolo

Isaku Yamahata (1):
  KVM: x86: Add is_vm_type_supported callback

Paolo Bonzini (10):
  KVM: x86: define standard behavior for bits 0/1 of VM type
  KVM: SEV: fix compat ABI for KVM_MEMORY_ENCRYPT_OP
  KVM: introduce new vendor op for KVM_GET_DEVICE_ATTR
  Documentation: kvm/sev: separate description of firmware
  KVM: SEV: publish supported VMSA features
  KVM: SEV: store VMSA features in kvm_sev_info
  KVM: SEV: define VM types for SEV and SEV-ES
  KVM: SEV: introduce KVM_SEV_INIT2 operation
  selftests: kvm: add tests for KVM_SEV_INIT2
  selftests: kvm: switch sev_migrate_tests to KVM_SEV_INIT2

 Documentation/virt/kvm/api.rst                |   2 +
 .../virt/kvm/x86/amd-memory-encryption.rst    |  81 +++++++--
 arch/x86/include/asm/kvm-x86-ops.h            |   2 +
 arch/x86/include/asm/kvm_host.h               |   4 +-
 arch/x86/include/uapi/asm/kvm.h               |  42 ++++-
 arch/x86/kvm/svm/sev.c                        | 104 +++++++++++-
 arch/x86/kvm/svm/svm.c                        |  14 +-
 arch/x86/kvm/svm/svm.h                        |   6 +-
 arch/x86/kvm/x86.c                            | 158 ++++++++++++++----
 arch/x86/kvm/x86.h                            |   2 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/include/kvm_util_base.h     |   6 +-
 .../selftests/kvm/set_memory_region_test.c    |   8 +-
 .../selftests/kvm/x86_64/sev_init2_tests.c    | 147 ++++++++++++++++
 .../selftests/kvm/x86_64/sev_migrate_tests.c  |  45 ++---
 15 files changed, 530 insertions(+), 92 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/sev_init2_tests.c

-- 
2.39.0



