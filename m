Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9E377FE49
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 21:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237142AbjHQTBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 15:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354583AbjHQSuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:50:14 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2482D64
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:50:13 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe5c0e5747so976325e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692298212; x=1692903012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kVt4UaEckj/OVSUq+AY8VPPJo4yqLEpGjl9otmnnyg=;
        b=ie4buCgMtbVu3kOFSWsnDYS8jBNS8e9g6vpCbKP8e2rDg8wTzklwY+VbgFsx6vX4t8
         hvfnQ6lGuYHl+lGuCTDTGYcLX/2wpO37OGyve7s6L9Ugpo6otpVQMYU9NvAwiJdax9Vc
         OW3/fPEk85VbPhcks0aLcjac9Z/PGLIvpmsZzZa/pM1w6cpDLjoiYpa3wF6TwJ2N66aD
         3Yb4oZGITDyZz2ABoD3ryiSA7oVw9nX/eqDlDb8VQtA5MnPXewjJVr0nRtv6sa9fs0mm
         EpaGVKrO+LXshyF4B9GnK4rSxP3H28CheAt3lHtPh3wIXmLrGKs6m7IUrlLgXHDfh9pg
         kxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692298212; x=1692903012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8kVt4UaEckj/OVSUq+AY8VPPJo4yqLEpGjl9otmnnyg=;
        b=OILBB1RJEEyL8yfDZ0OhlvVEeiDn7q+i83n0I0+eGa39/y1Wh9dP+k6M38ckTiNw1g
         UZWUT8MH6pqlhVc3SIBJwOCFbM/U8w10ij+0mVxS/uzphPOoUKWTzmSXjQllfEb8ce3w
         d+9mDbKOFMdsj069IAWd/79aejCbhy9x2Qe6LWy4PHJJlTGRI9FsZMoKKLUwi98tFrSw
         SdXdK7yLEiPIqiGNoWJDb0M9FIfBbDv38NF1IflOyaTKwMZWQ4I/3V5EW7bmJAmm1EpU
         jvLxHPJNx1kca8RBn2DHsuCU2mrkdmNdAYbAW80cnUG7ztLq1DArL/8OpYWPUVjHOsB5
         PnpQ==
X-Gm-Message-State: AOJu0Yx5cK+DtTXMsI7+iDrCijZgzkwfL+yg8Is3v7Hr2PdLBNwryWEr
        TtUArzrZttsBoYbyz2VldKwcWg==
X-Google-Smtp-Source: AGHT+IGa0mywF2NM0O4rN+E+N22z2zGoSyswdtJ2cOuvxwj301QyVM3fuuFhUWCLMCbxcN5eybT61Q==
X-Received: by 2002:a1c:4c12:0:b0:3fb:af9a:bf30 with SMTP id z18-20020a1c4c12000000b003fbaf9abf30mr195111wmf.2.1692298211708;
        Thu, 17 Aug 2023 11:50:11 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:2f99:c690:b4da:e3d2])
        by smtp.gmail.com with ESMTPSA id a23-20020a05600c225700b003fe1cdbc33dsm3963020wmm.9.2023.08.17.11.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 11:50:11 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 5/6] gpio: cdev: wake up linereq poll() on device unbind
Date:   Thu, 17 Aug 2023 20:49:57 +0200
Message-Id: <20230817184958.25349-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230817184958.25349-1-brgl@bgdev.pl>
References: <20230817184958.25349-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a notifier block to the linereq structure and register it with the
gpio_device's device notifier. Upon reception of an event, wake up the
wait queue so that the user-space be forced out of poll() and need to go
into a new system call which will then fail due to the chip being gone.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-cdev.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 8b081c9b8d27..4c3b186bc638 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -555,6 +555,7 @@ struct line {
  * @label: consumer label used to tag GPIO descriptors
  * @num_lines: the number of lines in the lines array
  * @wait: wait queue that handles blocking reads of events
+ * @device_unregistered_nb: notifier block for receiving gdev unregister events
  * @event_buffer_size: the number of elements allocated in @events
  * @events: KFIFO for the GPIO events
  * @seqno: the sequence number for edge events generated on all lines in
@@ -569,6 +570,7 @@ struct linereq {
 	const char *label;
 	u32 num_lines;
 	wait_queue_head_t wait;
+	struct notifier_block device_unregistered_nb;
 	u32 event_buffer_size;
 	DECLARE_KFIFO_PTR(events, struct gpio_v2_line_event);
 	atomic_t seqno;
@@ -610,6 +612,17 @@ struct linereq {
 	 GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE | \
 	 GPIO_V2_LINE_EDGE_FLAGS)
 
+static int linereq_unregistered_notify(struct notifier_block *nb,
+				       unsigned long action, void *data)
+{
+	struct linereq *lr = container_of(nb, struct linereq,
+					  device_unregistered_nb);
+
+	wake_up_poll(&lr->wait, EPOLLIN | EPOLLERR);
+
+	return NOTIFY_OK;
+}
+
 static void linereq_put_event(struct linereq *lr,
 			      struct gpio_v2_line_event *le)
 {
@@ -1567,6 +1580,10 @@ static void linereq_free(struct linereq *lr)
 {
 	unsigned int i;
 
+	if (lr->device_unregistered_nb.notifier_call)
+		blocking_notifier_chain_unregister(&lr->gdev->device_notifier,
+						   &lr->device_unregistered_nb);
+
 	for (i = 0; i < lr->num_lines; i++) {
 		if (lr->lines[i].desc) {
 			edge_detector_stop(&lr->lines[i]);
@@ -1727,6 +1744,12 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 			offset);
 	}
 
+	lr->device_unregistered_nb.notifier_call = linereq_unregistered_notify;
+	ret = blocking_notifier_chain_register(&gdev->device_notifier,
+					       &lr->device_unregistered_nb);
+	if (ret)
+		goto out_free_linereq;
+
 	fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
 	if (fd < 0) {
 		ret = fd;
-- 
2.39.2

