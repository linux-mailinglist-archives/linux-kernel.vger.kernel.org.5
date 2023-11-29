Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C897FD7E7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbjK2NWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbjK2NWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:22:49 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F4E10D4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:22:52 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50bbfad8758so2156252e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701264171; x=1701868971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5IOvkkJMIsRd1YnRawuk60UJlAJd1F2TXb9DiAiWHk0=;
        b=WuYri+A4bmz7uEXdcvZzhqaV0v/18u/AiHE2J26RD0lht42nsdtLz71cv4hpj1HtEC
         UumufLBynbt4j4Z5GjmRLRMbauAUutLkOHRvpEQweD3rudtcV/lGQ48mH4qMFHdelhcc
         X9TFnNzSMMBWGOTP/7FQCXq1rj/j6CzdhFd1UJEAjifVCl8uvizLHaa1vEbdKu9yxUQC
         dFJtDkf0dOMaeFtQ4wzx9dj12/rGrpaa0L7DlQymW/N9d67f8gXYlzgXjVO0GJ6AIcW8
         FV+i+mWUxWGv7oaoPlgcgx59V7q1OW8FbLRcksWQ4qKDX0iyMChaftDgXlJS0Ee7jezo
         amPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701264171; x=1701868971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5IOvkkJMIsRd1YnRawuk60UJlAJd1F2TXb9DiAiWHk0=;
        b=JrntOusRrnbTydyfeWM0lZsQz17tvNa2EEmhI94w7AlwyiVCncsaLkz/+AMwDwHKFh
         72MHWQmuM/mW1X/1tLZQhAfUVwKN03CTCCsdikbUQETuCGeughTM09R34BUaQlm9n1fh
         2ncFqprxuB3JWsvQ1jV2FH1hSnnRucmdN6+zfuxgrFhsaKREoSRBz0Gp7rLyLg6XXZj7
         EAKTUJSZ414F4h+Eam4JJ6QWlP472idpU05t2AuGXKmuBCi3Z6d8J41ue+DQzJ0f41JT
         Z83cdnYEY782qXkTBSnO31RiPD+llQgUxVOZ9br6SAWGb3CPza793JZo+8ESa2fPWvOk
         aCeQ==
X-Gm-Message-State: AOJu0YxEljB5nxrcrBBGe1Y9JO29lrlKlciGj6/6BFR007N/2G308Nsj
        RQvQNe47LjUMoviMWMqKim+YwA==
X-Google-Smtp-Source: AGHT+IEAvJW1jTIhtMigwpP5a30LlihRuQxnoO9mK4Y8tBnvnxT7g9sM5dZUcDS9OuilUlyjBIHyXg==
X-Received: by 2002:a05:6512:615:b0:50b:b8a9:e735 with SMTP id b21-20020a056512061500b0050bb8a9e735mr3576863lfe.8.1701264170802;
        Wed, 29 Nov 2023 05:22:50 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id lb16-20020a170907785000b009fda665860csm7844842ejc.22.2023.11.29.05.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 05:22:50 -0800 (PST)
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
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/5] arm64: dts: qcom: sm8650: audio support
Date:   Wed, 29 Nov 2023 14:22:42 +0100
Message-Id: <20231129132247.63721-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Still not complete, but most of audio support. Sending early to get the bits
accepted so we can focus later on more difficult parts (like WCD codec).

Dependecy
=========
Depends on:
https://lore.kernel.org/linux-devicetree/20231124-topic-sm8650-upstream-dt-v4-0-e402e73cc5f0@linaro.org/

Bindings used in this patch were documented here:
https://lore.kernel.org/linux-devicetree/20231129113014.38837-1-krzysztof.kozlowski@linaro.org/

Cc: Neil Armstrong <neil.armstrong@linaro.org>

Best regards,
Krzysztof

Krzysztof Kozlowski (5):
  arm64: dts: qcom: sm8650: add ADSP GPR
  arm64: dts: qcom: sm8650: add LPASS LPI pin controller
  arm64: dts: qcom: sm8650: add ADSP audio codec macros
  arm64: dts: qcom: sm8650: add Soundwire controllers
  arm64: dts: qcom: sm8650-mtp: add WSA8845 speakers

 arch/arm64/boot/dts/qcom/sm8650-mtp.dts |  48 ++++
 arch/arm64/boot/dts/qcom/sm8650.dtsi    | 363 ++++++++++++++++++++++++
 2 files changed, 411 insertions(+)

-- 
2.34.1

