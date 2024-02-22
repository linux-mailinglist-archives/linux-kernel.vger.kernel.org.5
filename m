Return-Path: <linux-kernel+bounces-77155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 123EB8601BF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C08D32885ED
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5901954903;
	Thu, 22 Feb 2024 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kioV02ZG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7B2548ED
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627170; cv=none; b=bABpUVqMg73kT7DkVDNodlyGsskPlQv3Koh5TQGpD6PkifKNpOACbo+RZ0gHwce7Dr03oQ5kdgif19zDV0pEUoU83cl/LSvJqf7pjIvfseTiwhShrUuXees/BTNbK8Rq3AwdOmToy++4M4Z593B87Z53PPQs6HPMDX+4Wx+1FbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627170; c=relaxed/simple;
	bh=vgTVF3fDvGFxF4OBhUY/4q62vw94GJkPL24swZeT0Rw=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=uiYO2ngh0nBPTawwA28Cyw8xN71T352mV2WxZXEnAJnkNEHyqM70qgPr68HMNpYGgsXisKG/er2Nxm5DX3tf3C2IgfiybpiQ/+rHwjrmDO2y56ZdHHMw0hd+kYvrYFkJdepQHPQ3NuS5IizaIMEPngtYySYGWlmdvvwqZWOw4fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kioV02ZG; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627170; x=1740163170;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=vgTVF3fDvGFxF4OBhUY/4q62vw94GJkPL24swZeT0Rw=;
  b=kioV02ZGV65ayAoM4nTnR1ZSF9cn7W4dvS8gzf1jgffMd6HWsfQ+rjUB
   vlXCZzNePIKEG4JVeQxc0kpnRBrmT5X/w7Bt7x12lva9gYBhpKpjRhHQT
   fmAAyZedqG6NuPMTrm67I572kYhhcAACGtWo83xTfHKsBVTbCeX6Qs5Jl
   gEvv+2Fnu+Qs9aa8q/Lg562cNbQ4MZKipkNHI9dxF2UtzyONKjxp0pkfF
   uyph4b4rf7O66IWL6sShdSdosI1Gn8Diq+vjmveos9VmI7ZFs0XhsKZWx
   xaPjvGWAqUE/GANsJqHqsxReK2oxSdSJgi586YTFJ2ZTwnziBGixcKa06
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3031679"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3031679"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:39:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5975353"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa008.jf.intel.com with ESMTP; 22 Feb 2024 10:39:29 -0800
Subject: [RFC][PATCH 01/34] x86/xen: Explain why calling get_cpu_cap() so early is a hack
To: linux-kernel@vger.kernel.org
Cc: kirill.shutemov@linux.intel.com,pbonzini@redhat.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>,jgross@suse.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 22 Feb 2024 10:39:28 -0800
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
Message-Id: <20240222183928.0D8942B2@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

xen_start_kernel() some of the first C code run "Xen PV" systems.
It precedes normally very early things like setup_arch() or the
processor initialization code.

That means that 'boot_cpu_data' is garbage.  It has not even
established the utter basics like if the CPU supports the CPUID
instruction.  Unfortunately get_cpu_cap() requires this exact
information.

Nevertheless xen_start_kernel() calls get_cpu_cap().  But it
works out in practice because it's looking for the NX bit which
comes from an extended CPUID leaf that doesn't depend on
c->cpuid_level being set.  This also implicitly assumes that
Xen PV guests support CPUID.

Leave the hack in place, but at least explain some of what is
going on.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Juergen Gross <jgross@suse.com>
---

 b/arch/x86/xen/enlighten_pv.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff -puN arch/x86/xen/enlighten_pv.c~xen-explain1 arch/x86/xen/enlighten_pv.c
--- a/arch/x86/xen/enlighten_pv.c~xen-explain1	2024-02-22 10:08:48.404451146 -0800
+++ b/arch/x86/xen/enlighten_pv.c	2024-02-22 10:08:48.404451146 -0800
@@ -1372,7 +1372,11 @@ asmlinkage __visible void __init xen_sta
 	/* Get mfn list */
 	xen_build_dynamic_phys_to_machine();
 
-	/* Work out if we support NX */
+	/*
+	 * This is a hack.  'boot_cpu_data' is not filled out enough
+	 * for get_cpu_cap() to function fully.  But it _can_ fill out
+	 * the leaves where NX is.  Gross, but it works.
+	 */
 	get_cpu_cap(&boot_cpu_data);
 	x86_configure_nx();
 
_

