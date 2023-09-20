Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C307A8B35
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 20:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjITSJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 14:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjITSJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:09:19 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DD2D6;
        Wed, 20 Sep 2023 11:09:14 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-274b01849c4so11531a91.3;
        Wed, 20 Sep 2023 11:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695233353; x=1695838153; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B/lu8BcHJ/ysOPQIAbugBzzumndKD9GUIWEsPV6mHQU=;
        b=ATLStUVarJQARDf6LuL8kZwydKTbXAQ/6pcLEDT6yWMNTYVEZAbSuvl+NcGXPh/Vhp
         EmyweuFZXm9EC2M8uc/0aqzwLWxNL7UpgW/QgpgePqy+oHTtRIkn5+ZiPi0d9W0bkZ+m
         jQD/11Yv3UeXNmsy6gh332yjYvX8OSOjgEBDVqVvvWq9phGC1gtYsMSiEW441P9AW+/T
         g/twWg3sdks6xOMMMh8+HFdJPRMa3ptxor9mCfFTx0Pq8vwgKCVpg+zyfq4gZwO1olw0
         prjXtJr5kVMMKeOevSLOQqOdz4cVQktcDk5J6oVmBAEzz3qQXMIW9h3imbl4hqkwazHJ
         IgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695233353; x=1695838153;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B/lu8BcHJ/ysOPQIAbugBzzumndKD9GUIWEsPV6mHQU=;
        b=CMnzmgpuJx1oX1LooHioviSyNvbWCwXVKQbcEf3VumK2LyaOWSgibbaDwYB4TEUFmH
         h+SDeQ8CFDUYg0116uVVYTmCjSmYLRftDjyAOM/3igtSlMzO+CBUjVUNtNie7DDYuupT
         IrkOyX1UIC3JeM/mR8tBbqjJ7pBMMIMoPbE2OKmlhPi8JKz/lEIO2jeEnN+DjxdTJwvL
         k0AyEiHJkSI0ARlMS8MYRYPAsyItLATnk28+uNu/u8jmDad6YIeqXSE1N3DtJT/7eonS
         TyBLgjFi2ev8EF+IiGM3nVuauizFQTu0A7s9S+l336cgvIUt0XQUXGQ9pkAf6HMSqPaD
         9gKg==
X-Gm-Message-State: AOJu0Ywjl5m5eQfrZsissj4JiRq+qbTwGdgD7cRl1LAs3s149UpYMdA+
        JRvs4kWoeTn+5gM3SyZudCY=
X-Google-Smtp-Source: AGHT+IEKT/IAOFUythlW5W88vJzTtnhHbWBqSiKa/tGntWajo2/y1nIo13iyVVq8GgAC4g2BIhItCg==
X-Received: by 2002:a17:90a:3ec6:b0:268:29cf:3231 with SMTP id k64-20020a17090a3ec600b0026829cf3231mr3278194pjc.3.1695233353165;
        Wed, 20 Sep 2023 11:09:13 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:3073:3a17:4a3d:2738])
        by smtp.gmail.com with ESMTPSA id v13-20020a17090ac90d00b002639c4f81cesm1632455pjt.3.2023.09.20.11.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 11:09:12 -0700 (PDT)
Date:   Wed, 20 Sep 2023 11:09:10 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: avoid unsafe code pattern in find_pinctrl()
Message-ID: <ZQs1RgTKg6VJqmPs@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code in find_pinctrl() takes a mutex and traverses a list of pinctrl
structures. Later the caller bumps up reference count on the found
structure. Such pattern is not safe as pinctrl that was found may get
deleted before the caller gets around to increasing the reference count.

Fix this by taking the reference count in find_pinctrl(), while it still
holds the mutex.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/pinctrl/core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index e9dc9638120a..e2f7519bef04 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1022,17 +1022,20 @@ static int add_setting(struct pinctrl *p, struct pinctrl_dev *pctldev,
 
 static struct pinctrl *find_pinctrl(struct device *dev)
 {
-	struct pinctrl *p;
+	struct pinctrl *entry, *p = NULL;
 
 	mutex_lock(&pinctrl_list_mutex);
-	list_for_each_entry(p, &pinctrl_list, node)
-		if (p->dev == dev) {
-			mutex_unlock(&pinctrl_list_mutex);
-			return p;
+
+	list_for_each_entry(entry, &pinctrl_list, node) {
+		if (entry->dev == dev) {
+			p = entry;
+			kref_get(&p->users);
+			break;
 		}
+	}
 
 	mutex_unlock(&pinctrl_list_mutex);
-	return NULL;
+	return p;
 }
 
 static void pinctrl_free(struct pinctrl *p, bool inlist);
@@ -1140,7 +1143,6 @@ struct pinctrl *pinctrl_get(struct device *dev)
 	p = find_pinctrl(dev);
 	if (p) {
 		dev_dbg(dev, "obtain a copy of previously claimed pinctrl\n");
-		kref_get(&p->users);
 		return p;
 	}
 
-- 
2.42.0.515.g380fc7ccd1-goog


-- 
Dmitry
