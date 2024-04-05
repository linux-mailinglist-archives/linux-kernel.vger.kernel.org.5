Return-Path: <linux-kernel+bounces-133129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 456C0899F48
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383081C222DA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4A216F85F;
	Fri,  5 Apr 2024 14:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qRkHnNXK"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A657F16F29A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712326518; cv=none; b=qOE2mbx6+sN0dNj7FxlaCcAddgOroE2HxppVgOKlW30RgDGN2AlgdYw8KH9a9vra9tzogTEy1E8zhri1qZq35RGk9sN+ufwu11kKT1INbSjXHn2va1fmUGqTC/0wKHPd4wFB7X6m6te0KMg+xf9YqvOBpeoVuTFcq0oXf9ATeYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712326518; c=relaxed/simple;
	bh=ntS1pULOfao09pkQklGZunQlgY3iQS75f26X4n18NUw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n2UVeSOpsX5Z3XbOhYhEBoc0Yrs2YMZSABIjyY2SsiawtHL9hXezWF/w0bs5N1BT0d3kKgvk98W6NH5LeLPcUJJlz9lUtDuBs7g0nRHJ9/T1SxlIcJyfItNq/0s0r8obiWqYxaGzt1PGLNhFgY7TFjfnUlDqfXaczxagrZfxJaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qRkHnNXK; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-343f1064acaso237737f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 07:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712326515; x=1712931315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u/DYRsGuD2azP54ih0vSn8RrFIexS1cmRe6nsqzzojM=;
        b=qRkHnNXKIYbHHthPbRLJGyG/3qm8nlmuS6LXEYAPcqVgEwOXjgySjvseR1NnGuzy26
         UtWq1BzLHoPhH3ONLPZBlV5hZMnErzPukIJ2N+Xm6jIBCG4vOb2TxBXjwh+n0t1FKOq+
         +KyVSILdrrLX+r7UyD9pckK0qoqQC9HRg2YAbbQ+QwrsTSJG3Z60J3+RLt81vubRXGEa
         A479idsPVc7bVzK42jZrCXL94/daRzg7CjzVdswwzkL94SBZol00xDKhlV0otUU2BiMg
         xAZ/6OCTXZBSpOKT72D8BTL8KHVahqti9eWVLYzomYEf9iEsx5rguOba/Yd0ErYlCFhv
         4vIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712326515; x=1712931315;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u/DYRsGuD2azP54ih0vSn8RrFIexS1cmRe6nsqzzojM=;
        b=W+emvzHwGNoNXtl62bve5Tq4RGr/wKa6/garlksEdhZwKA04G2xKMWJ4a14cc3NHRW
         F6Z2Nd8mSAWbrhuRsbZDy4bsaJQKbS4mdcRCaWaeYq0p3fOLwsXhFNnYODuW3Lj9uIgr
         RXFkiQAlGRh8AL3vARGIxVcXpoQEwQoKKju6mVzIkVpOrqDraNe2FAJVrycB396j7XTh
         u8kjD+4RF9b4SK9zZS0IplqtRtCdpOX5LmuOxk2zIovzOGsDnipoeNi4QZHK/aT30p29
         a44kCijF49ISCX9hLx0tLwt8YCZiy3guVyX5Sl4wKOCmXR620kQfCqkiGFRLDPJ6K4Vm
         ptMw==
X-Forwarded-Encrypted: i=1; AJvYcCVWrcniHQzGnfGzNvLq1ffeDmCjKymnAgqRUTcmzdRUjcdmjbHFES4T3wDWjXsxiqq8MlAhRS6s2lBO95sW7/uZGJ52Bx/thxS9ZVGo
X-Gm-Message-State: AOJu0YxO/buDEzwYbxh+/aQYrQ9sxvSLoys5MZwhQzfYSePHpNE7l9bk
	EsIlah9sKdpdXDNP5EbboPGP8lGOXDQRxBniBXR6SmGPRQX0sln3ywqG/kvs0Q5wgcavj1nSyo+
	2jc/CXK/m3w==
