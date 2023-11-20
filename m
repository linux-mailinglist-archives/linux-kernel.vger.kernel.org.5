Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807B87F0E04
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjKTIrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbjKTIq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:46:56 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF6610EA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:46:43 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-332c46d5988so594421f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700470002; x=1701074802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9P13AuwHQNyol8ESmYlCJi/3K3sWj05YLgHYicy7J8=;
        b=iBMqkxPNTEKDL95lA/Gege1l4FJrPbPsQCoqpWNqFF2xGZpWxD7QcZ+0dPgruBqd7k
         kRNbJgglTjkPvfYFgeXcY3b34xL3OWM2i/93BPqdqqiS23OkEQs1bYRZhj17Bkwi8GYT
         EC/CIeV5zt9pRat8dYqMKNQkydET0BXuURurn3vAHb6kKZwDTjUrp0ilxDX7UtC1cow7
         TFsP2n4/JeTaGIC/KugGxw2noj3cAZE+VNP8Pz02vz2w+AgMlcnNwN0/Y2M0MOC1VxSU
         28cL473bju9D7Kdu6Pqfk2ZHiYXCOF0lfx394up4yYe8r3E1t+P1uLmiuKDbLXKPUdLr
         dTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700470002; x=1701074802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9P13AuwHQNyol8ESmYlCJi/3K3sWj05YLgHYicy7J8=;
        b=b/MZ9uAw+9rLCyEGjI63NUYiBVaLLTR1OEmk9lXeXENE5Uo7MdlVRjY0bpP3jOlq4+
         wYFN50x1YcRxyDMRcnO5+t+Ad5gshoT62iizyb5GPIHjIV+YckHYMpvZFydnREkH5PJX
         FmFJaKhmAkgKjo2qd8CPIYrw3nTna635XeWG2blmCBQdVvvrO8t5hy8BQ0Q30vQbqEz2
         NLB24oLA0IXW8eNeGTVV09AQp9APC+Tzp84/UGj3mkLbCwN69T3ChssSd+TOiTpema5C
         t/eVZQezI3OV3tcLSE1lcPiol4atC+z8Q3SNOcwOkOUlA5wqaxgI9B5VdEOamF0s/RDX
         h+LQ==
X-Gm-Message-State: AOJu0YwvELH+VO7SUL1pNVy4gLPYpoqOuQhyP2df18zriavRsgS67l3J
        k2zamDGfI6j/vf1VR8cTcz9ijw==
X-Google-Smtp-Source: AGHT+IH4tqjzxhfDBRO9JzLmK8bOQRhJkxyEAkin5Qwp4aH4sfWHYtHF/u857ef9ciIBxj5ZRGSdMg==
X-Received: by 2002:a5d:5f94:0:b0:32f:8a45:93a8 with SMTP id dr20-20020a5d5f94000000b0032f8a4593a8mr5042551wrb.0.1700470001599;
        Mon, 20 Nov 2023 00:46:41 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.183])
        by smtp.gmail.com with ESMTPSA id b8-20020a5d45c8000000b003142e438e8csm10435267wrs.26.2023.11.20.00.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 00:46:41 -0800 (PST)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, p.zabel@pengutronix.de,
        yoshihiro.shimoda.uh@renesas.com, geert+renesas@glider.be,
        wsa+renesas@sang-engineering.com, biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        sergei.shtylyov@cogentembedded.com,
        mitsuhiro.kimura.kc@renesas.com, masaru.nagai.vx@renesas.com
Cc:     netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 11/13] net: ravb: Use tabs instead of spaces
Date:   Mon, 20 Nov 2023 10:46:04 +0200
Message-Id: <20231120084606.4083194-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Use tabs instead of spaces in ravb_set_rate_gbeth() function.
This aligns with the coding style requirements.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 15fc494a8b97..a93b3d6b1863 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -85,13 +85,13 @@ static void ravb_set_rate_gbeth(struct net_device *ndev)
 	struct ravb_private *priv = netdev_priv(ndev);
 
 	switch (priv->speed) {
-	case 10:                /* 10BASE */
+	case 10:		/* 10BASE */
 		ravb_write(ndev, GBETH_GECMR_SPEED_10, GECMR);
 		break;
-	case 100:               /* 100BASE */
+	case 100:		/* 100BASE */
 		ravb_write(ndev, GBETH_GECMR_SPEED_100, GECMR);
 		break;
-	case 1000:              /* 1000BASE */
+	case 1000:		/* 1000BASE */
 		ravb_write(ndev, GBETH_GECMR_SPEED_1000, GECMR);
 		break;
 	}
-- 
2.39.2

