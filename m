Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06369774C50
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbjHHVEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234998AbjHHVEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:04:13 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053476A69
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 14:03:21 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe655796faso4960740e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 14:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691528597; x=1692133397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QHqFXZ6x0OPm4ZMw7WQeV7WZNp4cmRIh/Av5DgwSNhQ=;
        b=GQUbyw4eRYjKwQkU5ZMU/yeNnQVDHGDQdMvp/qWJGIY57WAbwVGFi3beDujQ6DoFkD
         deiVVsvTtEZZT6uz3lACeVQkh5886v4aLsOAyuUfgqCdxir+SLFu3rEcv/obMnTgAxV6
         yeT6l1GhG/sudeo/uTTdKZ6jai9Xn4aKc26RgdSxgq++VhsSyRGJvplJDSb6NoUkD/GT
         n7gasiqw7oDvjknFzGddWUp60RVM3W+FruMhz6u1/NVVghH+5FQtkH0QLVLDIku2uxVB
         KXS6GSjqoyok0rp9k5ki1PYoDqyKfqxCOF6v9cL4guXjzVK7F5scYE3AT77rYIwvzera
         R0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691528597; x=1692133397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHqFXZ6x0OPm4ZMw7WQeV7WZNp4cmRIh/Av5DgwSNhQ=;
        b=GbUGAMj0IU0t2Ih/SUl4Gsf9VdEOSTtKk6Dh9+Ha2kTtAZ3d8J1TFoJoGkyblpwKlH
         6qWFmPAegUxJj2hCWYVqMkYnFT13gXYzSQw2CyfmGxNiLhOZ6EXaiqO01KAhqErUWSA2
         57q3hDhXnI8kWObMWv5ZlkWXcjuIB7Kuxa0iNXZNbAfDe9mAwGB/XLDjR/AGnM2Ve/+A
         scpCDj7Nyiv33DAajFPFHMaHJa3932OIQZ871LV7naqZfE5Mjbj0kxSczodK/s/vl48O
         QaDs84C6UepicHr7xHweKr6hWvGSlxQ/lf6k92Gv0ZqChQ2tl8tdm+1+6BQ6r8WNOST6
         c6vQ==
X-Gm-Message-State: AOJu0YzHrToIMNDd6TYgmXpWpRwfnB7zdRUAL1I271e/HlfcHZPcW50U
        X+8Yd7nLsh/O/PqQDIrIgjAMuQ==
X-Google-Smtp-Source: AGHT+IFIE0Szj/KgGDm5MrS0BWlSGQSLooWZrPv7OJdSkMIOa28C2Xb44HY47TOrwSvtshviQefZoA==
X-Received: by 2002:a2e:9d54:0:b0:2b9:dfd1:3808 with SMTP id y20-20020a2e9d54000000b002b9dfd13808mr460068ljj.25.1691528597563;
        Tue, 08 Aug 2023 14:03:17 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id h11-20020a2eb0eb000000b002b6cc17add3sm2431483ljl.25.2023.08.08.14.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 14:03:17 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 08 Aug 2023 23:02:52 +0200
Subject: [PATCH v2 14/14] drm/msm/a6xx: Poll for GBIF unhalt status in
 hw_init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230628-topic-a7xx_drmmsm-v2-14-1439e1b2343f@linaro.org>
References: <20230628-topic-a7xx_drmmsm-v2-0-1439e1b2343f@linaro.org>
In-Reply-To: <20230628-topic-a7xx_drmmsm-v2-0-1439e1b2343f@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691528566; l=1394;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=adxhdr38vQ+H8w1ud+VW4JLIkAtv3z4AL0XqkuOgPHs=;
 b=XQDGBxuHYfbbYepOx78RUkDMexkbi9oIwe5G+gOBDPTNfeODBiBmltLstJo8wG7FOZvlbmixK
 dJY8My1JyIxAjexcNUki8A3SAwf+Ej9E7lDVtfvwQXhZtaZ6C1DidhH
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some GPUs - particularly A7xx ones - are really really stubborn and
sometimes take a longer-than-expected time to finish unhalting GBIF.

Note that this is not caused by the request a few lines above.

Poll for the unhalt ack to make sure we're not trying to write bits to
an essentially dead GPU that can't receive data on its end of the bus.
Failing to do this will result in inexplicable GMU timeouts or worse.

This is a rather ugly hack which introduces a whole lot of latency.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # sm8450
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 2313620084b6..11cb410e0ac7 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1629,6 +1629,10 @@ static int hw_init(struct msm_gpu *gpu)
 		mb();
 	}
 
+	/* Some GPUs are stubborn and take their sweet time to unhalt GBIF! */
+	if (adreno_is_a7xx(adreno_gpu) && a6xx_has_gbif(adreno_gpu))
+		spin_until(!gpu_read(gpu, REG_A6XX_GBIF_HALT_ACK));
+
 	gpu_write(gpu, REG_A6XX_RBBM_SECVID_TSB_CNTL, 0);
 
 	if (adreno_is_a619_holi(adreno_gpu))

-- 
2.41.0

