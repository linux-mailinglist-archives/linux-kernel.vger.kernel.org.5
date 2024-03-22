Return-Path: <linux-kernel+bounces-111390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE05886BB5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5CC8283978
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188C2405E5;
	Fri, 22 Mar 2024 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="wH6eNOa+"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67C93F8F7;
	Fri, 22 Mar 2024 11:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711108661; cv=none; b=RnhG8StasZvPPWaUAdak368p2WlM5rBrQNLYrE06nuWt9GOwu0GJtdeB8N7W2xNph9Eczov4AOsxYmmy1qzbjgtYNY8Ju0gcM9SKisovsfbiEjC4gJxi0uTiRBmscKVlKUQPh185bNSWZpuhMhP/WYedF178jWYEpiMGyB+zIhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711108661; c=relaxed/simple;
	bh=4fLslFzxOvf0s9odzqysPxgn/WllfqCRi1EcNhOBrms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMucqFUUlVDBwwHW8aASbI1Gw5gYZzcX88Pqp90PdmVw2o1UezO/xDIBOkcHmIr56ucT6yOBeA3rGvcnc3TXPVXF1dIVces4ZFxEHqulObccf7rsRH8LGNhc8InRPGWGpbQ4W0NYof4jE2fqIPBVhTe01X1I+8vKRz+rBFLqFjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=wH6eNOa+; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2CA45842;
	Fri, 22 Mar 2024 12:57:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1711108629;
	bh=4fLslFzxOvf0s9odzqysPxgn/WllfqCRi1EcNhOBrms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wH6eNOa+I4DHBwEdojUrqDk3Q+u0sJxJPiKlNCJQBQ1tBIiDtqCuXIjhx+A5RxLBy
	 f0xOof1HkCVTDPiYBlrumRHtixPW3EyxxRKIcbqr6dSrXeBJ+z9fHMI1HAL0DdJ0pQ
	 kjRjiP+00oU1jfvzrGAxwdUtS5pPDPQkRUzy/4tU=
Date: Fri, 22 Mar 2024 13:57:34 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Oliver Neukum <oneukum@suse.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] media: ucvideo: Add quirk for Logitech Rally Bar
Message-ID: <20240322115734.GB31979@pendragon.ideasonboard.com>
References: <20240108-rallybar-v4-1-a7450641e41b@chromium.org>
 <20240204105227.GB25334@pendragon.ideasonboard.com>
 <ca89eb86-a566-422c-9448-d8d5254d54b8@suse.com>
 <6aade777-d97c-4c65-b542-14ce5b39abb6@rowland.harvard.edu>
 <20240213104725.GC5012@pendragon.ideasonboard.com>
 <CANiDSCvqEkzD_-pUExT2Aci9t_tfFPWusnjST5iF-5N9yiob4g@mail.gmail.com>
 <CANiDSCsqER=3OqzxRKYR_vs4as5aO1bfSXmFJtNmzw1kznd_wQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiDSCsqER=3OqzxRKYR_vs4as5aO1bfSXmFJtNmzw1kznd_wQ@mail.gmail.com>

On Thu, Feb 29, 2024 at 05:57:38PM +0100, Ricardo Ribalda wrote:
> Oliver, friendly ping

Seconded :-) We can help with the implementation, but we would like your
guidance on the direction you think this should take.

> On Mon, 19 Feb 2024 at 16:13, Ricardo Ribalda wrote:
> >
> > Hi Oliver
> >
> > Would you prefer a version like this?
> >
> > https://lore.kernel.org/all/20231222-rallybar-v2-1-5849d62a9514@chromium.org/
> >
> > If so I can re-submit a version with the 3 vid/pids.  Alan, would you
> > be happy with that?
> >
> > Regards!
> >
> > On Tue, 13 Feb 2024 at 11:47, Laurent Pinchart wrote:
> > > On Mon, Feb 12, 2024 at 02:04:31PM -0500, Alan Stern wrote:
> > > > On Mon, Feb 12, 2024 at 01:22:42PM +0100, Oliver Neukum wrote:
> > > > > On 04.02.24 11:52, Laurent Pinchart wrote:
> > > > > > Hi Ricardo,
> > > > > >
> > > > > > Thank you for the patch.
> > > > >
> > > > > Hi,
> > > > >
> > > > > sorry for commenting on this late, but this patch has
> > > > > a fundamental issue. In fact this issue is the reason the
> > > > > handling for quirks is in usbcore at all.
> > > > >
> > > > > If you leave the setting/clearing of this flag to a driver you
> > > > > are introducing a race condition. The driver may or may not be
> > > > > present at the time a device is enumerated. And you have
> > > > > no idea how long the autosuspend delay is on a system
> > > > > and what its default policy is regarding suspending
> > > > > devices.
> > > > > That means that a device can have been suspended and
> > > > > resumed before it is probed. On a device that needs
> > > > > RESET_RESUME, we are in trouble.
> > > >
> > > > Not necessarily.  If the driver knows that one of these devices may
> > > > already have been suspend and resumed, it can issue its own preemptive
> > > > reset at probe time.
> > > >
> > > > > The inverse issue will arise if a device does not react
> > > > > well to RESET_RESUME. You cannot rule out that a device
> > > > > that must not be reset will be reset.
> > > >
> > > > That's a separate issue, with its own list of potential problems.
> > > >
> > > > > I am sorry, but it seems to me that the exceptions need
> > > > > to go into usbcore.
> > > >
> > > > If we do then we may want to come up with a better scheme for seeing
> > > > which devices need to have a quirk flag set.  A static listing probably
> > > > won't be good enough; the decision may have to be made dynamically.
> > >
> > > I don't mind either way personally. Oliver, could you try to find a good
> > > solution with Ricardo ? I'll merge the outcome.

-- 
Regards,

Laurent Pinchart

