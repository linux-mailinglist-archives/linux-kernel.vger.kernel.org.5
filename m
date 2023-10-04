Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767207B77F0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 08:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241431AbjJDGhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 02:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241426AbjJDGhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 02:37:40 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5AFAD
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 23:37:37 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5363227cc80so2887392a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 23:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google; t=1696401455; x=1697006255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7tjP/kNvFdirVdEdO+zKKMbLGQyGDvV/p73al1OJ6o=;
        b=J1h+REUPf/DWpLP0Tx+f7HWOn5cab89djUvdMpb94WvRETFjFD5/BHGVWaKX0+viTe
         jkpU9CHvkUpkwxYJUAiGiz2ORgpMhCkSvY5+bAtcSspZ0MniNP8HBwuWEre9TmKc9lVz
         rT+86CZugEyKl3KiLXlv+5Tlzwnglrf2PNu1O4M5iRsWgyQkLOFMBnps+3ix8XfsTN3W
         xDL14VmvYo1CbZEpgAwNNKKvOiHEoXix4njYSrBvUhwM0cnnKAZNw7I/W4Hq36OwMCD3
         wRvMKnlt5SdzeZOPPSM4ZWjwRYWT/MaEr9OkiZ2KOCAZVhZWY6U2c8HBfXNGQrgU30BE
         EcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696401455; x=1697006255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7tjP/kNvFdirVdEdO+zKKMbLGQyGDvV/p73al1OJ6o=;
        b=ZQEArHoiD/kwTE86fm6syJfIyKaQd2KEObADOkNt2zmnu7Fox857XG4LfuAfIecVNg
         TsoRYmuosGkru79GaVNipCOghM8BvpQpXFmzPqmG/NbSWgdnEVeyzHRppNUJDjRRUkWC
         Cezt7TG48a+N/DB+4zCoHfSH7KOxHUp9WDqMAvCnxKFPiMgJ8az7Lmp5vhmSGfZh9TU6
         4Q02Y30W+jPUvZRrD7lywttaLoFlQAAxbuh85GJxDe7ZeIGXttXHcLyJRCjLJ51rMDVJ
         3p3PDtx0ywpv8mJMhVyP5FA0IxW0bRWVrFJvvLFqAEEprsRiTKaceAjsMx/MLF+HK6MK
         S01A==
X-Gm-Message-State: AOJu0YyFejvq/t5mgpiIA5JqEKgLl4jQ/ksC26BKfI8XDO5DPyC0zkjL
        8hRc8inUXJYO64ScZXn2kb1nBQ==
X-Google-Smtp-Source: AGHT+IGLapIb4nj4ZcigiKiclJwBDD7Fs6WqXJRbY2zCs9wk0EgcSlXwJuT4bHJBOsXGkpLAkKWNew==
X-Received: by 2002:a17:907:d047:b0:9ae:6744:4591 with SMTP id vb7-20020a170907d04700b009ae67444591mr1105255ejc.43.1696401455571;
        Tue, 03 Oct 2023 23:37:35 -0700 (PDT)
Received: from capella.localdomain ([193.89.194.60])
        by smtp.gmail.com with ESMTPSA id jx14-20020a170906ca4e00b009ade1a4f795sm2193507ejb.168.2023.10.03.23.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 23:37:35 -0700 (PDT)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        =?UTF-8?q?=A0ipraga?= <alsi@bang-olufsen.dk>
Cc:     Rob Herring <robh@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/4] ARM: dts: dove-cubox: fix si5351 node names
Date:   Wed,  4 Oct 2023 08:35:28 +0200
Message-ID: <20231004063712.3348978-3-alvin@pqrs.dk>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004063712.3348978-1-alvin@pqrs.dk>
References: <20231004063712.3348978-1-alvin@pqrs.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

Correct the device tree to conform with the bindings. The node name and
index should be separated with an @.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
 arch/arm/boot/dts/marvell/dove-cubox.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/marvell/dove-cubox.dts b/arch/arm/boot/dts/marvell/dove-cubox.dts
index bfde99486a87..bcaaf8320c45 100644
--- a/arch/arm/boot/dts/marvell/dove-cubox.dts
+++ b/arch/arm/boot/dts/marvell/dove-cubox.dts
@@ -101,7 +101,7 @@ si5351: clock-generator@60 {
 		/* connect xtal input as source of pll0 and pll1 */
 		silabs,pll-source = <0 0>, <1 0>;
 
-		clkout0 {
+		clkout@0 {
 			reg = <0>;
 			silabs,drive-strength = <8>;
 			silabs,multisynth-source = <0>;
@@ -109,7 +109,7 @@ clkout0 {
 			silabs,pll-master;
 		};
 
-		clkout2 {
+		clkout@2 {
 			reg = <2>;
 			silabs,drive-strength = <8>;
 			silabs,multisynth-source = <1>;
-- 
2.42.0

