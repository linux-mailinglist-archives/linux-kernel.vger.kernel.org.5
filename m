Return-Path: <linux-kernel+bounces-14407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0481821CA4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6F111C220A7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D8BFC1D;
	Tue,  2 Jan 2024 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yTF8VXtP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1649EFBE4;
	Tue,  2 Jan 2024 13:34:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A040C433C7;
	Tue,  2 Jan 2024 13:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704202454;
	bh=UE6bcMz4qLf8bUdr80ygpuEnx8MhX2cnpnCRu9OT7ZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yTF8VXtPs2RrE0XnHxRUfGf1hjvNSPzPkQ7q/4PRmC94ApyAqPygbcAF8BFiidyap
	 pIEVEdc1QprdwpzjkES3NPITp9Y/y+3YBlDFWafEYhd+iD6cgMtyzz2Itnfd6VHpOK
	 B8fID1pllmWVFixsJIvbcPPps1hsGkhokmLAC7ms=
Date: Tue, 2 Jan 2024 14:34:11 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: core: Add quirk for Logitech Rallybar
Message-ID: <2024010236-handwoven-manicotti-4451@gregkh>
References: <20231222-rallybar-v2-1-5849d62a9514@chromium.org>
 <82bf432c-2a78-4b9c-88ab-ef4f0888e9aa@rowland.harvard.edu>
 <CANiDSCtd4-pQDdf03cBZz6deUe=b4ufiQ4WR=ddwjubOoxAQ1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiDSCtd4-pQDdf03cBZz6deUe=b4ufiQ4WR=ddwjubOoxAQ1w@mail.gmail.com>

On Tue, Jan 02, 2024 at 12:31:53PM +0100, Ricardo Ribalda wrote:
> Hi Alan
> 
> On Sat, 23 Dec 2023 at 21:01, Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Fri, Dec 22, 2023 at 10:55:49PM +0000, Ricardo Ribalda wrote:
> > > Logitech Rallybar devices, despite behaving as UVC camera, they have a
> > > different power management system than the rest of the other Logitech
> > > cameras.
> > >
> > > USB_QUIRK_RESET_RESUME causes undesired USB disconnects, that make the
> > > device unusable.
> > >
> > > These are the only two devices that have this behavior, and we do not
> > > have the list of devices that require USB_QUIRK_RESET_RESUME, so lets
> > > create a new lit for them that un-apply the USB_QUIRK_RESET_RESUME
> > > quirk.
> > >
> > > Fixes: e387ef5c47dd ("usb: Add USB_QUIRK_RESET_RESUME for all Logitech UVC webcams")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> >
> > Would it make more sense to do this inside the uvc driver instead of
> > creating a new single-purpose list in the core?
> 
> I can try to move it to the uvc driver. But maybe it is better to keep it here:
> 
> The same vid:pid also has other functionality, not only uvc: Sync
> agent interface, UPD Interface, ADB interface.
> If we apply the quirk to the uvc driver, and the uvc driver is not
> loaded, the other functionality will still be broken....
> 
> I expect to see more devices from Logitech not needing the
> RESET_RESUME quirk... so this list will eventually grow.
> 
> Setting/useting RESET_RESUME in two different locations, can make the
> code difficult to follow.
> 
> What do you think?

Try it in the specific driver first please.

thanks,

greg k-h

