Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A557A69C5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjISRlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbjISRl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:41:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4578E9F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 10:41:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61AB0FEC;
        Tue, 19 Sep 2023 10:41:58 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 164A93F5A1;
        Tue, 19 Sep 2023 10:41:19 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Tue, 19 Sep 2023 18:40:50 +0100
Subject: [PATCH RFT v2 02/18] firmware: arm_ffa: Implement notification
 bitmap create and destroy interfaces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230919-ffa_v1-1_notif-v2-2-6f3a3ca3923c@arm.com>
References: <20230919-ffa_v1-1_notif-v2-0-6f3a3ca3923c@arm.com>
In-Reply-To: <20230919-ffa_v1-1_notif-v2-0-6f3a3ca3923c@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Olivier Deprez <olivier.deprez@arm.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3398; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=j7d2i8CVINs5jyS14TuFWaqZrPCGJMCk2srmUKJvdW8=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlCd06QZn5C9izY1A/eynVtrklx/AVvq3+Tj6Gm
 lvxvS/Euo6JAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZQndOgAKCRAAQbq8MX7i
 mB8yD/9DKYH5p7gWrZcQ7Hfxovms8Cl+ggEC3d7QDvN9WXOOuMXb8RNZfw7KMOY1TuCuAoLBgUJ
 d0q7RmUwdXzN+/Ht6Xu8gxmqbzlLf9AzBvKVAXkdZBiJYQiXWqEmoiwpjrAEjYjgTsegD6hG5D6
 a95TqZeuNg/E9tdDn0FujAq9vwj5p1gEfUwzqJXt1k1FJMisB/0pUP+FO7u3lm4LlraRlC7eHtp
 KpqfnemY3giLyouee15bgPT/6YRetTdy8TGNxc3jMqxvGs0B63/BZQjZ5jh9spnTR6/HSZGVe8V
 z3mJN70EKBW5xQ+oGhVCDV9hGfUQLm5cq5/gq/STBCw25kswPqCa2pRqaCsn0K0rMaJ1byoyCew
 6bctIu0lIaPVCHhZqG0E0vF6wSopHiZeEvUEP8QOHb+gzk5VYgpIKogPxOubW0DfHhsREaS7Q9L
 w5tN9xknIwHf3FFSczYhIaprybxqYfpjsE3dcL2V3Ri2OFTEYLE0A6UyD7yXl4dpTZo4K/wIWap
 /9cRI9k6/Jq7XWqtAa0LuJeTTJOrXmZJG5eaboC5HVqlavS+46/2rVTiFgVtQtCKxRzz6KA9nNe
 KOjCY4Akufdh7B0hA1BBYJ5U5VEcjQzFoNrOLx9I5jjNfm7UuA2oFt4LBYuVUnRxSDv/uimbtU9
 ZK/FHygpJePngQA==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On systems without a hypervisor the responsibility of requesting the
creation of the notification bitmaps in the SPM falls to the FF-A driver.

We use FFA features to determine if the ABI is supported, if it is not
we can assume there is a hypervisor present and will take care of ensure
the relevant notifications bitmaps are created on this partitions behalf.

An endpoint’s notification bitmaps needs to be setup before it configures
its notifications and before other endpoints and partition managers can
start signaling these notifications.

Add interface to create and destroy the notification bitmaps and use the
same to do the necessary setup during the initialisation and cleanup
during the module exit.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 60 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 6fc83fa6b81c..5522523afefe 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -84,6 +84,7 @@ struct ffa_drv_info {
 	void *rx_buffer;
 	void *tx_buffer;
 	bool mem_ops_native;
+	bool bitmap_created;
 };
 
 static struct ffa_drv_info *drv_info;
@@ -543,6 +544,37 @@ static int ffa_features(u32 func_feat_id, u32 input_props,
 	return 0;
 }
 
+static int ffa_notification_bitmap_create(void)
+{
+	ffa_value_t ret;
+	u16 vcpu_count = nr_cpu_ids;
+
+	invoke_ffa_fn((ffa_value_t){
+		      .a0 = FFA_NOTIFICATION_BITMAP_CREATE,
+		      .a1 = drv_info->vm_id, .a2 = vcpu_count,
+		      }, &ret);
+
+	if (ret.a0 == FFA_ERROR)
+		return ffa_to_linux_errno((int)ret.a2);
+
+	return 0;
+}
+
+static int ffa_notification_bitmap_destroy(void)
+{
+	ffa_value_t ret;
+
+	invoke_ffa_fn((ffa_value_t){
+		      .a0 = FFA_NOTIFICATION_BITMAP_DESTROY,
+		      .a1 = drv_info->vm_id,
+		      }, &ret);
+
+	if (ret.a0 == FFA_ERROR)
+		return ffa_to_linux_errno((int)ret.a2);
+
+	return 0;
+}
+
 static void ffa_set_up_mem_ops_native_flag(void)
 {
 	if (!ffa_features(FFA_FN_NATIVE(MEM_LEND), 0, NULL, NULL) ||
@@ -700,6 +732,31 @@ static void ffa_setup_partitions(void)
 	kfree(pbuf);
 }
 
+static int ffa_notifications_setup(void)
+{
+	int ret;
+
+	ret = ffa_features(FFA_NOTIFICATION_BITMAP_CREATE, 0, NULL, NULL);
+	if (!ret) {
+		ret = ffa_notification_bitmap_create();
+		if (ret) {
+			pr_err("notification_bitmap_create error %d\n", ret);
+			return ret;
+		}
+	}
+	drv_info->bitmap_created = true;
+
+	return 0;
+}
+
+static void ffa_notifications_cleanup(void)
+{
+	if (drv_info->bitmap_created) {
+		ffa_notification_bitmap_destroy();
+		drv_info->bitmap_created = false;
+	}
+}
+
 static int __init ffa_init(void)
 {
 	int ret;
@@ -755,7 +812,7 @@ static int __init ffa_init(void)
 
 	ffa_set_up_mem_ops_native_flag();
 
-	return 0;
+	return ffa_notifications_setup();
 free_pages:
 	if (drv_info->tx_buffer)
 		free_pages_exact(drv_info->tx_buffer, RXTX_BUFFER_SIZE);
@@ -770,6 +827,7 @@ subsys_initcall(ffa_init);
 
 static void __exit ffa_exit(void)
 {
+	ffa_notifications_cleanup();
 	ffa_rxtx_unmap(drv_info->vm_id);
 	free_pages_exact(drv_info->tx_buffer, RXTX_BUFFER_SIZE);
 	free_pages_exact(drv_info->rx_buffer, RXTX_BUFFER_SIZE);

-- 
2.42.0

