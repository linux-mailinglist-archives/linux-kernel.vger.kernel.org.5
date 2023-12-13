Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A3D8119C6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377494AbjLMQm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjLMQmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:42:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390DAAC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:43:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544A4C433CA;
        Wed, 13 Dec 2023 16:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702485780;
        bh=KSAg8fBYTK/g8UcM2sFdqwu8/yDHIW+WrzcjHTdiJFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oAG9v5+tPvaDHtFMQw+V4isvoCeKyHr0+26UlNATao/l4R2pCjfcNwXwwxBi+9rMI
         rT9pWiqzv1QXzOuGBrRe77E3PB2kdxSIdycKipspgwuoaSIkZakjZ1oLcowdUab0Ex
         eYiLRyq1hwbTDL/oC55Mb9NYFcUkfwtmDq0uYb1akYQmugbBJwGfd9ExClKgns9JsB
         su/WftgG+nDCIMTf+vs9MYqVA1VIjFG/bwbMbldosdZvqIt7/ZGJhKlthn9dbGBnn5
         WeOwx9Tc8B+3fu5LhgvX5xxs5azFwI29T3ovol7yOpAQobyetzTEbB9ZvOfVIanxi/
         o3akhp8l1F81Q==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Julian Scheel <julian@jusst.de>, Bryan Wu <cooloney@kernel.org>
Subject: [PATCH 02/12] usb: gadget: f_uac1: Replace snprintf() with the safer scnprintf() variant
Date:   Wed, 13 Dec 2023 16:42:31 +0000
Message-ID: <20231213164246.1021885-3-lee@kernel.org>
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
Cc: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Cc: Julian Scheel <julian@jusst.de>
Cc: Bryan Wu <cooloney@kernel.org>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/usb/gadget/function/f_uac1.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uac1.c b/drivers/usb/gadget/function/f_uac1.c
index 6f0e1d803dc24..998e2331effb0 100644
--- a/drivers/usb/gadget/function/f_uac1.c
+++ b/drivers/usb/gadget/function/f_uac1.c
@@ -1561,7 +1561,7 @@ static ssize_t f_uac1_opts_##name##_show(struct config_item *item,	\
 	int result;							\
 									\
 	mutex_lock(&opts->lock);					\
-	result = snprintf(page, sizeof(opts->name), "%s", opts->name);	\
+	result = scnprintf(page, sizeof(opts->name), "%s", opts->name);	\
 	mutex_unlock(&opts->lock);					\
 									\
 	return result;							\
@@ -1579,7 +1579,7 @@ static ssize_t f_uac1_opts_##name##_store(struct config_item *item,	\
 		goto end;						\
 	}								\
 									\
-	ret = snprintf(opts->name, min(sizeof(opts->name), len),	\
+	ret = scnprintf(opts->name, min(sizeof(opts->name), len),	\
 			"%s", page);					\
 									\
 end:									\
@@ -1685,7 +1685,7 @@ static struct usb_function_instance *f_audio_alloc_inst(void)
 
 	opts->req_number = UAC1_DEF_REQ_NUM;
 
-	snprintf(opts->function_name, sizeof(opts->function_name), "AC Interface");
+	scnprintf(opts->function_name, sizeof(opts->function_name), "AC Interface");
 
 	return &opts->func_inst;
 }
-- 
2.43.0.472.g3155946c3a-goog

