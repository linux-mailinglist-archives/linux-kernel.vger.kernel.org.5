Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B4080B6F2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 23:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjLIWve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 17:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjLIWvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 17:51:32 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E63115;
        Sat,  9 Dec 2023 14:51:38 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3332ad5b3e3so3170159f8f.2;
        Sat, 09 Dec 2023 14:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702162297; x=1702767097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jiKQMydv0yccuw3WqYLVo3Netyg+0OTtTTWArCeoSKY=;
        b=I3tpzAHzzJPp2aZUlnspAbs+YrXXvhGV4/fWlAuJQdsGhhMA6uRo1GDLO3ujL1nhG3
         N3mdoUf2m+GMtcPj79CaKwtveDfRTztVC4saeivZ/h1L1h7U1aRnECNHRVpenmSrF9mE
         VmfWmkcNZBsvRCgQzFb8eWSi8uvn7LmbZoMh/4VcONYQYDHg59OGGmP5Ca6lENA0MLMp
         AG8Kcm1+FcSRr9MeA49BsYgQ5X3xEw7Kog6QNyql6j0CIOWhNHX7vOBgQf+Pkjdbk6Bw
         mjZzlpUObTcthoWdHCNR2TUvzxsO1ttlEXYOQM7a7up9iAE/t1EBAOcrNOlygoBsgTRw
         x3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702162297; x=1702767097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jiKQMydv0yccuw3WqYLVo3Netyg+0OTtTTWArCeoSKY=;
        b=iKNVrPz6+vWFiGxVatWq39OlKxiHEidAzHiC4O/bGj4aC0zoVRYl+8v8yd+QvRta+1
         +OhWQBki1uIlF/HSJbpM3Dr4vd7klcwouTgoEozMQnn8CGiuKkqZPeb+Z/b7NW7K/imI
         GK8T+mDLLMrA/qFZYkJF57Ih9tj/9DzZoFx9buJtBN3/31bZ+jq5K5JN6jorJ4b5qIro
         aM4I9IwzP0eZWHoeKJcYu0OnUt2Esrv5bCEMFrsNDUQr93BDsRgj7x1o0DYngK8W9vv3
         mmzHm3vV3en0Pb/m4h5zbgLSeZClRLpLT2werppldSTe5prylj1xcf9EvXCFgX/KOLHr
         hA1g==
X-Gm-Message-State: AOJu0YxVdtMUoUQBtqqKlVa+sNm0rY87Aq5G7E705xMD7J9bNzEKRvu+
        j23wWBgdjTsoc8GAi0b2/v8=
X-Google-Smtp-Source: AGHT+IF5XBRzg6/xP8NjgYbvmYKrwvHLZUyBo/spRGo9BW2cjYArKW/xqCqXEeiK7aMEBoXd/nu8SQ==
X-Received: by 2002:a05:6000:4d0:b0:332:eeba:ee8b with SMTP id h16-20020a05600004d000b00332eebaee8bmr913794wri.24.1702162296902;
        Sat, 09 Dec 2023 14:51:36 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id w14-20020a5d608e000000b003333c2c313bsm5157467wrt.100.2023.12.09.14.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 14:51:36 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Tariq Toukan <tariqt@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] mlx4: Fix spelling mistake: "mape" -> "map"
Date:   Sat,  9 Dec 2023 22:51:35 +0000
Message-Id: <20231209225135.4055334-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in a mlx4_err error message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx4/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c
index 2581226836b5..43cbe4e5d0c4 100644
--- a/drivers/net/ethernet/mellanox/mlx4/main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/main.c
@@ -1508,7 +1508,7 @@ static int mlx4_port_map_set(struct mlx4_dev *dev, struct mlx4_port_map *v2p)
 			priv->v2p.port1 = port1;
 			priv->v2p.port2 = port2;
 		} else {
-			mlx4_err(dev, "Failed to change port mape: %d\n", err);
+			mlx4_err(dev, "Failed to change port map: %d\n", err);
 		}
 	}
 
-- 
2.39.2

