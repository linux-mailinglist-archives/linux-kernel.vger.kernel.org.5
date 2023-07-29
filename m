Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E99767A33
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236694AbjG2AxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjG2AxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:53:08 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B064C18;
        Fri, 28 Jul 2023 17:52:43 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bbc7b2133fso17280535ad.1;
        Fri, 28 Jul 2023 17:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690591900; x=1691196700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OwCo368h8I/PSrTBOGTf7U7WL91FxVTMHVax+dxpNss=;
        b=B7DC46bJ4n/GqAMHWKQ/8twIiwPzTAvJUbvGSyCaVo4NrxGNK8IWfrNJa4Pyb/jJ7a
         5qeW47pROCDP+a1bEZpDLAKja68SUTVuxTsW+8KDPTq1d9cMyUtTBY6zIivtfdWaCXDe
         T1s2VgHJe8npEpp6kvUl7KZsD4bze2s9/h+xbJOpf6MB/PlnINv/y6zA67BeJpTg3OTK
         IiWPS0iT1pOPVxjcMZuRtkgd9qtlEC7Px718rWoxGwyeOpQ/U+eQl4pzj9+vjg0I0KQx
         o6jQX7ElIQsb5Lxt1mhohrMcixJ5+yYnBiJvJZwNtalqOWk1Tc8grS1prNxLRTLgwRTh
         rRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591900; x=1691196700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OwCo368h8I/PSrTBOGTf7U7WL91FxVTMHVax+dxpNss=;
        b=CtJYoZkS1Fe22BjZhpWEr0yyfR5ZwRKRAR+RnbQRYJ01Y28uVnWYkIu/9z51Qf7yYa
         7EfxaCJx0LNzGZbK4wZ/0usIwLFTl9isBtnJNXI7ic2/+p4LgQi4jP0BEor6n2ZASNZK
         4g5gz4LqEHGz7rVQr/nDmLIIODTmnenYYUXbX/CrL02FcRaUMcspUK8PRTlqxTj0C1mB
         K6OO/hdKoNVOnFLahTCHEdJLqztiuZHt1B0hnV91vo479bCTd5uKJuTg0kWqHo03fOMq
         BXICQEpLov1YD9OKWYZudxT+Htm4eREZxAu82hL0uLrWrs+TAD77DS9zhXvleCze9L2Q
         ABbQ==
X-Gm-Message-State: ABy/qLYMnmAQ6sWGwGElqyOCSpg1HDT5+65UFGlukDu8UoFet/9BXTYz
        RUWEf1dlW5Qk28lHnaFkwM0/9YIhdHk=
X-Google-Smtp-Source: APBJJlHnW2ERZB+WxlawIQJUGZYfhZJd4TAfNggGkuKjz8oBrQ+v64kkkGIb/Bw+jkB1EilmtVKdDQ==
X-Received: by 2002:a17:903:32ce:b0:1b6:79e3:636d with SMTP id i14-20020a17090332ce00b001b679e3636dmr3657985plr.58.1690591900609;
        Fri, 28 Jul 2023 17:51:40 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:bc93:3749:59cc:1d5c])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902704c00b001bb97e51ab4sm4149524plt.98.2023.07.28.17.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 17:51:40 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 05/22] Input: ad7877 - use device core to create driver-specific device attributes
Date:   Fri, 28 Jul 2023 17:51:14 -0700
Message-ID: <20230729005133.1095051-5-dmitry.torokhov@gmail.com>
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
 drivers/input/touchscreen/ad7877.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
index edb36d663f22..a0598e9c7aff 100644
--- a/drivers/input/touchscreen/ad7877.c
+++ b/drivers/input/touchscreen/ad7877.c
@@ -612,10 +612,11 @@ static umode_t ad7877_attr_is_visible(struct kobject *kobj,
 	return mode;
 }
 
-static const struct attribute_group ad7877_attr_group = {
+static const struct attribute_group ad7877_group = {
 	.is_visible	= ad7877_attr_is_visible,
 	.attrs		= ad7877_attributes,
 };
+__ATTRIBUTE_GROUPS(ad7877);
 
 static void ad7877_setup_ts_def_msg(struct spi_device *spi, struct ad7877 *ts)
 {
@@ -777,10 +778,6 @@ static int ad7877_probe(struct spi_device *spi)
 		return err;
 	}
 
-	err = devm_device_add_group(&spi->dev, &ad7877_attr_group);
-	if (err)
-		return err;
-
 	err = input_register_device(input_dev);
 	if (err)
 		return err;
@@ -810,8 +807,9 @@ static DEFINE_SIMPLE_DEV_PM_OPS(ad7877_pm, ad7877_suspend, ad7877_resume);
 
 static struct spi_driver ad7877_driver = {
 	.driver = {
-		.name	= "ad7877",
-		.pm	= pm_sleep_ptr(&ad7877_pm),
+		.name		= "ad7877",
+		.dev_groups	= ad7877_groups,
+		.pm		= pm_sleep_ptr(&ad7877_pm),
 	},
 	.probe		= ad7877_probe,
 };
-- 
2.41.0.487.g6d72f3e995-goog

