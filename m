Return-Path: <linux-kernel+bounces-53828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A7184A713
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9136BB2313D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9466560248;
	Mon,  5 Feb 2024 19:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TQN++WZp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4A56024D;
	Mon,  5 Feb 2024 19:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707161987; cv=none; b=hlEnVqd1u5FqOcRQVKJPUhdCSJHVNcHNdhCKLDqXRlVoU8IuqlsDXxK/ECRbMVqSXiQsDo7Z/KpDGiYtQPiMh31ScZRF9+7qnzXmZ9qTV17ublC2B9I8sDJcFbdkfb5jlMqUDmB83RG4RAixte41Fmot3ZnB4Z4vnrbft72OG/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707161987; c=relaxed/simple;
	bh=QZjCi9w2QAUBNAT4DeEq5OxdqGZIc/8C3wk4n3B13a0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1hfDpKblAciDnLrvtmYRnjrppk7zD47N04Y6/klM2nMqAEX6doltL0t5cWyElYY2uVK6KSkzWq3gjGqo7kYrzRptLupDpjksKr3+XShksA3mCulhSec/LBMVuCvDXBe/8MNSPqXTjK6b71dWHWUetEtcivqv52RLch95DiRaB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TQN++WZp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E047AC43390;
	Mon,  5 Feb 2024 19:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707161987;
	bh=QZjCi9w2QAUBNAT4DeEq5OxdqGZIc/8C3wk4n3B13a0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TQN++WZpEoPFhG1GJWnObOLG3jMrTenfT8ksYFni0uSX6o6XELPBwH4MyJEtrqbln
	 4YOr6UjDw0duab4XOao+7cy/mdihdx39dK/UJWG3ARLMHXGk7iZh/W3E3Xp82qri7C
	 wBpSPG5Pi0dUSK4X+qeJkLYQ1vvMGHA/Cntpst48=
Date: Mon, 5 Feb 2024 19:39:44 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, naveenkrishna.chatradhi@amd.com,
	LKML <linux-kernel@vger.kernel.org>,
	Carlos Bilbao <carlos.bilbao@amd.com>,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86/amd/hsmp: switch to use
 device_add_groups()
Message-ID: <2024020540-siesta-palm-03cd@gregkh>
References: <2024020145-junior-outnumber-3e76@gregkh>
 <07010c54-2e44-463b-9a9b-95697fd30ffd@redhat.com>
 <2024020243-blinks-pantomime-c51e@gregkh>
 <06e92b87-4d48-4519-b1db-6d7605bf3962@redhat.com>
 <e8605fd7-1ffc-00ff-ec3b-e125085d4e92@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8605fd7-1ffc-00ff-ec3b-e125085d4e92@linux.intel.com>

On Mon, Feb 05, 2024 at 12:27:24PM +0200, Ilpo Järvinen wrote:
> On Fri, 2 Feb 2024, Hans de Goede wrote:
> > On 2/2/24 16:32, Greg Kroah-Hartman wrote:
> > > On Fri, Feb 02, 2024 at 08:49:39AM +0100, Hans de Goede wrote:
> > >> Hi Greg,
> > >>
> > >> On 2/2/24 03:44, Greg Kroah-Hartman wrote:
> > >>> The use of devm_*() functions works properly for when the device
> > >>> structure itself is dynamic, but the hsmp driver is attempting to have a
> > >>> local, static, struct device and then calls devm_() functions attaching
> > >>> memory to the device that will never be freed.
> > >>
> > >> As I mentioned in my reply to v1, this is not correct.
> > >>
> > >> There is a global data struct, but that holds a struct device
> > >> pointer, not the device struct.
> > > 
> > > Ooops, I misread that:
> > > 	static struct hsmp_plat_device plat_dev;
> > > was not the actual device struct anymore.
> > > 
> > >> The device itself is created with platform_device_alloc() +
> > >> platform_device_add() from module-init and it is removed
> > >> on module-exit by calling platform_device_unregister()
> > > 
> > > Ok, much better.
> > > 
> > >> So AFAICT this should keep using the devm_ variant to properly
> > >> cleanup the sysfs attributes.
> > > 
> > > This devm_ variant is odd, and should never have been created as the
> > > sysfs core always cleans up the sysfs attributes when a device is
> > > removed, there is no need for it (i.e. they do the same thing.)
> > > 
> > > That's why I want to get rid of it, it's pointless :)
> > > 
> > >> But what this really needs is to be converted to using
> > >> amd_hsmp_driver.driver.dev_groups rather then manually
> > >> calling devm_device_add_groups() I have already asked
> > >> Suma Hegde (AMD) to take a look at this.
> > > 
> > > The initial issue I saw with this is that these attributes are being
> > > created dynamically, so using dev_groups can be a bit harder.  The code
> > > paths here are twisty and not obvious as it seems to want to support
> > > devices of multiple types in the same codebase at the same time.
> > > 
> > > But yes, using dev_groups is ideal, and if that happens, I'm happy.
> > > It's just that there are now only 2 in-kernel users of
> > > devm_device_add_groups() and I have a patch series to get rid of the
> > > other one, and so this would be the last, hence my attention to this.
> > > 
> > > Again, moving from devm_device_add_groups() to device_add_groups() is a
> > > no-op from a functional standpoint, so this should be fine.
> > 
> > Ok, I was not aware that the core automatically cleans up
> > all the attributes anyways.
> > 
> > In that case this fine with me and I agree with merging this
> > so that you can entirely remove the  devm_ variant:
> > 
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Greg,
> 
> Does this same stuff apply to devm_device_add_group() which was added 
> along the ACPI changes?

Probably, I haven't looked at that yet.

> And the changelog is quite misleading as is, it should be changed to 
> match the real motivation.

"Motivation" isn't always needed in a changelog text, I was trying to
describe why this specific instance was not needed, not the overall
pointlessness of the function :)

I got the text wrong about this being a static variable (but one is
still in there, so it's confusing.)

I'll be glad to reword this if needed to just say "This function is
pointless, does nothing, and is about to be removed from the kernel so
stop using it", or something along those lines...

thanks,

greg k-h

