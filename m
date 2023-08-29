Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C4978C5CC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbjH2NeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236215AbjH2Ndf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:33:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2900CD4;
        Tue, 29 Aug 2023 06:33:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0D336576A;
        Tue, 29 Aug 2023 13:32:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B27BC43391;
        Tue, 29 Aug 2023 13:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693315960;
        bh=oH6hl56tUU6fyNan0MeAbQaEx2I7FS353c7o/JZ+zRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S+AA4hswFLYssmlQhiCZS4RpXFHLfChKfl4zkNh967cO+V9nIrl5LML4CaHWHVBYK
         JeDqEsYSHTqLTKJ+MuYwrNvosh3RhUYAT86SGIjZ8PtG+O1anKbxB488Umr/n5SJle
         9rDQx5GmilNmGxzG5rtIpYpcMUkasVWBgVWU9HOigPXI734E/45sYIb9Rs+NpC2kJw
         asAgN+s1bjLR3MQ3SlMkYQPrcss2ne6tDPVOGYCDLEdFmnLRFuwCQN/SCJWhuXKCMO
         Zst2BioBhvDoQOv9LZSAp4qj8ryLRvm2nAmRFEplJoB/b4W+ih2Jy7gqRgvK9dhOSL
         6WWogbGxo0SRA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Artem Chernyshev <artem.chernyshev@red-soft.ru>,
        Leon Romanovsky <leonro@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, michael.chan@broadcom.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 15/17] broadcom: b44: Use b44_writephy() return value
Date:   Tue, 29 Aug 2023 09:32:02 -0400
Message-Id: <20230829133211.519957-15-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230829133211.519957-1-sashal@kernel.org>
References: <20230829133211.519957-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.12
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Artem Chernyshev <artem.chernyshev@red-soft.ru>

[ Upstream commit 9944d203fa63721b87eee84a89f7275dc3d25c05 ]

Return result of b44_writephy() instead of zero to
deal with possible error.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/b44.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
index 392ec09a1d8a6..3e4fb3c3e8342 100644
--- a/drivers/net/ethernet/broadcom/b44.c
+++ b/drivers/net/ethernet/broadcom/b44.c
@@ -1793,11 +1793,9 @@ static int b44_nway_reset(struct net_device *dev)
 	b44_readphy(bp, MII_BMCR, &bmcr);
 	b44_readphy(bp, MII_BMCR, &bmcr);
 	r = -EINVAL;
-	if (bmcr & BMCR_ANENABLE) {
-		b44_writephy(bp, MII_BMCR,
-			     bmcr | BMCR_ANRESTART);
-		r = 0;
-	}
+	if (bmcr & BMCR_ANENABLE)
+		r = b44_writephy(bp, MII_BMCR,
+				 bmcr | BMCR_ANRESTART);
 	spin_unlock_irq(&bp->lock);
 
 	return r;
-- 
2.40.1

