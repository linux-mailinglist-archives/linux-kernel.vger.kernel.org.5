Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92E8812DA5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443911AbjLNKxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443804AbjLNKxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:53:01 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F324ED4A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:53:04 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c2308faedso81896795e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702551183; x=1703155983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iA5vpao/nlkM+BgS1JES9JQXKEWnmeNI0auTBLc7cY=;
        b=FV+DjVE8H70sTQH6kRDVqJ3wExPAVdqrMa24gJvMtraeUJisUsqEL1EDAs6Mp2JBDH
         wokxdMyYpkFz5aI0NdfEdywYYHonlNu5elwoHncMnf7w6VxUXoVfSYUji70EyjLIIC9X
         5s4ejiA4GXYwzSIlaoNWQxqldQdyL3gZMvq3J/2G9V1BVl0nupXxbO5O6We3VB8zVuTM
         mp436UXfkCZYP3ZzoHkwwtju0tPsM615UA2EJQLiTWgxvfBbxPjhXVg//UIu49VIdCi0
         EHNTL2oqGrGKHILl5FrCUHRbHP3NyyGck1KdsJrQ5EAPdv4Suxy+8cvISAKrzyu5Z0H9
         8wjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702551183; x=1703155983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iA5vpao/nlkM+BgS1JES9JQXKEWnmeNI0auTBLc7cY=;
        b=DtZ7Ro+VJL37Rei2hWSHzJitTT+olimQfpX6ri29CtMU++Aw8shoaW7XxqKqhkDgpl
         28Y7se5nOcqqlPvlxMLwO7HIhUC1JxclTiphbkdLKeiI8XLpS5h3jTijA+LRnMiD4P9g
         bI9wTlRPL3zZ9GYYLye7WikWov4+fAqyzt2JNKRo3lQPgY3cnvXrr9ILIwOg9i83VLnF
         101nLZozpVUanijfNfQi8QLhzyNYuax1X4ryj8jD4wLe+b/YS08jVoIRWtJn6juGrKNK
         y1SzSIXaWxB8aSytNsVABl5Xm/UzfwbgqF9/RXhuFT3VWO81C+2hd5cXAaDyqPZ5acpP
         f71g==
X-Gm-Message-State: AOJu0YwPQ56BqhA1MW9kZV91E31DUImg3S2IjrijT2s4RvQMoifPZh8C
        Sk+PuNivKl1hLjjPrb5nKd6A3w==
X-Google-Smtp-Source: AGHT+IFhXWtaTCFsSRB/rCN50lEOB2f4DScvINgysd4f+wNUqjxRfR1ruqRktKeZe3CB7TSMb14q8Q==
X-Received: by 2002:a05:600c:4d0e:b0:40b:5e1e:cf1 with SMTP id u14-20020a05600c4d0e00b0040b5e1e0cf1mr4741397wmp.44.1702551183507;
        Thu, 14 Dec 2023 02:53:03 -0800 (PST)
Received: from ta2.c.googlers.com.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c468700b0040c420eda48sm17614854wmo.22.2023.12.14.02.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:53:02 -0800 (PST)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     peter.griffin@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org, andi.shyti@kernel.org,
        alim.akhtar@samsung.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        s.nawrocki@samsung.com, tomasz.figa@gmail.com,
        cw00.choi@samsung.com, arnd@arndb.de, semen.protsenko@linaro.org
Cc:     andre.draszik@linaro.org, saravanak@google.com,
        willmcvicker@google.com, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 13/13] arm64: defconfig: make at24 eeprom builtin
Date:   Thu, 14 Dec 2023 10:52:43 +0000
Message-ID: <20231214105243.3707730-14-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214105243.3707730-1-tudor.ambarus@linaro.org>
References: <20231214105243.3707730-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gs101-oriole populates an at24 eeprom on the battery connector.
Make EEPROM_AT24 builtin.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/configs/defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 09fb467303ba..19c1d61382f6 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -276,7 +276,7 @@ CONFIG_QCOM_COINCELL=m
 CONFIG_QCOM_FASTRPC=m
 CONFIG_SRAM=y
 CONFIG_PCI_ENDPOINT_TEST=m
-CONFIG_EEPROM_AT24=m
+CONFIG_EEPROM_AT24=y
 CONFIG_EEPROM_AT25=m
 CONFIG_UACCE=m
 # CONFIG_SCSI_PROC_FS is not set
-- 
2.43.0.472.g3155946c3a-goog

