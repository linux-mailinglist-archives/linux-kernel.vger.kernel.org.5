Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78577787BE6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 01:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244043AbjHXXQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 19:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244104AbjHXXQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 19:16:45 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5B01BFE;
        Thu, 24 Aug 2023 16:16:34 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d780bca9275so366617276.1;
        Thu, 24 Aug 2023 16:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692918994; x=1693523794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xg2yByo1Np1P/TgXsSLJ4r1IwzSnzgvjX/HFW4qum3M=;
        b=CRX/tpIytqSV1B07mimvyiICfKt1eM4Z9PpqAmOS4EIp+x+6dI0WI6IE2x+ha5OyCB
         KguHdfoa8q0WU+W90VxSnFRf53BevugM2Xsj4PyjY2zhPpoR6spAHaFSNk7LUfltarHk
         KIpQWzBQJ+C0q92J1aeIMFhB1SHN5TvYzbbfKG9yRk4TFQI3xhQXgPZMccdcKsaLk0Ak
         uNelEMhfasus1yNtMG3JtAXXUDgsvCiuXBYbnT38LGIzHKpSe/oHBtljmNpFLQYuyg8E
         cHvoGgnILWIbTyhync53HIsv59b1P3EYetLdTqt+TRC9voCrWWL3+cOyQFjqaSEaRmjZ
         4qCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692918994; x=1693523794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xg2yByo1Np1P/TgXsSLJ4r1IwzSnzgvjX/HFW4qum3M=;
        b=EYBBGzX3/KDVo1liYnY3SYQRxrdzZnwHXE1uoDhLoHqNTKMvXz/N1B9z6ZjFiMCgR6
         BPaYYqu6qTAMg7oHkrSnhAIE0UMJqIlYqm0Peyc3R0HCuuEX666HPsXDYoiRtYEY/0o1
         qW83IpIB+4uAW+PzZInOjJcSpTet2Wutblm2a0u8Bkfnntwn5zAc1bNx/qf5oOwcMif3
         +6g7/hJGswf0+9hfH7Wmmj+SzQFwMacnUkJrMCOKEzXP+v5zM/hUGwd17AXvaV7584uE
         LsYAXG1Tz+jCbucjXeyUekI+t5KHa2ZC7/mVFu68bzqJP+NbrWxk4bvQRVrWkX+nFsp5
         ni8A==
X-Gm-Message-State: AOJu0YyL3CmPB/ttZOj6RMYcDlF+3kdIvYuBUSdyrqxoBJJTX4LGWmJx
        UhnFZl4q5yWSwLeEpMZrwF+VaZUBCGjOsF07
X-Google-Smtp-Source: AGHT+IGm+eHmb+iUEWTGCl7YBR4AjlPwd/TfuZeHI7kAGMpwIhfQk2suAHg4ZzMMV6Mt+gJ2f5renw==
X-Received: by 2002:a25:b0a1:0:b0:d39:5e6a:9e6c with SMTP id f33-20020a25b0a1000000b00d395e6a9e6cmr18311113ybj.24.1692918993940;
        Thu, 24 Aug 2023 16:16:33 -0700 (PDT)
Received: from [192.168.0.16] (modemcable063.135-226-192.mc.videotron.ca. [192.226.135.63])
        by smtp.gmail.com with ESMTPSA id eo9-20020a05622a544900b004054b435f8csm151322qtb.65.2023.08.24.16.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 16:16:33 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
Date:   Thu, 24 Aug 2023 19:16:25 -0400
Subject: [PATCH 1/2] gpio: pca953x: add support for TCA9538
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230824-tca9538-v1-1-ee3bf2065065@gmail.com>
References: <20230824-tca9538-v1-0-ee3bf2065065@gmail.com>
In-Reply-To: <20230824-tca9538-v1-0-ee3bf2065065@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, Liam Beguin <liambeguin@gmail.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692918991; l=1310;
 i=liambeguin@gmail.com; s=20230824; h=from:subject:message-id;
 bh=4pZdGZb0hr9FM4cnbOhlG8yyvGORbp6I/pW1OFwRl18=;
 b=TJUWuN7T7lylXzpyw+c0699x+mwvLwCHp8vuxvkgndqxNrfyvE2IYT8cGRi+hcZlNkCHzc4Qw
 53lZTl3tbKKBeFGX4kOXHccWd+oiIZL7+pNIXpQGxwp5OAZVD/50m2a
X-Developer-Key: i=liambeguin@gmail.com; a=ed25519;
 pk=x+XyGOzOACLmUQ7jTEZhMy+lL3K5nhtUH6Oxt+tHkUQ=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TCA9538 is an 8 bit version of the already supported TCA9539.
This chip also has interrupt support.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 drivers/gpio/gpio-pca953x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index a806a3c1b801..71a750363738 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -108,6 +108,7 @@ static const struct i2c_device_id pca953x_id[] = {
 	{ "tca6408", 8  | PCA953X_TYPE | PCA_INT, },
 	{ "tca6416", 16 | PCA953X_TYPE | PCA_INT, },
 	{ "tca6424", 24 | PCA953X_TYPE | PCA_INT, },
+	{ "tca9538", 8  | PCA953X_TYPE | PCA_INT, },
 	{ "tca9539", 16 | PCA953X_TYPE | PCA_INT, },
 	{ "tca9554", 8  | PCA953X_TYPE | PCA_INT, },
 	{ "xra1202", 8  | PCA953X_TYPE },
@@ -1354,6 +1355,7 @@ static const struct of_device_id pca953x_dt_ids[] = {
 	{ .compatible = "ti,tca6408", .data = OF_953X( 8, PCA_INT), },
 	{ .compatible = "ti,tca6416", .data = OF_953X(16, PCA_INT), },
 	{ .compatible = "ti,tca6424", .data = OF_953X(24, PCA_INT), },
+	{ .compatible = "ti,tca9538", .data = OF_953X( 8, PCA_INT), },
 	{ .compatible = "ti,tca9539", .data = OF_953X(16, PCA_INT), },
 
 	{ .compatible = "onnn,cat9554", .data = OF_953X( 8, PCA_INT), },

-- 
2.39.0

