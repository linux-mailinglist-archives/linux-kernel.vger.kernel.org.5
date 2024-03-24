Return-Path: <linux-kernel+bounces-113860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E36888EB6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0EEA1C261E6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19862081C2;
	Sun, 24 Mar 2024 23:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNBgvXje"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260F01E9F8E;
	Sun, 24 Mar 2024 22:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320906; cv=none; b=M6cP3tTsNEfpLcgrMd6awEhiugCqy89wXaJLZfgMdKtGqrHXERb36vqzi3qBv0kD01JeFwFfdVYMkI2ph0R/z9X2wm2JDDMNk/kTMM6b6s265P4/8bFpT7X8mzX19I5+LXz9grQeMsmMpcaXWUmHZAO2gmoV0DToOlePdV29RmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320906; c=relaxed/simple;
	bh=bbwcNU7KSNEeMQZqW0jlD/Hx/LZZO+TK6h51Kbym4Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ApyKNGxufmXD4nuWHKKo8SO7mmILA6jYoqT0BNUosQR916Ujqkh1IhJjC3o3TJHvRaS3VLdgpnNMT+vOzNpi1ocHZVgtF45LVyZUjSBvyFKmXLCCMYF7/MM5+05EwF7XQEzlyIWJtGjvZ8j9gcoWCkZARvk4QHMakFpWhK70oz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNBgvXje; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AF9C43394;
	Sun, 24 Mar 2024 22:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320905;
	bh=bbwcNU7KSNEeMQZqW0jlD/Hx/LZZO+TK6h51Kbym4Bs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eNBgvXjeNvUyN9yAhwpBS2kh5M1arASMpcBXJslxmxyZdUsEPUN4K8YWrGN62vQzh
	 k9xA+dKSDR0wX75w4kjUemEawHdAHV96K7/NTXw4eI/eo6pTWZDHbRKxpPmlm2jS+Z
	 JvjTJv3XqU6fsE2gl2XSumkfZmvB0pTti0K6oZqRuz1f2t53XQBEvR7QggdyrNJoRL
	 1GrA0Wp9z6Wz28ABTb/I8vJnfQIg5PwwONPFs8HZA0bjCjH314TVD7i1JKUuB6paFJ
	 M3Dk0xXAw85kO9fiTDntfzdj+BPSAYveSUkb9GlHRRnRouhErzzDAFKmAb/GLLLHUa
	 PPi6uXDmNywew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 468/713] media: sun8i-di: Fix chroma difference threshold
Date: Sun, 24 Mar 2024 18:43:14 -0400
Message-ID: <20240324224720.1345309-469-sashal@kernel.org>
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

From: Jernej Skrabec <jernej.skrabec@gmail.com>

[ Upstream commit 856525e8db272b0ce6d9c6e6c2eeb97892b485a6 ]

While there is no good explanation what this value does, vendor driver
uses value 31 for it. Align driver with it.

Fixes: a4260ea49547 ("media: sun4i: Add H3 deinterlace driver")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/sunxi/sun8i-di/sun8i-di.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c b/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
index f253a40cc04f8..f7ff0937828cf 100644
--- a/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
+++ b/drivers/media/platform/sunxi/sun8i-di/sun8i-di.c
@@ -304,7 +304,7 @@ static void deinterlace_init(struct deinterlace_dev *dev)
 
 	deinterlace_clr_set_bits(dev, DEINTERLACE_CHROMA_DIFF,
 				 DEINTERLACE_CHROMA_DIFF_TH_MSK,
-				 DEINTERLACE_CHROMA_DIFF_TH(5));
+				 DEINTERLACE_CHROMA_DIFF_TH(31));
 }
 
 static inline struct deinterlace_ctx *deinterlace_file2ctx(struct file *file)
-- 
2.43.0


