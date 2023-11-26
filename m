Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0097F9133
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 05:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjKZEFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 23:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjKZEFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 23:05:40 -0500
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4D6B3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 20:05:47 -0800 (PST)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5b99999614bso3351743a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 20:05:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700971546; x=1701576346;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bAXGZdQTHSEp68vg5xcT08FTpMfyr9oJm+bNgy+U+7U=;
        b=O2lg2SnBRtK8okRr3sus5PHFkVPiySIB8FKrC6CNKg7qZUv7VI1M/HxmvEsB1vnpcY
         0SoiC10Q8snlzZkLpzwyo8+p7zMBaf0rV4aqsO2/IsN8yaP3TqJjC/452W19aO0JeEHI
         YCd+lhgIm4kxPHECOKC9JmhktC306HGIs+Xhr7eUXcGVpUkDJde9O2RvSS3ZKeJHWneN
         MOWDnV/bIP1VTI2JdASLG7oM0FXBa/O7lVcd3AZ9s0EfyYl3tmQmyvjXEx1WrWe7hL6f
         VA3WvvdWJEYREcgjBlWkj58m5YcaWdhEj5ncbbShtYhEwJIN1H9OXXd4HvrtDg+lLiI0
         snqg==
X-Gm-Message-State: AOJu0YzyHKv2JwmtFHuqR+ozyfNo76IxikEYaFNzUi2/OYvuFdg6aUeD
        v5weSrnaoAm2zcIJgHj1kfPWfUa5XIblHw5epBTRKE8Wa5coJrc=
X-Google-Smtp-Source: AGHT+IHIX4YF3LDtL4CFzc2Br/cZMAKb1mUtNMFwEEFBWvn4GP1crhIGWextCZmbog4X+4Qw85fwNArmTf7mbUSU9u01E6V/QOGx
MIME-Version: 1.0
X-Received: by 2002:a63:211f:0:b0:5bd:4149:a123 with SMTP id
 h31-20020a63211f000000b005bd4149a123mr1273990pgh.7.1700971546681; Sat, 25 Nov
 2023 20:05:46 -0800 (PST)
Date:   Sat, 25 Nov 2023 20:05:46 -0800
In-Reply-To: <0000000000003d77e6060af9f233@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d02d4b060b064cd3@google.com>
Subject: Re: [syzbot] [crypto?] INFO: task hung in hwrng_fillfn
From:   syzbot <syzbot+c52ab18308964d248092@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [crypto?] INFO: task hung in hwrng_fillfn
Author: eadavis@qq.com

please test task hung in hwrng_fillfn

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 98b1cc82c4af

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index 420f155d251f..883412bbf9f2 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -225,17 +225,18 @@ static ssize_t rng_dev_read(struct file *filp, char __user *buf,
 			goto out;
 		}
 
-		if (mutex_lock_interruptible(&reading_mutex)) {
-			err = -ERESTARTSYS;
-			goto out_put;
-		}
 		if (!data_avail) {
+			if (mutex_lock_interruptible(&reading_mutex)) {
+				err = -ERESTARTSYS;
+				goto out_put;
+			}
 			bytes_read = rng_get_data(rng, rng_buffer,
 				rng_buffer_size(),
 				!(filp->f_flags & O_NONBLOCK));
+			mutex_unlock(&reading_mutex);
 			if (bytes_read < 0) {
 				err = bytes_read;
-				goto out_unlock_reading;
+				goto out_put;
 			}
 			data_avail = bytes_read;
 		}
@@ -243,7 +244,7 @@ static ssize_t rng_dev_read(struct file *filp, char __user *buf,
 		if (!data_avail) {
 			if (filp->f_flags & O_NONBLOCK) {
 				err = -EAGAIN;
-				goto out_unlock_reading;
+				goto out_put;
 			}
 		} else {
 			len = data_avail;
@@ -255,14 +256,13 @@ static ssize_t rng_dev_read(struct file *filp, char __user *buf,
 			if (copy_to_user(buf + ret, rng_buffer + data_avail,
 								len)) {
 				err = -EFAULT;
-				goto out_unlock_reading;
+				goto out_put;
 			}
 
 			size -= len;
 			ret += len;
 		}
 
-		mutex_unlock(&reading_mutex);
 		put_rng(rng);
 
 		if (need_resched())
@@ -276,8 +276,6 @@ static ssize_t rng_dev_read(struct file *filp, char __user *buf,
 out:
 	return ret ? : err;
 
-out_unlock_reading:
-	mutex_unlock(&reading_mutex);
 out_put:
 	put_rng(rng);
 	goto out;
@@ -501,7 +499,10 @@ static int hwrng_fillfn(void *unused)
 		rng = get_current_rng();
 		if (IS_ERR(rng) || !rng)
 			break;
-		mutex_lock(&reading_mutex);
+		if (mutex_lock_interruptible(&reading_mutex)) {
+			put_rng(rng);
+			return = -ERESTARTSYS;
+		}
 		rc = rng_get_data(rng, rng_fillbuf,
 				  rng_buffer_size(), 1);
 		if (current_quality != rng->quality)

