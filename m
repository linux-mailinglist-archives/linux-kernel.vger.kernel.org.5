Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755117D2603
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 23:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbjJVVA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 17:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbjJVVA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 17:00:27 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5BD126
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 14:00:24 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id ufYFqwcwpG6boufYdqoCCl; Sun, 22 Oct 2023 23:00:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1698008423;
        bh=W0mHaNEAAUX2nTaO6oddXS59CQugHmEWhSnV8c4UJ+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=UxbDtzfouZDnBiHAY7DY4xX5Tf2OqORvmMe7We+8GBAdJ3IU/P+6Q9u7nxkUNbxU0
         XiNAMfBiNWFs99Zczv0LH6m6oj5Kq6Iji3ALJUQyKjWMHTw4uio+/MYJnwA1bO/6+Q
         RnhczO2O942rlK/5B1OzgsvX3uICfJg05m6jD92x7lueFfPc3fAxZH56OYqkkb/X86
         Y9OzKhbYJVwu3OyF7lcYW1Bf9nx7kBvonzjkLokWtftsIqhRcJ8TDYt86/eUTZ1SBv
         0NbQCcTyFss5/bkwM1kZ8lpoRy68YLlV7GfW2OL6UPSGvPg1MerPNx/VYUilpuRkFd
         Hsq7qCbOo1Oqg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 22 Oct 2023 23:00:23 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     dchickles@marvell.com, sburla@marvell.com, fmanlunas@marvell.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, veerasenareddy.burru@cavium.com
Cc:     felix.manlunas@cavium.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH net 1/2] liquidio: Fix an off by one in octeon_download_firmware()
Date:   Sun, 22 Oct 2023 22:59:46 +0200
Message-Id: <30f085627802594da71bb0b5ca52213ab11301fc.1698007858.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1698007858.git.christophe.jaillet@wanadoo.fr>
References: <cover.1698007858.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to append the 'boottime' string to 'h->bootcmd', the final NULL
has to betaken into account when checking if there is enough space.

Fixes: 907aaa6babe1 ("liquidio: pass date and time info to NIC firmware")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/cavium/liquidio/octeon_console.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_console.c b/drivers/net/ethernet/cavium/liquidio/octeon_console.c
index 67c3570f875f..bd6baf2872a5 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_console.c
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_console.c
@@ -899,13 +899,13 @@ int octeon_download_firmware(struct octeon_device *oct, const u8 *data,
 	ret = snprintf(boottime, MAX_BOOTTIME_SIZE,
 		       " time_sec=%lld time_nsec=%ld",
 		       (s64)ts.tv_sec, ts.tv_nsec);
-	if ((sizeof(h->bootcmd) - strnlen(h->bootcmd, sizeof(h->bootcmd))) <
+	if ((sizeof(h->bootcmd) - strnlen(h->bootcmd, sizeof(h->bootcmd))) <=
 		ret) {
 		dev_err(&oct->pci_dev->dev, "Boot command buffer too small\n");
 		return -EINVAL;
 	}
 	strncat(h->bootcmd, boottime,
-		sizeof(h->bootcmd) - strnlen(h->bootcmd, sizeof(h->bootcmd)));
+		sizeof(h->bootcmd) - strnlen(h->bootcmd, sizeof(h->bootcmd)) - 1);
 
 	dev_info(&oct->pci_dev->dev, "Writing boot command: %s\n",
 		 h->bootcmd);
-- 
2.34.1

