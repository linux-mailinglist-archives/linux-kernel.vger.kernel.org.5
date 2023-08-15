Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F4977CDBA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237493AbjHOOBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237431AbjHOOAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:00:40 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1091199A;
        Tue, 15 Aug 2023 07:00:38 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5231410ab27so7095398a12.0;
        Tue, 15 Aug 2023 07:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692108037; x=1692712837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mZoNnewKQDmbxD48rcfjhqVVmaStyll33cRTzymWNU=;
        b=QpFAZ4qKDgw+pEskJQpnti+erQcjjvbcgl2qfbt8mFW0noSyrgBGfX9BkaBHknfLMR
         wZoZqiEW+93B9oDwZZdZNuyCA649B3wc9/P9eD+7LCXjzY8SA1NmfLiS9dUbiXTqfKFA
         tNlK6aPpk/sSwDuET12vedI3OJvpkRMvIPvQQwf0A84tQ2Hv5X2BIsaLO1LZE2Z5Lvl/
         i+cgnP0oDNyj2CHVQ5yBAM4QirRK+5XugNl+V48lmMIsJLZioCciRxIOfvbSC9DfIAgg
         XVJls/3H3/890cs0EW1nAb+MHws0P/6W7ccU7U4zpxFvTzCSd/mQnh93pYcUpVmZcN5/
         uIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692108037; x=1692712837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mZoNnewKQDmbxD48rcfjhqVVmaStyll33cRTzymWNU=;
        b=BT5WXqICk97+PRqSmtVHYVFC6+8x5dnCPb9xlELkGGbr8bGA1nTJLroYEW4GjuDF9e
         gSQtYfIySgfV3Nd5KbxdOEHpbspvM7/53XH0jlYBXi5LDLwSGviq4JV5oZ4BXgW4cter
         c4s572kThm8Q8aGfZhB2UwrBrOrcq5te4Kux3VPsblQpPmjhkzd0O6Q7sCO0TmP9PneE
         Ms1POauDM2vGwDe5SprI2FQL2OvcOdoBI1j/vbgPn24u+Uc6JID7hiZDKHxT9RD8tUXh
         JqgxOrINdlYFAIn3b7U0tFCsIORgKS42+YpWJxc2NEBkE3RokTx6w2KRjGhB8Ey7viqI
         +U4w==
X-Gm-Message-State: AOJu0YyzC4z/xH8/EMKCPGK8xs8e7aDWxzZkKTpzr2xR3TqJI6s/y+Rx
        4cPw7J7jCbutdGuETdPE+0I=
X-Google-Smtp-Source: AGHT+IE0E4oixKaZbCWGOYt5Rzkyjigj39Arszy2GW/HFD8p/g6uUY1YAEWFCoOlgPAAE2RBNR3RxQ==
X-Received: by 2002:a05:6402:12d8:b0:523:2274:91cb with SMTP id k24-20020a05640212d800b00523227491cbmr9688003edx.12.1692108037121;
        Tue, 15 Aug 2023 07:00:37 -0700 (PDT)
Received: from fedora.. (dh207-96-14.xnet.hr. [88.207.96.14])
        by smtp.googlemail.com with ESMTPSA id a26-20020aa7d91a000000b00525740aa68dsm1049042edr.36.2023.08.15.07.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 07:00:36 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, quic_gurus@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     computersforpeace@gmail.com, Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 3/5] firmware: qcom_scm: disable SDI if required
Date:   Tue, 15 Aug 2023 15:59:36 +0200
Message-ID: <20230815140030.1068590-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815140030.1068590-1-robimarko@gmail.com>
References: <20230815140030.1068590-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPQ5018 has SDI (Secure Debug Image) enabled by TZ by default, and that
means that WDT being asserted or just trying to reboot will hang the board
in the debug mode and only pulling the power and repowering will help.
Some IPQ4019 boards like Google WiFI have it enabled as well.

So, lets use the boolean DT property to disable SDI during SCM probe.
It is important to disable it as soon as possible as we might have a WDT
assertion at any time which would then leave the board in debug mode,
thus disabling it during SCM removal is not enough.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/firmware/qcom_scm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index abb54df663ea..71d886626233 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -1491,6 +1491,12 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	if (download_mode)
 		qcom_scm_set_download_mode(true);
 
+	/*
+	 * Disable SDI if indicated by DT.
+	 */
+	if (of_property_read_bool(pdev->dev.of_node, "qcom,sdi-disable"))
+		qcom_scm_disable_sdi();
+
 	return 0;
 }
 
-- 
2.41.0

