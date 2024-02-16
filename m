Return-Path: <linux-kernel+bounces-68119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B83685763C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1FC3B23D6D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D041B81C;
	Fri, 16 Feb 2024 06:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7Qk1Sx4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB8D1B812
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 06:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708066429; cv=none; b=j//97qXGpbpiDbY/1/tHQDmQvwG8WzI+iZTH1od0qcPC3kKabO7G9z1NYzJFQA15ij4keSk/fb6H+CltIwPR8vYtDslS/PV8CoarpxWf8mgMom+ldQlOyUtV9VAGgnNqhpFJYEpFdOxrJVPXxU7f9r84N1dl2kb87xmMuTPYteI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708066429; c=relaxed/simple;
	bh=qkEq3E8Km4jpaGRnx1Vm2eeB5z7Na+ns2sz54n6h9uI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UopiKH7eG+vgORDjQ7wwP5/j/rrhnExjPUNcU+AwxN6WgEp4Eiqqd5haNq2qDO7XBsuwdDUvh1ZsP+UgOqdO1YHS35uASMp0ugpFmvVrAjZx4mc8gbsXho6q00YoUbaBJEE/r72Ne1C5y0ivdVc+rjLVgIFFWPNYaFGa10SEnS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7Qk1Sx4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F02DC433A6;
	Fri, 16 Feb 2024 06:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708066428;
	bh=qkEq3E8Km4jpaGRnx1Vm2eeB5z7Na+ns2sz54n6h9uI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u7Qk1Sx4GA+PGmFjQyCFB2rBOZ8P5QWLyc9Jh5KlH9OocfGntKGl75SuUz2Bi+9J4
	 3I5IfLJuVP+ogCoPL4n9b8H/U3Kr9ev+t5BHRElOVCFHW9FERbXvNH/eVG0iuhqURy
	 Z+OMoy66+JIxkK9LzplSveGRMzqKLuPd4L3SwrGP46ODY1hm71WVuRIspzO50219nx
	 N/DizssclSDGn1Sup9OZ4A0csADlHybg9vVfZ60a018fmhWDovvO8GvF71UcODibIu
	 6FBKW9V5mCgdrU19Lzl0/nnqd/D90L6uytIClTUUfNpDReTZSpSDuGpO5Zgzqh5+Gn
	 EMDkYkElKaqqw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: jani.nikula@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH 05/21] drm/i915: remove intel_gvt_mmio_info::{device,addr_range}
Date: Fri, 16 Feb 2024 07:53:10 +0100
Message-ID: <20240216065326.6910-6-jirislaby@kernel.org>
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

intel_gvt_mmio_info::device is not used since commit e0f74ed4634d
(i915/gvt: Separate the MMIO tracking table from GVT-g) and ::addr_range
was never used since its addition in commit 12d14cc43b34 (drm/i915/gvt:
Introduce a framework for tracking HW registers.). Drop them.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/i915/gvt/mmio.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/mmio.h b/drivers/gpu/drm/i915/gvt/mmio.h
index bba154e38705..32ebacb078e8 100644
--- a/drivers/gpu/drm/i915/gvt/mmio.h
+++ b/drivers/gpu/drm/i915/gvt/mmio.h
@@ -62,10 +62,8 @@ typedef int (*gvt_mmio_func)(struct intel_vgpu *, unsigned int, void *,
 struct intel_gvt_mmio_info {
 	u32 offset;
 	u64 ro_mask;
-	u32 device;
 	gvt_mmio_func read;
 	gvt_mmio_func write;
-	u32 addr_range;
 	struct hlist_node node;
 };
 
-- 
2.43.1


