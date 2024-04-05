Return-Path: <linux-kernel+bounces-133137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8422899F5C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07DC11C22707
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FEB171E62;
	Fri,  5 Apr 2024 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lGfM31qn"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A67171E40
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 14:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712326534; cv=none; b=HCCXcVJwjrUSEAaS0QbzLWNJPNL3i8q7Zrp028zneRP6S/R/7PKbbQ3ElObFWGepXd73mkBsiDwF/ZdiQuofnq9jXWCdNBlnX0zl0+ZehRhwhhTmqXYkUjsKyxl74QtSEwMhD/b04IwSPzFIfyvvKfbszKKE2HsmgsOL63KhHq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712326534; c=relaxed/simple;
	bh=l0oG3N8c8mojKDmxECCVZ1V3hwbkCu1xRwc6SEUeGck=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pRHnXGxxPXfsqzpv/723Qzc5mqKeK/V66+bC2Xw0Qkr5xkHs+MR1jl+VGgVqV2fhpzFDoPbtQEfeSiHkMwonYwEK4RpjxHPKJc1zSMU2iHiRzgIOptqo3v9jaXV26gG+eEyydwNjFkZvD1IHjto+jho2LQ8Rmbh5WdrccuLculg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lGfM31qn; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6150e36ca0dso35169937b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 07:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712326532; x=1712931332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HIc/vnSojBwtbKTlmQZ+P1NRRI2WMTZiwEa64VZPTHs=;
        b=lGfM31qnbTW8rUmAx5p+NPQwxJZcUuZOLG4Y2sn1VWK7CmT6WR3G65fN9SExuf4cQ4
         kQxcpxezF8f1dO36zRBubuRdpDoDQcEHaPYBZNpgij9d6opO2ev25X/QOtRSCKx6YAd+
         zgM7mx39tC5sApE94sTL24ZWxsjNvmMF9cvsBKZ/7qfp8QF/ThdVIVQ/OQpQdhjEiKUw
         pWfQ+cu5uF8dCNPZvJ2Jz/DuA34hVNiYhjFmVshHDrnMXsZBZNxaiKW3rlGf69aJN9zk
         zyUbw3nutYyEIu79f7fOq55MUNmCRliqtDS+spMzoYIi2HWPQEzCQqcvFAgDoN6TUwfh
         WBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712326532; x=1712931332;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HIc/vnSojBwtbKTlmQZ+P1NRRI2WMTZiwEa64VZPTHs=;
        b=n+waLSun5vWuk/x5y4NrJhTprBkA+zLYJJQwzd1sliOWFHbsWew1mctPWVU1k2euQm
         ShOGjYStryeTxMmKeLZxqTS5zzUb1jQ4Ho0TsFpPsp5T4MIXXrlAtdICEMe7G2dWvyXh
         BuUH571j4QYwdcoqht0kb8d5IYz47NVbOF18uCkPunIRuQoWwwEhDbtHxBORYaVXVyhk
         udec5fXot9OyL8EQNkWbBo/jD3j4o1OsqZZup133ZUyILhwB1HwdR1GpH2eTiiAhhq47
         Dukc2iWbtzeResfCDOkeDx3nzdPl0C+i//xFDdxNOLFuyov0seEsrcd2I6y5gjRhAc99
         mNBw==
X-Forwarded-Encrypted: i=1; AJvYcCX5gTjXH8K9J3dP5p7KbUmcANW1QMWmMZR/ORy52tfudgmyE0qP5bBugMtij22s8iojqOnhBQ73xWf/J876DTRmEjoeeQRUnSFRQTsg
X-Gm-Message-State: AOJu0YywDPX8nMxlP3zlpNY5RdptNLqpj88NjMnGy0Pxa9QCACjwN2GF
	PkK+O7FtHxR7fJvmZYrlgLDvH5FC3iRqr9KSgbRuPH0xvCQ1MXNZvluW+c8XO40ftWjDBVNDxr0
	eiy4rsDXwkQ==
