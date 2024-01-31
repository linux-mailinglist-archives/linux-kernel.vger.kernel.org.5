Return-Path: <linux-kernel+bounces-47277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3322844B42
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEE25B26331
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E003B781;
	Wed, 31 Jan 2024 22:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SveXXnsB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BA03B797
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 22:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706741425; cv=none; b=kdJKIkSgjCUpucu0BeLWXOlXWuRjg4QvLykreb/GARQbDXHOof6J3VnqYWoEd704p2MFFjYbYvRT0gDXZHFKf5CS0ne25cpTilwh3UuBwA3AP0pYmbsP+jgHs934A94967xwzLLi2Pxs0z+ZvUTC/v1zK+tOio4KZVNj/P6oMvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706741425; c=relaxed/simple;
	bh=AYdMEWZrrFVOE5/Y3TiS+Iapcw8zW/FHFD57cTayr5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qaw65lZcz5S8p4oraaEfz4sKer74xtghQJkd4MI+OWkqMeyOdJtgkI74aMycRma6Z2+gbQC3e6WiIqEorY0w+PaeCt0JAc0/MXEL0X5SWascDv0YIW0ABZEQK8u2T52tskN+F2bBZTBcs1JxmqTb0a7BkxJUffLciIhdCsUmBOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SveXXnsB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706741422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FcW4aA4QUlOADw+pKX0iGEX+H00vP76wOtrVID4JVvo=;
	b=SveXXnsBu5hYvZ5clmg3TN6vUaNje4HL10VCW4dcW0xn9gbFKeupEfQFAnx07AI5kidcUn
	PscGN7S2mbGKmUSfhXM5bzgeUxLc9nK6yTaLAPGtsStoSafrzvn+8FpJ9/mIAhNUP1mgWM
	Pd4OUH9ga8BY84PZYhXSnCwBk8XZ2rY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-PhiVAquEOmSRTXpoEibaxg-1; Wed, 31 Jan 2024 17:50:11 -0500
X-MC-Unique: PhiVAquEOmSRTXpoEibaxg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85444185A787;
	Wed, 31 Jan 2024 22:50:11 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 63A5D2166B31;
	Wed, 31 Jan 2024 22:50:11 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: dionnaglaze@google.com,
	seanjc@google.com
Subject: [PATCH 3/3] kvm: x86: use a uapi-friendly macro for GENMASK
Date: Wed, 31 Jan 2024 17:50:10 -0500
Message-Id: <20240131225010.2872733-4-pbonzini@redhat.com>
In-Reply-To: <20240131225010.2872733-1-pbonzini@redhat.com>
References: <20240131225010.2872733-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Change uapi header uses of GENMASK to instead use the uapi/linux/bits.h bit
macros, since GENMASK is not defined in uapi headers.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/arm64/include/uapi/asm/kvm.h    | 8 ++++----
 arch/x86/include/uapi/asm/kvm.h      | 7 ++++---
 arch/x86/include/uapi/asm/kvm_para.h | 2 +-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 89d2fc872d9f..6b8b57b97228 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -76,11 +76,11 @@ struct kvm_regs {
 
 /* KVM_ARM_SET_DEVICE_ADDR ioctl id encoding */
 #define KVM_ARM_DEVICE_TYPE_SHIFT	0
-#define KVM_ARM_DEVICE_TYPE_MASK	GENMASK(KVM_ARM_DEVICE_TYPE_SHIFT + 15, \
-						KVM_ARM_DEVICE_TYPE_SHIFT)
+#define KVM_ARM_DEVICE_TYPE_MASK	__GENMASK(KVM_ARM_DEVICE_TYPE_SHIFT + 15, \
+						  KVM_ARM_DEVICE_TYPE_SHIFT)
 #define KVM_ARM_DEVICE_ID_SHIFT		16
-#define KVM_ARM_DEVICE_ID_MASK		GENMASK(KVM_ARM_DEVICE_ID_SHIFT + 15, \
-						KVM_ARM_DEVICE_ID_SHIFT)
+#define KVM_ARM_DEVICE_ID_MASK		__GENMASK(KVM_ARM_DEVICE_ID_SHIFT + 15, \
+						  KVM_ARM_DEVICE_ID_SHIFT)
 
 /* Supported device IDs */
 #define KVM_ARM_DEVICE_VGIC_V2		0
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 9ae91a21ffea..bd36d74b593b 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -8,6 +8,7 @@
  */
 
 #include <linux/const.h>
+#include <linux/bits.h>
 #include <linux/types.h>
 #include <linux/ioctl.h>
 #include <linux/stddef.h>
@@ -550,9 +551,9 @@ struct kvm_pmu_event_filter {
 	((__u64)(!!(exclude)) << 55))
 
 #define KVM_PMU_MASKED_ENTRY_EVENT_SELECT \
-	(GENMASK_ULL(7, 0) | GENMASK_ULL(35, 32))
-#define KVM_PMU_MASKED_ENTRY_UMASK_MASK		(GENMASK_ULL(63, 56))
-#define KVM_PMU_MASKED_ENTRY_UMASK_MATCH	(GENMASK_ULL(15, 8))
+	(__GENMASK_ULL(7, 0) | __GENMASK_ULL(35, 32))
+#define KVM_PMU_MASKED_ENTRY_UMASK_MASK		(__GENMASK_ULL(63, 56))
+#define KVM_PMU_MASKED_ENTRY_UMASK_MATCH	(__GENMASK_ULL(15, 8))
 #define KVM_PMU_MASKED_ENTRY_EXCLUDE		(_BITULL(55))
 #define KVM_PMU_MASKED_ENTRY_UMASK_MASK_SHIFT	(56)
 
diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
index 6e64b27b2c1e..6bc3456a8ebf 100644
--- a/arch/x86/include/uapi/asm/kvm_para.h
+++ b/arch/x86/include/uapi/asm/kvm_para.h
@@ -92,7 +92,7 @@ struct kvm_clock_pairing {
 #define KVM_ASYNC_PF_DELIVERY_AS_INT		(1 << 3)
 
 /* MSR_KVM_ASYNC_PF_INT */
-#define KVM_ASYNC_PF_VEC_MASK			GENMASK(7, 0)
+#define KVM_ASYNC_PF_VEC_MASK			__GENMASK(7, 0)
 
 /* MSR_KVM_MIGRATION_CONTROL */
 #define KVM_MIGRATION_READY		(1 << 0)
-- 
2.39.0


