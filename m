Return-Path: <linux-kernel+bounces-44368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F262E8420FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91EE41F23682
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4347460DC7;
	Tue, 30 Jan 2024 10:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KeMGWHIh"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C73A60869
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706609926; cv=none; b=gGbXfnliLKSyqcjq4lPwYpko/Z2tMaNIj/hdn1MFz/kmzgzfym7aXuVapl2fUJBsWmOIuoUOnETo1JVWBoe7Z0gAKXijsmozMrmc9SwPno9/0YSY3kZwinWRcnsbKBSRcrlyj9kDHX2WYZZVsi/VGmtYkgIHw1LJDiD45CgwfW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706609926; c=relaxed/simple;
	bh=A2NG9B9N8tLHm4kxPliIEqFmb2Hcb8wx1Xa+E1oBSdo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c+1SSvYpzdzLub78b4ujW+J5zOXF1sWVoM8VfEiGIRTkkM9rFwMjeMU2eXo74cUUstHC1+GLzJAv+QN6Tag0i215BDjDxrnSvdgbC56falTVe8zYXc/aIxmneLVbXEqCwZuZAjULAmfXLxOzoqrSPxZJi5ssyqBNp8z7n2wFgwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KeMGWHIh; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=e2FiQ
	hU+RTDN+Ko8jTvok8WomqOu6UE1H2nRRf9t1x4=; b=KeMGWHIh8XxfVLcfvhOtc
	dOT6iWXTPXY23QTiiYUHoMVuxl9IslvBFGHrG1y92xB1WbzkThSRe4CBI0BzWo0a
	yip+SLLv21ScuCn5WfpmqNg1zAwYzmxK1TDaf7s/rpMVIfy9EspYkkrvpaD1ejxh
	3BniyVxneyJVa+VNXHErlk=
Received: from yangzhang2020.localdomain (unknown [60.24.209.222])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wDXL2jmzLhlyCwHBg--.29538S2;
	Tue, 30 Jan 2024 18:18:20 +0800 (CST)
From: "yang.zhang" <gaoshanliukou@163.com>
To: ebiederm@xmission.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"yang.zhang" <yang.zhang@hexintek.com>
Subject: [PATCH] kexec: should use uchunk for user buffer increasing
Date: Tue, 30 Jan 2024 18:18:02 +0800
Message-Id: <20240130101802.23850-1-gaoshanliukou@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXL2jmzLhlyCwHBg--.29538S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw18ZFWrWr1DGr4xGFy3urg_yoWDtFb_Jw
	1Iyw4DWr4UZw43Jw4DZrWIgry2yw4Uur4S9r1I9FW7Ar9Yyrs0grZ3trnagr4fGrZ3W3yx
	tF97J3WSvr1jqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnVbyJUUUUU==
X-CM-SenderInfo: pjdr2x5dqox3xnrxqiywtou0bp/1tbiRAF18mVOBPed+QABs-

From: "yang.zhang" <yang.zhang@hexintek.com>

Because of alignment requirement in kexec-tools, there is
no problem for user buffer increasing when loading segments.
But when coping, the step is uchunk, so we should use uchunk
not mchunk.

Signed-off-by: yang.zhang <yang.zhang@hexintek.com>
---
 kernel/kexec_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index d08fc7b5db97..2b8354313c85 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -813,9 +813,9 @@ static int kimage_load_normal_segment(struct kimage *image,
 		ubytes -= uchunk;
 		maddr  += mchunk;
 		if (image->file_mode)
-			kbuf += mchunk;
+			kbuf += uchunk;
 		else
-			buf += mchunk;
+			buf += uchunk;
 		mbytes -= mchunk;
 
 		cond_resched();
@@ -881,9 +881,9 @@ static int kimage_load_crash_segment(struct kimage *image,
 		ubytes -= uchunk;
 		maddr  += mchunk;
 		if (image->file_mode)
-			kbuf += mchunk;
+			kbuf += uchunk;
 		else
-			buf += mchunk;
+			buf += uchunk;
 		mbytes -= mchunk;
 
 		cond_resched();
-- 
2.34.1


