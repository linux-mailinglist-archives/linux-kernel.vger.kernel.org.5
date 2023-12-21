Return-Path: <linux-kernel+bounces-7723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E40E881AC21
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 566EF1F24739
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71D2184C;
	Thu, 21 Dec 2023 01:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVdHktCq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559DF4419;
	Thu, 21 Dec 2023 01:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6da69dd6e9fso189255a34.1;
        Wed, 20 Dec 2023 17:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703121732; x=1703726532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oIuaHLOj8O8LSsFxzvBYQlFdWLFJBkiRSrLUWFUI2U=;
        b=UVdHktCq3w70KOorItu17K2Fve6VFbveD+CAUOP4rWxUIH1HjMW7rIAvf5g5Qtt8LN
         OZolnuC8WjLp4TOXj3v6nWJRNDKXJHJbiSd4/RPadPKTCVHUjFI++oc39SQYK8JKydiO
         8iwPJBeH7CMNbgG438InKpWQc4XNX47SMAj7FmV2twmGPhXqvW/heInOW/MnSAaNa9jo
         SZpiCTOOGZ0RVdlRbsFEbuG6YXZskEoi+rtGlbyR606P63D5NvW+HHm9SXB3lrb373fx
         6hdSEmB5Q72jJXv27Z69bSXf9nmqXs7z/LoMQ4XAtmo7nwsJevvgTGn/ar7cmcVQfERW
         bFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703121732; x=1703726532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4oIuaHLOj8O8LSsFxzvBYQlFdWLFJBkiRSrLUWFUI2U=;
        b=ivf1zgAFhOOp16VNnUHxKuhVg8JTinjQ4IrXWTp/tlUeNdvhTnZFcFve7m+WSQezfg
         MVNRPwgDk65aw55nqAPshX6yOPLj2A1PfMoDplJFb8GfsCqkpucPPSyncgZE6oxCIk9j
         sQ+S/NFjGOAeGxyFigcn/spUgj2zRvyckcB8vTvJQ1XFf3rK0YvFI3aocUf+8XDIji36
         3+/CSMhjcHaE8Cela1zDTuXGW2afQodx/OxRjswAk+Vaf8ArNYz3cFKMKgNhMH0mWqIc
         nL+MuDc/lgk/guHTNg613ajkr/uhqzgNeJUUiX67bJMKJU2xl+A3Xi7fYv5hjVHvu6ML
         lEUg==
X-Gm-Message-State: AOJu0Yy1DUtxVWNMmsop8xfteevzuRjWL8iPBdHgN1h/PVAgxiP+UrbE
	8nmahs87tWLBXT44/KndQxTELwUC0ZI=
X-Google-Smtp-Source: AGHT+IGAnDITY3XgghV1SlTFLy/8kmlDmtPvvVrotVqkefawGSjwgRRMI0P217+kADCnXhW3jseUIQ==
X-Received: by 2002:a05:6830:138a:b0:6db:b215:ad8d with SMTP id d10-20020a056830138a00b006dbb215ad8dmr1070230otq.36.1703121732119;
        Wed, 20 Dec 2023 17:22:12 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id x1-20020a056a00270100b006d088356541sm375959pfv.104.2023.12.20.17.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 17:22:11 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v2 5/5] gpiolib: cdev: replace locking wrappers for gpio_device with guards
Date: Thu, 21 Dec 2023 09:20:40 +0800
Message-Id: <20231221012040.17763-6-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231221012040.17763-1-warthog618@gmail.com>
References: <20231221012040.17763-1-warthog618@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the wrapping functions that inhibit removal of the gpio chip
with equivalent guards.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 drivers/gpio/gpiolib-cdev.c | 205 +++++++++---------------------------
 1 file changed, 47 insertions(+), 158 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 9ff2b447cc20..2a88736629ef 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -24,6 +24,7 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/poll.h>
 #include <linux/rbtree.h>
+#include <linux/rwsem.h>
 #include <linux/seq_file.h>
 #include <linux/spinlock.h>
 #include <linux/timekeeping.h>
@@ -65,45 +66,6 @@ typedef long (*ioctl_fn)(struct file *, unsigned int, unsigned long);
 typedef ssize_t (*read_fn)(struct file *, char __user *,
 			   size_t count, loff_t *);
 
