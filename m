Return-Path: <linux-kernel+bounces-77182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E44918601DE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21AAB1C2603F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA34714EFFD;
	Thu, 22 Feb 2024 18:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mQHvS9Xa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255D714EFC7
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627206; cv=none; b=XD91gesTGmsuw+5xf+3ZBixAfUl8H30mGE0oC3t0h1k1/CvyKIFq39hsrKw5OopGLZPp8m1c+WP/xwqW1U5zjpuByZcBIt2X2S5nZymtxYH08IKR8mf0Zt3FgCvf8MrB4rjdj4yXXMV3y36FhRhIYYRhIanzvzIFfs0YYQJ0tDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627206; c=relaxed/simple;
	bh=qBn4TiOyJK73Ejv38vlOE4n5SWGEzB9iLnbLIjuNbPw=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=D7VXxwZEmGXNRggk+4kh4ZM70MYBbRFT9LvrmMbrmQ1jBcf5p5LdAnzg6eUFYlnFMK5bRPjuQfOHqN0+OlxxRe0S4yGDw950Ii3JdVz3h0EkLUEU/ut+a93RJQiaNJMrTJ0L0HvELhuTvjyqiNthgdcI5sOcDm3t0NsyvjTeafM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mQHvS9Xa; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627205; x=1740163205;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=qBn4TiOyJK73Ejv38vlOE4n5SWGEzB9iLnbLIjuNbPw=;
  b=mQHvS9Xa6qEW9scb65ws0Dfmfjzyi19XNkUPG1WOJdKoocVSupuWbKta
   QeMuvy+v1kq5M1//ABn8JFr3NAKVKOs87RqB39h+OPPuwaCnSSI/Knvrf
   Wt05TUk1VOxhIWVD46yKfe8B/uVBDaLBQVcOkhHZS+dPM1spTz3i/GvpV
   hrhXRzcqMhdyIsAfpeINR9MkyhOwJEAk+cMRPuNto6Zn2ot1AjmWhFTgE
   ZIGmj5XV8RNVEWlydJAw4DS1UOQ7qAk7L1G2Bx1dAKRuyBgv/7rCatqiR
   9zmhgKWCz/Kw40bFI+tNyZZpflAhYxE9S+B8Sv81tplUnx7pah6D6JRye
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="13584579"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="13584579"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:40:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10265264"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa004.jf.intel.com with ESMTP; 22 Feb 2024 10:40:05 -0800
Subject: [RFC][PATCH 29/34] x86/xen: Remove extra get_cpu_address_sizes() call
To: linux-kernel@vger.kernel.org
Cc: kirill.shutemov@linux.intel.com,pbonzini@redhat.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 22 Feb 2024 10:40:04 -0800
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
Message-Id: <20240222184004.C5E65C3C@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

Xen PV should now be avoiding reading 'x86_config' at all due to
previous fixes.  Even if something was missed, it should now get sane
values *and* be able to survive long enough to get a warning out later
in boot.

Remove the belt-and-suspenders call to get_cpu_address_sizes().

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/xen/enlighten_pv.c |    3 ---
 1 file changed, 3 deletions(-)

diff -puN arch/x86/xen/enlighten_pv.c~xen-remove-early-addr_size-fun arch/x86/xen/enlighten_pv.c
--- a/arch/x86/xen/enlighten_pv.c~xen-remove-early-addr_size-fun	2024-02-22 10:09:02.753014433 -0800
+++ b/arch/x86/xen/enlighten_pv.c	2024-02-22 10:09:02.757014590 -0800
@@ -1386,9 +1386,6 @@ asmlinkage __visible void __init xen_sta
 	 */
 	xen_setup_gdt(0);
 
-	/* Determine virtual and physical address sizes */
-	get_cpu_address_sizes(&boot_cpu_data);
-
 	/* Let's presume PV guests always boot on vCPU with id 0. */
 	per_cpu(xen_vcpu_id, 0) = 0;
 
_

