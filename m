Return-Path: <linux-kernel+bounces-140776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1118A18E8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A8562863E5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD938446B2;
	Thu, 11 Apr 2024 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nOEAYCat"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5045175AE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849524; cv=none; b=NMhEQvMLpg7nLwIYXHeA1oJfrNRbVb9SjPoXTjPTSXO6WUdByW4do5dZGzVNWR+5BOkYa9giTaRcMrTQ2Ai5M8b6M0qjA4uUBc82S2DHCnPQ+FMWr4955TE3sTP8qMLMbliDYn630lfEVe9Wsow4a+OI4NTyEVwH70DIyfI7eTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849524; c=relaxed/simple;
	bh=QBiDVzSin8HPfW0uBG0g4Ul1ewVi2wp/GU6MLCcmEaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXVDCe0JdJ7uOr1t1iU8HjqwT6fMdAj/nKqipmY83EZrdJRveeK9OK6y4WWWvw4/IE/UMuR8JdOOYVdIhd+T8QiKzqK9id1LKGS1KRGgl7e7qPe82vrn2/mZa8Cuyd4FtcpqPDJZrGv6plfiSzppIBzHK4fkTlhGW76a+FG5vSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nOEAYCat; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso57938339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849521; x=1713454321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gbggku78E3fbHQKVUkS5Ce4TOh7ympwjV4l2OQYW8+o=;
        b=nOEAYCatldmJ+9ceSAR51Wf8y70Dypd3X2S4awAXdY5ZhBqQWfonn5EpQDFlZXDF1O
         sX6nEGc3qM0CSenFkHyx2QUDbE+X63HO6sKZga+X7BdBpQDo4MTjB5Jj14CDBN1noayU
         v2O+eAyxbKp2p/sI2yQuTH9vozUfo9Iqm9m5VDwgZeZEicLJjETwZ0KHER0vKYqnNm78
         6P25SgQYD0rA1Z1h0YhXSwWjmggKYB3/AefvssMdDu0nv/ZumabXs2Sk0l7Tf6BPjkUp
         bi4DY0ueDDkiY0nwx/JBisnqLr11tH/L9kfNOfktnvZGYyIpphL8f5TdnM8/vZ8dTQP3
         r6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849521; x=1713454321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gbggku78E3fbHQKVUkS5Ce4TOh7ympwjV4l2OQYW8+o=;
        b=H0h0tXun5PKCWzKRrWTmd5J04/vrYP+1+gT5/uR486hrztWUry+p1DToM3m13WOfGD
         JWwlRLmwZkkQWfxoH14JThQ4+evpLjbXAMYkZoGkDDA2go3HxLwcVrziLGNpzhZTZL2X
         QMNTqXQS27LvBG7L6vXCiJmFkIeD/tHYLs2u3naUpo0JzXDuXFAXOEej4FSe6uMWa8BF
         AY+4QiWYun0y5d+AwW7UVubrKacLVq/KxOA3nyeGlz80QF0PhiRd61feaInecvvYBfTr
         4bTDEsLU2iigcYlxgMMabg6CGfcy+u0rhaNVHAWP0wH3ctSasgu+Lbc9+NyI1+VZfX7P
         5Qlw==
X-Gm-Message-State: AOJu0Yw0nuWqRUcy3rBPugAEUQLm5TxWYet0xUBNxvuB2Y0bS0wZUdW/
	VN7Ynut867EfSOsJOh9FPH+JJa2GMzv/QlZ25xqZZWXpbTJpqkalVWmDTiILzDGMFtvtRhWgEbR
	g
X-Google-Smtp-Source: AGHT+IECVRxB69nG714WegAG2l4K5mxu7VW8ZiRT1dpZ/JBO5U8RN+c56UOg+n4m9b6x8LnRGkAVUg==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr168976iov.2.1712849521459;
        Thu, 11 Apr 2024 08:32:01 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:32:00 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 019/437] char/hpet: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:12:39 -0600
Message-ID: <20240411153126.16201-20-axboe@kernel.dk>
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
 drivers/char/hpet.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index d51fc8321d41..68a3ab149e72 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -303,6 +303,7 @@ hpet_read(struct file *file, char __user *buf, size_t count, loff_t * ppos)
 
 	return retval;
 }
+FOPS_READ_ITER_HELPER(hpet_read);
 
 static __poll_t hpet_poll(struct file *file, poll_table * wait)
 {
@@ -677,7 +678,7 @@ hpet_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 static const struct file_operations hpet_fops = {
 	.owner = THIS_MODULE,
 	.llseek = no_llseek,
-	.read = hpet_read,
+	.read_iter = hpet_read_iter,
 	.poll = hpet_poll,
 	.unlocked_ioctl = hpet_ioctl,
 #ifdef CONFIG_COMPAT
-- 
2.43.0


