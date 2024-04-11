Return-Path: <linux-kernel+bounces-140972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8A68A19DD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877F01C2131B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37CA39AD5;
	Thu, 11 Apr 2024 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ppxdMzeM"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE6817AD89
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849842; cv=none; b=T8NIx6072hbbu4ZUWvwoubdJMgb2Pc8VGh7ctt8SD2XF3OSQrXw56bqMST19J/lhEszDasySZYkYfH919I8LnUrLZJj2jjPuR4c30x17VCAx6myUeUik9q0E7KdZgY+KI0oTqAE7wuZ7Mb/yv+2LcfNnpQP4l42jrjh4KGhtgmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849842; c=relaxed/simple;
	bh=e2gTwFqCtDrY3UJAn9H2Bhmoo5CFknNWcQ48BCmUjKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGvIReiL7KSnauqaTn28MNHMsgDGcZhmPcdfIOxKDBWysmw0Y+o78vJUhHlMvQX/Bm7u8O5/T/jrs1cyxbyk/wvd17y4l5suLVv+GwZsfIvVR7HuSuuYSJxVKLq7BWFOewTdR7yrMk1YeeAnb8jOn0iw85cSXNU+vIbYAZm8iTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ppxdMzeM; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8971939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849839; x=1713454639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWEn5iB1LmcjEiy1XdfAmvuMK+L+7s2BzBG5cbasvDQ=;
        b=ppxdMzeM6PVeL/AjRTCAj/Dn7PELly2hlKdjyW4a8BMH13UmuiqQ0EZbwY4zwjj/bz
         5u7s0W+eMleHKpm3SFkxIY/9XBzzOcJI9JjkN5amckOY/WXzTgRh437YWHiTSOMkPmWL
         Ac/IplO1rHQgCv/bkDZQf5n6gwxKVfxLOgXNTd+BAfLZuUguj9nN7fuu6w2rcUdMRqPL
         hiVDzLc4F7CR8weCtnbw81WZsUDxnHYro9QwL09xpH4D/uVuLJZN1BfzzHnqSHHQMtwB
         6jQq3vETn1wlpUkhRC9eO+SHxHEMxO1OinaRI/UAeA8330AOnWkZNHYE02+kQBgX9fBs
         gmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849839; x=1713454639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWEn5iB1LmcjEiy1XdfAmvuMK+L+7s2BzBG5cbasvDQ=;
        b=aNNfvzT99ZNjEC9/COYDhgYt8TdJGZ7bgpEH/QGSirxZ8jF0a9kHOtWACHEB2mAgn7
         Wofn9tavq8a7Ln3VWP2ByjrfabTh8Fs8cPtH0U1c47K0DC3M0sWV0xNp05MWjXx2LhR5
         jBRV+r6y1Y23gNLB6hbh4nUBiInfJjhm9d2yfB/qRrk3ve3pyMzfUmBgsy5XWjAUbpsa
         dnRdJmfrHhyMdIngP5HP2WJl34VEuf3p3qmhAiVXLO2zpqMdIpLClQ3SrDg3q86sHNEw
         r+C3paH6vHtHpMHWrhdHmgGZ70RAWBdFev+UECN/lcBU/rxApmVYGHS2Jmgs93ASOOy2
         IOjw==
X-Gm-Message-State: AOJu0YyuiX87Qr9eMMyIb622hjRYWXPq6wChil3EBCIiPNeUUatyGtB8
	dUsUK5n50RsYetf9r2QYs0VkpRORoX3ZkKrmb+UkVIMlKUvp6+4CIWFkOlMli9N0dEI4ya88oWB
	z
X-Google-Smtp-Source: AGHT+IGdzPWk0DWzg/Wx0k5JD5EGSKe6rDKOsUGN7PQMJGG5K1QsfICRfNxifBHzhHrvz6rRXq85Tw==
X-Received: by 2002:a92:d352:0:b0:36a:1275:4aeb with SMTP id a18-20020a92d352000000b0036a12754aebmr5885227ilh.1.1712849839682;
        Thu, 11 Apr 2024 08:37:19 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:18 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 203/437] staging: av7110: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:43 -0600
