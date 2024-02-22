Return-Path: <linux-kernel+bounces-76207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8732A85F42B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CEF61F24B8A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E789D3716A;
	Thu, 22 Feb 2024 09:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bh4IqpA6"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1902375F
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708593707; cv=none; b=LkK6bl/v0NH/FfmTOsRhT0xpJwLFHlshUS9ffT+enQCXsi8CupMQtuKQf3/erda8tqLKWB6DaHD9MZAQRY3052dLCL0Yq9SgixnBcSCMu1Y0yUUDn6c50Q564lph8nnCaC/YETKMT3SKrbLrcVqbgCWsTkWBENaelKL+U4cmOTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708593707; c=relaxed/simple;
	bh=Gp6ifRhXtu6IzNFdn/+ncdfl38xS/UkvsM6DFjdqeBo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cwsp/jw8obi76SXqUivbncaGJgk8xy8ZKGuQYCRuUzn3OX4KeMTL/kyCMF+dIidGmAezZjbwrL/yMFGcMyu78P58x0rWSEnQXzCG/DUi0e5r6vbOTPcABpjM4hqlXaiJcFNLe3F8Mgji2tGtMSezUhD6Md6WOhlUfLYhCveG6F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bh4IqpA6; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=oCVce
	RJ4c78MPAjhinbj8feHNV7TeUxfiGEfqf5K8ws=; b=bh4IqpA6DUBrOMjpjwuIg
	a9XQAhUt7C9PAcjYXAq/cu4Ie4lnQ3ABCb8R6fwdqCY1+7yDrJU8PJkjMM4nTKqR
	BW0fQ0o/c40PIt4KJVKghjw4XuVh4VLh1/fOZRizSj5chzACLmGRMNJMqxDZwzdF
	kdEsvnUMBXV5URm5pbWyGY=
Received: from yangzhang2020.localdomain (unknown [60.27.226.204])
	by gzga-smtp-mta-g1-5 (Coremail) with SMTP id _____wDXD4USEtdlSNHNDg--.2170S2;
	Thu, 22 Feb 2024 17:21:23 +0800 (CST)
From: "yang.zhang" <gaoshanliukou@163.com>
To: ebiederm@xmission.com
Cc: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	bhe@redhat.com,
	"yang.zhang" <yang.zhang@hexintek.com>
Subject: [PATCH V3] kexec: copy only happens before uchunk goes to zero
Date: Thu, 22 Feb 2024 17:21:19 +0800
Message-Id: <20240222092119.5602-1-gaoshanliukou@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXD4USEtdlSNHNDg--.2170S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFyfXFykCw4rJF1DXF4rAFb_yoW5XFyxp3
	9xGr1FkrW8Jr9rXr1ktF15CayfJ3s7GryrurW7CF95KrnI93Wvq34S93Wj93yUKryFkrn5
	Jw4qkF9Iga4UX37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jgR6rUUUUU=
X-CM-SenderInfo: pjdr2x5dqox3xnrxqiywtou0bp/xtbB0BmM8mWXwByflwAAsR

From: "yang.zhang" <yang.zhang@hexintek.com>

When loading segments, ubytes is <= mbytes. When ubytes is exhausted,
there could be remaining mbytes. Then in the while loop, the buf pointer
advancing with mchunk will causing meaningless reading even though it
doesn't harm.

So let's change to make sure that all of the copying and the rest only
happens before uchunk goes to zero.

Acked-by: Baoquan He <bhe@redhat.com>
Signed-off-by: yang.zhang <yang.zhang@hexintek.com>

---
V2 -> V3:
- Add more detailed description in the commit message
v1 -> v2:
- Only copy before uchunk goes to zero

V1: https://lore.kernel.org/lkml/20240130101802.23850-1-gaoshanliukou@163.com/
---
 kernel/kexec_core.c | 44 ++++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index d08fc7b5db97..2fc3d0e3715a 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -800,22 +800,24 @@ static int kimage_load_normal_segment(struct kimage *image,
 				PAGE_SIZE - (maddr & ~PAGE_MASK));
 		uchunk = min(ubytes, mchunk);
 
-		/* For file based kexec, source pages are in kernel memory */
-		if (image->file_mode)
-			memcpy(ptr, kbuf, uchunk);
-		else
-			result = copy_from_user(ptr, buf, uchunk);
+		if (uchunk) {
+			/* For file based kexec, source pages are in kernel memory */
+			if (image->file_mode)
+				memcpy(ptr, kbuf, uchunk);
+			else
+				result = copy_from_user(ptr, buf, uchunk);
+			ubytes -= uchunk;
+			if (image->file_mode)
+				kbuf += uchunk;
+			else
+				buf += uchunk;
+		}
 		kunmap_local(ptr);
 		if (result) {
 			result = -EFAULT;
 			goto out;
 		}
-		ubytes -= uchunk;
 		maddr  += mchunk;
-		if (image->file_mode)
-			kbuf += mchunk;
-		else
-			buf += mchunk;
 		mbytes -= mchunk;
 
 		cond_resched();
@@ -866,11 +868,18 @@ static int kimage_load_crash_segment(struct kimage *image,
 			memset(ptr + uchunk, 0, mchunk - uchunk);
 		}
 
-		/* For file based kexec, source pages are in kernel memory */
-		if (image->file_mode)
-			memcpy(ptr, kbuf, uchunk);
-		else
-			result = copy_from_user(ptr, buf, uchunk);
+		if (uchunk) {
+			/* For file based kexec, source pages are in kernel memory */
+			if (image->file_mode)
+				memcpy(ptr, kbuf, uchunk);
+			else
+				result = copy_from_user(ptr, buf, uchunk);
+			ubytes -= uchunk;
+			if (image->file_mode)
+				kbuf += uchunk;
+			else
+				buf += uchunk;
+		}
 		kexec_flush_icache_page(page);
 		kunmap_local(ptr);
 		arch_kexec_pre_free_pages(page_address(page), 1);
@@ -878,12 +887,7 @@ static int kimage_load_crash_segment(struct kimage *image,
 			result = -EFAULT;
 			goto out;
 		}
-		ubytes -= uchunk;
 		maddr  += mchunk;
-		if (image->file_mode)
-			kbuf += mchunk;
-		else
-			buf += mchunk;
 		mbytes -= mchunk;
 
 		cond_resched();
-- 
2.25.1


