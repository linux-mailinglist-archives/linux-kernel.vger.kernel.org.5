Return-Path: <linux-kernel+bounces-68117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C94D857630
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 835781C22841
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E29C18AF6;
	Fri, 16 Feb 2024 06:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLD6gqCd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656191862F
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 06:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708066422; cv=none; b=cETfNJQl2jqf35QHuvPAXOVogQL7IuU1FwG8pa3M1SQbiqyzmv0rvXD8K7kIW9QslxZ6OsFfeo8ayNh5MThyx/LTDhYWpZ5vLzmJkQIsIL4F+1eY8G/SPh7IhfqUy7ueDTUpsjM5OQGPOxOTWAzRmgrB+cOxKsFMq4OBdUZ0Pmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708066422; c=relaxed/simple;
	bh=amudruWj9HLCey00JO7KSVlxOakx7qFxQBUB40Y74us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/+MXUvQo08fWK9qjebjS1v/HVr/jVKe4rVFenqGVY1pXf5fIyvz4UusOe49SZTe7iVrMccdYzq5kemswDbNtlEXKbRY+uomPjKdNl4d+RF16rs17OA0c9IC6i/wnoGJcRo7ax4otzewn4Zh0ZQdhjZN20taz44r1lh1fweG12Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLD6gqCd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF4EC43390;
	Fri, 16 Feb 2024 06:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708066421;
	bh=amudruWj9HLCey00JO7KSVlxOakx7qFxQBUB40Y74us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mLD6gqCd+4bBf7thLiyk9DVfkCA8lRghiFBtNXzuEQ2h1aaq0lwuSuqaVrzZ9L4lw
	 XWDIHc0l7tRFoASez4k/goMJyHoNQNMi7l6m70P8Hq+AAOQaD9QFZasMxiT0Vmxw4C
	 aQHgZVvrnfHtLMLfXkht+oTJSGfrF2+UbkMSt8IZoQxq1xpMQz5ca+sNGsqNCtzfxA
	 P6fO2HgYcv4oC/So+Gqxg6oWWXnp+nwBXMjx0FLDG4H84S/4oa2ab+ryhDsmdVC5aT
	 7tU4WNDeciASWvRQRXWYv0sSOEJXWVY0QfzfAPpFl4UbyjYDcy2C5P1aNJPkLR42d8
	 9xNhKMtdF4FpA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: jani.nikula@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH 03/21] drm/i915: remove intel_dsi::{port_bits,hs}
Date: Fri, 16 Feb 2024 07:53:08 +0100
Message-ID: <20240216065326.6910-4-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240216065326.6910-1-jirislaby@kernel.org>
References: <20240216065326.6910-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel_dsi::port_bits is unused since commit 369602d370fa (drm/i915: Add
support for port enable/disable for dual link configuration) and ::hs is
unused likely since commit 063c86f60ad4 (drm/i915/dsi: remove
intel_dsi_cmd.c and the unused functions therein). Drop them.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/i915/display/intel_dsi.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dsi.h b/drivers/gpu/drm/i915/display/intel_dsi.h
index 083390e5e442..e99c94edfaae 100644
--- a/drivers/gpu/drm/i915/display/intel_dsi.h
+++ b/drivers/gpu/drm/i915/display/intel_dsi.h
@@ -57,9 +57,6 @@ struct intel_dsi {
 		u16 phys;	/* ICL DSI */
 	};
 
-	/* if true, use HS mode, otherwise LP */
-	bool hs;
-
 	/* virtual channel */
 	int channel;
 
@@ -93,7 +90,6 @@ struct intel_dsi {
 	bool bgr_enabled;
 
 	u8 pixel_overlap;
-	u32 port_bits;
 	u32 bw_timer;
 	u32 dphy_reg;
 
-- 
2.43.1


