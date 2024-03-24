Return-Path: <linux-kernel+bounces-113823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C76678886CE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67B2BB215A6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDF7200133;
	Sun, 24 Mar 2024 23:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kp3/y+vi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CA21E6F63;
	Sun, 24 Mar 2024 22:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320860; cv=none; b=E9X4XT8Ih25m1vST10XaMPtg9Nhc7Y9S7cUQcmyYzL426I77rN82auvORnrnht6bbnViwq8sqvsZSMW36zjsCEAGBLyjJDRu1nM8f2OmLJwfEiv/P0W033R/MOpsSJlwfO2dOYjjJ5jvnLC+9QDgkixdigxRti057iZ29vnQBdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320860; c=relaxed/simple;
	bh=i6qbJ0YigLE3yuZNNmqK6Rf7CvUlWxagcLz5SoaV904=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKoFhu6V79oZnKkzmawiA8u5VUQw9qdvJ8okaM80osXiQLDwy8CHFdTP3HaSHoGj9aDR1rQDNMA20d/e+0Nh72MjN37AH1EJoS0fSb2NBiBh04f8/A/UwPNyzpyLQG7Urs8DkTC12H+eWX1JdFQM+TmE1cVE0eAYfXNfY0OQMZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kp3/y+vi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F1EC433C7;
	Sun, 24 Mar 2024 22:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320859;
	bh=i6qbJ0YigLE3yuZNNmqK6Rf7CvUlWxagcLz5SoaV904=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kp3/y+viON++vhJ5pyj6xUu/81TrwiduBEBIr4ED8nMuXi2Sz0NVB6eRupWRP6jrv
	 kY6Xb54H+TSX40jy8a9Yn9JvpUU5u899dDEssvf0IfFXMM8iVvynQ5iCYGCys9jmNq
	 s2T54/0Tnn2cfhBCrd3LFZWlDfiAUcrNf7qR6MtRKSWTV0iHx8I+EPCeJxPEFIR5b2
	 IzCdo4PA5fRuvU9byy/1P43OcKv5r5KSon+2j5oEBQQCgg0ijj1yne08GRkfn9ivIj
	 e3HpXt8MVSqULnMYnOJGz9wqfPuXJKjatW9+z9G8AR3haknMRiIA1+L+C62YAiiFlt
	 3lEetsEhbDWNA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Julien Massot <julien.massot@collabora.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 423/713] media: v4l2: cci: print leading 0 on error
Date: Sun, 24 Mar 2024 18:42:29 -0400
Message-ID: <20240324224720.1345309-424-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


