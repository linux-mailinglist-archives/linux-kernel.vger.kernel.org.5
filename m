Return-Path: <linux-kernel+bounces-141185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EB08A1B0E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67A9FB2CA37
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D665168AFB;
	Thu, 11 Apr 2024 15:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QOYryXPn"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6F31F963C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850175; cv=none; b=RJhCA+RMDTrH3m4KMmeyKlyj+RMLVhG9HZLIwzBchvyh6Vr5D5zQDzhjNcfx7hrA/Wu2ed09zalG2C03kUKS9hVX80FO8iLyeAqLazgC5hDQICsDz2cN5G3muadPXW4TL/an/zqPHn2nxktiouSjII9quKd9VPICEIedwQDfP6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850175; c=relaxed/simple;
	bh=pfD6fHF7FVHjS1MHW/1VI7SrO+gJwSfuNWDc9ChRNlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRqv40rretjniUs612Jx+Oyzk4J2Mc67kzEwCH1+P4qVLOfIqoO1emE4LCSA2DlS58BSUQOcic/HI5RqcfT+G9l4lsXX0kpl9UMNrT7J4hL3R6i6Y4kK9oawCMXra5WKrDdUd8tB9jrP0wNBND8y0BWNfMu3Okp4/+wz5jc5x8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QOYryXPn; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-36a224d7414so198035ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850173; x=1713454973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4f7bTOPbltzgB55dfgHaCSueh8d6mX2RrlOjiz80WA=;
        b=QOYryXPn83njHXwd1CYRLnvM7f59i+WtZZk1L58uBZO3EqiZFukJ5dwQkWpMPp1wVs
         ugj1rbwD6PtwyqvIcMUG5UizdDlLlPW0EO1EXEbIFveMkpkR+TDsnhwtw4GCdCxEicH4
         W/ziDFhJzNPuMXXzubFBNvfAhl26c8J268iVWq+8gMBT5Hf221TJ+NhDPgNd0LrDvHDn
         v7kiUt0MYNEWyKQM3OhbD4ACb4+f05gej4dGw4HCaPi6xW+nMgIzWG0Y/NsnN2/dbx/i
         MUrYblWIBrHJypoxWJsLXcGrqQXUJuIAiL+PYn+FTYHz2JTymc+N7kaKUd5nyx4/uyJY
         iN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850173; x=1713454973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4f7bTOPbltzgB55dfgHaCSueh8d6mX2RrlOjiz80WA=;
        b=JZUIPOom6aEGm/S+UJ+G5UKGT+9ZLtsCZTrymplzOqcxxQ+y64yucadRzMrzDFbdGb
         pR6T9hz+fbfpnQ+AERCpf6s4mG856ul3g2/4mwoVFwq8v06CB5dzxwM/TZez1P2c65W4
         K32FZYKkVYfMA02EWzZBWkp68gEk2nJt23ppfOOisLdMKjMKKbvYDDYbCy9dkOzG9+nN
         qd/9lN+6TKw6fwr82HpYGPerLeN6q9lHc/Uk94xPB8XHHzw3WxHMXeoJ/pkh6QcLQ5gP
         lXCCJ+hZ1n7DtBI9Dte/c87XO9044XGZqMWoBtWNMbZmpZE02CQz4iJ6mOTVI7k7DKa7
         fqsw==
X-Gm-Message-State: AOJu0Yz+ZGBKDAQ1rX+SJ7DFJU0XZ1L63EfQcONNzrlH4YNNFhFkH8wt
	UKlqDU4MERHmcbOcu7LN5TLJvKnQjAb65oyKR1Y/F36RSzqRD5ZNlHSRKJqj+5Ut2R0jqwkN9WT
	A
X-Google-Smtp-Source: AGHT+IFIrd9kFpu2g/k86D/zaKEIPA+uzT9HxvIh3MaA34ahizcFHWu2+ghbSRunZCbXv3OAtTwyGg==
X-Received: by 2002:a6b:6605:0:b0:7d4:1dae:da1a with SMTP id a5-20020a6b6605000000b007d41daeda1amr164676ioc.2.1712850171747;
        Thu, 11 Apr 2024 08:42:51 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:50 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 400/437] drivers/extcon: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:19:00 -0600
Message-ID: <20240411153126.16201-401-axboe@kernel.dk>
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
 drivers/extcon/extcon-rtk-type-c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/extcon/extcon-rtk-type-c.c b/drivers/extcon/extcon-rtk-type-c.c
index a592bab77538..70a83ce3318e 100644
--- a/drivers/extcon/extcon-rtk-type-c.c
+++ b/drivers/extcon/extcon-rtk-type-c.c
@@ -796,7 +796,7 @@ static int type_c_parameter_open(struct inode *inode, struct file *file)
 
 static const struct file_operations type_c_parameter_fops = {
 	.open			= type_c_parameter_open,
-	.read			= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek			= seq_lseek,
 	.release		= single_release,
 };
@@ -838,7 +838,7 @@ static int type_c_status_open(struct inode *inode, struct file *file)
 
 static const struct file_operations type_c_status_fops = {
 	.open			= type_c_status_open,
-	.read			= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek			= seq_lseek,
 	.release		= single_release,
 };
-- 
2.43.0


