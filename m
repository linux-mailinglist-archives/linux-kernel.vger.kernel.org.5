Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6B276F326
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 21:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjHCTCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 15:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjHCTCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 15:02:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA5721734
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 12:02:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74D131474;
        Thu,  3 Aug 2023 12:03:07 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 595B03F6C4;
        Thu,  3 Aug 2023 12:02:23 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Lucian Paul-Trifu <lucian.paul-trifu@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Subject: [PATCH RFT 02/12] firmware: arm_ffa: Implement notification bitmap create and destroy interfaces
Date:   Thu,  3 Aug 2023 20:02:06 +0100
Message-ID: <20230803-ffa_v1-1_notif-v1-2-6613ff2b1f81@arm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803-ffa_v1-1_notif-v1-0-6613ff2b1f81@arm.com>
References: <20230803-ffa_v1-1_notif-v1-0-6613ff2b1f81@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3353; i=sudeep.holla@arm.com; h=from:subject:message-id; bh=LjH8zfz+NSMR+jD4bGN8jL66879DFQjmAd8Zz162PAI=; b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBky/iMaxntS0KpaU2/1R5tA+iKx9/x8ods9t7Ok eCvBJYhoVKJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZMv4jAAKCRAAQbq8MX7i mMsID/9s4LbC/Bg40/xIJACO2aE3Q05WOdrjwdzAzm/gwkN1ioRVW98hKvwa4GdaaG2yPOBr9Gr 6pcRod3atLXK01PwKJE4k/14c1/RmLCCEMuFdjGMK199FvJdMIH9PrgWDjTvNpmn2j50PPjDONE 37t8Mo68WPo56ylte/svzGUiPrmULdojgMG3xdWZgFGCSBo15w+5qEWEPBnN30oH71OpFOJfWT6 +EXhTmAMmgMstzdwOP5nvU8+iTBInCwuuJM91mJGDvE01wJLw2YeKTxsBQkcp61jtLDqxGH8sB7 vGZH+GLbWHXbk3eHiP3hDxyFfwPspTWv+DrRdsp2RfIx6YjQvhH84T9zgiMyHWlfqg7wUWhO0D9 Wi6h68giUNTPgwjuxK4DqLa7vmD2b5PN671/dP8Zy4/xSD8l7t4tTRbUdNYpEWhuW/FBmrgKcYZ WxK9Z7FAOtrHxP5TYqJS8Zzce4Cw7V8hlhwPYnWenOTfdpWDmdTZlQYJEjaSJncxt5z4+Sn6uAe lGzduJ5jdNDzdyJvolC1+2opkY/u4GgMnlQ3/Itr5BQrW0xTgoKajF671RO7zfKtEmbhuCo4NYV JF2quBrCe45ti8nghRLfvrjl4iaEUqHZWAr0VumoGlFY+JOdJ2pP+kVNNab2WHOjAe89h6CBoFi LBm/CFH+
 tIK73Rw==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp; fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/firmware/arm_ffa/driver.c | 58 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 6fc83fa6b81c..022c893c9e06 100644
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
@@ -700,6 +732,29 @@ static void ffa_setup_partitions(void)
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
+	if (drv_info->bitmap_created)
+		ffa_notification_bitmap_destroy();
+}
+
 static int __init ffa_init(void)
 {
 	int ret;
@@ -755,7 +810,7 @@ static int __init ffa_init(void)
 
 	ffa_set_up_mem_ops_native_flag();
 
-	return 0;
+	return ffa_notifications_setup();
 free_pages:
 	if (drv_info->tx_buffer)
 		free_pages_exact(drv_info->tx_buffer, RXTX_BUFFER_SIZE);
@@ -770,6 +825,7 @@ subsys_initcall(ffa_init);
 
 static void __exit ffa_exit(void)
 {
+	ffa_notifications_cleanup();
 	ffa_rxtx_unmap(drv_info->vm_id);
 	free_pages_exact(drv_info->tx_buffer, RXTX_BUFFER_SIZE);
 	free_pages_exact(drv_info->rx_buffer, RXTX_BUFFER_SIZE);

-- 
2.41.0

