Return-Path: <linux-kernel+bounces-119170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC1588C510
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0602929BFDB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1976B12D77F;
	Tue, 26 Mar 2024 14:26:12 +0000 (UTC)
Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F34F20DF7;
	Tue, 26 Mar 2024 14:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711463171; cv=none; b=OY0GwwCRemAoJLkhUYt6U2OWGQRKn2p9CQ95yGFuzKvgD6r+hBlInRH0DUpepgeJhKJp/VJJLiGyT8u96xxDmquVDz9TutyX9VQ9er+p7hCFBn6q5r3Ty2fiEgiHGpNx+Ejxc9hKnAgo0igJspJauyRMTavbUjoqxUwq9EB1Nuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711463171; c=relaxed/simple;
	bh=OC7tCvTydfv2WFPYMhnm6Kce8VRGXQdO45oszdOLx2w=;
	h=From:To:Cc:Subject:Date:Message-Id; b=R91NulUY6xNDLEUI/teb7v71jErr7BLSD9xau8X82lvpMIaC4TQwwfeYo8Qy9WroD11d0yYnOJSrjps63rjU6dkukK/ZLAOMyoOpiyQknE4V3Kh9CTMVoLFatfnr88hdfjYOWpT5hc1G7mpG1uTSgTSJCZDEydQjmp+PKYRbXKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [218.12.18.99])
	by mail-app4 (Coremail) with SMTP id cS_KCgDXi8Dm2gJmIc5YAQ--.22282S2;
	Tue, 26 Mar 2024 22:25:52 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-hams@vger.kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	jreuter@yaina.de,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH net] ax25: fix use-after-free bugs caused by ax25_ds_del_timer
Date: Tue, 26 Mar 2024 22:25:42 +0800
Message-Id: <20240326142542.118058-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:cS_KCgDXi8Dm2gJmIc5YAQ--.22282S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy7GF45tw47JFyxJr13Jwb_yoW8JF4kpF
	WqgF43AF97AryqyF48WF1kWryUAFy8Z3yDCFy7ua1Ikwn3X3Z8JF1DK3yIqFW7GFZ5Arn7
	Cw10qr45uFn5CFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFylc2xSY4AK67AK6ry5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7VU1OtxDUUUUU==
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwUMAWYBgRkWjQBPsg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

When the ax25 device is detaching, the ax25_dev_device_down()
calls ax25_ds_del_timer() to cleanup the slave_timer. When
the timer handler is running, the ax25_ds_del_timer() that
calls del_timer() in it will return directly. As a result,
the use-after-free bugs could happen, one of the scenarios
is shown below:

      (Thread 1)          |      (Thread 2)
                          | ax25_ds_timeout()
ax25_dev_device_down()    |
  ax25_ds_del_timer()     |
    del_timer()           |
  ax25_dev_put() //FREE   |
                          |  ax25_dev-> //USE

In order to mitigate bugs, when the device is detaching, use
timer_shutdown_sync() to stop the timer.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 net/ax25/ax25_ds_timer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ax25/ax25_ds_timer.c b/net/ax25/ax25_ds_timer.c
index c4f8adbf814..5624c0d174c 100644
--- a/net/ax25/ax25_ds_timer.c
+++ b/net/ax25/ax25_ds_timer.c
@@ -43,7 +43,12 @@ void ax25_ds_setup_timer(ax25_dev *ax25_dev)
 
 void ax25_ds_del_timer(ax25_dev *ax25_dev)
 {
-	if (ax25_dev)
+	if (!ax25_dev)
+		return;
+
+	if (!ax25_dev->device_up)
+		timer_shutdown_sync(&ax25_dev->dama.slave_timer);
+	else
 		del_timer(&ax25_dev->dama.slave_timer);
 }
 
-- 
2.17.1


