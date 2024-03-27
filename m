Return-Path: <linux-kernel+bounces-121520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E5888EB57
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03E17B28C46
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B805148826;
	Wed, 27 Mar 2024 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NT6qT5nz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8301487F4;
	Wed, 27 Mar 2024 15:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553108; cv=none; b=gOf6YO7gZu3JbojO9EIwOzMVobbiPFtxO7D9qUdugDboH2TwgsRJ9FvwnrLpvCFlZ79InJEJNVTXDVpsZlGkRNZ+0YIWXGC2f74i15Zk3PGXu1BABdmbdoSQFLconR/SBLRqTOD2G9WLYopWurlTtqSRbRaeRp3FOmibEBMCrlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553108; c=relaxed/simple;
	bh=u2jcYbqW/2iYrBZ8+bFOWIsxfZaEDXIGPQlM3mcmYrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DVqrXGC3ndnZbXS2iMicYZ2FxS+Fv/ZSqd5SiDcV2OcegaaCBaYsyHCLblQ1WdXuGV7HtJIUORBhJaMrEOxNzb660EeeDUbc869wGmCpmmzec0pJAtBBcjAU/LH8Ci8cyRUv6xWoPlUF9oPKcn1DrM+W4v3Wkol2uxUloye0r34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NT6qT5nz; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711553107; x=1743089107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u2jcYbqW/2iYrBZ8+bFOWIsxfZaEDXIGPQlM3mcmYrQ=;
  b=NT6qT5nzGAJ0aH98hZvssDYzrCax5DDXTN6IN37AZhCIrbG7gaZftUhX
   s3gOWw8ySGpVP+/fF+dlmrlSgrUf0VyLaqJzUr1aJZYm1ChRns3D2UUG3
   NhvIXi3xMOLnDcN4lrPznze4sigXznwOd3o4vz5MzhDq5npVK7QDvhQVw
   SrRaRIR1C95pz0KC9bahCktV2mN7z1OlqyEEHUmgvIYK5D0xpjPt/gfxv
   byEN4ET1ZUmLpatzGQsGgJL6RHO7EFyQ20YPrtHMlsYJgUMNopjoX/VZJ
   o/vgky6kVdx49xgf+Il8AkuHZqSCYiFkQad0GEPn1NaDZjKGjd17xyBqG
   g==;
X-CSE-ConnectionGUID: Z9+Yrhv6RdOixjC4Dc5MtA==
X-CSE-MsgGUID: CmFDSyLqQdKw0MgZWkkHfw==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6518198"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="6518198"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 08:25:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16414246"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa008.fm.intel.com with ESMTP; 27 Mar 2024 08:25:04 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Yury Norov <yury.norov@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH net-next v6 10/21] btrfs: rename bitmap_set_bits() -> btrfs_bitmap_set_bits()
Date: Wed, 27 Mar 2024 16:23:47 +0100
Message-ID: <20240327152358.2368467-11-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327152358.2368467-1-aleksander.lobakin@intel.com>
References: <20240327152358.2368467-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bitmap_set_bits() does not start with the FS' prefix and may collide
with a new generic helper one day. It operates with the FS-specific
types, so there's no change those two could do the same thing.
Just add the prefix to exclude such possible conflict.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Acked-by: David Sterba <dsterba@suse.com>
Reviewed-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 fs/btrfs/free-space-cache.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index c8a05d5eb9cb..3ab8dea5036b 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1911,9 +1911,9 @@ static inline void bitmap_clear_bits(struct btrfs_free_space_ctl *ctl,
 		ctl->free_space -= bytes;
 }
 
-static void bitmap_set_bits(struct btrfs_free_space_ctl *ctl,
-			    struct btrfs_free_space *info, u64 offset,
-			    u64 bytes)
+static void btrfs_bitmap_set_bits(struct btrfs_free_space_ctl *ctl,
+				  struct btrfs_free_space *info, u64 offset,
+				  u64 bytes)
 {
 	unsigned long start, count, end;
 	int extent_delta = 1;
@@ -2249,7 +2249,7 @@ static u64 add_bytes_to_bitmap(struct btrfs_free_space_ctl *ctl,
 
 	bytes_to_set = min(end - offset, bytes);
 
-	bitmap_set_bits(ctl, info, offset, bytes_to_set);
+	btrfs_bitmap_set_bits(ctl, info, offset, bytes_to_set);
 
 	return bytes_to_set;
 
-- 
2.44.0


