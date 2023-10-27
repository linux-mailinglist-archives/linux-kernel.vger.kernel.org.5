Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4DB7D9A30
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345979AbjJ0Nj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345931AbjJ0Njy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:39:54 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CABD6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:39:50 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1qwN3y-0004ER-0l; Fri, 27 Oct 2023 15:39:46 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mgr@pengutronix.de>)
        id 1qwN3w-004ebD-Gq; Fri, 27 Oct 2023 15:39:44 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <mgr@pengutronix.de>)
        id 1qwN3w-00Bqyj-7P; Fri, 27 Oct 2023 15:39:44 +0200
Date:   Fri, 27 Oct 2023 15:39:44 +0200
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Jayant Chowdhary <jchowdhary@google.com>,
        Thinh.Nguyen@synopsys.com, arakesh@google.com, etalvala@google.com,
        dan.scally@ideasonboard.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] usb:gadget:uvc Do not use worker thread to pump usb
 requests
Message-ID: <ZTu9oEw1QEOxbHCf@pengutronix.de>
References: <ZToOJhyOFeGCGUFj@pengutronix.de>
 <20231026215635.2478767-1-jchowdhary@google.com>
 <20231027075117.GJ26306@pendragon.ideasonboard.com>
 <ZTuanepgXLXRoSMW@pengutronix.de>
 <20231027114752.GB12144@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8TbuoqaByW9sqUzB"
Content-Disposition: inline
In-Reply-To: <20231027114752.GB12144@pendragon.ideasonboard.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8TbuoqaByW9sqUzB
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 02:47:52PM +0300, Laurent Pinchart wrote:
>On Fri, Oct 27, 2023 at 01:10:21PM +0200, Michael Grzeschik wrote:
>> On Fri, Oct 27, 2023 at 10:51:17AM +0300, Laurent Pinchart wrote:
>> > On Thu, Oct 26, 2023 at 09:56:35PM +0000, Jayant Chowdhary wrote:
>> >> This patch is based on top of
>> >> https://lore.kernel.org/linux-usb/20230930184821.310143-1-arakesh@goo=
gle.com/T/#t:
>> >>
>> >> When we use an async work queue to perform the function of pumping
>> >> usb requests to the usb controller, it is possible that thread schedu=
ling
>> >> affects at what cadence we're able to pump requests. This could mean =
usb
>> >> requests miss their uframes - resulting in video stream flickers on t=
he host
>> >> device.
>> >>
>> >> In this patch, we move the pumping of usb requests to
>> >> 1) uvcg_video_complete() complete handler for both isoc + bulk
>> >>    endpoints. We still send 0 length requests when there is no uvc bu=
ffer
>> >>    available to encode.
>> >
>> > This means you will end up copying large amounts of data in interrupt
>> > context. The work queue was there to avoid exactly that, as it will
>> > introduce delays that can affect other parts of the system. I think th=
is
>> > is a problem.
>>
>> Regarding Thin's argument about possible scheduling latency that is alre=
ady
>> introducing real errors, this seemed like a good solution.
>>
>> But sure, this potential latency introduced in the interrupt context can
>> trigger other side effects.
>>
>> However I think we need some compromise since both arguments are very va=
lid.
>
>Agreed.
>
>> Any ideas, how to solve this?
>
>I'm afraid not.

We discussed this and came to the conclusion that we could make use of
kthread_create and sched_setattr with an attr->sched_policy =3D SCHED_DEADL=
INE
here instead of the workqueue. This way we would ensure that the worker
would be triggered with hard definitions.

Since the SG case is not that heavy on the completion handler, we could
also make this kthread conditionaly to the memcpy case.

