Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A2E79942C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345776AbjIIAjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345811AbjIIAjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:39:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625132702;
        Fri,  8 Sep 2023 17:38:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C269C433BF;
        Sat,  9 Sep 2023 00:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694219903;
        bh=jQRjJqCxiS2xgnYhcH7Xbo+FN0aoh/RMEQ2iSadk/4c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bpe3jkI9qhVwQhQg0/44uI8hM8OD0cVja7VPFspSwPflsrTM24qIMoZNfoDMw2OK3
         mvi3N7jRtkr20Zt1s1ViRTxK0Tom91yzxk1HJidzFlu+ErM5yjXcHB3jg266uPD7yI
         cxW6julooM68zq8RQGMaJ+1HS3jtbWXkDiyehT2UiFDit4pYu5tdiM11ImPCdPEqxb
         K6ISBD0VKWyEKp9mL9ts72CBVuug+RTXUv9ZndSQviDoXhMWpf0cir2+SaICYQRd7e
         pODnsLMg3cBAvjknwhbzTylXE6nWsm9l4ULNIArbBgbwr4u8ElpifBbrFV/aLapoP3
         rA7yKUxzE/cuw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhang Shurong <zhang_shurong@foxmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>, crope@iki.fi,
        mchehab@kernel.org, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 02/24] media: dvb-usb-v2: af9035: Fix null-ptr-deref in af9035_i2c_master_xfer
Date:   Fri,  8 Sep 2023 20:37:54 -0400
Message-Id: <20230909003818.3580081-2-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909003818.3580081-1-sashal@kernel.org>
References: <20230909003818.3580081-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.52
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

[ Upstream commit 7bf744f2de0a848fb1d717f5831b03db96feae89 ]

In af9035_i2c_master_xfer, msg is controlled by user. When msg[i].buf
is null and msg[i].len is zero, former checks on msg[i].buf would be
passed. Malicious data finally reach af9035_i2c_master_xfer. If accessing
msg[i].buf[0] without sanity check, null ptr deref would happen.
We add check on msg[i].len to prevent crash.

Similar commit:
commit 0ed554fd769a
("media: dvb-usb: az6027: fix null-ptr-deref in az6027_i2c_xfer()")

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/dvb-usb-v2/af9035.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/dvb-usb-v2/af9035.c b/drivers/media/usb/dvb-usb-v2/af9035.c
index 1e9c8d01523be..33a2aa8907e65 100644
--- a/drivers/media/usb/dvb-usb-v2/af9035.c
+++ b/drivers/media/usb/dvb-usb-v2/af9035.c
@@ -322,6 +322,8 @@ static int af9035_i2c_master_xfer(struct i2c_adapter *adap,
 			ret = -EOPNOTSUPP;
 		} else if ((msg[0].addr == state->af9033_i2c_addr[0]) ||
 			   (msg[0].addr == state->af9033_i2c_addr[1])) {
+			if (msg[0].len < 3 || msg[1].len < 1)
+				return -EOPNOTSUPP;
 			/* demod access via firmware interface */
 			u32 reg = msg[0].buf[0] << 16 | msg[0].buf[1] << 8 |
 					msg[0].buf[2];
@@ -381,6 +383,8 @@ static int af9035_i2c_master_xfer(struct i2c_adapter *adap,
 			ret = -EOPNOTSUPP;
 		} else if ((msg[0].addr == state->af9033_i2c_addr[0]) ||
 			   (msg[0].addr == state->af9033_i2c_addr[1])) {
+			if (msg[0].len < 3)
+				return -EOPNOTSUPP;
 			/* demod access via firmware interface */
 			u32 reg = msg[0].buf[0] << 16 | msg[0].buf[1] << 8 |
 					msg[0].buf[2];
@@ -388,10 +392,7 @@ static int af9035_i2c_master_xfer(struct i2c_adapter *adap,
 			if (msg[0].addr == state->af9033_i2c_addr[1])
 				reg |= 0x100000;
 
-			ret = (msg[0].len >= 3) ? af9035_wr_regs(d, reg,
-							         &msg[0].buf[3],
-							         msg[0].len - 3)
-					        : -EOPNOTSUPP;
+			ret = af9035_wr_regs(d, reg, &msg[0].buf[3], msg[0].len - 3);
 		} else {
 			/* I2C write */
 			u8 buf[MAX_XFER_SIZE];
-- 
2.40.1

