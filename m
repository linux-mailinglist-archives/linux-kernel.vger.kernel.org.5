Return-Path: <linux-kernel+bounces-140819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC758A1918
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B62AA281C95
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B91C82888;
	Thu, 11 Apr 2024 15:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zLLbkRg1"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD53981742
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849606; cv=none; b=ctvmHv53ATGGc6ZWPBnwEsOWnYQSsG6MLu/fS2TSsqfOifn0VEUYrMJFIMg3Jm/aFAeGyyle7/cANqgipPMgigdnagD6SiklAuFo9LNmOTpx95vwnilr2F76s7ku7TSiYROWjmfMJaI/PcV+fF9yVRaiI2j7tJLH0DbGr5NI1r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849606; c=relaxed/simple;
	bh=iwJvlrqfYyUElK/l05+RCD+xKYQOcPZF5kLYGwpTsm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8F8xDYCixueYZx/5GGmyaBPIocqyS5Okaz8ku/f4ivlYw99sXCHVzqpt90PRutyU7NXsYdrHzKn+S+QzjFNJwZqp3G9ngmT9iK0HO/YyThsWun/SqJz5Fu6jip2aj9nDQMOV1eqMHj10wGV6m3Mi9okDEe7UCNX8byI826DrT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zLLbkRg1; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso57975439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849603; x=1713454403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncOUPP3alKNpnXNjXBkDsVRyy/frtxN9Tt0itgJwxuk=;
        b=zLLbkRg1RPLzSav1edITY/sncKsck8lY3yLbxGSrPTYJHp8bXtg4A+HScfZI/6mudE
         lgFti6lLy9/Rvj+0pa+VyejGoiad3XKM6QCEKwpmZyCGAt2o3kJ2cmWZfVH2Lu9aUGev
         RzKy+TOpq/DUh76RzzQyl2gyEC6FfFfDU9sISNOdMY+Rdc6eQy4NG+ehY5dsyBzvb4Zc
         7Ims9ID+Ky860ItoUMDYlkMv8Aq8rTR6yS/apJyZoZiGEzxfRoqwunh2h46Oer9oN3gs
         ew4ZE3mThXqnMp8/d3ldDP6XXpmHLLMjuXiO2Z6n0zkRYf2aUGNbH3sOFEV1HTLc4ub2
         zu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849603; x=1713454403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncOUPP3alKNpnXNjXBkDsVRyy/frtxN9Tt0itgJwxuk=;
        b=Os0bAkEvkoMiNF+tJvvbhjoosmjaQCq0f2MZZZzrKFGCRLvccaHxdvDJkgkB57qxga
         6aUXodIb3YdFfIRTJGeNIgd4KCPkFSBJGfJXTd8v/wcBKlkjUckzhO5mPLWnM9tMzBAF
         c1kipS6arsvWmPUQWmmfVNz46sMkUz1038MyJD4Mdmjjvw1TiJfzNAxCLsW09fCpv1Wm
         Y8as8mGUl4v1XtwwFeGeKCYUtmIZyePkv1/ImvNt19yFaSAkft0K3QWzNayLs7ZwnCci
         sF3q865BKRi8elYa4ukw5uyVgvWXZfzEeoNT+3mzcLj7oGYfRrHFZT+Yva4HpYKZKGb8
         JsIQ==
X-Gm-Message-State: AOJu0Yx5arWttOlWZgLTpRi8H/NssuPer05EfoU0tJ0jhEXBcHw1/Vf5
	tLIn7XNupwhhY62v+p/F6/+CohTzRe0QQmdVXPg7yVZtVY+Czy7zoW2es3Fx9S2qkycjyRaUipZ
	L
X-Google-Smtp-Source: AGHT+IGXXPq0beTj7z85DNrIcZxrSl0GARQzfLnSa0pJq/aVZtxHQswIpLq/iMqwuCoGlDNJ4/N/+g==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr152530ioh.1.1712849602983;
        Thu, 11 Apr 2024 08:33:22 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:33:21 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 059/437] ALSA: core: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:19 -0600
