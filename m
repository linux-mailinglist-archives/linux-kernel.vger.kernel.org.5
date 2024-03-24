Return-Path: <linux-kernel+bounces-114276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C9B88916B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFA53B33531
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7E015D5CC;
	Sun, 24 Mar 2024 23:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/DgLJio"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13561EBD24;
	Sun, 24 Mar 2024 23:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321648; cv=none; b=qkyju48pSb9c6i0sXthRAme36wNVQXm6m91jtN6AzXBqBCLX9DAA3F+6voFjyZScT00CKrxA59xDWMOHHfo//0DNUCVmUy8ZwiOlYZKFu9ije6hj0vWauKs2hwx4CVYDlMCgNxQqqxV1rUp+ZvxyBy5UdUYXOC5p3QB7exIs6Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321648; c=relaxed/simple;
	bh=i6qbJ0YigLE3yuZNNmqK6Rf7CvUlWxagcLz5SoaV904=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AXUEQeQ1CrUSwmA70EPGESIK//gM2u6CQwhTUObCWWS/NU227Tm72JNp7lX03kiksG8qqT3bmI1PKLTvOtTPz7r+H0ONK9wMTs+mLqhKK0YeH4UcGs1bGsMW4qTpV078qqfpMWtSY9SVOe3TdtRM2ewDTbfTmw8+Bz5sPi1mplA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/DgLJio; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C270C433C7;
	Sun, 24 Mar 2024 23:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321646;
	bh=i6qbJ0YigLE3yuZNNmqK6Rf7CvUlWxagcLz5SoaV904=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W/DgLJiooIa9qG0qSUzXfIyYeOBLiAfMTSU8P+Ex/mRpGHcXiD+2aMsGySNmZB7B3
	 gRK6iS1iOPQDIo+/2gdIwJahv6cSiYXt/gJbTsfvtU8tYfS2fdwNFGm2XEco0rJwEx
	 MGzLUiVqsbf6uH2kfqJEWpCi9gkJGktwBueU/jP2cxf5jsDYqmK83HMtXYTBDA75YL
	 lI+cHsiCVeR2KLgf3zR0VWUBQ0bZXi00PDuIE4vnA574KZQDwK588qEad8m3lThcH+
	 IIDP2xi9Gq3ifa9oIkvHlyxuHAyC8/BaoYFLVkDrTdY9OcZfsEnWHzT1LEidpsLBv5
	 OOmyWyV4d5hwg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Julien Massot <julien.massot@collabora.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 376/638] media: v4l2: cci: print leading 0 on error
Date: Sun, 24 Mar 2024 18:56:53 -0400
Message-ID: <20240324230116.1348576-377-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Julien Massot <julien.massot@collabora.com>

[ Upstream commit 58ab1f9e140006e9e5686640f1773260038fe889 ]

In some error cases leading '0' for register address
were missing.

Fixes: 613cbb91e9ce ("media: Add MIPI CCI register access helper functions")
Signed-off-by: Julien Massot <julien.massot@collabora.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/v4l2-core/v4l2-cci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-cci.c b/drivers/media/v4l2-core/v4l2-cci.c
index 10005c80f43b5..ee3475bed37fa 100644
--- a/drivers/media/v4l2-core/v4l2-cci.c
+++ b/drivers/media/v4l2-core/v4l2-cci.c
@@ -32,7 +32,7 @@ int cci_read(struct regmap *map, u32 reg, u64 *val, int *err)
 
 	ret = regmap_bulk_read(map, reg, buf, len);
 	if (ret) {
-		dev_err(regmap_get_device(map), "Error reading reg 0x%4x: %d\n",
+		dev_err(regmap_get_device(map), "Error reading reg 0x%04x: %d\n",
 			reg, ret);
 		goto out;
 	}
@@ -131,7 +131,7 @@ int cci_write(struct regmap *map, u32 reg, u64 val, int *err)
 
 	ret = regmap_bulk_write(map, reg, buf, len);
 	if (ret)
-		dev_err(regmap_get_device(map), "Error writing reg 0x%4x: %d\n",
+		dev_err(regmap_get_device(map), "Error writing reg 0x%04x: %d\n",
 			reg, ret);
 
 out:
-- 
2.43.0


