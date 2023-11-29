Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14157FD131
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjK2Im5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjK2Imz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:42:55 -0500
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91DE8AF;
        Wed, 29 Nov 2023 00:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=xpJTTKdHjlMBDZ7Oqe
        lLGxQdRARxit/bAj42fJtrMCk=; b=h0sVgehhTNhFRzv849YRR8Xr9gsPP/wulp
        J+H8chFOrVTHNwTrKV52UA4Uy9OAFQ2v91g4+VWSh/BuCUvgp+E8Kd9FxPVg/ltC
        0Rz4+WXuDl6TEuny97NhDrnlH+fLaGx5bABi+6s/QAs5e8I3KnrBx+tQUseLugoN
        aBKayErMM=
Received: from localhost.localdomain (unknown [39.144.190.126])
        by zwqz-smtp-mta-g0-4 (Coremail) with SMTP id _____wAH6_yJ+WZlBfKnAA--.15849S2;
        Wed, 29 Nov 2023 16:42:50 +0800 (CST)
From:   Haoran Liu <liuhaoran14@163.com>
To:     rafael@kernel.org
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] [ACPI] sbshc: Add error handling for acpi_driver_data
Date:   Wed, 29 Nov 2023 00:42:47 -0800
Message-Id: <20231129084247.32443-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wAH6_yJ+WZlBfKnAA--.15849S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr48ur13Aw47tF1fur4rXwb_yoW8Gry8pF
        ZFgry7C3y8Gr47Krn3CFsYvFy5ua1Iv3srKF4xG34fWa1Uury5u3sYya40ya4jkFWxGF4I
        vw1UJFyruF4DZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEPl8UUUUUU=
X-Originating-IP: [39.144.190.126]
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/1tbiZQE3gl8ZaQm27gAAsv
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enhances the acpi_smbus_hc_add and acpi_smbus_hc_remove
functions in drivers/acpi/sbshc.c by adding error handling for the
acpi_driver_data calls. Previously, these functions did not check
the return value of acpi_driver_data, potentially leading to
stability issues if the function failed and returned a null pointer.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
---
 drivers/acpi/sbshc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
index 16f2daaa2c45..1394104d3894 100644
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -267,6 +267,12 @@ static int acpi_smbus_hc_add(struct acpi_device *device)
 	init_waitqueue_head(&hc->wait);
 
 	hc->ec = acpi_driver_data(acpi_dev_parent(device));
+	if (!hc->ec) {
+		pr_err("Failed to retrieve parent ACPI device data\n");
+		kfree(hc);
+		return -ENODEV;
+	}
+
 	hc->offset = (val >> 8) & 0xff;
 	hc->query_bit = val & 0xff;
 	device->driver_data = hc;
@@ -288,6 +294,11 @@ static void acpi_smbus_hc_remove(struct acpi_device *device)
 		return;
 
 	hc = acpi_driver_data(device);
+	if (!hc) {
+		pr_err("Failed to retrieve ACPI SMBus HC data\n");
+		return;
+	}
+
 	acpi_ec_remove_query_handler(hc->ec, hc->query_bit);
 	acpi_os_wait_events_complete();
 	kfree(hc);
-- 
2.17.1

