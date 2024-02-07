Return-Path: <linux-kernel+bounces-56073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B7A84C5A1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 768C51C24230
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D3F200AB;
	Wed,  7 Feb 2024 07:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtZEUOh0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFA21F953
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 07:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707290905; cv=none; b=ITK3nmmicoPBL86jVBP+ZUOZ+v/xdklDsNCSrISWk3j21Yw8XzKIaJopxIQd01TAg1yp+cl6ls6ZOARg/0a4Y14UVYuutyx59byHcgR8wukc/VnHb+HEnKxri3+3Mv+70T9PZCoPOyQOfWqYc9gf9iEnqLKJ3RodZF0brxmlXMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707290905; c=relaxed/simple;
	bh=BaBHHsLR+o2kRrQL4hy2Xypz7kcRhGFamMXsbhKvWuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmW5w3TxQbrEvLZGtIIDWd5E3+7QsWvEnjMc0ahJWHfQl2COW7LTI+FKxSoJBGEkYNuqKABdHEqbwQOvlijJPONa5v6WPp26sYf8UVtK4jKP5pMwnGcPv1XRgNWYTueVGVKrqFGQWEDcraAJA01YY93U+Ii6D/NYgC7de9qdrW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtZEUOh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C81C433F1;
	Wed,  7 Feb 2024 07:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707290905;
	bh=BaBHHsLR+o2kRrQL4hy2Xypz7kcRhGFamMXsbhKvWuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JtZEUOh0zRyxwwk34XIHx6A3v4f86vUzDdohVwqDarRmZ/nvXulBxuTQvTLAZ1vaG
	 VjAHHJ6Cokwkisng7pRIgUVIwIVE8H+8mcUrdOSAe6MQtzwbhHEo2cqMEmZ/Ji5Nlp
	 yyCsglY+/e1OChNvvsDKK2/1PBXOncxfW1FuMd7uFgqgQ4/UimYP9qNAVXko+j4g0p
	 MwPK1ySscNrlm0BKysPlOnOcJ9j7doblgAsrYoUNu1XBM90JFTW9Q9jXx6QakIqUMU
	 yB0bfZwmt/vRgktKMNCBwr3sHV02XK6Fa4UU2gPZ5Pav2MvtIY4SEvQyVHxYDgMSwH
	 RkDBRtPh2GgGg==
From: Saeed Mahameed <saeed@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Aron Silverton <aron.silverton@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	andrew.gospodarek@broadcom.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/5] mlx5: Add aux dev for ctl interface
Date: Tue,  6 Feb 2024 23:24:31 -0800
Message-ID: <20240207072435.14182-2-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207072435.14182-1-saeed@kernel.org>
References: <20240207072435.14182-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Allow ctl protocol interface auxiliary driver in mlx5.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/dev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
index cf0477f53dc4..753c11f7050d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
@@ -228,8 +228,14 @@ enum {
 	MLX5_INTERFACE_PROTOCOL_VNET,
 
 	MLX5_INTERFACE_PROTOCOL_DPLL,
+	MLX5_INTERFACE_PROTOCOL_CTL,
 };
 
+static bool is_ctl_supported(struct mlx5_core_dev *dev)
+{
+	return MLX5_CAP_GEN(dev, uctx_cap);
+}
+
 static const struct mlx5_adev_device {
 	const char *suffix;
 	bool (*is_supported)(struct mlx5_core_dev *dev);
@@ -252,6 +258,8 @@ static const struct mlx5_adev_device {
 					   .is_supported = &is_mp_supported },
 	[MLX5_INTERFACE_PROTOCOL_DPLL] = { .suffix = "dpll",
 					   .is_supported = &is_dpll_supported },
+	[MLX5_INTERFACE_PROTOCOL_CTL] = { .suffix = "ctl",
+					  .is_supported = &is_ctl_supported },
 };
 
 int mlx5_adev_idx_alloc(void)
-- 
2.43.0


