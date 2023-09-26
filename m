Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1979F7AE7A2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 10:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbjIZIOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 04:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbjIZIOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 04:14:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9AAFC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 01:13:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A11C433C8;
        Tue, 26 Sep 2023 08:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695716037;
        bh=c2byi9VLht35+07GvYDKXq5iwgVqSZPYJVjeHGyVh5I=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=t29FIkWIvtQkJlTnlokSQ+55bAIH6AKaaMbKlt71yrSEBsjX10+d4hpCCv8/pnIXU
         gkYXDtOceKN9Cs0ijf5ILs+jgT0+TIUM2HTqbcvBtIAjmsRK83g6PwRxMX5OYa9qh3
         mp9LdYSGGPJP2TLncpK/Snzb3n6kajL2C29tgSxh3SZ90MT4eNZ7RfC7TQ/T0zsddR
         hW56SNlnH6awedCxgRk+Ei/pX+ZUVZuuU6HwujS74bmDaiGtKoekWrtkk+fqQm83gf
         V5IN1497w3iy/cR28F6BnSRWz+DbVVumTosI97g32/nkg5PGnJWNa5vEys1KdsZ96+
         ok6eilu97NOYA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] accel/habanalabs: print device name when it is removed
Date:   Tue, 26 Sep 2023 11:13:42 +0300
Message-Id: <20230926081345.240927-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926081345.240927-1-ogabbay@kernel.org>
References: <20230926081345.240927-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Notifies the user which device was removed. It is important in
a server with multiple devices.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index b1d330cd2537..9711e8fc979d 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -2420,7 +2420,7 @@ void hl_device_fini(struct hl_device *hdev)
 	u64 reset_sec;
 	int i, rc;
 
-	dev_info(hdev->dev, "Removing device\n");
+	dev_info(hdev->dev, "Removing device %s\n", dev_name(&(hdev)->pdev->dev));
 
 	hdev->device_fini_pending = 1;
 	flush_delayed_work(&hdev->device_reset_work.reset_work);
-- 
2.34.1

