Return-Path: <linux-kernel+bounces-111058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D92B886774
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242A4283CCA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EB414AAE;
	Fri, 22 Mar 2024 07:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="S3gBIDuJ"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AEF1119E;
	Fri, 22 Mar 2024 07:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711092322; cv=none; b=JeU+0PbCqC++9LxInZIG2/YVq30vrIQAEhZvCNaEch2PmnFxsHbRGN6XezZ8tdet+UoABCzvb8Q0kp8Q7ZDuQO/zSZgZBSvpC6ZRwmmnLoo0NhOKed3gF8curoDbMn0FP+sXnoVZ0XScAu9hKb/qumrVcg+UB4xRWp7XIbhT/iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711092322; c=relaxed/simple;
	bh=deldEFKMWIiGWJW2Eh0gw1DLVhU5F6dOnznP2xCyQaA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UYYiBWEJb/KkpO3NiLBZ0AaB05BsN99VIxiqHt0mfjUqwDS6Hgbuqdu4MwiD3C1Dr/UdJQTqQ11Vy5yj3RaGFDR7PlRCPfbfnlHpW1URE0f4dAnrrYYLqyijvXJVQ9LnjRqyvJnDD+zRQDrQksFdz8eZdgLvdnK6bIWXhWn7c7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=S3gBIDuJ; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZlmxMcxkID2APtdDfuPjyw9p7ZsnzMLqcX7Pogi+DwM=;
  b=S3gBIDuJwtLpODXitOZtu7d+JPZWfXlEKDDRrdpd91mZdDnU9XwPNv8W
   A/DxwGKelRp0rlpAxQ1BO9ZhYMblxfbkn2sIqF2ykNh785PtT94jrqPBV
   WFQKUyPTqj7gip27FdT+S/UnWpXzytrLuU2RB35RjvKHJ/0bs80Z9Xdlv
   0=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,145,1708383600"; 
   d="scan'208";a="157923739"
Received: from 184-074-243-067.biz.spectrum.com (HELO [172.20.17.26]) ([184.74.243.67])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 08:25:08 +0100
Date: Fri, 22 Mar 2024 03:24:56 -0400 (EDT)
From: Julia Lawall <julia.lawall@inria.fr>
To: Jakub Kicinski <kuba@kernel.org>
cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, 
    Julia Lawall <Julia.Lawall@inria.fr>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Dan Carpenter <dan.carpenter@linaro.org>, kernel-janitors@vger.kernel.org, 
    netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
    Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
    Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
    Tony Nguyen <anthony.l.nguyen@intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Alexander Lobakin <aleksander.lobakin@intel.com>, 
    David Laight <David.Laight@aculab.com>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jiri Pirko <jiri@resnulli.us>, 
    Jonathan Cameron <jic23@kernel.org>, Kees Cook <keescook@chromium.org>, 
    Lukasz Czapnik <lukasz.czapnik@intel.com>, Paolo Abeni <pabeni@redhat.com>, 
    Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>, 
    Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH net] ice: Fix freeing uninitialized pointers
In-Reply-To: <20240321184828.3e22c698@kernel.org>
Message-ID: <82b49991-eb5a-7e8c-67e0-b0fd932f40b4@inria.fr>
References: <e5172afb-427b-423e-877a-10352cf4a007@web.de> <F2FBADE8-EDF9-4987-A97B-CF4D2D1452E0@inria.fr> <b9dc2c7a-2688-4a7b-8482-1e762c39449c@intel.com> <20240321184828.3e22c698@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-551105037-1711092310=:3390"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-551105037-1711092310=:3390
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 21 Mar 2024, Jakub Kicinski wrote:

> On Thu, 21 Mar 2024 15:27:47 -0700 Jesse Brandeburg wrote:
> > The gist of it is that we should instead be using inline declarations,
> > which I also agree is a reasonable style for this. It more clearly shows
> > the __free(kfree) and the allocation (kzalloc, kcalloc, etc) on the same
> > (or virtually the same) line of code.
> >
> > I'm curious if Jakub would dislike this less? Accept?
>
> At present I find this construct unreadable.
> I may get used to it, hard to say.
>
> Also I don't see the benefit of the auto-freeing construct,
> I'd venture a guess that all the bugs it may prevent would
> have been caught by smatch. But I'm an old curmudgeon stuck
> in my ways. Feel free to experiment in Intel drivers, and we'll
> see how it works out 🤷️

In my experiments with of_node_put, there seem to be many functions where
removing the frees makes the function much more readable.  But
kmalloc/kfree may be used in different contexts, where the management of
the memory is a smaller percentage of the overall code.  So the tradeoffs
may be different.

julia
--8323329-551105037-1711092310=:3390--

