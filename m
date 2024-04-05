Return-Path: <linux-kernel+bounces-133135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB6E899F58
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815611C22063
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB3E171659;
	Fri,  5 Apr 2024 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1NDS4pOq"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0313C17108B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712326530; cv=none; b=ujB/9HZhiU65fJ2/EI1k1CN7X1LHUQgJRTQkxjMjzCMBycU8Iq8JY8k+FZOWFynslbrTmUwy12+5gUUgnQQG4fRm1fJDXUbgq16uJGlKhbSZTghrtmWesCAz50wXhg7FyZjbYJlp9dZ1Ug8S9XMR7kK7lViLF8K1z9k76Y5iHJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712326530; c=relaxed/simple;
	bh=yvs5ohvMMIVQE6dxuoqe23hp8oOeKkHAZNgJM1b+eKo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mCUkyR1iDD/nMrV6wjHk1mJ9WURLZhMn2BfmcEsy9H2mQVzpDedlNyCDsP6t3AUHyJmBmBSlicWJG8OjK63N2OC+zk0bqAdciHCjfxWlL1z6jH0sdoIDA5Dn7pEesPfnhBII4lbwA44F7wyxAYMrkW+1+5SYvVMqNtBs3YuJtzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1NDS4pOq; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf618042daso3441917276.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 07:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712326528; x=1712931328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/C3TWz2wSP1NLw9gzEQpvHS/0ZIC1cjOjpTFuVIJ/6s=;
        b=1NDS4pOqa1MUMC9X9Dt/O2w125FOzhVlpogK4thoUyLctqpGh6i+LY+PxQj3blJ1tX
         q1HxiQNm/TqaSWQXI4Dhd6Bpc3WbxrFWuHIIVl6NzsrNMeFOhG2pCso9dK6N2Znw2seH
         Jd0bIfy9dHMziuUc/RoqvpnmHX+uz2oJc7tDVtkB2rzWFhteVVq11SV/70QFLsBn6zPj
         toaipmG4wLpkq0u4SgM7qehQ/PGOJjAnZ9GzVBbu09qmALdAmIGrTGSjXjJHsk+ATIV6
         DA34rc44LaLekwFBaTkCRoQX881V9Jl0Y1YgCZwU04oQLTQOEDLb9+av/bVX3fzG7oto
         m0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712326528; x=1712931328;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/C3TWz2wSP1NLw9gzEQpvHS/0ZIC1cjOjpTFuVIJ/6s=;
        b=n3vaN7Jkz94/S0WEt4dzwtfnQDeR4jPP0QkJ/9qbfkLxszAN5/FEbFDREDFFJrGOgf
         PJiWvjTOwEe8TcXGJ+Rjg7bE8CTFVY40JmErnpQOOaj+E7dgsBjAYO0MDgD/yrxWfR3K
         OVGXNH4np8v0TxFhYQVFZJQP/uPDPeoLol8NwnJ0PgjVEDO+uj1DPoIMdoKt+394UGmr
         K20ZJmlzKz+FyhLk2GFtzWsQWbqAaynpLG/wXW145pEclGZv/6F6DtaR+Izcavau8l5c
         FnY4mr9RH2Tqprbizo+iNgD5UeUYK9jfgfJY89HT9L0WAW92Nza2AL/Ytgb8qIfaFBCL
         bmfw==
X-Forwarded-Encrypted: i=1; AJvYcCWZYnRk3mvLl1LbjOXzVBQ3qOFEFs7bG7g8RXhHE5eWKilREvUKZts/l3gayJLD9KkJLeZ8lOc5ZgsM2XxjagICRc1B+HNmA6XlWiwQ
X-Gm-Message-State: AOJu0YzlafOCSE5tmhSPipWuNK4YPmzLZ5k6yD0v8eZYDal62gxRzyD1
	/Xu+DNURtR9oNNbxJNXuN1J3yXzCyCQ7hEO1cK8rDh1a/owZw9Ia+86ecFjK3ilTCCnhlS48w2l
	R1Dj08SSLKA==
X-Google-Smtp-Source: AGHT+IEvp+BsuWIh3iX4/LFegWn3KNCA11AfpYD2+Kk6/aMGIrt5lA5NyDXfFDJdRSyf+ooQiTrgoqyEH/yGTA==
X-Received: from szatan.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2d83])
 (user=panikiel job=sendgmr) by 2002:a05:6902:1108:b0:dc7:865b:22c6 with SMTP
 id o8-20020a056902110800b00dc7865b22c6mr78546ybu.8.1712326528036; Fri, 05 Apr
 2024 07:15:28 -0700 (PDT)
Date: Fri,  5 Apr 2024 14:14:08 +0000
In-Reply-To: <20240405141411.1807189-1-panikiel@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405141411.1807189-1-panikiel@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405141411.1807189-14-panikiel@google.com>
Subject: [PATCH 13/16] media: rcar-vin: Use pad variant of dv timing subdev calls
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
 drivers/media/platform/renesas/rcar-vin/rcar-v4l2.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/renesas/rcar-vin/rcar-v4l2.c b/drivers/=
media/platform/renesas/rcar-vin/rcar-v4l2.c
index 073f70c6ac68..bb4b07bed28d 100644
--- a/drivers/media/platform/renesas/rcar-vin/rcar-v4l2.c
+++ b/drivers/media/platform/renesas/rcar-vin/rcar-v4l2.c
@@ -730,7 +730,8 @@ static int rvin_s_dv_timings(struct file *file, void *p=
riv_fh,
 	struct v4l2_subdev *sd =3D vin_to_source(vin);
 	int ret;
=20
-	ret =3D v4l2_subdev_call(sd, video, s_dv_timings, timings);
+	ret =3D v4l2_subdev_call(sd, pad, s_dv_timings,
+			       vin->parallel.sink_pad, timings);
 	if (ret)
 		return ret;
=20
@@ -744,7 +745,8 @@ static int rvin_g_dv_timings(struct file *file, void *p=
riv_fh,
 	struct rvin_dev *vin =3D video_drvdata(file);
 	struct v4l2_subdev *sd =3D vin_to_source(vin);
=20
-	return v4l2_subdev_call(sd, video, g_dv_timings, timings);
+	return v4l2_subdev_call(sd, pad, g_dv_timings,
+				vin->parallel.sink_pad, timings);
 }
=20
 static int rvin_query_dv_timings(struct file *file, void *priv_fh,
@@ -753,7 +755,8 @@ static int rvin_query_dv_timings(struct file *file, voi=
d *priv_fh,
 	struct rvin_dev *vin =3D video_drvdata(file);
 	struct v4l2_subdev *sd =3D vin_to_source(vin);
=20
-	return v4l2_subdev_call(sd, video, query_dv_timings, timings);
+	return v4l2_subdev_call(sd, pad, query_dv_timings,
+				vin->parallel.sink_pad, timings);
 }
=20
 static int rvin_dv_timings_cap(struct file *file, void *priv_fh,
--=20
2.44.0.478.gd926399ef9-goog