Message-ID: <20240411153126.16201-60-axboe@kernel.dk>
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
 sound/core/compress_offload.c  |  7 +--
 sound/core/control.c           | 14 +++---
 sound/core/hwdep.c             |  6 ++-
 sound/core/init.c              | 10 ++--
 sound/core/jack.c              | 83 ++++++++++++++--------------------
 sound/core/oss/pcm_oss.c       |  6 ++-
 sound/core/pcm_native.c        | 22 +++++++--
 sound/core/rawmidi.c           |  6 ++-
 sound/core/seq/oss/seq_oss.c   | 11 +++--
 sound/core/seq/seq_clientmgr.c |  8 ++--
 sound/core/timer.c             | 23 +++++-----
 11 files changed, 100 insertions(+), 96 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index f0008fa2d839..3d2df5eda81b 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -322,7 +322,7 @@ static ssize_t snd_compr_write(struct file *f, const char __user *buf,
 
 	return retval;
 }
-
+FOPS_WRITE_ITER_HELPER(snd_compr_write);
 
 static ssize_t snd_compr_read(struct file *f, char __user *buf,
 		size_t count, loff_t *offset)
@@ -367,6 +367,7 @@ static ssize_t snd_compr_read(struct file *f, char __user *buf,
 
 	return retval;
 }
