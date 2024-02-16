Return-Path: <linux-kernel+bounces-68116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD2585762C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40ECE1C226F3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAAE17BD4;
	Fri, 16 Feb 2024 06:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0o9/HY5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60D117BC9
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 06:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708066418; cv=none; b=BrM9RxG0FgHgTvjjfBlq+sG6Udd2f5pC6uToTMjmwGDLDVtaWO78Us5k8xGJy2+yzs5BbYBLitGDJ6cI8qLRhHBgOm7aZ0+LbQv8pqJphUryUu9+r76zH3Im0vhCK30D9IS8apRX9s7TGerTEK+bMzZgV4fMgss+u7/Nc6XmhLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708066418; c=relaxed/simple;
	bh=pXw6+3BPDvBumd0PwA+aAJatufGvT44a+p6B8ZAqPXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mEj8vzMgik6A+gOEUsoUq7mYVLszKy22PPiTCcMY24b8xiAFKjaaJI2HFdZgF1BW1ktjp9HkXOKAya66m8g90eEJVvovQC+3I696f7KwjFHwpDqAF3forUWL35iWcWR21xNzlim8xCNz/yaZJyb7zAQWUTL8ujFotunZawabFlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0o9/HY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D32C433C7;
	Fri, 16 Feb 2024 06:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708066418;
	bh=pXw6+3BPDvBumd0PwA+aAJatufGvT44a+p6B8ZAqPXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y0o9/HY5F2PEyFbtUd5uHnUb/4bjqoiE6DU767MASXwLFxpanMtU0lFrsZqH5Gcd4
	 bl31pIfTFA1GIkCS+R14e6FV07Q1o+mxoAJks1TRO/5lzULPAcdP2eyTcaj+sM/zdL
	 N4DUmtOI535iN6br5CyWlxIWHauPYOu15R1JkWglfRgQURsD92lxkH0yjA0ukxa40x
	 fjTvpX6mtC2IHEWFnt+Az3SDHBtGC4+q+hidXBhZcrL/ZtRo5+6Nzds08IkoYDmjKr
	 Q/RR2v8rYegAQ8VsJ1k8b0BYpittp5xJW9yvbgiehpOARow5a90hLFVe4r413/KnAM
	 HKTww1cbxWHRw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: jani.nikula@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH 02/21] drm/i915: remove structs intel_vgpu_pipe_format and intel_vgpu_fb_format
Date: Fri, 16 Feb 2024 07:53:07 +0100
Message-ID: <20240216065326.6910-3-jirislaby@kernel.org>
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

Both struct intel_vgpu_pipe_format and intel_vgpu_fb_format were never
used since its addition in commit 9f31d1063b43 (drm/i915/gvt: Add
framebuffer decoder support). Drop them.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/i915/gvt/fb_decoder.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/fb_decoder.h b/drivers/gpu/drm/i915/gvt/fb_decoder.h
index 4eff44194439..fa6503900c84 100644
--- a/drivers/gpu/drm/i915/gvt/fb_decoder.h
+++ b/drivers/gpu/drm/i915/gvt/fb_decoder.h
@@ -152,17 +152,6 @@ struct intel_vgpu_cursor_plane_format {
 	u32	y_hot;		/* in pixels */
 };
 
-struct intel_vgpu_pipe_format {
-	struct intel_vgpu_primary_plane_format	primary;
-	struct intel_vgpu_sprite_plane_format	sprite;
-	struct intel_vgpu_cursor_plane_format	cursor;
-	enum DDI_PORT ddi_port;  /* the DDI port that pipe is connected to */
-};
-
-struct intel_vgpu_fb_format {
-	struct intel_vgpu_pipe_format	pipes[I915_MAX_PIPES];
-};
-
 int intel_vgpu_decode_primary_plane(struct intel_vgpu *vgpu,
 	struct intel_vgpu_primary_plane_format *plane);
 int intel_vgpu_decode_cursor_plane(struct intel_vgpu *vgpu,
-- 
2.43.1


