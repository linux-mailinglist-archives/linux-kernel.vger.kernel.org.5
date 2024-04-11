Return-Path: <linux-kernel+bounces-140818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B83908A1917
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2F801C21C14
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552947FBC3;
	Thu, 11 Apr 2024 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="x/KTf3BV"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC837FBB0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849603; cv=none; b=tljDmrUAILrQqejWVsdzus2Aw2DqT+CEgbqc5b1yEEMFB8XKqy9TY5kpe03Io6yhjPXsZ3USJ5OKOlKYnzn1f5p34p9j5I4HYPeU8QtffhH8kbB7Qh/6OAngSQPcK6rnq92jVQ7euFzywJRloGGEl83Lq9hoSMgKXPKycxksdKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849603; c=relaxed/simple;
	bh=+zTtp6NA4SHbH8H0M6K4Xl+0VEVe9wGeFSItGDOWGd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3nh2eQ39fVSSm3FmJ/nfAgZsboAU0slPghz070DX71+8L9x6KogotRLxlDo919tdwtYOXiq5WU0/ylA8a7jQEulMbX+ZIffK1ZlQmViA95bPPPvlZ/SzOg4Dpq1dkisdisRyI04O+FV5TmELBffhpF6n1MmKLjRVz4TBur28oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=x/KTf3BV; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d0772bb5ffso180620739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849601; x=1713454401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLAdAdRZHwZNysaGixn7u/LgA9hoPoumk3u1iKTi2oY=;
        b=x/KTf3BV4kZtTALifDWAQf1jFXMazdtDN0nQXnz3H83JmO4L4Bs765KMNSQ244yH7V
         GtcSXCxaCng/4yNFyCDuh6fJ+TMw5hXmMm+kvzo+FeuMkkK3u6nAKcbhMXto+mQDeEqA
         MG+gkSVsZKxTkYfqGw0IJd1CjHOlaIs1aaWvflym6/Lp6NdNqeQTCXefuKdo8S4gSo60
         kAIu4SVFrd0+NBh4x0YKuTkRsRjDKjF0jYVnGgRCqB0yl9hZ/XCFCmaPdGRWmZ0dbYhd
         18vOLaixbxamj83NPAFKtsV88WTRu1pDJVHATtd+QcVfdIaN/jRs/EwGBgx4tZ6V5tXF
         e74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849601; x=1713454401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLAdAdRZHwZNysaGixn7u/LgA9hoPoumk3u1iKTi2oY=;
        b=wo7CXeiURcWtUzIsMBTfKnwymoPyfXOuqk4FsH18MVT2gtwwXUfPcXjWM78+chlLVr
         zesMAlqM0n2PD2Ezymeref2PdLIqq+tgJdhyjtyplRjf3zkGi+1LsTEO2FZFpJklWYIR
         lyTRIj+hkNY8DBKrD2sIpsCFBnnz4bzqi1UO637muBGEy+FMlp5JqpXvizv1JI1EQaoJ
         zVh5Z0fQ03eYPWWIuIL7q01YfjXcov+nfZKP9DcdnKKE9ff7ATI7o+UCuWnls7z84zt8
         YQMPjqpm7zZbWNsQT+igsM+KpGz50Ezz4WKAAwa+VgLPlnuVtp6Bh9Ahrne0NcP7v2mJ
         1Iyw==
X-Gm-Message-State: AOJu0YxkTVJI76Pe/0A2pfeSrUUY7o0XjwcNXKo83rF+oE2Fgyk+PyGX
	5af4XyU51qt5P3LuxMvOej76XNnOrrOxAhWX278yTvYpuXpaMLVtIyG2iex1hpf4C70txIjBBsk
	u
X-Google-Smtp-Source: AGHT+IHs94RIFqk2tSa/xfrq5oIslDpMAMLG4Anc/WEmvFzu5co0Srta4X7hANVQkWlsTC8X8l4jJw==
X-Received: by 2002:a05:6602:4ed7:b0:7d5:ddc8:504d with SMTP id gk23-20020a0566024ed700b007d5ddc8504dmr181482iob.0.1712849601109;
        Thu, 11 Apr 2024 08:33:21 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:33:18 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 058/437] fs: add IOCB_VECTORED flags
Date: Thu, 11 Apr 2024 09:13:18 -0600
Message-ID: <20240411153126.16201-59-axboe@kernel.dk>
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

This allows a user of ->read_iter() or ->write_iter() to tell if this
request originally came as a readv/writev, or if it was a normal
read/write operation.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/read_write.c    | 1 +
 include/linux/fs.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/fs/read_write.c b/fs/read_write.c
index 1d035293607b..efddd395d436 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -733,6 +733,7 @@ static ssize_t do_iter_readv_writev(struct file *filp, struct iov_iter *iter,
 	ret = kiocb_set_rw_flags(&kiocb, flags);
 	if (ret)
 		return ret;
+	kiocb.ki_flags |= IOCB_VECTORED;
 	kiocb.ki_pos = (ppos ? *ppos : 0);
 
 	if (type == READ)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 483c70d3941e..69e4dfac2853 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -346,6 +346,8 @@ struct readahead_control;
 #define IOCB_DIO_CALLER_COMP	(1 << 22)
 /* kiocb is a read or write operation submitted by fs/aio.c. */
 #define IOCB_AIO_RW		(1 << 23)
+/* came from readv/writev */
+#define IOCB_VECTORED		(1 << 24)
 
 /* for use in trace events */
 #define TRACE_IOCB_STRINGS \
-- 
2.43.0


