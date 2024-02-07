Return-Path: <linux-kernel+bounces-56285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6305B84C850
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95AA81C24DD6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B712E250ED;
	Wed,  7 Feb 2024 10:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bWH0Yv0T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25FB24B2F;
	Wed,  7 Feb 2024 10:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707300578; cv=none; b=KSjJrVX/xWsOpdP0hnfvuluVFHOvKIAqHVuLO8mXm/uwAeiDaJczgb3VlwlBJ6t5jko+BKn3AaQ33DMP+Qz1/+29xYYnz9Yk8ffPdavm2Tw82lY6lmrXl//Nnar7XyzYpM9UwLzxas23zV8pgoDAuvfKaWLwbqUzp+FLp+0+zXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707300578; c=relaxed/simple;
	bh=GX4Tfyd35kpVX8P4fYXsUxs2ee//i7TBi6iywu14vhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=As6ymhVCb6f8vXqlGTAZ85AzfxmP7oBIUTsgzjOJaPUb9w8v9a1e5CPtbxoM6jxTgafWyGwkjOS+BZdnYzvp3UPtM8bL1CrX5L17cA9A6IYnRZ2oWEYi2RucETPaapDo5K+U/2laLhotY4gXn9uePx0Of2ZtbOUx/IW9igUGtFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bWH0Yv0T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C3CC433C7;
	Wed,  7 Feb 2024 10:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707300577;
	bh=GX4Tfyd35kpVX8P4fYXsUxs2ee//i7TBi6iywu14vhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bWH0Yv0Tblenbca/VGH4PxVWoFpeeSgv6rTl+q0Dkd4Jkbt3pkXEgjkjSF6z88i+w
	 /VjFIwd5KkfyHsOSLOrZpKnx3K3vN8uKVGSWh7Bi9Wb0t1NHAonkhTr6PBLeOxK8Jp
	 qeGJciwEEecftClv8LNTyjNRxUEbTUx2RmKxisYI=
Date: Wed, 7 Feb 2024 10:09:34 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.6 000/326] 6.6.16-rc2 review
Message-ID: <2024020758-judo-stardom-80f5@gregkh>
References: <CAH37n11s_8qjBaDrao3PKct4FriCWNXHWBBHe-ddMYHSw4wK0Q@mail.gmail.com>
 <e4305f3d-ede8-44fc-8bd4-eae899284f56@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e4305f3d-ede8-44fc-8bd4-eae899284f56@leemhuis.info>

On Wed, Feb 07, 2024 at 08:04:49AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 04.02.24 05:43, Стас Ничипорович wrote:
> > After trying again to create the ipset with timeout option I get a kernel panic
> > # ipset create throttled-ips hash:ip family inet hashsize 1024 maxelem
> > 100000 timeout 600 bucketsize 12 initval 0x22b96e3a
> > ipset v7.20: Set cannot be created: set with the same name already exists
> 
> To be sure the issue doesn't fall through the cracks unnoticed, I'm
> adding it to regzbot, the Linux kernel regression tracking bot:
> 
> #regzbot ^introduced fdb8e12cc2cc
> #regzbot title netfilter: WARNING when using ipset with timeout option
> #regzbot fix: netfilter: ipset: Missing gc cancellations fixed
> #regzbot ignore-activity

Note, this did not get applied to the stable kernels, so it's an issue
in Linus's tree only, with a proposed fix already posted (and might be
in linux-next already, haven't checked...)

thanks,

greg k-h

