Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E9A807409
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442567AbjLFPzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379416AbjLFPzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:55:17 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C7CD4F;
        Wed,  6 Dec 2023 07:55:23 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5bdb0be3591so4541632a12.2;
        Wed, 06 Dec 2023 07:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701878123; x=1702482923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F8GAW3TyMQDn0zU5OEduOYL67Qvlrqm9celtiaHSioM=;
        b=cDGP9rFX03Ofvin2HSBZUW8/vbrOEao/YDMbHnVlL+wOQ0YYuzfHs7o5I7N9G7tcdM
         QqtQEDNcR3nSfBKNZxYyFPGn84vHa1s6teUTNTn/7qnKX0vJ0PKU+LmXhS+I5l4E5xnA
         MqiWW8Z+lfBBnTsVf+huDohbsnAxvkiMQqAVbFRasyDnfmenNeLIFNaiBf/IuyLcW2lQ
         C2sPSA1TiUAzRYEGPinVuvKrm7PxrlYdZanUlyE7jrOaD9xDlASFjtSdKnseqA6kw2a4
         O/hp4/qPiYplD0ueImFEg2JXQ0T+RmVQ93kL/hYRgdNgcCNL3hxEbp9Y/GYtaDyBfuvS
         R2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701878123; x=1702482923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8GAW3TyMQDn0zU5OEduOYL67Qvlrqm9celtiaHSioM=;
        b=nEk/S5n2lxD5iAfNju8gSiytkQ3K3lrN+Jh1G64rbKA+yHXkE6ctyaZAnCLrIwFPPG
         cf2PAgExOqEHxVNdjw/gPaErNe37nfN50fK5gMZe41dqeK/OFxKf9BslOJfuSbxlmeuZ
         vZW1gt/yGq/TodFtTct8kIKyzaLLZWKO0woXLZcE5r5qDqXa9C4rikd/SYpV+YWk6IKG
         ZaSnmhuiWJk6vLPItOk6OdFBgCuLOXxDXY1kWWBIHyLnG0qF6hVTMNCwHZwYV3u5A4Yz
         RwYqOXxChEcd0Wuto45C0pJlLZ8DYMhksMnqzk1iAuCyW4lVIQIugijKMO/6x/a0l1kv
         Xelg==
X-Gm-Message-State: AOJu0YypEQ4o6dfB4PGFep03Ih6Ij5gi+tuC/eTyh3bKiZpiwxJY12ys
        aYFbDrdqT0j1QUGbWLGcxhw=
X-Google-Smtp-Source: AGHT+IHkcZjDQOAwHADh9ySrv8AZOUsLca6FBP2ogTSfxx5J3OTGLHGjNdk3BTo9WKhHMCRKl3QJyQ==
X-Received: by 2002:a17:90b:3b52:b0:286:ad3e:dea6 with SMTP id ot18-20020a17090b3b5200b00286ad3edea6mr1119615pjb.25.1701878122939;
        Wed, 06 Dec 2023 07:55:22 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id sj16-20020a17090b2d9000b0028652f98978sm3451pjb.8.2023.12.06.07.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 07:55:22 -0800 (PST)
From:   Peter Yin <peteryin.openbmc@gmail.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] dt-bindings: arm: aspeed: add Meta Harma board
Date:   Wed,  6 Dec 2023 23:53:14 +0800
Message-Id: <20231206155316.4181813-2-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231206155316.4181813-1-peteryin.openbmc@gmail.com>
References: <20231206155316.4181813-1-peteryin.openbmc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new compatibles used on Meta Harma.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index e17b3d66d6e55..fac3cda3f4870 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -79,6 +79,7 @@ properties:
               - facebook,elbert-bmc
               - facebook,fuji-bmc
               - facebook,greatlakes-bmc
+              - facebook,harma-bmc
               - facebook,yosemite4-bmc
               - ibm,everest-bmc
               - ibm,rainier-bmc
-- 
2.25.1

