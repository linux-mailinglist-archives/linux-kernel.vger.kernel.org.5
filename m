Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389C77E9031
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 14:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjKLNYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 08:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjKLNYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 08:24:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A9F49FE;
        Sun, 12 Nov 2023 05:24:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48A8C433D9;
        Sun, 12 Nov 2023 13:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699795453;
        bh=ju5sMtIR5PEWLuld4r3Z5XVp1jGemYzS/JCK/K6QcHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ayCFZARdw6kO5sR2KoX6YIyZhpEdAFzkR4YIM3pmJsn7/T4pHO668gjidxV4xvFNR
         uPgYCiGxl+7lQTBWMgOui7oxq9PXfpLa0QB6Ae3651cZpHJl+M01PYm99Xen9KVI4W
         wwm5eU7jzyfMQprJDc7yuc2Ls5rgMtjJDzhaaK3XLBwVQhy1Zlmlkf+kuKfzivRJ9l
         OuGAXESwRg5RcRCROIr0RB1IQEFJd6iWFxMVAcxiyv5QhF8wtHncPh5dxskkxKTS2I
         7DEe9T4HXgYdyz7niTOYufU40G+41Yjr+rBoAMpL2ofFuoxHhjrU9AeSkzIDPffihu
         7Y/HuDbXxhXPA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 2/6] i2c: fix memleak in i2c_new_client_device()
Date:   Sun, 12 Nov 2023 08:23:57 -0500
Message-ID: <20231112132408.174499-2-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231112132408.174499-1-sashal@kernel.org>
References: <20231112132408.174499-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.62
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit 6af79f7fe748fe6a3c5c3a63d7f35981a82c2769 ]

Yang Yingliang reported a memleak:
===

I got memory leak as follows when doing fault injection test:

unreferenced object 0xffff888014aec078 (size 8):
  comm "xrun", pid 356, jiffies 4294910619 (age 16.332s)
  hex dump (first 8 bytes):
    31 2d 30 30 31 63 00 00                          1-001c..
  backtrace:
    [<00000000eb56c0a9>] __kmalloc_track_caller+0x1a6/0x300
    [<000000000b220ea3>] kvasprintf+0xad/0x140
    [<00000000b83203e5>] kvasprintf_const+0x62/0x190
    [<000000002a5eab37>] kobject_set_name_vargs+0x56/0x140
    [<00000000300ac279>] dev_set_name+0xb0/0xe0
    [<00000000b66ebd6f>] i2c_new_client_device+0x7e4/0x9a0

If device_register() returns error in i2c_new_client_device(),
the name allocated by i2c_dev_set_name() need be freed. As
comment of device_register() says, it should use put_device()
to give up the reference in the error path.

===
I think this solution is less intrusive and more robust than he
originally proposed solutions, though.

Reported-by: Yang Yingliang <yangyingliang@huawei.com>
Closes: http://patchwork.ozlabs.org/project/linux-i2c/patch/20221124085448.3620240-1-yangyingliang@huawei.com/
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 7539b0740351d..5e3976ba52650 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -916,8 +916,9 @@ int i2c_dev_irq_from_resources(const struct resource *resources,
 struct i2c_client *
 i2c_new_client_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
 {
-	struct i2c_client	*client;
-	int			status;
+	struct i2c_client *client;
+	bool need_put = false;
+	int status;
 
 	client = kzalloc(sizeof *client, GFP_KERNEL);
 	if (!client)
@@ -955,7 +956,6 @@ i2c_new_client_device(struct i2c_adapter *adap, struct i2c_board_info const *inf
 	client->dev.fwnode = info->fwnode;
 
 	device_enable_async_suspend(&client->dev);
-	i2c_dev_set_name(adap, client, info);
 
 	if (info->swnode) {
 		status = device_add_software_node(&client->dev, info->swnode);
@@ -967,6 +967,7 @@ i2c_new_client_device(struct i2c_adapter *adap, struct i2c_board_info const *inf
 		}
 	}
 
+	i2c_dev_set_name(adap, client, info);
 	status = device_register(&client->dev);
 	if (status)
 		goto out_remove_swnode;
@@ -978,6 +979,7 @@ i2c_new_client_device(struct i2c_adapter *adap, struct i2c_board_info const *inf
 
 out_remove_swnode:
 	device_remove_software_node(&client->dev);
+	need_put = true;
 out_err_put_of_node:
 	of_node_put(info->of_node);
 out_err:
@@ -985,7 +987,10 @@ i2c_new_client_device(struct i2c_adapter *adap, struct i2c_board_info const *inf
 		"Failed to register i2c client %s at 0x%02x (%d)\n",
 		client->name, client->addr, status);
 out_err_silent:
-	kfree(client);
+	if (need_put)
+		put_device(&client->dev);
+	else
+		kfree(client);
 	return ERR_PTR(status);
 }
 EXPORT_SYMBOL_GPL(i2c_new_client_device);
-- 
2.42.0

