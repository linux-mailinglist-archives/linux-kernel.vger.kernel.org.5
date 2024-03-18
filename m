Return-Path: <linux-kernel+bounces-106140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BA087E9C5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 772581F21F8A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724333BBEE;
	Mon, 18 Mar 2024 13:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AUIw+RRe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E547F38F96;
	Mon, 18 Mar 2024 13:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710767059; cv=none; b=ie8qTJoHA8ZvcFSAuMjEayb7ep0aP8nXH6+IvhLIXEPtbuOwUHiLNrcxAfgvHn+h4jDbDOtWPfP8zmGkLqCq4ifbva40WcZPrrnwvKo7trYWBW3ts1l0lUH5vNCnxW0OLTKuCQfhybMhr17b1By0VWSARBjmRNG3pWvGqHey8aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710767059; c=relaxed/simple;
	bh=ZRL03sPQx6c/A6XYa9UfTEt3fY76GaN/+XjCyG2UFFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJ4XhD5IRem/PjG3jtCthvT4Q6peA95gjnTMzUuETiSgEba/wQhdyvVc076+QYGBofyiecH+lAjieqh4cn+xdsTTD75gAd0KwPsksF99tZxRKeiNh7bYeALl/0xaqJZcnQ0le+1ePOi5yJ/QMVR43K0VDC9M+9MoaAHB0UrOgig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AUIw+RRe; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710767058; x=1742303058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZRL03sPQx6c/A6XYa9UfTEt3fY76GaN/+XjCyG2UFFo=;
  b=AUIw+RReOIXJ/LYUvdF3xvtJpQXiV1iJlfNoP1GUSLrLNKHMDE28okPC
   /aYonqCXPh9P9cqeoLzRDA+MMTWFDqo8EDWNAIHQ/3hAuTmpwp5jgZQo+
   JUrg2VrtLzQL3rnPXJ4cx4DrWs4gnbzDbnDRtDmBfq+mEpuBZkgoHYshi
   5po4LwBZ467H7HjpdNVzPq9El7TyknPz7UknfBj3NUUyFVBIfpVZNvcJH
   2w5BnOBknpL1mt0aSxBl7LJon1XaW1B+QiOztqm+TSu2DcEbntoMm1Ovr
   OvVgUjHZJbIrFWbJDt2Mzdl/u+K2U4jD6YhjJN/iC+i8c9+Y2AAPtQT4C
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="5707153"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5707153"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 06:04:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="44392883"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 18 Mar 2024 06:04:16 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: linux-hardening@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Marco Elver <elver@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC kspp-next 2/3] idpf: make virtchnl2.h self-contained
Date: Mon, 18 Mar 2024 14:03:53 +0100
Message-ID: <20240318130354.2713265-3-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318130354.2713265-1-aleksander.lobakin@intel.com>
References: <20240318130354.2713265-1-aleksander.lobakin@intel.com>
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
At the same time, virtchnl2_lan_desc.h is not anywhere in the file,
so remove this include to speed up preprocessing.

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


