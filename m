Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54507E3847
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbjKGJyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbjKGJyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:54:41 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42F6125
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 01:54:38 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507f1c29f25so7164466e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 01:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699350877; x=1699955677; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rfck5FY3dF9200YZ4tXULFpESCIi8VAAOTwzFmje8Pw=;
        b=jaqEPfOjjS8CV42CwprK1l68GnR4JdiOoJohAiH02+nt0IJs/CYUAwD0g/nF8ewjSR
         WzVDEbobx9Ftxyzqr4x0ruhqu54YWgU9pRfdAtKgDwoRGOp5krhn4dvWok0LdrQKU4uT
         +A9G+zGOGi1vq0DXOF8njAJyWvEmvBomINwbmRMXkkIcyBg4ZXQJG+BVnrwryuvMFez0
         x7kkohxNP7HZ+hMGwa41bs9+Kz4DoJ8Uw7ZTVZyCeIX5TQWfLQ+DiD3ZaDFIwHj2w5Fc
         udelUm0nWexT3QhiFg+2rbh1CDkSFyVLw0T4ea11v+GSl+3pQVN27DHS4dCYf40AuWNS
         d65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699350877; x=1699955677;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rfck5FY3dF9200YZ4tXULFpESCIi8VAAOTwzFmje8Pw=;
        b=TAqAJkNVPlbSFRo526M1LviwrMVuvANbkmKr3r8t1kY3eSd9bxbG4YqNfGGqGqIRef
         acxZPwRmrf8y+29ECKwfxroKeVDFrtxeuQzs03Qry6m2hwvwAhKjTchaJsBr8qILsDm6
         y+FvobgU/1BAKW1D17LG0EmNHfLGEBOMf210IYDM2RhibIqpBdbsj0jm4T2pZxMd/y1G
         m1yMFyJCY3fFEW/UjSUsAHpGMznFDAG6LOd3aU/sIpmxCExXmjqFYnijmcS1AcgLxzk/
         FP22t7W58gm9epFD7vfwvkZC9+BRbWZcFxtYSYHeaEDzH8V5j0oAecQKlpeSjNgsl9+M
         4bpQ==
X-Gm-Message-State: AOJu0Yxs5DdMTp6pMldRTlXYX+b/hABu85V3QgOaahnBvk5mARtBTpCr
        VGbUnWIWyjXi7INVo/gTL9fvrA==
X-Google-Smtp-Source: AGHT+IEBVvk5s+3+jjuHHDZToklheab9cKewXJF+TOy2czkLFGo94g0k21Br2Tt8rSSzF8K3JABtuQ==
X-Received: by 2002:a05:6512:ad5:b0:501:bd43:3b9c with SMTP id n21-20020a0565120ad500b00501bd433b9cmr29893465lfu.23.1699350877142;
        Tue, 07 Nov 2023 01:54:37 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id m25-20020ac24ad9000000b005091314185asm296356lfp.285.2023.11.07.01.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 01:54:36 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 07 Nov 2023 10:54:29 +0100
Subject: [PATCH net v3 4/4] net: ethernet: cortina: Checksum only TCP and
 UDP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231107-gemini-largeframe-fix-v3-4-e3803c080b75@linaro.org>
References: <20231107-gemini-largeframe-fix-v3-0-e3803c080b75@linaro.org>
In-Reply-To: <20231107-gemini-largeframe-fix-v3-0-e3803c080b75@linaro.org>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is a bit odd that frames that are neither TCP or UDP
(such as ICMP or ARP) are still sent to the checksumming
engine, where they are clearly just ignored.

Rewrite the logic slightly so that we first check if the
frame is TCP or UDP, in that case bypass the checksum
engine.

Reported-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 78287cfcbf63..1bf07505653b 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1144,6 +1144,7 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	skb_frag_t *skb_frag;
 	dma_addr_t mapping;
 	unsigned short mtu;
+	bool tcp, udp;
 	void *buffer;
 	int ret;
 
@@ -1160,7 +1161,18 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 		word3 |= mtu;
 	}
 
-	if (skb->len >= ETH_FRAME_LEN) {
+	/* Check if the protocol is TCP or UDP */
+	tcp = false;
+	udp = false;
+	if (skb->protocol == htons(ETH_P_IP)) {
+		tcp = ip_hdr(skb)->protocol == IPPROTO_TCP;
+		udp = ip_hdr(skb)->protocol == IPPROTO_UDP;
+	} else { /* IPv6 */
+		tcp = ipv6_hdr(skb)->nexthdr == IPPROTO_TCP;
+		udp = ipv6_hdr(skb)->nexthdr == IPPROTO_UDP;
+	}
+
+	if (skb->len >= ETH_FRAME_LEN || (!tcp && !udp)) {
 		/* Hardware offloaded checksumming isn't working on frames
 		 * bigger than 1514 bytes. A hypothesis about this is that the
 		 * checksum buffer is only 1518 bytes, so when the frames get
@@ -1168,6 +1180,9 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 		 * overwritten by the FCS.
 		 *
 		 * Just use software checksumming and bypass on bigger frames.
+		 *
+		 * Bypass the checksumming engine for any protocols that are
+		 * not TCP or UDP.
 		 */
 		if (skb->ip_summed == CHECKSUM_PARTIAL) {
 			ret = skb_checksum_help(skb);
@@ -1176,22 +1191,14 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 		}
 		word1 |= TSS_BYPASS_BIT;
 	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
-		int tcp = 0;
-
-		/* We do not switch off the checksumming on non TCP/UDP
-		 * frames: as is shown from tests, the checksumming engine
-		 * is smart enough to see that a frame is not actually TCP
-		 * or UDP and then just pass it through without any changes
-		 * to the frame.
+		/* If we get here we are dealing with a TCP or UDP frame
+		 * which is small enough to be processed by the checkumming
+		 * engine.
 		 */
-		if (skb->protocol == htons(ETH_P_IP)) {
+		if (skb->protocol == htons(ETH_P_IP))
 			word1 |= TSS_IP_CHKSUM_BIT;
-			tcp = ip_hdr(skb)->protocol == IPPROTO_TCP;
-		} else { /* IPv6 */
+		else
 			word1 |= TSS_IPV6_ENABLE_BIT;
-			tcp = ipv6_hdr(skb)->nexthdr == IPPROTO_TCP;
-		}
-
 		word1 |= tcp ? TSS_TCP_CHKSUM_BIT : TSS_UDP_CHKSUM_BIT;
 	}
 

-- 
2.34.1

