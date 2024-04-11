Return-Path: <linux-kernel+bounces-141194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A87438A1AEB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 629EF286779
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40121FBC30;
	Thu, 11 Apr 2024 15:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Z+aYVMjN"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173C91FBC03
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850189; cv=none; b=jrQHsq/Ji+U5IDw6RBJEzZk3R7ky3iR1vpMT/T/Jioi3+eNXim3xYBprCWGlod8wCW8EcJ2yh4UU97goVwRrWYskg3AEOQNGuPRLc4wiYwnut3w3Ure39JmmTvU1u5UxgY0YbMWl/0Zb5ErsJOl7k/5sU2mPGlSrosvD0cokc8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850189; c=relaxed/simple;
	bh=z5t/sLd8xrIg10379kdNTqq7jWFFn1DIMJwJEDt70nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lSCPMqyc8McpY40wfRCjC/xSuHNXGPt+fzjP8wcmcg+mCT1htjuPb2VfliYs7IsRdTSFYnSy0FyUQh8o8Nz0YRwYEa/y6uedte8P7zecKWFOojxuUXOJ3HeQ62tksYQn59J1Gyc7BgesCJIX/0dSEs9W7q72bXTMlB+qWnZ7ABo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Z+aYVMjN; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so9109039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850187; x=1713454987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNXi0uR6GYfH8PKwi/oyy/OsiBdF2NS80OSMklOKL+A=;
        b=Z+aYVMjNg6a1BrCTCWwydCDi9NvX/0/nnrahPw8hp973J+5wtqblG1bmu+76zRAS9n
         5+ljS0rM2MooFiE0gwEwGqpsas8YHsnxE8Nkw+gSEFP+TkuJ1yX7Fkj2SoAP43TX91FE
         KGjIzpo2KEdZvNnbw8EY6ZwmDerBIMZKQwvUCXJtFNzusLnNGJP0O3SCS4T/qJQ0V86z
         pA8czwTUk5IYiK1psUGbWnEAy16CI2qabqnIyU6JiHDTeC3zQOB69zwdWptpE4W1FEyb
         N4P4V2DTOa2c3g0O42pf5kVvt4b+lxp5exeF3SaaXFYENyILV6QJAluKA62kU/AO7dBR
         8aRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850187; x=1713454987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNXi0uR6GYfH8PKwi/oyy/OsiBdF2NS80OSMklOKL+A=;
        b=SqQ4S9oV0D4A24ah6ZK4HJHuuQ8jdmEgmBNIlq7sjGcFzV8c5dr0g4Bll08rV5C8ZK
         rvr7ptRO7OW6Rppmq/+POJsH5Mvc1i88vzdqe4fXvIoZB4S9waD0kyz9+O7YAe+veJe4
         ah9QSoJSUanvMJwwlTzQca5X3DNmpKIZmRysj6cXxGoXqzk4SkRPE5JzUSnmIKSUwN8h
         qmxpgJKMmUkQbmCv06an4uboBXd+l44pI3bR+Kwu0tpRr2Gjc8+N1WMxcD48h6zeTq79
         hzCZXf8iT0IJL2lONGdgMxJLBdcjF5y8jJm9QjiGajyk84TP2l4AsSRmgvT1mCtPCU95
         2FUw==
X-Gm-Message-State: AOJu0YyFfnjctp1R+LQT1rthkEm6r6hVJCTS0wYv2KwyQGEP5CKwkmio
	mLN9aJM/h0BlE0r8O5KRlkWbd0wxL6V7/YDycJc7RA5Z43gyqxuLObltbUbW0yJQdV5CtgtpGUH
	p
X-Google-Smtp-Source: AGHT+IExKGcurTPI2O9n9CQgf+MOCyTSgJT617P2Olnfit/5/vZPvxZOhpTYy/l/IRUpyNjfySKH2g==
X-Received: by 2002:a05:6602:21d7:b0:7d6:9ddf:5095 with SMTP id c23-20020a05660221d700b007d69ddf5095mr34914ioc.1.1712850186989;
        Thu, 11 Apr 2024 08:43:06 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:43:06 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 410/437] infiniband/hns: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:19:10 -0600
Message-ID: <20240411153126.16201-411-axboe@kernel.dk>
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
 drivers/infiniband/hw/hns/hns_roce_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_debugfs.c b/drivers/infiniband/hw/hns/hns_roce_debugfs.c
index e8febb40f645..102ccddf598a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_debugfs.c
+++ b/drivers/infiniband/hw/hns/hns_roce_debugfs.c
@@ -21,7 +21,7 @@ static const struct file_operations hns_debugfs_seqfile_fops = {
 	.owner = THIS_MODULE,
 	.open = hns_debugfs_seqfile_open,
 	.release = single_release,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek
 };
 
-- 
2.43.0


