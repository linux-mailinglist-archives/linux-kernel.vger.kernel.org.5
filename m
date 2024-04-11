Return-Path: <linux-kernel+bounces-141186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DF48A1AE2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A25991C21C6D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFAC168B1D;
	Thu, 11 Apr 2024 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="s/g6HPcF"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07C5168AF3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850177; cv=none; b=cZQlR+xHR2DNKG+XRTeXpklC58qJcH9N3Wzq4MP0dZ+TEq+ufvyvwipwx34rO5pj6ACAq4RWZEk0MwX+EdF/otg+ng/RC+PDmp8rmdBLX0YaQ2A8LaJhoB9I39gE905GrISWjCLJ42Y4ps7pNn7Urvy0F94huvRgcBmaqnTj6Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850177; c=relaxed/simple;
	bh=hW01X43oNwgMsTKPgpDnqooa0SYsAFOu48H3ZhApNNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MvbbYU1au4sBrsZDeoZt06MPkW8rtyltfF4EWfORTuo0GqQ6z0YkLR5EyeMx7EhKqt1i4rLg3fvtEePW46G+Dse2IiaNc/7cU2lpv093PaP6ze4lSLzgLMr01hZrGET3J/PjpZH3OFu3lLkaOpz+LzapqjKPtT7NjBiu7mC/e1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=s/g6HPcF; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-36a34b68277so124225ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850174; x=1713454974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWT52uGMOx2ZIQ3eejFL0pgQV5B61W7lUo9GEaXb1Vk=;
        b=s/g6HPcFiwwdRI3Xg1VF7WW5OJViBPY/oVEzCD5GuUF/H2b50ZteDxD0yEvQntrbvx
         V7UiFd/XG+WdIXed1NaCWJkleVsgBLPdJJjHORIcyVW+XeoVV5ZVJQy7Vaj+gMQp3xUN
         PjenmUexjFA8mVEhQM1eZhgTNMl2sJ6I3GLdqWn31aNg7Kk0gjxO2yzYksC1Ttu5FuU3
         K6J6l00cjaWwhwusyLsrtkiErF9SGfzFyE6H2cLu+Xup+0BNMNK15ujDmdax4pT6xtbk
         dPw1OP6kWImWa4vmmvI0EfZMw9FlsB6V++NRtZGJRRXf3W9GpqZUDbZubGQ+XhX0PdJP
         GHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850174; x=1713454974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWT52uGMOx2ZIQ3eejFL0pgQV5B61W7lUo9GEaXb1Vk=;
        b=VOMfks2vZDpYW2sujjnzVQJ1lg7Z+jrS9ERQifg7+iePo/XAA5nW4sRjsvBO8WBZhS
         Uv0p3UO4/cC4BTeWyYMugiSOQ/WKNQpBVUziQ2s5eRhQu48fyCB40Y0pXZB/PaKX6R5Q
         /zqEM4d5OjfKADQvmDKH16z5oNpRy5/zbMcADkNeHIDNGUNmbjuwT7ZGV3hD7MTL2/NA
         ty3MacU8ZlaTG907hMAzy9dwjN3TgXUxoxUhqLT8o3/CIkL+flCRfJGbFqNP66C8vVtq
         CZPzOhjl1wYK9+8D6mX91nQwXST3YpJbJaIAceGXu66bnXgtYxyc5NcOQlkRTvOTnNNT
         J3Ug==
X-Gm-Message-State: AOJu0YzpEcTCsTEUcxwKQCsn7oTsGo24aZ1tL4Pjc5EisesNdwONRQmK
	ybw841HraLTO1doCNFf/56/htEW8zxO9hQpnHR8+JkIVU1eG8N3kpLslc4sU2zaf+BDM0we/Ao3
	b
X-Google-Smtp-Source: AGHT+IG04kwgA+pXN5ythRhLTT/CUNaeJ0WkplFoB5ePPcdPOKNTmwiGNUHFqdgZ7/i89leQSOOnyA==
X-Received: by 2002:a6b:6605:0:b0:7d4:1dae:da1a with SMTP id a5-20020a6b6605000000b007d41daeda1amr164786ioc.2.1712850174581;
        Thu, 11 Apr 2024 08:42:54 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:52 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 402/437] drivers/rapidio: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:19:02 -0600
Message-ID: <20240411153126.16201-403-axboe@kernel.dk>
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
 drivers/rapidio/devices/rio_mport_cdev.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index 27afbb9d544b..de1628737808 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -2297,12 +2297,13 @@ static ssize_t mport_read(struct file *filp, char __user *buf, size_t count,
 
 	return ret;
 }
+FOPS_READ_ITER_HELPER(mport_read);
 
-static ssize_t mport_write(struct file *filp, const char __user *buf,
-			 size_t count, loff_t *ppos)
+static ssize_t mport_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct mport_cdev_priv *priv = filp->private_data;
+	struct mport_cdev_priv *priv = iocb->ki_filp->private_data;
 	struct rio_mport *mport = priv->md->mport;
+	size_t count = iov_iter_count(from);
 	struct rio_event event;
 	int len, ret;
 
@@ -2314,7 +2315,7 @@ static ssize_t mport_write(struct file *filp, const char __user *buf,
 
 	len = 0;
 	while ((count - len) >= (int)sizeof(event)) {
-		if (copy_from_user(&event, buf, sizeof(event)))
+		if (!copy_from_iter_full(&event,sizeof(event), from))
 			return -EFAULT;
 
 		if (event.header != RIO_DOORBELL)
@@ -2327,7 +2328,6 @@ static ssize_t mport_write(struct file *filp, const char __user *buf,
 			return ret;
 
 		len += sizeof(event);
-		buf += sizeof(event);
 	}
 
 	return len;
@@ -2338,8 +2338,8 @@ static const struct file_operations mport_fops = {
 	.open		= mport_cdev_open,
 	.release	= mport_cdev_release,
 	.poll		= mport_cdev_poll,
-	.read		= mport_read,
-	.write		= mport_write,
+	.read_iter	= mport_read_iter,
+	.write_iter	= mport_write,
 	.mmap		= mport_cdev_mmap,
 	.fasync		= mport_cdev_fasync,
 	.unlocked_ioctl = mport_cdev_ioctl
-- 
2.43.0


