Return-Path: <linux-kernel+bounces-114535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B04F888AE9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C9F71C291E8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402B922BF6B;
	Sun, 24 Mar 2024 23:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNrZhQzr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4C914A08E;
	Sun, 24 Mar 2024 23:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322168; cv=none; b=cJQ5MWI/qKZut2lQnr1ZFd2ZUry7JuEgaBAmyUg8umo5V5sx2eV+4gH18OwfCK9RKRN8JrC9kzNopY3zZ1BwbfuuLvK95opETyd8dN/2hGmetJmJmvtDYcStIZaztS+67/Cw1V0oMYYi2AlsIql8QAxTVevHBwuDmzM5kl9zlGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322168; c=relaxed/simple;
	bh=KwT+Jadw65672/zjmUvOIOc9f3vzYLmL/4riuvvi1Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qszj5l7wi1iRvrOHPpAGqwqk/jPmj7Jc4W2t/siSXTGUsU+P1fxdOT9TLp9ZC7L0LE0aJlG0144fgxpBqXw3LqpSiWmHdDNKChJIz3eJUF+PdFrbssg05oRuHI5mslti7Z/mmxgW05JD2jbRFGQ6+5Q7notkNt9t5SN4dbXbBA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNrZhQzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B6CC433C7;
	Sun, 24 Mar 2024 23:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322167;
	bh=KwT+Jadw65672/zjmUvOIOc9f3vzYLmL/4riuvvi1Yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bNrZhQzr49LwiaWQPKNZ14Ixt3ZHKMkSth+XvPvZC850lddCFgD2FCyzneKwXGS7C
	 OKslId0Zunhml6D8Ac50gDYtQ22tgBHXG6Jf97P5pAv8d7XcYZmCN7ZsAChSdFPrqL
	 hxPp3gDnYwz2J3kmu2Q8OGSlryQ6B+qxuEOHS/mcs5mhcH3erZKqG3GhichswqypHL
	 ttlKZbJRuHj1jsn1b52QRv5qXkDfwTtWH7m3Cy/Rjd3iOLSoOClBSa6jTsXij6bNG3
	 6OCp/2xyIVkwlV/rVak6Us2j9DNhYxfWhkecKnCTppNYfhCv1n+00MgzyFwfO49eIt
	 E7SLGhrvBm+Sg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>,
	Simon Ser <contact@emersion.fr>,
	Melissa Wen <mwen@igalia.com>,
	Melissa Wen <melissa.srw@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 245/451] drm: Don't treat 0 as -1 in drm_fixp2int_ceil
Date: Sun, 24 Mar 2024 19:08:41 -0400
Message-ID: <20240324231207.1351418-246-sashal@kernel.org>
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

From: Harry Wentland <harry.wentland@amd.com>

[ Upstream commit cf8837d7204481026335461629b84ac7f4538fa5 ]

Unit testing this in VKMS shows that passing 0 into
this function returns -1, which is highly counter-
intuitive. Fix it by checking whether the input is
>= 0 instead of > 0.

Fixes: 64566b5e767f ("drm: Add drm_fixp_from_fraction and drm_fixp2int_ceil")
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Simon Ser <contact@emersion.fr>
Reviewed-by: Melissa Wen <mwen@igalia.com>
Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231108163647.106853-2-harry.wentland@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/drm/drm_fixed.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_fixed.h b/include/drm/drm_fixed.h
index 03cb890690e83..6230088428cdb 100644
--- a/include/drm/drm_fixed.h
+++ b/include/drm/drm_fixed.h
@@ -94,7 +94,7 @@ static inline int drm_fixp2int_round(s64 a)
 
 static inline int drm_fixp2int_ceil(s64 a)
 {
-	if (a > 0)
+	if (a >= 0)
 		return drm_fixp2int(a + DRM_FIXED_ALMOST_ONE);
 	else
 		return drm_fixp2int(a - DRM_FIXED_ALMOST_ONE);
-- 
2.43.0


