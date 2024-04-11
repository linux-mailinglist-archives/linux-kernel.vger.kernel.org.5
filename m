Return-Path: <linux-kernel+bounces-140980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF728A19E9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F15591F26D35
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189138248E;
	Thu, 11 Apr 2024 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="w6HQfqMq"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1DC17CBFB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849855; cv=none; b=tXQPXpy9ncR+ZEPgNlEmxccccD7hszQuSOoA/fXGnpU8kt66aZO/TM0xhz0NBtyuIRGVE+klKYV8wB2/mMEBv9lc441j/J1e50gLh8GEXo56Ki0lU5CTh4ef/I2VmXiMBDQsZqXOrkS9KYfh4wzQLoIYmRYO1AIQtpUnuOpPmOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849855; c=relaxed/simple;
	bh=RYfj26rwOD0NcTI7naAxIxhbDaPw//slAvca4bWdwoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sb0xduM+c5teTRhoU+Ef6ig7VUq/hDNsgn8Gv7CSum5unupUO1G5JnlgvL6NCKOiCeh5soKKo4KNcRaJCiNk6YvFUyN9ml9T6on275U3B+gOXu8gWa4RGR//eQdAeNN9JPT5sIV4O7r3MNKCa2RRn6NIuakhptXgzd2PbuliVZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=w6HQfqMq; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58106939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849852; x=1713454652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYTio9cuTG8IqodR8qPe4BDqonf+sOjdiG84YSGYG2E=;
        b=w6HQfqMq7inW1aO+TdJd0bUbZmJNQ1auJ1I9M6QC8zC2JBfwbexT4623RI/E3XHpq1
         CD9n/YXwrq86xgS5WodQRbZAHZiDgjCDzdsLhC/zy2IOxO1QQh7pj1p67E77RvMBF6tC
         eYwe4zNMpGhONbGPe2QtVY3sRNcv6GothOTrvxAXmgXq6QDMwxiK2DOvSmE/GpuUhVOC
         xJmSH+wGsPO/rmkj0XDy2XXh1UM17BHY7o6odZ5fKMQ6sbPLychWeFmtsg4WNljRNVDU
         UH3SwdK3+4fYILZI4+aJdYV1FxUICLrW89BS3T4w6WPFDmgbmqBiDFDctvHTjGNasf7T
         otUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849852; x=1713454652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pYTio9cuTG8IqodR8qPe4BDqonf+sOjdiG84YSGYG2E=;
        b=OSAJbIzW+GVIeSyIfNMaB3/ulzpygG/ZrilBQX9uwOY3Wp1v1p81Cf1/Wwve+OHvV1
         1TVVxeAM54m2Kk7uxkefEtt7dJW8+X5LMGOlMlJOh3ICg7KOx6TcBcuCK4IYDQLzJwMf
         u/jznxKlch+klCzJJ1HDgq/ZNuiCmoZFlJ+Yr23ZhEiQv9c7E6X/cMhPKaHRRMfIal/e
         I1u0O5BT1jgXm/rhu+zIAAYzw3d9nRhAicR+qmEphDN5OJoU/A67lM5/k1WXfc1r+kpL
         eLCTcrIQcISSOM8Y1uiR6lmj1dRn9QyptdDkM79Ditz3oc7g27Fr4GRFkDtxJffdYt/d
         AbmQ==
X-Gm-Message-State: AOJu0Yy/wW/+Pki7Coam4kc6hBvEpHVNceG39GQjXFE1VLpWtqhq4Qp1
	zEnFc7hdC/5IH7oU6DwDEkuJ/6K/C7TgXLtc0gBdxpPOh6ziilE7BcaTDybIQ1hkFH+/CoOx9rz
	f
X-Google-Smtp-Source: AGHT+IEcj/GcF7xVAU2gaxvOoFIGX2VqxiPCzMNztrOzGIShRqSzNTT7SlA/dtk4NqkLbxMyB1276Q==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr165045ioh.1.1712849852377;
        Thu, 11 Apr 2024 08:37:32 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:30 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 210/437] drivers/iommu: convert intel iommu to read/write iterators
Date: Thu, 11 Apr 2024 09:15:50 -0600
Message-ID: <20240411153126.16201-211-axboe@kernel.dk>
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
 drivers/iommu/intel/debugfs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index 86b506af7daa..8655098a3a17 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -679,19 +679,19 @@ static int dmar_perf_latency_open(struct inode *inode, struct file *filp)
 	return single_open(filp, latency_show, NULL);
 }
 
-static ssize_t dmar_perf_latency_write(struct file *filp,
-				       const char __user *ubuf,
-				       size_t cnt, loff_t *ppos)
+static ssize_t dmar_perf_latency_write(struct kiocb *iocb,
+				       struct iov_iter *from)
 {
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
+	size_t cnt = iov_iter_count(from);
 	int counting;
 	char buf[64];
 
 	if (cnt > 63)
 		cnt = 63;
 
-	if (copy_from_user(&buf, ubuf, cnt))
+	if (!copy_from_iter_full(&buf, cnt, from))
 		return -EFAULT;
 
 	buf[cnt] = 0;
@@ -738,14 +738,14 @@ static ssize_t dmar_perf_latency_write(struct file *filp,
 		return -EINVAL;
 	}
 
-	*ppos += cnt;
+	iocb->ki_pos += cnt;
 	return cnt;
 }
 
 static const struct file_operations dmar_perf_latency_fops = {
 	.open		= dmar_perf_latency_open,
-	.write		= dmar_perf_latency_write,
-	.read		= seq_read,
+	.write_iter	= dmar_perf_latency_write,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
-- 
2.43.0


