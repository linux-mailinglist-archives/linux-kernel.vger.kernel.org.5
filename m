Return-Path: <linux-kernel+bounces-140970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B3C8A1AEF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA9B287A34
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEED17AD76;
	Thu, 11 Apr 2024 15:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1c20Vr7i"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FAD1BAA95
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849838; cv=none; b=EOyBNh3/vv+UtUvfwMZ1lkEc9Oj+uWSWwEy7bbs1GwRFG/C2JfUAu4K3LMg0ZtA0halOG8YUODiRgwn0SOwjqsG9etv00FIViXH7fw6Vat+DxHy6BGEYFov006ElPW1GJZjBLF3G7ZLhvomXeJU/YxrQk1xTnI2aivRfv6gTyEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849838; c=relaxed/simple;
	bh=hzeGJuqsCNENJiQjtg2MffEahLh9ZmQ/4D1HGjsIBj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FEORkqNUFDYvtEbvIzVDaq2ZE5TdCLWv3/kK+kTCRdVu31uzWlxKlx42uLllq1ct7SYlYVRfeisazpmvzEtNdVrwIk5UOHoEIFF+Vd+tyCkpoBhZ5fhN2N7UClfD2KCm4NUkflgzp+nxcpjK5M7nnBHv9Tnn3YchRM2qfM9LXmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1c20Vr7i; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170538939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849836; x=1713454636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJHWZ8kVRf9wEcPJrG9reH4bITaufD9pcVT3oPpa9tY=;
        b=1c20Vr7iHeouKXDLeCgGs4o/O/T1HqrqfZcoMW6vHuOqgg6hxOEjtW4C2+k0FtGI86
         0u99I9HYAFxClGkXOKoR/oaPSsCT4yUuYi5ue+3++t0CYpNZ6E56N7qQouW9lgv5LLzV
         7fiFSdwc268W9Cpq6Y2iY3zFmoz9rhE8mw/NybjaN/V2RH0DMBmsbjGYJuMD1vcCj7l9
         lRfDtuPqrgg9I3Gq1qTM8GINT3VRGYHWigliEimCLeo68E1nwu8pIfRcNcLPvhQhM1OG
         NDLiIfam4UiUgNpbBbkuwwInlwIUqdkswdq0bQD1A3sOXGwVjN8cxthqO+suIpM4eG0O
         i8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849836; x=1713454636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJHWZ8kVRf9wEcPJrG9reH4bITaufD9pcVT3oPpa9tY=;
        b=M3EqWWkNIteIO9/Y3gTLStQ82nS8S9WnczEaac+eeG2uotT9zKGMnE/fr9zBx6avmp
         54blJwaiLH2DJ1rKR/k9dEcgdOX5uRfJjhWZGcwjMR93zUALJGJ2T/AGMb0BtsDARS1Q
         dz+LCv4dS79vo6RGE72MJuJX7Q756vqReqrs3kISjkIhAYOrzQ1W1701KMYXNQpFSNxK
         ArWm8X5XwnEtzrcOFgMFa2o/xWgl8G/jp2ObBkPQageGZiRKwNWlLrmouY9pp4OtEwV/
         shfd+12rcwz50+1v1Jrzhv//Q9+96KXGD6gyMrOjTJogKVWii56EYUjUjd0T8E13I7+D
         5p+g==
X-Gm-Message-State: AOJu0YzsAALXzsg3qoyufEHwaAuaHuS2dnbRTnfPGuvdbNsux5bW+ENL
	WdSTa3VdzTiXJLl0pYX85s0DerzdmQGYNsHG9xK9cEFeSlFYyLUAHSfFyG3j+MGnjAOPu3q1HfE
	o
X-Google-Smtp-Source: AGHT+IEBvww1ZiWRpvw9iQvAZx3AB9ey7p+JIo6btKpdoFNqFL17IHMTxEC2zLUOF/nZ2nyJTykdXg==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr183380ioj.2.1712849836257;
        Thu, 11 Apr 2024 08:37:16 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:15 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 201/437] staging: fieldbus: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:41 -0600
Message-ID: <20240411153126.16201-202-axboe@kernel.dk>
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
 drivers/staging/fieldbus/dev_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fieldbus/dev_core.c b/drivers/staging/fieldbus/dev_core.c
index 0053ebd91442..4a9e211640db 100644
--- a/drivers/staging/fieldbus/dev_core.c
+++ b/drivers/staging/fieldbus/dev_core.c
@@ -194,6 +194,7 @@ static ssize_t fieldbus_read(struct file *filp, char __user *buf, size_t size,
 	of->dc_event = fbdev->dc_event;
 	return fbdev->read_area(fbdev, buf, size, offset);
 }
+FOPS_READ_ITER_HELPER(fieldbus_read);
 
 static ssize_t fieldbus_write(struct file *filp, const char __user *buf,
 			      size_t size, loff_t *offset)
@@ -203,6 +204,7 @@ static ssize_t fieldbus_write(struct file *filp, const char __user *buf,
 
 	return fbdev->write_area(fbdev, buf, size, offset);
 }
+FOPS_WRITE_ITER_HELPER(fieldbus_write);
 
 static __poll_t fieldbus_poll(struct file *filp, poll_table *wait)
 {
@@ -220,8 +222,8 @@ static __poll_t fieldbus_poll(struct file *filp, poll_table *wait)
 static const struct file_operations fieldbus_fops = {
 	.open		= fieldbus_open,
 	.release	= fieldbus_release,
-	.read		= fieldbus_read,
-	.write		= fieldbus_write,
+	.read_iter	= fieldbus_read_iter,
+	.write_iter	= fieldbus_write_iter,
 	.poll		= fieldbus_poll,
 	.llseek		= generic_file_llseek,
 	.owner		= THIS_MODULE,
-- 
2.43.0


