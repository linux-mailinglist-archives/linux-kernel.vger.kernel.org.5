Return-Path: <linux-kernel+bounces-114314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C468889BD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C36EB1F29D01
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62E726424D;
	Sun, 24 Mar 2024 23:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDg0rxOV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E73153591;
	Sun, 24 Mar 2024 23:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321693; cv=none; b=KocyYI6ZG1ASkOw9lRwbhJwjicr8UuAyAMTmbnr4kp1CYzfdlQG7+SYLNBBELdLPABB2GBHNz0vsT1T0GlGOjnqWSuzqcg1SZLcUBVai832ooQPk0Amr5pDylHmyRMeC/XIFoH2J3aOBJwPO4U8232EXIelp7hrZs8qPC9O/8rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321693; c=relaxed/simple;
	bh=bbwcNU7KSNEeMQZqW0jlD/Hx/LZZO+TK6h51Kbym4Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yyi5hb5N4tvyQhzUC57lo2DQoLuO77Yu76Vwz1FSOtVQsFnE6c9mJAhNDbf/pZ1XzP0Dz0SHnnqNxgkOBLtMQsEvwzwMV0RAV+ixNS/8+JwahTo0twJLKWRRhHqw6SK/L+c/MhnT0Xas+i2A5Mq8PAhpHQo0hMUdywLLw1KcHXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDg0rxOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C29C433C7;
	Sun, 24 Mar 2024 23:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321691;
	bh=bbwcNU7KSNEeMQZqW0jlD/Hx/LZZO+TK6h51Kbym4Bs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QDg0rxOVKrlXizKgH3cC3lqq+h0YVyiUEhpQaQcmizOAe+Ruk/C+zoV+0fvCKyW87
	 QDoqpv3FPA4P0/WsbwWj0LqOSO3B0XAtqyGnzeN2XaJfc5VYwy+tIq4ot4iGdcZnRF
	 iO+g6MZoyv7x9829cGdhf6d2nGAr23ozFY4D7bypRFKqTerP9DfEB1H/Imnhzn1eHJ
	 jI+4RX+KJXTpQ0WP/qivQEOgYO53KtWxJTvF4EjpPZky2AE5AEUsHEj8xend/m/+o5
	 u0tILTOy70X4z8fj0hML/uzkSd7mB6VR79PC9kp0yCfXUDG7IDQcRydLFtBzWSOopY
	 VKDXCfi8x6Z9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 420/638] media: sun8i-di: Fix chroma difference threshold
Date: Sun, 24 Mar 2024 18:57:37 -0400
Message-ID: <20240324230116.1348576-421-sashal@kernel.org>
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


