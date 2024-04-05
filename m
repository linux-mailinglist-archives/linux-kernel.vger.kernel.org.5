Return-Path: <linux-kernel+bounces-133131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A64899F4E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8C1B1F26706
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AC216FF31;
	Fri,  5 Apr 2024 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aGVrssa2"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372DD16F906
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712326522; cv=none; b=LFYQ2XPZzCH8QogBBNtt3YkQChQ+FZNBetJSGb98S05ZSPd0bK44ol5uADIDgcu3NOJOd7BHNScIcomxo6WzKBT4vRpLV25dPLo35tWsRvxh8BB3jonXs8Kz7IwqmS14js7yWoKKF0boO6jtvnRIQ4ox80tIQvkKcW+2nzsA2b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712326522; c=relaxed/simple;
	bh=6SE0kPCYxfLmOcadEJPk07sX9YIfwYS2lpWnkue2zR8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=etLi8CHfuuTCNTiUcUqnubeIpgez7VQ/PNyD3NUZ2VrTuNxK0RMZOfXRTlGTzbNUUSn0r7nTQHIsT7njPYI2uRcvIIxBFvUmC9jgBCH7ctJlaqwbUNlJV/x0XfYI4ugQSqkpbQHWn+XIZHngjS65b22Kkg1HJ7d/SC2f4vZWg2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aGVrssa2; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-41481ad9364so16300375e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 07:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712326519; x=1712931319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tPWJ94tQJYhK3/OOBFjDm8S/NzfWr3sQ4mvAu40pbWw=;
        b=aGVrssa208/JedoXdhuAsfVNsbChm8ilvckj5H+2nfjKmQhqWXzeEFotcsfeNU7Ngy
         G6qqHzMWDo+GYN/rs1Ot/FsHE21DGl28cYBv8MKFsModJMsVnhlgN5XDI02CezGC/cD5
         yHlKpH97FucAjF1VfHEeyrtkTnCGC0+Cy40BWpiGTFcss4wYCTWMuuloRmGM3+hX1DE1
         ZIg47Uuqx4VMzT+A2+Fjz+CwC0KMRCeU5sDF8JhbSYiipNNL+Qx44Dep88ITy0R8zOw3
         ySHS5peYFH3y1XPMk+fjBCtDr7qOETY5vlcHPYF3jfegCP6KZx9bxaDk9w/djpf44yXN
         NJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712326519; x=1712931319;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tPWJ94tQJYhK3/OOBFjDm8S/NzfWr3sQ4mvAu40pbWw=;
        b=XG+M0K7bNS5YUpuyyDPObkJy0coEtGQiy3PurID2huf59JMvvO7uByf18dhCEiSCLp
         3QECljUKr8Rz0vFfCuZzXWuCSdSeTjDpHi36hHSw5YLBN7WpeK6aIbE5kv+UcO6KQaOm
         gmIR482J1RqqE2ztEz1WPFsUrtQ7vT/orKFPFgRhSYNnoevdNqYS4AU0A4iQZ9Ow9Obd
         paGpJzazv7UjAHxQpZjrQWoYuDn1jvkjWjgXSrfovF9hnOihAG6rWdJ2ggWPa2G484Ti
         G7jFJs50lzA3xiBvvO9hLFOTQ5mAI1gHzsr2rmuubfuY9DsNZZhLgKepoBNJUNcLTEDr
         +9iA==
X-Forwarded-Encrypted: i=1; AJvYcCXOYNb20Hs5MjjwMbNL1RsMy7/L4a69H5pyI42J8s5BHEZZqpynesA8XscypxxmUmBz48vTG/CwkCtI2V8E6NJxN+FO3FNuBi+LC87n
X-Gm-Message-State: AOJu0YwEciMhF7kPeW2oSfiuS5EN+bryV2l3c90u79bPX1HLfUHJ2Z+a
	js7qweoUx/eOwB3ZKwm6KvCNzCNFmafLW8XS5NVEvzg51afCdh9TfXWmV6i6QZ+k4TXI3AZIK2l
	eDGHQWkljcQ==
X-Google-Smtp-Source: AGHT+IHQfTupTS6QFxw4wd1lUfUH34e1AoeuC2pe3b5AQePG8p20sMvmkeKQHBjCW7WGybe4z/i4eJInLgDU+Q==
X-Received: from szatan.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2d83])
 (user=panikiel job=sendgmr) by 2002:a05:600c:1d12:b0:416:2c7a:6b6 with SMTP
 id l18-20020a05600c1d1200b004162c7a06b6mr5110wms.0.1712326519687; Fri, 05 Apr
 2024 07:15:19 -0700 (PDT)
Date: Fri,  5 Apr 2024 14:14:04 +0000
In-Reply-To: <20240405141411.1807189-1-panikiel@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405141411.1807189-1-panikiel@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405141411.1807189-10-panikiel@google.com>
Subject: [PATCH 09/16] media: i2c: ths8200: Switch dv timing callbacks to pad ops
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
 drivers/media/i2c/ths8200.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/ths8200.c b/drivers/media/i2c/ths8200.c
index 0e0f676cd221..ce0a7f809f19 100644
--- a/drivers/media/i2c/ths8200.c
+++ b/drivers/media/i2c/ths8200.c
@@ -358,13 +358,16 @@ static void ths8200_setup(struct v4l2_subdev *sd, str=
uct v4l2_bt_timings *bt)
 		 bt->hsync, bt->vsync);
 }
=20
-static int ths8200_s_dv_timings(struct v4l2_subdev *sd,
+static int ths8200_s_dv_timings(struct v4l2_subdev *sd, unsigned int pad,
 				struct v4l2_dv_timings *timings)
 {
 	struct ths8200_state *state =3D to_state(sd);
=20
 	v4l2_dbg(1, debug, sd, "%s:\n", __func__);
=20
+	if (pad !=3D 0)
+		return -EINVAL;
+
 	if (!v4l2_valid_dv_timings(timings, &ths8200_timings_cap,
 				NULL, NULL))
 		return -EINVAL;
@@ -385,13 +388,16 @@ static int ths8200_s_dv_timings(struct v4l2_subdev *s=
d,
 	return 0;
 }
=20
-static int ths8200_g_dv_timings(struct v4l2_subdev *sd,
+static int ths8200_g_dv_timings(struct v4l2_subdev *sd, unsigned int pad,
 				struct v4l2_dv_timings *timings)
 {
 	struct ths8200_state *state =3D to_state(sd);
=20
 	v4l2_dbg(1, debug, sd, "%s:\n", __func__);
=20
+	if (pad !=3D 0)
+		return -EINVAL;
+
 	*timings =3D state->dv_timings;
=20
 	return 0;
@@ -420,11 +426,11 @@ static int ths8200_dv_timings_cap(struct v4l2_subdev =
*sd,
 /* Specific video subsystem operation handlers */
 static const struct v4l2_subdev_video_ops ths8200_video_ops =3D {
 	.s_stream =3D ths8200_s_stream,
-	.s_dv_timings =3D ths8200_s_dv_timings,
-	.g_dv_timings =3D ths8200_g_dv_timings,
 };
=20
 static const struct v4l2_subdev_pad_ops ths8200_pad_ops =3D {
+	.s_dv_timings =3D ths8200_s_dv_timings,
+	.g_dv_timings =3D ths8200_g_dv_timings,
 	.enum_dv_timings =3D ths8200_enum_dv_timings,
 	.dv_timings_cap =3D ths8200_dv_timings_cap,
 };
--=20
2.44.0.478.gd926399ef9-goog


