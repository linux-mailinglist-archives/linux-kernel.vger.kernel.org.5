Return-Path: <linux-kernel+bounces-141037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4008A1A2A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 251171F217F6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A47A1CD79A;
	Thu, 11 Apr 2024 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="aQ6NP5Gi"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917B91CD76D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849942; cv=none; b=V+dBfck8HX1+NxuGOFl4VquqePTfvH0hcb23DYH+PGniMp9EuaO6lp7Z3DdTmHKcEnhXdDpx1KRKdw/dygHxpLDMd48uLbm7QZdYCWkASDR20b0ycp2GWFeCqBR0u+/Cz7QmHMBu0odLL1v4TER35g8zdTrqaByJvsKy75FZxA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849942; c=relaxed/simple;
	bh=5L5X9RRdtX6cte1fQhAG6PLg0zKC8wCBomjPeYYi17s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bn28MffWC2koLb/bB8b2W0IK6qiHpU7H0Zp2zIHavhfJndDPVHculGguMtGYxaivypkUIjtPTcuAH8n7dYxH26BgjUxUDjUBWhCyNxDWX1ZdzXo9Ea7zf1POm29TNs7MNx2M5szJatxTHyEzovIT6pb+6q4BHAkFVI4NCCnHBkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=aQ6NP5Gi; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69626939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849939; x=1713454739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lmvmWxQcOR/remXZ8+nEl5Yz08ETmiFLxioOyAPUV8=;
        b=aQ6NP5GiBjq32o3V9rEEwbOED259LEL1yYb3cZWMOQON1Irb1OJAxz6IMvwloGobKj
         gjYiCJCnZkZsa5HlRy7IAIpclDcbi6bqZpAleGTL2tGIzHdWJ/iIX6uuXRp4Ayd2tKzd
         kZtV6bkO/dICU/CzqcOUQO0Ke7h9UWVo0Buyp+faE+VFP2krYeH+63O849eZr3NNT9j3
         nA0d5gbT4ds1t00nxiFi4kSALmxKMwRBzbNY+XapiJ9ssAu4Fe3T7Bd14WeDeNrRsWSR
         sfUjuldoN4xOpHJVx4mnXvvCwiWS/VKeF5ZD1622WTnWSqMZm86cUa4GDMXOsv40mZMm
         Ub5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849939; x=1713454739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6lmvmWxQcOR/remXZ8+nEl5Yz08ETmiFLxioOyAPUV8=;
        b=kAJiJfelfFfmdgtIEuFLukp0v/49IPxR2JGkW2UIxTNDc5GevamjywM2udMix0tHBw
         SXJHLUcNCPqAysv4rZ9IP8whGhyUvLVmHM236plW1FNSjWpARrVsk1W1W2lMlIyf5aIz
         LnVBVQ9OteZrbBgZvRv4XibGT1sq+dZUtgKciV+FnNU5K/XECRJYLcD03rJ4Ux4jk4cn
         lFatezieydrNK/Xfn2mf7PeNUUuE9xLJuKH8gLJ3uWGwOoSr+qHRNQCRN3e/2InyQylY
         RJGdNCHo4ubIEcl4+yy++jXYkCOSjEdvyaOEH3CzyRx6FTcoReBvo49TMgL5sZzXdRWO
         Ig4Q==
X-Gm-Message-State: AOJu0Yy0X8GwBgJBv+51EIiCcsSYPmaMfeCuKJsOz0CMlJ4sbTViGhXo
	nFiuSucY4uIhd3zyCDzqiv+/zppYBR1vxDCVURKtFNTM7fOCqks7j9v4xT0+8CIDFbwLc2iundj
	L
X-Google-Smtp-Source: AGHT+IHuoVHx7arwizqFHOEBaQ+dd3PKm/hh0Id6D0LyZ7MjZ6SxKypWCmmyEaa4VYJcW3CaYFuZaw==
X-Received: by 2002:a05:6602:84:b0:7d6:9d75:6de2 with SMTP id h4-20020a056602008400b007d69d756de2mr48390iob.2.1712849939380;
        Thu, 11 Apr 2024 08:38:59 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:57 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 263/437] watchdog: wdt_pci: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:43 -0600
Message-ID: <20240411153126.16201-264-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411153126.16201-1-axboe@kernel.dk>
References: <20240411153126.16201-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/watchdog/wdt_pci.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/watchdog/wdt_pci.c b/drivers/watchdog/wdt_pci.c
index d5e56b601351..21efe34c9fd6 100644
--- a/drivers/watchdog/wdt_pci.c
+++ b/drivers/watchdog/wdt_pci.c
@@ -350,9 +350,9 @@ static irqreturn_t wdtpci_interrupt(int irq, void *dev_id)
  *	write of data will do, as we we don't define content meaning.
  */
 
-static ssize_t wdtpci_write(struct file *file, const char __user *buf,
-						size_t count, loff_t *ppos)
+static ssize_t wdtpci_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	if (count) {
 		if (!nowayout) {
 			size_t i;
@@ -362,7 +362,7 @@ static ssize_t wdtpci_write(struct file *file, const char __user *buf,
 
 			for (i = 0; i != count; i++) {
 				char c;
-				if (get_user(c, buf + i))
+				if (get_iter(c, from))
 					return -EFAULT;
 				if (c == 'V')
 					expect_close = 42;
@@ -487,24 +487,21 @@ static int wdtpci_release(struct inode *inode, struct file *file)
 
 /**
  *	wdtpci_temp_read:
- *	@file: file handle to the watchdog board
- *	@buf: buffer to write 1 byte into
- *	@count: length of buffer
- *	@ptr: offset (no seek allowed)
+ *	@iocb: metadata for IO
+ *	@to: buffer to write 1 byte into
  *
  *	Read reports the temperature in degrees Fahrenheit. The API is in
  *	fahrenheit. It was designed by an imperial measurement luddite.
  */
 
-static ssize_t wdtpci_temp_read(struct file *file, char __user *buf,
-						size_t count, loff_t *ptr)
+static ssize_t wdtpci_temp_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	int temperature;
 
 	if (wdtpci_get_temperature(&temperature))
 		return -EFAULT;
 
-	if (copy_to_user(buf, &temperature, 1))
+	if (!copy_to_iter_full(&temperature, 1, to))
 		return -EFAULT;
 
 	return 1;
@@ -564,7 +561,7 @@ static int wdtpci_notify_sys(struct notifier_block *this, unsigned long code,
 static const struct file_operations wdtpci_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.write		= wdtpci_write,
+	.write_iter	= wdtpci_write,
 	.unlocked_ioctl	= wdtpci_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= wdtpci_open,
@@ -580,7 +577,7 @@ static struct miscdevice wdtpci_miscdev = {
 static const struct file_operations wdtpci_temp_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.read		= wdtpci_temp_read,
+	.read_iter	= wdtpci_temp_read,
 	.open		= wdtpci_temp_open,
 	.release	= wdtpci_temp_release,
 };
-- 
2.43.0


