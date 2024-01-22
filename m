Return-Path: <linux-kernel+bounces-33258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A80AC836774
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCADC1C2320C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519D054BCE;
	Mon, 22 Jan 2024 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuGJ/qdK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9406854674;
	Mon, 22 Jan 2024 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935509; cv=none; b=CKxDgkrzNvHEAxxVTKOXl6RWiFch1HIizfSadHg7c4JNoSQcTKzXeuXrLN6hY+UenGvLn508TGnpO02cWRJcYnBf4GflngC1LbleoLtHJ46o4Dp1FTFqKqlrrUL+5KnPAgtujuHQQbCF14+W1aydWz2Ii1DC37ZYA6qHi4Y7cbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935509; c=relaxed/simple;
	bh=0vse99/kKixfDBqusosdmXGea5zqNdeoyLw1kNT6yJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fx85OLCaZT5LvSVp460o2MQMLihKLng9e2NbMha+vyf79KcEuF22l//omQ+RUO7lwzh+ojnpFLdEMt1hc7sQ84dq5fkMd8fcplqE41E7ETjv4HE/gVOzjGtCzpdd9+jCGpPvEdfwXGTHkfGB2wIIqnUJHjma8aQ14KNg70ziXnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuGJ/qdK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AE3C433F1;
	Mon, 22 Jan 2024 14:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935509;
	bh=0vse99/kKixfDBqusosdmXGea5zqNdeoyLw1kNT6yJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CuGJ/qdKzTaug7p4Kx+GHjVuHZ+ZmqXP2xFP0glzIab2YqqKxz4rnJEeCeYIzH9qs
	 R9kBcbouB/qxhwAd5zMRTshNAzOgLggXYfeZZU+KvLsjulN9zbwLpDvGKDuJB3q7wW
	 fyiw8RL/gWCTzsuRJzCLJ3CVOmZugAh5S+/X51oTGf/G0OfVzbXfy/fAL0C5ya6JWD
	 lq0Iv+7m/079m89VDa65Vh1vtNpePtS6wRkov/qd6zHEk2pjixHVdS7gq96ixM1yHa
	 3mARX/5phH91cOc5pobI3oEHlSb0yNduwwpRjNCw+Bx0Un/TFtjm+i9UYTvdrEssLX
	 AtCLQhLEUIdOw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Paul Elder <paul.elder@ideasonboard.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dafna@fastmail.com,
	heiko@sntech.de,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.7 39/88] media: rkisp1: resizer: Stop manual allocation of v4l2_subdev_state
Date: Mon, 22 Jan 2024 09:51:12 -0500
Message-ID: <20240122145608.990137-39-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
Content-Transfer-Encoding: 8bit

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

[ Upstream commit efa28efd9cba015f8c3d88123527c3c3cfcd13d0 ]

Supported media bus codes on the resizer sink pad are identical to the
ISP source pad. The .enum_mbus_code() handler thus delegates the
enumeration to the ISP's operation. This is problematic for two
reasons:

- Format enumeration on the ISP source pad is dependent on the format
  configured on the ISP sink pad for the same subdev state (TRY or
  ACTIVE), while format enumeration on the resizer sink pad should
  return all formats supported by the resizer subdev, regardless of the
  ISP configuration.

- Delegating the operation involves creating a fake v4l2_subdev_state on
  the stack to pass to the ISP .enum_mbus_code() handler. This gets in
  the way of evolution of both the ISP enumeration handler and, more
  generally, the V4L2 subdev state infrastructure.

Fix those two issues by implementing format enumeration manually for the
resizer.

Link: https://lore.kernel.org/r/20231126020948.2700-1-laurent.pinchart@ideasonboard.com

Reviewed-by: Paul Elder <paul.elder@ideasonboard.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../platform/rockchip/rkisp1/rkisp1-resizer.c | 38 ++++++++++++-------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
index 28ecc7347d54..6297870ee9e9 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
@@ -335,12 +335,8 @@ static int rkisp1_rsz_enum_mbus_code(struct v4l2_subdev *sd,
 {
 	struct rkisp1_resizer *rsz =
 		container_of(sd, struct rkisp1_resizer, sd);
-	struct v4l2_subdev_pad_config dummy_cfg;
-	struct v4l2_subdev_state pad_state = {
-		.pads = &dummy_cfg
-	};
-	u32 pad = code->pad;
-	int ret;
+	unsigned int index = code->index;
+	unsigned int i;
 
 	if (code->pad == RKISP1_RSZ_PAD_SRC) {
 		/* supported mbus codes on the src are the same as in the capture */
@@ -360,15 +356,29 @@ static int rkisp1_rsz_enum_mbus_code(struct v4l2_subdev *sd,
 		return 0;
 	}
 
-	/* supported mbus codes on the sink pad are the same as isp src pad */
-	code->pad = RKISP1_ISP_PAD_SOURCE_VIDEO;
-	ret = v4l2_subdev_call(&rsz->rkisp1->isp.sd, pad, enum_mbus_code,
-			       &pad_state, code);
+	/*
+	 * Supported mbus codes on the sink pad are the same as on the ISP
+	 * source pad.
+	 */
+	for (i = 0; ; i++) {
+		const struct rkisp1_mbus_info *fmt =
+			rkisp1_mbus_info_get_by_index(i);
 
-	/* restore pad */
-	code->pad = pad;
-	code->flags = 0;
-	return ret;
+		if (!fmt)
+			break;
+
+		if (!(fmt->direction & RKISP1_ISP_SD_SRC))
+			continue;
+
+		if (!index) {
+			code->code = fmt->mbus_code;
+			return 0;
+		}
+
+		index--;
+	}
+
+	return -EINVAL;
 }
 
 static int rkisp1_rsz_init_config(struct v4l2_subdev *sd,
-- 
2.43.0


