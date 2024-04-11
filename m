Return-Path: <linux-kernel+bounces-140792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 040718A18FE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3041B1C20F06
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64C256B7B;
	Thu, 11 Apr 2024 15:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bigPtRtD"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7535645E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849549; cv=none; b=eRQ4Nww+2JTeb3lU9YH5/NNsvf473AVQ2MmWsCGlLM5OIYEBnsydx3D3SPgIXoVgKWR4enh/3sYEsUc0Db3nNIFzlo7QOXIgsDBozaltcljC1yB6XRlApLk/1/LNBrj+axnIHrqV5OOf7xLH1Z/Xz2S4Axeyrm9PzP8stRS6mVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849549; c=relaxed/simple;
	bh=o+qsAzJS440SymviPGy/fOwRbpcVojQucXIaEMr+2Dw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f88THiujO5xNjnenKaVTN7zojQQDTAQ2Rgm7pbzXNEF0A9OScvS0itFKZp+H/Iwnc4RiwUzeQx3ou4yCEucocEhODV6fxS5Lv1kb3mKZ5cE/ubUrLaK/SSUVkbXHCFVyj0wX8c1jHjHGMsxxBfMjKZzq31opiuzXh4uUFTvSRpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=bigPtRtD; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso57949139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849547; x=1713454347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVaSbL/N5pzoM5XDW5UBpSsORrcFxHXToaNbhKwyBxc=;
        b=bigPtRtD1cEzH7ep6qFjKDPYu3h40xHA5UmDOrmEQKLDix93HPeJt5UuTdexovl5j8
         PvA9WMqDH6BO3Q8lovdmozN59MoNPhZ1D/3nBsk5hGgwkEu8ztSudS0gva6/ZT71UD1q
         GU6bd+VY3StUSOoJKsPWg5GmpLMN3TlU3Lb8wGaEQHtUubE4oSitD3e6CU2WVIrzWMIL
         EOAXTfOXg8YYYlnhkRK1qVKeMfIHjKAyEekgvxq9UYd45IYOqe7v/FARKEtLNSFpVZvb
         ppFtIVTy3SmPaaY5yj3n1Lb4CPR9JtRGu2K3xPDEuWvNdDGgNZDxXr4E4oNMGVpBiRaM
         fMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849547; x=1713454347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVaSbL/N5pzoM5XDW5UBpSsORrcFxHXToaNbhKwyBxc=;
        b=Zsr8ebL0AMTaf15NuF3X3usk3Z0UWaX2iHFKqhTgsVzmLqmeO+8FDJ1pY64qJkXbs2
         xX7zNWle4kIQOngr+XICEbhpGFts30TrNY1gIf84C6/J3d1fmxceV3LD4flbIJqDdseq
         I6nAnnsTh9SXBfwq+1saFdq+n67zDYynR1aaFaqaxHYSa3A14NCUJQRflLwbCEkjLSHX
         1gvwjVlYGKEmlspZJ8SxkuGQudWh/LptxX90nePR5yzv0AtoKn5UIXuiEhkjbBPrYDcH
         eZGH/ZIr6XprzZTZfhpNuUkrm2NC2Q1JN2Vr4Ncfta9bN0PfLzpA75OjNi7RAUP/20/8
         ZyZQ==
X-Gm-Message-State: AOJu0YyxUHncIU/Wx1Hyikoa+tmdW304SDLD4q2KEqa8r3IMaQsDV6DX
	xoT0BGiSVa8dLDKe+/la9VEa+91SP9Y9ky/mNrRqyjKYa2/Qvobdzr7D2kJy+zmi6Zy5EsEHVJv
	u
X-Google-Smtp-Source: AGHT+IE23mYS9/XbxcRb7XHlTtW8DHdWWUoLTo99TnhoJtnEwbR2JfldPnpndBVEgCUKIcdA0KBTug==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr170536iov.2.1712849546722;
        Thu, 11 Apr 2024 08:32:26 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:32:24 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 034/437] char/sonypi: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:12:54 -0600
Message-ID: <20240411153126.16201-35-axboe@kernel.dk>
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
 drivers/char/sonypi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/sonypi.c b/drivers/char/sonypi.c
index 22d249333f53..2bb9f0a17989 100644
--- a/drivers/char/sonypi.c
+++ b/drivers/char/sonypi.c
@@ -925,6 +925,7 @@ static ssize_t sonypi_misc_read(struct file *file, char __user *buf,
 
 	return ret;
 }
+FOPS_READ_ITER_HELPER(sonypi_misc_read);
 
 static __poll_t sonypi_misc_poll(struct file *file, poll_table *wait)
 {
@@ -1048,7 +1049,7 @@ static long sonypi_misc_ioctl(struct file *fp,
 
 static const struct file_operations sonypi_misc_fops = {
 	.owner		= THIS_MODULE,
-	.read		= sonypi_misc_read,
+	.read_iter	= sonypi_misc_read_iter,
 	.poll		= sonypi_misc_poll,
 	.open		= sonypi_misc_open,
 	.release	= sonypi_misc_release,
-- 
2.43.0


