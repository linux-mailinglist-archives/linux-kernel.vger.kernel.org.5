Return-Path: <linux-kernel+bounces-68389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EDE857994
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BA85B25041
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C021E219F6;
	Fri, 16 Feb 2024 09:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="KxMnnzdZ"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A77A2110E;
	Fri, 16 Feb 2024 09:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077350; cv=none; b=DmEnbytb8AcEIPRikM4hbcjcWcSMIY9U7QDF967cWBEBpIll1uVuxHnIS094Nzp2SfY2lOvMpd8EDlozRb5g2wc9ooF4mHYFvdUBBSPLp2I+4tJ/4RR2bWeYl8QM3SmSVJSiTEhdcN0VH/ZKDwwt2Gt+dwwVkCyusHaUzRDiPTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077350; c=relaxed/simple;
	bh=Ck/+exqg1EcWWvcqDsaDHQJ5Wz7v5d1Bcq/AocX7McM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rrbZELlTT71uz1aKgNUxoDbF9SreSKgmDiMmalbe+1muaOnziKOqPguubaL6sBvoGj84cU5ud0bqCtDQZc4cm3uro/NVvlxPmAOXrjZKnWoHbyp1A875nemUgA1g/CpkK7ajmX/Hi4iHB6dLt/9d9IE1WLjCHEYWrIWp+FLhXrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=KxMnnzdZ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pyrite.hamster-moth.ts.net (h175-177-049-156.catv02.itscom.jp [175.177.49.156])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B6973D4A;
	Fri, 16 Feb 2024 10:55:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1708077343;
	bh=Ck/+exqg1EcWWvcqDsaDHQJ5Wz7v5d1Bcq/AocX7McM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KxMnnzdZCFB7zbcpbYQXjh6IH5fiMOXLTu7Ya62pT9LbG0lR0o2uDBN86/CjgVQ5V
	 cEO/RZsQscHKFe0cjQqtXUFrAwC+xwRH3hwcJbME4drGbrhOkIoRcWXJHrgv66Zkgl
	 pE0BeByhKjFIfJMcN2z0BTrcr9qtvc86i9YZyiFY=
From: Paul Elder <paul.elder@ideasonboard.com>
To: linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: kieran.bingham@ideasonboard.com,
	tomi.valkeinen@ideasonboard.com,
	umang.jain@ideasonboard.com,
	aford173@gmail.com,
	Paul Elder <paul.elder@ideasonboard.com>,
	Dafna Hirschfeld <dafna@fastmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v12 06/12] media: rkisp1: Add version enum for i.MX8MP ISP
Date: Fri, 16 Feb 2024 18:54:52 +0900
Message-Id: <20240216095458.2919694-7-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240216095458.2919694-1-paul.elder@ideasonboard.com>
References: <20240216095458.2919694-1-paul.elder@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add to the version enum an entry for the i.MX8MP ISP.

Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
---
New in v12:
- split out from "media: rkisp1: Add match data for i.MX8MP ISP"
- changed the version enum name
---
 include/uapi/linux/rkisp1-config.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/rkisp1-config.h b/include/uapi/linux/rkisp1-config.h
index 730673ecc63d..2d1c448a6ab8 100644
--- a/include/uapi/linux/rkisp1-config.h
+++ b/include/uapi/linux/rkisp1-config.h
@@ -179,12 +179,14 @@
  * @RKISP1_V11: declared in the original vendor code, but not used
  * @RKISP1_V12: used at least in rk3326 and px30
  * @RKISP1_V13: used at least in rk1808
+ * @RKISP1_V_IMX8MP: used in at least imx8mp
  */
 enum rkisp1_cif_isp_version {
 	RKISP1_V10 = 10,
 	RKISP1_V11,
 	RKISP1_V12,
 	RKISP1_V13,
+	RKISP1_V_IMX8MP,
 };
 
 enum rkisp1_cif_isp_histogram_mode {
-- 
2.39.2


