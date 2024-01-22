Return-Path: <linux-kernel+bounces-33355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630068368DB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4133CB2BBBB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2656266B3C;
	Mon, 22 Jan 2024 15:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhlpmKW3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6825D66B29;
	Mon, 22 Jan 2024 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935962; cv=none; b=QPZgi4oIqJF3d24HSp18Y1JvpP8m0n6kpqp06D4zfJ1mnmLg0H2SDimR3SaXi1+2xfumvzHnwFyMPH5OtzYxIbq6zG1osX29kuAXo4dzJiSOvwdRXxfJFNCj0Ph+ulzoDIgfmRu0hnH6epjKxzaHWLfYCS8Dq/WYDzeCzMaD7Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935962; c=relaxed/simple;
	bh=hf/H0+yhOOVplRLK4SCGzNdBfN3H+R6kuy4AeT/hJ2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqN2HHEamaQpmJB87TvqF/yKzX0p7RTDy9Ww1VRalgNSypbE3ic/Rie5MMmpflGk6pjJnwjDZ9cEuF1iMhFVpyLW/Qgqq7n+m3wrPgKe1FcjC4b3buhoUhQvGBDcBDxaUoYr4Nlwbug3hBFlj8A/e07jUAYB2Sb7oKGI1p3W0VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhlpmKW3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73B2C43390;
	Mon, 22 Jan 2024 15:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935962;
	bh=hf/H0+yhOOVplRLK4SCGzNdBfN3H+R6kuy4AeT/hJ2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UhlpmKW3Zs1GXAGglGMaB1sXjdZ8AZOY5oEkWZgs6aRlorGmwAgE5Ih9bBhw4p5XP
	 WY0AuAh9g9NaivzVB+rbpniJL1fsyyx6cmPQ+jxoiRfgl5HlaQIOxp9EenG07rrP8r
	 2iB7TVA5J9GYBwcZm7pl4oM25iT9fVNbSCGxeBksbXTBes03eIM775Id8Q8k+ACBKd
	 b0uF+k0MRdeYVZpaxNTOGEMVtTlmrZTY/sxDvTRDUnQUC/P28f3dQapnc4tskXLsbT
	 tir5kDj0CmxoMt/rH286mugKar2Yi2b8bG1cpgPIZCLlMP2FrZZladGyfr6eOS9Vqv
	 XJrd7Md81v5ZA==
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
Subject: [PATCH AUTOSEL 6.6 33/73] media: rkisp1: resizer: Stop manual allocation of v4l2_subdev_state
Date: Mon, 22 Jan 2024 10:01:47 -0500
Message-ID: <20240122150432.992458-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
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
index c15ae0218118..eb0aae56d2c7 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
@@ -363,12 +363,8 @@ static int rkisp1_rsz_enum_mbus_code(struct v4l2_subdev *sd,
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
@@ -388,15 +384,29 @@ static int rkisp1_rsz_enum_mbus_code(struct v4l2_subdev *sd,
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


