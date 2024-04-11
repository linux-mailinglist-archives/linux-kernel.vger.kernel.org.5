Return-Path: <linux-kernel+bounces-140813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034C08A1914
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8BEB282E3F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CB67E796;
	Thu, 11 Apr 2024 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="q/pGY313"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4671076036
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849595; cv=none; b=iJpPYmgbYp8mbACc9Ll5Vg9EUE+aabkpYTwvYiYOr6nPQCUVXeapISE3GLI9D/C3SxaBqWP7Ghcpqpc4wVnDJijpBNF9lv/GNlHPtOObvmPG6l0peQt3h0s79Fxrw52S6vTDNIThxBN1j1A0s2R8ivEBWeJwRiqtaOD+xFJ3V0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849595; c=relaxed/simple;
	bh=JMHGbsbH3/p2/2Pc/GsuMM/kShjNXLRyyXRzZxTSHCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSLZIYPYb209iAjXaCJcAc9BL2NGeGoX260SvYgnnOqfyqT+5duDfO7kXTEKiPoRj6cml2ddwSgQDNrrPXB0rXHkheNEpxvk+buf9quJ6tubk06AN+kpSlbizTPhUdXvqlD8Mb0egQ0KcqSBkOGuXZEs1i7Mfe9Z/1LCb0sGais=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=q/pGY313; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16112339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849591; x=1713454391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTHLSN6q6uDO3ubR9Id6JaOEnIGD3H3ZO0XrATdmC0g=;
        b=q/pGY3133vTWwS9qCsSSLlFPekpt+9fnjwAsMbuLPo3pNXEgaY+2izFkoTF6ea8qrc
         Vkvz7oor8dVc8IYtn4nPaD9T8CfZ1cFKIus8jO/Q0OFW47oWomGuewFvcBfzDmrutaCp
         WxvyZMZ0OCcpdB6Z8BSj3VXEmM2p6m9ueCvYadeWFObC8sPmoKszSNqj1Bz34X+MA+LF
         llTGBOIHOSQ9yJVG8nzYIM/sL9jPCX69oLSYor8ig//cAJ5YaQYZMsmK4vUX0yqQLNvw
         rXlEicd6QgL+75e/OEQmOOs3Vmoz97A2RnGrA7siuLWsszH4XLGobx3hpJQbV4vvF6aC
         oGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849591; x=1713454391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTHLSN6q6uDO3ubR9Id6JaOEnIGD3H3ZO0XrATdmC0g=;
        b=bXIbK6s9WZOkY89rHIkqq40l2dJfHa/SS+7gijdhmOlb+ES6Iz0aJu8jDeZPLqUe0y
         fjkikjKWy4JC4iWQOJERN19dw4r+2e70XXbb3pKTjQlhKx3QHKa05a8z8x7P8NTUrZks
         4eAknnzsYt/vEl6x2cDTo93o/GmOQD1rGiFZr2l0A8wo/Bt868z5qHLHLgsS0EWoEbAP
         TTwXA83+P7RbfdXfH3r3GJslzbQ4kp+IntN3SHLlrnCd6ckhedrcuvu3sEn2rbDR2kfE
         hiJ2DqeBc/WSwGqGkTraT6Zd9WtT/k3kdJnZG9fsq3NJ6Hd8OaYfomw2ppVf7cAnbV+6
         N1SA==
X-Gm-Message-State: AOJu0YyoLucFDn7f1OiA0BDKe/zvhTBX3O5KnOTWtNX+EL0MWg4gwgjI
	S/q+Q1VWlQLDHBLY1y0AV1tv1/fgKWRgHU8L3LHkxMKhDjsPQq3059khUZki8n9PAJl49XzBdCE
	C
X-Google-Smtp-Source: AGHT+IGPK/u5RJI76LgOr0uPz+eCZoHTSC3jic5M9NKggCvRRnrlUaAKe9kqv2XHLl8mHtIGGiAnNQ==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr151755ioh.1.1712849590412;
        Thu, 11 Apr 2024 08:33:10 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:33:08 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 052/437] net: mac80211: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:12 -0600
Message-ID: <20240411153126.16201-53-axboe@kernel.dk>
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
 include/net/cfg80211.h                     |  24 +--
 net/mac80211/debugfs.c                     | 185 +++++++++------------
 net/mac80211/debugfs.h                     |   4 +-
 net/mac80211/debugfs_key.c                 |  81 ++++-----
 net/mac80211/debugfs_netdev.c              | 126 ++++++--------
 net/mac80211/debugfs_sta.c                 | 146 +++++++---------
 net/mac80211/rate.c                        |  10 +-
 net/mac80211/rc80211_minstrel_ht_debugfs.c |  11 +-
 net/wireless/debugfs.c                     |  36 ++--
 9 files changed, 260 insertions(+), 363 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 1e09329acc42..4c33df652196 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -9469,21 +9469,17 @@ void cfg80211_schedule_channels_check(struct wireless_dev *wdev);
 /**
  * wiphy_locked_debugfs_read - do a locked read in debugfs
  * @wiphy: the wiphy to use
- * @file: the file being read
+ * @iocb: metadata for the IO
  * @buf: the buffer to fill and then read from
  * @bufsize: size of the buffer
- * @userbuf: the user buffer to copy to
- * @count: read count
- * @ppos: read position
+ * @to: the user buffer to copy to
  * @handler: the read handler to call (under wiphy lock)
  * @data: additional data to pass to the read handler
  */
