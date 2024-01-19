Return-Path: <linux-kernel+bounces-31288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C06832BE7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4693B2220B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9237956447;
	Fri, 19 Jan 2024 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VsAuQgls"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF0E5472A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705676069; cv=none; b=puLf5wkhSf86C/ONroohOquK64929aX/tkTiHTwRWYte17wLNcfRRONK2+eDTjNxo3Rv1r/2bUcxYUKoMGBlq3622Rt8Rdmjo9IE/7dFsTtnqWJ0U3Sa3neSHxEf1Vbcm839+G+5V8LY3ZNFPk7wvX4Jn307o8sJ/4okpoTnYoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705676069; c=relaxed/simple;
	bh=oQxkSQ4O/ud5VcJBDiA8+ft0EzjaxWOJ7uOdw3yUGIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=nmCZDMNZ293MdFiDOWhQ2zN2e5ehO9QUG0cCvBaiYYBMu1W01HML7G5NJw/GP2U+6jQ1Q6wOlg7YNKQgMQGQNppVs0lLV3+04MnbGaXLy1kGe9P2bRpgFd9ZwpZdoxqJLzFWy2UifNF+ANfs5MkGZcYhU/5Wc1FxPscB/1IUmT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VsAuQgls; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705676067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PNOeu1HbpskBZbW25MWU6cZYUz3N/w+rWXoFdZjNr5M=;
	b=VsAuQglsbaetpoSH/asBihypGS1D0Lw/1Hfixu7SvUzNEBtDpzbPGLJg3/3S5MYotmstRH
	Ov1A/bLDAig87eBKm7ho4iqKSsXAsqGLWpX4IyciMAXAqhuyvxjT0mMd2rH6CrkcHyAQZt
	uz+uZctH4RMPgdteFvaBwiTwnA7sRKs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-VfYFFUBHNdin9KkcEv-clA-1; Fri, 19 Jan 2024 09:54:24 -0500
X-MC-Unique: VfYFFUBHNdin9KkcEv-clA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1734E106D107;
	Fri, 19 Jan 2024 14:54:23 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BB5F351D5;
	Fri, 19 Jan 2024 14:54:16 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	loongarch@lists.linux.dev,
	akpm@linux-foundation.org,
	ebiederm@xmission.com,
	hbathini@linux.ibm.com,
	piliu@redhat.com,
	viro@zeniv.linux.org.uk,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 12/14] mips, crash: wrap crash dumping code into crash related ifdefs
Date: Fri, 19 Jan 2024 22:52:39 +0800
Message-ID: <20240119145241.769622-13-bhe@redhat.com>
In-Reply-To: <20240119145241.769622-1-bhe@redhat.com>
References: <20240119145241.769622-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Now crash codes under kernel/ folder has been split out from kexec
code, crash dumping can be separated from kexec reboot in config
items on mips with some adjustments.

Here use IS_ENABLED(CONFIG_CRASH_RESERVE) check to decide if compiling
in the crashkernel reservation code.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/mips/kernel/setup.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 9c30de151597..12a1a4ffb602 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -442,8 +442,6 @@ static void __init mips_reserve_vmcore(void)
 #endif
 }
 
-#ifdef CONFIG_KEXEC
-
 /* 64M alignment for crash kernel regions */
 #define CRASH_ALIGN	SZ_64M
 #define CRASH_ADDR_MAX	SZ_512M
@@ -454,6 +452,9 @@ static void __init mips_parse_crashkernel(void)
 	unsigned long long crash_size, crash_base;
 	int ret;
 
+	if (!IS_ENABLED(CONFIG_CRASH_RESERVE))
+		return;
+
 	total_mem = memblock_phys_mem_size();
 	ret = parse_crashkernel(boot_command_line, total_mem,
 				&crash_size, &crash_base,
@@ -489,6 +490,9 @@ static void __init request_crashkernel(struct resource *res)
 {
 	int ret;
 
+	if (!IS_ENABLED(CONFIG_CRASH_RESERVE))
+		return;
+
 	if (crashk_res.start == crashk_res.end)
 		return;
 
@@ -498,15 +502,6 @@ static void __init request_crashkernel(struct resource *res)
 			(unsigned long)(resource_size(&crashk_res) >> 20),
 			(unsigned long)(crashk_res.start  >> 20));
 }
-#else /* !defined(CONFIG_KEXEC)		*/
-static void __init mips_parse_crashkernel(void)
-{
-}
-
-static void __init request_crashkernel(struct resource *res)
-{
-}
-#endif /* !defined(CONFIG_KEXEC)  */
 
 static void __init check_kernel_sections_mem(void)
 {
-- 
2.41.0


