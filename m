Return-Path: <linux-kernel+bounces-33789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AA5836E89
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5759C1C263E7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0A05025B;
	Mon, 22 Jan 2024 17:21:17 +0000 (UTC)
Received: from zg8tmty3ljk5ljewns4xndka.icoremail.net (zg8tmty3ljk5ljewns4xndka.icoremail.net [167.99.105.149])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA7660885
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.99.105.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944076; cv=none; b=r/ndtETasfRYMyRc5jEt/W1rTqENBabaY5z0bebWLBqAOs193Nlob/3jHC12e/BLluH3dG34hBNyjiUazMxBoeqFRlxWkhQYmSZDQjio2yWmO79FEKBAIYwL1gwL+XJUgBTYUjnGBq1nZnZAy503/qdPqK5t++tTx23S1pOZtOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944076; c=relaxed/simple;
	bh=2V9Iq+B/eJMgiMP5UOIZEY6gJkg/us4u+IV6rDI2l0E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rhHkTF6xEMQX5fL1s4idfrqSxD7AwaYgo0MOm0wj0vk8aCqMFHp4fsNB0Q4JpJxW2MnMk7zRNy0S6tQlVubsTnvJ/Vf8V5l63gd2juGCt+FnuGJMWnqqhGsTv5+9DqpIe74aUQJ9PEe1TYKvDpw+x9n+2Pl72nTGNOtZQh+u+7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=167.99.105.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from luzhipeng.223.5.5.5 (unknown [39.174.92.167])
	by mail-app4 (Coremail) with SMTP id cS_KCgDHBIUBpK5lxVh5AA--.20045S2;
	Tue, 23 Jan 2024 01:21:05 +0800 (CST)
From: Zhipeng Lu <alexious@zju.edu.cn>
To: alexious@zju.edu.cn
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Christian Gromm <christian.gromm@microchip.com>,
	Dan Carpenter <error27@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] most: fix a memleak in audio_probe_channel
Date: Tue, 23 Jan 2024 01:20:44 +0800
Message-Id: <20240122172044.3840976-1-alexious@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cS_KCgDHBIUBpK5lxVh5AA--.20045S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFyDuFy3uF43XF18CrWUtwb_yoWfuFX_Cw
	4fZrnrXr109ry7Zw13K345CryFkr1j9ryxZw4ktFWaqFW7ua45G34jvrn5JFWUCF12kr92
	y3y5XrZIy342kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbskFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1lc2xSY4AK67AK6r4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjfU1fHUDUUUU
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/

When get_channel fails, audio_probe_channel should free adpt like all
its following error-handling paths after get_channel. Otherwise there
could be a memleak.

Fixes: 15600aea2754 ("staging: most: sound: create one sound card w/ multiple PCM devices per MOST device")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
---
 drivers/most/most_snd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/most/most_snd.c b/drivers/most/most_snd.c
index 45d762804c5e..6cccc9c26796 100644
--- a/drivers/most/most_snd.c
+++ b/drivers/most/most_snd.c
@@ -564,7 +564,8 @@ static int audio_probe_channel(struct most_interface *iface, int channel_id,
 	if (get_channel(iface, channel_id)) {
 		pr_err("channel (%s:%d) is already linked\n",
 		       iface->description, channel_id);
-		return -EEXIST;
+		ret = -EEXIST;
+		goto err_free_adpt;
 	}
 
 	if (cfg->direction == MOST_CH_TX) {
-- 
2.34.1


