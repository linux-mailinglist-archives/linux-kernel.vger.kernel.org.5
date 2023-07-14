Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BF4753B35
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbjGNMlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235543AbjGNMk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:40:58 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846F52700
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 05:40:54 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fa48b5dc2eso3127927e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 05:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689338453; x=1691930453;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F7FQbwznFAgSuJA/t4/9pBXIFBPKIZ2SvpdmR44YbXo=;
        b=T0H7JJ/JlofO75mAdVZUhbppOBZQ25vIQUa+PTi2PYu7XWz78iBjEymc8DtZi/WEKK
         ZLJHngug7Tse5yc3arMuVrE91yIAtGfNt2H45MPWtWuSPjluppQNy3po0KXgRYef/qDh
         GdzyA2fsz45bOwLtDkNhmWh5ev0T7gygjz1rGU55lJOdYKWNWfP7uMgCBOHGLgx2niav
         I+Vfdfhmdi3iMlHPFCaObjsY6/cqD0j/6fGOLzfcIaHoO07G7G15xuVAULEP5enq/QOd
         rdGRW9BfFKi2nDH9NJd6ccmfpAQWcrvxNi6LnfRaE3MzoBHpRjeS52yInhTH/ytLIp7O
         CsTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689338453; x=1691930453;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7FQbwznFAgSuJA/t4/9pBXIFBPKIZ2SvpdmR44YbXo=;
        b=axRc+5wfau66ElNthvQsf3kIbVBJM0JKbKN42U+Hq9DedS+WLDsoWWX/Wr/R7D/6ky
         Hh3XycYHiRg/M011S4mDXsRivqvjuto/0pNZbix01cp4IvCbDwDUn3ON8GcfOp1P1RNH
         KoA7cjit3do3NjYTL6BloG+IM3bqnEtC+T0eo5r6UcwneJnCS0noYMynTB8DzJtoI6MB
         SoOlBruecCAWctm9vbBca8sxv7Incph1OwWLbI8oIRY4HPgXNeFO0IgPb1pxV00+5dC2
         XqRBhQu/WQrD6cBoGufx0Ym1AZRmzsq8bpE8OrS2SbVLrzN3PeJu3JBGoniwUKvN24x9
         EbYg==
X-Gm-Message-State: ABy/qLZTR149Gd6dotxPMEutXFyopDMXR29TIGiJiKdeg1UvTGE4smm4
        4CoMYWggiVsmVlElWOTmjoW9eg==
X-Google-Smtp-Source: APBJJlHuq18fcKx2UbRe39iWRACZta+eHtXupAKnhYJXXUJ/Y2M2tRCAirfr2e6+YsFAQBlLXurG4g==
X-Received: by 2002:a19:710a:0:b0:4fb:7c40:9f95 with SMTP id m10-20020a19710a000000b004fb7c409f95mr3007848lfc.47.1689338452705;
        Fri, 14 Jul 2023 05:40:52 -0700 (PDT)
Received: from [192.168.1.101] (abxj146.neoplus.adsl.tpnet.pl. [83.9.3.146])
        by smtp.gmail.com with ESMTPSA id b6-20020ac25e86000000b004fb2244563fsm1482588lfq.289.2023.07.14.05.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 05:40:52 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 14 Jul 2023 14:40:46 +0200
Subject: [PATCH 1/3] pinctrl: qcom: lpass-lpi: Make the clocks optional,
 always
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230714-topic-lpass_lpi_cleanup-v1-1-dc18b5bd14f7@linaro.org>
References: <20230714-topic-lpass_lpi_cleanup-v1-0-dc18b5bd14f7@linaro.org>
In-Reply-To: <20230714-topic-lpass_lpi_cleanup-v1-0-dc18b5bd14f7@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689338449; l=1172;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=JjuJ8qCad7hrRpLN/xAgdh9in9df+oYi9FZ5wdlA/hQ=;
 b=3ikJXtJU50n5Ipa+iXkN77TNrKupAYLU+H3w/WnEq4vokZTXxAiSq9HAlEkvXq6tOH7jZug8M
 GKaTTr7O7WuBVQ7kpxLhAASLGFyCNXYdNF7PYaLvvbEUffy+CIRFX0O
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms provide a single clock source to all LPASS peripherals,
others provide two, and there are probably others that provide it through
magic invisible-to-Linux wires.

Rely on bindings to mandate the adequate number of clocks necessary.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
index fdb6585a9234..6cf6c734db17 100644
--- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
@@ -438,11 +438,7 @@ int lpi_pinctrl_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(pctrl->slew_base),
 				     "Slew resource not provided\n");
 
-	if (of_property_read_bool(dev->of_node, "qcom,adsp-bypass-mode"))
-		ret = devm_clk_bulk_get_optional(dev, MAX_LPI_NUM_CLKS, pctrl->clks);
-	else
-		ret = devm_clk_bulk_get(dev, MAX_LPI_NUM_CLKS, pctrl->clks);
-
+	ret = devm_clk_bulk_get_optional(dev, MAX_LPI_NUM_CLKS, pctrl->clks);
 	if (ret)
 		return ret;
 

-- 
2.41.0

