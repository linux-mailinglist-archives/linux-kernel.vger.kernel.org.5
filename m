Return-Path: <linux-kernel+bounces-133138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2B9899F5E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B3A281653
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5BB171E7F;
	Fri,  5 Apr 2024 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yCIY2Y5r"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC8416F0D3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712326536; cv=none; b=Wk66UdIAhbSvGF27wLpXC4vmbI4CrHmpwRhdknh5aua/zT1iT709bpgawSkvDmutQkXwnR6RREzvFys7Huf1Jz6XIoaaWU6Dd+EP50Kk7kGU2pUhasYT4Onq6RFchr9sq3VeGLfIVdMkr53eowI+NFHmLPh3AEEjpImf8t/UIEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712326536; c=relaxed/simple;
	bh=i4Tr+nVq+Xi4RO9+q//9cew+LkXLU25d9j5EEYLNZ0w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XmoTCjvLThMe/PtUpUgOgw9PnlzDXwWNZQ8cp9/Q20SyleQRFZRr/EDxSenNT+cUfPQMaeZ+P32MaDBsTEZ2UcOrpg0eIQyVSfK+LhLuN++G0qwpnuhWyxT3i1FFXGF0awaRNs5Y+mJq20eH/CTmJfv0CeVwnXLLjmvkT2AwjB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yCIY2Y5r; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a61b31993so36780037b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 07:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712326534; x=1712931334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zsDOfX+3b1RUaLhcJa3oIsCx6Cf2GznngtDV1SnNmvI=;
        b=yCIY2Y5r52Kg6SeycmYxCmlYo5begxTNog5Kx0TJ9ixkHE7TKjqSHA6Ykf72dzaucG
         fYUsOsB7xI2/Lp8dPDQxyitXD+hKdadvHKdreDk03wTWvegycvnnQjysvhOYd+GmNsJM
         V9INDvqTjD6zRrL1UW3oVrRwAyVStaq89EU2rLASAn4InIOBcK9XUKm64D7zObIAPVT7
         +KDf2U0j1fJXvQZ9EI4wj4PkXVmfYySLWw921dCyKovkc0JlgyxyAMVugJreVfC8K6+J
         41LVyunD7aJBqE0+iKbMHbJOz3IsO3XgHc8nHPNZUCuxYx74dTJV0yRqaiYug50wnzoc
         13Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712326534; x=1712931334;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zsDOfX+3b1RUaLhcJa3oIsCx6Cf2GznngtDV1SnNmvI=;
        b=dZxE7JgrwutEmjkX0ffme9uj+EH4icf8+tHf9e78K+59FJT6MPhKkyEdwJA29IGBv8
         JMQ4aZT7Nnj3FPJ/cyjRRclTFG7gaCP43EOB04eFLpqaB24q3OTiBZeXFG0//cdN5SOO
         vke9NIJ8uc3WlztbaRchzUW6GlywVycbzsKdtJhcZfjfeE87I4sINPbGoAOrUDcaQJPw
         QAlG3thNARnR/Lg3ubHYQ10CjLC7TU66xxH3Gn2VaYkupwk3ZB5AOGdZSytTigvO2rbe
         2la1EzZg76e6ahpf6KFUFA8PW2Uu1jdQqsBMiTrIwV9gT0CqUJIb9HdJYFoLIKSntz3n
         o8Iw==
X-Forwarded-Encrypted: i=1; AJvYcCXIIJCTnQtvH8AecAKR9A+ynbthBjSTx8WjF9tRSGsZBl3wL4lWZaEK+21OlziAObXgWY/QJXw6mwrnTzwT4Y5wwzbbXCV/rxcmNIJe
X-Gm-Message-State: AOJu0YzrImmr0kxumqx4yoLiP+jsARWHaLBJVmz8Bav8dXYZHptENgC9
	JwA6c0zdKuWUkRZNHSbsBiJnMHmIPMeYtgCjwEyELc/SlfamFDWSnL9W1qeenHuNldoc+jGsWax
	oX68Cbi/uoA==
