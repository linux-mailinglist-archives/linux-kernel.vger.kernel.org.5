Return-Path: <linux-kernel+bounces-93825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EED87354B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D19E8B23146
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7225FDDC;
	Wed,  6 Mar 2024 11:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GJQarYuB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EBE604A7;
	Wed,  6 Mar 2024 11:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709722886; cv=none; b=G8n6o7p2xbc0rvUc8rB6bGIOda0GltK8GIqsc/+Ogn6oc8T2B8CMiL9pHcEbm4iBTtHqH/4SBIHwcP/g5OsTtMR4BT3EtY/1KzKCYj4ZCEl9ogiOSl5C78zCdkyoCoRrKLGQV2n9unhOvgz+lwf/98QlA6zMUUHLaShfAGHiPec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709722886; c=relaxed/simple;
	bh=QnEU6jhwX7i1ZB/3pShjxSETQ3xsLNz0r4DdTZhkXTo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sYI0gf+o6Oscij8/HCaFDtvpvu5BBoQYp+T38AGNn4E7pEbRIKAg68S9go21xsKbUacMmrv2DVq5pXVxxU37siBgNHmKdWFfZngckjop8/TO0p12qT2dxtdS/8Qi7+gymEsDvWcWAi8YJ3uK59gq4RQT0cLRoK+nYBCiRjFAqQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GJQarYuB; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709722884; x=1741258884;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QnEU6jhwX7i1ZB/3pShjxSETQ3xsLNz0r4DdTZhkXTo=;
  b=GJQarYuBT2EZ8Y84EQn/LWtWpuGgMtkh+cA6cW0M2QD/1hzhXkhs4B93
   pwQYqUtsqs0X9e+Wr2ltTtNZ6DO1Vf/lZtrxPezxnkrZLqmSjNDaro3Ai
   Wzy1bCFClr/TliLg0xAleI3Fub/uRo28pPdRfzSPom4Htab/p3KP20Khy
   SNkQgdvtIzjkodZvITttECrmyoR3eIqRE+unAGfYLCKCfR0vy404bge7v
   hFAnF7UOVT3YRp0D/YxKMawUBgFwkkMnk13lLa2XdUcUkx7FgetMDX/8i
   EuXPAP8Ok6MOZuMaVnORI9hRdNN/kEq70CYUy+ZWn2yM5VorhdnfYI0c6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4445296"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="4445296"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 03:01:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="9594623"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 03:01:20 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 6 Mar 2024 13:01:14 +0200 (EET)
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc: Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    stable@vger.kernel.org
Subject: Re: [PATCH] platform/x86/intel/tpmi: Change vsec offset to u64
In-Reply-To: <20240305194644.2077867-1-srinivas.pandruvada@linux.intel.com>
Message-ID: <3a97f188-3998-866d-6a23-e0f4559c673d@linux.intel.com>
References: <20240305194644.2077867-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 5 Mar 2024, Srinivas Pandruvada wrote:

> The vsec offset can be 64 bit long depending on the PFS start. So change
> type to u64. Also use 64 bit formatting for seq_printf.
> 
> Fixes: 47731fd2865f ("platform/x86/intel: Intel TPMI enumeration driver")
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v6.3+
> ---
> This is a forward looking change. There is no platform with this issue.
> This can go through regular cycle.

I've applied this to review-ilpo.

-- 
 i.


