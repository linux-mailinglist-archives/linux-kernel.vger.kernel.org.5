Return-Path: <linux-kernel+bounces-149502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFF88A921A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7758282B73
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CA0433A6;
	Thu, 18 Apr 2024 04:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wBVsrPCt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E0E1E49B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 04:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713415082; cv=none; b=W0jnqX54AMpRIcCjLEMc1M80Agi3BfbDHV25JNblnf22m8EcrIOs5p1qyf0iL1Nk0drsXbN/g0Nb28Zgzg/OQ2e5uN0M7b3LHp1BexUxwc0j4hTxzQ0AY9lycAqxtAv0RN0RNyGy4UAC3vX81sYXW7usTOsMoNNTNz9PmdIX8Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713415082; c=relaxed/simple;
	bh=tyUM8/5jDpVuOaExwiWIFw4yv8/1WmmRGcRK4GbkFpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOTanALdfmtt28mLHuLAV8g4DsBTzUyxMBkYfpl8+qiPI5Hpi83WOwsjL9Xyx7fVd3SHxyBCvKL0di89ejmiutDlUc0F9qWML1YoESFw1cz1krdA/gyWQNpyQ6SDqIw59NDm7XID7PgLkw+EK5FgiFMoFcZDhTiB8iDkkpSxmwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wBVsrPCt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3FC0C113CE;
	Thu, 18 Apr 2024 04:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713415081;
	bh=tyUM8/5jDpVuOaExwiWIFw4yv8/1WmmRGcRK4GbkFpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wBVsrPCtzCN68kCYngjtg26/Z3o6PyT/vuh6vvs6oB/Mwt43YIfGUAnKWXLwvIzW7
	 JMVCgTd4H6qekrxckW0m3EJJvQvrIsjDFKW9/rhGdE0fxjDrOUoCxyLWKQmvhavOwl
	 pBnBpULXRUTW966qORSWyuB5QtblFoqL2Sm9LPw0=
Date: Thu, 18 Apr 2024 06:37:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: wangzhu <wangzhu9@huawei.com>
Cc: "harry.wentland@amd.com" <harry.wentland@amd.com>,
	"sunpeng.li@amd.com" <sunpeng.li@amd.com>,
	"Rodrigo.Siqueira@amd.com" <Rodrigo.Siqueira@amd.com>,
	"alexander.deucher@amd.com" <alexander.deucher@amd.com>,
	"christian.koenig@amd.com" <christian.koenig@amd.com>,
	"airlied@linux.ie" <airlied@linux.ie>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>,
	"qingqing.zhuo@amd.com" <qingqing.zhuo@amd.com>,
	"stylon.wang@amd.com" <stylon.wang@amd.com>,
	"Josip.Pavic@amd.com" <Josip.Pavic@amd.com>,
	"trix@redhat.com" <trix@redhat.com>,
	"cruise.hung@amd.com" <cruise.hung@amd.com>,
	"Eric.Yang2@amd.com" <Eric.Yang2@amd.com>,
	"mario.limonciello@amd.com" <mario.limonciello@amd.com>,
	"alvin.lee2@amd.com" <alvin.lee2@amd.com>,
	"jun.lei@amd.com" <jun.lei@amd.com>,
	"austin.zheng@amd.com" <austin.zheng@amd.com>,
	"sunglee@amd.com" <sunglee@amd.com>,
	"paul.hsieh@amd.com" <paul.hsieh@amd.com>,
	"hanghong.ma@amd.com" <hanghong.ma@amd.com>,
	"JinZe.Xu@amd.com" <JinZe.Xu@amd.com>,
	"lewis.huang@amd.com" <lewis.huang@amd.com>,
	Zhengzengkai <zhengzengkai@huawei.com>,
	"alex.hung@amd.com" <alex.hung@amd.com>,
	"syed.hassan@amd.com" <syed.hassan@amd.com>,
	"wayne.lin@amd.com" <wayne.lin@amd.com>,
	"nicholas.kazlauskas@amd.com" <nicholas.kazlauskas@amd.com>,
	"chiahsuan.chung@amd.com" <chiahsuan.chung@amd.com>,
	"aurabindo.pillai@amd.com" <aurabindo.pillai@amd.com>,
	"aric.cyr@amd.com" <aric.cyr@amd.com>,
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjYuNg==?= =?utf-8?Q?=5D?=
 drm/amd/display: Wake DMCUB before executing GPINT commands
Message-ID: <2024041835-important-salad-407e@gregkh>
References: <20240416035240.2450127-1-wangzhu9@huawei.com>
 <2024041658-imagines-unlatch-a9b6@gregkh>
 <036c3371d3a64ef8881260197ce37dbc@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <036c3371d3a64ef8881260197ce37dbc@huawei.com>

On Thu, Apr 18, 2024 at 01:51:33AM +0000, wangzhu wrote:
> Hi Greg, thanks for your reply. Since there is no patch to fix CVE-2023-52624 in linux-5.10, there is a patch in the linux-6.7 branch, its commit is 2ef98c6d753a744e333b7e34b9cf687040fba57d ("drm/amd/display: Wake DMCUB before executing GPINT commands"). When we apply this patch to linux-5.10, there are lots of conflicts, and we found there are lots of dependent patches, and lots of patches are not proposed to fix the cve, they are presented to add new functions of the kernel.
> 
> My commit comes from nearly 20 patches. For each patch, not all of its content is meant to fix the cve, so I just get the part which is helpful to fix. It is why I don't present the patches one by one instead of merging them into one big patch.
> 


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

Also, yes, we want to take the original commits, as you see on the
stable mailing list, submit a series of commits that are in Linus's tree
that resolve the issue (and send them to the proper people, as explained
in the link above.)

thanks,

greg k-h

