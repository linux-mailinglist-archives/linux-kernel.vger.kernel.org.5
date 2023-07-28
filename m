Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AC8766F4E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbjG1OUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 10:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237006AbjG1OTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:19:33 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7713ABA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 07:19:31 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe078dcc3aso7492695e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 07:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690553970; x=1691158770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tK3XW9CvIKNotY0VMKRibuYSfqNfjSdewyrI1jRS2zM=;
        b=c7iw206NmNGXQD51dyCTfjKcxUDG5tZ5kJQD2+JAaW4M6K4d4qsYEkIRe9WdL7qtmU
         xJLPDNDokcsQGomwHemsFPimM7eQAPctRh4pOVsJlChdD4ayKSNiBmSQJBEyzJnc3nBL
         qbJOMF4ro31jIVEvfxr2c1suQK7+xMStzu8Kq5cPkiSBTqFyNHsquGLDbNwsyM3eFne0
         YUtZ/LQsQjWolMIoRmkohkvQ1sa112UoCnUGsWavlCW+fQvnFXm7p4kMN7bPNSoQCv6X
         fZTq3/5CLSNH5tRBuCV9QVzM8VSzVhY2q/3nqZDfapW5IfIRPDRXvVDmOXYCbORy97IU
         3u6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690553970; x=1691158770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tK3XW9CvIKNotY0VMKRibuYSfqNfjSdewyrI1jRS2zM=;
        b=YkyJsTaPtX7HCUsFiB7uJx18/berVpVdDmlrVIspuwnm3y3No6LRzfPtYG65mwcawG
         W2dyGH+v4R4c2T2CfmkNnYrLD9GEatU8iIz+yzel/GGIj2RX+CPPpgXtBzQwMjWfne8N
         ipE2crSbnck2LScDYH4hR57tRooYDubER3ql42kGEYFcCrqruYmOltOQmibDsxXUHkkP
         PLiW/9qO0VFtExZDUfrynKWNFLJ/UsOXvqsPWAMy3i6P2fZchqztD79NajO9xwQM1jfB
         VKymA+DYXob0UMqeMCNaSJhPEVu2NlIvlAbEJTAWCgIUPi4Y6SjE2yR4Qys5AaHEGZ1V
         JtaQ==
X-Gm-Message-State: ABy/qLYjtAoZwCpq+uUoIpoOJr8eHJoau5TS5hfzQDFbSOzgzSIXzDyI
        I1m8pIzWp02LLmVH7rVgG5JLCA==
X-Google-Smtp-Source: APBJJlFs7imRnBEtCs6iYDPuFHgy5C9OPLlOXwI/YIhw8iAEpaIG1yV7BAqgPEz424UL52Nd4O+l1g==
X-Received: by 2002:a05:600c:20f:b0:3fe:785:ac0b with SMTP id 15-20020a05600c020f00b003fe0785ac0bmr1757369wmi.5.1690553969966;
        Fri, 28 Jul 2023 07:19:29 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4090:a246:80e3:766f:be78:d79a:8686])
        by smtp.gmail.com with ESMTPSA id l6-20020adfe586000000b0031416362e23sm5013681wrm.3.2023.07.28.07.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 07:19:29 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Vivek Yadav <vivek.2311@samsung.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v4 4/6] can: tcan4x5x: Rename ID registers to match datasheet
Date:   Fri, 28 Jul 2023 16:19:21 +0200
Message-Id: <20230728141923.162477-5-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230728141923.162477-1-msp@baylibre.com>
References: <20230728141923.162477-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The datasheet calls these registers ID1 and ID2. Rename these to avoid
confusion.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index e706518176e4..fb9375fa20ec 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -6,8 +6,8 @@
 
 #define TCAN4X5X_EXT_CLK_DEF 40000000
 
-#define TCAN4X5X_DEV_ID0 0x00
-#define TCAN4X5X_DEV_ID1 0x04
+#define TCAN4X5X_DEV_ID1 0x00
+#define TCAN4X5X_DEV_ID2 0x04
 #define TCAN4X5X_REV 0x08
 #define TCAN4X5X_STATUS 0x0C
 #define TCAN4X5X_ERROR_STATUS_MASK 0x10
-- 
2.40.1

