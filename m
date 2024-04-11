Return-Path: <linux-kernel+bounces-140775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C0F8A18E6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087701F20F63
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CEF175BC;
	Thu, 11 Apr 2024 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="LoyugoHs"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F321647A40
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849522; cv=none; b=hco9/uRUeDD6Dru0XzkouvNurh4KMegriBp7kopbeynbxwr1SoMPDQGYat6Ew3i3+7tL/hRiBHOu9ULIOADNh1sJ6YEviW14s3HUVxDGKzUK4AE0DcjKKejSDoUOglxS4fwpMZhLCigFdJYR/qGWu4xiHVUGXSYFLo0tWzAbr2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849522; c=relaxed/simple;
	bh=b6BJ6bdYgKcmSRPu3h2ZBMnIlJhAsaOnXN294n0w57Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNE8k+sZqrtKi6IriIvevu9+Kj7FXsM8/xeVAsOCGIlpDykmZMH8yD8bpo8fDcjY9TGLiLnNvGXnDrVNxTLC7NToIFZ+dUp0YCb7CVRTJUlbDG2z2AXTIH74b8W/Pnmy0UuakdROnyzD5GCOJmP+N/XMERmibSDhboNjlPupeGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=LoyugoHs; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16097139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849520; x=1713454320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VW34PY8bhtWaLL10H9ZPJKMPMEp/LIC7us+UOvg4OgI=;
        b=LoyugoHs7iyLOK4LGQ3jcvGMa24AZ0tY/2+VQKyfls11AwZazo3K1vzkOt2z2nd+fV
         hm00OkwBA9B1gGVPxRp2EWVQh8yJQp3m+TNM+hbTbELQl19QkRF21Sb28lVz9dbe4hxX
         9YoELneNWYsIJYkwNEDHLbKDlXzZfdhYtI85Zw4h8ZlgI025jV667sKTe+lmpHVj0oNA
         61le3tOzzVaUBGEdsfOelH2COTSfL0QbAXqkakkB1FPGE0u0GNTjlNpx+NrC43MV85gY
         9A5I2V2xRQuMQGDuP6KXKGY4CtvKdO8zckKzT8zm5garqESpom0eYxdhFsLlLODxml4A
         oyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849520; x=1713454320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VW34PY8bhtWaLL10H9ZPJKMPMEp/LIC7us+UOvg4OgI=;
        b=ffpu3+fCh9r7OTCL6NNf7C+oCcyeIfQug/RB6XAjzXaryGCoLcDXQ/+4mw0fT3zIF7
         27o1Zm1LjBjpewg+mMMXa/2++9uy2czvxL2x4joEoE/CACEncyAQwfdbeNR7QPb72hR6
         OdgPt859p3CAUN7rIVvFJ3DgOtBLJwc51dsKO1TuR0nOdVJADiPR7Kb/SMNWYINC1ui2
         y+NicJtzV6l43gw3kzF5MldEJ56YG4BPD+VW3XtakgnCzzovRpwzDe/XNWX8wZPLOnaP
         qeAc61zvEHPZAteIrGpSA3vSXQFUN5crhOxlwwcEi6vTsSjr1earBHzU5Sryu3Cu/vFM
         wlug==
X-Gm-Message-State: AOJu0YyKN6JZ75pBe5xbNN3XGlo+BEpZdv6p44oWtMenJFunXQc+xqNZ
	3eC7DZBLyGsNnZWqA/aKhmE4seB8Gowv0f/1JQQ2ER9U+S0wBX/EZzpoI6WEQQbFkZczV81tkiy
	D
X-Google-Smtp-Source: AGHT+IEYia7GGaSTRbfcGC/W4pV+Z3t+Kj8quO0C0QSCXGrUoUWhUy7zFkpKFPLeoR0r61cTT+2ojA==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr147854ioh.1.1712849519873;
        Thu, 11 Apr 2024 08:31:59 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:31:58 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 018/437] char/dtlk: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:12:38 -0600
Message-ID: <20240411153126.16201-19-axboe@kernel.dk>
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
 drivers/char/dtlk.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/char/dtlk.c b/drivers/char/dtlk.c
index 6946c1cad9f6..60858db14c43 100644
--- a/drivers/char/dtlk.c
+++ b/drivers/char/dtlk.c
@@ -101,8 +101,8 @@ static long dtlk_ioctl(struct file *file,
 static const struct file_operations dtlk_fops =
 {
 	.owner		= THIS_MODULE,
-	.read		= dtlk_read,
-	.write		= dtlk_write,
+	.read_iter	= dtlk_read_iter,
+	.write_iter	= dtlk_write_iter,
 	.poll		= dtlk_poll,
 	.unlocked_ioctl	= dtlk_ioctl,
 	.open		= dtlk_open,
@@ -155,6 +155,7 @@ static ssize_t dtlk_read(struct file *file, char __user *buf,
 	TRACE_RET;
 	return -EAGAIN;
 }
+FOPS_READ_ITER_HELPER(dtlk_read);
 
 static ssize_t dtlk_write(struct file *file, const char __user *buf,
 			  size_t count, loff_t * ppos)
@@ -228,6 +229,7 @@ static ssize_t dtlk_write(struct file *file, const char __user *buf,
 	TRACE_RET;
 	return -EAGAIN;
 }
+FOPS_WRITE_ITER_HELPER(dtlk_write);
 
 static __poll_t dtlk_poll(struct file *file, poll_table * wait)
 {
-- 
2.43.0


