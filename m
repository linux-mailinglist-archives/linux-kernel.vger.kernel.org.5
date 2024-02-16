Return-Path: <linux-kernel+bounces-68124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A41DD857641
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FDB5281AAE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426111C6B7;
	Fri, 16 Feb 2024 06:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDyJ4V/b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8132B1C69F
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 06:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708066443; cv=none; b=F7Ff8jtqG7+bcKetFBJGSBbSEKpEuXF+55zQ+8+0NGnIqV4VQ/xCDXP1WCew52KbiJUTdBlYj2iJsIdksctdXdbnzzCjhdhzjRPzPD7YdYjeEjmpg9jguMaz6UTgVliWHiO0RjXBlLWpoafo+c/DNLVSKE6sWNgzvxHoeaRbxWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708066443; c=relaxed/simple;
	bh=YgYjxfvUqDqcc0kdOcmV9/pe6rLivB5Hnys3gp0apvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f9eNsRpCdj+VNLAka7dtz1KKC6Wf/9ECCzdZVc6pK6QOHGVKG6NN988DSnFFLa7CENvgosTRi8Dbg74v+qUWNqM+N8yYvwxCZ125FS/47HqIHk8MEXdHDRFwQlX4HzFKuT8lILrcy7Kr9TRRjs6IW10bp02rPknJvD23wtK+IGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDyJ4V/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1EE4C433C7;
	Fri, 16 Feb 2024 06:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708066443;
	bh=YgYjxfvUqDqcc0kdOcmV9/pe6rLivB5Hnys3gp0apvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aDyJ4V/bLN4EkcMd8v47X1GZjrkbl4ceRUkFCXyjR/WHxHtMAmW8xc4cPK1n/BSCo
	 fIqVQrxaOyozPq9h7b1vzKQQNuzbvdTG/id6nXhT1vKErrtpsVvEKjYXDbf6VDNn59
	 OUGefLN2cjl1iN4ua9iqNJRgS3HobVWSRtRjrptOwzu+x2vuqmy1q/GRh4Atk9NWv0
	 k0/BprtQj2kLdq/6ZlLApcfoUL2yO296nyzeV6sh0ZxRc2fU3sFg9MdVcjeO7zZFxt
	 HVsj9AYDjTopKUxsbUHn34LtHeJkLAN2t1F7Gd0sF09/b6MfOPH0WrZPdJ7QxTRiqr
	 1rLk1LQoXhfbg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: jani.nikula@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH 10/21] drm/i915: remove i915_perf_stream::size_exponent
Date: Fri, 16 Feb 2024 07:53:15 +0100
Message-ID: <20240216065326.6910-11-jirislaby@kernel.org>
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

i915_perf_stream::size_exponent was never used since its addition in
commit a37f08a882b0 (drm/i915/perf: Refactor oa object to better manage
resources). Drop it.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/i915/i915_perf_types.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_perf_types.h b/drivers/gpu/drm/i915/i915_perf_types.h
index 46445248d193..39fb6ce4a7ef 100644
--- a/drivers/gpu/drm/i915/i915_perf_types.h
+++ b/drivers/gpu/drm/i915/i915_perf_types.h
@@ -288,7 +288,6 @@ struct i915_perf_stream {
 		struct i915_vma *vma;
 		u8 *vaddr;
 		u32 last_ctx_id;
-		int size_exponent;
 
 		/**
 		 * @oa_buffer.ptr_lock: Locks reads and writes to all
-- 
2.43.1


