Return-Path: <linux-kernel+bounces-78165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D9A860FB9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FCEFB249A4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FF47E59C;
	Fri, 23 Feb 2024 10:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i54Cjzsa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442AC82869
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684833; cv=none; b=dMcvvPqT40AR8Yh7QDQEE383kOKoKsvDL6bjaBuIJuo0gERemulG719f1fB7iLSlteYeiGTryPXCIUpJtEoWeh5NhLobfwv894dVG9lekYri887RXag/TVwa2Ya+C9Aq9Iv8sSaNexazK6+fYMxk8ySK67HKvDGpghY2KZmpDzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684833; c=relaxed/simple;
	bh=DX9YcffDBaz6DU6P4zQRuDxKywNhABwdJPiW+EG6rz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o9eC6snf86Q+fF3f91rYKqAzy+TLCgmFCvP9r7SG8/NzWCeLQydu7ZsUcta1yMhGu385JpUkdgaqMQA+4UUjjDv3+8Fr8CNVIc+tzvjd1CkZ1p6hU0/0LyhMwJpVBx+TZgxX/Ak0JLMNQQC1pSIs98nBMhpDBqB8JO6epVfhqd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i54Cjzsa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708684831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LVP8O1T68Ud+akMCY43T5a2gER3eDvB9zlOBSBJIRR0=;
	b=i54Cjzsa4ziw4JfKmXaMcQEbi8tXLSPLJPAbGfdfPBkjieF6/Tz19mMJlgRyaeleRIhroj
	D3/hZEPdxAY8zSJ+o6W9d6Cg39iYCwmVmDBNJyOZnEhzrdpynm1Z9D9B/nBppO/y2vUpH2
	Ua8YL6hS8BdDEfgMsnFi+051LXG1wIA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-bpr3kyCZO3quMyRLFlPPbg-1; Fri, 23 Feb 2024 05:40:26 -0500
X-MC-Unique: bpr3kyCZO3quMyRLFlPPbg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9BA6F88F4C6;
	Fri, 23 Feb 2024 10:40:10 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 758C9112132A;
	Fri, 23 Feb 2024 10:40:10 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	michael.roth@amd.com,
	aik@amd.com
Subject: [PATCH v2 01/11] KVM: SEV: fix compat ABI for KVM_MEMORY_ENCRYPT_OP
Date: Fri, 23 Feb 2024 05:39:59 -0500
Message-Id: <20240223104009.632194-2-pbonzini@redhat.com>
In-Reply-To: <20240223104009.632194-1-pbonzini@redhat.com>
References: <20240223104009.632194-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

The data structs for KVM_MEMORY_ENCRYPT_OP have different sizes for 32- and 64-bit
kernels, but they do not make any attempt to convert from one ABI to the other.
Fix this by adding the appropriate padding.

No functional change intended for 64-bit userspace.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20240209183743.22030-2-pbonzini@redhat.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/uapi/asm/kvm.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 0ad6bda1fc39..b305daff056e 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -687,6 +687,7 @@ enum sev_cmd_id {
 
 struct kvm_sev_cmd {
 	__u32 id;
+	__u32 pad0;
 	__u64 data;
 	__u32 error;
 	__u32 sev_fd;
@@ -697,28 +698,35 @@ struct kvm_sev_launch_start {
 	__u32 policy;
 	__u64 dh_uaddr;
 	__u32 dh_len;
+	__u32 pad0;
 	__u64 session_uaddr;
 	__u32 session_len;
+	__u32 pad1;
 };
 
 struct kvm_sev_launch_update_data {
 	__u64 uaddr;
 	__u32 len;
+	__u32 pad0;
 };
 
 
 struct kvm_sev_launch_secret {
 	__u64 hdr_uaddr;
 	__u32 hdr_len;
+	__u32 pad0;
 	__u64 guest_uaddr;
 	__u32 guest_len;
+	__u32 pad1;
 	__u64 trans_uaddr;
 	__u32 trans_len;
+	__u32 pad2;
 };
 
 struct kvm_sev_launch_measure {
 	__u64 uaddr;
 	__u32 len;
+	__u32 pad0;
 };
 
 struct kvm_sev_guest_status {
@@ -731,33 +739,43 @@ struct kvm_sev_dbg {
 	__u64 src_uaddr;
 	__u64 dst_uaddr;
 	__u32 len;
+	__u32 pad0;
 };
 
 struct kvm_sev_attestation_report {
 	__u8 mnonce[16];
 	__u64 uaddr;
 	__u32 len;
+	__u32 pad0;
 };
 
 struct kvm_sev_send_start {
 	__u32 policy;
+	__u32 pad0;
 	__u64 pdh_cert_uaddr;
 	__u32 pdh_cert_len;
+	__u32 pad1;
 	__u64 plat_certs_uaddr;
 	__u32 plat_certs_len;
+	__u32 pad2;
 	__u64 amd_certs_uaddr;
 	__u32 amd_certs_len;
+	__u32 pad3;
 	__u64 session_uaddr;
 	__u32 session_len;
+	__u32 pad4;
 };
 
 struct kvm_sev_send_update_data {
 	__u64 hdr_uaddr;
 	__u32 hdr_len;
+	__u32 pad0;
 	__u64 guest_uaddr;
 	__u32 guest_len;
+	__u32 pad1;
 	__u64 trans_uaddr;
 	__u32 trans_len;
+	__u32 pad2;
 };
 
 struct kvm_sev_receive_start {
@@ -765,17 +783,22 @@ struct kvm_sev_receive_start {
 	__u32 policy;
 	__u64 pdh_uaddr;
 	__u32 pdh_len;
+	__u32 pad0;
 	__u64 session_uaddr;
 	__u32 session_len;
+	__u32 pad1;
 };
 
 struct kvm_sev_receive_update_data {
 	__u64 hdr_uaddr;
 	__u32 hdr_len;
+	__u32 pad0;
 	__u64 guest_uaddr;
 	__u32 guest_len;
+	__u32 pad1;
 	__u64 trans_uaddr;
 	__u32 trans_len;
+	__u32 pad2;
 };
 
 #define KVM_X2APIC_API_USE_32BIT_IDS            (1ULL << 0)
-- 
2.39.1



