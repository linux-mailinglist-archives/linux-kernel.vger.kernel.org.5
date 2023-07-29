Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215CC767A35
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236928AbjG2AxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbjG2AxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:53:08 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B2D3A94;
        Fri, 28 Jul 2023 17:52:42 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-26837895fc8so1539956a91.0;
        Fri, 28 Jul 2023 17:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690591900; x=1691196700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kEmwUppJ9g7P3H3N3s8Z1q91hqRjAwdzuiQ4B09xoj0=;
        b=OD64285w4UKfHpbN+DM3V6gzSpnafC7xHmbrGbRQPDa8MxDiRBh6+2cYASGNFsHnth
         I74dqfNRHzMOGV+yTlFOeR60D2n9o5Sgd6Xdffo0ZwZtBeQg0Kh53RioKPEMEZTvJhsp
         j3LIfWjIYAexPKT1+lh0PtS9a9HkI9Hbb1QifiHCkJxH8+dbTWavetpNiKtSg5G0JaLt
         FQTnCBJn+ELEZzzcaCd56U/LXqK+Kc7s+Ar5ijc50s6hmLNhdpUrdYMojW87naXBJAAk
         6vpM4ousdTsZ9vQV6/RIvRl/tvqFnfejzLfxkS+r1v42wPyzJ86QH6QoMe1SAsgjSvT9
         2GMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690591900; x=1691196700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kEmwUppJ9g7P3H3N3s8Z1q91hqRjAwdzuiQ4B09xoj0=;
        b=af+ouN8dPaFmE+ZD863oK7f+eAd3WYdMbkFENYDLnPwErR5hAMYCjO0kj9ceZ4JK6t
         DxvPHh+56Vupws2kAIpYPETmv3LPpLehq8zc3gIonmo0pGdYHs3faLEtoAY4OH0e6XVH
         M7vWCealPofeeSEnNqtJPv26e5bqzBAF8UStV41Dshq6GRBQLhXsPO83HXJqrhLzsvNo
         eR8PP6YuvgOb75+I3LxeBmHc2/L3F8XiICj+EbW6gTEjY/2fnaJZTX3g3cXl0p7Gea9D
         Gt5QQ2kHkU6TuN0XZ2g2grN3RuoCTpZUutIfxIaIi7ppYUd7LrmvcLwZ347uCapbQKlK
         SHcg==
X-Gm-Message-State: ABy/qLZOSVHwJEsRJSaEl72TLTrfUJtlxnG3wReyp94t0fYDFZTyN8VG
        KAig7cuBJh/9XZ2mykyu4KR1i+VGmy8=
X-Google-Smtp-Source: APBJJlHFklk1NKaULoJmdWSaTrt6MLg6u9yzF6aB0tIuvuSNUs7nfEchSDrsPMwiqoMm4TQGBZBzqw==
X-Received: by 2002:a17:90a:8905:b0:268:6e77:2024 with SMTP id u5-20020a17090a890500b002686e772024mr2579485pjn.22.1690591899828;
        Fri, 28 Jul 2023 17:51:39 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:bc93:3749:59cc:1d5c])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902704c00b001bb97e51ab4sm4149524plt.98.2023.07.28.17.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 17:51:39 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 04/22] Input: kxtj9 - use device core to create driver-specific device attributes
Date:   Fri, 28 Jul 2023 17:51:13 -0700
Message-ID: <20230729005133.1095051-4-dmitry.torokhov@gmail.com>
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
 drivers/input/misc/kxtj9.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/input/misc/kxtj9.c b/drivers/input/misc/kxtj9.c
index 912e614d039d..d47269b10e9a 100644
--- a/drivers/input/misc/kxtj9.c
+++ b/drivers/input/misc/kxtj9.c
@@ -334,14 +334,25 @@ static ssize_t kxtj9_set_poll(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR(poll, S_IRUGO|S_IWUSR, kxtj9_get_poll, kxtj9_set_poll);
 
-static struct attribute *kxtj9_attributes[] = {
+static struct attribute *kxtj9_attrs[] = {
 	&dev_attr_poll.attr,
 	NULL
 };
 
-static struct attribute_group kxtj9_attribute_group = {
-	.attrs = kxtj9_attributes
+static umode_t kxtj9_attr_is_visible(struct kobject *kobj,
+				     struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct i2c_client *client = to_i2c_client(dev);
+
+	return client->irq ? attr->mode : 0;
+}
+
+static struct attribute_group kxtj9_group = {
+	.attrs = kxtj9_attrs,
+	.is_visible = kxtj9_attr_is_visible,
 };
+__ATTRIBUTE_GROUPS(kxtj9);
 
 static void kxtj9_poll(struct input_dev *input)
 {
@@ -482,13 +493,6 @@ static int kxtj9_probe(struct i2c_client *client)
 			dev_err(&client->dev, "request irq failed: %d\n", err);
 			return err;
 		}
-
-		err = devm_device_add_group(&client->dev,
-					    &kxtj9_attribute_group);
-		if (err) {
-			dev_err(&client->dev, "sysfs create failed: %d\n", err);
-			return err;
-		}
 	}
 
 	return 0;
@@ -535,8 +539,9 @@ MODULE_DEVICE_TABLE(i2c, kxtj9_id);
 
 static struct i2c_driver kxtj9_driver = {
 	.driver = {
-		.name	= NAME,
-		.pm	= pm_sleep_ptr(&kxtj9_pm_ops),
+		.name		= NAME,
+		.dev_groups	= kxtj9_groups,
+		.pm		= pm_sleep_ptr(&kxtj9_pm_ops),
 	},
 	.probe		= kxtj9_probe,
 	.id_table	= kxtj9_id,
-- 
2.41.0.487.g6d72f3e995-goog

