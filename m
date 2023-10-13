Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBD17C8742
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 15:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjJMN4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 09:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjJMN4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 09:56:45 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD85BD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 06:56:42 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99c3c8adb27so338420566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 06:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1697205401; x=1697810201; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kFlDh2veCoYGtweA/suIrNJN5h1cgFkvvCUfEXmQbkY=;
        b=g9h3R8o7mLledtHrOdZekoiuEsrRPCH8TKNZ2CeG1kJZglolMXQNS+bNaERVslNkSk
         5+oWsBa9PeldBYZPkrsPRH+wXwUYj6RXygb+oi8PLZGpF1XXAdPSGZg7qr0jSCnw/fTi
         mlERjGSdXvhuqhCmShzbEfJcjd2Pkyjc5M9GOfcww/PD2q9h48X/gUDP0kBnRNYSFCJY
         qGTw4N9BddiJO5DIXkGay1HRM+R4B8B9leXdi+MWFjiRjSy18GYBMGWA5ptS1Yn//S24
         ygua53JTwx+Ou1rGRXW6ojirLB/e5D1w+98YbYbjHHwjFvk1814c65yMHzIebLVSF9L9
         A9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697205401; x=1697810201;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kFlDh2veCoYGtweA/suIrNJN5h1cgFkvvCUfEXmQbkY=;
        b=maMnauRAKL4G0ZIcitAGETe9hrmse69WSnmq3Re2hxO/A2OdJqOjUcYOj2qSL0gKvJ
         /t8xmaDewvoc1p+OCFO9+sFS0Mb8vV+b/dhmxPgXng4OT66/mczs7SUVOA8nIbD+94VK
         B7yFz+g4iFq7f7li4OuHXws5t+vKxdFTUwDCojJ3hPcsREsOWRZtDJ68PN1OOVqa2AuS
         QR2hUGRA8s8+vGzeq+GeOSFy6xQGwh7Zwr3ufittCFPvt2vc4lTQ3AKLBg9rUFLMze0S
         C5frJxJWdaAJg3EK5bU8/zliL/3l9MwYXvpMffh7/qDnsIAZ8kSNns8TCQglRyl4SXoF
         9iag==
X-Gm-Message-State: AOJu0YySmqA3v8wU+0IxaMFvC+pnU+V3YQAmUJll2Q0O2TSw/IbAsRV+
        S9BS7q5ZnUaI5s7x1n2ELeoXBQ==
X-Google-Smtp-Source: AGHT+IGCfaLV0dvw2Wye2KJWcfr3tAYEYcKYP8aDY0KLyDMq9dvsech9YulGhUztvUdwKOco42zbvw==
X-Received: by 2002:a17:907:a08a:b0:9bd:cab6:a34d with SMTP id hu10-20020a170907a08a00b009bdcab6a34dmr1171556ejc.31.1697205401106;
        Fri, 13 Oct 2023 06:56:41 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id j16-20020a170906051000b0099bcf1c07c6sm12462745eja.138.2023.10.13.06.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 06:56:40 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 13 Oct 2023 15:56:40 +0200
Subject: [PATCH] soc: qcom: pmic_glink_altmode: Print error when retimer
 setup fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231013-glink-altmode-ret-v1-1-77941537a35b@fairphone.com>
X-B4-Tracking: v=1; b=H4sIAJdMKWUC/x3MwQpAQBRG4VfRXbvlmiheRRaDHzcMzUhK3t1k+
 S3OeSjAKwLVyUMelwbdXYSkCfWzdRNYh2jKs9xIJoanVd3Cdj23fQB7nGwqEZS9wHYFxe7wGPX
 +n037vh+1bt8fYwAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can be useful to know with which return value the retimer_set call
failed, so include this info in the dev_err print.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/soc/qcom/pmic_glink_altmode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
index 9569d999391d..136713e1155e 100644
--- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -168,7 +168,7 @@ static void pmic_glink_altmode_enable_dp(struct pmic_glink_altmode *altmode,
 
 	ret = typec_retimer_set(port->typec_retimer, &port->retimer_state);
 	if (ret)
-		dev_err(altmode->dev, "failed to setup retimer to DP\n");
+		dev_err(altmode->dev, "failed to setup retimer to DP: %d\n", ret);
 }
 
 static void pmic_glink_altmode_enable_usb(struct pmic_glink_altmode *altmode,

---
base-commit: e3b18f7200f45d66f7141136c25554ac1e82009b
change-id: 20231013-glink-altmode-ret-3911e6c1eab5

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>

