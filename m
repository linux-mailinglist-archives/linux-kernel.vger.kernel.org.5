Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45327CBCFF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbjJQIAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbjJQIAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:00:35 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2C9FF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:00:28 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53db3811d8fso11152041a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 01:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1697529627; x=1698134427; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nBYtQLiZ5RB4OSac9xrnHTxrEXkSr1E/izR9K8kO0uY=;
        b=ZB6l7pESFKFD8Ixh/gcGKrj8uAwJAIZMcJzlXYJLGa8h4/e8djQ3df5YAFFy2co7ly
         M1cQE30YqWZWFRNYXwpudlZjvxtsnXvLUc19HJcXwUPhtEEGz4D716kuNr+RD7q6FN1k
         VE0hxU8TF9uAYLnTK0pi23e6LqyEXy9hRyxx+5hKfhdGd5Npb6iIsKBPXAGZN2KwTFIh
         VhF4B4nFeR/tF2pIoXJseqcZNihDS2xK2KoKS1do9Ta95/i2r4Y+ASRrmu+gApojjFju
         Kg0j280Xs2q8G21jp9TXECrcAqKp9+ZWmrVuAfQxp+cR+7fRopSsE58PKEV85EZ7DnMI
         nbmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697529627; x=1698134427;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nBYtQLiZ5RB4OSac9xrnHTxrEXkSr1E/izR9K8kO0uY=;
        b=Vrhk/MkCmgR2+3Wb/CspBOafrNcI5gNdelefEMFpZ0kyZXF4e2O1jrGFYQIH03ru95
         8wFp5mVw78XNWpGhopPC/Ur7olW+vK7NkOKGEk1GqCilsQF2TQOZnngkI4Pdvxzwd0i3
         FYZ9OMWnqDrvJfXl9fwftdFXv+QJb4wf+CBbvGWCgVptLCWfGmrJVxUobwtlcmgvxLFs
         H7xL8Pr8DbNXIH8g4CnRzjxUvEEHMbt2iL/okzdIMKAktNMSXmUvWXR0Fk/yn3csxETO
         xU1esdjUjAPzbppVgVE0FMCe28hpMqraRYtK/c8bVH9eejslK6Lvf2MJBi+w6nHTfadf
         9FlQ==
X-Gm-Message-State: AOJu0YwhBhkpePoFRy/M/eoHa6geGLi77qOi/MbP3h7IQljTDkkUBdUz
        KSu/i9sQrAeSNukiRwahcS8KDN9bkGzlHJHExM0Mdw==
X-Google-Smtp-Source: AGHT+IF3O+tPGmdIpZqs0l2cGcskV6IjZnudEtO0W9v8N+CqBJA+5x1fNuHZohpF4FQjSiwk7axPRQ==
X-Received: by 2002:a50:9996:0:b0:523:2e23:a0bf with SMTP id m22-20020a509996000000b005232e23a0bfmr1035714edb.11.1697529626646;
        Tue, 17 Oct 2023 01:00:26 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id s23-20020a508d17000000b00536031525e5sm718625eds.91.2023.10.17.01.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 01:00:26 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Tue, 17 Oct 2023 10:00:23 +0200
Subject: [PATCH v2] soc: qcom: pmic_glink_altmode: Print return value on
 error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231017-glink-altmode-ret-v2-1-921aa7cfc381@fairphone.com>
X-B4-Tracking: v=1; b=H4sIABY/LmUC/32NQQ6CMBBFr0Jm7RiGWgmuuIdhUWCgE6ElLSEaw
 t2tHMDle8l/f4fIQTjCI9sh8CZRvEtQXDLorHEjo/SJocgLRTkpHCdxLzTTOvueMfCKqiLie0d
 sWg1ptwQe5H02n01iK3H14XNebPSz/2obIWFZVjfSqjRKt/VgJCzWO752fobmOI4vpeV2U7YAA
 AA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can be useful to know with which return value for example the
