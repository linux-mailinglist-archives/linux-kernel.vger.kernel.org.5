Return-Path: <linux-kernel+bounces-47176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D1B844A21
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCE961C23A9C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8956939856;
	Wed, 31 Jan 2024 21:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WoTMNNjW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EACE39847
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 21:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737005; cv=none; b=k9t2j/INE+YfrIqAlc763ghfonk675zervlwB6LMEY4LPhrDSj96+O7O9rWgKpav2i6aSPLmmxQ6SNJ/OQWavzK+JCPZzBbA3Zma4mFzoItJi/MyV+tNk4gWX/VPPwt8B0UMZn0D0BC2OfJn+T0OwH0rvZR/t3xGkqlHCjU/NjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737005; c=relaxed/simple;
	bh=YOr5p7OqhyyhW5TZ0msg6DHQwIpWUrFc8I5/ZuxT8lM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=f8f388QWKFbyTQ6ALUm63/G6dmHgqmaJga/gGLpcR3ePHMpPW5Ro4D1bYdvnbAttLvF/y5USTDueH3IzXC4iaI/J8zZNGnt1Pasv63Evvn1rkNpu04UE+RW8dVnX4s7a1YJpxR80yLIKRMK0i7XVF8xSgBTalGKEH3VDvZdbL00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WoTMNNjW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706737003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2IICm0xc8cHxl8ntw7Ux3EV0imOL/Y1QKA8M5sz6CME=;
	b=WoTMNNjWNl84eV853a4InTC8yK9moKfSO6EubBB48PjoEO+4IXK4osaOABvupC7ProaPl+
	9LuhqElzs8a4McEO58v9NNCJ2qGCjHT5s+y9r0lpqlacKHuEgF3M+wNbvqTy7Fou2OsYuM
	GGx2fNNCMBDDRy9kjw6BTYLPeBZlcZ8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-7StyiotBP7OD_JLc19Iwxg-1; Wed, 31 Jan 2024 16:36:41 -0500
X-MC-Unique: 7StyiotBP7OD_JLc19Iwxg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC83A88B7A5;
	Wed, 31 Jan 2024 21:36:40 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D5A9E1121312;
	Wed, 31 Jan 2024 21:36:40 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH] kvm: move "select IRQ_BYPASS_MANAGER" to common code
Date: Wed, 31 Jan 2024 16:36:40 -0500
Message-Id: <20240131213640.409682-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

CONFIG_IRQ_BYPASS_MANAGER is a dependency of the common code included by
CONFIG_HAVE_KVM_IRQ_BYPASS.  There is no advantage in adding the corresponding
"select" directive to each architecture.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/arm64/kvm/Kconfig   | 1 -
 arch/powerpc/kvm/Kconfig | 1 -
 arch/x86/kvm/Kconfig     | 1 -
 virt/kvm/Kconfig         | 1 +
 4 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 6c3c8ca73e7f..46bdbd852857 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -34,7 +34,6 @@ menuconfig KVM
 	select HAVE_KVM_MSI
 	select HAVE_KVM_IRQCHIP
 	select HAVE_KVM_IRQ_ROUTING
-	select IRQ_BYPASS_MANAGER
 	select HAVE_KVM_IRQ_BYPASS
 	select HAVE_KVM_VCPU_RUN_PID_CHANGE
 	select SCHED_INFO
diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index 074263429faf..dbfdc126bf14 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -22,7 +22,6 @@ config KVM
 	select KVM_COMMON
 	select HAVE_KVM_VCPU_ASYNC_IOCTL
 	select KVM_VFIO
-	select IRQ_BYPASS_MANAGER
 	select HAVE_KVM_IRQ_BYPASS
 
 config KVM_BOOK3S_HANDLER
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 87e3da7b0439..e7cbf011d766 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -29,7 +29,6 @@ config KVM
 	select HAVE_KVM_PFNCACHE
 	select HAVE_KVM_DIRTY_RING_TSO
 	select HAVE_KVM_DIRTY_RING_ACQ_REL
-	select IRQ_BYPASS_MANAGER
 	select HAVE_KVM_IRQ_BYPASS
 	select HAVE_KVM_IRQ_ROUTING
 	select KVM_ASYNC_PF
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 184dab4ee871..6408bc5dacd1 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -73,6 +73,7 @@ config KVM_COMPAT
 
 config HAVE_KVM_IRQ_BYPASS
        bool
+       select IRQ_BYPASS_MANAGER
 
 config HAVE_KVM_VCPU_ASYNC_IOCTL
        bool
-- 
2.39.0


