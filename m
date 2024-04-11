Return-Path: <linux-kernel+bounces-141203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF6A8A1AF6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022651F26EE5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFA41FEAB2;
	Thu, 11 Apr 2024 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dT4+QThC"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9029C1FEA92
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850203; cv=none; b=uCg2MuLk6HpAKrWeh2eukoX19HC64j3lnw9xqsPgv9E/w5XuWnY3wtf5rJUFdOd8KRCQ8CW6lOcIzI+0yFaOoR2TmanVWj1bQ7HzJsRhKXopzxRAkEwr7naXNLvvb9qdQVeQRavRP2It9dR+h+HagU+O1pixDHNfC1mHZuLrMRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850203; c=relaxed/simple;
	bh=Sp9xNQ3fe3ZWUi69TjJ8pFL9SfWpSiMbarIdUkHWX+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=belXj1isA4Olwm0moAxeVOm6oSV573scbS3CypM/QZFgs7Nq/pvoHIDE9WGLAOyJlPi4aqtR0U1ojYbaDsv/09RtEsjjt7PQ6e1ED881mYz+vkr5zrk6bbWbH5MCK1jZb4rLZ/u+BPQ7hQ7EROIqnV5/0TVyqeK/b1kl8JuT1tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dT4+QThC; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58286039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850201; x=1713455001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jtvf2UC0ZL3xZ8ATaOiZ9KZ4PUsCCITMpZgcBxBakU4=;
        b=dT4+QThCYaArdhfdrj3zY7XURTbF6epQ72FaXyc8Wn9GOJPDH9owtqCMNfkpYnNAD1
         RvnAWcxIoyHdwRcX/ea/k4YZ7ul7j9CAWMc7z79Vv40kZkqe+q/i/EryvO8bNWiRn8Ak
         Z45fmkRyc2uEFTJPoz7TmZuczgBkdHURIZehRVJAXzXDNSTCGrtLFfpOkw2p+qwHeWwA
         Bz3JwIfgaZ0KVxn5PDZDZAI6SImtzqWJ2vEvpzTcoW5u6yQovx9M5ixpJwd9LO58XbLR
         BnOIXUuZXvRVg+ZRCv0oTRhkFp07DABRo0O7iN2esUQIctmkrhvZ06GXXhZ6Ze9TBvw/
         +yyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850201; x=1713455001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jtvf2UC0ZL3xZ8ATaOiZ9KZ4PUsCCITMpZgcBxBakU4=;
        b=VuqY2x5FSJsdYaIM0Nz86WJeYE/lGS9jJhAKs+CfYV67LeAhSgJede230ascz8nA2J
         KswF3RcKPSlQtgAXtr0cO5IOrOW7p9uE9SDf4mbLdJE4kO7aXn3VCXhH1yqHxxL1u0rU
         +0aYRVq/aZ7HLXzmwBY0gbyipdUamhcCa2guh1qngfwsWNmetKHbUBqSqZ7GDbUHzRYQ
         XQka9hYSU7i/7RwCgjeq51MSA/KQp6Wp1KA8GboKd4S4S1nqpPoRxmM14WtNOuw7zZKm
         h8xPuwyxJhEbtm6gkGzypgFmUaTAmnZs9hNklbpatr4dAiojzOxLb6vvAXEUZESMqgT0
         mP9w==
X-Gm-Message-State: AOJu0Yw9eHMDe3g0PQQIoCHnU8+t4gCzyUf4kxpnFxruZUr8UDAi1myk
	g1ugrdW1/61LKOKWgvSJTqWZldB3IlzWuAWZWgesk4OEPxPN8RRxofEe2dYxQbzFV/twxYjJvcC
	X
X-Google-Smtp-Source: AGHT+IGEVH5FPlz0gAUfBHKrDKE454im5PrtAeH+OBM85IIbR/DjHwR7y5rUIEaL/ur4jty95M1L9Q==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr181501ioh.1.1712850201223;
        Thu, 11 Apr 2024 08:43:21 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:43:20 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 419/437] media: media-devnode: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:19:19 -0600
Message-ID: <20240411153126.16201-420-axboe@kernel.dk>
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
 drivers/media/mc/mc-devnode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/mc/mc-devnode.c b/drivers/media/mc/mc-devnode.c
index 7f67825c8757..43e3297e0447 100644
--- a/drivers/media/mc/mc-devnode.c
+++ b/drivers/media/mc/mc-devnode.c
@@ -78,6 +78,7 @@ static ssize_t media_read(struct file *filp, char __user *buf,
 		return -EIO;
 	return devnode->fops->read(filp, buf, sz, off);
 }
+FOPS_READ_ITER_HELPER(media_read);
 
 static ssize_t media_write(struct file *filp, const char __user *buf,
 		size_t sz, loff_t *off)
@@ -90,6 +91,7 @@ static ssize_t media_write(struct file *filp, const char __user *buf,
 		return -EIO;
 	return devnode->fops->write(filp, buf, sz, off);
 }
+FOPS_WRITE_ITER_HELPER(media_write);
 
 static __poll_t media_poll(struct file *filp,
 			       struct poll_table_struct *poll)
@@ -195,8 +197,8 @@ static int media_release(struct inode *inode, struct file *filp)
 
 static const struct file_operations media_devnode_fops = {
 	.owner = THIS_MODULE,
-	.read = media_read,
-	.write = media_write,
+	.read_iter = media_read_iter,
+	.write_iter = media_write_iter,
 	.open = media_open,
 	.unlocked_ioctl = media_ioctl,
 #ifdef CONFIG_COMPAT
-- 
2.43.0


