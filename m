Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D1B79945B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241573AbjIIAlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345902AbjIIAkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:40:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6455A2D56;
        Fri,  8 Sep 2023 17:39:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604B3C4339A;
        Sat,  9 Sep 2023 00:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694219957;
        bh=lD0W62Gb89XMInZipeZtZ+rDmFvBX28Qm4aq9zgBHK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DnlkLjPUKjLz25cY4tgsDU84XYkbPa3lvxbvMwTHItxBpDSUipe3IoxgZdLLkGL5F
         4rqfr3Q9XFHgJErSI2DTgr1E8ftrjc3SnHlLhmNIa5K3zK6FMpiXhx+HoitjfKqosm
         8BaWG1DgRYNUoE4/qVuIMmMgKWRi7dT0skaNiQ3NoHGBErnqVVB4nGWVWpWgrNmI66
         OXZhwHn9w3D70H/5SOcV0Y2FMIlnbN21xgAFB0MVp6NTDu6owZN5r+r4jhHXzBkDwF
         crhdTFW6n0sMekl3akZxFP409uKuTOHJICURoy+iA6tXAZTQFYqzxWf+Ig6X6E2zmv
         +xTYDUef6lHKg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhang Shurong <zhang_shurong@foxmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>, crope@iki.fi,
        mchehab@kernel.org, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 06/19] media: dvb-usb-v2: gl861: Fix null-ptr-deref in gl861_i2c_master_xfer
Date:   Fri,  8 Sep 2023 20:38:50 -0400
Message-Id: <20230909003903.3580394-6-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909003903.3580394-1-sashal@kernel.org>
References: <20230909003903.3580394-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.131
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

[ Upstream commit b97719a66970601cd3151a3e2020f4454a1c4ff6 ]

In gl861_i2c_master_xfer, msg is controlled by user. When msg[i].buf
is null and msg[i].len is zero, former checks on msg[i].buf would be
passed. Malicious data finally reach gl861_i2c_master_xfer. If accessing
msg[i].buf[0] without sanity check, null ptr deref would happen.
We add check on msg[i].len to prevent crash.

Similar commit:
commit 0ed554fd769a
("media: dvb-usb: az6027: fix null-ptr-deref in az6027_i2c_xfer()")

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/dvb-usb-v2/gl861.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/dvb-usb-v2/gl861.c b/drivers/media/usb/dvb-usb-v2/gl861.c
index 0c434259c36f1..c71e7b93476de 100644
--- a/drivers/media/usb/dvb-usb-v2/gl861.c
+++ b/drivers/media/usb/dvb-usb-v2/gl861.c
@@ -120,7 +120,7 @@ static int gl861_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 	} else if (num == 2 && !(msg[0].flags & I2C_M_RD) &&
 		   (msg[1].flags & I2C_M_RD)) {
 		/* I2C write + read */
-		if (msg[0].len > 1 || msg[1].len > sizeof(ctx->buf)) {
+		if (msg[0].len != 1 || msg[1].len > sizeof(ctx->buf)) {
 			ret = -EOPNOTSUPP;
 			goto err;
 		}
-- 
2.40.1

