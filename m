Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0109B802F76
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjLDKBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjLDKBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:01:20 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F220FB6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 02:01:25 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a06e59384b6so583812766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 02:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701684084; x=1702288884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gcpWgbYxTJM4cDAhuGusGlvYgR0Ejalgkc6iMWP0mY=;
        b=FG22JHgTG56LLk+w8LIVub6yVamtIsam+1oKG9ylMA91dBQxWyOq91GuDLokRa+Y6q
         CP0jdSRAeIl6ONcbmjuS4J5kacFHrBeujbjMOO7SATzv4Loi6YDwoEQU0YW7W43OSPi+
         Hm+B2jni6kzHJMpW4y7vHY6fN4Qm5Yj2uBxt5GT/eHRQXeSwfHBBfvDrn1hX0naFWcJX
         Ql9gbjHMJHpli3z7v8vK25iJKKTalkCEs/Ibkw6eWkoQHdABwXaaM7N6Zg8M5TVw678b
         wyrafC12qtAvZNiXAmn90MUUo/TC8Vp2dXjOydaanwIiWieAMW2hTz0MfGu3nEdb0CHw
         djRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701684084; x=1702288884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5gcpWgbYxTJM4cDAhuGusGlvYgR0Ejalgkc6iMWP0mY=;
        b=uKT74bTpv+kKhuXyZWl4bdmfWPiNl0tFcPDdUZRT/JDT1GbKtkgyoW5OBKHRsgRvyU
         uI9koi+AO8/2Mf5aSfe4uGGaJ7AhJUW7mUJ97GuiEsDmYEKvuWUE6QM/b69qAN6kJUxP
         0xmBq2svKX+2Ii1VeKXHaZ4w8qCOo69jXRdH47w6K3S255yEW5QjZ6WYR1Nz+fLMo9jR
         3i5iU+RoByWtpXsibB5fN5+0f94XAAtFGXdCwcb2vD3q2gxtRAhgV0n6kB2EoJpw1Vdn
         fA4Uagz0j5ZAayo4RQvREqO3J1VeHTQ2Lgisr329qmgfc3fq5JHubHvNyugPq1awt32r
         CO2A==
X-Gm-Message-State: AOJu0YySKhA80ylqNs6nc2HknLebLG5ReZHVVBegTbXMczlxddbQVDRJ
        ahYndGp2GN3nNUuMpumIKIPmGA==
X-Google-Smtp-Source: AGHT+IGIU3jORR6B0x3FGVJgT+5hu64J0FQmCPUvyJ3aNFTkxr8CSXX7InvfFNXJYlFuqoPmGBKcKQ==
X-Received: by 2002:a17:906:3f57:b0:a1b:7313:504f with SMTP id f23-20020a1709063f5700b00a1b7313504fmr701721ejj.101.1701684084486;
        Mon, 04 Dec 2023 02:01:24 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id pj21-20020a170906d79500b00a188fe9563esm5065572ejb.131.2023.12.04.02.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 02:01:24 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ASoC: dt-bindings: qcom,sm8250: Add X1E80100 sound card
Date:   Mon,  4 Dec 2023 11:01:16 +0100
Message-Id: <20231204100116.211898-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204100116.211898-1-krzysztof.kozlowski@linaro.org>
References: <20231204100116.211898-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document bindings for the Qualcomm X1E80100 SoC sound card.  The
bindings are the same as for other newer Qualcomm ADSP sound cards, thus
keep them in existing qcom,sm8250.yaml file, even though Linux driver is
separate.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
index ec641fa2cd4b..4673fdffe312 100644
--- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
@@ -34,6 +34,7 @@ properties:
           - qcom,sdm845-sndcard
           - qcom,sm8250-sndcard
           - qcom,sm8450-sndcard
+          - qcom,x1e80100-sndcard
 
   audio-routing:
     $ref: /schemas/types.yaml#/definitions/non-unique-string-array
-- 
2.34.1

