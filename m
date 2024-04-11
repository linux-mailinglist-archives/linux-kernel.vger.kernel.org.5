Return-Path: <linux-kernel+bounces-140828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ACC8A1921
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A25341C23462
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD87A86250;
	Thu, 11 Apr 2024 15:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bXOdftaJ"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E1B85935
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849618; cv=none; b=eHliynHDFVtfpIHh83yXqwxe8ZLq8ZYePSvt4vroDHDwzecoFt1ePTOWxkVjbwQAbbg9CvMgpEn9hubG5BgYcmHX6m62v56WVILSzcSSKRng4+IacOPdeG2FobRosFTrwZXZUe2cDoL2238fsdJxf8tomW/Q5Ru4/Sn5JrlqFmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849618; c=relaxed/simple;
	bh=L1CEr14c7mBj4sr4CNjxSe0f4NZNFDDr5bqgk55pJ9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=scnXIF0qKDZh4xgrVtlyN5Qc3xCeHBQ1eLbmBQgHHZC/NHqnS6vQqQ6+09nsvtsNS9F5xkZJH+AYq2z8roBo9VmLLn9FavqM/VSdzFXZtUmxT04BawTFT9akkIV6Pd6kMV0pu61ijiAV0s1+YIhSWUhKBD687TK8+3KEjfkeeew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=bXOdftaJ; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69517239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849615; x=1713454415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Yp9XiWZV4f9xB1HqyHZEA0yY6Ji0QcCa2CoWMJQVdk=;
        b=bXOdftaJWdol5Uzcp/F3yP8C/C4BYpyu7CE0vBcEDQNp2mNiX7bqd4Yh8BYfxhtMpz
         wB8VMrF3MWX4QNWTGiO1e0WNPEuyQMmovVIl7QLLBsTa7kf6gg6oqWA+GOwQUQlWQzXF
         hUulzqhXNzxlFZatwhqGyrMY9WF4bi2Xk1sOfnXFd7anFmuGcJ5Zu8FZeJxA+OmWrr8r
         DTRQOCCcytPURqa4cU0ofWIZXgpkBY037lIHBfjVPUVnKBWOGy/tRgW9K8/TpsaN8JOj
         ynE4xa/tS7pFUhPMRll/JpJ9mT0uoLJH7b38g5Mj03gzVrqU16aLV8AziCD+Lb+hOSeJ
         UD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849615; x=1713454415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Yp9XiWZV4f9xB1HqyHZEA0yY6Ji0QcCa2CoWMJQVdk=;
        b=kO7qt0K5CXLoQMmIfeDw/ri4By6brxSYsjHWrzeere+PZS2arzN2avKFtJ58olZbtQ
         tse9TJKs8eAclLFRjRPwbWsXTmH+EUHhSIA/69Hu1DWEl8sie6hWQSaftTLsiqQgMdVY
         TLoRhuRWCUmTIs4Afr+YLDnWi9DY+hZhIYGugG7CKg35WYu4VKmJDqzv8SCvNu/GPTBv
         da4QjG5jWShOirbYe+Syh/A5G3rlOvPKAODpKEQeJu0Rl/lYhDGuaRwF0kxgQqyr/U6T
         zjNWcddrrvTK2o23HvYS7n+8WokV08EjoY71fLiFxU+x7nYr58H86x/p0XR3F7zbGF0w
         XmMw==
X-Gm-Message-State: AOJu0Yw7y9yJ07RO1vL5T9l9Ml3NyGs2uyFmrs/ebJqSHBiu2l98Mkyh
	eTP+EtWLE+ca7KRw0CJWH0HQWxyt3t3zYo8KNY8s/2Hc2eHihE91q6dY4rtEaQh03r6obgxCtz6
	1
