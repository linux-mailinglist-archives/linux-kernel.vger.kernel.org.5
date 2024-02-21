Return-Path: <linux-kernel+bounces-75063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EAD85E276
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBF011C22955
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A359982870;
	Wed, 21 Feb 2024 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TC2r+sho"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6A481AAA
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708531354; cv=none; b=GehQQlgWBwA0AgpItY+lDTWxRH/yKlyczRi5H8poht0qb1z3R2TgICmmxR52ITJubkd5GnMsFNAeeN/bnQBhdqXLWECtc3vPsLxjNGYiU1u8/J2s4njD9lu+uVsjWK4lQ40DTwnmh0GBGL+oD4cyMwmho0PjRIsmo+Mv8EiiS1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708531354; c=relaxed/simple;
	bh=xp1En7WEY2Yy2e9YIWX40hV8+s5QANKt/pakIjV5+QE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ooRhgc+E8SAfNYuMT+TdS3zdz+8nK+3DoheAq/3pN4HSJrx/QaOolpUC40UNsL/gt+JbOuXS/GwaTbjpHyTX9/CCXF0QI2MTSYj1dJ66psGSgo/DgN9O80iZSXyGewz5t80cuRvdslflhO3Xu43dPQdG2kOesiJ3IUM05pwPTco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TC2r+sho; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608852fc324so12067317b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 08:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708531352; x=1709136152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXMOhwD5qEr4jMu4yu+cDm4xZSeU+k4T71jhjLqjWWI=;
        b=TC2r+shos3PvnTlGhemWMTI1tAZe6A9zkIbRBTvBK+uoX6/5G9J6oAwL0WH+srdvIW
         Hjk8JxwAb2MbIYVrD6oj71n5BlpxMH0WeQVaUzRyy19YiJBIf9wKGK174iEOKOevANwu
         +rGIaRYD4dB/FvwSc4KkHD4XZrAh6lsvisj+AusE+uG1ZFKt0CaJ2+dFL45ur7vsX/yl
         NRBk/oU+ZWf5g1JUWDFxpf6WG/hzCmH646Qtq0q4bgtRgdXBsGavjis6EQryswkTuvcn
         lNBFQXc2qC4cXfdDLSCY1jjeMVPIlwwXxalso1iirYnVg+Q06mnVQODCNpQiXb8nCnV6
         zOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708531352; x=1709136152;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pXMOhwD5qEr4jMu4yu+cDm4xZSeU+k4T71jhjLqjWWI=;
        b=ZYPrQbBq2O0it1lhuveeMD3wcAmuwPmoSqcNhW7NaF20JA+s8Foz5+1ex4235QTjBx
         oR7igxIFx+pD4TFzy2SOcoOGHry++ag7jfO5jtsLhShT+s45BkB5UIsK/XtbtYvBqmHl
         X6bs+oOZChR6SuiXLzRuAxHV2LorLnvbwdzLlIO4kb0lStTvgk8sgPgw+4HCSPgjWwbu
         AvmNsQOwh1swvNS2SSOwWMeTBny+PcOV7nCbTKb3SzeX+joGNl5b1gqcTMVkfdcwJFVi
         38MpF9EsGFN7tFi+GgVQ86J2af+9ey/7YaTyj0zPmDd09qGqXnSK7IbQ2vG8JmmZMDTl
         pkiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY2sfZVMr1BrUijfznrhWZYVem661We9mwvtTHSK/GdDXe3f39GSTBRj9HgR3OkG0taua6hz7l7F/BAF4LZAGmCHNjmmVnBCbBp1tZ
X-Gm-Message-State: AOJu0YxPizUZSQJLZ1QGCweXeSO5Zij4DJM/ssZzA+C8ZUgGnw8FTcAX
	cfwq0uFrMwKrPb6uRQTX4c4VJ69sWr4eaKo6icgwkYqcmhTAOsPUOGsOa8DtR20kdB4QZ3oSuza
	+SntJC0K+kQ==
X-Google-Smtp-Source: AGHT+IEQSmE+pix24dTxLHfotoQgbv1Z0gXzz2ZnjnupyHoB1Vw6PlSxU+BraxbINWyowl3J+NqG5SJCyd+0Bg==
X-Received: from szatan.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2d83])
 (user=panikiel job=sendgmr) by 2002:a05:690c:a:b0:608:2104:5c64 with SMTP id
 bc10-20020a05690c000a00b0060821045c64mr2767809ywb.3.1708531352282; Wed, 21
 Feb 2024 08:02:32 -0800 (PST)
