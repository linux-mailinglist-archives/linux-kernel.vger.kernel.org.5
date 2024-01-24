Return-Path: <linux-kernel+bounces-36460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A2083A123
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2391C26286
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16270175AA;
	Wed, 24 Jan 2024 05:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TFM34+Kt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36CF175A5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 05:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706073269; cv=none; b=iuGfibcktKzIXkQisJ1EYZdyP4HfQ/RCgLqYPOKxtKt2MzpbVVSxt87fFuKpi2KSTm9ih2JEf2S/1DFAzIt/FM3w6pluOA4NpbVcQIMwJNwS4cDsJ17QneUOvpTZ2UbU5A2MvQDks1Xseyoq1zraxRQdQrdriDlYcmiEbVY2qAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706073269; c=relaxed/simple;
	bh=oQxkSQ4O/ud5VcJBDiA8+ft0EzjaxWOJ7uOdw3yUGIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=UvNEOkVo1MmnTMs0jhDQOk4txJnPB/8c+CKiL66aYbYJQu9jbgaTGbRvYeDwU8mT1+DkZsGGAZmd5rGVy3F9Wl4AQ41OqemxF1Rjyc1P9ft7Q942P5ONG5U9DbY02Ji8aaRKXtyhk+BkxQTt6nMudKui61bz6IeaPvsEzyxBn70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TFM34+Kt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706073267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PNOeu1HbpskBZbW25MWU6cZYUz3N/w+rWXoFdZjNr5M=;
	b=TFM34+KtGCKZMxs436uwig+Eria2DbQV5zigfrl8Rzhu14Z73M/8FB2dgvM8wLUZHApc+d
	jWS9n6Jxd9QgJlzJNXc6Ra5cR2lt5kHwMeLWYWsueQxUnjV6xTk9kdjKfIVug/W4h/I67X
	/A4KN3wDL07g8o8C6AuPpQaDtWvSdT0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-xwsoB4tCPl2PN_DmUSobQw-1; Wed, 24 Jan 2024 00:14:21 -0500
X-MC-Unique: xwsoB4tCPl2PN_DmUSobQw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3761085A589;
	Wed, 24 Jan 2024 05:14:20 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.117])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 966E31C060AF;
	Wed, 24 Jan 2024 05:14:14 +0000 (UTC)
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
Subject: [PATCH linux-next v3 11/14] mips, crash: wrap crash dumping code into crash related ifdefs
Date: Wed, 24 Jan 2024 13:12:51 +0800
Message-ID: <20240124051254.67105-12-bhe@redhat.com>
In-Reply-To: <20240124051254.67105-1-bhe@redhat.com>
References: <20240124051254.67105-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

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


