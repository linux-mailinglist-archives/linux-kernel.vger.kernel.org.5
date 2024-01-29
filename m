Return-Path: <linux-kernel+bounces-42226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B60883FE3A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18888284AE9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF094F1F7;
	Mon, 29 Jan 2024 06:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HQFw8mmp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E34D4C626;
	Mon, 29 Jan 2024 06:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706509294; cv=none; b=b/YxWXqPTv9y1FkMZIBHmzjjmHubIKyjZSbGX8YhWYxU50Z9UWHAS7RDCU6Nkkci3X+1k5Cm8+yzexGsseZ9szIXNSCX3gu6aFgCxO6wSSVPGTImNHZgv1zzi+YFWWdayRS4YPu71iXGEUQeh5Kqd0x19nNU7H6H1oEpHG5qHSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706509294; c=relaxed/simple;
	bh=9LXmX5XyuFdYLtJO0yMfI03WjB1o2At8qEtstHT9ETI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=oeD+LLqvZz9h42fWMRxrRSVQO4vi60LFTIbrWz7AnIpxvK1MAMjcv6+YNwdiDBxHnc6PEuMJkTeFRoOaH25zLFmLBae9NZHjJ9CRZEcWHy8T3PUF/2XAaOx+vLB1vGigzp2QEvQRhkOpdMfbbHWfjFQvN72TUTzJCiDjDRWmk9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HQFw8mmp; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706509292; x=1738045292;
  h=from:to:cc:subject:date:message-id;
  bh=9LXmX5XyuFdYLtJO0yMfI03WjB1o2At8qEtstHT9ETI=;
  b=HQFw8mmpFG/vgn2nTFzPuRIOOO2iJ65A/szVRLChO+Amn3sYgIEl3xFM
   m+4ynwuZE6EkCsYXXjVvJHO7bEF9n3Bm94sDwOC7XBgIJGSzz4Jwl8YI/
   vNs8InG3Gum0BuHri2fwz0X8oLKS3SMOZDY5SiZu2XMQNFdrn/YsljgL9
   rDWxgqTM1EE4uX3rbC18upjKLhe8DTcjo+V6fIBUwhzNwSNv7NsHfllKz
   Cv8yTXlygHWTQKizRKE8fjym4kdxbsuQs2YXSHCA3/Zoe3L9akRNWXufz
   3txF46XU4LhAC4hQ9vOCsgfXFGwWEOyOp8z+JXqK2aSL2jY1UYwsP4ZJY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="16219109"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="16219109"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 22:21:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="3270551"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 22:21:28 -0800
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: Tony Luck <tony.luck@intel.com>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Aristeu Rozanski <aris@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lili.li@intel.com,
	ricardo.neri-calderon@linux.intel.com
Subject: [PATCH 0/2] EDAC/{igen6,i10nm}: Add EDAC support for two Intel CPUs
Date: Mon, 29 Jan 2024 14:20:38 +0800
Message-Id: <20240129062040.60809-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Both patches solely add CPU IDs for EDAC support.

- Part1: Add a new Alder Lake-N SoC compute die ID for EDAC support.
- Part2: Add the Grand Ridge (micro-server) CPU model ID for EDAC support.

Lili Li (1):
  EDAC/igen6: Add one more Intel Alder Lake-N SoC support

Qiuxu Zhuo (1):
  EDAC/i10nm: Add Intel Grand Ridge micro-server support

 drivers/edac/i10nm_base.c | 1 +
 drivers/edac/igen6_edac.c | 2 ++
 2 files changed, 3 insertions(+)


base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
2.17.1


