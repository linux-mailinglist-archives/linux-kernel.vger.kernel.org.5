Return-Path: <linux-kernel+bounces-33460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B53008369F4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47A461F257D6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6744612F5A0;
	Mon, 22 Jan 2024 15:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1RBvC1g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1FB50A72;
	Mon, 22 Jan 2024 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936394; cv=none; b=A9vVvMyIa7Hb1QGFcKFkMI3j4UOJucrM3uhTqPSzzRuVpD1FczvrJdqQfLj2CEUw9nRazuJQZYLn1of007ysv4XZs3x/sJS3K5f9yAfiuzrhhbQnV4PEhfGBuia5/8QvITubQv848aNW87U+fIRZXqoq3Ub7YnioimV/LX+wELw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936394; c=relaxed/simple;
	bh=vmyO24YHFKdgEbGviAcUxNuIr0zWNNtVYbmIoc339XA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=owwfn6g6CpeRSKDfxQ6qT6MRJE38GZY9XYBZNskvXUvt8m8x8cwanQ8hqXIgOc6iK96pXbFGl//RC8hDSKhs55C5Jg0+KMXHOq3vBxX616lHEHtjDFDMvzE4SeLLoTi8O63MHymUanoAZi8a93f/JB/j7GUBy9L5tQJ2HlnjDSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1RBvC1g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1AD7C433F1;
	Mon, 22 Jan 2024 15:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936394;
	bh=vmyO24YHFKdgEbGviAcUxNuIr0zWNNtVYbmIoc339XA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l1RBvC1gDgiKkwxVcs18++4AQ4zsqxiCVEn7TDIryh2bjoPc0btu6DqJPv4vRSXih
	 GfpL2triSUSRnGa2uRCwgn0qV57jIyHwlG6UENiswCGN04mWUxpJPA5Vy1G8Bh4Hqg
	 ASAb7eMhWwqJJw3Tx3GRjbQ9Qu1wlb/6WMLhBSlDy2NUXUtLH3H+JhIEZYSIUKki6A
	 IUkq97y2dRoOjQavyGK5HsQhLzpi2lmNjFwymt99x9tgwEVXgdLcDMXMA6S2opTG2P
	 v7Lcaq5pMSVMScolmPF8eTSzcznuZOwkC+9RnJa5SRomG7Rerhsc1u2k2JM0gaKR2j
	 /XuJM88dD1oOw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 04/35] drm: Fix color LUT rounding
Date: Mon, 22 Jan 2024 10:12:01 -0500
Message-ID: <20240122151302.995456-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151302.995456-1-sashal@kernel.org>
References: <20240122151302.995456-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

[ Upstream commit c6fbb6bca10838485b820e8a26c23996f77ce580 ]

The current implementation of drm_color_lut_extract()
generates weird results. Eg. if we go through all the
values for 16->8bpc conversion we see the following pattern:

in            out (count)
   0 -   7f ->  0 (128)
  80 -  17f ->  1 (256)
 180 -  27f ->  2 (256)
 280 -  37f ->  3 (256)
..
fb80 - fc7f -> fc (256)
fc80 - fd7f -> fd (256)
fd80 - fe7f -> fe (256)
fe80 - ffff -> ff (384)

So less values map to 0 and more values map 0xff, which
doesn't seem particularly great.

To get just the same number of input values to map to
the same output values we'd just need to drop the rounding
entrirely. But perhaps a better idea would be to follow the
OpenGL int<->float conversion rules, in which case we get
the following results:

in            out (count)
   0 -   80 ->  0 (129)
  81 -  181 ->  1 (257)
 182 -  282 ->  2 (257)
 283 -  383 ->  3 (257)
..
fc7c - fd7c -> fc (257)
fd7d - fe7d -> fd (257)
fe7e - ff7e -> fe (257)
ff7f - ffff -> ff (129)

Note that since the divisor is constant the compiler
is able to optimize away the integer division in most
cases. The only exception is the _ULL() case on 32bit
architectures since that gets emitted as inline asm
via do_div() and thus the compiler doesn't get to
optimize it.

Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231013131402.24072-2-ville.syrjala@linux.intel.com
Reviewed-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/drm/drm_color_mgmt.h | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/include/drm/drm_color_mgmt.h b/include/drm/drm_color_mgmt.h
index 81c298488b0c..54b2b2467bfd 100644
--- a/include/drm/drm_color_mgmt.h
+++ b/include/drm/drm_color_mgmt.h
@@ -36,20 +36,17 @@ struct drm_plane;
  *
  * Extract a degamma/gamma LUT value provided by user (in the form of
  * &drm_color_lut entries) and round it to the precision supported by the
- * hardware.
+ * hardware, following OpenGL int<->float conversion rules
+ * (see eg. OpenGL 4.6 specification - 2.3.5 Fixed-Point Data Conversions).
  */
 static inline u32 drm_color_lut_extract(u32 user_input, int bit_precision)
 {
-	u32 val = user_input;
-	u32 max = 0xffff >> (16 - bit_precision);
-
-	/* Round only if we're not using full precision. */
-	if (bit_precision < 16) {
-		val += 1UL << (16 - bit_precision - 1);
-		val >>= 16 - bit_precision;
-	}
-
-	return clamp_val(val, 0, max);
+	if (bit_precision > 16)
+		return DIV_ROUND_CLOSEST_ULL(mul_u32_u32(user_input, (1 << bit_precision) - 1),
+					     (1 << 16) - 1);
+	else
+		return DIV_ROUND_CLOSEST(user_input * ((1 << bit_precision) - 1),
+					 (1 << 16) - 1);
 }
 
 u64 drm_color_ctm_s31_32_to_qm_n(u64 user_input, u32 m, u32 n);
-- 
2.43.0


