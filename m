Return-Path: <linux-kernel+bounces-136223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CEF89D173
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F7601F2262B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F5656477;
	Tue,  9 Apr 2024 04:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bP4520uS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C388054672
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 04:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712636574; cv=none; b=AZh2BJYj41aHpDixwF8bTnZuzHSSABDljfLmxdxlsVSS5WIMMNvN0P4cc4OqZ4ztgY8mCYh1OllYmn829874dXVJi3pGbNpf+xt+Vemm4gs2ogbjKTjrYJgNVdX0+B10vQefwxbe8+FbrCVu74vZHxYEJ38rQie9vM/uYRGEGpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712636574; c=relaxed/simple;
	bh=mni5WVvCDm+zkncO9NAz8NliA7a2eGSlY5U9viMNhac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=bakc7wUKUWAdqMb2FDwu0wyZs5Yb9hbuSHbPY50Vu4saOYlEBeQY8J3/fGC46Jk7+h+dPd1A9OBp4NXYvswYUrorfO96T35eP3WEokI9+9Z66cyTne80ZE/BEfWqDeqdJ9yl9AJ51EJnPFAKwfKFy4UJb63fuEXVZfup0AT2xRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bP4520uS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712636571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6KAPtGBew3LOOWgs/rnupaUNsltQxJ2vjmJVi4Tpsck=;
	b=bP4520uS6kcmsCpxQYwoBXXa3dqGTTsgH+zNsamJ1Anp2zKUl5EBe1BPNynmZ6OVdpb8iY
	8kjhXXWAJTweaRBpUOhvpZ44+sQ1nFXjXBH/3AUPmbv/mzJGWCiLBhounRxGIUMJsp8XJO
	lhryJKyqVe42Q4ynwtFf8hYQNCyGxw0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-K6JynX3JObK_P15MTvSksg-1; Tue,
 09 Apr 2024 00:22:49 -0400
X-MC-Unique: K6JynX3JObK_P15MTvSksg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 664E51C03163;
	Tue,  9 Apr 2024 04:22:49 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2451D1C060A6;
	Tue,  9 Apr 2024 04:22:46 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	jirislaby@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v2] kexec: fix the unexpected kexec_dprintk() macro
Date: Tue,  9 Apr 2024 12:22:38 +0800
Message-ID: <20240409042238.1240462-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Jiri reported that the current kexec_dprintk() always prints out
debugging message whenever kexec/kdmmp loading is triggered. That is
not wanted. The debugging message is supposed to be printed out when
'kexec -s -d' is specified for kexec/kdump loading.

After investigating, the reason is the current kexec_dprintk() takes
printk(KERN_INFO) or printk(KERN_DEBUG) depending on whether '-d' is
specified. However, distros usually have defaulg log level like below:

 [~]# cat /proc/sys/kernel/printk
 7       4      1       7

So, even though '-d' is not specified, printk(KERN_DEBUG) also always
prints out. I thought printk(KERN_DEBUG) is equal to pr_debug(), it's
not.

Fix it by changing to use pr_info() instead which are expected to work.

Fixes: cbc2fe9d9cb2 ("kexec_file: add kexec_file flag to control debug printing")
Signed-off-by: Baoquan He <bhe@redhat.com>
Reported-by: Jiri Slaby <jirislaby@kernel.org>
Closes: https://lore.kernel.org/all/4c775fca-5def-4a2d-8437-7130b02722a2@kernel.org
---
v1->v2:
- Change to use pr_info() only when "kexec -s -d" is specified. With
  this change, those debugging message for "kexec -c -d" of kexec_load
  will be missed. We'll see if we need add them for kexec_load too, if
  someone explicitly requests it.

 include/linux/kexec.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 060835bb82d5..f31bd304df45 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -461,10 +461,8 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
 
 extern bool kexec_file_dbg_print;
 
-#define kexec_dprintk(fmt, ...)					\
-	printk("%s" fmt,					\
-	       kexec_file_dbg_print ? KERN_INFO : KERN_DEBUG,	\
-	       ##__VA_ARGS__)
+#define kexec_dprintk(fmt, arg...) \
+        do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
 
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
-- 
2.41.0


