Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D812A7F857F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 22:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjKXVa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 16:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbjKXVao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 16:30:44 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18EC1BCD
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 13:30:42 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50ba6881282so148891e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 13:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700861441; x=1701466241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7G27DLDSnr98RUfDdYxVys5pn2qiQC28hb1GX/OMO0I=;
        b=MabYu45wjiDBq4byElOD5vzbuPvynSuopzPPa42V4xYNkyse2nj2y0YRrMH1oiw1TK
         iqUHvlDKVTzkrvvfuSRrVOsfb1chQMZOUyumG/qu8nE9KSjDTcQwUp14NjNMmMmit2RI
         Cvgv4f8FMegFf2Ekg01vd2AOmbKwQ5x8iIy5tuWb4pa30mFlv4SiHiv5ebU4+xelVn2j
         E+caj/0gT9sulh0/zk6Hx5A/TSoFrxflT8tH6iD6DIL+8UgIx6AE4vV0mfnioE3zATlB
         rdY12p4UaJFhiP7UCugYPg+fsej/xO1ZMQFJIOUpNA2yqXnMOljbBe0lnhExkGgCQcF6
         Ikxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700861441; x=1701466241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7G27DLDSnr98RUfDdYxVys5pn2qiQC28hb1GX/OMO0I=;
        b=S4hs5B9r6juA7w2kGyppnhEOJOE/WkruBUjQYzK6mATFt1uZ6SLWgLw3RDJrZDYzGS
         VntthGNmbFrIFGeuabyfcdqBfXR3agmgbJcDfge73gBdCgY2UsQZ4ucTBJ/8adQZLnbF
         o5onzufIWf+izHPf6kkO7Htk03IsZJ5YDB6A35y4kKLPbccI3Q51vR5OwaCQ2jG8iGOt
         09BMkkS+ZVCMo2jIXzNGdYAa4QYpjMt7qMDVpJ2x7FMukvVW5J73n4aENR+ntGNV+jrD
         476XY3GIXrqZEbGpZ6nNtNq2zNgWCTuJF/QsfjQlEEVH2tt3qRzXkZuBQpifx0Ubyyj+
         BIYw==
X-Gm-Message-State: AOJu0Yz3257uxFwmzLWURAd5Og359cT/5Db/06Iy94jUrYDJNBt5nvuO
        KtmLv5QbptJKoRZrDzAN6Nc=
X-Google-Smtp-Source: AGHT+IFlYdG7tyeIYbb8Y7pITwOO+/AGFM093dRsUC8/YvjlAYnA3fBVfLMrwtAQKK6QP0i2QzzMKQ==
X-Received: by 2002:a05:6512:3b0a:b0:507:b1b8:cf0a with SMTP id f10-20020a0565123b0a00b00507b1b8cf0amr2922142lfv.3.1700861440913;
        Fri, 24 Nov 2023 13:30:40 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id x22-20020a170906135600b009efe6fdf615sm2519712ejb.150.2023.11.24.13.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 13:30:40 -0800 (PST)
Date:   Fri, 24 Nov 2023 22:30:39 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] staging: rtl8192e: Remove unused function
 rtllib_get_beacon()
Message-ID: <d76eeb7e273f4fcfec4ae8879e56d237363ebde2.1700860758.git.philipp.g.hortmann@gmail.com>
References: <cover.1700860758.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1700860758.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused function rtllib_get_beacon().

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h         |  1 -
 drivers/staging/rtl8192e/rtllib_softmac.c | 21 ---------------------
 2 files changed, 22 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 5d6563d12480..835b407ab180 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1693,7 +1693,6 @@ void rtllib_softmac_start_protocol(struct rtllib_device *ieee);
 void rtllib_reset_queue(struct rtllib_device *ieee);
 void rtllib_wake_all_queues(struct rtllib_device *ieee);
 void rtllib_stop_all_queues(struct rtllib_device *ieee);
-struct sk_buff *rtllib_get_beacon(struct rtllib_device *ieee);
 
 void notify_wx_assoc_event(struct rtllib_device *ieee);
 void rtllib_ps_tx_ack(struct rtllib_device *ieee, short success);
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 2ce4f64f88f6..0ad08165fd85 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2180,27 +2180,6 @@ static struct sk_buff *rtllib_get_beacon_(struct rtllib_device *ieee)
 	return skb;
 }
 
-struct sk_buff *rtllib_get_beacon(struct rtllib_device *ieee)
-{
-	struct sk_buff *skb;
-	struct rtllib_probe_response *b;
-
-	skb = rtllib_get_beacon_(ieee);
-	if (!skb)
-		return NULL;
-
-	b = (struct rtllib_probe_response *)skb->data;
-	b->header.seq_ctrl = cpu_to_le16(ieee->seq_ctrl[0] << 4);
-
-	if (ieee->seq_ctrl[0] == 0xFFF)
-		ieee->seq_ctrl[0] = 0;
-	else
-		ieee->seq_ctrl[0]++;
-
-	return skb;
-}
-EXPORT_SYMBOL(rtllib_get_beacon);
-
 void rtllib_softmac_stop_protocol(struct rtllib_device *ieee)
 {
 	rtllib_stop_scan_syncro(ieee);
-- 
2.42.0