-ssize_t wiphy_locked_debugfs_read(struct wiphy *wiphy, struct file *file,
+ssize_t wiphy_locked_debugfs_read(struct wiphy *wiphy, struct kiocb *iocb,
 				  char *buf, size_t bufsize,
-				  char __user *userbuf, size_t count,
-				  loff_t *ppos,
+				  struct iov_iter *to,
 				  ssize_t (*handler)(struct wiphy *wiphy,
-						     struct file *file,
 						     char *buf,
 						     size_t bufsize,
 						     void *data),
@@ -9492,21 +9488,19 @@ ssize_t wiphy_locked_debugfs_read(struct wiphy *wiphy, struct file *file,
 /**
  * wiphy_locked_debugfs_write - do a locked write in debugfs
  * @wiphy: the wiphy to use
- * @file: the file being written to
+ * @iocb: metadata for the IO
  * @buf: the buffer to copy the user data to
  * @bufsize: size of the buffer
- * @userbuf: the user buffer to copy from
- * @count: read count
+ * @from: the user buffer to copy from
  * @handler: the write handler to call (under wiphy lock)
  * @data: additional data to pass to the write handler
  */
-ssize_t wiphy_locked_debugfs_write(struct wiphy *wiphy, struct file *file,
+ssize_t wiphy_locked_debugfs_write(struct wiphy *wiphy, struct kiocb *iocb,
 				   char *buf, size_t bufsize,
-				   const char __user *userbuf, size_t count,
+				   struct iov_iter *from,
 				   ssize_t (*handler)(struct wiphy *wiphy,
-						      struct file *file,
 						      char *buf,
-						      size_t count,
+						      size_t bufsize,
 						      void *data),
 				   void *data);
 #endif
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 2f68e92a7404..6d83b91373ce 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -17,8 +17,8 @@
 
 #define DEBUGFS_FORMAT_BUFFER_SIZE 100
 
-int mac80211_format_buffer(char __user *userbuf, size_t count,
-				  loff_t *ppos, char *fmt, ...)
+int mac80211_format_buffer(struct kiocb *iocb, struct iov_iter *to,
+			   char *fmt, ...)
 {
 	va_list args;
 	char buf[DEBUGFS_FORMAT_BUFFER_SIZE];
@@ -28,22 +28,20 @@ int mac80211_format_buffer(char __user *userbuf, size_t count,
 	res = vscnprintf(buf, sizeof(buf), fmt, args);
 	va_end(args);
 
-	return simple_read_from_buffer(userbuf, count, ppos, buf, res);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, res, to);
 }
 
 #define DEBUGFS_READONLY_FILE_FN(name, fmt, value...)			\
-static ssize_t name## _read(struct file *file, char __user *userbuf,	\
-			    size_t count, loff_t *ppos)			\
+static ssize_t name## _read(struct kiocb *iocb, struct iov_iter *to)	\
 {									\
-	struct ieee80211_local *local = file->private_data;		\
+	struct ieee80211_local *local = iocb->ki_filp->private_data;	\
 									\
-	return mac80211_format_buffer(userbuf, count, ppos, 		\
-				      fmt "\n", ##value);		\
-}
+	return mac80211_format_buffer(iocb, to, fmt "\n", ##value);	\
+}									\
 
 #define DEBUGFS_READONLY_FILE_OPS(name)			\
 static const struct file_operations name## _ops = {			\
-	.read = name## _read,						\
+	.read_iter = name## _read,					\
 	.open = simple_open,						\
 	.llseek = generic_file_llseek,					\
 };
@@ -72,12 +70,9 @@ DEBUGFS_READONLY_FILE(wep_iv, "%#08x",
 DEBUGFS_READONLY_FILE(rate_ctrl_alg, "%s",
 	local->rate_ctrl ? local->rate_ctrl->ops->name : "hw/driver");
 
-static ssize_t aqm_read(struct file *file,
-			char __user *user_buf,
-			size_t count,
-			loff_t *ppos)
+static ssize_t aqm_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ieee80211_local *local = file->private_data;
+	struct ieee80211_local *local = iocb->ki_filp->private_data;
 	struct fq *fq = &local->fq;
 	char buf[200];
 	int len = 0;
@@ -109,22 +104,19 @@ static ssize_t aqm_read(struct file *file,
 	rcu_read_unlock();
 	spin_unlock_bh(&local->fq.lock);
 
-	return simple_read_from_buffer(user_buf, count, ppos,
-				       buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t aqm_write(struct file *file,
-			 const char __user *user_buf,
-			 size_t count,
-			 loff_t *ppos)
+static ssize_t aqm_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ieee80211_local *local = file->private_data;
+	struct ieee80211_local *local = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[100];
 
 	if (count >= sizeof(buf))
 		return -EINVAL;
 
-	if (copy_from_user(buf, user_buf, count))
+	if (!copy_from_iter(buf, count, from))
 		return -EFAULT;
 
 	if (count && buf[count - 1] == '\n')
@@ -143,17 +135,15 @@ static ssize_t aqm_write(struct file *file,
 }
 
 static const struct file_operations aqm_ops = {
-	.write = aqm_write,
-	.read = aqm_read,
+	.write_iter = aqm_write,
+	.read_iter = aqm_read,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
 
-static ssize_t airtime_flags_read(struct file *file,
-				  char __user *user_buf,
-				  size_t count, loff_t *ppos)
+static ssize_t airtime_flags_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ieee80211_local *local = file->private_data;
+	struct ieee80211_local *local = iocb->ki_filp->private_data;
 	char buf[128] = {}, *pos, *end;
 
 	pos = buf;
@@ -166,21 +156,19 @@ static ssize_t airtime_flags_read(struct file *file,
 		pos += scnprintf(pos, end - pos, "AIRTIME_RX\t(%lx)\n",
 				 AIRTIME_USE_RX);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf,
-				       strlen(buf));
+	return simple_copy_to_iter(buf, &iocb->ki_pos, strlen(buf), to);
 }
 
-static ssize_t airtime_flags_write(struct file *file,
-				   const char __user *user_buf,
-				   size_t count, loff_t *ppos)
+static ssize_t airtime_flags_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ieee80211_local *local = file->private_data;
+	struct ieee80211_local *local = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[16];
 
 	if (count >= sizeof(buf))
 		return -EINVAL;
 
-	if (copy_from_user(buf, user_buf, count))
+	if (!copy_from_iter(buf, count, from))
 		return -EFAULT;
 
 	if (count && buf[count - 1] == '\n')
@@ -195,17 +183,15 @@ static ssize_t airtime_flags_write(struct file *file,
 }
 
 static const struct file_operations airtime_flags_ops = {
-	.write = airtime_flags_write,
-	.read = airtime_flags_read,
+	.write_iter = airtime_flags_write,
+	.read_iter = airtime_flags_read,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
 
-static ssize_t aql_pending_read(struct file *file,
-				char __user *user_buf,
-				size_t count, loff_t *ppos)
+static ssize_t aql_pending_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ieee80211_local *local = file->private_data;
+	struct ieee80211_local *local = iocb->ki_filp->private_data;
 	char buf[400];
 	int len = 0;
 
@@ -221,22 +207,18 @@ static ssize_t aql_pending_read(struct file *file,
 			atomic_read(&local->aql_ac_pending_airtime[IEEE80211_AC_BE]),
 			atomic_read(&local->aql_ac_pending_airtime[IEEE80211_AC_BK]),
 			atomic_read(&local->aql_total_pending_airtime));
-	return simple_read_from_buffer(user_buf, count, ppos,
-				       buf, len);
+	return simple_copy_to_iter( buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations aql_pending_ops = {
-	.read = aql_pending_read,
+	.read_iter = aql_pending_read,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
 
-static ssize_t aql_txq_limit_read(struct file *file,
-				  char __user *user_buf,
-				  size_t count,
-				  loff_t *ppos)
+static ssize_t aql_txq_limit_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ieee80211_local *local = file->private_data;
+	struct ieee80211_local *local = iocb->ki_filp->private_data;
 	char buf[400];
 	int len = 0;
 
@@ -254,24 +236,21 @@ static ssize_t aql_txq_limit_read(struct file *file,
 			local->aql_txq_limit_high[IEEE80211_AC_BE],
 			local->aql_txq_limit_low[IEEE80211_AC_BK],
 			local->aql_txq_limit_high[IEEE80211_AC_BK]);
-	return simple_read_from_buffer(user_buf, count, ppos,
-				       buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t aql_txq_limit_write(struct file *file,
-				   const char __user *user_buf,
-				   size_t count,
-				   loff_t *ppos)
+static ssize_t aql_txq_limit_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ieee80211_local *local = file->private_data;
+	struct ieee80211_local *local = iocb->ki_filp->private_data;
 	char buf[100];
 	u32 ac, q_limit_low, q_limit_high, q_limit_low_old, q_limit_high_old;
 	struct sta_info *sta;
+	size_t count = iov_iter_count(from);
 
 	if (count >= sizeof(buf))
 		return -EINVAL;
 
-	if (copy_from_user(buf, user_buf, count))
+	if (!copy_from_iter_full(buf, count, from))
 		return -EFAULT;
 
 	if (count && buf[count - 1] == '\n')
@@ -306,14 +285,13 @@ static ssize_t aql_txq_limit_write(struct file *file,
 }
 
 static const struct file_operations aql_txq_limit_ops = {
-	.write = aql_txq_limit_write,
-	.read = aql_txq_limit_read,
+	.write_iter = aql_txq_limit_write,
+	.read_iter = aql_txq_limit_read,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
 
-static ssize_t aql_enable_read(struct file *file, char __user *user_buf,
-			       size_t count, loff_t *ppos)
+static ssize_t aql_enable_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char buf[3];
 	int len;
@@ -321,20 +299,20 @@ static ssize_t aql_enable_read(struct file *file, char __user *user_buf,
 	len = scnprintf(buf, sizeof(buf), "%d\n",
 			!static_key_false(&aql_disable.key));
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t aql_enable_write(struct file *file, const char __user *user_buf,
-				size_t count, loff_t *ppos)
+static ssize_t aql_enable_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	bool aql_disabled = static_key_false(&aql_disable.key);
+	size_t count = iov_iter_count(from);
 	char buf[3];
 	size_t len;
 
 	if (count > sizeof(buf))
 		return -EINVAL;
 
-	if (copy_from_user(buf, user_buf, count))
+	if (!copy_from_iter_full(buf, count, from))
 		return -EFAULT;
 
 	buf[sizeof(buf) - 1] = '\0';
@@ -356,39 +334,33 @@ static ssize_t aql_enable_write(struct file *file, const char __user *user_buf,
 }
 
 static const struct file_operations aql_enable_ops = {
-	.write = aql_enable_write,
-	.read = aql_enable_read,
+	.write_iter = aql_enable_write,
+	.read_iter = aql_enable_read,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
 
-static ssize_t force_tx_status_read(struct file *file,
-				    char __user *user_buf,
-				    size_t count,
-				    loff_t *ppos)
+static ssize_t force_tx_status_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ieee80211_local *local = file->private_data;
+	struct ieee80211_local *local = iocb->ki_filp->private_data;
 	char buf[3];
 	int len = 0;
 
 	len = scnprintf(buf, sizeof(buf), "%d\n", (int)local->force_tx_status);
 
-	return simple_read_from_buffer(user_buf, count, ppos,
-				       buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t force_tx_status_write(struct file *file,
-				     const char __user *user_buf,
-				     size_t count,
-				     loff_t *ppos)
+static ssize_t force_tx_status_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ieee80211_local *local = file->private_data;
+	struct ieee80211_local *local = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char buf[3];
 
 	if (count >= sizeof(buf))
 		return -EINVAL;
 
-	if (copy_from_user(buf, user_buf, count))
+	if (!copy_from_iter_full(buf, count, from))
 		return -EFAULT;
 
 	if (count && buf[count - 1] == '\n')
@@ -407,17 +379,17 @@ static ssize_t force_tx_status_write(struct file *file,
 }
 
 static const struct file_operations force_tx_status_ops = {
-	.write = force_tx_status_write,
-	.read = force_tx_status_read,
+	.write_iter = force_tx_status_write,
+	.read_iter = force_tx_status_read,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
 
 #ifdef CONFIG_PM
-static ssize_t reset_write(struct file *file, const char __user *user_buf,
-			   size_t count, loff_t *ppos)
+static ssize_t reset_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ieee80211_local *local = file->private_data;
+	struct ieee80211_local *local = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	int ret;
 
 	rtnl_lock();
@@ -435,7 +407,7 @@ static ssize_t reset_write(struct file *file, const char __user *user_buf,
 }
 
 static const struct file_operations reset_ops = {
-	.write = reset_write,
+	.write_iter = reset_write,
 	.open = simple_open,
 	.llseek = noop_llseek,
 };
@@ -502,10 +474,9 @@ static const char *hw_flag_names[] = {
 #undef FLAG
 };
 
-static ssize_t hwflags_read(struct file *file, char __user *user_buf,
-			    size_t count, loff_t *ppos)
+static ssize_t hwflags_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ieee80211_local *local = file->private_data;
+	struct ieee80211_local *local = iocb->ki_filp->private_data;
 	size_t bufsz = 30 * NUM_IEEE80211_HW_FLAGS;
 	char *buf = kzalloc(bufsz, GFP_KERNEL);
 	char *pos = buf, *end = buf + bufsz - 1;
@@ -526,15 +497,14 @@ static ssize_t hwflags_read(struct file *file, char __user *user_buf,
 					 hw_flag_names[i]);
 	}
 
-	rv = simple_read_from_buffer(user_buf, count, ppos, buf, strlen(buf));
+	rv = simple_copy_to_iter(buf, &iocb->ki_pos, strlen(buf), to);
 	kfree(buf);
 	return rv;
 }
 
-static ssize_t misc_read(struct file *file, char __user *user_buf,
-			 size_t count, loff_t *ppos)
+static ssize_t misc_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ieee80211_local *local = file->private_data;
+	struct ieee80211_local *local = iocb->ki_filp->private_data;
 	/* Max len of each line is 16 characters, plus 9 for 'pending:\n' */
 	size_t bufsz = IEEE80211_MAX_QUEUES * 16 + 9;
 	char *buf;
@@ -558,15 +528,14 @@ static ssize_t misc_read(struct file *file, char __user *user_buf,
 				 i, ln);
 	}
 
-	rv = simple_read_from_buffer(user_buf, count, ppos, buf, strlen(buf));
+	rv = simple_copy_to_iter(buf, &iocb->ki_pos, strlen(buf), to);
 	kfree(buf);
 	return rv;
 }
 
-static ssize_t queues_read(struct file *file, char __user *user_buf,
-			   size_t count, loff_t *ppos)
+static ssize_t queues_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ieee80211_local *local = file->private_data;
+	struct ieee80211_local *local = iocb->ki_filp->private_data;
 	unsigned long flags;
 	char buf[IEEE80211_MAX_QUEUES * 20];
 	int q, res = 0;
@@ -578,7 +547,7 @@ static ssize_t queues_read(struct file *file, char __user *user_buf,
 				skb_queue_len(&local->pending[q]));
 	spin_unlock_irqrestore(&local->queue_stop_reason_lock, flags);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, res);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, res, to);
 }
 
 DEBUGFS_READONLY_FILE_OPS(hwflags);
@@ -588,8 +557,7 @@ DEBUGFS_READONLY_FILE_OPS(misc);
 /* statistics stuff */
 
 static ssize_t format_devstat_counter(struct ieee80211_local *local,
-	char __user *userbuf,
-	size_t count, loff_t *ppos,
+	struct kiocb *iocb, struct iov_iter *to,
 	int (*printvalue)(struct ieee80211_low_level_stats *stats, char *buf,
 			  int buflen))
 {
@@ -603,7 +571,7 @@ static ssize_t format_devstat_counter(struct ieee80211_local *local,
 	if (res)
 		return res;
 	res = printvalue(&stats, buf, sizeof(buf));
-	return simple_read_from_buffer(userbuf, count, ppos, buf, res);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, res, to);
 }
 
 #define DEBUGFS_DEVSTATS_FILE(name)					\
@@ -612,19 +580,16 @@ static int print_devstats_##name(struct ieee80211_low_level_stats *stats,\
 {									\
 	return scnprintf(buf, buflen, "%u\n", stats->name);		\
 }									\
-static ssize_t stats_ ##name## _read(struct file *file,			\
-				     char __user *userbuf,		\
-				     size_t count, loff_t *ppos)	\
+static ssize_t stats_ ##name## _read(struct kiocb *iocb,		\
+				     struct iov_iter *to)		\
 {									\
-	return format_devstat_counter(file->private_data,		\
-				      userbuf,				\
-				      count,				\
-				      ppos,				\
+	return format_devstat_counter(iocb->ki_filp->private_data,	\
+				      iocb, to,				\
 				      print_devstats_##name);		\
 }									\
 									\
 static const struct file_operations stats_ ##name## _ops = {		\
-	.read = stats_ ##name## _read,					\
+	.read_iter = stats_ ##name## _read,				\
 	.open = simple_open,						\
 	.llseek = generic_file_llseek,					\
 };
diff --git a/net/mac80211/debugfs.h b/net/mac80211/debugfs.h
index d2c424787463..786f08f19713 100644
--- a/net/mac80211/debugfs.h
+++ b/net/mac80211/debugfs.h
@@ -6,8 +6,8 @@
 
 #ifdef CONFIG_MAC80211_DEBUGFS
 void debugfs_hw_add(struct ieee80211_local *local);
-int __printf(4, 5) mac80211_format_buffer(char __user *userbuf, size_t count,
-					  loff_t *ppos, char *fmt, ...);
+int __printf(3, 4) mac80211_format_buffer(struct kiocb *iocb,
+					  struct iov_iter *to, char *fmt, ...);
 #else
 static inline void debugfs_hw_add(struct ieee80211_local *local)
 {
diff --git a/net/mac80211/debugfs_key.c b/net/mac80211/debugfs_key.c
index 7e54da508765..decf19878e79 100644
--- a/net/mac80211/debugfs_key.c
+++ b/net/mac80211/debugfs_key.c
@@ -15,27 +15,27 @@
 #include "debugfs_key.h"
 
 #define KEY_READ(name, prop, format_string)				\
-static ssize_t key_##name##_read(struct file *file,			\
-				 char __user *userbuf,			\
-				 size_t count, loff_t *ppos)		\
+static ssize_t key_##name##_read(struct kiocb *iocb,			\
+				 struct iov_iter *to)			\
 {									\
-	struct ieee80211_key *key = file->private_data;			\
-	return mac80211_format_buffer(userbuf, count, ppos, 		\
-				      format_string, key->prop);	\
-}
+	struct ieee80211_key *key = iocb->ki_filp->private_data;	\
+	return mac80211_format_buffer(iocb, to, format_string,		\
+				      key->prop);			\
+}									\
+
 #define KEY_READ_X(name) KEY_READ(name, name, "0x%x\n")
 
 #define KEY_OPS(name)							\
 static const struct file_operations key_ ##name## _ops = {		\
-	.read = key_##name##_read,					\
+	.read_iter = key_##name##_read,					\
 	.open = simple_open,						\
 	.llseek = generic_file_llseek,					\
 }
 
 #define KEY_OPS_W(name)							\
 static const struct file_operations key_ ##name## _ops = {		\
-	.read = key_##name##_read,					\
-	.write = key_##name##_write,					\
+	.read_iter = key_##name##_read,					\
+	.write_iter = key_##name##_write,				\
 	.open = simple_open,						\
 	.llseek = generic_file_llseek,					\
 }
@@ -50,7 +50,7 @@ static const struct file_operations key_ ##name## _ops = {		\
 
 #define KEY_CONF_OPS(name)						\
 static const struct file_operations key_ ##name## _ops = {		\
-	.read = key_conf_##name##_read,					\
+	.read_iter = key_conf_##name##_read,				\
 	.open = simple_open,						\
 	.llseek = generic_file_llseek,					\
 }
@@ -66,24 +66,22 @@ KEY_FILE(flags, X);
 KEY_READ(ifindex, sdata->name, "%s\n");
 KEY_OPS(ifindex);
 
-static ssize_t key_algorithm_read(struct file *file,
-				  char __user *userbuf,
-				  size_t count, loff_t *ppos)
+static ssize_t key_algorithm_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char buf[15];
-	struct ieee80211_key *key = file->private_data;
+	struct ieee80211_key *key = iocb->ki_filp->private_data;
 	u32 c = key->conf.cipher;
 
 	sprintf(buf, "%.2x-%.2x-%.2x:%d\n",
 		c >> 24, (c >> 16) & 0xff, (c >> 8) & 0xff, c & 0xff);
-	return simple_read_from_buffer(userbuf, count, ppos, buf, strlen(buf));
+	return simple_copy_to_iter(buf, &iocb->ki_pos, strlen(buf), to);
 }
 KEY_OPS(algorithm);
 
-static ssize_t key_tx_spec_write(struct file *file, const char __user *userbuf,
-				 size_t count, loff_t *ppos)
+static ssize_t key_tx_spec_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ieee80211_key *key = file->private_data;
+	struct ieee80211_key *key = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	u64 pn;
 	int ret;
 
@@ -102,7 +100,7 @@ static ssize_t key_tx_spec_write(struct file *file, const char __user *userbuf,
 	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
 	case WLAN_CIPHER_SUITE_GCMP:
 	case WLAN_CIPHER_SUITE_GCMP_256:
-		ret = kstrtou64_from_user(userbuf, count, 16, &pn);
+		ret = kstrtou64_from_iter(from, count, 16, &pn);
 		if (ret)
 			return ret;
 		/* PN is a 48-bit counter */
@@ -115,13 +113,12 @@ static ssize_t key_tx_spec_write(struct file *file, const char __user *userbuf,
 	}
 }
 
-static ssize_t key_tx_spec_read(struct file *file, char __user *userbuf,
-				size_t count, loff_t *ppos)
+static ssize_t key_tx_spec_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	u64 pn;
 	char buf[20];
 	int len;
-	struct ieee80211_key *key = file->private_data;
+	struct ieee80211_key *key = iocb->ki_filp->private_data;
 
 	switch (key->conf.cipher) {
 	case WLAN_CIPHER_SUITE_WEP40:
@@ -150,14 +147,13 @@ static ssize_t key_tx_spec_read(struct file *file, char __user *userbuf,
 	default:
 		return 0;
 	}
-	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 KEY_OPS_W(tx_spec);
 
-static ssize_t key_rx_spec_read(struct file *file, char __user *userbuf,
-				size_t count, loff_t *ppos)
+static ssize_t key_rx_spec_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ieee80211_key *key = file->private_data;
+	struct ieee80211_key *key = iocb->ki_filp->private_data;
 	char buf[14*IEEE80211_NUM_TIDS+1], *p = buf;
 	int i, len;
 	const u8 *rpn;
@@ -218,14 +214,13 @@ static ssize_t key_rx_spec_read(struct file *file, char __user *userbuf,
 	default:
 		return 0;
 	}
-	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 KEY_OPS(rx_spec);
 
-static ssize_t key_replays_read(struct file *file, char __user *userbuf,
-				size_t count, loff_t *ppos)
+static ssize_t key_replays_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ieee80211_key *key = file->private_data;
+	struct ieee80211_key *key = iocb->ki_filp->private_data;
 	char buf[20];
 	int len;
 
@@ -251,14 +246,13 @@ static ssize_t key_replays_read(struct file *file, char __user *userbuf,
 	default:
 		return 0;
 	}
-	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 KEY_OPS(replays);
 
-static ssize_t key_icverrors_read(struct file *file, char __user *userbuf,
-				  size_t count, loff_t *ppos)
+static ssize_t key_icverrors_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ieee80211_key *key = file->private_data;
+	struct ieee80211_key *key = iocb->ki_filp->private_data;
 	char buf[20];
 	int len;
 
@@ -276,14 +270,13 @@ static ssize_t key_icverrors_read(struct file *file, char __user *userbuf,
 	default:
 		return 0;
 	}
-	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 KEY_OPS(icverrors);
 
-static ssize_t key_mic_failures_read(struct file *file, char __user *userbuf,
-				     size_t count, loff_t *ppos)
+static ssize_t key_mic_failures_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ieee80211_key *key = file->private_data;
+	struct ieee80211_key *key = iocb->ki_filp->private_data;
 	char buf[20];
 	int len;
 
@@ -291,15 +284,13 @@ static ssize_t key_mic_failures_read(struct file *file, char __user *userbuf,
 		return -EINVAL;
 
 	len = scnprintf(buf, sizeof(buf), "%u\n", key->u.tkip.mic_failures);
-
-	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 KEY_OPS(mic_failures);
 
-static ssize_t key_key_read(struct file *file, char __user *userbuf,
-			    size_t count, loff_t *ppos)
+static ssize_t key_key_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ieee80211_key *key = file->private_data;
+	struct ieee80211_key *key = iocb->ki_filp->private_data;
 	int i, bufsize = 2 * key->conf.keylen + 2;
 	char *buf = kmalloc(bufsize, GFP_KERNEL);
 	char *p = buf;
@@ -311,7 +302,7 @@ static ssize_t key_key_read(struct file *file, char __user *userbuf,
 	for (i = 0; i < key->conf.keylen; i++)
 		p += scnprintf(p, bufsize + buf - p, "%02x", key->conf.key[i]);
 	p += scnprintf(p, bufsize+buf-p, "\n");
-	res = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
+	res = simple_copy_to_iter(buf, &iocb->ki_pos, p - buf, to);
 	kfree(buf);
 	return res;
 }
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index 68596ef78b15..41f1072334c3 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -28,9 +28,7 @@ struct ieee80211_if_read_sdata_data {
 };
 
 static ssize_t ieee80211_if_read_sdata_handler(struct wiphy *wiphy,
-					       struct file *file,
-					       char *buf,
-					       size_t bufsize,
+					       char *buf, size_t bufsize,
 					       void *data)
 {
 	struct ieee80211_if_read_sdata_data *d = data;
@@ -39,12 +37,11 @@ static ssize_t ieee80211_if_read_sdata_handler(struct wiphy *wiphy,
 }
 
 static ssize_t ieee80211_if_read_sdata(
-	struct file *file,
-	char __user *userbuf,
-	size_t count, loff_t *ppos,
+	struct kiocb *iocb,
+	struct iov_iter *to,
 	ssize_t (*format)(const struct ieee80211_sub_if_data *sdata, char *, int))
 {
-	struct ieee80211_sub_if_data *sdata = file->private_data;
+	struct ieee80211_sub_if_data *sdata = iocb->ki_filp->private_data;
 	struct ieee80211_if_read_sdata_data data = {
 		.format = format,
 		.sdata = sdata,
@@ -52,44 +49,39 @@ static ssize_t ieee80211_if_read_sdata(
 	char buf[200];
 
 	return wiphy_locked_debugfs_read(sdata->local->hw.wiphy,
-					 file, buf, sizeof(buf),
-					 userbuf, count, ppos,
+					 iocb, buf, sizeof(buf), to,
 					 ieee80211_if_read_sdata_handler,
 					 &data);
 }
 
 struct ieee80211_if_write_sdata_data {
-	ssize_t (*write)(struct ieee80211_sub_if_data *, const char *, int);
+	ssize_t (*write)(struct ieee80211_sub_if_data *, char *, size_t);
 	struct ieee80211_sub_if_data *sdata;
 };
 
 static ssize_t ieee80211_if_write_sdata_handler(struct wiphy *wiphy,
-						struct file *file,
-						char *buf,
-						size_t count,
+						char *buf, size_t bufsize,
 						void *data)
 {
 	struct ieee80211_if_write_sdata_data *d = data;
 
-	return d->write(d->sdata, buf, count);
+	return d->write(d->sdata, buf, bufsize);
 }
 
 static ssize_t ieee80211_if_write_sdata(
-	struct file *file,
-	const char __user *userbuf,
-	size_t count, loff_t *ppos,
-	ssize_t (*write)(struct ieee80211_sub_if_data *sdata, const char *, int))
+	struct kiocb *iocb,
+	struct iov_iter *from,
+	ssize_t (*write)(struct ieee80211_sub_if_data *sdata, char *, size_t))
 {
-	struct ieee80211_sub_if_data *sdata = file->private_data;
+	struct ieee80211_sub_if_data *sdata = iocb->ki_filp->private_data;
 	struct ieee80211_if_write_sdata_data data = {
 		.write = write,
 		.sdata = sdata,
 	};
 	char buf[64];
 
-	return wiphy_locked_debugfs_write(sdata->local->hw.wiphy,
-					  file, buf, sizeof(buf),
-					  userbuf, count,
+	return wiphy_locked_debugfs_write(sdata->local->hw.wiphy, iocb,
+					  buf, sizeof(buf), from,
 					  ieee80211_if_write_sdata_handler,
 					  &data);
 }
@@ -100,7 +92,6 @@ struct ieee80211_if_read_link_data {
 };
 
 static ssize_t ieee80211_if_read_link_handler(struct wiphy *wiphy,
-					      struct file *file,
 					      char *buf,
 					      size_t bufsize,
 					      void *data)
@@ -111,12 +102,11 @@ static ssize_t ieee80211_if_read_link_handler(struct wiphy *wiphy,
 }
 
 static ssize_t ieee80211_if_read_link(
-	struct file *file,
-	char __user *userbuf,
-	size_t count, loff_t *ppos,
+	struct kiocb *iocb,
+	struct iov_iter *to,
 	ssize_t (*format)(const struct ieee80211_link_data *link, char *, int))
 {
-	struct ieee80211_link_data *link = file->private_data;
+	struct ieee80211_link_data *link = iocb->ki_filp->private_data;
 	struct ieee80211_if_read_link_data data = {
 		.format = format,
 		.link = link,
@@ -124,8 +114,7 @@ static ssize_t ieee80211_if_read_link(
 	char buf[200];
 
 	return wiphy_locked_debugfs_read(link->sdata->local->hw.wiphy,
-					 file, buf, sizeof(buf),
-					 userbuf, count, ppos,
+					 iocb, buf, sizeof(buf), to,
 					 ieee80211_if_read_link_handler,
 					 &data);
 }
@@ -136,23 +125,19 @@ struct ieee80211_if_write_link_data {
 };
 
 static ssize_t ieee80211_if_write_link_handler(struct wiphy *wiphy,
-					       struct file *file,
-					       char *buf,
-					       size_t count,
+					       char *buf, size_t bufsize,
 					       void *data)
 {
 	struct ieee80211_if_write_sdata_data *d = data;
 
-	return d->write(d->sdata, buf, count);
+	return d->write(d->sdata, buf, bufsize);
 }
 
-static ssize_t ieee80211_if_write_link(
-	struct file *file,
-	const char __user *userbuf,
-	size_t count, loff_t *ppos,
+static ssize_t ieee80211_if_write_link(struct kiocb *iocb,
+	struct iov_iter *from,
 	ssize_t (*write)(struct ieee80211_link_data *link, const char *, int))
 {
-	struct ieee80211_link_data *link = file->private_data;
+	struct ieee80211_link_data *link = iocb->ki_filp->private_data;
 	struct ieee80211_if_write_link_data data = {
 		.write = write,
 		.link = link,
@@ -160,8 +145,7 @@ static ssize_t ieee80211_if_write_link(
 	char buf[64];
 
 	return wiphy_locked_debugfs_write(link->sdata->local->hw.wiphy,
-					  file, buf, sizeof(buf),
-					  userbuf, count,
+					  iocb, buf, sizeof(buf), from,
 					  ieee80211_if_write_link_handler,
 					  &data);
 }
@@ -222,31 +206,27 @@ static ssize_t ieee80211_if_fmt_##name(					\
 
 #define _IEEE80211_IF_FILE_OPS(name, _read, _write)			\
 static const struct file_operations name##_ops = {			\
-	.read = (_read),						\
-	.write = (_write),						\
+	.read_iter = (_read),						\
+	.write_iter = (_write),						\
 	.open = simple_open,						\
 	.llseek = generic_file_llseek,					\
 }
 
 #define _IEEE80211_IF_FILE_R_FN(name)					\
-static ssize_t ieee80211_if_read_##name(struct file *file,		\
-					char __user *userbuf,		\
-					size_t count, loff_t *ppos)	\
+static ssize_t ieee80211_if_read_##name(struct kiocb *iocb,		\
+					struct iov_iter *to)		\
 {									\
-	return ieee80211_if_read_sdata(file,				\
-				       userbuf, count, ppos,		\
-				       ieee80211_if_fmt_##name);	\
-}
+	return ieee80211_if_read_sdata(iocb,				\
+				       to, ieee80211_if_fmt_##name);	\
+}									\
 
 #define _IEEE80211_IF_FILE_W_FN(name)					\
-static ssize_t ieee80211_if_write_##name(struct file *file,		\
-					 const char __user *userbuf,	\
-					 size_t count, loff_t *ppos)	\
+static ssize_t ieee80211_if_write_##name(struct kiocb *iocb,		\
+					 struct iov_iter *from)		\
 {									\
-	return ieee80211_if_write_sdata(file, userbuf,			\
-					count, ppos,			\
+	return ieee80211_if_write_sdata(iocb, from,			\
 					ieee80211_if_parse_##name);	\
-}
+}									\
 
 #define IEEE80211_IF_FILE_R(name)					\
 	_IEEE80211_IF_FILE_R_FN(name)					\
@@ -267,24 +247,20 @@ static ssize_t ieee80211_if_write_##name(struct file *file,		\
 	IEEE80211_IF_FILE_R(name)
 
 #define _IEEE80211_IF_LINK_R_FN(name)					\
-static ssize_t ieee80211_if_read_##name(struct file *file,		\
-					char __user *userbuf,		\
-					size_t count, loff_t *ppos)	\
+static ssize_t ieee80211_if_read_##name(struct kiocb *iocb,		\
+					struct iov_iter *to)		\
 {									\
-	return ieee80211_if_read_link(file,				\
-				      userbuf, count, ppos,		\
-				      ieee80211_if_fmt_##name);	\
-}
+	return ieee80211_if_read_link(iocb, to,				\
+				      ieee80211_if_fmt_##name);		\
+}									\
 
 #define _IEEE80211_IF_LINK_W_FN(name)					\
-static ssize_t ieee80211_if_write_##name(struct file *file,		\
-					 const char __user *userbuf,	\
-					 size_t count, loff_t *ppos)	\
+static ssize_t ieee80211_if_write_##name(struct kiocb *iocb,		\
+					 struct iov_iter *from)		\
 {									\
-	return ieee80211_if_write_link(file, userbuf,			\
-				       count, ppos,			\
+	return ieee80211_if_write_link(iocb, from,			\
 				       ieee80211_if_parse_##name);	\
-}
+}									\
 
 #define IEEE80211_IF_LINK_FILE_R(name)					\
 	_IEEE80211_IF_LINK_R_FN(name)					\
@@ -441,7 +417,7 @@ static ssize_t ieee80211_if_parse_smps(struct ieee80211_link_data *link,
 IEEE80211_IF_LINK_FILE_RW(smps);
 
 static ssize_t ieee80211_if_parse_tkip_mic_test(
-	struct ieee80211_sub_if_data *sdata, const char *buf, int buflen)
+	struct ieee80211_sub_if_data *sdata, char *buf, size_t buflen)
 {
 	struct ieee80211_local *local = sdata->local;
 	u8 addr[ETH_ALEN];
@@ -504,7 +480,7 @@ static ssize_t ieee80211_if_parse_tkip_mic_test(
 IEEE80211_IF_FILE_W(tkip_mic_test);
 
 static ssize_t ieee80211_if_parse_beacon_loss(
-	struct ieee80211_sub_if_data *sdata, const char *buf, int buflen)
+	struct ieee80211_sub_if_data *sdata, char *buf, size_t buflen)
 {
 	if (!ieee80211_sdata_running(sdata) || !sdata->vif.cfg.assoc)
 		return -ENOTCONN;
@@ -524,7 +500,7 @@ static ssize_t ieee80211_if_fmt_uapsd_queues(
 }
 
 static ssize_t ieee80211_if_parse_uapsd_queues(
-	struct ieee80211_sub_if_data *sdata, const char *buf, int buflen)
+	struct ieee80211_sub_if_data *sdata, char *buf, size_t buflen)
 {
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	u8 val;
@@ -552,7 +528,7 @@ static ssize_t ieee80211_if_fmt_uapsd_max_sp_len(
 }
 
 static ssize_t ieee80211_if_parse_uapsd_max_sp_len(
-	struct ieee80211_sub_if_data *sdata, const char *buf, int buflen)
+	struct ieee80211_sub_if_data *sdata, char *buf, size_t buflen)
 {
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	unsigned long val;
@@ -584,7 +560,7 @@ static ssize_t ieee80211_if_fmt_tdls_wider_bw(
 }
 
 static ssize_t ieee80211_if_parse_tdls_wider_bw(
-	struct ieee80211_sub_if_data *sdata, const char *buf, int buflen)
+	struct ieee80211_sub_if_data *sdata, char *buf, size_t buflen)
 {
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	u8 val;
@@ -665,7 +641,7 @@ static ssize_t ieee80211_if_fmt_tsf(
 }
 
 static ssize_t ieee80211_if_parse_tsf(
-	struct ieee80211_sub_if_data *sdata, const char *buf, int buflen)
+	struct ieee80211_sub_if_data *sdata, char *buf, size_t buflen)
 {
 	struct ieee80211_local *local = sdata->local;
 	unsigned long long tsf;
@@ -724,7 +700,7 @@ static ssize_t ieee80211_if_fmt_active_links(const struct ieee80211_sub_if_data
 }
 
 static ssize_t ieee80211_if_parse_active_links(struct ieee80211_sub_if_data *sdata,
-					       const char *buf, int buflen)
+					       char *buf, size_t buflen)
 {
 	u16 active_links;
 
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index 1e9389c49a57..6a900c671ced 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -19,27 +19,27 @@
 /* sta attributes */
 
 #define STA_READ(name, field, format_string)				\
-static ssize_t sta_ ##name## _read(struct file *file,			\
-				   char __user *userbuf,		\
-				   size_t count, loff_t *ppos)		\
+static ssize_t sta_ ##name## _read(struct kiocb *iocb,			\
+				   struct iov_iter *to)			\
 {									\
-	struct sta_info *sta = file->private_data;			\
-	return mac80211_format_buffer(userbuf, count, ppos, 		\
-				      format_string, sta->field);	\
-}
+	struct sta_info *sta = iocb->ki_filp->private_data;		\
+	return mac80211_format_buffer(iocb, to, format_string,		\
+				      sta->field);			\
+}									\
+
 #define STA_READ_D(name, field) STA_READ(name, field, "%d\n")
 
 #define STA_OPS(name)							\
 static const struct file_operations sta_ ##name## _ops = {		\
-	.read = sta_##name##_read,					\
+	.read_iter = sta_##name##_read,					\
 	.open = simple_open,						\
 	.llseek = generic_file_llseek,					\
 }
 
 #define STA_OPS_RW(name)						\
 static const struct file_operations sta_ ##name## _ops = {		\
-	.read = sta_##name##_read,					\
-	.write = sta_##name##_write,					\
+	.read_iter = sta_##name##_read,					\
+	.write_iter = sta_##name##_write,				\
 	.open = simple_open,						\
 	.llseek = generic_file_llseek,					\
 }
@@ -83,12 +83,11 @@ static const char * const sta_flag_names[] = {
 #undef FLAG
 };
 
-static ssize_t sta_flags_read(struct file *file, char __user *userbuf,
-			      size_t count, loff_t *ppos)
+static ssize_t sta_flags_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char buf[16 * NUM_WLAN_STA_FLAGS], *pos = buf;
 	char *end = buf + sizeof(buf) - 1;
-	struct sta_info *sta = file->private_data;
+	struct sta_info *sta = iocb->ki_filp->private_data;
 	unsigned int flg;
 
 	BUILD_BUG_ON(ARRAY_SIZE(sta_flag_names) != NUM_WLAN_STA_FLAGS);
@@ -99,15 +98,14 @@ static ssize_t sta_flags_read(struct file *file, char __user *userbuf,
 					 sta_flag_names[flg]);
 	}
 
-	return simple_read_from_buffer(userbuf, count, ppos, buf, strlen(buf));
+	return simple_copy_to_iter(buf, &iocb->ki_pos, strlen(buf), to);
 }
 STA_OPS(flags);
 
-static ssize_t sta_num_ps_buf_frames_read(struct file *file,
-					  char __user *userbuf,
-					  size_t count, loff_t *ppos)
+static ssize_t sta_num_ps_buf_frames_read(struct kiocb *iocb,
+					  struct iov_iter *to)
 {
-	struct sta_info *sta = file->private_data;
+	struct sta_info *sta = iocb->ki_filp->private_data;
 	char buf[17*IEEE80211_NUM_ACS], *p = buf;
 	int ac;
 
@@ -115,30 +113,28 @@ static ssize_t sta_num_ps_buf_frames_read(struct file *file,
 		p += scnprintf(p, sizeof(buf)+buf-p, "AC%d: %d\n", ac,
 			       skb_queue_len(&sta->ps_tx_buf[ac]) +
 			       skb_queue_len(&sta->tx_filtered[ac]));
-	return simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, p - buf, to);
 }
 STA_OPS(num_ps_buf_frames);
 
-static ssize_t sta_last_seq_ctrl_read(struct file *file, char __user *userbuf,
-				      size_t count, loff_t *ppos)
+static ssize_t sta_last_seq_ctrl_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char buf[15*IEEE80211_NUM_TIDS], *p = buf;
 	int i;
-	struct sta_info *sta = file->private_data;
+	struct sta_info *sta = iocb->ki_filp->private_data;
 	for (i = 0; i < IEEE80211_NUM_TIDS; i++)
 		p += scnprintf(p, sizeof(buf)+buf-p, "%x ",
 			       le16_to_cpu(sta->last_seq_ctrl[i]));
 	p += scnprintf(p, sizeof(buf)+buf-p, "\n");
-	return simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, p - buf, to);
 }
 STA_OPS(last_seq_ctrl);
 
 #define AQM_TXQ_ENTRY_LEN 130
 
