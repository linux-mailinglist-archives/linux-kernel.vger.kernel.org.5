Return-Path: <linux-kernel+bounces-95849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB158875402
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 689551F23C69
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4769912FB12;
	Thu,  7 Mar 2024 16:15:46 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C262983CAD
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 16:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709828145; cv=none; b=R8LRpvBRykFgvK+g/EbsHLu7DA+IkUER1lujhLs/n0tY3ILEawMcHYOdQ1kxx0IfYyI77wlIvJU9cH4+qQ6G8y4ylEm6chYT3XinQwfYi7VNelx837WjhfE0eFMMEKttQRR1rv6XPqOlz7dKQ96LA7B6CW0IeI3fFfugWMnX50I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709828145; c=relaxed/simple;
	bh=qJYnLCapEmT7Ajrz9ekftaJwc5Tg58ZuGzaIhu4UQeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2+vpisxyF/mfWo+kimdYQobgMvjuywu+bmTjCv3qBW5mynclsJfJyqKASE+xFLq/WW53xl1nxMgu0PE9LWX0In8sF4GafeDxZPNuRzhvjaPtI1jbOB92aybCY+AtZW4QyFwVJASox9YqHyKgCx68JILLcr4rxdIAqBx2G5/2OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1riGOo-00085I-8E; Thu, 07 Mar 2024 17:15:14 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1riGOn-004ybQ-4E; Thu, 07 Mar 2024 17:15:13 +0100
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1riGOn-006SBZ-04;
	Thu, 07 Mar 2024 17:15:13 +0100
Date: Thu, 7 Mar 2024 17:15:12 +0100
From: Michael Grzeschik <mgr@pengutronix.de>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Dan Vacura <w36195@motorola.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Jeff Vanhoof <qjv001@motorola.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Felipe Balbi <balbi@kernel.org>,
	Paul Elder <paul.elder@ideasonboard.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] usb: dwc3: gadget: cancel requests instead of
 release after missed isoc
Message-ID: <ZenoEJmne73BlCFI@pengutronix.de>
References: <20221017205446.523796-1-w36195@motorola.com>
 <20221017205446.523796-3-w36195@motorola.com>
 <ZdaPLGTbsBo4F4pK@pengutronix.de>
 <20240222011955.7sida4udjlvrlue7@synopsys.com>
 <Zd5Nns91uXvTOAwd@pengutronix.de>
 <20240307015736.4dhcrzsli4dihym5@synopsys.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r33SlKd0DtSnqSFk"
