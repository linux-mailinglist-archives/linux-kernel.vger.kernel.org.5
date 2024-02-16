Return-Path: <linux-kernel+bounces-68126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 095B4857643
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACFA7287057
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E70B1CD07;
	Fri, 16 Feb 2024 06:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDfx5flm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E9B1CAB7
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 06:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708066449; cv=none; b=qxMONfvXYhLm0y+aX7tKl2zviOcPFNRXNcJJUR78D7urTIyPLPScnzBfFUesOEGysupiZusVKxeVs1QuD79qiuROCakGHUSC33iFio+VPD0RMm0g47sQqi718IjtLYrIM3HPzrjUuSHsA6hJl3lA2SXCDFUfEcdy4t1o+wRVwAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708066449; c=relaxed/simple;
	bh=8o0wvfgtp9sQfzOgFfW8t1yUu/RnxbOaOuDmpI5A5qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anwak8RlJe7tKv/tv77bh5F/Iry8XufU+L6qQeIp7GiGifxKomT9crjRqoFUO87Mmhn08raa64ufaDI8P9zqVc2GxyZ1lvRMeFlZAgp8+3yl+zzbqi6uzWjAEv1/yxHYXQfwetxQpMNlIlxOIfaWSHC5u3G8t8fZIQ2mIHgcSpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDfx5flm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1434FC433C7;
	Fri, 16 Feb 2024 06:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708066449;
	bh=8o0wvfgtp9sQfzOgFfW8t1yUu/RnxbOaOuDmpI5A5qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KDfx5flmsaTtfTYf4Irng/CnPwsgJzJ+dCaPmXn2In2KJowAOIDfk3S4a8EZN8Wci
	 BNHEy6+fHdkUEo33XX5p8tlaEut0C49KaVhNLaHht/oPG2DVLypJecnoYueC81JbXi
	 V0HMdYliYRfKvpOuoGFohYyUEurgXau3BOqP80MA+a6fFF2OrIEUmbWa6oaOlOC/I9
	 l6Py+6hUpe5SiWWTWl///JzRTnAmmSkRN2KvUepgwDllHeTf1tMrfqLy5uFFpg1g6y
	 H+/gIlTcFRsYy4ZdCjDqRfIxjzk/y2rYHqBZoql1212DKkabX918XDQfNWKRkEzMzb
	 xNGpHrnT1crUQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: jani.nikula@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH 12/21] drm/i915: remove intel_vgpu_fence::base
Date: Fri, 16 Feb 2024 07:53:17 +0100
Message-ID: <20240216065326.6910-13-jirislaby@kernel.org>
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

intel_vgpu_fence::base was never used since its addition in commit
28a60dee2ce6 (drm/i915/gvt: vGPU HW resource management). Drop it.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/i915/gvt/gvt.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gvt.h
index c57aba09091f..b6fe17f1a16f 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.h
+++ b/drivers/gpu/drm/i915/gvt/gvt.h
@@ -89,7 +89,6 @@ struct intel_vgpu_gm {
 /* Fences owned by a vGPU */
 struct intel_vgpu_fence {
 	struct i915_fence_reg *regs[INTEL_GVT_MAX_NUM_FENCES];
-	u32 base;
 	u32 size;
 };
 
@@ -444,7 +443,6 @@ int intel_gvt_load_firmware(struct intel_gvt *gvt);
 #define vgpu_hidden_gmadr_end(vgpu) \
 	(vgpu_hidden_gmadr_base(vgpu) + vgpu_hidden_sz(vgpu) - 1)
 
-#define vgpu_fence_base(vgpu) (vgpu->fence.base)
 #define vgpu_fence_sz(vgpu) (vgpu->fence.size)
 
 /* ring context size i.e. the first 0x50 dwords*/
-- 
2.43.1


