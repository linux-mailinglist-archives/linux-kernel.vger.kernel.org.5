Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EAE7BB737
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbjJFMCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjJFMCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:02:11 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABB3DB
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 05:02:07 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-313e742a787so1258572f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 05:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696593726; x=1697198526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPx5XIROD0uk2BJ+/kWMJ+ECquKjMnEvjFyUvfWcStI=;
        b=AToBu3VOjWX6B7/+Ot0c/T97RhKQWgK23KJ8AcZ0r+UZHmCS0MfzLGQeeBkIq46hUi
         breDYtn1IPyFs7F3yT8/Be7ZBC4oDmT1kku5TQA0VLBrM6XCTuDZmQXpBeLpr9CLEvSM
         OhXhJeifkH8h4KBew+CFjYGj+c0yrS+3yqowuukrApqM9poqMftcyhrqkD1PEfso237e
         C68BzHVEp/dPNKbjJqf41ODpCtkE2EvQzhiKmdaMZen8nQDvdkeeSh8UBXSS3PMSOZeM
         o3y90AoSxmjgOAlSXS0O9IA8KCq+irzq5MAIYuWGBXcjQRzw2drDIJOnMgGuj/qeYoQ7
         a46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696593726; x=1697198526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPx5XIROD0uk2BJ+/kWMJ+ECquKjMnEvjFyUvfWcStI=;
        b=vOeLONSsrAkBwJ8d/yyta5kLhKytC0YtE2xWjinIwAyL2ktk39DOqR7oiobOQOPLMe
         KWdNZ0TfppVxHVf4LsQaYLaaoCpuUdTDhGlcZub8gow/r/tkWG6Pibw+N+wDnqk6X7zJ
         SfzwT4dYwoAGzNpyqJ4BxWTO3IKyDdCm+AV5miwTaM+CrGORQUa4yWX2lj8uOZy9eO+c
         Z7i5F0O1J/g+Wl1esMzPhXvDiew6uOHRSGJ27dkLlR9h9UVrDAZ41twOI4MI/+AUkZg6
         LelA6GymUtu+aNs/zAQPUPZGCXHE6pL9duQbf7TsGu8lB610NlWfbZmHZOiVEhlPOPcT
         L0rg==
X-Gm-Message-State: AOJu0YzUseDb/sPB+9IGT3ML78FMmI1np/OKBSzsmB9XGqrXCDYVj43W
        Ccm9kjymXW7mB7DAvV9gWmPSwg==
X-Google-Smtp-Source: AGHT+IGiUVNyzR2JIXoZkF52E5pn5Q9iYVla7N3NhZeecZoMGDksUfU+uMeITERRJXGsZdFJITVsJA==
X-Received: by 2002:adf:a4c2:0:b0:329:6b63:c3 with SMTP id h2-20020adfa4c2000000b003296b6300c3mr1142125wrb.22.1696593725989;
        Fri, 06 Oct 2023 05:02:05 -0700 (PDT)
Received: from x13s-linux.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id m8-20020a056000180800b00321773bb933sm1491061wrh.77.2023.10.06.05.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 05:02:05 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        loic.poulain@linaro.org, rfoss@kernel.org, andi.shyti@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, todor.too@gmail.com, mchehab@kernel.org,
        bryan.odonoghue@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] i2c: qcom-cci: Add sc8280xp compatible
Date:   Fri,  6 Oct 2023 13:01:56 +0100
Message-Id: <20231006120159.3413789-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231006120159.3413789-1-bryan.odonoghue@linaro.org>
References: <20231006120159.3413789-1-bryan.odonoghue@linaro.org>
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

Add sc8280xp compatible with cci_v2_data parameters.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/i2c/busses/i2c-qcom-cci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 414882c57d7f..677e4bc6e2c5 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -819,6 +819,7 @@ static const struct of_device_id cci_dt_match[] = {
 	{ .compatible = "qcom,msm8916-cci", .data = &cci_v1_data},
 	{ .compatible = "qcom,sdm845-cci", .data = &cci_v2_data},
 	{ .compatible = "qcom,sm8250-cci", .data = &cci_v2_data},
+	{ .compatible = "qcom,sc8280xp-cci", .data = &cci_v2_data},
 	{ .compatible = "qcom,sm8450-cci", .data = &cci_v2_data},
 	{}
 };
-- 
2.40.1

