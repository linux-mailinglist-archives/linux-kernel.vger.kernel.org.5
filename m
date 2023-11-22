Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3105D7F3C59
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 04:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343578AbjKVDYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 22:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbjKVDYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 22:24:44 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23390D4B;
        Tue, 21 Nov 2023 19:24:39 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6b709048f32so5602980b3a.0;
        Tue, 21 Nov 2023 19:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700623478; x=1701228278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gwnN5Mp60GbUqaJnJtdiPEfokf2xhEImDf6jAe/ZdME=;
        b=hYJpKcws4Cj7PR72VKbfLjkzwB3D8yoEjo2VCrThgGoqfshLZ9kUu7WJ1HGTQ+1IHy
         +c23NH0ITcblfJDtnjDJVxdWOa6EHsuYDvUrKsFtPmiAzcgGc0h7RdaruKeEDKxSEs3Y
         zhfv5heknEOFzueN8dGdtfusnAW8PRp0shm5VBdp4T5xgPksLyCzwuQD9/TmsOgDxI37
         qD9++i2D+CVZW8V3WhCfvmwh0o4rNJgkNsSmd2xJGtyTte7RD/7Gf7jshQFJ96Xx1dTW
         RTJD3ngJQ6z65iznUR5CDemnjeEw2DhC3SWsDd59s43Y7hTfrec38wjLmLoSb1AE4Qid
         Fxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700623478; x=1701228278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gwnN5Mp60GbUqaJnJtdiPEfokf2xhEImDf6jAe/ZdME=;
        b=QY2UtxmCOJFuh+x7zveerhLNTb7n8I6B8GtnwaEK9IIO5yWC9vioR7dRd/1wwOHTrn
         PWs8H4iYLlVICKt57tZ42qL+fhvkDcU0+awF0Rt2lN6n+x09ddNUjJ+odoPsd7U8V5Nb
         VwXUK8RtIN5Dxt+GALRLoZeuCDN2noSRLWvoKv3KIpHa3B5dwYsL9rLM2HmZWv4qo4/k
         tCtO22SFy/MQ0UzEwSx4PUoGsZAze7zJj0kHVY32OQpJe4VhsAl8RD1FyGFxO4v/JgAQ
         V+Z3L66uFEz2b9qBG3ToGVknELCiN8ZZqFeK6t3HGdwLUqsD27vpWh0/zPKDHsxgRipZ
         8oBQ==
X-Gm-Message-State: AOJu0YzGfK2upqocXgze0/G7WPnp6K83kfUkvs+MSJvYgb2Hre5Nlo+o
        PJbkhkRUD+QUmGatxBINicg=
X-Google-Smtp-Source: AGHT+IFdDj8vN1C0M9rSgwZNk2buw3bn5CSJsGVqk6RpbHp0er3n8pMZyxFxiWR+rsYryxYnT5HX/A==
X-Received: by 2002:a05:6a00:3a1d:b0:6cb:a1fe:18c0 with SMTP id fj29-20020a056a003a1d00b006cba1fe18c0mr1274579pfb.8.1700623478416;
        Tue, 21 Nov 2023 19:24:38 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id s4-20020a056a00194400b0069323619f69sm8820110pfk.143.2023.11.21.19.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 19:24:38 -0800 (PST)
From:   Peter Yin <peteryin.openbmc@gmail.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add Facebook Minerva Harma (AST2600) BMC
Date:   Wed, 22 Nov 2023 11:22:32 +0800
Message-Id: <20231122032234.744144-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Summary:
Add linux device tree entry related to Minerva Harma
specific devices connected to BMC SoC.

Change log
v1 -> v2:
  - Add Power sensors
  - Modify ehci number
  - Add Led
  - Modify SGPIO line-name
v1:
  - Create minerva harma dts file.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
Peter Yin (2):
  dt-bindings: arm: aspeed: add Meta Minerva Harma board
  ARM: dts: aspeed: Minerva Harma: Add Facebook Minerva Harma (AST2600)
    BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed-bmc-facebook-minerva-harma.dts     | 533 ++++++++++++++++++
 3 files changed, 535 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva-harma.dts

-- 
2.25.1

