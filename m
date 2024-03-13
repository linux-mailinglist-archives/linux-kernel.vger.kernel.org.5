Return-Path: <linux-kernel+bounces-101731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0D987AB1B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77A5E1F22554
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A38482DA;
	Wed, 13 Mar 2024 16:27:56 +0000 (UTC)
Received: from relay161.nicmail.ru (relay161.nicmail.ru [91.189.117.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711F54596D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347276; cv=none; b=tVXA8XU+pWHqFTz+EQ3tVIUXjECNskV0HZavqLqB4juWgxDilwGMoL421QmB/9T/C9Hfsw5hP1aCiLQkpIglsOgbH9HeHotiPRFPrGjrMqwu0DEhKecJvLQpJEE2O/Syyoe/CyMJziwLCacKesNaiNwBWX56pZm2QAHZqvVZyDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347276; c=relaxed/simple;
	bh=YU11scXvmpPysOaCdp11+qR9MQxZXWdTxoxTQCHZTaI=;
	h=Message-ID:Date:MIME-Version:From:Subject:References:To:Cc:
	 In-Reply-To:Content-Type; b=tw1TZce76dskmQEiIzCH+EUftNIQCo7qFm+XYg1KvjKsM2jtrbKe6PSsniQNCwUm/PDk6o+jWB496rZf/kKyFlvczmP4zUTJf1I8L7vwAnyxFpCzceWBaixs43s/NysDI21ij0CsAgZ/LESwRU0zSJgyxLvzJK3d8NVAOY7xouk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.138.152] (port=35910 helo=[192.168.95.111])
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1rkRS6-0000rC-68;
	Wed, 13 Mar 2024 19:27:39 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO [192.168.95.111])
	by incarp1104.mail.hosting.nic.ru (Exim 5.55)
	with id 1rkRS6-00GwOs-2f;
	Wed, 13 Mar 2024 19:27:38 +0300
Message-ID: <2931c3e3-054d-4085-9bd9-3b8414788675@ancud.ru>
Date: Wed, 13 Mar 2024 19:27:36 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nikita Kiryushin <kiryushin@ancud.ru>
Subject: [PATCH] drm/i915: remove platform checks in platform-specific
 handlers
References: <>
Content-Language: en-US
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Matt Roper <matthew.d.roper@intel.com>,
 Radhakrishna Sripada <radhakrishna.sripada@intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>,
 Gustavo Sousa <gustavo.sousa@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>,
 Shekhar Chauhan <shekhar.chauhan@intel.com>,
 Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MS-Exchange-Organization-SCL: -1


Remove IS_KABYLAKE and IS_SKYLAKE in special handlers for
skylake and kabylake: the checks are done at hook initialization and are
always true in corresponding handlers.

Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
---
  drivers/gpu/drm/i915/gt/intel_workarounds.c | 6 +++---
  drivers/gpu/drm/i915/intel_clock_gating.c   | 4 ++--
  2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_workarounds.c 
b/drivers/gpu/drm/i915/gt/intel_workarounds.c
index 3eacbc50caf8..8eff6be9d74c 100644
--- a/drivers/gpu/drm/i915/gt/intel_workarounds.c
+++ b/drivers/gpu/drm/i915/gt/intel_workarounds.c
@@ -601,7 +601,7 @@ static void kbl_ctx_workarounds_init(struct 
intel_engine_cs *engine,
  	gen9_ctx_workarounds_init(engine, wal);
   	/* WaToEnableHwFixForPushConstHWBug:kbl */
-	if (IS_KABYLAKE(i915) && IS_GRAPHICS_STEP(i915, STEP_C0, STEP_FOREVER))
+	if (IS_GRAPHICS_STEP(i915, STEP_C0, STEP_FOREVER))
  		wa_masked_en(wal, COMMON_SLICE_CHICKEN2,
  			     GEN8_SBE_DISABLE_REPLAY_BUF_OPTIMIZATION);
  @@ -1169,7 +1169,7 @@ skl_gt_workarounds_init(struct intel_gt *gt, 
struct i915_wa_list *wal)
  		    GEN8_EU_GAUNIT_CLOCK_GATE_DISABLE);
   	/* WaInPlaceDecompressionHang:skl */
-	if (IS_SKYLAKE(gt->i915) && IS_GRAPHICS_STEP(gt->i915, STEP_A0, STEP_H0))
+	if (IS_GRAPHICS_STEP(gt->i915, STEP_A0, STEP_H0))
  		wa_write_or(wal,
  			    GEN9_GAMT_ECO_REG_RW_IA,
  			    GAMT_ECO_ENABLE_IN_PLACE_DECOMPRESS);
@@ -1181,7 +1181,7 @@ kbl_gt_workarounds_init(struct intel_gt *gt, 
struct i915_wa_list *wal)
  	gen9_gt_workarounds_init(gt, wal);
   	/* WaDisableDynamicCreditSharing:kbl */
-	if (IS_KABYLAKE(gt->i915) && IS_GRAPHICS_STEP(gt->i915, 0, STEP_C0))
+	if (IS_GRAPHICS_STEP(gt->i915, 0, STEP_C0))
  		wa_write_or(wal,
  			    GAMT_CHKN_BIT_REG,
  			    GAMT_CHKN_DISABLE_DYNAMIC_CREDIT_SHARING);
diff --git a/drivers/gpu/drm/i915/intel_clock_gating.c 
b/drivers/gpu/drm/i915/intel_clock_gating.c
index 9c21ce69bd98..977251bcbf42 100644
--- a/drivers/gpu/drm/i915/intel_clock_gating.c
+++ b/drivers/gpu/drm/i915/intel_clock_gating.c
@@ -413,12 +413,12 @@ static void kbl_init_clock_gating(struct 
drm_i915_private *i915)
  	intel_uncore_rmw(&i915->uncore, FBC_LLC_READ_CTRL, 0, 
FBC_LLC_FULLY_OPEN);
   	/* WaDisableSDEUnitClockGating:kbl */
-	if (IS_KABYLAKE(i915) && IS_GRAPHICS_STEP(i915, 0, STEP_C0))
+	if (IS_GRAPHICS_STEP(i915, 0, STEP_C0))
  		intel_uncore_rmw(&i915->uncore, GEN8_UCGCTL6,
  				 0, GEN8_SDEUNIT_CLOCK_GATE_DISABLE);
   	/* WaDisableGamClockGating:kbl */
-	if (IS_KABYLAKE(i915) && IS_GRAPHICS_STEP(i915, 0, STEP_C0))
+	if (IS_GRAPHICS_STEP(i915, 0, STEP_C0))
  		intel_uncore_rmw(&i915->uncore, GEN6_UCGCTL1,
  				 0, GEN6_GAMUNIT_CLOCK_GATE_DISABLE);
  -- 2.34.1


