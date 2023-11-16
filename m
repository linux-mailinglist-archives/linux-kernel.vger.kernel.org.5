Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559B67EE55D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 17:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344093AbjKPQoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 11:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjKPQo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 11:44:29 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8136D51
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 08:44:24 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4094301d505so7842195e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 08:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700153063; x=1700757863; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sDzOfYCdfGdhIwsTkT/XnXRFMX5EnP+LI41FMa/BEgU=;
        b=A5W8DmrAJ71QfvlWN1rgZdFw5x0ffp35576eJClXY8DSzCedNzsdYDhHFpy2Lw4N13
         xvCp/CRv0CaSUZnFMWHuTZdnxuZIdtSUNVdcm6OsnC2pg4DAUEz8J6i5l/v0AI0yvuNk
         8aisWWPsy2Mf9JrTt2exGeWKCf/jQaHK9pam3SCBIR24xJJNqVb4K1m2hVce/xibFZO7
         YgBNYLpP15euep2jFWQ0c1Skytfblx8x8V8SCooEWBy7VONqv1MmXVE15c2Ba2hlhmH1
         M5CXc+NzPxY/PXdgX8rUcU34zONPZe1THvFeyFWNuzfFBwFo1veQ2kDVz/F3wkp38zKg
         5tbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700153063; x=1700757863;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sDzOfYCdfGdhIwsTkT/XnXRFMX5EnP+LI41FMa/BEgU=;
        b=k5vYD5t/wp8aBxDsHbsDhuRusBsKmK6mDv+K4i1jbPV96hn+l4UK9JpNrOvzOMIz/L
         LWBUFWS9cwo6ux2tgP8I56Nf/6id7hg8fLGFA31E7zdQU8bQ4WHzD0vB1uawB9Rs3amQ
         2xm5FreTAsqeqQ/+ukRm/GJq0Rf29tezfmUtX3xZk7D/9YdVag/rsMrkp1gp8pGTrgIE
         90juJP6l3II/DtQ3n8SGocTKyV36EzdsGIJA02wXLDcwLcv/IVtIX3N7JQ3lxf/KEg6r
         o5kxn6WCv/1QQLmPCGvR4qCnf9LhDAg9QfzWawg1o0vjv1iVLi2zZeBN2rDPj4NPz7FB
         6mlg==
X-Gm-Message-State: AOJu0YwER6Fe/gIdj3SG2QPBz6CtVGjNY5dTs8rtJVmmv4n5dMK2YKVP
        Jh+CaHql1V6VKW0WsG+HcmiMlw==
X-Google-Smtp-Source: AGHT+IHn7OB0r9MkxAhFTonw+6qeVUoxgahqxWdmltXDSS2WfR4eRPqtvUnCGmh3o2tZVLIEgCLqMQ==
X-Received: by 2002:adf:f28e:0:b0:32f:7cea:2ea1 with SMTP id k14-20020adff28e000000b0032f7cea2ea1mr11101444wro.18.1700153063188;
        Thu, 16 Nov 2023 08:44:23 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id z8-20020a5d6548000000b0032da75af3easm14025882wrv.80.2023.11.16.08.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 08:44:22 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 16 Nov 2023 17:44:21 +0100
Subject: [PATCH] ASoC: codecs: lpass-tx-macro: set active_decimator correct
 default value
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231116-topic-sm8x50-upstream-tx-macro-fix-active-decimator-set-v1-1-6edf402f4b6f@linaro.org>
X-B4-Tracking: v=1; b=H4sIAORGVmUC/x2NQQrDIBAAvxL23IUYqTT9SunB6Kbdg1F2TRBC/
 l7pcWCYOUFJmBSewwlCByvnrYO5DRC+fvsQcuwM0zhZY4zDmgsH1PRo9xH3olXIJ6wNkw+SceW
 GPlQ+CCMFTr5mQaWKs43W2WVdrJuh14tQd//n1/u6fkmbvraJAAAA
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     krzysztof.kozlowski@linaro.org,
        linux-arm-msm-owner@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1388;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=4dAw4vqYtyZ3uH1NpDIOG5tDL7gWy8TiV101k/eDcNg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlVkbljrU4sS5DvYQUP+pgNOPnplVSf7WYMq9uttCK
 11awh6yJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZVZG5QAKCRB33NvayMhJ0TDpD/
 9r0Lt00io9LJH6n4fXgDoMEXeJBY8FYP+myiaoUUrYb3dqkBDWtdRWG1LV6jEeqMHd4T8F/Hp23wxc
 2Q/POMxLme9nsAtsOOrjyjLU7tyAnEb6/2roYm1uPobovuOrVyHg2RgZLP+dkG2v1PCwSVgHkOVl69
 zo14f8NIyWs+2hwU+9QjTD3gYHIX+RDhr8nVIZrpvwLaZ5GBozOeINNPURb1pTqyT5SwDdtZH+o0Zq
 zXFDkUP36NRbHeQDYGSTDgxlos+EuHQ7CeQSpKzVHZhAlIKkv5v9zkodLBSt2lBSXYQ2buwOGY3rQ1
 Tssp2A5+G+Fhu5PyzHqblyiRBUbJXwS9Ozp76mMN5HJdpw5XHWXz07QO9GrQhpHmRFLDkHy7aUvfYO
 Eh1WhZY1/dlhsu/czwEKpZArDf1v8AA2xo/5U3dkMOHo2NKXc/mep7B8wjOBVMJ0a0uPR/coB+n8V5
 IUYeZ3YFm00Z+u2sD5J1hVY8IghVUwk/bCehKQeEySg9JGRRfh+DwHrHVVjZNx6VcH39F2Cxw/MJGK
 J2YRkHwO0E/5LnNwRs4d4CBAZbAjlzFizr1cUAvdKcdZMYRh1y0G/dZkZr0pWh6DkxgwdlXpWpc2mv
 sk7vxggEojUHkvW6JwJ5NsDd4vAwNi1w3PoKSLZRN1qsKfuKeM0iCLk4u4OA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The -1 value for active_decimator[dai_id] is considered as "not set",
but at probe the table is initialized a 0, this prevents enabling the
DEC0 Mixer since it will be considered as already set.

Initialize the table entries as -1 to fix tx_macro_tx_mixer_put().

Fixes: 1c6a7f5250ce ("ASoC: codecs: tx-macro: fix active_decimator array")
Fixes: c1057a08af43 ("ASoC: codecs: tx-macro: fix kcontrol put")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 sound/soc/codecs/lpass-tx-macro.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 82f9873ffada..124c2e144f33 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -2021,6 +2021,11 @@ static int tx_macro_probe(struct platform_device *pdev)
 
 	tx->dev = dev;
 
+	/* Set active_decimator default value */
+	tx->active_decimator[TX_MACRO_AIF1_CAP] = -1;
+	tx->active_decimator[TX_MACRO_AIF2_CAP] = -1;
+	tx->active_decimator[TX_MACRO_AIF3_CAP] = -1;
+
 	/* set MCLK and NPL rates */
 	clk_set_rate(tx->mclk, MCLK_FREQ);
 	clk_set_rate(tx->npl, MCLK_FREQ);

---
base-commit: 5ba73bec5e7b0494da7fdca3e003d8b97fa932cd
change-id: 20231116-topic-sm8x50-upstream-tx-macro-fix-active-decimator-set-93d363bfb369

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

