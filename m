Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7117DCBA3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbjJaLTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234961AbjJaLTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:19:10 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679E0C1;
        Tue, 31 Oct 2023 04:19:08 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-577fff1cae6so3878873a12.1;
        Tue, 31 Oct 2023 04:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698751148; x=1699355948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N7G3Botv4Z2Nn9bgAtDAhiUWVmZjvUPWNuCgWEigInY=;
        b=haQCIV9PH8r9m5dkEA5CE+l9SmbTwl8dE0BmIbhknlxuPqLJ3u9X/3BfScwN80O3sC
         a0GRw4o9fYq/qVaQV4v7q2FeGhAxMD5qdEg0+t181EqNsUB4f+DLexUomCDJePxB+re5
         RzFMYW155fEcEmPomZ9STzNdEYCnxA/vEuMsm6JuFtDJsFHyIXfYjY9NiWbLS/j70ljB
         MnYnSQcUYHyW3ix/lN+FJQrEP6ikOeQL3vYdJ1/wDeQXWzxdyyPaLIZwYfBkUBY/jjxe
         v0FSVuJsvk3deCd2JRL8MkUYafTgIOFOHc8a2CCLn04r4llh7BLi1Zn3dSqM9IKc+dYK
         PKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698751148; x=1699355948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N7G3Botv4Z2Nn9bgAtDAhiUWVmZjvUPWNuCgWEigInY=;
        b=SFg1jYO3/t6Ch/371vtqhYua1p0UTxX/vPCSiz1MBrEdkCzxrcfpSwzUUOkb3Vdn1q
         gSs2RE/wpK593cotQHYuocxpWZZwTwXDvtA93JTe4agOELOlfvE8GYwNxR1Tx/dKlOJh
         vJePhdcGBU6FM4OK4vz/DQgwvSiL9ZgzcLKa//OsbRXQ/2je8d5SgBI48+tQFtbzhyfN
         zmNwugR66uqxZWsOmqStx7cR6Iv8pu3TRKB0ekovPk4tLq/a0mzpRMWbbVBFhn3mT3+m
         UiEXaY2OQkcbbGEhXdGOIqL6AtBvBrXvY76wzKAxTL1g54zIEGcbc2IVOsUQlTfShUZZ
         2ohg==
X-Gm-Message-State: AOJu0YxRr33Qx2yEb5doVhK1KqN8BO+MEdQtzDgGBjI1UhtebS3NRv1x
        x8Q+QLs44BffFFBFH+5QRzk=
X-Google-Smtp-Source: AGHT+IGSGVOqegKTcqcNc0YuBuXQyZWg+SJxYVSPd2yGYsHoR7fkH95bGWnwpOOG8uFd5ucKELyC/Q==
X-Received: by 2002:a17:903:1cd:b0:1cc:58f6:5347 with SMTP id e13-20020a17090301cd00b001cc58f65347mr3147599plh.34.1698751147792;
        Tue, 31 Oct 2023 04:19:07 -0700 (PDT)
Received: from localhost.localdomain ([111.207.111.194])
        by smtp.gmail.com with ESMTPSA id jo13-20020a170903054d00b001c9cb2fb8d8sm1118435plb.49.2023.10.31.04.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 04:19:07 -0700 (PDT)
From:   Weihao Li <cn.liweihao@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, heiko@sntech.de
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Weihao Li <cn.liweihao@gmail.com>
Subject: [PATCH] clk: rockchip: rk3128: Fix HCLK_OTG gate register
Date:   Tue, 31 Oct 2023 19:18:16 +0800
Message-Id: <20231031111816.8777-1-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.20.1
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

The HCLK_OTG gate control is in CRU_CLKGATE5_CON, not CRU_CLKGATE3_CON.

Signed-off-by: Weihao Li <cn.liweihao@gmail.com>
---
 drivers/clk/rockchip/clk-rk3128.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3128.c b/drivers/clk/rockchip/clk-rk3128.c
index aa53797dbfc1..7782785a86e6 100644
--- a/drivers/clk/rockchip/clk-rk3128.c
+++ b/drivers/clk/rockchip/clk-rk3128.c
@@ -490,7 +490,7 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 	GATE(HCLK_I2S_2CH, "hclk_i2s_2ch", "hclk_peri", 0, RK2928_CLKGATE_CON(7), 2, GFLAGS),
 	GATE(0, "hclk_usb_peri", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(9), 13, GFLAGS),
 	GATE(HCLK_HOST2, "hclk_host2", "hclk_peri", 0, RK2928_CLKGATE_CON(7), 3, GFLAGS),
-	GATE(HCLK_OTG, "hclk_otg", "hclk_peri", 0, RK2928_CLKGATE_CON(3), 13, GFLAGS),
+	GATE(HCLK_OTG, "hclk_otg", "hclk_peri", 0, RK2928_CLKGATE_CON(5), 13, GFLAGS),
 	GATE(0, "hclk_peri_ahb", "hclk_peri", CLK_IGNORE_UNUSED, RK2928_CLKGATE_CON(9), 14, GFLAGS),
 	GATE(HCLK_SPDIF, "hclk_spdif", "hclk_peri", 0, RK2928_CLKGATE_CON(10), 9, GFLAGS),
 	GATE(HCLK_TSP, "hclk_tsp", "hclk_peri", 0, RK2928_CLKGATE_CON(10), 12, GFLAGS),
-- 
2.20.1

