Return-Path: <linux-kernel+bounces-39730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B44883D57E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE67E1C25D11
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEAB64CC9;
	Fri, 26 Jan 2024 07:58:12 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.231.56.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349EB8820;
	Fri, 26 Jan 2024 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.231.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706255892; cv=none; b=uWwFQ+UHxKrICE6YpEFUM8hRN/OJ/suRpPdzxU1E0PYYbSB7WOaFWOLT5lgyDAi2MKpsucoJ0Gds42q8hR59bg/5CXjdJmtlXAIlGcKkJHxQMOoXdZzFjlv9urKaj1UiiwhL8ZWat3HDDi+D2jj6ze5jl4JWnL9fQj2GkeFJSvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706255892; c=relaxed/simple;
	bh=SC15Rb/PFemCDAqfyzo2GcqUMQvpP3E+9WLV00xHdyU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jyKSlZLphiL747Xiwqd+EjaRQEv7pl4wUNgQOSe3WRVLhjsnLPDD3VUCQAR2VW5lEPsuqjCZ/70Em07K2N8d5djC83HLW6tUelSoqdFyzg1VKICu84pp24dOcfcribcoOlzM2cbYdUBTRBafp3nr+ltHtZexI6a/iU008pggZCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=20.231.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from luzhipeng.223.5.5.5 (unknown [39.174.92.167])
	by mail-app2 (Coremail) with SMTP id by_KCgDnKKjuZbNl12bZAA--.20178S2;
	Fri, 26 Jan 2024 15:57:36 +0800 (CST)
From: Zhipeng Lu <alexious@zju.edu.cn>
To: alexious@zju.edu.cn
Cc: Kalle Valo <kvalo@kernel.org>,
	"John W. Linville" <linville@tuxdriver.com>,
	Marcelo Tosatti <marcelo@kvack.org>,
	libertas-dev@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] libertas: fix some memleaks in lbs_allocate_cmd_buffer
Date: Fri, 26 Jan 2024 15:53:34 +0800
Message-Id: <20240126075336.2825608-1-alexious@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:by_KCgDnKKjuZbNl12bZAA--.20178S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF43Zr4kGF18XrW8Cr4Durg_yoW8Gw4fpF
	4Ygr18Cr15Zr4vya9xJaykGas0ga1Fq347Ka1F9w1rur98Ar1Fvr1rWF1xZrsY9FWxJaya
	vrW2yr1UuF1kt3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl
	6s0DM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSfO7UUUU
	U==
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/

In the for statement of lbs_allocate_cmd_buffer, if the allocation of
cmdarray[i].cmdbuf fails, both cmdarray and cmdarray[i].cmdbuf needs to
be freed. Otherwise, there will be memleaks in lbs_allocate_cmd_buffer.

Fixes: 876c9d3aeb98 ("[PATCH] Marvell Libertas 8388 802.11b/g USB driver")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
---
 drivers/net/wireless/marvell/libertas/cmd.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/cmd.c b/drivers/net/wireless/marvell/libertas/cmd.c
index 104d2b6dc9af..5a525da434c2 100644
--- a/drivers/net/wireless/marvell/libertas/cmd.c
+++ b/drivers/net/wireless/marvell/libertas/cmd.c
@@ -1132,7 +1132,7 @@ int lbs_allocate_cmd_buffer(struct lbs_private *priv)
 		if (!cmdarray[i].cmdbuf) {
 			lbs_deb_host("ALLOC_CMD_BUF: ptempvirtualaddr is NULL\n");
 			ret = -1;
-			goto done;
+			goto free_cmd_array;
 		}
 	}
 
@@ -1140,8 +1140,17 @@ int lbs_allocate_cmd_buffer(struct lbs_private *priv)
 		init_waitqueue_head(&cmdarray[i].cmdwait_q);
 		lbs_cleanup_and_insert_cmd(priv, &cmdarray[i]);
 	}
-	ret = 0;
+	return 0;
 
+free_cmd_array:
+	for (i = 0; i < LBS_NUM_CMD_BUFFERS; i++) {
+		if (cmdarray[i].cmdbuf) {
+			kfree(cmdarray[i].cmdbuf);
+			cmdarray[i].cmdbuf = NULL;
+		}
+	}
+	kfree(priv->cmd_array);
+	priv->cmd_array = NULL;
 done:
 	return ret;
 }
-- 
2.34.1


