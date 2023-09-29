Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2C97B363E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbjI2PDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbjI2PDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:03:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BAE55F7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:03:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 794261007;
        Fri, 29 Sep 2023 08:03:55 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 226643F5A1;
        Fri, 29 Sep 2023 08:03:16 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Fri, 29 Sep 2023 16:02:51 +0100
Subject: [PATCH v3 02/17] firmware: arm_ffa: Implement notification bitmap
 create and destroy interfaces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230929-ffa_v1-1_notif-v3-2-c8e4f15190c8@arm.com>
References: <20230929-ffa_v1-1_notif-v3-0-c8e4f15190c8@arm.com>
In-Reply-To: <20230929-ffa_v1-1_notif-v3-0-c8e4f15190c8@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Olivier Deprez <olivier.deprez@arm.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3398; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=E8dkL+QG2QXGEwg80l0faZM6cA032hi2OPI14UW5ukU=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlFucuvBBiLwRwI+A6SBHoF7BhodlY60hl2wjwZ
 SYQKjnfHqqJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZRbnLgAKCRAAQbq8MX7i
 mFOQEAC1qH09c9WVdsH6CsUdBdw3pCM0Gbn2kvv/5BJyJEKhaSlahsvCohQGLVkTiinsRzlQN/G
 AcbwPbb9tZ6+AvWDnxeUa+YLz+hjT8PgQuLziXUmrqyngPU8IivU3ENKLnHIjjyI68E+q1hEddD
 Svfmo57KwmzLDn6fbf4BlyL2rF2KDR+VamNUuLOUp2dCgn9nMoQ/1bchDcxwLK2OiYyAiTqI+Fs
 tSCdY/pzUJXye/nnv5FK+H++Y9Xv2Ji4lmCTPDKTunmMpVRu2xlG5JClEVE5XfLjLwCsvkGiEF5
 me4K9Kg3IIoENEpbOV18LLSJN7BcY/LU6DKfhqvH5jhRHx0rbm7lkhikTDwFCR1Gwdy8IJ6VgHn
 o40WyqaKv6EorKh4e+DFuAGDp6d/XpyS5OTVGE7HDWlucYNIAl61NZrm3KEmrjFekJhyhgRIeo8
 q9cX4JCiLvfKxuMCzChS7AuDsBBqxqKxl01wFXBzKAV+xFIySKgSlLRmnLbelzFtlE6b//SigsB
 jaXxpvQwwDP9iNWBomOpWr6CDOJfb3VfumDdG7+ZWp25wXMhkgNy/gTVs4KlvT6o/EWJIexGdNy
 5CeJ3/a3wfsW/0u+goWAFd7k+lebdnG7HsvrJLbCXR3eyzJLSTHfT3QwXPqQRyKuLB4pns2+euD
 4XFwj2kKBd17Y+w==
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
index 2b24cda2a185..efa4e7fb15e3 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -84,6 +84,7 @@ struct ffa_drv_info {
 	void *rx_buffer;
 	void *tx_buffer;
 	bool mem_ops_native;
+	bool bitmap_created;
 };
 
 static struct ffa_drv_info *drv_info;
@@ -555,6 +556,37 @@ static int ffa_features(u32 func_feat_id, u32 input_props,
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
@@ -712,6 +744,31 @@ static void ffa_setup_partitions(void)
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
@@ -767,7 +824,7 @@ static int __init ffa_init(void)
 
 	ffa_set_up_mem_ops_native_flag();
 
-	return 0;
+	return ffa_notifications_setup();
 free_pages:
 	if (drv_info->tx_buffer)
 		free_pages_exact(drv_info->tx_buffer, RXTX_BUFFER_SIZE);
@@ -782,6 +839,7 @@ subsys_initcall(ffa_init);
 
 static void __exit ffa_exit(void)
 {
+	ffa_notifications_cleanup();
 	ffa_rxtx_unmap(drv_info->vm_id);
 	free_pages_exact(drv_info->tx_buffer, RXTX_BUFFER_SIZE);
 	free_pages_exact(drv_info->rx_buffer, RXTX_BUFFER_SIZE);

-- 
2.42.0

