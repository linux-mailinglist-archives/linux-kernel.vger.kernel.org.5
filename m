Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894397FD06C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjK2IOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjK2IOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:14:09 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42E811735;
        Wed, 29 Nov 2023 00:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=9p8e0KY2P60TNVeST4
        fjoopvIyST862pP3T8NJI8fMA=; b=eaodECY4Mt7e77h+Zo94XNCN7+q6VqF0ci
        SRONFmPvJg2zqOZwFztTQVlSGtdiwp8TqZaVjympV7Lsp91xGUeybJeOWDA9OZ0g
        tpXopoMmpxODZXx482ufhh3s+eGm78HE9tcb1hMshY1+ssDA28rEwzL4kA15YU1r
        c/zCoapTY=
Received: from localhost.localdomain (unknown [39.144.190.126])
        by zwqz-smtp-mta-g3-2 (Coremail) with SMTP id _____wD3H0zE8mZln_DuEA--.38488S2;
        Wed, 29 Nov 2023 16:13:57 +0800 (CST)
From:   Haoran Liu <liuhaoran14@163.com>
To:     rafael@kernel.org
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] [ACPI] fan_core: Add error handling for acpi_driver_data
Date:   Wed, 29 Nov 2023 00:13:55 -0800
Message-Id: <20231129081355.32317-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wD3H0zE8mZln_DuEA--.38488S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur4kAFyxCF13Zw18GFWxJFb_yoW8XF4UpF
        W3KFy5ArWqgr47Ww4UCa1rZFW3X3Z5Z34I9FWkA345Wa15Kr98uFyxGa4jv34YyF4xKan2
        vrykJFyDCF1DZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEBTYUUUUUU=
X-Originating-IP: [39.144.190.126]
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/xtbBcgQ3gletj45lSAAAsV
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces error handling for the acpi_driver_data call
in function acpi_fan_get_fif and acpi_fan_get_fps, within
drivers/acpi/fan_core.c. Previously, there was no check for a null
return from acpi_driver_data, which could lead to potential
instability in scenarios where acpi_driver_data fails.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
---
 drivers/acpi/fan_core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index 9dccbae9e8ea..f3228fb9c90f 100644
--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -215,6 +215,13 @@ static int acpi_fan_get_fif(struct acpi_device *device)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct acpi_fan *fan = acpi_driver_data(device);
+
+	if (!fan) {
+		dev_err(&device->dev, "No ACPI fan data associated "
+			"with the device\n");
+		return -EINVAL;
+	}
+
 	struct acpi_buffer format = { sizeof("NNNN"), "NNNN" };
 	u64 fields[4];
 	struct acpi_buffer fif = { sizeof(fields), fields };
@@ -265,6 +272,12 @@ static int acpi_fan_speed_cmp(const void *a, const void *b)
 static int acpi_fan_get_fps(struct acpi_device *device)
 {
 	struct acpi_fan *fan = acpi_driver_data(device);
+
+	if (!fan) {
+		dev_err(&device->dev, "Failed to retrieve ACPI fan data\n");
+		return -ENODEV;
+	}
+
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *obj;
 	acpi_status status;
-- 
2.17.1

