Return-Path: <linux-kernel+bounces-60549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD565850695
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 22:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398D11F22734
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 21:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABBF5FDD8;
	Sat, 10 Feb 2024 21:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dL0FFOFu"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781443D54E;
	Sat, 10 Feb 2024 21:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707601974; cv=none; b=KyRellBa86Hw8d5c7N/t9rbjAtisUnBHM3L/9wnaMQJkclBNf/Q+7bVlQjbm1uqLTb5nM7zc41e5KvKIZI6eilLYM7+EVnuCPaNgOK63angmYq49w8SN9uDMMGjxM4IjF5m53DZzYAQnHZJ+bt2UALNpZauNNenrXGHbhITi6HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707601974; c=relaxed/simple;
	bh=u259KnwOI46B8vtWRyb9ZfelL9BXUSRWHJ8fsCzW3P4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SAc3D7NmiBnYVdQWLigVf+M5gN7iwHV/4BFL6MYDdS48kAeC8WRlVkt4ABQ5dINpl0EJjoRMgfYXE7baNwrOW2ErRFfk8Cxnn7TGt9Y04nWe2nlZepEdzYK2m4S4wd5NKzoDCyyVICpP1TSXONEEPOobludm6kzWLtlOACjtWyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dL0FFOFu; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51182f8590bso697777e87.0;
        Sat, 10 Feb 2024 13:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707601971; x=1708206771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocnxbMsGoBgHErUm8d0uQ9FCaUr3+Pyz5TTyo3yrGuY=;
        b=dL0FFOFunmQGTsLw7MkjnnUQWpWGrwfAe4PdoJ9zwQZdy4mZY3oXWSN5ssJw88mK0H
         VswXJzTtXU3T4On+tzJKuXIPD6F6kDg3vR7kAvHaRAA51T1ZoNws9+P8uebCp+Yoe7tw
         UnGoplb8eLcEw5/fjMy1cSy1cBx0PmBNo909/kQXEnPkfiqPHoitaQ4bWWwD1Ve+dz5c
         zX6XAfKNvoM3pja2sVRqzp6Rvr8o/XXtoB4IO/a23homfSTzjVzd9bhy/BhRmQ25nWzR
         OneiVtJ/0x0ihmjwu/Jv48DD1Jt6CByQ9Q2CTiSwX+sf50rbC5Alt8t7/PKewNLk2h4t
         wTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707601971; x=1708206771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocnxbMsGoBgHErUm8d0uQ9FCaUr3+Pyz5TTyo3yrGuY=;
        b=DA2WmUGIs0T8NiZapEEVz7mNhNdVv41kAd4wOD/Rsv/H2w5wz5HR/WTC2sWXKN6zFr
         TKzqjwPjbAaL2rcNn1OGR1sNK9DA0dptkZ6BahuD7NdAZWRd9/OvYJAWhzXJGqY74KYy
         kwW8wWEYplmZihbhlSxaqaogR4oqwjRhHRhnJ03gcjMB4dLs5w3ohwJp26d5hSkzsc+6
         HtWO2bVXxVriunBUZJVMoVGm8Ww3oKWDvY0nj0s8YkC+gybhIHdoBiIbWC/pgcE/nwZ3
         lba76ikzerQTfu+gGcEunZqmejXY3a+ZzX5QfXv/FOGt9CS0Om9++hwP4c8OMkrTYZky
         Q6+w==
X-Gm-Message-State: AOJu0YyoU8r5Re8gc3d0XH0BgmjHdgn7vTpYj48yVzksMoXwrXqaPgRI
	RgLnrbR4LDGqVcPmjTMKtCc+sWVkoShIz1m8/pgXBZqw37VGnylz
