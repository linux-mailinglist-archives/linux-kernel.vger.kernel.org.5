Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46AD8119CA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbjLMQnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbjLMQm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:42:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B11B9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:43:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54559C433C8;
        Wed, 13 Dec 2023 16:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702485783;
        bh=O6zPhvOuiRaMjZO2N7+0OTpsYUd4lm9ZY2n6Y+b+qeE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bTqHvry36GwQ2JC5GUEHK2OZj84VP8H5phOup1YRj0QFGrDNCoBXjQXSWGFMqTY0B
         SQymbQsSGp50F/KU/lWWhLi0U2e0DNozV3AWJ+9d3fuAF91aquJHahP80iqWziuFju
         hkjOv4iVYP70IxzU9YbZcmwbm8mTOTwYXC4MgQvLeq157b9PoYT2CGZyhNfAZnNZTO
         V+RrnfSIDC2f9xXxwuE/mK1YOLsVPywIRokO1ioLrD+PmjQIsj8BJ+Dba2RrxVcJlG
         CuGYuXQ832/9hEQcuiLgu/CmE8Wg9MoBvTeSZeBBADWWXAq10oQlK8ljIoBN9O7oC2
         Q/UDcpIbS5EvQ==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        James Gruber <jimmyjgruber@gmail.com>,
        Yadwinder Singh <yadi.brar01@gmail.com>,
        Jaswinder Singh <jaswinder.singh@linaro.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: [PATCH 03/12] usb: gadget: f_uac2: Replace snprintf() with the safer scnprintf() variant
Date:   Wed, 13 Dec 2023 16:42:32 +0000
Message-ID: <20231213164246.1021885-4-lee@kernel.org>
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
Cc: James Gruber <jimmyjgruber@gmail.com>
Cc: Yadwinder Singh <yadi.brar01@gmail.com>
Cc: Jaswinder Singh <jaswinder.singh@linaro.org>
Cc: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/usb/gadget/function/f_uac2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index f9a0f07a7476b..383f6854cfec5 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -2045,7 +2045,7 @@ static ssize_t f_uac2_opts_##name##_show(struct config_item *item,	\
 	int result;							\
 									\
 	mutex_lock(&opts->lock);					\
-	result = snprintf(page, sizeof(opts->name), "%s", opts->name);	\
+	result = scnprintf(page, sizeof(opts->name), "%s", opts->name);	\
 	mutex_unlock(&opts->lock);					\
 									\
 	return result;							\
@@ -2063,7 +2063,7 @@ static ssize_t f_uac2_opts_##name##_store(struct config_item *item,	\
 		goto end;						\
 	}								\
 									\
-	ret = snprintf(opts->name, min(sizeof(opts->name), len),	\
+	ret = scnprintf(opts->name, min(sizeof(opts->name), len),	\
 			"%s", page);					\
 									\
 end:									\
@@ -2187,7 +2187,7 @@ static struct usb_function_instance *afunc_alloc_inst(void)
 	opts->req_number = UAC2_DEF_REQ_NUM;
 	opts->fb_max = FBACK_FAST_MAX;
 
-	snprintf(opts->function_name, sizeof(opts->function_name), "Source/Sink");
+	scnprintf(opts->function_name, sizeof(opts->function_name), "Source/Sink");
 
 	opts->p_terminal_type = UAC2_DEF_P_TERM_TYPE;
 	opts->c_terminal_type = UAC2_DEF_C_TERM_TYPE;
-- 
2.43.0.472.g3155946c3a-goog

