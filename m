Return-Path: <linux-kernel+bounces-93054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AE1872A27
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 423321F25482
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B1C12D1E4;
	Tue,  5 Mar 2024 22:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gemf1XjK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DE018E29
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 22:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709677515; cv=none; b=BkumshUfasn1QR/OVpx6MExHqBjEod3Kk6mjueJyaUGikZ9/XgC2ia4ABWhGovyLR35oT0seRLPiTr7UBG1pVdZHdGTHlmgj8N2gV6lrskfYaD/A6vTcSu84uoZstTCVH5it9HgUf0b4Ujsahr2kcLHfn5WN4icFZ0XQCjDJ4s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709677515; c=relaxed/simple;
	bh=Ep1JmQKGaGwRYwPkX5qkhsSyqWOpGbHUlzLHbGcoox0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcYvaLxTZlkuy+5/yrk78tMv/EKe5YfN5ZVeWzouhbnEfeVQOyC1cPSXqmKj+CtqOeUdmwpxl3yR7jpTbyVoDs9caXLLbpoOxR9V6cybrMWzMJHE9AB8rO39HN6olxpTymcRwZSJRK2RU7gJDyETmeX8vHPgrbx5CJ1lUW+P5Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gemf1XjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77DFC433C7;
	Tue,  5 Mar 2024 22:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709677515;
	bh=Ep1JmQKGaGwRYwPkX5qkhsSyqWOpGbHUlzLHbGcoox0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gemf1XjKwbKz+W05RL044F37GGXRGcmhBsGtXzworfc/Di/FUoj0n6CbNPbAhxKiA
	 07clvOZ4hASsMPtCdS8Vmr++H9xgE4g8OlmNvjAaqS+ca6bo5W/Ly3Pf/7cRPP7d0y
	 DUrEMY9W5LMBCC9QoBfSR0iEhMRUQjPmaU8ONSto=
Date: Tue, 5 Mar 2024 22:25:11 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52560: mm/damon/vaddr-test: fix memory leak in
 damon_do_test_apply_three_regions()
Message-ID: <2024030527-sinless-platter-510a@gregkh>
References: <2024030252-CVE-2023-52560-c3de@gregkh>
 <ZedNf9uP3_TjIy0g@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZedNf9uP3_TjIy0g@tiehlicka>

On Tue, Mar 05, 2024 at 05:51:11PM +0100, Michal Hocko wrote:
> On Sat 02-03-24 22:59:54, Greg KH wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > mm/damon/vaddr-test: fix memory leak in damon_do_test_apply_three_regions()
> > 
> > When CONFIG_DAMON_VADDR_KUNIT_TEST=y and making CONFIG_DEBUG_KMEMLEAK=y
> > and CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y, the below memory leak is detected.
> 
> This is a kunit test case AFAICS. Is this really a CVE material?

People run kunit tests on real systems (again, we do not dictate use
cases.)  So yes, fixing a memory leak that can be triggered is resolving
a weakness and so should get a CVE I would think, right?

thanks,

greg k-h

