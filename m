Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB6677749C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbjHJJcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbjHJJcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:32:33 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C822D55
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:32:21 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-52328e96869so870095a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691659939; x=1692264739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2v+GRu6WDJvM0/2vgpI60e4B3OmPCtheyKzDBXMk+w8=;
        b=o4jgiMwMVX0IiDCQPHUJ6qSwSFOILMQCYj4lC3GhVWDoy3MWB9fMV70SgjJUh8xEVj
         wniAvKl0MSU7+zoPkTG5yuSe7zscSLxzqGGnaR4uPoYEtag8PPCHuR2yGHGsQHtqFTOG
         2Ye/fqUAmxRf7V9k+W4w69VNPDmWKZu9O70OUs832sEHmjSGcVq/vFnZCJr893LyOrxk
         LNCHz+GWH/vgqakvzYAXW5jQb5sUPJXXUcrPp8BGzu/bIASkkc7IGdA931HD4tgjBj0d
         j6vYxF/V6cBJ2J2G6VwuujX0fFsI1JAgQl/jAxc5yqkPoFLYXPnoMzqd0qlPowB3lvVs
         bbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691659939; x=1692264739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2v+GRu6WDJvM0/2vgpI60e4B3OmPCtheyKzDBXMk+w8=;
        b=YNgcbJ3ZlwpTvFr9z0Fvf1j0bjF2slfWlVwkQwFTkzxhlPmH+6Qussk1yEFIPXyXyF
         nGu4XcLmFNcRBcsTWe/btZVsH8h6bdk90xELOrucjW1W+nAduJ7FTYF/+gLrInZcg3F0
         ejWi93lSm/1rAZ+XLeceFvTM0Vodbaa2yu629wrxUVTsCNG68RY7zFumqZwZ5IzdgGKm
         fE4/ZnRKy3BnHNU149SWGFKZ/GeYTjO7iCws5/eY87CvJfHXIYZS6RMgz9lWK8k0ecs7
         ekth6yTK48S0wEAnsCH64zbT10s6ApSSaEPIS+FthkUPi7ZDzXEJoylD5PwhSpH8Hl2u
         FxZA==
X-Gm-Message-State: AOJu0YyRtK1qQc5yOIImdB1AVi2raKvbbkoQ2DU0js9M9jYGlizJzCle
        phS7P3HEOX7/1gDY6BUkQMhvfqzvdKD9PAd7myQojA==
X-Google-Smtp-Source: AGHT+IFCMVjABixV3IsTADinp1g9DSc/LsoKu78Jm61rtsCfnVREq1+p8G36qoH6UON4ybbfTIJglQ==
X-Received: by 2002:a17:906:5357:b0:992:c5ad:18bc with SMTP id j23-20020a170906535700b00992c5ad18bcmr1902845ejo.70.1691659939768;
        Thu, 10 Aug 2023 02:32:19 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id e22-20020a170906249600b0098e2969ed44sm667642ejb.45.2023.08.10.02.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:32:18 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Eric Tremblay <etremblay@distech-controls.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 13/15] hwmon: (pmbus/tps53679) fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 11:31:55 +0200
Message-Id: <20230810093157.94244-13-krzysztof.kozlowski@linaro.org>
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

'chip_id' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  tps53679.c:238:13: error: cast to smaller integer type 'enum chips' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/hwmon/pmbus/tps53679.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/tps53679.c b/drivers/hwmon/pmbus/tps53679.c
index e77b12f342b4..5c9466244d70 100644
--- a/drivers/hwmon/pmbus/tps53679.c
+++ b/drivers/hwmon/pmbus/tps53679.c
@@ -235,7 +235,7 @@ static int tps53679_probe(struct i2c_client *client)
 	enum chips chip_id;
 
 	if (dev->of_node)
-		chip_id = (enum chips)of_device_get_match_data(dev);
+		chip_id = (uintptr_t)of_device_get_match_data(dev);
 	else
 		chip_id = i2c_match_id(tps53679_id, client)->driver_data;
 
-- 
2.34.1

