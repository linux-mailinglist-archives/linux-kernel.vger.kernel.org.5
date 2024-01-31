Return-Path: <linux-kernel+bounces-47374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B135844D00
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1323B286488
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E3441770;
	Wed, 31 Jan 2024 23:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+4V8kwc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8673BB53
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706743862; cv=none; b=ZUZ8S7eolkqMu5jnplgLru/ydedPOK/bKOBaQGByIJb5A1i8iu5Yh4rQcUt2V4tuUFXKYzyNRMBjJYIwKL9LzAotZ3xkLYFltxJlc7H3dk0IJ/xCaXKwqPlxHSagRGCwLng7xHzQfyJ1EHtK8yvKwFLhfjGoPp4JRm9N09O/ivc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706743862; c=relaxed/simple;
	bh=BDJaHPvofpfiISPE/qEiQQf3zc6+15Xz8vueMizXKGs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JQLZWiQ+3J/99rvzZU5THdhYuogFdjZaLxNT/87NoZIsl77UF/T+LqNTu3e4NLzplmGjfiQU1EGMY5mj2cqIYdauUWJkcFaSO8vtPAfSTTq0zHntEFXu/NlNpR+QPH4FCu0Ig5PDRzKZ5FTPhL5El4XodmzebU6CTHRj66Nkcx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F+4V8kwc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706743859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aEh+wFpUinJIaznT4QZk7JIQDrVHQazll8Aw7qFD9DI=;
	b=F+4V8kwcmW1cist3BzLtFC9kyaCxE0J1PPoS2EBL6WLoxqcjAQEw0VMouJ3etDpjVvWMYf
	VDXwBfRwJt8ADvU3BzCO84ToFbadfkKVPvi2MCdf04o63TLE4BJEX83iw7NKDOxfZMiPKm
	SUw0KQ20+WszbqffJa53EGi7VZNx/F8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-wQOvrYrqMeeO4c6k-EyjNA-1; Wed,
 31 Jan 2024 18:30:57 -0500
X-MC-Unique: wQOvrYrqMeeO4c6k-EyjNA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CEE213C0C102;
	Wed, 31 Jan 2024 23:30:56 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B6F65C2590D;
	Wed, 31 Jan 2024 23:30:56 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 1/8] KVM: remove more traces of device assignment UAPI
Date: Wed, 31 Jan 2024 18:30:49 -0500
Message-Id: <20240131233056.10845-2-pbonzini@redhat.com>
In-Reply-To: <20240131233056.10845-1-pbonzini@redhat.com>
References: <20240131233056.10845-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/uapi/linux/kvm.h | 50 ----------------------------------------
 1 file changed, 50 deletions(-)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index c3308536482b..e107ea953585 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1965,56 +1965,6 @@ struct kvm_sev_receive_update_data {
 	__u32 trans_len;
 };
 
-#define KVM_DEV_ASSIGN_ENABLE_IOMMU	(1 << 0)
-#define KVM_DEV_ASSIGN_PCI_2_3		(1 << 1)
-#define KVM_DEV_ASSIGN_MASK_INTX	(1 << 2)
-
-struct kvm_assigned_pci_dev {
-	__u32 assigned_dev_id;
-	__u32 busnr;
-	__u32 devfn;
-	__u32 flags;
-	__u32 segnr;
-	union {
-		__u32 reserved[11];
-	};
-};
-
-#define KVM_DEV_IRQ_HOST_INTX    (1 << 0)
-#define KVM_DEV_IRQ_HOST_MSI     (1 << 1)
-#define KVM_DEV_IRQ_HOST_MSIX    (1 << 2)
-
-#define KVM_DEV_IRQ_GUEST_INTX   (1 << 8)
-#define KVM_DEV_IRQ_GUEST_MSI    (1 << 9)
-#define KVM_DEV_IRQ_GUEST_MSIX   (1 << 10)
-
-#define KVM_DEV_IRQ_HOST_MASK	 0x00ff
-#define KVM_DEV_IRQ_GUEST_MASK   0xff00
-
-struct kvm_assigned_irq {
-	__u32 assigned_dev_id;
-	__u32 host_irq; /* ignored (legacy field) */
-	__u32 guest_irq;
-	__u32 flags;
-	union {
-		__u32 reserved[12];
-	};
-};
-
-struct kvm_assigned_msix_nr {
-	__u32 assigned_dev_id;
-	__u16 entry_nr;
-	__u16 padding;
-};
-
-#define KVM_MAX_MSIX_PER_DEV		256
-struct kvm_assigned_msix_entry {
-	__u32 assigned_dev_id;
-	__u32 gsi;
-	__u16 entry; /* The index of entry in the MSI-X table */
-	__u16 padding[3];
-};
-
 #define KVM_X2APIC_API_USE_32BIT_IDS            (1ULL << 0)
 #define KVM_X2APIC_API_DISABLE_BROADCAST_QUIRK  (1ULL << 1)
 
-- 
2.39.0



