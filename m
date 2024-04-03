Return-Path: <linux-kernel+bounces-129305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7B1896861
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A5BAB2B500
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C78130AE5;
	Wed,  3 Apr 2024 08:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FidQLK6g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53FE6BFC2;
	Wed,  3 Apr 2024 08:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131893; cv=none; b=TIRx1sJQazHniDOMl2lxRw5oTJFmMyk587p0yrTV66M3Y6+00HWY4XTiDMJHrzbn8IedR7ouXL7ESS4zNY7qad7jstP2+sQNr1qbStOeyNhUCeA8enpfsbdvvG5BUhwec6cIZyZ7CHqr94Y3HzdT3j8ZyDs+Cg6R2XxV4TC6i0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131893; c=relaxed/simple;
	bh=SH31gyLQOUjbQcsB8HrfJNW22dR7OQWuGrhgZCjvHU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PXLgbXcXWJo5jR87y6N+M2qaHg5837eymDKdFOTlbfxnuU9ta3S8G/JYl26xecN2iYLoL56NdYFASS9hQfB0WiCwL+PQRnxA7CQkKvWK44lI9Zp3asY4F/7hdQv+k3c14Mh5fvzXuEGtXv+s8M15uzTB8h2d+5Pt9K3ImTsvBy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FidQLK6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD697C433F1;
	Wed,  3 Apr 2024 08:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712131893;
	bh=SH31gyLQOUjbQcsB8HrfJNW22dR7OQWuGrhgZCjvHU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FidQLK6gJYLaHmLSbMmJq7Apfm2CmmsGY0w8vFJ9AUgB5Uvdf+QMvV5PQKVWqQAsm
	 UDMd2GxCQgrKO2Y4/qnJXh1w61ipZJlUbr0wgYopmxLFUXvny2uvMjnn/JGYWwXtIj
	 M07HB74PU7sW9slUtYd/dghQLUoDL0ycxWajmLD3jCfbjHh8rUfLLB6pQbseX/wRgC
	 cfIg9+Xx3szTAegVMFufdxt8Cj6BvbFapg8ir/FoHKNqqZmtd2bIDnZoh2EGuj+K0q
	 OLpDs6Gn5QRKlNWmZt/Zg9ZIlPjf4h0g0l0adlbszBXPhIovybmrJFgeeYLiy/60LI
	 B1j3vM0Uy+ung==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Karsten Keil <isdn@linux-pingi.de>,
	Kees Cook <keescook@chromium.org>,
	Justin Stitt <justinstitt@google.com>,
	netdev@vger.kernel.org
Subject: [PATCH 26/34] isdn: kcapi: don't build unused procfs code
Date: Wed,  3 Apr 2024 10:06:44 +0200
Message-Id: <20240403080702.3509288-27-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240403080702.3509288-1-arnd@kernel.org>
References: <20240403080702.3509288-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The procfs file is completely unused without CONFIG_PROC_FS but causes
a compile time warning:

drivers/isdn/capi/kcapi_proc.c:97:36: error: unused variable 'seq_controller_ops' [-Werror,-Wunused-const-variable]
static const struct seq_operations seq_controller_ops = {
drivers/isdn/capi/kcapi_proc.c:104:36: error: unused variable 'seq_contrstats_ops' [-Werror,-Wunused-const-variable]
drivers/isdn/capi/kcapi_proc.c:179:36: error: unused variable 'seq_applications_ops' [-Werror,-Wunused-const-variable]
drivers/isdn/capi/kcapi_proc.c:186:36: error: unused variable 'seq_applstats_ops' [-Werror,-Wunused-const-variable]

Remove the file from the build in that config and make the calls into
it conditional instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/isdn/capi/Makefile | 3 ++-
 drivers/isdn/capi/kcapi.c  | 7 +++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/isdn/capi/Makefile b/drivers/isdn/capi/Makefile
index 352217ebabd8..4fd3a4d7133f 100644
--- a/drivers/isdn/capi/Makefile
+++ b/drivers/isdn/capi/Makefile
@@ -2,4 +2,5 @@
 # Makefile for the CAPI subsystem used by BT_CMTP
 
 obj-$(CONFIG_BT_CMTP)			+= kernelcapi.o
-kernelcapi-y				:= kcapi.o capiutil.o capi.o kcapi_proc.o
+kernelcapi-y				:= kcapi.o capiutil.o capi.o
+kernelcapi-$(CONFIG_PROC_FS)		+= kcapi_proc.o
diff --git a/drivers/isdn/capi/kcapi.c b/drivers/isdn/capi/kcapi.c
index 136ba9fe55e0..c5d13bdc239b 100644
--- a/drivers/isdn/capi/kcapi.c
+++ b/drivers/isdn/capi/kcapi.c
@@ -917,13 +917,16 @@ int __init kcapi_init(void)
 		return err;
 	}
 
-	kcapi_proc_init();
+	if (IS_ENABLED(CONFIG_PROC_FS))
+		kcapi_proc_init();
+
 	return 0;
 }
 
 void kcapi_exit(void)
 {
-	kcapi_proc_exit();
+	if (IS_ENABLED(CONFIG_PROC_FS))
+		kcapi_proc_exit();
 
 	cdebug_exit();
 	destroy_workqueue(kcapi_wq);
-- 
2.39.2


