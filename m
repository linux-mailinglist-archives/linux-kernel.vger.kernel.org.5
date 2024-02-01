Return-Path: <linux-kernel+bounces-48417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3868845BAC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC2F1C25736
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D796215A;
	Thu,  1 Feb 2024 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t9WXw0PC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A766626A3;
	Thu,  1 Feb 2024 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801699; cv=none; b=FjuxEsUtuseWh9M7uuw0jlLPH+MKFUIva1N2ufoUvSv3DzsWvhIEl3Lo672P8IyGlJWxZMa3KNIR4VMicE0wFNZORiKyd5OK6qJi6fTRucpXRK6KF1PdC2HtCAN+FwTdio/j5Vgy3zinQz9dMAWzKI8EJ/Nlj4GAHyN4Efay4j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801699; c=relaxed/simple;
	bh=92wOjai83MNYikSNgzyhgo4pXtuXVYoQBQ0iJgRYYeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/8YGZnCrfDN3DW3IyMuHPPAhpT907FAcRGiflyOJngF80O70AObuQBcCdEy+M5kq+kGJMir3WFuoWEM9feiKd/cTyXUrSjvgKgXxfZLDdHStsQbXhOTe+/rSeN0SQ8OBhWI5o9IhsBRvWVOtBoD5cp5myVXjpAhGDAZf5T7C60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t9WXw0PC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6F8C433F1;
	Thu,  1 Feb 2024 15:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706801699;
	bh=92wOjai83MNYikSNgzyhgo4pXtuXVYoQBQ0iJgRYYeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t9WXw0PCnRPV/1t0PVCSpps11fq4ZDWzZ4l5o4Q8/KnhKtXC2Ja77YAMZ2lO22RIP
	 Nzf5ltRtt48pUS/WPpxwzWwvC6uji24oLfku+QlNtKuEU4UUsEsBvwOa/+oVIwKmbF
	 zPtEtZgjOl+LnETbfl/J4k9ZxmE+R/yuq4Jd04h0=
Date: Thu, 1 Feb 2024 07:34:58 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Hegde, Suma" <Suma.Hegde@amd.com>, naveenkrishna.chatradhi@amd.com,
	LKML <linux-kernel@vger.kernel.org>,
	Carlos Bilbao <carlos.bilbao@amd.com>,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] platform/x86/amd/hsmp: switch to use device_add_groups()
Message-ID: <2024020122-undertone-hammock-b08d@gregkh>
References: <2024012822-exalted-fidgeting-f180@gregkh>
 <0d110d2a-da0c-017a-0e5a-fc6bef7b066a@linux.intel.com>
 <e73426f6-6d50-4ed7-8613-1ec42fa3f991@amd.com>
 <2024020144-duplicity-nuptials-1cd7@gregkh>
 <f48ebcb1-8f87-efee-08ed-844775c995aa@linux.intel.com>
 <2024020135-sly-theft-0594@gregkh>
 <fb66b037-eeba-45d6-be41-215478cf3ba9@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb66b037-eeba-45d6-be41-215478cf3ba9@redhat.com>

On Thu, Feb 01, 2024 at 03:50:08PM +0100, Hans de Goede wrote:
> Hi Greg,
> 
> On 2/1/24 15:47, Greg Kroah-Hartman wrote:
> > On Thu, Feb 01, 2024 at 04:34:30PM +0200, Ilpo Järvinen wrote:
> >> On Thu, 1 Feb 2024, Greg Kroah-Hartman wrote:
> >>
> >>> On Thu, Feb 01, 2024 at 06:50:33PM +0530, Hegde, Suma wrote:
> >>>> On 1/29/2024 6:16 PM, Ilpo Järvinen wrote:
> >>>>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> >>>>>
> >>>>>
> >>>>> + Cc Suma Hegde.
> >>>>>
> >>>>> On Sun, 28 Jan 2024, Greg Kroah-Hartman wrote:
> >>>>>
> >>>>>> The use of devm_*() functions works properly for when the device
> >>>>>> structure itself is dynamic, but the hsmp driver is attempting to have a
> >>>>>> local, static, struct device and then calls devm_() functions attaching
> >>>>>> memory to the device that will never be freed.
> >>>>>>
> >>>>>> The logic of having a static struct device is almost never a wise
> >>>>>> choice, but for now, just remove the use of devm_device_add_groups() in
> >>>>>> this driver as it obviously is not needed.
> >>>>
> >>>> Hi Greg,
> >>>>
> >>>> Could you please hold on merging this patch for a week? I will push a patch
> >>>> for converting platform specific structure's memory allocation from static
> >>>> to a dynamic
> >>>>
> >>>> allocation.
> >>>
> >>> Push it where?  Ususally we do "first patch wins" type stuff, why not
> >>> just do your work on top of mine?
> >>>
> >>> Also, when you do make the needed changes, please remove the explicit
> >>> call to create sysfs groups and use the default groups pointer instead,
> >>> that will make things much simpler and avoid races in the code.
> >>
> >> Hi Greg,
> >>
> >> Well, if you really want to "win" :-), please provide an updated version 
> >> which considers the changes already made in the for-next branch (the 
> >> current one won't apply).
> > 
> > Fair enough, I don't want to "win", I just want to squash any "hold off
> > and don't make any changes to this file because I was going to plan on
> > doing something else here in the future" type of stuff, as that is what
> > has been documented to take down many projects in the past.
> > 
> > That's why we almost always take patches that people have submitted
> > today, instead of ignoring them for potential future changes, unless of
> > course, they are not acceptable.
> > 
> > I'll rebase on linux-next, rejecting it for that reason is totally valid :)
> 
> I checked the code in linux-next and the dev passed to devm_device_add_groups()
> now is &amd_hsmp_platdev->dev and amd_hsmp_platdev gets properly removed
> from hsmp_plt_exit(), so I believe that keeping the devm_... call is
> the right thing to do.

I'm trying to delete the devm_device_add_groups() function entirely from
the kernel, so I might disagree with you there :)

> With that said this driver really could use some modernization
> (even though it is not a very old driver):
> 
> 1. The sysfs attribute registration should really switch to using
> amd_hsmp_driver.driver.dev_groups rather then manually
> calling devm_device_add_groups().

Yes, I'm all for that, I'll look at that this afternoon.  That's my main
goal here, to get rid of ALL manual group additions in the tree if at
all possible.  And for those rare cases that it isn't, because they are
dynamically created, work on a solution for those.

thanks,

greg k-h

