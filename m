Return-Path: <linux-kernel+bounces-36457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E7183A116
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022201F2A523
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370F71755E;
	Wed, 24 Jan 2024 05:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IoEbuqCc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6AD17552
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 05:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706073248; cv=none; b=ZX0Lrg9H2FdbZVabDNAi+eQ6bhmO4kLYMh4NoR8PGfCM/ztCBt0RMKJ0EbunSMXIY7xhaqVwgKJzlMt7dfHX9S2rGE4Mn2eFxH/5wmE+g6zoIW8Fih8FHJjH5Fe5bAr9uW8At1TtiiNSs8DDjt2OFBtWnkJw6VmPCV9hgDxVwpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706073248; c=relaxed/simple;
	bh=dkYTv4vv/1SoWwXXD+uudRFCP4mJqhIMMcl51qz1x/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=eykD00wtyumNhPPrcnCxnbK0lE5toYOsDleDBD98jsJy5qRtuLStMJGtVtnqBJtTHfOoIhNnba5E+amJufY0ePGfMxoAeKWyUhJ0d1ciZDrX5G8rIZz1KJsK9Rb6iNUiwIeSRggiS0kWV/t6GHH2omzSOmHCnAhmrPrLyX24HUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IoEbuqCc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706073246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XGJ4xzKEBHQCL+Lx7EHmlxoam/nGU3dZpz0/i2oQX6A=;
	b=IoEbuqCcYvZsVlJpdY52PcfAim9/O2XKBKL8VGYLpzfk0BcVXC6G7WPSC8v3NF8AXBzri2
	8TCzCKLKyy/zpIvp4bkLbWtVHui/7PUFSNreXk0y9YiHgQ6BYikl77aB9n2f5TiKhUt2tX
	r4zrjcutG8Q3MSGOvzoFpy/MZYOafCY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-mzXdjdWzM6OsVmH87hSpMw-1; Wed, 24 Jan 2024 00:14:01 -0500
X-MC-Unique: mzXdjdWzM6OsVmH87hSpMw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1D2C185A780;
	Wed, 24 Jan 2024 05:14:00 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.117])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 367081C060AF;
	Wed, 24 Jan 2024 05:13:54 +0000 (UTC)
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
Subject: [PATCH linux-next v3 08/14] ppc, crash: enforce KEXEC and KEXEC_FILE to select CRASH_DUMP
Date: Wed, 24 Jan 2024 13:12:48 +0800
Message-ID: <20240124051254.67105-9-bhe@redhat.com>
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

In PowerPC, the crash dumping and kexec reboot share code in
arch_kexec_locate_mem_hole(), in which struct crash_mem is used.

Here enfoce enforce KEXEC and KEXEC_FILE to select CRASH_DUMP for now.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/powerpc/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e66fd9923250..31f013e636e3 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -608,6 +608,10 @@ config PPC64_SUPPORTS_MEMORY_FAILURE
 config ARCH_SUPPORTS_KEXEC
 	def_bool PPC_BOOK3S || PPC_E500 || (44x && !SMP)
 
+config ARCH_SELECTS_KEXEC
+	def_bool y
+	select CRASH_DUMP
+
 config ARCH_SUPPORTS_KEXEC_FILE
 	def_bool PPC64
 
@@ -618,6 +622,7 @@ config ARCH_SELECTS_KEXEC_FILE
 	def_bool y
 	depends on KEXEC_FILE
 	select KEXEC_ELF
+	select CRASH_DUMP
 	select HAVE_IMA_KEXEC if IMA
 
 config PPC64_BIG_ENDIAN_ELF_ABI_V2
-- 
2.41.0


