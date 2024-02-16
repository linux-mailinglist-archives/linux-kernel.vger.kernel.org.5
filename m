Return-Path: <linux-kernel+bounces-68122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF1585763F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ABC4287717
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E8E1BF44;
	Fri, 16 Feb 2024 06:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7EaO9HR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2E71BF34
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 06:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708066438; cv=none; b=eXC/j/67ab+QIF5lufZa4sB0G6F1f+EBkHQ41iUK+OYTNmp7R/6Uphu2Y/N0eBIgnPauCNx/luJFzqQC8E6dWAzehRZmx6AfNNGhgEovZyq1ajWiueRKQu9oUSD7/BSHCHg4/qJrhxS8jedIJ+Rfzs29P8GrQQxHKDqhfWiQ0F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708066438; c=relaxed/simple;
	bh=xAhGbARzs83EneUXBDZflPwViGnccMXkpjIP1CYeQhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6B5CUeWlICT2EMU9/vol1aBW2keH587rVsS7HgblEtOfy7Dd6IIuOut5z47oVwA9Tq3tUSW202A8kB/Y51iKlGRdJM7NupDuzwkT0SS5gSpvB/E9LfoGsDm6xzOx9SnUhp1JnU0PI+ogpWsDb75tj0tyeN1VH1SmuMXSIcg2l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7EaO9HR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FF7C433C7;
	Fri, 16 Feb 2024 06:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708066438;
	bh=xAhGbARzs83EneUXBDZflPwViGnccMXkpjIP1CYeQhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X7EaO9HRGWuJT9OQFFjFHOAEGCSPJNOQSEQW0OotFJMCh7gKgYIKkMgYhYMzAWg9v
	 qfpU8ExWaTf2OiwDh6c53Ac7/1HYTXPhh8A4fkDq/nCoduEvxlSW5EwGNsEq5J8nZx
	 2qpItkKEWsQ+JyzTFRXoPRNjaX061QSbmI4gQ7YKSR6YwV0Ex3jI3HNSIyEmJuFnL+
	 B+mbyNcy95vWmTcsE140ztEKmi/9iquKXznkR58v1/wo+m7TpRalI4f/dqHyYkdMwk
	 P8jXM54QskG/ecIOS/wDcQFhiw2xjKEM7sC2BYuIdwyRGOg02R29XGzsgOGMKQag2p
	 8pfD4dIju9SlA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: jani.nikula@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH 08/21] drm/i915: remove intel_guc::ads_engine_usage_size
Date: Fri, 16 Feb 2024 07:53:13 +0100
Message-ID: <20240216065326.6910-9-jirislaby@kernel.org>
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

intel_guc::ads_engine_usage_size was never used since its addition in
commit 77cdd054dd2c (drm/i915/pmu: Connect engine busyness stats from
GuC to pmu). Drop it.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/i915/gt/uc/intel_guc.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc.h b/drivers/gpu/drm/i915/gt/uc/intel_guc.h
index 813cc888e6fa..be70c46604b4 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc.h
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc.h
@@ -206,8 +206,6 @@ struct intel_guc {
 	u32 ads_golden_ctxt_size;
 	/** @ads_capture_size: size of register lists in the ADS used for error capture */
 	u32 ads_capture_size;
-	/** @ads_engine_usage_size: size of engine usage in the ADS */
-	u32 ads_engine_usage_size;
 
 	/** @lrc_desc_pool_v69: object allocated to hold the GuC LRC descriptor pool */
 	struct i915_vma *lrc_desc_pool_v69;
-- 
2.43.1


