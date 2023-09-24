Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4287AC8F0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjIXNVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjIXNUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:20:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA03171F;
        Sun, 24 Sep 2023 06:18:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B034C43391;
        Sun, 24 Sep 2023 13:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561502;
        bh=zbFmQ45HpDOudC7crOmoknEiEDeFeWVX6XUc7yFMAUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CFY+rDLr7YpEQZqk6gnSmDjAFHmDqK53bLNp1t0MkPQ/Q/aoXhmLeLaKzmdCxAQzN
         zHKVIuiVJtuvuCtGdWx81pVQ+yPeSv3Rnnud39z757d3jhCHYJ0WKinQ3gtNE1EvhF
         XUQ1MeMtoVR7GoVOMQ2N3KJA3epkN6VOPZ17KLCG+T/+RMdhYCV3F8WDlb+l2p1JWa
         7pGn5SXUMDoBBEYVLQajLpWhXtNmVKeLalL/9jmWGjlAdkzUS9dnxcDyW2SjsYcfZ/
         5QF9AuZ5YjtZvPbK+xphGYHJ4xvokPGpLFE5QclYoqytYNezKYn6wAcBiDaN2rGUyz
         N3YB23l5WuKqA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 15/28] net/smc: bugfix for smcr v2 server connect success statistic
Date:   Sun, 24 Sep 2023 09:17:32 -0400
Message-Id: <20230924131745.1275960-15-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131745.1275960-1-sashal@kernel.org>
References: <20230924131745.1275960-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.55
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guangguan Wang <guangguan.wang@linux.alibaba.com>

[ Upstream commit 6912e724832c47bb381eb1bd1e483ec8df0d0f0f ]

In the macro SMC_STAT_SERV_SUCC_INC, the smcd_version is used
to determin whether to increase the v1 statistic or the v2
statistic. It is correct for SMCD. But for SMCR, smcr_version
should be used.

Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_stats.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/smc/smc_stats.h b/net/smc/smc_stats.h
index 84b7ecd8c05ca..4dbc237b7c19e 100644
--- a/net/smc/smc_stats.h
+++ b/net/smc/smc_stats.h
@@ -244,8 +244,9 @@ while (0)
 #define SMC_STAT_SERV_SUCC_INC(net, _ini) \
 do { \
 	typeof(_ini) i = (_ini); \
-	bool is_v2 = (i->smcd_version & SMC_V2); \
 	bool is_smcd = (i->is_smcd); \
+	u8 version = is_smcd ? i->smcd_version : i->smcr_version; \
+	bool is_v2 = (version & SMC_V2); \
 	typeof(net->smc.smc_stats) smc_stats = (net)->smc.smc_stats; \
 	if (is_v2 && is_smcd) \
 		this_cpu_inc(smc_stats->smc[SMC_TYPE_D].srv_v2_succ_cnt); \
-- 
2.40.1

