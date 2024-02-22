Return-Path: <linux-kernel+bounces-77185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E564F8601E1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1E5428775B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A65A140E2A;
	Thu, 22 Feb 2024 18:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HfjcCjsp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878BC14F96A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627210; cv=none; b=EMQbirii/3B7ofvwr/UpMRW4y+CqWy5PRDNoACqjYEEUJGdnsIvea3KdQyNok3Ooa6cIlMKedyhvF2lk4x4fNljjrk0yrYcSt2m5iBoakQkYmACGx6S9Nx7qckywgVuY0TqRwP0lrM6CnQYg/3XFAx85frvc8so3JIpCEyvqYAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627210; c=relaxed/simple;
	bh=V0nhZmX+DNdyizRXt1fC0+DFHcTx60c+hJHBb5KG2wU=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=Ci4tb2lCNPieh6msZjkRG9ov70My+4gO/uZm52/GOh3D/aZycZxY6FF7O5epmDNvzL5UqutUTExXS571Lc6+gp3a4SI1nfeaaI1oIihYTR74Xn4L3iRkODegZw8/LkZX76jGmDLlhjt9WtyaWEr/SXptQXx98PaIsdXc/vwfn/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HfjcCjsp; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627208; x=1740163208;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=V0nhZmX+DNdyizRXt1fC0+DFHcTx60c+hJHBb5KG2wU=;
  b=HfjcCjspuWUh3fkCLmOCJ6dcsbvMLVwTxs90C9I4svxTngJjB08HpE6Q
   UMg5bokm3LsUVDM6hRvdP+Wc71so0B//BLheUY/pBQvg/lEy+4c0BijI9
   8s7KmYujFbYbydzu+qQOlEkl+pasBcN/PiKN5OA3bbeCnDzn12Kt1A3jH
   N1NnYXl2kUlX8JO+8nGNKJNEBn8yNLDvgSM2yyZLMuCpyXvhR4lBUZCjZ
   J6fFLRETEVD1AuSosqfXpxTWOnit037F+4Lklzjwc6czIZqST3vLOD9Uh
   dpaGCKa+Oo5HveN/9OiSqtiB7HBmYnh6KgsdfGH0S87Kg3k3c7l4OPjo+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="13584590"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="13584590"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:40:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10265276"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa004.jf.intel.com with ESMTP; 22 Feb 2024 10:40:08 -0800
Subject: [RFC][PATCH 31/34] x86/cpu/intel: Mark BSP init function as __init
To: linux-kernel@vger.kernel.org
Cc: kirill.shutemov@linux.intel.com,pbonzini@redhat.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 22 Feb 2024 10:40:07 -0800
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
Message-Id: <20240222184007.9E437D9D@davehans-spike.ostc.intel.com>
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

 b/arch/x86/kernel/cpu/intel.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/x86/kernel/cpu/intel.c~bsp_init_intel-__init arch/x86/kernel/cpu/intel.c
--- a/arch/x86/kernel/cpu/intel.c~bsp_init_intel-__init	2024-02-22 10:09:03.721052435 -0800
+++ b/arch/x86/kernel/cpu/intel.c	2024-02-22 10:09:03.725052592 -0800
@@ -433,7 +433,7 @@ static void set_min_cache_bits(struct cp
 	}
 }
 
-static void bsp_init_intel(struct cpuinfo_x86 *c)
+static void __init bsp_init_intel(struct cpuinfo_x86 *c)
 {
 	int keyid_bits = 0;
 
_

