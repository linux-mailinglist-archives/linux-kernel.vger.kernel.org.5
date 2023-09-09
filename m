Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E63F7999DD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbjIIQ0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346441AbjIIOfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 10:35:11 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804CF18F;
        Sat,  9 Sep 2023 07:35:03 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99bcfe28909so363964466b.3;
        Sat, 09 Sep 2023 07:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694270102; x=1694874902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wy2Lb/rUwudSvnIiRGCw4FsxCiBdrK+e4ZEqb1+9uQ8=;
        b=skLSs9MB9e2ADKRFJLoY5nOAGsLsMCEC4zIEd9KcomfxGvp1XWoqouxJqUnX0olxN7
         na/LL3MtUF4R1GiMJbGv0+WOMtzJwP+WUIrP7EFD/EHKBxA/WuNA/CbMFX+Ggv9374aO
         4pkxtCF+rCS4ZiwUtM4F7nddh23pz6TgLha0rXnYE6fa5Be8xS+w6ZQonEDXDTjBjgO4
         p6+qBV+cYLDo9VvTZ63JbsM4SdTTUWzyPCLLMbKKOWIPZlLhl1DTWu0cszF8rOOcGXCu
         /5zgSABqqkjv3JcGFnKF8ti1GCTV4Yf3Btl2c0xeVqhmEce7qmXmdal0mrkFjOuppGGM
         wncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694270102; x=1694874902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wy2Lb/rUwudSvnIiRGCw4FsxCiBdrK+e4ZEqb1+9uQ8=;
        b=vSukfpCpaLNtZccsF0bRPCA25hjHrOYIX8soQKODVnpR9qNmjBc0OJGLjSgD2YYNVN
         NqnpWxOFuMRnoZoWFSiEc2wfv/acPPPr3b07ixBZGh8zIMGkQtU1ULnotX+ghHUxzzSE
         kvJ5aIdR29ZmTTYBEjzMgEfre3+MH1jK2uv/UJoRLwy3EioOnv7A2UbvCtkWxyaHIthD
         Ef9pNz2yC4Jfhgn5mPZHDji8HJWh18aNexkioOENd4zIgRrfIGPPq9t8ScXbnc9i2vSF
         t93u3MLgmiXBI94FNyPOqWQLIuwZRjqMsKOga6Q+NzADU1FFXWP32ZIV8Nz1PT0BM0nj
         dseA==
X-Gm-Message-State: AOJu0YyxG9+kMqF326H0gI99ivJmZaLgxnldmrR44doTdeWFg4NZeSI2
        etvZGzbcb8GoQzp/JjFLPEY=
X-Google-Smtp-Source: AGHT+IFH86sAgB8w+MEEk41VvHbNk14lx+2i8CKF2QuTWtf8BDB/EC2E+tnIa/qWbEuz4SJf0RfRgg==
X-Received: by 2002:a17:906:23ea:b0:993:d617:bdc2 with SMTP id j10-20020a17090623ea00b00993d617bdc2mr3608578ejg.75.1694270102010;
        Sat, 09 Sep 2023 07:35:02 -0700 (PDT)
Received: from localhost.localdomain (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id n3-20020a17090695c300b0099bc8bd9066sm2433945ejy.150.2023.09.09.07.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 07:35:01 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 2/2] pinctrl: pinmux: Use dev_err_probe() in pin_request()
Date:   Sat,  9 Sep 2023 16:34:57 +0200
Message-ID: <20230909143457.9149-3-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230909143457.9149-1-jernej.skrabec@gmail.com>
References: <20230909143457.9149-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dev_err_probe() when printing error message in pin_request() since
it may fail with -EPROBE_DEFER.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/pinctrl/pinmux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index 301fe0157b02..0ecd74ce5890 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -188,8 +188,8 @@ static int pin_request(struct pinctrl_dev *pctldev,
 	}
 out:
 	if (status)
-		dev_err(pctldev->dev, "pin-%d (%s) status %d\n",
-			pin, owner, status);
+		dev_err_probe(pctldev->dev, status, "pin-%d (%s)\n",
+			      pin, owner);
 
 	return status;
 }
-- 
2.42.0

