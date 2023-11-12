Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663877E90CC
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 14:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjKLNb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 08:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjKLN3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 08:29:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F354C21;
        Sun, 12 Nov 2023 05:28:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B347DC433CC;
        Sun, 12 Nov 2023 13:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699795736;
        bh=l+roqsthKupWX2mn5L8VaxW4bZ2+8pSXj16huIry9Ks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X8nAzxiv5AOJCNggGNfru3AwhKMvingjE7H1jVZCJf4PZcPjLa8X9XuHTWZgIV8vy
         wFd1hgvHwtveMOHKr+cS6OJ+L0OIAISXEsgKIt92WYz0aXtVEUaAlQTHSubw6enSCj
         Lkgw+ytRhcMb2y8foMibt9CXjGa/pk+xYkFkDA9+HSWHSfVzplnSHEbZbD29ntHuO8
         ItCm3YmCLCw/4sg/rpo1aUb2RGjSQ4BWz0E428pWeFBjcildgVHfDBeVHs10tWDsId
         Lk0DCSXR83cbk6rrGLQxG5nIAgGzCzZTzRYHloa4RDRUNmPyTHVt4F7ejakfpHCXD/
         ai/awIaw7/BVw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>,
        syzbot+59875ffef5cb9c9b29e9@syzkaller.appspotmail.com,
        "Ricardo B . Marliere" <ricardo@marliere.net>,
        Sean Young <sean@mess.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>, gautammenghani201@gmail.com,
        linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 6/8] media: imon: fix access to invalid resource for the second interface
Date:   Sun, 12 Nov 2023 08:28:44 -0500
Message-ID: <20231112132847.176473-6-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231112132847.176473-1-sashal@kernel.org>
References: <20231112132847.176473-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.200
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
index 98a38755c694e..253a1d1a840a0 100644
--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
@@ -2430,6 +2430,12 @@ static int imon_probe(struct usb_interface *interface,
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

