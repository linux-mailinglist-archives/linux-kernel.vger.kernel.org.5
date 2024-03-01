Return-Path: <linux-kernel+bounces-88623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E45DD86E455
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B6A6B23E4A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695C141C7A;
	Fri,  1 Mar 2024 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q0+ZC4T/"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0721B6E5EB
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709306986; cv=none; b=QTuEyxuoBJAtsQZYFYkOV8ygvam6uLYhNpXblJqsMKtyzIcE3EMjMkTnh7JcevkDgBL0PZm4zk6ES3+YFvZS8DX+iE4YyYNmhnJ0fR4SEIRnN5ZLMYGJ42prXqvjz9MlnZ2ArQ+d39Vt0TkhZ32IXHvUvGHECnXDgr0q+o2gp20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709306986; c=relaxed/simple;
	bh=5ZdVDMXs3mwTr4vWqpROwmQUzW0VeWSwZH0+3nB9a6A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZPhZ9ekPg27Q8G6pjsGLlvcY5RfwPflPSo9LiAI/675Sdbp5hnhrsMvZFNefhHddEDWSTiaZ1tdEEqrvRnuvZqDm79Vhg2SY+ts67pN12KNzWpAG2SbOo9Y/m5LCsLe7xGbFjHQdJKjVK7zsYHOfsWvrEHK9t7JXcv64GCob0jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q0+ZC4T/; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412c780464dso6095035e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 07:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709306983; x=1709911783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A9xdheLv/6a2bwYercXwXyeHsHuRfad0YKjyOjEInbQ=;
        b=q0+ZC4T/71iLdg16IhHSC/synJmVczkJseZeCNfmPn1qDFKotgzxb8wnW183Hgk3EM
         wiskBJl1jY28QnFeOVYfSztid724P2+7NW7Dw7pLIhaui2DD19L6Y68AwNQHsS8R7S2B
         igNXHQHn85NOvTSfiLaJIbOkb0eHcIPRMms1EPB/P2NrKdXjec+4BWUZn3IXtFbCF33T
         JyrGF8MttGt4umpZDpJ51pqEx/VTTEUuMKFF3VssQ6GX/2jfRYI1Ee0fWoaS0lwPG8h+
         y5wame0LMrmTTY2bAffdGpLVH2QhiiEfkF+4HFfn+vdc2V47Zp7ArEf0WazNRuxRsaIz
         Znaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709306983; x=1709911783;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A9xdheLv/6a2bwYercXwXyeHsHuRfad0YKjyOjEInbQ=;
        b=KvdjIxJ/JmqopI6Lj5ihxcyFrGIGTVIXNqGI++I2BFDdeoX1LUqKPbUSL22C+XXfhS
         xIdw9HDS4G160JqkaSMhN9ciSp3kYWOVUBtUTrILq4lFZL++WeVAqRWoHBbJAcd4QcKP
         GTWGKfz4hRmFUBEwramuK5cGOSHv9GC1AVguY8yyPDMMlkm7Tpeo3hjvraiJ/1AC7msb
         WvoAPIPvQhPBiF/vutoN19NBSCG/g08vyW/5gO02Rae38YY18DAEaMvrMNelhcuFSDri
         sNqlGVQdveW9wE6IT9CUmJYQT3qJxI08Y/uHRdZByQCtidwtZzvt+8VXuUIkgjw2aF7d
         aFig==
X-Forwarded-Encrypted: i=1; AJvYcCXn6gOXi1d37mzB5ELroPq/X1Nter1Iq3yjGt+vzo4U8HrDX1hNL9eVgJV2Wj8M+wYbIbyA0KpXNxv87Heoo32Jgs/cYHoslPskjdca
X-Gm-Message-State: AOJu0Yw8IDVuyS0gJ89KRxPJ2XSn/vM1epzcO98M37tn1jQ+WnOm8Kw7
	6X/X9F4bSvxNyzTndiYddjkVdA9Y4fBybAFJKj8Xo55Tj8H1u9z/U7cvSwoc5pM=
X-Google-Smtp-Source: AGHT+IGGv3plD+hCVhgRd5kUqoLDDA+4lOiRrar8lyoH+2ulD04zylW5q06PRdjlxmOjAeoNva3p3w==
X-Received: by 2002:a05:600c:4f83:b0:412:268f:1fa4 with SMTP id n3-20020a05600c4f8300b00412268f1fa4mr1731633wmq.1.1709306983141;
        Fri, 01 Mar 2024 07:29:43 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id jd20-20020a05600c68d400b004128fa77216sm8827201wmb.1.2024.03.01.07.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 07:29:42 -0800 (PST)
Date: Fri, 1 Mar 2024 18:29:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dylan Yudaken <dylany@fb.com>
Cc: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
	io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] io_uring/net: fix overflow check in
 io_recvmsg_mshot_prep()
Message-ID: <138bd2e2-ede8-4bcc-aa7b-f3d9de167a37@moroto.mountain>
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

The "controllen" variable is type size_t (unsigned long).  Casting it
to int could lead to an integer underflow.

The check_add_overflow() function considers the type of the destination
which is type int.  If we add two positive values and the result cannot
fit in an integer then that's counted as an overflow.

However, if we cast "controllen" to an int and it turns negative, then
negative values *can* fit into an int type so there is no overflow.

Good: 100 + (unsigned long)-4 = 96  <-- overflow
 Bad: 100 + (int)-4 = 96 <-- no overflow

I deleted the cast of the sizeof() as well.  That's not a bug but the
cast is unnecessary.

Fixes: 9b0fc3c054ff ("io_uring: fix types in io_recvmsg_multishot_overflow")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 io_uring/net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index 926d1fb0335d..da257bf429d5 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -559,10 +559,10 @@ static int io_recvmsg_mshot_prep(struct io_kiocb *req,
 
 		if (unlikely(namelen < 0))
 			return -EOVERFLOW;
-		if (check_add_overflow((int)sizeof(struct io_uring_recvmsg_out),
+		if (check_add_overflow(sizeof(struct io_uring_recvmsg_out),
 					namelen, &hdr))
 			return -EOVERFLOW;
-		if (check_add_overflow(hdr, (int)controllen, &hdr))
+		if (check_add_overflow(hdr, controllen, &hdr))
 			return -EOVERFLOW;
 
 		iomsg->namelen = namelen;
-- 
2.43.0


