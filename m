Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03ADB7D4E59
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 12:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbjJXK4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 06:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbjJXK4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 06:56:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A184E5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 03:56:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7D3C1424;
        Tue, 24 Oct 2023 03:57:09 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 165EC3F64C;
        Tue, 24 Oct 2023 03:56:27 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Tue, 24 Oct 2023 11:56:18 +0100
Subject: [PATCH 2/4] firmware: arm_ffa: Setup the partitions after the
 notification initialisation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-ffa-notification-fixes-v1-2-d552c0ec260d@arm.com>
References: <20231024-ffa-notification-fixes-v1-0-d552c0ec260d@arm.com>
In-Reply-To: <20231024-ffa-notification-fixes-v1-0-d552c0ec260d@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1808; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=3aXcRjKfbSWHb8DoeLoTEHJIg2fFmreeDpN2RSMCi4I=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlN6LZLEQG8QC6qdL+oXai0m2YRoseXesNT1eBd
 mkxD38jUYeJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZTei2QAKCRAAQbq8MX7i
 mPcQEACPjeCJeGI2k7cfqoZsiAJxlaLTuatUGBnRApRiAi8yn8g//buZpcNTlVmo+p7ME9hnHJj
 4cnb4hTyW9eG/jmYBI1KIo9kTVwS74GLNZ2JeSMQAunc9O0SVfnfOsMB9mcxh8e8Yenr3/FRD3M
 eiftmxTmBZJy7YXr+PCChncMZOUHIRqJtjWJT3PngbvTgfnXGPZ3USHiqofP3vI7aKhaCP2rQMC
 6pVkhVEb60R8B7BE9BWhdWOCO47NUR26WzY193Tufwnhh7PDmG/PTw3tCWaBw2QfgZnCFUo1glj
 FHsSLsAvkZr338EA7YZ+opkqd4F4m17cQ9LaTrN8zZwkZS0Gv++jLCwzutL6udNvM1bMysQZ5/1
 UaxKdgohtul2Esp+0fqxAZCUjPhR29opNBbVlPpB6VMgJhGH5RxjV9e/GMLp3nmTCHTLHLWRyOI
 523KXa+W8pTCghTikElmQycWj41QyU0JaqwD3r69wrTztdTmHlMPtBZNrmkBq1yLT63n7/TTlIG
 MmyKnmWxd4somSJUWbX7rq9k7mJdJbUrFjENZt1XOgXhRHMWfHF6AunmO2hw2R8K/CIGbZ9E3zG
 d8JSftbzO+j+j1sh4OnB90VTCsM/zsr2nXm/nofJb+CN4gDqgLLOF1nnBJcz3ULWFU62RpGqGaS
 yUaiT867UnQLfmg==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the notifications are setup of the partitions are probed and
FF-A devices are added on the FF-A bus. The FF-A driver probe can be
called even before the FF-A notification setup happens which is wrong
and may result in failure or misbehaviour in the FF-A partition device
probe.

In order to ensure the FF-A notifications are setup before the FF-A
devices are probed, let us move the FF-A partition setup after the
completion of FF-A notification setup.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index b4ba52d674e5..0ab30b571a69 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -1422,11 +1422,7 @@ static void ffa_notifications_setup(void)
 	hash_init(drv_info->notifier_hash);
 	mutex_init(&drv_info->notify_lock);
 
-	/* Register internal scheduling callback */
-	ret = ffa_sched_recv_cb_update(drv_info->vm_id, ffa_self_notif_handle,
-				       drv_info, true);
-	if (!ret)
-		return;
+	return;
 cleanup:
 	pr_info("Notification setup failed %d, not enabled\n", ret);
 	ffa_notifications_cleanup();
@@ -1484,12 +1480,17 @@ static int __init ffa_init(void)
 	mutex_init(&drv_info->rx_lock);
 	mutex_init(&drv_info->tx_lock);
 
-	ffa_setup_partitions();
-
 	ffa_set_up_mem_ops_native_flag();
 
 	ffa_notifications_setup();
 
+	ffa_setup_partitions();
+
+	ret = ffa_sched_recv_cb_update(drv_info->vm_id, ffa_self_notif_handle,
+				       drv_info, true);
+	if (ret)
+		pr_info("Failed to register driver sched callback %d\n", ret);
+
 	return 0;
 free_pages:
 	if (drv_info->tx_buffer)

-- 
2.42.0

