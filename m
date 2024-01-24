Return-Path: <linux-kernel+bounces-36462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B0F83A12C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48ADD1C2683B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205D817983;
	Wed, 24 Jan 2024 05:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fpw1LwqO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20DA1775C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 05:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706073280; cv=none; b=uRtw52mI85vXyaIsYb2EqRxmUr6HJNThDQl3F71E4Q7MoqD7v2kLrSWKUNQiqsgMbxGAKysvCrZbVALy3yHg+5bgD2lnQDJUMuOVSqviRbwDDoKziQCGTImmCa0siSEFZSSF5wRRrG0JufAQHpKZsGVLGBbL4z5Du/BHCXKRKCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706073280; c=relaxed/simple;
	bh=k6IRigT5ShOUPzBco13SjuMG/jHBS6L0oyGW6iX8LiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=ooyq7iz/9y0f+YdI5EO/Dnc1Yg+9lXYsQhvjL0fy4sPWBWyXoALGG0T8yNfIDwWEAKttEjqIwxqrb+1J+l2m3huU6U15xlR0FuYPLlkdunjhAl4YaqcGr/kZb0yjkxPEBDMmALa2kkzd4UHtrWV9ecmsJm6k3tMs8qDwxl4eVbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fpw1LwqO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706073278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DIZYlTsptXiAI7dlXg4SxNVNXFZexCcZy74a3rSLM5Q=;
	b=fpw1LwqOlJurgFB7MzF1w7EK49COv4KnLkAwtKuHp01dTeEg9KiSCs4aBQNrjd8Qkyk72t
	1LG7Cn1fOCc1iYbymIx8Ch5V0Ul7IuNa/iIf76Ic16cHR53TjdFbED6LFQMDfsxbguUjVF
	WnhXZro5ny3lftfpLtmeYGAjZ50fHds=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-vrDbGUhWNFqeQwQpMZG3Sw-1; Wed, 24 Jan 2024 00:14:34 -0500
X-MC-Unique: vrDbGUhWNFqeQwQpMZG3Sw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83719837224;
	Wed, 24 Jan 2024 05:14:33 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.117])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EEA7C1C060AF;
	Wed, 24 Jan 2024 05:14:27 +0000 (UTC)
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
Subject: [PATCH linux-next v3 13/14] arm, crash: wrap crash dumping code into crash related ifdefs
Date: Wed, 24 Jan 2024 13:12:53 +0800
Message-ID: <20240124051254.67105-14-bhe@redhat.com>
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
items on arm with some adjustments.

Here use CONFIG_CRASH_RESERVE ifdef to replace CONFIG_KEXEC ifdef.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
v2->v3:
- Fix the lkp reported issue by using CONFIG_CRASH_RESERVE ifdef,
  giving up the earlier IS_ENABLED(CONFIG_CRASH_RESERVE) checking 
  in v2.

 arch/arm/kernel/setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index ff2299ce1ad7..7b33b157fca0 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -979,7 +979,7 @@ static int __init init_machine_late(void)
 }
 late_initcall(init_machine_late);
 
-#ifdef CONFIG_KEXEC
+#ifdef CONFIG_CRASH_RESERVE
 /*
  * The crash region must be aligned to 128MB to avoid
  * zImage relocating below the reserved region.
@@ -1066,7 +1066,7 @@ static void __init reserve_crashkernel(void)
 }
 #else
 static inline void reserve_crashkernel(void) {}
-#endif /* CONFIG_KEXEC */
+#endif /* CONFIG_CRASH_RESERVE*/
 
 void __init hyp_mode_check(void)
 {
-- 
2.41.0


