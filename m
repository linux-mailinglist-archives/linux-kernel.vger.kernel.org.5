Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81037995AA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 03:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344890AbjIIBh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 21:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242524AbjIIBhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 21:37:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F111FE7;
        Fri,  8 Sep 2023 18:37:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C72DC433B7;
        Sat,  9 Sep 2023 00:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694220024;
        bh=I4ry+pOAL5mFFPKbk8id1WIZYAFRc5rhAX9f2ESfT6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ozhj1OfjrxaQdp3BF/VD7gOqTV9ZlcF4Sof0M0MI3hByW2y89p4wE8l19Wo9G2vsj
         s/Ma7SAavUuQF6xrWBjmy/hzL3GnD8elxIKtXToO9DxE5WhhLgpwsVHchzGCxRp6WC
         4/AiHqWCY4xy1ksw7yfufIOSRuBr4wmDwyLYV6iPx0HINqDUs+9IS2K5xAqWmIg8xW
         aijEz9i0XYi3+kAJt41EMiUQfHLhdpynXypI/jVakNAIwGMkeC5+DcQc9XNJqQVWws
         G7Lh9+d+nJ7ard1oNsrxgY2hi8p1fpK5XDGGzRL8Ne1UD8YjzQnzFs4brCEqHKvnpt
         IxEaWmlsy7sXQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhang Shurong <zhang_shurong@foxmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>, mchehab@kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 03/14] media: af9005: Fix null-ptr-deref in af9005_i2c_xfer
Date:   Fri,  8 Sep 2023 20:40:03 -0400
Message-Id: <20230909004015.3580832-3-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909004015.3580832-1-sashal@kernel.org>
References: <20230909004015.3580832-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.256
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Shurong <zhang_shurong@foxmail.com>

[ Upstream commit f4ee84f27625ce1fdf41e8483fa0561a1b837d10 ]

In af9005_i2c_xfer, msg is controlled by user. When msg[i].buf
is null and msg[i].len is zero, former checks on msg[i].buf would be
passed. Malicious data finally reach af9005_i2c_xfer. If accessing
msg[i].buf[0] without sanity check, null ptr deref would happen.
We add check on msg[i].len to prevent crash.

Similar commit:
commit 0ed554fd769a
("media: dvb-usb: az6027: fix null-ptr-deref in az6027_i2c_xfer()")

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/dvb-usb/af9005.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/usb/dvb-usb/af9005.c b/drivers/media/usb/dvb-usb/af9005.c
index 89b4b5d84cdff..827f9db16aa10 100644
--- a/drivers/media/usb/dvb-usb/af9005.c
+++ b/drivers/media/usb/dvb-usb/af9005.c
@@ -422,6 +422,10 @@ static int af9005_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 		if (ret == 0)
 			ret = 2;
 	} else {
+		if (msg[0].len < 2) {
+			ret = -EOPNOTSUPP;
+			goto unlock;
+		}
 		/* write one or more registers */
 		reg = msg[0].buf[0];
 		addr = msg[0].addr;
@@ -431,6 +435,7 @@ static int af9005_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			ret = 1;
 	}
 
+unlock:
 	mutex_unlock(&d->i2c_mutex);
 	return ret;
 }
-- 
2.40.1

