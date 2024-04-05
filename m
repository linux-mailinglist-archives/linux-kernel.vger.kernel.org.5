Return-Path: <linux-kernel+bounces-133124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2EE899F3D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D3B1C21BE3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7684416F0E0;
	Fri,  5 Apr 2024 14:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r5l6/Ip/"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAEF16EC1D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712326507; cv=none; b=S1qL+M/aPkx0UznHvaTYrDXpterxyZgpvYYB+Hyip9pt4Iw9CZYzQoN4E7+hHxYQPYjgE63qlZhq0MXwA5S9fYTnjjzb5PiywacWuDpo3jX5+65xXTB7CepGpyqDcKABNU9LPlGNiY5UUYcEFrr1eILSCWOXy6KM6H7D0U+Cf9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712326507; c=relaxed/simple;
	bh=6EehccEvTPWYOq7+XxW7U39Z7ElCZmB+5qet67lPQQs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mhav7C/nyF21LTTjWzyygF7bRyELOzB3vvI5As4FCJxYvrtke1pqCyhHwn7O+n1EWeThAhu/Uih+qKoYWmeo3wh6CMyHhffqeDOJzru9oMvifnIVlODgmmV52nvXSA3kupix5DRPBchQgH1x0mypcHrYZBj5orVPvjZ/2V41+kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r5l6/Ip/; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3418412a734so1425092f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 07:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712326504; x=1712931304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EB1OqCeM+zzEWfmV9H/3BRd83N3O3aUGhb7gLO7v4Gs=;
        b=r5l6/Ip/rFUB8dW3ahq9kAitPKmB9Lngsi3ub2sxepQil40+4ROeQkPAvQUAWFsgc7
         xfoIezE6JCZf0nD0tTKsr9FE45OVKMVrhqf8oRuZalW7p9cqKECi7SCf4r7kMhhk8PV9
         VtZ4vBAVwJ+TSwkOejCwdapx0zwPQulR1jxfEsZBN3dv9HHPZDEYMbfnOBVLak/cs64X
         6AFdmUBQRJc2rQvdeWkjbNOXH8VZhBpTs3e2QI1XiCvBmj2zzUk/vpvXc2CTtASlaGyj
         0X/Sbeaud4Q3qWHRDdxmj/+HF6J+DOfqAjBL6IZnhhImCMxKfsirjt/VC9J+dVQyqDmL
         0mZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712326504; x=1712931304;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EB1OqCeM+zzEWfmV9H/3BRd83N3O3aUGhb7gLO7v4Gs=;
        b=vSrWGoY8KoghKV90qnti/g6PrEbbx/HzVM5PCXqfPIaCPg6N/6hcbvNdf8/Ez6wZ0b
         TAoHiL5WkdLISax8oaZEvD5NIObNhKA8MDHrmj4Pi6df3cnrFBGpAZCIk6wL2W9D8vPm
         S1Lfozqs3b4qhGtZXtK10wS6cB3WTJxp88qegs2xx4gaEycgQfeVKuMZdh3uqom0tnrw
         be7lXcmxxa6aRLLrv5KQBjF4bfq8k3qd/Syro4Vp4F5P3i1gK8wsidogHliEosm88o3o
         vud0ZWW8/wZkSfX7G4h8uLlch2XCIb1LZCiVwBd10xbgIkZUOoX3MnnHDHZAoDsJh5SJ
         G05w==
X-Forwarded-Encrypted: i=1; AJvYcCWEBapIiJAUXGsrt0Mxwlf8t2PFY4p8es5/vECkJUhpgpZClBEdTh/0Ojzz09tPEWlKKFiTKn/ijG36l+0oXhLqT4IOYRpe9j+X70ez
X-Gm-Message-State: AOJu0YwSM4UXNI8Y50tc94TA8TfhGLpLtS16KLVcR3yQYth4xwoysrt0
	ARCs3ANIKblK+dZGMYX3jKWgx+beeoy/ni4OxOkA8Bf4Z6pmxIcMXRE12njJ06Dxb9jtqfA0uP2
	5cN1+tZFnpA==
X-Google-Smtp-Source: AGHT+IHxUh/sNELzePmUjUKXOONpTWRH6C10MHQYsitlB4/bEok8pDIcPZmqe/e/AmmgnCRzPUYVo9trVTS96A==
X-Received: from szatan.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2d83])
 (user=panikiel job=sendgmr) by 2002:a05:6000:1d9c:b0:343:ce9e:3732 with SMTP
 id bk28-20020a0560001d9c00b00343ce9e3732mr2847wrb.11.1712326504331; Fri, 05
 Apr 2024 07:15:04 -0700 (PDT)
