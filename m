Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F20767A40
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbjG2Axu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236889AbjG2AxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:53:15 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DFC3AB4;
        Fri, 28 Jul 2023 17:52:52 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b8ad8383faso22173165ad.0;
        Fri, 28 Jul 2023 17:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690591905; x=1691196705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xavxab7fE6BTORYI6YBoGvd5tEdjUx93KODPnqkxvR0=;
        b=i8rRuaznTbxKDT8qIjwW6J6o2OwYbtcbaMZ74rUyPVoo2qR7fy0/0GCB+dWxaIXqjH
         DB3YIfICmbglL0sDGqIBfhiNjmL12ZIit+vHF3Icxdb8kk1U45MhNkg5ohb/z43jwxTD
         OXFgJBOjQEQLsGE+VZ50tnWPnASCOQjMh+GmxW02SK9UtRSzxB+ACytTonlAxUrU7azt
         IDIYGsvSM548cfC7WW8OSvYx1Z3m+RAIQiPFOGkai3piCHvDC7Y4vCUvjVcyFbJm4ybn
         GgEeHrKDXTdEoKiaHBgmuZKeN45ZtsDDox7BJ+NgHDy+gYMBj/uXyKeBvGmft5iH4e+f
         C5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591905; x=1691196705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xavxab7fE6BTORYI6YBoGvd5tEdjUx93KODPnqkxvR0=;
        b=RsqYngpNMsx7D7VAQi8ZDjDNaD/KB96IXNx/0efqgNAhO7ChDv+dWEIbhDxnk3doYB
         AXJAvqKSXIesGIsEi6aF9phThsjM5BgUGzTzyi8MpNKDkGatP/UkurxfZiPoDBdFQVOe
         VhhkNE+3yrYnVF2Y4W/g57cqTfhpOiD7c2fgiRXNHF8fdlgOSzVm6rMhNImgSm/XLRr3
         mlsd0gJqqK232fsRyotpm5jhOOQLwvQCGfR842FqZxKVNQ//I/8Bmnm4j66KM8umqUxG
         JmgYeCmeNz/gCNBw2DOzCTPaokdZ8HCp5oao2QwNseO4C1xkFjR7Lyug075gUpy9crMz
         3qpQ==
X-Gm-Message-State: ABy/qLbD6zt/EusBJmCKPhf2OMlgtQemElAoBzokvGdo11Yn2Gqw5Nic
        8OM2f5bu3PhWo6sWaqNWLtvKpMLHMFg=
X-Google-Smtp-Source: APBJJlEID0Ip0DtR27FJA+cMBJgZJvVSNknZqau26FLSTVwBNoZ9PsJTDQJR2UqOKVq+Gj4UIvR0Dg==
X-Received: by 2002:a17:902:c3c1:b0:1bb:d586:d2a5 with SMTP id j1-20020a170902c3c100b001bbd586d2a5mr3191815plj.45.1690591905124;
        Fri, 28 Jul 2023 17:51:45 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:bc93:3749:59cc:1d5c])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902704c00b001bb97e51ab4sm4149524plt.98.2023.07.28.17.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 17:51:44 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 11/22] Input: hideep - use device core to create driver-specific device attributes
Date:   Fri, 28 Jul 2023 17:51:20 -0700
Message-ID: <20230729005133.1095051-11-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230729005133.1095051-1-dmitry.torokhov@gmail.com>
References: <20230729005133.1095051-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of creating driver-specific device attributes with
devm_device_add_group() have device core do this by setting up dev_groups
pointer in the driver structure.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/hideep.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/input/touchscreen/hideep.c b/drivers/input/touchscreen/hideep.c
index 404153338df7..0f58258306bf 100644
--- a/drivers/input/touchscreen/hideep.c
+++ b/drivers/input/touchscreen/hideep.c
@@ -954,16 +954,13 @@ static DEVICE_ATTR(version, 0664, hideep_fw_version_show, NULL);
 static DEVICE_ATTR(product_id, 0664, hideep_product_id_show, NULL);
 static DEVICE_ATTR(update_fw, 0664, NULL, hideep_update_fw);
 
-static struct attribute *hideep_ts_sysfs_entries[] = {
+static struct attribute *hideep_ts_attrs[] = {
 	&dev_attr_version.attr,
 	&dev_attr_product_id.attr,
 	&dev_attr_update_fw.attr,
 	NULL,
 };
-
-static const struct attribute_group hideep_ts_attr_group = {
-	.attrs = hideep_ts_sysfs_entries,
-};
+ATTRIBUTE_GROUPS(hideep_ts);
 
 static void hideep_set_work_mode(struct hideep_ts *ts)
 {
@@ -1096,13 +1093,6 @@ static int hideep_probe(struct i2c_client *client)
 		return error;
 	}
 
-	error = devm_device_add_group(&client->dev, &hideep_ts_attr_group);
-	if (error) {
-		dev_err(&client->dev,
-			"failed to add sysfs attributes: %d\n", error);
-		return error;
-	}
-
 	return 0;
 }
 
@@ -1131,6 +1121,7 @@ MODULE_DEVICE_TABLE(of, hideep_match_table);
 static struct i2c_driver hideep_driver = {
 	.driver = {
 		.name			= HIDEEP_I2C_NAME,
+		.dev_groups		= hideep_ts_groups,
 		.of_match_table		= of_match_ptr(hideep_match_table),
 		.acpi_match_table	= ACPI_PTR(hideep_acpi_id),
 		.pm			= pm_sleep_ptr(&hideep_pm_ops),
-- 
2.41.0.487.g6d72f3e995-goog

