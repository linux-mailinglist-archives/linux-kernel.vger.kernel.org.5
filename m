Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EF880C88C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 12:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbjLKLlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 06:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbjLKLkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 06:40:55 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20836D0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 03:41:01 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c2bb872e2so40154855e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 03:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702294859; x=1702899659; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cMvA/ANtahW+hb9oH+xQ7G9xSFgd/krQcWaU1bteuv4=;
        b=nBB0QM99ztLXI6RgbXCeVBuDP5ZoSF1RDANFe1/qh2EyTu7BBG6Jogth/vdj+5B18q
         LN7U6iryl2Z73mg8sBiVCOHTdL7aCQgVGu2/wBQwPolxbO4dEOmd+1jXlWmQElSoixWG
         8/LhnQFZoR8uM7NJbqAUOVxzfx6S4c71RvzNjlhKZY++mjau7Y128eVW8K+X+OnbCdlG
         b+JoElNnYgvlu56iNYf1PLpbtnL4Sjp/vIHOjfEqNiNY9AISbVbYcDR6bwjbp+C08D7x
         cQo8ImCsdmvi55Zl16MSxyzkiBjxn+dakk2sZ9EpdNeL2Q2I3NyO7e4auO5NO5PRq3Iw
         xqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702294859; x=1702899659;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cMvA/ANtahW+hb9oH+xQ7G9xSFgd/krQcWaU1bteuv4=;
        b=j28q3OgGxJ+52QkkSOXKoEBdDGfQmf9uyFGQy6RmDopKgrfAjstfqK+zwHXvDPzSVa
         MQELxnc++gV7IFbmI6dhzDq06mAB0Em9zP/0VbpxkEIKZgkWof7xjoP/K84KT1ZjLKO5
         fkoU41DKNiDqhuE2yJtniR4R+kBv+HBnNomi6dYv7eLejHN8ByN72JnEVSUAtbxyRgL/
         wz1JNBUS7Wd/zX1ib4mszvf5SUk9Eu/ZPD4lc/lZXDFVvROtRCMA0dfW2XTw7Q0koAhB
         GPiGi3mx4qzUT8HroEcKm0AIZRi8mL3IR4ndIN7c37yh2kIXRdP2GqOGdJlRsYig+BSu
         G+HA==
X-Gm-Message-State: AOJu0YxlmVpNK5ueE9pHn6kGYUwTmuyBcH2MvdNfXknZJf/BLcHQs3YE
        tZww94Wy8QFdID5UdQGsAyfm/r4cs8Mujiz5+tGzVr/v
X-Google-Smtp-Source: AGHT+IGEjB1saOzLbqjUnbbOLBg/lh3L6Ga+lymW3L4n04g9lWLUrFnJl2hsCTDEre3MRludqgGqdw==
X-Received: by 2002:a7b:ce8b:0:b0:40c:3270:ec9a with SMTP id q11-20020a7bce8b000000b0040c3270ec9amr1089805wmj.349.1702294859472;
        Mon, 11 Dec 2023 03:40:59 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c468700b0040c420eda48sm6178883wmo.22.2023.12.11.03.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 03:40:59 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 11 Dec 2023 12:40:57 +0100
