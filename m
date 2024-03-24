Return-Path: <linux-kernel+bounces-112705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DE6887D2C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 15:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B600281746
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 14:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8C218038;
	Sun, 24 Mar 2024 14:05:39 +0000 (UTC)
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net (zg8tmja5ljk3lje4ms43mwaa.icoremail.net [209.97.181.73])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9BD17BD6;
	Sun, 24 Mar 2024 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.181.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711289139; cv=none; b=kMduMSdv6izfx0BCe32zk+dJGJtvndH+kfHWD8AS9nj7HeNu8Kyq0xWqFziJFu6QNofKZeVCUR8z1LW7Eqzwp3U64kwG3c11GTDUgSq4pe9WU6qjKOZrYueWmWVcpjcNfJV2kbxBbwVMDm/YwV3eBhaalPS/JlrOF9Q/lVSDy9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711289139; c=relaxed/simple;
	bh=o2gfx2M0LqqtCFmcmwNJmkgj/vYb5MeMt7l5rcKqAlM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=VNougTvSzbYxU2oZjf+kbdfyfnMB56h/isGYH3Y7iu72/+zIrvNqetq8BDxL5VEnjbpzsKgIEwc5GWj7yObUPF9f+AMY6OU70EW4dr6pgOutKZVtufOTwcGtNsPaRAXe87KNE346xzaUSIvaNowxYeA4Gx+l/QrZ1+HrP3RDi6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=209.97.181.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [106.117.100.135])
	by mail-app3 (Coremail) with SMTP id cC_KCgDX18H8MgBmd0YTAQ--.13126S2;
	Sun, 24 Mar 2024 22:05:00 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	wim@linux-watchdog.org,
	linux@roeck-us.net,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH] watchdog: cpu5wdt.c: Fix use-after-free bug caused by cpu5wdt_trigger
Date: Sun, 24 Mar 2024 22:04:44 +0800
Message-Id: <20240324140444.119584-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:cC_KCgDX18H8MgBmd0YTAQ--.13126S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Jw4DAF4kJry8Xr15Ww1Utrb_yoW8JryUpr
	W8Jry2kryktrW293Z7ZFn8ZFW8u3sxAa4IkF1UC39a9Fs3Xr1fCFWrKr4jgFZrtFZ5J3y3
	Xr10q345W34rXrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUSNtxUUU
	UU=
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwMJAWX+3hkBYwA5sP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

When the cpu5wdt module is removing, the origin code uses del_timer() to
de-activate the timer. If the timer handler is running, del_timer() could
not stop it and will return directly. If the port region is released by
release_region() and then the timer handler cpu5wdt_trigger() calls outb()
to write into the region that is released, the use-after-free bug will
happen.

Change del_timer() to timer_shutdown_sync() in order that the timer handler
could be finished before the port region is released.

Fixes: e09d9c3e9f85 ("watchdog: cpu5wdt.c: add missing del_timer call")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 drivers/watchdog/cpu5wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/cpu5wdt.c b/drivers/watchdog/cpu5wdt.c
index 688b112e712..9f279c0e13a 100644
--- a/drivers/watchdog/cpu5wdt.c
+++ b/drivers/watchdog/cpu5wdt.c
@@ -252,7 +252,7 @@ static void cpu5wdt_exit(void)
 	if (cpu5wdt_device.queue) {
 		cpu5wdt_device.queue = 0;
 		wait_for_completion(&cpu5wdt_device.stop);
-		del_timer(&cpu5wdt_device.timer);
+		timer_shutdown_sync(&cpu5wdt_device.timer);
 	}
 
 	misc_deregister(&cpu5wdt_misc);
-- 
2.17.1


