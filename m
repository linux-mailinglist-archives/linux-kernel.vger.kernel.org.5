Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEA4771BDA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 09:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjHGHwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 03:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjHGHwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 03:52:00 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70871708
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 00:51:52 -0700 (PDT)
Received: from kwepemi500009.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RK7k62zMtz1Z1Yq;
        Mon,  7 Aug 2023 15:49:02 +0800 (CST)
Received: from huawei.com (10.67.175.85) by kwepemi500009.china.huawei.com
 (7.221.188.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 15:51:49 +0800
From:   Xia Fukun <xiafukun@huawei.com>
To:     <peter.ujfalusi@linux.intel.com>, <broonie@kernel.org>,
        <pierre-louis.bossart@linux.intel.com>,
        <ranjani.sridharan@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>, <cujomalainey@chromium.org>,
        <noah.klayman@intel.com>, <daniel.baluta@nxp.com>,
        <rander.wang@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <xiafukun@huawei.com>
Subject: [PATCH] ASoC: SOF: Fix incorrect use of sizeof in sof_ipc3_do_rx_work()
Date:   Mon, 7 Aug 2023 15:51:18 +0800
Message-ID: <20230807075118.128122-1-xiafukun@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.85]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500009.china.huawei.com (7.221.188.199)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here hdr is a pointer, and we should measure the size of
struct sof_ipc_cmd_hdr.

Fixes: 12c41c779fad ("ASoC: SOF: Refactor rx function for fuzzing")
Signed-off-by: Xia Fukun <xiafukun@huawei.com>
---
 sound/soc/sof/ipc3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/ipc3.c b/sound/soc/sof/ipc3.c
index 2c5aac31e8b0..580960ff273d 100644
--- a/sound/soc/sof/ipc3.c
+++ b/sound/soc/sof/ipc3.c
@@ -1001,7 +1001,7 @@ void sof_ipc3_do_rx_work(struct snd_sof_dev *sdev, struct sof_ipc_cmd_hdr *hdr,
 
 	ipc3_log_header(sdev->dev, "ipc rx", hdr->cmd);
 
-	if (hdr->size < sizeof(hdr) || hdr->size > SOF_IPC_MSG_MAX_SIZE) {
+	if (hdr->size < sizeof(*hdr) || hdr->size > SOF_IPC_MSG_MAX_SIZE) {
 		dev_err(sdev->dev, "The received message size is invalid: %u\n",
 			hdr->size);
 		return;
-- 
2.17.1

