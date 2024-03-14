Return-Path: <linux-kernel+bounces-103134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9A087BB73
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51C1BB21474
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5EA5DF0E;
	Thu, 14 Mar 2024 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSw8VGoo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A411A38FC
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710412799; cv=none; b=gcFeJvbssuGPej55EY3kGwiekwU22+T3KJQoycoc/JJjdewU4p9dl+NKmOOgg0JRnaQVzaWbVXGmYNsOcHQpgwiUf5QDlwlhRLCDnBVKboEFUkjQNFepSBKNvRsAm1m195MYnjlMYdEP+EKTiafRkhe8CO+9H5Z7XC8n+zOl1b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710412799; c=relaxed/simple;
	bh=WA/d7U+qMBdpAtL/JkS2HGf9X4mCPAEE0NoMZUmak6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=irN99MOg/h4jAaq5Ecw4tUMrSJ/SjuLjyol3aTmTA7xk25kTlc7S8vod9wd5QK4dCt9cYG/7HpuT7fCQyYookwvQKx/7kXqRK3wpvdzhjjTynHloThMgQcsdQ1UPH8U3bSRYchZu3MnnKBDd7HgrWhk++ODnJ+KSKLIY/AeTsDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MSw8VGoo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710412797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=h1t6v9xZW/pkiF5v9nyuhZFPcP+Pb9Nu3++MFe0FI4s=;
	b=MSw8VGoowUqdf2PIWFzqWYaqXnoUqmxZTGa6u1UMsw7vuIx7eKi6II3JYTFhfTTEDv9Crr
	3AKXlO21odCDnrkCih0stR0XQG8LOnSJSxvrSIQqztwb5UVLG9gIH0j7VdqL+uUlGZsrMh
	5ZWNqyN/J0MKvVxwOuE6aNI3evpx6+o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-Nvm8_iUWOYO1Tcub9tdI1Q-1; Thu, 14 Mar 2024 06:39:55 -0400
X-MC-Unique: Nvm8_iUWOYO1Tcub9tdI1Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03F2784B061;
	Thu, 14 Mar 2024 10:39:55 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 459FF16A9C;
	Thu, 14 Mar 2024 10:39:50 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org,
	jirislaby@kernel.org,
	akpm@linux-foundation.org,
	joe@perches.com,
	dyoung@redhat.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH] kexec: fix the unexpected kexec_dprintk() macro
Date: Thu, 14 Mar 2024 18:39:47 +0800
Message-ID: <20240314103947.717991-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Jiri reported that the current kexec_dprintk() always prints out
debugging message whenever kexec/kdmmp loading is triggered. That is
not wanted. The debugging message is supposed to be printed out when
'kexec -s -d' is specified for kexec/kdump loading.

After investigating, the reason is the current kexec_dprintk() takes
printk(KERN_INFO) or printk(KERN_DEBUG) depending on whether '-d' is
specified. However, distros usually have defaulg log level like below:

 [~]# cat /proc/sys/kernel/printk
 7	 4	1	7

So, even though '-d' is not specified, printk(KERN_DEBUG) also always
prints out. I thought printk(KERN_DEBUG) is equal to pr_debug(), it's
not.

Fix it by changing to use pr_info() and pr_debug() instead which are
expected to work.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reported-by: Jiri Slaby <jirislaby@kernel.org>
Closes: https://lore.kernel.org/all/4c775fca-5def-4a2d-8437-7130b02722a2@kernel.org
---
 include/linux/kexec.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 400cb6c02176..09688e681bf7 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -502,10 +502,13 @@ static inline unsigned int crash_get_elfcorehdr_size(void) { return 0; }
 
 extern bool kexec_file_dbg_print;
 
-#define kexec_dprintk(fmt, ...)					\
-	printk("%s" fmt,					\
-	       kexec_file_dbg_print ? KERN_INFO : KERN_DEBUG,	\
-	       ##__VA_ARGS__)
+#define kexec_dprintk(fmt, args...)				\
+	do {							\
+		if (kexec_file_dbg_print)			\
+			pr_info(fmt, ##args);			\
+		else						\
+			pr_debug(fmt, ##args);			\
+	} while (0)
 
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
-- 
2.41.0


