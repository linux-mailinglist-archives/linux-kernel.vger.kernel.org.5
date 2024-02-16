Return-Path: <linux-kernel+bounces-68120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C78BF85763D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 794311F22B11
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAA91B972;
	Fri, 16 Feb 2024 06:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRSpAaUC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6051B959
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 06:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708066431; cv=none; b=cX/3AjR8gk3Yumf2h18AUVypx8P+wMYJ2HnYZmrIqiEuA14oqzqtTxp8PXkW4ZgEOBqMcKDPDU17cmiCE0Ep0P9hqhNNTAbUEMfmxj760vL+EUP5lMMTxu2KpgsGinc/03s77TDiQl+tc6vZaIG00kvuxqOVLjzsSV/3d/75Fis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708066431; c=relaxed/simple;
	bh=eet1vEI7EGs4P/wMxc9m6gOO4iuk9u8MjHggPAsGzEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f3JzfbZcfJYnsbYauB/jXObKe5Wsku41lBg9gJjZjANM6qLnBDhmXADGzMbM1GPzvede+i8e81EdqSLfVhYHPg1J8oVz+5m8LIstT1rvedQG056OcmgrgQmoMJm602+G5RppZN/zzHlfjkCqjBGN2djY9rrgAdV4Ugx36oDSb38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRSpAaUC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A57AC433C7;
	Fri, 16 Feb 2024 06:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708066431;
	bh=eet1vEI7EGs4P/wMxc9m6gOO4iuk9u8MjHggPAsGzEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gRSpAaUCq7sEC/LdG4M3Prfc0JaS8gfE/ZNfbr3xXAa+cwpwcDl0zfq9KRfMRwunE
	 aHcasZ3/yonQzNLzyHiKFokR5zQLwEFmz09UtPTvTA6EHbgwoxRfP6x9+QRmKiMWLp
	 eb9q0U0C54U5xO41R0JDA8qHjM3CNOrK5qJ6kfnBILsh3qHGe8z19tZOP9bA1Cf2VC
	 3zSma9BWhPEotfmdH+P2JQlG1fsMRTBltcDKbRAIisxZCc7TPD3Pgcm5BjXd78B+H8
	 tqBf+civB8pKDnVAZvqVu3UPWKMVNrkl89yjMvFOIa0EqiblkauoZBCEA4c7kRpqkN
	 qIav2T3ztQW8w==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: jani.nikula@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH 06/21] drm/i915: remove intel_vgpu_workload::{ring_context,restore_inhibit}
Date: Fri, 16 Feb 2024 07:53:11 +0100
Message-ID: <20240216065326.6910-7-jirislaby@kernel.org>
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

intel_vgpu_workload::ring_context was never used since its addition in
commit 28c4c6ca7f79 (drm/i915/gvt: vGPU workload submission) and
::restore_inhibit since its addition in commit e473405783c0
(drm/i915/gvt: vGPU workload scheduler). Drop them.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/i915/gvt/scheduler.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/scheduler.h b/drivers/gpu/drm/i915/gvt/scheduler.h
index 1f391b3da2cc..cd94993278b6 100644
--- a/drivers/gpu/drm/i915/gvt/scheduler.h
+++ b/drivers/gpu/drm/i915/gvt/scheduler.h
@@ -104,10 +104,8 @@ struct intel_vgpu_workload {
 
 	/* execlist context information */
 	struct execlist_ctx_descriptor_format ctx_desc;
-	struct execlist_ring_context *ring_context;
 	unsigned long rb_head, rb_tail, rb_ctl, rb_start, rb_len;
 	unsigned long guest_rb_head;
-	bool restore_inhibit;
 	struct intel_vgpu_elsp_dwords elsp_dwords;
 	bool emulate_schedule_in;
 	atomic_t shadow_ctx_active;
-- 
2.43.1


