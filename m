Return-Path: <linux-kernel+bounces-47379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D63844D10
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 939431C22B38
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0805E47A67;
	Wed, 31 Jan 2024 23:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YCP1/srB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5E63C46C
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706743864; cv=none; b=SvK5aPVfugjVwjYHPVU8eTmIgX/usXQMpBlBPYwD8bGxf3f8ZAEu0EApUxa0dxtD69IXS8ee2a0VrBhubofmYQko+7ss5OM3nCcKGv5aOgjmQKrkGAd0hW/YovnbeZGyhWs+8pp7YThFi376W2xBr4O4gPGdG9QBylLVNYQbWkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706743864; c=relaxed/simple;
	bh=a11DBiciXg2fo6+BDhs0EEQ+8s9DaH42cJVQm78o8l0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=CU8PdZP0MJFe2XHaW8x1X6lMkOxfSbs3ftrpITsk8DPEGRqE1cTfxT1WiWxftKnvXS//N9q5o6+Btyln0WosVieJoA8XciLgfx+OcUQvVxeTYNvnZjW+2TPZ8doX/le5kPqncBGlb0F4xAk5QvFu+rbGsRHIc3xEfSEboqrdUkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YCP1/srB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706743861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M6Nv0QDSdRGQB7DAkiGBWR53UACzKTdMG5hTEw+ea88=;
	b=YCP1/srBf3Zbdz1Gx1qtM1Cbswb7KH+L6d5Gl04ZPmU6iafky++NYczhj0ckrRDDG93Qax
	5Cug2jcj74cMdQecHQr0RVSagMReGLr5T19cUrmQhOiNBFnznufQLq+75ZTS7n1aPvmyfy
	Wvcl4KnUv4qrUxz6iML14/ArZwH/1m8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-aS_si6hSMOCZEc4lBAdv_w-1; Wed,
 31 Jan 2024 18:30:56 -0500
X-MC-Unique: aS_si6hSMOCZEc4lBAdv_w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFAB638149A2;
	Wed, 31 Jan 2024 23:30:56 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 97B62C2590D;
	Wed, 31 Jan 2024 23:30:56 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 0/8] KVM: cleanup linux/kvm.h
Date: Wed, 31 Jan 2024 18:30:48 -0500
Message-Id: <20240131233056.10845-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

More cleanups of KVM's main header:

* remove thoroughly obsolete APIs

* move architecture-dependent stuff to uapi/asm/kvm.h

* small cleanups to __KVM_HAVE_* symbols

Paolo

Paolo Bonzini (8):
  KVM: remove more traces of device assignment UAPI
  KVM: x86: move x86-specific structs to uapi/asm/kvm.h
  KVM: powerpc: move powerpc-specific structs to uapi/asm/kvm.h
  KVM: s390: move s390-specific structs to uapi/asm/kvm.h
  KVM: arm64: move ARM-specific defines to uapi/asm/kvm.h
  kvm: replace __KVM_HAVE_READONLY_MEM with Kconfig symbol
  KVM: define __KVM_HAVE_GUEST_DEBUG unconditionally
  KVM: remove unnecessary #ifdef

 arch/arm64/include/uapi/asm/kvm.h     |   7 +-
 arch/arm64/kvm/Kconfig                |   1 +
 arch/loongarch/include/uapi/asm/kvm.h |   2 -
 arch/loongarch/kvm/Kconfig            |   1 +
 arch/mips/include/uapi/asm/kvm.h      |   2 -
 arch/mips/kvm/Kconfig                 |   1 +
 arch/powerpc/include/uapi/asm/kvm.h   |  45 +-
 arch/riscv/include/uapi/asm/kvm.h     |   1 -
 arch/riscv/kvm/Kconfig                |   1 +
 arch/s390/include/uapi/asm/kvm.h      | 315 +++++++++++-
 arch/x86/include/uapi/asm/kvm.h       | 264 +++++++++-
 arch/x86/kvm/Kconfig                  |   1 +
 include/uapi/linux/kvm.h              | 692 +-------------------------
 virt/kvm/Kconfig                      |   3 +
 virt/kvm/kvm_main.c                   |   2 +-
 15 files changed, 642 insertions(+), 696 deletions(-)

-- 
2.39.0


