Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863387F3C5A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 04:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343595AbjKVDYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 22:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343543AbjKVDYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 22:24:46 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99EE1A2;
        Tue, 21 Nov 2023 19:24:41 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b8382b8f5aso668107b6e.0;
        Tue, 21 Nov 2023 19:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700623481; x=1701228281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=06y6U8sIEAJcocDpDQt1xUv0207pV5nMk8x8doEVyR8=;
        b=enG7XY6TRuXDAxVKCbnqiW634bX8GhS+Bf3syQ4iD86hTbpoo4dYUuQBV8StNvl1Gv
         QlJII92oxkMYG9V8vrB2EMwmrGQHTDPvqZhSgAJgymD4W/GA+po8M49/dQbvAH3zpfnQ
         mTMrDC6tsQVIJO1yI/C9oVDYyOWIJweHsUdCYcoUJ1iryGJIVCSDBZz9pZjVSyzMX0VE
         EPIDm/HAxymYz3aeTbZdDrV/lfeS/uyutNM/cQ/4RoKs172/+GTmBCY8aNCFuC26Lzne
         m7aR47DTa8h38wOPQg1jmUwjTYw+acMMdjoJHZAv5aIesDVDOV9TYqDBPtc39yA1wMZq
         CbDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700623481; x=1701228281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06y6U8sIEAJcocDpDQt1xUv0207pV5nMk8x8doEVyR8=;
        b=ZeKHH5UFgd/xsjC0ho9ChrZzTK0dY3+olwKgm/nxpPrTKmjjo3wrdAC95LFcwaNGj6
         y+N3TVUvDf9iTrxtngYYDRnE5J9er2e4kX3xeTi/7qlSiwPiv0oItBx1kEiNYkEqjjJh
         7M9w2F2MMsvy9wK/24UutIoehTStd2U4bykElxi8FV8CZ+LXnEQ2z4CYhcSfgvovfmDf
         zrivt5m0pZZbxL4koUMrUs3lu4VwrtXpaMVplb6S50zTqS19bAG845gdLjBnY83gNPr9
         fz3yPHgDAL+zgpbxF2TZ+2thMN9iuyRTGn+ODTRlWFQnu7yGOKu7mqvO8+bHv05Hx+OA
         ncCA==
X-Gm-Message-State: AOJu0YwHo7uicLsQgAhoMxvwlpfuHn0zMqTTSe/YkcFbLa3G5GO3tuvQ
        PX+pO6gjGkq6sPccQMsxDCs=
X-Google-Smtp-Source: AGHT+IGp/lLNXGHKX5vtHx2LciGvau3yOT75/yckm6oIhuiZfYpoWlBqMAyCqhqsBS2wHrsv7r3Q5A==
X-Received: by 2002:a05:6808:23c9:b0:3ae:501e:a64a with SMTP id bq9-20020a05680823c900b003ae501ea64amr1774710oib.10.1700623481117;
        Tue, 21 Nov 2023 19:24:41 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id s4-20020a056a00194400b0069323619f69sm8820110pfk.143.2023.11.21.19.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 19:24:40 -0800 (PST)
From:   Peter Yin <peteryin.openbmc@gmail.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: arm: aspeed: add Meta Minerva Harma board
Date:   Wed, 22 Nov 2023 11:22:33 +0800
Message-Id: <20231122032234.744144-2-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231122032234.744144-1-peteryin.openbmc@gmail.com>
References: <20231122032234.744144-1-peteryin.openbmc@gmail.com>
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

Document the new compatibles used on Meta Minerva Harma.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index e17b3d66d6e5..20e3be8d8c78 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -79,6 +79,7 @@ properties:
               - facebook,elbert-bmc
               - facebook,fuji-bmc
               - facebook,greatlakes-bmc
+              - facebook,minerva-harma
               - facebook,yosemite4-bmc
               - ibm,everest-bmc
               - ibm,rainier-bmc
-- 
2.25.1

