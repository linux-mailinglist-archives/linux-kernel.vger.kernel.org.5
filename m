Return-Path: <linux-kernel+bounces-62252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B10B8851D90
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 379E4B23803
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15C547A55;
	Mon, 12 Feb 2024 19:04:39 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 774BE4644E
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 19:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707764679; cv=none; b=mc8NxCSsNkv9Lj6E7JlCNfLYocQJI421MwvswcKrLktrPMDPTtF+RcYuwMZHb8J7yMF9EkqOT94uKADeSkrx55NVAoEvcbVQUqwVqKKmWXssnX0fsab5CxxC27Mrgq2b5xOYmg2pG1FgKEsO0PJlfTM4XFIE/NiY1q7S2h7FprA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707764679; c=relaxed/simple;
	bh=L88DGTxBYgIkeriiYxq9PZjYUYpswT+GoOTTkCN5DvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UD2f5FHIwFeD+DYCe9614zvo8iISaaP5lnZgssv9GxBxxrtEB1yut/IWPZ5DyOgDirLI/0FEAeXnkSWXQHnYGWAwCz70/l33pt5QFW6M9vKyo2GkIg9w0FCSi4Nr6QDsqFrsDfqZoLDl+5d0VU/clLPsWR7KRq6uuXkImsB7hnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 345404 invoked by uid 1000); 12 Feb 2024 14:04:31 -0500
Date: Mon, 12 Feb 2024 14:04:31 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Oliver Neukum <oneukum@suse.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
  Ricardo Ribalda <ribalda@chromium.org>,
  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  Mauro Carvalho Chehab <mchehab@kernel.org>, linux-usb@vger.kernel.org,
  linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH v4] media: ucvideo: Add quirk for Logitech Rally Bar
Message-ID: <6aade777-d97c-4c65-b542-14ce5b39abb6@rowland.harvard.edu>
References: <20240108-rallybar-v4-1-a7450641e41b@chromium.org>
 <20240204105227.GB25334@pendragon.ideasonboard.com>
 <ca89eb86-a566-422c-9448-d8d5254d54b8@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca89eb86-a566-422c-9448-d8d5254d54b8@suse.com>

On Mon, Feb 12, 2024 at 01:22:42PM +0100, Oliver Neukum wrote:
> On 04.02.24 11:52, Laurent Pinchart wrote:
> > Hi Ricardo,
> > 
> > Thank you for the patch.
> 
> Hi,
> 
> sorry for commenting on this late, but this patch has
> a fundamental issue. In fact this issue is the reason the
> handling for quirks is in usbcore at all.
> 
> If you leave the setting/clearing of this flag to a driver you
> are introducing a race condition. The driver may or may not be
> present at the time a device is enumerated. And you have
> no idea how long the autosuspend delay is on a system
> and what its default policy is regarding suspending
> devices.
> That means that a device can have been suspended and
> resumed before it is probed. On a device that needs
> RESET_RESUME, we are in trouble.

Not necessarily.  If the driver knows that one of these devices may 
already have been suspend and resumed, it can issue its own preemptive 
reset at probe time.

> The inverse issue will arise if a device does not react
> well to RESET_RESUME. You cannot rule out that a device
> that must not be reset will be reset.

That's a separate issue, with its own list of potential problems.

> I am sorry, but it seems to me that the exceptions need
> to go into usbcore.

If we do then we may want to come up with a better scheme for seeing 
which devices need to have a quirk flag set.  A static listing probably 
won't be good enough; the decision may have to be made dynamically.

Alan Stern