X-Google-Smtp-Source: AGHT+IGVcif+Faaig453j1h+31TrZh3tBMb+AFeW0Uj0gxfTGG7Ih3adQK1q6wGfDlzXEzt+uvm5oUV+rRa+3A==
X-Received: from szatan.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2d83])
 (user=panikiel job=sendgmr) by 2002:adf:9d91:0:b0:343:8420:4d1c with SMTP id
 p17-20020adf9d91000000b0034384204d1cmr3903wre.3.1712326515313; Fri, 05 Apr
 2024 07:15:15 -0700 (PDT)
Date: Fri,  5 Apr 2024 14:14:02 +0000
In-Reply-To: <20240405141411.1807189-1-panikiel@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405141411.1807189-1-panikiel@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405141411.1807189-8-panikiel@google.com>
Subject: [PATCH 07/16] media: i2c: tda1997x: Switch dv timing callbacks to pad ops
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

Change all (s|g|query)_dv_timings subdev callbacks to include
a pad argument.

Signed-off-by: Pawe=C5=82 Anikiel <panikiel@google.com>
---
 drivers/media/i2c/tda1997x.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/tda1997x.c b/drivers/media/i2c/tda1997x.c
index 8e4a0718c4b6..55a0b5d39893 100644
--- a/drivers/media/i2c/tda1997x.c
+++ b/drivers/media/i2c/tda1997x.c
@@ -1669,7 +1669,7 @@ tda1997x_g_input_status(struct v4l2_subdev *sd, u32 *=
status)
 	return 0;
 };
=20
-static int tda1997x_s_dv_timings(struct v4l2_subdev *sd,
+static int tda1997x_s_dv_timings(struct v4l2_subdev *sd, unsigned int pad,
 				struct v4l2_dv_timings *timings)
 {
 	struct tda1997x_state *state =3D to_state(sd);
@@ -1694,7 +1694,7 @@ static int tda1997x_s_dv_timings(struct v4l2_subdev *=
sd,
 	return 0;
 }
=20
-static int tda1997x_g_dv_timings(struct v4l2_subdev *sd,
+static int tda1997x_g_dv_timings(struct v4l2_subdev *sd, unsigned int pad,
 				 struct v4l2_dv_timings *timings)
 {
 	struct tda1997x_state *state =3D to_state(sd);
@@ -1707,7 +1707,7 @@ static int tda1997x_g_dv_timings(struct v4l2_subdev *=
sd,
 	return 0;
 }
=20
-static int tda1997x_query_dv_timings(struct v4l2_subdev *sd,
+static int tda1997x_query_dv_timings(struct v4l2_subdev *sd, unsigned int =
pad,
 				     struct v4l2_dv_timings *timings)
 {
 	struct tda1997x_state *state =3D to_state(sd);
@@ -1724,9 +1724,6 @@ static int tda1997x_query_dv_timings(struct v4l2_subd=
ev *sd,
=20
 static const struct v4l2_subdev_video_ops tda1997x_video_ops =3D {
 	.g_input_status =3D tda1997x_g_input_status,
-	.s_dv_timings =3D tda1997x_s_dv_timings,
-	.g_dv_timings =3D tda1997x_g_dv_timings,
-	.query_dv_timings =3D tda1997x_query_dv_timings,
 };
=20
=20
@@ -1930,6 +1927,9 @@ static const struct v4l2_subdev_pad_ops tda1997x_pad_=
ops =3D {
 	.set_fmt =3D tda1997x_set_format,
 	.get_edid =3D tda1997x_get_edid,
 	.set_edid =3D tda1997x_set_edid,
+	.s_dv_timings =3D tda1997x_s_dv_timings,
+	.g_dv_timings =3D tda1997x_g_dv_timings,
+	.query_dv_timings =3D tda1997x_query_dv_timings,
 	.dv_timings_cap =3D tda1997x_get_dv_timings_cap,
 	.enum_dv_timings =3D tda1997x_enum_dv_timings,
 };
--=20
2.44.0.478.gd926399ef9-goog


