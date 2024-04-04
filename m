Return-Path: <linux-kernel+bounces-131392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9ABB898708
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31F5828DCC4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C5D86AE7;
	Thu,  4 Apr 2024 12:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RB1yPqR2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF74386634
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712232879; cv=none; b=fY6c2QQDLU02lMBdSTon2/WFAke3g70MoHkW+hPYCW5lB7wtsqPJez00rKvIqsI9Vt5Q2EAs6odv9JkvnEftwSD/yl3tfOBUtQTbN348YUJ7qCc0w9ALdwtLJawF1CB+AJpKbUe/ym3kUmsM8pwBjW+u5lxejJAARmHx20xkb+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712232879; c=relaxed/simple;
	bh=79fyvg6eezjxxkD4dqHkcqexLGmoZdlcwbY6OSWAM9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KOhbzq+ha1GnckdMiQQX5iiAHLgZdmhktb3u99z5oIGRyGFYiPkxF7WKoPMwFwOR9m4d7gP6G0ZrFbUFiykUrUPiZtmgKBMed+B21aU/iYXIv9cx0AjMr55ePl8sl1enJIGHDm4SWQVRPaGGFrqA9qOiUYQ8Sq9AbSkR3nK3u8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RB1yPqR2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712232876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=siEojvJz+9pd959IDg+Ca7yTVzm2HP7m64YDzvkN/LQ=;
	b=RB1yPqR2FYono+1drOq5tn7/n9ROodTi8KI5Tj/jBaqWJxniwCEduuXymvKY1LdIopA3Qp
	+Evs6ztNzkq3KtjbaU9+ceLSJLe8HnDQ9hxXOwuo8qCABrZkluFgp/mcev5S0igln6WVRn
	so3cGKKJEZguWzj1YIZMRbfTsEfy298=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-ZKxRtCP5OhKF1Bz1bPlmAA-1; Thu, 04 Apr 2024 08:14:35 -0400
X-MC-Unique: ZKxRtCP5OhKF1Bz1bPlmAA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3059A805A60;
	Thu,  4 Apr 2024 12:14:35 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0E0BC492BD7;
	Thu,  4 Apr 2024 12:14:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: michael.roth@amd.com,
	seanjc@google.com
Subject: [PATCH] KVM: SEV: use u64_to_user_ptr throughout
Date: Thu,  4 Apr 2024 08:14:34 -0400
Message-ID: <20240404121434.3107212-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 44 +++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 022d92fb4b85..1642d7d49bde 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -377,7 +377,7 @@ static int sev_launch_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	if (!sev_guest(kvm))
 		return -ENOTTY;
 
-	if (copy_from_user(&params, (void __user *)(uintptr_t)argp->data, sizeof(params)))
+	if (copy_from_user(&params, u64_to_user_ptr(argp->data), sizeof(params)))
 		return -EFAULT;
 
 	memset(&start, 0, sizeof(start));
@@ -421,7 +421,7 @@ static int sev_launch_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
 	/* return handle to userspace */
 	params.handle = start.handle;
