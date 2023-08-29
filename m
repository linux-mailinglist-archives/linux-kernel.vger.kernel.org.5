Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0A478C5F8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbjH2Ne5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236209AbjH2Ndd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:33:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8AACD3;
        Tue, 29 Aug 2023 06:33:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36ED86575D;
        Tue, 29 Aug 2023 13:32:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E552DC433C9;
        Tue, 29 Aug 2023 13:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693315958;
        bh=VPzsTuzuRVs4PH5orOjSLTMnSeozDKlpRLSI7sv5Nmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BKkUWTjt2PIJob3VBPcg9ewE6mDETO7xCLvsRqK5PmtW8mNJYZWFxxidDuxlWEnGP
         LWfBL+wP3z0UPrN3FsCL6EWAegwNrpi1KsM+I8nKcVP/Gvz8bjA5w/HeYiue0v88+U
         0gNRQ/RxiAcLtQ0SDcZS9h6+i5V+K2iZP9zH77G4dS27NuE6+WbdSZgmz8Zta5OgWx
         vGnzcOlMvChYxtaMf2jk1EN/vzP2XRWI3J8wL+ZnlN+5RhDkeKDj7uo7lMarQVWPqb
         qDGs7a+ocR8QV2+LeEfDpprGx6MA2hcYBnc+QukhJlTd+lFVweSqes2Rs0Tx3IrWd1
         zUOj4ImoIITZQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhu Wang <wangzhu9@huawei.com>, Helge Deller <deller@gmx.de>,
        Sasha Levin <sashal@kernel.org>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.4 14/17] fbdev: goldfishfb: Do not check 0 for platform_get_irq()
Date:   Tue, 29 Aug 2023 09:32:01 -0400
Message-Id: <20230829133211.519957-14-sashal@kernel.org>
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

From: Zhu Wang <wangzhu9@huawei.com>

[ Upstream commit 0650d5098f8b6b232cd5ea0e15437fc38f7d63ba ]

Since platform_get_irq() never returned zero, so it need not to check
whether it returned zero, and we use the return error code of
platform_get_irq() to replace the current return error code.

Please refer to the commit a85a6c86c25b ("driver core: platform: Clarify
that IRQ 0 is invalid") to get that platform_get_irq() never returned
zero.

Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/goldfishfb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/goldfishfb.c b/drivers/video/fbdev/goldfishfb.c
index 6fa2108fd912d..e41c9fef4a3b6 100644
--- a/drivers/video/fbdev/goldfishfb.c
+++ b/drivers/video/fbdev/goldfishfb.c
@@ -203,8 +203,8 @@ static int goldfish_fb_probe(struct platform_device *pdev)
 	}
 
 	fb->irq = platform_get_irq(pdev, 0);
-	if (fb->irq <= 0) {
-		ret = -ENODEV;
+	if (fb->irq < 0) {
+		ret = fb->irq;
 		goto err_no_irq;
 	}
 
-- 
2.40.1