X-Google-Smtp-Source: AGHT+IGWbLOCgfzwfZc8tU+VsT9rKKHZsutZBdAsn+B39qTP/IIPgAb+S1esh1vqEJwGY1X1e+Rwtw==
X-Received: by 2002:a19:ee09:0:b0:511:494b:c483 with SMTP id g9-20020a19ee09000000b00511494bc483mr1523278lfb.31.1707601970525;
        Sat, 10 Feb 2024 13:52:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVDzAqbKAN35hKpiDb98iWNg2jY3Xw2dAYYCI9MbzNHSdSbTQrWIApK1QMGBlZR+RI6GUGVzycQKhm1aBZ99EyKofzRIdL9nyyLpdyKoB4J8lWP9TrgfF6EyI8gb4R82R/Ssveych5JI20R30CSiTKUHe88fGbeMcruSZ+fGa9vYjdMHzqYPIA8T6ATtRdBx+3rDT7sMMIbuehCCClSEDlIR9kl5S4473vBGRflFW/R/tgCx4dzE9jsJBhjId51i2eVoccNgCKz2Jwu7mp4HfNwvotpBjb6vjxnqX14sb8lHuQwW+ukLPmNyj9CAnLADyfYVKIjowMHmaxcHrQ7zP16wGyBahOz1tvJjn5ssu1KWv/bF5Aecg==
Received: from m2.. (89-139-223-180.bb.netvision.net.il. [89.139.223.180])
        by smtp.googlemail.com with ESMTPSA id a7-20020a19ca07000000b0051189b53f93sm24005lfg.302.2024.02.10.13.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 13:52:50 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: chrysh@christina-quast.de,
	daniel.beer@igorinstitute.com,
	jikos@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	johan@kernel.org,
	gregkh@linuxfoundation.org,
	equinox@diac24.net,
	michael.zaidman@gmail.com
Subject: [PATCH v1 02/19] hid-ft260: fix Wformat warning
Date: Sat, 10 Feb 2024 23:51:30 +0200
Message-Id: <20240210215147.77629-3-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240210215147.77629-1-michael.zaidman@gmail.com>
References: <20240210215147.77629-1-michael.zaidman@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fixed compilation warning introduced by "hid-ft260: Add serial driver" patch
    https://lore.kernel.org/all/20231218093153.192268-1-contact@christina-quast.de/

  You are using:           gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
  CC [M]  /home/michael/sw/hid-ft260/hid-ft260.o
In file included from ./include/linux/kernel.h:30,
                 from ./arch/x86/include/asm/percpu.h:27,
                 from ./arch/x86/include/asm/preempt.h:6,
                 from ./include/linux/preempt.h:79,
                 from ./include/linux/spinlock.h:56,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:7,
                 from ./include/linux/slab.h:16,
                 from ./include/linux/hid.h:19,
                 from ./include/uapi/linux/hidraw.h:19,
                 from ./include/linux/hidraw.h:8,
                 from /home/michael/sw/hid-ft260/hid-ft260.c:12:
/home/michael/sw/hid-ft260/hid-ft260.c: In function ‘ft260_uart_write’:
/include/linux/kern_levels.h:5:25: warning: format ‘%ld’ expects argument of type ‘long int’,
but argument 3 has type ‘int’ [-Wformat=]
    5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
      |                         ^~~~~~
/include/linux/printk.h:427:25: note: in definition of macro ‘printk_index_wrap’
  427 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
      |                         ^~~~
/include/linux/printk.h:528:9: note: in expansion of macro ‘printk’
  528 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
      |         ^~~~~~
/include/linux/kern_levels.h:14:25: note: in expansion of macro ‘KERN_SOH’
   14 | #define KERN_INFO       KERN_SOH "6"    /* informational */
      |                         ^~~~~~~~
/include/linux/printk.h:528:16: note: in expansion of macro ‘KERN_INFO’
  528 |         printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
      |                ^~~~~~~~~
/home/michael/sw/hid-ft260/hid-ft260.c:38:25: note: in expansion of macro ‘pr_info’
   38 |                         pr_info("%s: " format, __func__, ##arg);          \
      |                         ^~~~~~~
/home/michael/sw/hid-ft260/hid-ft260.c:1231:9: note: in expansion of macro ‘ft260_dbg’
 1231 |         ft260_dbg("count: %ld, len: %d", count, len);
      |         ^~~~~~~~~

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 7273d401337a..a67c625c9165 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1228,7 +1228,7 @@ static int ft260_uart_write(struct tty_struct *tty, const unsigned char *buf,
 	int len, ret;
 
 	len = kfifo_in_locked(&port->xmit_fifo, buf, count, &port->write_lock);
-	ft260_dbg("count: %ld, len: %d", count, len);
+	ft260_dbg("count: %d, len: %d", count, len);
 
 	ret = ft260_uart_transmit_chars(port);
 	if (ret < 0) {
-- 
2.40.1


