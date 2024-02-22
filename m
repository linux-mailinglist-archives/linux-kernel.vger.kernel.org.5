Return-Path: <linux-kernel+bounces-75696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F8985ED81
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E56621C2291A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B62C1755A;
	Thu, 22 Feb 2024 00:03:14 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC22D168AC
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708560193; cv=none; b=ia8CgJyqxU5UcpNL68xIxTYSHn5F5EqYE57eGmYMpn+QUJuu6zf9w2muvRzrdJ9MHJ6BQUV7/gEdPvj2MjiOmyTwYY9Cq1K//SoK2Bft6g3x7wR4mplXHJ7h5XhuBYnxXaph3vA/57hFv8IdoY4ihcchDrQOnNcLpReIJE2k2hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708560193; c=relaxed/simple;
	bh=CRm2/J2tmxJvfyj/dvWAkWX3iQ5AB5xxi9YWHB4X8ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEVd1lRMe7xTJDhUUQ2DoUJ7cM+kiexJSmn7kdRqAYh1Rh9Qco4I52NlvvUbUOIdC9jdmUoRCabCY0joOIJL1mXFm8csQwywGiX8560ObYgSCxrYTzenTwwt5olUbOB6pk6LePY7fYYt9fhSu9uzR/+GcS6qRXWO3+45N4bEsPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mgr@pengutronix.de>)
	id 1rcwYA-0004FG-J6; Thu, 22 Feb 2024 01:02:54 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mgr@pengutronix.de>)
	id 1rcwY8-0027zR-Sz; Thu, 22 Feb 2024 01:02:52 +0100
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mgr@pengutronix.de>)
	id 1rcwY8-001QME-2N;
	Thu, 22 Feb 2024 01:02:52 +0100
Date: Thu, 22 Feb 2024 01:02:52 +0100
From: Michael Grzeschik <mgr@pengutronix.de>
To: Dan Vacura <w36195@motorola.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: linux-usb@vger.kernel.org, Daniel Scally <dan.scally@ideasonboard.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Jeff Vanhoof <qjv001@motorola.com>, stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Felipe Balbi <balbi@kernel.org>,
	Paul Elder <paul.elder@ideasonboard.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/6] usb: dwc3: gadget: cancel requests instead of
 release after missed isoc
Message-ID: <ZdaPLGTbsBo4F4pK@pengutronix.de>
References: <20221017205446.523796-1-w36195@motorola.com>
 <20221017205446.523796-3-w36195@motorola.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7167IsNR9GtUxaC9"
Content-Disposition: inline
In-Reply-To: <20221017205446.523796-3-w36195@motorola.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--7167IsNR9GtUxaC9
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sorry for digging up this grave! :)

I once more came accross the whole situation we are still encountering
since one year or so again and found the some reasons why:

#1 there are so many latencies, so that the system is not fast enough to
enqueue requests back into an running HW-Transfer. At least on our
system setup.

and

#2 there are so many missed transfers leading to broken frames
when adding request with no_interrupt set.

For #1: There sometimes are situations in the system where the threaded
interrupt handler for the dwc3 is not called fast enough, although the
HW-irq was called early and enqueued the irq event and woke the irq
thread early. In our case this often happens, when there are other tasks
involved on the same CPU and the scheduler is not able to pipeline the
irq thread in the necessary time. In our case the main issue is an
HW-irq handler of the ethernet controller (cadence macb) that runs
berserk on CPU0 and therefor is taking a lot of CPU time. Per default on
our system all irq handlers are running on the same CPU. As per
definition all interrupt threads will be started on the same CPU as the
irq was called, this forces a lot of pressure on one Core. So changing
the smp_affinity of the dwc3 irq to the second CPU only, already solves
a lot of the underruns.

For #2: I found an issue in the handling of the completion of requests in
the started list. When the interrupt handler is *explicitly* calling
stop_active_transfer if the overall event of the request was an missed
event. This event value only represents the value of the request that
was actually triggering the interrupt.

It also calls ep_cleanup_completed_requests and is iterating over the
started requests and will call giveback/complete functions of the
requests with the proper request status.

So this will also catch missed requests in the queue. However, since
there might be, lets say 5 good requests and one missed request, what
will happen is, that each complete call for the first good requests will
enqueue new requests into the started list and will also call the
updatecmd on that transfer that was already missed until the loop will
reach the one request with the MISSED status bit set.

