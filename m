Return-Path: <linux-kernel+bounces-48332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AD1845A86
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF657B25139
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092445F485;
	Thu,  1 Feb 2024 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hp7wO7jo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269AF53385;
	Thu,  1 Feb 2024 14:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706798829; cv=none; b=GgBfxM/r4c4UyPynLKIhetQb+wYkuPY7V1RwQfTYu8gIrkR2D4HQ2QJ1o7FBEhsqYVvshCVZk/Dy2vPkWxaKeo5ydAp7BlqghxHNgmyksE1iBE4s+ugvQLTbXUNW9stA0/CO5D22TUZezuD/fgYL7TImuJ/zXCdsN46nBhFvfEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706798829; c=relaxed/simple;
	bh=Op51wgxnKz739GQ7m4pPxxOXzlkXkfmYI8j1uup/GdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9M5lWMAatFOfzu2fQ2gGWqCZ+3szGvi+DwyUVyzuKnbKmJo3r+tOckBnyBfsc6/5Og5ZcLHTVkZSFGmdDQ8sohshWAzHLwW+JqML/MVLJ4t/NqZuvKefdlmhAF2jcFBF0gyYh3wNTGnKQc7xFmV7OZtWTb7sJebhrOCjbUL6wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hp7wO7jo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98943C433C7;
	Thu,  1 Feb 2024 14:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706798828;
	bh=Op51wgxnKz739GQ7m4pPxxOXzlkXkfmYI8j1uup/GdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hp7wO7joI4VfWLO6zvQiKjqUaV0d9262qFHOff7P74jMMApODqxoEUP/HiFTbiEb6
	 IOwqX6HNOj5F29AOYwYQbJ+/hgcgupu6Fm2tJHV990tK35odGevqhXIettd3tHnr8K
	 Ej080f4gIw8vUr1tla86542hXwCP+9jwqdq0AgLg=
Date: Thu, 1 Feb 2024 06:47:07 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Hegde, Suma" <Suma.Hegde@amd.com>, naveenkrishna.chatradhi@amd.com,
	LKML <linux-kernel@vger.kernel.org>,
	Carlos Bilbao <carlos.bilbao@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] platform/x86/amd/hsmp: switch to use device_add_groups()
Message-ID: <2024020135-sly-theft-0594@gregkh>
References: <2024012822-exalted-fidgeting-f180@gregkh>
 <0d110d2a-da0c-017a-0e5a-fc6bef7b066a@linux.intel.com>
 <e73426f6-6d50-4ed7-8613-1ec42fa3f991@amd.com>
 <2024020144-duplicity-nuptials-1cd7@gregkh>
 <f48ebcb1-8f87-efee-08ed-844775c995aa@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f48ebcb1-8f87-efee-08ed-844775c995aa@linux.intel.com>

On Thu, Feb 01, 2024 at 04:34:30PM +0200, Ilpo Järvinen wrote:
> On Thu, 1 Feb 2024, Greg Kroah-Hartman wrote:
> 
> > On Thu, Feb 01, 2024 at 06:50:33PM +0530, Hegde, Suma wrote:
> > > On 1/29/2024 6:16 PM, Ilpo Järvinen wrote:
> > > > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > > > 
> > > > 
> > > > + Cc Suma Hegde.
> > > > 
> > > > On Sun, 28 Jan 2024, Greg Kroah-Hartman wrote:
> > > > 
> > > > > The use of devm_*() functions works properly for when the device
> > > > > structure itself is dynamic, but the hsmp driver is attempting to have a
> > > > > local, static, struct device and then calls devm_() functions attaching
> > > > > memory to the device that will never be freed.
> > > > > 
> > > > > The logic of having a static struct device is almost never a wise
> > > > > choice, but for now, just remove the use of devm_device_add_groups() in
> > > > > this driver as it obviously is not needed.
> > > 
> > > Hi Greg,
> > > 
> > > Could you please hold on merging this patch for a week? I will push a patch
> > > for converting platform specific structure's memory allocation from static
> > > to a dynamic
> > > 
> > > allocation.
> > 
> > Push it where?  Ususally we do "first patch wins" type stuff, why not
> > just do your work on top of mine?
> > 
> > Also, when you do make the needed changes, please remove the explicit
> > call to create sysfs groups and use the default groups pointer instead,
> > that will make things much simpler and avoid races in the code.
> 
> Hi Greg,
> 
> Well, if you really want to "win" :-), please provide an updated version 
> which considers the changes already made in the for-next branch (the 
> current one won't apply).

Fair enough, I don't want to "win", I just want to squash any "hold off
and don't make any changes to this file because I was going to plan on
doing something else here in the future" type of stuff, as that is what
has been documented to take down many projects in the past.

That's why we almost always take patches that people have submitted
today, instead of ignoring them for potential future changes, unless of
course, they are not acceptable.

I'll rebase on linux-next, rejecting it for that reason is totally valid :)

thanks,

greg k-h

