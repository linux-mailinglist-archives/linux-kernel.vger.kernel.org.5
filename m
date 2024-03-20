Return-Path: <linux-kernel+bounces-108545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EC9880C17
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB5D21C20310
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C95523770;
	Wed, 20 Mar 2024 07:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="hvE5SlOa"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DEB210FE;
	Wed, 20 Mar 2024 07:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710919951; cv=none; b=aIK8bvyze5/fdjR8r7f3qQ8CSKFf7KMkQy0lxcJZ5ZQlJf0dXqDLI4yrLbum7ksE/5Pql0qAWlj26Yfffg2CRMzmuGgoS2asCAc4qVwAXp5LH3UKCEHgUd5lhptFrGk38lLv88WZU3Gga/YD8+ORfMDQpZD3xbFC9/5bURzhiYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710919951; c=relaxed/simple;
	bh=W352MWh4bC/sCGnq6hRHMpiRENfzvwFGb/Q+kSMC+Cs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fe4XVgy0eNqIB36lbwUh4vDDXLd4E7kRyNZnEQdq6Xn6DgTUZ5kADaJgCmjjtLUk5h/0sT+CfjSUkS3z2zcZvqQ7//EEGRvuW5LTDfKaKhdJJAewLom3oP4UchyrlVMkAOxYUhp7qppmzqICgNPiSwrrl2kzyNV7zoQzuuvqbb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=hvE5SlOa; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qzcBOQ9A2gjB2nXWLEneAyXAgJH2MzSNJvie31esoxU=;
  b=hvE5SlOaaYtsnN0MQvi5uhuOIyDe8W3ACZt7Xy+mVsU0ATlOQNLPa2BJ
   bL5yAPtVv0Ru0aanmuHg7DuVoqohm8Fw3aEqNQSjKqTyZkJONR+6yfeRJ
   ionEiL2ncdyt87/84p3UwUr1tbbXr0ZssuoZq9LQbojhkPCb002PysCzG
   s=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,139,1708383600"; 
   d="scan'208";a="82621728"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 08:32:18 +0100
Date: Wed, 20 Mar 2024 08:32:17 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Dan Carpenter <dan.carpenter@linaro.org>
cc: Jakub Kicinski <kuba@kernel.org>, 
    Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
    Jesse Brandeburg <jesse.brandeburg@intel.com>, 
    Tony Nguyen <anthony.l.nguyen@intel.com>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
    Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
    intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
    linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
    Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH net] ice: Fix freeing uninitialized pointers
In-Reply-To: <facf5615-d7ac-4167-b23c-6bab7c123138@moroto.mountain>
Message-ID: <f1bdbed9-8549-3787-bd17-ecd62851e8a@inria.fr>
References: <77145930-e3df-4e77-a22d-04851cf3a426@moroto.mountain> <20240319124317.3c3f16cd@kernel.org> <facf5615-d7ac-4167-b23c-6bab7c123138@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 20 Mar 2024, Dan Carpenter wrote:

> On Tue, Mar 19, 2024 at 12:43:17PM -0700, Jakub Kicinski wrote:
> > On Sat, 16 Mar 2024 12:44:40 +0300 Dan Carpenter wrote:
> > > -	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree);
> > > -	void *mac_buf __free(kfree);
> > > +	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree) = NULL;
> > > +	void *mac_buf __free(kfree) = NULL;
> >
> > This is just trading one kind of bug for another, and the __free()
> > magic is at a cost of readability.
> >
> > I think we should ban the use of __free() in all of networking,
> > until / unless it cleanly handles the NULL init case.
>
> Free handles the NULL init case, it doesn't handle the uninitialized
> case.  I had previously argued that checkpatch should complain about
> every __free() pointer if the declaration doesn't have an assignment.
>
> The = NULL assignment is unnecessary if the pointer is assigned to
> something else before the first return, so this might cause "unused
> assignment" warnings?  I don't know if there are any tools which
> complain about that in that situation.  I think probably we should just
> make that an exception and do the checkpatch thing because it's such a
> simple rule to implement.

My understanding from Jonathan Cameron was that Linus wants a NULL always,
unless there is an initialization with the declaration.

julia

