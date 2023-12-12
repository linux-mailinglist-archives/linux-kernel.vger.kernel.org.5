Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E5080EC9E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376288AbjLLM4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 07:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbjLLM4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:56:32 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B229CA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 04:56:38 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c4846847eso19915785e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 04:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702385797; x=1702990597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/REoHRC8EpvIBFzSqK+riwD+PQlohKwOub1bzwmxD4g=;
        b=ptNPZqnKnsJ5+gY/Z4ISW4ASlY5ML4F+bU8YImS2Yv8RVh7+FSQScQOfesoaTKl+BO
         ZNSMHJfBLOwG/trU4K54lN53j05/cEclJ9Avnk/DKmonKu9EPdKdZeIqp8TTt0EdT2OX
         MvBCkvmWw6gLyKHhIXz75y1QM6ymBw3LDM37q8jwmtsa8D6pvqkMpYXxEpqvKAjwC17j
         cMyZMG9NXzYbZ+DMq/fslIkUUO32jAvfVwFFI+cMNBjG4G6QmeI4wDnS7zm44ZLMfjng
         Mle0v219RhGUSNozxCzLca7RRof0sqditzQGpE7eFLh0fzUAQccwo8ZmVD6b0mD0lYWm
         W4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702385797; x=1702990597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/REoHRC8EpvIBFzSqK+riwD+PQlohKwOub1bzwmxD4g=;
        b=MfNvAWBdBmAdQaH/6E0tkJSZzzm3zD9u2c2yIHXdrpAx7KYM5MLK1CcqPtQFokKuIK
         E1a0LzwGgMYnKctmv8aHLHFF5NqGkyi7L0RM37tB2tZt6280zVG3sEJvDFBn3XfqfkQS
         Ij8Ncl4Hh9LZjgeu5BdtBlisYvlNWmDWPmZf/9Pg3KblgTw6Y5EiP8WfynqdYSUH4vw5
         ZBZ1CfbwHPg6qOiCE+HAB0syFWtOOjhbtAC5DvIZxl0QU0Cio1C0NndE4UzAoD0WoaAd
         ACqeHszya1aHzIbHnl9uSRT4BxJX4yH+sbSk4eQYtnTVwnLn/6Za6jg3OOmuKuxNF5lc
         PX2A==
X-Gm-Message-State: AOJu0YxM4rDGA/9WrLyEZEkwcoet1PX0QlxtJY2EX975Wd6NcjeBHw9Q
        qSD78uWvXm1QSDdBxkigGaxqCA==
X-Google-Smtp-Source: AGHT+IEX3/ysuozCRgiqNGdA66zA1f/uo2y1zcKGzyzZ3Bq8GOq9UOx1wFEjekqDrbKxtL9ycZEgDw==
X-Received: by 2002:a05:600c:ac6:b0:40c:2d85:3a01 with SMTP id c6-20020a05600c0ac600b0040c2d853a01mr3273027wmr.161.1702385797071;
        Tue, 12 Dec 2023 04:56:37 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id e12-20020a05600c4e4c00b0040b398f0585sm16820693wmq.9.2023.12.12.04.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 04:56:36 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH 0/2] arm64: dts: qcom: x1e80100: add ADSP pieces
Date:   Tue, 12 Dec 2023 13:56:30 +0100
Message-Id: <20231212125632.54021-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Hi,

Depends on:
https://lore.kernel.org/all/20231212-x1e80100-dts-missing-nodes-v1-0-1472efec2b08@linaro.org/

Bindings were already applied.

Best regards,
Krzysztof

Cc: Abel Vesa <abel.vesa@linaro.org>

Krzysztof Kozlowski (2):
  arm64: dts: qcom: x1e80100: add ADSP GPR
  arm64: dts: qcom: x1e80100: add LPASS LPI pin controller

 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 56 ++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

-- 
2.34.1

