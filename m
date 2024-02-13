Return-Path: <linux-kernel+bounces-63920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEE885365F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DE721C2225B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFC15F866;
	Tue, 13 Feb 2024 16:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z0kyfBtf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F905FB8D;
	Tue, 13 Feb 2024 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842628; cv=none; b=Ht5Hy4VmfVjyfBArI7tkdbexF3XlK7bWkczYjP2A2cFdg6uV/Jb5DMC7uQPS7+JhZMfj56xfCTjt1J0+t1Rv29YyDhwIzGz07EUrRAbmh9w57Pr6Las9asYig2LAoi7tENaTJm50Ess5QyxMIkCw68L1nGCge8rhRz0PilA00Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842628; c=relaxed/simple;
	bh=IVfpppykE2plUKwWtkp2z9oyNL8LDEqus0ZAW9zqGZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvEahupiFP4BwG5LlZarjiqLNSJHEib1RR4rxG8pgtWTlouQ2/iF+hbtFOkGeGTaiqVVkuODH7aDF5fyO1TtUslgQ6iWWRAZSg8NQB6tWABLSQzU5yUj0ZxHgpfpbPii8sl+OqvKz7xhUcagqN69Y8w4x5sMerVXc1KyVRDr2ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z0kyfBtf; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707842627; x=1739378627;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IVfpppykE2plUKwWtkp2z9oyNL8LDEqus0ZAW9zqGZE=;
  b=Z0kyfBtfwEDFLulQ4PW1vqSBijq4o5cgv2g7RbwTZsZ0F+6lVRqZFtJZ
   Xfiypjv7BLLRh8CMnrNqpc6YkJUw6H2Ms6I93VTtTmXwsc+VwOPmWp0Qc
   OfviAeufVT2IHS9zPKDePFHA3/mAJkgIuw47c7IdRJ4WESQoGSfVVQ0g5
   udG6sIHYlKUJw2GKeZftYX6N6z6gFUrpEqtX5e50GJf/d6QOGFlUgaiWB
   Q8maci8v76PPZnybeYi0uwr72azu6BDv9aLHEL8DTMm/K3a2AV5EvuEpk
   02TUDy4gXHo55Jg/amyiNnR7IuKEw0lllIWtZDkD3vRitfcjDxMGX3z5E
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="4825908"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="4825908"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 08:43:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="911830782"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="911830782"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 08:43:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZvsh-00000004Gee-36D7;
	Tue, 13 Feb 2024 18:43:39 +0200
Date: Tue, 13 Feb 2024 18:43:39 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Ralf Schlatterbeck <rsc@runtux.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: auxdisplay: hit, hd44780: drop
 redundant GPIO node
Message-ID: <ZcucO8R8ZOtR38jl@smile.fi.intel.com>
References: <20240212083426.26757-1-krzysztof.kozlowski@linaro.org>
 <CAMuHMdU-c5_Z2AMNtNH4Cc4JUrn+oKU-1CumEOAP6=5Zomcj_A@mail.gmail.com>
 <2922eece-5486-4eff-af99-f7060cb61d17@linaro.org>
 <20240212115837.efz73yxinkysdmgh@runtux.com>
 <e2a5b005-7916-4296-b072-c24efd4b3357@linaro.org>
 <Zcogl6tqbMdQldKA@smile.fi.intel.com>
 <d603a588-d312-486e-b6c9-647a6b90580c@linaro.org>
 <20240213161905.GA1459669-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213161905.GA1459669-robh@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 13, 2024 at 10:19:05AM -0600, Rob Herring wrote:
> On Mon, Feb 12, 2024 at 02:59:02PM +0100, Krzysztof Kozlowski wrote:
> > On 12/02/2024 14:43, Andy Shevchenko wrote:
> > > On Mon, Feb 12, 2024 at 02:38:27PM +0100, Krzysztof Kozlowski wrote:
> > >> On 12/02/2024 12:58, Ralf Schlatterbeck wrote:

..

> > >> Anyway, binding examples should not be collection of unrelated
> > >> solutions, because then we should accept for each device schema several
> > >> other variations and combinations.
> > > 
> > > Is this documented?
> > 
> > Yes, writing schema says what the example is. We repeated it multiple
> > times on multiple reviews, we made multiple commits multiple times and I
> > briefly mentioned it also in my talks.
> 
> While yes, this is the guidance, I think this case has provided enough
> justification to keep it. Let's move on please.

Thank you, Rob.

Krzysztof, can you send v2, I'll apply it to the tree?

-- 
With Best Regards,
Andy Shevchenko



