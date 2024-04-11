Return-Path: <linux-kernel+bounces-140853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD348A19A7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F0D4B294CE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C797137C26;
	Thu, 11 Apr 2024 15:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KEvoLLQP"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27230137904
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849659; cv=none; b=AGpirpwT5Aolzfzlvim4dk1lXdrIuFDsBt8H6dQEQL7WzwBilXFtsbthWSleLhhvsgCM+K6MeZ94QdfHowoFZNhyba+qCbSEMHKxUkKP6J00aCbm0Ez16HaAHHfsuzn6KniULKhVnia4p4ZQ3C7Z54vQAtyT5J0kXQhQ3+uI2y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849659; c=relaxed/simple;
	bh=AP5RPz/E+pwYxNd2wwmdiHkuvAntphTgRIqwFpCJcS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbS6lG0oJRDPopJJVFMYl44H0k2y4PTpkDFa+Kt/Hq+wmzWm76ZOHNXKyUpwA6YDf8IEgQ1r8waEaROpyN3jbG6E5t7dD5X+VjRTax6vb7H4g6FFZPj18CNjMaOOflqwXAgGBb7/72ifbdF49gRGLUcotQw5RoRX3SlSlcEwPSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KEvoLLQP; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16136639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849657; x=1713454457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TydMiuJzAnVI1Y/DgMFL+Q7ONv6WRnlP2/JlOY38Vuo=;
        b=KEvoLLQP3bfZyLmR7lh4490FtwqRVjd/ThtpS93FTyhpQzCInN8R9FLnM7XsTcHJjh
         QN6XliBOwu/4mDN6WQt0evBvBy4yZ3RWvLS7u6HLxyVAYAAYybr99uun/tFvVE1qs1tN
         ltlOVDlbfa7dnx4esq8Efg0WqwC+JGsz9iNXmIGqWdxmTVFiX5iLBep1r+6zItwawHEL
         CGbISC/oFWEh42z2Dka4QD9UHWA80q5hhkON58wXv47waz8US8q7VzhG8lu/Pkgnc5kM
         Ifi2TUAiJe8IhXlo8d7DRv2Jb+JWj49QwdDhmdQYkSIOZbTm2y+PYa0ITX3iTdbtUHwf
         jIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849657; x=1713454457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TydMiuJzAnVI1Y/DgMFL+Q7ONv6WRnlP2/JlOY38Vuo=;
        b=H22GH18rGekkZpnqfKm4JDAljHvKArd5hNjvQlK6fW8arNWkHfPvfivOATwgUcyhC1
         CMJk6xj0wEc6VVYp+EmXsHWMNfWSg8wVzK+FIjavX9QrbQFVKFbqzEauAbPUJfWfb02u
         wGFLWfke2+kN/a22CaBItJRW1VModuplIyPHHapZYpyLH8pP7pcPuJ0FrYS4NhviGmWQ
         xtRun/2OVo6C/XC9sjZSgHVWaOPfIXf9dH3GBW5cepnx5OunBOOnTa4Tsn1NT7LPD668
         RW7lYpvlO+htAbjB04tldeB3anGRsdeV+khXGnZDggKuiCkynz+7ALHNtTT1ULQv0Fbm
         wdXg==
X-Gm-Message-State: AOJu0YwXuPcA2hcqFEjsjZqX2pndNlfc8gNPod1RqBp1OHJ68wcjJohA
	3mkL+kj2fg+wy1r7AHHDjIqrW5gp9dTorFa7Mfrpu5cNgUpLgsHVso0QRIQaO04hW9QHQq/UVHK
	c
X-Google-Smtp-Source: AGHT+IHGNBpHIg15nWL5QNLyBB1Z3yFkn/vEZdgXiEpUqLeXRR5peQaISH+VubqQ5rMyASGsr5HWhA==
X-Received: by 2002:a92:60b:0:b0:369:f53b:6c2 with SMTP id x11-20020a92060b000000b00369f53b06c2mr5337304ilg.1.1712849657076;
        Thu, 11 Apr 2024 08:34:17 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:15 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 091/437] lsm: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:51 -0600
Message-ID: <20240411153126.16201-92-axboe@kernel.dk>
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
 security/safesetid/securityfs.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
index 25310468bcdd..82e1e9c37db2 100644
--- a/security/safesetid/securityfs.c
+++ b/security/safesetid/securityfs.c
@@ -245,6 +245,7 @@ static ssize_t safesetid_uid_file_write(struct file *file,
 
 	return handle_policy_update(file, buf, len, UID);
 }
+FOPS_WRITE_ITER_HELPER(safesetid_uid_file_write);
 
 static ssize_t safesetid_gid_file_write(struct file *file,
 				    const char __user *buf,
@@ -259,6 +260,7 @@ static ssize_t safesetid_gid_file_write(struct file *file,
 
 	return handle_policy_update(file, buf, len, GID);
 }
+FOPS_WRITE_ITER_HELPER(safesetid_gid_file_write);
 
 static ssize_t safesetid_file_read(struct file *file, char __user *buf,
 				   size_t len, loff_t *ppos, struct mutex *policy_update_lock, struct __rcu setid_ruleset* ruleset)
@@ -285,6 +287,7 @@ static ssize_t safesetid_uid_file_read(struct file *file, char __user *buf,
 	return safesetid_file_read(file, buf, len, ppos,
 				   &uid_policy_update_lock, safesetid_setuid_rules);
 }
+FOPS_READ_ITER_HELPER(safesetid_uid_file_read);
 
 static ssize_t safesetid_gid_file_read(struct file *file, char __user *buf,
 				   size_t len, loff_t *ppos)
@@ -292,17 +295,16 @@ static ssize_t safesetid_gid_file_read(struct file *file, char __user *buf,
 	return safesetid_file_read(file, buf, len, ppos,
 				   &gid_policy_update_lock, safesetid_setgid_rules);
 }
-
-
+FOPS_READ_ITER_HELPER(safesetid_gid_file_read);
 
 static const struct file_operations safesetid_uid_file_fops = {
-	.read = safesetid_uid_file_read,
-	.write = safesetid_uid_file_write,
+	.read_iter = safesetid_uid_file_read_iter,
+	.write_iter = safesetid_uid_file_write_iter,
 };
 
 static const struct file_operations safesetid_gid_file_fops = {
-	.read = safesetid_gid_file_read,
-	.write = safesetid_gid_file_write,
+	.read_iter = safesetid_gid_file_read_iter,
+	.write_iter = safesetid_gid_file_write_iter,
 };
 
 static int __init safesetid_init_securityfs(void)
-- 
2.43.0


