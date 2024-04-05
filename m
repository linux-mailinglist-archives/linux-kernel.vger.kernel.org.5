Return-Path: <linux-kernel+bounces-133130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92282899F4B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3BFD1C226D9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67AF16F8FF;
	Fri,  5 Apr 2024 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="koNcX9m1"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38E816F853
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 14:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712326520; cv=none; b=tpvPQO7ODpwHOO38rxkv+MGAGn970zO+mE+WVRm7bRzWyK7QoeC+34/HWrTE6HkyrrG26qt5V5U7m7CCeDeGJBeHhhEnTJBZuUixJRixwM8uij/r8WwmsOk1ds6OYfyQJ0g78TPqmPY7hWmogQ6/J4EBCOfGFZTjG2eZOee8kWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712326520; c=relaxed/simple;
	bh=ZMS7hM6KW9z07sWnfqtb0vfUnCFSGDurCvDVGwpKtH4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lUcmF/Vrg0ISMr8qRgDN3SIHv9HBPA7PuvwNoTKFWa0lKqElK1aDPJuuHfOwsd23OpRGchqVBn0Pm6YTY44Wzrxw/CAdRUmwGopFdbR0URMXYoh8dmIU1EqqsmMgQglWfReNBuBED3QF/Izie01y0gB1QagHnJVMjbWPcMBWNxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=koNcX9m1; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61504a34400so35540817b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 07:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712326517; x=1712931317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=94YlLU32Aw+sMxB+PMoafcDiaHrqtTcDMU3Gx4Hxs1I=;
        b=koNcX9m1Ps2wwp0tQBqFmNo8qemsmuR+pkJ6lBfjalreLVYj/Zg9JtbXfU70owHpWh
         gPAqGJDJIhZIIxEwuucfEyiAylMu1JOTyWOleu7XpgjxDxixOvtMxq1/PVfx2//nLIEe
         w1eGhREbvLdrl6mgqJ0RWWrXZMzpYvQft2Znd3xun1qiWyJ6ZaHp61+1Y4BKDlfertnY
         0Vyc7SYwtitDBZ7TZLZ7iJIfTjJaoBFdEdSKJ/aEzElPRkcVOVJ/gVkXO4M+bbkDXGDl
         E3EjnCEcd7+9m1VEHmauaMeYN6EuJ20XJWndN9QzTn9M/x12GlY/BhXURA1Hl9CMWvbF
         WO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712326517; x=1712931317;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=94YlLU32Aw+sMxB+PMoafcDiaHrqtTcDMU3Gx4Hxs1I=;
        b=f/uCg6IfCB4uUKtTDbajgiXk0aavU88/T/Pl1SXpadd7VigD6MEyrJ/JSTW3eXMd9G
         XMEEOia4zDIxDQyOJtPmChGSEJe2BDJBrzqMpLZ4tJHSQqe9Wk9RyfyaNEj0zho7TKfo
         eL+IfX0FmMzNqjkgBTQ2i6C9BwFkmqJmkFQTla+ia6JiXKQ5eUFYKTFyUI2zSApbnGSu
         2A+R0m+ON6GUaA7T5ifoq+cFOf8nOSyPEXyNYz1EYIbzBxu/nR+gOpAtEdFDydzA0FQk
         8uigN6Ix/WasgqEX7Klhd3wvICG9JbqAc0gO0kBxYcR4MQKyKaMj2wl/KP5N6kPSID9y
         FF0A==
X-Forwarded-Encrypted: i=1; AJvYcCX4W4xGuWdvwBs4bdEUkngyD+egQ/YP7yp9cVDbKFFHFr+lWun3LvXALvQHgnv+7WrHLFhSKk65X/CfROBp5BNjcu6xz3C7+wZfLeFw
X-Gm-Message-State: AOJu0YycLB66e4ep86CAp7o/msHDxgZpTv5omwW4VVyGJFLhzoH5m3bJ
	iPr0jCVrjV3YkYbHVb9fP7Zv2GjFZNlb+nKsQdip/aXnTeblQSWEMeKboq59GrTNudaWifOWgNd
	Py3lKl18T8A==
X-Google-Smtp-Source: AGHT+IGrK5D+Al9x3FTMCHj14GU/jIUebXWjMWxE2WeT0/GABiLAK8y3wTuNfqwVvbVtebybpNUuNDmYAKkDAA==
X-Received: from szatan.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2d83])
 (user=panikiel job=sendgmr) by 2002:a05:6902:1502:b0:dd9:1b94:edb5 with SMTP
 id q2-20020a056902150200b00dd91b94edb5mr78790ybu.10.1712326517609; Fri, 05
 Apr 2024 07:15:17 -0700 (PDT)
Date: Fri,  5 Apr 2024 14:14:03 +0000
In-Reply-To: <20240405141411.1807189-1-panikiel@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405141411.1807189-1-panikiel@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405141411.1807189-9-panikiel@google.com>
Subject: [PATCH 08/16] media: i2c: ths7303: Switch dv timing callbacks to pad ops
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
 drivers/media/i2c/ths7303.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ths7303.c b/drivers/media/i2c/ths7303.c
index ea70c1c13872..5e4a76eaf507 100644
--- a/drivers/media/i2c/ths7303.c
+++ b/drivers/media/i2c/ths7303.c
@@ -193,7 +193,7 @@ static int ths7303_s_stream(struct v4l2_subdev *sd, int=
 enable)
 }
=20
 /* for setting filter for HD output */
-static int ths7303_s_dv_timings(struct v4l2_subdev *sd,
+static int ths7303_s_dv_timings(struct v4l2_subdev *sd, unsigned int pad,
 			       struct v4l2_dv_timings *dv_timings)
 {
 	struct ths7303_state *state =3D to_state(sd);
@@ -210,7 +210,6 @@ static int ths7303_s_dv_timings(struct v4l2_subdev *sd,
 static const struct v4l2_subdev_video_ops ths7303_video_ops =3D {
 	.s_stream	=3D ths7303_s_stream,
 	.s_std_output	=3D ths7303_s_std_output,
-	.s_dv_timings   =3D ths7303_s_dv_timings,
 };
=20
 #ifdef CONFIG_VIDEO_ADV_DEBUG
@@ -317,9 +316,14 @@ static const struct v4l2_subdev_core_ops ths7303_core_=
ops =3D {
 #endif
 };
=20
+static const struct v4l2_subdev_pad_ops ths7303_pad_ops =3D {
+	.s_dv_timings =3D ths7303_s_dv_timings,
+};
+
 static const struct v4l2_subdev_ops ths7303_ops =3D {
 	.core	=3D &ths7303_core_ops,
 	.video	=3D &ths7303_video_ops,
+	.pad	=3D &ths7303_pad_ops,
 };
=20
 static int ths7303_probe(struct i2c_client *client)
--=20
2.44.0.478.gd926399ef9-goog


