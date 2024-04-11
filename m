Return-Path: <linux-kernel+bounces-141206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6267E8A1AF9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 929941C22003
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC671FFC30;
	Thu, 11 Apr 2024 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jy+ynLmO"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2DA1FF314
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850208; cv=none; b=SB/YjsOZOkfN73bbvYduqsY34SthyVry3cdBPzllq0htfuJpDSATnE8tASnkNkBrnmYd9V96DM3z+Yg5pxELhZ+cCNd7XA62qARykdnEmHxhSgZw5OEEiNDQYrhAft6QMTEI09kGU/dEralN9UQWfp+FvcrwexzIQPm1W1kxrqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850208; c=relaxed/simple;
	bh=nS1jNvrbvWmPX9lvzlRyLIelGLdpT151XRYuNi2ZuVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2NDIP6UgpbVP4ZY1L4TgONJPODQ8Rk6xu/MFBkzlq40Hx/+FHKQhVclLZsS6+F7Rl9b8SA3fXqfJxtitFI3ixuTBoFos2ksH9ZxiHMAEa7MffIuocVhK+C+o1PcB4Q8wl8EbD7iWbriLeiMVW29WYDvgKJTU1GYiZWeKuJZ6Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jy+ynLmO; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58288239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850206; x=1713455006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3w8Na6yblbY9jsnh6xPO9UBR9OoU7LpVwy2yOHFsEc4=;
        b=jy+ynLmOytiRWBR5QqzRVE7Ie2iU8Y86beOVy5Vk5qOU1mj2lZPJHS+ZvTjJFlyl0d
         zxqlXuz2F6Z7bOjaEdjsGKfolV0NDR7S8n+DtNpEF4WoJXdOMISTjooDiQKR3VRGWmWt
         WmVe1d6db1raK8a3H3DtJ2YUycjcw1zJPAeFtSagm6zvt53VFmsnhq9V2zDVRwot8ZlU
         pwlHGQlvlk/djg2daM3wRdj6Bn1UP+rcxAF710E1PlZlfzK7osrw4Cri7X0Tn6czA1M1
         ysGvgJQvVRHFrW2azWHGjs3K1aba8zxuweDpjFSYY9pt9AVBw2oMt6pNl+j1m/2JEHT0
         A5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850206; x=1713455006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3w8Na6yblbY9jsnh6xPO9UBR9OoU7LpVwy2yOHFsEc4=;
        b=hiTIm0yIL77aRyiLpz+P+hPt4/ZLKAbAj+bezOysKTh4NsIy7EdnMEclsc91QgP8XG
         zghmVcPUuLoH9pK0GDOSlLQwprd4Rj6Gcb0O6TmJTL+0ro6aALe0Wrxl9dEkiSkzhdgc
         GaSPaN+rWAfHYRfWlwIARlbilLbpVtYadBgO1UsDvVE045xVaehroNmnjyY/Ltqm6JVM
         NgLAUBgRUb+t3ZMLHGXmv/wqQACTOIQ+lafkElLc7jZpyjNdqyBydFMQLuOM/TS/MWuy
         BfvcbCF0kmS9aCekRv43YoPJUfX22ZCicJ3a4OFMgU9oQbWIGbqjchc92C4yEdiVM32k
         f0cg==
X-Gm-Message-State: AOJu0Yyn8U5mENIfeUDwZIERtoo7oTWJOHm5GfNFiIXxbtuS7N4ug0dP
	g7ereUvdonUiXVYU59xLvOtGamIoDISlxMzalZwq+09e9cU1Wawqm1CeKj8fyR1xB14Ou26dsMM
	K
X-Google-Smtp-Source: AGHT+IHePdnffe9chztRpY+mUIlpEimhrHFfZI/WTIh0AynaXxFvLLYfa4EH4Bek4LuDHzvf2Ln7Ug==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr181788ioh.1.1712850206650;
        Thu, 11 Apr 2024 08:43:26 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:43:24 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 422/437] media: ngene: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:19:22 -0600
Message-ID: <20240411153126.16201-423-axboe@kernel.dk>
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
 drivers/media/pci/ngene/ngene-dvb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/ngene/ngene-dvb.c b/drivers/media/pci/ngene/ngene-dvb.c
index fda24ba3dc3c..dacf56140347 100644
--- a/drivers/media/pci/ngene/ngene-dvb.c
+++ b/drivers/media/pci/ngene/ngene-dvb.c
@@ -49,6 +49,7 @@ static ssize_t ts_write(struct file *file, const char __user *buf,
 
 	return count;
 }
+FOPS_WRITE_ITER_HELPER(ts_write);
 
 static ssize_t ts_read(struct file *file, char __user *buf,
 		       size_t count, loff_t *ppos)
@@ -73,6 +74,7 @@ static ssize_t ts_read(struct file *file, char __user *buf,
 	}
 	return count;
 }
+FOPS_READ_ITER_HELPER(ts_read);
 
 static __poll_t ts_poll(struct file *file, poll_table *wait)
 {
@@ -96,8 +98,8 @@ static __poll_t ts_poll(struct file *file, poll_table *wait)
 
 static const struct file_operations ci_fops = {
 	.owner   = THIS_MODULE,
-	.read    = ts_read,
-	.write   = ts_write,
+	.read_iter = ts_read_iter,
+	.write_iter = ts_write_iter,
 	.open    = dvb_generic_open,
 	.release = dvb_generic_release,
 	.poll    = ts_poll,
-- 
2.43.0


