Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808E878DDA2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244739AbjH3SvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242581AbjH3JFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:05:55 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C21CC9;
        Wed, 30 Aug 2023 02:05:52 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6bca66e6c44so4243685a34.0;
        Wed, 30 Aug 2023 02:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693386352; x=1693991152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJ+Y7CXqKbGK1IYq1UEYCIh7uYK50Z8X6EK6Ai4bZgE=;
        b=YPPZ0nWOr7WTQL7eQJZL7/rEAVFKMwdXbTspMy3hh1ckfdwueKFlLGip11Ojzn/mWe
         AuN5wxW2Ndk6cqFOgjmKGU57Psrz5VAGeR5XerWrMumgBtlEiUbPYkQ5w0Y9cNn81Gbu
         NKStLEIkEnoYoH+DDUgupiWOcDizTgeBmmAGmw7wL6+rYwMHUm9VONYi4kTycUGMZxeS
         SvEGrfzFl25AV4DZ6NACZ+WTi9NkBOKJQ1eOcdUZ1KZfno2e1OgOSzpk9BuQEIl7E/ik
         IUQ/Bu3asa+NZQeBhGcsOp7YwPBnRuomVm9gX1tEZIhrDoYw8opKb6q56Sg+kbRWJelB
         P+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693386352; x=1693991152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJ+Y7CXqKbGK1IYq1UEYCIh7uYK50Z8X6EK6Ai4bZgE=;
        b=J7sdlQ4r5ZRKWtYjVYIoOrNSUtNioDwQkDEba9f6/n+RWNLBtwh/+Xo2OLgNmXUHfu
         ub6Y6/6pODQQ08GUNGLxUC9Zz5liz5F43rBCZB/UtKFIsuTMePk3Gy+HMZ65X1ozZzqe
         txddU0svgSVT8vHbZuHTt8uA3xwR5wY96VhvcGf0unR0y+gDXavnFrYdvEh9h7fNdnzo
         SbybkrjUGn+mVwZiIPgk32Wb/MBi9G438oBh0Kb6NbZamcCCG3YYFGzL6UupsQQRNVig
         xLfzmhItdblmwsKLDIGoZtUTUw4p33hIF6FNT6OvQLO86A2h0s8hkSxCVTviSC9oWpin
         mdLA==
X-Gm-Message-State: AOJu0YwxQCc9b25ZpNqGs1nF53NsiEzUGpEvgcYuUmf+s0O5Od7+zrFJ
        jN1mCgjd4InWDeKRbDk//q0=
X-Google-Smtp-Source: AGHT+IHBi4wWX18II858/6D5KjNsEuV47hc5ZmyFbvALqMzO+3lIqlPuTfCfgYY/EmoJoJ1gBDaM8g==
X-Received: by 2002:a05:6358:9318:b0:135:57d0:d171 with SMTP id x24-20020a056358931800b0013557d0d171mr1313065rwa.15.1693386351915;
        Wed, 30 Aug 2023 02:05:51 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id x4-20020a656aa4000000b00553dcfc2179sm9263226pgu.52.2023.08.30.02.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 02:05:51 -0700 (PDT)
From:   peteryin <peteryin.openbmc@gmail.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     cosmo.chou@quantatw.com, potin.lai@quantatw.com,
        daniel-hsu@quantatw.com, peteryin <peteryin.openbmc@gmail.com>
Subject: [PATCH v4 2/2] dt-bindings: arm: aspeed: add Meta Minerva board
Date:   Wed, 30 Aug 2023 17:02:11 +0800
Message-Id: <20230830090212.3880559-3-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230830090212.3880559-1-peteryin.openbmc@gmail.com>
References: <20230830090212.3880559-1-peteryin.openbmc@gmail.com>
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

Document the new compatibles used on Meta Minerva.

Signed-off-by: peteryin <peteryin.openbmc@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 6b0a6683ccae..b681bbf960d1 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -80,6 +80,7 @@ properties:
               - facebook,fuji-bmc
               - facebook,greatlakes-bmc
               - facebook,yosemite4-bmc
+              - facebook,minerva-bmc
               - ibm,everest-bmc
               - ibm,rainier-bmc
               - ibm,tacoma-bmc
-- 
2.25.1