-static ssize_t sta_aqm_read(struct file *file, char __user *userbuf,
-			size_t count, loff_t *ppos)
+static ssize_t sta_aqm_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct sta_info *sta = file->private_data;
+	struct sta_info *sta = iocb->ki_filp->private_data;
 	struct ieee80211_local *local = sta->local;
 	size_t bufsz = AQM_TXQ_ENTRY_LEN * (IEEE80211_NUM_TIDS + 2);
 	char *buf = kzalloc(bufsz, GFP_KERNEL), *p = buf;
@@ -189,16 +185,15 @@ static ssize_t sta_aqm_read(struct file *file, char __user *userbuf,
 	rcu_read_unlock();
 	spin_unlock_bh(&local->fq.lock);
 
-	rv = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
+	rv = simple_copy_to_iter(buf, &iocb->ki_pos, p - buf, to);
 	kfree(buf);
 	return rv;
 }
 STA_OPS(aqm);
 
-static ssize_t sta_airtime_read(struct file *file, char __user *userbuf,
-				size_t count, loff_t *ppos)
+static ssize_t sta_airtime_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct sta_info *sta = file->private_data;
+	struct sta_info *sta = iocb->ki_filp->private_data;
 	struct ieee80211_local *local = sta->sdata->local;
 	size_t bufsz = 400;
 	char *buf = kzalloc(bufsz, GFP_KERNEL), *p = buf;
