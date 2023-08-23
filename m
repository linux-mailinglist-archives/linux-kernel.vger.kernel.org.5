Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857C57855BB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbjHWKp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbjHWKpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:45:07 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB9BE71
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 03:45:02 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31c4d5bd69cso2706580f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 03:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692787501; x=1693392301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMd5xa502zq+zJtKRyAW8i5LwxGHRj3qKCAl3AH36Ls=;
        b=kRX+keFShYoh3ikMrf8cieD3HTIbEKNjElXdJfca5/STD+euldcxH9lQw+TGrRxUET
         663qZveXENmbbe8vJjAgTfwx/sYchdjMcpSYv2uvPbeHu35inNNTglkSaUNWHf2ZL4QI
         V1+piWmnj8CCcrRA3spBcxae2v3j70cPp5W4I03E11KbYRq/B/2nis/jvNWtmXIIlCFI
         LXXg8lLQoYSm0cbaHiAn9H6oBhNmgPOo3Vc5VCiKWLFSU3qgSV914GQImUZybOiwQhv/
         YV4jskSpJFlKZFU2I0Vcv2Kfsc9EndnEtR4lRhw35QGQGwGGZCTx2MOxa1zbuvl4R3ce
         1UoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692787501; x=1693392301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMd5xa502zq+zJtKRyAW8i5LwxGHRj3qKCAl3AH36Ls=;
        b=Wnm+iqBmaheF6CSgG74V6XrifddklCcX47k4ALJh47hWf+Js6aC7HpRdxjih0janpO
         q4DzW2RYJ7+E/TPcPz8EA8EOJVHX4/sq+HeuonFf5iFfqy/n8xFb/ocrrpSohh2ff+25
         +B2wmaQRMVnzHZ22W3sg2N+f61DU/Olrio6bNHyHfMGKb3q46WWSDnBQcRhKhsUUFtCe
         MpLN5ptFcay6sHzVb52ZshagEI9lbvpXO74Htvb01TC973teqcgcPe7JE5D6YzhMNm8X
         Q1gy0LZkGHDV7TeeUipSURILPYlRIB1IMFxAEfFRT99+4OPVCBAmTwMKimV9Ore+soQ0
         Lnfg==
X-Gm-Message-State: AOJu0YxinmA5rgInm46k/ux378gvVZwTu24GeoGyjaPfxPaJqDNMVqkP
        vFGOhd08mEVJ1bgw2gEbpZsB1A==
X-Google-Smtp-Source: AGHT+IGtFeJIM5mGqGxuAXbxR9IEjUJ9fiJWEwAXZ4bsSILfwimb94qbYymylV3hO3wxz5YYWRej1w==
X-Received: by 2002:adf:dcce:0:b0:319:6b6c:dd01 with SMTP id x14-20020adfdcce000000b003196b6cdd01mr9885635wrm.17.1692787500902;
        Wed, 23 Aug 2023 03:45:00 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d4204000000b0031c5dda3aedsm6281213wrq.95.2023.08.23.03.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 03:45:00 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/15] media: qcom: camss: Improve error printout on icc_get fail
Date:   Wed, 23 Aug 2023 11:44:38 +0100
Message-ID: <20230823104444.1954663-10-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823104444.1954663-1-bryan.odonoghue@linaro.org>
References: <20230823104444.1954663-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If icc_get() fails print the name of the failing path.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index c8b8ad176ee2b..72a0a9f304bb2 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -1504,8 +1504,11 @@ static int camss_icc_get(struct camss *camss)
 	for (i = 0; i < camss->res->icc_path_num; i++) {
 		camss->icc_path[i] = devm_of_icc_get(camss->dev,
 						     icc_res[i].name);
-		if (IS_ERR(camss->icc_path[i]))
+		if (IS_ERR(camss->icc_path[i])) {
+			dev_err(camss->dev, "Unable to icc_get %s\n",
+				icc_res[i].name);
 			return PTR_ERR(camss->icc_path[i]);
+		}
 	}
 
 	return 0;
-- 
2.41.0

