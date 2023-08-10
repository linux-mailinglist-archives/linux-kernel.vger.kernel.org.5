Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D444F77723E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbjHJIJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjHJIJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:09:25 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D842698
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:09:22 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9a828c920so9520531fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691654961; x=1692259761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpXdzO18RrtXwG1vEq4oV2dagvFMdv6OctdPNcdZEJ8=;
        b=nfvkb65ILI7O6/eV3tgDEznl1SJwxEb471cXklCICLHiO10nmoX7XaRQDhiL1U6WFk
         mvsfSbR0jzYB+qrV3aoZ3vFofFI/J+PuSV05QhkPj88czct74lkoQuzF1PgY8YhWv/5A
         GE8ssaeSSsteIKNzXvS42j0+UvcWw3RUn4D0glmhHzYSuvrC1Gzws8KKWz2sofAkNfk1
         1PZI6rbnoxGWSq5oP/33c39F0U7Ltn0YjOujvy2dQLMju6qGivs0TSBxh7guigELB+UJ
         A9epM8z1jdCzsXplWgog/RJcdBKVWPHnTSUX+UwW1A2FNpu75m9+gAZdG81lzuAmYT4z
         cK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691654961; x=1692259761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cpXdzO18RrtXwG1vEq4oV2dagvFMdv6OctdPNcdZEJ8=;
        b=VOrqvYZw42XwNHlhwO6QBXiu62FXke9zdfMRoawvRf6Q0kHilYQ/SCN5NH6obdUMTD
         hy9jRGLbQTWViMbKT2rGzj4SVVTJ/m9pN2s4HCZOGC5W0+JGvwzxp4tbueDeFS5tZR2x
         rv0CjVAEntpeKM3/FgruptHU/LeUDuyDKAGLofb6TvYlJHZLDGXproZKkWmUey0qYyUw
         3nWxnmAIe4Y0fmRx59GloHLSv8PwlV8p/exgYSs2UHE+GUxlEhR7614rGy8Y6C+QkHZt
         GguZwh01jE3bg9fj4Es47gLEmSz4ZbNs50jFa0eMew+yEWQqMcehUy7RFyRIdNbqmnPn
         b1gg==
X-Gm-Message-State: AOJu0Yx7AZfLl3q+WGoRYVk6kuQKC4sM7/wJH92022sJiUOfrDURtQ7v
        463VZfVKaiXnq0Qi9kYRbgOLIw==
X-Google-Smtp-Source: AGHT+IGcGnKOGdbYi4/mD8nbOxs4Jab1BFmWSwEyjhk+nVjauJLO97xg7euetaCl7JaWUKCEBZYZqw==
X-Received: by 2002:a2e:8ecc:0:b0:2b9:4811:2b6 with SMTP id e12-20020a2e8ecc000000b002b9481102b6mr1248341ljl.48.1691654960916;
        Thu, 10 Aug 2023 01:09:20 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:74d3:226a:31b3:454c])
        by smtp.gmail.com with ESMTPSA id y10-20020a1c4b0a000000b003fe2f3a89d4sm1321790wma.7.2023.08.10.01.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:09:20 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrew Halaney <ahalaney@redhat.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 7/9] arm64: dts: qcom: sa8775p-ride: sort aliases alphabetically
Date:   Thu, 10 Aug 2023 10:09:07 +0200
Message-Id: <20230810080909.6259-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810080909.6259-1-brgl@bgdev.pl>
References: <20230810080909.6259-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

For improved readability order the aliases alphabetically for
sa8775p-ride.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index 486cb48ecb9d..93d64618ba58 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -16,11 +16,11 @@ / {
 	compatible = "qcom,sa8775p-ride", "qcom,sa8775p";
 
 	aliases {
+		i2c11 = &i2c11;
+		i2c18 = &i2c18;
 		serial0 = &uart10;
 		serial1 = &uart12;
 		serial2 = &uart17;
-		i2c11 = &i2c11;
-		i2c18 = &i2c18;
 		spi16 = &spi16;
 		ufshc1 = &ufs_mem_hc;
 	};
-- 
2.39.2

