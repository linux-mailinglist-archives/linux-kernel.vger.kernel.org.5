Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFE777FA63
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352870AbjHQPJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352917AbjHQPJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:09:16 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE83D2D50
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 08:08:40 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bb97f2c99cso33357531fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 08:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692284907; x=1692889707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ddjcWCgwJaLnL8ww0foMDG3MYHlwLCKKRjeLVlMd+8=;
        b=NmS12C68Ek6FGxcL41yJMQAPpOLInT4lZJeuT198d6qei9HTL1O5AugK5oiLnbnnNo
         rb+aJVG3ydOaASzM8WvQMOSdFNtCu0jHGTbDkx2HCi5kL2HEkbJ8orTysaFwQQQNOkbG
         2SYp8AIRrFc9u3H+0syt/F0ww+3TX+pPqY98eQBYjR/Z9HkHLmuf4cffRy5WNxSPLRxW
         ws2UTYL2M1TuSyK2Bp6hVDZLwb/nQpS+3AwqXh+hP984rq0NwsqwsWEVzxCTeEMa/I0u
         WtVVzmiOqaAnjg8IR5tSVt/WdU1Cs1rkTBEdMCIC81KEraJHwcFv4fZLywOe2X1zgTlH
         ejXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692284907; x=1692889707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ddjcWCgwJaLnL8ww0foMDG3MYHlwLCKKRjeLVlMd+8=;
        b=jOYqVwXShVoVfss4hmHq2vHS5ivqolNzB6kjXvn0MCgAkob/asXvh9+j4txWnY3jDU
         uc/HjGO4x+AiiLG7jRZFdtpPY4Pu4jq6Qf74egnWo/j3yddhuYgLpRX3qT78fL06Ie5V
         XiCadQ1JMTccqmvPRfmQEgFLhEOwo+V3StuO487vxotJPXZ0J3U0VltcjeOcVKOZQ7am
         No3hTFNCM05rteaxuki+RIeiWoeCEvRXFN6ZvNOLMYGCcEkgpauo0iTKGLdLrlnReXUT
         U5DmK/0W3UEY3st/CAF5NhFgO1Ca6k+vv0p/07VjrbPKsOe1ldI+akS4mLXZv2MDTlA5
         GejQ==
X-Gm-Message-State: AOJu0Yxh9m5JcS7o16Afltly3eSUXJSJMSTmI1+OFDLi5tpu+gOpS8FW
        0/slNXbpVwj3SzD58JmpSjTdew==
X-Google-Smtp-Source: AGHT+IH+dUtUNhhf+BxvarcZxUA7ooVgEEkhp9jCXNmwcEXY+Qd+X5hRytpK9tASF6fmVJXVwoesLg==
X-Received: by 2002:a05:651c:218:b0:2ba:cbb:47a6 with SMTP id y24-20020a05651c021800b002ba0cbb47a6mr4153573ljn.5.1692284907272;
        Thu, 17 Aug 2023 08:08:27 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id u8-20020a2e9b08000000b002b6ef2fca66sm4111413lji.41.2023.08.17.08.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 08:08:26 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] usb: typec: altmodes/displayport: add support for embedded DP cases
Date:   Thu, 17 Aug 2023 18:08:23 +0300
Message-Id: <20230817150824.14371-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230817150824.14371-1-dmitry.baryshkov@linaro.org>
References: <20230817150824.14371-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the embedded cases, the DisplayPort connector is handled by the TCPM
itself. It was proposed to add the "displayport" OF property to the DT
bindings, but it  was rejected in favour of properly describing the
electrical signal path using of_graph.

Fallback to the controller fwnode for HPD notifications to
support such usecases without requiring additional DT properties.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/altmodes/displayport.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index bc4af130940d..a4cf1045b535 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -594,7 +594,10 @@ int dp_altmode_probe(struct typec_altmode *alt)
 	alt->ops = &dp_altmode_ops;
 
 	fwnode = dev_fwnode(alt->dev.parent->parent); /* typec_port fwnode */
-	dp->connector_fwnode = fwnode_find_reference(fwnode, "displayport", 0);
+	if (fwnode_property_present(fwnode, "displayport"))
+		dp->connector_fwnode = fwnode_find_reference(fwnode, "displayport", 0);
+	else
+		dp->connector_fwnode = fwnode_handle_get(fwnode); /* embedded DP */
 	if (IS_ERR(dp->connector_fwnode))
 		dp->connector_fwnode = NULL;
 
-- 
2.39.2

