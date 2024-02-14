Return-Path: <linux-kernel+bounces-64825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5465885434C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86B81B22899
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A2C11706;
	Wed, 14 Feb 2024 07:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ejTcvIYm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FA210A25;
	Wed, 14 Feb 2024 07:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707894602; cv=none; b=PDGqvvhWsUQ4b8VbQmOLdeNSFXAIFHOfJWQFX9J700LgMJqmyZ9eyhjgUbckm4U3hkOQRmPUk5OCvPYJJHtMSKCAsBKvcr6OxXdxbLKfJ9Aenk4OHR2ae5JwFJnsho4rqCYXBerD/xZDZb3UNJKXfG0rzX/argjJu6pMF9BP97Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707894602; c=relaxed/simple;
	bh=OmZiqJBsNOZBfJ1AJN84aA24Z9t9LzxTDt3eDw44UCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UB7+Wl8AcPHd+ngPjAGusI69323HvBcjG9hNviawrb+x9Y9I4Kl6q1bST3a7BBZ4uW+LlG+If8cymahxDV/Ps4/dIA85YuAhX0DC/1/EoCk1oPrIJim2wKGrWaTqof71WV4PHDsO9hCxFT0MEpUxaM1glV/n2zi8XfLEMDJs96s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ejTcvIYm; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707894601; x=1739430601;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OmZiqJBsNOZBfJ1AJN84aA24Z9t9LzxTDt3eDw44UCA=;
  b=ejTcvIYmsflgRzAMM5YuwTspzWS/d44K4ikUCeLKIovt+n4MdPz4B/Kc
   SIjZNBWhJpQ7zSYE93KSyDLJc8KedmXwvKwscDB43qKxYjoZmHQurMohK
   u2f2u7Cqm/rUnsdZynbBGMMTqK7dJdzF8dOrMh3L8pUUhI3XAVVu4ER45
   Wo9K7tTSfW8ecJ3Kp54VrEiZhJxjPYOUxAUkR6MtmQ/UuWMScswiS5yJ7
   X4wCDVAixS13Ys0Smfql7DZAsHifquCLjXP1V5yBVX4mPT9mwTniIcncy
   3gW3pNCtpPYe9AyRfFotToqxpFwFr4B+Xg1AsbG6fg2nevqA7xNo9KMoP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1801212"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="1801212"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 23:09:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="3085562"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 23:09:57 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 34F8B11F86A;
	Wed, 14 Feb 2024 09:09:54 +0200 (EET)
Date: Wed, 14 Feb 2024 07:09:54 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: linux-next: manual merge of the pm tree with the pci-current tree
Message-ID: <ZcxnQvpEohaBUIPc@kekkonen.localdomain>
References: <20240214103008.0bb12069@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214103008.0bb12069@canb.auug.org.au>

Hi Stephen,

On Wed, Feb 14, 2024 at 10:30:08AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the pm tree got a conflict in:
> 
>   drivers/pci/pci.c
> 
> between commit:
> 
>   41044d536068 ("PCI: Fix active state requirement in PME polling")
> 
> from the pci-current tree and commit:
> 
>   c0ef3df8dbae ("PM: runtime: Simplify pm_runtime_get_if_active() usage")
> 
> from the pm tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

The change looks good to me.

Thanks!

> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc drivers/pci/pci.c
> index a532bf597e57,cb51c4079013..000000000000
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@@ -2361,36 -2522,29 +2361,36 @@@ static void pci_pme_list_scan(struct wo
>   		if (pdev->pme_poll) {
>   			struct pci_dev *bridge = pdev->bus->self;
>   			struct device *dev = &pdev->dev;
>  -			int pm_status;
>  +			struct device *bdev = bridge ? &bridge->dev : NULL;
>  +			int bref = 0;
>   
>   			/*
>  -			 * If bridge is in low power state, the
>  -			 * configuration space of subordinate devices
>  -			 * may be not accessible
>  +			 * If we have a bridge, it should be in an active/D0
>  +			 * state or the configuration space of subordinate
>  +			 * devices may not be accessible or stable over the
>  +			 * course of the call.
>   			 */
>  -			if (bridge && bridge->current_state != PCI_D0)
>  -				continue;
>  +			if (bdev) {
> - 				bref = pm_runtime_get_if_active(bdev, true);
> ++				bref = pm_runtime_get_if_active(bdev);
>  +				if (!bref)
>  +					continue;
>  +
>  +				if (bridge->current_state != PCI_D0)
>  +					goto put_bridge;
>  +			}
>   
>   			/*
>  -			 * If the device is in a low power state it
>  -			 * should not be polled either.
>  +			 * The device itself should be suspended but config
>  +			 * space must be accessible, therefore it cannot be in
>  +			 * D3cold.
>   			 */
>  -			pm_status = pm_runtime_get_if_active(dev);
>  -			if (!pm_status)
>  -				continue;
>  -
>  -			if (pdev->current_state != PCI_D3cold)
>  +			if (pm_runtime_suspended(dev) &&
>  +			    pdev->current_state != PCI_D3cold)
>   				pci_pme_wakeup(pdev, NULL);
>   
>  -			if (pm_status > 0)
>  -				pm_runtime_put(dev);
>  +put_bridge:
>  +			if (bref > 0)
>  +				pm_runtime_put(bdev);
>   		} else {
>   			list_del(&pme_dev->list);
>   			kfree(pme_dev);

-- 
Kind regards,

Sakari Ailus

