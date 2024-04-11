Return-Path: <linux-kernel+bounces-141026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ED68A1A1E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7794281297
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558531CA6B2;
	Thu, 11 Apr 2024 15:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vahgsLwS"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633B017D15D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849922; cv=none; b=cvXgMzR4Akmi6l6WXxAr4UiOp5g2iWipzKK5uLt40nUtSu5uGiy/Y54YA32QFH5J1j5gaPVoacMNJggL0sFRa75KI89JJ3LCsXiS6n+SgY+8XLpGD+m4SI7Avn5BbxyhuQugOgOd271UbsFPJVQwP8efBfu6DLy/ogaMzVVQuHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849922; c=relaxed/simple;
	bh=yvj6Fx2S8MgjUf4sPizIzz/1gQ6nUrv6shwg9v2Oi2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E6067YNy1oN7S12yIFGxec0kqSOmyceGFr8uxWrMxJ2yH7oCC4LXBaQDj181tryiwgWYywuk+uBg1uyQaVmmr+Dp/ZxIii2guA7DU4PjuauO+9BL69c26pGY2wf5t4TYJyAGM0xXRyhkcxk6JCW52eZlaSKxtIhUnAT/aNZ7i9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vahgsLwS; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8998639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849920; x=1713454720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlTiJyqp1UTe69uWYXEk00kh5Kvuj6AMI5UGQjYjQno=;
        b=vahgsLwSyGC3CxbEGGMrVeGszY5AKTXii26wQKBcmOxU5ow5G0OxGveTUvBOthj78V
         N1sao+6Nl4dOC6pFINkdabN7PwJ60vc2+DMCmyJ3u6q+S8Fk1HUAt4A6JyVliWSHg77c
         dFqMobX4UAA0apqNu2pGR+PUPnH/90CGufjUQNTjcXNdMqaqW8LNlb2uGBg3Dd6JAwST
         3lAfOQfwa4v5kngiUp0wtgV1U38DnDoBQppypJYLgc904D/M4pTHXsh3w82SRvjp2DIL
         fESB+PhAHpe5L3gAu0vSuiEtknR/jR+hm8IlqBf2VB6X/zVI6DD8xKgutdjssJv0Svkg
         Qmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849920; x=1713454720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlTiJyqp1UTe69uWYXEk00kh5Kvuj6AMI5UGQjYjQno=;
        b=cAYdyg3p1DJzHjaEqFgxmy24ZHAOvZhfq4a5YxgMNiG7MbYhbYwuuRtEPxsLcyMRAk
         B5qct4SQ7k4785qNjOcfXtUy09Dh7TtlFjcmQq+T+cZ0iuLcCcqwP/pVtUplnPIjdKlD
         MMIIDD8lahLCbcNr57pX+b8k2n8qbWRCINaLGNiwEiWWiMTu+BJWY7cb5ZW7zAyL4NRt
         JRYr1plWdtDOCGETnOU3Y30ityj8xQ2DHfk8JeDFAiQ76nGqkvJgdSfX2cUvMspgiCjc
         cR9Y9PC4QZNC3ieoF/Js7hWv82pr+BvsvAUcRutLK/zmqvcXP7qNDU6o6s68rBCfTkbp
         3zUg==
X-Gm-Message-State: AOJu0YzG3GjOG/T8IhaPG4udZD54rifRlg6hVGly1ENZiGQB5MFqMtbN
	O8e31y6Vw9dgRCxqBPAkPspnOoq/6AQLUMyWfU73bI43VjRWwzJ9ZDWhJLYlmWHc3640UZjdEEr
	P
X-Google-Smtp-Source: AGHT+IFwu2SbuFOvmNnvtle476cDHH8Rw5UilYmORIunXUwkT0lHMbmPaK4+7lPb/wPGTXnrkwKDUA==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr228148ioh.0.1712849919961;
        Thu, 11 Apr 2024 08:38:39 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 253/437] watchdog: sbc_epx_c3: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:33 -0600
Message-ID: <20240411153126.16201-254-axboe@kernel.dk>
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
 drivers/watchdog/sbc_epx_c3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/sbc_epx_c3.c b/drivers/watchdog/sbc_epx_c3.c
index 5e3a9ddb952e..6bbb9db5e57e 100644
--- a/drivers/watchdog/sbc_epx_c3.c
+++ b/drivers/watchdog/sbc_epx_c3.c
@@ -89,9 +89,9 @@ static int epx_c3_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t epx_c3_write(struct file *file, const char __user *data,
-			size_t len, loff_t *ppos)
+static ssize_t epx_c3_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t len = iov_iter_count(from);
 	/* Refresh the timer. */
 	if (len)
 		epx_c3_pet();
@@ -154,7 +154,7 @@ static int epx_c3_notify_sys(struct notifier_block *this, unsigned long code,
 static const struct file_operations epx_c3_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.write		= epx_c3_write,
+	.write_iter	= epx_c3_write,
 	.unlocked_ioctl	= epx_c3_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= epx_c3_open,
-- 
2.43.0


