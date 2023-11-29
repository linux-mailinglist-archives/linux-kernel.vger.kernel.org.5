Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700E27FCFC1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 08:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjK2HPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 02:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjK2HP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 02:15:28 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09F4BBF;
        Tue, 28 Nov 2023 23:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=Eg+ZzyXZk8yqeNmbK6
        JWXWPVhXmFOC2yU/DrurhhVDs=; b=FFRABG8ndd8I5OxwXp1jMr9ZSx22M10Yq7
        nyqLp7S0z1OCr2zCf+TcUwSdAelfEChOQkedrAfRVtAbS5GEFlz+Cc03g99KAjhD
        dcAuceiDr7/KIELR3IyvurYr99aPGkeXD8HkhpMZd4Zy4BeKm5TE9bZrQAhDUWdY
        Qv4LiVO2A=
Received: from localhost.localdomain (unknown [39.144.190.126])
        by zwqz-smtp-mta-g3-2 (Coremail) with SMTP id _____wD3n10F5WZlADXrEA--.37816S2;
        Wed, 29 Nov 2023 15:15:18 +0800 (CST)
From:   Haoran Liu <liuhaoran14@163.com>
To:     rafael@kernel.org
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] [ACPI] fan_core: Add error handling in fan_set_state_acpi4
Date:   Tue, 28 Nov 2023 23:15:14 -0800
Message-Id: <20231129071514.31486-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wD3n10F5WZlADXrEA--.37816S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gry7tFyUKF13XFyfZF1UWrg_yoWftrb_u3
        WkZryxWFn8C3WxKa1IkFZ8ZryIkrnxXFs5uF42qFyfCry8ZryrXr1jvrnF9wnrXws5Crsr
        ta13Ww1IkwnrGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_a9aDUUUUU==
X-Originating-IP: [39.144.190.126]
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/1tbiwgw3glc661WbqgABsY
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_L3,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces error handling for the acpi_driver_data
call within the fan_set_state_acpi4 function in
drivers/acpi/fan_core.c. Previously, the function did not account
for potential null returns from acpi_driver_data, which could
lead to instability if encountered.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
---
 drivers/acpi/fan_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index 9dccbae9e8ea..f2553a47a705 100644
--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -154,6 +154,12 @@ static int fan_set_state_acpi4(struct acpi_device *device, unsigned long state)
 	u64 value = state;
 	int max_state;
 
+	if (!fan) {
+		pr_err("%s: No ACPI fan data "
+			"associated with the device\n", __func__);
+		return -ENODEV;
+	}
+
 	if (fan->fif.fine_grain_ctrl)
 		max_state = 100 / fan->fif.step_size;
 	else
-- 
2.17.1

