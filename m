Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46127812C5B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443473AbjLNJ6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443502AbjLNJ6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:58:41 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969AC11A;
        Thu, 14 Dec 2023 01:58:45 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1d331f12f45so19658245ad.2;
        Thu, 14 Dec 2023 01:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702547925; x=1703152725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Md3WJ0oNs1hZ2BPjMh8r7Ze0V2gO4q2OZDPAOTLVPAw=;
        b=aJcI1KGGsdo63y+3eY8cZXxcVB9lUSeSmY0SYhGYYwZPsYkNwfXurTfgICNJX/sEXF
         1SnGknoI5DSGQfcwG2zi2zK2eAepdGelTeLEvf1P9E4h23FmbP41XnY5uv/B0Q+nGMmf
         fJGe619+FX8ox/0tXI4LaoksGCVWRNsgsBqiewZhD0z1g4oOQKLC4rp0c7EZ5sQRTPQX
         4naPFutX/gELQJFhHuraQkLGLOHEWhtL5udEk0CKJDyEqSDPHd6DHuOJpUb7GPEDVBgu
         yvtuAXcIasoUgxrcH/S2QX4P7zl9bEtSfKPUaQRoUGV/dCkAAPSzfeR4aotvi0U0dEvd
         JAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702547925; x=1703152725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Md3WJ0oNs1hZ2BPjMh8r7Ze0V2gO4q2OZDPAOTLVPAw=;
        b=QhYe9KB7GDEpxyO4ZL6iNWc4a9OoPz+E9/Ut7haDOSPpIPvUBZFykk1AnsCiaXpMvw
         4DKh/WjABPTpgwyNKnqAE91OTtz7zyLx1FPHlabuLoE93SdAw5F9IEf7jWTwgnlKXvGA
         aRRNFsZ5FXu4ZYjMAB522Gl+rrF0CwZ3j3uEfm/7V76c+0KlMJMCrdTL39lP2CW8xCoX
         kRRMuq8xXRB+DGKp/njpx4jh6DHEGkQyVkBNqXi8HZvDnytzmS0keesVmzZEXc3tD6nn
         FSkpSnC9zTEEKkR9zWvqJ4lcw5pMvt5tXURpksgD6AsmhCJ1SyKYIF13RteJD8ui7F8H
         d7Qw==
X-Gm-Message-State: AOJu0Yz3+1gQUubs4U1Ruv0+MAqTDx4ia/ebCudL0lvbO/QQdOIshz1D
        b8MRS3BiZ5f8055jSl2TYIhivR39ZOE=
X-Google-Smtp-Source: AGHT+IHH2bs2g9tNEdezAHQ+gjqjs9Z9tbX7E+ZhKpw1/cFLa2qzfFM9kJ9txXOh/q4uuzjArxYHog==
X-Received: by 2002:a17:902:db05:b0:1d0:9a64:e51f with SMTP id m5-20020a170902db0500b001d09a64e51fmr6062796plx.0.1702547924809;
        Thu, 14 Dec 2023 01:58:44 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id r2-20020a1709028bc200b001bc6e6069a6sm922807plo.122.2023.12.14.01.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 01:58:44 -0800 (PST)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org, andy@kernel.org
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v2 2/5] gpiolib: cdev: relocate debounce_period_us from struct gpio_desc
Date:   Thu, 14 Dec 2023 17:58:11 +0800
Message-Id: <20231214095814.132400-3-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231214095814.132400-1-warthog618@gmail.com>
References: <20231214095814.132400-1-warthog618@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Store the debounce period for a requested line locally, rather than in
the debounce_period_us field in the gpiolib struct gpio_desc.

Add a global tree of lines containing supplemental line information
to make the debounce period available to be reported by the
GPIO_V2_GET_LINEINFO_IOCTL and the line change notifier.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 drivers/gpio/gpiolib-cdev.c | 167 +++++++++++++++++++++++++++++++-----
 1 file changed, 145 insertions(+), 22 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index d03698812f61..7da3b3706547 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -21,6 +21,7 @@
 #include <linux/mutex.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/poll.h>
