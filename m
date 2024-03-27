Return-Path: <linux-kernel+bounces-121420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CB688E7BC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFAE21F33192
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045A01448FF;
	Wed, 27 Mar 2024 14:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ANEgTDwh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E4414534B;
	Wed, 27 Mar 2024 14:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711549400; cv=none; b=B8GIger6evFIbheYWTacrdYwAgRhJco54JJP48Mre1L/DHrXd5i4I3u4Gu0n0HXpdz4kCuY3ZEdxDyp2gIpevzPsctiAxaWt0yKtXnAsJFL4xB2aQrWA0yN/tTVBSod0W8LN0wmWe0GKB8C+yvyf5nNllR2viMGWwMmdsiltZRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711549400; c=relaxed/simple;
	bh=XdOmxjY9WLGSoqpYiIHq0/c596ZAW41172TmKdUdESs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SpLCZBBrC0sQwANKrEK6Z5mLdmi5cj/xeBNbvGM82cBe6+RSqLOIY8NSHgvRkzRWvJSOsrcG8Sab6RdMFUkwtgJ4vtuITM3F1XjWP+qzvBddwcLpizDMap2+mNCrCNY0SmdtIpZHOQ7nFLiTCNPpI3rjF/G5hCQ+gIir9//taf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ANEgTDwh; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711549398; x=1743085398;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XdOmxjY9WLGSoqpYiIHq0/c596ZAW41172TmKdUdESs=;
  b=ANEgTDwhokGR1OsU4S+Ipk+Ur82p9wzkCRU6AReX5yqaSq0syqsgWbc9
   ZBgWkvMoV8S6pMpmDF/R0KinSJ1jJP/4BTXpLwjMSjFs6FksnSAcpof5O
   pXKwa19xD9LagjuwauPmZ7EyRLT8awlsR3xihB5EK4yDLmdQCyEsBLw2s
   tZz8iL0MCT721TzWVO78StlOrxCZAknc7U9XRyZ9p6vpK78H1nF4IpvTu
   pkEqiXjyDbQWMaWSd4XqFQDrf9zHfm4K90MvgBb3WL50ScqAB0Ar3mj9s
   hzN4Dh72fToV3uoulLK3+rtL1lJ6IILh+PhJlWJ92Jx5AYReZFnxHkJeX
   Q==;
X-CSE-ConnectionGUID: SJg2sOf0SvG7Rsim+aMy2g==
X-CSE-MsgGUID: rvJ86yzgS6enKgJB3bixmg==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6592540"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="6592540"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 07:23:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="20973081"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa004.fm.intel.com with ESMTP; 27 Mar 2024 07:23:16 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Simon Horman <horms@kernel.org>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/3] idpf: make virtchnl2.h self-contained
Date: Wed, 27 Mar 2024 15:22:40 +0100
Message-ID: <20240327142241.1745989-3-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327142241.1745989-1-aleksander.lobakin@intel.com>
References: <20240327142241.1745989-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To ease maintaining of virtchnl2.h, which already is messy enough,
make it self-contained by adding missing if_ether.h include due to
%ETH_ALEN usage.
At the same time, virtchnl2_lan_desc.h is not used anywhere in the
file, so move this include to idpf_txrx.h to speed up C preprocessing.

Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h | 2 ++
 drivers/net/ethernet/intel/idpf/virtchnl2.h | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index df76493faa75..3d046b81e507 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -8,6 +8,8 @@
 #include <net/tcp.h>
 #include <net/netdev_queues.h>
 
+#include "virtchnl2_lan_desc.h"
+
 #define IDPF_LARGE_MAX_Q			256
 #define IDPF_MAX_Q				16
 #define IDPF_MIN_Q				2
diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/drivers/net/ethernet/intel/idpf/virtchnl2.h
index 4a3c4454d25a..29419211b3d9 100644
--- a/drivers/net/ethernet/intel/idpf/virtchnl2.h
+++ b/drivers/net/ethernet/intel/idpf/virtchnl2.h
@@ -4,6 +4,8 @@
 #ifndef _VIRTCHNL2_H_
 #define _VIRTCHNL2_H_
 
+#include <linux/if_ether.h>
+
 /* All opcodes associated with virtchnl2 are prefixed with virtchnl2 or
  * VIRTCHNL2. Any future opcodes, offloads/capabilities, structures,
  * and defines must be prefixed with virtchnl2 or VIRTCHNL2 to avoid confusion.
@@ -17,8 +19,6 @@
  * must remain unchanged over time, so we specify explicit values for all enums.
  */
 
-#include "virtchnl2_lan_desc.h"
-
 /* This macro is used to generate compilation errors if a structure
  * is not exactly the correct length.
  */
-- 
2.44.0


