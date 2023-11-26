Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D6B7F9176
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 06:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjKZFfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 00:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKZFfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 00:35:36 -0500
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FC0CE
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 21:35:42 -0800 (PST)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2859447a409so2917496a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 21:35:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700976942; x=1701581742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IMzzzrHQcZNtfEipT/FghEZuPLoklrOQYabnOYQ35gw=;
        b=gz41cLPyvWdbXcxnHqI9F+JF0hgiA4U2VUdjNU4eawpZULySrJy1vEFaRPvJ5auRr8
         b4iGkhB5uiRGKPsm04gK9+WAW4aFmjiEW3jCyIOy6onmvJXR3PZGcioPY/p2P/AuyehC
         T1LxfrshH6z5oPOp+M0gUJ47qMnL8urPZH0cjTwE8jDegRp9xdGXZctAgaDDI0aIXFlz
         Msn39XqVdj9p+IyJQQtUvogGa14lLk5QB1NQeXKINYTRaEwmSNF/pBRcYCxTnkDv3+b0
         32JujwUmMWpn62KpXXwEPIqiymMGmy+pz3dKROk9t/Zlpjvk0tgQ36kRbeKzZDD5Yr7G
         28jQ==
X-Gm-Message-State: AOJu0YzJjegGesrnQH0q4gGiCYGJbDaIvjEoqAshVeF7eFcDk6m547Fv
        GfcFF1AQFi32HAPgsirGI2qKW9E14Rotb1W3whGk1LSuwWVNYbU=
X-Google-Smtp-Source: AGHT+IHSztTlrTEa/jevK+l0xzTK7J8H1WwggyCThRolPNgvXGbwMVWfDwI7nv6qgHT7d8jeqNGuDnLMAvauhNoWiD9qV+q9mzOw
MIME-Version: 1.0
X-Received: by 2002:a17:90a:69c4:b0:281:1c2e:9e6c with SMTP id
 s62-20020a17090a69c400b002811c2e9e6cmr1512585pjj.5.1700976942266; Sat, 25 Nov
 2023 21:35:42 -0800 (PST)
Date:   Sat, 25 Nov 2023 21:35:42 -0800
In-Reply-To: <0000000000003d77e6060af9f233@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a40ed060b078eb9@google.com>
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
+			return -ERESTARTSYS;
+		}
 		rc = rng_get_data(rng, rng_fillbuf,
 				  rng_buffer_size(), 1);
 		if (current_quality != rng->quality)

