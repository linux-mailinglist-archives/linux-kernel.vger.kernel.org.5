Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A547723E3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbjHGM0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjHGM0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:26:50 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31010128
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:26:49 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bbf3da0ea9so28029515ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 05:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691411208; x=1692016008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZBR/L7n+c0K4+2jvj2qF9IKHrGGr2P5oMHLWIibsdA=;
        b=dngqcxXkDTjUguZrMGIXCZRSIUUg9AZAyokTIPWxIrcInPtG7Oom8LrZYQCNQfAxfM
         HfuxYkkNZ92dsmzFnU31gFlDgQ0QnbwdGfT9Es48c0ImSHzs/d0j7HH9+TEWMgk9Tr8i
         iKjXU4rtNS7XpURqDZLWy7NBO1O1V8h1eQ4pgieMGX4/yDGfQz7qyaIZ49ua5sPJbjxy
         4LJtbYzALFrjnewrODhYVDl5AMUkle2pxD9GEFBQSPMvXnNEY61rNykWv5GjFEcfUFLo
         KiPxWohvcAjtUDfEA2/xHi2IoyZpyJZzi3/kisTUicQ9gqTEhWgVrhSUXP1Mt7ljP3Qm
         6Jkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691411208; x=1692016008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZBR/L7n+c0K4+2jvj2qF9IKHrGGr2P5oMHLWIibsdA=;
        b=ao1UegBGw4t6IWxqnUdpZ7gIZupGt6PHO6HFdiHKJD8IVfXqkY3OaZm8qm5qFWo2qd
         knsgZw/sCLDT0SvLc+crR9tnOSzlLCyvev6X82tOnf6ySZ72IdcStQjlXHtz7anAuCre
         6Lm3ZZL/E646BgxzFuNk2Ci9WqmWUK0MR9RcqCBidgWnSCWcd+X1cpxFSDiKqiPQZZaS
         9DSr4jTdPpN5Pgb/A/h6nKHVymajDQUe8OcbozWe0F9Q2WNnrnfEMH0ywm80Jw1OshoY
         npQPIOplGY5VurFe9DsxbCDMWWsAXnKQaNcf5DjvdI3/WMSYxvT7YxwGD4GGI/ouCRw9
         WGZA==
X-Gm-Message-State: AOJu0YzJ03j9jvLvQc8Vs2x7gwGnZgT4XCpusQuTSDh0U+Mere7bMZRy
        Td8RuLEuGBN8kprA8EUoQqR8yg==
X-Google-Smtp-Source: AGHT+IE0UTxZOMHvSuq9wsKJiCX3RPP6CxfzwfTLYdpnBG8UJD0b3bu3kQMZ6+Be3716D2hcPya8Yg==
X-Received: by 2002:a17:903:1cb:b0:1b8:2ba0:c9c0 with SMTP id e11-20020a17090301cb00b001b82ba0c9c0mr8983752plh.59.1691411208720;
        Mon, 07 Aug 2023 05:26:48 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2408:8656:30f8:e020::b])
        by smtp.gmail.com with ESMTPSA id m3-20020a170902768300b001b8a3dd5a4asm6792670pll.283.2023.08.07.05.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 05:26:48 -0700 (PDT)
From:   Albert Huang <huangjie.albert@bytedance.com>
Cc:     Albert Huang <huangjie.albert@bytedance.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC v2 Optimizing veth xsk performance 9/9] veth: add support for AF_XDP tx need_wakup feature
Date:   Mon,  7 Aug 2023 20:26:40 +0800
Message-Id: <20230807122641.85940-1-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230807120434.83644-1-huangjie.albert@bytedance.com>
References: <20230807120434.83644-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patch only support for tx need_wakup feature.

Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
---
 drivers/net/veth.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 70489d017b51..7c60c64ef10b 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1447,9 +1447,9 @@ static int veth_xsk_tx_xmit(struct veth_sq *sq, struct xsk_buff_pool *xsk_pool,
 
 	memset(&tuple, 0, sizeof(tuple));
 
-	/* set xsk wake up flag, to do: where to disable */
+	/* clear xsk wake up flag */
 	if (xsk_uses_need_wakeup(xsk_pool))
-		xsk_set_tx_need_wakeup(xsk_pool);
+		xsk_clear_tx_need_wakeup(xsk_pool);
 
 	while (budget-- > 0) {
 		unsigned int truesize = 0;
@@ -1539,12 +1539,15 @@ static int veth_poll_tx(struct napi_struct *napi, int budget)
 	if (pool)
 		done  = veth_xsk_tx_xmit(sq, pool, budget);
 
-	rcu_read_unlock();
-
 	if (done < budget) {
+		/* set xsk wake up flag */
+		if (xsk_uses_need_wakeup(pool))
+			xsk_set_tx_need_wakeup(pool);
+
 		/* if done < budget, the tx ring is no buffer */
 		napi_complete_done(napi, done);
 	}
+	rcu_read_unlock();
 
 	return done;
 }
-- 
2.20.1

