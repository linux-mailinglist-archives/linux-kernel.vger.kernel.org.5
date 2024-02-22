Return-Path: <linux-kernel+bounces-77180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F258601DB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B733F28C82E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E395D14DFF1;
	Thu, 22 Feb 2024 18:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bETgXOOG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19DA140E3F
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627203; cv=none; b=p3lwDtxFhXqhpE9QEpuXZ0qFerBxxpKmGRA+Kg2IeAGG2YFW+BHCo08TcZo5yvJ3AGimADiU8YiCksVt0DO7wSoo4WzfPg/4wZA6EQQux8w8UBNeFTpbrTxq4VdQxXzjCLJXxVIOg03eHPjFY21DvaZu/PnacZ+801n1Uy+DPlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627203; c=relaxed/simple;
	bh=jlRQT407YyuEjgIgy+f+wvbminlLl1hPvuPvmjlH09Y=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=WOWrRakq714HcGhhrxxyGSHMrV+EEP7lhpl+0pd6j1O1HElUJVlmxvBiMvBoZHaSVdsRLiHsQgStTOawhFeAVm+425nMlc7mgweDzFkV+aZgqy13yB/2TjJqdyWsWc5PxxqePZJjoaEjmvMSm8osPI/UInBtRkf0+CRglKcEkCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bETgXOOG; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627201; x=1740163201;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=jlRQT407YyuEjgIgy+f+wvbminlLl1hPvuPvmjlH09Y=;
  b=bETgXOOGtYZCsTAscMo1LIy7QXRlyKmhmJpCffzlJ46I0L4NbNnk2lKO
   wUdNUIObaNU6EGuMy/clQXIR2FTllf+quUfJjT+fAUpzQmB/2xkjZHYBW
   3T6VHtpyU2hAI1UqEjttXKmjMlHPOJFA3UpGmIZoiN7MPCQLbuf69f+FE
   vR5TYIC8CIZ3vcFGhAab+5JG5RCObs7fZy/iWHMZPqWIFx3kHOFhrol5x
   //rVs6wZUEjzamXJAXMXHBjFRTE+k5YIqWvAwucxryCNOSdYjbxxf9fya
   GKmiOsVpun/hmVZ1246SNDFzha1JcjrzlTH5OLLPMNEjdRGAlcuzBjCXI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="13584558"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="13584558"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:40:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10265242"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa004.jf.intel.com with ESMTP; 22 Feb 2024 10:40:01 -0800
Subject: [RFC][PATCH 26/34] x86/cpu: Zap superfluous get_cpu_address_sizes()
To: linux-kernel@vger.kernel.org
Cc: kirill.shutemov@linux.intel.com,pbonzini@redhat.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 22 Feb 2024 10:40:00 -0800
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
Message-Id: <20240222184000.F74060D0@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

All of the 'x86_config' state is established by the boot CPU long
before generic_identify().  There is no need to call
get_cpu_address_sizes() again.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/kernel/cpu/common.c |    2 --
 1 file changed, 2 deletions(-)

diff -puN arch/x86/kernel/cpu/common.c~zap-extra-get_cpu_address_sizes arch/x86/kernel/cpu/common.c
--- a/arch/x86/kernel/cpu/common.c~zap-extra-get_cpu_address_sizes	2024-02-22 10:09:01.292957116 -0800
+++ b/arch/x86/kernel/cpu/common.c	2024-02-22 10:09:01.296957273 -0800
@@ -1770,8 +1770,6 @@ static void generic_identify(struct cpui
 
 	get_cpu_cap(c);
 
-	get_cpu_address_sizes(c);
-
 	if (c->cpuid_level >= 0x00000001) {
 		c->topo.initial_apicid = (cpuid_ebx(1) >> 24) & 0xFF;
 #ifdef CONFIG_X86_32
_

