Return-Path: <linux-kernel+bounces-68135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6225185764C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FAC31C226CA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DFB210ED;
	Fri, 16 Feb 2024 06:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkCk/EdX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C01B20DE5
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 06:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708066479; cv=none; b=Y4LRoUpVV1/BxCuDUWKr1xgsAj6ZCw2ZqSnHq1ynblpyocPcSFDdSXDJQi1quGank10wgNAD7GoJ2vDlYk7Kkb6K2Xn8jz+u+xf74ecxnT22u8KcGbJae6HZdwHNw8uI1VuxliVOV5E7PWG8vJNwyrpyr5pNZ8G5UTtGcWDo2tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708066479; c=relaxed/simple;
	bh=Jq2+MsKda76OUscmqQ543pe72ImY+6RM/tfDpkyIMK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cupkLw8ETIeRO/s01IZODzDHVc8lCCMBaLRmJHgmhwObW+muDKO4SZ2YqFdBGO+vPoIxb45aPkdvSRHiMj1ZAfWG0KR8HwX6hxdyQe6rEp5mgIvLdaAIbqB5jMYr181Hv3HPZBKSF6CYo7+8VpwYfzEH+pzwOSKQx+atyPdjZ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkCk/EdX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57635C433F1;
	Fri, 16 Feb 2024 06:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708066479;
	bh=Jq2+MsKda76OUscmqQ543pe72ImY+6RM/tfDpkyIMK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KkCk/EdXUalSl8XNMQmbSKUjLRJjlybaY/6DisldmRz2BqNd/KYBYSArzer+GxFYD
	 gNFrHIYOIOhy6Gut4k1WJb7w0/8JVT8GsaoTmyF2Whf7YgHTxpsDuamgEwPaiEWNYj
	 pfpbk5AF/DejlPXJWyYzgw+lt0kqZkb1gIhAx2Kp+CBF7wmSLZbSAnmAMyqcdHhHRy
	 QK5Fwg0R+6vuD/uj+IoEvpJ9ZdsO/MRaUmNVQ63cE1V6O43+DQ7/93WqbppPszqVdf
	 +PQbtvX9kacjomPPNYXau7JpYJ03BnzzfaZSVg4tP9sf4UyIbmOWn50SFraGbN8aXQ
	 D5KLtC6WYJ4Aw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: jani.nikula@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH 21/21] drm/i915: remove intel_memory_region_ops::flags
Date: Fri, 16 Feb 2024 07:53:26 +0100
Message-ID: <20240216065326.6910-22-jirislaby@kernel.org>
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

intel_memory_region_ops::flags was never used since its addition in
commit 232a6ebae419 (drm/i915: introduce intel_memory_region). Drop it.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org
---
 drivers/gpu/drm/i915/intel_memory_region.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_memory_region.h b/drivers/gpu/drm/i915/intel_memory_region.h
index 40810cfb3fd9..8c927e303c4a 100644
--- a/drivers/gpu/drm/i915/intel_memory_region.h
+++ b/drivers/gpu/drm/i915/intel_memory_region.h
@@ -50,8 +50,6 @@ enum intel_region_id {
 		for_each_if((mr) = (i915)->mm.regions[id])
 
 struct intel_memory_region_ops {
-	unsigned int flags;
-
 	int (*init)(struct intel_memory_region *mem);
 	int (*release)(struct intel_memory_region *mem);
 
-- 
2.43.1


