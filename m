Return-Path: <linux-kernel+bounces-141033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7AE8A1A27
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BAEE1C22029
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA371CCEE1;
	Thu, 11 Apr 2024 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="U2UNswVq"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AF41CC4BC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849934; cv=none; b=fkvuD2RfYJFqOpX+dNmS8wpm5ugjU7a3fp1HQVZolbayIrBulnNWiNuHMloUDLJ8B3K4iSJleDBr9oEHSyycQNJPmGQeg7+uYWyL5UlL5BgL9U0umdUoAE2MtV4V60ETNSl4r88k+5RJefnQ6gOFustAR91kNssB+CBA8p4Cq+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849934; c=relaxed/simple;
	bh=KhElin05L3HRMuFXkSKrkWiDXpTOzGaQNIbrAPIJ758=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGCwJUZECFAg2if7VPRFYB6N+XzkF6ju0UWptib0hUx3QzwsHMdXUuKha/SNXfkv0x0Jy2PufAzzfCyrVFAvDOwT86B9NuSWAFxHOVI5BBuYZQiJlFfJ3FXHtfzj5QVwCTO4nWGsxe9X4heI063xaB2S2OKU40vEeIbdUXPFwf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=U2UNswVq; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16204639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849932; x=1713454732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMR7VhGGRmCpKQy7RpuzVduqXFufN0s3k6wCvkujAKM=;
        b=U2UNswVq6M7KcXX/ZMHdyRmIgFFa2UL0rYoIN3oIKzISL8lLFwvP2rS0ykyRG92aAf
         EmqMKsd8CZw1UGZPaAE243sRfaNuCPy8wVcBgDo/8YNvQDzGa1/rm02JXB8dj5YISXMe
         VOpkcHGatXsiicYEIKl5PMRD8HDDu5/S0HBDBURSDZCFGp3LQiUEMQ3HhZGbo3+kYQEW
         hHaftDmEQVzOxsorGJtIuiToDWHa+QHZeF45/HhaXNWacyPyvZkT7d1l35eaZ4Ao65y4
         C0pGhSJOMXPdIficcjxxX3QKl2xunKyx9PQVtvCM4RUMFDrIFX4O9d/hmsH0SU4x6Cb8
         bUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849932; x=1713454732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMR7VhGGRmCpKQy7RpuzVduqXFufN0s3k6wCvkujAKM=;
        b=uIe9nC0qoi5QL3ZmxU7mHAnScmHAgL0bqtz5914S3STRqBLQHvPz6ouurOyO/ieXhs
         r+267PeXnT5fgwfFf1FXFPWfOHu1zVqNAQmPHUFqI6XLrtm9uD9+IPRxcJ/+Y9YXw0sT
         RjnEucNB9mNH77AxVCLjifuiPrQ4DkGs5VAlxutFBCPoG79yG1EvFV5z27uTVZUjxzi6
         0x8b6Dvj/j772zDZquWPFYaXH4y6l36EmGFAZNrQKMOvRoMIqp1W1xU1Eg2WPpn1hA8w
         JWyrD+z/H7Tgb+f+OOOKsOMz4qZp2nk1SxR/EmtVpJLXGcqHU3k+EMl54MY4BA2bTcle
         aQOA==
X-Gm-Message-State: AOJu0Yw4czLeMjhx4DklJhxcbHZyVQVZFbZ31N/UQ1/rFvZV8y1vcB1K
	CFuScjN2UlaYkqZhPqzoW9FSsdN/tdfD4grK3MRL3SEy8fI1k3EhVIuxw3You0E1HbvW0PKnzZR
	Y
X-Google-Smtp-Source: AGHT+IGUIor0GgPlLR+NLHgZuwl6+Ry4Wvs8Judccn7K9DibZMfAIriMRGaKFI/KaCnxzIjEkqBH5A==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr193521iov.2.1712849932187;
        Thu, 11 Apr 2024 08:38:52 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:50 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 259/437] watchdog: w83877f_wdt: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:39 -0600
Message-ID: <20240411153126.16201-260-axboe@kernel.dk>
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
 drivers/watchdog/w83877f_wdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/w83877f_wdt.c b/drivers/watchdog/w83877f_wdt.c
index f2650863fd02..5c55951f9d5b 100644
--- a/drivers/watchdog/w83877f_wdt.c
+++ b/drivers/watchdog/w83877f_wdt.c
@@ -183,9 +183,9 @@ static void wdt_keepalive(void)
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
@@ -199,7 +199,7 @@ static ssize_t fop_write(struct file *file, const char __user *buf,
 			   magic character */
 			for (ofs = 0; ofs != count; ofs++) {
 				char c;
-				if (get_user(c, buf + ofs))
+				if (get_iter(c, from))
 					return -EFAULT;
 				if (c == 'V')
 					wdt_expect_close = 42;
@@ -300,7 +300,7 @@ static long fop_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
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