-static __poll_t call_poll_locked(struct file *file,
-				 struct poll_table_struct *wait,
-				 struct gpio_device *gdev, poll_fn func)
-{
-	__poll_t ret;
-
-	down_read(&gdev->sem);
-	ret = func(file, wait);
-	up_read(&gdev->sem);
-
-	return ret;
-}
-
-static long call_ioctl_locked(struct file *file, unsigned int cmd,
-			      unsigned long arg, struct gpio_device *gdev,
-			      ioctl_fn func)
-{
-	long ret;
-
-	down_read(&gdev->sem);
-	ret = func(file, cmd, arg);
-	up_read(&gdev->sem);
-
-	return ret;
-}
-
-static ssize_t call_read_locked(struct file *file, char __user *buf,
-				size_t count, loff_t *f_ps,
-				struct gpio_device *gdev, read_fn func)
-{
-	ssize_t ret;
-
-	down_read(&gdev->sem);
-	ret = func(file, buf, count, f_ps);
-	up_read(&gdev->sem);
-
-	return ret;
-}
-
 /*
  * GPIO line handle management
  */
@@ -238,8 +200,8 @@ static long linehandle_set_config(struct linehandle_state *lh,
 	return 0;
 }
 
-static long linehandle_ioctl_unlocked(struct file *file, unsigned int cmd,
-				      unsigned long arg)
+static long linehandle_ioctl(struct file *file, unsigned int cmd,
+			     unsigned long arg)
 {
 	struct linehandle_state *lh = file->private_data;
 	void __user *ip = (void __user *)arg;
@@ -248,6 +210,8 @@ static long linehandle_ioctl_unlocked(struct file *file, unsigned int cmd,
 	unsigned int i;
 	int ret;
 
+	guard(rwsem_read)(&lh->gdev->sem);
+
 	if (!lh->gdev->chip)
 		return -ENODEV;
 
@@ -297,15 +261,6 @@ static long linehandle_ioctl_unlocked(struct file *file, unsigned int cmd,
 	}
 }
 
-static long linehandle_ioctl(struct file *file, unsigned int cmd,
-			     unsigned long arg)
-{
-	struct linehandle_state *lh = file->private_data;
-
-	return call_ioctl_locked(file, cmd, arg, lh->gdev,
-				 linehandle_ioctl_unlocked);
-}
-
 #ifdef CONFIG_COMPAT
 static long linehandle_ioctl_compat(struct file *file, unsigned int cmd,
 				    unsigned long arg)
@@ -1564,12 +1519,14 @@ static long linereq_set_config(struct linereq *lr, void __user *ip)
 	return 0;
 }
 
-static long linereq_ioctl_unlocked(struct file *file, unsigned int cmd,
-				   unsigned long arg)
+static long linereq_ioctl(struct file *file, unsigned int cmd,
+			  unsigned long arg)
 {
 	struct linereq *lr = file->private_data;
 	void __user *ip = (void __user *)arg;
 
+	guard(rwsem_read)(&lr->gdev->sem);
+
 	if (!lr->gdev->chip)
 		return -ENODEV;
 
@@ -1585,15 +1542,6 @@ static long linereq_ioctl_unlocked(struct file *file, unsigned int cmd,
 	}
 }
 
-static long linereq_ioctl(struct file *file, unsigned int cmd,
-			  unsigned long arg)
-{
-	struct linereq *lr = file->private_data;
-
-	return call_ioctl_locked(file, cmd, arg, lr->gdev,
-				 linereq_ioctl_unlocked);
-}
-
 #ifdef CONFIG_COMPAT
 static long linereq_ioctl_compat(struct file *file, unsigned int cmd,
 				 unsigned long arg)
@@ -1602,12 +1550,14 @@ static long linereq_ioctl_compat(struct file *file, unsigned int cmd,
 }
 #endif
 
