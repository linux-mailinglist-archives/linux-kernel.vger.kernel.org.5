Return-Path: <linux-kernel+bounces-97957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CE987724D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 17:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7B101C20BC1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 16:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D5B1CD23;
	Sat,  9 Mar 2024 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CtftAZmq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B219EBF
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710001881; cv=none; b=TGRZmQfkJJ1GC+siWg9pAEf94jf+QdS2wWJfJElS6gubUT3Bc2mgzHFSuW0S64RbXBTC8v2Vz+grVmtI2i5ndWrrjnQVnyHqWssiXpnguP52QmK/6lcF13kb6fFFdPZA10T983WbyDArYivxGHk8fl0ihnJUyAQY4rX/kexsDpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710001881; c=relaxed/simple;
	bh=UQc3izrgQr12h3Xm9t3aa7jRiYIq8O1PvIR3W3XHYC0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tZoyCI4SX4cynErgeZE+bFkRa21O5WZ4bgrXJ3YzE9CLkprwTQ3XO0YxNp55vz8KzhD1xJT6xc+vwIxL+VOrANDCkZAGj4pO2JSFZnGMc89H5YspvRa+pOEgPtHosZuhQF7dfSwkVx8G5p8ZU1TYROC+BOvNNMCw60bBRgmEa/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CtftAZmq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710001878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U/gHXMil7a5VrcnGbVUk1+YLbdf6KR/XO3UxnJ9TTQQ=;
	b=CtftAZmqvJyjvh62DKZXo+PNb71mecoOdea40xh/cN4ztR1GumyrlaH1aiaebDNBDmRNUs
	FwNAxXwuAVM14oadT5QdKsZMoICFgkT2wJuBjMipTIFVz2rpIapuqMVPtaJR+/d+Amr0p+
	tStOjUlKpYVfzXxngu/fNa9pVDNy86I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-s-jvVsfJNZ2UCQRK9TVDZQ-1; Sat,
 09 Mar 2024 11:31:15 -0500
X-MC-Unique: s-jvVsfJNZ2UCQRK9TVDZQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4E2C3C025D0;
	Sat,  9 Mar 2024 16:31:14 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BEDC3200E28D;
	Sat,  9 Mar 2024 16:31:14 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	stable@vger.kernel.org
Subject: [PATCH] SEV: disable SEV-ES DebugSwap by default
Date: Sat,  9 Mar 2024 11:31:14 -0500
Message-Id: <20240309163114.2368452-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

The DebugSwap feature of SEV-ES provides a way for confidential guests to use
data breakpoints.  However, because the status of the DebugSwap feature is
recorded in the VMSA, enabling it by default invalidates the attestation
signatures.  In 6.10 we will introduce a new API to create SEV VMs that
will allow enabling DebugSwap based on what the user tells KVM to do.
Contextually, we will change the legacy KVM_SEV_ES_INIT API to never
enable DebugSwap.

For compatibility with kernels that pre-date the introduction of DebugSwap,
as well as with those where KVM_SEV_ES_INIT will never enable it, do not enable
the feature by default.  If anybody wants to use it, for now they can enable
the sev_es_debug_swap_enabled module parameter, but this will result in a
warning.

Fixes: d1f85fbe836e ("KVM: SEV: Enable data breakpoints in SEV-ES")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index f760106c31f8..69b37956c1c8 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -57,7 +57,7 @@ static bool sev_es_enabled = true;
 module_param_named(sev_es, sev_es_enabled, bool, 0444);
 
 /* enable/disable SEV-ES DebugSwap support */
-static bool sev_es_debug_swap_enabled = true;
+static bool sev_es_debug_swap_enabled = false;
 module_param_named(debug_swap, sev_es_debug_swap_enabled, bool, 0444);
 #else
 #define sev_enabled false
@@ -612,8 +612,11 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
 	save->xss  = svm->vcpu.arch.ia32_xss;
 	save->dr6  = svm->vcpu.arch.dr6;
 
-	if (sev_es_debug_swap_enabled)
+	if (sev_es_debug_swap_enabled) {
 		save->sev_features |= SVM_SEV_FEAT_DEBUG_SWAP;
+		pr_warn_once("Enabling DebugSwap with KVM_SEV_ES_INIT. "
+			     "This will not work starting with Linux 6.10\n");
+	}
 
 	pr_debug("Virtual Machine Save Area (VMSA):\n");
 	print_hex_dump_debug("", DUMP_PREFIX_NONE, 16, 1, save, sizeof(*save), false);
-- 
2.39.1


