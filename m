Return-Path: <linux-kernel+bounces-161959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2A68B53C5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE8941C21685
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC9A29428;
	Mon, 29 Apr 2024 09:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C17eIb6x"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E862F2941E;
	Mon, 29 Apr 2024 09:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714381462; cv=none; b=DBWWw6DVf4yhrLem4FS2unWYyGhcUZuJuFi1sZfMRnyfXM1y1bHgyrERvBuLTw042/1PuEbLuvj/1Yo3z6gUu4Qg7hHULzHIIjlpdhvdsfMmgfWY6nflFimD+Noz/aS/vv7fk2EBh8iDmTL/Ho8fzdxwKBp52P2J+8Xqhai4A6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714381462; c=relaxed/simple;
	bh=TXSIpzhjWOqDlZ9ZndMS8MVcT2vSwGprAlf2ys/5PIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAH1PTnmsdaE/FwFyL2wWzqGdpdO0OwvSS22RLlPhszzYIbCOm8uqjn+yIvmYEeXeoqoYimF41Z2SpAkmA3qsZzL/huJVi53LlMcT/xTUSBertwf4PNn3AlAbuI4D5lAURFRZoKB9KsmzzzTpvQw7jP0oPCoLAqeHQxASqGJB0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C17eIb6x; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714381461; x=1745917461;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TXSIpzhjWOqDlZ9ZndMS8MVcT2vSwGprAlf2ys/5PIM=;
  b=C17eIb6xdRruGDSzx7yTDGmjilZNUvAWgXp/+hBeuM5U0PBnMrzzFiIH
   AR/e6qJzyXq/soLvo0YS19zEfri+3YFkLoV6Mz5ORWafiUO4zXquEAF2b
   EpZ02dn2smMvZrJmCAyveg32bUkinAN2iREPHybtDnd8mZtwGHBbD2HlY
   NJfK8HvDkQjhWOtZYpGDdzhJuz3rbfpj3jCEXTWWV72kGNATUTUSBZtPF
   S2wt6NFTzXF9SpyusOMSdxSSF0Nbt27Yjhz07OB8l1HezxqWoV1WtNnYB
   eOSK+mH1UDe4hHriTEhV2yAdvLpWlPn5w2djFoVSorkT8w02KnlnubT60
   A==;
X-CSE-ConnectionGUID: Ld+zyqrrQvKehUb0X3SeGw==
X-CSE-MsgGUID: sVNa4dxZRhO7At5HJYlpnw==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="13821464"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="13821464"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 02:04:20 -0700
X-CSE-ConnectionGUID: qt6AXxPETF6DdR1M12fUcA==
X-CSE-MsgGUID: khqWJ2hNThe2JHDXARiQPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26122823"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 02:04:17 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 4C59311F830;
	Mon, 29 Apr 2024 12:04:15 +0300 (EEST)
Date: Mon, 29 Apr 2024 09:04:15 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Benjamin Mugnier <benjamin.mugnier@foss.st.com>
Cc: R Sundar <prosunofficial@gmail.com>, sylvain.petinot@foss.st.com,
	mchehab@kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com,
	Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH linux-next] media: i2c: st-mipid02: replace of_node_put()
 with __free
Message-ID: <Zi9ij_9vW8ADl2fC@kekkonen.localdomain>
References: <20240427095643.11486-1-prosunofficial@gmail.com>
 <d2432381-827f-4825-a450-9954f8291576@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2432381-827f-4825-a450-9954f8291576@foss.st.com>

Hi Benjamin,

On Mon, Apr 29, 2024 at 10:52:34AM +0200, Benjamin Mugnier wrote:
> Hi,
> 
> Thank you for your patch.
> 
> On 4/27/24 11:56, R Sundar wrote:
> > Use the new cleanup magic to replace of_node_put() with
> > __free(device_node) marking to auto release and to simplify the error
> > paths.
> > 
> > Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> > Signed-off-by: R Sundar <prosunofficial@gmail.com>
> 
> I was not aware of this kind of auto release mechanism. Thanks for
> bringing that to my eyes.
> 
> Now I looked in /drivers/media and couldn't find such structure. All
> drivers seem to follow the goto error_of_node_put style.
> As I'm unsure if we want to introduce such magic, could either Laurent
> or Sakari comment on this ?

It's new and little used so far. I don't have concerns using it, although
it's mostly useful in cases where all exit paths release the same resource.

-- 
Kind regards,

Sakari Ailus

