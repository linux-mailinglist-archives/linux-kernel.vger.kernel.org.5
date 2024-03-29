Return-Path: <linux-kernel+bounces-125193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B8B8921F8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581751C24EFE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B117E108;
	Fri, 29 Mar 2024 16:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S2NyHfSc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AC3C120;
	Fri, 29 Mar 2024 16:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711731358; cv=none; b=hIeZMx//3Zh3n1R55J6wJxkPAtqFBjFuxNgskxZ0LIlrU+UY2nIkKgxP/aHw9tTXzpzwNEdE5ejR1MD960lJBcbOAl/AmzzJZE8NfLFzRBhWOaWfQUQQJXr+XCu9w8MS7m0EY/3Lrg5Lpn97byKCo28B9gBK+S64AYJVI2Y8nMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711731358; c=relaxed/simple;
	bh=RV3VRFSxY52XIFyp4YJivtHZiq5gbFXa9jWiDKfQaI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qWEPPCQAo6fGTapJQcdUynzztZwTT/81cQQhZ26wOt7JZCxMqiO8oDnIuHaXc/DtznH3Wgv2HilNXfuMxXe2QZed+k5c9ggNnK7PwSNM/C6sLXQf0+MuOMRLx8wlVDexCW/QEUrcDxJCgDjdr0jCeiL584cc1dXlvQ+wUYuWA4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S2NyHfSc; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711731356; x=1743267356;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RV3VRFSxY52XIFyp4YJivtHZiq5gbFXa9jWiDKfQaI4=;
  b=S2NyHfScMD9xphw4hOcvqzBYMn+nEyEm39mNMaIH/XHPW1XQVeNvEiOL
   v563e73Ljhd3GC/vO2/yiseEg6K8YLYDCOh2wBfB2FMxtVscI8q6zj2SH
   jHV8T81CPiU6kBSoC6zDrXoS5DSrMwlmvHQZKlK0hIxFLBAelIccde3hu
   d55vPzNLXkyFeg9PaHJjKTvCJSnkm3W8/n0dhhddpjCA72O8wqgYgv9ke
   7y5EYrl3CSkMfOM5626Z/TDm+Obup7vaJxA0vJN1l2Y/9w0o0WQe6giUV
   2YrAAcgsVrP3t4jmjsbYCUNXru3f/+kTLpTM65EbZvj4+h7Np+YCa0v/m
   Q==;
X-CSE-ConnectionGUID: ZvOZmYCPSRScSTzfAImb3w==
X-CSE-MsgGUID: PHL6ekUSQIKhsOdDXpE2Wg==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="18072461"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="18072461"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 09:55:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="17100373"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa008.fm.intel.com with ESMTP; 29 Mar 2024 09:55:53 -0700
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
Subject: [PATCH net-next 0/2] page_pool: allow direct bulk recycling
Date: Fri, 29 Mar 2024 17:55:05 +0100
Message-ID: <20240329165507.3240110-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, there was no reliable way to check whether it's safe to use
direct PP cache. The drivers were passing @allow_direct to the PP
recycling functions and that was it. Bulk recycling is used by
xdp_return_frame_bulk() on .ndo_xdp_xmit() frames completion where
the page origin is unknown, thus the direct recycling has never been
tried.
Now that we have at least 2 ways of checking if we're allowed to perform
direct recycling -- pool->p.napi (Jakub) and pool->cpuid (Lorenzo), we
can use them when doing bulk recycling as well. Just move that logic
from the skb core to the PP core and call it before
__page_pool_put_page() every time @allow_direct is false.
Under high .ndo_xdp_xmit() traffic load, the win is 2-3% Pps assuming
the sending driver uses xdp_return_frame_bulk() on Tx completion.

Alexander Lobakin (2):
  page_pool: check for PP direct cache locality later
  page_pool: try direct bulk recycling

 include/linux/skbuff.h | 12 ++++----
 net/core/page_pool.c   | 38 ++++++++++++++++++++---
 net/core/skbuff.c      | 70 +++++++++++++-----------------------------
 net/ipv4/esp4.c        |  2 +-
 net/ipv6/esp6.c        |  2 +-
 5 files changed, 63 insertions(+), 61 deletions(-)

-- 
2.44.0


