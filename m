Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694ED8130F6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573211AbjLNNKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573195AbjLNNKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:10:15 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F48C98
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:10:21 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a22eba5a290so376768366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702559420; x=1703164220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AUIDfecuT3CPgdXD9xs9nBICujuqZFrFJljrYUStf5M=;
        b=TtNVA4PiDYtLuFLRTcI7YwiGX9MV6OC+xM7vWbEVgc2QYsR43j++JwA8OAmVN1+JP8
         I5qeDPtLSqclF60lK7nx4ycMVpGwgMPIcdvq6t2mSeGLkXp4MjM8SYvTSrFL9sfdI6+3
         6kkCV2WEVaRyI0/XJl16x03WTnqzwsbqU+n1bNJXTb5s1XS85SWtUM1Wy1jw/MenNeUQ
         VRFkb6OpRlLxq+6STt99wcZKHwiI+TllA/gQ4Z/ndem+owOn56QHHFmbhsZNZAzBk4zi
         HOImXyC4wD8bMU7XJ6kNugiss0K9g/4bc40UHCkL47LMa4FJqk3HdDYgv4laPTHtp3Re
         bIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702559420; x=1703164220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AUIDfecuT3CPgdXD9xs9nBICujuqZFrFJljrYUStf5M=;
        b=hjJEt/zb/FfyXDYaJAHTFEz3k4uynFE3VKR1CvzaoEgtfgEVxIx7JVwXhYaHHvktrV
         qvZv/Gjxem+e4YOQNC/y/lp2LHNLAxgb90m8PGimk9H7EJ6yZy4hKniL98lLURjK7beE
         ZnrdBGasKtlCEYdjnnLsiQZIMW2Lup+1UjMbm5CRK0xNf69ZufqeqHgtuSsSAU9x/BaA
         J6iq+8yCekZYEoK4fQDFAIUJa4hi4qYwTfq4lgYsWudHmmtf7lGkJq9YvS46gaA2P3sO
         lil1//qOucOJ9M1iPQQMulifn9tT85TbH1jw0YD4s8DRp0Y/Hepy2fz+jOR/WC6BnTsi
         05RA==
X-Gm-Message-State: AOJu0Yx8/UVpOLhmYm2GdXauIHdcpbcrDzu382bdFTKQ34UD8nKCqTjN
        /AKNmiMUhLXlcPfE27cZKtUMPw==
X-Google-Smtp-Source: AGHT+IHcI+CB3dbqOBHc6gZyiSRJLCh66jgUkizSK5tB7H8mSiwkIVstbwBUz8Ca/NrqwqFnQQ219w==
X-Received: by 2002:a17:907:2d11:b0:a1f:60d2:f0af with SMTP id gs17-20020a1709072d1100b00a1f60d2f0afmr6420294ejc.70.1702559419956;
        Thu, 14 Dec 2023 05:10:19 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id vq2-20020a170907a4c200b00a22faee6649sm2547776ejc.117.2023.12.14.05.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:10:19 -0800 (PST)
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
Subject: [PATCH 0/4] arm64: dts: qcom: x1e80100: audio support components
Date:   Thu, 14 Dec 2023 14:10:12 +0100
Message-Id: <20231214131016.30502-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Still not complete, but most of audio support.

Dependency
=========
Depends on:
https://lore.kernel.org/linux-arm-msm/20231212125632.54021-1-krzysztof.kozlowski@linaro.org/

Bindings were already applied.

Cc: Abel Vesa <abel.vesa@linaro.org>

Best regards,
Krzysztof

Krzysztof Kozlowski (4):
  arm64: dts: qcom: x1e80100: add ADSP audio codec macros
  arm64: dts: qcom: x1e80100: add Soundwire controllers
  arm64: dts: qcom: x1e80100-crd: add WCD9385 Audio Codec
  arm64: dts: qcom: x1e80100-crd: add WSA8845 speakers

 arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 132 +++++++++
 arch/arm64/boot/dts/qcom/x1e80100.dtsi    | 311 ++++++++++++++++++++++
 2 files changed, 443 insertions(+)

-- 
2.34.1

