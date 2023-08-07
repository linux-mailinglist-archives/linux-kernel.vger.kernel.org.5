Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED123772EC1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjHGTfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjHGTfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:35:22 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4381717
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 12:35:20 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9bee2d320so75951031fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 12:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691436919; x=1692041719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e27wbiFJtLlf43t1k7vc8pvwOKH5unMgNn5Odb2O+Z8=;
        b=0ClHwQmDfHox7caha97lX3plPiiO9uO/nV4QJN2dkc8f/qkhCWBPsutilB3bREPHr4
         9NFno8L+SXRLiDnvRt+qNn8aqOk7Db8x1nMjFqMaRBuMB1Vj1nU2Uwi75BChTWV7tUQx
         7Hzzz871BHBcswazgRdh5hFNjOo0gA22e1zOHuIO+U4203plfrdrDIKkBPl9kmBMXktF
         gNJB6sNjiFc8O3jDztpnJuADTxxstNh0XKDuIQXel7XAX1teMKQnzdnB522fQMYeTDjH
         cswqB1b/e0c1/q28xCtpLeyOslraYAMkbS02ORfJGWYCuQgPrlMDaSt6g9T8NE/UYesB
         ECdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691436919; x=1692041719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e27wbiFJtLlf43t1k7vc8pvwOKH5unMgNn5Odb2O+Z8=;
        b=ZGlXe7BQEJAUC0HCk3AEZZgvkkl02Pq2Un92b2Et1WROoQ6TP74JOKgwDfy1fkcx6d
         /LaGoSLX881krufXNrz6Q+MtjoCO3QNKPg6wIYD7tnyOc7TWxeq51meuIQjfoM735Q0d
         TwsnPjfj7o1Yxbf4ovxrRAkIQeqOJRg7TF3k0V+HQwGmrJbYIh8OtC+tOcAVU0lhXuCs
         VJKionDsoz/Jmmgv7GoWu5kfpX0U4T/TIoTsi8QnNZETNt8XfymqVoUICJcWEpzbXWkH
         Mzpmx4HmA1j5hvqVgcUa3S+4oWMSDL2kbprYy0eXdrNDMtw97WQsoVlBm5xAX+I1VIg6
         HCxw==
X-Gm-Message-State: AOJu0Yxu3JUsq7vQtoQXWek/k15M2FNVjmAIkaU7uAVtyykPVGf0oQ5f
        8L69umVFgBZJb17D77It4U7a2g==
X-Google-Smtp-Source: AGHT+IF792kTobb8MlI4iFxkIWn86W6q+R/OSGQFuQifwhPAUOuWr6eKA+8sKr0Z/k14NOqktWgXqQ==
X-Received: by 2002:a2e:7217:0:b0:2b9:cb2a:11bf with SMTP id n23-20020a2e7217000000b002b9cb2a11bfmr7483270ljc.49.1691436918813;
        Mon, 07 Aug 2023 12:35:18 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b3d6:9e6:79d9:37cd])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003fc04d13242sm16061488wmc.0.2023.08.07.12.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 12:35:18 -0700 (PDT)
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
Subject: [PATCH 0/9] arm64: dts: qcom: enable EMAC1 on sa8775p
Date:   Mon,  7 Aug 2023 21:34:58 +0200
Message-Id: <20230807193507.6488-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This series contains changes required to enable EMAC1 on sa8775p-ride.

Bartosz Golaszewski (9):
  arm64: dts: qcom: sa8775p: add a node for the second serdes PHY
  arm64: dts: qcom: sa8775p: add a node for EMAC1
  arm64: dts: qcom: sa8775p-ride: enable the second SerDes PHY
  arm64: dts: qcom: sa8775p-ride: add pin functions for ethernet1
  arm64: dts: qcom: sa8775p-ride: move the reset-gpios property of the
    PHY
  arm64: dts: qcom: sa8775p-ride: index the first SGMII PHY
  arm64: dts: qcom: sa8775p-ride: add the second SGMII PHY
  arm64: dts: qcom: sa8775p-ride: label the mdio node
  arm64: dts: qcom: sa8775p-ride: enable EMAC1

 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 116 ++++++++++++++++++++--
 arch/arm64/boot/dts/qcom/sa8775p.dtsi     |  43 ++++++++
 2 files changed, 152 insertions(+), 7 deletions(-)

-- 
2.39.2

