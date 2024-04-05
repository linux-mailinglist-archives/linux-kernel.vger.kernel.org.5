Return-Path: <linux-kernel+bounces-132575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 167F38996C0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6151FB230A1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B548D13C9C1;
	Fri,  5 Apr 2024 07:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtXa4uRa"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D80F13C919
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 07:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712302823; cv=none; b=sBE7O10L2Oo9ibP5RbJmqgt8G4AH3znx5A0jtEkMDWu8jbr+MjD8KUXEk098AI+GVV0NsRtIfVuweoDN4NsT+59033sjnsMVt7NBmB3qSW6AzXKBgjBWv0/HGvXsz7a4KQmlBpnJNHbCNQ2aDMeO7q8S66bm7LMLvhP90FnZIok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712302823; c=relaxed/simple;
	bh=6A7E8mEhs3KXYwrM2uDEBEWNmZfL2jIWrfVNakhFg2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c6LPOztzwfTTwNuMBM5u11WS4XBEeRMYRqhM2+3u051eZuYH2PVa3DDsq+svsAQtiba3WKBg08dILlG11zN+AeRuzK5x0MDyER2gTlZslVy5cMnO+VKs8Q6KlQEtPMSADUaMFezyKQO8P31rws1bc2KPzfRMawqcjbpE89Jh1ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtXa4uRa; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516be63af88so2082173e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 00:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712302819; x=1712907619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ll9cx3RyF2mwcmQbJn6nm/vNnPUvqbUfuPvzuxeiac4=;
        b=OtXa4uRaxDPt5SD4fyLkyY+xCGNLTOqnps1guK6vJmXGhNhThXWsODXzfBxbMPtb+Y
         4GGtIq+Qq148IguiL6Na0V+DYDd2Hhf9Q1XRnhVoKQl/p48FqEhIFtb4yZj/Ff+W9A58
         KOcR0jekjEH5YM1Rfz1t9fvwrYISKaXHbY82ITP76HqmVh+Fet3FcjoSXhwybUltFubV
         9jfwA2HkD8u3drrdwuSkD/OJpnWK7qMtXP9Wl5ONwBm9eSnEOAW7GO9D0g2TKdvN09gv
         YXAiDEQKTp5UkC2ggA2Im/fvAMhPxVwswX0ag/O73U4EPaz5MFhm80/1b8XJeXv/4vWR
         RgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712302819; x=1712907619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ll9cx3RyF2mwcmQbJn6nm/vNnPUvqbUfuPvzuxeiac4=;
        b=U+5/JJwp/z1PyDI760LbLPHOkdWhw48H2Z4WUUj4X18599p6foqDMq09u6VV8Yzahl
         r7RClcqHaCSgfjpX6AVDglAd/Tj4zWhc54Kncw5RWzrpfJ/r8JuzeKtDMoTohX4roTFc
         /OkS5KccP8ELkIpk1PryrYImeKurQsUI/V42RILXVtdbPPmVveahSmkW5f8ECeUx3EIj
         X9XZI5C2c+fs0Q7KnoW+FR2cRIsM1HWuHAaTGU0/ZgDoBlOokY2TuytZhvKEfnQ/wvz4
         kygKdqrRTINvj2ixKsaEVBA7XNptYSsqRIcU/dAlL1XsSEDdP22tbt0/FHv5gHi6kaEz
         Ke3g==
X-Forwarded-Encrypted: i=1; AJvYcCWZeXblVel8uj72aZe06kx/c9L6LHowbzhJhj9DH1QkD/gwmHqBxxEV+LvM/MoNLlx13nXo1i47+J03hpSv4U+6CBOrFS3SXqCR6Y07
X-Gm-Message-State: AOJu0Ywbb1PsS33cLtTzLf9Azgg9OgNdlQamSwsi0rP3ucRva6rF0vdF
	O3RqpKqkAluv0qg0g0KHVx52ESopxMKko7sm+BrDbmFpBB4bxMAe
X-Google-Smtp-Source: AGHT+IFvXxRBKHpmPMp/cqVHJIstyDR+r0Bs5N44IFJVlWHFI8nUvyiKYx/SyYNlgH/fII+G4opQQg==
X-Received: by 2002:ac2:550d:0:b0:516:a1ce:6a20 with SMTP id j13-20020ac2550d000000b00516a1ce6a20mr394762lfk.24.1712302819247;
        Fri, 05 Apr 2024 00:40:19 -0700 (PDT)
Received: from localhost.localdomain ([2a06:c701:737b:ef00:2bdf:f41a:ebd1:fb2c])
        by smtp.gmail.com with ESMTPSA id l10-20020adfe58a000000b003434f526cb5sm1311643wrm.95.2024.04.05.00.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 00:40:18 -0700 (PDT)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	hverkuil-cisco@xs4all.nl,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org,
	felixkimbu1@gmail.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/7] staging: pi433: Reorder pi433_exit cleanup calls.
Date: Fri,  5 Apr 2024 10:40:00 +0300
Message-Id: <20240405074000.3481217-8-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405074000.3481217-1-ikobh7@gmail.com>
References: <20240405074000.3481217-1-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

debugfs_remove was called out of order.
Ensure pi433 init & exit have reverse function calls order.

Signed-off-by: Shahar Avidar <ikobh7@gmail.com>
---
 drivers/staging/pi433/pi433_if.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 77e37a5bd1a2..67b945a41067 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -1427,9 +1427,9 @@ module_init(pi433_init);
 static void __exit pi433_exit(void)
 {
 	spi_unregister_driver(&pi433_spi_driver);
+	debugfs_remove(root_dir);
 	class_unregister(&pi433_class);
 	unregister_chrdev(MAJOR(pi433_devt), pi433_spi_driver.driver.name);
-	debugfs_remove(root_dir);
 }
 module_exit(pi433_exit);
 
-- 
2.34.1