Date: Fri,  5 Apr 2024 14:13:57 +0000
In-Reply-To: <20240405141411.1807189-1-panikiel@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405141411.1807189-1-panikiel@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405141411.1807189-3-panikiel@google.com>
Subject: [PATCH 02/16] media: i2c: adv748x: Switch dv timing callbacks to pad ops
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
 drivers/media/i2c/adv748x/adv748x-hdmi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/media/i2c/adv748x/adv748x-hdmi.c b/drivers/media/i2c/a=
dv748x/adv748x-hdmi.c
index ec151dc69c23..a4db9bae5f79 100644
--- a/drivers/media/i2c/adv748x/adv748x-hdmi.c
+++ b/drivers/media/i2c/adv748x/adv748x-hdmi.c
@@ -214,7 +214,7 @@ static int adv748x_hdmi_set_video_timings(struct adv748=
x_state *state,
  * v4l2_subdev_video_ops
  */
=20
-static int adv748x_hdmi_s_dv_timings(struct v4l2_subdev *sd,
+static int adv748x_hdmi_s_dv_timings(struct v4l2_subdev *sd, unsigned int =
pad,
 				     struct v4l2_dv_timings *timings)
 {
 	struct adv748x_hdmi *hdmi =3D adv748x_sd_to_hdmi(sd);
@@ -254,7 +254,7 @@ static int adv748x_hdmi_s_dv_timings(struct v4l2_subdev=
 *sd,
 	return ret;
 }
=20
-static int adv748x_hdmi_g_dv_timings(struct v4l2_subdev *sd,
+static int adv748x_hdmi_g_dv_timings(struct v4l2_subdev *sd, unsigned int =
pad,
 				     struct v4l2_dv_timings *timings)
 {
 	struct adv748x_hdmi *hdmi =3D adv748x_sd_to_hdmi(sd);
@@ -269,7 +269,7 @@ static int adv748x_hdmi_g_dv_timings(struct v4l2_subdev=
 *sd,
 	return 0;
 }
=20
-static int adv748x_hdmi_query_dv_timings(struct v4l2_subdev *sd,
+static int adv748x_hdmi_query_dv_timings(struct v4l2_subdev *sd, unsigned =
int pad,
 					 struct v4l2_dv_timings *timings)
 {
 	struct adv748x_hdmi *hdmi =3D adv748x_sd_to_hdmi(sd);
@@ -392,9 +392,6 @@ static int adv748x_hdmi_g_pixelaspect(struct v4l2_subde=
v *sd,
 }
=20
 static const struct v4l2_subdev_video_ops adv748x_video_ops_hdmi =3D {
-	.s_dv_timings =3D adv748x_hdmi_s_dv_timings,
-	.g_dv_timings =3D adv748x_hdmi_g_dv_timings,
-	.query_dv_timings =3D adv748x_hdmi_query_dv_timings,
 	.g_input_status =3D adv748x_hdmi_g_input_status,
 	.s_stream =3D adv748x_hdmi_s_stream,
 	.g_pixelaspect =3D adv748x_hdmi_g_pixelaspect,
@@ -413,7 +410,7 @@ static int adv748x_hdmi_propagate_pixelrate(struct adv7=
48x_hdmi *hdmi)
 	if (!tx)
 		return -ENOLINK;
=20
-	adv748x_hdmi_query_dv_timings(&hdmi->sd, &timings);
+	adv748x_hdmi_query_dv_timings(&hdmi->sd, 0, &timings);
=20
 	return adv748x_csi2_set_pixelrate(tx, timings.bt.pixelclock);
 }
@@ -610,6 +607,9 @@ static const struct v4l2_subdev_pad_ops adv748x_pad_ops=
_hdmi =3D {
 	.get_fmt =3D adv748x_hdmi_get_format,
 	.get_edid =3D adv748x_hdmi_get_edid,
 	.set_edid =3D adv748x_hdmi_set_edid,
+	.s_dv_timings =3D adv748x_hdmi_s_dv_timings,
+	.g_dv_timings =3D adv748x_hdmi_g_dv_timings,
+	.query_dv_timings =3D adv748x_hdmi_query_dv_timings,
 	.dv_timings_cap =3D adv748x_hdmi_dv_timings_cap,
 	.enum_dv_timings =3D adv748x_hdmi_enum_dv_timings,
 };
@@ -734,7 +734,7 @@ int adv748x_hdmi_init(struct adv748x_hdmi *hdmi)
 	struct v4l2_dv_timings cea1280x720 =3D V4L2_DV_BT_CEA_1280X720P30;
 	int ret;
=20
-	adv748x_hdmi_s_dv_timings(&hdmi->sd, &cea1280x720);
+	adv748x_hdmi_s_dv_timings(&hdmi->sd, 0, &cea1280x720);
=20
 	/* Initialise a default 16:9 aspect ratio */
 	hdmi->aspect_ratio.numerator =3D 16;
--=20
2.44.0.478.gd926399ef9-goog


