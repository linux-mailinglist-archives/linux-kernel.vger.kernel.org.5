Return-Path: <linux-kernel+bounces-141156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B205D8A1ABD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BA271F2411D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F861F143C;
	Thu, 11 Apr 2024 15:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FD372j4a"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DECA1F1421
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850131; cv=none; b=fs1Fx8Iw4wu2YD6kyw5bNs6E7iZ7XOsTnIlNwJZ17Dqo2hUdHsL/rcBIeWYDo4SroJ8SWvX7r8nzo13oBsoFTGAmVTWNiQHBnwIzW5w7tRIH4uTFZpyJqDKVK/HjTD/nlk+EIueIaz6n+WyeaKYbI+1eXrpGJy19SeSr8Km9d3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850131; c=relaxed/simple;
	bh=dqtVeTYhQASUycisSYaIVNPleS7no3IpNbn4fVSlEjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/8+vzk5XleWjfwWRyiB0J+eGOGkvX5v7EWgs73ZZssKHPStjNR/btN5hVIX1G4gG/7hZnI2jULPNs61FIG5YFheBivgubPnLA8mpzN8aX8z8WKYZm7QR2pFV0PQ8MzrNjIQzmw4vxwGzNFqZKX8RWeRVCy5xmDom72al4cXKp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FD372j4a; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170644539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850129; x=1713454929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66zc67EVQwWAQaHwvyKajfsawNvErn36IZcn2AYQxyY=;
        b=FD372j4a/D542tYoo308ccLBovQLLvrHEW/MDn7bsf0JA2hgaPmadVYUvsJOv7l+wi
         4kDO1xef+Amwb2fAjrpH6eTXp8/bcfGdMriYCmMMZEN6lNNIs67X9XPoh8uakf7ica66
         nYQ/BG8Gw4Nr4d80m2+KEXjxlbMBM+O11TwME+3W5PSjUAn6W1MQ2F16L5Y9Y3FFdFrJ
         3S1iL6kMZQ4EhidFxEAqMmRpd7gU0vWmMPjBHhMV2D4FqB/bJz1/vFj6uSTKJwIiJaYy
         gsOTK8pyhUV2e6UTpX6ogvVaVPQiFvOYzb3oMtI3SDJSmvUk5gKlivFvj8WdeJoOm/iX
         5kZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850129; x=1713454929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66zc67EVQwWAQaHwvyKajfsawNvErn36IZcn2AYQxyY=;
        b=Epjin/+eC9ktYek5UNBlbnkDoFANu7SYhivgr8BkJLgzAVRTBIJvqg/RyN/218DkcV
         NrC91sBrvyUV29DRUu5uJRlwycdxK3zQkdR7d1Sqgy10m0KrHzCQ3EL4Mv2Zv05pHTuv
         vZOIL0EZytCkmUNMvxtrbQazYINWx8QIPtW502ZqG6mtwSdBLHkqtc2lryWVvDG137ke
         eMpOmbuVUOmL4whm5BlSWxX9oSbgJjQtxg0HW+BQPm7n2B27LdMrq7tFcN4TAgeBr3IU
         HFI9OsHHl+x/LyKqW863WATbco9/0/wLcfBy2YQPW+knC7/R1/JtcwpTdvS0yj8TSXPU
         PNBw==
X-Gm-Message-State: AOJu0YyDhQ3xJLqorcqafytqBoM1rrUEK8SI9IZashAgO8oa5v/fm+j8
	6rcvClKSZF8SKxrknMbMK+nO/3Nl9FfxSo29T8zuuTHIFrU3SDmK3nyszgpsNdfpau0TUpla1IL
	3
X-Google-Smtp-Source: AGHT+IH2i4vXowqMEG0sx9QT+6Eq9OAmgIa8HPhB2UPs5XXT5XXxKW1aUORA95bc3+Mn+4Wv7/9mkg==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr237857ioh.0.1712850129602;
        Thu, 11 Apr 2024 08:42:09 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:08 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 374/437] drivers/thunderbolt: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:34 -0600
Message-ID: <20240411153126.16201-375-axboe@kernel.dk>
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
 drivers/thunderbolt/debugfs.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/thunderbolt/debugfs.c b/drivers/thunderbolt/debugfs.c
