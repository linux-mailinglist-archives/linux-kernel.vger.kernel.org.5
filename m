Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BAF800C9C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 14:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379080AbjLANxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 08:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379060AbjLANxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 08:53:32 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42478170F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 05:53:38 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54c1cd8d239so1976583a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 05:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701438817; x=1702043617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XO1jfSNAX5UUapl1o0DoRwp6Muw1NAKcPjYnOb3wSQ=;
        b=kVc3BHY6ms+vr7mCEQhUipVj6lSVOqPo9jLWvxYAuvO8C1gVMG/80/+N27hEVVrxIA
         h8BmlrCeJZtS8jo28/0BE/4dht1RgPizeFEYE1lOuGnxT8+XOAuQdGf+7Ggf8Rw8ODvB
         GgdaLWX1xM8MVryLNF6Tg76iiDUr/twUugpVKm5iOp5h4oNOclJxJW1/1YLCr88srRgc
         f6GH18qhjRrzeZ456y2qzFjG7On/G3MmXe3aW4ukK3hnMVzKMcqmj9zMQkBGdpqdByxS
         03z8OwV69sAoiN6L6qPmTM8lRg0BVy3sYffbVRocc/IJ87y6+6nbpYouywERIJ9qkOjT
         Ccow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701438817; x=1702043617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XO1jfSNAX5UUapl1o0DoRwp6Muw1NAKcPjYnOb3wSQ=;
        b=qPt1CYZ7X5MSni0bzXvHE+RHFaSft+WRHE6EqE2B2D6qG0yhSOHcdq/iBbfQIiuHu+
         8o6rYK1G247WpSp8wBQV7qXSaLeWrzeFTgBhfS374izAjYiBZ1bKCD7HvcAz/dVrF/K9
         yloWVOw2wYiBGjzdAHlVwVJ1OKgDUh+qADjp6sBnnHv++ydugdzMMmDUbrL7QOfIIgZ8
         tE1Iz3Oyn/72jjsj/8l2NXBqYR1+9G4LyLpasdS/Oe6GZmlbXTeqQ51X416ZdRcq+xiX
         gW+vcknLrt+2DnjPX9MZcc/WElWZVe1iDiwbVoUof6yp2acrbDnU5+c+Pd9ilDXfF5LM
         m3/Q==
X-Gm-Message-State: AOJu0YyFAM4RShcnKuHY5NcIiiFkA6gMuT8L4Ti4d30Y5xHJ9d+u4FjM
        xbzyPuJPrhqSyF1Le48hzsXUhg==
X-Google-Smtp-Source: AGHT+IEUEBgek6GqGcBQw9JPEGr/EOjPY1nRmeSrVXDWF27h8GC0nLXB3/Be8p+vpwpYsM4Ye9nsOw==
X-Received: by 2002:a50:d651:0:b0:54c:4fec:f1 with SMTP id c17-20020a50d651000000b0054c4fec00f1mr361610edj.128.1701438816710;
        Fri, 01 Dec 2023 05:53:36 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id d20-20020a056402001400b0054b531907f8sm1643159edu.73.2023.12.01.05.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 05:53:36 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ASoC: qcom: sc8280xp: Add support for SM8450 and SM8550
Date:   Fri,  1 Dec 2023 14:53:32 +0100
Message-Id: <20231201135332.154017-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201135332.154017-1-krzysztof.kozlowski@linaro.org>
References: <20231201135332.154017-1-krzysztof.kozlowski@linaro.org>
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

Add compatibles for sound card on Qualcomm SM8450 and SM8550 boards.
The compatibles were already documented.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/qcom/sc8280xp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
index 7df28ecefd65..837356ac541f 100644
--- a/sound/soc/qcom/sc8280xp.c
+++ b/sound/soc/qcom/sc8280xp.c
@@ -138,6 +138,8 @@ static int sc8280xp_platform_probe(struct platform_device *pdev)
 
 static const struct of_device_id snd_sc8280xp_dt_match[] = {
 	{.compatible = "qcom,sc8280xp-sndcard", "sc8280xp"},
+	{.compatible = "qcom,sm8450-sndcard", "sm8450"},
+	{.compatible = "qcom,sm8550-sndcard", "sm8550"},
 	{}
 };
 
-- 
2.34.1

