Return-Path: <linux-kernel+bounces-64975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B9F854557
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B3B292147
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E05F12B9E;
	Wed, 14 Feb 2024 09:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nU6797v1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1798A14A93;
	Wed, 14 Feb 2024 09:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903152; cv=none; b=sdMBuY9OUiv2n555OUEoLTrZMyDmJhAm3r2CbuikOafkZPdPGFuIiwClf8UUbmBETpnXDNFbgLjTCnJNShwV3htbTia87qQm458lZ9F8FhYL3JZhs6MN9bkWN8RA782bX84ePKCwz5gA2i4Okw+mSvoTj2+SxjoXz0Bu2GdbZuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903152; c=relaxed/simple;
	bh=sgHsCHxDoO5MTtQjA5HZm+TAMiYkv40VOYSxH54M9zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGsy30tp2JyrByWb1KjZbDPW5VgJ0QN35ge/IX2WllcmItoFCfOfJGVMkmySEV70RndalWiP8rhoqownFGVa8u35vBkAaOIDnoeqa5JUjbBj77znlg4vJNWqidmMTbZcNpZQuEU8iNkKpUYon8PwD6mQf9AA6aYSoLJpoIe2Ous=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nU6797v1; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707903150; x=1739439150;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sgHsCHxDoO5MTtQjA5HZm+TAMiYkv40VOYSxH54M9zo=;
  b=nU6797v17Rn6J/S4CVT0fMXk0cVMUCBHqbnM1OBU9KDlrEjcoKWfVHF8
   UH1S1Ijxb/+iLC+LtjeSbRHGdpVP4IOn5q6irVIC2SRgQwOcVg/wnatZF
   waOlaz7CiEeMSHplGuEndRCx76mTi8KEEsipwgQ1/O7Dz/IcbJDesoKcE
   vA0kVfM2TKOxtV4ZYQPrdt86fwYO765yu819pjeWQnau7eR3R2n+SuBn4
   zxAEFVkdRf44FbtHsUCScO8JbnUKP9xM/1CppEkDX6AyIj8nwVbIOT948
   6f9rUAsH4LsM7JbkjhRfY1l52xjznzQ+boZboIj8YVK1b3XH2urkXzRa4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="2303707"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="2303707"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 01:32:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935606727"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="935606727"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 01:32:27 -0800
Date: Wed, 14 Feb 2024 11:32:24 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: u.kleine-koenig@pengutronix.de, mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] pwm: lpss: drop redundant runtime PM handles
Message-ID: <ZcyIqEFufO39WMqn@black.fi.intel.com>
References: <20240212061037.4271-1-raag.jadav@intel.com>
 <20240212061037.4271-3-raag.jadav@intel.com>
 <91bbea2c-b6f7-48cf-b540-83c73750d1d2@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91bbea2c-b6f7-48cf-b540-83c73750d1d2@linux.intel.com>

On Wed, Feb 14, 2024 at 09:04:09AM +0200, Jarkko Nikula wrote:
> On 2/12/24 08:10, Raag Jadav wrote:
> > We no longer need empty runtime PM handles for PCI devices after commit
> > c5eb1190074c ("PCI / PM: Allow runtime PM without callback functions").
> > Drop them and let PCI core take care of power state transitions.
> > 
> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >   drivers/pwm/pwm-lpss-pci.c | 22 ----------------------
> >   1 file changed, 22 deletions(-)
> > 
> Will this patch cause a regression if applied without your another patch to
> the drivers/pci/pci-driver.c?
> 
> https://lore.kernel.org/linux-pci/20240212063233.5599-1-raag.jadav@intel.com/

Yes, I'll send out a v2 with updated commit message after the PCI
one is accepted.

Raag