@@ -224,15 +219,14 @@ static ssize_t sta_airtime_read(struct file *file, char __user *userbuf,
 		rx_airtime, tx_airtime, sta->airtime_weight,
 		deficit[0], deficit[1], deficit[2], deficit[3]);
 
-	rv = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
+	rv = simple_copy_to_iter(buf, &iocb->ki_pos, p - buf, to);
 	kfree(buf);
 	return rv;
 }
 
-static ssize_t sta_airtime_write(struct file *file, const char __user *userbuf,
-				 size_t count, loff_t *ppos)
+static ssize_t sta_airtime_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct sta_info *sta = file->private_data;
+	struct sta_info *sta = iocb->ki_filp->private_data;
 	struct ieee80211_local *local = sta->sdata->local;
 	int ac;
 
@@ -244,14 +238,13 @@ static ssize_t sta_airtime_write(struct file *file, const char __user *userbuf,
 		spin_unlock_bh(&local->active_txq_lock[ac]);
 	}
 
-	return count;
+	return iov_iter_count(from);
 }
 STA_OPS_RW(airtime);
 
-static ssize_t sta_aql_read(struct file *file, char __user *userbuf,
-				size_t count, loff_t *ppos)
+static ssize_t sta_aql_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct sta_info *sta = file->private_data;
+	struct sta_info *sta = iocb->ki_filp->private_data;
 	struct ieee80211_local *local = sta->sdata->local;
 	size_t bufsz = 400;
 	char *buf = kzalloc(bufsz, GFP_KERNEL), *p = buf;
