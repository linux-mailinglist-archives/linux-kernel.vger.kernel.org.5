Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F11777492
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbjHJJcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbjHJJcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:32:20 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4E82703
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:32:13 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-986d8332f50so105962266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691659932; x=1692264732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jg2L3vi9gBJrOjVe0teUOiDg+bStvnc1pYKHQaDLRLY=;
        b=GVmzERpBcBK1W096yDEP1r1Pl3nC0+Ij76R5rvLYqaXAJ0rvNj4BqF10hsYPhtJGNw
         RUtDvGR97yY8MaMbsZJqxIz1QLyg7lTle3/MmTDX9CTfc3dqkRZQ/0IInpPNJYNx27c8
         IRNggJ1wO49lYHL/FuZdWIuD3pBTm3jvKM67Gku4PrR6avZydiG8aWbzGJk/lQLAhszX
         Ug5JKKHuAAO/PCiC+kIiEmPP1VPtGYa0XYuFMVSa43ywnJ6Q1Fl+c7M1wYmLFLjLyPZ4
         WNCbwu8MMcSJJyov1C5EDj9tT0mX5MC887Kb0WNGXPrPl+sY3DXpZ8peS7PbqK8WyXsW
         EVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691659932; x=1692264732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jg2L3vi9gBJrOjVe0teUOiDg+bStvnc1pYKHQaDLRLY=;
        b=UmjCZhs3S8Bx8sl3EomNlqTlSXo6olX17k02r0wAtnlA/UJcsfCU+EgfVnkaXR7PlQ
         PybQPqa5A98kFndUAii64F09WWRXgudvU42COoUoIbQ94ZVKlrtrhy4KuLgi2xzsEupW
         p+OxXVCmfmyoqldEG4Jaf52+mjzf8EVXNrBba88Ti50pxbY/wyQoq+PTZ+5gXi6zPjSY
         QM/xz874+vNamlHjO/JAN+xqiXFDFAIbCtjqu63dnC45Ws6hgR84VlrBeVe8RG/By02p
         yshiF8wAmTqqQKsG5YFTqdYNW5N8fwonThouiZPCoJIJ/cz71QJbCdMUzxJwGDwhLYSW
         li4w==
X-Gm-Message-State: AOJu0YwuT0caYJx9y+MhGAJ1k4QiADkK94UuGS5GW4BAZV4gef6YVr84
        RPYDEYvWXlOJaRDr2GssE21ljA==
X-Google-Smtp-Source: AGHT+IHQZHg+OP3fP402UEuzmAjOFlYBsh9Wcsht2n1PcPuSiQDN5MAAQTdnWn5XqV+qqH5El/nZpA==
X-Received: by 2002:a17:906:3114:b0:970:c9f:2db6 with SMTP id 20-20020a170906311400b009700c9f2db6mr1489439ejx.63.1691659932008;
        Thu, 10 Aug 2023 02:32:12 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id e22-20020a170906249600b0098e2969ed44sm667642ejb.45.2023.08.10.02.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:32:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Eric Tremblay <etremblay@distech-controls.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 08/15] hwmon: (lm90) fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:31:50 +0200
Message-Id: <20230810093157.94244-8-krzysztof.kozlowski@linaro.org>
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

'kind' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  lm90.c:2768:16: error: cast to smaller integer type 'enum chips' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/hwmon/lm90.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index b25ae8b7ec90..e0d7454a301c 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -2765,7 +2765,7 @@ static int lm90_probe(struct i2c_client *client)
 
 	/* Set the device type */
 	if (client->dev.of_node)
-		data->kind = (enum chips)of_device_get_match_data(&client->dev);
+		data->kind = (uintptr_t)of_device_get_match_data(&client->dev);
 	else
 		data->kind = i2c_match_id(lm90_id, client)->driver_data;
 
-- 
2.34.1

