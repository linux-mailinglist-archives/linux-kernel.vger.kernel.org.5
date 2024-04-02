Return-Path: <linux-kernel+bounces-128372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EB5895A0A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EF92284B57
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FA4159913;
	Tue,  2 Apr 2024 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USZU5DEX"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D93A15AD81;
	Tue,  2 Apr 2024 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076382; cv=none; b=ELB4IYZIU1tjiSMRBZ14aAWEUEIsZ1Ef+vhkR7kKszwTMZkDNQjL/BoDZIterT59iWdCyjME1LAxtrY6y2tVUIOIuhbtSG4tDef6YMUqsB6d1rj9iRb81ryFebOiDlUEPpjEB82Y7T8/4F6EtPEzxJ7tQM/u008xSd7oy3W87GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076382; c=relaxed/simple;
	bh=gtV7owZRYzoOjVE9V7/zetWs7Op+tJKE99DwxPJUt8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7bEevUZdWLC2pmKzrGf5WJaMd2iGYgv7xU1/O8p5Yb4r94kIgRG4N6ZOSlMW6NEmGzH4pEz2Yy4on+lJTI9/jV9AZciVJ41aLWvZ7adJaKkfdNud+H+4PhBjTPkkW6+caWxSbWU0RmRxI1qfYo1oSbw7H+u2HjZRsadOgoC7fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USZU5DEX; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-516b6e75dc3so861881e87.3;
        Tue, 02 Apr 2024 09:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712076378; x=1712681178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWbyHQKX45rMNdHdGNsZAuo4LbzVfBFJvQO257UCyxQ=;
        b=USZU5DEXjbsrLKVcxdojKUh8Q9t/i3WfYqOPFhVAug9PvElcBtN3d9FAGVdSFp0G8I
         j1UsIhQKbzzO0nIU4f1VpzZvcTrBfs0gudqKV/G33l+MNIHUZvRhRlDIiPbWnQHUFW5t
         wIUUjKpwBUNqqHANt/tEEtIpfRk94pBBjH+NqlmvXzkpucDf72Hr8BHyQc9QgIXX5WSe
         KFZQeEKEdZFPgkPNwd3zJxW7sUcpiq++EgxzT8+A2E86dLFOJ3YxE4yp2DRA5BODIl2T
         XIv5N5CjJB5UiVTdNZEi3JyJiiU8QXJWdRT8Mecxqlc7KgfbGK6KIHUaOcX1Kbo4lQ/w
         1NNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712076378; x=1712681178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWbyHQKX45rMNdHdGNsZAuo4LbzVfBFJvQO257UCyxQ=;
        b=pIR4wXxeJ1A4bBoxpSNAMw++A3HhACvfvh3iqaEgYDcWyRotiwmdLU8vF2BLYkNFI+
         CyYIdPJIK3g8MjLkH3tH+caPbuaAh6e4Ag4PWYUN/lkQcXEsQ7boI6vWCfdmELzSYz1y
         qezGN9nBM79hAFRaDd7kOmohPNuQ7OoJe2DsRgjjgAGdGJGRcnP+kHk1hVo6P3znpX5/
         OriSe845yOyeL7MthasViGoSKHniqQDnJZFEWspxcjlA7Y5Gs8bLiYhGAXB1aMTz4+gI
         YRBmKYnwpxmb3mTuHKkAhe2RBf04TIjuP93EC0vVNqKEVkY4yRqgw21vv19xCoai9ckr
         8ROw==
X-Forwarded-Encrypted: i=1; AJvYcCWbuPG8JjP9JJFpBEq8d9iFIYnSnBH2eUiERRZFQfLlNTkpaX5utRiE4pKkXv4gmPbc6IwRnOtFJqH7Yti4wVsEDkCj1OIPm0ISojPU
X-Gm-Message-State: AOJu0YwWky3euoj89NrAs0Hlf/cCAM/tTrKI1tpfiA/mSnaC6L+t6EET
	noV4GBlgbn7scLOPfv97BmyWIjEINnVtUkOgpoznHcsWqdesnT/BkxGz+bKUIATqwQ==
X-Google-Smtp-Source: AGHT+IExTlJLreZKWUPek+xRioeTkH5Uz/7gBs9Er7Ab1z4+dxFdPw+UkwjFhW1L6XWXUyHSlESygQ==
X-Received: by 2002:a05:6512:752:b0:513:1a9c:ae77 with SMTP id c18-20020a056512075200b005131a9cae77mr7611340lfs.52.1712076377903;
        Tue, 02 Apr 2024 09:46:17 -0700 (PDT)
Received: from localhost ([77.91.78.25])
        by smtp.gmail.com with ESMTPSA id fc3-20020a056512138300b00516a88ea29csm734620lfb.18.2024.04.02.09.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 09:46:17 -0700 (PDT)
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mikhail Rudenko <mike.rudenko@gmail.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: [PATCH v4 06/20] media: i2c: ov4689: Refactor ov4689_set_ctrl
Date: Tue,  2 Apr 2024 19:45:37 +0300
Message-ID: <20240402164552.19171-7-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402164552.19171-1-mike.rudenko@gmail.com>
References: <20240402164552.19171-1-mike.rudenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce local variable for regmap within the ov4689_set_ctrl
function. This adjustment eliminates repetition within the function.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
---
 drivers/media/i2c/ov4689.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 56bf1d964e43..1bc00404f3fb 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -580,10 +580,11 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct ov4689 *ov4689 =
 		container_of(ctrl->handler, struct ov4689, ctrl_handler);
+	struct regmap *regmap = ov4689->regmap;
 	struct device *dev = ov4689->dev;
 	int sensor_gain;
 	s64 max_expo;
-	int ret;
+	int ret = 0;
 
 	/* Propagate change of current control to all related controls */
 	switch (ctrl->id) {
@@ -603,16 +604,15 @@ static int ov4689_set_ctrl(struct v4l2_ctrl *ctrl)
 	switch (ctrl->id) {
 	case V4L2_CID_EXPOSURE:
 		/* 4 least significant bits of exposure are fractional part */
-		ret = cci_write(ov4689->regmap, OV4689_REG_EXPOSURE,
-				ctrl->val << 4, NULL);
+		cci_write(regmap, OV4689_REG_EXPOSURE, ctrl->val << 4, &ret);
 		break;
 	case V4L2_CID_ANALOGUE_GAIN:
 		ret = ov4689_map_gain(ov4689, ctrl->val, &sensor_gain);
-		cci_write(ov4689->regmap, OV4689_REG_GAIN, sensor_gain, &ret);
+		cci_write(regmap, OV4689_REG_GAIN, sensor_gain, &ret);
 		break;
 	case V4L2_CID_VBLANK:
-		ret = cci_write(ov4689->regmap, OV4689_REG_VTS,
-				ctrl->val + ov4689->cur_mode->height, NULL);
+		cci_write(regmap, OV4689_REG_VTS,
+			  ctrl->val + ov4689->cur_mode->height, &ret);
 		break;
 	case V4L2_CID_TEST_PATTERN:
 		ret = ov4689_enable_test_pattern(ov4689, ctrl->val);
-- 
2.44.0