@@ -278,22 +271,22 @@ static ssize_t sta_aql_read(struct file *file, char __user *userbuf,
 		q_limit_l[0], q_limit_h[0], q_limit_l[1], q_limit_h[1],
 		q_limit_l[2], q_limit_h[2], q_limit_l[3], q_limit_h[3]);
 
-	rv = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
+	rv = simple_copy_to_iter(buf, &iocb->ki_pos, p - buf, to);
 	kfree(buf);
 	return rv;
 }
 
-static ssize_t sta_aql_write(struct file *file, const char __user *userbuf,
-				 size_t count, loff_t *ppos)
+static ssize_t sta_aql_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct sta_info *sta = file->private_data;
+	struct sta_info *sta = iocb->ki_filp->private_data;
 	u32 ac, q_limit_l, q_limit_h;
 	char _buf[100] = {}, *buf = _buf;
+	size_t count = iov_iter_count(from);
 
 	if (count > sizeof(_buf))
 		return -EINVAL;
 
-	if (copy_from_user(buf, userbuf, count))
+	if (!copy_from_iter(buf, count, from))
 		return -EFAULT;
 
 	buf[sizeof(_buf) - 1] = '\0';
@@ -312,8 +305,8 @@ static ssize_t sta_aql_write(struct file *file, const char __user *userbuf,
 STA_OPS_RW(aql);
 
 
-static ssize_t sta_agg_status_do_read(struct wiphy *wiphy, struct file *file,
-				      char *buf, size_t bufsz, void *data)
+static ssize_t sta_agg_status_do_read(struct wiphy *wiphy, char *buf,
+				      size_t bufsz, void *data)
 {
 	struct sta_info *sta = data;
 	char *p = buf;
@@ -353,10 +346,9 @@ static ssize_t sta_agg_status_do_read(struct wiphy *wiphy, struct file *file,
 	return p - buf;
 }
 
-static ssize_t sta_agg_status_read(struct file *file, char __user *userbuf,
-				   size_t count, loff_t *ppos)
+static ssize_t sta_agg_status_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct sta_info *sta = file->private_data;
+	struct sta_info *sta = iocb->ki_filp->private_data;
 	struct wiphy *wiphy = sta->local->hw.wiphy;
 	size_t bufsz = 71 + IEEE80211_NUM_TIDS * 40;
 	char *buf = kmalloc(bufsz, GFP_KERNEL);
@@ -365,16 +357,15 @@ static ssize_t sta_agg_status_read(struct file *file, char __user *userbuf,
 	if (!buf)
 		return -ENOMEM;
 
-	ret = wiphy_locked_debugfs_read(wiphy, file, buf, bufsz,
-					userbuf, count, ppos,
-					sta_agg_status_do_read, sta);
+	ret = wiphy_locked_debugfs_read(wiphy, iocb, buf, bufsz,
+					to, sta_agg_status_do_read, sta);
 	kfree(buf);
 
 	return ret;
 }
 
-static ssize_t sta_agg_status_do_write(struct wiphy *wiphy, struct file *file,
-				       char *buf, size_t count, void *data)
+static ssize_t sta_agg_status_do_write(struct wiphy *wiphy, char *buf,
+				       size_t count, void *data)
 {
 	struct sta_info *sta = data;
 	bool start, tx;
@@ -434,43 +425,37 @@ static ssize_t sta_agg_status_do_write(struct wiphy *wiphy, struct file *file,
 	return ret ?: count;
 }
 
-static ssize_t sta_agg_status_write(struct file *file,
-				    const char __user *userbuf,
-				    size_t count, loff_t *ppos)
+static ssize_t sta_agg_status_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct sta_info *sta = file->private_data;
+	struct sta_info *sta = iocb->ki_filp->private_data;
 	struct wiphy *wiphy = sta->local->hw.wiphy;
 	char _buf[26];
 
-	return wiphy_locked_debugfs_write(wiphy, file, _buf, sizeof(_buf),
-					  userbuf, count,
-					  sta_agg_status_do_write, sta);
+	return wiphy_locked_debugfs_write(wiphy, iocb, _buf, sizeof(_buf),
+					  from, sta_agg_status_do_write, sta);
 }
 STA_OPS_RW(agg_status);
 
 /* link sta attributes */
 #define LINK_STA_OPS(name)						\
 static const struct file_operations link_sta_ ##name## _ops = {		\
-	.read = link_sta_##name##_read,					\
+	.read_iter = link_sta_##name##_read,				\
 	.open = simple_open,						\
 	.llseek = generic_file_llseek,					\
 }
 
-static ssize_t link_sta_addr_read(struct file *file, char __user *userbuf,
-				  size_t count, loff_t *ppos)
+static ssize_t link_sta_addr_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct link_sta_info *link_sta = file->private_data;
+	struct link_sta_info *link_sta = iocb->ki_filp->private_data;
 	u8 mac[3 * ETH_ALEN + 1];
 
 	snprintf(mac, sizeof(mac), "%pM\n", link_sta->pub->addr);
 
-	return simple_read_from_buffer(userbuf, count, ppos, mac, 3 * ETH_ALEN);
+	return simple_copy_to_iter(mac, &iocb->ki_pos, 3 * ETH_ALEN, to);
 }
