Return-Path: <linux-kernel+bounces-141025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA43A8A1AB2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C89D2B24482
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30981C822D;
	Thu, 11 Apr 2024 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZbPyJ9er"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF56817D14C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849922; cv=none; b=uGE6/fX+AsyucGSV5LuqUIkDPW29scFctZN0xLWI4fU+GfqQ+yayG9Laq/HvxBkSUG4WVcM8GIhhXL4TWVy64jbyLov4PVyaLCj7p462HzEVaIUd8R8Cp9y82VmaMu0TlBMi4GraLEMO03xUWQrezvKKWR/yFzpWmLp9WhRFGaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849922; c=relaxed/simple;
	bh=bCtXbQ0OFBriS+yV5uGvubGKabA1yy1bdobVM9qbR+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XiLsvRY2+CsR5M5QvjUe/EA6MnjeIoNCrgdBSK4rPhnDVG39P35uuQKoX/MhONiwEjcIDlmTCAcUPPkk/1mnZUayREt0AGV0HjLLOQXJIb3S+46yEw190eiFM1C5whkZ10B+3AXVzWp1GFf9HR5VGKbWafecyQiaF9hYMZUgYSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZbPyJ9er; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9841839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849920; x=1713454720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmAhqQs5gVR2K93MNDL7yppZPnqIKQFXDAq/G1NusRk=;
        b=ZbPyJ9er5612zJh0owAbDX4zz18CLf6HzujoTrCrKwzE3bMseK+ufRrwEcw5m0zCDZ
         P/B08Ai9MrC+1x01Pba7YDtYZHXbHMaKHrjw1/wVRQMDXbvTdqi4YQgqydhMzL/fKnUm
         XFu2tXi37j30W0RVvG99VKbbj9u16vxe4fFH+/unICh83cs2AtXg5VGvAlJDg0uJu6RY
         RGPZldLkz8chOS78UdsPczZV0wdhO3A8hITQbHfMp/a0X2yDtqNk1BTfMBNu+i0uj1rs
         dyve7vwgzC1Fynh2SS/gmYTOTwGQI/dKhh1ovrvaGGOgF2xrJTYQWaYVS4b5BQ82Uxo1
         m4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849920; x=1713454720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmAhqQs5gVR2K93MNDL7yppZPnqIKQFXDAq/G1NusRk=;
        b=j9lE7HimIuNrW3cNXfHk5UyxG/HZXVutVPOv0h18Mf4oJykwBhhBzzOx92x+c1v1DA
         oZ2O85OAiQU2EjOSuxIljb/5YRV1XS/yXGpjvIWR3nlr2Ul0wMe9CUCwsXjN7PV6IOS7
         kXJbnJ+hUAXX6P7HYrqdhIS+mJ64l5nuQHIIJvXeDzIJvJ0DJFRPs6Y0mjfTvGg+Dn00
         D1fh2mMlsc694fwSkWzYhHZXGB6RAAxTdbnCLd/jhVnBFUv61mnV7AH9DvYYMB0g4r7U
         GFcK0WeThyTNgwwzMgNx/5bTLW3/WMHv/q8yffyUBrM8HpFrbPvVoXCuGQPUZFhTRIU4
         OAcw==
X-Gm-Message-State: AOJu0YzsfEfbvmCLWJV5FAMy1VKwlLtxYCflEZlmV/2MFLpomOmFHS+U
	oh7iOWM3yc/vjr7WM+dbte9qGffMmVb6qATgKlQTjo0+GVDBJ+hNmvBa/yRGFGEwEe5z68bsTSt
	T
X-Google-Smtp-Source: AGHT+IHfwTWtg5oSdR+PY0YSMZZaUnlWS33fdEB+hp9xkuxA2fyywFgsVUGizmtShZyVraqS+w0IfA==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr199412iop.1.1712849919228;
        Thu, 11 Apr 2024 08:38:39 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:37 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 252/437] watchdog: sbc60xxwdt: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:32 -0600
Message-ID: <20240411153126.16201-253-axboe@kernel.dk>
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
 drivers/watchdog/sbc60xxwdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/sbc60xxwdt.c b/drivers/watchdog/sbc60xxwdt.c
index 7b974802dfc7..ce727f42b88e 100644
--- a/drivers/watchdog/sbc60xxwdt.c
+++ b/drivers/watchdog/sbc60xxwdt.c
@@ -161,9 +161,9 @@ static void wdt_keepalive(void)
  * /dev/watchdog handling
  */
 
-static ssize_t fop_write(struct file *file, const char __user *buf,
-						size_t count, loff_t *ppos)
+static ssize_t fop_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	/* See if we got the magic character 'V' and reload the timer */
 	if (count) {
 		if (!nowayout) {
@@ -177,7 +177,7 @@ static ssize_t fop_write(struct file *file, const char __user *buf,
 			   magic character */
 			for (ofs = 0; ofs != count; ofs++) {
 				char c;
-				if (get_user(c, buf + ofs))
+				if (get_iter(c, from))
 					return -EFAULT;
 				if (c == 'V')
 					wdt_expect_close = 42;
@@ -276,7 +276,7 @@ static long fop_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 static const struct file_operations wdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.write		= fop_write,
+	.write_iter	= fop_write,
 	.open		= fop_open,
 	.release	= fop_close,
 	.unlocked_ioctl	= fop_ioctl,
-- 
2.43.0