X-Google-Smtp-Source: AGHT+IEazU1D3+af0NVMWywuHy/ujQAr1fDtXw2VNn2XTE2hgtIiqfvfx0Pk6JxWWw8zhjW8vAbmO2PrbYxeKw==
X-Received: from szatan.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2d83])
 (user=panikiel job=sendgmr) by 2002:a81:6c92:0:b0:617:cb4f:a5df with SMTP id
 h140-20020a816c92000000b00617cb4fa5dfmr370403ywc.3.1712326534377; Fri, 05 Apr
 2024 07:15:34 -0700 (PDT)
Date: Fri,  5 Apr 2024 14:14:11 +0000
In-Reply-To: <20240405141411.1807189-1-panikiel@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405141411.1807189-1-panikiel@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405141411.1807189-17-panikiel@google.com>
Subject: [PATCH 16/16] media: v4l2-subdev: Remove non-pad dv timing callbacks
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

After the conversion of dv timing calls to use a pad argument is done,
remove the old callbacks. Update the subdev ioctl handlers to use the
new callbacks.

Signed-off-by: Pawe=C5=82 Anikiel <panikiel@google.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c |  6 +++---
 include/media/v4l2-subdev.h           | 14 --------------
 2 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-cor=
e/v4l2-subdev.c
index 07759cdd0844..6572667fd5c4 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -906,16 +906,16 @@ static long subdev_do_ioctl(struct file *file, unsign=
ed int cmd, void *arg,
 	}
=20
 	case VIDIOC_SUBDEV_QUERY_DV_TIMINGS:
-		return v4l2_subdev_call(sd, video, query_dv_timings, arg);
+		return v4l2_subdev_call(sd, pad, query_dv_timings, 0, arg);
=20
 	case VIDIOC_SUBDEV_G_DV_TIMINGS:
-		return v4l2_subdev_call(sd, video, g_dv_timings, arg);
+		return v4l2_subdev_call(sd, pad, g_dv_timings, 0, arg);
=20
 	case VIDIOC_SUBDEV_S_DV_TIMINGS:
 		if (ro_subdev)
 			return -EPERM;
=20
-		return v4l2_subdev_call(sd, video, s_dv_timings, arg);
+		return v4l2_subdev_call(sd, pad, s_dv_timings, 0, arg);
=20
 	case VIDIOC_SUBDEV_G_STD:
 		return v4l2_subdev_call(sd, video, g_std, arg);
diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
index a5213411ef2b..1af16b16f0bf 100644
--- a/include/media/v4l2-subdev.h
+++ b/include/media/v4l2-subdev.h
@@ -452,14 +452,6 @@ enum v4l2_subdev_pre_streamon_flags {
  *
  * @g_pixelaspect: callback to return the pixelaspect ratio.
  *
- * @s_dv_timings: Set custom dv timings in the sub device. This is used
- *	when sub device is capable of setting detailed timing information
- *	in the hardware to generate/detect the video signal.
- *
- * @g_dv_timings: Get custom dv timings in the sub device.
- *
- * @query_dv_timings: callback for VIDIOC_QUERY_DV_TIMINGS() ioctl handler=
 code.
- *
  * @s_rx_buffer: set a host allocated memory buffer for the subdev. The su=
bdev
  *	can adjust @size to a lower value and must not write more data to the
  *	buffer starting at @data than the original value of @size.
@@ -490,12 +482,6 @@ struct v4l2_subdev_video_ops {
 	int (*g_input_status)(struct v4l2_subdev *sd, u32 *status);
 	int (*s_stream)(struct v4l2_subdev *sd, int enable);
 	int (*g_pixelaspect)(struct v4l2_subdev *sd, struct v4l2_fract *aspect);
-	int (*s_dv_timings)(struct v4l2_subdev *sd,
-			struct v4l2_dv_timings *timings);
-	int (*g_dv_timings)(struct v4l2_subdev *sd,
-			struct v4l2_dv_timings *timings);
-	int (*query_dv_timings)(struct v4l2_subdev *sd,
-			struct v4l2_dv_timings *timings);
 	int (*s_rx_buffer)(struct v4l2_subdev *sd, void *buf,
 			   unsigned int *size);
 	int (*pre_streamon)(struct v4l2_subdev *sd, u32 flags);
--=20
2.44.0.478.gd926399ef9-goog


