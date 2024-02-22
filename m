Return-Path: <linux-kernel+bounces-77169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356D98601D2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66EFB1C25AF1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB4E13BAE6;
	Thu, 22 Feb 2024 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U++5FIQ9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02214137911
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627189; cv=none; b=pvMoZ0xPoXiOZpUVjXR0wzpw403puUnQOlerVpPqqWxOUzz25E6aKfqSvYNBrIq0E4EHo/OwrENpp0ivkvIAsHG5u50fPrEPKqRDJd8dxlhTN15h+W+8GYnr9xM5MItv/JWXwliJ1sgAoYhNttcX0NH9R7nshD77aneIYB26+eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627189; c=relaxed/simple;
	bh=84dXCfycOCeIkvzfMQyuyX9PyM2pSN/8B8x9nVAoz80=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=JrJclWTTrqo05/ScCDvgA2d+eODfrp5XF0yl7UmwlC0Q2VOLpA4ruEAgWLZiO67sQD0kJQLkjpPk25XtQHRiYCiisbkP4GssrSWYDUpK4raRuVdM5UGgDQn099ZBw2Ceb/z5OKhTp5rbfPlwZ7qKNz1prkuOcYd7qn8jaojLmFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U++5FIQ9; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627188; x=1740163188;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=84dXCfycOCeIkvzfMQyuyX9PyM2pSN/8B8x9nVAoz80=;
  b=U++5FIQ9pj7EBpG9tDUwXemy+cPOItPwJD86d+n3jPf3dZW8mgdbvZJu
   sNLaQ41H8bzPexATwOxZ8HZ9AbKrGGMbGvAug7jB7pNbFp/p/5WXHmUlm
   mgUZv0kcSQvdSR1WQcbr4x8MhzjzA0TP+/8U/qIuIONEz5RcR754MPLyO
   q1oHcAZsnv/g2Ezok1JSCundSXworTrL2MKstSmPRvE/+aU0IVzMSGjih
   QlW3VNxNNUCHkubHyrok8MNZfOoIQUtqCHXGQQcMg+4xKevUpoOfq38SC
   AqeV3nzCnjYMouKLuIdxO8Yv8fBtQ5SvoYVGD+HqGnQSJDjJpVs9/CLut
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3031804"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3031804"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:39:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5975520"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa008.jf.intel.com with ESMTP; 22 Feb 2024 10:39:47 -0800
Subject: [RFC][PATCH 15/34] x86/cpu: Remove default x86_phys_bits assignment
To: linux-kernel@vger.kernel.org
Cc: kirill.shutemov@linux.intel.com,pbonzini@redhat.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 22 Feb 2024 10:39:46 -0800
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
Message-Id: <20240222183946.76C864D3@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

This was presumably needed for *some* reason at some point.  It is
useless now.  Remove it.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/kernel/setup.c |    1 -
 1 file changed, 1 deletion(-)

diff -puN arch/x86/kernel/setup.c~no-early-max_phys_bits-assign arch/x86/kernel/setup.c
--- a/arch/x86/kernel/setup.c~no-early-max_phys_bits-assign	2024-02-22 10:08:55.736738995 -0800
+++ b/arch/x86/kernel/setup.c	2024-02-22 10:08:55.740739152 -0800
@@ -752,7 +752,6 @@ void __init setup_arch(char **cmdline_p)
 	__flush_tlb_all();
 #else
 	printk(KERN_INFO "Command line: %s\n", boot_command_line);
-	boot_cpu_data.x86_phys_bits = MAX_PHYSMEM_BITS;
 #endif
 
 	/*
_

