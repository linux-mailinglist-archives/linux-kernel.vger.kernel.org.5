Return-Path: <linux-kernel+bounces-30883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2DE832576
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1929C1C22AD1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B245DF6C;
	Fri, 19 Jan 2024 08:12:15 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3914FDDA0;
	Fri, 19 Jan 2024 08:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705651934; cv=none; b=sGW+U65fdjGwx3ebwpEBDun+AS5RlOElPm8mff3ku97oq4l0cmUKj1wFwfflWklktP/WTnIK31OBVE40hVz/5SNgrqbN8JZjIw857AWvlgKPdGYDn6RcErifWJbjNGq90pDmfgCufOixYzi1XIN53Gtj8iRzselbSXZuFx/rm3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705651934; c=relaxed/simple;
	bh=guoj+3QJklbr2Xa6Xp4EhL7L/dh04thkR/aQOTW8RFc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rjCF5oE7IvsPMXvWNcc1a1O7EeVg5pEj7PW5pIy2NDOgw2/uT/j9IMrlD6FU68H/N8XCW8VKpRwi3HABAwOqXNWe8BY6JYOUPU1XqWm00NJJH2T3phWYhgKHjPcyIZIvhi1Y3Xjt49TcCg1L+8x8S3SxEN3rwR3COqSbaO4tJbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TGXNZ0F3Qz1S5FN;
	Fri, 19 Jan 2024 16:10:22 +0800 (CST)
Received: from kwepemm600018.china.huawei.com (unknown [7.193.23.140])
	by mail.maildlp.com (Postfix) with ESMTPS id 2ABF71400D6;
	Fri, 19 Jan 2024 16:11:47 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600018.china.huawei.com (7.193.23.140) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Jan 2024 16:11:46 +0800
From: Wenkai Lin <linwenkai6@hisilicon.com>
To: <herbert@gondor.apana.org.au>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<liulongfang@huawei.com>, <fanghao11@huawei.com>, <linwenkai6@hisilicon.com>,
	<acc@openeuler.org>
Subject: [PATCH] crypto: hisilicon - Fix smp_processor_id() warnings
Date: Fri, 19 Jan 2024 16:11:07 +0800
Message-ID: <20240119081107.5306-1-linwenkai6@hisilicon.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600018.china.huawei.com (7.193.23.140)

Switch to raw_smp_processor_id() to prevent a number of
warnings from kernel debugging. We do not care about
preemption here, as the CPU number is only used as a
poor mans load balancing or device selection. If preemption
happens during an encrypt/decrypt operation a small performance
hit will occur but everything will continue to work, so just
ignore it. This commit is similar to e7a9b05ca4
("crypto: cavium - Fix smp_processor_id() warnings").

[ 7538.874350] BUG: using smp_processor_id() in preemptible [00000000] code: af_alg06/8438
[ 7538.874368] caller is debug_smp_processor_id+0x1c/0x28
[ 7538.874373] CPU: 50 PID: 8438 Comm: af_alg06 Kdump: loaded Not tainted 5.10.0.pc+ #18
[ 7538.874377] Call trace:
[ 7538.874387]  dump_backtrace+0x0/0x210
[ 7538.874389]  show_stack+0x2c/0x38
[ 7538.874392]  dump_stack+0x110/0x164
[ 7538.874394]  check_preemption_disabled+0xf4/0x108
[ 7538.874396]  debug_smp_processor_id+0x1c/0x28
[ 7538.874406]  sec_create_qps+0x24/0xe8 [hisi_sec2]
[ 7538.874408]  sec_ctx_base_init+0x20/0x4d8 [hisi_sec2]
[ 7538.874411]  sec_aead_ctx_init+0x68/0x180 [hisi_sec2]
[ 7538.874413]  sec_aead_sha256_ctx_init+0x28/0x38 [hisi_sec2]
[ 7538.874421]  crypto_aead_init_tfm+0x54/0x68
[ 7538.874423]  crypto_create_tfm_node+0x6c/0x110
[ 7538.874424]  crypto_alloc_tfm_node+0x74/0x288
[ 7538.874426]  crypto_alloc_aead+0x40/0x50
[ 7538.874431]  aead_bind+0x50/0xd0
[ 7538.874433]  alg_bind+0x94/0x148
[ 7538.874439]  __sys_bind+0x98/0x118
[ 7538.874441]  __arm64_sys_bind+0x28/0x38
[ 7538.874445]  do_el0_svc+0x88/0x258
[ 7538.874447]  el0_svc+0x1c/0x28
[ 7538.874449]  el0_sync_handler+0x8c/0xb8
[ 7538.874452]  el0_sync+0x148/0x180

Signed-off-by: Wenkai Lin <linwenkai6@hisilicon.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c | 2 +-
 drivers/crypto/hisilicon/sec2/sec_main.c  | 2 +-
 drivers/crypto/hisilicon/zip/zip_main.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 56777099e..340592c6b 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -472,7 +472,7 @@ static inline int hpre_cluster_core_mask(struct hisi_qm *qm)
 
 struct hisi_qp *hpre_create_qp(u8 type)
 {
-	int node = cpu_to_node(smp_processor_id());
+	int node = cpu_to_node(raw_smp_processor_id());
 	struct hisi_qp *qp = NULL;
 	int ret;
 
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 0e56a47eb..eaf3fc6d8 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -373,7 +373,7 @@ void sec_destroy_qps(struct hisi_qp **qps, int qp_num)
 
 struct hisi_qp **sec_create_qps(void)
 {
-	int node = cpu_to_node(smp_processor_id());
+	int node = cpu_to_node(raw_smp_processor_id());
 	u32 ctx_num = ctx_q_num;
 	struct hisi_qp **qps;
 	int ret;
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index db4c964cd..9e35d6432 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -401,7 +401,7 @@ MODULE_DEVICE_TABLE(pci, hisi_zip_dev_ids);
 int zip_create_qps(struct hisi_qp **qps, int qp_num, int node)
 {
 	if (node == NUMA_NO_NODE)
-		node = cpu_to_node(smp_processor_id());
+		node = cpu_to_node(raw_smp_processor_id());
 
 	return hisi_qm_alloc_qps_node(&zip_devices, qp_num, 0, node, qps);
 }
-- 
2.30.0


