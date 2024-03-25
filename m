Return-Path: <linux-kernel+bounces-117438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1125788AB6A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B27B41F63B70
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B5B6F505;
	Mon, 25 Mar 2024 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UY2GvH7i"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9913DABFF;
	Mon, 25 Mar 2024 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382819; cv=none; b=OksTsQmDBMZ3feWpBrPV6mpZ+8KU2GQ2xDcZMLvMdGWAuMvtJ9KSvSPAVhJuz9KlWKuy5dl9lrqitobUgTM3YAg2ATeruwn31fj9oQXsn4Q/7+1ayPknBiJIxM19kFmSbtNluuIHOjHP1CKhvZmIiWOqzlBnoO+rjds4Y752VKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382819; c=relaxed/simple;
	bh=IZh/2COuzN7LI3CUVc2tFyndfcbuRuvwsPNrBw6vFxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jw5Swl3PJn+vQR/eidD/TFcLEzUYIOZDBjMUvtnpVxC6D3fz2VuUnJUDfpdPA+INnljPk+LGm5l7GXACVfmzW+8/AgMJ/4O9JUS2WoqHtAXEw0EZxkjOkAYbvAy/S7C5yfGgrg/OKdC+uzvtzU6ppBJltCNZXCdNIY8GAjY2y0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UY2GvH7i; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711382818; x=1742918818;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IZh/2COuzN7LI3CUVc2tFyndfcbuRuvwsPNrBw6vFxg=;
  b=UY2GvH7iZuqPsjASOSTIGsIYLkEiYHsrTEzdvMzd7cUEi8Nd8oPnofJZ
   gratkRr/vFcAbeWavvQ2KlIxhj2Vf8uW3nckOdtnWthVi6pKh+jfFHFYG
   lBlFBetUiV+bYzMQ+8B0d9UNZJM5pBRTigIu+MfnbZu61cEEfIx93eQ9H
   ukKhQXQ7cvS8HUf+HPKWGkRNespFhxXezgJt7STZYCefyFJpZBfMMdvCZ
   mWFaXMC5CutmtXYn5lrdMvzVcM6f6LGSXYgjvEVXQmRu8Nxp3IsSJ7y3V
   hAHuPlyZ6PKfeZmKJ0mARpUpO71p2Qg2x56OHHTXs4tq0kiwYWr78kk5T
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="17789590"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="17789590"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 09:06:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="15563795"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa010.fm.intel.com with ESMTP; 25 Mar 2024 09:06:51 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: pin system percpu page_pools to the corresponding NUMA nodes
Date: Mon, 25 Mar 2024 17:06:35 +0100
Message-ID: <20240325160635.3215855-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

System page_pools are percpu and one instance can be used only on
one CPU.
%NUMA_NO_NODE is fine for allocating pages, as the PP core always
allocates local pages in this case. But for the struct &page_pool
itself, this node ID means they are allocated on the boot CPU,
which may belong to a different node than the target CPU.
Pin system page_pools to the corresponding nodes when creating,
so that all the allocated data will always be local. Use
cpu_to_mem() to account memless nodes.
Nodes != 0 win some Kpps when testing with xdp-trafficgen.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 9a67003e49db..fefa484d715a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11712,7 +11712,7 @@ static int net_page_pool_create(int cpuid)
 	struct page_pool_params page_pool_params = {
 		.pool_size = SYSTEM_PERCPU_PAGE_POOL_SIZE,
 		.flags = PP_FLAG_SYSTEM_POOL,
-		.nid = NUMA_NO_NODE,
+		.nid = cpu_to_mem(cpuid),
 	};
 	struct page_pool *pp_ptr;
 
-- 
2.44.0


