Return-Path: <linux-kernel+bounces-149848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CBE8A96BB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 354FA284386
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B7415B146;
	Thu, 18 Apr 2024 09:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IFWeH69J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF54515AD86
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433966; cv=none; b=a2H0GTiNfbZByycFOWeo8K4TF7zpOi/NEKYk/NaLmV63S5rVpvXMOBPr3wy/i/M6H1NUORMCw1xS2TeHcXspykIOBUX4moJkR2SHesTNFsYSlfKOvUS0sYa6Q28H7kGRASCIdN69REZXh8L+N3uv4siLNPc/nUCWVzdiGpNZnZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433966; c=relaxed/simple;
	bh=UILc22gN9ocfZvvxDWaiey3h29zRRo2zvofEpjVNhbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNA9LemFgy8uRT4CKHjREumDGaSggNkl/rZRwbTMWNqdWZWYuyxtsKNR5wZpaMgztwo/MWWL9Pj+cD5N67RSFYEEA4PwpFoQrIWToXhX+6WhDPrCZNmQe++/ARVJFzy4TwYPftc9JyZsCeGOVXg1igh7kuLewpDvqwNbibkcGIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IFWeH69J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2454C113CC;
	Thu, 18 Apr 2024 09:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713433966;
	bh=UILc22gN9ocfZvvxDWaiey3h29zRRo2zvofEpjVNhbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IFWeH69Jz3uobtuWKzimd0JGuGKgTXBEFvUVb7KHKr9f8HolsjeX3JPJ7aBP/U6NZ
	 TBWu+HvjYAHPb9iNKIvxEwFwLfEg8fKtcjEp/V4FyhtoufTv2w72vC+GXKOvsGOcPC
	 gf811mYD9FR+j50SHVDeyhXCoDT4E6bIV1Kt/wNw=
Date: Thu, 18 Apr 2024 11:52:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: wangzhu <wangzhu9@huawei.com>
Cc: "harry.wentland@amd.com" <harry.wentland@amd.com>,
	"sunpeng.li@amd.com" <sunpeng.li@amd.com>,
	"alexander.deucher@amd.com" <alexander.deucher@amd.com>,
	"christian.koenig@amd.com" <christian.koenig@amd.com>,
	"airlied@linux.ie" <airlied@linux.ie>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>,
	"sanglipeng1@jd.com" <sanglipeng1@jd.com>,
	"sashal@kernel.org" <sashal@kernel.org>,
	"wayne.lin@amd.com" <wayne.lin@amd.com>,
	"joshua@froggi.es" <joshua@froggi.es>,
	"hongao@uniontech.com" <hongao@uniontech.com>,
	"cssk@net-c.es" <cssk@net-c.es>,
	"nicholas.kazlauskas@amd.com" <nicholas.kazlauskas@amd.com>,
	"chiahsuan.chung@amd.com" <chiahsuan.chung@amd.com>,
	"mwen@igalia.com" <mwen@igalia.com>,
	"roman.li@amd.com" <roman.li@amd.com>,
	"aurabindo.pillai@amd.com" <aurabindo.pillai@amd.com>,
	"hansen.dsouza@amd.com" <hansen.dsouza@amd.com>,
	"Rodrigo.Siqueira@amd.com" <Rodrigo.Siqueira@amd.com>,
	"Konstantin Meskhidze (A)" <konstantin.meskhidze@huawei.com>,
	"aric.cyr@amd.com" <aric.cyr@amd.com>,
	"jaehyun.chung@amd.com" <jaehyun.chung@amd.com>,
	"mario.limonciello@amd.com" <mario.limonciello@amd.com>,
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjUuMTA=?= =?utf-8?Q?=5D?=
 drm/amd/display: Wake DMCUB before executing GPINT commands
Message-ID: <2024041852-surrogate-nimbly-0538@gregkh>
References: <20240416024347.2446403-1-wangzhu9@huawei.com>
 <2024041633-breath-unfiled-86c1@gregkh>
 <a0b467dd1c074758aa89a18fa7a9c6ab@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0b467dd1c074758aa89a18fa7a9c6ab@huawei.com>

On Thu, Apr 18, 2024 at 03:19:46AM +0000, wangzhu wrote:
> Hi Greg, thanks for your reply. Since there is no patch to fix CVE-2023-52624 in linux-5.10, there is a patch in the linux-6.7 branch to fix it, its commit is 2ef98c6d753a744e333b7e34b9cf687040fba57d ("drm/amd/display: Wake DMCUB before executing GPINT commands"). When we apply this patch to linux-5.10, there are lots of conflicts, and we found there are lots of dependent patches, we do not apply all these patches since some are not meant to fix the cve, so we just get part of them, and for each patch we just get the part which is helpful to fix.

Why do you think that specific CVE is relevent to the 5.10.y kernel?
And if so, what about the ones newer than that, as you know I can not
take patches only for older kernels, that would leave newer branches
vulnerable to the same bug.

So please submit fixes for all branches that you wish to see resolved at
the same time.

thanks,

greg k-h

