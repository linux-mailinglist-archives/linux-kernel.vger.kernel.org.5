Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C395C7774A1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbjHJJd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbjHJJdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:33:16 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4900335BE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:32:46 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99d6d5054bcso48947266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691659962; x=1692264762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAUHyC66z7nc30Y9XWG6TM6gua2fmA0h+hpvdL87oQA=;
        b=jUxnAbkuxgoE31SY8BvQi7Df7dhp+J1EHoyx99hmdQY66Kq6jmz3p9DVbeYbt/yCRt
         cBfa9HurbKIWv/dtmsGVmYOig3ECYUQW5ITaBv9oXOarb60xre4MaT4llDs/NmxEyQNc
         DZIIElmsyhlNumVRzeocHbmIIDnY3VJsiE0d9J4BDVys2XIpJHK+a0Fog4nTTGmQMF5r
         Lpoz8/9feRT9kmje73DGXddlNZVLlilHINixoVf276nWKM22LCxjVYbcCV//R/X+wS4t
         IGrSLr+pFupOSzarWKI16E6Wqz+KX1z1H7UMjD1CmniAqLznjdQuFwHZZ84cQDJ58fsa
         fWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691659962; x=1692264762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAUHyC66z7nc30Y9XWG6TM6gua2fmA0h+hpvdL87oQA=;
        b=CS6t9fsN6bBoG1gYFwlon942P0jIrAo52G3Do8iY1ObeLUeg8/2kMKUvtghGEsIfqN
         7rvuDVUdtjIFuiDbHHhoQZz0Ut++MiV81EEOO5Z5S14Vm8ZsxTytvrXqQHxdc4Ri8dJh
         2X0/2nw8XVhDAPFwMFJ81WuLMIUkkyIlC1Q1A14ZrjgZL0rv1RNXtXzCtbNfo7ipleeD
         AbWOXLY4gbQ96nYOFuQZDnPGSV7s5+UBFHKu7NsfR21gYRTkQ3uR2FCNTPutTjpPa2wD
         P5+rfHr7KSBTRvy+CDMB8B7IBaoz/lwxqZtPx8DaONZ+iql9prwIehsTe6gXBfQQbwkq
         9T3Q==
X-Gm-Message-State: AOJu0Yx4CcoPBAcJv3itctkbYtdjDJ+I+5wllyRNdwxHCOoJpltjM3pS
        YFytLcbwtJ2ruHCHpDfX1SNjAgsjSE8cZdTQGMEMVw==
X-Google-Smtp-Source: AGHT+IGNF/Vs6kB3N3MLb9XZ6oEiQnvfsiUtTgSjQi50K9OZa3V1kADiyNra0EjkW7lomY6apVyZVw==
X-Received: by 2002:a17:907:3f9c:b0:992:103c:43fa with SMTP id hr28-20020a1709073f9c00b00992103c43famr1820080ejc.30.1691659941241;
        Thu, 10 Aug 2023 02:32:21 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id e22-20020a170906249600b0098e2969ed44sm667642ejb.45.2023.08.10.02.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:32:20 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Eric Tremblay <etremblay@distech-controls.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 14/15] hwmon: (pmbus/ucd9000) fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:31:56 +0200
Message-Id: <20230810093157.94244-14-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810093157.94244-1-krzysztof.kozlowski@linaro.org>
References: <20230810093157.94244-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'chip' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  ucd9000.c:591:10: error: cast to smaller integer type 'enum chips' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/hwmon/pmbus/ucd9000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/ucd9000.c b/drivers/hwmon/pmbus/ucd9000.c
index b1d1d4214e69..8d9d422450e5 100644
--- a/drivers/hwmon/pmbus/ucd9000.c
+++ b/drivers/hwmon/pmbus/ucd9000.c
@@ -588,7 +588,7 @@ static int ucd9000_probe(struct i2c_client *client)
 	}
 
 	if (client->dev.of_node)
-		chip = (enum chips)of_device_get_match_data(&client->dev);
+		chip = (uintptr_t)of_device_get_match_data(&client->dev);
 	else
 		chip = mid->driver_data;
 
-- 
2.34.1

