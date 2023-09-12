Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADF579C526
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 06:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjILEx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 00:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjILEwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 00:52:33 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B05E7B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:52:29 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-502b0d23f28so3813885e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 21:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694494347; x=1695099147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blF8ap3LXnoETV8kqGoGgVp41zZl+ItWO0Kpw1E4c38=;
        b=k8D53/M4BFzDWOyZMnzfHLhOCvfEKxizrKB4sDtNFNyFIPTXSd7HuZQ5cs+497V6Ku
         YmL0xj5KyQFtOTPqQyTb8nIpAXAO3q5UH5mtwGTX2yVuZwx/z9Toz4RyPYU1mHzBucxQ
         b3OtX6oLsQvDBOVZIaL/XBCwBWTSn7ccnoem2cs+21sDgttNXscjfEB0uNJ2O0BNkRoC
         1sW321ezY2kvZxd4WP7sEs77Gv6uW/Wlr5uq8lbwuYE2iiCtJGGouQX4EBmKYAbji6fC
         yUdb5RxjkEPJqiZ7uFNCUv3ymvNWQsYA8FZ484UijaYy7UEyEvbideFSaU+VDdbrtTiV
         gkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494347; x=1695099147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=blF8ap3LXnoETV8kqGoGgVp41zZl+ItWO0Kpw1E4c38=;
        b=QSbaGEd+1x9/aIt+oReThoUcwK5kcUZuKrYr1lqVgyeR50S39TBdqxSc7fuAQ00ww1
         /4h2vhxIKNWzrVNH+FjbNkedrGbyn8RcLdN8cEwFcYdhNzKA0SPf7GrZvMEWGg+X50e2
         Y8aEof2bsLf8MS8hp0x5Vnp6CrnCwdTJKe/WudU5QP/lyszTUR8QwJXMIVOPKPMNcBFJ
         ILtlcCijOjL1lSzc+bs2lGcu+y2+rUvVqocw+HXF72C8jIVxPRB93Y03dHWE1YYyannB
         GPSWvLTADqsRzqoanCHuVCh+1QUWJz/PNI3gAqyaIj9kkGSHdLtOgpoC2RzQI2ZKVycl
         Br4g==
X-Gm-Message-State: AOJu0YzSZTcjOQjy/jZ1kiJfEwbBLmEMv4Kvro1At+zhumxDggigterr
        UaT83VG2VN+nx8oBVgxEeg2nGA==
X-Google-Smtp-Source: AGHT+IEpsVF589Hvbx0zf52CXpAXwmIg6kcwdC98hWk8TgGYV4S9HPh+LdArAWuydoaFIe/FI2lJBg==
X-Received: by 2002:a05:6512:46b:b0:4f9:51ac:41eb with SMTP id x11-20020a056512046b00b004f951ac41ebmr7821277lfd.16.1694494347236;
        Mon, 11 Sep 2023 21:52:27 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id f21-20020a05640214d500b0051e22660835sm5422415edx.46.2023.09.11.21.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 21:52:26 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 05/37] soc: renesas: remove blank lines
Date:   Tue, 12 Sep 2023 07:51:25 +0300
Message-Id: <20230912045157.177966-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Remove blank lines.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/soc/renesas/renesas-soc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index 1598b66ffb51..c732d4a5b26a 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -12,7 +12,6 @@
 #include <linux/string.h>
 #include <linux/sys_soc.h>
 
-
 struct renesas_family {
 	const char name[16];
 	u32 reg;			/* CCCR or PRR, if not in DT */
@@ -89,7 +88,6 @@ static const struct renesas_family fam_shmobile __initconst __maybe_unused = {
 	.reg	= 0xe600101c,		/* CCCR (Common Chip Code Register) */
 };
 
-
 struct renesas_soc {
 	const struct renesas_family *family;
 	u32 id;
-- 
2.39.2

