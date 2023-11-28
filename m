Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628D07FB652
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343735AbjK1JxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjK1JxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:53:01 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BF4DA;
        Tue, 28 Nov 2023 01:53:07 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c88b7e69dfso63588591fa.0;
        Tue, 28 Nov 2023 01:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701165186; x=1701769986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8fnuFAM44FHAY/l2SxhpvzrWnwI14D3DgP24AAWT9I4=;
        b=MrLWDHI5BIxiO3gGNzKi3sXMcBhJpBddr0YEyqfNwFixYWVdKKIBIZdIA3GnA7siQ2
         jqNWlD/nb1chFR5bOeZqLAzu2gLd+z6OggYrIb10QvLqa4B/fETmooLVpjB2nAZjmd7h
         U9ESZqLNzd5smjWzGyFHpUVlrDHbg7TmVxEdWR0p9NXXEQl9U6+htJt56Kvp4v8K3IDK
         /r3z/3NRMln+XvZHcDKbjH36+rqfqy4vohOI8A4hXTKu3ktXvNPm84BB21yixUtDwfQT
         UmZZYbN85Dm669alWrDNC+AdWJHSeb50FFbgKcyHrOlcGYBc2ylU18ZFdZmQpRLVShBg
         lM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701165186; x=1701769986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8fnuFAM44FHAY/l2SxhpvzrWnwI14D3DgP24AAWT9I4=;
        b=sA5f5kpbu0CkiDObPZGNpcdOexS9+tKFNK+fq3a5/BIYDGxk3RI/oaYFXMH6Zt58D3
         y5yGlinucHQ8Garp1eOhT4wTgHvf2SqjpjUyciguRIla7NVFaPR6cCKHxORNIPoDzyIp
         rC8TvklwNZ7uzbV7SdLaQsb44BS1dNW195MRIVJE8G6uyYs7pFRkfimmsqbJ+d5HyaY0
         EcBTaGEXaAbL0ooQ3sXyuDMKz6A3i+muz5dPJiuCNSwI/MANzcUFZDMYnOsuM9orI9hB
         U6poaqbBKuM5O3HVK2xxfxB7FTFLnSjMheWOwCZOYpd3WZNtJmAbgXbQ+jl9DW2el/BM
         8WgQ==
X-Gm-Message-State: AOJu0YwDLTi7UhsNv7Lg7MvrZG0XrvWfY+Cg7kspYT7Hd/EUjlVE7pyC
        jDBrvMBajlL7JcneO+8XfqI=
X-Google-Smtp-Source: AGHT+IHjPhheeQIjuEYzvtN0rYQsl7JEiqKv3b5VJmvijk95YzymIXyVAjVdPxK6e+Z/7WGEZAL1KA==
X-Received: by 2002:a2e:9bc7:0:b0:2c7:610:2dd1 with SMTP id w7-20020a2e9bc7000000b002c706102dd1mr8630005ljj.47.1701165185572;
        Tue, 28 Nov 2023 01:53:05 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c314800b0040b3937833dsm14695341wmo.3.2023.11.28.01.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 01:53:05 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Long Li <longli@microsoft.com>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Shradha Gupta <shradhagupta@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] net: mana: Fix spelling mistake "enforecement" -> "enforcement"
Date:   Tue, 28 Nov 2023 09:53:04 +0000
Message-Id: <20231128095304.515492-1-colin.i.king@gmail.com>
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

There is a spelling mistake in struct field hc_tx_err_sqpdid_enforecement.
Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c      | 2 +-
 drivers/net/ethernet/microsoft/mana/mana_ethtool.c | 4 ++--
 include/net/mana/mana.h                            | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 6b857188b9da..bc65cc83b662 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2445,7 +2445,7 @@ void mana_query_gf_stats(struct mana_port_context *apc)
 	apc->eth_stats.hc_tx_err_eth_type_enforcement =
 					     resp.tx_err_ethtype_enforcement;
 	apc->eth_stats.hc_tx_err_sa_enforcement = resp.tx_err_SA_enforcement;
-	apc->eth_stats.hc_tx_err_sqpdid_enforecement =
+	apc->eth_stats.hc_tx_err_sqpdid_enforcement =
 					     resp.tx_err_SQPDID_enforcement;
 	apc->eth_stats.hc_tx_err_cqpdid_enforcement =
 					     resp.tx_err_CQPDID_enforcement;
diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
index 7077d647d99a..777e65b8223d 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
@@ -43,8 +43,8 @@ static const struct {
 	 offsetof(struct mana_ethtool_stats, hc_tx_err_eth_type_enforcement)},
 	{"hc_tx_err_sa_enforcement", offsetof(struct mana_ethtool_stats,
 					      hc_tx_err_sa_enforcement)},
-	{"hc_tx_err_sqpdid_enforecement",
-	 offsetof(struct mana_ethtool_stats, hc_tx_err_sqpdid_enforecement)},
+	{"hc_tx_err_sqpdid_enforcement",
+	 offsetof(struct mana_ethtool_stats, hc_tx_err_sqpdid_enforcement)},
 	{"hc_tx_err_cqpdid_enforcement",
 	 offsetof(struct mana_ethtool_stats, hc_tx_err_cqpdid_enforcement)},
 	{"hc_tx_err_mtu_violation", offsetof(struct mana_ethtool_stats,
diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
index 5567f5bc8eb6..76147feb0d10 100644
--- a/include/net/mana/mana.h
+++ b/include/net/mana/mana.h
@@ -368,7 +368,7 @@ struct mana_ethtool_stats {
 	u64 hc_tx_err_vlan_enforcement;
 	u64 hc_tx_err_eth_type_enforcement;
 	u64 hc_tx_err_sa_enforcement;
-	u64 hc_tx_err_sqpdid_enforecement;
+	u64 hc_tx_err_sqpdid_enforcement;
 	u64 hc_tx_err_cqpdid_enforcement;
 	u64 hc_tx_err_mtu_violation;
 	u64 hc_tx_err_inval_oob;
-- 
2.39.2

