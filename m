Return-Path: <linux-kernel+bounces-44959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE33D842970
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C12CB2A4D4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F43D1292E0;
	Tue, 30 Jan 2024 16:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SoDX8xGj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FE1128395;
	Tue, 30 Jan 2024 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706632533; cv=none; b=T/U/3a2eLNQcUqfAVcXIfMBQ0DW1xx6Mrk3eR8EEUt1ccFlb8B+u4pWrz3HHpo+oj1vzxlU2HHs1Y4Z8l60GzYshvdVi3vdI38DwUWa+OYFqhpEuJ4b0xEga74082D4uBfwpaKcAItZB+IZ2zlIa1yZs8DtqFwm90yqqC5l3kUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706632533; c=relaxed/simple;
	bh=zhG+8/nuWgNItbhLKSC+JpSH5oPOHh80vN9YuUa75NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ri+iArhN6J0OpIScd7kvM9HaKpmGpHmTpyw37kQ2Vy9+0/B5g+CHqWvNECmy3UIJ4FcN/Z8zO66+qD65fyAP7VDPuCjzmo3z+2/8qLxalLZHDSpJvp4Wv5P8eWzTtAbyASZqpuFUdCe74Tl1ODl42grUZYyHxOIXA0yC6oSwDNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SoDX8xGj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3323C433C7;
	Tue, 30 Jan 2024 16:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706632532;
	bh=zhG+8/nuWgNItbhLKSC+JpSH5oPOHh80vN9YuUa75NA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SoDX8xGj0l37PBpmm/oaZpUNvBIXmLRNBGHXi3n2OPaxKxwzNhpYjynPdyJc/hpY/
	 Wkzt3BaZvdEYjgwNtQNqIfdHYcYMm9dCWAHnknK2/496Q37oJ+kw2Ajlj+GnV/ZvrO
	 b4OPMrETh2Xtl/p1rGOQMnuYUKbezyqbrQH8bfbk=
Date: Tue, 30 Jan 2024 06:11:17 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, linux-fpga@vger.kernel.org,
	kernel-janitors@vger.kernel.org, Luwei Kang <luwei.kang@intel.com>,
	Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH] fpga: dfl: fme: Return directly after a failed
 devm_kasprintf() call in fme_perf_pmu_register()
Message-ID: <2024013044-proved-ligament-9555@gregkh>
References: <d94376b6-12e8-45bb-a9be-4887bb316d35@web.de>
 <ZbjJYMlDifIv0WId@yilunxu-OptiPlex-7050>
 <ZbjPDX1y2I9Heanq@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZbjPDX1y2I9Heanq@yilunxu-OptiPlex-7050>

On Tue, Jan 30, 2024 at 06:27:25PM +0800, Xu Yilun wrote:
> On Tue, Jan 30, 2024 at 06:03:12PM +0800, Xu Yilun wrote:
> > On Sat, Jan 27, 2024 at 03:55:19PM +0100, Markus Elfring wrote:
> > > From: Markus Elfring <elfring@users.sourceforge.net>
> > > Date: Sat, 27 Jan 2024 15:43:42 +0100
> 
> Sorry, something to fix.
> 
> Please shorten your shortlog to less than 75 chars.
> Please refer to Documentation/process/submitting-patches.rst
> 
> > > 
> > > The result from a call of the function “devm_kasprintf” was passed to
> > > a subsequent function call without checking for a null pointer before
> > > (according to a memory allocation failure).
> > > This issue was detected by using the Coccinelle software.
> > > 
> > > Thus return directly after a failed devm_kasprintf() call.
> > > 
> > > Fixes: 724142f8c42a7 ("fpga: dfl: fme: add performance reporting support")
> 
> One more char of sha.
> 
> Please use checkpatch to verify.
> 
> Thanks,
> Yilun

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

