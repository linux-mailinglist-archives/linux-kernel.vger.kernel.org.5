Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1617FC83F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346635AbjK1VIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346654AbjK1VIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:08:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F451BC0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:07:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA200C433CB;
        Tue, 28 Nov 2023 21:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205635;
        bh=P2uQ5/4CmM9CK+imh/1k1oIXYXrTVS9ToOqdCaQdvL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sm8v9YS9PDTmIbAlp6TXINicYiBKVn9YQBz+bDkpYs8OBvVl4tpi4HdK5kKRRF44U
         PAOyJ1oAv6gYP/sovQUelVIzluY8mtSrAB8iwCIYn9fqQt/9/YUV5KaNav6YkygvTW
         YE3ETncJIuQtHtpt0oF/dSFqH1LEFU7zItt+YEZY6DvnCYPXVXE6k3g+M15pzVnEGC
         XOtkoCGq3WqKUxGg23HSIB11kCKVjE9Qx/xGrUtQZ/uTWq82gAN1QMwqUFGVBzw3vH
         oSqIpJGrmkrD2oNuSz+yE3FBAvm8VpbyTlXKcw7L9tgvrvQ9jKDnQYjkz8jJFXRn9A
         VqWWDo9NcQyFQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        gupt21@gmail.com, jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-i2c@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 25/40] HID: mcp2221: Allow IO to start during probe
Date:   Tue, 28 Nov 2023 16:05:31 -0500
Message-ID: <20231128210615.875085-25-sashal@kernel.org>
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

[ Upstream commit 73ce9f1f2741a38f5d27393e627702ae2c46e6f2 ]

During the probe we add an I2C adapter and as soon as we add that adapter
it may be used for a transfer (e.g via the code in i2cdetect()).
Those transfers are not able to complete and time out. This is because the
HID raw_event callback (mcp2221_raw_event) will not be invoked until the
HID device's 'driver_input_lock' is marked up at the completion of the
probe in hid_device_probe(). This starves the driver of the responses it
is waiting for.
In order to allow the I2C transfers to complete while we are still in the
probe, start the IO once we have completed init of the HID device.

This issue seems to have been seen before and a patch was submitted but
it seems it was never accepted. See:
https://lore.kernel.org/all/20221103222714.21566-3-Enrik.Berkhan@inka.de/

Signed-off-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-mcp2221.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-mcp2221.c b/drivers/hid/hid-mcp2221.c
index b95f31cf0fa21..aef0785c91cc2 100644
--- a/drivers/hid/hid-mcp2221.c
+++ b/drivers/hid/hid-mcp2221.c
@@ -1142,6 +1142,8 @@ static int mcp2221_probe(struct hid_device *hdev,
 	if (ret)
 		return ret;
 
+	hid_device_io_start(hdev);
+
 	/* Set I2C bus clock diviser */
 	if (i2c_clk_freq > 400)
 		i2c_clk_freq = 400;
-- 
2.42.0

