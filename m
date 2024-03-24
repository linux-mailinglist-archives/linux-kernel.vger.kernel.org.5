Return-Path: <linux-kernel+bounces-113847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6720E8886F2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98F791C25BCC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C194B204FB6;
	Sun, 24 Mar 2024 23:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gsb7WeiX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F021E8E22;
	Sun, 24 Mar 2024 22:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320886; cv=none; b=RT40KF++pMQ4gsIG/zHbpSpKNCmTEojAjfzuXiv8xXCKugqaBJswCzWkruIsv+Wczbg6mngoVAz4QxZEqkUyoVIWWMlq5KPT+vhn0S4YuUhktV4V+hfRLRHxc8d9rh32SIxcZ/9k2gUZ+TKnJxa7BgaUBWqFiUjv94FjAUiY9uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320886; c=relaxed/simple;
	bh=V+exzm1680Qq3G/AZ3EOjqsgmTXfXHcSj3o1Kk9ZpvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mw53K4GUrnwsDWX2Gx/wb4KdwSUEuqJYaCvS/z+cNIGh6mI8T63AdRjI61FqFU095p4E3ePAvFn2K5fR9d/V3SZQ4ZsG3BUC0jbcDG6zhc6PKQFdlq5q8K9fJfM48mcZkq3NQCQVbpaaIg4ooc+9Aa+Sg0WY7JOD2bkTaThBw8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gsb7WeiX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59B7C433C7;
	Sun, 24 Mar 2024 22:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320885;
	bh=V+exzm1680Qq3G/AZ3EOjqsgmTXfXHcSj3o1Kk9ZpvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gsb7WeiX0JGmi/iNPmUeoc7d9lWP/gdxFyN3j2xECKugdqZStcpcJBWby4UIkPXl1
	 0dmqM7vho8wbK1JkGVwyclqctBbBMziyTlSX4+ve5eWqjtDTikHQXOSaPOT9+jYGpe
	 2oWo8u/EUC2mIq67f1w+pMFKehI+SVDRP7eU6cIiURkTD5ZFCw/A/aFTmv/bff2oEN
	 SlZ4FifBZ/45aXLrCA/Us9FU59IOdiFPzQfvV7l2Wnsmu4NG3Y0OOJk0bpqSxKg7k6
	 8l7N493Hr6U2qbCczcUF9DLjz/mYCKYUBRS2EiC5hhbi/o5yVgLKiBNk+eB4m7rw2Y
	 PPEV8kG4RNQ6g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 449/713] drm/msm/dpu: Only enable DSC_MODE_MULTIPLEX if dsc_merge is enabled
Date: Sun, 24 Mar 2024 18:42:55 -0400
Message-ID: <20240324224720.1345309-450-sashal@kernel.org>
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

From: Marijn Suijten <marijn.suijten@somainline.org>

[ Upstream commit 06267d22f9ee6fd34150b6dcdb2fa6983e1a85bc ]

When the topology calls for two interfaces on the current fixed topology
of 2 DSC blocks, or uses 1 DSC block for a single interface (e.g. SC7280
with only one DSC block), there should be no merging of DSC output.

This is already represented by the return value of
dpu_encoder_use_dsc_merge(), but not yet used to correctly configure
this flag.

Fixes: 58dca9810749 ("drm/msm/disp/dpu1: Add support for DSC in encoder")
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/577067/
Link: https://lore.kernel.org/r/20240204-dpu-dsc-multiplex-v1-1-080963233c52@somainline.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 86bfc109b2fae..b26d23b2ab6af 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1867,7 +1867,9 @@ static void dpu_encoder_prep_dsc(struct dpu_encoder_virt *dpu_enc,
 	dsc_common_mode = 0;
 	pic_width = dsc->pic_width;
 
-	dsc_common_mode = DSC_MODE_MULTIPLEX | DSC_MODE_SPLIT_PANEL;
+	dsc_common_mode = DSC_MODE_SPLIT_PANEL;
+	if (dpu_encoder_use_dsc_merge(enc_master->parent))
+		dsc_common_mode |= DSC_MODE_MULTIPLEX;
 	if (enc_master->intf_mode == INTF_MODE_VIDEO)
 		dsc_common_mode |= DSC_MODE_VIDEO;
 
-- 
2.43.0


