Return-Path: <linux-kernel+bounces-68132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8E8857649
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78241F21D2E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1E92030F;
	Fri, 16 Feb 2024 06:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJqCV8/y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7668200D1
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 06:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708066468; cv=none; b=AJRv2XCiMqDQb4oC2VWsPb93QW9wCpdTW46P1NILTxZRQJlavPw7KsV+T1Ng5vGXA2xLXyxfQh/bkV8zYuTZzPf/v7YRsuLdajhXEcqx5ZySUxCLFE9+IEr/6cXPPZ3qBT2oZrNqYH928QF/fnUf+GpfhqivAqYbeZ/eQlb00dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708066468; c=relaxed/simple;
	bh=FdrONz3jqnEbBJVqtq1ykjLmdW7prwTBxhfQ4GglgTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWBpmtIIxdiIOtjzH7YLhFmZD3C57Z9YVbBCfbOtzoFspgztEaj/DM5LM4vVKG3FTJ63aAKQLjizYQ3keu2ci3jYFYkVzGhEh8cobcadVM3Ur9UQ4ZkvS3GgnIluMWyYSFP17RG03FXcgcL4t0cApKnyQxSZExovr4fWPX6yRp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJqCV8/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BF0C43390;
	Fri, 16 Feb 2024 06:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708066468;
	bh=FdrONz3jqnEbBJVqtq1ykjLmdW7prwTBxhfQ4GglgTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CJqCV8/yNzOiPeXngxMZCidOZ2fEeSBe7MNvGGeKcUAZcvCE9A7SQK+hJG4s9kfjw
	 vXE2Uu77p1raT/HW+nbRV6hkej2H7N6zAg/8ZrC4Sr5o0SmceBZC+XJ46r7StE3KEl
	 o6x6NeyQnKKBz3pCA/p8VXxhY0h1NeMQaSCF+EAbouvlthpTMewOWOvJSyKRJn/Eor
	 typPJkEulN5DS6e3TeD/PgzkF0HgWDVUMwZSgSrCVIGg022tGWmbxmLsDqTzuD2rMb
	 ATAlZwiezvB5qOdZivlJWHAyhb570/hY1KpCUnYsvGhb6ZgQFNCww1uqIAhtzN2ko9
	 BJG76DnQun4/Q==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: jani.nikula@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH 18/21] drm/i915: remove intel_gvt_irq::pending_events
Date: Fri, 16 Feb 2024 07:53:23 +0100
Message-ID: <20240216065326.6910-19-jirislaby@kernel.org>
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

intel_gvt_irq::pending_events was never used since its addition in
commit c8fe6a6811a7 (drm/i915/gvt: vGPU interrupt virtualization.).
Drop it.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/i915/gvt/interrupt.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/interrupt.h b/drivers/gpu/drm/i915/gvt/interrupt.h
index b1fd6ed4e34a..cd214be98668 100644
--- a/drivers/gpu/drm/i915/gvt/interrupt.h
+++ b/drivers/gpu/drm/i915/gvt/interrupt.h
@@ -187,7 +187,6 @@ struct intel_gvt_irq {
 	struct intel_gvt_irq_info *info[INTEL_GVT_IRQ_INFO_MAX];
 	DECLARE_BITMAP(irq_info_bitmap, INTEL_GVT_IRQ_INFO_MAX);
 	struct intel_gvt_event_info events[INTEL_GVT_EVENT_MAX];
-	DECLARE_BITMAP(pending_events, INTEL_GVT_EVENT_MAX);
 	struct intel_gvt_irq_map *irq_map;
 };
 
-- 
2.43.1


