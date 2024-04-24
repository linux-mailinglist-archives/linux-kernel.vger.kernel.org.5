Return-Path: <linux-kernel+bounces-156265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D308B0070
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4D8A285794
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D489140363;
	Wed, 24 Apr 2024 04:17:34 +0000 (UTC)
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1802.securemx.jp [210.130.202.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5291613AA2B;
	Wed, 24 Apr 2024 04:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713932254; cv=none; b=FDZx3iujNEjhaR2lG1s2E9MLDyJWYmy11OaLPEL0kx7Gpm/I0CiSL4+Bk5H3zkx1JdTKI+Mb9rSppftoxadaTsL9qJSGPQju89wXamHJoB8jctADZVCQPIdJOHQRQNi29bfkTnUtWZzmAsGVEoaZu1gdQC2ZaZ/HM2Cfptq47ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713932254; c=relaxed/simple;
	bh=tmZivAPoRtjSnEGiLMrWJXye+3/kG+MWQ2bcPivPywA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kXGE4ED0b/Pqv76Jv6vhsMbBm5AYoU2kek7THYtit7taRspXQcFnAG7dVqJl3CbBy9XXoTxBcnyi9jeZNH+rwuUBPyEnUVFFtmkObrV3QbNCrge0xK9eW/4AMXLphsdN5Wcea3eVu1YeOGYCdNuMFvB7umQ7yy/f3dmPIKGuynU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; arc=none smtp.client-ip=210.130.202.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1802) id 43O2mFon1222808; Wed, 24 Apr 2024 11:48:15 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 43O2lZUw3514010; Wed, 24 Apr 2024 11:47:35 +0900
X-Iguazu-Qid: 2yAbdMiuYNn0EEa8l0
X-Iguazu-QSIG: v=2; s=0; t=1713926855; q=2yAbdMiuYNn0EEa8l0; m=ryJhWAlzIXynJusIuDL36Fxw7+i1HfiH1CQUOwHDqDY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 43O2lW2s2335784
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 24 Apr 2024 11:47:33 +0900
X-SA-MID: 21956136
From: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To: Hans Verkuil <hverkuil@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 2/6] media: videodev2.h: add visconti viif meta buffer format
Date: Wed, 24 Apr 2024 11:42:11 +0900
X-TSB-HOP2: ON
Message-Id: <20240424024215.1624299-3-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424024215.1624299-1-yuji2.ishikawa@toshiba.co.jp>
References: <20240424024215.1624299-1-yuji2.ishikawa@toshiba.co.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds the Toshiba Visconti VIIF specific metadata format

- V4L2_META_FMT_VISCONTI_VIIF_PARAMS for ISP parameters
- V4L2_META_FMT_VISCONTI_VIIF_STATS for ISP statistics

Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
---
Changelog v10:
- add entry for V4L2_META_FMT_VISCONTI_VIIF_PARAMS
- add entry for V4L2_META_FMT_VISCONTI_VIIF_STATS

 include/uapi/linux/videodev2.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index a8015e5e7f..686657e022 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -839,6 +839,10 @@ struct v4l2_pix_format {
 #define V4L2_META_FMT_RK_ISP1_PARAMS	v4l2_fourcc('R', 'K', '1', 'P') /* Rockchip ISP1 3A Parameters */
 #define V4L2_META_FMT_RK_ISP1_STAT_3A	v4l2_fourcc('R', 'K', '1', 'S') /* Rockchip ISP1 3A Statistics */
 
+/* Vendor specific - used for Visconti VIIF sub-system */
+#define V4L2_META_FMT_VISCONTI_VIIF_PARAMS	v4l2_fourcc('V', 'I', 'F', 'P') /* ISP Params */
+#define V4L2_META_FMT_VISCONTI_VIIF_STATS	v4l2_fourcc('V', 'I', 'F', 'S') /* ISP Stats */
+
 /* priv field value to indicates that subsequent fields are valid. */
 #define V4L2_PIX_FMT_PRIV_MAGIC		0xfeedcafe
 
-- 
2.25.1