Message-ID: <20240411153126.16201-204-axboe@kernel.dk>
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
 drivers/staging/media/av7110/av7110_av.c | 6 ++++--
 drivers/staging/media/av7110/av7110_ca.c | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/media/av7110/av7110_av.c b/drivers/staging/media/av7110/av7110_av.c
index 00dd6a7fea64..eb3ad2eae2d0 100644
--- a/drivers/staging/media/av7110/av7110_av.c
+++ b/drivers/staging/media/av7110/av7110_av.c
@@ -974,6 +974,7 @@ static ssize_t dvb_video_write(struct file *file, const char __user *buf,
 	else
 		return dvb_play(av7110, buf, count, file->f_flags & O_NONBLOCK, 1);
 }
+FOPS_WRITE_ITER_HELPER(dvb_video_write);
 
 static __poll_t dvb_audio_poll(struct file *file, poll_table *wait)
 {
@@ -1015,6 +1016,7 @@ static ssize_t dvb_audio_write(struct file *file, const char __user *buf,
 	else
 		return dvb_aplay(av7110, buf, count, file->f_flags & O_NONBLOCK, 0);
 }
+FOPS_WRITE_ITER_HELPER(dvb_audio_write);
 
 static u8 iframe_header[] = { 0x00, 0x00, 0x01, 0xe0, 0x00, 0x00, 0x80, 0x00, 0x00 };
 
@@ -1572,7 +1574,7 @@ static int dvb_audio_release(struct inode *inode, struct file *file)
 
 static const struct file_operations dvb_video_fops = {
 	.owner		= THIS_MODULE,
-	.write		= dvb_video_write,
+	.write_iter	= dvb_video_write_iter,
 	.unlocked_ioctl	= dvb_generic_ioctl,
 	.compat_ioctl	= dvb_generic_ioctl,
 	.open		= dvb_video_open,
@@ -1592,7 +1594,7 @@ static struct dvb_device dvbdev_video = {
 
 static const struct file_operations dvb_audio_fops = {
 	.owner		= THIS_MODULE,
-	.write		= dvb_audio_write,
+	.write_iter	= dvb_audio_write_iter,
 	.unlocked_ioctl	= dvb_generic_ioctl,
 	.compat_ioctl	= dvb_generic_ioctl,
 	.open		= dvb_audio_open,
diff --git a/drivers/staging/media/av7110/av7110_ca.c b/drivers/staging/media/av7110/av7110_ca.c
index c1338e074a3d..6b9c90562228 100644
--- a/drivers/staging/media/av7110/av7110_ca.c
+++ b/drivers/staging/media/av7110/av7110_ca.c
@@ -327,6 +327,7 @@ static ssize_t dvb_ca_write(struct file *file, const char __user *buf,
 	dprintk(8, "av7110:%p\n",av7110);
 	return ci_ll_write(&av7110->ci_wbuffer, file, buf, count, ppos);
 }
+FOPS_WRITE_ITER_HELPER(dvb_ca_write);
 
 static ssize_t dvb_ca_read(struct file *file, char __user *buf,
 			   size_t count, loff_t *ppos)
@@ -337,11 +338,12 @@ static ssize_t dvb_ca_read(struct file *file, char __user *buf,
 	dprintk(8, "av7110:%p\n",av7110);
 	return ci_ll_read(&av7110->ci_rbuffer, file, buf, count, ppos);
 }
+FOPS_READ_ITER_HELPER(dvb_ca_read);
 
 static const struct file_operations dvb_ca_fops = {
 	.owner		= THIS_MODULE,
-	.read		= dvb_ca_read,
-	.write		= dvb_ca_write,
+	.read_iter	= dvb_ca_read_iter,
+	.write_iter	= dvb_ca_write_iter,
 	.unlocked_ioctl	= dvb_generic_ioctl,
 	.open		= dvb_ca_open,
 	.release	= dvb_generic_release,
-- 
2.43.0