+#include <linux/rbtree.h>
 #include <linux/seq_file.h>
 #include <linux/spinlock.h>
 #include <linux/timekeeping.h>
@@ -461,6 +462,7 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
 
 /**
  * struct line - contains the state of a requested line
+ * @node: to store the object in supinfo if supplemental
  * @desc: the GPIO descriptor for this line.
  * @req: the corresponding line request
  * @irq: the interrupt triggered in response to events on this GPIO
@@ -473,6 +475,7 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
  * @line_seqno: the seqno for the current edge event in the sequence of
  * events for this line.
  * @work: the worker that implements software debouncing
+ * @debounce_period_us: the debounce period in microseconds
  * @sw_debounced: flag indicating if the software debouncer is active
  * @level: the current debounced physical level of the line
  * @hdesc: the Hardware Timestamp Engine (HTE) descriptor
@@ -481,6 +484,7 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
  * @last_seqno: the last sequence number before debounce period expires
  */
 struct line {
+	struct rb_node node;
 	struct gpio_desc *desc;
 	/*
 	 * -- edge detector specific fields --
@@ -514,6 +518,15 @@ struct line {
 	 * -- debouncer specific fields --
 	 */
 	struct delayed_work work;
+	/*
+	 * debounce_period_us is accessed by debounce_irq_handler() and
+	 * process_hw_ts() which are disabled when modified by
+	 * debounce_setup(), edge_detector_setup() or edge_detector_stop()
+	 * or can live with a stale version when updated by
+	 * edge_detector_update().
+	 * The modifying functions are themselves mutually exclusive.
+	 */
+	unsigned int debounce_period_us;
 	/*
 	 * sw_debounce is accessed by linereq_set_config(), which is the
 	 * only setter, and linereq_get_values(), which can live with a
@@ -546,6 +559,19 @@ struct line {
 #endif /* CONFIG_HTE */
 };
 
