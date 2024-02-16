Return-Path: <linux-kernel+bounces-68133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AEF85764A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28E241F21ABC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2879E208A7;
	Fri, 16 Feb 2024 06:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvmJQd1o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72333208B8
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 06:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708066472; cv=none; b=aksIqCqki5PqUxR+kDHyGFioYqWvREtXtIaidlpA1eQjLlhSYWUXlwkfmft8HHfkr6ZvCvK30y3VDbpEoO/Bij2nnbCaK/uHUDIX31W48e+j8RCzyFr9xeXAkDP2G77QlP/SpclxyWGYDZ83j2eeNhO4PlfARaqdVSc9gB3tFbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708066472; c=relaxed/simple;
	bh=vDCO89h9ED/qo4wLWevCKElHpB2BcZotTCPZ1w3i9Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxiGJ5a7XHWphyrsaMLWLGp3uMToMy564l7OIW/Wbny6d8ag7B1DjUgymV+R0EIiSrrmR2m2rYJ8niffNf6pyebYq39acFvh/zWHeVGQDD/kk+zBQlkT/vxbUnnONZxRLSUP1KN1LS8rySCVz/4+v2iYmc//CiPku/75Y0hPYng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvmJQd1o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B58AC433F1;
	Fri, 16 Feb 2024 06:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708066471;
	bh=vDCO89h9ED/qo4wLWevCKElHpB2BcZotTCPZ1w3i9Jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pvmJQd1o5CPP9qPttQiY8V031wAlyPP80QwLnSBoz7mapvpDVmB0wq9pCsvT88IrX
	 Iuta+sHkqfu1xh25oWlE98lwYiv6ag5ntxnwyRNEvLwru12wKB0SJUlIzc+dQCvtsy
	 p9TyfWuQKHnJj756zzSkg7Tqv6NYshRSJ22ABSL3L98kvQlwW2Usnm0BJnp3WjBnrz
	 nGPIXkqWsjtkR0TyHn5IyVseq9XEN3h7IrZ7YvurSZ6awet7/7Y9Jlb0xb6lAxvrX4
	 Dcigyiv139H7vp8DNQG7K5OwwaXijp+kQV1A/+ruD8H9e0q98RA+qk+NyC4ABkBNGm
	 uugYm5JdvTBOw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: jani.nikula@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH 19/21] drm/i915: remove execute_cb::signal
Date: Fri, 16 Feb 2024 07:53:24 +0100
Message-ID: <20240216065326.6910-20-jirislaby@kernel.org>
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

execute_cb::signal is not used since commit 5ac545b8b014
(drm/i915/request: Remove the hook from await_execution). Drop it.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/i915/i915_request.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
index f59081066a19..519e096c607c 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -52,7 +52,6 @@
 struct execute_cb {
 	struct irq_work work;
 	struct i915_sw_fence *fence;
-	struct i915_request *signal;
 };
 
 static struct kmem_cache *slab_requests;
-- 
2.43.1


