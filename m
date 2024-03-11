Return-Path: <linux-kernel+bounces-99231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B83878554
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8151B21B97
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1689856473;
	Mon, 11 Mar 2024 16:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ez11vfOu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FB656443
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710174070; cv=none; b=mH7sXhq07caDp0B7w5qbSQ5KYiqB4dDWVMboBx3wDps5WfiylFKETp6SEf9aCURjXShPzXopp46+Z6R2WOFdqqa9/qe1ACk5HKqzKg8FrzmLryD7jmQZx9EHWvRZI9ir/KzILdyxtQgiqcHjRs5H1CrTZxoPQlWfJpMs7VQcFVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710174070; c=relaxed/simple;
	bh=qgnk+NurW/dc0O021XzFvbekQGoW8NW7JLtzZnW170g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+O7zSdwJu6vlcRhf8m7scmqX/tVtDhK8CNsMJO1JKoH7jEMg9sYO3JY+IuMDEyrcNi791fDrf5IEIs0NsHrCbvmYRKBNs0Y5bq9JmYFmPzHMNd1eIOTXv2Cn+Rzw41UOg+aB/61gZnmXr5XXkQC+nSlE0wfckwhNhDG6JpSHM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ez11vfOu; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710174067; x=1741710067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qgnk+NurW/dc0O021XzFvbekQGoW8NW7JLtzZnW170g=;
  b=ez11vfOudd5YGLWRK5lygLoMmgogG6DPlGOFLNIkSI2PYpRntwk0m5MO
   zPA3OAKylM7RDCubOiG3hFwtCyw8GqLGuZSMhp8djnRyByau6stQHEZFT
   01jGtvbY8nCuMbOWMRbBYy+x+utWoXIjTIa3sXcB6ehbgzXdnOGnBKTq8
   9w+FQFT7V7MP44HJmiM7GtjvE8KbbCdNZy+31wCAjmou7r0tAstWVathc
   k4hI/MlJr+xYUcpZcbHeZ55NfmpTjRYzO87GWHfZoNmNoD7caOVlbR+oZ
   gn7vdsJGBU+L49g/tNRg3z7HOYH4FDZMJi/xFLvBOYaVKn+kXyc67FnF7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="27317291"
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="27317291"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 09:21:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="15710843"
Received: from cindreic-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.141.11])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 09:21:02 -0700
Date: Mon, 11 Mar 2024 18:20:52 +0200
From: Aapo Vienamo <aapo.vienamo@linux.intel.com>
To: Michael Walle <mwalle@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] mtd: core: Don't fail mtd_device_parse_register() if
 OTP is unsupported
Message-ID: <xeqscncwirfaz77mtpcvkueo5xto7vis5khr3uwclcx4sfx6eb@35j3grcqrzo2>
References: <20240307130418.3131898-1-aapo.vienamo@linux.intel.com>
 <20240307130418.3131898-3-aapo.vienamo@linux.intel.com>
 <CZQZXAB2GOCY.12YVJ6CRGG26B@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CZQZXAB2GOCY.12YVJ6CRGG26B@kernel.org>

Hi Michael

On Mon, Mar 11, 2024 at 03:38:17PM +0100, Michael Walle wrote:
> On Thu Mar 7, 2024 at 2:04 PM CET, Aapo Vienamo wrote:
> > Handle the case where -EOPNOTSUPP is returned from OTP driver.
> > +	/*
> > +	 * Don't abort MTD init if OTP functionality is unsupported. The
> > +	 * cleanup of the OTP init is contained within mtd_otp_nvmem_add().
> > +	 * Omitting goto out here is safe since the cleanup code there
> > +	 * should be no-ops.
> > +	 */
> 
> Only if that's true for both the factory and user OTP area.

I'm not sure I follow. I'm not seeing a path in mtd_otp_nvmem_add()
that would result in either mtd->otp_user_nvmem or mtd->otp_factor_nvmem
needing to be cleaned up by the caller, if an error is returned, if
that's what you are referring to.

> Also, you'll print an error message for EOPNOTSUPP, although that is
> not really an error. Is that intended? 

Well, when we hit this, the functionality of the SPI memory itself is
degraded in the sense that the OTP functionality is not available. What
would you suggest?

> 
> >  	ret = mtd_otp_nvmem_add(mtd);
> > -	if (ret)
> > +	if (ret && ret != -EOPNOTSUPP)
> 
> Maybe there is a better way to handle this, like controller
> capabilities instead of putting these EOPNOTSUPP checks
> everywhere? I'm not sure.

Trying to come up with clear semantics for a capabilities flag to solve
this is difficult. The issue is that on the SPI controller side, the
limitation stems from the really strict set of opcodes that are allowed.
For example, we already hit an error with the 0x35 (read configuration
register) not being on the set of allowed opcodes. While this
instruction is used by the OTP code, it's not a strictly OTP specific
operation.

If there was a flag that would signal OTP support, I think it would have
be defined as "the controller supports all operations that are
performed by the OTP code", which sounds brittle. The other way around
would be to have a really fine-grained set of flags that the MTD core
would check, but that feels tedious and error prone as well.

Best,
Aapo

