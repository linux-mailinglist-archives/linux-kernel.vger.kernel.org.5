Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F777978FC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238411AbjIGQ7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbjIGQ7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:59:30 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2BA1FD2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:59:03 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bceca8a41aso19981441fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694105872; x=1694710672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IGORlEL+j7QOCTKX6XyQpE4GsPUdQpP3Lht2awpSqA=;
        b=dvpnDOAGqyIulgWWS55DvTHqts2W7Vm9HF5zs+1NFwr6WiOfTFU4Njysu850kgnyBO
         kVqGoYvY63vnzOZhtdV7cFOJNQAVRwBIRB82JjM5O7xKV0imazrBuZE/CQvqohUvCsTW
         AwbrVN9FIajQTcPUeNGJDo6lJRt71fEE9sY4M39khZ0KYecqszrTyVo+HHusSE3ZKYH2
         Qhizx+2Y9U/DvjVTUPD2bCIbgZ/ykclR/1IX62fvJkyH+9xZTYECKli4gdIpA6v/j8I1
         LQfF9dgklmpOrqKsFl7I7LF4k4EPDfSpkQ/Muw/D2huEcm53VA2rFWKu567ekYdKq24h
         i1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694105872; x=1694710672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3IGORlEL+j7QOCTKX6XyQpE4GsPUdQpP3Lht2awpSqA=;
        b=W7VqYrQZ0hybCKP1KgO4p4C/vdYXKgueWX+7yAO/K3caCmaPD+lsn/f/yLPwyq81ce
         7ndDOOVzMVqlf3wplohsFAZdiHklQAqNCX0gYtB2RNE/t8/w3tLVuA4SYc8qXjI+XopY
         5meBdHktoob13KuKHmUjJ3RLvgz28Kt9TV7gFd0mXBcS+faLpFqcPcdyyayLH8mDWNJh
         HERRJIjpvlJMuXEFS1ycjafx+KuMBLbmwe+0VzW4m5gvq8ImGQ34ldSZn3djpla9bRbz
         wlRcyxjK5zphLB43YIInehMrH0IZyX9He2dRewGlDCREacssxYTqfMhzpzIfKnup+9PI
         Ek+A==
X-Gm-Message-State: AOJu0YxU2oF48F0NK0I3h+2CvLSsv9Mw6BQFGgrzxIy0diOEtC7T3svy
        H/Ot0UamK0s0h/tOEI4lUpQ2L/QaBb1KzqBqdes=
X-Google-Smtp-Source: AGHT+IFFhtFOfyjIUjTQaoISN3ahU3GulYsY3a4nJuObsLIa20hRbGZNlKWDpuep8zKWObREFaQEoQ==
X-Received: by 2002:a5d:6504:0:b0:31a:d4a9:bdac with SMTP id x4-20020a5d6504000000b0031ad4a9bdacmr948wru.11.1694105072392;
        Thu, 07 Sep 2023 09:44:32 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d15-20020adffd8f000000b00317ab75748bsm23822145wrr.49.2023.09.07.09.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 09:44:31 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 13/17] media: qcom: camss: Fix support for setting CSIPHY clock name csiphyX
Date:   Thu,  7 Sep 2023 17:44:06 +0100
Message-ID: <20230907164410.36651-14-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230907164410.36651-1-bryan.odonoghue@linaro.org>
References: <20230907164410.36651-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several of our upstream and soon-to-be upstream SoC CAMSS dtsi declare
csiphyX as opposed to the older clock name csiX_phy.

Right now the CAMSS code will fail to set the csiphyX clock even if we have
declared it in our list of clocks. For sdm845 and sm8250 we appear to "get
away" with this error, however on sc8280xp we don't.

The right approach here is to set the clock when it is declared. If a SoC
doesn't require or a SoC driver implementer doesn't think we need, then the
clock ought to simply be omitted from the clock list.

Include csiphyX in the set of permissible strings which will subsequently
lead to the csiphyX clock being set during csiphy_set_clock_rates() phase.

sdm845 and sm8250 will work with the code as-is so I've omitted this from a
suggested Fixes list.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-csiphy.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
index 87d6d65aa90cf..5202bfcdbc35a 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
@@ -677,6 +677,10 @@ int msm_csiphy_subdev_init(struct camss *camss,
 				if (csiphy->rate_set[i])
 					break;
 			}
+
+			csiphy->rate_set[i] = csiphy_match_clock_name(clock->name, "csiphy%d", k);
+			if (csiphy->rate_set[i])
+				break;
 		}
 	}
 
-- 
2.41.0

