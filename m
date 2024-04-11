Return-Path: <linux-kernel+bounces-141219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 799108A1B0A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19AAF1F280FB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A006D20406F;
	Thu, 11 Apr 2024 15:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="f9RBlfCr"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EEE20404B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850226; cv=none; b=TLUDopP2X4VYBLKD1eI8XBgWVoxtzzopBwaM0rlyT6OsV8Z5Jgbx3b/4Aqr7TzV4Y4Lzm656c6ieaD3WKTKlFw+Dwm5BtjyxcC831h09cVKlkUlVejlZjdNsK8SYRa2WDs8Ck3YireJDE3Tt6GUn2KkNNTn8Sx0jMQaDcUIerEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850226; c=relaxed/simple;
	bh=zWATLctHVPydKOBIwB+abK4Uy0TcMGukpkxMWhEsUPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8D4WvdFqCfIL4P4TN0G2faoj0ArjXMlFQi+pD4FB1tD1+RIkZkHIT0RPCYgAIGXe+aRey100IufIifHOnPX9wIbjQGbydr+ATRXhL+2LgrXosIjre3HGAT0jglgOQbB3tZ8RO09VNnn6HG0orj64Ci11bAv3BKJGRZRz+wgqn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=f9RBlfCr; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69705839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850224; x=1713455024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOfssJivSCemVVoipy+tqLOOQD7sJiCVPG0eYTdUsjU=;
        b=f9RBlfCrF3zTIpiiPMx/ylo8hyiIAd1sGs90HQlHKiebaeKEJY93VFn8Bk25BSDNPG
         A8sdI2ORSM8L3akNm18a635e7srzN0gjYYewy0D1xkbhDniZEKabjh8q52KlD0b9+Jww
         4vn5IaUNdnPl9+/ydlx9MOhUr3hhacETkj2T26HV/g7c77KdDPw5XoPmDJSZA9EdWLoP
         HZZWBxBZ1Jis/Tq4SU1yDwF6nXzppJzZvrIIfSDcdUfSmq10hfKWq3YJyrm5H/hKTzJb
         9WaLLr1+N/ofZUnZFra/zq14YgudAiVIH4DmsdZnj7zVve5A3hVV9uBpbUmNQaWRB40H
         Jfkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850224; x=1713455024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOfssJivSCemVVoipy+tqLOOQD7sJiCVPG0eYTdUsjU=;
        b=xSQq7SxdlxQCaWf6XdbmQPfWyLns4qFgrvyaUJuB7xYtzdqrL1tVuhbI/qo89dZHrX
         DnTi06XGkIgTyyrBOirK9cqPfnFlG3h+MwixdXehN6PrLqMlMJ7tBevNWnY43iHg0NUr
         q7RvShgWAQVfcxb/lI5nnUBhbjGgX1YqKkz7Ld2madvCiOhOPtKdhSOtRYVpWJqxKjml
         glP1Ly6GbGzf6g48rGI4V3cCXbh42md3hQacOaJva5Ed5EnwZNInhLvj306SfVXPMR0j
         Ht4v+oZh9lGJXemM7O7aX+Ob6haSRkkLX6QEnS0mgTbxRkgmCW3iWJZGUzBRZZ58XRYF
         3m4A==
X-Gm-Message-State: AOJu0YwDsHft8hs5aMUaGx18fWPTfl7Xj7Zjt7xu44IuKsTu5ETFgQ/3
	8kd+lT4jdJ/wdvhMPmmv8oJlJHbHHIW8oh4IYEnYPTvJPJWvhfJYj7WUiK/qhJbtoaITumIS7rb
	x
X-Google-Smtp-Source: AGHT+IESkNgW2eDtwJG+ysNi4hYeWDKwyR7PqQSYicYpYHLZZAKp1MwCCU1/gAPAs/z7ZMnBdnOxQQ==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr212738iop.1.1712850223745;
        Thu, 11 Apr 2024 08:43:43 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:43:42 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 432/437] seq_file: switch to using ->read_iter()
Date: Thu, 11 Apr 2024 09:19:32 -0600
Message-ID: <20240411153126.16201-433-axboe@kernel.dk>
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

There's a seq_read_iter() helper already, use it.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/seq_file.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index 234bcdb1fba4..a562c611ed3d 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -188,7 +188,7 @@ static int __name ## _open(struct inode *inode, struct file *file)	\
 static const struct file_operations __name ## _fops = {			\
 	.owner		= THIS_MODULE,					\
 	.open		= __name ## _open,				\
-	.read		= seq_read,					\
+	.read_iter	= seq_read_iter,				\
 	.llseek		= seq_lseek,					\
 	.release	= seq_release,					\
 }
@@ -202,7 +202,7 @@ static int __name ## _open(struct inode *inode, struct file *file)	\
 static const struct file_operations __name ## _fops = {			\
 	.owner		= THIS_MODULE,					\
 	.open		= __name ## _open,				\
-	.read		= seq_read,					\
+	.read_iter	= seq_read_iter,				\
 	.llseek		= seq_lseek,					\
 	.release	= single_release,				\
 }
@@ -216,8 +216,8 @@ static int __name ## _open(struct inode *inode, struct file *file)	\
 static const struct file_operations __name ## _fops = {			\
 	.owner		= THIS_MODULE,					\
 	.open		= __name ## _open,				\
-	.read		= seq_read,					\
-	.write		= __name ## _write,				\
+	.read_iter	= seq_read_iter,				\
+	.write_iter	= __name ## _write_iter,			\
 	.llseek		= seq_lseek,					\
 	.release	= single_release,				\
 }
-- 
2.43.0


