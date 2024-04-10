Return-Path: <linux-kernel+bounces-139392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0319C8A0271
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F68928ACBB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940C1194C63;
	Wed, 10 Apr 2024 21:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SCZqqIHh"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130D7184127
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 21:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712786090; cv=none; b=R/iXCWe387AI4qGWJSahBvyccbKrIo9bZLRrnaqNEOOHoI6t+hz47qnRvq52QfdDuNxaCG0qxM0LcxalqzFpweBgt7hJoWcdewC41tcA5762D6dftYZILX3hFwYzN7SINfMtBhF3Y0sEExY5ZlZLc3/lPGvasmYBwNRunAt0l7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712786090; c=relaxed/simple;
	bh=CNOEK2aWkC3W8YJDXsiqotp6WsB7BgDuWRBpQs7crVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X3XGUEnD3cUdOc/mFJlfHJ6ogQBYM3Y99wQFvVacWeKDrUlVJi56i4WMc97mW1f/KKPyjx9E7cy220H7jgBdRToTOfArOCPFxBjgKfHH02ytQ1nCvPDD4unnBok0GD9JJftt9uVpzE2R9nJCP1Ck3sNZMaZiLmuHauFxmaqcxKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SCZqqIHh; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcbef31a9dbso4775388276.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712786088; x=1713390888; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s6vhOcczX0Rso19zsRzhH1nUym0L4HSC9FS2OUDhpCI=;
        b=SCZqqIHhAbzTPWD+OERGE/77Jwb5jSH/ZN9+jIiYC4RhRU4pYeLTtQ8S0cjQm08oX4
         ZLaTYJoh1V+WQRE0WQaAyxucj/8t3Mn9Rdcw1EWUchjIpP1+5OXFHgqgLbyfLtMTxvKN
         ThiQCA1T3+VLDlGfGNUQsQwyJ9TPb63f9x608=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712786088; x=1713390888;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6vhOcczX0Rso19zsRzhH1nUym0L4HSC9FS2OUDhpCI=;
        b=WGtapXnpSJmVgMTF0kFPw6fVFIXC3JvBGdpk+/fkSRZjP5Guvk1tXumNAbJ2HOnGwO
         vk7aOFoFS5aL4+DRjZYKw86qggAt/tCkfsvtbPWkLYaWF5zI83FHlfrY9nYcGFvF0FrO
         PZEUaR3Hn6nbvgwNVThwu4kvcCL4i6tRQ+BlOpTecaVFptJ/HUJzt1LTxARfV4i5s0T7
         FBin9171CQZYOwmgOgkPEt/9pPJF/rdu2Q5+vCbsREuHg/tUDPGGoP0E7A4+A00XklYj
         A3G/2XWFDBhr1o+fC5rHeY0WCQVH4VBi9uJ+ZtmDENGJUbjAZ3ZVJkgphSzHNdqDf3Cn
         QZlg==
X-Forwarded-Encrypted: i=1; AJvYcCUQksN04apBYPdyIRSTv6FY+rAojaVKZIH5PG5kQPAaxPS+eK9DRAsQOgiG4thlkQeuTmDdSo5PGosNLn2mgJRLikfoW80cy6Fg1J3t
X-Gm-Message-State: AOJu0Yw7YUfCm6FOmC1J1/ebiSGTLbuzi4nWBiG7e3f66nOyYGxvLVya
	bLpkFnVZJSWhotwHzBlFP5J7BF4W5IWPqD+9um6g1gLh0pgUcJaelYTnOPV1yQ==
X-Google-Smtp-Source: AGHT+IGIfO/2mFuyvVoujR3E89kj5KMNHwJfRYxvWyAQjc1xNMc4jdF0XAAcb1kFRJTlscFJbgdi9Q==
X-Received: by 2002:a25:acc1:0:b0:dcd:5bfa:8184 with SMTP id x1-20020a25acc1000000b00dcd5bfa8184mr4697141ybd.39.1712786087887;
        Wed, 10 Apr 2024 14:54:47 -0700 (PDT)
Received: from denia.c.googlers.com (188.173.86.34.bc.googleusercontent.com. [34.86.173.188])
        by smtp.gmail.com with ESMTPSA id kg26-20020a05622a761a00b00434c1eedb0esm67330qtb.36.2024.04.10.14.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 14:54:47 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 10 Apr 2024 21:54:40 +0000
Subject: [PATCH 3/6] media: platform: sti: hva: clk_unprepare
 unconditionally
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-smatch-v1-3-785d009a852b@chromium.org>
References: <20240410-smatch-v1-0-785d009a852b@chromium.org>
In-Reply-To: <20240410-smatch-v1-0-785d009a852b@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>, 
 Jean-Christophe Trotin <jean-christophe.trotin@foss.st.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

hva->clk cannot be NULL at this point. Simplify the code and make smatch
happy:

drivers/media/platform/st/sti/hva/hva-hw.c:412 hva_hw_probe() warn: 'hva->clk' from clk_prepare() not released on lines: 412

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/st/sti/hva/hva-hw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/platform/st/sti/hva/hva-hw.c b/drivers/media/platform/st/sti/hva/hva-hw.c
index fe4ea2e7f37e3..fcb18fb52fdd7 100644
--- a/drivers/media/platform/st/sti/hva/hva-hw.c
+++ b/drivers/media/platform/st/sti/hva/hva-hw.c
@@ -406,8 +406,7 @@ int hva_hw_probe(struct platform_device *pdev, struct hva_dev *hva)
 err_disable:
 	pm_runtime_disable(dev);
 err_clk:
-	if (hva->clk)
-		clk_unprepare(hva->clk);
+	clk_unprepare(hva->clk);
 
 	return ret;
 }

-- 
2.44.0.478.gd926399ef9-goog


