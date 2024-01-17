Return-Path: <linux-kernel+bounces-28637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D71830129
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E95A287E39
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3659125AB;
	Wed, 17 Jan 2024 08:19:01 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.231.56.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02572CA73;
	Wed, 17 Jan 2024 08:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.231.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705479541; cv=none; b=GNfC3IRQsilu77N2d7+8QXsfbxmcdKQViURx5yq3Mj+a0JFGLD2rIs3PiDiSiSkI+KAoAD7f5XL8fSpwp+Fu1zVCBEyz9DDFJvSOfjw9KHhsMy32WyqLM2XXur+mxYlva0wlfzGvewl1By1QMoWMB4/IkqzgXWRcTJWtLI5Z7SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705479541; c=relaxed/simple;
	bh=YOzCraFGvw1PLY77Yxo76qhKtpwqmc8DWbhhZXYpDYE=;
	h=Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo; b=Og5x1Nx4nx42B6R5TWAo0ebNdAr4tJKK4qSKZy05Cy3QF0Li2Sf3TZuQwV1AVMj17U2QXlO2xqSE7yRG24P7m6kdI0ijKCFCdOuCPJMHV+czXQgknyVQ8+8m+Cr8prtm+Ue9evN5uKcgN2dAf6xcrJoHZ666pmY6QgmGm5CT53g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=20.231.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from luzhipeng.223.5.5.5 (unknown [183.159.170.227])
	by mail-app4 (Coremail) with SMTP id cS_KCgCHo4IyjKdlfk0uAA--.42394S2;
	Wed, 17 Jan 2024 16:13:38 +0800 (CST)
From: Zhipeng Lu <alexious@zju.edu.cn>
To: alexious@zju.edu.cn
Cc: Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	Chandrakanth patil <chandrakanth.patil@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	megaraidlinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: megaraid_sas: Fix a memleak in megasas_init_fw
Date: Wed, 17 Jan 2024 16:13:13 +0800
Message-Id: <20240117081314.3818871-1-alexious@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cS_KCgCHo4IyjKdlfk0uAA--.42394S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFyfZr4Dur1xCr1xGFW5Awb_yoW8uF4Upr
	yruw13tr17AayfWrWDKw4F9ayjya18G345Kr18t34j934agry5XF4vgrWxGFn7CF95JF9x
	Zrn8Xr1fCF4jgaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUObyZUUUUU
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/

In the error-handling paths after allocation of
fusion->stream_detect_by_ld and fusion->stream_detect_by_ld[i],
megasas_init_fw should free them or there would be memleaks.

Fixes: 2e47e4e62e40 ("scsi: megaraid_sas: Fail init if heartbeat timer fails")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 3d4f13da1ae8..046d7c880be6 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -6378,11 +6378,7 @@ static int megasas_init_fw(struct megasas_instance *instance)
 			if (!fusion->stream_detect_by_ld[i]) {
 				dev_err(&instance->pdev->dev,
 					"unable to allocate stream detect by LD\n ");
-				for (j = 0; j < i; ++j)
-					kfree(fusion->stream_detect_by_ld[j]);
-				kfree(fusion->stream_detect_by_ld);
-				fusion->stream_detect_by_ld = NULL;
-				goto fail_get_ld_pd_list;
+				goto fail_alloc_stream_detect;
 			}
 			fusion->stream_detect_by_ld[i]->mru_bit_map
 				= MR_STREAM_BITMAP;
@@ -6502,7 +6498,7 @@ static int megasas_init_fw(struct megasas_instance *instance)
 			megasas_start_timer(instance);
 		} else {
 			instance->skip_heartbeat_timer_del = 1;
-			goto fail_get_ld_pd_list;
+			goto fail_alloc_stream_detect;
 		}
 	}
 
@@ -6520,6 +6516,13 @@ static int megasas_init_fw(struct megasas_instance *instance)
 fail_start_watchdog:
 	if (instance->requestorId && !instance->skip_heartbeat_timer_del)
 		del_timer_sync(&instance->sriov_heartbeat_timer);
+fail_alloc_stream_detect:
+	if (instance->adapter_type >= VENTURA_SERIES) {
+		for (i = 0; i < MAX_LOGICAL_DRIVES_EXT; ++i)
+			kfree(fusion->stream_detect_by_ld[i]);
+		kfree(fusion->stream_detect_by_ld);
+		fusion->stream_detect_by_ld = NULL;
+	}
 fail_get_ld_pd_list:
 	instance->instancet->disable_intr(instance);
 	megasas_destroy_irqs(instance);
-- 
2.34.1


