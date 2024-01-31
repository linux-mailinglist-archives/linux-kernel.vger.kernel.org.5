Return-Path: <linux-kernel+bounces-45790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 852F4843644
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3491A1F281F4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE30C3FB3F;
	Wed, 31 Jan 2024 05:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="KK8UGB3I"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D143F8F0;
	Wed, 31 Jan 2024 05:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706680348; cv=none; b=D9J8PaiiwLENOb+PPZoEzSUSV265Xq7/XXFaP7an49eqq+8ivKpYwoQoHP1S/psyDRJ02PWZjyouaXw5nn8+cC49+NvOumzrBH5AWwOYW7E8bAEH7mtAoEjNpueVNHAiDclKs4/Bt2+ckoARiRCGUDgIg9Hy+a01J0XUZYuuu1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706680348; c=relaxed/simple;
	bh=ma7dEcFPhHPYt1lVJga9B1+IwD8cgjTRXMmLiGdj1yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aEeLK0CuOCGt0aXcMNJEtjH90i+vgrSUvQYtERmV1sYVVfyqoK/tH7kc3Zcv0Fdg1hVyPq+D3DYBRmCVmjYHMWBa3zPp1aWMTcC0V1/1bYuwJ8Q99XHtxWYwBrvwF45/VE5asWB/ntjbX/2HhS4mBOWi6kSOSz864z7JI/VWHhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=KK8UGB3I; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.Jain (unknown [103.86.18.206])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E9BD416CF;
	Wed, 31 Jan 2024 06:50:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1706680259;
	bh=ma7dEcFPhHPYt1lVJga9B1+IwD8cgjTRXMmLiGdj1yk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KK8UGB3Irw1MXc6ihmRj8+LXP785j+aMCvxV4oHT+OjOwK4t5uIWhO45N95cFGF3w
	 GylscYeJ2N4vKGklOsTafsVM8ScyB4i21m3ku+po4NLqQ08CWGUpuic4KKBGWKLOU/
	 zozF4Yk20bJThpacHJzc89qR5Zqdd6AKZBB5kDc0=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v2 1/5] media: i2c: imx335: Drop setting of 0x3a00 register
Date: Wed, 31 Jan 2024 11:22:04 +0530
Message-ID: <20240131055208.170934-2-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240131055208.170934-1-umang.jain@ideasonboard.com>
References: <20240131055208.170934-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register 0x3a00 is a reserved field as per the IMX335 datasheet,
hence shouldn't be set by the driver.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/media/i2c/imx335.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index 7a37eb327ff4..927b4806a5d7 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -249,7 +249,6 @@ static const struct imx335_reg mode_2592x1940_regs[] = {
 	{0x3794, 0x7a},
 	{0x3796, 0xa1},
 	{0x37b0, 0x36},
-	{0x3a00, 0x01},
 };
 
 static const struct imx335_reg raw10_framefmt_regs[] = {
-- 
2.41.0


