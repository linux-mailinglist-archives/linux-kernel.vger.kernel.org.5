Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933717B17A5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjI1Jjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbjI1JjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:39:23 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C2ACE7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:39:06 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3226b8de467so10837743f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1695893945; x=1696498745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUAvpHbZIlJDAymrC3wO69unj3kyTMzvS96nKCkH42g=;
        b=QCw8itSkMqpC5Prk0VPaoql/XSrWr14r5OHinGiKdig7dubkSVYoFamSqilNgisdx5
         0kwunV7CjHNNCPp56sMJiFlODTk0YUjN4yLCCMGo4D2RRGj8i/AzGjyPzUOqt/BwuUJ/
         VxplwlXtJGxeBvOzNhI45xMl3X8NQVWZirvU6d3UfK5PKV3JrbQZU19luk2vuaykZQcc
         TQIkgJgOEgByhapcL+g6gH2pENMFUmOSkETV2uIDUTrZJ3HWIqTt+WyHMGB39mRarVdq
         z3lSMzh5Igj3YBPngkprUem45GgW/L8CFwfeZdGfSaialid5MLfNktX8kNGezalImPwc
         qHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695893945; x=1696498745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUAvpHbZIlJDAymrC3wO69unj3kyTMzvS96nKCkH42g=;
        b=vJ1Q8oBDf5A9JjD9euKEKg8WuK48LPB2xGAY+f3CVvhA72bodfn44MkSPkDWXqiEbk
         Yb4zAVp6PzHNXDQ0zh210c8UKXrSriLeOlGifKannKwb5oAkonb/PXKbEAFq0oJ944a9
         TepAfWem7L9Fjhlr0MV/Iy2AUByI5VyhFWrDH8/xqCTpmtNR0xhBRP7YJ+e5Px/ht2yU
         YIxr8y/9lxF279uhzkBkzryI7g/cTsbmPFitutVu/YKR1/msA7ijLiqp73+W+r3bER6N
         ydjX3cy6SY+0kgRC6adkcMtbGK07mF1h9oixGFVk4ZL8eoPaCyLkht2ullocrKr0d0D+
         DUCA==
X-Gm-Message-State: AOJu0YxPYnx9cni1TKn34B7ql5Vl21JeT4dMpGiA4vp7TRyuQQtcj5mT
        ao1o/XAsgTO2qeZp35bi1FDbGik3XnE2UNJvfzBTvg==
X-Google-Smtp-Source: AGHT+IFOh1UVdUIHYK2shBxIs9apOwc+4FRG5zqxR/3bZCY1dSSV3c0K6NkS/zzqRscr/ae10XfuIw==
X-Received: by 2002:a5d:4985:0:b0:320:10c:37a4 with SMTP id r5-20020a5d4985000000b00320010c37a4mr712514wrq.21.1695893944947;
        Thu, 28 Sep 2023 02:39:04 -0700 (PDT)
Received: from localhost.localdomain (213-225-13-130.nat.highway.a1.net. [213.225.13.130])
        by smtp.gmail.com with ESMTPSA id f4-20020a5d50c4000000b0031fa870d4b3sm18931449wrt.60.2023.09.28.02.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 02:39:04 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars@linbit.com>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Joel Colledge <joel.colledge@linbit.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 5/5] drbd: Get rid of conn_reconfig_start() and conn_reconfig_done()
Date:   Thu, 28 Sep 2023 11:38:52 +0200
Message-ID: <20230928093852.676786-6-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928093852.676786-1-christoph.boehmwalder@linbit.com>
References: <20230928093852.676786-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally-from: Andreas Gruenbacher <agruen@kernel.org>
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_nl.c | 34 +++-------------------------------
 1 file changed, 3 insertions(+), 31 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 85ab6f0f9d87..5de8a6641253 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1349,28 +1349,6 @@ void drbd_reconsider_queue_parameters(struct drbd_device *device, struct drbd_ba
 	drbd_setup_queue_param(device, bdev, new, o);
 }
 
-/* Starts the sender thread */
-static void conn_reconfig_start(struct drbd_connection *connection)
-{
-	drbd_thread_start(&connection->sender);
-	drbd_flush_workqueue(&connection->sender_work);
-}
-
-/* if still unconfigured, stops sender again. */
-static void conn_reconfig_done(struct drbd_connection *connection)
-{
-	bool stop_threads;
-	spin_lock_irq(&connection->resource->req_lock);
-	stop_threads = connection->cstate == C_STANDALONE;
-	spin_unlock_irq(&connection->resource->req_lock);
-	if (stop_threads) {
-		/* ack_receiver thread and ack_sender workqueue are implicitly
-		 * stopped by receiver in conn_disconnect() */
-		drbd_thread_stop(&connection->receiver);
-		drbd_thread_stop(&connection->sender);
-	}
-}
-
 /* Make sure IO is suspended before calling this function(). */
 static void drbd_suspend_al(struct drbd_device *device)
 {
@@ -2382,7 +2360,7 @@ int drbd_adm_net_opts(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
-	conn_reconfig_start(connection);
+	drbd_flush_workqueue(&connection->sender_work);
 
 	mutex_lock(&connection->data.mutex);
 	mutex_lock(&connection->resource->conf_update);
@@ -2461,15 +2439,13 @@ int drbd_adm_net_opts(struct sk_buff *skb, struct genl_info *info)
 			drbd_send_sync_param(peer_device);
 	}
 
-	goto done;
+	goto out;
 
  fail:
 	mutex_unlock(&connection->resource->conf_update);
 	mutex_unlock(&connection->data.mutex);
 	free_crypto(&crypto);
 	kfree(new_net_conf);
- done:
-	conn_reconfig_done(connection);
  out:
 	mutex_unlock(&adm_ctx.resource->adm_mutex);
  finish:
@@ -2548,7 +2524,6 @@ int drbd_adm_connect(struct sk_buff *skb, struct genl_info *info)
 
 	mutex_lock(&adm_ctx.resource->adm_mutex);
 	connection = first_connection(adm_ctx.resource);
-	conn_reconfig_start(connection);
 
 	if (connection->cstate > C_STANDALONE) {
 		retcode = ERR_NET_CONFIGURED;
@@ -2581,8 +2556,6 @@ int drbd_adm_connect(struct sk_buff *skb, struct genl_info *info)
 
 	((char *)new_net_conf->shared_secret)[SHARED_SECRET_MAX-1] = 0;
 
-	drbd_flush_workqueue(&connection->sender_work);
-
 	mutex_lock(&adm_ctx.resource->conf_update);
 	old_net_conf = connection->net_conf;
 	if (old_net_conf) {
@@ -2631,7 +2604,7 @@ int drbd_adm_connect(struct sk_buff *skb, struct genl_info *info)
 
 	rv = conn_request_state(connection, NS(conn, C_UNCONNECTED), CS_VERBOSE);
 
-	conn_reconfig_done(connection);
+	drbd_thread_start(&connection->sender);
 	mutex_unlock(&adm_ctx.resource->adm_mutex);
 	drbd_adm_finish(&adm_ctx, info, rv);
 	return 0;
@@ -2640,7 +2613,6 @@ int drbd_adm_connect(struct sk_buff *skb, struct genl_info *info)
 	free_crypto(&crypto);
 	kfree(new_net_conf);
 
-	conn_reconfig_done(connection);
 	mutex_unlock(&adm_ctx.resource->adm_mutex);
 out:
 	drbd_adm_finish(&adm_ctx, info, retcode);
-- 
2.41.0

