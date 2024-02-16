Return-Path: <linux-kernel+bounces-68123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8CA857640
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2CE2B24172
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1171C2AD;
	Fri, 16 Feb 2024 06:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYhfAahz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71F01C28B
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 06:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708066440; cv=none; b=NAsRdqtplkf9LKmx0ET1zsZVr7KRQRVmdP1PscthTm4tAx1Z0scXr49FOfl9At7u5yEadGKTRlporuMxia57d36ECVPGMO7wD5/65xk/7bHhbVs0+lWOlCqRcH1RcroU0JOngfrx5bL/a9THe2j1+rZoQDZkAk2/zAA9aoATvl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708066440; c=relaxed/simple;
	bh=e3JLcK2Zorv6NzoLDXNqOtoctfvRfUkVpj0zHb6Uma0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SbCTRT0gVoy9PlE68Rlj+hSGE2FBkCfpCg2OtSCv3+chZV75yIi+pPZbRLvYI3FYK+GJDGkwYUf3bKD3972TzCKx3bHzW1F+KALx71OgJLQWQAIQg50u4/e+4gzzTeUPvA6lBSAO++deNL0QuoWzha58xaoLQg9ytvFD93khjxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYhfAahz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873C8C43390;
	Fri, 16 Feb 2024 06:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708066440;
	bh=e3JLcK2Zorv6NzoLDXNqOtoctfvRfUkVpj0zHb6Uma0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MYhfAahznJHHc68nDGRIoxA2wQ6gIDbhrKn+7x4NtBDivZwEl1JX6AcMoyyufiVcp
	 AXtdHNVVfwW/c7PEUNYyy3OCjLq/uonp9U+Y5zx0v0R7H3b9QyFhKfKrjVfw25bgNC
	 vRDgrr78LIDkkkqOTS9LV4DbW0LllabFa+IrTGrx0n8P7YMuvQl6LCCNjFzMtIQMrF
	 YnIFg25kvKFlZndJGBmmcJFm6ayZIWAIem3QMmRN0ydO0++zMkRbFz0xQYkXQ1B+5F
	 JINaZHCT7vopkXJvrkhhRO/ejiy/1W9JMmUTK0JGKwJfalNn7vExyRzv9vnzl7Ft8T
	 PrrAqqQz2GcAw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: jani.nikula@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH 09/21] drm/i915: remove i915_drm_client::id
Date: Fri, 16 Feb 2024 07:53:14 +0100
Message-ID: <20240216065326.6910-10-jirislaby@kernel.org>
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

i915_drm_client::id is not used since commit e894b724c316 (drm/i915:
Use the fdinfo helper). Drop it.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/i915/i915_drm_client.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_drm_client.h b/drivers/gpu/drm/i915/i915_drm_client.h
index a439dd789936..2e7a50d16a88 100644
--- a/drivers/gpu/drm/i915/i915_drm_client.h
+++ b/drivers/gpu/drm/i915/i915_drm_client.h
@@ -24,8 +24,6 @@ struct drm_printer;
 struct i915_drm_client {
 	struct kref kref;
 
-	unsigned int id;
-
 	spinlock_t ctx_lock; /* For add/remove from ctx_list. */
 	struct list_head ctx_list; /* List of contexts belonging to client. */
 
-- 
2.43.1