Content-Disposition: inline
In-Reply-To: <20240307015736.4dhcrzsli4dihym5@synopsys.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--r33SlKd0DtSnqSFk
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2024 at 01:57:44AM +0000, Thinh Nguyen wrote:
>On Tue, Feb 27, 2024, Michael Grzeschik wrote:
>> On Thu, Feb 22, 2024 at 01:20:04AM +0000, Thinh Nguyen wrote:
>> > On Thu, Feb 22, 2024, Michael Grzeschik wrote:
>> > > For #2: I found an issue in the handling of the completion of reques=
ts in
>> > > the started list. When the interrupt handler is *explicitly* calling
>> > > stop_active_transfer if the overall event of the request was an miss=
ed
>> > > event. This event value only represents the value of the request that
>> > > was actually triggering the interrupt.
>> > >
>> > > It also calls ep_cleanup_completed_requests and is iterating over the
>> > > started requests and will call giveback/complete functions of the
>> > > requests with the proper request status.
>> > >
>> > > So this will also catch missed requests in the queue. However, since
>> > > there might be, lets say 5 good requests and one missed request, what
>> > > will happen is, that each complete call for the first good requests =
will
>> > > enqueue new requests into the started list and will also call the
>> > > updatecmd on that transfer that was already missed until the loop wi=
ll
>> > > reach the one request with the MISSED status bit set.
>> > >
>> > > So in my opinion the patch from Jeff makes sense when adding the
>> > > following change aswell. With those both changes the underruns and
>> > > broken frames finally disappear. I am still unsure about the complete
>> > > solution about that, since with this the mentioned 5 good requests
>> > > will be cancelled aswell. So this is still a WIP status here.
>> > >
>> >
>> > When the dwc3 driver issues stop_active_transfer(), that means that the
>> > started_list is empty and there is an underrun.
>>
>> At this moment this is only the case when both, pending and started list
>> are empty. Or the interrupt event was EXDEV.
>>
>> The main problem is that the function
>> dwc3_gadget_ep_cleanup_completed_requests(dep, event, status); will
>> issue an complete for each started request, which on the other hand will
>> refill the pending list, and therefor after that refill the
>> stop_active_transfer is currently never hit.
>>
>> > It treats the incoming requests as staled. However, for UVC, they are
>> > still "good".
>>
>> Right, so in that case we can requeue them anyway. But this will have to
>> be done after the stop transfer cmd has finished.
>>
>> > I think you can just check if the started_list is empty before queuing
>> > new requests. If it is, perform stop_active_transfer() to reschedule t=
he
>> > incoming requests. None of the newly queue requests will be released
>> > yet since they are in the pending_list.
>>
>> So that is basically exactly what my patch is doing. However in the case
>> of an underrun it is not safe to call dwc3_gadget_ep_cleanup_completed_r=
equests
>> as jeff stated. So his underlying patch is really fixing an issue here.
>
>What I mean is to actively check for started list on every
>usb_ep_queue() call. Checking during
>dwc3_gadget_ep_cleanup_completed_requests() is already too late.

I see.

>>
>> > For UVC, perhaps you can introduce a new flag to usb_request called
>> > "ignore_queue_latency" or something equivalent. The dwc3 is already
>> > partially doing this for UVC. With this new flag, we can rework dwc3 to
>> > clearly separate the expected behavior from the function driver.
>>
>> I don't know why this "extra" flag is even necessary. The code example
>> is already working without that extra flag.
>
>The flag is for controller to determine what kinds of behavior the
>function driver expects. My intention is if this extra flag is not set,
>the dwc3 driver will not attempt to reshcedule isoc request at all (ie.
>no stop_active_transfer()).

Ok.

>>
>> Actually I even came up with an better solution. Additionally of checkin=
g if
>> one of the requests in the started list was missed, we can activly check=
 if
