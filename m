Return-Path: <linux-kernel+bounces-141094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC2A8A1A74
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797F31F22007
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA5D1DED9D;
	Thu, 11 Apr 2024 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qLXHoW8V"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E3F1DDD0E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850026; cv=none; b=JtL3L1seAhpFDkleBpxdPH9xS5caN8MQiTdk15i74iNOf4atu4E1dw4DMBEDVxfbeqH9KR/Yhu64vODPbt0sEWJ4NQRx+734AlSu+A0EYplg/zaJepCQ0LuwU8/2m/wXA90Prob8kccfNamGozl0AllW971zZi0juwMcu9vUhD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850026; c=relaxed/simple;
	bh=EGw1BOxH+8TlI/yCEcnowLoOoHfmNMYRoPPVvCXzyHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVitISpAdn9nYeaBJQp0Sks1TriEohuZA3j9o6OPmyVhOEmYxGOxRTSC1cWZXbdUZLWJVjg/GQXBrJtGPtdn3m5XWsU3pr2tRU7WmXrdLr3ctxnFy0jFXkMNsfhyY2VPq03t7rX+yKfhV09oUvLmQz/D5QoEsqAVsVnVLoTW274=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qLXHoW8V; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170601139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850023; x=1713454823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGx3p0kGge9nZqXreOcFImKKXNlrYv9cmnn1pOkixJM=;
        b=qLXHoW8VZH+pfKFByX7PR1MrbiPf2sKF+t23J2VVnFkV6kROIfydfzhB0q287TsGgm
         tEwzpc4WC3Nf9q0XkA1kMmQvP5witML7b88kn25zw8qqlWhRzMmKEvVu4zvdz01qeHl2
         ZaQ2GUyUrxIm32J7beADbBRy7AeSKhSFrZVTc9RlhMvc2cbKrDoey+2BVcNn13kMO6sA
         2adpRxODl2NlgvPCMUj1oR6qDyQrUz2Ga0W2mxYaPsaNOlIzdMibsTATQmkge38LUK5A
         JQBA/4NVXth8DlZLQzwUFkzrBtL5DhhOfZ09EUR3mnrhD7cdY3WJTCzZzS0UJsgIVFbb
         FOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850023; x=1713454823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jGx3p0kGge9nZqXreOcFImKKXNlrYv9cmnn1pOkixJM=;
        b=vTd0D6baBrtq9n36dHgjRM2qyyZjWYNvNIu+nTySiyEAVfzBWGt427sUbb+NO8PviC
         QuHyCdAriYC3RKAf7Q5P22MMVY1t3bKXq2TcjYbRlQ8Msu/5BcC1aeV16ZuZDzzoBkGf
         4ZAxZWEm2Y4gwKbb3zzpdqlzDPdDGtaWDSLUsXiJdumsl8UT5jn2zmngLrvR6HTHkEpp
         ybBdwVszoxp7Cr2vFovstHd9onIwPr6UmxPBl8ESpuW5aeQLb22Vwp2z1sadNk3U+uQn
         3hmVv+VcXh2I8JzGlOQAnWxBRx0gyKlTtwWeKYZjL46t63JDCirfJRGGQkk5bxFoM6bd
         eWiA==
X-Gm-Message-State: AOJu0YyQKvSrHkIW8QFP9NmiLp2GvTgc1YUhN2clUW+PLEmP3WFAQSfo
	0wpbjFazdXRCAB5KWzOgj4WH0QHt1D9oet3ckVxDt1FN9mBIyiUISCFskGWn+9XkWaiDElTXd6F
	f
X-Google-Smtp-Source: AGHT+IEetb38GIVyLPD6euQncp7vUUBBqjfIja9U1mCAcnSQeJzOy74Yp6RfnglHUUG2SfrZSZKhsg==
X-Received: by 2002:a92:2912:0:b0:36a:f9aa:5757 with SMTP id l18-20020a922912000000b0036af9aa5757mr3593512ilg.2.1712850023666;
        Thu, 11 Apr 2024 08:40:23 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:22 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 316/437] drivers/net/ppp: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:36 -0600
Message-ID: <20240411153126.16201-317-axboe@kernel.dk>
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
 drivers/net/ppp/ppp_generic.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index fe380fe196e7..6601b6c3e2b2 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -492,11 +492,12 @@ static ssize_t ppp_read(struct file *file, char __user *buf,
  out:
 	return ret;
 }
+FOPS_READ_ITER_HELPER(ppp_read);
 
-static ssize_t ppp_write(struct file *file, const char __user *buf,
-			 size_t count, loff_t *ppos)
+static ssize_t ppp_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ppp_file *pf = file->private_data;
+	struct ppp_file *pf = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct sk_buff *skb;
 	ssize_t ret;
 
@@ -511,7 +512,7 @@ static ssize_t ppp_write(struct file *file, const char __user *buf,
 		goto out;
 	skb_reserve(skb, pf->hdrlen);
 	ret = -EFAULT;
-	if (copy_from_user(skb_put(skb, count), buf, count)) {
+	if (!copy_from_iter_full(skb_put(skb, count), count, from)) {
 		kfree_skb(skb);
 		goto out;
 	}
@@ -1092,8 +1093,8 @@ static int ppp_unattached_ioctl(struct net *net, struct ppp_file *pf,
 
 static const struct file_operations ppp_device_fops = {
 	.owner		= THIS_MODULE,
-	.read		= ppp_read,
-	.write		= ppp_write,
+	.read_iter	= ppp_read_iter,
+	.write_iter	= ppp_write,
 	.poll		= ppp_poll,
 	.unlocked_ioctl	= ppp_ioctl,
 #ifdef CONFIG_COMPAT
-- 
2.43.0


