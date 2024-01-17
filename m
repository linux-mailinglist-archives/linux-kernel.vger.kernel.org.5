Return-Path: <linux-kernel+bounces-28909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE5383047E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C27232884E8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C231DDF2;
	Wed, 17 Jan 2024 11:26:16 +0000 (UTC)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E261DDE7
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 11:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705490776; cv=none; b=fXP6vrON/1wtKHc83lQVkfLXebIYjjyjLIhHjrKQYovJsvQSaWV8Jm+1vsBttTBx/9DL1w8s598Y06EEz5puHtoStfGbblhX6Q6wjTCoQj3MZxNYsyJdjIMsUVnu1t3Ktj+YBvTCc2s5A+pHIvfi+/xV5zToTx8w8gqle3U1tFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705490776; c=relaxed/simple;
	bh=3g850I79bJFIBqc3V9qzvsDFb9DcwF8ME2+QRi5ZdsM=;
	h=X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=H4B0qFryTxT9OTYaSO1vrwIruB0hGv1XVcQLSLkoGAPsAOXco2nC8DiWxBMeNknuHH/F3EvqotBRAuATMLXCOla65BIyvJajr0X0zHNU0qA20eZqkgd141eu2MrMGGTkGQJtd5FF9FvwhI5OmruKU3XsDcRHahWqZCbBPwFo35U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=escape@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W-pLl.H_1705490764;
Received: from localhost(mailfrom:escape@linux.alibaba.com fp:SMTPD_---0W-pLl.H_1705490764)
          by smtp.aliyun-inc.com;
          Wed, 17 Jan 2024 19:26:05 +0800
From: Yi Tao <escape@linux.alibaba.com>
To: hannes@cmpxchg.org,
	surenb@google.com,
	peterz@infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sched/psi: Fix the bug where the last character is overwritten
Date: Wed, 17 Jan 2024 19:26:01 +0800
Message-Id: <a33440f33d42aab66ad4120303ecbe8dca401d5c.1705490349.git.escape@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The buffer buf in psi_write has only 32 bytes, and to ensure the correct
parsing of the string, it needs to be terminated with '\0', which means
users can input no more than 31 characters. When the user inputs fewer
than 31 characters, buf_size equals nbytes, which causes the last
character entered by the user to be overwritten by '\0', affecting the
parsing results.

Here is a specific example.

$echo -n "some 500000 1000000" > /proc/pressure/cpu
$bash: echo: write error: Invalid argument

Because the last character is overwritten, the value obtained by sscanf
parsing is 500000 and 100000; window_us is missing a zero, hence the
return of -EINVAL.

The reason 'echo' without the '-n' flag can be parsed correctly is
because the last character that gets overwritten is '\n', so it won't
return an error.

Limiting buf_size to no more than 31 and writing '\0' at the position of
buf_size can fix this bug.

Signed-off-by: Yi Tao <escape@linux.alibaba.com>
---
 kernel/sched/psi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 7b4aa5809c0f..5ae336e1c2d8 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1523,11 +1523,11 @@ static ssize_t psi_write(struct file *file, const char __user *user_buf,
 	if (!nbytes)
 		return -EINVAL;
 
-	buf_size = min(nbytes, sizeof(buf));
+	buf_size = min(nbytes, sizeof(buf) - 1);
 	if (copy_from_user(buf, user_buf, buf_size))
 		return -EFAULT;
 
-	buf[buf_size - 1] = '\0';
+	buf[buf_size] = '\0';
 
 	seq = file->private_data;
 
-- 
2.32.0.3.g01195cf9f


