Return-Path: <linux-kernel+bounces-112298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 974E9887811
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 11:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847E61C20DAE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 10:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0670A2941C;
	Sat, 23 Mar 2024 10:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tv2f5+uB"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B399D17585
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 10:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711190514; cv=none; b=riYfS3bVmp9U330PtKxB7iDhzcJhKZuYq6i2Usfg9CWuy5qC8qh2Ol1sMpKhSNdbCd/igA35wl+kSnUboW8amjVrJaRtDdK6Qi538VJ2emd7zoYhcpl+644nMBzHmyaL2MasN3wBjLT3q/v6GAfclYuLRUCcUsbS+usne2xGXnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711190514; c=relaxed/simple;
	bh=GEI/ooPR1uxzhyNgwywp7m8zeQWCBAmFv9ShGuGC3WM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T8cN4zKpPiqkvgEz0tTyZjkwh06Dls1UdyI6DhkT1jH7XSNNDpRgxVAeR/gUK0sbrCrscmE1UP4NcFiDkvxi94f0L8+n7GJ3udhYQAuAy9injgGmLjJwDi2WFkz3nqWVYdVkgU9yV4F5dO+L45VELDhK5hioIF7vxyuj6tTyka4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Tv2f5+uB; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-69107859bedso20060986d6.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 03:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711190512; x=1711795312; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MqD8wzexo6xit6zjT25NUCdriPsphWfFfa0tlNyYYks=;
        b=Tv2f5+uBv93MVvRfoVm2O8kRG3mojEdZIlp7HnN6hdomSBgI5qeTE6TyG4kC/jfqBU
         2Sw7By4TEqxXtjDSv1l3JagA9pvPfZw2BZkEyT1AqkwPtYojstR/N63qiDXbCm7SsPSr
         SD3r57QbWIjksbhZEnhEW4sL3nziVVZ41ZPVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711190512; x=1711795312;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MqD8wzexo6xit6zjT25NUCdriPsphWfFfa0tlNyYYks=;
        b=bZEIdUb+g8AWn6n0U3FjHW0OZv+im6ALwxYEKFi+e+j4L/D4QwWQAVAfwYv1u2sr22
         ZnTW8T4nVkFsgABBNY2Kwkv320lf8myptTwMmzrjQgJKXeDqwXViFVfuZaBw9CQDT7Gr
         xdlEhbb/fOsMdGm07Ajdn9q8Zbgn2CRUF7quNrLefDVBHSWxK7CkcrW9C5gKjgV9KQqk
         k3c6qiFa+y5zjFdJZKpUjvQOmpyjgJ4vQM/VvN57xw5HayF61a9WHa3xPYOf+c+SMuCc
         jZYb9PZMcq2SvN9G3yhrYiXtRlox+9jj3w/AyBtzEugi7kSkRB6SXuf3ARe5JaNqFLeC
         qz6g==
X-Forwarded-Encrypted: i=1; AJvYcCUyUML4FOrNdh45DS+e+x/lMhV5XGjmM6XaKXIB0KAdNY+kaOzNoHiWfOSxoITGC8oeoPVW3ndVwgH5pmSeBnqEB9srV3XqiQ3IIqjv
X-Gm-Message-State: AOJu0YxsVSUf+KdAhwoL/8YJMHeE1YVC6qDm19x3CaGWDTEW7lZ6iyjE
	HcV8IzFp6qJlYnul4gP4r8GILr9A317MF+UXoqBsGRmJD4tcqiRZDwGHGUaQvQ==
X-Google-Smtp-Source: AGHT+IFqiP6PxKrx0iNYkypU5fRxQ2Tg1JQsARpN7FhxoFv5VhxvCeHLgOCqbXVBG5RX/NkfTi463g==
X-Received: by 2002:a05:6214:2249:b0:690:c093:d833 with SMTP id c9-20020a056214224900b00690c093d833mr2314782qvc.0.1711190511851;
        Sat, 23 Mar 2024 03:41:51 -0700 (PDT)
Received: from denia.c.googlers.com (188.173.86.34.bc.googleusercontent.com. [34.86.173.188])
        by smtp.gmail.com with ESMTPSA id 6-20020a0562140d4600b0068f75622543sm1998523qvr.1.2024.03.23.03.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 03:41:51 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Sat, 23 Mar 2024 10:41:47 +0000
Subject: [PATCH 3/3] media: dvbdev: Initialize sbuf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240323-gcc-arm-warnings-v1-3-0b45cc52f39e@chromium.org>
References: <20240323-gcc-arm-warnings-v1-0-0b45cc52f39e@chromium.org>
In-Reply-To: <20240323-gcc-arm-warnings-v1-0-0b45cc52f39e@chromium.org>
To: Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

Because the size passed to copy_from_user() cannot be known beforehand,
it needs to be checked during runtime with check_object_size. That makes
gcc believe that the content of sbuf can be used before init.

Fix:
/include/linux/thread_info.h:215:17: warning: ‘sbuf’ may be used uninitialized [-Wmaybe-uninitialized]

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/dvb-core/dvbdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index 733d0bc4b4cc3..b43695bc51e75 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -956,7 +956,7 @@ int dvb_usercopy(struct file *file,
 		 int (*func)(struct file *file,
 			     unsigned int cmd, void *arg))
 {
-	char    sbuf[128];
+	char    sbuf[128] = {};
 	void    *mbuf = NULL;
 	void    *parg = NULL;
 	int     err  = -EINVAL;

-- 
2.44.0.396.g6e790dbe36-goog