-static __poll_t linereq_poll_unlocked(struct file *file,
-				      struct poll_table_struct *wait)
+static __poll_t linereq_poll(struct file *file,
+			     struct poll_table_struct *wait)
 {
 	struct linereq *lr = file->private_data;
 	__poll_t events = 0;
 
+	guard(rwsem_read)(&lr->gdev->sem);
+
 	if (!lr->gdev->chip)
 		return EPOLLHUP | EPOLLERR;
 
@@ -1620,22 +1570,16 @@ static __poll_t linereq_poll_unlocked(struct file *file,
 	return events;
 }
 
-static __poll_t linereq_poll(struct file *file,
-			     struct poll_table_struct *wait)
-{
-	struct linereq *lr = file->private_data;
-
-	return call_poll_locked(file, wait, lr->gdev, linereq_poll_unlocked);
-}
-
-static ssize_t linereq_read_unlocked(struct file *file, char __user *buf,
-				     size_t count, loff_t *f_ps)
+static ssize_t linereq_read(struct file *file, char __user *buf,
+			    size_t count, loff_t *f_ps)
 {
 	struct linereq *lr = file->private_data;
 	struct gpio_v2_line_event le;
 	ssize_t bytes_read = 0;
 	int ret;
 
+	guard(rwsem_read)(&lr->gdev->sem);
+
 	if (!lr->gdev->chip)
 		return -ENODEV;
 
@@ -1677,15 +1621,6 @@ static ssize_t linereq_read_unlocked(struct file *file, char __user *buf,
 	return bytes_read;
 }
 
-static ssize_t linereq_read(struct file *file, char __user *buf,
-			    size_t count, loff_t *f_ps)
-{
-	struct linereq *lr = file->private_data;
-
-	return call_read_locked(file, buf, count, f_ps, lr->gdev,
-				linereq_read_unlocked);
-}
-
 static void linereq_free(struct linereq *lr)
 {
 	struct line *line;
@@ -1938,12 +1873,14 @@ struct lineevent_state {
 	(GPIOEVENT_REQUEST_RISING_EDGE | \
 	GPIOEVENT_REQUEST_FALLING_EDGE)
 
-static __poll_t lineevent_poll_unlocked(struct file *file,
-					struct poll_table_struct *wait)
+static __poll_t lineevent_poll(struct file *file,
+			       struct poll_table_struct *wait)
 {
 	struct lineevent_state *le = file->private_data;
 	__poll_t events = 0;
 
+	guard(rwsem_read)(&le->gdev->sem);
+
 	if (!le->gdev->chip)
 		return EPOLLHUP | EPOLLERR;
 
@@ -1955,14 +1892,6 @@ static __poll_t lineevent_poll_unlocked(struct file *file,
 	return events;
 }
 
-static __poll_t lineevent_poll(struct file *file,
-			       struct poll_table_struct *wait)
-{
-	struct lineevent_state *le = file->private_data;
-
-	return call_poll_locked(file, wait, le->gdev, lineevent_poll_unlocked);
-}
-
 static int lineevent_unregistered_notify(struct notifier_block *nb,
 					 unsigned long action, void *data)
 {
@@ -1979,8 +1908,8 @@ struct compat_gpioeevent_data {
 	u32		id;
 };
 
-static ssize_t lineevent_read_unlocked(struct file *file, char __user *buf,
-				       size_t count, loff_t *f_ps)
+static ssize_t lineevent_read(struct file *file, char __user *buf,
+			      size_t count, loff_t *f_ps)
 {
 	struct lineevent_state *le = file->private_data;
 	struct gpioevent_data ge;
@@ -1988,6 +1917,8 @@ static ssize_t lineevent_read_unlocked(struct file *file, char __user *buf,
 	ssize_t ge_size;
 	int ret;
 
+	guard(rwsem_read)(&le->gdev->sem);
+
 	if (!le->gdev->chip)
 		return -ENODEV;
 
@@ -2042,15 +1973,6 @@ static ssize_t lineevent_read_unlocked(struct file *file, char __user *buf,
 	return bytes_read;
 }
 
-static ssize_t lineevent_read(struct file *file, char __user *buf,
-			      size_t count, loff_t *f_ps)
-{
-	struct lineevent_state *le = file->private_data;
-
-	return call_read_locked(file, buf, count, f_ps, le->gdev,
-				lineevent_read_unlocked);
-}
-
 static void lineevent_free(struct lineevent_state *le)
 {
 	if (le->device_unregistered_nb.notifier_call)
@@ -2071,13 +1993,15 @@ static int lineevent_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static long lineevent_ioctl_unlocked(struct file *file, unsigned int cmd,
-				     unsigned long arg)
+static long lineevent_ioctl(struct file *file, unsigned int cmd,
+			    unsigned long arg)
 {
 	struct lineevent_state *le = file->private_data;
 	void __user *ip = (void __user *)arg;
 	struct gpiohandle_data ghd;
 
+	guard(rwsem_read)(&le->gdev->sem);
+
 	if (!le->gdev->chip)
 		return -ENODEV;
 
@@ -2103,15 +2027,6 @@ static long lineevent_ioctl_unlocked(struct file *file, unsigned int cmd,
 	return -EINVAL;
 }
 
-static long lineevent_ioctl(struct file *file, unsigned int cmd,
-			    unsigned long arg)
-{
-	struct lineevent_state *le = file->private_data;
-
-	return call_ioctl_locked(file, cmd, arg, le->gdev,
-				 lineevent_ioctl_unlocked);
-}
-
 #ifdef CONFIG_COMPAT
 static long lineevent_ioctl_compat(struct file *file, unsigned int cmd,
 				   unsigned long arg)
@@ -2584,12 +2499,17 @@ static int lineinfo_unwatch(struct gpio_chardev_data *cdev, void __user *ip)
 	return 0;
 }
 
-static long gpio_ioctl_unlocked(struct file *file, unsigned int cmd, unsigned long arg)
+/*
+ * gpio_ioctl() - ioctl handler for the GPIO chardev
+ */
+static long gpio_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct gpio_chardev_data *cdev = file->private_data;
 	struct gpio_device *gdev = cdev->gdev;
 	void __user *ip = (void __user *)arg;
 
+	guard(rwsem_read)(&gdev->sem);
+
 	/* We fail any subsequent ioctl():s when the chip is gone */
 	if (!gdev->chip)
 		return -ENODEV;
@@ -2621,17 +2541,6 @@ static long gpio_ioctl_unlocked(struct file *file, unsigned int cmd, unsigned lo
 	}
 }
 
-/*
- * gpio_ioctl() - ioctl handler for the GPIO chardev
- */
-static long gpio_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
-{
-	struct gpio_chardev_data *cdev = file->private_data;
-
-	return call_ioctl_locked(file, cmd, arg, cdev->gdev,
-				 gpio_ioctl_unlocked);
-}
-
 #ifdef CONFIG_COMPAT
 static long gpio_ioctl_compat(struct file *file, unsigned int cmd,
 			      unsigned long arg)
@@ -2679,12 +2588,14 @@ static int gpio_device_unregistered_notify(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-static __poll_t lineinfo_watch_poll_unlocked(struct file *file,
-					     struct poll_table_struct *pollt)
+static __poll_t lineinfo_watch_poll(struct file *file,
+				    struct poll_table_struct *pollt)
 {
 	struct gpio_chardev_data *cdev = file->private_data;
 	__poll_t events = 0;
 
+	guard(rwsem_read)(&cdev->gdev->sem);
+
 	if (!cdev->gdev->chip)
 		return EPOLLHUP | EPOLLERR;
 
@@ -2697,17 +2608,8 @@ static __poll_t lineinfo_watch_poll_unlocked(struct file *file,
 	return events;
 }
 
-static __poll_t lineinfo_watch_poll(struct file *file,
-				    struct poll_table_struct *pollt)
-{
-	struct gpio_chardev_data *cdev = file->private_data;
-
-	return call_poll_locked(file, pollt, cdev->gdev,
-				lineinfo_watch_poll_unlocked);
-}
-
-static ssize_t lineinfo_watch_read_unlocked(struct file *file, char __user *buf,
-					    size_t count, loff_t *off)
+static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
+				   size_t count, loff_t *off)
 {
 	struct gpio_chardev_data *cdev = file->private_data;
 	struct gpio_v2_line_info_changed event;
@@ -2715,6 +2617,8 @@ static ssize_t lineinfo_watch_read_unlocked(struct file *file, char __user *buf,
 	int ret;
 	size_t event_size;
 
+	guard(rwsem_read)(&cdev->gdev->sem);
+
 	if (!cdev->gdev->chip)
 		return -ENODEV;
 
@@ -2777,15 +2681,6 @@ static ssize_t lineinfo_watch_read_unlocked(struct file *file, char __user *buf,
 	return bytes_read;
 }
 
-static ssize_t lineinfo_watch_read(struct file *file, char __user *buf,
-				   size_t count, loff_t *off)
-{
-	struct gpio_chardev_data *cdev = file->private_data;
-
-	return call_read_locked(file, buf, count, off, cdev->gdev,
-				lineinfo_watch_read_unlocked);
-}
-
 /**
  * gpio_chrdev_open() - open the chardev for ioctl operations
  * @inode: inode for this chardev
@@ -2799,17 +2694,15 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 	struct gpio_chardev_data *cdev;
 	int ret = -ENOMEM;
 
-	down_read(&gdev->sem);
+	guard(rwsem_read)(&gdev->sem);
 
 	/* Fail on open if the backing gpiochip is gone */
-	if (!gdev->chip) {
-		ret = -ENODEV;
-		goto out_unlock;
-	}
+	if (!gdev->chip)
+		return -ENODEV;
 
 	cdev = kzalloc(sizeof(*cdev), GFP_KERNEL);
 	if (!cdev)
-		goto out_unlock;
+		return -ENODEV;
 
 	cdev->watched_lines = bitmap_zalloc(gdev->chip->ngpio, GFP_KERNEL);
 	if (!cdev->watched_lines)
@@ -2838,8 +2731,6 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 	if (ret)
 		goto out_unregister_device_notifier;
 
-	up_read(&gdev->sem);
-
 	return ret;
 
 out_unregister_device_notifier:
@@ -2853,8 +2744,6 @@ static int gpio_chrdev_open(struct inode *inode, struct file *file)
 	bitmap_free(cdev->watched_lines);
 out_free_cdev:
 	kfree(cdev);
-out_unlock:
-	up_read(&gdev->sem);
 	return ret;
 }
 
-- 
2.39.2