X-Google-Smtp-Source: AGHT+IEz1h6qQXkUMFl83+ZlYjZaKW4vvKVyMAs0V5zDifiOK4TkxQWVP3Z2WIWTgMXCjmjqeMR6zOmDG+MU6Q==
X-Received: from szatan.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2d83])
 (user=panikiel job=sendgmr) by 2002:a05:6902:100a:b0:dc6:c94e:fb85 with SMTP
 id w10-20020a056902100a00b00dc6c94efb85mr72164ybt.2.1712326532310; Fri, 05
 Apr 2024 07:15:32 -0700 (PDT)
Date: Fri,  5 Apr 2024 14:14:10 +0000
In-Reply-To: <20240405141411.1807189-1-panikiel@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405141411.1807189-1-panikiel@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405141411.1807189-16-panikiel@google.com>
Subject: [PATCH 15/16] media: tegra-video: Use pad variant of dv timing subdev calls
From: "=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <panikiel@google.com>
To: kieran.bingham@ideasonboard.com, mchehab@kernel.org, 
	hverkuil-cisco@xs4all.nl, tharvey@gateworks.com, 
	niklas.soderlund@ragnatech.se, prabhakar.csengg@gmail.com, 
	charles-antoine.couret@nexvision.fr, thierry.reding@gmail.com, 
	jonathanh@nvidia.com, skomatineni@nvidia.com, luca.ceresoli@bootlin.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chromeos-krk-upstreaming@google.com, 
	"=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <panikiel@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Use the pad variant for all (s|g|query)_dv_timings subdev calls, which
includes a pad argument.

Signed-off-by: Pawe=C5=82 Anikiel <panikiel@google.com>
---
 drivers/staging/media/tegra-video/vi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/tegra-video/vi.c b/drivers/staging/media=
/tegra-video/vi.c
index af6e3a0d8df4..57a856a21e90 100644
--- a/drivers/staging/media/tegra-video/vi.c
+++ b/drivers/staging/media/tegra-video/vi.c
@@ -719,11 +719,11 @@ static int tegra_channel_g_dv_timings(struct file *fi=
le, void *fh,
 	struct v4l2_subdev *subdev;
=20
 	subdev =3D tegra_channel_get_remote_source_subdev(chan);
-	if (!v4l2_subdev_has_op(subdev, video, g_dv_timings))
+	if (!v4l2_subdev_has_op(subdev, pad, g_dv_timings))
 		return -ENOTTY;
=20
 	return v4l2_device_call_until_err(chan->video.v4l2_dev, 0,
-					  video, g_dv_timings, timings);
+					  pad, g_dv_timings, 0, timings);
 }
=20
 static int tegra_channel_s_dv_timings(struct file *file, void *fh,
@@ -736,7 +736,7 @@ static int tegra_channel_s_dv_timings(struct file *file=
, void *fh,
 	int ret;
=20
 	subdev =3D tegra_channel_get_remote_source_subdev(chan);
-	if (!v4l2_subdev_has_op(subdev, video, s_dv_timings))
+	if (!v4l2_subdev_has_op(subdev, pad, s_dv_timings))
 		return -ENOTTY;
=20
 	ret =3D tegra_channel_g_dv_timings(file, fh, &curr_timings);
@@ -750,7 +750,7 @@ static int tegra_channel_s_dv_timings(struct file *file=
, void *fh,
 		return -EBUSY;
=20
 	ret =3D v4l2_device_call_until_err(chan->video.v4l2_dev, 0,
-					 video, s_dv_timings, timings);
+					 pad, s_dv_timings, 0, timings);
 	if (ret)
 		return ret;
=20
@@ -771,11 +771,11 @@ static int tegra_channel_query_dv_timings(struct file=
 *file, void *fh,
 	struct v4l2_subdev *subdev;
=20
 	subdev =3D tegra_channel_get_remote_source_subdev(chan);
-	if (!v4l2_subdev_has_op(subdev, video, query_dv_timings))
+	if (!v4l2_subdev_has_op(subdev, pad, query_dv_timings))
 		return -ENOTTY;
=20
 	return v4l2_device_call_until_err(chan->video.v4l2_dev, 0,
-					  video, query_dv_timings, timings);
+					  pad, query_dv_timings, 0, timings);
 }
=20
 static int tegra_channel_enum_dv_timings(struct file *file, void *fh,
--=20
2.44.0.478.gd926399ef9-goog