Date: Wed, 21 Feb 2024 16:02:07 +0000
In-Reply-To: <20240221160215.484151-1-panikiel@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221160215.484151-1-panikiel@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221160215.484151-2-panikiel@google.com>
Subject: [PATCH v2 1/9] media: v4l2-subdev: Add a pad variant of .query_dv_timings()
From: "=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <panikiel@google.com>
To: airlied@gmail.com, akpm@linux-foundation.org, conor+dt@kernel.org, 
	daniel@ffwll.ch, dinguyen@kernel.org, hverkuil-cisco@xs4all.nl, 
	krzysztof.kozlowski+dt@linaro.org, maarten.lankhorst@linux.intel.com, 
	mchehab@kernel.org, mripard@kernel.org, robh+dt@kernel.org, 
	tzimmermann@suse.de
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	chromeos-krk-upstreaming@google.com, ribalda@chromium.org, 
	"=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <panikiel@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Currently, .query_dv_timings() is defined as a video callback without
a pad argument. This is a problem if the subdevice can have different
dv timings for each pad (e.g. a DisplayPort receiver with multiple
virtual channels).

To solve this, add a pad variant of this callback which includes
the pad number as an argument.

Signed-off-by: Pawe=C5=82 Anikiel <panikiel@google.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 11 +++++++++++
 include/media/v4l2-subdev.h           |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-cor=
e/v4l2-subdev.c
index 4c6198c48dd6..11f865dd19b4 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -389,6 +389,16 @@ static int call_enum_dv_timings(struct v4l2_subdev *sd=
,
 	       sd->ops->pad->enum_dv_timings(sd, dvt);
 }
=20
+static int call_query_dv_timings(struct v4l2_subdev *sd, unsigned int pad,
+				 struct v4l2_dv_timings *timings)
+{
+	if (!timings)
+		return -EINVAL;
+
+	return check_pad(sd, pad) ? :
+	       sd->ops->pad->query_dv_timings(sd, pad, timings);
+}
+
 static int call_get_mbus_config(struct v4l2_subdev *sd, unsigned int pad,
 				struct v4l2_mbus_config *config)
 {
@@ -489,6 +499,7 @@ static const struct v4l2_subdev_pad_ops v4l2_subdev_cal=
l_pad_wrappers =3D {
 	.set_edid		=3D call_set_edid,
 	.dv_timings_cap		=3D call_dv_timings_cap,
 	.enum_dv_timings	=3D call_enum_dv_timings,
+	.query_dv_timings	=3D call_query_dv_timings,
 	.get_frame_desc		=3D call_get_frame_desc,
 	.get_mbus_config	=3D call_get_mbus_config,
 };
diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
index a9e6b8146279..dc8963fa5a06 100644
--- a/include/media/v4l2-subdev.h
+++ b/include/media/v4l2-subdev.h
@@ -797,6 +797,9 @@ struct v4l2_subdev_state {
  * @enum_dv_timings: callback for VIDIOC_SUBDEV_ENUM_DV_TIMINGS() ioctl ha=
ndler
  *		     code.
  *
+ * @query_dv_timings: same as query_dv_timings() from v4l2_subdev_video_op=
s,
+ *		      but with additional pad argument.
+ *
  * @link_validate: used by the media controller code to check if the links
  *		   that belongs to a pipeline can be used for stream.
  *
@@ -868,6 +871,8 @@ struct v4l2_subdev_pad_ops {
 			      struct v4l2_dv_timings_cap *cap);
 	int (*enum_dv_timings)(struct v4l2_subdev *sd,
 			       struct v4l2_enum_dv_timings *timings);
+	int (*query_dv_timings)(struct v4l2_subdev *sd, unsigned int pad,
+				struct v4l2_dv_timings *timings);
 #ifdef CONFIG_MEDIA_CONTROLLER
 	int (*link_validate)(struct v4l2_subdev *sd, struct media_link *link,
 			     struct v4l2_subdev_format *source_fmt,
--=20
2.44.0.rc0.258.g7320e95886-goog


