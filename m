Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AC37E16B0
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 21:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjKEU5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 15:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjKEU5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 15:57:35 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D268F2
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 12:57:32 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c514cbbe7eso54279311fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 12:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699217850; x=1699822650; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hHGg7IgOG8aP3eorgAYgy9MJBjBd5UgvuR9R9eWvihw=;
        b=u8Wy9jANe9JmWn3rXVAJj1iNV1dQIxXllohcGldOr4GrLo2+dAwpct5BXSIncZGY/V
         IynXdgJUzzzrO6bQQ/QBdlwqCjGYq4JuQ7IMEHNfQOIfthAw9fOjYgqi3u9/j0y8Nkmu
         Zerox7yAGlML/hU/LfOzJ0DxroanMhajcMYIUqHDJEP7ksfV3FaYXjMVCTgaU4KEjJbT
         PPx3a1ceGdTx9ei7i8YcUT61pxDiWXcM3X8l5t8I6QHnMdyxS82iT7nwfMD6pHhQKnsZ
         9gCXzh5QWjOcbvhR/Ma/YmRtbGeHrJ8akaujvYhe0E2oJUO3OTejjOLiNR0senP2x+IV
         ZUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699217850; x=1699822650;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHGg7IgOG8aP3eorgAYgy9MJBjBd5UgvuR9R9eWvihw=;
        b=Ezixc6WFM2FuR+NEcIeZCj2dzV6oMP9F7y9Zhyt9ayzhpnNMgwsz9MiihJimRhdA/5
         RopiLpcqinjMh1Z34Kp3h4sTRBJ3ABymISVqDB2rAkvU6mLDvryl2mDBTiDxXPv5BAA4
         yoZMzSBBPrp/vE48MCiY3P7nYfY93wl6HNPhzcBWulNshCfAqQUVYDMgmW+Hx4URp8rQ
         wMuiaoQaOKoFUqC/9J88NS0Xt4WItH13sF5/hKKkLXaKlgHkfmh4+qM5gcxL80GHZ1zM
         +jzOkFsNYfbrqvX0hDaLtM+R7lm37HOX9D6stOuAfasHE0C9qqDou02Ov5s+cdaREIOI
         ANKA==
X-Gm-Message-State: AOJu0Yyd+SKImRMfFZRUg9XaPpXVSo53v9DwoV+xwfFtLEI8VbNYBgxB
        S4pSbjqtCuFa1syJ0hJ8I1VLAA==
X-Google-Smtp-Source: AGHT+IF7W3TbvSvzphWkJ38I4V5LXCkTCcll16Xd2nGcrFIOQF+dFaXj5XAglJ+flcNEhVosFX81xQ==
X-Received: by 2002:a05:6512:368f:b0:506:8d2a:5654 with SMTP id d15-20020a056512368f00b005068d2a5654mr17718911lfs.28.1699217850484;
        Sun, 05 Nov 2023 12:57:30 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id d12-20020ac24c8c000000b00507c72697d0sm931873lfl.303.2023.11.05.12.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 12:57:30 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 05 Nov 2023 21:57:25 +0100
Subject: [PATCH net v2 3/4] net: ethernet: cortina: Protect against
 oversized frames
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231105-gemini-largeframe-fix-v2-3-cd3a5aa6c496@linaro.org>
References: <20231105-gemini-largeframe-fix-v2-0-cd3a5aa6c496@linaro.org>
In-Reply-To: <20231105-gemini-largeframe-fix-v2-0-cd3a5aa6c496@linaro.org>
To:     Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Vladimir Oltean <olteanv@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The max size of a transfer no matter the MTU is 64KB-1 so immediately
bail out if the skb exceeds that.

The calling site tries to linearize the skbuff on error so return a
special error code -E2BIG to indicate that this will not work in
any way and bail out immediately if this happens.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index b21a94b4ab5c..576174a862a9 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1151,6 +1151,12 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	if (skb->protocol == htons(ETH_P_8021Q))
 		mtu += VLAN_HLEN;
 
+	if (skb->len > 65535) {
+		/* The field for length is only 16 bits */
+		netdev_err(netdev, "%s: frame too big, max size 65535 bytes\n", __func__);
+		return -E2BIG;
+	}
+
 	word1 = skb->len;
 	word3 = SOF_BIT;
 
@@ -1232,6 +1238,7 @@ static netdev_tx_t gmac_start_xmit(struct sk_buff *skb,
 	struct gmac_txq *txq;
 	int txq_num, nfrags;
 	union dma_rwptr rw;
+	int ret;
 
 	if (skb->len >= 0x10000)
 		goto out_drop_free;
@@ -1269,7 +1276,11 @@ static netdev_tx_t gmac_start_xmit(struct sk_buff *skb,
 		}
 	}
 
-	if (gmac_map_tx_bufs(netdev, skb, txq, &w)) {
+	ret = gmac_map_tx_bufs(netdev, skb, txq, &w);
+	if (ret == -E2BIG)
+		goto out_drop;
+	if (ret) {
+		/* Linearize and retry */
 		if (skb_linearize(skb))
 			goto out_drop;
 

-- 
2.34.1

