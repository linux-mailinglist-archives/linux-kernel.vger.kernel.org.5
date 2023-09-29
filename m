Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5547B356C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbjI2Ocw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbjI2OcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:32:15 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3948FCD0;
        Fri, 29 Sep 2023 07:32:10 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso1916950666b.1;
        Fri, 29 Sep 2023 07:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695997928; x=1696602728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUbuI3ctZezGQFs9q+kb+yJaHuWgpsp3o/CvTzIwMrw=;
        b=N2bZPpu9a2XMFDBI30fcTHanBfPSyB3ToqqR62vLEiVf8kb0P7ZCMIeMEEB/+clFTz
         BhrXRVlDrs1r/CRGuAT4wGdB4VFiKf1t/1eufLNT0EtDU77ZpLoHBY2OMJAE3TL73VlY
         AMOMMjCeaZRttM0g44BtpwyWBldCiGozlrh85vzwOeKepnQ1s1SXUo6+j0TbmkOik1ic
         CDKvUqTsYz+8S5SgBYJevg09pInJdfV4F9uS2MyUSRjluzAz7rrj54NdE/5rcBQEqkie
         YSwrnB8HRaL7JUdHkqsc/Q60ZB020Pv1C1QciwQuLcDFfWEUSZ9nX2oZvhz5Z7t+fs0x
         yq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695997928; x=1696602728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUbuI3ctZezGQFs9q+kb+yJaHuWgpsp3o/CvTzIwMrw=;
        b=vIEx4eMODIiJmBa8nvxFCnsJ8lP/PCm3cOcFUsnuAGxs+h+snwRJJzXN1iA+ztoC+I
         45bOZhT0wOT/VlAkSNG8/N3eSVHvmhQatOXTRD8W7ek0DF+CX0Q5fgVWEDmPikb93BZ4
         XkH9k8bTdvDk0ImdqIHv3+BMHZUOkqFoRmCINZ4CuGnSMbmjntLkF9OynDzS5MDw2Bc7
         kr3Gx0Se+VLHK4N5IbFUPlCYFq8wfTOR1aTZMhJ4agUx/uissAEpU1/AYMZybxfogAeF
         7E6JbTljAlTujK+jpnt/isEBfXid61cMzEmarOnGNTVK5vXDu3g+3QDS2tdoNqTIglmz
         9vdg==
X-Gm-Message-State: AOJu0YyAnqEKyix5df/uJE3fzj6a1bqCVfdRieTbk9OyW2KxxDp+DDwm
        ovLNIXppu4Kv78pGTvm3UJY=
X-Google-Smtp-Source: AGHT+IGh+LemyEyaQBGkZrJ5aOulho2NCPpS1QzvpKtYR/XRb04cxyQMCtgcH9ncV00S+HCWDxBqYg==
X-Received: by 2002:a17:906:a00f:b0:9b2:c2a9:357a with SMTP id p15-20020a170906a00f00b009b2c2a9357amr3980429ejy.68.1695997928566;
        Fri, 29 Sep 2023 07:32:08 -0700 (PDT)
Received: from primary.. ([212.34.12.50])
        by smtp.gmail.com with ESMTPSA id a7-20020a170906670700b0099293cdbc98sm12660105ejp.145.2023.09.29.07.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 07:32:08 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v8 07/14] USB: typec: tps6598x: Apply patch again after power resume
Date:   Fri, 29 Sep 2023 10:30:48 -0400
Message-Id: <20230929143055.31360-8-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929143055.31360-1-alkuor@gmail.com>
References: <20230929143055.31360-1-alkuor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abdel Alkuor <abdelalkuor@geotab.com>

TPS25750 PD controller might be powered off externally at power suspend,
after resuming PD controller power back, apply the patch again.

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
Changes in v8:
  - Use device_is_compatible instead of of_device_is_compatible
Changes in v7:
  - Add driver name to commit subject
Changes in v6:
  - Check tps25750 using is_compatiable device node
Changes in v5:
  - Incorporating tps25750 into tps6598x driver

 drivers/usb/typec/tipd/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 2598433a69cf..32e42798688f 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -1203,6 +1203,17 @@ static int __maybe_unused tps6598x_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct tps6598x *tps = i2c_get_clientdata(client);
+	int ret;
+
+	ret = tps6598x_check_mode(tps);
+	if (ret < 0)
+		return ret;
+
+	if (device_is_compatible(tps->dev, "ti,tps25750") && ret == TPS_MODE_PTCH) {
+		ret = tps25750_apply_patch(tps);
+		if (ret)
+			return ret;
+	}
 
 	if (tps->wakeup) {
 		disable_irq_wake(client->irq);
-- 
2.34.1

