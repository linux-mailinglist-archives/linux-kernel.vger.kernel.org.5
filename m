Return-Path: <linux-kernel+bounces-117291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8763788A9B5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9E531C381BF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3612158A06;
	Mon, 25 Mar 2024 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VgUCYr2k"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960E213248B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711378231; cv=none; b=OeObjozxIWlcSqK0X3QZNVfOMUUlSRJTfxkDq/7ONnEmgLFtB0lrhesYCSbD1ARovLmU9eP8au2Yq3IJhD2VwSOXkTToTg5QwX+i50diIE60R9ZYEGiMLKy0SG5xz9b4qVZiaPTUWSnVDFJJyZT+JCGbulHoP6tY5i+z0XbNW1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711378231; c=relaxed/simple;
	bh=GEI/ooPR1uxzhyNgwywp7m8zeQWCBAmFv9ShGuGC3WM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=prxLTj8ctkpxDkRnmpmNnCbS2LetRQpyZyM8VoDln6TySiNCVexIDcCYgjLnyRv/nS+iN17znbXmTgfsWUW/KgqtTUxC4FUKBFZ4krs5LaQzlBI2aDBfj4/DjqzcgqEUD7mw1Sqx2ebTlDnb2zZsXi1lYBOrxNeuW1N/aijs1ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VgUCYr2k; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-430a25ed4e7so30128361cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 07:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711378227; x=1711983027; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MqD8wzexo6xit6zjT25NUCdriPsphWfFfa0tlNyYYks=;
        b=VgUCYr2ktZ2ZnLPpj1w6jKHNBU0Smcz4R5UlwEf+LObLXyS5zOAiLplPSImgdBgil5
         vJw/JdVdSHt5OunlKR0Jqif4eYLGBwwAhzFekUuDVUvJ9hU3dYZ/BckA1dP3Gq/GmrAQ
         Sl0lHzJD+E1mVY074tE9f6UI/73pFdCgkxefk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711378227; x=1711983027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MqD8wzexo6xit6zjT25NUCdriPsphWfFfa0tlNyYYks=;
        b=t3JWYrEJT7NinAw7whi/Wa3YgwxMIIJepmPf6Tc0+BC75juMq4pPkAUKVATXS//Seg
         7rNt8ohMTVWmVklx21gyTrF/AzM7q4/lPUel+pC7WsuOjVu1OmjjoyoxHyRfP8F2MneF
         LBsewDuMr6Fc7NZmOPIwr/WsLbaG3nw/iV2QajLU3rumTUIfnzKQENlzGawlNWtv/jse
         vZo97XspKjw5XlzWHK2yjKB0j5K5Yrv3OMyu78jAaYwawmvwPUuhB9gv6fA5v+y7NDJT
         fbeO8PXDj8zmIE+I7ZDBS9tmnmlQPcBIqnWFxijNqqjuG40gLWTrew6Vz3rHD9Ip+Rl8
         Hw/w==
X-Forwarded-Encrypted: i=1; AJvYcCUdbvf5pW/YaoLdmaechN658GSFWPDxCKf+lUNzI1B6kj+wcJ3fGR1hpohSNuLqcBlscSqbLiwy9TvcvcJvOATsYoPURcNgC9kq10/c
X-Gm-Message-State: AOJu0YxYlBD5gXc7rCevHLQnz7ikKXaJoh9NOd1zLZW0jTpF+Iy9qlW8
	VasaavOFmJRpfC6wKu5uyPUQCtG+U1LG1yICKYkgv4TPetShMCG+osv/NtjOUQ==
X-Google-Smtp-Source: AGHT+IE6yzbqY9Tnz0mf6K9GR4TUk/vQYebvk9s+XGtSDcB03p3513ghSfX16LycTxIPRRyfSLKj6Q==
X-Received: by 2002:a05:622a:15cb:b0:431:47f2:df8e with SMTP id d11-20020a05622a15cb00b0043147f2df8emr7329210qty.2.1711378227626;
        Mon, 25 Mar 2024 07:50:27 -0700 (PDT)
Received: from denia.c.googlers.com (188.173.86.34.bc.googleusercontent.com. [34.86.173.188])
        by smtp.gmail.com with ESMTPSA id eq17-20020a05622a5e1100b004313f54aaa9sm2491449qtb.5.2024.03.25.07.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 07:50:26 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 25 Mar 2024 14:50:25 +0000
Subject: [PATCH v3 3/3] media: dvbdev: Initialize sbuf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240325-gcc-arm-warnings-v3-3-81b8c10dc18a@chromium.org>
References: <20240325-gcc-arm-warnings-v3-0-81b8c10dc18a@chromium.org>
In-Reply-To: <20240325-gcc-arm-warnings-v3-0-81b8c10dc18a@chromium.org>
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


