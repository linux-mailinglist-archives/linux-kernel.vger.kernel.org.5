Return-Path: <linux-kernel+bounces-31286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FBF832BE0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7133283C50
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64AF54BFD;
	Fri, 19 Jan 2024 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZG8kYmV9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F012D5467D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 14:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705676057; cv=none; b=mBHNOV47mP2iQ+BdlQzZBrdE+7fHV66g0gz4EAnhZcNVTOZgx9Hl6Zl9Ddc+fvvcTsJXvtKQX3OiVUC9RiiTdQzEm7Z8APiCuNbioIZ1Zbj9iYogtW6zJ6Qv7ERc8A8Qffc/2aF1QBcAdJM2KLWpnw2iOYtUMZ40XZkrrfJk54s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705676057; c=relaxed/simple;
	bh=NVnBdGZA7tQM0SMzzy9C+0Stne+AfN1tEQ8W4aNz72Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=krRbiWDxb7rghnQNcf0DcNVYVbBhAsxEfWAd5j4o8b9nWx/j0y0AuDDYt4K7hlea/xluW6wN3+a22HlFDaH5Yup61Xv2WIAC9m911rKf++mFFAUIgrXuEtv/9G5KaFMTf9MHMWDq3l6QvtLsn3G5Ux306B52JhkzGH0B676+vYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZG8kYmV9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705676055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o/8hCUVuTDtixWcZu0Bhjq+7RevB6bL41WaDVirnLF4=;
	b=ZG8kYmV9c0UI3iU0shmY5yyfjFt1GuIkMm84RzfPmbIuhEkOmA6Pvu4dg1n6wBcZb5kdBq
	P99Sk80KookpmM0Uwc1XyFUVzzhcxnit9AUVVroVf3eSSKbHKarM9vKpcidD0TcCEljX+/
	uVgIgnS24UnHsnv6uptvZwi5iRgp5L4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-D60y9ktTMdCt2oSU5Zg3Og-1; Fri, 19 Jan 2024 09:54:10 -0500
X-MC-Unique: D60y9ktTMdCt2oSU5Zg3Og-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 46A7484FA82;
	Fri, 19 Jan 2024 14:54:09 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4A02E51D5;
	Fri, 19 Jan 2024 14:54:02 +0000 (UTC)
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
Subject: [PATCH v2 10/14] sh, crash: wrap crash dumping code into crash related ifdefs
Date: Fri, 19 Jan 2024 22:52:37 +0800
Message-ID: <20240119145241.769622-11-bhe@redhat.com>
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
items on SuperH with some adjustments.

Here wrap up crashkernel reservation code inside CONFIG_CRASH_RESERVE
ifdeffery scope.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/sh/kernel/machine_kexec.c | 3 +++
 arch/sh/kernel/setup.c         | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/sh/kernel/machine_kexec.c b/arch/sh/kernel/machine_kexec.c
index fa3a7b36190a..8daa8a6e6fa6 100644
--- a/arch/sh/kernel/machine_kexec.c
+++ b/arch/sh/kernel/machine_kexec.c
@@ -153,6 +153,9 @@ void __init reserve_crashkernel(void)
 	unsigned long long crash_size, crash_base;
 	int ret;
 
+	if (!IS_ENABLED(CONFIG_CRASH_RESERVE))
+		return;
+
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
 			&crash_size, &crash_base, NULL, NULL);
 	if (ret == 0 && crash_size > 0) {
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index d3175f09b3aa..620e5cf8ae1e 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -220,7 +220,7 @@ void __init __add_active_range(unsigned int nid, unsigned long start_pfn,
 	request_resource(res, &code_resource);
 	request_resource(res, &data_resource);
 	request_resource(res, &bss_resource);
-#ifdef CONFIG_KEXEC_CORE
+#ifdef CONFIG_CRASH_RESERVE
 	request_resource(res, &crashk_res);
 #endif
 
-- 
2.41.0


