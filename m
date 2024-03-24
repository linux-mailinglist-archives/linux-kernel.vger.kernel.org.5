Return-Path: <linux-kernel+bounces-114688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC09888BC0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD4FD295C65
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FE918C78A;
	Sun, 24 Mar 2024 23:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaaRzLnz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDF32398B2;
	Sun, 24 Mar 2024 23:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322337; cv=none; b=UFa4nsr5hoV/nyLvZTqX61bOKqk9fkf6I6pwO7BTe7XNqzP1FXamUq6Ln/embCHfP6WtrzO3GpgUPGjyQozcAqinZ244VhX12n1R3jJZnVBRMyg+xlhgoCPG/rDJ3S4UcnmqqUEJDllF6ZTb2RLqEqYV3G9Z2LS8jLlEgfKjV9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322337; c=relaxed/simple;
	bh=qm8TX9xSC2TJi9KWAjxttvDXX1Sa2xyg/GY5N8v5aMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6gZPCnD8opB0ODZVznjv+/BcpHKPKu8tNHbtB33paWSPzMf/67Y8aj9lVOn2s2JPL9H7IYMa5zoRijyIlpE25uPvcBo+QqffgvhCv4OIQ5w/Keq8Y2FpKiwJZwQmwfmJHwDHwH2O2k630nP+PyqzqZwoecfJeJpysvIJLYxNkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaaRzLnz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257A1C433B1;
	Sun, 24 Mar 2024 23:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322336;
	bh=qm8TX9xSC2TJi9KWAjxttvDXX1Sa2xyg/GY5N8v5aMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AaaRzLnzk3S+1pA/UUEtD/ytWoi2gowOdZUQYqknSV4YxYWSuuUF1wjOcu5ai3e1L
	 PSI/n6yXcmhAN6Ca2Rky0u1j6JYYxG+jL/QqYHIJVwIghf1D418FnXqigP3SHj3L3b
	 AEujHjqc1jaQmfRjPLkW3pCsstMDQQJIMlIwK0CtV82r6AFPrrwV2lQDKH7HjpXbw/
	 eZ344PtpD1+2QebXPjD36fUGSDlRPDvcg33cXNLH1d7b8lvrlFJ3isP49La3jRv5Fr
	 6CcYgCI5jTxPYwZyEG40ImIZrQw6K80eJbsTYTQ7o7Ycpn7f3LJCBNExFdMoLV8M5w
	 qZLEtdqnxeFZg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arthur Grillo <arthurgrillo@riseup.net>,
	Pekka Paalanen <pekka.paalanen@collabora.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Melissa Wen <mwen@igalia.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 418/451] drm: Fix drm_fixp2int_round() making it add 0.5
Date: Sun, 24 Mar 2024 19:11:34 -0400
Message-ID: <20240324231207.1351418-419-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Arthur Grillo <arthurgrillo@riseup.net>

[ Upstream commit 807f96abdf14c80f534c78f2d854c2590963345c ]

As well noted by Pekka[1], the rounding of drm_fixp2int_round is wrong.
To round a number, you need to add 0.5 to the number and floor that,
drm_fixp2int_round() is adding 0.0000076. Make it add 0.5.

[1]: https://lore.kernel.org/all/20240301135327.22efe0dd.pekka.paalanen@collabora.com/

Fixes: 8b25320887d7 ("drm: Add fixed-point helper to get rounded integer values")
Suggested-by: Pekka Paalanen <pekka.paalanen@collabora.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Melissa Wen <mwen@igalia.com>
Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240316-drm_fixed-v2-1-c1bc2665b5ed@riseup.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/drm/drm_fixed.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/drm/drm_fixed.h b/include/drm/drm_fixed.h
index 6230088428cdb..a476a406e5997 100644
--- a/include/drm/drm_fixed.h
+++ b/include/drm/drm_fixed.h
@@ -70,7 +70,6 @@ static inline u32 dfixed_div(fixed20_12 A, fixed20_12 B)
 }
 
 #define DRM_FIXED_POINT		32
-#define DRM_FIXED_POINT_HALF	16
 #define DRM_FIXED_ONE		(1ULL << DRM_FIXED_POINT)
 #define DRM_FIXED_DECIMAL_MASK	(DRM_FIXED_ONE - 1)
 #define DRM_FIXED_DIGITS_MASK	(~DRM_FIXED_DECIMAL_MASK)
@@ -89,7 +88,7 @@ static inline int drm_fixp2int(s64 a)
 
 static inline int drm_fixp2int_round(s64 a)
 {
-	return drm_fixp2int(a + (1 << (DRM_FIXED_POINT_HALF - 1)));
+	return drm_fixp2int(a + DRM_FIXED_ONE / 2);
 }
 
 static inline int drm_fixp2int_ceil(s64 a)
-- 
2.43.0


