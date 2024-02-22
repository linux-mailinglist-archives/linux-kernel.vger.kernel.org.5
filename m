Return-Path: <linux-kernel+bounces-77184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 134418601E2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD0B1C252F2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753B614EFE3;
	Thu, 22 Feb 2024 18:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y02G1hto"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4436A14038D
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627210; cv=none; b=q+6eX3zO+W9Auvl3CdYO3MBpYn6YurAGrbuK2LQbeiU0i1kkelWP62RaxX/b9nHyZono+artC41vpaCCx8hvHZgWCfj1SPqlax70ejMkVNFA6ACiEBhu8+7qDm9u99dn5FFiZuV7FDz4KGb+10xvOeoNyRfkY+5yu1zmlD2BSC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627210; c=relaxed/simple;
	bh=IHq53bWUd8zFRS3i8EHUWcDqCt/OSX6cwnyJtJ5m0oY=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=Hj5AA2Hyju5+lUprAj3f4kWqhcaS8yjD04HPWXvz7l98aWE+k269fZFhozuubNUwoi5rnRBLDZ/q9hWYysRn+xeI3Di0kfhHGou5Ifnd2TjN+JgrIq0TLa+SUosubSySVZJuNy2SI90/9TBJUT5MrUq5EL2SURy/eXxfDqWhB1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y02G1hto; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627208; x=1740163208;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=IHq53bWUd8zFRS3i8EHUWcDqCt/OSX6cwnyJtJ5m0oY=;
  b=Y02G1htoWg/nmJknhefWTrk61U14CuT4uQx9ZoF04Iw1bVaLof3lPXCC
   lbEeDY12YBliUCWq77qV7wDHNmkzRbT18tU49r+ua+cuznC7LolgXBUBj
   DFGaeFP+2dBRdk9jAiNycfZfeoZNQnrFFu6UwIfIzaj3C0qFlU1ra3pPd
   8vudXSMIE257s/LkFppLkC3bRuu4VBWYzhQRLPstEEFy88dvgj/lVFM5r
   oWoCgGN0y8VTBhO8+pKIGCCfFAyLq50LOis4QPxlfV/BfYjwcnMIWBa9M
   1kM/3nsmuBtYJ47t/qjYJd7sTW++whmARAJ4W0H44EFl70cZh5ellraQY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="13584585"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="13584585"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:40:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10265271"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa004.jf.intel.com with ESMTP; 22 Feb 2024 10:40:06 -0800
Subject: [RFC][PATCH 30/34] x86/cpu/centaur: Mark BSP init function as __init
To: linux-kernel@vger.kernel.org
Cc: kirill.shutemov@linux.intel.com,pbonzini@redhat.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 22 Feb 2024 10:40:05 -0800
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
Message-Id: <20240222184005.87229530@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

The boot CPU is obviously not initialized during normal system runtime
and its code can be __init.  This prevents a warning once
'bsp_addr_config' gets marked __init.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/kernel/cpu/centaur.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/x86/kernel/cpu/centaur.c~bsp_init_centaur-__init arch/x86/kernel/cpu/centaur.c
--- a/arch/x86/kernel/cpu/centaur.c~bsp_init_centaur-__init	2024-02-22 10:09:03.237033434 -0800
+++ b/arch/x86/kernel/cpu/centaur.c	2024-02-22 10:09:03.237033434 -0800
@@ -213,7 +213,7 @@ static void init_centaur(struct cpuinfo_
 	init_ia32_feat_ctl(c);
 }
 
-static void bsp_init_centaur(struct cpuinfo_x86 *c)
+static void __init bsp_init_centaur(struct cpuinfo_x86 *c)
 {
 	if (c->x86 == 0x6 && c->x86_model >= 0xf)
 		bsp_addr_config.cache_align_mult = 2;
_