+FOPS_READ_ITER_HELPER(snd_compr_read);
 
 static int snd_compr_mmap(struct file *f, struct vm_area_struct *vma)
 {
@@ -1004,8 +1005,8 @@ static const struct file_operations snd_compr_file_ops = {
 		.owner =	THIS_MODULE,
 		.open =		snd_compr_open,
 		.release =	snd_compr_free,
-		.write =	snd_compr_write,
-		.read =		snd_compr_read,
+		.write_iter =	snd_compr_write_iter,
+		.read_iter =	snd_compr_read_iter,
 		.unlocked_ioctl = snd_compr_ioctl,
 #ifdef CONFIG_COMPAT
 		.compat_ioctl = snd_compr_ioctl_compat,
diff --git a/sound/core/control.c b/sound/core/control.c
index fb0c60044f7b..1faa740c5ec4 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1985,14 +1985,14 @@ static long snd_ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg
 	return -ENOTTY;
 }
 
-static ssize_t snd_ctl_read(struct file *file, char __user *buffer,
-			    size_t count, loff_t * offset)
+static ssize_t snd_ctl_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	size_t count = iov_iter_count(to);
 	struct snd_ctl_file *ctl;
 	int err = 0;
 	ssize_t result = 0;
 
-	ctl = file->private_data;
+	ctl = iocb->ki_filp->private_data;
 	if (snd_BUG_ON(!ctl || !ctl->card))
 		return -ENXIO;
 	if (!ctl->subscribed)
@@ -2005,7 +2005,8 @@ static ssize_t snd_ctl_read(struct file *file, char __user *buffer,
 		struct snd_kctl_event *kev;
 		while (list_empty(&ctl->events)) {
 			wait_queue_entry_t wait;
-			if ((file->f_flags & O_NONBLOCK) != 0 || result > 0) {
+			if ((iocb->ki_filp->f_flags & O_NONBLOCK) != 0 ||
+			    result > 0) {
 				err = -EAGAIN;
 				goto __end_lock;
 			}
@@ -2028,12 +2029,11 @@ static ssize_t snd_ctl_read(struct file *file, char __user *buffer,
 		list_del(&kev->list);
 		spin_unlock_irq(&ctl->read_lock);
 		kfree(kev);
-		if (copy_to_user(buffer, &ev, sizeof(struct snd_ctl_event))) {
+		if (!copy_to_iter_full(&ev, sizeof(struct snd_ctl_event), to)) {
 			err = -EFAULT;
 			goto __end;
 		}
 		spin_lock_irq(&ctl->read_lock);
-		buffer += sizeof(struct snd_ctl_event);
 		count -= sizeof(struct snd_ctl_event);
 		result += sizeof(struct snd_ctl_event);
 	}
@@ -2277,7 +2277,7 @@ EXPORT_SYMBOL_GPL(snd_ctl_disconnect_layer);
 static const struct file_operations snd_ctl_f_ops =
 {
 	.owner =	THIS_MODULE,
-	.read =		snd_ctl_read,
+	.read_iter =	snd_ctl_read,
 	.open =		snd_ctl_open,
 	.release =	snd_ctl_release,
 	.llseek =	no_llseek,
diff --git a/sound/core/hwdep.c b/sound/core/hwdep.c
index 09200df2932c..3db085c2ec6e 100644
--- a/sound/core/hwdep.c
+++ b/sound/core/hwdep.c
@@ -55,6 +55,7 @@ static ssize_t snd_hwdep_read(struct file * file, char __user *buf,
 		return hw->ops.read(hw, buf, count, offset);
 	return -ENXIO;	
 }
+FOPS_READ_ITER_HELPER(snd_hwdep_read);
 
 static ssize_t snd_hwdep_write(struct file * file, const char __user *buf,
 			       size_t count, loff_t *offset)
@@ -64,6 +65,7 @@ static ssize_t snd_hwdep_write(struct file * file, const char __user *buf,
 		return hw->ops.write(hw, buf, count, offset);
 	return -ENXIO;	
 }
+FOPS_WRITE_ITER_HELPER(snd_hwdep_write);
 
 static int snd_hwdep_open(struct inode *inode, struct file * file)
 {
@@ -327,8 +329,8 @@ static const struct file_operations snd_hwdep_f_ops =
 {
 	.owner = 	THIS_MODULE,
 	.llseek =	snd_hwdep_llseek,
-	.read = 	snd_hwdep_read,
-	.write =	snd_hwdep_write,
+	.read_iter = 	snd_hwdep_read_iter,
+	.write_iter =	snd_hwdep_write_iter,
 	.open =		snd_hwdep_open,
 	.release =	snd_hwdep_release,
 	.poll =		snd_hwdep_poll,
diff --git a/sound/core/init.c b/sound/core/init.c
index 4ed5037d8693..d2045533e33d 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -407,14 +407,12 @@ static loff_t snd_disconnect_llseek(struct file *file, loff_t offset, int orig)
 	return -ENODEV;
 }
 
-static ssize_t snd_disconnect_read(struct file *file, char __user *buf,
-				   size_t count, loff_t *offset)
+static ssize_t snd_disconnect_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	return -ENODEV;
 }
 
-static ssize_t snd_disconnect_write(struct file *file, const char __user *buf,
-				    size_t count, loff_t *offset)
+static ssize_t snd_disconnect_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	return -ENODEV;
 }
@@ -467,8 +465,8 @@ static const struct file_operations snd_shutdown_f_ops =
 {
 	.owner = 	THIS_MODULE,
 	.llseek =	snd_disconnect_llseek,
-	.read = 	snd_disconnect_read,
-	.write =	snd_disconnect_write,
+	.read_iter = 	snd_disconnect_read,
+	.write_iter =	snd_disconnect_write,
 	.release =	snd_disconnect_release,
 	.poll =		snd_disconnect_poll,
 	.unlocked_ioctl = snd_disconnect_ioctl,
diff --git a/sound/core/jack.c b/sound/core/jack.c
index e08b2c4fbd1a..d7a0a26389ca 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -161,29 +161,25 @@ static void snd_jack_inject_report(struct snd_jack_kctl *jack_kctl, int status)
 #endif /* CONFIG_SND_JACK_INPUT_DEV */
 }
 
-static ssize_t sw_inject_enable_read(struct file *file,
-				     char __user *to, size_t count, loff_t *ppos)
+static ssize_t sw_inject_enable_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct snd_jack_kctl *jack_kctl = file->private_data;
-	int len, ret;
+	struct snd_jack_kctl *jack_kctl = iocb->ki_filp->private_data;
 	char buf[128];
+	int len;
 
 	len = scnprintf(buf, sizeof(buf), "%s: %s\t\t%s: %i\n", "Jack", jack_kctl->kctl->id.name,
 			"Inject Enabled", jack_kctl->sw_inject_enable);
-	ret = simple_read_from_buffer(to, count, ppos, buf, len);
-
-	return ret;
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t sw_inject_enable_write(struct file *file,
-				      const char __user *from, size_t count, loff_t *ppos)
+static ssize_t sw_inject_enable_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct snd_jack_kctl *jack_kctl = file->private_data;
+	struct snd_jack_kctl *jack_kctl = iocb->ki_filp->private_data;
 	int ret, err;
 	unsigned long enable;
 	char buf[8] = { 0 };
 
-	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, from, count);
+	ret = simple_copy_from_iter(buf, &iocb->ki_pos, sizeof(buf) - 1, from);
 	err = kstrtoul(buf, 0, &enable);
 	if (err)
 		return err;
@@ -199,10 +195,9 @@ static ssize_t sw_inject_enable_write(struct file *file,
 	return ret;
 }
 
-static ssize_t jackin_inject_write(struct file *file,
-				   const char __user *from, size_t count, loff_t *ppos)
+static ssize_t jackin_inject_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct snd_jack_kctl *jack_kctl = file->private_data;
+	struct snd_jack_kctl *jack_kctl = iocb->ki_filp->private_data;
 	int ret, err;
 	unsigned long enable;
 	char buf[8] = { 0 };
@@ -210,7 +205,7 @@ static ssize_t jackin_inject_write(struct file *file,
 	if (!jack_kctl->sw_inject_enable)
 		return -EINVAL;
 
-	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, from, count);
+	ret = simple_copy_from_iter(buf, &iocb->ki_pos, sizeof(buf) - 1, from);
 	err = kstrtoul(buf, 0, &enable);
 	if (err)
 		return err;
@@ -220,17 +215,14 @@ static ssize_t jackin_inject_write(struct file *file,
 	return ret;
 }
 
-static ssize_t jack_kctl_id_read(struct file *file,
-				 char __user *to, size_t count, loff_t *ppos)
+static ssize_t jack_kctl_id_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct snd_jack_kctl *jack_kctl = file->private_data;
+	struct snd_jack_kctl *jack_kctl = iocb->ki_filp->private_data;
 	char buf[64];
-	int len, ret;
+	int len;
 
 	len = scnprintf(buf, sizeof(buf), "%s\n", jack_kctl->kctl->id.name);
-	ret = simple_read_from_buffer(to, count, ppos, buf, len);
-
-	return ret;
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 /* the bit definition is aligned with snd_jack_types in jack.h */
@@ -258,82 +250,73 @@ static int parse_mask_bits(unsigned int mask_bits, char *buf, size_t buf_size)
 	return strlen(buf);
 }
 
-static ssize_t jack_kctl_mask_bits_read(struct file *file,
-					char __user *to, size_t count, loff_t *ppos)
+static ssize_t jack_kctl_mask_bits_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct snd_jack_kctl *jack_kctl = file->private_data;
+	struct snd_jack_kctl *jack_kctl = iocb->ki_filp->private_data;
 	char buf[256];
-	int len, ret;
+	int len;
 
 	len = parse_mask_bits(jack_kctl->mask_bits, buf, sizeof(buf));
-	ret = simple_read_from_buffer(to, count, ppos, buf, len);
-
-	return ret;
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t jack_kctl_status_read(struct file *file,
-				     char __user *to, size_t count, loff_t *ppos)
+static ssize_t jack_kctl_status_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct snd_jack_kctl *jack_kctl = file->private_data;
+	struct snd_jack_kctl *jack_kctl = iocb->ki_filp->private_data;
 	char buf[16];
-	int len, ret;
+	int len;
 
 	len = scnprintf(buf, sizeof(buf), "%s\n", jack_kctl->kctl->private_value ?
 			"Plugged" : "Unplugged");
-	ret = simple_read_from_buffer(to, count, ppos, buf, len);
-
-	return ret;
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 #ifdef CONFIG_SND_JACK_INPUT_DEV
-static ssize_t jack_type_read(struct file *file,
-			      char __user *to, size_t count, loff_t *ppos)
+static ssize_t jack_type_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct snd_jack_kctl *jack_kctl = file->private_data;
+	struct snd_jack_kctl *jack_kctl = iocb->ki_filp->private_data;
 	char buf[256];
-	int len, ret;
+	int len;
 
 	len = parse_mask_bits(jack_kctl->jack->type, buf, sizeof(buf));
-	ret = simple_read_from_buffer(to, count, ppos, buf, len);
-
-	return ret;
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations jack_type_fops = {
 	.open = simple_open,
-	.read = jack_type_read,
+	.read_iter = jack_type_read,
 	.llseek = default_llseek,
 };
 #endif
 
 static const struct file_operations sw_inject_enable_fops = {
 	.open = simple_open,
-	.read = sw_inject_enable_read,
-	.write = sw_inject_enable_write,
+	.read_iter = sw_inject_enable_read,
+	.write_iter = sw_inject_enable_write,
 	.llseek = default_llseek,
 };
 
 static const struct file_operations jackin_inject_fops = {
 	.open = simple_open,
-	.write = jackin_inject_write,
+	.write_iter = jackin_inject_write,
 	.llseek = default_llseek,
 };
 
 static const struct file_operations jack_kctl_id_fops = {
 	.open = simple_open,
-	.read = jack_kctl_id_read,
+	.read_iter = jack_kctl_id_read,
 	.llseek = default_llseek,
 };
 
 static const struct file_operations jack_kctl_mask_bits_fops = {
 	.open = simple_open,
-	.read = jack_kctl_mask_bits_read,
+	.read_iter = jack_kctl_mask_bits_read,
 	.llseek = default_llseek,
 };
 
 static const struct file_operations jack_kctl_status_fops = {
 	.open = simple_open,
-	.read = jack_kctl_status_read,
+	.read_iter = jack_kctl_status_read,
 	.llseek = default_llseek,
 };
 
diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index 7386982cf40e..40a51f9743ea 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -2781,6 +2781,7 @@ static ssize_t snd_pcm_oss_read(struct file *file, char __user *buf, size_t coun
 	}
 #endif
 }
+FOPS_READ_ITER_HELPER(snd_pcm_oss_read);
 
 static ssize_t snd_pcm_oss_write(struct file *file, const char __user *buf, size_t count, loff_t *offset)
 {
@@ -2800,6 +2801,7 @@ static ssize_t snd_pcm_oss_write(struct file *file, const char __user *buf, size
 #endif
 	return result;
 }
+FOPS_WRITE_ITER_HELPER(snd_pcm_oss_write);
 
 static int snd_pcm_oss_playback_ready(struct snd_pcm_substream *substream)
 {
@@ -3102,8 +3104,8 @@ static inline void snd_pcm_oss_proc_done(struct snd_pcm *pcm)
 static const struct file_operations snd_pcm_oss_f_reg =
 {
 	.owner =	THIS_MODULE,
-	.read =		snd_pcm_oss_read,
-	.write =	snd_pcm_oss_write,
+	.read_iter =	snd_pcm_oss_read_iter,
+	.write_iter =	snd_pcm_oss_write_iter,
 	.open =		snd_pcm_oss_open,
 	.release =	snd_pcm_oss_release,
 	.llseek =	no_llseek,
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 0b76e76823d2..a3278321bcb0 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3577,6 +3577,22 @@ static ssize_t snd_pcm_writev(struct kiocb *iocb, struct iov_iter *from)
 	return result;
 }
 
+static ssize_t snd_pcm_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	if (!(iocb->ki_flags & IOCB_VECTORED))
+		return vfs_read_iter(iocb, to, snd_pcm_read);
+
+	return snd_pcm_readv(iocb, to);
+}
+
+static ssize_t snd_pcm_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	if (!(iocb->ki_flags & IOCB_VECTORED))
+		return vfs_write_iter(iocb, from, snd_pcm_write);
+
+	return snd_pcm_writev(iocb, from);
+}
+
 static __poll_t snd_pcm_poll(struct file *file, poll_table *wait)
 {
 	struct snd_pcm_file *pcm_file;
@@ -4099,8 +4115,7 @@ static unsigned long snd_pcm_get_unmapped_area(struct file *file,
 const struct file_operations snd_pcm_f_ops[2] = {
 	{
 		.owner =		THIS_MODULE,
-		.write =		snd_pcm_write,
-		.write_iter =		snd_pcm_writev,
+		.write_iter =		snd_pcm_write_iter,
 		.open =			snd_pcm_playback_open,
 		.release =		snd_pcm_release,
 		.llseek =		no_llseek,
@@ -4113,8 +4128,7 @@ const struct file_operations snd_pcm_f_ops[2] = {
 	},
 	{
 		.owner =		THIS_MODULE,
-		.read =			snd_pcm_read,
-		.read_iter =		snd_pcm_readv,
+		.read_iter =		snd_pcm_read_iter,
 		.open =			snd_pcm_capture_open,
 		.release =		snd_pcm_release,
 		.llseek =		no_llseek,
diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index 7accf9a1ddf4..37590a2f447e 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -1316,6 +1316,7 @@ static ssize_t snd_rawmidi_read(struct file *file, char __user *buf, size_t coun
 	}
 	return result;
 }
+FOPS_READ_ITER_HELPER(snd_rawmidi_read);
 
 /**
  * snd_rawmidi_transmit_empty - check whether the output buffer is empty
@@ -1652,6 +1653,7 @@ static ssize_t snd_rawmidi_write(struct file *file, const char __user *buf,
 	}
 	return result;
 }
+FOPS_WRITE_ITER_HELPER(snd_rawmidi_write);
 
 static __poll_t snd_rawmidi_poll(struct file *file, poll_table *wait)
 {
@@ -1780,8 +1782,8 @@ static void snd_rawmidi_proc_info_read(struct snd_info_entry *entry,
 
 static const struct file_operations snd_rawmidi_f_ops = {
 	.owner =	THIS_MODULE,
-	.read =		snd_rawmidi_read,
-	.write =	snd_rawmidi_write,
+	.read_iter =	snd_rawmidi_read_iter,
+	.write_iter =	snd_rawmidi_write_iter,
 	.open =		snd_rawmidi_open,
 	.release =	snd_rawmidi_release,
 	.llseek =	no_llseek,
diff --git a/sound/core/seq/oss/seq_oss.c b/sound/core/seq/oss/seq_oss.c
index 77c1214acd90..6bc9454c83e9 100644
--- a/sound/core/seq/oss/seq_oss.c
+++ b/sound/core/seq/oss/seq_oss.c
@@ -43,8 +43,8 @@ static inline void unregister_proc(void) {}
 
 static int odev_open(struct inode *inode, struct file *file);
 static int odev_release(struct inode *inode, struct file *file);
-static ssize_t odev_read(struct file *file, char __user *buf, size_t count, loff_t *offset);
-static ssize_t odev_write(struct file *file, const char __user *buf, size_t count, loff_t *offset);
+static ssize_t odev_read_iter(struct kiocb *iocb, struct iov_iter *to);
+static ssize_t odev_write_iter(struct kiocb *iocb, struct iov_iter *from);
 static long odev_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 static __poll_t odev_poll(struct file *file, poll_table * wait);
 
@@ -156,7 +156,7 @@ odev_read(struct file *file, char __user *buf, size_t count, loff_t *offset)
 		return -ENXIO;
 	return snd_seq_oss_read(dp, buf, count);
 }
-
+FOPS_READ_ITER_HELPER(odev_read);
 
 static ssize_t
 odev_write(struct file *file, const char __user *buf, size_t count, loff_t *offset)
@@ -167,6 +167,7 @@ odev_write(struct file *file, const char __user *buf, size_t count, loff_t *offs
 		return -ENXIO;
 	return snd_seq_oss_write(dp, buf, count, file);
 }
+FOPS_WRITE_ITER_HELPER(odev_write);
 
 static long
 odev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
@@ -214,8 +215,8 @@ odev_poll(struct file *file, poll_table * wait)
 static const struct file_operations seq_oss_f_ops =
 {
 	.owner =	THIS_MODULE,
-	.read =		odev_read,
-	.write =	odev_write,
+	.read_iter =	odev_read_iter,
+	.write_iter =	odev_write_iter,
 	.open =		odev_open,
 	.release =	odev_release,
 	.poll =		odev_poll,
diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 42a705141050..8945d2b0a16f 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -511,7 +511,7 @@ static ssize_t snd_seq_read(struct file *file, char __user *buf, size_t count,
 
 	return (err < 0) ? err : result;
 }
-
+FOPS_READ_ITER_HELPER(snd_seq_read);
 
 /*
  * check access permission to the port
@@ -1107,7 +1107,7 @@ static ssize_t snd_seq_write(struct file *file, const char __user *buf,
 	mutex_unlock(&client->ioctl_mutex);
 	return written ? written : err;
 }
-
+FOPS_WRITE_ITER_HELPER(snd_seq_write);
 
 /*
  * handle polling
@@ -2711,8 +2711,8 @@ void snd_seq_info_clients_read(struct snd_info_entry *entry,
 static const struct file_operations snd_seq_f_ops =
 {
 	.owner =	THIS_MODULE,
-	.read =		snd_seq_read,
-	.write =	snd_seq_write,
+	.read_iter =	snd_seq_read_iter,
+	.write_iter =	snd_seq_write_iter,
 	.open =		snd_seq_open,
 	.release =	snd_seq_release,
 	.llseek =	no_llseek,
diff --git a/sound/core/timer.c b/sound/core/timer.c
index 4d2ee99c12a3..9727e2db3eec 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -2066,9 +2066,9 @@ static int snd_timer_user_fasync(int fd, struct file * file, int on)
 	return snd_fasync_helper(fd, file, on, &tu->fasync);
 }
 
-static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
-				   size_t count, loff_t *offset)
+static ssize_t snd_timer_user_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	size_t count = iov_iter_count(to);
 	struct snd_timer_tread64 *tread;
 	struct snd_timer_tread32 tread32;
 	struct snd_timer_user *tu;
@@ -2076,7 +2076,7 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
 	int qhead;
 	int err = 0;
 
-	tu = file->private_data;
+	tu = iocb->ki_filp->private_data;
 	switch (tu->tread) {
 	case TREAD_FORMAT_TIME64:
 		unit = sizeof(struct snd_timer_tread64);
@@ -2098,7 +2098,8 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
 		while (!tu->qused) {
 			wait_queue_entry_t wait;
 
-			if ((file->f_flags & O_NONBLOCK) != 0 || result > 0) {
+			if ((iocb->ki_filp->f_flags & O_NONBLOCK) != 0 ||
+			     result > 0) {
 				err = -EAGAIN;
 				goto _error;
 			}
@@ -2134,8 +2135,9 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
 
 		switch (tu->tread) {
 		case TREAD_FORMAT_TIME64:
-			if (copy_to_user(buffer, tread,
-					 sizeof(struct snd_timer_tread64)))
+			if (!copy_to_iter_full(tread,
+					       sizeof(struct snd_timer_tread64),
+					       to))
 				err = -EFAULT;
 			break;
 		case TREAD_FORMAT_TIME32:
@@ -2147,12 +2149,12 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
 				.val = tread->val,
 			};
 
-			if (copy_to_user(buffer, &tread32, sizeof(tread32)))
+			if (!copy_to_iter_full(&tread32, sizeof(tread32), to))
 				err = -EFAULT;
 			break;
 		case TREAD_FORMAT_NONE:
-			if (copy_to_user(buffer, &tu->queue[qhead],
-					 sizeof(struct snd_timer_read)))
+			if (!copy_to_iter_full(&tu->queue[qhead],
+					 sizeof(struct snd_timer_read), to))
 				err = -EFAULT;
 			break;
 		default:
@@ -2164,7 +2166,6 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
 		if (err < 0)
 			goto _error;
 		result += unit;
-		buffer += unit;
 	}
  _error:
 	spin_unlock_irq(&tu->qlock);
@@ -2200,7 +2201,7 @@ static __poll_t snd_timer_user_poll(struct file *file, poll_table * wait)
 static const struct file_operations snd_timer_f_ops =
 {
 	.owner =	THIS_MODULE,
-	.read =		snd_timer_user_read,
+	.read_iter =	snd_timer_user_read,
 	.open =		snd_timer_user_open,
 	.release =	snd_timer_user_release,
 	.llseek =	no_llseek,
-- 
2.43.0


