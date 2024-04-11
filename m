Return-Path: <linux-kernel+bounces-141187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E379C8A1AE4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 929FF2869C1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C15F1FA5B7;
	Thu, 11 Apr 2024 15:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="d3EtQh/F"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E758168B02
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850178; cv=none; b=P/URWuQ8rEKALL1Jv9CYKobST/ehS5dkpjFL8QxTopLoxyEmphXJHq2W83fkbpla18IdsalQ9rnb/E+CSx6DGbr55AtrdGtf3j56sOpX8Hc3nrnQpyL9ibEeRDeWk5VwkyZ9ZRNUI2VIYuMS8uhqddEDPU4ud5NU7KB2ZyVxLqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850178; c=relaxed/simple;
	bh=dI/wSY85VOc4me9+Ccypl4dEBuPpvV3IXn6oIlQPdpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UbSu3O0jYuSDypTsGtGqxbdpsOwoeO4onMFOMRH9GyCh40gOnwJsVOm4/h9KUFAy28DaFo09262uV6YoF+d9UaUpnA1lWECbyoIfy0w/CgFrV6tVL6gerbL7TeUMyrzU7YmZP1wpkKBhW4q9gR/TmAC/lnkel0bRLjtLRPWusyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=d3EtQh/F; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so9106439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850176; x=1713454976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFHFSRHo+xB67r6Y72+flGGp03xzG9AA0yCqxsVjNFc=;
        b=d3EtQh/F+P+CxGgps1EjzduIlD+dew0mutY2/3f7TBSqhsAyntMO3Amnti37R/saUB
         wQ1ciBzSxL8SYeooT9JunXNWYXF6IYEYYcZqNUA74UKpxAycaflsFXmI8yeASU0ohGPe
         7nI5mhNLaoV/G8rtpysUM6PJI0+T2FozVQBpot0fejl1xahCimKLK2CjqC6ZAIjaP15K
         2+QAZwhAeF5M4tqiihv6ILyHyjVJrV8yUsLaqH/2OHLUXlLLroA/bDmg2YLMEoKZVeMc
         TK2EgLiSvLr/R2GneBNNR6FHBtL4CW0eJOUh/p6LKTTmXbyFG+i6sIKW5E57+Og83sV9
         /bMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850176; x=1713454976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFHFSRHo+xB67r6Y72+flGGp03xzG9AA0yCqxsVjNFc=;
        b=s3mbfsNb2ucN4hBITAel0iwgijrkarUZ/KqX1nKIVC1N3/WfNoeh5Kg2BhKinBBttt
         UMVU8erj72LYFSPz/Oa/lXCOGNCZGK0o1vTS5OkrlQTMugxDbauq9F/8w6wXaekXbPTr
         f75OsJyBkytu2N8wZQPlWYNyoDij/IcMTTwIsw2PmnZ7XYjbemITyAKcvAMyB71YIE2i
         d3++lGv84ZWl424T+6VuULlduoa+3mOy5RQpv9kyo1On+H8bDD9mNC2PBsmZF5P2r9vo
         otg67fKY3Dj+xVJZJl/VSvbOjF6l7ifERITxnzwf4uE/0ThelmkGVLKXx3ksza/Md14D
         L8xg==
X-Gm-Message-State: AOJu0Yzt+qgh79ojJg05CCYpZAKvo8BXR2EyAX285ufDOUsoVMmFucY/
	FdjILzJPC2STB59B/LvOQnJs7xK5MuEgWhhERfyUHlILXchVfBfnTr5y3WYJPL1f1NjYhpReUbk
	N
X-Google-Smtp-Source: AGHT+IEO3L9m/P0KWpeCWqzbWaDxeb5zpCEeiiGLOqLAIgSqxKNbgnmzCdlHOS47BZ5vrIgjWf1H8w==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr239836ioh.0.1712850176421;
        Thu, 11 Apr 2024 08:42:56 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:55 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Krzysztof Kanas <kkanas@fastmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 403/437] drivers/media/platform/mediatek/vcodec: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:19:03 -0600
Message-ID: <20240411153126.16201-404-axboe@kernel.dk>
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

From: Krzysztof Kanas <kkanas@fastmail.com>

Signed-off-by: Krzysztof Kanas <kkanas@fastmail.com>
[axboe: fold in patch for killing FOPS helpers]
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 .../mediatek/vcodec/common/mtk_vcodec_dbgfs.c | 21 +++++++++----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_dbgfs.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_dbgfs.c
index 5ad3797836db..b8e4779b32d2 100644
--- a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_dbgfs.c
+++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_dbgfs.c
@@ -70,15 +70,15 @@ static void mtk_vdec_dbgfs_get_help(char *buf, int *used, int total)
 	*used += curr_len;
 }
 
-static ssize_t mtk_vdec_dbgfs_write(struct file *filp, const char __user *ubuf,
-				    size_t count, loff_t *ppos)
+static ssize_t mtk_vdec_dbgfs_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct mtk_vcodec_dec_dev *vcodec_dev = filp->private_data;
+	struct mtk_vcodec_dec_dev *vcodec_dev = iocb->ki_filp->private_data;
 	struct mtk_vcodec_dbgfs *dbgfs = &vcodec_dev->dbgfs;
+	size_t count = iov_iter_count(from);
 
 	mutex_lock(&dbgfs->dbgfs_lock);
-	dbgfs->buf_size = simple_write_to_buffer(dbgfs->dbgfs_buf, sizeof(dbgfs->dbgfs_buf),
-						 ppos, ubuf, count);
+	dbgfs->buf_size = simple_copy_to_iter(dbgfs->dbgfs_buf, &iocb->ki_pos,
+						sizeof(dbgfs->dbgfs_buf), from);
 	mutex_unlock(&dbgfs->dbgfs_lock);
 	if (dbgfs->buf_size > 0)
 		return count;
@@ -86,10 +86,9 @@ static ssize_t mtk_vdec_dbgfs_write(struct file *filp, const char __user *ubuf,
 	return dbgfs->buf_size;
 }
 
-static ssize_t mtk_vdec_dbgfs_read(struct file *filp, char __user *ubuf,
-				   size_t count, loff_t *ppos)
+static ssize_t mtk_vdec_dbgfs_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct mtk_vcodec_dec_dev *vcodec_dev = filp->private_data;
+	struct mtk_vcodec_dec_dev *vcodec_dev = iocb->ki_filp->private_data;
 	struct mtk_vcodec_dbgfs *dbgfs = &vcodec_dev->dbgfs;
 	struct mtk_vcodec_dbgfs_inst *dbgfs_inst;
 	struct mtk_vcodec_dec_ctx *ctx;
@@ -133,15 +132,15 @@ static ssize_t mtk_vdec_dbgfs_read(struct file *filp, char __user *ubuf,
 	}
 	mutex_unlock(&dbgfs->dbgfs_lock);
 read_buffer:
-	ret = simple_read_from_buffer(ubuf, count, ppos, buf, used_len);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, used_len, to);
 	kfree(buf);
 	return ret;
 }
 
 static const struct file_operations vdec_fops = {
 	.open = simple_open,
-	.write = mtk_vdec_dbgfs_write,
-	.read = mtk_vdec_dbgfs_read,
+	.write_iter = mtk_vdec_dbgfs_write,
+	.read_iter = mtk_vdec_dbgfs_read,
 };
 
 void mtk_vcodec_dbgfs_create(struct mtk_vcodec_dec_ctx *ctx)
-- 
2.43.0


