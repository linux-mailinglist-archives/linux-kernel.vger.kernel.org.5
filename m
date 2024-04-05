Return-Path: <linux-kernel+bounces-133134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3FA899F56
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6A451C226CD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FD316FF3D;
	Fri,  5 Apr 2024 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ifTDKXB0"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87956171073
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 14:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712326529; cv=none; b=MBxmm46zHmxNRlnaNTTkKvcybW/Gy3fvEpbDMEfrbh30U3dXGDllCn1S3vGHK93U8IV+xNgNkueLuhKVrJC0NiS7qgDAtPvbZUyMmK0dl1v1tmeh8CJYInJ8jWFy811PprTSqfEhK+0ac4RTWs3F0AzOziqFgvtVnb1/7gBiG4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712326529; c=relaxed/simple;
	bh=mfc1m6KDq5p7GnXUa2OC5+vQdowDmHrvR4jMIquIzew=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oxSx50GD1neBrQlAX4ceWVM+Q9OhyHXV2iEN2lWkCQaB+ROEVHQhHSY3FbASmhVNEBgJEBRxH/d3DXwvm6SNj1i+38Kyc+OZhwT7RIzX7aLUnPyAKDgxOPwTj+dtC7+CWlIfMWHgaKjMb3b1l8GSYA9DW3JMlUR8CZd83BJ2RM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ifTDKXB0; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-41545bc8962so11152515e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 07:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712326526; x=1712931326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wugwx+VMt8ynxKvmOS+NYWFgHzSCikAiIg38gbA/J2Y=;
        b=ifTDKXB0IPsN1TKwwdaZSIgfQoNkhEOnvZkZzg5fnDOGNxgCPUzzU+JdxPp9RMvBii
         sPZNCCPprlffIp0fm7cbh6ucvJ2nieW20NrJMnUGK5K8tadoiYevaId3Af/MzMuo2HDD
         NHdPgOqR0lFxer+/mtFEVfISh4nmxFOE7GBdlUG8IJpoYIIjGvs1gY0dluiti9Iwi4c8
         cQFnH6htFZlOoN3QKYoSzPDIJyPTWth7dq4aGOb3HQLR0dq5lNpLk2U+d/Ejg6icrziz
         wxzSPsyWoWKLHXWM4yoVEX6Z+VFZot9UBEdaFDTdnCDOuJMcpoDnqIiFGVpWdxgRSRuO
         odRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712326526; x=1712931326;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wugwx+VMt8ynxKvmOS+NYWFgHzSCikAiIg38gbA/J2Y=;
        b=IXAoQpQQ59LDReAeqAEYOkwbZg1SOrmwcBnSBCHI8ttamRLKaLYJvfztSoU1/KRtgg
         GPOlnVaHkca3ptW6VYEBKu/eNg0NVVcB3Mch7ErXhnUKPR/9nurEE5VnkceHF3y29/S3
         ZUFqsHxXjeLHBntYybycIy9TYZ+OA1+blBro2mjjjWkIMHe0owydYfy4eCjImjk/E90n
         3PY+JfG4D2bZdpRKBCNQjdgKcoOTQ3PiPhTlQO1I4pUhOu7CmPot9ajFs2Fo0glGSHKM
         o9eYF8Hs38rX8NkZEemKJhplxIdgEpDJhaQwxZPjFBzpc1eOLcDBJjfwVM8VynvjHZOc
         BOwg==
X-Forwarded-Encrypted: i=1; AJvYcCWta32cAqorIyjB+ZJY+QWG4c3AjocrGGYe67hfBG60fgjzgiUNqXNq/Lg2db9FoDX60cXkbjgVfloCPDmMTfjJv/POHzoU9qt2UJKX
X-Gm-Message-State: AOJu0YyQXFnJDzka1AhwGTBHHlmKDKiOCE4eGYta8NygEzcMbgVDEVU0
	z/blITr7/f+lsp79pxWCJtUL1npnnlcTQHHMUztMHfaRS2pNGarsxxn1VOTUry+Vkju0eBSMfow
	9ZcFB3xhyOA==
