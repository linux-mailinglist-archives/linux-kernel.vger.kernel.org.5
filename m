Return-Path: <linux-kernel+bounces-141004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9720C8A1A10
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D761C21C6D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9AE1C2FD7;
	Thu, 11 Apr 2024 15:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="V9WdfyPi"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D406D127E1E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849890; cv=none; b=U75D+wwav19v0puQaPEE/uiJjlBAq/A41QLm30c4P0XFQKvcuKP6yTxzKcnhnmUBAoSIgIUbjtkQehj2msUoKQJNOdytaD3qRlZL28bBO7h+eLyryuAGOLaj/ymZWF249wsqLjoOyiGKCkEcM+mY2KU+Pu7V2SdG9zhJaMW9CJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849890; c=relaxed/simple;
	bh=G7fA2zph9UHpcDHHvN1L+DDxS/deAwJXMw5zl2iH8TM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1ijzcrLxsiD71NGGy+9ikCtXm+40vNm2xVxFVMmuvEtnrYwOESV7Rmtb4apNcbqSUBLk0ilyd25PuoojfO/hRSBz0+9AbMTVpXOnOFI7Ddhbj0gEMxmkCEnDMPdTh9/u8jwfIExDc1j/rUwFmEOeLtp+6j8v0Bpfavmm+sfhAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=V9WdfyPi; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8986439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849887; x=1713454687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsibYaDnAk7XMCHdjfEv+RnnWbGsgcEz7VUXWsWdK5Y=;
        b=V9WdfyPi+XOl3V2+u2JZ8Dn+LU6Orjqh3+AwOB+ORXleb2YmMh8WWOOcdyn7v8SFhj
         u7KJ2lHaGBWuFpF1xa0Lqn7YwQ0ekW6MIGJt6SXKMVnwQgiTFHb8T7stPmSzHIyrG02h
         0de7oy12xJ7sOMUku+jZdNRR8yrkj6oa7gctibj4qDFhQAQBNi+P/fFIdG/5tv2m3EK6
         JwdEY3FJ7uTCFMK84UplVQPAtXmo6z+fyfL5LD+/Pg+Z6NcgAO0uLJEDL0z5AeF2kzFS
         f5SZeYMnh6IlXYDGxkkqBkBpWRPZpOY6f2qUYkN1Uy87BNMHa9x6aZ5ZBhv5aJi3+xXG
         ItQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849887; x=1713454687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JsibYaDnAk7XMCHdjfEv+RnnWbGsgcEz7VUXWsWdK5Y=;
        b=Tw3WM8jLFv55TcXswkkf1vDQ+jM1+ZueLCFC4XRlylFx+B7JxKgAMtdSyQgsGbYbxB
         +3O+gbBhW8C/5fQvaZF/P4fYMrwILd1rg/z/ukB1diX3kINtaK3T+VgpKAar0FKJW+RB
         ovuU+nrAn9qHKNz7Da5AVRHYj25Jg3L8wk8cmC6AglXEKlRG3+bJOtc6+IZK2P6mVFtW
         jkzF98YWwC9o3Fo9lOV5cbqIYKTyebn6f5AQD/Bs49kcC3pPmwklWfU1nFawF396nSLK
         TA7OWbtGV8wFMVcnAco65FkBjw8Bt7pZNpvW06bN0Qop4WvgTN//jI23N4EsHJHNlYOO
         jGMQ==
X-Gm-Message-State: AOJu0Ywvv5HVO4hriOp8PJABBPqbLnWvrHgpZCLD3BBm8xAUWFmBDHWI
	bwccsKNcoCggQhpOhhYW/4L15F0FkmEPos1wLwMycXFw+UQEOzVLle8yWs+UudOt8J8Fuazy3xu
	v
X-Google-Smtp-Source: AGHT+IGPHP3+WiPBRD8kOKazk8x4E9Co3eargOhC09iK+qoEAoWMV4y2Ia/CmDHXI6HD5T9dZ8YX5A==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr226822ioh.0.1712849887593;
        Thu, 11 Apr 2024 08:38:07 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:06 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 232/437] drivers/mfd: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:12 -0600
Message-ID: <20240411153126.16201-233-axboe@kernel.dk>
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
 drivers/mfd/tps65010.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tps65010.c b/drivers/mfd/tps65010.c
index 2b9105295f30..74272a534020 100644
--- a/drivers/mfd/tps65010.c
+++ b/drivers/mfd/tps65010.c
@@ -290,7 +290,7 @@ static int dbg_tps_open(struct inode *inode, struct file *file)
 
 static const struct file_operations debug_fops = {
 	.open		= dbg_tps_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
-- 
2.43.0


