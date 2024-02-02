Return-Path: <linux-kernel+bounces-49971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AEE847249
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 731222918A6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607BF145359;
	Fri,  2 Feb 2024 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oBgXtYSX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBF747774;
	Fri,  2 Feb 2024 14:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706885713; cv=none; b=vCo0eJ4KZtPlOMh1URzI4YuLb6rqpIN5TjmeoDKgDC4ut99r0pBNKA+/R2p8uJ2PWQ5F/VbVxSCHAWpTBoT5rIGhYf455WFUqDv/1Ucsij03I19HGRnqy0GniPtoMrpoZlBpYDWifQzmT2wI6Xz+j1CYX6s7NemJjCTjNNYp9d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706885713; c=relaxed/simple;
	bh=KhvAZZUlyfEIti1ZSfucEzAWh4a+uw7wMqi9w/EFAfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaRhkveUKyaICkOIjOu9NMKe3wGMtVcJh5/G0mcG6LB7ZJNF13jtLiRJ2tGDTwtJxBo0N29nrEF7y4BLxh8r7w18f8gpBKCuYh0BDI42sA19yqayvXa1U6V1uhuHICZ5VEr6a0BUrpbpKdmmBO/hCfT0QsPbldUXmGxiZfkSg3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oBgXtYSX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00F1C43390;
	Fri,  2 Feb 2024 14:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706885712;
	bh=KhvAZZUlyfEIti1ZSfucEzAWh4a+uw7wMqi9w/EFAfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oBgXtYSXiM09MGeLDmCuBcjYanU0SRyKoDSWn1wN1p8Z2k5wSNWpGqxXvJkKmlCJl
	 yWufyo7gXVR+Mrs5D0Zw+h55PbuMT5LWclVXnFNhLKeMNM7/XGpiL6b388fPiEDjNs
	 RPL5SJrfW0tGVAiFpoD9vJWowzCJR07sYPI1M9f4=
Date: Fri, 2 Feb 2024 06:55:11 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Guan-Yu Lin <guanyulin@google.com>
Cc: mathias.nyman@intel.com, stern@rowland.harvard.edu, royluo@google.com,
	benjamin.tissoires@redhat.com, hadess@hadess.net,
	heikki.krogerus@linux.intel.com, grundler@chromium.org,
	oneukum@suse.com, dianders@chromium.org, yajun.deng@linux.dev,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: host: enable suspend-to-RAM control in userspace
Message-ID: <2024020255-diocese-rocket-99ba@gregkh>
References: <20240202084815.3064391-1-guanyulin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202084815.3064391-1-guanyulin@google.com>

On Fri, Feb 02, 2024 at 08:42:35AM +0000, Guan-Yu Lin wrote:
> In systems with both a main processor and a co-processor, asynchronous
> controller management can lead to conflicts. For example, the main
> processor might attempt to suspend a USB device while the co-processor
> is actively transferring data. To address this, we introduce a new
> sysfs entry, "disable_suspend2ram", which allows userspace to control
> the suspend-to-RAM functionality of devices on a specific USB bus.
> Since the userspace has visibility into the activities of both
> processors, it can resolve potential conflicts.
> 
> Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-usb | 10 +++++++
>  drivers/usb/core/driver.c               | 12 ++++++++
>  drivers/usb/core/sysfs.c                | 29 ++++++++++++++++++
>  drivers/usb/host/xhci-plat.c            | 40 ++++++++++++++++++++++---
>  include/linux/usb.h                     |  4 +++
>  5 files changed, 91 insertions(+), 4 deletions(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

