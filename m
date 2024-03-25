Return-Path: <linux-kernel+bounces-117289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7652B88A9AE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187031F6119C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D1012C7E5;
	Mon, 25 Mar 2024 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W2gaYCIG"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C77913D254
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711378228; cv=none; b=OQnNgWjVN+LvuZ3cK+jK1IVVzH6QHF2f1TNCytLSwSet/mR/MEK1VaaAbRDZR2uBnMR4tqQ1/tylwdNbmcd/maodayKh6ZUGsuEajl7u5ez5jrciKMl83NzW2C4pJfooUmWn6Cwi5jx6BE0rvFSk9eI3PQ42ZJ4sbcI4Dv6acRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711378228; c=relaxed/simple;
	bh=bzGkhh3857LfO//R8Cc3xM+Sm0Pu0LcZVZpGpS79/9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LDpvwccsWzcTJJ2Pfm1X0rCOFAqikXWbKHpsVrTsIG/NHFjdkF2R3bLnRqLgnvqH3LOWWEjMYdzn/gXBYgYnMrzuoTRhg6yK++ahBBeNJzovOzAfQ+bK4yv89WKxNghuQvZcdXDOSa2/2n+2dXrOzCpZdJDDHz4mjqMg279HJNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W2gaYCIG; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-229a90b7aa9so2041293fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 07:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711378225; x=1711983025; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HiJIJJs/fXvTyCDSSNBDGHDw2J3EG4BtX2teiiFjae0=;
        b=W2gaYCIGNnCQvWLmUv7VdKQ4w9GjZaQ4/4apOsJMbIWRsmtzRHCNVLCerGfSc53Q7W
         dWZJJQukVWNVYlNTbiuXBMgDKsAzi801kDG79DRg4StubaWNySl1aquooJVwppQwGISr
         V5XU5gripwuSe4PpeD52JJk++ZjMY4NAvYcHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711378225; x=1711983025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HiJIJJs/fXvTyCDSSNBDGHDw2J3EG4BtX2teiiFjae0=;
        b=RJ3rjp7NVrl9Sj1o3o926hqq/8x60NPkcx00qy2Q9XjyWQ+uEAQXpYURboimQ9xqY3
         zXuKUxScp2+eeBxC7yHhTf7TOoi0VM/kgy3sk1poXIJZrFwRtM/kFCo9qzMhGRv2ZTl3
         s9+lVBCgz1QNGYIoSekQZ2HuAiXYaehrad2a3PABPVLNW70/pRjjbB1y3tceTtwEz2rI
         2vmfI7PHG4M6tNeeIuDLtaEm1QMUDivIh/ATmNR+jJIS9mCSJWZp3PLeUi0y6dLkKkYS
         NOuO1HcVV4DXVCzf6uPUXrLoOqYuDLqBvc2QRY/ykBh7qOh7DjJfV+7ff6VbYOrzufR2
         JllQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAWOzbzfSjS5GD0BVhGIJvtviPqry9lGyt1Vrgp9cl9L/QW7l+iJnZRXSb6kFgGztBixvGLhAE3FZtDPFkDonblmV7zwyMzTnR/rKm
X-Gm-Message-State: AOJu0YyIm9uctq6h3nqUUxmOxZllBFMkOL1Ezg2knqFwPbQSSHjpVbfG
	v8MmW4nDkE/XXyomy7j9OEWS5Mg4HpVeT0bb3/+HP6HSj3bez+ZtWtrcvP6Stg==
X-Google-Smtp-Source: AGHT+IFi6H6aHLQfI8VFi0WO8ICSYFmiwIeOfLPtxErl0UIG07TzmLmgVZ3n0y6H5EShjbVyMwmPSQ==
X-Received: by 2002:a05:6870:1641:b0:229:e41e:a6b0 with SMTP id c1-20020a056870164100b00229e41ea6b0mr7401259oae.47.1711378225403;
        Mon, 25 Mar 2024 07:50:25 -0700 (PDT)
Received: from denia.c.googlers.com (188.173.86.34.bc.googleusercontent.com. [34.86.173.188])
        by smtp.gmail.com with ESMTPSA id eq17-20020a05622a5e1100b004313f54aaa9sm2491449qtb.5.2024.03.25.07.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 07:50:25 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 25 Mar 2024 14:50:23 +0000
Subject: [PATCH v3 1/3] staging: media: tegra-video: Fix
 -Wmaybe-unitialized warn in gcc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240325-gcc-arm-warnings-v3-1-81b8c10dc18a@chromium.org>
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

Make sure that tegra20_vi_get_input_formats always assign a value for
yuv_input_format.

Fix:
drivers/staging/media/tegra-video/tegra20.c:624:72: warning: ‘yuv_input_format’ may be used uninitialized [-Wmaybe-uninitialized]

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/staging/media/tegra-video/tegra20.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/media/tegra-video/tegra20.c b/drivers/staging/media/tegra-video/tegra20.c
index c25286772603c..630e2ff987a37 100644
--- a/drivers/staging/media/tegra-video/tegra20.c
+++ b/drivers/staging/media/tegra-video/tegra20.c
@@ -164,6 +164,7 @@ static void tegra20_vi_get_input_formats(struct tegra_vi_channel *chan,
 	unsigned int input_mbus_code = chan->fmtinfo->code;
 
 	(*main_input_format) = VI_INPUT_INPUT_FORMAT_YUV422;
+	(*yuv_input_format) = VI_INPUT_YUV_INPUT_FORMAT_UYVY;
 
 	switch (input_mbus_code) {
 	case MEDIA_BUS_FMT_UYVY8_2X8:

-- 
2.44.0.396.g6e790dbe36-goog


