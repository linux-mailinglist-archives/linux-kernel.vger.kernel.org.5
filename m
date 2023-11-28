Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497977FC85E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376452AbjK1VI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376441AbjK1VH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:07:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD752D4C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:07:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D3CC433C8;
        Tue, 28 Nov 2023 21:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205634;
        bh=IVw3bUqj96xvMhDrvVTGpuXVF4X6lVujV/9OUJK9BNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cTHEKupmG7Q9tJP8bIE3KCijOkIcZIMe5HV9l7fnG9UFD5ZZAojr8eB1oYUtf108l
         8bTZVISWXDik00Gp+l2yBZUFkSE02ll2Un0Dei15js1fyQDboAgMeuTXAWEYGR4Ezb
         l9AuREuY2mue/s7jn9AcpveU2LW2x7kW0oyUUAtakXQlRTUjgUvP+SyBxmUE86q35h
         YtS51qxz3xNTXaMlf54QcB7ddTpnt5MBlL6zUmNP4ION9QiOVew0Shxt2f8Ngh/oHa
         0zP7KylIFTreWGjVlanrZTFOsnY0Kc6Rlwk1zQcQ8DefHA2Q6MecgwutEQf8uYnYkb
         ZUFcAOsRpKSqA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        gupt21@gmail.com, jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-i2c@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 24/40] HID: mcp2221: Set driver data before I2C adapter add
Date:   Tue, 28 Nov 2023 16:05:30 -0500
Message-ID: <20231128210615.875085-24-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210615.875085-1-sashal@kernel.org>
References: <20231128210615.875085-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hamish Martin <hamish.martin@alliedtelesis.co.nz>

[ Upstream commit f2d4a5834638bbc967371b9168c0b481519f7c5e ]

The process of adding an I2C adapter can invoke I2C accesses on that new
adapter (see i2c_detect()).

Ensure we have set the adapter's driver data to avoid null pointer
dereferences in the xfer functions during the adapter add.

This has been noted in the past and the same fix proposed but not
completed. See:
https://lore.kernel.org/lkml/ef597e73-ed71-168e-52af-0d19b03734ac@vigem.de/

Signed-off-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-mcp2221.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index 72883e0ce7575..b95f31cf0fa21 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -1157,12 +1157,12 @@ static int mcp2221_probe(struct hid_device *hdev,
 	snprintf(mcp->adapter.name, sizeof(mcp->adapter.name),
 			"MCP2221 usb-i2c bridge");
 
+	i2c_set_adapdata(&mcp->adapter, mcp);
 	ret = devm_i2c_add_adapter(&hdev->dev, &mcp->adapter);
 	if (ret) {
 		hid_err(hdev, "can't add usb-i2c adapter: %d\n", ret);
 		return ret;
 	}
-	i2c_set_adapdata(&mcp->adapter, mcp);
 
 #if IS_REACHABLE(CONFIG_GPIOLIB)
 	/* Setup GPIO chip */
-- 
2.42.0

