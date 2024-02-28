Return-Path: <linux-kernel+bounces-84250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B2686A42E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B7E71F2831E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10AA537E5;
	Wed, 28 Feb 2024 00:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XG6wMJGI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED0F1400D;
	Wed, 28 Feb 2024 00:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709078422; cv=none; b=rmN/zUD/V6A9X1fX+4zChA8cUwRPwIU8T9NUB6yrQ00+nZzOgYmbHqS1oKwjsP5U3UDOkg2xrTLJZaRLHZIaylAGMkuStm7E/YwZBuG7VK42hzPXboi0sWeJxBhkJjKkxn85aU9opMjbARIUQcRSUourQm90f4rAY6Yp/yBbry8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709078422; c=relaxed/simple;
	bh=iCjI+PJKNrX2ec8KuwZzO40AKoWqyEUBGXtTR4zNvjQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gV8Gl119IQpSRp+ERNM2VgyyzOz1wvTpi2WfHPWnXdvlgN4/uAB+gtMnz8bzd+4GQmTUJ8AVgmsibY2V6H/fxrdB7Lx3JPmmHzHtV47M+AS7XpzgbMx/rJ29eQDmrn0AdQkzhoPcS2l85a9e++A9hBwxL7Itw/T1B8Gx+jQ3oD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XG6wMJGI; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709078421; x=1740614421;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=iCjI+PJKNrX2ec8KuwZzO40AKoWqyEUBGXtTR4zNvjQ=;
  b=XG6wMJGIvaKwcqOdaipIYQ+pK0l9u9F4GV9JIDUFNVM7W+JmsLIw9Jsk
   70pOQ9M4Q1K31aETO2uOtcypFX34zslB3Jtvd2hak6+PdAz3sAWRneO2G
   LWWov3AMBRdPtkZdgcEULtBTN9aqP7m3zw4CagPEfb12lvn2YXHmfODOj
   iRql1jwA+xnIGNio8S9ch9apnZtoQkhyWGSHvYZyCylWvEvKuLADcS4C6
   IzlqIw1VbEVPAcr0IufJm9AUD6/Z7zju8fcaIb5xY93okVTvCLe0QjEsD
   iL66SKjc1ls19Dsa9N6UgpHhhmiXa4T/PfOQN4+rS4ZVnMB9lA4ZigoQi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="25919838"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="25919838"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 16:00:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="7439177"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 16:00:18 -0800
Received: from debox1-desk4.lan (unknown [10.251.6.149])
	by linux.intel.com (Postfix) with ESMTP id 9B989580B9A;
	Tue, 27 Feb 2024 16:00:17 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	rajvi.jingar@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH V2 7/9] tools/arch/x86/intel_sdsi: Fix meter_certificate decoding
Date: Tue, 27 Feb 2024 16:00:14 -0800
Message-Id: <20240228000016.1685518-8-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228000016.1685518-1-david.e.box@linux.intel.com>
References: <20240228000016.1685518-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix errors in the calculation of the start position of the counters and in
the display loop.

Fixes: aad129780bae ("platform/x86/intel/sdsi: Add support for reading the current meter state")
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---

V2 - Split of V1 patch 7

 tools/arch/x86/intel_sdsi/intel_sdsi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
index def1b9a01738..2acc6be5f5d6 100644
--- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
+++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
@@ -403,15 +403,16 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
 		return -1;
 	}
 
-	bec = (void *)(mc) + sizeof(mc);
+	bec = (void *)(mc) + sizeof(*mc);
 
 	printf("Number of Feature Counters:   %d\n", mc->bundle_length / 8);
-	while (count++ < mc->bundle_length / 8) {
+	while (count < mc->bundle_length / 8) {
 		char feature[5];
 
 		feature[4] = '\0';
 		get_feature(bec[count].encoding, feature);
 		printf("    %s:          %d\n", feature, bec[count].counter);
+		++count;
 	}
 
 	return 0;
-- 
2.34.1


