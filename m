Return-Path: <linux-kernel+bounces-30030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4E5831827
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEF681C22EE4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A69424A16;
	Thu, 18 Jan 2024 11:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="chmEHK/p"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C906C2377B;
	Thu, 18 Jan 2024 11:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705576234; cv=none; b=cYTi6FQhBsgpBaB6W87yu1X69f9VAR/kBDV7ikCDFuEpCh/7mazWGvIcxQ29jyHpfRHaBMVw07W9rPbc94PXeJPgdua26F0y66efygU8nr1ojXR6rKByF/R1+uTGsbM09VpB7BI/n+LCcrO/WzWxZ1sfFattfqSBieTgXfEAw/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705576234; c=relaxed/simple;
	bh=+Xu20dORa8ppOptEVErsUmVHtjvUkyabhTNmd/IQJPs=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding; b=ZNHKcE2XPxfNH0Z49wegtcmnhMdPBmXQ9e3i4MA+U9piFhJP3Wr/SipEumaYzWPlHYlRy4R0X1aZWcM+6bi4g6HjFdEN/TH9s38fnUsnfJPfnDuBConT6VDcfECMiR8vu5QUEjY5gpLAJT2HSoWJ1Swprc5Q50mpbotpSYWEPSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=chmEHK/p; arc=none smtp.client-ip=192.55.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705576229; x=1737112229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+Xu20dORa8ppOptEVErsUmVHtjvUkyabhTNmd/IQJPs=;
  b=chmEHK/paJyYJw6lqAnZ8kJ854ofM7eUynxjBMTl8vOzCYNKgGzzyba+
   KrRsRGWmAtjbCkUrfsBdVcBxbJYxOfovdW6deBsqsR2KxfmEvBoiE8yKT
   1Bd6mHG24IKyAtHUjRU2ZhWq7q7Z/VkrsyLrpqlO0XOTAjV+vglqLSgUf
   CYcZC9NztUEUc3aRMpHq4RyzK2y6bdO8UEKt4GfCepzCU/53iYdoAEx2J
   lvZGGNQrkPanYXYYuLi9Qd2PfkN8bpjevotcoPoNO0Ah4MvptBNP7aTx/
   DHIgNRVyZU7dwrBYOOppvj997A0F4Z86PnW0Biv2yNcXXGsYnrjZMPZQ0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="486571176"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="486571176"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 03:10:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="262419"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmviesa003.fm.intel.com with ESMTP; 18 Jan 2024 03:10:27 -0800
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
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH net v5 1/4] dpll: fix broken error path in dpll_pin_alloc(..)
Date: Thu, 18 Jan 2024 12:07:16 +0100
Message-Id: <20240118110719.567117-2-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240118110719.567117-1-arkadiusz.kubalewski@intel.com>
References: <20240118110719.567117-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If pin type is not expected, or dpll_pin_prop_dup(..) failed to
allocate memory, the unwind error path shall not destroy pin's xarrays,
which were not yet initialized.
Add new goto label and use it to fix broken error path.

Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
v5:
- make this patch first in the series, previously was fourth

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


