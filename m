Return-Path: <linux-kernel+bounces-88624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C08A86E458
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45CB61C232CE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA8D7004D;
	Fri,  1 Mar 2024 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iN+Gj8BL"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4216F53D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709306999; cv=none; b=hWPqoz7/6N86IMsJYdKpUpTxjCKZGikPLBh5PjiGmaxCC10SaNPpaWFqs34mln5FPbDMDBAMQJ7JLvW9lBz9e87kUlhHqPIQ756O8HqYLv0vmiwBf9URfNvi41Ech/vwMtUKO8+MfoejjkjGsJvhYVZXHlqhkZbf1kJcIiQiVZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709306999; c=relaxed/simple;
	bh=zh1tMmI9C8esm9t8S5ODtHnOIgNunq7h2YrtfEFvx/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jau09z1RQL9UgFA52xxbzLADu2wb3PJgSSC8CLSO5yTKtqQ2L4/ItpueXhG/o4roaxIyXL5Yx1bfhPdWo7DEEsoui/yEzjnhD3psZkaEEJcAfUVyKtUX/GlDq+F8CDG5Z6++2PhOTp4cL+QHz+u7gUAwykoM5SXmRJhdsjQ/lZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iN+Gj8BL; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d275e63590so29904021fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 07:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709306996; x=1709911796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LwF1vEHHtNcLEL22JU7CbamIfjcY0v8w9f8KAiAGRpo=;
        b=iN+Gj8BLG7HaTyiBwK6YrhMrrIGiUH1KBbRM+WYLGIStLQUsdJiiDT8mAnZhyYDe0i
         c9M/sZSyJC3TxXEIAeRBVuAiHTKg6msl4k8SgObymvgGho+tdkul7JSAZm/ZYzpidVMj
         bFm3yJByorJR58EPp23wAxNsFc+DU7GFkuwsCqsUh+wbHJGPOINsql66cjrGOomlD5fw
         FSgwzISi1HG0hbsWJ2v+R2XowxCCzXND8GW3lWvgMt7eAH5bjqfc1XQXD0f37mVJpHIB
         1ktYZPekGQZubSeNJiS8/IESaCq6PCGWpPnL9Ib2y9V6zRIToV1fOpdDRSbUsDMLAjY/
         HVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709306996; x=1709911796;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LwF1vEHHtNcLEL22JU7CbamIfjcY0v8w9f8KAiAGRpo=;
        b=Bj4ww0/uY6aNPA9BOFPc/2sBPJFrDpmpc9EmnthBvpz7+2IC4FGXwQkiNo35m7z1t2
         /W6yojUtTe/LXTJ1y/U9l7S6jED4H291fgS/aNaLtcFih5T4LUjRJHWTutG9njiLvHe5
         h+pE+c+tYDrfuh3VdBk78JnqrbLi3++MvmfoPoTuE7JHIMTXjyC4JgBmJUXKBJHJ0VJZ
         8LkCcMJViTzBAjlXFnsPL6d56Df41wb9EnnajoOrNHo+7z23MnEGk6IfJD9PTom6N8Sd
         +KkzIBN1GQeolGs4Bdr0XOTzhkpuAs2UJohGWrNmWrYBdgQP7G96pY2/HpVt7gVJ94yr
         aGag==
X-Forwarded-Encrypted: i=1; AJvYcCVx4qgCgTP4LvcakLqYo3WOFMnjAk+NZ9JMNPztgy+w4h6F9UfO27EXH3MgIxChTP1oJnSHrOEPInJ07zIYTA/ZThp9gMTI3kSPbu/U
X-Gm-Message-State: AOJu0YxEIlHGJCwwueqeYaFR6ZYnt2QQ0/5VDUIiOnc5xkK4J4f7mJmA
	uI6IZXFF7ZF5D8pciMK+M+ytvmMqe4A55paB9czt+9WpTCqXpeNjJvdD1rvs05c=
X-Google-Smtp-Source: AGHT+IF+EdHbA/WMtHbEnW0MVWTX37KjpNSG/+lUHF/XBnrsQVeoc3UrADapsOV5vobHj+kpeNESiw==
X-Received: by 2002:a2e:2404:0:b0:2d2:935a:7a3d with SMTP id k4-20020a2e2404000000b002d2935a7a3dmr1312182ljk.34.1709306996297;
        Fri, 01 Mar 2024 07:29:56 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id g8-20020a05600c310800b00412b0ef22basm5835531wmo.10.2024.03.01.07.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 07:29:56 -0800 (PST)
Date: Fri, 1 Mar 2024 18:29:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] io_uring/net: remove unnecessary check
Message-ID: <3d17a814-2300-4902-8b2c-2a73c0e9bfc4@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f5d7887-f76e-4e68-98c2-894bfedbf292@moroto.mountain>
X-Mailer: git-send-email haha only kidding

"namelen" is type size_t so it can't be negative.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 io_uring/net.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index da257bf429d5..04a7426c80d2 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -557,8 +557,6 @@ static int io_recvmsg_mshot_prep(struct io_kiocb *req,
 			  (REQ_F_APOLL_MULTISHOT|REQ_F_BUFFER_SELECT)) {
 		int hdr;
 
-		if (unlikely(namelen < 0))
-			return -EOVERFLOW;
 		if (check_add_overflow(sizeof(struct io_uring_recvmsg_out),
 					namelen, &hdr))
 			return -EOVERFLOW;
-- 
2.43.0


