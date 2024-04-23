Return-Path: <linux-kernel+bounces-155367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727358AE969
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78AE1B22425
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9511A6A03F;
	Tue, 23 Apr 2024 14:25:14 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEFE139D1B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 14:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713882313; cv=none; b=Y2ItNhdu9lJgANnRaQS0pB0U56t1IT8pnDY8yQGluF3BmD2LLABF296n1zL51VW2z+pMZB6PKKuTZY3QU2DS2QSQLR5aD85d6nv/70fh6UTna11HSXbc9S+cxoQP/28ol2l6JmVsSzZagjkwdqtwabokxVn24fJS0pk2O/jpdEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713882313; c=relaxed/simple;
	bh=8gqjlT+NAG/LnNUmirvpIEfJgjj4C/RuZXZoY7Tx8z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etY/2xY8IM+56oYxiXdCziCuLaO9UTw1C214ZvJDUicS6TnSxVKuohQDqMlzM4da/XBPn9Ws6lzIkV7cxi53YDwBDpxB4ZIRGKCXgP5xxrb/u/S6gVEKuq4wUeLsxSbZtaG0dJdZwFIWfK4DXCUji6o0zT9gE5v4TwterpjwtPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1rzH4x-0000NU-CJ; Tue, 23 Apr 2024 16:25:03 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1rzH4w-00DuYX-09; Tue, 23 Apr 2024 16:25:02 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1rzH4v-009uDa-2u;
	Tue, 23 Apr 2024 16:25:01 +0200
Date: Tue, 23 Apr 2024 16:25:01 +0200
From: Michael Grzeschik <mgr@pengutronix.de>
To: Avichal Rakesh <arakesh@google.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jayant Chowdhary <jchowdhary@google.com>, etalvala@google.com,
	Michael Riesch <michael.riesch@wolfvision.net>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] usb: gadget: uvc: allocate requests based on frame
 interval length and buffersize
Message-ID: <ZifEvUi9-E8M4dp8@pengutronix.de>
References: <ZiWga5Kqno1ICv97@pengutronix.de>
 <dcad0089-4105-44bc-a2b4-3cfc6f44164b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pAYe3sblKvwSCo0F"
Content-Disposition: inline
In-Reply-To: <dcad0089-4105-44bc-a2b4-3cfc6f44164b@google.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--pAYe3sblKvwSCo0F
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ccing:

Michael Riesch <michael.riesch@wolfvision.net>
Thinh Nguyen <Thinh.Nguyen@synopsys.com>

On Mon, Apr 22, 2024 at 05:21:09PM -0700, Avichal Rakesh wrote:
>On 4/21/24 16:25, Michael Grzeschik wrote:
>> On Tue, Apr 09, 2024 at 11:24:56PM +0200, Michael Grzeschik wrote:
>>> This patch series is improving the size calculation and allocation
>>> of the uvc requests. Using the currenlty setup frame duration of the
>>> stream it is possible to calculate the number of requests based on the
>>> interval length.
>>
>> The basic concept here is right. But unfortunatly we found out that
>> together with Patch [1] and the current zero length request pump
>> mechanism [2] and [3] this is not working as expected.
>>
>> The conclusion that we can not queue more than one frame at once into
>> the hw led to [1]. The current implementation of zero length reqeusts
>> which will be queued while we are waiting for the frame to finish
>> transferring will enlarge the frame duration. Since every zero-length
>> request is still taking up at least one frame interval of 125 us.
>
>I haven't taken a super close look at your patches, so please feel free
>to correct me if I am misunderstanding something.
>
>It looks like the goal of the patches is to determine a better number
>and size of usb_requests from the given framerate such that we send exactly
>nreqs requests per frame where nreqs is determined to be the exact number
>of requests that can be sent in one frame interval?

It does not need to be the exact time, actually it may not be exact.
Scattering the data over all requests would not leave any headroom for
any latencies or overhead.

>As the logic stands, we need some 0-length requests to be circulating to
>ensure that we don't miss ISOC deadlines. The current logic unconditionally
>sends half of all allocated requests to be circulated.
>
>With those two things in mind, this means than video_pump can at encode
>at most half a frame in one go, and then has to wait for complete
>callbacks to come in. In such cases, the theoretical worst case for
>encode time is
>125us * (number of requests needed per frame / 2) + scheduling delays
>as after the first half of the frame has been encoded, the video_pump
>thread will have to wait 125us for each of the zero length requests to
>be returned.
>
>The underlying assumption behind the "queue 0-length requests" approach
>was that video_pump encodes the frames in as few requests as possible
>and that there are spare requests to maintain a pressure on the
>ISOC queue without hindering the video_pump thread, and unfortunately
>it seems like patch 3/3 is breaking both of them?

Right.

>Assuming my understanding of your patches is correct, my question
>is: Why do we want to spread the frame uniformly over the requests
>instead of encoding it in as few requests as possible. Spreading
>the frame over more requests artificially increases the encode time
>required by video_pump, and AFAICT there is no real benefit to it?

