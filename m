Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CBA7EE000
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjKPLmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjKPLmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:42:08 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CE7181
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:42:04 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6bd73395bceso543183b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700134924; x=1700739724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Y3a3I6T3ynb1aD8/N7le6GGs5vGQafrGkelqcFRqTs=;
        b=Ca+HDLgo+cQwnOIdBisEWKsCjU41bJd9t9FseQmE5DCKHyFgClUT8PfQ6w2aM7bXNq
         MGUGKZDes8uS1XWZhvjWbVSeOnQAaWeXsgwvJyLYhXg49NOVuDTRMEE8ghXn0h7j9fUJ
         cIqNQO+9mIweWgiB2VmdFf7UUHhB/JdwFgd5Cm0N6126+UQdp10iXXDUJsxQwu+xrZb/
         LTLWEHL2ON6SRyn4fNC8lNjUMC69xV070ZzjkeM3g5R2MVyk23n+gbSU9cbzoevxsjJG
         XDbEqSMs42LI10oOiofHW+VhwTXYTYsco5R43bMrBZW23/cfPWIrfbydQUxzhkxil3yp
         yNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700134924; x=1700739724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Y3a3I6T3ynb1aD8/N7le6GGs5vGQafrGkelqcFRqTs=;
        b=dAKrRsm36QGNKmkXNryIVY8P3Bkbmd6o9LbwfgPIPR5sjJZiICAqQ8g5La5j0TT5O0
         LhQRJ6A5FUvXIdASOOHGk1XV9sR4sgwGxFlY1BL3EVgR3IdP9nmP5k8RP1tuQ8t44K3i
         t+BqWybWDgoiId8H2JFXrAiJvMUeUPUGIZtiTptFmGuOag9HMJg6PikeyIo8MlBc9j9T
         ZGjPWFvECIj4cbKqqMCKCLuHrtGSsc0Bpe/1vJOeYs+Vif47ARmd2sj1Dc8ecTBHuKiO
         A++5WWT0KUC3lIH7I9ecNQoAw0UXvmoTCkd6MAwDf2EvHa7B9fuwlOZTHJBLs4InJZhg
         xpJA==
X-Gm-Message-State: AOJu0Yxg2UXE4UYjA3JRE4wehYc99rMRsRa8eqblhWhuybs+HbsXiymp
        +8m68Edn2j2HK6TZibKZVbMIQiF7Pohq4wNqJFo=
X-Google-Smtp-Source: AGHT+IHH4rNcD9vWbtsk5f/2nk2Pqt1+wCLMj9nH/ql+RdHA1p48ijIxJb7paX8q+GAjLu7Gqox02w==
X-Received: by 2002:a05:6a00:1304:b0:6c3:415a:5c05 with SMTP id j4-20020a056a00130400b006c3415a5c05mr2353312pfu.14.1700134924154;
        Thu, 16 Nov 2023 03:42:04 -0800 (PST)
Received: from C02FG34NMD6R.bytedance.net ([2001:c10:ff04:0:1000:0:1:7])
        by smtp.gmail.com with ESMTPSA id e3-20020aa78c43000000b006c4d4d5a197sm4440457pfd.171.2023.11.16.03.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 03:42:03 -0800 (PST)
From:   Albert Huang <huangjie.albert@bytedance.com>
To:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Albert Huang <huangjie.albert@bytedance.com>,
        "David S. Miller" <davem@davemloft.net>,
        Toshiaki Makita <toshiaki.makita1@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net] veth: fix ethtool statistical errors
Date:   Thu, 16 Nov 2023 19:41:50 +0800
Message-Id: <20231116114150.48639-1-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if peer->real_num_rx_queues > 1, the ethtool -s command for
veth network device will display some error statistical values.
The value of tx_idx is reset with each iteration, so even if
peer->real_num_rx_queues is greater than 1, the value of tx_idx
will remain constant. This results in incorrect statistical values.
To fix this issue, assign the value of pp_idx to tx_idx.

Fixes: 5fe6e56776ba ("veth: rely on peer veth_rq for ndo_xdp_xmit accounting")
Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
---
 drivers/net/veth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 0deefd1573cf..3a8e3fc5eeb5 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -225,7 +225,7 @@ static void veth_get_ethtool_stats(struct net_device *dev,
 	for (i = 0; i < peer->real_num_rx_queues; i++) {
 		const struct veth_rq_stats *rq_stats = &rcv_priv->rq[i].stats;
 		const void *base = (void *)&rq_stats->vs;
-		unsigned int start, tx_idx = idx;
+		unsigned int start, tx_idx = pp_idx;
 		size_t offset;
 
 		tx_idx += (i % dev->real_num_tx_queues) * VETH_TQ_STATS_LEN;
-- 
2.20.1

