Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466308119C8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjLMQmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjLMQmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:42:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7A5AC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:42:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C8AC433C9;
        Wed, 13 Dec 2023 16:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702485778;
        bh=9hIznFcw8DaH/AT2cUPzctof/XKOI1gZcHfpU8gxwaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D6sduuO3AhilOynckvUN791n2U8Y+YaO3mW522cT/m1JUmQEpDCLOCrW5Cbge2pzE
         wCeH4/KlBpDTS75d7/yK4zhfzS3jtlWJ/4nv2aRg+1voRfHkDtx9HoV55S1iI8CAn6
         FYj0fOh+aYgp3wSNEDlKQ8IEkwLy1m5upNThpQqwLWHrORUGTzDLdQpG7pbcUvSl/X
         H3u8eXWfQSTY2LWM6oGkjZjJOnlF/R4zBoI4IO1k5aLy7RaKi8lGt5fPAl9yZMZpAB
         Ig+ngBEtwwDSiUsmbroyS6nTForV/Biy0aj/61+WxgtHuNBQqRQ/YtU4Cbgi9UIu47
         cm2orOSHOmxcQ==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH 01/12] usb: gadget: configfs: Replace snprintf() with the safer scnprintf() variant
Date:   Wed, 13 Dec 2023 16:42:30 +0000
Message-ID: <20231213164246.1021885-2-lee@kernel.org>
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
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/usb/gadget/configfs.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index b7d2a1313a684..ce3cfa1f36f51 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -606,10 +606,11 @@ static struct config_group *function_make(
 	char *instance_name;
 	int ret;
 
-	ret = snprintf(buf, MAX_NAME_LEN, "%s", name);
-	if (ret >= MAX_NAME_LEN)
+	if (strlen(name) >= MAX_NAME_LEN)
 		return ERR_PTR(-ENAMETOOLONG);
 
+	scnprintf(buf, MAX_NAME_LEN, "%s", name);
+
 	func_name = buf;
 	instance_name = strchr(func_name, '.');
 	if (!instance_name) {
@@ -701,10 +702,12 @@ static struct config_group *config_desc_make(
 	int ret;
 
 	gi = container_of(group, struct gadget_info, configs_group);
-	ret = snprintf(buf, MAX_NAME_LEN, "%s", name);
-	if (ret >= MAX_NAME_LEN)
+
+	if (strlen(name) >= MAX_NAME_LEN)
 		return ERR_PTR(-ENAMETOOLONG);
 
+	scnprintf(buf, MAX_NAME_LEN, "%s", name);
+
 	num_str = strchr(buf, '.');
 	if (!num_str) {
 		pr_err("Unable to locate . in name.bConfigurationValue\n");
-- 
2.43.0.472.g3155946c3a-goog

