Return-Path: <linux-kernel+bounces-51527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303B7848C33
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633E61C2274F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DB714284;
	Sun,  4 Feb 2024 08:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N3ALNsLK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED9C1426B;
	Sun,  4 Feb 2024 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707035624; cv=none; b=gqQK+ob9p+oQbYbr16Q5bJhAWVSOAY8WoAuRYF3GvWg6IKsxEFF9XCY74SWicCH8CWZ6/uQslfC/DIHRI8+AhbeXBiurz4sd3hT0MHfsNYfe4ynDbVkt59e6HUm3FIIdZq4gC83nFo/th9Q9E2DtLfWJEcnAUzlu2KWcpQsbj1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707035624; c=relaxed/simple;
	bh=6hnOSJLUGircKMBizQ5z9dUDIidd26XLeYApieCrnlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i53u2/k7TxxEQR7zunfT4FyP2rALKSNviCKE8+ej6t7WrBMkKrMoQPg4rP5himX8mtQVLMEx93lL/ltg+PUzeZawggJfLogmUMPbjtPof21ettspzzeQaOTnpqC2v3sYSQwJwyPsaHLH/L2L/lAGCUsk9no1t8Psc57nAvgyPIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N3ALNsLK; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707035623; x=1738571623;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6hnOSJLUGircKMBizQ5z9dUDIidd26XLeYApieCrnlA=;
  b=N3ALNsLKSUQq2kw1m+mJNidksnRm5BZh8FCtmy4QJ3W6Z83JHrdNPIWQ
   iLY+wZJWuIHbVae+fz7kbZaGzk+wxPKHYW0sI4BXIJEzP7xGZjs1yJGly
   h39f+pVjSnQt5W8BOSmCxS7ks7I8O7NY3xt8ltDOGMi4TpLAUbf6D38DA
   UhjG7kQwGVWJt2wpDIFY3vlb3RWdAd52dRTGYET9alYKfRTLlW1cTFhQ+
   qOw4tQi8kGZatm4wKpwmd4cS7Aup4dQ+9vNuCppvPpOKwMZqgbag2lR9s
   neMLhgIoVxQOKLnJCWplKeaYohgLDjbi9m1BnVyRod0rFC8BCHh8LnOlE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="25823114"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="25823114"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 00:33:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="781505"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa008.jf.intel.com with ESMTP; 04 Feb 2024 00:33:38 -0800
Date: Sun, 4 Feb 2024 16:30:05 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Kris Chaplin <kris.chaplin@amd.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Charles Perry <charles.perry@savoirfairelinux.com>, mdf@kernel.org,
	"michal.simek@amd.com" <michal.simek@amd.com>, hao.wu@intel.com,
	yilun.xu@intel.com, trix@redhat.com,
	krzysztof.kozlowski+dt@linaro.org, bcody@markem-imaje.com,
	avandiver@markem-imaje.com, linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: fpga: xlnx,fpga-slave-selectmap: add DT
 schema
Message-ID: <Zb9LDQP3xzrv6LWr@yilunxu-OptiPlex-7050>
References: <20240129225602.3832449-1-charles.perry@savoirfairelinux.com>
 <20240129225602.3832449-2-charles.perry@savoirfairelinux.com>
 <9b0680b6-1952-41d3-82f4-88c60469dc3a@linaro.org>
 <471d9438-e2c0-4881-8ace-778c9d14669c@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <471d9438-e2c0-4881-8ace-778c9d14669c@amd.com>

On Wed, Jan 31, 2024 at 11:03:25AM +0000, Kris Chaplin wrote:
> Hello Krzysztof,
> 
> On 30/01/2024 16:09, Krzysztof Kozlowski wrote:
> 
> > > +
> > > +description: |
> > > +  Xilinx 7 Series FPGAs support a method of loading the bitstream over a
> > > +  parallel port named the slave SelectMAP interface in the documentation. Only
> > > +  the x8 mode is supported where data is loaded at one byte per rising edge of
> > > +  the clock, with the MSB of each byte presented to the D0 pin.
> > > +
> > > +  Datasheets:
> > > +    https://www.xilinx.com/support/documentation/user_guides/ug470_7Series_Config.pdf
> > 
> > I am surprised that AMD/Xilinx still did not update the document to
> > modern naming (slave->secondary).
> 
> Thank you for bringing this up.
> 
> We are moving away from using non-inclusive technical terminology and are
> removing non-inclusive language from our products and related collateral.
> You will for some time find examples of non-inclusive language, especially
> in our older products as we work to make these changes and align with
> industry standards.  For new IP we're ensuring that we switch and stick to
> inclusive terminology, as you may have seen with my recent w1 driver
> submission.
> 
> SelectMAP is a decades-old interface and as such it is unlikely that we will
> update this in all documentation dating back this time.  I shall however
> look to understand what is planned here for active documentation and new
> driver submissions.

Yes, I need review from AMD/Xilinx side. Especially the HW parts, and
some namings of variables, e.g. if xilinx-core is proper for what products
it supports, and won't be an issue in future.

Thanks,
Yilun

> 
> regards
> Kris
> 