index e324cd899719..fbe0fb7d40a6 100644
--- a/drivers/thunderbolt/debugfs.c
+++ b/drivers/thunderbolt/debugfs.c
@@ -43,8 +43,8 @@ static const struct file_operations __space ## _fops = {		\
 	.owner = THIS_MODULE,						\
 	.open = __space ## _open,					\
 	.release = single_release,					\
-	.read  = seq_read,						\
-	.write = __write,						\
+	.read_iter  = seq_read_iter,					\
+	.write_iter = __write,						\
 	.llseek = seq_lseek,						\
 }
 
@@ -52,7 +52,7 @@ static const struct file_operations __space ## _fops = {		\
 	DEBUGFS_ATTR(__space, NULL)
 
 #define DEBUGFS_ATTR_RW(__space)					\
-	DEBUGFS_ATTR(__space, __space ## _write)
+	DEBUGFS_ATTR(__space, __space ## _write ## _iter)
 
 static struct dentry *tb_debugfs_root;
 
@@ -175,6 +175,7 @@ static ssize_t port_regs_write(struct file *file, const char __user *user_buf,
 
 	return regs_write(port->sw, port, user_buf, count, ppos);
 }
+FOPS_WRITE_ITER_HELPER(port_regs_write);
 
 static ssize_t switch_regs_write(struct file *file, const char __user *user_buf,
 				 size_t count, loff_t *ppos)
@@ -184,10 +185,11 @@ static ssize_t switch_regs_write(struct file *file, const char __user *user_buf,
 
 	return regs_write(sw, NULL, user_buf, count, ppos);
 }
+FOPS_WRITE_ITER_HELPER(switch_regs_write);
 #define DEBUGFS_MODE		0600
 #else
-#define port_regs_write		NULL
-#define switch_regs_write	NULL
+#define port_regs_write_iter	NULL
+#define switch_regs_write_iter	NULL
 #define DEBUGFS_MODE		0400
 #endif
 
@@ -305,6 +307,7 @@ margining_ber_level_write(struct file *file, const char __user *user_buf,
 
 	return ret < 0 ? ret : count;
 }
+FOPS_WRITE_ITER_HELPER(margining_ber_level_write);
 
 static void ber_level_show(struct seq_file *s, unsigned int val)
 {
@@ -445,6 +448,7 @@ margining_lanes_write(struct file *file, const char __user *user_buf,
 	free_page((unsigned long)buf);
 	return ret < 0 ? ret : count;
 }
+FOPS_WRITE_ITER_HELPER(margining_lanes_write);
 
 static int margining_lanes_show(struct seq_file *s, void *not_used)
 {
@@ -518,6 +522,7 @@ static ssize_t margining_mode_write(struct file *file,
 	free_page((unsigned long)buf);
 	return ret ? ret : count;
 }
+FOPS_WRITE_ITER_HELPER(margining_mode_write);
 
 static int margining_mode_show(struct seq_file *s, void *not_used)
 {
@@ -646,6 +651,7 @@ static ssize_t margining_results_write(struct file *file,
 	mutex_unlock(&tb->lock);
 	return count;
 }
+FOPS_WRITE_ITER_HELPER(margining_results_write);
 
 static void voltage_margin_show(struct seq_file *s,
 				const struct tb_margining *margining, u8 val)
@@ -775,6 +781,7 @@ static ssize_t margining_test_write(struct file *file,
 	free_page((unsigned long)buf);
 	return ret ? ret : count;
 }
+FOPS_WRITE_ITER_HELPER(margining_test_write);
 
 static int margining_test_show(struct seq_file *s, void *not_used)
 {
@@ -843,6 +850,7 @@ static ssize_t margining_margin_write(struct file *file,
 	free_page((unsigned long)buf);
 	return ret ? ret : count;
 }
+FOPS_WRITE_ITER_HELPER(margining_margin_write);
 
 static int margining_margin_show(struct seq_file *s, void *not_used)
 {
@@ -1089,6 +1097,7 @@ static ssize_t counters_write(struct file *file, const char __user *user_buf,
 
 	return ret < 0 ? ret : count;
 }
+FOPS_WRITE_ITER_HELPER(counters_write);
 
 static void cap_show_by_dw(struct seq_file *s, struct tb_switch *sw,
 			   struct tb_port *port, unsigned int cap,
-- 
2.43.0


