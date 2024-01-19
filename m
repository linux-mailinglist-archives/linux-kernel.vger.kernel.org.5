Return-Path: <linux-kernel+bounces-31216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61112832AB4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 940A31C241DB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F4053818;
	Fri, 19 Jan 2024 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YLHRE/Q2"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A44952F97;
	Fri, 19 Jan 2024 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705671977; cv=none; b=KM6Ixt2u+ffkELMHLj7BD6AImQbISsmY0c+qZu5SLo41yAUd8zItAgkf8+1qGz4R4XbWqnVbvMcrkOuu69w5FjIqDxpwqBk1KQto1m3CxIE9lm791ElFIGwXS6/A9baGqPFi3DZFBajIfK6bWjoty2gCLBFAWjIR+9JGs+Skvzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705671977; c=relaxed/simple;
	bh=tRIwU7gwsDz+zqq2CsA81lk0Upeoqq9BY6wWzJVRuqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eqoy37I9yBMTuDrJ2X16c8GuO8aSVDIEs7Lu93JIrauNwzckkbr/eR71R89UWImyqrceD6LoYjoCRqYkmjyUnid6jIONTRgQk30oJ57HHsAqSXqdOAuWrQabQW9uVX4e/6r2vXpUCYLiRFqKxWIa2dhvuNzbAUOA7LHWNz3UDvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YLHRE/Q2; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705671976; x=1737207976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tRIwU7gwsDz+zqq2CsA81lk0Upeoqq9BY6wWzJVRuqU=;
  b=YLHRE/Q2MMv7Xh0M04+hwbOiozvm2CqBJq72FO+Q7wxX5zIFUF6w2SrB
   Ci/dx485PupGamu7ZtEY3YDDaLzEhPO5PHOEkdrvNdZVLELBsdjdqo0rm
   3GN2oPVXRwkmI4bEiIuz6moINXZ7YhTgR0D97PE6U64lR+ngLD6nUpBO9
   p/FOBzKnRszkuDkCgnrXq9Dskwcu0XipjPAbu/OOUeNTJtuF/mjvtMRoa
   1EVRD/GT8qqxml+zuVjX1s7aBVCn2QzBCxAcAyZ/NYg2b5udqdEhmDTBV
   dP6M5jirbmcmbGHwI83TorJ5j0vRHF+xjsFASV1njQRuq1jeRCTQg8Lz/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="465026897"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="465026897"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 05:46:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="788360387"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="788360387"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmsmga007.fm.intel.com with ESMTP; 19 Jan 2024 05:46:13 -0800
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: netdev@vger.kernel.org
Cc: vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	davem@davemloft.net,
	milena.olech@intel.com,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	mschmidt@redhat.com,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net v6 1/4] dpll: fix broken error path in dpll_pin_alloc(..)
Date: Fri, 19 Jan 2024 14:43:01 +0100
Message-Id: <20240119134304.576956-2-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240119134304.576956-1-arkadiusz.kubalewski@intel.com>
References: <20240119134304.576956-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If pin type is not expected, or pin properities failed to allocate
memory, the unwind error path shall not destroy pin's xarrays, which
were not yet initialized.
Add new goto label and use it to fix broken error path.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
v6:
- no changes, bump the series version

 drivers/dpll/dpll_core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 1eca8cc271f8..c08772ee9fd6 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -441,7 +441,7 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
 	if (WARN_ON(prop->type < DPLL_PIN_TYPE_MUX ||
 		    prop->type > DPLL_PIN_TYPE_MAX)) {
 		ret = -EINVAL;
-		goto err;
+		goto err_pin_prop;
 	}
 	pin->prop = prop;
 	refcount_set(&pin->refcount, 1);
@@ -450,11 +450,12 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
 	ret = xa_alloc_cyclic(&dpll_pin_xa, &pin->id, pin, xa_limit_32b,
 			      &dpll_pin_xa_id, GFP_KERNEL);
 	if (ret)
-		goto err;
+		goto err_xa_alloc;
 	return pin;
-err:
+err_xa_alloc:
 	xa_destroy(&pin->dpll_refs);
 	xa_destroy(&pin->parent_refs);
+err_pin_prop:
 	kfree(pin);
 	return ERR_PTR(ret);
 }
-- 
2.38.1


