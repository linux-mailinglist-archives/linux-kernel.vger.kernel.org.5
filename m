Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68817BA233
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjJEPUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbjJEPTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:19:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFD773866
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:45:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E58FD139F;
        Thu,  5 Oct 2023 07:45:49 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B6EE3F641;
        Thu,  5 Oct 2023 07:45:10 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Thu, 05 Oct 2023 15:44:55 +0100
Subject: [PATCH v4 02/17] firmware: arm_ffa: Implement notification bitmap
 create and destroy interfaces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231005-ffa_v1-1_notif-v4-2-cddd3237809c@arm.com>
References: <20231005-ffa_v1-1_notif-v4-0-cddd3237809c@arm.com>
In-Reply-To: <20231005-ffa_v1-1_notif-v4-0-cddd3237809c@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Olivier Deprez <olivier.deprez@arm.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3477; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=uUL2ZAphmbDP68h5pYnBIMj7pjeetUE+/DHcD8KcBDo=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlHsvwJYa5tKnQfZaTKhzLY4WPPK31PNv/mf0ul
 VCCjuqGifWJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZR7L8AAKCRAAQbq8MX7i
 mIqlD/9ZEzkQ5vVuCRL2ahSlui8c006jtP9sHnonqbqj/uQI25nWgyFlpfjkONGVjuCMTyUxRWu
 xPfCEn94+9Nx50JUjhdjNc9lCj3k8PvmC0kPUGwP96/dA4nNBdeYQmENzZNAnTMdDmj42UsCr7D
 /uBP0aJtAoA1lT2tLSqmsRx0ACpfaysMnTu/D+G4ZHuqNhzPXHiW+bE3EJm2lWc+yLY7UttbGGI
 vEUFMRS6Iz3/H5CJeDNSmvB94k6cnvNXEWdQeuL+cVAiiQLnls8iQ2ZLgqVVxjJlwHZ9C1Ol83D
 /voSUdLmKmDyfFcqxQR/VsZGakRzJKhgHgsqNYETj3VcVLBGvbKimPHA/QXXGejKWaRKtdb1M2d
 64QcsZkswWyn0Vfz/Ku/ImS0Bt6teVWNbP6Yt7Edi+whd9/b3AmfUSY6WD3N55nrfD4W6FJwP0b
 EunSKSrbY9qbWhzejMYfZS+vRZnVxLu7/Su1ZJEtVEjPLH+Fcpg2G7ffClOyyRswQtBvL14hXzJ
 R2ca4WEMv1PAzoWFn6gik8c77a9suhCesDI9ubXm4+Y4/uU6mGDTMxalUn0DcDeN/qmha7Dmt5j
 uXreRXJ/pFpNCmG5vwW6+Fn2aGF5i6McW5N6lLQjbzFqbHvq/nKgVAZy+rJdR+cBAMEiZnfN7YO
 m82V4mWUYhJq3mQ==
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
 drivers/firmware/arm_ffa/driver.c | 63 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index a64512388ea5..c2ab6f4cf296 100644
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
@@ -704,6 +736,34 @@ static void ffa_setup_partitions(void)
 	kfree(pbuf);
 }
 
+static int ffa_notifications_setup(void)
+{
+	int ret;
+
+	ret = ffa_features(FFA_NOTIFICATION_BITMAP_CREATE, 0, NULL, NULL);
+	if (ret) {
+		pr_err("Notifications not supported, continuing with it ..\n");
+		return 0;
+	}
+
+	ret = ffa_notification_bitmap_create();
+	if (ret) {
+		pr_err("notification_bitmap_create error %d\n", ret);
+		return ret;
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
@@ -759,7 +819,7 @@ static int __init ffa_init(void)
 
 	ffa_set_up_mem_ops_native_flag();
 
-	return 0;
+	return ffa_notifications_setup();
 free_pages:
 	if (drv_info->tx_buffer)
 		free_pages_exact(drv_info->tx_buffer, RXTX_BUFFER_SIZE);
@@ -774,6 +834,7 @@ subsys_initcall(ffa_init);
 
 static void __exit ffa_exit(void)
 {
+	ffa_notifications_cleanup();
 	ffa_rxtx_unmap(drv_info->vm_id);
 	free_pages_exact(drv_info->tx_buffer, RXTX_BUFFER_SIZE);
 	free_pages_exact(drv_info->rx_buffer, RXTX_BUFFER_SIZE);

-- 
2.42.0

