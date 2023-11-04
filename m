Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744207E0F77
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 13:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbjKDMoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 08:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjKDMn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 08:43:58 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1BC1B2
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 05:43:55 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5079f9675c6so3866973e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 05:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699101833; x=1699706633; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vbrVElpE/LRcXL9QrTPOXjtUB0U3i3Et1aitWER/TV4=;
        b=yy3Uh94eo9ISIt7N3igeFW2Yn93KkptUPRKaRqm3tc95Hckgfob3SSvrYpMf9QyCGR
         /ae+NOo9o1uiKrgwVONTOQBO72lMiC6bN7n66oLerfIJ2I/pwJf4PL+f1sF4ft/CzB0q
         /vGTbxUE/lgnK+bCgP8P6nnnbRAfQ5vUMmbvxEbiwk7Ufef3G2Y2cwbrKgDi7uFTXeWq
         Tl+YJTVcdLA0SJ1cmeyRz6t7l71Mut7g0W2F1R1BkYG3Mh5t6LJAOHYgL7vq+UbZzA6B
         RIpTv+c4wD/6J1i/g0A9G0YrT01GB6ZUz5UeMOex12P0p0QTCWR2HYVXuPqifCHvn7NV
         Cm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699101833; x=1699706633;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbrVElpE/LRcXL9QrTPOXjtUB0U3i3Et1aitWER/TV4=;
        b=ni/9i3PpXzZP2jHCv+AUTLo1sM1xGY1AZcTAOCDrvh8ZpNM06SWurMfgGPjzB/yYIA
         ACHhW8E9sUr5GakJZvTtEKV9IfzJpKi9m0HjajVkWbPObRJwhxVV/yRvinIA5wc3Tg0E
         t2WUAzYXFtEUyQA+PUTRVjeirrrWPt2bKTxe2FwpbBxb7zFe/2QBcTgPBYA2i/05d4cG
         7tppPhviY7sqICcnlAAj1pK88Y1qd3Iniz+oQiGuwY3Rn4ExbjAX5VHt8DuzrnXkDIDZ
         AjXBwMpcME0no1Fo1ZG0xM/aNN4zO+3mIYYMr43mpNVQFvl1j9+BRcJl1MJn+V+oDHeo
         doow==
X-Gm-Message-State: AOJu0YzV0ZEzoJkAzz3NO1tgYTbVBDDsZYGalYrAgxh/nK/77ZXR6IHR
        hdy+y6kY4GjX+ml0ARTsAs56GQ==
X-Google-Smtp-Source: AGHT+IEOvtUSGS8gPMNB3spqJXMI2GzAA6fdOtLX2o73ozW/2re2ZnkjNq0X0bY0Zzh1Cl/kg6zB/Q==
X-Received: by 2002:a05:6512:b93:b0:4fe:347d:7c4b with SMTP id b19-20020a0565120b9300b004fe347d7c4bmr23951283lfv.7.1699101833426;
        Sat, 04 Nov 2023 05:43:53 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id u22-20020ac24c36000000b005093312f66fsm496100lfq.124.2023.11.04.05.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 05:43:52 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 04 Nov 2023 13:43:50 +0100
Subject: [PATCH net 3/4] net: ethernet: cortina: Protect against oversized
 frames
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231104-gemini-largeframe-fix-v1-3-9c5513f22f33@linaro.org>
References: <20231104-gemini-largeframe-fix-v1-0-9c5513f22f33@linaro.org>
In-Reply-To: <20231104-gemini-largeframe-fix-v1-0-9c5513f22f33@linaro.org>
To:     Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Vladimir Oltean <olteanv@gmail.com>
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

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index fd08f098850b..23723c9c0f93 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1156,6 +1156,12 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 		mtu = MTU_SIZE_BIT_MASK;
 	}
 
+	if (skb->len > 65535) {
+		/* The field for length is only 16 bits */
+		netdev_err(netdev, "%s: frame too big, max size 65535 bytes\n", __func__);
+		return -EINVAL;
+	}
+
 	word1 = skb->len;
 	word3 = SOF_BIT;
 

-- 
2.34.1

