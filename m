Return-Path: <linux-kernel+bounces-106744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5790087F301
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1073428314D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8B35C8EB;
	Mon, 18 Mar 2024 22:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWKXmU5k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EB05A4CA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 22:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710799812; cv=none; b=asTA9S9QAlWF+C66RVZXrRoZbl0N3E5tcj5OLoXiKuaD5OnlBoyexUa2Z1/Bvi6x+905kUl1vn7KjCBTq25FzGynVQrxa9ez1NDMNWdDIRkIGPHFPogVhw9Db12DwTwIVX6mnYP3v0R6u7q72hRuerTKfAoE0BaebPdW4HssgCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710799812; c=relaxed/simple;
	bh=Z5iRfxdNh5CyrDoUPDoH234u8YFkwUvwaTp8RBly4oA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p4elbk+OFVa1waiFocSGhTEhdg4eC5hUy+lM4EojsGeKMBEshsGOaGbejMr5AnZ6ysBvIDN8FoIMnMCNlqOaT4GtlQnu5sZhqL/C++KifJ4l+4o0NU8GbGMFKEDzFmmGgQyaLQTQx5JgQRg4queFuGmFZOhldbKHAIutQ9ev3b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWKXmU5k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710799808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WBkKm95Ln/2RsUgEOWoo/2LuPFULXZi0eLnZQwdqLAM=;
	b=XWKXmU5kMG0UVPLYFCQ6x0ReXR9vxZsINggyDCtk4O+4Xc46qLeGMSsMQoRIj1Y0lqpb0j
	UUECrgPKGsvisE2/hCBgy8FUmDoyIAoyeMW/iPxLym4VwgWXU6caFZcYXXklFALZJVGR12
	gYx7MzyXyjyWvWJD9niSit79kVVbh6k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-NnrrJCCFNB-Nld8hG1-VXA-1; Mon,
 18 Mar 2024 18:10:05 -0400
X-MC-Unique: NnrrJCCFNB-Nld8hG1-VXA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACB591C04330;
	Mon, 18 Mar 2024 22:10:04 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8BF02492BC8;
	Mon, 18 Mar 2024 22:10:04 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Michael Roth <michael.roth@amd.com>
Subject: [PATCH 6/7] Documentation: kvm/sev: separate description of firmware
Date: Mon, 18 Mar 2024 18:10:01 -0400
Message-ID: <20240318221002.2712738-7-pbonzini@redhat.com>
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

The description of firmware is included part under the "SEV Key Management"
header, part under the KVM_SEV_INIT ioctl.  Put these two bits together and
and rename "SEV Key Management" to what it actually is, namely a description
of the KVM_MEMORY_ENCRYPT_OP API.

Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .../virt/kvm/x86/amd-memory-encryption.rst    | 29 +++++++++++--------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/Documentation/virt/kvm/x86/amd-memory-encryption.rst b/Documentation/virt/kvm/x86/amd-memory-encryption.rst
index 995780088eb2..4f2eb441c718 100644
--- a/Documentation/virt/kvm/x86/amd-memory-encryption.rst
+++ b/Documentation/virt/kvm/x86/amd-memory-encryption.rst
@@ -46,14 +46,8 @@ SEV hardware uses ASIDs to associate a memory encryption key with a VM.
 Hence, the ASID for the SEV-enabled guests must be from 1 to a maximum value
 defined in the CPUID 0x8000001f[ecx] field.
 
-SEV Key Management
-==================
-
-The SEV guest key management is handled by a separate processor called the AMD
-Secure Processor (AMD-SP). Firmware running inside the AMD-SP provides a secure
-key management interface to perform common hypervisor activities such as
-encrypting bootstrap code, snapshot, migrating and debugging the guest. For more
-information, see the SEV Key Management spec [api-spec]_
+The KVM_MEMORY_ENCRYPT_OP ioctl
+===============================
 
 The main ioctl to access SEV is KVM_MEMORY_ENCRYPT_OP.  If the argument
 to KVM_MEMORY_ENCRYPT_OP is NULL, the ioctl returns 0 if SEV is enabled
@@ -87,10 +81,6 @@ guests, such as launching, running, snapshotting, migrating and decommissioning.
 The KVM_SEV_INIT command is used by the hypervisor to initialize the SEV platform
 context. In a typical workflow, this command should be the first command issued.
 
-The firmware can be initialized either by using its own non-volatile storage or
-the OS can manage the NV storage for the firmware using the module parameter
-``init_ex_path``. If the file specified by ``init_ex_path`` does not exist or
-is invalid, the OS will create or override the file with output from PSP.
 
 Returns: 0 on success, -negative on error
 
@@ -434,6 +424,21 @@ issued by the hypervisor to make the guest ready for execution.
 
 Returns: 0 on success, -negative on error
 
+Firmware Management
+===================
+
+The SEV guest key management is handled by a separate processor called the AMD
+Secure Processor (AMD-SP). Firmware running inside the AMD-SP provides a secure
+key management interface to perform common hypervisor activities such as
+encrypting bootstrap code, snapshot, migrating and debugging the guest. For more
+information, see the SEV Key Management spec [api-spec]_
+
+The AMD-SP firmware can be initialized either by using its own non-volatile
+storage or the OS can manage the NV storage for the firmware using
+parameter ``init_ex_path`` of the ``ccp`` module. If the file specified
+by ``init_ex_path`` does not exist or is invalid, the OS will create or
+override the file with PSP non-volatile storage.
+
 References
 ==========
 
-- 
2.43.0