Subject: [PATCH] ASoC: codec: wsa884x: make use of new
 mute_unmute_on_trigger flag
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231211-topic-sm8x50-upstream-wsa884x-fix-plop-v1-1-0dc630a19172@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEj1dmUC/x2N0QrCMAwAf2Xk2cBSlRZ/RXwIMWrAraXZtDD27
 xYfj4O7DVyrqcNl2KDqx9zy3IEOA8iL56ei3TtDGMORAhEuuZigT6mdR1yLL1V5wq9zSqeGD2t
 Y3rkgR47CUSWQQI+Vqt39R9fbvv8AkBnT3HgAAAA=
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1958;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=O686kNPfhDqyBc+yvwfM+enx5jWXb5MAlOqcdwFA5+M=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBldvVKCbZAQnrutsDlCbNPOPYiveBzyrvr8dCS2rbw
 arXbjQ+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZXb1SgAKCRB33NvayMhJ0YCuD/
 4iq4pN/CJwoFmazc6CD98pcr/TlK3oH4npma/Gs2B+MZTt+bseIgVjy7pKgNTjE5vrvEw3+bq+MRJ2
 Cp4uZw2wpfsoKXt+BCvBbJvYc9O51e+8ffKK1N7dviP5eGURT6e3y/lfftkg508YRt9n+tfKV17FMt
 2UsrqH4vi7QSxaDs2a0ucGSeMY6oGIMLeeNTdLxOE6Uz+Cbm79efoq4AcFRI4Rva8fAn7AbvGpKFVj
 ts4dpZNYV+baK1SHjl5/t6+JjVQCitZlZ5PzMdKRVtjLDIBvT1NG4Rv0W9Q6ww4xF90o9BZaNL4vla
 xlShjZLc6AH/UtbGt3J37/yI1nwiA6ueJbVd9Gq9O92uUiyysiIfwz4pelB4sBCKJv9n4Zdmct0t+v
 CnrpMcB9wbJe1ftEXAOeD52qjAQA56HcmtIMK5cbJveK063an5mP5Hdlay1jWE3FSIikfRZHa9agV+
 +kqkQZ4WeqA6P1rNmkZZCsbKJ2XyfRpOU8uwPT6xdphNGLBmwLPQ90U+nO1G8larZowOHxqqncpcdD
 D4yDelhqVet0n8HyvlL8nWTsNATliDsDuM1HtcwXhOVIN0oqvtxXNSiXoteSyYdcA9nQHbPTUHryUT
 RAFidOJ9l8TCF1wXxCjQNzJb3LtXXeaZrLMX96ICC51k4smRFJOCddjRq90A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fix is based on commit [1] fixing click and pop sounds during
SoundWire port start because PA is left unmuted.

making use of new mute_unmute_on_trigger flag and removing unmute
at PA setup, removes the Click/Pop issue at SoundWire enable.

[1] 805ce81826c8 ("ASoC: codecs: wsa883x: make use of new mute_unmute_on_trigger flag")

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Fixes: aa21a7d4f68a ("ASoC: codecs: wsa884x: Add WSA884x family of speakers")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 sound/soc/codecs/wsa884x.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wsa884x.c b/sound/soc/codecs/wsa884x.c
index 993d76b18b53..f2653df84e4a 100644
--- a/sound/soc/codecs/wsa884x.c
+++ b/sound/soc/codecs/wsa884x.c
@@ -1654,15 +1654,9 @@ static int wsa884x_spkr_event(struct snd_soc_dapm_widget *w,
 		snd_soc_component_write_field(component, WSA884X_PDM_WD_CTL,
 					      WSA884X_PDM_WD_CTL_PDM_WD_EN_MASK,
 					      0x1);
-		snd_soc_component_write_field(component, WSA884X_PA_FSM_EN,
-					      WSA884X_PA_FSM_EN_GLOBAL_PA_EN_MASK,
-					      0x1);
 
 		break;
 	case SND_SOC_DAPM_PRE_PMD:
-		snd_soc_component_write_field(component, WSA884X_PA_FSM_EN,
-					      WSA884X_PA_FSM_EN_GLOBAL_PA_EN_MASK,
-					      0x0);
 		snd_soc_component_write_field(component, WSA884X_PDM_WD_CTL,
 					      WSA884X_PDM_WD_CTL_PDM_WD_EN_MASK,
 					      0x0);
@@ -1786,6 +1780,7 @@ static const struct snd_soc_dai_ops wsa884x_dai_ops = {
 	.hw_free = wsa884x_hw_free,
 	.mute_stream = wsa884x_mute_stream,
 	.set_stream = wsa884x_set_stream,
+	.mute_unmute_on_trigger = true,
 };
 
 static struct snd_soc_dai_driver wsa884x_dais[] = {

---
base-commit: bbd220ce4e29ed55ab079007cff0b550895258eb
change-id: 20231211-topic-sm8x50-upstream-wsa884x-fix-plop-a7a7ca7ec21c

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

