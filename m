Return-Path: <linux-kernel+bounces-97166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D83B876657
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360781F212F4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C544F48CC6;
	Fri,  8 Mar 2024 14:26:22 +0000 (UTC)
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5C740865;
	Fri,  8 Mar 2024 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709907982; cv=none; b=JpDLBe68xYvj46QV+cIi4otcGmoBInjvZAPWuFY2AoUZidjtDHkKiQ6TscTH/ry9J+ACxmrLmrlQGS9vPEHFLYRPzRcEotyeK0wTKsjm/uf6jN1N5ByFCn4Z0YASbQVenccaBXY8NBRiStwP6/z27xz3t/6GHcj4zSP38gSHE3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709907982; c=relaxed/simple;
	bh=hBTJt9H7VdDf21FfkUT23Mg6sQ8d8QmQj6IQp938Occ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=sJ8ce2LlEhxK2i/GVj3pF/SEwUAFXmZ8+jPh+pkUDoR7lMyr5fm5Kf8fCy29A4bhtkWX1ehH0l7FpeY1mplgAJqm+Pl1Ioyxx+28wilGbQqx+qrcnaAUzUzJxat2K9skQPJctRw2wmhbru/XzBgRoJQr4GUQ+EFTQqAS/x+/jfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [218.12.19.169])
	by mail-app4 (Coremail) with SMTP id cS_KCgCnzcPlH+tlrFwTAA--.54944S2;
	Fri, 08 Mar 2024 22:25:52 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: yinjun.zhang@corigine.com,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com,
	christophe.jaillet@wanadoo.fr,
	horms@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	louis.peens@corigine.com,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH v2] nfp: flower: handle acti_netdevs allocation failure
Date: Fri,  8 Mar 2024 22:25:40 +0800
Message-Id: <20240308142540.9674-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:cS_KCgCnzcPlH+tlrFwTAA--.54944S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy7Zw4DXFWrXr1fuF48Zwb_yoW8GryfpF
	Z8GFyUZa1kJw13Ka17Jw4xWFyF9a4vqFyUWF1fZws5ur9Yq3WDKrWDKFWUK3W5ArW5G3Wf
	ZrWFv3ZrWF1DG37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwIOAWXrF5cAYAALsr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The kmalloc_array() in nfp_fl_lag_do_work() will return null, if
the physical memory has run out. As a result, if we dereference
the acti_netdevs, the null pointer dereference bugs will happen.

This patch adds a check to judge whether allocation failure occurs.
If it happens, the delayed work will be rescheduled and try again.

Fixes: bb9a8d031140 ("nfp: flower: monitor and offload LAG groups")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
Changes in v2:
  - Remove print warnings on allocation failures.

 drivers/net/ethernet/netronome/nfp/flower/lag_conf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c b/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
index 361d7c495e2..2c7bd6e80d9 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
@@ -337,6 +337,11 @@ static void nfp_fl_lag_do_work(struct work_struct *work)
 
 		acti_netdevs = kmalloc_array(entry->slave_cnt,
 					     sizeof(*acti_netdevs), GFP_KERNEL);
+		if (!acti_netdevs) {
+			schedule_delayed_work(&lag->work,
+					      NFP_FL_LAG_DELAY);
+			continue;
+		}
 
 		/* Include sanity check in the loop. It may be that a bond has
 		 * changed between processing the last notification and the
-- 
2.17.1