Thinh gave me the advise that it is better to use the isoc stream
constantly filled. Rather then streaming big amounts of data in the
beginning of an frameinterval and having then a lot of spare time
where the bandwidth is completely unsused.

In our reallife scenario streaming big requests had the impact, that
the dwc3 core could not keep up with reading the amount of data
=66rom the memory bus, as the bus is already under heavy load. When the
HW was then not able to transfer the requested and actually available
amount of data in the interval, the hw did give us the usual missed
interrupt answer.

Using smaller requests solved the problem here, as it really was
unnecessary to stress the memory and usb bus in the beginning as
we had enough headroom in the temporal domain.

Which then led to the conclusion that the number of needed requests
per image frame interval is calculatable since we know the usb
interval length.

@Thinh: Correct me if I am saying something wrong here.

>> Therefor to properly make those patches work, we will have to get rid of
>> the zero length pump mechanism again and make sure that the whole
>> business logic of what to be queued and when will only be done in the
>> pump worker. It is possible to let the dwc3 udc run dry, as we are
>> actively waiting for the frame to finish, the last request in the
>> prepared and started list will stop the current dwc3 stream and  for
>> no underruns will occur with the next ep_queue.
>
>One thing to note here: The reason we moved to queuing 0-length requests
>from complete callback was because even with realtime priority, video_pump
>thread doesn't always meet the ISOC queueing cadence. I think stopping and
>starting the stream was briefly discussed in our initial discussion in
>https://lore.kernel.org/all/20230419001143.pdxflhzyecf4kvee@synopsys.com/
>and Thinh mentioned that dwc3 controller does it if it detects an underrun,
>but I am not sure if starting and stopping an ISOC stream is good practice.

The realtime latency aspect is not an issue anymore if we ensure that we
always keep only one frame in the hw ring buffer. When the pump worker
ensure that it will always run through one full frame the scheduler has
no chance to break our running dwc3 stream. Since the pump is running
under a while(1) this should be possible.

Also with the request amount precalculation we can always encode the
whole frame into all available requests and don't have to wait for
requests to be available again.

Together with the latest knowladge about the underlying hw we even need to =
only
keep one frame in the HW ring buffer. Since we have some interrupt latency,
keeping more frames in the ring buffer, would mean that we are not able to =
tag
the currently streamed frame properly as errornous if the dwc3 hw ring buff=
er
is already telling the host some data about the next frame. And as we alrea=
dy
need to wait for the end of the frame to finish, based on the assumption th=
at
only one frame is enqueued in the ring buffer the hw will stop the stream a=
nd
the next requst will start a new stream. So there will no missed underruns =
be
happening.

So the main fact here is, that telling the host some status about a
frame in the past is impossible! Therefor the first request of the next
hw stream need to be the one that is telling the Host if the previous frame
is ment to be drawn or not.

>Someone better versed in USB protocol can probably confirm, but it seems
>somewhat hacky to stop the ISOC stream at the end of the frame and restart
>with the next frame.

All I know is that the HW mechanism that is reading from the trb ring buffe=
r is
started or stopped I don't know if really the ISOC stream is stopped and
restarted here or what that means on the real wire. And if so, I am unsure =
if
that is really a problem or not. Thinh?

Regards,
Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--pAYe3sblKvwSCo0F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmYnxLcACgkQC+njFXoe
LGTxWw/7BgPauuaLsObgielou/Vbj4cuMoFf/sDUjtHTPxs//knIZdN5OJQGvtSA
p3j21QhhVZCG/vaa7luIRV9VLAo6ZlkAWZDFpYa+D2P9e4MnsMsZ7DA7lTqm00Vj
4GDf9AmXk69ENwWWcGZRru/tz4MIhBdXsIBa0dHzLtzyY8PMHH6ltg7s81Kg6+Uw
DVBCD8P2FdMcFqrik8sIG+hY34xodoX5MsMQPMvy/ZQzjMbQ1tkzwAQIx6a76uZ1
gMN28swzpk+jypHshExpUwMlNaIh1R3HeVTHPuZySYEvenxjIJhaD01MGsub8LKz
0neONyQVVkkrS804Dzqi3+jyaOaFxvHLaJlkcjKEWh2MfaDB77WCcnL3ikqjSYxW
5Hmzwy94NVKPy+WxZ1peUP+SnxfiE0iXQ1M0D3+TXLx7WXdxco0Zqtbn5ZeedDuJ
s8pkp8IjmacGP1xEEZHjxUg6TVkSXNEoXChdSwwRAICnpg1Y+6X9gwC36bnkUjst
VEHhuOst39Ir2VWg+p/e3Yz3JMaJ/hOhZK6rMG8Uxdf/urdmYe1B5HI5cNpcTZAK
S3bwJ09suo8l7KVMDV1swxPOKWdGIYrJo1zbCGQHm5lJvo91SnOaLrOZBPH8bZw7
hDqVPEb3LM2QaxrddaXobjVN1sLQobYkJKCgIHRrL9p5khpLVno=
=uJCa
-----END PGP SIGNATURE-----

--pAYe3sblKvwSCo0F--