-
 LINK_STA_OPS(addr);
 
-static ssize_t link_sta_ht_capa_read(struct file *file, char __user *userbuf,
-				     size_t count, loff_t *ppos)
+static ssize_t link_sta_ht_capa_read(struct kiocb *iocb, struct iov_iter *to)
 {
 #define PRINT_HT_CAP(_cond, _str) \
 	do { \
@@ -480,7 +465,7 @@ static ssize_t link_sta_ht_capa_read(struct file *file, char __user *userbuf,
 	char *buf, *p;
 	int i;
 	ssize_t bufsz = 512;
-	struct link_sta_info *link_sta = file->private_data;
+	struct link_sta_info *link_sta = iocb->ki_filp->private_data;
 	struct ieee80211_sta_ht_cap *htc = &link_sta->pub->ht_cap;
 	ssize_t ret;
 
@@ -554,17 +539,16 @@ static ssize_t link_sta_ht_capa_read(struct file *file, char __user *userbuf,
 				htc->mcs.tx_params);
 	}
 
-	ret = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, p - buf, to);
 	kfree(buf);
 	return ret;
 }
 LINK_STA_OPS(ht_capa);
 
-static ssize_t link_sta_vht_capa_read(struct file *file, char __user *userbuf,
-				      size_t count, loff_t *ppos)
+static ssize_t link_sta_vht_capa_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char *buf, *p;
-	struct link_sta_info *link_sta = file->private_data;
+	struct link_sta_info *link_sta = iocb->ki_filp->private_data;
 	struct ieee80211_sta_vht_cap *vhtc = &link_sta->pub->vht_cap;
 	ssize_t ret;
 	ssize_t bufsz = 512;
