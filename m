Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC9B7993CD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345641AbjIIAhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjIIAhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:37:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01D326B0;
        Fri,  8 Sep 2023 17:37:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D61C4339A;
        Sat,  9 Sep 2023 00:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694219778;
        bh=ehx0+XjXQRkBXLcAbL52szKHwym6xSO5buVIy78jN0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p2a6Yw25cNU7voqqzPBlAbBxmViwUSw78xBFe21NnqHz0C94bIvund5AV49FrG/OC
         N/RmBDhcPiwJYZFWwAp/8aOx73aMsLUrF36QkNF81qRCha4T7wN2B9yP6hddZ6L9+r
         ndXZUcQxULy08z3pukgs8WoZy6MUz/6c8lEmyILZor6giF2rcsU6hMkEqaFFn/t/l1
         tIIdEjJ01ZrmVELuKPOkRQ1v1Pw7pWVzn0dQwcGY0CGZXRmW23hR5AhvkuBGpY9gow
         HoQu/Crk4qseT35ER6L2Gvq2lyEh9NcmmURBKJ/gHFo2bjBXqG0JxlDfYrdCr0j74R
         THtBe68UOnSWQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhang Shurong <zhang_shurong@foxmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>, mchehab@kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 06/28] media: az6007: Fix null-ptr-deref in az6007_i2c_xfer()
Date:   Fri,  8 Sep 2023 20:35:40 -0400
Message-Id: <20230909003604.3579407-6-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909003604.3579407-1-sashal@kernel.org>
References: <20230909003604.3579407-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Shurong <zhang_shurong@foxmail.com>

[ Upstream commit 1047f9343011f2cedc73c64829686206a7e9fc3f ]

In az6007_i2c_xfer, msg is controlled by user. When msg[i].buf
is null and msg[i].len is zero, former checks on msg[i].buf would be
passed. Malicious data finally reach az6007_i2c_xfer. If accessing
msg[i].buf[0] without sanity check, null ptr deref would happen.
We add check on msg[i].len to prevent crash.

Similar commit:
commit 0ed554fd769a
("media: dvb-usb: az6027: fix null-ptr-deref in az6027_i2c_xfer()")

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/dvb-usb-v2/az6007.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/usb/dvb-usb-v2/az6007.c b/drivers/media/usb/dvb-usb-v2/az6007.c
index 2dcbb49d66dab..2410054ddb2c3 100644
--- a/drivers/media/usb/dvb-usb-v2/az6007.c
+++ b/drivers/media/usb/dvb-usb-v2/az6007.c
@@ -788,6 +788,10 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 			if (az6007_xfer_debug)
 				printk(KERN_DEBUG "az6007: I2C W addr=0x%x len=%d\n",
 				       addr, msgs[i].len);
+			if (msgs[i].len < 1) {
+				ret = -EIO;
+				goto err;
+			}
 			req = AZ6007_I2C_WR;
 			index = msgs[i].buf[0];
 			value = addr | (1 << 8);
@@ -802,6 +806,10 @@ static int az6007_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 			if (az6007_xfer_debug)
 				printk(KERN_DEBUG "az6007: I2C R addr=0x%x len=%d\n",
 				       addr, msgs[i].len);
+			if (msgs[i].len < 1) {
+				ret = -EIO;
+				goto err;
+			}
 			req = AZ6007_I2C_RD;
 			index = msgs[i].buf[0];
 			value = addr;
-- 
2.40.1