typec_retimer_set call failed, so include this info in the dev_err
prints.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v2:
- Add ret to print in more prints, not just typec_retimer_set (Bjorn)
- Link to v1: https://lore.kernel.org/r/20231013-glink-altmode-ret-v1-1-77941537a35b@fairphone.com
---
 drivers/soc/qcom/pmic_glink_altmode.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
index 9569d999391d..0a75bfac5e02 100644
--- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -160,7 +160,7 @@ static void pmic_glink_altmode_enable_dp(struct pmic_glink_altmode *altmode,
 
 	ret = typec_mux_set(port->typec_mux, &port->state);
 	if (ret)
-		dev_err(altmode->dev, "failed to switch mux to DP\n");
+		dev_err(altmode->dev, "failed to switch mux to DP: %d\n", ret);
 
 	port->retimer_state.alt = &port->dp_alt;
 	port->retimer_state.data = &dp_data;
@@ -168,7 +168,7 @@ static void pmic_glink_altmode_enable_dp(struct pmic_glink_altmode *altmode,
 
 	ret = typec_retimer_set(port->typec_retimer, &port->retimer_state);
 	if (ret)
-		dev_err(altmode->dev, "failed to setup retimer to DP\n");
+		dev_err(altmode->dev, "failed to setup retimer to DP: %d\n", ret);
 }
 
 static void pmic_glink_altmode_enable_usb(struct pmic_glink_altmode *altmode,
@@ -182,7 +182,7 @@ static void pmic_glink_altmode_enable_usb(struct pmic_glink_altmode *altmode,
 
 	ret = typec_mux_set(port->typec_mux, &port->state);
 	if (ret)
-		dev_err(altmode->dev, "failed to switch mux to USB\n");
+		dev_err(altmode->dev, "failed to switch mux to USB: %d\n", ret);
 
 	port->retimer_state.alt = NULL;
 	port->retimer_state.data = NULL;
@@ -190,7 +190,7 @@ static void pmic_glink_altmode_enable_usb(struct pmic_glink_altmode *altmode,
 
 	ret = typec_retimer_set(port->typec_retimer, &port->retimer_state);
 	if (ret)
-		dev_err(altmode->dev, "failed to setup retimer to USB\n");
+		dev_err(altmode->dev, "failed to setup retimer to USB: %d\n", ret);
 }
 
 static void pmic_glink_altmode_safe(struct pmic_glink_altmode *altmode,
@@ -204,7 +204,7 @@ static void pmic_glink_altmode_safe(struct pmic_glink_altmode *altmode,
 
 	ret = typec_mux_set(port->typec_mux, &port->state);
 	if (ret)
-		dev_err(altmode->dev, "failed to switch mux to safe mode\n");
+		dev_err(altmode->dev, "failed to switch mux to safe mode: %d\n", ret);
 
 	port->retimer_state.alt = NULL;
 	port->retimer_state.data = NULL;
@@ -212,7 +212,7 @@ static void pmic_glink_altmode_safe(struct pmic_glink_altmode *altmode,
 
 	ret = typec_retimer_set(port->typec_retimer, &port->retimer_state);
 	if (ret)
-		dev_err(altmode->dev, "failed to setup retimer to USB\n");
+		dev_err(altmode->dev, "failed to setup retimer to USB: %d\n", ret);
 }
 
 static void pmic_glink_altmode_worker(struct work_struct *work)
@@ -397,7 +397,7 @@ static void pmic_glink_altmode_enable_worker(struct work_struct *work)
 
 	ret = pmic_glink_altmode_request(altmode, ALTMODE_PAN_EN, 0);
 	if (ret)
-		dev_err(altmode->dev, "failed to request altmode notifications\n");
+		dev_err(altmode->dev, "failed to request altmode notifications: %d\n", ret);
 }
 
 static void pmic_glink_altmode_pdr_notify(void *priv, int state)

---
base-commit: e3b18f7200f45d66f7141136c25554ac1e82009b
change-id: 20231013-glink-altmode-ret-3911e6c1eab5

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>