>> >> 2) uvc_v4l2_qbuf - only for bulk endpoints since it is not legal to s=
end
>> >>    0 length requests.
>> >>
>> >> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>> >> Signed-off-by: Jayant Chowdhary <jchowdhary@google.com>
>> >> Suggested-by: Jayant Chowdhary <jchowdhary@google.com>
>> >> Suggested-by: Avichal Rakesh <arakesh@google.com>
>> >> Tested-by: Jayant Chowdhary <jchowdhary@google.com>
>> >> ---
>> >>  v1->v2: Fix code style and add self Signed-off-by
>> >>
>> >>  drivers/usb/gadget/function/f_uvc.c     |  4 --
>> >>  drivers/usb/gadget/function/uvc.h       |  4 +-
>> >>  drivers/usb/gadget/function/uvc_v4l2.c  |  5 +-
>> >>  drivers/usb/gadget/function/uvc_video.c | 71 ++++++++++++++++-------=
--
>> >>  drivers/usb/gadget/function/uvc_video.h |  2 +
>> >>  5 files changed, 51 insertions(+), 35 deletions(-)
>> >>
>> >> diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget=
/function/f_uvc.c
>> >> index ae08341961eb..53cb2539486d 100644
>> >> --- a/drivers/usb/gadget/function/f_uvc.c
>> >> +++ b/drivers/usb/gadget/function/f_uvc.c
>> >> @@ -959,14 +959,10 @@ static void uvc_function_unbind(struct usb_conf=
iguration *c,
>> >>  {
>> >>  	struct usb_composite_dev *cdev =3D c->cdev;
>> >>  	struct uvc_device *uvc =3D to_uvc(f);
>> >> -	struct uvc_video *video =3D &uvc->video;
>> >>  	long wait_ret =3D 1;
>> >>
>> >>  	uvcg_info(f, "%s()\n", __func__);
>> >>
>> >> -	if (video->async_wq)
>> >> -		destroy_workqueue(video->async_wq);
>> >> -
>> >>  	/*
>> >>  	 * If we know we're connected via v4l2, then there should be a clea=
nup
>> >>  	 * of the device from userspace either via UVC_EVENT_DISCONNECT or
>> >> diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/f=
unction/uvc.h
>> >> index be0d012aa244..498f344fda4b 100644
>> >> --- a/drivers/usb/gadget/function/uvc.h
>> >> +++ b/drivers/usb/gadget/function/uvc.h
>> >> @@ -88,9 +88,6 @@ struct uvc_video {
>> >>  	struct uvc_device *uvc;
>> >>  	struct usb_ep *ep;
>> >>
>> >> -	struct work_struct pump;
>> >> -	struct workqueue_struct *async_wq;
>> >> -
>> >>  	/* Frame parameters */
>> >>  	u8 bpp;
>> >>  	u32 fcc;
>> >> @@ -116,6 +113,7 @@ struct uvc_video {
>> >>  	/* Context data used by the completion handler */
>> >>  	__u32 payload_size;
>> >>  	__u32 max_payload_size;
>> >> +	bool is_bulk;
>> >
>> >This should be introduced in a separate patch.
>> >
>> >>
>> >>  	struct uvc_video_queue queue;
>> >>  	unsigned int fid;
>> >> diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gad=
get/function/uvc_v4l2.c
>> >> index f4d2e24835d4..678ea6df7b5c 100644
>> >> --- a/drivers/usb/gadget/function/uvc_v4l2.c
>> >> +++ b/drivers/usb/gadget/function/uvc_v4l2.c
>> >> @@ -414,10 +414,7 @@ uvc_v4l2_qbuf(struct file *file, void *fh, struc=
t v4l2_buffer *b)
>> >>  	ret =3D uvcg_queue_buffer(&video->queue, b);
>> >>  	if (ret < 0)
>> >>  		return ret;
>> >> -
>> >> -	if (uvc->state =3D=3D UVC_STATE_STREAMING)
>> >> -		queue_work(video->async_wq, &video->pump);
>> >> -
>> >> +	uvcg_video_pump_qbuf(video);
>> >>  	return ret;
>> >>  }
>> >>
>> >> diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/ga=
dget/function/uvc_video.c
>> >> index ab3f02054e85..0fcd8e5edbac 100644
>> >> --- a/drivers/usb/gadget/function/uvc_video.c
>> >> +++ b/drivers/usb/gadget/function/uvc_video.c
>> >> @@ -24,6 +24,8 @@
>> >>   * Video codecs
>> >>   */
>> >>
>> >> +static void uvcg_video_pump(struct uvc_video *video);
>> >> +
>> >>  static int
>> >>  uvc_video_encode_header(struct uvc_video *video, struct uvc_buffer *=
buf,
>> >>  		u8 *data, int len)
>> >> @@ -329,7 +331,9 @@ uvc_video_complete(struct usb_ep *ep, struct usb_=
request *req)
>> >>  	 */
>> >>  	if (video->is_enabled) {
>> >>  		list_add_tail(&req->list, &video->req_free);
>> >> -		queue_work(video->async_wq, &video->pump);
>> >> +		spin_unlock_irqrestore(&video->req_lock, flags);
>> >> +		uvcg_video_pump(video);
>> >> +		return;
>> >>  	} else {
>> >>  		uvc_video_free_request(ureq, ep);
>> >>  	}
>> >> @@ -409,20 +413,31 @@ uvc_video_alloc_requests(struct uvc_video *vide=
o)
>> >>   * Video streaming
>> >>   */
>> >>
>> >> +void uvcg_video_pump_qbuf(struct uvc_video *video)
>> >> +{
>> >> +	/*
>> >> +	 * Only call uvcg_video_pump() from qbuf, for bulk eps since
>> >> +	 * for isoc, the complete handler will call uvcg_video_pump()
>> >> +	 * consistently. Calling it for isoc eps, while correct
>> >> +	 * will increase contention for video->req_lock since the
>> >> +	 * complete handler will be called more often.
>> >> +	*/
>> >> +	if (video->is_bulk)
>> >> +		uvcg_video_pump(video);
>> >
>> > Am I the only one to see the *major* race condition that this patch
>> > introduces ?
>>
>> Possible that you are. Please elaborate.
>
>uvcg_video_pump() can now run multiple times in parallel on multiple
>CPUs. Look at the while() loop in the function, and consider what will
>happen when run on two CPUs concurrently. See below for an additional
>comment on this.
>
>> >> +}
>> >> +
>> >>  /*
>> >>   * uvcg_video_pump - Pump video data into the USB requests
>> >>   *
>> >>   * This function fills the available USB requests (listed in req_fre=
e) with
>> >>   * video data from the queued buffers.
>> >>   */
>> >> -static void uvcg_video_pump(struct work_struct *work)
>> >> +static void uvcg_video_pump(struct uvc_video *video)
>> >>  {
>> >> -	struct uvc_video *video =3D container_of(work, struct uvc_video, pu=
mp);
>> >>  	struct uvc_video_queue *queue =3D &video->queue;
>> >> -	/* video->max_payload_size is only set when using bulk transfer */
>> >> -	bool is_bulk =3D video->max_payload_size;
>> >>  	struct usb_request *req =3D NULL;
>> >> -	struct uvc_buffer *buf;
>> >> +	struct uvc_request *ureq =3D NULL;
>> >> +	struct uvc_buffer *buf =3D NULL, *last_buf =3D NULL;
>> >>  	unsigned long flags;
>> >>  	bool buf_done;
>> >>  	int ret;
>> >> @@ -455,7 +470,8 @@ static void uvcg_video_pump(struct work_struct *w=
ork)
>> >>  		if (buf !=3D NULL) {
>> >>  			video->encode(req, video, buf);
>> >>  			buf_done =3D buf->state =3D=3D UVC_BUF_STATE_DONE;
>> >> -		} else if (!(queue->flags & UVC_QUEUE_DISCONNECTED) && !is_bulk) {
>> >> +		} else if (!(queue->flags & UVC_QUEUE_DISCONNECTED) &&
>> >> +				!video->is_bulk) {
>> >>  			/*
>> >>  			 * No video buffer available; the queue is still connected and
>> >>  			 * we're transferring over ISOC. Queue a 0 length request to
>> >> @@ -500,18 +516,30 @@ static void uvcg_video_pump(struct work_struct =
*work)
>> >>  			req->no_interrupt =3D 1;
>> >>  		}
>> >>
>> >> -		/* Queue the USB request */
>> >> -		ret =3D uvcg_video_ep_queue(video, req);
>> >>  		spin_unlock_irqrestore(&queue->irqlock, flags);
>> >> -
>
>Here's one problematic point. The code above may have run on CPU A,
>which releases IRQ lock. CPU B may then run the same code to encode the
>next chunk of data in a request, and proceed to the code below before
>CPU A. The requests will then be queued in the wrong order.

Right

>In the next iteration of this patch, I would like to see a clear
>explanation in the commit message of why there is no race condition
>(after fixing the existing ones, of course). Writing it down forces
>going through the mental exercise of thinking about the race conditions,
>which should help catching them.

Agreed.

>> >> +		spin_lock_irqsave(&video->req_lock, flags);
>> >> +		if (video->is_enabled) {
>> >> +			/* Queue the USB request */
>> >> +			ret =3D uvcg_video_ep_queue(video, req);
>> >> +			/* Endpoint now owns the request */
>> >> +			req =3D NULL;
>> >> +			video->req_int_count++;
>> >> +		} else {
>> >> +			ret =3D  -ENODEV;
>> >> +			ureq =3D req->context;
>> >> +			last_buf =3D ureq->last_buf;
>> >> +			ureq->last_buf =3D NULL;
>> >> +		}
>> >> +		spin_unlock_irqrestore(&video->req_lock, flags);
>> >>  		if (ret < 0) {
>> >> +			if (last_buf !=3D NULL) {
>> >> +				// Return the buffer to the queue in the case the
>> >> +				// request was not queued to the ep.
>> >
>> > Wrong comment style.
>> >
>> >> +				uvcg_complete_buffer(&video->queue, last_buf);
>> >> +			}
>> >>  			uvcg_queue_cancel(queue, 0);
>> >>  			break;
>> >>  		}
>> >> -
>> >> -		/* Endpoint now owns the request */
>> >> -		req =3D NULL;
>> >> -		video->req_int_count++;
>> >>  	}
>> >>
>> >>  	if (!req)
>> >> @@ -556,7 +584,6 @@ uvcg_video_disable(struct uvc_video *video)
>> >>  	}
>> >>  	spin_unlock_irqrestore(&video->req_lock, flags);
>> >>
>> >> -	cancel_work_sync(&video->pump);
>> >>  	uvcg_queue_cancel(&video->queue, 0);
>> >>
>> >>  	spin_lock_irqsave(&video->req_lock, flags);
>> >> @@ -626,14 +653,16 @@ int uvcg_video_enable(struct uvc_video *video, =
int enable)
>> >>  	if (video->max_payload_size) {
>> >>  		video->encode =3D uvc_video_encode_bulk;
>> >>  		video->payload_size =3D 0;
>> >> -	} else
>> >> +		video->is_bulk =3D true;
>> >> +	} else {
>> >>  		video->encode =3D video->queue.use_sg ?
>> >>  			uvc_video_encode_isoc_sg : uvc_video_encode_isoc;
>> >> +		video->is_bulk =3D false;
>> >> +	}
>> >>
>> >>  	video->req_int_count =3D 0;
>> >>
>> >> -	queue_work(video->async_wq, &video->pump);
>> >> -
>> >> +	uvcg_video_pump(video);
>> >>  	return ret;
>> >>  }
>> >>
>> >> @@ -646,12 +675,6 @@ int uvcg_video_init(struct uvc_video *video, str=
uct uvc_device *uvc)
>> >>  	INIT_LIST_HEAD(&video->ureqs);
>> >>  	INIT_LIST_HEAD(&video->req_free);
>> >>  	spin_lock_init(&video->req_lock);
>> >> -	INIT_WORK(&video->pump, uvcg_video_pump);
>> >> -
>> >> -	/* Allocate a work queue for asynchronous video pump handler. */
>> >> -	video->async_wq =3D alloc_workqueue("uvcgadget", WQ_UNBOUND | WQ_HI=
GHPRI, 0);
>> >> -	if (!video->async_wq)
>> >> -		return -EINVAL;
>> >>
>> >>  	video->uvc =3D uvc;
>> >>  	video->fcc =3D V4L2_PIX_FMT_YUYV;
>> >> diff --git a/drivers/usb/gadget/function/uvc_video.h b/drivers/usb/ga=
dget/function/uvc_video.h
>> >> index 03adeefa343b..29c6b9a2e9c3 100644
>> >> --- a/drivers/usb/gadget/function/uvc_video.h
>> >> +++ b/drivers/usb/gadget/function/uvc_video.h
>> >> @@ -18,4 +18,6 @@ int uvcg_video_enable(struct uvc_video *video, int =
enable);
>> >>
>> >>  int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc);
>> >>
>> >> +void uvcg_video_pump_qbuf(struct uvc_video *video);
>> >> +
>> >>  #endif /* __UVC_VIDEO_H__ */
>
>--=20
>Regards,
>
>Laurent Pinchart
>

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--8TbuoqaByW9sqUzB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmU7vZ0ACgkQC+njFXoe
LGTrGQ/+ICyva+z9afl879BUd4ky0xvmWCeqa+A2sHTG+EFF6YopNT8PjrdVznvB
++OjfRHggQPUYFyyfrKeY/PRixEglD2018DbHoh+ptTXNl72WtT8CL3PaKJ8zs1W
xO2F3AO3Ql5RDwH0xrCR6lY9eqNR/Ls7KQk3ipMd/rH7VvmJtPJV/0cdC/AQ2KB1
6u/3zO2sqDwab1N5dOkgXe/c+5nu9asr1yhMIqsCNVKzGLRZMCN+M6j6OILl6QhG
Zp2sbIhVHqXRXcJ4ZhaV1WdhGO0q5o6b8aMo4fF1ZDYxZBnSV8RYQJ88dhryBw0x
qnR9o6C4mu5DZ8TQBSvTwW/JU6P0c+kY2oB4C02AVZ561WPD9xLTZmzW7A+I+B/J
LAev8dC5pDXnPxl52v1geXOxn2mdFlV+6TPsIUaBkGH9JlD22fRmYGBg0PnwGnpW
ohwS1wJwtuaZ+UaOfYFYAaRLBlAfyKt+Qhj4OXm//yZ4DsP2Ol5Dc9bwctNX2kdy
aW93Z8LAOpXuPBov8xWoIYVEUBQbqxYjYYrGIZPts9uIptSeVxZXLYBz+EPprN8Q
ikW+prOmXIXGvbSGQSUzmSvTngtRJeFAXGxF7z6gCclKww0k0LHTcy1DL2x0SA+p
1DN/Q1KA5dzJzFZY+WLMratU4VEXF0OryTPp5oK+fxx0wMXXxnk=
=qban
-----END PGP SIGNATURE-----

--8TbuoqaByW9sqUzB--
