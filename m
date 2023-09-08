Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6894798DC5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343831AbjIHSYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344583AbjIHSXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:23:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6993C03;
        Fri,  8 Sep 2023 11:20:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8317C43397;
        Fri,  8 Sep 2023 18:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694197211;
        bh=KzI5BGwRkYWhhwf1++9WVDoIGkamAKzbmDqPdrT7qJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FGZYIy1gKzHNc47dwTIh4yEc95SrdEuC6x4psvNRKaTYXZhgFL/1lqsck01VYV67n
         OjvrqupvtVvSMH07914QQWqjTlIxdpr808tPXiFBoB6z4RyP+fTJOVv0hLgUnsNT3F
         feAqyrzyczT2Sn/kofMNoXtlFPNcW07HoIKaiDKpjpZMUeTQ53O9eOMw11pn15TtqE
         fonZM0noXvz4HHtI4h5NVv9YGX9sQo79vzzqZ0loyZAR9Vj3ZDI4QD5cLTWemSWL1m
         0Qe9evN3mNgQW8qDrB8lSKrjqMQJwkAMpCIrzwErvu5bH33flbcNBCjp+CqBOpLJGe
         ON+JuxjFdgj4g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dongliang Mu <dzm91@hust.edu.cn>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 04/14] wifi: ath9k: fix printk specifier
Date:   Fri,  8 Sep 2023 14:19:51 -0400
Message-Id: <20230908182003.3460721-4-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908182003.3460721-1-sashal@kernel.org>
References: <20230908182003.3460721-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.194
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dongliang Mu <dzm91@hust.edu.cn>

[ Upstream commit 061115fbfb2ce5870c9a004d68dc63138c07c782 ]

Smatch reports:

ath_pci_probe() warn: argument 4 to %lx specifier is cast from pointer
ath_ahb_probe() warn: argument 4 to %lx specifier is cast from pointer

Fix it by modifying %lx to %p in the printk format string.

Note that with this change, the pointer address will be printed as a
hashed value by default. This is appropriate because the kernel
should not leak kernel pointers to user space in an informational
message. If someone wants to see the real address for debugging
purposes, this can be achieved with the no_hash_pointers kernel option.

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230723040403.296723-1-dzm91@hust.edu.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/ahb.c | 4 ++--
 drivers/net/wireless/ath/ath9k/pci.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ahb.c b/drivers/net/wireless/ath/ath9k/ahb.c
index cdefb8e2daf14..05fb76a4e144e 100644
--- a/drivers/net/wireless/ath/ath9k/ahb.c
+++ b/drivers/net/wireless/ath/ath9k/ahb.c
@@ -136,8 +136,8 @@ static int ath_ahb_probe(struct platform_device *pdev)
 
 	ah = sc->sc_ah;
 	ath9k_hw_name(ah, hw_name, sizeof(hw_name));
-	wiphy_info(hw->wiphy, "%s mem=0x%lx, irq=%d\n",
-		   hw_name, (unsigned long)mem, irq);
+	wiphy_info(hw->wiphy, "%s mem=0x%p, irq=%d\n",
+		   hw_name, mem, irq);
 
 	return 0;
 
diff --git a/drivers/net/wireless/ath/ath9k/pci.c b/drivers/net/wireless/ath/ath9k/pci.c
index cff9af3af38d5..4f90c304d1214 100644
--- a/drivers/net/wireless/ath/ath9k/pci.c
+++ b/drivers/net/wireless/ath/ath9k/pci.c
@@ -994,8 +994,8 @@ static int ath_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	sc->sc_ah->msi_reg = 0;
 
 	ath9k_hw_name(sc->sc_ah, hw_name, sizeof(hw_name));
-	wiphy_info(hw->wiphy, "%s mem=0x%lx, irq=%d\n",
-		   hw_name, (unsigned long)sc->mem, pdev->irq);
+	wiphy_info(hw->wiphy, "%s mem=0x%p, irq=%d\n",
+		   hw_name, sc->mem, pdev->irq);
 
 	return 0;
 
-- 
2.40.1

