Return-Path: <linux-kernel+bounces-72694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D5685B773
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EDC12871FB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE0A61663;
	Tue, 20 Feb 2024 09:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="FNHqudLS"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B0D60DC4;
	Tue, 20 Feb 2024 09:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421315; cv=none; b=Gz4wtKurpYQQEkB9Qz9Jd+E+rZIed1LDXK8l1v+G08haYrxdMRxyOtNvr75YZFcIgHurUCigg3nUBs+yWxQb6TFf+yf+BDo/Z5qiM4Jp/q2PoemxB/A1svSUZlMbwM/CR/O5fzwbEPJtllAYZp28XWwKPTRozAD2c2psllAJXc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421315; c=relaxed/simple;
	bh=ojTTiT7sFsKLZQgcQ3xTUQAx0XjIPRDu5NRR820vWbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cycs/Xk0wabHxfkOW5AwMYzYMzEzDsQf1TiOG3Yr4E+00SIww9BvIi8FQn6E7QGlAUQuoVjHeU4hp9aGVLOWiINvhPv1ULgZ9GOo9aokcGNLMUknHXSRKMtlW/pm1nZs8lb7vH+jK4+/mLRUe8If6uVeupN/bNdC++RKtEnfdWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=FNHqudLS; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.86.18.159])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2E3A214AF;
	Tue, 20 Feb 2024 10:28:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1708421304;
	bh=ojTTiT7sFsKLZQgcQ3xTUQAx0XjIPRDu5NRR820vWbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FNHqudLSaF49k70GYlsIMmJOhIlAVqlyMliyANY3PDGKX7BhaKdduZcOtHmydPyKb
	 qmYLH5rfVbtl818UdnBxBZ7TltCU+fCoTZ69/hfG9ZDUA0HRmy807W73iMUSXeIwja
	 VRkwZWIcPBMiY6mvQc/J9Gr9ue0YvXYxm6f7PUHo=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	Matthias Fend <matthias.fend@emfend.at>
Subject: [PATCH v3 1/5] media: imx335: Set reserved register to default value
Date: Tue, 20 Feb 2024 14:58:17 +0530
Message-ID: <20240220092821.1993-2-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220092821.1993-1-umang.jain@ideasonboard.com>
References: <20240220092821.1993-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

0x3a00 is a reserved register as per the datasheet. The driver
currently sets to it 0x01 while the datasheet claims 0x00 to be
the default value.

On one of the setup based on i.MX8MP platform with IMX335, this register
write broke the CSI-2 configuration. Setting 0x3a00 to its default
value (i.e. 0x00) fixed the issue. It is not clear from the datasheet
what this register write is responsible for but setting it to its default
value seems the right thing to do, provided it has been found
responsible to break CSI-2 configuration on one of the platform.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
Reported-by: Matthias Fend <matthias.fend@emfend.at>
---
 drivers/media/i2c/imx335.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index 7a37eb327ff4..3d3848a58fa7 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -249,7 +249,7 @@ static const struct imx335_reg mode_2592x1940_regs[] = {
 	{0x3794, 0x7a},
 	{0x3796, 0xa1},
 	{0x37b0, 0x36},
-	{0x3a00, 0x01},
+	{0x3a00, 0x00},
 };
 
 static const struct imx335_reg raw10_framefmt_regs[] = {
-- 
2.43.0


