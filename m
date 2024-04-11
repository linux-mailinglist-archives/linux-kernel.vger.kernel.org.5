Return-Path: <linux-kernel+bounces-140915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B706D8A1996
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D712857FA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EF4190682;
	Thu, 11 Apr 2024 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BUwdvZXQ"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA6E1836FD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849753; cv=none; b=ezxM3+UNN74Zav2ABDpb/Jll6qeYkc/UdMaa9HLGyAl7NH0Pdn4Ot8WxqotKrzWBNBd/2nHMdKpLe7RqEZYdKoD/YLd3e1id+IN7r8d6+C6Ffr+g/YzJfEh5hJ5+6m28I+1sAmziwImF9woG5aIrdV4TjrPteF6mDE7Cs6yyrVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849753; c=relaxed/simple;
	bh=vlkPlovNZ52U4T8uEy4BNRLC8J2EDTLI0Oesh/5coxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kmlt7U0nCAXP3fGFYFw9vheaikMRzdFI6AhKziNSL21UD3ysKXP8utiWPEwvYypaOKgpsxJ1rHWQQuMglSR98r0fDmIhlslmUSqP1HT9Shqpwg0lyOGHnHuuJ0yRF98ZZiaFEjTkqfP0zIlg1SYI3jOr4O+Nw3WyY0XWZ3Gwgko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BUwdvZXQ; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9784439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849751; x=1713454551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQzA5nP2JMWTk+IGmGSfrsH3b6kiTmy4C8RlssKIpE8=;
        b=BUwdvZXQJdtu8wPhdsLKPe26imb+vZ/X7JROr7UG3ZLA4LNf2ar0yHaBGXa4yLO16J
         BOXcvopP30gnonXhGNDXsHGEoLMBTXjd1nCvTxwJ5nJxCzxsuYlfozARj4BlUbJ7gzRF
         9u77w9WmfBPA9rgU8nbEJSD+oVJIDJ22F/E4sXeOQE/mT7AKNWyXOkDaS3dP1RJXqQLv
         BcfyYZIh7FwMDWV1vhXZTY3G5ALOmlSEEoVAhyk0LGf8Y7aVWoQNK9NMQfdvtcgD7Dyv
         EXBcEhxNIDRtQyA4bTCzmpZ1yQ2K3xaJ2FOKWilW8yJPGokAE8lNTNAPVwC/lgTdQVoa
         YyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849751; x=1713454551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQzA5nP2JMWTk+IGmGSfrsH3b6kiTmy4C8RlssKIpE8=;
        b=m9HqWboc6aJloOTTBOq3SMmle7LGTg2/r5ODT+aBasWIw+EKFV4ecjPMwm3HWtJffQ
         EtDp/MmffcBHggjobofg9j5wmEK3/3V839lHCQ5z9Tilxr/kJ56f0glQ7mDxcaULeBW9
         AmB/Hl1y6mlMbLmvJqAruqkDt79GYLZMy57azc5nGULuTuhGYEeDAyNEEdyoNJUSvvuC
         2jZFLD/mPVv5JEq+juBYDVrKqU0hw95qYF4JyL5pdtJ6Y9rq8ZrMTYCfMqMZDLm3SaOp
         PhkqtIJoOwWkn7lHS50q9EyoP3cRPpsikDe5Gv4G47k/LzF4V1k1muGL5vUONI64I1aw
         iQTw==
X-Gm-Message-State: AOJu0YyoWhS1sMAfHzfEd+D701/ABISJsUzVOEFN3ZLp+H8TSgmp/vcd
	ZiRfy/cpS8SnAjEjtAlyHBKdsLjZR/dSgXoj9xuhzXyiiXzJrmxN+mdoSSqNQBo9ZsAG2zd4jtk
	P
X-Google-Smtp-Source: AGHT+IHWgBp4WfLjP6VoCr+IbRXcycnXtxwlp7eM3UXIYxLWVAHpeX52uzugvvOEz5QxUINtj/U39g==
X-Received: by 2002:a05:6602:84:b0:7d6:9d75:6de2 with SMTP id h4-20020a056602008400b007d69d756de2mr40671iob.2.1712849751459;
        Thu, 11 Apr 2024 08:35:51 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:35:49 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 149/437] drm: omap: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:49 -0600
Message-ID: <20240411153126.16201-150-axboe@kernel.dk>
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
 drivers/gpu/drm/omapdrm/dss/dss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/dss.c b/drivers/gpu/drm/omapdrm/dss/dss.c
index 988888e164d7..2f0a3cda2c6c 100644
--- a/drivers/gpu/drm/omapdrm/dss/dss.c
+++ b/drivers/gpu/drm/omapdrm/dss/dss.c
@@ -916,7 +916,7 @@ static int dss_debug_open(struct inode *inode, struct file *file)
 
 static const struct file_operations dss_debug_fops = {
 	.open		= dss_debug_open,
-	.read		= seq_read,
+	.read_iter	= seq_read,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
-- 
2.43.0


