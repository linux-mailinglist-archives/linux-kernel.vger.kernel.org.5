Return-Path: <linux-kernel+bounces-57927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 056DE84DF18
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 288CD1C2612C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC566F538;
	Thu,  8 Feb 2024 10:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FusfIhoA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ABA6E2DB
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 10:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707389802; cv=none; b=b+6rp6mbObOIvWlNdCBX404HwajX+4cmhSmgCylRYrSYJlMdrsPfydiE5w4CloB+hEaNTtsPpiB9pbwUrlfkHxeoZys977hOZcRjpzNxTIaq7dW/JMrpb5Bf60e64H6cM1aEUf0z3FpnpDMQyH1Y0u+rxtzZcxmhRBjvCEsQz70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707389802; c=relaxed/simple;
	bh=1Xztb13hDcGIaM6t06UVkL3GSZDBP/g0Kc/asZOQ/fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPC9pSIBb+HGoPB5+emp1WWFldExf5xQK2CVrWnCc6ZZn6yatBp7wPbZ5CBinTnzXl9hyjwk0/ykAMiOIEWOtN4CrAM8fRH8D1MGG2ZiE3VIcWkptk8uixNUZO6kylYWd+FVHUszcQ9BRx9xNYi7xPVLlI4yPbpdLiogb3wrmsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FusfIhoA; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707389801; x=1738925801;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1Xztb13hDcGIaM6t06UVkL3GSZDBP/g0Kc/asZOQ/fc=;
  b=FusfIhoASHrhOfpv16iPo2KSKuHkuxE0DCsht2zn3b+t7D+46M5Qf5C8
   PVQ+Rch02ILvFKT85G9KSEPPQ7POvxzk1x2MOkf30pWbCFxGz6F9YMgR8
   XwGdvaXcSAnUZ/jrAbebYTRIEIGy0oGeawh8vtrn6uuMrH7L3E/Ivj5BU
   lPJUA4NsEDKtSfB4we2NKXIT76kDNjOTmL1zWyDAoAxYlma7XA/8m/zES
   eWYs5vZnQs03DdZwjmjyVV+afvdzsqlziHAHvm+JSq7YHqr9TwgRCCOyB
   klapp5Mb05SKUY/WhgleFhtc52WKAv4vyNTCrTpXob6uaZXviUWsaaIb2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="11772026"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="11772026"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 02:56:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="910313917"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="910313917"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 02:56:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rY24y-00000002r9y-0xmi;
	Thu, 08 Feb 2024 12:56:28 +0200
Date: Thu, 8 Feb 2024 12:56:27 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Howard Yen <howardyen@google.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, broonie@kernel.org,
	james@equiv.tech, james.clark@arm.com, masahiroy@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2] dma-coherent: add support for multi coherent rmems
 per dev
Message-ID: <ZcSzW1kFZIZ_f759@smile.fi.intel.com>
References: <20240205072312.2342188-1-howardyen@google.com>
 <ZcDPn5eLvMwpb7N1@smile.fi.intel.com>
 <ZcJTkQFcVhcGC52Z@smile.fi.intel.com>
 <CAJDAHvYYUcn2HL1QTSG-KA0QcuAOotk5hY4cpuasOu_H=X-V0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJDAHvYYUcn2HL1QTSG-KA0QcuAOotk5hY4cpuasOu_H=X-V0A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 08, 2024 at 03:53:37PM +0800, Howard Yen wrote:
> On Tue, Feb 6, 2024 at 11:43 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Feb 05, 2024 at 02:08:00PM +0200, Andy Shevchenko wrote:
> > > On Mon, Feb 05, 2024 at 07:23:00AM +0000, Howard Yen wrote:

..

> > > > @@ -18,15 +18,9 @@ struct dma_coherent_mem {
> > > >     unsigned long   *bitmap;
> > > >     spinlock_t      spinlock;
> > > >     bool            use_dev_dma_pfn_offset;
> > > > +   struct list_head        node;
> > >
> > > Have you run `pahole`? Here I see wasted bytes for nothing.
> >
> > On top of that one may make container_of() to be no-op, by placing this member
> > to be the first one. But, double check this with bloat-o-meter (that it indeed
> > does better code generation) and on the other hand check if the current first
> > member is not performance critical and having additional pointer arithmetics is
> > okay.
> >
> > > >  };
> 
> I'm trying to re-org the members as below
> 
> from ===>
> 
> struct dma_coherent_mem {
> void *                     virt_base;            /*     0     8 */
> dma_addr_t                 device_base;          /*     8     8 */
> unsigned long              pfn_base;             /*    16     8 */
> int                        size;                 /*    24     4 */
> 
> /* XXX 4 bytes hole, try to pack */
> 
> unsigned long *            bitmap;               /*    32     8 */
> spinlock_t                 spinlock;             /*    40     4 */
> bool                       use_dev_dma_pfn_offset; /*    44     1 */
> 
> /* XXX 3 bytes hole, try to pack */
> 
> struct list_head           node;                 /*    48    16 */
> 
> /* size: 64, cachelines: 1, members: 8 */
> /* sum members: 57, holes: 2, sum holes: 7 */
> };
> 
> 
> to ===>
> 
> struct dma_coherent_mem {
> struct list_head           node;                 /*     0    16 */
> void *                     virt_base;            /*    16     8 */
> dma_addr_t                 device_base;          /*    24     8 */
> unsigned long              pfn_base;             /*    32     8 */
> int                        size;                 /*    40     4 */
> spinlock_t                 spinlock;             /*    44     4 */
> unsigned long *            bitmap;               /*    48     8 */
> bool                       use_dev_dma_pfn_offset; /*    56     1 */
> 
> /* size: 64, cachelines: 1, members: 8 */
> /* padding: 7 */

Which seems better that above, right?

> };
> 
> Looks like there is about 7 bytes padding at the end of the structure.
> Should I add __attribute__((__packed__)) to not add the padding?

No, __packed is about alignment, may give you much worse code generation.
With list_head member first you might get better code from the original,
check it with bloat-o-meter.

-- 
With Best Regards,
Andy Shevchenko



