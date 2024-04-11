Return-Path: <linux-kernel+bounces-140786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8527B8A18F6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37DA71F2249E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0838753388;
	Thu, 11 Apr 2024 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="W2E8Z7Gu"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D7151C4D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849539; cv=none; b=ZdRHvnpRANSI1/ihVTqLmfQek/zSCw/ibpnRb/UVtC3NXAiw7qzwdnxtCHEs8Vmu0AzCdb9SCWMACjNLRE2SirtFHbwrjsNkFM09u9z/dkJgyOrxMWZy2mDmGgTlKous6YD9t7BdQP7iQbB0FKEuf3LPaBZhW48mBqhC9sRgmE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849539; c=relaxed/simple;
	bh=kyw/HdCUwTeWRwwA+0T6XYDiM1ZoUTaYBdjVI0tuHt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UN+pvPyjP4+sZme8vm+Bq5TSJ7S8Hb7eEhcpARTC4QvcTnCrvEz213we/R/eQ5BRva+0X7ULpffh9mn/d9KTUHvoWQmW3kBmHH1E2iPVxIZNFNq6F/DYMfewFTpb8tE+C+xJ2+kx/TQLB7BuN4RMhDGibUAIa841hSjCsim+sBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=W2E8Z7Gu; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69489339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849536; x=1713454336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGpvMSeP55U4CAnay381szdexyIncKVKMN6QJLNVTXI=;
        b=W2E8Z7GupadnBskv5iNaftv0clqF/wYjROdH6dcJc611R4O1wk36ZNFHnisc0vj7ik
         E1j6WaKG+EcWsJ3CIpK+qTjwIci0EZMnoR0KVPIQTk54b6zKRHH2Sh+XcHrgyquuqelV
         afGaZ4w1MbaGBei+RkeLd/EP33SyjN4coB9Foos1h76RD121nFP9U1Jdri+joMgvjOqb
         PoSSeku+nZvibtVp6JpgwKauvNuU/b6MeKqZsLbS+stnn9ZQxPId32GvZeLZonvQWcxd
         +OuENCSg0ly02x7od1Ii38l9f7q0bdIEp740ap/miy7EXMbx0QjJgFsCEJ3m/Rdotre8
         +LvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849536; x=1713454336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGpvMSeP55U4CAnay381szdexyIncKVKMN6QJLNVTXI=;
        b=o98XFm/5ueDqpqLDML2HvgH/oi4eR5I5Yusk4QFhW5FbC55KbXHpWoZb9KH/o2G0v2
         mBmC8Dt05VxNgl96aAdVIIbZOFDa1B4yOvBdmhMMiYCsd0Xie4s3XXayeZZkNp/+oha8
         uhW6TebNzk4jFfaln1ASV1Mj8tQXvcAjwKlzfehQmZmTFpDeQTjKeHcb5AFpdVaZreYf
         yJBO99aeRPUFd5jbzVXwpXTm8skdrx1BC78/HIU/sD6Mr/irpJx3YoEtNpxwIKaOWtKL
         Ms9trRyU40eGrPu3DdPkk3X3ppeKOI81fIdZBJ71J26yCqzILRWFIfYsMlqx9mLzKVV+
         ub/A==
X-Gm-Message-State: AOJu0YyUM0IUiTAEZVcLTM02HaHWFYeYG2s2l7oW0TUdg3S3fDMfjYNi
	/IX3MSe5wEJ/4/VIwTXfbxbRQokK79jmcUM+5zCrI6J9XrFDorkXXzgKHeyM7+TFANgjtyuLMlO
	K
X-Google-Smtp-Source: AGHT+IFo3HSOHcR2Ho2i/pya4vLLfXlNeF2PJYWVN9WFKXE4DsBK+OcNN0OtZ9Xm8rR9mlONopxzqA==
X-Received: by 2002:a6b:c34e:0:b0:7d6:7b7c:8257 with SMTP id t75-20020a6bc34e000000b007d67b7c8257mr203006iof.0.1712849536556;
        Thu, 11 Apr 2024 08:32:16 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:32:16 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 029/437] char/pc8736x_gpio: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:12:49 -0600
Message-ID: <20240411153126.16201-30-axboe@kernel.dk>
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
 drivers/char/pc8736x_gpio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/pc8736x_gpio.c b/drivers/char/pc8736x_gpio.c
index c39a836ebd15..9ffd84788550 100644
--- a/drivers/char/pc8736x_gpio.c
+++ b/drivers/char/pc8736x_gpio.c
@@ -233,8 +233,8 @@ static int pc8736x_gpio_open(struct inode *inode, struct file *file)
 static const struct file_operations pc8736x_gpio_fileops = {
 	.owner	= THIS_MODULE,
 	.open	= pc8736x_gpio_open,
-	.write	= nsc_gpio_write,
-	.read	= nsc_gpio_read,
+	.write_iter	= nsc_gpio_write_iter,
+	.read_iter	= nsc_gpio_read_iter,
 	.llseek = no_llseek,
 };
 
-- 
2.43.0


