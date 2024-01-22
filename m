Return-Path: <linux-kernel+bounces-33766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F1F836E53
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F6381F28B10
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209FC5EE9E;
	Mon, 22 Jan 2024 17:16:48 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.231.56.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEDC4D592;
	Mon, 22 Jan 2024 17:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.231.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705943807; cv=none; b=hqZK8GaYmK1udIBWBqQOv6thZ0anipOdxn6G7G918K0dca2tNgnImdvQ5PiJi09upqAK0kh/R7WTK8ZPyjPeqXBzLr6L3K9P+ZRJVQaEHfbG7GQ33Wheljx7SYYWfNB7TUxGthu+5HXX/zFhb6YITEkDfEpMklb4k8tZjc4e0yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705943807; c=relaxed/simple;
	bh=J+CE1fjgXdIrGGtCeeEtcrHP/hpRi/SonczTZdsbyEc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VFn0r/Nn0ag0byiKd8NzxS61MxKbTvD/gq+eNPxq/8FlXb++jkFD0J34tr7zDXKsozTWXmvuMHhwhYJCfvF2v8mv6VuLV1a131h30fw/IInZP2GbEP17KZNG99hE4wT8a8N6dKcMhzjCBi4EuWTUySErXFUPbT5k5lG/Y+NoOBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=20.231.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from luzhipeng.223.5.5.5 (unknown [39.174.92.167])
	by mail-app4 (Coremail) with SMTP id cS_KCgCHhYXsoq5lm0x5AA--.18549S2;
	Tue, 23 Jan 2024 01:16:29 +0800 (CST)
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
Subject: [PATCH] [v2] scsi: megaraid_sas: Fix a memleak in megasas_init_fw
Date: Tue, 23 Jan 2024 01:16:10 +0800
Message-Id: <20240122171610.3840351-1-alexious@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cS_KCgCHhYXsoq5lm0x5AA--.18549S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFyfZr4Dur1xCFyUXrWxCrg_yoW5JF15pr
	yruw13tr17AayxWrWqkw4F93yYyw48G3s8Kr18J34j93Wagr15XF4vgrW7GF97CFZ5JF9x
	Zr4Yqr1fCF4UKaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/

In the error-handling paths after allocation of
fusion->stream_detect_by_ld and fusion->stream_detect_by_ld[i],
megasas_init_fw should free them or there would be memleaks.

Fixes: 2e47e4e62e40 ("scsi: megaraid_sas: Fail init if heartbeat timer fails")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
---
Changelog:

v2: remove the unused variable j.
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 3d4f13da1ae8..a7d3c51fc17b 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -6016,7 +6016,7 @@ static int megasas_init_fw(struct megasas_instance *instance)
 	void *base_addr_phys;
 	struct megasas_ctrl_info *ctrl_info = NULL;
 	unsigned long bar_list;
-	int i, j, loop;
+	int i, loop;
 	struct IOV_111 *iovPtr;
 	struct fusion_context *fusion;
 	bool intr_coalescing;
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


