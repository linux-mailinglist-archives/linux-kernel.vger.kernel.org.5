Return-Path: <linux-kernel+bounces-106742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9AD87F2FD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BF0DB215D9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672B05B66B;
	Mon, 18 Mar 2024 22:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wbvgy+qp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBCD5A4E9
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 22:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710799811; cv=none; b=t2tLN+FRclwjl6X1i+5tHcSVAdh8Kcjwe5dFSO7amNbci/Gwv4gHjcZ20w0dfKBWO8NgY1hRjo3dkTSxIZKZDMxTm2ULYL6m50+HTeD/hPOtHO1UzjdBv6cbVKCGlxmHg8bo9sXGAevIgw0W8SpOZsX7aYlOmHjkn+xCX2xf67Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710799811; c=relaxed/simple;
	bh=qaJEDXwpaSJXM+1hD3fE9I/G0z5IQq6ORF3Rr7L/kFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ezjn14ZhcU5e5uWl/DF7h5neQhHKH1XBZtHGSOJd9C8BoN3ch7vJp4xlXNVL5M1WNI6l/a2hFIuC5e8DL8ON5CmW1MnpkXk7dfMgV058S2q2ecMzZSpBUUpqLKqdJmDN+U+ANNVoCLqOm1Ba+TxRap61di5bW46FQw0wrRU8KSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wbvgy+qp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710799808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gMEmPn7yUS4wreWy4Dg8bjqaNwIrv+R0K2a7wjWFE2c=;
	b=Wbvgy+qpjzltpD+psahFXWvob3PC13wEU2g8t18e3vgBqPljWw1VazF64xnMWOsaaciUOb
	R/fOsXyyhSLNua98P415ICaONJvhS2zLyxnGFHOD7NXdqk3XCVkB1PmmXfBsjRryw+zd8q
	nxnDVQSfYqtmSPF4gCOPAF64Sf+5d/c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-0_C0MuIrMzapy9sgm8UnZQ-1; Mon,
 18 Mar 2024 18:10:05 -0400
X-MC-Unique: 0_C0MuIrMzapy9sgm8UnZQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1DC11C04332;
	Mon, 18 Mar 2024 22:10:04 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B483F492BC8;
	Mon, 18 Mar 2024 22:10:04 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com
Subject: [PATCH 7/7] Documentation: kvm/sev: clarify usage of KVM_MEMORY_ENCRYPT_OP
Date: Mon, 18 Mar 2024 18:10:02 -0400
Message-ID: <20240318221002.2712738-8-pbonzini@redhat.com>
In-Reply-To: <20240318221002.2712738-1-pbonzini@redhat.com>
References: <20240318221002.2712738-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Explain that it operates on the VM file descriptor, and also clarify how
detection of SEV operates on old kernels predating commit 2da1ed62d55c
("KVM: SVM: document KVM_MEM_ENCRYPT_OP, let userspace detect if SEV
is available").

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .../virt/kvm/x86/amd-memory-encryption.rst          | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/virt/kvm/x86/amd-memory-encryption.rst b/Documentation/virt/kvm/x86/amd-memory-encryption.rst
index 4f2eb441c718..84335d119ff1 100644
--- a/Documentation/virt/kvm/x86/amd-memory-encryption.rst
+++ b/Documentation/virt/kvm/x86/amd-memory-encryption.rst
@@ -49,12 +49,13 @@ defined in the CPUID 0x8000001f[ecx] field.
 The KVM_MEMORY_ENCRYPT_OP ioctl
 ===============================
 
-The main ioctl to access SEV is KVM_MEMORY_ENCRYPT_OP.  If the argument
-to KVM_MEMORY_ENCRYPT_OP is NULL, the ioctl returns 0 if SEV is enabled
-and ``ENOTTY`` if it is disabled (on some older versions of Linux,
-the ioctl runs normally even with a NULL argument, and therefore will
-likely return ``EFAULT``).  If non-NULL, the argument to KVM_MEMORY_ENCRYPT_OP
-must be a struct kvm_sev_cmd::
+The main ioctl to access SEV is KVM_MEMORY_ENCRYPT_OP, which operates on
+the VM file descriptor.  If the argument to KVM_MEMORY_ENCRYPT_OP is NULL,
+the ioctl returns 0 if SEV is enabled and ``ENOTTY`` if it is disabled
+(on some older versions of Linux, the ioctl tries to run normally even
+with a NULL argument, and therefore will likely return ``EFAULT`` instead
+of zero if SEV is enabled).  If non-NULL, the argument to
+KVM_MEMORY_ENCRYPT_OP must be a struct kvm_sev_cmd::
 
        struct kvm_sev_cmd {
                __u32 id;
-- 
2.43.0