@@ -668,18 +652,17 @@ static ssize_t link_sta_vht_capa_read(struct file *file, char __user *userbuf,
 #undef PFLAG
 	}
 
-	ret = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, p - buf, to);
 	kfree(buf);
 	return ret;
 }
 LINK_STA_OPS(vht_capa);
 
-static ssize_t link_sta_he_capa_read(struct file *file, char __user *userbuf,
-				     size_t count, loff_t *ppos)
+static ssize_t link_sta_he_capa_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char *buf, *p;
 	size_t buf_sz = PAGE_SIZE;
-	struct link_sta_info *link_sta = file->private_data;
+	struct link_sta_info *link_sta = iocb->ki_filp->private_data;
 	struct ieee80211_sta_he_cap *hec = &link_sta->pub->he_cap;
 	struct ieee80211_he_mcs_nss_supp *nss = &hec->he_mcs_nss_supp;
 	u8 ppe_size;
@@ -1041,18 +1024,17 @@ static ssize_t link_sta_he_capa_read(struct file *file, char __user *userbuf,
 	p += scnprintf(p, buf_sz + buf - p, "\n");
 
 out:
-	ret = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, p - buf, to);
 	kfree(buf);
 	return ret;
 }
 LINK_STA_OPS(he_capa);
 
-static ssize_t link_sta_eht_capa_read(struct file *file, char __user *userbuf,
-				      size_t count, loff_t *ppos)
+static ssize_t link_sta_eht_capa_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char *buf, *p;
 	size_t buf_sz = PAGE_SIZE;
-	struct link_sta_info *link_sta = file->private_data;
+	struct link_sta_info *link_sta = iocb->ki_filp->private_data;
 	struct ieee80211_sta_eht_cap *bec = &link_sta->pub->eht_cap;
 	struct ieee80211_eht_cap_elem_fixed *fixed = &bec->eht_cap_elem;
 	struct ieee80211_eht_mcs_nss_supp *nss = &bec->eht_mcs_nss_supp;
@@ -1225,7 +1207,7 @@ static ssize_t link_sta_eht_capa_read(struct file *file, char __user *userbuf,
 	}
 
 out:
-	ret = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, p - buf, to);
 	kfree(buf);
 	return ret;
 }
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index 23404b275457..d8715afa8a6a 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -219,18 +219,16 @@ ieee80211_rate_control_ops_get(const char *name)
 }
 
 #ifdef CONFIG_MAC80211_DEBUGFS
