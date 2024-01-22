Return-Path: <linux-kernel+bounces-33336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AE6836885
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB8E287396
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D3846535;
	Mon, 22 Jan 2024 15:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGflirC4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1A2482D9;
	Mon, 22 Jan 2024 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935920; cv=none; b=Y9QxntV8uMknsWw2UkteynMMhmNkSt1WJihKN39O1MgmErDT9zhhotMIzFHvFvRmKBe46cB1JnERj45Mpbjbl0g5vNsD8wbAUtGos7q0Ydl3OHCywzTc2baPN/H+K4iyKg4vOxLJ8HayV3HcRAT2yt7zLZD+AXF0RIrmtgOPMjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935920; c=relaxed/simple;
	bh=h9ciZHRUeJ+ceoD40XRUcI/LtNH3l9lBF6kcy1GpEIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YsAv90l9prqGqPEyY1n+ZSQd80VGfBVjPBRq/BdVhGLHdvXcQuuw6SzXPb/CcKD8GRi7ihWzdNFFX7e/dsWZVzABmj0eQN5GDfXqDcXhP8LE8BKdwOgPX0B2GZjhtUo7TJWjrBXNiZsaViDT+EHZ6kaocMIF0/qhJBc2PsYdft8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGflirC4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607D6C433B2;
	Mon, 22 Jan 2024 15:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935919;
	bh=h9ciZHRUeJ+ceoD40XRUcI/LtNH3l9lBF6kcy1GpEIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rGflirC4Z5pzgzbAphG8yPdXTxbpTZP/qn5kl+avR0UDTcuRcSF59dMvvS2VReh5o
	 ZxQ34hva4pY1CDrBMEKY+LraU3QGKk5BI7WupB0TmDOd7dAazYxoNbQY94UfPmUpeF
	 qOXS5G02S+7CZYO63Rxb7bw8GzL934ZkhamxNnZhJm9CGwwYiF+uo5DdBlvI+9g6O2
	 mDDQHGLEeYSKJiCOClaDpkahCGI6Qv0bBw/nQRz3U0OJOWwku2+0SlE2EOHWLtO+Wl
	 DJSXC8lueTliRYFqLDscOxSG0AqVLDUkFSJ51eDCTOOrcQC9FbfcjBeMxikrgoH1jv
	 IPzdbG/CbmUkg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ilya Bakoulin <ilya.bakoulin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Wenjing Liu <wenjing.liu@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Qingqing.Zhuo@amd.com,
	jun.lei@amd.com,
	hamza.mahfooz@amd.com,
	Jingwen.Zhu@amd.com,
	peichen.huang@amd.com,
	camille.cho@amd.com,
	wayne.lin@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 15/73] drm/amd/display: Fix MST PBN/X.Y value calculations
Date: Mon, 22 Jan 2024 10:01:29 -0500
Message-ID: <20240122150432.992458-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
Content-Transfer-Encoding: 8bit

From: Ilya Bakoulin <ilya.bakoulin@amd.com>

[ Upstream commit 94bbf802efd0a8f13147d6664af6e653637340a8 ]

Changing PBN calculation to be more in line with spec. We don't need to
inflate PBN_NATIVE value by the 1.006 margin, since that is already
taken care of in the get_pbn_per_slot function.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 35d087cf1980..c5f8ce6e30f3 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -1055,18 +1055,21 @@ static struct fixed31_32 get_pbn_from_bw_in_kbps(uint64_t kbps)
 	uint32_t denominator = 1;
 
 	/*
-	 * margin 5300ppm + 300ppm ~ 0.6% as per spec, factor is 1.006
+	 * The 1.006 factor (margin 5300ppm + 300ppm ~ 0.6% as per spec) is not
+	 * required when determining PBN/time slot utilization on the link between
+	 * us and the branch, since that overhead is already accounted for in
+	 * the get_pbn_per_slot function.
+	 *
 	 * The unit of 54/64Mbytes/sec is an arbitrary unit chosen based on
 	 * common multiplier to render an integer PBN for all link rate/lane
 	 * counts combinations
 	 * calculate
-	 * peak_kbps *= (1006/1000)
 	 * peak_kbps *= (64/54)
-	 * peak_kbps *= 8    convert to bytes
+	 * peak_kbps /= (8 * 1000) convert to bytes
 	 */
 
-	numerator = 64 * PEAK_FACTOR_X1000;
-	denominator = 54 * 8 * 1000 * 1000;
+	numerator = 64;
+	denominator = 54 * 8 * 1000;
 	kbps *= numerator;
 	peak_kbps = dc_fixpt_from_fraction(kbps, denominator);
 
-- 
2.43.0


