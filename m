Return-Path: <linux-kernel+bounces-80595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8668866A25
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C33F1F23228
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED8B18E2A;
	Mon, 26 Feb 2024 06:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GZYIdcs+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5FD817;
	Mon, 26 Feb 2024 06:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708929585; cv=none; b=BMeKeSazzT7mEfQszzRva8THtQCuv9HQWVFcc67WWNQ1E6PH2bYSdqBJXVqx7kBksO1SESb82bVeKK63G37yddPVsqLTotAFPXmUNzEsfmayuRUWq/zMsnOGczzHma/AYW4h02qRW10pN3vvZwSBX1OjUb327Uw0A1KuzmuiC9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708929585; c=relaxed/simple;
	bh=FsxT/r8VNKmPa+ah0mYBvQGeTSYBzgrBfiuchLPbY68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYZRxqkhD+07/ixE/vreBT1YMvnvWgXBSED40DDwsGkg6zl674fEENgL/86TIKh6vqg0/eMecsfEX8Zz8nFmrVD8zfX5pi5zls10kpuBj63lIFo84Xj8Hv94QmMkmyy9uSbzVwZi+17f8dWVfDCQsJlrj1KjvoN0acF/QrENnnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GZYIdcs+; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708929584; x=1740465584;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FsxT/r8VNKmPa+ah0mYBvQGeTSYBzgrBfiuchLPbY68=;
  b=GZYIdcs+sziuY8JCO8Ri/Iuve+jLeEaCCkC/eqhDk7JPD0lVaxX2/SiN
   noWBNYo7q8X7kWLE+2dpBmkPnc9/ejOBUxArE4C2hCZ37NdqFy/ginmlb
   9XokjoXZRDwF14KKwyOvnIeXNus09Rb6kLGe7ekYMZF2KHJh9JIX9ogOC
   +NiN73Mkjk/ay4OhbqoWTc3BFni0jZ4UooQT8kgzwgIxA8cR9sccMHYP+
   wL0k0TidY0OnZh1Qbew891Mn2MZUHOvTnsaF0xQhaEo8DHzfFn+On6Q5M
   7mg/xIV97TiqBUw2GUuXopMTiO3qV1DpxrTPvK95l1qYfSMOB+Kxs3RIc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="14327797"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="14327797"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 22:39:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="937029328"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="937029328"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Feb 2024 22:39:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 160181E5; Mon, 26 Feb 2024 08:39:40 +0200 (EET)
Date: Mon, 26 Feb 2024 08:39:39 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Armin Wolf <W_Armin@gmx.de>
Cc: Shyam-sundar.S-k@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
	hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] platform/x86: intel_scu_ipcutil: Make scu static
Message-ID: <20240226063939.GV8454@black.fi.intel.com>
References: <20240223163901.13504-1-W_Armin@gmx.de>
 <20240223163901.13504-3-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240223163901.13504-3-W_Armin@gmx.de>

On Fri, Feb 23, 2024 at 05:39:01PM +0100, Armin Wolf wrote:
> The variable is only used internally and has no external users,
> so it should me made static.
> 
> Compile-tested only.
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

