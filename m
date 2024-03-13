Return-Path: <linux-kernel+bounces-101224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A772E87A434
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 466E21F22191
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E59D1B971;
	Wed, 13 Mar 2024 08:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1Jk2b1G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B2F1B943
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710319663; cv=none; b=PJzcyKrQXp0CVydhN5qDE9ub3xi6ByE+OojYwexC1O/siumjW3NfDoP1CGfnECExV2yxnaOT8A6jTdt1IQQWcdCJ5/y9Mx1cKqH0EAxg7GANb+5P1U398Pk5UTV99ecAH2T3QtjIATbps+oaMK1SpX/pdfMfy69uvc08NGTT6K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710319663; c=relaxed/simple;
	bh=DOtrx5taZpCaGGzBrVh7vSdllhCDtiQSs7F4mlLOxMk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hqWz5z+FjTD+Fy5BP3ANoATi4591VwxCo0HUOVHCxPPFF806Epyxy5up4zrdjkn8EH4jbuMXvg8iVyS55LiHnVEORjATntZLHK49Vjq5uV4IMFEfBO29ALAUWjdIIDMHVJ+tvhnpDoA4gDZWGQlq4wXSmNqYvPnEU+GVNGXnKsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1Jk2b1G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF25C433F1;
	Wed, 13 Mar 2024 08:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710319662;
	bh=DOtrx5taZpCaGGzBrVh7vSdllhCDtiQSs7F4mlLOxMk=;
	h=From:To:Cc:Subject:Date:From;
	b=W1Jk2b1GyJrAyokLXa1F9I9wi/qsE+mo1ksbL6UFjdrfHuvfEP4CIgxksyVWQrCkQ
	 Qh8Ul/pEFsLrggxR1JNsVsHqjSP3ULjZeQikNqwib4IJGZR9Q723bitsvIVKcp04wp
	 U57zdK9hhIpvQdoc4nTCIgdYzBmcDECQOfZC5Tb1WjWR5hErjTGl7eD6F8BI34b1AH
	 UnMr+q+J7MVCWt/p4kv9wQrwUFhSekLOv3vt90tli/2NUcDWKjnTyEfqpYbMJ5DwDs
	 ERspbYZZgM61PI5Yo+MCUaSzO2ZAhw7TgVvWQ8E3xp9sN3w6oKkBG1cZHx5H+lcBgZ
	 d1HyZK9qZK69g==
From: Arnd Bergmann <arnd@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Radhakrishna Sripada <radhakrishna.sripada@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Imre Deak <imre.deak@intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915: add intel_opregion_vbt_present() stub function
Date: Wed, 13 Mar 2024 09:47:26 +0100
Message-Id: <20240313084735.3305424-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The newly added function is not available without CONFIG_ACPI, causing
a build failure:

drivers/gpu/drm/i915/display/intel_bios.c:3424:24: error: implicit declaration of function 'intel_opregion_vbt_present'; did you mean 'intel_opregion_asle_present'? [-Werror=implicit-function-declaration]

Add an empty stub in the same place as the other stubs.

Fixes: 9d9bb71f3e11 ("drm/i915: Extract opregion vbt presence check")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/i915/display/intel_opregion.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_opregion.h b/drivers/gpu/drm/i915/display/intel_opregion.h
index 63573c38d735..4b2b8e752632 100644
--- a/drivers/gpu/drm/i915/display/intel_opregion.h
+++ b/drivers/gpu/drm/i915/display/intel_opregion.h
@@ -120,6 +120,11 @@ intel_opregion_get_edid(struct intel_connector *connector)
 	return NULL;
 }
 
+static inline bool intel_opregion_vbt_present(struct drm_i915_private *i915)
+{
+	return false;
+}
+
 static inline const void *
 intel_opregion_get_vbt(struct drm_i915_private *i915, size_t *size)
 {
-- 
2.39.2


