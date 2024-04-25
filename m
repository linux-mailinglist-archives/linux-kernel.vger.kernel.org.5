Return-Path: <linux-kernel+bounces-158354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 064198B1EBC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7EA4284053
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0086126F37;
	Thu, 25 Apr 2024 10:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a3mL236y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4561486AFA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 10:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714039487; cv=none; b=NZiK3hXZTdtfMrFwlOySUKO/UMZEZzNf78qClOZMo1axEkwRImY0j95mHKTi74dM3TywI2AzEggxdtr+Dm0scfczlqZ2U/mbc2xVp89y4ZI3FgveNvzEpcUvPQvXBN/NkFNxpxQ46FXDpFHPotsiQYC/O6O/+bToCDNAIffpoew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714039487; c=relaxed/simple;
	bh=WCihwivYZH8W0XeKOEd64Cs3hnChnBiPIvusi34oOuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOa7VFwAH/fqIz/FJO54sbz2hUWZK2WyNTKwV4qMJn+nPrYbRq6Idgv968OmLoZjfeUphvc4yzYaoDNrcrbjCTrO3G0VqnnaDMLBvuz9f1gfefm8kUASrP9rqVvrJLPhq7Oqar4oumFMmdz4VMu9kvJjH3G3bAhDdOnSFRVhu60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a3mL236y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714039484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t7YJePHmU0xnd5mm75PGlWk6ufheCOsZkTtpzDbbBcI=;
	b=a3mL236yPkps8aoaWEfF5UUOLGEGYVTLVo3eWD51lX+57T4qJLj1FGrhdm/mOHrsjGQBTe
	4iyglNcpOAxmChPsz0/B39tBLkc7R6H+KrAOb82JIa515+DdzclewpTPvYWT6gIS505qz6
	REqFqlOQnC2RsI1CkWNnKjIu7ZzxXko=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-3-O0xwkSOSC8QGsRUFmQ-g-1; Thu, 25 Apr 2024 06:04:42 -0400
X-MC-Unique: 3-O0xwkSOSC8QGsRUFmQ-g-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5c6245bc7caso843574a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 03:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714039482; x=1714644282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7YJePHmU0xnd5mm75PGlWk6ufheCOsZkTtpzDbbBcI=;
        b=KtTdlZnaOYD2gMB014Kz9UoiPIEkG15QDLjI0DRnYkDT//aT/3l9V/L9RkkCsljdln
         KOz6GaPCITSS7kx8mCLmx8K5HCFu207H17IN50mxjwacaM1UGR5NeUvEBa0X4evvWk9f
         CzUszrdoMUujlfImrBDmlyDvyq77cKjOWqC233i3jhplEhOUl7Nkm7dLJTZ7jFxp9D8j
         VbGsxH/coAcKcqsiW8ZWgHrW+InpmQfXb1uvAH78zZfIY9ZEwJTblQlEdtYAxGwp5K5B
         U92L/L7sWrGwD04TvfMdogWnkUvQ1JskZPY/wMocdxl1oeK4EpXw5GfLY+ONjxFO4GVg
         8m2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXSQVPrY230CBReE+fVRASTwrAVGRUuwN4ug3su3CUUprcrP6bz2Wu2u6fOl1zGnO2evCg9LghG8mMFiPobmciSwLuAijbji8l6hZkP
X-Gm-Message-State: AOJu0Yzw+2m1gfOqfn/F87beuexKaw38ngot3QZEn36WSrUpFpttJZX7
	9cnV0Soia711ZmI/ms2nRzwrdwgTOBeLQukebTZ8v1J0bXv6tmFmW57VocduNPoS5Th1FY7o2b4
	6QlLbDsqHLYpvsyCuJoKJ61ZHNdty2mhVf7ZE5wCJUrRISBsCsXWTjgOnbeUOyw==
X-Received: by 2002:a17:902:ce8b:b0:1ea:d979:d778 with SMTP id f11-20020a170902ce8b00b001ead979d778mr224430plg.5.1714039481204;
        Thu, 25 Apr 2024 03:04:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHN0TZp8wDqekae9LssrRvMGxaiGtqZMmDqIbLmVRxKgwD9CaWsKIbQrIIuSnXcFnS4B8UqqA==
X-Received: by 2002:a17:902:ce8b:b0:1ea:d979:d778 with SMTP id f11-20020a170902ce8b00b001ead979d778mr224381plg.5.1714039480577;
        Thu, 25 Apr 2024 03:04:40 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e13-20020a17090ab38d00b0029c49ed3974sm12575962pjr.37.2024.04.25.03.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 03:04:40 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	dm-devel@redhat.com,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH v3 1/7] kexec_file: allow to place kexec_buf randomly
Date: Thu, 25 Apr 2024 18:04:25 +0800
Message-ID: <20240425100434.198925-2-coxu@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240425100434.198925-1-coxu@redhat.com>
References: <20240425100434.198925-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, kexec_buf is placed in order which means for the same
machine, the info in the kexec_buf is always located at the same
position each time the machine is booted. This may cause a risk for
sensitive information like LUKS volume key. Now struct kexec_buf has a
new field random which indicates it's supposed to be placed in a random
position.

Suggested-by: Jan Pazdziora <jpazdziora@redhat.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/kexec.h |  2 ++
 kernel/kexec_file.c   | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 060835bb82d5..fc1e20d565d5 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -171,6 +171,7 @@ int kexec_image_post_load_cleanup_default(struct kimage *image);
  * @buf_min:	The buffer can't be placed below this address.
  * @buf_max:	The buffer can't be placed above this address.
  * @top_down:	Allocate from top of memory.
+ * @random:	Place the buffer at a random position.
  */
 struct kexec_buf {
 	struct kimage *image;
@@ -182,6 +183,7 @@ struct kexec_buf {
 	unsigned long buf_min;
 	unsigned long buf_max;
 	bool top_down;
+	bool random;
 };
 
 int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf);
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 2d1db05fbf04..e0630fe30d43 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -25,6 +25,7 @@
 #include <linux/elfcore.h>
 #include <linux/kernel.h>
 #include <linux/kernel_read_file.h>
+#include <linux/prandom.h>
 #include <linux/syscalls.h>
 #include <linux/vmalloc.h>
 #include "kexec_internal.h"
@@ -432,6 +433,16 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	return ret;
 }
 
+static unsigned long kexec_random_start(unsigned long start, unsigned long end)
+{
+	unsigned long temp_start;
+	unsigned short i;
+
+	get_random_bytes(&i, sizeof(unsigned short));
+	temp_start = start + (end - start) / USHRT_MAX * i;
+	return temp_start;
+}
+
 static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 				    struct kexec_buf *kbuf)
 {
@@ -440,6 +451,8 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
 
 	temp_end = min(end, kbuf->buf_max);
 	temp_start = temp_end - kbuf->memsz + 1;
+	if (kbuf->random)
+		temp_start = kexec_random_start(temp_start, temp_end);
 
 	do {
 		/* align down start */
@@ -477,6 +490,8 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
 	unsigned long temp_start, temp_end;
 
 	temp_start = max(start, kbuf->buf_min);
+	if (kbuf->random)
+		temp_start = kexec_random_start(temp_start, end);
 
 	do {
 		temp_start = ALIGN(temp_start, kbuf->buf_align);
-- 
2.44.0


