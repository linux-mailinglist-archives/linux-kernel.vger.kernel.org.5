Return-Path: <linux-kernel+bounces-130121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC245897450
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6722128700C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19B414A4C8;
	Wed,  3 Apr 2024 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oHUUxulc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2D6149DE1;
	Wed,  3 Apr 2024 15:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159217; cv=none; b=DKgZgNlqdoUq3bemhF19nU1lH24s3tkgldD6T9lIKSPxbRXm5qoJS8SDdPNsv++i2/qqWkio1DhV3KiGrrbZG1zGWuIXVxvDtx+PUAWSk/gTJCQZ32gBQfXC/MejQ6i67He4f4S7lCvgY4RV7iEKESe9Uwv1AYlXAKDtFFP4A/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159217; c=relaxed/simple;
	bh=XiYKyw+AJCXchrW+Wi7lqiXPYWcBscqK01H9Iv3gS30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HG64FuEOiJ3K6w5ENQ5AleX/CO5u2LKhSGZYfxu4CrQkRxB0McmEvjNK81fXVpN5g2jQ6ETrbRfO4JRH26vKX1hPYabuZlNdNMZlL7h/74u/a2wuQ8Pu2/0aqTU0i7AwIAjZvDHL+znh2nPVpVGhrgFx4gmQObqy/UcVfKZm7jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oHUUxulc; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712159215; x=1743695215;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XiYKyw+AJCXchrW+Wi7lqiXPYWcBscqK01H9Iv3gS30=;
  b=oHUUxulcunXc19oWfNx0NKZFpMw1euCvoGWDGhDnj9OhyrgkpfMWvEw4
   YKWrr3/Y3al+3p599ax/io3gmUszdtnt9JnFCqZH6UOObfzC02K1qMygh
   SrQkd76EZk+IEa65nFtwVyCZMRhdQCWXuPe++7xWtwVF69RCQINudiVp1
   Mkkrq3YH7QgTOwKe1SM+fo7Wr5TiWQ+8GpOZAmz7S6xjt+vjaKiNGaCqN
   WuOu6nLNkHXIe0YZ4XgdcrR7eZaSMeOQNttA+CvWNNYhbfUfseJ7CWFc9
   E8l3+T38AO4Xrq/aXP6wPwb80qMYPIgdgkbfzWG7ovzjkrwdElGT+Vgqs
   g==;
X-CSE-ConnectionGUID: S9RLrCehTUKrWXVaYY4+AQ==
X-CSE-MsgGUID: v16yJMztTtGy3gQZ7g8fpQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="17972612"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="17972612"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 08:46:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="915186749"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="915186749"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 08:46:30 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rs2ol-00000001A3N-3xYM;
	Wed, 03 Apr 2024 18:46:27 +0300
Date: Wed, 3 Apr 2024 18:46:27 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	linux-fpga@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v1 1/1] fpga: dfl: pci: Use pci_find_vsec_capability()
 when looking for DFL
Message-ID: <Zg1506TfukWTGRVa@smile.fi.intel.com>
References: <20211109154127.18455-1-andriy.shevchenko@linux.intel.com>
 <8ccc133a-fb47-4548-fee3-d57775a5166d@redhat.com>
 <YYq4fSRoyzFE4Vei@smile.fi.intel.com>
 <39ac1f40-66ab-6c7e-0042-8fcdc062ed00@redhat.com>
 <YYuBz0tdduAk1c/6@smile.fi.intel.com>
 <3106bd57-9144-6a4d-8ad9-3ebf804018ab@redhat.com>
 <CAHp75Vf16mH4KQ232rip9MPLoSE1TmJ_jeiwVUzqxOH5b0RFJQ@mail.gmail.com>
 <Zg03BTubHLslIi_P@smile.fi.intel.com>
 <Zg1xZ+k8eZJwOs41@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg1xZ+k8eZJwOs41@yilunxu-OptiPlex-7050>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 03, 2024 at 11:10:31PM +0800, Xu Yilun wrote:
> On Wed, Apr 03, 2024 at 02:01:25PM +0300, Andy Shevchenko wrote:
> > On Wed, Nov 10, 2021 at 06:59:25PM +0200, Andy Shevchenko wrote:
> > > On Wed, Nov 10, 2021 at 2:28 PM Tom Rix <trix@redhat.com> wrote:
> > > > On 11/10/21 12:24 AM, Andy Shevchenko wrote:
> > > > > On Tue, Nov 09, 2021 at 10:27:58AM -0800, Tom Rix wrote:
> > > > >> On 11/9/21 10:05 AM, Andy Shevchenko wrote:
> > > > >>> On Tue, Nov 09, 2021 at 07:55:43AM -0800, Tom Rix wrote:
> > > > >>>> On 11/9/21 7:41 AM, Andy Shevchenko wrote:

..

> > > > >>>>> + voff = pci_find_vsec_capability(dev, PCI_VENDOR_ID_INTEL, PCI_VSEC_ID_INTEL_DFLS);
> > > > >>>> This may be a weakness in the origin code, but intel isn't the exclusive
> > > > >>>> user of DFL.
> > > > >>> This does not change the original code. If you think so, this can be extended
> > > > >>> later on.
> > > > >> I would rather see this fixed now or explained why this isn't a problem.
> > > > > This is out of scope of this change in a few ways:
> > > > >   - we don't do 2+ things in one patch
> > > > >   - the change doesn't change behaviour
> > > > >   - the change is a simple cleanup
> > > > >   - another vendor may well have quite different VSEC ID for DFL
> > > > >
> > > > > If you think that it should be needed, one can come up with it later on.
> > > >
> > > > Fixing a problem is more useful than a cleanup. The fix should come first.
> > > 
> > > What do you mean by that? The original code never worked with what you
> > > are suggesting. There is nothing to fix in terms of "fix". What you
> > > are proposing is a feature. And as we know the features are going into
> > > the kernel in a natural order, means fixes - priority 1, cleanups /
> > > refactoring as prerequisites to the feature enabling - priority 2,
> > > feature - priority 3, other cleanups and code improvements - priority
> > > 4.
> > > 
> > > That said, the proposed change definitely falls into category 2. It
> > > makes the proposed feature to be easily realized.
> > > 
> > > Also, do not forget that vendor specific stuff is _by definition_
> > > vendor specific, and the proposed feature is doubtful until you prove
> > > there is another vendor-id pair.
> > 
> > Interestingly that you included
> > 8607d9c1bd57 ("fpga: dfl-pci: Use pci_find_vsec_capability() to simplify the code")
> > without even letting me know...
> 
> I'm sorry. Apparently I forgot what we've discussed in 2021.
> 
> In 2021, I was waiting for some more comments although I was already
> good at your patch, but sadly I didn't follow up and missed it. In
> 2023, I was pretty sure no more comment and I could just apply.

The job is done and this is good. Thank you.
One thing less to carry for me :-)

-- 
With Best Regards,
Andy Shevchenko



