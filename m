Return-Path: <linux-kernel+bounces-140866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0998A1944
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8951F2239F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A6614D6FC;
	Thu, 11 Apr 2024 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="v3n65eDz"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E985F13AD17
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849679; cv=none; b=YgoBaq9Lq/PCt+AO1ga6aaJKYIIAybhZgtj7jsEaJ8HVGCninmm6G1owQzPmtKphHIaOdFZXA+UnDjLSiHbADeskUXXD6Su4b0RKgNnntTRuxibobA2GV6CeYKDh2YkGJNcpNMdvKo9ZBhoI5xLBnGbZrJAffl8/Ev35GcB0h0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849679; c=relaxed/simple;
	bh=9iwBnyjscqkNxKDG/Io1VkU/8gPoyQWeh181FlHiehg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CN38fJuhrB54B66UABMpJjJENbnMDPRXxpgqhco+9X3/nNYcaFhb9Ph3Rl2cdL/gFIektv5VqXYucL5k4jOG8KobHZdneAeYyy3NLdohw64vVZBbp6QA2FRCngzmxca2xz1aKP12EZXBbhkq9ruKovY00DSLfctxMAr7h1V2Odk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=v3n65eDz; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-36a1c0bf9faso4608125ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849676; x=1713454476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmU1aZy/lE4HT3Yy01T5BIJ8zKUrwZbC57s7AX7t8Gw=;
        b=v3n65eDzvlauIwO4/kqnATSP8IpRn4TddtXtnF+tlVGQooah66g0OLua2ZTzIOiESA
         L0e42xv9LUV+1Me0nFyRh2e9Y8iTHBXKKCh3pZQL4gJD7O5tw7bK/e5jTzRlDFZSSomH
         M7sKIarpuwBuOdXkLp/X971EVRquql59Uo2hzZiuaoibvjhSoQDGdhDQN4i1s9Irxv/b
         FbQ0KDZH07ebeUZEvhfGvVJuT+81TguuzBcj+2iy6QIISNcuXuLWjcMdbApuM5UPdb8r
         7RkfOMuNRIi0ZcOkAgSd8VH4FZnCDrHv08MknrHxTqTtlna9XV28BCY8bpcfinFsyg/2
         ddew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849676; x=1713454476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmU1aZy/lE4HT3Yy01T5BIJ8zKUrwZbC57s7AX7t8Gw=;
        b=OBmgWuOsmp0/TW3ISTITIapl6TXzCLeP/8rEoYbIrx9Dsga04rBHqUXHRo2de3ATu4
         OYI/fnk2zmrfNnR5Pq8eqC22Wtpf0QM9AaQbHezOaApAhBWCLYVk+Us5RVK1AseVFJ5P
         TuURlkOlZksFnykMEtc97dm/U5rGHATfTe5Rk3+d338G7lKtAAbXMFm/tclwQgRqQpOW
         okHDLX7/t8m85AYRh4Mu/9XK4yv7kniRJCfYH7vMYIHFZHRglmpnVA023wfy1DscXvLV
         FxYWkBX3oaTioBOuI6taTSSpLZtNX89wZHJZUeTDgXlPDNvpLDuPBm7HyHJ4FmW/EcLs
         x1Og==
X-Gm-Message-State: AOJu0YwnCsG/Wo3lLxqfogm7Y+5EuJrkqRiO4ZbdJlsn6jIpj9GJPEvE
	fMhBBIh2oYvyPB30fiffl2IjQ207+n4HXqaBZXiq0/ojyYYMjmnf/t9FqkPIQUjxlvEiV7Oiivj
	l
X-Google-Smtp-Source: AGHT+IEyy+KST9s6pnfvsh0GKBVt/uD4oYpTJ+yGYVQ0R5EhzWSpgd8gsHxlJHxZQ1uK2XiUjk8lmA==
X-Received: by 2002:a05:6e02:1fcb:b0:368:efa4:be12 with SMTP id dj11-20020a056e021fcb00b00368efa4be12mr7845214ilb.3.1712849676691;
        Thu, 11 Apr 2024 08:34:36 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:35 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 103/437] ipc: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:03 -0600
Message-ID: <20240411153126.16201-104-axboe@kernel.dk>
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
 ipc/mqueue.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 5eea4dc0509e..812b03cf4273 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -632,10 +632,9 @@ static int mqueue_unlink(struct inode *dir, struct dentry *dentry)
 *	that are interesting from user point of view and aren't accessible
 *	through std routines)
 */
-static ssize_t mqueue_read_file(struct file *filp, char __user *u_data,
-				size_t count, loff_t *off)
+static ssize_t mqueue_read_file(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct inode *inode = file_inode(filp);
+	struct inode *inode = file_inode(iocb->ki_filp);
 	struct mqueue_inode_info *info = MQUEUE_I(inode);
 	char buffer[FILENT_SIZE];
 	ssize_t ret;
@@ -652,8 +651,7 @@ static ssize_t mqueue_read_file(struct file *filp, char __user *u_data,
 	spin_unlock(&info->lock);
 	buffer[sizeof(buffer)-1] = '\0';
 
-	ret = simple_read_from_buffer(u_data, count, off, buffer,
-				strlen(buffer));
+	ret = simple_copy_to_iter(buffer, &iocb->ki_pos, strlen(buffer), to);
 	if (ret <= 0)
 		return ret;
 
@@ -1663,7 +1661,7 @@ static const struct inode_operations mqueue_dir_inode_operations = {
 static const struct file_operations mqueue_file_operations = {
 	.flush = mqueue_flush_file,
 	.poll = mqueue_poll_file,
-	.read = mqueue_read_file,
+	.read_iter = mqueue_read_file,
 	.llseek = default_llseek,
 };
 
-- 
2.43.0


