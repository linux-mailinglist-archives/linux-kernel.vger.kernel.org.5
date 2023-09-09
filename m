Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2AB799487
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237767AbjIIAkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345927AbjIIAjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:39:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BE22690;
        Fri,  8 Sep 2023 17:38:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76ECC43215;
        Sat,  9 Sep 2023 00:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694219910;
        bh=PoqB7G9Vfikam0GR9KERBfdi5X+OnD1jcrHBQlZ5In4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QW1EkZ+VwZrDPSDKQ7ZgR7OrL0HT/8k9I26M/KVokbNchMVk+ROqxUX46J/sckLd6
         kukLzwgd0cRSRfcBUI/FRiHnO2VdbQqbeq8D0Bt57XyAnfrifSVpYUGJoeHZthSaUv
         KvT+NULhTuEmlWZF5RjTXyQuonTxCLLEIau655rzmclk+LGXbp0sKJkeoOAtAjn2Tf
         xsJi4Udq1cQzqN0sjCRy0ON1Vf33yticE/gTaCYjFXXKDbPvEv63H9fbIz/4ppLuk6
         gX6sLn1BzZfqBxsO09yBV6VJdtTjrr/Zrt487s1OH0lTbqKSpSONvlCFh7cT/gD++m
         efsbDzc+T2adg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhang Shurong <zhang_shurong@foxmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>, crope@iki.fi,
        mchehab@kernel.org, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 05/24] media: anysee: fix null-ptr-deref in anysee_master_xfer
Date:   Fri,  8 Sep 2023 20:37:57 -0400
Message-Id: <20230909003818.3580081-5-sashal@kernel.org>
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

[ Upstream commit c30411266fd67ea3c02a05c157231654d5a3bdc9 ]

In anysee_master_xfer, msg is controlled by user. When msg[i].buf
is null and msg[i].len is zero, former checks on msg[i].buf would be
passed. Malicious data finally reach anysee_master_xfer. If accessing
msg[i].buf[0] without sanity check, null ptr deref would happen.
We add check on msg[i].len to prevent crash.

Similar commit:
commit 0ed554fd769a
("media: dvb-usb: az6027: fix null-ptr-deref in az6027_i2c_xfer()")

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
[hverkuil: add spaces around +]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/dvb-usb-v2/anysee.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/dvb-usb-v2/anysee.c b/drivers/media/usb/dvb-usb-v2/anysee.c
index aa45b5d263f6b..a1235d0cce92f 100644
--- a/drivers/media/usb/dvb-usb-v2/anysee.c
+++ b/drivers/media/usb/dvb-usb-v2/anysee.c
@@ -202,7 +202,7 @@ static int anysee_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msg,
 
 	while (i < num) {
 		if (num > i + 1 && (msg[i+1].flags & I2C_M_RD)) {
-			if (msg[i].len > 2 || msg[i+1].len > 60) {
+			if (msg[i].len != 2 || msg[i + 1].len > 60) {
 				ret = -EOPNOTSUPP;
 				break;
 			}
-- 
2.40.1

