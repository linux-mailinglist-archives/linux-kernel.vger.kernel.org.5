Return-Path: <linux-kernel+bounces-30765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F034E83241D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 05:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6885B22A00
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 04:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679FE4A05;
	Fri, 19 Jan 2024 04:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L4yVwEmj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D3D4437
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 04:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705640316; cv=none; b=ccI8bm3uBOyeBi/I1W6swaYyGox+81GRmiOoUao3Bs/oYJMv0cZKoGoGHdgtWHJ46AgGoFJrvYF+zMZoRuP58CXCCgLCjq10rQDp9w7gCwuXKIiLIxgpAtpLUFDjVc0a4e65pvimOljUqSxu1lnuSAvsKZtm3UI1UaIcVYPqc7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705640316; c=relaxed/simple;
	bh=8QJSAvI0LMNhlgPMo9ucUzZ1CMGI8vxL4qfd4Ivube0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=di4zk9AcAnb0t9IZgTSgCMg0NmdvkBPhXZXF0IwpNK0khBy/DYL1BkuelDYz87C5ozIKa5nBwQm9iu2tvYxL28srrFGKHNS8kM20iTUoh1qyuUye1lM4lerYFM9A3CunFwYIb+B5NlpddIuaD1smUbbIJT9LQqb0iaWOYhQFtBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L4yVwEmj; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705640315; x=1737176315;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8QJSAvI0LMNhlgPMo9ucUzZ1CMGI8vxL4qfd4Ivube0=;
  b=L4yVwEmjZHBp0CYeybHCAG+NdqUS7QAOvGpYi451JLEtqmOke98avmcX
   EHozH9pRdjWHXqHOiG9E8ljG6fmckcSLugh2heY1rr3AfFfF4BGpwK8U2
   K/vvF2ZUeJhQTKyHJzybP3XPEVvpPZJ/lc/rx2LhgivL+Kjt7ZoT6tlzm
   Ewx/3KW9xRdGv/1MlclJK22LgVZZgmet5Un4MZyBLxVsulyiwQKAlAEp5
   EBLqIExntdW0YqSa8GG0Jwb97UwvOY6nZA0/ZmA3kjLt+7Ib+UW6zfdvq
   PVtau4Y80YNIAIfoecKQvrjCjZ28eVf5+FPRPsgzZOPo+8smmRTx9uQbp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="551100"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="551100"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 20:58:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="484333"
Received: from clucarz-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.214.192])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 20:58:31 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 8C4BB10A0C4; Fri, 19 Jan 2024 07:58:28 +0300 (+03)
Date: Fri, 19 Jan 2024 07:58:28 +0300
From: kirill.shutemov@linux.intel.com
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	daniel.sneddon@linux.intel.com,
	antonio.gomez.iglesias@linux.intel.com, rick.p.edgecombe@intel.com,
	sohil.mehta@intel.com, alexander.shishkin@intel.com
Subject: Re: [PATCH] x86/lam: Disable ADDRESS_MASKING in most cases
Message-ID: <20240119045828.xcypcr32cpovqptg@box.shutemov.name>
References: <919b6370a908bb091779ec2eca7ca5e369d57847.1705631230.git.pawan.kumar.gupta@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <919b6370a908bb091779ec2eca7ca5e369d57847.1705631230.git.pawan.kumar.gupta@linux.intel.com>

On Thu, Jan 18, 2024 at 06:35:47PM -0800, Pawan Gupta wrote:
> Intel feature Linear Address Masking (LAM) has a weakness related to
> transient execution as described in the SLAM paper[1]. Unless Linear
> Address Space Separation (LASS) is enabled this weakness may be
> exploitable.
> 
> Until kernel adds support for LASS[2], only allow LAM for COMPILE_TEST,
> or when speculation mitigations have been disabled at compile time,
> otherwise keep LAM disabled.
> 

It worth adding that there's no HW on market that supports LAM, so nobody
affected by the issue.

> [1] SLAM: https://download.vusec.net/papers/slam_sp24.pdf
> [2] LASS: https://lore.kernel.org/lkml/20230609183632.48706-1-alexander.shishkin@linux.intel.com/
> 
> Cc: stable@vger.kernel.org # v6.4+
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

