Return-Path: <linux-kernel+bounces-128092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F479895602
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF4951C2244A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2920C85958;
	Tue,  2 Apr 2024 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N5ibYs2s"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7E585283;
	Tue,  2 Apr 2024 14:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066457; cv=none; b=M4mQHRf46Ui1zNzm8Db5XFPH8EG3oXkAiKoCqC2vEtAnaMzqzehcjdaNXiAhHZ+46R/6F5DmohZtqr0aKBHk/t1o/92PniNO+QtPCXUa9JhgQL6bJ/FuJzECEkaQPHOnzW5nacOI2AlUsODi9/Ps3+WYaOhRru9g+NwUVOw+fhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066457; c=relaxed/simple;
	bh=sx/n5YT2uP/IXACSVATwzxQmHEWq2jAIn4wcthue3w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjB4rMxpGm5qT8LRlawiOLizfp11f0T9LdifG8pDTsAfpX3DtkGTHDs1rtF1sBFIOQkwUsri2ZZztEU1h2AkexqLI/SJenUxfG4zoeSuM6CulQ6hOHfOTBd5xoFpJz7h2uzjnP+OpAJ1pk2dCUijs9dE2Qx8YG3MoWAOjouofew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N5ibYs2s; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712066456; x=1743602456;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sx/n5YT2uP/IXACSVATwzxQmHEWq2jAIn4wcthue3w8=;
  b=N5ibYs2sURqHp6AZfR/wq0oNmNWgpmveYysbNlruzMAZM6SX7X/Z3/I7
   B8BVgeU1oFP+5lRCfODIdvtj2YYaQVjKIiW56iWszix+3hx9bUJdv5TBr
   20QGlGX4C3nyOUlQu9GfzdQwdGJB6n7we2FHaRGpcQJiQyR7nJKx30OYq
   E7/LJtqZRIXFPgiLcyOhxUYMERqy2shdaTWv1quLiu44lMHvdSVDOta1C
   BVg7ShLQciu/QI+k+k5Qy+RZqLxP3cUfMeJE1xuDx1IV9so/PdiGC0570
   dbSc15e0ZdOPAKVy+t3zLE1MsE7ZeeSppmUDTp7zCUiTG0jiLAf1g7XI0
   g==;
X-CSE-ConnectionGUID: APbHvTPQRYKxa74cvMfayQ==
X-CSE-MsgGUID: q2V2BQzWTQuq00iU30FrZw==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="18687660"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="18687660"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 07:00:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="915142011"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="915142011"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 07:00:52 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rreh0-00000000pJ9-0jG6;
	Tue, 02 Apr 2024 17:00:50 +0300
Date: Tue, 2 Apr 2024 17:00:49 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Lee Jones <lee@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the mfd tree with the pci tree
Message-ID: <ZgwPkWB5QBUDX2cj@smile.fi.intel.com>
References: <20240402113116.70d6a885@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402113116.70d6a885@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 02, 2024 at 11:31:16AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the mfd tree got a conflict in:
> 
>   drivers/mfd/intel-lpss-pci.c
> 
> between commit:
> 
>   5133224938b9 ("mfd: intel-lpss: Use PCI_IRQ_INTX instead of PCI_IRQ_LEGACY")
> 
> from the pci tree and commit:
> 
>   e42199bf13d4 ("mfd: intel-lpss: Switch over to MSI interrupts")
> 
> from the mfd tree.
> 
> I fixed it up (I just used the latter)

This is correct fix, thank you!

>	and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

-- 
With Best Regards,
Andy Shevchenko



