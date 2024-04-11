Return-Path: <linux-kernel+bounces-140821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087758A1919
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3264E1C20F4C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1CA82C60;
	Thu, 11 Apr 2024 15:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dnOSiAgp"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4677FBB0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849608; cv=none; b=SBdhsZVR9N7mWC8GPtwd4lBrzSeqWdgX4yP+iVIfvCag+T+6LozVzU66Qo3tHmeu6Pyh2dj33XHZtVOSJhiVTFy9vgsfh9cKk7NG+25tplFJ/2hcvv1RKn8SLgk6O3Z1778gFoYL1SsoyUPttQZE6RtxLzjGDqApskT8ZzqgMAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849608; c=relaxed/simple;
	bh=ixAxhsQ5BEDYRb0oFjH7cCMlrYuKljtAZJNh9CQ7ETk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ud5p1YJdOZPqCx49mh0XnQFz8eo2oXCizb8Q3DTRZXrb3DdR8XkcjWA7WC6T6pLjEl0bP2qItQLzbTqedob8IM8ioEp62SByFG2Xw2tcTAnLLO2u1BTQ8UfMQFYa5C0BdH25vKyG3RIXhT685g5BE3FBvCHakcIOGaD6gLnYKcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dnOSiAgp; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-36a224d7414so177825ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849606; x=1713454406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPq3O8JL5wt2QNsDusZeSAcsf+5km/B4tpNnOzV1qYY=;
        b=dnOSiAgpNHmTLY5/0kMWHuvrzjiaryUcAGxy1Lqnsq7RAtVOuriYSsFy4zSxy4KVEj
         zR6QD96xbNMC4Q0mkqNrNTgb/4hYv8aaTDBQITvoZ4tvEjfcd2WdNnp0gyd4tOJ7km7m
         9y7n7IXdJGj3Gcqriidtj0wqZnN1Qfwqn3hYxcFqyQy15Cnt61B1tNIpIH5ONnoz1tw8
         I3dGc2iuHns8l43b/JRzdr+ZXTPT+xoZMIoWTGYrCN6C0lIxQ20h3MTuTNPfvm5lY0Zh
         1PC6o4BhjkjM4rWyNMR6Ouebj8oQJfRLUpls/7Vb+dvp6RD40T01om8jPWKCKiRHrqnV
         p6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849606; x=1713454406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPq3O8JL5wt2QNsDusZeSAcsf+5km/B4tpNnOzV1qYY=;
        b=wuMR1W8vsBmuTr+vF4dMV4vnoa1pIlfUHxTTguvgZsPRLM0vyHMuedw3cAsZZhKP3t
         6akaO8EF4JHXtqMe1CfATcnity02ZZoyq1FdNpd2rwqEPhcGiau0p9i7QDqxDmnIki9M
         l1LKBmWWyGhZSNU59g8DhJTVwq5pybPrOp52zoRDGHHyglnlJEf0hUmDCnEaTj7jlwNm
         QwMhgahzrt287FFiANOidFJxroIBUB6BbqiXqmH6TIR0q1iTa4pPLBdX7PKizR3xhoJ6
         Rsuu3MbWc/ri15t73LpVcZAW0xsfcHzGiF17axR6zVkDiRcs2UZmrAJyeV2VVau5yJdu
         BN5w==
X-Gm-Message-State: AOJu0YwS9bgB1/ctUYmbtDUaaa4nPkIXVzn5PRJepz3Ui6AETMul4B/b
	tly+Q+SmXz/nTZJ5AKROgIJBJHfU7JCisAWwV1jeLk/QULY3slrrpYJrk9QbBgQ+XaLIe/dPxNv
	k
X-Google-Smtp-Source: AGHT+IH5t6HtZHh7e9CZQsUccf+2a8Au74rt5JiWF7yyJbw+ZFDyhLcAVWljcPHRfzIKdBqtqS+xAw==
X-Received: by 2002:a05:6602:4ed7:b0:7d5:ddc8:504d with SMTP id gk23-20020a0566024ed700b007d5ddc8504dmr181723iob.0.1712849605692;
        Thu, 11 Apr 2024 08:33:25 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:33:24 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 061/437] ASoC: fsl: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:21 -0600
Message-ID: <20240411153126.16201-62-axboe@kernel.dk>
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
 sound/soc/fsl/imx-audmux.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index 747ab2f1aae3..479fd59e329c 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -53,12 +53,11 @@ static const char *audmux_port_string(int port)
 	}
 }
 
-static ssize_t audmux_read_file(struct file *file, char __user *user_buf,
-				size_t count, loff_t *ppos)
+static ssize_t audmux_read_file(struct kiocb *iocb, struct iov_iter *to)
 {
 	ssize_t ret;
 	char *buf;
-	uintptr_t port = (uintptr_t)file->private_data;
+	uintptr_t port = (uintptr_t)iocb->ki_filp->private_data;
 	u32 pdcr, ptcr;
 
 	ret = clk_prepare_enable(audmux_clk);
@@ -119,16 +118,14 @@ static ssize_t audmux_read_file(struct file *file, char __user *user_buf,
 			"\nData received from %s\n",
 			audmux_port_string((pdcr >> 13) & 0x7));
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
-
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, ret, to);
 	kfree(buf);
-
 	return ret;
 }
 
 static const struct file_operations audmux_debugfs_fops = {
 	.open = simple_open,
-	.read = audmux_read_file,
+	.read_iter = audmux_read_file,
 	.llseek = default_llseek,
 };
 
-- 
2.43.0


