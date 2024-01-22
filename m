Return-Path: <linux-kernel+bounces-32918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AEA8361EB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C591C23CE7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB3A47A5D;
	Mon, 22 Jan 2024 11:26:45 +0000 (UTC)
Received: from zg8tmty3ljk5ljewns4xndka.icoremail.net (zg8tmty3ljk5ljewns4xndka.icoremail.net [167.99.105.149])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8D13FB0F;
	Mon, 22 Jan 2024 11:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.99.105.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705922804; cv=none; b=fNga8OoNwkuTr58zKl3AKbt114wHPjrKxDTvxu27nrdIESTsSa8Hw9OjTXf1mqWhVMr3k9EUW34ZA4DDUan5FPDwKnCNhXo1EQGXcka04dqVy+nEz3W914CagtkqgTTuc9W4ymgM3AeSNnc+lhV9gGw5rEJVd6P7pisEAZ8t1v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705922804; c=relaxed/simple;
	bh=4MTzk8hRpsL1+wfg2XAn8qvaYkdX9cgM4ufqwTPlx6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SpF/ucddlPVrf16O3OSdiI74hFRIY6QsapA6jtAhbUgHdY9YuGZjz9X3JgKvUA9msMPsJoUD2XfboOcqqjpw0IkYKdeAkF+X6+4x6mOIzwQlL8L9ZDM+09BHMFvzSfU79exRssQWHMtcdWPjUQmuksH1/XQelSdwJGryQGNKYU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=167.99.105.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app1 (Coremail) with SMTP id HgEQrACXmim7UK5lq3KtAQ--.37301S2;
	Mon, 22 Jan 2024 19:25:47 +0800 (CST)
Received: from localhost.localdomain (unknown [10.12.190.56])
	by gateway (Coremail) with SMTP id _____wCHJbasUK5lBlwmAA--.60615S2;
	Mon, 22 Jan 2024 19:25:47 +0800 (CST)
From: Mingxuan Xiang <mx_xiang@hust.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Dongliang Mu <dzm91@hust.edu.cn>,
	Mingxuan Xiang <mx_xiang@hust.edu.cn>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] media: usb: hackrf: add null ptr check in hackrf_ctrl_msg
Date: Mon, 22 Jan 2024 19:22:10 +0800
Message-ID: <20240122112210.424698-1-mx_xiang@hust.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrACXmim7UK5lq3KtAQ--.37301S2
Authentication-Results: app1; spf=neutral smtp.mail=mx_xiang@hust.edu.
	cn;
X-Coremail-Antispam: 1UD129KBjvJXoWxAFyfCFWxXFW5Kr1kKF18uFg_yoW5Xw45pF
	yFyrZFkryrXry29wn7Jr1UWFyrZan3AFy5Wryfu395urs8Jw4xXF1jqayqgr4qkrZ2yF90
	yF9YqrW3tF4UZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Yb7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0EF7xvrVAajcxG14v26r4UJVWxJr1lYx0E74AGY7Cv6cx26r4fZr1UJr1lYx
	0Ec7CjxVAajcxG14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uFyUJr1UMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCT
	nIWIevJa73UjIFyTuYvjxUV1xRUUUUU
X-CM-SenderInfo: jxsqimaruylmo6kx23oohg3hdfq/1tbiAQkEE2WtIjAvbQAAsH

If the user yanks out the cable before closing the file,
dev->udev would be set to NULL therefore causing a null-ptr-deref
in hackrf_ctrl_msg issued by hackrf_stop_streaming.

This patch adds a check in hackrf_ctrl_msg before using
dev->udev.

Found by modified syzkaller.

BUG: KASAN: null-ptr-deref in hackrf_ctrl_msg+0x6d/0x180 drivers/media/usb/hackrf/hackrf.c:195
Read of size 4 at addr 0000000000000000 by task syz-executor/579
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x5e/0x7c lib/dump_stack.c:106
 print_report.cold+0x49a/0x6bb mm/kasan/report.c:436
 kasan_report+0xa8/0x130 mm/kasan/report.c:495
 hackrf_ctrl_msg+0x6d/0x180 drivers/media/usb/hackrf/hackrf.c:195
 hackrf_stop_streaming+0x45/0x140 drivers/media/usb/hackrf/hackrf.c:869
 __vb2_queue_cancel+0x5c/0x550 drivers/media/common/videobuf2/videobuf2-core.c:1992
 vb2_core_streamoff+0x2f/0xb0 drivers/media/common/videobuf2/videobuf2-core.c:2149
 __vb2_cleanup_fileio+0x3e/0xa0 drivers/media/common/videobuf2/videobuf2-core.c:2710
 vb2_core_queue_release+0x1a/0x50 drivers/media/common/videobuf2/videobuf2-core.c:2430
 vb2_queue_release drivers/media/common/videobuf2/videobuf2-v4l2.c:947 [inline]
 _vb2_fop_release+0x110/0x140 drivers/media/common/videobuf2/videobuf2-v4l2.c:1132
 v4l2_release+0x1b9/0x1e0 drivers/media/v4l2-core/v4l2-dev.c:459
 __fput+0x12d/0x4b0 fs/file_table.c:320
 task_work_run+0xa8/0xf0 kernel/task_work.c:177
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:169 [inline]
 exit_to_user_mode_prepare+0x123/0x130 kernel/entry/common.c:201
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x22/0x50 kernel/entry/common.c:294
 do_syscall_64+0x48/0x90 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Signed-off-by: Mingxuan Xiang <mx_xiang@hust.edu.cn>
---
 drivers/media/usb/hackrf/hackrf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/usb/hackrf/hackrf.c b/drivers/media/usb/hackrf/hackrf.c
index 9c0ecd5f056c..9588b8aa6e98 100644
--- a/drivers/media/usb/hackrf/hackrf.c
+++ b/drivers/media/usb/hackrf/hackrf.c
@@ -186,6 +186,11 @@ static int hackrf_ctrl_msg(struct hackrf_dev *dev, u8 request, u16 value,
 	unsigned int pipe;
 	u8 requesttype;
 
+	if (!dev->udev) {
+		pr_err("udev is null in %s\n", __func__);
+		ret = -EINVAL;
+		goto err;
+	}
 	switch (request) {
 	case CMD_SET_TRANSCEIVER_MODE:
 	case CMD_SET_FREQ:
-- 
2.43.0


