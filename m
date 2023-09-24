Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCE47AC884
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjIXNRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjIXNRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:17:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E161717;
        Sun, 24 Sep 2023 06:16:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7A0C433C8;
        Sun, 24 Sep 2023 13:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561372;
        bh=pPmCSRq7LsPwt9WgVd4iUn6iV3z68X5Q8RyzgZcg6pU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TQ1/R55tew0kfIWmT/4kjT17k+5E7mxZH2Myo6IiHaQFyU9eWJPW2mPnULSV5Kkks
         PE/dD6yM+fi9quaiuBPaijjF9S6fosQbTSS6KnzWKByg8lta98Ki7oAaCdl+TGKOS6
         4EsHlkrGARLFW59tKk4yGMTcPLbSCkSmTXtgAHFk6OrkMI6HYyaBegj4PzA91IpTqw
         5ZErywm7b5CiUxZpkpQaMPMKmqmwiQnp1RJWMTnBRVf2FHr1R2oiYd29kmM8e62ubc
         sHJwxVX6k7KTn82vJoW4js6dcU0Qd+p311+x95mU3o0Ekpj06PPRgPGjIOjA5jc6Gn
         x7ynvtd+Vg0ng==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 18/41] net/smc: bugfix for smcr v2 server connect success statistic
Date:   Sun, 24 Sep 2023 09:15:06 -0400
Message-Id: <20230924131529.1275335-18-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131529.1275335-1-sashal@kernel.org>
References: <20230924131529.1275335-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.5
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
index b60fe1eb37ab6..aa8928975cc63 100644
--- a/net/smc/smc_stats.h
+++ b/net/smc/smc_stats.h
@@ -243,8 +243,9 @@ while (0)
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

