Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C7A77E161
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 14:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245121AbjHPMVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 08:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245081AbjHPMUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:20:42 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB922136
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 05:20:40 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9a828c920so98384041fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 05:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692188439; x=1692793239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Am7bI6bfSitSW1lki/Nh1/0VtCPZ62yUJw5gPNa+qeo=;
        b=w0B7/+FuLacJhBAv6aShs3+zb2UZ8ABq2mnih8O4abteYETwWx5tR4GeIUJwHSS7pI
         NAXRnsgA3EtFmLbrgxFb8l1u2uBWAFgOR183W0dacaSWX325Vh8KcUBZDpRiB1vNZdMH
         5FbSjSyWs5UT5iqI4HJYe9YQ5dAKCKDaVa7CLesL4faIioCl4Dk2+C+RtLcwvHHQ/DDh
         41R/Dng25t16C+1szjVA4rC3ReVPaO08GO/TTWGkNDwopLH3oW4JnjIZwCseW4zmowW4
         am1D1LJ7aYnmrL0BB48IOJjgYLxmjY6z6Wi/oUfGGSurA3NMHn2OqhLCwVindZ7R5Lcv
         bcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692188439; x=1692793239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Am7bI6bfSitSW1lki/Nh1/0VtCPZ62yUJw5gPNa+qeo=;
        b=glT/7L038X5F6WDkyEoMALhg2ufR1gSu9AnC6J1cnwXfbYxVBzpBXSAYdR4X17Bdc/
         HDy2RrBuSBx9OdaWUHf5Rggsw5TLh0oe2QO5IiyP72NjqOT71qxF0pMUSOjkkULSc8mf
         7t4D2Zyqvw8yEl5iDdfk7wMNGGKBzaOpVFb/YpP1eI3p7yxu3q/gsYeGDhGmJrHbLcnb
         nn+5+VyNcJ9xg0K3VYKDkjRymqet4XxKNK3e4PD317AeOJAx9xC/Dh9It96PPelMBQmc
         j6KdXbgPfjyj/4PO7QokOVx9WijgZMQuvfjaiYfOtQ2Ujyb92+N3QH6T2CcXMhtNqRzC
         6Bjw==
X-Gm-Message-State: AOJu0Yx0jeQbo8nxu0rRyuAqR7pDr6vcfHXOJ1dx2QGG0x2LDPj/vKyN
        05zR9udqBgzfix37BYuZgKv+GMknfXLtUylWHDCoWw==
X-Google-Smtp-Source: AGHT+IENColA7BIp/lKtNBrXBzmg8CdpZ/MoVKtFHesq7ljpKBW2+rbY2oBTtgZjc3gsboJdLLhpTA==
X-Received: by 2002:a2e:9ac6:0:b0:2b6:a6e7:5afa with SMTP id p6-20020a2e9ac6000000b002b6a6e75afamr1498211ljj.12.1692188439174;
        Wed, 16 Aug 2023 05:20:39 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:55ba:c083:817:86f])
        by smtp.gmail.com with ESMTPSA id e6-20020adffd06000000b003196b1bb528sm14566112wrr.64.2023.08.16.05.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 05:20:38 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 4/5] gpio: cdev: wake up linereq poll() on device unbind
Date:   Wed, 16 Aug 2023 14:20:31 +0200
Message-Id: <20230816122032.15548-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816122032.15548-1-brgl@bgdev.pl>
References: <20230816122032.15548-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Extend struct linereq with a notifier block and use it to receive the
GPIO device unregister event. Upon reception, wake up the wait queue so
that the user-space be forced out of poll() and need to go into a new
system call which will then fail due to the chip being gone.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-cdev.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index eb8c0cb71da4..0b21ea04fa52 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -563,6 +563,7 @@ struct line {
  * @wait: wait queue that handles blocking reads of events
  * @event_buffer_size: the number of elements allocated in @events
  * @events: KFIFO for the GPIO events
+ * @nb: notifier block for receiving gpio_device notifications
  * @seqno: the sequence number for edge events generated on all lines in
  * this line request.  Note that this is not used when @num_lines is 1, as
  * the line_seqno is then the same and is cheaper to calculate.
@@ -577,11 +578,17 @@ struct linereq {
 	wait_queue_head_t wait;
 	u32 event_buffer_size;
 	DECLARE_KFIFO_PTR(events, struct gpio_v2_line_event);
+	struct notifier_block nb;
 	atomic_t seqno;
 	struct mutex config_mutex;
 	struct line lines[];
 };
 
+static struct linereq *to_linereq(struct notifier_block *nb)
+{
+	return container_of(nb, struct linereq, nb);
+}
+
 #define GPIO_V2_LINE_BIAS_FLAGS \
 	(GPIO_V2_LINE_FLAG_BIAS_PULL_UP | \
 	 GPIO_V2_LINE_FLAG_BIAS_PULL_DOWN | \
@@ -1573,6 +1580,10 @@ static void linereq_free(struct linereq *lr)
 {
 	unsigned int i;
 
+	if (lr->nb.notifier_call)
+		blocking_notifier_chain_unregister(&lr->gdev->notifier,
+						   &lr->nb);
+
 	for (i = 0; i < lr->num_lines; i++) {
 		if (lr->lines[i].desc) {
 			edge_detector_stop(&lr->lines[i]);
@@ -1623,6 +1634,22 @@ static const struct file_operations line_fileops = {
 #endif
 };
 
+static int linereq_notify(struct notifier_block *nb, unsigned long action,
+			  void *data)
+{
+	struct linereq *lr = to_linereq(nb);
+
+	switch (action) {
+	case GPIO_CDEV_UNREGISTERED:
+		wake_up_poll(&lr->wait, EPOLLIN | EPOLLERR);
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
 static int linereq_create(struct gpio_device *gdev, void __user *ip)
 {
 	struct gpio_v2_line_request ulr;
@@ -1733,6 +1760,11 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
 			offset);
 	}
 
+	lr->nb.notifier_call = linereq_notify;
+	ret = blocking_notifier_chain_register(&gdev->notifier, &lr->nb);
+	if (ret)
+		goto out_free_linereq;
+
 	fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
 	if (fd < 0) {
 		ret = fd;
-- 
2.39.2

