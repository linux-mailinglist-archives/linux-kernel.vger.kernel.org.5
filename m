Return-Path: <linux-kernel+bounces-139096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B1B89FE76
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08F2B1C230FC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D6817F36F;
	Wed, 10 Apr 2024 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dI4+G5Cb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A1217BB3D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712770009; cv=none; b=M/EdFTCXL4DjaU3atpzfqufBa3HVuHfCyDyPQfIj66FtRNnJxxB+FO/YQ8nyPoSNi21I+fQC7gDgNIXoewI0T6uAFg9iMYo96XdEF2TLdZduUit6MhkblJHLZOij/9cHEpKppplqc7Bf2V/JlqU6V+gkyquFcIzS3EM17NsWRAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712770009; c=relaxed/simple;
	bh=r04eHSYv2SWZsHc1lZDgJPbGcXw9A/LFXCeLzTLjbZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ssMu1F2hr4yHCHxz2P8NQoSuOkfRm4RwnnlZ79kMaBDwDG4Fjh8XY9K2xsgV1f3eNs1EaEAPFOS2AjJQwGGguVAdB9fKM8lQXWJjqK/J1YySZ2go+83bf/qdopmLeIVhcC7MaGNVP7oNaK1UrfvgCTelthanLPapY4d6Vo6lTeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dI4+G5Cb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72FFC43390;
	Wed, 10 Apr 2024 17:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712770008;
	bh=r04eHSYv2SWZsHc1lZDgJPbGcXw9A/LFXCeLzTLjbZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dI4+G5CbKfBwQxnmV4SYym9uuaKo6qpEvyVqA8fTgMsrPVCzmCgTPtF6jlglN81V+
	 3KO5ji2+UwbxhjaWxEmD5d+ojywCl7q1UfyF/KeXqrHl935vgu5yRJBPErYd2liK11
	 k+uPgOQkB975zLI3wFFe1Xgwp0jYgB1UUEfcVTtt8UHIzeYrKZBfR3GLHCMEokgFyC
	 CIhJMmJdDSF5aEVjk8Pcdh2nq+zWvt2EeXs5BhUPRS7FRiQDgGfm8f//1dL8CNrVx7
	 Mn+pggmN257W4llNnMIZ8F303k4oWZMnZF+JV+uiApvPrdDpDVYQ7nKRCca5SkRqYm
	 dXJEZUSyTa0eQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/2] nvmem: sprd: fix module autoloading
Date: Wed, 10 Apr 2024 19:26:34 +0200
Message-Id: <20240410172634.255480-2-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410172634.255480-1-krzk@kernel.org>
References: <20240410172634.255480-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/nvmem/sprd-efuse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
index bb3105f3291f..1a7e4e5d8b86 100644
--- a/drivers/nvmem/sprd-efuse.c
+++ b/drivers/nvmem/sprd-efuse.c
@@ -426,6 +426,7 @@ static const struct of_device_id sprd_efuse_of_match[] = {
 	{ .compatible = "sprd,ums312-efuse", .data = &ums312_data },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, sprd_efuse_of_match);
 
 static struct platform_driver sprd_efuse_driver = {
 	.probe = sprd_efuse_probe,
-- 
2.34.1


