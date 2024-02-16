Return-Path: <linux-kernel+bounces-68129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D537A857646
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13C171C22877
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D901DA5F;
	Fri, 16 Feb 2024 06:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZYa6F4s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7EA1DA23
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 06:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708066460; cv=none; b=m+mIRxcNeDGRR0UbKeTHOQWX4WO+WBLqLkSo1x4EyUCtElW9fQ8V6FXhJDeKqMiMqU/mUdRmnZQtN4rMkdZSisCVeAOJSgVYmA/fu+cgfG0rhFTKCphXtZyFKXd1mDGEO9f4nidP7TMS1xb5OlCq9YppvNh8PlYVKZn8QzE4Y6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708066460; c=relaxed/simple;
	bh=BXImqGWAPuqO33Ld3ZnMdqeekf4kcUYdKg21p7D7eN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SbdylYw+yG3Ac37YpaRJ/Bm7ekUA8NiNeJe7naT1gq1SZHE7IH7dzWeNONpUSgArd1etUwdhIQ+yx8l61dhvm8jKHY9IB7uGH7Uv73aXhlBqoLGF4HeBQhDOZ57p6UnBer6CeHQQFnUE9QMGtJgOYBa308YN99FJsRkNeprGAFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZYa6F4s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DD1C433C7;
	Fri, 16 Feb 2024 06:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708066459;
	bh=BXImqGWAPuqO33Ld3ZnMdqeekf4kcUYdKg21p7D7eN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OZYa6F4sJIbOHW1A/nf05Cx7UXrlVbKnctd7m6e53k5qk8qOzli1waB1ESFi+U2kM
	 P2n7o+9xU4Ntq4h0Cenr6KVAOohzzzX7qwCJK+WI3IuxC5cSB34oywUqoOSyhRuvKb
	 aLKc44lOuKkKl66wsvAS9WJ7J8ioRM2/cjBSJJ8LMfhqiRA/TRDj5nNHO28jkT6H4N
	 t3wKvbTA+xDlpXRf3E/OfJ/TayYEbOW0ZTu/bJDW2ZbLWxajekbTh0wPJ1FJ+oP0ga
	 lkSC+uUbjxdLM6E3hn5kJ68nOcZqtknkriN1Nv3taD8LPYcq7WmzzZO0msKpQG1zm/
	 2VxP9q4/ufFlg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: jani.nikula@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH 15/21] drm/i915: remove gvt_mmio_block::device
Date: Fri, 16 Feb 2024 07:53:20 +0100
Message-ID: <20240216065326.6910-16-jirislaby@kernel.org>
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

gvt_mmio_block::device is not used since commit e0f74ed4634d (i915/gvt:
Separate the MMIO tracking table from GVT-g). Drop it.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/i915/gvt/gvt.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gvt.h
index b8b8ffe4d566..2c95aeef4e41 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.h
+++ b/drivers/gpu/drm/i915/gvt/gvt.h
@@ -253,7 +253,6 @@ struct intel_gvt_fence {
 
 /* Special MMIO blocks. */
 struct gvt_mmio_block {
-	unsigned int device;
 	i915_reg_t   offset;
 	unsigned int size;
 	gvt_mmio_func read;
-- 
2.43.1


