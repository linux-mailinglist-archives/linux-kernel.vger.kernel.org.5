Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0178119CB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbjLMQnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbjLMQnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:43:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FB7F4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:43:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDE1C433C7;
        Wed, 13 Dec 2023 16:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702485785;
        bh=iLYjIbUlVCLTe0kMorEK0VE5bRrv64V6utYWmUc7b34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gykg4kIB0fJzVUy7m3W/GPqLEYkG+uUFedlst3B6F+OV8ZdO3lVqs7eJpYz7fLtaz
         G/PZ7imQUxBO1VJ0b1NQApfsPHV0rWqwI/JsbEcVI+6JjbBhi4M2/9yIeTPOcvvzpG
         Thx+2ud4DU3x7X6U2hxwf0ISktRgf7pkKHQMQnt7HCWlyAAmneXrFyQA8Fb0VnEx+p
         hnS0cJRhQ+abCt4i2dAhQMhuMTGdlm94dA5ZScOQNDX7J/Dm3belaMi5lvhkEeHzfa
         kWQf7LbFACW14jelerfw9Hl3O6YA4UbwmfnOi/9HQFIp+bSB3IzyoNQ9TS4MERp7X+
         tI1w4j7iumgrw==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>
Subject: [PATCH 04/12] usb: gadget: uvc: Replace snprintf() with the safer scnprintf() variant
Date:   Wed, 13 Dec 2023 16:42:33 +0000
Message-ID: <20231213164246.1021885-5-lee@kernel.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231213164246.1021885-1-lee@kernel.org>
References: <20231213164246.1021885-1-lee@kernel.org>
MIME-Version: 1.0
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

There is a general misunderstanding amongst engineers that {v}snprintf()
returns the length of the data *actually* encoded into the destination
array.  However, as per the C99 standard {v}snprintf() really returns
the length of the data that *would have been* written if there were
enough space for it.  This misunderstanding has led to buffer-overruns
in the past.  It's generally considered safer to use the {v}scnprintf()
variants in their place (or even sprintf() in simple cases).  So let's
do that.

Link: https://lwn.net/Articles/69419/
Link: https://github.com/KSPP/linux/issues/105
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Daniel Scally <dan.scally@ideasonboard.com>
Cc: Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/usb/gadget/function/uvc_configfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/uvc_configfs.c b/drivers/usb/gadget/function/uvc_configfs.c
index 9bf0e985acfab..7e704b2bcfd1c 100644
--- a/drivers/usb/gadget/function/uvc_configfs.c
+++ b/drivers/usb/gadget/function/uvc_configfs.c
@@ -3414,7 +3414,7 @@ static ssize_t f_uvc_opts_string_##cname##_show(struct config_item *item,\
 	int result;							\
 									\
 	mutex_lock(&opts->lock);					\
-	result = snprintf(page, sizeof(opts->aname), "%s", opts->aname);\
+	result = scnprintf(page, sizeof(opts->aname), "%s", opts->aname);\
 	mutex_unlock(&opts->lock);					\
 									\
 	return result;							\
-- 
2.43.0.472.g3155946c3a-goog

