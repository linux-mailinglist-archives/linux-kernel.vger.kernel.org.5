Return-Path: <linux-kernel+bounces-160145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 051F18B39D6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B552B281403
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B456014882F;
	Fri, 26 Apr 2024 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="QQT4WjVw"
Received: from out0-215.mail.aliyun.com (out0-215.mail.aliyun.com [140.205.0.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ACC13C9A3;
	Fri, 26 Apr 2024 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714141516; cv=none; b=H4J4b09fuHek3R7j4aVbnqk5qUuRg/ajrArGEcG2iqxZllgOK2OevhAVSavIz8qkVeGxS4x0cWoN/Vbf6vbQkjzsystWAK5gMy8+kSwFXbvDzLnc8zZKvAFPCEwvfuql6KHHuvPf5KA2kmLscvXe1cuQk06v37nO64zT+JQ96C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714141516; c=relaxed/simple;
	bh=dH6gXOMJzlWzz6rs5kHH5ugJrn+LocQPBu92TAKVHZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K710BroRbEoJDwcFxBFCS3L15flo00XlAX79zYFpzh1CNS/BK9nVOVcTr4EqKi3MnutShD4njomeKMqIKu3kZwHq+ZjeDa2+hd+IoGLJzKouhShqH9yhdMf1+xXtozxWvmF6bEn6Tg9CsgXbdkF4u5G0IFcULEgi745RDxYRCnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=QQT4WjVw; arc=none smtp.client-ip=140.205.0.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1714141505; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=vC6F+p1uePGPuYCXcSPJhPQ9nmAco8R10WN+YQVVKvg=;
	b=QQT4WjVwSyo2PtHFEIUyEujF/gd7+sXsa1soyAl7LaEFGyT04sRxY1A9OoQszpxxKJmFVtHedvE5q9vJrXcXIs9NGKSblx683qnAO0Rst24S0ed7XqD6eG5V2VbXP+mSQW/TQslubnpERNzzuB8XU07r3CfZUalTggEMY7IphK4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047188;MF=zhubojun.zbj@antgroup.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---.XM7T9lG_1714141176;
Received: from localhost(mailfrom:zhubojun.zbj@antgroup.com fp:SMTPD_---.XM7T9lG_1714141176)
          by smtp.aliyun-inc.com;
          Fri, 26 Apr 2024 22:19:45 +0800
From: "Bojun Zhu" <zhubojun.zbj@antgroup.com>
To: linux-kernel@vger.kernel.org,
	linux-sgx@vger.kernel.org,
	jarkko@kernel.org,
	dave.hansen@linux.intel.com
Cc:  <reinette.chatre@intel.com>,
  "=?UTF-8?B?5YiY5Y+MKOi9qeWxuSk=?=" <ls123674@antgroup.com>,
  "Bojun Zhu" <zhubojun.zbj@antgroup.com>
Subject: [RFC PATCH v2 1/1] x86/sgx: Explicitly give up the CPU in EDMM's ioctl() to avoid softlockup
Date: Fri, 26 Apr 2024 22:18:23 +0800
Message-Id: <20240426141823.112366-2-zhubojun.zbj@antgroup.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240426141823.112366-1-zhubojun.zbj@antgroup.com>
References: <20240426141823.112366-1-zhubojun.zbj@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EDMM's ioctl()s support batch operations, which may be
time-consuming. Try to explicitly give up the CPU as the prefix
operation at the every begin of "for loop" in
sgx_enclave_{ modify_types | restrict_permissions | remove_pages}
to give other tasks a chance to run, and avoid softlockup warning.

Additionally perform pending signals check as the prefix operation,
and introduce sgx_check_signal_and_resched(),
which wraps all the checks.

The following has been observed on Linux v6.9-rc5 with kernel
preemptions disabled(by configuring "PREEMPT_NONE=y"), when kernel
is requested to restrict page permissions of a large number of EPC pages.

    ------------[ cut here ]------------
    watchdog: BUG: soft lockup - CPU#45 stuck for 22s!
    ...
    RIP: 0010:sgx_enclave_restrict_permissions+0xba/0x1f0
    ...
    Call Trace:
     sgx_ioctl
     __x64_sys_ioctl
     x64_sys_call
     do_syscall_64
     entry_SYSCALL_64_after_hwframe
    ------------[ end trace ]------------

Signed-off-by: Bojun Zhu <zhubojun.zbj@antgroup.com>
---
 arch/x86/kernel/cpu/sgx/ioctl.c | 40 +++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index b65ab214bdf5..e0645920bcb5 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -365,6 +365,20 @@ static int sgx_validate_offset_length(struct sgx_encl *encl,
 	return 0;
 }
 
+/*
+ * Check signals and invoke scheduler. Return true for a pending signal.
+ */
+static bool sgx_check_signal_and_resched(void)
+{
+	if (signal_pending(current))
+		return true;
+
+	if (need_resched())
+		cond_resched();
+
+	return false;
+}
+
 /**
  * sgx_ioc_enclave_add_pages() - The handler for %SGX_IOC_ENCLAVE_ADD_PAGES
  * @encl:       an enclave pointer
@@ -432,16 +446,13 @@ static long sgx_ioc_enclave_add_pages(struct sgx_encl *encl, void __user *arg)
 		return -EINVAL;
 
 	for (c = 0 ; c < add_arg.length; c += PAGE_SIZE) {
-		if (signal_pending(current)) {
+		if (sgx_check_signal_and_resched()) {
 			if (!c)
 				ret = -ERESTARTSYS;
 
 			break;
 		}
 
-		if (need_resched())
-			cond_resched();
-
 		ret = sgx_encl_add_page(encl, add_arg.src + c, add_arg.offset + c,
 					&secinfo, add_arg.flags);
 		if (ret)
@@ -746,6 +757,13 @@ sgx_enclave_restrict_permissions(struct sgx_encl *encl,
 	secinfo.flags = modp->permissions & SGX_SECINFO_PERMISSION_MASK;
 
 	for (c = 0 ; c < modp->length; c += PAGE_SIZE) {
+		if (sgx_check_signal_and_resched()) {
+			if (!c)
+				ret = -ERESTARTSYS;
+
+			goto out;
+		}
+
 		addr = encl->base + modp->offset + c;
 
 		sgx_reclaim_direct();
@@ -913,6 +931,13 @@ static long sgx_enclave_modify_types(struct sgx_encl *encl,
 	secinfo.flags = page_type << 8;
 
 	for (c = 0 ; c < modt->length; c += PAGE_SIZE) {
+		if (sgx_check_signal_and_resched()) {
+			if (!c)
+				ret = -ERESTARTSYS;
+
+			goto out;
+		}
+
 		addr = encl->base + modt->offset + c;
 
 		sgx_reclaim_direct();
@@ -1101,6 +1126,13 @@ static long sgx_encl_remove_pages(struct sgx_encl *encl,
 	secinfo.flags = SGX_SECINFO_R | SGX_SECINFO_W | SGX_SECINFO_X;
 
 	for (c = 0 ; c < params->length; c += PAGE_SIZE) {
+		if (sgx_check_signal_and_resched()) {
+			if (!c)
+				ret = -ERESTARTSYS;
+
+			goto out;
+		}
+
 		addr = encl->base + params->offset + c;
 
 		sgx_reclaim_direct();
-- 
2.25.1


