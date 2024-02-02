Return-Path: <linux-kernel+bounces-50023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4EC847336
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEBA61F26C24
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E0C1468F7;
	Fri,  2 Feb 2024 15:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FYG8Adgk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36FA145B20;
	Fri,  2 Feb 2024 15:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706887953; cv=none; b=INvZvkyCQzQM+fKNfu7oGv81SuEYMoJfDgzm+FHgGs/PdM+dVRScvVig8DSquG2pmtUBnUceAriIviRv3MLW7sGbrr9Pn69uwJ8VohA0tq764hX7FWcyz4KD9nCPOwSBUVk7MzydmTuvTuWrGZ1lcBqD+k34VvN+MtxNluNEAYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706887953; c=relaxed/simple;
	bh=YPkSvytEEBb/qeJVsFU1fMko8TQCBCDq/nPKJnIl+bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C80NCfetwq5tiqCHvum1hX9eUNaevSnXfgBNbp3zb8XHjH6bDwCAZ8mbU6mqRkAOjIVX7XupojnzHd38IPV6l1P8XkXOgoKiXV8pP3tMWkN8L8XJL2vTLrZhTGFkp7gELUGMX9nZX7Kr372QCC+v7S3Ww7jarC27sl7TOOuSE5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FYG8Adgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59519C433C7;
	Fri,  2 Feb 2024 15:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706887953;
	bh=YPkSvytEEBb/qeJVsFU1fMko8TQCBCDq/nPKJnIl+bE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FYG8AdgkCYmUNEylUzdiCra/uwbz+wT6RZmwsK8OkWghJ8Ix0/vvI7Qfp3UxOuIIv
	 6IKy/LnZhGZ7Gy1osozYYVn+kPhHbRYeIVQQh45FCU8LaKXD59ywLuOWHsdsy08FFj
	 j4qZzJuvlSgHKzYduAM18rihd5uGjQJsGjiNvBto=
Date: Fri, 2 Feb 2024 07:32:32 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: naveenkrishna.chatradhi@amd.com, linux-kernel@vger.kernel.org,
	Carlos Bilbao <carlos.bilbao@amd.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86/amd/hsmp: switch to use
 device_add_groups()
Message-ID: <2024020243-blinks-pantomime-c51e@gregkh>
References: <2024020145-junior-outnumber-3e76@gregkh>
 <07010c54-2e44-463b-9a9b-95697fd30ffd@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07010c54-2e44-463b-9a9b-95697fd30ffd@redhat.com>

On Fri, Feb 02, 2024 at 08:49:39AM +0100, Hans de Goede wrote:
> Hi Greg,
> 
> On 2/2/24 03:44, Greg Kroah-Hartman wrote:
> > The use of devm_*() functions works properly for when the device
> > structure itself is dynamic, but the hsmp driver is attempting to have a
> > local, static, struct device and then calls devm_() functions attaching
> > memory to the device that will never be freed.
> 
> As I mentioned in my reply to v1, this is not correct.
> 
> There is a global data struct, but that holds a struct device
> pointer, not the device struct.

Ooops, I misread that:
	static struct hsmp_plat_device plat_dev;
was not the actual device struct anymore.

> The device itself is created with platform_device_alloc() +
> platform_device_add() from module-init and it is removed
> on module-exit by calling platform_device_unregister()

Ok, much better.

> So AFAICT this should keep using the devm_ variant to properly
> cleanup the sysfs attributes.

This devm_ variant is odd, and should never have been created as the
sysfs core always cleans up the sysfs attributes when a device is
removed, there is no need for it (i.e. they do the same thing.)

That's why I want to get rid of it, it's pointless :)

> But what this really needs is to be converted to using
> amd_hsmp_driver.driver.dev_groups rather then manually
> calling devm_device_add_groups() I have already asked
> Suma Hegde (AMD) to take a look at this.

The initial issue I saw with this is that these attributes are being
created dynamically, so using dev_groups can be a bit harder.  The code
paths here are twisty and not obvious as it seems to want to support
devices of multiple types in the same codebase at the same time.

But yes, using dev_groups is ideal, and if that happens, I'm happy.
It's just that there are now only 2 in-kernel users of
devm_device_add_groups() and I have a patch series to get rid of the
other one, and so this would be the last, hence my attention to this.

Again, moving from devm_device_add_groups() to device_add_groups() is a
no-op from a functional standpoint, so this should be fine.

thanks,

greg k-h