X-Google-Smtp-Source: AGHT+IHJajsXylJ3ozZ++Bed7L/PWKRTz7PUdHfFio7rpOyj8GQBDJOG7WNByvCOXG/K8U43dd/3uQ==
X-Received: by 2002:a05:6602:84:b0:7d6:9d75:6de2 with SMTP id h4-20020a056602008400b007d69d756de2mr35160iob.2.1712849615382;
        Thu, 11 Apr 2024 08:33:35 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:33:34 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 067/437] ASoC: SOF: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:27 -0600
Message-ID: <20240411153126.16201-68-axboe@kernel.dk>
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
 sound/soc/soc-dapm.c | 21 ++++++++-------------
 sound/soc/soc-pcm.c  | 10 ++++------
 2 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index ad8ba8fbbaee..f3cfbf70f8a4 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2094,11 +2094,9 @@ static int dapm_power_widgets(struct snd_soc_card *card, int event)
 }
 
 #ifdef CONFIG_DEBUG_FS
-static ssize_t dapm_widget_power_read_file(struct file *file,
-					   char __user *user_buf,
-					   size_t count, loff_t *ppos)
+static ssize_t dapm_widget_power_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct snd_soc_dapm_widget *w = file->private_data;
+	struct snd_soc_dapm_widget *w = iocb->ki_filp->private_data;
 	enum snd_soc_dapm_direction dir, rdir;
 	char *buf;
 	int in, out;
@@ -2155,22 +2153,20 @@ static ssize_t dapm_widget_power_read_file(struct file *file,
 
 	snd_soc_dapm_mutex_unlock(w->dapm);
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
-
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, ret, to);
 	kfree(buf);
 	return ret;
 }
 
 static const struct file_operations dapm_widget_power_fops = {
 	.open = simple_open,
-	.read = dapm_widget_power_read_file,
+	.read_iter = dapm_widget_power_read,
 	.llseek = default_llseek,
 };
 
-static ssize_t dapm_bias_read_file(struct file *file, char __user *user_buf,
-				   size_t count, loff_t *ppos)
+static ssize_t dapm_bias_read_file(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct snd_soc_dapm_context *dapm = file->private_data;
+	struct snd_soc_dapm_context *dapm = iocb->ki_filp->private_data;
 	char *level;
 
 	switch (dapm->bias_level) {
@@ -2192,13 +2188,12 @@ static ssize_t dapm_bias_read_file(struct file *file, char __user *user_buf,
 		break;
 	}
 
-	return simple_read_from_buffer(user_buf, count, ppos, level,
-				       strlen(level));
+	return simple_copy_to_iter(level, &iocb->ki_pos, strlen(level), to);
 }
 
 static const struct file_operations dapm_bias_fops = {
 	.open = simple_open,
-	.read = dapm_bias_read_file,
+	.read_iter = dapm_bias_read_file,
 	.llseek = default_llseek,
 };
 
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 77ee103b7cd1..611845526491 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -164,10 +164,9 @@ static ssize_t dpcm_show_state(struct snd_soc_pcm_runtime *fe,
 	return offset;
 }
 
-static ssize_t dpcm_state_read_file(struct file *file, char __user *user_buf,
-				    size_t count, loff_t *ppos)
+static ssize_t dpcm_state_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct snd_soc_pcm_runtime *fe = file->private_data;
+	struct snd_soc_pcm_runtime *fe = iocb->ki_filp->private_data;
 	ssize_t out_count = PAGE_SIZE, offset = 0, ret = 0;
 	int stream;
 	char *buf;
@@ -190,15 +189,14 @@ static ssize_t dpcm_state_read_file(struct file *file, char __user *user_buf,
 						  out_count - offset);
 	snd_soc_dpcm_mutex_unlock(fe);
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, offset);
-
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, offset, to);
 	kfree(buf);
 	return ret;
 }
 
 static const struct file_operations dpcm_state_fops = {
 	.open = simple_open,
-	.read = dpcm_state_read_file,
+	.read_iter = dpcm_state_read,
 	.llseek = default_llseek,
 };
 
-- 
2.43.0