So in my opinion the patch from Jeff makes sense when adding the
following change aswell. With those both changes the underruns and
broken frames finally disappear. I am still unsure about the complete
solution about that, since with this the mentioned 5 good requests
will be cancelled aswell. So this is still a WIP status here.

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index e031813c5769b..b991d25bbf897 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3509,6 +3509,45 @@ static int dwc3_gadget_ep_cleanup_completed_request(=
struct dwc3_ep *dep,
         return ret;
  }

+static int dwc3_gadget_ep_check_missed_requests(struct dwc3_ep *dep)
+{
+       struct dwc3_request     *req;
+       struct dwc3_request     *tmp;
+       int ret =3D 0;
+
+       list_for_each_entry_safe(req, tmp, &dep->started_list, list) {
+               struct dwc3_trb *trb;
+
+               /* TOOD: check if the trb association is correct */
+               trb =3D req->trb;
+               switch (DWC3_TRB_SIZE_TRBSTS(trb->size)) {
+               case DWC3_TRBSTS_MISSED_ISOC:
+                       /* Isoc endpoint only */
+                       ret =3D -EXDEV;
+                       break;
+               case DWC3_TRB_STS_XFER_IN_PROG:
+                       /* Applicable when End Transfer with ForceRM=3D0 */
+               case DWC3_TRBSTS_SETUP_PENDING:
+                       /* Control endpoint only */
+               case DWC3_TRBSTS_OK:
+               default:
+                       ret =3D 0;
+                       break;
+               }
+       }
+
+       return ret;
+}
+
  static void dwc3_gadget_ep_cleanup_completed_requests(struct dwc3_ep *dep,
                 const struct dwc3_event_depevt *event, int status)
  {
@@ -3566,7 +3605,7 @@ static bool dwc3_gadget_endpoint_trbs_complete(struct=
 dwc3_ep *dep,
         struct dwc3             *dwc =3D dep->dwc;
         bool                    no_started_trb =3D true;

-       if (status =3D=3D -EXDEV) {
+       if (status =3D=3D -EXDEV || dwc3_gadget_ep_check_missed_requests(de=
p)) {
                 struct dwc3_request *tmp;
                 struct dwc3_request *req;


On Mon, Oct 17, 2022 at 03:54:40PM -0500, Dan Vacura wrote:
>From: Jeff Vanhoof <qjv001@motorola.com>
>
>arm-smmu related crashes seen after a Missed ISOC interrupt when
>no_interrupt=3D1 is used. This can happen if the hardware is still using
>the data associated with a TRB after the usb_request's ->complete call
>has been made.  Instead of immediately releasing a request when a Missed
>ISOC interrupt has occurred, this change will add logic to cancel the
>request instead where it will eventually be released when the
>END_TRANSFER command has completed. This logic is similar to some of the
>cleanup done in dwc3_gadget_ep_dequeue.
>
>Fixes: 6d8a019614f3 ("usb: dwc3: gadget: check for Missed Isoc from event =
status")
>Cc: <stable@vger.kernel.org>
>Signed-off-by: Jeff Vanhoof <qjv001@motorola.com>
>Co-developed-by: Dan Vacura <w36195@motorola.com>
>Signed-off-by: Dan Vacura <w36195@motorola.com>
>---
>V1 -> V3:
>- no change, new patch in series
>
> drivers/usb/dwc3/core.h   |  1 +
> drivers/usb/dwc3/gadget.c | 38 ++++++++++++++++++++++++++------------
> 2 files changed, 27 insertions(+), 12 deletions(-)
>
>diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>index 8f9959ba9fd4..9b005d912241 100644
>--- a/drivers/usb/dwc3/core.h
>+++ b/drivers/usb/dwc3/core.h
>@@ -943,6 +943,7 @@ struct dwc3_request {
> #define DWC3_REQUEST_STATUS_DEQUEUED		3
> #define DWC3_REQUEST_STATUS_STALLED		4
> #define DWC3_REQUEST_STATUS_COMPLETED		5
>+#define DWC3_REQUEST_STATUS_MISSED_ISOC		6
> #define DWC3_REQUEST_STATUS_UNKNOWN		-1
>
> 	u8			epnum;
>diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>index 079cd333632e..411532c5c378 100644
>--- a/drivers/usb/dwc3/gadget.c
>+++ b/drivers/usb/dwc3/gadget.c
>@@ -2021,6 +2021,9 @@ static void dwc3_gadget_ep_cleanup_cancelled_request=
s(struct dwc3_ep *dep)
> 		case DWC3_REQUEST_STATUS_STALLED:
> 			dwc3_gadget_giveback(dep, req, -EPIPE);
> 			break;
>+		case DWC3_REQUEST_STATUS_MISSED_ISOC:
>+			dwc3_gadget_giveback(dep, req, -EXDEV);
>+			break;
> 		default:
> 			dev_err(dwc->dev, "request cancelled with wrong reason:%d\n", req->sta=
tus);
> 			dwc3_gadget_giveback(dep, req, -ECONNRESET);
>@@ -3402,21 +3405,32 @@ static bool dwc3_gadget_endpoint_trbs_complete(str=
uct dwc3_ep *dep,
> 	struct dwc3		*dwc =3D dep->dwc;
> 	bool			no_started_trb =3D true;
>
>-	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);
>+	if (status =3D=3D -EXDEV) {
>+		struct dwc3_request *tmp;
>+		struct dwc3_request *req;
>
>-	if (dep->flags & DWC3_EP_END_TRANSFER_PENDING)
>-		goto out;
>+		if (!(dep->flags & DWC3_EP_END_TRANSFER_PENDING))
>+			dwc3_stop_active_transfer(dep, true, true);
>
>-	if (!dep->endpoint.desc)
>-		return no_started_trb;
>+		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
>+			dwc3_gadget_move_cancelled_request(req,
>+					DWC3_REQUEST_STATUS_MISSED_ISOC);
>+	} else {
>+		dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);
>
>-	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
>-		list_empty(&dep->started_list) &&
>-		(list_empty(&dep->pending_list) || status =3D=3D -EXDEV))
>-		dwc3_stop_active_transfer(dep, true, true);
>-	else if (dwc3_gadget_ep_should_continue(dep))
>-		if (__dwc3_gadget_kick_transfer(dep) =3D=3D 0)
>-			no_started_trb =3D false;
>+		if (dep->flags & DWC3_EP_END_TRANSFER_PENDING)
>+			goto out;
>+
>+		if (!dep->endpoint.desc)
>+			return no_started_trb;
>+
>+		if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
>+			list_empty(&dep->started_list) && list_empty(&dep->pending_list))
>+			dwc3_stop_active_transfer(dep, true, true);
>+		else if (dwc3_gadget_ep_should_continue(dep))
>+			if (__dwc3_gadget_kick_transfer(dep) =3D=3D 0)
>+				no_started_trb =3D false;
>+	}
>
> out:
> 	/*
>--=20
>2.34.1
>

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--7167IsNR9GtUxaC9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmXWjykACgkQC+njFXoe
LGRNBg/9Ggqr8dqyPbcVNqwQ76whL7PXxMgDlxYZVgyaH/muk5JSxnGVD4LzbNAn
gq2kWbkWRV9qqlMICcniXSlDlumccR6PznVmC9SRcWm8sxY+3L8dAHGc1mJ6IyPy
dgtbiBLitH0dRdBRN6Oo3cZoxE1zMkiKumaZDO7/U851glEgQ+/jgUPWTksbU7x0
GNrvOHlK7S5IKnB25hcfYYtzsQOWobnyfEEBdgxkUd0tBfUjGNmHgP4tBVelbDAQ
lKl8OBdazijiDs0JO1cW0Y2uQ8fUhVWi+b3SgUsTVj8eMMoz65xxEqHJla5x462t
uNnRf2PDdjSGg5OloG6NmvvPin5NNAVKW9kCb6s6VDmun0XmpAG2e/rQdcwyAfpX
62Uc7FzJxilMq1yT7RDI/sl82qYaLIvmLvgcDOGdqg4Ofl/pyj7Ck47Q71YMxwuQ
bxiKZC+pzkifx6dw/MIKaA3JWj/0aMAGAToEPMEKxgAdyMlO0edIqNK9nvIx7wkr
I74aaks+reY6CZxtv7wHHVuVH1leAtVL0xVtm5aq2deHx5ssJGQz+83AUYSwZPZY
6dWZ7gUYM7v/0PpQeVLO10VJsnLZfHC40JWH7FQbTKyUbhA9zMdrH4dbQ2DtkGDV
vHN8dgm5mDmUr5CrxybAK/OFAMrz/vSumAN8bKVmPkG/oVlPt5Q=
=FhI4
-----END PGP SIGNATURE-----

--7167IsNR9GtUxaC9--

