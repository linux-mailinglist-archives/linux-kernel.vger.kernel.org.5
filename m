Return-Path: <linux-kernel+bounces-93523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524448730F9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D6DF28A9F4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AC73309C;
	Wed,  6 Mar 2024 08:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ev4aG0JW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF9E5C604
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 08:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709714530; cv=none; b=EoQ2lgQ2NY61h7lSs8JxaJaMKLrq4wolmlYgZoOvahnNvnV2gFNlJ6jmus2JZuAr9bP4ZNZ2iQ4pWiQdI23lUkK+maYpVjybcXm+2Je6sauA2uImvwRdIV79NZqAKFcl2Ib7bYFzM5pieNh+g/1ibLsbVWJkNBM8nPLvZ5cPTp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709714530; c=relaxed/simple;
	bh=huPuWCGUcJRri8JOs7T4zB4hRAtclLeB5d+5GT0G9rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KabNaXz6g4C9EcP1SvUKepCchtxaSMkacLtbJA6AuuYt2sIhfUWkDLIGKI/907krcVxXq+QgvChmOseyU6A0Tefmj0BGGe+7ll568CNY9qrYn5nsfo5smz6bBAnZM8M0izGh4MqDnCy613RWXO3PmLtYwDPzwXqzEUTdqK6tNrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ev4aG0JW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECFDC433F1;
	Wed,  6 Mar 2024 08:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709714530;
	bh=huPuWCGUcJRri8JOs7T4zB4hRAtclLeB5d+5GT0G9rg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ev4aG0JWgPk6JJXixEw8WB8zmaHFScMG/2rtF78devL4/1DJzawwtxumRFzei8P9j
	 r/N13EuE3z/xms8wFHFqLz+mY4l4Aimj1Ce9HzR4ylPyNKaaZwJ+MR6Rwk0YmWsyGc
	 6++mvELEWh2cDvGncE3iOXEMop+Wc9kJg8tSb6Fw=
Date: Wed, 6 Mar 2024 08:42:07 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52560: mm/damon/vaddr-test: fix memory leak in
 damon_do_test_apply_three_regions()
Message-ID: <2024030604-unstuffed-grant-758c@gregkh>
References: <2024030252-CVE-2023-52560-c3de@gregkh>
 <ZedNf9uP3_TjIy0g@tiehlicka>
 <2024030527-sinless-platter-510a@gregkh>
 <ZeggFvhW-nLqM6G-@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeggFvhW-nLqM6G-@tiehlicka>

On Wed, Mar 06, 2024 at 08:49:42AM +0100, Michal Hocko wrote:
> On Tue 05-03-24 22:25:11, Greg KH wrote:
> > On Tue, Mar 05, 2024 at 05:51:11PM +0100, Michal Hocko wrote:
> > > On Sat 02-03-24 22:59:54, Greg KH wrote:
> > > > Description
> > > > ===========
> > > > 
> > > > In the Linux kernel, the following vulnerability has been resolved:
> > > > 
> > > > mm/damon/vaddr-test: fix memory leak in damon_do_test_apply_three_regions()
> > > > 
> > > > When CONFIG_DAMON_VADDR_KUNIT_TEST=y and making CONFIG_DEBUG_KMEMLEAK=y
> > > > and CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y, the below memory leak is detected.
> > > 
> > > This is a kunit test case AFAICS. Is this really a CVE material?
> > 
> > People run kunit tests on real systems (again, we do not dictate use
> > cases.)  So yes, fixing a memory leak that can be triggered is resolving
> > a weakness and so should get a CVE I would think, right?
> 
> This is stretching the meaning of CVE beyond my imagination. Up to you
> to decide but I yet have to see a real production system that casually
> runs unit test just for <looking for a reason .... but failed>.

I know of at least one place that uses kunit tests in "production", and
I know of more that will be enabling them in newer releases, so this is
a real thing.  Again, we just mark "fixes for a weakness" as a CVE and
let others decide what to do with it.

thanks,

greg k-h

