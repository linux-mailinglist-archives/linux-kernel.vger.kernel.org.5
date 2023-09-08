Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821CE799081
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239461AbjIHTsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238308AbjIHTsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:48:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18712102;
        Fri,  8 Sep 2023 12:47:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24547C43142;
        Fri,  8 Sep 2023 19:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201724;
        bh=eESCcEKOL8gnPNejzVsOTGlwH7u/x9jWa48LkxgSGwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AM42QT8HTjDIBgV8q0jS44+PzcQ3kq5c3vJ/4NNpJ+7fcxeyc6duVnZc74cDTSGJy
         r3IxNV1fV1PbleJAWaOtld7p7lZrwii/FcKR/dnWQBFViTStNawBr+fIUWiKC/56JR
         swX0O2u/yekHukTrzxHrSs5YRwsWg476L8pLt2JrLegeo2Tb3UyNebiprb9f7g30FQ
         QvPh37cQV17QDNk++6hmSBEOOhonZQB3hi7AyVD7uCpIFNho0b9srjdDkJ8KLTzd4G
         1mofURDY0+B4WYTRIUVFdZMZ7dWAaDD8mf5ndqPP3jSy4Q+tJOJPRkOGsfIeZBBPsz
         OAfPT9xLJ7Hgw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 19/22] bus: ti-sysc: Configure uart quirks for k3 SoC
Date:   Fri,  8 Sep 2023 15:34:03 -0400
Message-Id: <20230908193407.3463368-19-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908193407.3463368-1-sashal@kernel.org>
References: <20230908193407.3463368-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.52
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 03a711d3cb83692733f865312f49e665c49de6de ]

Enable the uart quirks similar to the earlier SoCs. Let's assume we are
likely going to need a k3 specific quirk mask separate from the earlier
SoCs, so let's not start changing the revision register mask at this point.

Note that SYSC_QUIRK_LEGACY_IDLE will be needed until we can remove the
need for pm_runtime_irq_safe() from 8250_omap driver.

Reviewed-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/ti-sysc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 9b7268bae66ab..0eab809fbf371 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1548,6 +1548,8 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x47422e03, 0xffffffff,
 		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
+	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x47424e03, 0xffffffff,
+		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
 
 	/* Quirks that need to be set based on the module address */
 	SYSC_QUIRK("mcpdm", 0x40132000, 0, 0x10, -ENODEV, 0x50000800, 0xffffffff,
-- 
2.40.1

