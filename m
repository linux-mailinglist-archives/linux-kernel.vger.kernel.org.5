Return-Path: <linux-kernel+bounces-123276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F428905DB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41ABF29A5EF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3991713A86D;
	Thu, 28 Mar 2024 16:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="McmXbZHx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004FB13A3FA
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643874; cv=none; b=rm0yVfD09hLtVZAua32cOYRRjonVrFQA6GBJufSsyucKHTThfb8pNyQL/8CNjNpdugFxgRhii4bKYr6w4Ca1am/tLV7PZZdADRLkl396niGyIK0oNYM9+ywptr7hi76FWerx/MSHNQ7m8XHvw4wwwoyaHfkyY0EDG0i4UxiHX9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643874; c=relaxed/simple;
	bh=KWBh8g5qezvg7G7Awmc1JPz7LX3fEPmblNlcvDU1Zbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ghd05VCZYAD95RQbXV42WcZVC2PDhrrAprvexEE8YKr3+hY+K1mR55OwRnFbzHhXdAlHgaIXUyJ7GN3qO508TKNbZTkUBP3ZMi6MFVgFlwplfn3W5jkihU64XsbkJd4EmBTzUv6OoNsYBwBvzethmYx0F9Zlpm0vwN2EltQ9jzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=McmXbZHx; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711643871; x=1743179871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KWBh8g5qezvg7G7Awmc1JPz7LX3fEPmblNlcvDU1Zbw=;
  b=McmXbZHxeeF3hxMTXp1kZKiWl1TNKvoMe7ZNffqa+mZXsHGughm6hvP7
   o8llkftAYpJUMEQGeORwbU2t7+rTD2vx4Ggk+6YXMOsKL5xzgb/s9t6IW
   7t6qQSprQdJ3+cExUPCy+g4wmqwx+wcO2PlcjbolNBtcXYfBpIpnjEEs2
   RZUX3n8wORy8luUveX2ehIjkfwmeh5ME9VPVitcxhP8TOd3+d9McJdcvh
   OLxfmRskkEKdfBzsrJjAJQSd8bEGW+w2frQsb2T8hyFSI+bIvJI4nEIas
   hf+6StVI3Not5gJo47o8XS7tLxqvGTEJQJkQYt6M+iCxTN2qg6DoLC2QW
   Q==;
X-CSE-ConnectionGUID: wz+17/afT4GI4lU6uq0q/Q==
X-CSE-MsgGUID: dEdJjj4/QMKXZMoo54JD1Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="24296527"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="24296527"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 09:37:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="39852822"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 09:37:52 -0700
From: Tony Luck <tony.luck@intel.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH 01/74] x86/cpu/vfm: Add/initialize x86_vfm field to struct cpuinfo_x86
Date: Thu, 28 Mar 2024 09:37:44 -0700
Message-ID: <20240328163746.243023-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328163746.243023-1-tony.luck@intel.com>
References: <20240328163746.243023-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor struct cpuinfo_x86 so that the vendor, family, and model
fields are overlayed in a union with a 32-bit field that combines
all three (together with a one byte reserved field in the upper
byte).

This will make it easy, cheap, and reliable to check all three
values at once.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/processor.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 811548f131f4..87115e5d884f 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -108,9 +108,15 @@ struct cpuinfo_topology {
 };
 
 struct cpuinfo_x86 {
-	__u8			x86;		/* CPU family */
-	__u8			x86_vendor;	/* CPU vendor */
-	__u8			x86_model;
+	union {
+		struct {
+			__u8	x86_vendor;	/* CPU vendor */
+			__u8	x86;		/* CPU family */
+			__u8	x86_model;
+			__u8	x86_reserved;
+		};
+		__u32		x86_vfm;	/* combined vendor, family, model */
+	};
 	__u8			x86_stepping;
 #ifdef CONFIG_X86_64
 	/* Number of 4K pages in DTLB/ITLB combined(in pages): */
-- 
2.44.0


