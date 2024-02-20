Return-Path: <linux-kernel+bounces-72203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1883085B0BE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADE00B216CF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9313EA88;
	Tue, 20 Feb 2024 02:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hk9ERh2B"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6C0171AA
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 02:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708395124; cv=none; b=sA6YLmcTHMymO5FN5USH++yS3876aW7dlnLDQly2f3lOeENMcOKMq6iM+ehQLPdHhSFoq71RG7DCDDwG9TWC63nDNilYPG1XYfYH2Cxf7Dr8knBjIVkwpOdSK4J5nSC4kmm7fenF1maox0JpfgLFkQ20BWS7N+VUpgILG+DmaVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708395124; c=relaxed/simple;
	bh=bDNG2Mey+KC6KZ1T8yZBEYKkBjWpo5P+1ge2mZuklTI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ddWTmlxXzheiLij+27Nt30ZrAtGokbWX2bpc6g9nzIuszkWnfU/MPMQhmRFHQyQgPwOf/TOEe+dcIa4e+/M4eOUxpLOo6sDfkyX5aF33GKZx0x/7LwLT22rdnoEUTwxRVCaMiYSn9apvhdeIYcRL1aNCaCn1GSGfwvVQy2UeDUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hk9ERh2B; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hfqV3
	prgl2YOJl/pulYljFe3VTVS7nYpmcsCfsx02Kg=; b=hk9ERh2Bu9lud3FFYD15Y
	2yRLx2UcqL6yNR6bKtcs0gIA9xbROdx4gadQeaTff2PwcpVPlDZnOMyDmA+1sLKg
	yVAeIasTI+9SRJJPk5D/qmqgJUFiiKmbMrLShH5Lazs16kHRYnJjNjGo+7ZONsKf
	Gk8RfZnEuFxNHV0eyxpw8Y=
Received: from yangzhang2020.localdomain (unknown [60.24.209.108])
	by gzga-smtp-mta-g1-2 (Coremail) with SMTP id _____wDn9_o7CtRlEnztDA--.4655S2;
	Tue, 20 Feb 2024 10:11:08 +0800 (CST)
From: "yang.zhang" <gaoshanliukou@163.com>
To: ebiederm@xmission.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bhe@redhat.com,
	akpm@linux-foundation.org,
	"yang.zhang" <yang.zhang@hexintek.com>
Subject: [PATCH v2] kexec: copy only happens before uchunk goes to zero
Date: Tue, 20 Feb 2024 10:11:06 +0800
Message-Id: <20240220021106.694-1-gaoshanliukou@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn9_o7CtRlEnztDA--.4655S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur4xtr4UArykCw17GF1DAwb_yoW8KFWDp3
	9xGr10grWrJr9rXrn7tF98C3yfJ3s7GrWru3yUCF95KrnI93Wvq34F93Wj93yUKryFkrn5
	Jw4qkFyaga4UX37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jv1v3UUUUU=
X-CM-SenderInfo: pjdr2x5dqox3xnrxqiywtou0bp/xtbBZRyK8mV4H46InwAAsa

From: "yang.zhang" <yang.zhang@hexintek.com>

When load segments, all of the copying and the rest
only happens before uchunk goes to zero.

Signed-off-by: yang.zhang <yang.zhang@hexintek.com>

---
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