>> the trb ring did run dry and if dwc3_gadget_endpoint_trbs_complete is
>> going to enqueue in to the empty trb ring.
>>
>> So my whole change looks like that:
>>
>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>> index efe6caf4d0e87..2c8047dcd1612 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -952,6 +952,7 @@ struct dwc3_request {
>>  #define DWC3_REQUEST_STATUS_DEQUEUED		3
>>  #define DWC3_REQUEST_STATUS_STALLED		4
>>  #define DWC3_REQUEST_STATUS_COMPLETED		5
>> +#define DWC3_REQUEST_STATUS_MISSED_ISOC		6
>>  #define DWC3_REQUEST_STATUS_UNKNOWN		-1
>>  	u8			epnum;
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 858fe4c299b7a..a31f4d3502bd3 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -2057,6 +2057,9 @@ static void dwc3_gadget_ep_cleanup_cancelled_reque=
sts(struct dwc3_ep *dep)
>>  		req =3D next_request(&dep->cancelled_list);
>>  		dwc3_gadget_ep_skip_trbs(dep, req);
>>  		switch (req->status) {
>> +		case 0:
>> +			dwc3_gadget_giveback(dep, req, 0);
>> +			break;
>>  		case DWC3_REQUEST_STATUS_DISCONNECTED:
>>  			dwc3_gadget_giveback(dep, req, -ESHUTDOWN);
>>  			break;
>> @@ -2066,6 +2069,9 @@ static void dwc3_gadget_ep_cleanup_cancelled_reque=
sts(struct dwc3_ep *dep)
>>  		case DWC3_REQUEST_STATUS_STALLED:
>>  			dwc3_gadget_giveback(dep, req, -EPIPE);
>>  			break;
>> +		case DWC3_REQUEST_STATUS_MISSED_ISOC:
>> +			dwc3_gadget_giveback(dep, req, -EXDEV);
>> +			break;
>>  		default:
>>  			dev_err(dwc->dev, "request cancelled with wrong reason:%d\n", req->s=
tatus);
>>  			dwc3_gadget_giveback(dep, req, -ECONNRESET);
>> @@ -3509,6 +3515,36 @@ static int dwc3_gadget_ep_cleanup_completed_reque=
st(struct dwc3_ep *dep,
>>  	return ret;
>>  }
>> +static int dwc3_gadget_ep_check_missed_requests(struct dwc3_ep *dep)
>> +{
>> +	struct dwc3_request	*req;
>> +	struct dwc3_request	*tmp;
>> +	int ret =3D 0;
>> +
>> +	list_for_each_entry_safe(req, tmp, &dep->started_list, list) {
>> +		struct dwc3_trb *trb;
>> +
>> +		trb =3D req->trb;
>> +		switch (DWC3_TRB_SIZE_TRBSTS(trb->size)) {
>> +		case DWC3_TRBSTS_MISSED_ISOC:
>> +			/* Isoc endpoint only */
>> +			ret =3D -EXDEV;
>> +			break;
>> +		case DWC3_TRB_STS_XFER_IN_PROG:
>> +			/* Applicable when End Transfer with ForceRM=3D0 */
>> +		case DWC3_TRBSTS_SETUP_PENDING:
>> +			/* Control endpoint only */
>> +		case DWC3_TRBSTS_OK:
>> +		default:
>> +			ret =3D 0;
>> +			break;
>> +		}
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>  static void dwc3_gadget_ep_cleanup_completed_requests(struct dwc3_ep *d=
ep,
>>  		const struct dwc3_event_depevt *event, int status)
>>  {
>> @@ -3565,22 +3601,51 @@ static bool dwc3_gadget_endpoint_trbs_complete(s=
truct dwc3_ep *dep,
>>  {
>>  	struct dwc3		*dwc =3D dep->dwc;
>>  	bool			no_started_trb =3D true;
>> +	unsigned int		transfer_in_flight =3D 0;
>> +
>> +	/* It is possible that the interrupt thread was delayed by
>> +	 * scheduling in the system, and therefor the HW has already
>> +	 * run dry. In that case the last trb in the queue is already
>> +	 * handled by the hw. By checking the HWO bit we know to restart
>> +	 * the whole transfer. The condition to appear is more likelely
>> +	 * if not every trb has the IOC bit set and therefor does not
>> +	 * trigger the interrupt thread fewer.
>> +	 */
>> +	if (dep->number && usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
>> +		struct dwc3_trb *trb;
>> -	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);
>> +		trb =3D dwc3_ep_prev_trb(dep, dep->trb_enqueue);
>> +		transfer_in_flight =3D trb->ctrl & DWC3_TRB_CTRL_HWO;
>> +	}
>> -	if (dep->flags & DWC3_EP_END_TRANSFER_PENDING)
>> -		goto out;
>> +	if (status =3D=3D -EXDEV || !transfer_in_flight) {
>> +		struct dwc3_request *tmp;
>> +		struct dwc3_request *req;
>> -	if (!dep->endpoint.desc)
>> -		return no_started_trb;
>> +		if (!(dep->flags & DWC3_EP_END_TRANSFER_PENDING))
>> +			dwc3_stop_active_transfer(dep, true, true);
>> -	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
>> -		list_empty(&dep->started_list) &&
>> -		(list_empty(&dep->pending_list) || status =3D=3D -EXDEV))

@[!!here!!]

>> -		dwc3_stop_active_transfer(dep, true, true);
>> -	else if (dwc3_gadget_ep_should_continue(dep))
>> -		if (__dwc3_gadget_kick_transfer(dep) =3D=3D 0)
>> -			no_started_trb =3D false;
>> +		list_for_each_entry_safe(req, tmp, &dep->started_list, list) {
>> +			dwc3_gadget_move_cancelled_request(req,
>> +					(DWC3_TRB_SIZE_TRBSTS(req->trb->size) =3D=3D DWC3_TRBSTS_MISSED_IS=
OC) ?
>> +					DWC3_REQUEST_STATUS_MISSED_ISOC : 0);
>> +		}
>> +	} else {
>> +		dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);
>> +
>> +		if (dep->flags & DWC3_EP_END_TRANSFER_PENDING)
>> +			goto out;
>> +
>> +		if (!dep->endpoint.desc)
>> +			return no_started_trb;
>> +
>> +		if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
>> +			list_empty(&dep->started_list) && list_empty(&dep->pending_list))
>> +			dwc3_stop_active_transfer(dep, true, true);
>> +		else if (dwc3_gadget_ep_should_continue(dep))
>> +			if (__dwc3_gadget_kick_transfer(dep) =3D=3D 0)
>> +				no_started_trb =3D false;
>> +	}
>>  out:
>>  	/*
>>
>> I will seperate the whole hunk into smaller changes and send an v1
>> the next days to review.
>>

I finally send a v1 of my series.

https://lore.kernel.org/linux-usb/20240307-dwc3-gadget-complete-irq-v1-0-4f=
e9ac0ba2b7@pengutronix.de/

For the rest of the discussion, I would like to move the conversation to
the newly send series.

>No, we should not reschedule for every missed-isoc. We only want to
>target underrun condition.

As you stated above, with reschedule what you mean is calling
stop_transfer after a missed transfer was seen?

If so, why is this condition in there already? (@[!!here!!])

Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--r33SlKd0DtSnqSFk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmXp6A4ACgkQC+njFXoe
LGSWkA//ZQaQ+k1jx9KQsMAKpuYUdItk4XYUxoq//AzhMksEfL9bBjueJ4c1mT5P
nY9y0wUWelHZPDz41LBMBN0vKaWQ/8tzu6Y/iW/OQM0BTQ8qxz9tbI1DoYGCbx7s
SylqrBgkasGvCmQ2iWacq4kcIQhx7E34xTPf05epxh7qihtYZkwzc9HSyugxXFnl
X0SPRKYjUD13dpaGGYYp04tBzzpKgXuXSBsDyqmQvbwAtB0aBTVlgYLfmioidKDo
wuVozstMYjo0BNypLB1GqPqgrTaRDs+3rhSZcjO2pOlJpfsGrkKfvJ4gYDHjmyvM
fbsLtKEdvRvDq7rxm1PINWN9VOW3zGhuOiyRAAaZGSe7yZMtyCn2kPF84q/vkz8W
MfATuXJrWbqC1qCI+dXAl/vXUg65280atKgZFBlwl/d23KuMSYrdNwBJfxYs0KWQ
axugdmcyLIb0uMtDkT1QXwnUNBGZz8wIMaD+JcTqU9CQUbNn7BuaDpBhQxGIaPiR
cvwmQwIynhS24OgUX+2raI+S+5rvqjGipXbTkkTEvsxbB5j3dojy4J1dT7L4/G5q
0Xapy2geNwYImilZpvqdxSQjjiSaLVHTuN/5d4RJxdGrf5gplkExXXZuYGYQ71Z5
kCT9HoupuDvl1OlAVDm7H5PCFG1jL+Nl75XeKuMdqE15hnszRk0=
=LLdF
-----END PGP SIGNATURE-----

--r33SlKd0DtSnqSFk--

