Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711DA7E90C4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 14:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjKLNbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 08:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjKLN3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 08:29:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C43A49DA;
        Sun, 12 Nov 2023 05:28:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54827C433D9;
        Sun, 12 Nov 2023 13:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699795730;
        bh=r1gw3hOsw+jtDnajYdiBQfXdRBa3YMT9bjyN5/VsQhE=;
        h=From:To:Cc:Subject:Date:From;
        b=P3940uXgRUl6S4BbLXpBrnjIdhya9OEzM4dsMxXvN9H0zr33Fk8iYNuqurP/P90LQ
         dmLuioeKuMsjDfvIEFbyYk6toDpvBxOyLKI+HTO6Jp9HVVR3s24pxaVFDzIOvEOm8/
         t/fB0Npfm+AIny7f6GmGf6iXrbtD8XrNjCZNn4m32GOkUNHIEXsE86NISqOueeF6wS
         n1ZHns6TE+/pbNCARTpIO1RqnewjlVOo1Nu6PbTebO7pp3oN/Ns53qqQH31aObWsoC
         wpyTE/cSpIFwzdldzlG1A3bAytPhWQnFJJ3PxHVR6i/sC534Wk0ixmldIxZmO2xOeX
         39cjVJez9R2oQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rajeshwar R Shinde <coolrrsh@gmail.com>,
        syzbot+e27f3dbdab04e43b9f73@syzkaller.appspotmail.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>, hverkuil@xs4all.nl,
        linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 1/8] media: gspca: cpia1: shift-out-of-bounds in set_flicker
Date:   Sun, 12 Nov 2023 08:28:39 -0500
Message-ID: <20231112132847.176473-1-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.200
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

From: Rajeshwar R Shinde <coolrrsh@gmail.com>

[ Upstream commit 099be1822d1f095433f4b08af9cc9d6308ec1953 ]

Syzkaller reported the following issue:
UBSAN: shift-out-of-bounds in drivers/media/usb/gspca/cpia1.c:1031:27
shift exponent 245 is too large for 32-bit type 'int'

When the value of the variable "sd->params.exposure.gain" exceeds the
number of bits in an integer, a shift-out-of-bounds error is reported. It
is triggered because the variable "currentexp" cannot be left-shifted by
more than the number of bits in an integer. In order to avoid invalid
range during left-shift, the conditional expression is added.

Reported-by: syzbot+e27f3dbdab04e43b9f73@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/20230818164522.12806-1-coolrrsh@gmail.com
Link: https://syzkaller.appspot.com/bug?extid=e27f3dbdab04e43b9f73
Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/gspca/cpia1.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/usb/gspca/cpia1.c b/drivers/media/usb/gspca/cpia1.c
index d93d384286c16..de945e13c7c6b 100644
--- a/drivers/media/usb/gspca/cpia1.c
+++ b/drivers/media/usb/gspca/cpia1.c
@@ -18,6 +18,7 @@
 
 #include <linux/input.h>
 #include <linux/sched/signal.h>
+#include <linux/bitops.h>
 
 #include "gspca.h"
 
@@ -1027,6 +1028,8 @@ static int set_flicker(struct gspca_dev *gspca_dev, int on, int apply)
 			sd->params.exposure.expMode = 2;
 			sd->exposure_status = EXPOSURE_NORMAL;
 		}
+		if (sd->params.exposure.gain >= BITS_PER_TYPE(currentexp))
+			return -EINVAL;
 		currentexp = currentexp << sd->params.exposure.gain;
 		sd->params.exposure.gain = 0;
 		/* round down current exposure to nearest value */
-- 
2.42.0

