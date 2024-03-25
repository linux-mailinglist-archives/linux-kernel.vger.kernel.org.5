Return-Path: <linux-kernel+bounces-116356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C52889792
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DCF6B3E897
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EA4154459;
	Mon, 25 Mar 2024 04:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="d7THtd3n"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212F1269903
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 00:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711327905; cv=none; b=hRQT5hINJjOkcK2VtUlt2jIWjTBM591mAoh0mAYkkEMcmGFZCOvHNYljmayH8HWcPLto77mImrOux0Tpsrhb9P4tBuGuaOQGxpaN6HCtsGO5lIG+3pePU15juV/sUOqfj1Bkzxv/jLanBAEsXjOBKC8MrQphFGLGgvJg8Ciw5G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711327905; c=relaxed/simple;
	bh=rugzEQwxpG0o7uxss9YYnLkjqIxogVp0Xnx7MXzIofo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vDj+U15BeCNrqE8dp+gagM0BbS3ZNIjYBtINdKgzjfPRFT7GQxvMRZR35JaeDh1pQQldla9QNXVETD3KK5YN2DsqY7UYg1NTB8dRAWUvO31fPMODT+9T/afhimH+7IKJ8efaGZZKzUq++TvEyEYVfbdGybJTpBKop4p50DbbO4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=d7THtd3n; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711327892; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=CpPQ5+N9JSD3TuX+GeGtJ95cCrFjaJOvUAapG+YGKlQ=;
	b=d7THtd3nmwm109s7VA1rKXwFc3lOvfKYBR+kD9FE4W9kWMzi79GI2Pe1+BgpbyG5Tb5dQyC+sfSlDDP9LQq/OH+uzgnXdTn/j6I8Itr1QG2wL5As/lZzGj4EyKYuWNDAiI6MjKoqGzEOo6IALrrk7cFX9vPmxTgmJ02KlVEaDz8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W37scbo_1711327880;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W37scbo_1711327880)
          by smtp.aliyun-inc.com;
          Mon, 25 Mar 2024 08:51:32 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: drop experimental warning for FSDAX
Date: Mon, 25 Mar 2024 08:51:16 +0800
Message-Id: <20240325005116.106351-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As EXT4/XFS filesystems, FSDAX functionality is considered to be stable.
Let's drop this warning.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/super.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 6fbb1fba2d31..fc60a5a7794f 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -430,7 +430,6 @@ static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
 
 	switch (mode) {
 	case EROFS_MOUNT_DAX_ALWAYS:
-		warnfc(fc, "DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
 		set_opt(&ctx->opt, DAX_ALWAYS);
 		clear_opt(&ctx->opt, DAX_NEVER);
 		return true;
-- 
2.39.3


