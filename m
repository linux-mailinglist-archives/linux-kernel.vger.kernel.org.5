Return-Path: <linux-kernel+bounces-133136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 883D4899F5A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2807B1F268A7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4114C17167F;
	Fri,  5 Apr 2024 14:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K6d0uWwc"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A49171653
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 14:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712326532; cv=none; b=H3D7JcyExhQ9zgr9QI6Nt5GGrmbWGW0/zKcvGryzleR8CFtK0LejVXW+Ljo0hphgKUXpzcrtojp4aPtbDy4kInZ7uq26ybYC3XukJ8PmBVuZWO91gPHaOewLGDNZhDYHOz1beHn/ESedzJMV1NyfDv8Odv20/eMoffamsSH/01g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712326532; c=relaxed/simple;
	bh=Gj3IPZ/cV8XkfW4/IgCRVRhUfpKtTDbbVSp/MYuw5kI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ogqV4T8tjg8aSZja/GzLl28jXU3sN7JLCUjmy6Gmy8X0KR71FlKuVV3l2IkCYMmuT/ZKfDyuuKm04cHABZS497BrwXm+HsHA/DdKO/01dAa8kwFRAGDSlJ0SrSt0olnEWlGML8Rmz1R3tM+UIQ62hrqfZ3NsJ/i2OijyzJ3in7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K6d0uWwc; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcbfe1a42a4so3760997276.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 07:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712326530; x=1712931330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9A37cgV5rFPpxOwI7Xp0bOeOJhNv60o94qm0Vr/m29M=;
        b=K6d0uWwcZnkeh2hgIAOIU90QMYBZDeteKQ4gzvEQq+0lJzMIcPQk6p9Uo28cu+0ZvH
         uJh6ZGYj0UvMdPqoM9OvAZ69pXJn4x17eaLVy3d7yqctq0l64KWzPXpDY1iHcBPvWHqj
         QtTgfIVihF6LADjHlUllvC77h/v2kxJfD50K4EvuutWr5VRDUkuOre/QqvvXnff6OGfB
         MpHV1F098tnZw9ZFL5F2KEharw3+VlmjVVzbpSOn5jlvxdC7fjUQRQ33FrbIvKK+4E25
         RTm2jv8M8IOxoJfbC8C7Xb5cDYgPrfJLtV0Y1voUENLKENjmThRtpg7NdE+Ow5ykj6Rn
         gVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712326530; x=1712931330;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9A37cgV5rFPpxOwI7Xp0bOeOJhNv60o94qm0Vr/m29M=;
        b=qpVM1P5mOEWby0Pt6V1/n8bpZRggJoH6CcFiF2b+tlRdudhSA9H2UJ0Szj9sm9Rgqa
         +WQ3sP5Hb2h4nZVSxxBPix79YLApFVVNmGa7WDK76ywSLz9lh+VJ70fuqIiTR2DX6ddC
         ygUHozO2l3kV6hw6HVPvX/40e1lRGRJwwRvjwHxHUmjRWsjHtTL77aDTILR0MEqeDH5P
         CHg64WY1iJfJNrItjYPT2E8pqcAMNO12HiEFjkI+QDiIX1qeIQwFNGEVl1E+9xVW+1uV
         VCj/G23UGMwm2OLqdUr/QN6YKs67OLh1i29KmzYAwLuQR0DMSQj186g9EW39WA4LcGGP
         McPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyWpBDhwF34yn3tbS6cUROD7M0Oo16RbkInolI+UcCJ5nJ0YbBoMbpCePqKqTWxazaTtMSYxrIdqPueZt9MW/eUP/6OvLd45TpSteF
X-Gm-Message-State: AOJu0Yxe7Owq3iHH22x5c/kiEr7n7iRPcnw+07klcvAvcwhGSJhRsnow
	mTdN8Uook6sFqXQbjBEKg40SAe6fjCJyvGint/ZU5LXweKANWOn2W/X4Jkp5lrlTGIuQxtQUZat
	yq9x8URNEXw==
X-Google-Smtp-Source: AGHT+IGf8GetzSX8AEJwlaqvDvL5MrA0JXoPMyjXUoUj+or0FEsWZ+U/ylOjbpKO18vhlQTas1pDdH/t0YW6Kw==
X-Received: from szatan.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2d83])
 (user=panikiel job=sendgmr) by 2002:a05:6902:100b:b0:dcc:6065:2b3d with SMTP
 id w11-20020a056902100b00b00dcc60652b3dmr394034ybt.8.1712326530209; Fri, 05
 Apr 2024 07:15:30 -0700 (PDT)
Date: Fri,  5 Apr 2024 14:14:09 +0000
In-Reply-To: <20240405141411.1807189-1-panikiel@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405141411.1807189-1-panikiel@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405141411.1807189-15-panikiel@google.com>
Subject: [PATCH 14/16] media: vpif_capture: Use pad variant of dv timing
 subdev calls
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
 drivers/media/platform/ti/davinci/vpif_capture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/ti/davinci/vpif_capture.c b/drivers/med=
ia/platform/ti/davinci/vpif_capture.c
index c31a5566fc5a..c28794b6677b 100644
--- a/drivers/media/platform/ti/davinci/vpif_capture.c
+++ b/drivers/media/platform/ti/davinci/vpif_capture.c
@@ -1132,7 +1132,7 @@ vpif_query_dv_timings(struct file *file, void *priv,
 	if (input.capabilities !=3D V4L2_IN_CAP_DV_TIMINGS)
 		return -ENODATA;
=20
-	ret =3D v4l2_subdev_call(ch->sd, video, query_dv_timings, timings);
+	ret =3D v4l2_subdev_call(ch->sd, pad, query_dv_timings, 0, timings);
 	if (ret =3D=3D -ENOIOCTLCMD || ret =3D=3D -ENODEV)
 		return -ENODATA;
=20
@@ -1177,7 +1177,7 @@ static int vpif_s_dv_timings(struct file *file, void =
*priv,
 		return -EBUSY;
=20
 	/* Configure subdevice timings, if any */
-	ret =3D v4l2_subdev_call(ch->sd, video, s_dv_timings, timings);
+	ret =3D v4l2_subdev_call(ch->sd, pad, s_dv_timings, 0, timings);
 	if (ret =3D=3D -ENOIOCTLCMD || ret =3D=3D -ENODEV)
 		ret =3D 0;
 	if (ret < 0) {
--=20
2.44.0.478.gd926399ef9-goog


