Return-Path: <linux-kernel+bounces-141085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD568A1A65
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C15284E77
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7D11DB52C;
	Thu, 11 Apr 2024 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FZDDejEF"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB881DA007
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850014; cv=none; b=oYWPU11nbTQXXhcmahCKB4CQQoHNg+8w1QGaGzIs0VFiOjL9pwkZZCfnGp03f8Kqf06g1GGiMfTqmCjB2oBOarT2i5oQxi1sdhPmdq6mbptocwMewNjKHqjQnEiplAwTzSYxWBfgnTahYtsGq+TX1CMlExJu+fTsr3uKQHB9yKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850014; c=relaxed/simple;
	bh=5zl6nzIuWlq9czwyq2zUon2yWwTfh7iogk+BETfNKxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZHUKmz24ywNCalbAkBM75qbAeAvefD9N+fXJN9nZXEGub2c7cN6TTsabq68fE9Xc/5Q3jxdfGb8G/b/3oEfCsFzQnQgET6/AYQVw3GzNJ8iIe3/WgRRGocQQONd1tDZASwA+BlGi0Q4u3zQ0HuX6eGzCEqs0Up3WEsrqymD2V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FZDDejEF; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so9040139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850012; x=1713454812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OZXlSeWjVCMHOcX2v1VMNOJ8Dbm+E1WqqonRpcahtk=;
        b=FZDDejEF1MnSBOMreAdTuHKV5BG+iQoM4T0qDw2ZJfEJESAGzCh6tLcJGxeU1jIjnJ
         kl3pjUr5w6NuQtYWUx+DtBrTvrKDUV4nwHAclHefYtJ8/80d8pAqyjnICCGJU6Y/dXbF
         jS7j8DiH7rBUzH1s5rNQmNFBw4JfqhimtHFtmPizK+75XuAGlRl4VUIKRWEYwUP4hDcI
         DZrVo9scYK/HzWplZ3dRl0rVaHzWUuRiOyjC+C+7RtLvweLAvQd+hRIdHxUWb0mBoa0p
         uVf6ntQU/bZFtr4oucELWLWqnFwIi72y5LbPv8bvHsrprJVuA2bj2noLn/IMalzDZYJs
         ccUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850012; x=1713454812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7OZXlSeWjVCMHOcX2v1VMNOJ8Dbm+E1WqqonRpcahtk=;
        b=fPjK6Gr+zUYqiqXgv4PIEd7+J/AyIrrg0p6ntipRTE3IY/QFYrcb8i11qpXQiEeK/6
         XyHOuyJeIi+pfD3NwkynOPgn/amxZw/Nw+dItIj/XqJNXsf6VmJQorPTLU28YRs0DnLS
         C8nwKaIZrHAfcMLS1e/xxEQCJobxTAkftsVDRaknb654pkcf21uQ5Iqt9AB42KVnLRrN
         JoLeNQgfsdXZwrDvVd6Ze2uOdhstcDTJagMLr6gfqtXbgSUEABtTGC/QcQUmdL70xqp+
         vHkloGp2UrW6jkHBS/UPXP90QxZBqPW+ZLISlGRpcQxb6O05QlV2XMo8WWG3QxnL0lAd
         D3/Q==
X-Gm-Message-State: AOJu0YwoAYqwoZTLh92Je4q1nRCrFIhP8cKa94cdhtgrZXFmYhEYL0Ae
	FdKKjDEjuOFujxKuzXX4wA5wJ1PP/VzZkZgn/HP4bpToiU9at5Ax7X4As83MW11vUgX/SBkYYpS
	q
X-Google-Smtp-Source: AGHT+IEPBDXCVtGYMG1NQiv7xDAkNPuyCjJ0NaFEu1RXHEZGAQvdvUH/7dKAXoSYOGEx6nMjBv2Xjg==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr232367ioh.0.1712850011846;
        Thu, 11 Apr 2024 08:40:11 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:09 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 308/437] wifi: rtlwifi: convert debugfs helpers to read/write iterators
Date: Thu, 11 Apr 2024 09:17:28 -0600
Message-ID: <20240411153126.16201-309-axboe@kernel.dk>
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
 drivers/net/wireless/realtek/rtlwifi/debug.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/debug.c b/drivers/net/wireless/realtek/rtlwifi/debug.c
index 9eb26dfe4ca9..11220484c4c6 100644
--- a/drivers/net/wireless/realtek/rtlwifi/debug.c
+++ b/drivers/net/wireless/realtek/rtlwifi/debug.c
@@ -66,7 +66,7 @@ static int dl_debug_open_common(struct inode *inode, struct file *file)
 
 static const struct file_operations file_ops_common = {
 	.open = dl_debug_open_common,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
@@ -411,10 +411,11 @@ static ssize_t rtl_debugfs_common_write(struct file *filp,
 
 	return debugfs_priv->cb_write(filp, buffer, count, loff);
 }
+FOPS_WRITE_ITER_HELPER(rtl_debugfs_common_write);
 
 static const struct file_operations file_ops_common_write = {
 	.owner = THIS_MODULE,
-	.write = rtl_debugfs_common_write,
+	.write_iter = rtl_debugfs_common_write_iter,
 	.open = simple_open,
 	.release = rtl_debugfs_close,
 };
-- 
2.43.0