+/*
+ * Used to populate gpio_v2_line_info with cdev specific fields not contained
+ * in the struct gpio_desc.
+ * A line is determined to contain supplemental information by
+ * line_is_supplemental().
+ */
+static struct {
+	/* a rbtree of the struct lines containing the supplemental info */
+	struct rb_root tree;
+	/* covers tree */
+	spinlock_t lock;
+} supinfo;
+
 /**
  * struct linereq - contains the state of a userspace line request
  * @gdev: the GPIO device the line request pertains to
@@ -575,6 +601,100 @@ struct linereq {
 	struct line lines[] __counted_by(num_lines);
 };
 
+static void supinfo_init(void)
+{
+	supinfo.tree = RB_ROOT;
+	spin_lock_init(&supinfo.lock);
+}
+
+static void supinfo_insert(struct line *line)
+{
+	struct rb_node **new = &(supinfo.tree.rb_node), *parent = NULL;
+	struct line *entry;
+
+	scoped_guard(spinlock, &supinfo.lock) {
+		while (*new) {
+			entry = container_of(*new, struct line, node);
+
+			parent = *new;
+			if (line->desc < entry->desc) {
+				new = &((*new)->rb_left);
+			} else if (line->desc > entry->desc) {
+				new = &((*new)->rb_right);
+			} else {
+				/* this should never happen */
+				WARN(1, "duplicate line inserted");
+				return;
+			}
+		}
+
+		rb_link_node(&line->node, parent, new);
+		rb_insert_color(&line->node, &supinfo.tree);
+	}
+}
+
+static void supinfo_erase(struct line *line)
+{
+	scoped_guard(spinlock, &supinfo.lock)
+		rb_erase(&line->node, &supinfo.tree);
+}
+
+static struct line *supinfo_find(struct gpio_desc *desc)
+{
+	struct rb_node *node = supinfo.tree.rb_node;
+	struct line *line;
+
+	while (node) {
+		line = container_of(node, struct line, node);
+		if (desc < line->desc)
+			node = node->rb_left;
+		else if (desc > line->desc)
+			node = node->rb_right;
+		else
+			return line;
+	}
+	return NULL;
+}
+
+static void supinfo_to_lineinfo(struct gpio_desc *desc,
+				struct gpio_v2_line_info *info)
+{
+	struct gpio_v2_line_attribute *attr;
+	struct line *line;
+
+	scoped_guard(spinlock, &supinfo.lock) {
+		line = supinfo_find(desc);
+		if (line) {
+			attr = &info->attrs[info->num_attrs];
+			attr->id = GPIO_V2_LINE_ATTR_ID_DEBOUNCE;
+			attr->debounce_period_us =
+				READ_ONCE(line->debounce_period_us);
+			info->num_attrs++;
+		}
+	}
+}
+
+static inline bool line_is_supplemental(struct line *line)
+{
+	return READ_ONCE(line->debounce_period_us);
+}
+
+static void line_set_debounce_period(struct line *line,
+				     unsigned int debounce_period_us)
+{
+	bool was_suppl = line_is_supplemental(line);
+
+	WRITE_ONCE(line->debounce_period_us, debounce_period_us);
+
+	if (line_is_supplemental(line) == was_suppl)
+		return;
+
+	if (was_suppl)
+		supinfo_erase(line);
+	else
+		supinfo_insert(line);
+}
+
 #define GPIO_V2_LINE_BIAS_FLAGS \
 	(GPIO_V2_LINE_FLAG_BIAS_PULL_UP | \
 	 GPIO_V2_LINE_FLAG_BIAS_PULL_DOWN | \
@@ -723,7 +843,7 @@ static enum hte_return process_hw_ts(struct hte_ts_data *ts, void *p)
 		line->total_discard_seq++;
 		line->last_seqno = ts->seq;
 		mod_delayed_work(system_wq, &line->work,
-		  usecs_to_jiffies(READ_ONCE(line->desc->debounce_period_us)));
+		  usecs_to_jiffies(READ_ONCE(line->debounce_period_us)));
 	} else {
 		if (unlikely(ts->seq < line->line_seqno))
 			return HTE_CB_HANDLED;
@@ -864,7 +984,7 @@ static irqreturn_t debounce_irq_handler(int irq, void *p)
 	struct line *line = p;
 
 	mod_delayed_work(system_wq, &line->work,
-		usecs_to_jiffies(READ_ONCE(line->desc->debounce_period_us)));
+		usecs_to_jiffies(READ_ONCE(line->debounce_period_us)));
 
 	return IRQ_HANDLED;
 }
@@ -946,7 +1066,7 @@ static int debounce_setup(struct line *line, unsigned int debounce_period_us)
 	/* try hardware */
 	ret = gpiod_set_debounce(line->desc, debounce_period_us);
 	if (!ret) {
-		WRITE_ONCE(line->desc->debounce_period_us, debounce_period_us);
+		line_set_debounce_period(line, debounce_period_us);
 		return ret;
 	}
 	if (ret != -ENOTSUPP)
@@ -1025,8 +1145,7 @@ static void edge_detector_stop(struct line *line)
 	cancel_delayed_work_sync(&line->work);
 	WRITE_ONCE(line->sw_debounced, 0);
 	WRITE_ONCE(line->edflags, 0);
-	if (line->desc)
-		WRITE_ONCE(line->desc->debounce_period_us, 0);
+	line_set_debounce_period(line, 0);
 	/* do not change line->level - see comment in debounced_value() */
 }
 
@@ -1051,7 +1170,7 @@ static int edge_detector_setup(struct line *line,
 		ret = debounce_setup(line, debounce_period_us);
 		if (ret)
 			return ret;
-		WRITE_ONCE(line->desc->debounce_period_us, debounce_period_us);
+		line_set_debounce_period(line, debounce_period_us);
 	}
 
 	/* detection disabled or sw debouncer will provide edge detection */
