Return-Path: <linux-kernel+bounces-119489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EBC88C99A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25A701C639EB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7AD1CFBB;
	Tue, 26 Mar 2024 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nGnNsKoD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A210B1BC39;
	Tue, 26 Mar 2024 16:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471323; cv=none; b=cc9aBjD4FHgkIUkb3RGlqQi1b23iE4sx851VjM6H249UlkcpMV9L0py7/vLjkMrQo6YPFsiO/VSnr1306nghwKHHdQBk0FcnE1lTwzhTbcGI2UI2Aa5Gjo2kpsYoPKXhc/2pVQMcmIGi5gHSEvGUR07pfAIsb7EfzgrsbMEwE7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471323; c=relaxed/simple;
	bh=Pg89mGTO5MXlxmpG09iTgv01udwZKDMGXu/rADrVlfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hLCmauw1fmPJn8epGcxmNAYziEQFnDbtfWf3RHMfZPs5JxcaT6sSeqLL8MDDEpEV+xpLipa6a7jTyaXcZSvHynVpQADiZ/ylfl0z50UwyRfpLpp2w9zTA3Xt25oY3VTdJ82RORP8tGEE4Rs7t9d/Y/bIHUhQjNIygPkIKd4p7gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nGnNsKoD; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711471322; x=1743007322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pg89mGTO5MXlxmpG09iTgv01udwZKDMGXu/rADrVlfY=;
  b=nGnNsKoDSjlryKZnYYwxnlAOtMTxmyCvZhvLOwKl9DZaDfang3v+y3Rm
   JhDe8s2lOU8UcbQmyfz1Iz6JITV+aM+vvl6DR6pjvRa10OjKqrayC3iRc
   LkMGwUq6s7r96BUpeajRj0yFD3bFJ6hGGaGf7eVMNjsxLJg7Ll5SkJgbr
   5SZPiv86j0WfdR+63ENnP7M3Sj3pUcy/NP+DVv8x1pVFpe20vWwaUVETm
   Cj53fV+PpdPDDpgpWhdYLxpf5qRt4li8/WkTO9GbtaLoMLv4Eh364I04I
   ZAqavNfYzT1eGCJp0En9lAV+UgCEednuuhSjY32wYAkKIIRFl3aGIV6fz
   w==;
X-CSE-ConnectionGUID: 8K3plxiTRweMUtUK36vQvg==
X-CSE-MsgGUID: RtcEJurERZKTxRrGuUN0/Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="24023324"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="24023324"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 09:41:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="20667400"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa003.jf.intel.com with ESMTP; 26 Mar 2024 09:41:49 -0700
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
Subject: [PATCH net-next 2/3] idpf: make virtchnl2.h self-contained
Date: Tue, 26 Mar 2024 17:41:15 +0100
Message-ID: <20240326164116.645718-3-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326164116.645718-1-aleksander.lobakin@intel.com>
References: <20240326164116.645718-1-aleksander.lobakin@intel.com>
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
file, so remove this include to speed up C preprocessing.

Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/virtchnl2.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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


