Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DAD783ED2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbjHVLbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbjHVLbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:31:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74906CF1;
        Tue, 22 Aug 2023 04:31:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0224F633D7;
        Tue, 22 Aug 2023 11:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503CDC433C9;
        Tue, 22 Aug 2023 11:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692703867;
        bh=ClUbNh5Ba5Ijk1bbKYM7eB7v7clusIUN0C4gBbPZPDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gfp9XaCwnP76zzJNmcmmEERnOZp5wb7aUyJ4dCINIpwE6aC1QlTiujZao070najm0
         es9nk1ttwJNWAonWlA+2jDhTiD8QctUCMRM0TqlhlzOv2IQs0aHloxl4jRgBmd7F11
         nOFjSqkdpRw/J4zaK3ob4u5L9LaM9gCxUjv54KCAq5noTVsdsEeGuL/EQfsV1kxQr1
         5ZcVnzD0EjySmNup2+WEucpJTij+4xrc+RTgVYS5Rbx+Dqa0hJK6qBRJx5guFiGhqL
         IEqV6afVquJSeIQKU9FIziWcW4dnU5/pG0CQE+Fr7OXUqp8pMZYsw9l+AW1a38nSYE
         ES2QnTbFQeKJQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kalle Valo <quic_kvalo@quicinc.com>, Kalle Valo <kvalo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, quic_jjohnson@quicinc.com,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 03/10] Revert "wifi: ath11k: Enable threaded NAPI"
Date:   Tue, 22 Aug 2023 07:30:53 -0400
Message-Id: <20230822113101.3549915-3-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230822113101.3549915-1-sashal@kernel.org>
References: <20230822113101.3549915-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.11
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

From: Kalle Valo <quic_kvalo@quicinc.com>

[ Upstream commit d265ebe41c911314bd273c218a37088835959fa1 ]

This reverts commit 13aa2fb692d3717767303817f35b3e650109add3.

This commit broke QCN9074 initialisation:

[  358.960477] ath11k_pci 0000:04:00.0: ce desc not available for wmi command 36866
[  358.960481] ath11k_pci 0000:04:00.0: failed to send WMI_STA_POWERSAVE_PARAM_CMDID
[  358.960484] ath11k_pci 0000:04:00.0: could not set uapsd params -105

As there's no fix available let's just revert it to get QCN9074 working again.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217536
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230720151444.2016637-1-kvalo@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/ahb.c  | 1 -
 drivers/net/wireless/ath/ath11k/pcic.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 396548e57022f..88aeb36ab2e79 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -376,7 +376,6 @@ static void ath11k_ahb_ext_irq_enable(struct ath11k_base *ab)
 		struct ath11k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
 
 		if (!irq_grp->napi_enabled) {
-			dev_set_threaded(&irq_grp->napi_ndev, true);
 			napi_enable(&irq_grp->napi);
 			irq_grp->napi_enabled = true;
 		}
diff --git a/drivers/net/wireless/ath/ath11k/pcic.c b/drivers/net/wireless/ath/ath11k/pcic.c
index 30d66147223f4..a8bcffcf2e813 100644
--- a/drivers/net/wireless/ath/ath11k/pcic.c
+++ b/drivers/net/wireless/ath/ath11k/pcic.c
@@ -466,7 +466,6 @@ void ath11k_pcic_ext_irq_enable(struct ath11k_base *ab)
 		struct ath11k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];
 
 		if (!irq_grp->napi_enabled) {
-			dev_set_threaded(&irq_grp->napi_ndev, true);
 			napi_enable(&irq_grp->napi);
 			irq_grp->napi_enabled = true;
 		}
-- 
2.40.1

