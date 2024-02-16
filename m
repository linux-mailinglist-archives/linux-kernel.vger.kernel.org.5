Return-Path: <linux-kernel+bounces-68125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEF5857642
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C1F028560C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABCB1CAA2;
	Fri, 16 Feb 2024 06:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcPOWQoE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642941CA9A
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 06:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708066447; cv=none; b=slIgSeT+jAKm58vFmP9PFtQPXf9Rg/8QjnkSWymibO1j9d6Menhc07GQrK6GKIVAq0+ZzkPleNvWouL8sWPtgTNbqDiZK84pi5xX6qacLP2afQvUyjZXRde1bBXsJOY8HL18A2NItlseyIFuLaQLK9hO7hZGRxvTBlpoWojIf6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708066447; c=relaxed/simple;
	bh=D1UVKTUwrumNB4hwYMCCqn17XRjRd4Butj96fqO0Ms8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9hyfHQ4SOh9oWEn2kLpHuNwb08jjqdYzouTBnHs51Mjvz2NguEve5c4ZyGkX/IzuXgkabynnDs7VFPyEDdtoFO3TpNWcQzyuueMu3GAyylwwA04BMQcaxmHpIOTt7+5ZB1Q59d7Fq5rWczZPAZxBy6kImgbt6rqCfZ8H964j1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcPOWQoE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D78C433F1;
	Fri, 16 Feb 2024 06:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708066446;
	bh=D1UVKTUwrumNB4hwYMCCqn17XRjRd4Butj96fqO0Ms8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bcPOWQoEz23Zw9RUcbqEyl8B6I+N8c2+TNF+litP20oTavcBUp4OMcqgSikxs9hIy
	 GBUv8uCuIGafuExHqqNKSGSexCkHq2tZl+4NTqRLuUSAQlAquRvyKfMh9ZEaDuWvYi
	 7Hwo0cJmbybLTXpfvhEU97F+owLSUn0nfuVr44SNOC4FBO5CBz3XdlAS87pPXo73RY
	 YiUpVcKDF0HlR+Bii/IWPxg6+qMa7l4kjVr+djNQCMxDkEYj0v1QAnshCedXfLqx5M
	 N68b3v8f0aCn+Hu6mL/eovXey2vuAviuiC0HezrAYj6ivjaPf2ow46KWtVaYYTAJRK
	 uRSTpcFUqEYNA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: jani.nikula@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH 11/21] drm/i915: remove intel_vgpu_gtt::active_ppgtt_mm_bitmap
Date: Fri, 16 Feb 2024 07:53:16 +0100
Message-ID: <20240216065326.6910-12-jirislaby@kernel.org>
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

intel_vgpu_gtt::active_ppgtt_mm_bitmap was never used since its
addition in commit 2707e4446688 (drm/i915/gvt: vGPU graphics memory
virtualization). Drop it.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/i915/gvt/gtt.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/gtt.h b/drivers/gpu/drm/i915/gvt/gtt.h
index fb96ea454fd1..cb50700e6cc9 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.h
+++ b/drivers/gpu/drm/i915/gvt/gtt.h
@@ -208,7 +208,6 @@ struct intel_vgpu_scratch_pt {
 
 struct intel_vgpu_gtt {
 	struct intel_vgpu_mm *ggtt_mm;
-	unsigned long active_ppgtt_mm_bitmap;
 	struct list_head ppgtt_mm_list_head;
 	struct radix_tree_root spt_tree;
 	struct list_head oos_page_list_head;
-- 
2.43.1


