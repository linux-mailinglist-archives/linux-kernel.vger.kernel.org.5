Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD18A7CDF5A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345077AbjJROTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345292AbjJROS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:18:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A5C478D;
        Wed, 18 Oct 2023 07:16:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14645C433CD;
        Wed, 18 Oct 2023 14:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697638564;
        bh=ZBOqYTiXkcJzSz+u57KsvsALv0M/Ij2IZ5n+f8FR60o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rWB+DfRMPlTjzezfSvVFUgVYmCZSi4Fr2SrqSQv65T+t5DpV2VxO2j/HH7zbF6VRX
         N9WShxAjhYQygU2NwLCEt4ZQoZPHWoAjrNnCiifNBvRRTqHg43axnC0hKg35mdojOl
         6Yn7AXBiD6MTO1nLbyskkulOu+wX19lmFTRqHrKg9leiEhaoV/PZZiNIGDDGTsCKTQ
         WieEmfqDMxSAb+OuprW6sTbmcjB5hZv++h26h+ttNdKxCkvtFnYy6c7h4cVg5d/igK
         NUqT805vGrsodzKqoKmgokyj/2OjGLNK0/6WScmu7jA7aWek8ErBrssUgAZ8INRMZe
         hu+jN/hr0/auQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jeffery Miller <jefferymiller@google.com>,
        Sasha Levin <sashal@kernel.org>, rrangel@chromium.org,
        u.kleine-koenig@pengutronix.de, Jonathan.Cameron@huawei.com,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 5/7] Input: synaptics-rmi4 - handle reset delay when using SMBus trsnsport
Date:   Wed, 18 Oct 2023 10:15:44 -0400
Message-Id: <20231018141548.1335665-5-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018141548.1335665-1-sashal@kernel.org>
References: <20231018141548.1335665-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.296
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit 5030b2fe6aab37fe42d14f31842ea38be7c55c57 ]

Touch controllers need some time after receiving reset command for the
firmware to finish re-initializing and be ready to respond to commands
from the host. The driver already had handling for the post-reset delay
for I2C and SPI transports, this change adds the handling to
SMBus-connected devices.

SMBus devices are peculiar because they implement legacy PS/2
compatibility mode, so reset is actually issued by psmouse driver on the
associated serio port, after which the control is passed to the RMI4
driver with SMBus companion device.

Note that originally the delay was added to psmouse driver in
92e24e0e57f7 ("Input: psmouse - add delay when deactivating for SMBus
mode"), but that resulted in an unwanted delay in "fast" reconnect
handler for the serio port, so it was decided to revert the patch and
have the delay being handled in the RMI4 driver, similar to the other
transports.

Tested-by: Jeffery Miller <jefferymiller@google.com>
Link: https://lore.kernel.org/r/ZR1yUFJ8a9Zt606N@penguin
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/mouse/synaptics.c |  1 +
 drivers/input/rmi4/rmi_smbus.c  | 50 ++++++++++++++++++---------------
 2 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index c6d393114502d..2075f9b99910e 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1749,6 +1749,7 @@ static int synaptics_create_intertouch(struct psmouse *psmouse,
 		psmouse_matches_pnp_id(psmouse, topbuttonpad_pnp_ids) &&
 		!SYN_CAP_EXT_BUTTONS_STICK(info->ext_cap_10);
 	const struct rmi_device_platform_data pdata = {
+		.reset_delay_ms = 30,
 		.sensor_pdata = {
 			.sensor_type = rmi_sensor_touchpad,
 			.axis_align.flip_y = true,
diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
index b6ccf39c6a7bb..e5b0109a4d155 100644
--- a/drivers/input/rmi4/rmi_smbus.c
+++ b/drivers/input/rmi4/rmi_smbus.c
@@ -238,12 +238,29 @@ static void rmi_smb_clear_state(struct rmi_smb_xport *rmi_smb)
 
 static int rmi_smb_enable_smbus_mode(struct rmi_smb_xport *rmi_smb)
 {
-	int retval;
+	struct i2c_client *client = rmi_smb->client;
+	int smbus_version;
+
+	/*
+	 * psmouse driver resets the controller, we only need to wait
+	 * to give the firmware chance to fully reinitialize.
+	 */
+	if (rmi_smb->xport.pdata.reset_delay_ms)
+		msleep(rmi_smb->xport.pdata.reset_delay_ms);
 
 	/* we need to get the smbus version to activate the touchpad */
-	retval = rmi_smb_get_version(rmi_smb);
-	if (retval < 0)
-		return retval;
+	smbus_version = rmi_smb_get_version(rmi_smb);
+	if (smbus_version < 0)
+		return smbus_version;
+
+	rmi_dbg(RMI_DEBUG_XPORT, &client->dev, "Smbus version is %d",
+		smbus_version);
+
+	if (smbus_version != 2 && smbus_version != 3) {
+		dev_err(&client->dev, "Unrecognized SMB version %d\n",
+				smbus_version);
+		return -ENODEV;
+	}
 
 	return 0;
 }
@@ -256,11 +273,10 @@ static int rmi_smb_reset(struct rmi_transport_dev *xport, u16 reset_addr)
 	rmi_smb_clear_state(rmi_smb);
 
 	/*
-	 * we do not call the actual reset command, it has to be handled in
-	 * PS/2 or there will be races between PS/2 and SMBus.
-	 * PS/2 should ensure that a psmouse_reset is called before
-	 * intializing the device and after it has been removed to be in a known
-	 * state.
+	 * We do not call the actual reset command, it has to be handled in
+	 * PS/2 or there will be races between PS/2 and SMBus. PS/2 should
+	 * ensure that a psmouse_reset is called before initializing the
+	 * device and after it has been removed to be in a known state.
 	 */
 	return rmi_smb_enable_smbus_mode(rmi_smb);
 }
@@ -276,7 +292,6 @@ static int rmi_smb_probe(struct i2c_client *client,
 {
 	struct rmi_device_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct rmi_smb_xport *rmi_smb;
-	int smbus_version;
 	int error;
 
 	if (!pdata) {
@@ -315,18 +330,9 @@ static int rmi_smb_probe(struct i2c_client *client,
 	rmi_smb->xport.proto_name = "smb";
 	rmi_smb->xport.ops = &rmi_smb_ops;
 
-	smbus_version = rmi_smb_get_version(rmi_smb);
-	if (smbus_version < 0)
-		return smbus_version;
-
-	rmi_dbg(RMI_DEBUG_XPORT, &client->dev, "Smbus version is %d",
-		smbus_version);
-
-	if (smbus_version != 2 && smbus_version != 3) {
-		dev_err(&client->dev, "Unrecognized SMB version %d\n",
-				smbus_version);
-		return -ENODEV;
-	}
+	error = rmi_smb_enable_smbus_mode(rmi_smb);
+	if (error)
+		return error;
 
 	i2c_set_clientdata(client, rmi_smb);
 
-- 
2.40.1

