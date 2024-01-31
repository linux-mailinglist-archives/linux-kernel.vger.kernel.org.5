Return-Path: <linux-kernel+bounces-46353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 456DD843E6C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D13290D63
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A7B78B55;
	Wed, 31 Jan 2024 11:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ETeO7YRz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE3B76902
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 11:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706700741; cv=none; b=TtsQjdfIubtsmYAILRimN0Dfgi34DNi5f+rivM9q7rRF3hot25ECJ9qBYhA9/2SIUJJQZO1Kk9251OIyXV25NGFe2OucNMx7D5J+eIzIyhlX+/opTfMAe1U7QYttxkVmQvXcPthEF89azNiYOBQWKvvXctzeYwDjGD1w8nQ0J9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706700741; c=relaxed/simple;
	bh=Y7qo1m5CDGT1VKthMffqdzzDPZQ45nJRPtbVqpGFfiU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yf2f9Wv6AbGjugFHjuDf8VAmsFNXhtyyMe6LM3o3YQUW+kxBZ0ERXgq/P86cNPcC6H3HguT+4QzCyAfQOH44ODLfsXww/RToq0tc+M6mYcZQOGMjjWbxK3IAEOqRasyikKxKOmVT11VYHCTY0vDojgGZtA7OAnS+akJb4fy48tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ETeO7YRz; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706700740; x=1738236740;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y7qo1m5CDGT1VKthMffqdzzDPZQ45nJRPtbVqpGFfiU=;
  b=ETeO7YRzyWU3h12lRwbnHiqrZtYOgLLlcqxEHz401eMZdw6yWvaevA1o
   eP+D7ZrdQ8BNP2xgK4IfBuAanydvDnka+HpeXvJUWctI5mLUsTjHTwHsE
   KdrfHzsXs3GHtTOgN4yj6xPHF/TfipvXdC8w/AzgOxCtupgiwBjHGKHAv
   UV/7t1yAzspfGSXqrTMWQrRCBhHmoiPZm0/uqYricYcoU6eAsDAyogUSE
   FNCKGunB2SFYz6+s/RWFG82U8cyQNtkjDCIz1mwZI2cP1twDd23wiRqy5
   4/wRPPOvvxcgvE8o8ekBlFGrc7Atd4/TfJPxf1vkkszaOC3IJc0o/d4tT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3414270"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3414270"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 03:32:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="878764820"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="878764820"
Received: from server.sh.intel.com ([10.239.53.117])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 03:32:16 -0800
From: "Huang, Kai" <kai.huang@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	dave.hansen@intel.com,
	kirill.shutemov@linux.intel.com,
	tglx@linutronix.de,
	bp@alien8.de,
	mingo@redhat.com,
	hpa@zytor.com,
	luto@kernel.org,
	peterz@infradead.org,
	thomas.lendacky@amd.com,
	chao.gao@intel.com,
	bhe@redhat.com,
	nik.borisov@suse.com,
	pbonzini@redhat.com
Subject: [PATCH 4/4] x86/virt/tdx: Remove the !KEXEC_CORE dependency
Date: Wed, 31 Jan 2024 11:31:56 +0000
Message-Id: <b571f5db35d42bbd90bf46251bd6da9665614b87.1706698706.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706698706.git.kai.huang@intel.com>
References: <cover.1706698706.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kai Huang <kai.huang@intel.com>

Now TDX host can work with kexec().  Remove the !KEXEC_CORE dependency.

Signed-off-by: Kai Huang <kai.huang@intel.com>
---
 arch/x86/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ac3b32149a77..5225f8f3eade 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1973,7 +1973,6 @@ config INTEL_TDX_HOST
 	depends on X86_X2APIC
 	select ARCH_KEEP_MEMBLOCK
 	depends on CONTIG_ALLOC
-	depends on !KEXEC_CORE
 	depends on X86_MCE
 	select ARCH_HAS_CC_PLATFORM
 	help
-- 
2.34.1


