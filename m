Return-Path: <linux-kernel+bounces-60284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E68CB85029B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 06:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807CD1F22865
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 05:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC0CD297;
	Sat, 10 Feb 2024 05:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IPOvzjMa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230205663
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 05:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707541756; cv=none; b=dCRoHL9CyxupaCEDIYUdeiasYUMCxrVrcebqaH8v39S8fJ/JqodM0wS1j3zJ38v0HF7kJ6+euK0zAjjGbwGH8nsqcqDo2ObqoUAhDKYrptNRqApSaPXKxTFzwAFqU5Xu6nCPqs3VE2jsMvzRRQSoqb2gSGxeYeM6etCiwTmKMgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707541756; c=relaxed/simple;
	bh=oMjZX/6/DadS/gsZQQTpMkvmtQ/1QCEs0FNmijd4Rhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=grYVPvfrM5Ezo+BJZB6rBrc3Ath7a4KYaSxKkrQyegfoo8Fhl7f8xwYojlDd7uF5W6vCXkQ7/sjV+fq7aXEFpbmApXOaTk20FNYn9dQ0psF9vptoTgaUDqokbv4oLenZgRLgadzTfdRs0B2AkRwtHcisBzzwCTaPR6he3uKF6xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IPOvzjMa; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707541755; x=1739077755;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oMjZX/6/DadS/gsZQQTpMkvmtQ/1QCEs0FNmijd4Rhs=;
  b=IPOvzjMaFsFremGHlUDnYE4mLpJ+pN6DkERxmOI9II+NF3ollgIl0FIg
   DUWeEwWMwt0GY4hrO9iW6B9aHrfP/ADX5eSK0ST+X4LnC8f58Vt+zuY3c
   PPhSlxaXAIV2F6ac43ky9dZ7d1ULOpby6jFau79u1Og161ajWnhVXZ1Ye
   c/ghGOIAwGMcoP+pXAPSoPEzpa7yjOi7HumO+EpYs69G0+y8y38lQDsU2
   e9A9mPrWYPcO/+2Qlurg/K1grslp9giddUeEDybXNwCsWnQOftB7tDpC9
   FFu+U7/2+vYOIg/NrFPstgBlZT3WHiYmhRrdNHevF5ba9ctc+/5iyhfdk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="19048176"
X-IronPort-AV: E=Sophos;i="6.05,258,1701158400"; 
   d="scan'208";a="19048176"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 21:09:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,258,1701158400"; 
   d="scan'208";a="6764203"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 21:09:14 -0800
Date: Fri, 9 Feb 2024 21:09:12 -0800
From: Andi Kleen <ak@linux.intel.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: x86@kernel.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Theodore Ts'o <tytso@mit.edu>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86/coco: Require seeding RNG with RDRAND on CoCo systems
Message-ID: <ZccE-LzC3uKyxdGa@tassilo>
References: <20240209164946.4164052-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209164946.4164052-1-Jason@zx2c4.com>


> +	for (i = 0; i < ARRAY_SIZE(rng_seed); i += longs) {
> +		longs = arch_get_random_longs(&rng_seed[i], ARRAY_SIZE(rng_seed) - i);
> +
> +		/*
> +		 * A zero return value means that the guest is under attack,
> +		 * the hardware is broken, or some other mishap has occurred
> +		 * that means the RNG cannot be properly rng_seeded, which also
> +		 * likely means most crypto inside of the CoCo instance will be
> +		 * broken, defeating the purpose of CoCo in the first place. So
> +		 * just panic here because it's absolutely unsafe to continue
> +		 * executing.
> +		 */
> +		BUG_ON(longs == 0);

BUG_ON doesn't necessarily panic. If you want panic, use panic.

-Andi


