Return-Path: <linux-kernel+bounces-33404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C1F836948
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830E01C23965
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B747CF2E;
	Mon, 22 Jan 2024 15:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="boR/u4YA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B677CF1A;
	Mon, 22 Jan 2024 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936199; cv=none; b=OnpYvfkWd2DTm+R0fOWOpKWnQ/ZuNIv/LvsEdOlVImnz4jGITB8vP5R5hn2wK8ODUXE/as4SiwXcpIobIpo9+Gjz9H4TftTcwmG8z0/J1VIosPdr0tP6nKB6jOILEr7+KEXpGn4k9oL6d/xbjxJSr7Jvcp+w98u0jzrSGgceHu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936199; c=relaxed/simple;
	bh=vmyO24YHFKdgEbGviAcUxNuIr0zWNNtVYbmIoc339XA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lBjtHGAcrANnlC7TmsC3q3DFTQqg4Awin2jx9qCWAj4WaMWaGdtRufpYgQTYZ4MHuNPJyuFzHu0FWtZNkOTY5j2gWFGNQIU+tWqubyDYQtnVSri3Zn7JbEfX6H4WOrfCZCehwiMcgKy1Je4GV4DvUzp0cUbBC3PhZXkqfM0z9hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=boR/u4YA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E5DC43390;
	Mon, 22 Jan 2024 15:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936199;
	bh=vmyO24YHFKdgEbGviAcUxNuIr0zWNNtVYbmIoc339XA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=boR/u4YAO6I0QRgfMPSD0JEUreiZiMTCJzqqUmsg2aK1WgjxWVrbweS5xN09iEXJ+
	 2oWWiQaXttEs62MpRO2MgofUuPahuzgLlluFZ/lNFW+ddhHr/OF03RvsuX7rDg9OTQ
	 QRGLCD2jLTA310frbN6kTJqpPp508/JVK0bf033lWwR3hPVcj4btY2hn+NNgV+R1sV
	 SqMZVHVQRTqFVkZeNbbYt7PKE2QXDQ9TrLpAjm2+oJMChtznUJHv2PZMbZxpStY0rV
	 sI90WqbYg7wfbcRLLMq/ItRJHi8B6g9tNuwsye2VOXe77rnUgmJ8xXMwKFjy4UiXUf
	 UokLVkwqzqB5g==
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
Subject: [PATCH AUTOSEL 6.1 04/53] drm: Fix color LUT rounding
Date: Mon, 22 Jan 2024 10:08:05 -0500
Message-ID: <20240122150949.994249-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150949.994249-1-sashal@kernel.org>
References: <20240122150949.994249-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
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


