Return-Path: <linux-kernel+bounces-113354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDCA8883A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20CC1281EF5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BF419AC0A;
	Sun, 24 Mar 2024 22:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUdMZDtm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8E419ABF1;
	Sun, 24 Mar 2024 22:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320154; cv=none; b=Zrmqz2Ewbc0lnKJpzcNVZaDtKfuQWEIMDl+gENEVC++ymUTlmh0lDsuIE6MpXG5H1NDjSmb/FCxNzVMPttjfF+LL8wAiMyXIEGi+fE8PJHa4PqTTpPB4E+0YiYiX+e4sz+BWs2vkNA2bP+YOTcRl6z28JD5rbSVA06sTJVGZIDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320154; c=relaxed/simple;
	bh=IHQKUG65SlounuAeFf6b0YURdCZEgBFW9Po4H7Hhhfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FWSlO5ktMNA2LM2ZoYhD+rdCHMpoGrQLBOM3NCQ5CKI6TFqT+GH5u6VUkQA3eyRFJ8IeJBmTcr6PnARNcxt+otqg7g39pnMgZr2g66XcX4ZifKpv2CFD2ZFVSPO7jTrO8tKuOtlQvnJTEQRJceJO9aG06iZnuLCgVw0x3nYHBNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUdMZDtm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CBEC433A6;
	Sun, 24 Mar 2024 22:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320154;
	bh=IHQKUG65SlounuAeFf6b0YURdCZEgBFW9Po4H7Hhhfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LUdMZDtmAQPH4qmrmax9kJXMnDBJOs2dBVstZY35OMHQox9RjX2Or+QlfT8sbzWuy
	 tVXUhG23y74LEZDDIF8DA2S5giygtWkrk/84i0tTB8m2wOf5mMlfCl5sDjNVJtL/jm
	 8/mAQJmBmxGAl8By9HxAUSKU/Sl194wmNkTUFk035CFzPUfo6jketY1RK6pttttLeM
	 gHcta4azdCnjBamRZLACrHbKMl8Ql8ZvxTkPpB7u+TN3fLjBy7SlFFOA/55HO4d+Zq
	 sEuSQ1rxkHT12BVLeGRSrthu6hSKBeUhR62u+SZGD/OWuKpEE03BwQ8oA5lV4H/zpL
	 hS4j+AnOBh6Rg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Griffin <peter.griffin@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 463/715] mfd: altera-sysmgr: Call of_node_put() only when of_parse_phandle() takes a ref
Date: Sun, 24 Mar 2024 18:30:42 -0400
Message-ID: <20240324223455.1342824-464-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Peter Griffin <peter.griffin@linaro.org>

[ Upstream commit e28c28a34ee9fa2ea671a20e5e7064e6220d55e7 ]

of_parse_phandle() returns a device_node with refcount incremented, which
the callee needs to call of_node_put() on when done. We should only call
of_node_put() when the property argument is provided though as otherwise
nothing has taken a reference on the node.

Fixes: f36e789a1f8d ("mfd: altera-sysmgr: Add SOCFPGA System Manager")
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Link: https://lore.kernel.org/r/20240220115012.471689-4-peter.griffin@linaro.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/altera-sysmgr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/altera-sysmgr.c b/drivers/mfd/altera-sysmgr.c
index 0e52bd2ebd74b..fb5f988e61f37 100644
--- a/drivers/mfd/altera-sysmgr.c
+++ b/drivers/mfd/altera-sysmgr.c
@@ -109,7 +109,9 @@ struct regmap *altr_sysmgr_regmap_lookup_by_phandle(struct device_node *np,
 
 	dev = driver_find_device_by_of_node(&altr_sysmgr_driver.driver,
 					    (void *)sysmgr_np);
-	of_node_put(sysmgr_np);
+	if (property)
+		of_node_put(sysmgr_np);
+
 	if (!dev)
 		return ERR_PTR(-EPROBE_DEFER);
 
-- 
2.43.0


