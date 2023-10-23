Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0C57D3834
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjJWNfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 09:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjJWNfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:35:07 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7638C9B;
        Mon, 23 Oct 2023 06:35:05 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c509f2c46cso47039161fa.1;
        Mon, 23 Oct 2023 06:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698068103; x=1698672903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wx0BrSEgwwqDaJo2A/cSmzYDiAma8W23poMJduSA6Ow=;
        b=nhlSRXDksbUM/cjLOmKub52Fp2knTiFJOY8CcD/notS3ykAd7cOSRXoYuyFOnf4YZ2
         XVPF+G5HL7nVTkrfNwJC2fAVUephG1JbZ+hSwQK5hP8ixX1slVwurkH41IypOwW6SjZ9
         ZWfc34x8ViyeXRubNeAUHHEpPvUIFqxzU8saYOrEvH8VXN5s8hH8m6dJ0g8NWEqiA8nY
         cIroRwyZOiAPo7vD/itfofybMS18hVegWQMqdtYTduiOgoXlrXc1ZT+r8I2KhYbWcinh
         grgpYBDYhT0mJEkUkls5Yiy8ojfZx2YOq7uTYFZJKJcd6caJ0VCQCvo9pUT0R5za/1he
         YhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698068103; x=1698672903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wx0BrSEgwwqDaJo2A/cSmzYDiAma8W23poMJduSA6Ow=;
        b=JkitEktwUl2HzRxkPEwLRmav2+P5kPPsxH0RhIGVwcgxqZREuvPFx2z5AIySYfxEbv
         Fe6Er8CplKL5Bv1BlE15NyMU1NlAEynM3cWU4ypyCJOMLG+b2wXSkQa2vyAzHYD6TTQ3
         L5J/UC9OuP56MqOFZr5+ItICbmn+TiK4Ato+fQ+XmriGYrxq1ncl8OJYhY81VE/c0WIc
         fB5n62nLEI3S0DzuOYmc0WU8JxEFjM1ct5qYPJE2JprIhXXTomLq9etI196H08iDFyPE
         xHpaQ7WjI+ZgbTl3Gt9SszxK9M8idwaOZYaqhMUCXulNY/Hd360Sc049gkVPlZS9SFsg
         ivcQ==
X-Gm-Message-State: AOJu0YzWSoCM+okuKQtgwaTj7cZKJZ34JWTfTkz1pWgAYIUBFCDXXOgB
        Q3QW63bD80mzF9M63CZlphc=
X-Google-Smtp-Source: AGHT+IF6iFCOYLHVJ673/GenbGT2JYzGsYEv1qorObhiXC5W33ZMltiL1xwut1ShRpGUTtslY+tkdw==
X-Received: by 2002:a2e:9f50:0:b0:2bc:f39b:d1a8 with SMTP id v16-20020a2e9f50000000b002bcf39bd1a8mr5834000ljk.46.1698068103373;
        Mon, 23 Oct 2023 06:35:03 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id m29-20020a05600c3b1d00b003fe61c33df5sm14469380wms.3.2023.10.23.06.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 06:35:02 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org
Subject: [PATCH][next] clk: sunxi-ng: nkm: remove redundant initialization of tmp_parent
Date:   Mon, 23 Oct 2023 14:35:02 +0100
Message-Id: <20231023133502.666559-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable tmp_parent is being ininitialized with a value that is never
read, the initialization is redundant and can be removed. Move the
initialization and move the variable to the inner loop scope.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/clk/sunxi-ng/ccu_nkm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
index eed64547ad42..853f84398e2b 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.c
+++ b/drivers/clk/sunxi-ng/ccu_nkm.c
@@ -21,17 +21,16 @@ static unsigned long ccu_nkm_find_best_with_parent_adj(struct ccu_common *common
 						       unsigned long *parent, unsigned long rate,
 						       struct _ccu_nkm *nkm)
 {
-	unsigned long best_rate = 0, best_parent_rate = *parent, tmp_parent = *parent;
+	unsigned long best_rate = 0, best_parent_rate = *parent;
 	unsigned long best_n = 0, best_k = 0, best_m = 0;
 	unsigned long _n, _k, _m;
 
 	for (_k = nkm->min_k; _k <= nkm->max_k; _k++) {
 		for (_n = nkm->min_n; _n <= nkm->max_n; _n++) {
 			for (_m = nkm->min_m; _m <= nkm->max_m; _m++) {
-				unsigned long tmp_rate;
+				unsigned long tmp_rate, tmp_parent;
 
 				tmp_parent = clk_hw_round_rate(parent_hw, rate * _m / (_n * _k));
-
 				tmp_rate = tmp_parent * _n * _k / _m;
 
 				if (ccu_is_better_rate(common, rate, tmp_rate, best_rate) ||
-- 
2.39.2