@@ -1093,12 +1212,12 @@ static int edge_detector_update(struct line *line,
 			gpio_v2_line_config_debounce_period(lc, line_idx);
 
 	if ((active_edflags == edflags) &&
-	    (READ_ONCE(line->desc->debounce_period_us) == debounce_period_us))
+	    (READ_ONCE(line->debounce_period_us) == debounce_period_us))
 		return 0;
 
 	/* sw debounced and still will be...*/
 	if (debounce_period_us && READ_ONCE(line->sw_debounced)) {
-		WRITE_ONCE(line->desc->debounce_period_us, debounce_period_us);
+		line_set_debounce_period(line, debounce_period_us);
 		return 0;
 	}
 
@@ -1561,6 +1680,7 @@ static ssize_t linereq_read(struct file *file, char __user *buf,
 
 static void linereq_free(struct linereq *lr)
 {
+	struct line *line;
 	unsigned int i;
 
 	if (lr->device_unregistered_nb.notifier_call)
@@ -1568,10 +1688,14 @@ static void linereq_free(struct linereq *lr)
 						   &lr->device_unregistered_nb);
 
 	for (i = 0; i < lr->num_lines; i++) {
-		if (lr->lines[i].desc) {
-			edge_detector_stop(&lr->lines[i]);
-			gpiod_free(lr->lines[i].desc);
-		}
+		line = &lr->lines[i];
+		if (!line->desc)
+			continue;
+
+		edge_detector_stop(line);
+		if (line_is_supplemental(line))
+			supinfo_erase(line);
+		gpiod_free(line->desc);
 	}
 	kfifo_free(&lr->events);
 	kfree(lr->label);
@@ -2256,8 +2380,6 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
 	struct gpio_chip *gc = desc->gdev->chip;
 	bool ok_for_pinctrl;
 	unsigned long flags;
-	u32 debounce_period_us;
-	unsigned int num_attrs = 0;
 
 	memset(info, 0, sizeof(*info));
 	info->offset = gpio_chip_hwgpio(desc);
@@ -2323,14 +2445,6 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
 	else if (test_bit(FLAG_EVENT_CLOCK_HTE, &desc->flags))
 		info->flags |= GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE;
 
-	debounce_period_us = READ_ONCE(desc->debounce_period_us);
-	if (debounce_period_us) {
-		info->attrs[num_attrs].id = GPIO_V2_LINE_ATTR_ID_DEBOUNCE;
-		info->attrs[num_attrs].debounce_period_us = debounce_period_us;
-		num_attrs++;
-	}
-	info->num_attrs = num_attrs;
-
 	spin_unlock_irqrestore(&gpio_lock, flags);
 }
 
@@ -2437,6 +2551,7 @@ static int lineinfo_get(struct gpio_chardev_data *cdev, void __user *ip,
 			return -EBUSY;
 	}
 	gpio_desc_to_lineinfo(desc, &lineinfo);
+	supinfo_to_lineinfo(desc, &lineinfo);
 
 	if (copy_to_user(ip, &lineinfo, sizeof(lineinfo))) {
 		if (watch)
@@ -2527,6 +2642,7 @@ static int lineinfo_changed_notify(struct notifier_block *nb,
 	chg.event_type = action;
 	chg.timestamp_ns = ktime_get_ns();
 	gpio_desc_to_lineinfo(desc, &chg.info);
+	supinfo_to_lineinfo(desc, &chg.info);
 
 	ret = kfifo_in_spinlocked(&cdev->events, &chg, 1, &cdev->wait.lock);
 	if (ret)
@@ -2786,3 +2902,10 @@ void gpiolib_cdev_unregister(struct gpio_device *gdev)
 	cdev_device_del(&gdev->chrdev, &gdev->dev);
 	blocking_notifier_call_chain(&gdev->device_notifier, 0, NULL);
 }
+
+static int __init gpiolib_cdev_init(void)
+{
+	supinfo_init();
+	return 0;
+}
+postcore_initcall(gpiolib_cdev_init);
-- 
2.39.2

