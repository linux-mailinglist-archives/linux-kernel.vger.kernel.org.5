Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F357616A5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbjGYLlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbjGYLku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:40:50 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329DC1FD0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 04:40:36 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-98dfb3f9af6so923097666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 04:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1690285234; x=1690890034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4EsAms/GBsK+1iUec9cOrJls/H2UjnYhAk3txEAwGRk=;
        b=cYToPYjk35PirQBwQx8NE3OVoFdb2pztaQ5bfC/OWBAdEiyHG2ot3SaseXH3+8zh/s
         zeu39mYeFkkyabzPpyRttmL4hapAwNo8OEKlRmb1geJTTieV2esQtH7w2lEp9cEzvCHR
         ir1XdGJCd7UWDP8mlJlFMczth2qG7Ibif4ZSWQ56oMuoUVujyOp7UxTeLsgwDHorGsyN
         gWsTLFNDQAjeLSjqyxooiHyMRFlpdReL3dUJAVTHnZoDotCXA6Ht5mBMJINufi+R0hr/
         i0qyhLOkNuYkVEDRM9yEpHS8+i7mPFzzYB9cSBaqOoeSAPEzcjAtfgjhI1x1EICLzAAf
         DmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690285234; x=1690890034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4EsAms/GBsK+1iUec9cOrJls/H2UjnYhAk3txEAwGRk=;
        b=gGWpdmP5/E+c8qRacUwPNwCBDLeq1ALBPG6/tL1Wd9e5yYBe1b4tpCWGrdVpQvusnv
         BK+qn2a9HYl9FzmzyYn9cMWEgWeWiGfEJcMsiOrfF6/OKiUM4ArFXTGVxpIh+oZPYplQ
         3SRYcE+Drfw0xMemkCHZQdKIYbgsOeqylWRpKNPSHRKoiJ+FI/I9QVntHsnzEFhzIOAH
         yl0U3nqE5bulNcCB9g5rCA9+obLvIoxcjRRtQQxyX07voesRCZehmCEeju+XqAlClCrB
         1sTX2Yv0IvhB3xqqDVkiCHyDvV5swKTP3t8+TTMli+JDgRVbda36E32ldXfJ1PkOe3Aw
         mXnQ==
X-Gm-Message-State: ABy/qLY92KH3tJjkSNMnztBid+I7r24c+IJF/gXtEFFqVBpDWDg8lemR
        Slu+Nn8UWQQFEv0Z1h2PSHwCXg==
X-Google-Smtp-Source: APBJJlHdTrdKDN3QHK37zBnlfxTsGeEnuQPKPszxCG5So9c4ue9V0GUISNjAv6fhrva4zHO2Y2kpgQ==
X-Received: by 2002:a17:906:318d:b0:99b:b2fb:27b3 with SMTP id 13-20020a170906318d00b0099bb2fb27b3mr1323318ejy.41.1690285234773;
        Tue, 25 Jul 2023 04:40:34 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id d6-20020a1709067f0600b009925cbafeaasm8088206ejr.100.2023.07.25.04.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 04:40:34 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] hwmon: (pmbus) Add ON_OFF_CONFIG register bits
Date:   Tue, 25 Jul 2023 13:40:27 +0200
Message-ID: <20230725114030.1860571-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725114030.1860571-1-Naresh.Solanki@9elements.com>
References: <20230725114030.1860571-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Add bits found in the ON_OFF_CONFIG register.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/pmbus.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index b0832a4c690d..7a28bac7f171 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -243,6 +243,15 @@ enum pmbus_regs {
  */
 #define PB_OPERATION_CONTROL_ON		BIT(7)
 
+/*
+ * ON_OFF_CONFIG
+ */
+#define PB_ON_OFF_CONFIG_POWERUP_CONTROL	BIT(4)
+#define PB_ON_OFF_CONFIG_OPERATION_REQ		BIT(3)
+#define PB_ON_OFF_CONFIG_EN_PIN_REQ		BIT(2)
+#define PB_ON_OFF_CONFIG_POLARITY_HIGH		BIT(1)
+#define PB_ON_OFF_CONFIG_TURN_OFF_FAST		BIT(0)
+
 /*
  * WRITE_PROTECT
  */
-- 
2.41.0

