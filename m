Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6CB7E90A6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 14:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjKLNaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 08:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjKLN2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 08:28:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6CD44BF;
        Sun, 12 Nov 2023 05:28:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE3AC433CC;
        Sun, 12 Nov 2023 13:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699795704;
        bh=v44BZYdol2owoedeipdPdbO7R11otCqacwrAXfHO6gc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HJ339hlPFy/+XWabp38GxYqcVBh29VZAPY3imJCQKDc96HT5Lusj85NS2Rtxh1DEV
         raCgJGTT8ekDp8EeqWhanhKBXGWTUF4rYC5iy032WY9gW08lWjGGu7gRn99gUL7wS3
         uDwyL45iNd23KqNMqNWZupY0SRvzyguoE1mTTP8DTtTf4ign85WrlGYneJ7062eLaB
         LUEAvwqbydIvBv3qM9dXMVeODjNIQqcQNe8AQPfcYb3RwuuN/Bjj1d9XIO/52VHkIl
         a5NlADA/BYW21EPjKZjZiEccoEEInfxqiZni9Zy4odhlg7yfcTnYdBlRe90ODX+tFG
         aVzX9/rcf+6sQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>,
        syzbot+59875ffef5cb9c9b29e9@syzkaller.appspotmail.com,
        "Ricardo B . Marliere" <ricardo@marliere.net>,
        Sean Young <sean@mess.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>, gautammenghani201@gmail.com,
        linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 7/9] media: imon: fix access to invalid resource for the second interface
Date:   Sun, 12 Nov 2023 08:28:10 -0500
Message-ID: <20231112132814.176005-7-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231112132814.176005-1-sashal@kernel.org>
References: <20231112132814.176005-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.62
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit a1766a4fd83befa0b34d932d532e7ebb7fab1fa7 ]

imon driver probes two USB interfaces, and at the probe of the second
interface, the driver assumes blindly that the first interface got
bound with the same imon driver.  It's usually true, but it's still
possible that the first interface is bound with another driver via a
malformed descriptor.  Then it may lead to a memory corruption, as
spotted by syzkaller; imon driver accesses the data from drvdata as
struct imon_context object although it's a completely different one
that was assigned by another driver.

This patch adds a sanity check -- whether the first interface is
really bound with the imon driver or not -- for avoiding the problem
above at the probe time.

Reported-by: syzbot+59875ffef5cb9c9b29e9@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000a838aa0603cc74d6@google.com/
Tested-by: Ricardo B. Marliere <ricardo@marliere.net>
Link: https://lore.kernel.org/r/20230922005152.163640-1-ricardo@marliere.net
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/imon.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
index 74546f7e34691..5719dda6e0f0e 100644
--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
@@ -2427,6 +2427,12 @@ static int imon_probe(struct usb_interface *interface,
 		goto fail;
 	}
 
+	if (first_if->dev.driver != interface->dev.driver) {
+		dev_err(&interface->dev, "inconsistent driver matching\n");
+		ret = -EINVAL;
+		goto fail;
+	}
+
 	if (ifnum == 0) {
 		ictx = imon_init_intf0(interface, id);
 		if (!ictx) {
-- 
2.42.0

