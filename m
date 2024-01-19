Return-Path: <linux-kernel+bounces-31633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EA58331A7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 00:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BC8A1F22A1F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 23:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB70B5810D;
	Fri, 19 Jan 2024 23:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EQub/PmV"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AD59461
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 23:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705707739; cv=none; b=LuMu2QHU5Br6twlfy+d8VV2rBSy2YsW+IA6RmYnTyE3GRS7KJNZRLXzMoajn8KeiigYulnpJYVdze+8UViDoJqicimhEfwBT5N8BxzQaJA6aamuwi7GtJ49owMqK/D8csZIFyDbXg0lzWr+NagzyKGr6qD4c0xqDJlFpWmPWfyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705707739; c=relaxed/simple;
	bh=EOMoCb0F8Dvt63jasgfU+CKNZAPBehIsLSRKgEsVDww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUOhFP+q8piv2QnAsEMJNyuyIAcw3PQ6kSi6IkRjuN7dSB4wYPbMX0tBe9Z37htEuodT86jp5tjcb7Fq1T/biOEbjy5pv1pARWPYtyMvZgXJe08HhHcUBoMX0T1tXGjZ9M90wCMnYsTaAc0G2q2E0gp3NbGMAshFR/3PW34iX5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EQub/PmV; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705707737; x=1737243737;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EOMoCb0F8Dvt63jasgfU+CKNZAPBehIsLSRKgEsVDww=;
  b=EQub/PmVO3hDNhbT7lhY2gUB7lMo7URUPVjeeRhEt+8hJfgPh9Eo0/Xj
   YSKf87T1idi4lYpbaMVDapRW0RvezdHIkyhfGOSvd47iDgcUjSRtvOcuN
   qjuC11mNbignR4meGdUePiCh3b+UySW7hOIvSUMottDOuwmiCZ6SSx8sq
   AF8W1rtfdCcbahSXy6sbB2WU50kgesaGS+TPZak6NeGJ3825knCCpp9T9
   51Cu2AqkpZvYSc5iHc4gvgufJV9RgflQLSk1TPHmCzeMcVqOrLyGpD39I
   VsutC72v0S31qYFdzpFsnvfXLTP3cykflD3lmX6XFmlmM1+G3XAAJRVH3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="400526768"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="400526768"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 15:42:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; 
   d="scan'208";a="707461"
Received: from guptapa-mobl1.amr.corp.intel.com (HELO windy) ([10.125.112.71])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 15:42:17 -0800
Date: Fri, 19 Jan 2024 12:54:42 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	kirill.shutemov@linux.intel.com, daniel.sneddon@linux.intel.com,
	antonio.gomez.iglesias@linux.intel.com, rick.p.edgecombe@intel.com,
	alexander.shishkin@intel.com
Subject: Re: [PATCH] x86/lam: Disable ADDRESS_MASKING in most cases
Message-ID: <20240119205442.x44qiu7yjbo4xkdi@windy>
References: <919b6370a908bb091779ec2eca7ca5e369d57847.1705631230.git.pawan.kumar.gupta@linux.intel.com>
 <8936e2c6-93b8-417e-9151-041c5f2e1102@intel.com>
 <20240119162104.4ehgnj4ptjrfwyhf@windy>
 <3c65826f-d313-4455-842b-da9fc4a271a5@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c65826f-d313-4455-842b-da9fc4a271a5@intel.com>

On Fri, Jan 19, 2024 at 03:36:22PM -0800, Sohil Mehta wrote:
> On 1/19/2024 8:21 AM, Pawan Gupta wrote:
> 
> > The goal is to compile test it whenever possible. As
> > SPECULATION_MITIGATIONS are ON by default, it wont get tested for most
> > configuration.
> 
> Sure, that would help increase the compile coverage. I wasn't sure how
> much of a difference it would make. Anyways, the restriction is expected
> to be short lived until LASS is available.

True.

> Please feel free to add:
> Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

Thanks