-	if (copy_to_user((void __user *)(uintptr_t)argp->data, &params, sizeof(params))) {
+	if (copy_to_user(u64_to_user_ptr(argp->data), &params, sizeof(params))) {
 		sev_unbind_asid(kvm, start.handle);
 		ret = -EFAULT;
 		goto e_free_session;
@@ -560,7 +560,7 @@ static int sev_launch_update_data(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	if (!sev_guest(kvm))
 		return -ENOTTY;
 
-	if (copy_from_user(&params, (void __user *)(uintptr_t)argp->data, sizeof(params)))
+	if (copy_from_user(&params, u64_to_user_ptr(argp->data), sizeof(params)))
 		return -EFAULT;
 
 	vaddr = params.uaddr;
@@ -780,7 +780,7 @@ static int sev_launch_update_vmsa(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
 static int sev_launch_measure(struct kvm *kvm, struct kvm_sev_cmd *argp)
 {
-	void __user *measure = (void __user *)(uintptr_t)argp->data;
+	void __user *measure = u64_to_user_ptr(argp->data);
 	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
 	struct sev_data_launch_measure data;
 	struct kvm_sev_launch_measure params;
@@ -800,7 +800,7 @@ static int sev_launch_measure(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	if (!params.len)
 		goto cmd;
 
-	p = (void __user *)(uintptr_t)params.uaddr;
+	p = u64_to_user_ptr(params.uaddr);
 	if (p) {
 		if (params.len > SEV_FW_BLOB_MAX_SIZE)
 			return -EINVAL;
@@ -873,7 +873,7 @@ static int sev_guest_status(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	params.state = data.state;
 	params.handle = data.handle;
 
-	if (copy_to_user((void __user *)(uintptr_t)argp->data, &params, sizeof(params)))
+	if (copy_to_user(u64_to_user_ptr(argp->data), &params, sizeof(params)))
 		ret = -EFAULT;
 
 	return ret;
@@ -1038,7 +1038,7 @@ static int sev_dbg_crypt(struct kvm *kvm, struct kvm_sev_cmd *argp, bool dec)
 	if (!sev_guest(kvm))
 		return -ENOTTY;
 
-	if (copy_from_user(&debug, (void __user *)(uintptr_t)argp->data, sizeof(debug)))
+	if (copy_from_user(&debug, u64_to_user_ptr(argp->data), sizeof(debug)))
 		return -EFAULT;
 
 	if (!debug.len || debug.src_uaddr + debug.len < debug.src_uaddr)
@@ -1122,7 +1122,7 @@ static int sev_launch_secret(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	if (!sev_guest(kvm))
 		return -ENOTTY;
 
-	if (copy_from_user(&params, (void __user *)(uintptr_t)argp->data, sizeof(params)))
+	if (copy_from_user(&params, u64_to_user_ptr(argp->data), sizeof(params)))
 		return -EFAULT;
 
 	pages = sev_pin_memory(kvm, params.guest_uaddr, params.guest_len, &n, 1);
@@ -1186,7 +1186,7 @@ static int sev_launch_secret(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
 static int sev_get_attestation_report(struct kvm *kvm, struct kvm_sev_cmd *argp)
 {
-	void __user *report = (void __user *)(uintptr_t)argp->data;
+	void __user *report = u64_to_user_ptr(argp->data);
 	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
 	struct sev_data_attestation_report data;
 	struct kvm_sev_attestation_report params;
@@ -1197,7 +1197,7 @@ static int sev_get_attestation_report(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	if (!sev_guest(kvm))
 		return -ENOTTY;
 
-	if (copy_from_user(&params, (void __user *)(uintptr_t)argp->data, sizeof(params)))
+	if (copy_from_user(&params, u64_to_user_ptr(argp->data), sizeof(params)))
 		return -EFAULT;
 
 	memset(&data, 0, sizeof(data));
@@ -1206,7 +1206,7 @@ static int sev_get_attestation_report(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	if (!params.len)
 		goto cmd;
 
-	p = (void __user *)(uintptr_t)params.uaddr;
+	p = u64_to_user_ptr(params.uaddr);
 	if (p) {
 		if (params.len > SEV_FW_BLOB_MAX_SIZE)
 			return -EINVAL;
@@ -1259,7 +1259,7 @@ __sev_send_start_query_session_length(struct kvm *kvm, struct kvm_sev_cmd *argp,
 	ret = sev_issue_cmd(kvm, SEV_CMD_SEND_START, &data, &argp->error);
 
 	params->session_len = data.session_len;
-	if (copy_to_user((void __user *)(uintptr_t)argp->data, params,
+	if (copy_to_user(u64_to_user_ptr(argp->data), params,
 				sizeof(struct kvm_sev_send_start)))
 		ret = -EFAULT;
 
@@ -1278,7 +1278,7 @@ static int sev_send_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	if (!sev_guest(kvm))
 		return -ENOTTY;
 
-	if (copy_from_user(&params, (void __user *)(uintptr_t)argp->data,
+	if (copy_from_user(&params, u64_to_user_ptr(argp->data),
 				sizeof(struct kvm_sev_send_start)))
 		return -EFAULT;
 
@@ -1333,7 +1333,7 @@ static int sev_send_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
 	ret = sev_issue_cmd(kvm, SEV_CMD_SEND_START, &data, &argp->error);
 
-	if (!ret && copy_to_user((void __user *)(uintptr_t)params.session_uaddr,
+	if (!ret && copy_to_user(u64_to_user_ptr(params.session_uaddr),
 			session_data, params.session_len)) {
 		ret = -EFAULT;
 		goto e_free_amd_cert;
@@ -1341,7 +1341,7 @@ static int sev_send_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
 
 	params.policy = data.policy;
 	params.session_len = data.session_len;
-	if (copy_to_user((void __user *)(uintptr_t)argp->data, &params,
+	if (copy_to_user(u64_to_user_ptr(argp->data), &params,
 				sizeof(struct kvm_sev_send_start)))
 		ret = -EFAULT;
 
@@ -1372,7 +1372,7 @@ __sev_send_update_data_query_lengths(struct kvm *kvm, struct kvm_sev_cmd *argp,
 	params->hdr_len = data.hdr_len;
 	params->trans_len = data.trans_len;
 
-	if (copy_to_user((void __user *)(uintptr_t)argp->data, params,
+	if (copy_to_user(u64_to_user_ptr(argp->data), params,
 			 sizeof(struct kvm_sev_send_update_data)))
 		ret = -EFAULT;
 
@@ -1392,7 +1392,7 @@ static int sev_send_update_data(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	if (!sev_guest(kvm))
 		return -ENOTTY;
 
-	if (copy_from_user(&params, (void __user *)(uintptr_t)argp->data,
+	if (copy_from_user(&params, u64_to_user_ptr(argp->data),
 			sizeof(struct kvm_sev_send_update_data)))
 		return -EFAULT;
 
@@ -1443,14 +1443,14 @@ static int sev_send_update_data(struct kvm *kvm, struct kvm_sev_cmd *argp)
 		goto e_free_trans_data;
 
 	/* copy transport buffer to user space */
-	if (copy_to_user((void __user *)(uintptr_t)params.trans_uaddr,
+	if (copy_to_user(u64_to_user_ptr(params.trans_uaddr),
 			 trans_data, params.trans_len)) {
 		ret = -EFAULT;
 		goto e_free_trans_data;
 	}
 
 	/* Copy packet header to userspace. */
-	if (copy_to_user((void __user *)(uintptr_t)params.hdr_uaddr, hdr,
+	if (copy_to_user(u64_to_user_ptr(params.hdr_uaddr), hdr,
 			 params.hdr_len))
 		ret = -EFAULT;
 
@@ -1502,7 +1502,7 @@ static int sev_receive_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
 		return -ENOTTY;
 
 	/* Get parameter from the userspace */
-	if (copy_from_user(&params, (void __user *)(uintptr_t)argp->data,
+	if (copy_from_user(&params, u64_to_user_ptr(argp->data),
 			sizeof(struct kvm_sev_receive_start)))
 		return -EFAULT;
 
@@ -1544,7 +1544,7 @@ static int sev_receive_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	}
 
 	params.handle = start.handle;
-	if (copy_to_user((void __user *)(uintptr_t)argp->data,
+	if (copy_to_user(u64_to_user_ptr(argp->data),
 			 &params, sizeof(struct kvm_sev_receive_start))) {
 		ret = -EFAULT;
 		sev_unbind_asid(kvm, start.handle);
@@ -1575,7 +1575,7 @@ static int sev_receive_update_data(struct kvm *kvm, struct kvm_sev_cmd *argp)
 	if (!sev_guest(kvm))
 		return -EINVAL;
 
-	if (copy_from_user(&params, (void __user *)(uintptr_t)argp->data,
+	if (copy_from_user(&params, u64_to_user_ptr(argp->data),
 			sizeof(struct kvm_sev_receive_update_data)))
 		return -EFAULT;
 
-- 
2.43.0


