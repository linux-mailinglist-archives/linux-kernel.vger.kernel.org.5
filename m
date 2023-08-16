Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73EBD77E162
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 14:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245132AbjHPMVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 08:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245083AbjHPMUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:20:42 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A202626A9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 05:20:41 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe1d462762so59809085e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 05:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692188440; x=1692793240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dP05q+RMOmNQ4Gl3VVSG0OrbP/ydNsWsk2YHlDd9aGg=;
        b=34QaAQx3vESmEiokl+YyNZrO0ncceSOT4XSxS0lcblrN+BAodcHQU1H2gh+RX91BhJ
         aD7f1IE/5OfXZ0S3X0l1ZqhjxW5OroxThQt5F2ue3iVsUt1jBs0YAPYrS8SDa5n+UogO
         PFfKDGsH2Ht8j5A6xDDPEp9/BOIqoLFMR+UQD2AVlqoRbJ6w0jNFv0STGrjDsff+KC02
         7jAEU/SXhZzjU/tRTeSIh/p9WV4ncvfa+chMbxPsKYdshIdK6vFxuXqg2suKmDSbgUwz
         cQElJ3lI11PWBYyqD2PcfGBIvujXpFmfMdikcgwBgFzGo0uD/R7DYvFdlUHqzexvTNyO
         I7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692188440; x=1692793240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dP05q+RMOmNQ4Gl3VVSG0OrbP/ydNsWsk2YHlDd9aGg=;
        b=Ht2hIE/e4k9DJ1qqTJ+RhFh56DYnSgf4CdPzshtclBWG/a3zu6AZNzkf1Mi0cj6jkw
         IvE8B1tan84DsI00S9K6IghLDIxW4vH4EvnCjDjcq8W1YG7lqkJkb1dGICJ/o20VrBB4
         nXW8n+1EeLhOnQsk/QCoQYk6LJPNBk+50eIJEtV9OLYJoTqhcLi/m+K+FcrTT16qa0aY
         z7poD3w+YAAY/JTQXPTsqOqME3MXMtWNqktuHzHGw/kVsX0Tn28loZbDGxk2FCUxnKcy
         yFpU1csiAaw9vxhM8pCQoqYyifVHdWREIIO6Y0yaNdQKCdvAxsoWXQu2Q70I3iY8+C+q
         JsFg==
X-Gm-Message-State: AOJu0YzLK5PKkTGXmURS0wNEqy/j+k3/B+ldSRXP3/NiAEy/tqsZ4h1D
        1rAoAXQxfiXPXJIGmT3LV8XUCw==
X-Google-Smtp-Source: AGHT+IEV+ik5O//GvPEkYWy5rfWG/+BGwXrQ9jf7vpe8YseN9XyYNkJC6rCwpUPFnzdZtXteJF79cQ==
X-Received: by 2002:a7b:cd8c:0:b0:3fa:9767:c816 with SMTP id y12-20020a7bcd8c000000b003fa9767c816mr1446313wmj.39.1692188440111;
        Wed, 16 Aug 2023 05:20:40 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:55ba:c083:817:86f])
        by smtp.gmail.com with ESMTPSA id e6-20020adffd06000000b003196b1bb528sm14566112wrr.64.2023.08.16.05.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 05:20:39 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 5/5] gpio: cdev: wake up lineevent poll() on device unbind
Date:   Wed, 16 Aug 2023 14:20:32 +0200
Message-Id: <20230816122032.15548-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816122032.15548-1-brgl@bgdev.pl>
References: <20230816122032.15548-1-brgl@bgdev.pl>
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

Extend struct lineevent_data with a notifier block and use it to receive
the GPIO device unregister event. Upon reception, wake up the wait queue
so that the user-space be forced out of poll() and need to go into a new
system call which will then fail due to the chip being gone.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-cdev.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 0b21ea04fa52..bb6a011f7857 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1830,9 +1830,15 @@ struct lineevent_state {
 	int irq;
 	wait_queue_head_t wait;
 	DECLARE_KFIFO(events, struct gpioevent_data, 16);
+	struct notifier_block nb;
 	u64 timestamp;
 };
 
+static struct lineevent_state *to_lineevent_state(struct notifier_block *nb)
+{
+	return container_of(nb, struct lineevent_state, nb);
+}
+
 #define GPIOEVENT_REQUEST_VALID_FLAGS \
 	(GPIOEVENT_REQUEST_RISING_EDGE | \
 	GPIOEVENT_REQUEST_FALLING_EDGE)
@@ -1947,6 +1953,9 @@ static ssize_t lineevent_read(struct file *file, char __user *buf,
 
 static void lineevent_free(struct lineevent_state *le)
 {
+	if (le->nb.notifier_call)
+		blocking_notifier_chain_unregister(&le->gdev->notifier,
+						   &le->nb);
 	if (le->irq)
 		free_irq(le->irq, le);
 	if (le->desc)
@@ -2084,6 +2093,22 @@ static irqreturn_t lineevent_irq_handler(int irq, void *p)
 	return IRQ_WAKE_THREAD;
 }
 
+static int lineevent_notify(struct notifier_block *nb, unsigned long action,
+			    void *data)
+{
+	struct lineevent_state *le = to_lineevent_state(nb);
+
+	switch (action) {
+	case GPIO_CDEV_UNREGISTERED:
+		wake_up_poll(&le->wait, EPOLLIN | EPOLLERR);
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
 static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 {
 	struct gpioevent_request eventreq;
@@ -2175,6 +2200,11 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	INIT_KFIFO(le->events);
 	init_waitqueue_head(&le->wait);
 
+	le->nb.notifier_call = lineevent_notify;
+	ret = blocking_notifier_chain_register(&gdev->notifier, &le->nb);
+	if (ret)
+		goto out_free_le;
+
 	/* Request a thread to read the events */
 	ret = request_threaded_irq(irq,
 				   lineevent_irq_handler,
-- 
2.39.2