-static ssize_t rcname_read(struct file *file, char __user *userbuf,
-			   size_t count, loff_t *ppos)
+static ssize_t rcname_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct rate_control_ref *ref = file->private_data;
+	struct rate_control_ref *ref = iocb->ki_filp->private_data;
 	int len = strlen(ref->ops->name);
 
-	return simple_read_from_buffer(userbuf, count, ppos,
-				       ref->ops->name, len);
+	return simple_copy_to_iter(ref->ops->name, &iocb->ki_pos, len, to);
 }
 
 const struct file_operations rcname_ops = {
-	.read = rcname_read,
+	.read_iter = rcname_read,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
diff --git a/net/mac80211/rc80211_minstrel_ht_debugfs.c b/net/mac80211/rc80211_minstrel_ht_debugfs.c
index 25b8a67a63a4..426c63e4e475 100644
--- a/net/mac80211/rc80211_minstrel_ht_debugfs.c
+++ b/net/mac80211/rc80211_minstrel_ht_debugfs.c
@@ -16,13 +16,12 @@ struct minstrel_debugfs_info {
 	char buf[];
 };
 
-static ssize_t
-minstrel_stats_read(struct file *file, char __user *buf, size_t len, loff_t *ppos)
+static ssize_t minstrel_stats_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct minstrel_debugfs_info *ms;
 
-	ms = file->private_data;
-	return simple_read_from_buffer(buf, len, ppos, ms->buf, ms->len);
+	ms = iocb->ki_filp->private_data;
+	return simple_copy_to_iter(ms->buf, &iocb->ki_pos, ms->len, to);
 }
 
 static int
@@ -185,7 +184,7 @@ minstrel_ht_stats_open(struct inode *inode, struct file *file)
 static const struct file_operations minstrel_ht_stat_fops = {
 	.owner = THIS_MODULE,
 	.open = minstrel_ht_stats_open,
-	.read = minstrel_stats_read,
+	.read_iter = minstrel_stats_read,
 	.release = minstrel_stats_release,
 	.llseek = no_llseek,
 };
@@ -321,7 +320,7 @@ minstrel_ht_stats_csv_open(struct inode *inode, struct file *file)
 static const struct file_operations minstrel_ht_stat_csv_fops = {
 	.owner = THIS_MODULE,
 	.open = minstrel_ht_stats_csv_open,
-	.read = minstrel_stats_read,
+	.read_iter = minstrel_stats_read,
 	.release = minstrel_stats_release,
 	.llseek = no_llseek,
 };
diff --git a/net/wireless/debugfs.c b/net/wireless/debugfs.c
index 40e49074e2ee..fd4509acec37 100644
--- a/net/wireless/debugfs.c
+++ b/net/wireless/debugfs.c
@@ -114,12 +114,10 @@ void cfg80211_debugfs_rdev_add(struct cfg80211_registered_device *rdev)
 struct debugfs_read_work {
 	struct wiphy_work work;
 	ssize_t (*handler)(struct wiphy *wiphy,
-			   struct file *file,
 			   char *buf,
 			   size_t count,
 			   void *data);
 	struct wiphy *wiphy;
-	struct file *file;
 	char *buf;
 	size_t bufsize;
 	void *data;
@@ -132,7 +130,7 @@ static void wiphy_locked_debugfs_read_work(struct wiphy *wiphy,
 {
 	struct debugfs_read_work *w = container_of(work, typeof(*w), work);
 
-	w->ret = w->handler(w->wiphy, w->file, w->buf, w->bufsize, w->data);
+	w->ret = w->handler(w->wiphy, w->buf, w->bufsize, w->data);
 	complete(&w->completion);
 }
 
@@ -145,12 +143,10 @@ static void wiphy_locked_debugfs_read_cancel(struct dentry *dentry,
 	complete(&w->completion);
 }
 
-ssize_t wiphy_locked_debugfs_read(struct wiphy *wiphy, struct file *file,
+ssize_t wiphy_locked_debugfs_read(struct wiphy *wiphy, struct kiocb *iocb,
 				  char *buf, size_t bufsize,
-				  char __user *userbuf, size_t count,
-				  loff_t *ppos,
+				  struct iov_iter *to,
 				  ssize_t (*handler)(struct wiphy *wiphy,
-						     struct file *file,
 						     char *buf,
 						     size_t bufsize,
 						     void *data),
@@ -159,7 +155,6 @@ ssize_t wiphy_locked_debugfs_read(struct wiphy *wiphy, struct file *file,
 	struct debugfs_read_work work = {
 		.handler = handler,
 		.wiphy = wiphy,
-		.file = file,
 		.buf = buf,
 		.bufsize = bufsize,
 		.data = data,
@@ -177,9 +172,9 @@ ssize_t wiphy_locked_debugfs_read(struct wiphy *wiphy, struct file *file,
 	wiphy_work_init(&work.work, wiphy_locked_debugfs_read_work);
 	wiphy_work_queue(wiphy, &work.work);
 
-	debugfs_enter_cancellation(file, &cancellation);
+	debugfs_enter_cancellation(iocb->ki_filp, &cancellation);
 	wait_for_completion(&work.completion);
-	debugfs_leave_cancellation(file, &cancellation);
+	debugfs_leave_cancellation(iocb->ki_filp, &cancellation);
 
 	if (work.ret < 0)
 		return work.ret;
@@ -187,19 +182,17 @@ ssize_t wiphy_locked_debugfs_read(struct wiphy *wiphy, struct file *file,
 	if (WARN_ON(work.ret > bufsize))
 		return -EINVAL;
 
-	return simple_read_from_buffer(userbuf, count, ppos, buf, work.ret);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, work.ret, to);
 }
 EXPORT_SYMBOL_GPL(wiphy_locked_debugfs_read);
 
 struct debugfs_write_work {
 	struct wiphy_work work;
 	ssize_t (*handler)(struct wiphy *wiphy,
-			   struct file *file,
 			   char *buf,
 			   size_t count,
 			   void *data);
 	struct wiphy *wiphy;
-	struct file *file;
 	char *buf;
 	size_t count;
 	void *data;
@@ -212,7 +205,7 @@ static void wiphy_locked_debugfs_write_work(struct wiphy *wiphy,
 {
 	struct debugfs_write_work *w = container_of(work, typeof(*w), work);
 
-	w->ret = w->handler(w->wiphy, w->file, w->buf, w->count, w->data);
+	w->ret = w->handler(w->wiphy, w->buf, w->count, w->data);
 	complete(&w->completion);
 }
 
@@ -226,10 +219,9 @@ static void wiphy_locked_debugfs_write_cancel(struct dentry *dentry,
 }
 
 ssize_t wiphy_locked_debugfs_write(struct wiphy *wiphy,
-				   struct file *file, char *buf, size_t bufsize,
-				   const char __user *userbuf, size_t count,
+				   struct kiocb *iocb, char *buf, size_t bufsize,
+				   struct iov_iter *from,
 				   ssize_t (*handler)(struct wiphy *wiphy,
-						      struct file *file,
 						      char *buf,
 						      size_t count,
 						      void *data),
@@ -238,9 +230,8 @@ ssize_t wiphy_locked_debugfs_write(struct wiphy *wiphy,
 	struct debugfs_write_work work = {
 		.handler = handler,
 		.wiphy = wiphy,
-		.file = file,
 		.buf = buf,
-		.count = count,
+		.count = bufsize,
 		.data = data,
 		.ret = -ENODEV,
 		.completion = COMPLETION_INITIALIZER_ONSTACK(work.completion),
@@ -249,6 +240,7 @@ ssize_t wiphy_locked_debugfs_write(struct wiphy *wiphy,
 		.cancel = wiphy_locked_debugfs_write_cancel,
 		.cancel_data = &work,
 	};
+	size_t count = iov_iter_count(from);
 
 	/* mostly used for strings so enforce NUL-termination for safety */
 	if (count >= bufsize)
@@ -256,15 +248,15 @@ ssize_t wiphy_locked_debugfs_write(struct wiphy *wiphy,
 
 	memset(buf, 0, bufsize);
 
-	if (copy_from_user(buf, userbuf, count))
+	if (!copy_from_iter_full(buf, count, from))
 		return -EFAULT;
 
 	wiphy_work_init(&work.work, wiphy_locked_debugfs_write_work);
 	wiphy_work_queue(wiphy, &work.work);
 
-	debugfs_enter_cancellation(file, &cancellation);
+	debugfs_enter_cancellation(iocb->ki_filp, &cancellation);
 	wait_for_completion(&work.completion);
-	debugfs_leave_cancellation(file, &cancellation);
+	debugfs_leave_cancellation(iocb->ki_filp, &cancellation);
 
 	return work.ret;
 }
-- 
2.43.0


