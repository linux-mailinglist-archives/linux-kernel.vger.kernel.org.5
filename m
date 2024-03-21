Return-Path: <linux-kernel+bounces-110532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81367886038
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0CC5B21923
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ABD1332BB;
	Thu, 21 Mar 2024 18:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LjblWkn4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14C38613B;
	Thu, 21 Mar 2024 18:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711044191; cv=none; b=L57npTFC1/kvL3zKJXmSIDc+tb8TA7PGUMQYZEYZs2gg9NealoUK8Jax71jYsFkNRgwhqU88zCudTnhSmeK2bJFOEhObgRVuf91a1QRjm322kWIeF/vrOvz6xrmeu0aE+NSN51zIy03q7+9wHbqMD+rK2/1mG6cGH0Xt9EPaIxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711044191; c=relaxed/simple;
	bh=cpK068KVvFXrGJJCmc7jXbXiOVvPQ+oU7A4+RLoU+Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foUGVIkfuTXwfNxmBI+ipS6iM8H2Seev4DCEe8ToO6SPXMb9eUKWmG3rXARWEel2JLFO3KQxmeRtuSn1sUcfWhVkXNhZor7NyegkizecCY+iTRSlQwieSRclzUwsEUMdNxRyyRMLAwHn9EcEPu/qIjxFLicBWEbxvxrYb00rVR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LjblWkn4; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711044190; x=1742580190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cpK068KVvFXrGJJCmc7jXbXiOVvPQ+oU7A4+RLoU+Qw=;
  b=LjblWkn46DoJ4D30T1Q4+Xd2HPvwa1M93IlbrFEIGc4mVKHokGBICI3L
   k1DV7xeY8QPHGYUMy0tVVOBiZnxjfeftq4YU77n1MWAnsZ/BEAMIY9/M7
   oaH4WY8SApKWwNspi8MOYAtUd9IKT4dY70kznKAf2nW1rZ7r8tAImk8ik
   xwyoD0fAxtGAxRseivGItDo6DzvJ2ee3HGygKUfqQaF5KYv+fX1soZP5k
   nyhCpxkMqF8PNDNd0LYoU3ljR1uGPC8/2x0idbHxZNPJ7G/ykfxpeVyNh
   Bn02mls4QgT04iL1Cs6qIjrvVbGU323Or3xdjJBpT8/070h2lmqx61438
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6180634"
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="6180634"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 11:03:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="914717075"
X-IronPort-AV: E=Sophos;i="6.07,143,1708416000"; 
   d="scan'208";a="914717075"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 11:03:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rnMkm-0000000ExcL-2Dkx;
	Thu, 21 Mar 2024 20:03:00 +0200
Date: Thu, 21 Mar 2024 20:03:00 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	kernel-janitors@vger.kernel.org, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	David Laight <David.Laight@aculab.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Cameron <jic23@kernel.org>,
	Julia Lawall <julia.lawall@inria.fr>,
	Kees Cook <keescook@chromium.org>,
	Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net] ice: Fix freeing uninitialized pointers
Message-ID: <Zfx2VL7xnj4rQoV8@smile.fi.intel.com>
References: <77145930-e3df-4e77-a22d-04851cf3a426@moroto.mountain>
 <d2b1f3bd-42f1-483b-916e-3735b39a30e1@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2b1f3bd-42f1-483b-916e-3735b39a30e1@web.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 21, 2024 at 06:59:00PM +0100, Markus Elfring wrote:

…

> > +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > @@ -941,11 +941,11 @@ static u64 ice_loopback_test(struct net_device *netdev)
> >  	struct ice_netdev_priv *np = netdev_priv(netdev);
> >  	struct ice_vsi *orig_vsi = np->vsi, *test_vsi;
> >  	struct ice_pf *pf = orig_vsi->back;
> > +	u8 *tx_frame __free(kfree) = NULL;
> >  	u8 broadcast[ETH_ALEN], ret = 0;
> >  	int num_frames, valid_frames;
> >  	struct ice_tx_ring *tx_ring;
> >  	struct ice_rx_ring *rx_ring;
> > -	u8 *tx_frame __free(kfree);
> >  	int i;
> >
> >  	netdev_info(netdev, "loopback test\n");
> 
> How do you think about to reduce the scope for the affected local variable instead
> with the help of a small script (like the following) for the semantic patch language?
> 
> @movement@
> attribute name __free;
> @@
> -u8 *tx_frame __free(kfree);
>  int i;
>  ... when any
>  if (ice_fltr_add_mac(test_vsi, ...))
>  { ... }
> +
> +{
> +u8 *tx_frame __free(kfree) = NULL;
>  if (ice_lbtest_create_frame(pf, &tx_frame, ...))
>  { ... }
>  ... when any
> +}
> +
>  valid_frames = ice_lbtest_receive_frames(...);

I believe you don't understand what the scope of the above can be.

-- 
With Best Regards,
Andy Shevchenko



