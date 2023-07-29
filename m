Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FC9767A49
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbjG2Axm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbjG2AxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:53:13 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8853C34;
        Fri, 28 Jul 2023 17:52:49 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b9c368f4b5so24837005ad.0;
        Fri, 28 Jul 2023 17:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690591904; x=1691196704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W11bDslsZDrGr3Qeuq0bXM64dJbwpUwMR1R8xbGg1gA=;
        b=dE7GU2Tco7wDRgQMqoVcBsaSAYvDFi8voSDX0grkGsEhJFBiAKcddbWd080zPj7LGQ
         uFJHVrHiG7bpJkhPgdXChnkkhcdF32zGGQZjwH4boBlm07P0qKoe01gXih2i95CcOyWC
         PQ6R2K4ZbCfNigBCuqN6x8kNAcd9m5rlYzoosjJeMDzu9/PszIEExyw1p5kh1l6+Cdbw
         a5Ju6nXKqvyv/8qjo3osFuaauLsssKqXFPpLDpBe276wSx6rpWgJ0iAgX6wLTb2ePHM4
         BFS2ARbioLhzoA1eVBOba4USgd3XmkDph03K+EgYenp26xitd8y2w9BzbKNeyWUdh10b
         W57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591904; x=1691196704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W11bDslsZDrGr3Qeuq0bXM64dJbwpUwMR1R8xbGg1gA=;
        b=aUZuCytLzDljLxodBX7hUT7lTOqzZLPgxuiFVrxGrkw8wG8xUdqVkv3isrTSTNXC/I
         WG5HAZABFSDvvjxsDKtEW9R4Ybx971qA4cU82echNWUnXO11CIQc/daxUuOHL22fj03Y
         P+V6qTxIbpmphXIsbTAQhaZZbs2PLxO5pmV6P7e8Ov4hlwVPCLtKBVYWNIGMZ3sxhdK1
         wym5701l9TFHsUxC5TOohD8cis2jF+e9dRSFEmw6hIpwXqhxZfiKD0NXxPF2W/ZwSUEl
         NjWnmLXQSe3YuGLEGB7MRYKk6KlbSicwchfVN0KqQpNpOC6vz/Ljc6BpXVuSlKl/0cmf
         x4zg==
X-Gm-Message-State: ABy/qLZd8AM/vJBLaA0K8n3c1MyHiBz7BA1ptm3rl45V2mY7CJqRh0Lw
        iQC0BJfAaAmkTGXqRVyOBkIYYlKkyQg=
X-Google-Smtp-Source: APBJJlFVJ6yvCHCmXe5sBsywuZZ6X1oIYSnYpGMv9CPAGq+Hc8sTqLc+MWoqmJicmVZiVUXnmQ32GA==
X-Received: by 2002:a17:903:186:b0:1bb:9efe:b1be with SMTP id z6-20020a170903018600b001bb9efeb1bemr4148861plg.30.1690591904392;
        Fri, 28 Jul 2023 17:51:44 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:bc93:3749:59cc:1d5c])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902704c00b001bb97e51ab4sm4149524plt.98.2023.07.28.17.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 17:51:44 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 10/22] Input: exc3000 - use device core to create driver-specific device attributes
Date:   Fri, 28 Jul 2023 17:51:19 -0700
Message-ID: <20230729005133.1095051-10-dmitry.torokhov@gmail.com>
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
 drivers/input/touchscreen/exc3000.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/input/touchscreen/exc3000.c b/drivers/input/touchscreen/exc3000.c
index 4c0d99aae9e0..a4030cc9ff60 100644
--- a/drivers/input/touchscreen/exc3000.c
+++ b/drivers/input/touchscreen/exc3000.c
@@ -325,16 +325,13 @@ static ssize_t type_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(type);
 
-static struct attribute *sysfs_attrs[] = {
+static struct attribute *exc3000_attrs[] = {
 	&dev_attr_fw_version.attr,
 	&dev_attr_model.attr,
 	&dev_attr_type.attr,
 	NULL
 };
-
-static struct attribute_group exc3000_attribute_group = {
-	.attrs = sysfs_attrs
-};
+ATTRIBUTE_GROUPS(exc3000);
 
 static int exc3000_probe(struct i2c_client *client)
 {
@@ -437,10 +434,6 @@ static int exc3000_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, data);
 
-	error = devm_device_add_group(&client->dev, &exc3000_attribute_group);
-	if (error)
-		return error;
-
 	return 0;
 }
 
@@ -473,6 +466,7 @@ MODULE_DEVICE_TABLE(acpi, exc3000_acpi_match);
 static struct i2c_driver exc3000_driver = {
 	.driver = {
 		.name	= "exc3000",
+		.dev_groups = exc3000_groups,
 		.of_match_table = of_match_ptr(exc3000_of_match),
 		.acpi_match_table = ACPI_PTR(exc3000_acpi_match),
 	},
-- 
2.41.0.487.g6d72f3e995-goog

