Return-Path: <linux-kernel+bounces-144869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B53B28A4BFE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E68E51C2074E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725EA47A7F;
	Mon, 15 Apr 2024 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NItyMYn4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6C340875;
	Mon, 15 Apr 2024 09:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174778; cv=none; b=b9eZOVwpjq7nASugHpkIg7e8UMY3g2iH6wy63ussQAgTUMHZ7xyQpkIFnq1fVKvWH9AvOxiJjy+LCMimYITUWUVJJy0LVDAJC4Mv9PHRU00fTrpO02nCMGrw/yCMZ0bQvsDFoIxkJiMJCkPnHbWpe4pZmVQEOmaGUjGXtKmqA70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174778; c=relaxed/simple;
	bh=V/X3vrE3jxSz3ehSDmcCXV4yyEQ3m8xL6Dlyz364sUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QU0ceNe0VvnbJQMPeBXunrWHRM+qvTGlGEMjKjxDTtiBWYYYkngJkh9oI4wj7jeMxVH07r1+9z3Vb9Fr0rM17jAcwIIQuduxi8hlgsTtMthOR+jxDIOOXLJdtQVUoyVAX0Q5nqEkrpMU71jFoleQuCz3BbGv/yMHScytp1rIFq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NItyMYn4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF48FC113CC;
	Mon, 15 Apr 2024 09:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713174778;
	bh=V/X3vrE3jxSz3ehSDmcCXV4yyEQ3m8xL6Dlyz364sUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NItyMYn4nODvxzunXF0rBWDX4mjwxMOncgDRtCD0EU+Iy7Mn5U36CFUa2d1rO7fyp
	 crqdmhItd6+IsgsmrkQKjAQhkxf/aGtid5kVvdcLRVnKmPRgqiqiO2okk4u1ekq+Oo
	 7BYmR5aQNZJ+neZXCvvHc24nJuz89kx4Xks1FeIs=
Date: Mon, 15 Apr 2024 11:52:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: Oliver Neukum <oneukum@suse.com>,
	Aleksander Morgado <aleksandermj@chromium.org>,
	linux-usb@vger.kernel.org, linux@roeck-us.net,
	linux-kernel@vger.kernel.org, ejcaruso@chromium.org
Subject: Re: [PATCH] usb: cdc-wdm: close race between read and workqueue
Message-ID: <2024041536-simile-flatly-824a@gregkh>
References: <385a3519-b45d-48c5-a6fd-a3fdb6bec92f@chromium.org>
 <87mspvi0lk.fsf@miraculix.mork.no>
 <a6ad34d3-9cce-4178-8271-0e09ced2b6f4@suse.com>
 <878r1fht93.fsf@miraculix.mork.no>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878r1fht93.fsf@miraculix.mork.no>

On Mon, Apr 15, 2024 at 11:26:00AM +0200, Bjørn Mork wrote:
> Oliver Neukum <oneukum@suse.com> writes:
> > On 15.04.24 08:47, Bjørn Mork wrote:
> >
> >> urb from service_outstanding_interrupt(). That's why it was added. See
> >> the explanation Robert wrote when introducing it:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/usb/class/cdc-wdm.c?id=c1da59dad0ebd3f9bd238f3fff82b1f7ffda7829
> >
> > Well, the explanation is correct in that we must read
> > data available. However, if the RESPONDING flag is set
> > and the URB submitted, we are already doing so.
> 
> Sounds reasonable.  Except that the bug proves we didn't.
> 
> If you are right that service_outstanding_interrupt can race againts
> itself (and I don't doubt that), then I guess this could also happen
> between failure to submit the URB and clearing the flag?
> 
> >> As for the XMM behaviour: it's been a long time since I tried any of
> >> those, but AFAIR one the major differences compared to Qualcomm was the
> >> strict queue handling in the firmware.  This caused a number of problems
> >> where the cdc-wdm driver wanted to skip a message for some reason.  So
> >> I'm not surprised that a bug like this is triggered by one of those
> >> modems. That's probably the only thing they are good for :-)
> >
> > I am not sure where exactly the issue lies here. Suggestions for
> > debugging?
> 
> Nothing more than the obvious;  Get one of those modems and do some
> usbmon snooping.

So for now, should we just revert this problem commit?

thanks,

greg k-h