X-Google-Smtp-Source: AGHT+IEw3A0Uc6NCN5jC8nFV1gniwcXIKQUoVyZzSeSYIjiu5QNMVRGAQCd+P4ZhwXiSptLaQwbbPf4g4bXbXg==
X-Received: from szatan.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2d83])
 (user=panikiel job=sendgmr) by 2002:a05:600c:3b8e:b0:414:8933:a617 with SMTP
 id n14-20020a05600c3b8e00b004148933a617mr4543wms.4.1712326525846; Fri, 05 Apr
 2024 07:15:25 -0700 (PDT)
Date: Fri,  5 Apr 2024 14:14:07 +0000
In-Reply-To: <20240405141411.1807189-1-panikiel@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405141411.1807189-1-panikiel@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405141411.1807189-13-panikiel@google.com>
Subject: [PATCH 12/16] media: cobalt: Use pad variant of dv timing subdev calls
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
 drivers/media/pci/cobalt/cobalt-v4l2.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/pci/cobalt/cobalt-v4l2.c b/drivers/media/pci/cob=
alt/cobalt-v4l2.c
index 77ba08ace29f..d4d7b264c965 100644
--- a/drivers/media/pci/cobalt/cobalt-v4l2.c
+++ b/drivers/media/pci/cobalt/cobalt-v4l2.c
@@ -633,7 +633,7 @@ static int cobalt_s_dv_timings(struct file *file, void =
*priv_fh,
 		return -EBUSY;
=20
 	err =3D v4l2_subdev_call(s->sd,
-			video, s_dv_timings, timings);
+			pad, s_dv_timings, 0, timings);
 	if (!err) {
 		s->timings =3D *timings;
 		s->width =3D timings->bt.width;
@@ -653,7 +653,7 @@ static int cobalt_g_dv_timings(struct file *file, void =
*priv_fh,
 		return 0;
 	}
 	return v4l2_subdev_call(s->sd,
-			video, g_dv_timings, timings);
+			pad, g_dv_timings, 0, timings);
 }
=20
 static int cobalt_query_dv_timings(struct file *file, void *priv_fh,
@@ -666,7 +666,7 @@ static int cobalt_query_dv_timings(struct file *file, v=
oid *priv_fh,
 		return 0;
 	}
 	return v4l2_subdev_call(s->sd,
-			video, query_dv_timings, timings);
+			pad, query_dv_timings, 0, timings);
 }
=20
 static int cobalt_dv_timings_cap(struct file *file, void *priv_fh,
@@ -1080,7 +1080,7 @@ static int cobalt_g_pixelaspect(struct file *file, vo=
id *fh,
 	if (s->input =3D=3D 1)
 		timings =3D cea1080p60;
 	else
-		err =3D v4l2_subdev_call(s->sd, video, g_dv_timings, &timings);
+		err =3D v4l2_subdev_call(s->sd, pad, g_dv_timings, 0, &timings);
 	if (!err)
 		*f =3D v4l2_dv_timings_aspect_ratio(&timings);
 	return err;
@@ -1099,7 +1099,7 @@ static int cobalt_g_selection(struct file *file, void=
 *fh,
 	if (s->input =3D=3D 1)
 		timings =3D cea1080p60;
 	else
-		err =3D v4l2_subdev_call(s->sd, video, g_dv_timings, &timings);
+		err =3D v4l2_subdev_call(s->sd, pad, g_dv_timings, 0, &timings);
=20
 	if (err)
 		return err;
@@ -1243,7 +1243,7 @@ static int cobalt_node_register(struct cobalt *cobalt=
, int node)
 		if (s->sd)
 			vdev->ctrl_handler =3D s->sd->ctrl_handler;
 		s->timings =3D dv1080p60;
-		v4l2_subdev_call(s->sd, video, s_dv_timings, &s->timings);
+		v4l2_subdev_call(s->sd, pad, s_dv_timings, 0, &s->timings);
 		if (!s->is_output && s->sd)
 			cobalt_enable_input(s);
 		vdev->ioctl_ops =3D s->is_dummy ? &cobalt_ioctl_empty_ops :
--=20
2.44.0.478.gd926399ef9-goog


