Return-Path: <linux-kernel+bounces-141153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926E38A1ABA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DBF28D538
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E1E1F0B99;
	Thu, 11 Apr 2024 15:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CY3gMhv9"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEC11F0B6C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850127; cv=none; b=cxIdKoqZd1D3uAyGKG9sKjx0O027Bz5DLo3CQH720mxcojesM7sbJr3Qr6USjuNBLJDze4iLHHvwtAWHgqxwHABBQx3I/jOif5hJn9ucAEpxbhSb4PyYwd27TCWhG3N3HjugvqHoZLO0Gns3O5yVl55dGtPmKS5T8IhZdD71aBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850127; c=relaxed/simple;
	bh=HWpRYWyoaUZ2U4fzX8sK97MS4hPQMcyB68wdiAXWcd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OBkHQV3N7WVHmv7K6PQkgPDcFFH7unWXfm5WdlhoaHdVacgPzLRktO0ifvCE/FOMtDi3vsHwMnYMxWpZS4m7kqajXREnJPCZ4Ss4rggbnZp8RV6AFUue56rTS90sNZWjDNLK579tR67F4djw5SQMe7L3Jr4ZiNV0szz2JxzhPbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CY3gMhv9; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170643339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850125; x=1713454925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJxPi8WmLQix200ePCP+T6VK310QZd3pEm6EroESoUU=;
        b=CY3gMhv9n4LVzVRrzRmw0HV2+MMsr8d/PdH1or0tTt45eabRc+QTxDqjjiHm505rpo
         qPQqrPhdMW3mcgyouWBBi/KL9DLkzrICL2ZWIzAdgSEDx6t8WLlUIgByA1ezVayABElh
         rLVU+U4anI8NKh3JBnAHoV6J7w/4BSB+qUmijoShvZAhy9D85sFvMTX2sSo1ZQl542RX
         9200N1VCfAxEADPRgITn/cShU2zJ2LkaFR5kLIhR4V//RhBhx+QGbVzuD/gdwqSGHjDl
         yLML5RzyejzdI4fPDzIs5gWRDBSuQGmZlMPLe52xInDyavUzSZkOTItZIQkih29ztD+p
         E7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850125; x=1713454925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJxPi8WmLQix200ePCP+T6VK310QZd3pEm6EroESoUU=;
        b=JAyZ3X7zJy8TQABywGUsH7+rQ4vNR9tOIxt9IhJXObI6nxKPkQOPfnK5pKgdjLSkQa
         kbG8TdW7CZUsxElpe1m1ax9HTGiCyrd5NQSUMjrVsFiFezusWicllmwLcKOw1YSoOYE5
         NUvKOkn5v8QDiGp1Z136B+uiDsGuRGlB2kHQzvWYmEZKgdbS/RFBZun9rqMmuC9hHOPS
         1eZ1KXwO+dPfT8G8pbU3aAe+nhcidfoeLy7QOFLVQi7HdAS3VUCM690uckrBdLcO/+tG
         PI+n1CjMzNsj1xMSQF1DEa60FR/WKm1o6lXFBtt6z1Aab8rm5BfeXak6i5D0RIASfIVv
         NB7w==
X-Gm-Message-State: AOJu0Yw0Ph+rgQBcAHOLWaGmI/34ZZUdFIg6SCTu0V/4DbkGZFYz89w6
	x9S9QRFzBQbRR/DoA1ZwjP4Xus3krnF+OzWvjdsxlEP9KgdVQOo8cAIGuQ/Mtm9KTns25CaaTiR
	q
X-Google-Smtp-Source: AGHT+IEW5qBY02Bryo2UNQ9fsWBGf1zoZLY2mkVh37eOaDpBhLgcDCe0JLvLYagskD6FbSa/Q9IIwQ==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr196739ioj.2.1712850125304;
        Thu, 11 Apr 2024 08:42:05 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:04 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 372/437] drivers/md: convert bcache to read/write iterators
Date: Thu, 11 Apr 2024 09:18:32 -0600
Message-ID: <20240411153126.16201-373-axboe@kernel.dk>
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
 drivers/md/bcache/debug.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
index 7510d1c983a5..6c28c8ca5629 100644
--- a/drivers/md/bcache/debug.c
+++ b/drivers/md/bcache/debug.c
@@ -169,10 +169,10 @@ static bool dump_pred(struct keybuf *buf, struct bkey *k)
 	return true;
 }
 
-static ssize_t bch_dump_read(struct file *file, char __user *buf,
-			     size_t size, loff_t *ppos)
+static ssize_t bch_dump_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct dump_iterator *i = file->private_data;
+	struct dump_iterator *i = iocb->ki_filp->private_data;
+	size_t size = iov_iter_count(to);
 	ssize_t ret = 0;
 	char kbuf[80];
 
@@ -180,11 +180,10 @@ static ssize_t bch_dump_read(struct file *file, char __user *buf,
 		struct keybuf_key *w;
 		unsigned int bytes = min(i->bytes, size);
 
-		if (copy_to_user(buf, i->buf, bytes))
+		if (!copy_to_iter_full(i->buf, bytes, to))
 			return -EFAULT;
 
 		ret	 += bytes;
-		buf	 += bytes;
 		size	 -= bytes;
 		i->bytes -= bytes;
 		memmove(i->buf, i->buf + bytes, i->bytes);
@@ -230,7 +229,7 @@ static int bch_dump_release(struct inode *inode, struct file *file)
 static const struct file_operations cache_set_debug_ops = {
 	.owner		= THIS_MODULE,
 	.open		= bch_dump_open,
-	.read		= bch_dump_read,
+	.read_iter	= bch_dump_read,
 	.release	= bch_dump_release
 };
 
-- 
2.43.0


