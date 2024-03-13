Return-Path: <linux-kernel+bounces-101584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C734887A903
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 833262880BC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2186045024;
	Wed, 13 Mar 2024 14:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=puri.sm header.i=@puri.sm header.b="skwZd2/F"
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B449C4120B;
	Wed, 13 Mar 2024 14:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.203.221.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710338735; cv=none; b=fIrrDtKjhbcxdVASwO40j4TAv4IFxXvmuvBywuRUzNSNuUk2yY4N8DGL3lBqowxWR3eftB2ZYASjj4nJVLxGYWLfBCu0/3pttbOiHI71vXTpAHCoSgZzdMOsQpLox0ndNSJAS259PedkLXoT+ruCQWlr8lsZTg+5dGtgC2m5b2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710338735; c=relaxed/simple;
	bh=8qtHRFqFZ2rbe52sUD4by7YDRxEdBcPf5IDzrs6Gjqk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cSjWXsMG+ZJLiVpMl+BnoSfZVlEiFGsOaecf5EpPaidZeCO9Em3kilnsLiGg4z4cW18Nx6DnU/Luv8QyaW8g1F1dUZJbRbIFuqocmiXj4CK2n/BGYNg1apho72Yk6o6vsJmDgdjz6vr5TG5+jbv5G05Cu8SPKgyqwvsrjHPFHKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=puri.sm; spf=pass smtp.mailfrom=puri.sm; dkim=pass (2048-bit key) header.d=puri.sm header.i=@puri.sm header.b=skwZd2/F; arc=none smtp.client-ip=159.203.221.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=puri.sm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=puri.sm
Received: from localhost (localhost [127.0.0.1])
	by comms.puri.sm (Postfix) with ESMTP id 4B155E7CE6;
	Wed, 13 Mar 2024 06:56:12 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
	by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UKUs71YCXFd8; Wed, 13 Mar 2024 06:56:11 -0700 (PDT)
From: Jonathon Hall <jonathon.hall@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
	t=1710338171; bh=8qtHRFqFZ2rbe52sUD4by7YDRxEdBcPf5IDzrs6Gjqk=;
	h=From:To:Cc:Subject:Date:From;
	b=skwZd2/FqDgucBW9TVZI7DDHLSeEqLuS6GX+OxZWnbxS94J7b5xXqbyf4dB2LCC7t
	 rkPNwVVnSTzp+Z4/DZNVjs8R4PtJ1KvjJGSf3p/p4RaVfmINKTtatBrXSmzzWB/mf9
	 x8lPunfhdCNq7U39Eb8Nu0oZxfUTI1RmlHVNpvMt3JkxM6awOnjzG4k7Rwkm6vdQEB
	 7xuvk1SeePRNVBruhxrcSNvXFXTUsQRIAm3OviQ2DTyXCJfjz6LFUWg/v76egWXC5L
	 2E0CRRgWGybYV8g/A3DA+bxoWgdhJlAogbAFjhOKvYLW9SLs3OT+msma+0x8Nymt8K
	 tJgmp+ZDJRI5w==
To: linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.viv@intel.com,
	tursulin@ursulin.net
Cc: Jonathon Hall <jonathon.hall@puri.sm>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915: Do not match JSL in ehl_combo_pll_div_frac_wa_needed()
Date: Wed, 13 Mar 2024 09:54:25 -0400
Message-Id: <20240313135424.3731410-1-jonathon.hall@puri.sm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 0c65dc062611 ("drm/i915/jsl: s/JSL/JASPERLAKE for
platform/subplatform defines"), boot freezes on a Jasper Lake tablet
(Librem 11), usually with graphical corruption on the eDP display,
but sometimes just a black screen.  This commit was included in 6.6 and
later.

That commit was intended to refactor EHL and JSL macros, but the change
to ehl_combo_pll_div_frac_wa_needed() started matching JSL incorrectly
when it was only intended to match EHL.

It replaced:
	return ((IS_PLATFORM(i915, INTEL_ELKHARTLAKE) &&
		 IS_JSL_EHL_DISPLAY_STEP(i915, STEP_B0, STEP_FOREVER)) ||
with:
	return (((IS_ELKHARTLAKE(i915) || IS_JASPERLAKE(i915)) &&
		 IS_DISPLAY_STEP(i915, STEP_B0, STEP_FOREVER)) ||

Remove IS_JASPERLAKE() to fix the regression.

Signed-off-by: Jonathon Hall <jonathon.hall@puri.sm>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
index ef57dad1a9cb..57a97880dcb3 100644
--- a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
+++ b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
@@ -2509,7 +2509,7 @@ static void icl_wrpll_params_populate(struct skl_wrpll_params *params,
 static bool
 ehl_combo_pll_div_frac_wa_needed(struct drm_i915_private *i915)
 {
-	return (((IS_ELKHARTLAKE(i915) || IS_JASPERLAKE(i915)) &&
+	return ((IS_ELKHARTLAKE(i915) &&
 		 IS_DISPLAY_STEP(i915, STEP_B0, STEP_FOREVER)) ||
 		 IS_TIGERLAKE(i915) || IS_ALDERLAKE_S(i915) || IS_ALDERLAKE_P(i915)) &&
 		 i915->display.dpll.ref_clks.nssc == 38400;
-- 
2.39.2


