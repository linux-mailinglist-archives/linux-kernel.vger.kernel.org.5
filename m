Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAAA7D1610
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 21:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjJTTFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 15:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjJTTF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 15:05:29 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11F0D4C
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 12:05:26 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a61f7aaf8so1442629276.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 12:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697828726; x=1698433526; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kK3RwRQ2hFONySy7vb2rlodkP+v8D8sjNHk/2UXCQCw=;
        b=EFIK5Xpz+34ho6bGbNYhtTTAOKRNZBChdY961KgaC3rQm/R9jtB1AvVD9VbDC579IH
         v5hPaBylm71IcYiqZ0IsNY81y1JL5sr8p8XJ2sBt67yQpNdM00Y8ufjUOk0SCqskkQlo
         or63JBl69lQ/jjoADt39FhCSIV4QLoxVCURrUNrM+1E3+G3n0g5AKOaCD4MVEzkHYfx6
         7LhFSQeCc3WnZuAa0KmUIknkrXA4ftNsDH9zJFLAeTcTIsRKYmqm2vE4vo0VPLbqYRdH
         Xmm61BhkknQDCIdqX1MbUafc537intIJnbpYjGejoo6VJSuQhwpkCj+fZKW2lZc4TS8i
         C/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697828726; x=1698433526;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kK3RwRQ2hFONySy7vb2rlodkP+v8D8sjNHk/2UXCQCw=;
        b=c9iHAnir4nXVlenw7H0QAO5n7KPygIiylUJLhS7ogJZ08eIubYRd/aLU7ansYVBTAC
         B8DUTMaOK/4WHmFXOmVNor+a4t5RR3NQ4BvBhDtlYc+H3JZA65v3hnTEpL5Op8kCgvB3
         UwQ6YQff4WXoq4CZNLBsIxMje3FPwPO1O0yqk/nGCTEUx1CZ2h4C3H8BtblMrbcQkOuL
         eCAC9cyWo2P9P3TlR55UiuIUnrB9o5DMoWiA8TAbOtX8RLBmlrZ6TDn7YTjBMi0bWyJS
         2kqOxGtZW69qsk/y3OgG6ZkoR7SXpfmym63fsdOg1mG8gRZvnrsKZz0jOkMfvBrVwfeA
         svYQ==
X-Gm-Message-State: AOJu0YxKDbaaBaGvUjatLUgCK5FfMYPy8fSz5ryPUYdXuqaBQ5SHogFH
        RFYvkL3FiFs7kobZchoUmnHaIQcFdEv67zqWIA==
X-Google-Smtp-Source: AGHT+IFIgFCUI8HjqfIf+Tklc39JbTp6ZaF/+XXlfiROC7bIg7hcKRNqFinXZ9QpU3wT9cqFbgb/bHQiEOBuCbThNA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:d34e:0:b0:d9a:e3d9:99bd with SMTP
 id e75-20020a25d34e000000b00d9ae3d999bdmr52155ybf.5.1697828725873; Fri, 20
 Oct 2023 12:05:25 -0700 (PDT)
Date:   Fri, 20 Oct 2023 19:05:25 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHTPMmUC/x2NUQrCQAwFr1LybWC70kW9iojYbawB2cZE65bSu
 xv8nAfzZgUjZTI4NSsozWw8FYd210B+3MpIyIMzxBD3bYgB7a0ly4KD8kxqKNOXFO0j8lywf8U u1Xp1VUefM/aUjrk7pBApgZ+K0p3rP3i+bNsPsPSlOYAAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697828724; l=2863;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=T9L+60rFiC2C22tjDxmZadYML+C8IPdvUbMCCZ+8ZV8=; b=g+KZD1lwFHNJ1xFiRWb7uqcL0Z5bEAbJH48+DOSAsG+RzN1Fpq+/0v1gC/I3Gh+CXpoyvlGbm
 8FNycQ/9sVEB7z1Ag9/AEX/GrjaQo1VSyvG8K+T824uWpGW7D3fSaty
X-Mailer: b4 0.12.3
Message-ID: <20231020-strncpy-drivers-power-supply-bq256xx_charger-c-v1-1-2fad856124f9@google.com>
Subject: [PATCH] power: supply: bq256xx: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

We expect bq->model_name to be NUL-terminated based on its usage with
sysfs_emit and format strings:

val->strval is assigned to bq->model_name in
bq256xx_get_charger_property():
|       val->strval = bq->model_name;

... then in power_supply_sysfs.c we use value.strval with a format string:
|       ret = sysfs_emit(buf, "%s\n", value.strval);

we assigned value.strval via:
|       ret = power_supply_get_property(psy, psp, &value);
... which invokes psy->desc->get_property():
|       return psy->desc->get_property(psy, psp, val);

with bq256xx_get_charger_property():
|       static const struct power_supply_desc bq256xx_power_supply_desc = {
...
|       	.get_property = bq256xx_get_charger_property,

Moreover, no NUL-padding is required as bq is zero-allocated in
bq256xx_charger.c:
|       bq = devm_kzalloc(dev, sizeof(*bq), GFP_KERNEL);

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Let's also opt to use the more idiomatic strscpy() usage of (dest, src,
sizeof(dest)) as this more closely ties the destination buffer and the
length.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Similar-to: https://lore.kernel.org/all/20231020-strncpy-drivers-power-supply-bq24190_charger-c-v1-1-e896223cb795@google.com/
Similar-to: https://lore.kernel.org/all/20231020-strncpy-drivers-power-supply-bq2515x_charger-c-v1-1-46664c6edf78@google.com/
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/power/supply/bq256xx_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/supply/bq256xx_charger.c
index 82d3cd5ee2f9..85e1185275b9 100644
--- a/drivers/power/supply/bq256xx_charger.c
+++ b/drivers/power/supply/bq256xx_charger.c
@@ -1706,7 +1706,7 @@ static int bq256xx_probe(struct i2c_client *client)
 
 	mutex_init(&bq->lock);
 
-	strncpy(bq->model_name, id->name, I2C_NAME_SIZE);
+	strscpy(bq->model_name, id->name, sizeof(bq->model_name));
 
 	bq->regmap = devm_regmap_init_i2c(client,
 					bq->chip_info->bq256xx_regmap_config);

---
base-commit: bb55d7f7f7445abcc8db50e6a65d4315e79f75c7
change-id: 20231020-strncpy-drivers-power-supply-bq256xx_charger-c-be69c58602e6

Best regards,
--
Justin Stitt <justinstitt@google.com>

