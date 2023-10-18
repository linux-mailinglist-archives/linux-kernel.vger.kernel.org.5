Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173ED7CDCC7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjJRNKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjJRNKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:10:15 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B34115
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 06:10:12 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1qt6JL-0003Re-QX; Wed, 18 Oct 2023 15:10:07 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mgr@pengutronix.de>)
        id 1qt6JL-002ZCt-Aw; Wed, 18 Oct 2023 15:10:07 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <mgr@pengutronix.de>)
        id 1qt6JL-00GSzS-1a; Wed, 18 Oct 2023 15:10:07 +0200
Date:   Wed, 18 Oct 2023 15:10:07 +0200
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Avichal Rakesh <arakesh@google.com>
Cc:     dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        etalvala@google.com, gregkh@linuxfoundation.org,
        jchowdhary@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v4 3/3] usb: gadget: uvc: Fix use-after-free for inflight
 usb_requests
Message-ID: <ZS/ZL8RMix7zppcP@pengutronix.de>
References: <20230930184821.310143-1-arakesh@google.com>
 <20231012002451.254737-1-arakesh@google.com>
 <20231012002451.254737-3-arakesh@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1sv+Q8p5KINhrMnO"
Content-Disposition: inline
In-Reply-To: <20231012002451.254737-3-arakesh@google.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1sv+Q8p5KINhrMnO
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2023 at 05:24:51PM -0700, Avichal Rakesh wrote:
>Currently, the uvc gadget driver allocates all uvc_requests as one array
>and deallocates them all when the video stream stops. This includes
>de-allocating all the usb_requests associated with those uvc_requests.
>This can lead to use-after-free issues if any of those de-allocated
>usb_requests were still owned by the usb controller.
>
>This is patch 2 of 2 in fixing the use-after-free issue. It adds a new
>flag to uvc_video to track when frames and requests should be flowing.
>When disabling the video stream, the flag is tripped and, instead
>of de-allocating all uvc_requests and usb_requests, the gadget
>driver only de-allocates those usb_requests that are currently
>owned by it (as present in req_free). Other usb_requests are left
>untouched until their completion handler is called which takes care
>of freeing the usb_request and its corresponding uvc_request.
>
>Now that uvc_video does not depends on uvc->state, this patch removes
>unnecessary upates to uvc->state that were made to accomodate uvc_video
>logic. This should ensure that uvc gadget driver never accidentally
>de-allocates a usb_request that it doesn't own.
>
>Link: https://lore.kernel.org/7cd81649-2795-45b6-8c10-b7df1055020d@google.=
com
>Suggested-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>Signed-off-by: Avichal Rakesh <arakesh@google.com>
>---
>v1 -> v2: Rebased to ToT, and fixed deadlock reported in
>          https://lore.kernel.org/all/ZRv2UnKztgyqk2pt@pengutronix.de/
>v2 -> v3: Fix email threading goof-up
>v3 -> v4: re-rebase to ToT & moved to a uvc_video level lock
>          as discussed in
>          https://lore.kernel.org/b14b296f-2e08-4edf-aeea-1c5b621e2d0c@goo=
gle.com/

I tested this and I no longer saw any use after free
errors anymore! :)

Here comes some more review:

> drivers/usb/gadget/function/uvc.h       |   1 +
> drivers/usb/gadget/function/uvc_v4l2.c  |  12 +-
> drivers/usb/gadget/function/uvc_video.c | 156 +++++++++++++++++++-----
> 3 files changed, 128 insertions(+), 41 deletions(-)
>
>diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/functi=
on/uvc.h
>index 993694da0bbc..be0d012aa244 100644
>--- a/drivers/usb/gadget/function/uvc.h
>+++ b/drivers/usb/gadget/function/uvc.h
>@@ -102,6 +102,7 @@ struct uvc_video {
> 	unsigned int uvc_num_requests;
>
> 	/* Requests */
>+	bool is_enabled; /* tracks whether video stream is enabled */
> 	unsigned int req_size;
> 	struct list_head ureqs; /* all uvc_requests allocated by uvc_video */
> 	struct list_head req_free;
>diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/f=
unction/uvc_v4l2.c
>index c0d77564a204..ded7d33c2a52 100644
>--- a/drivers/usb/gadget/function/uvc_v4l2.c
>+++ b/drivers/usb/gadget/function/uvc_v4l2.c
>@@ -451,8 +451,8 @@ uvc_v4l2_streamon(struct file *file, void *fh, enum v4=
l2_buf_type type)
> 	 * Complete the alternate setting selection setup phase now that
> 	 * userspace is ready to provide video frames.
> 	 */
>-	uvc_function_setup_continue(uvc, 0);
> 	uvc->state =3D UVC_STATE_STREAMING;
>+	uvc_function_setup_continue(uvc, 0);
>
> 	return 0;
> }
>@@ -468,12 +468,12 @@ uvc_v4l2_streamoff(struct file *file, void *fh, enum=
 v4l2_buf_type type)
> 	if (type !=3D video->queue.queue.type)
> 		return -EINVAL;
>
>-	uvc->state =3D UVC_STATE_CONNECTED;
> 	ret =3D uvcg_video_enable(video, 0);
> 	if (ret < 0) {
> 		return ret;
> 	}
>
>+	uvc->state =3D UVC_STATE_CONNECTED;
> 	uvc_function_setup_continue(uvc, 1);
> 	return 0;
> }
>@@ -508,14 +508,6 @@ uvc_v4l2_subscribe_event(struct v4l2_fh *fh,
> static void uvc_v4l2_disable(struct uvc_device *uvc)
> {
> 	uvc_function_disconnect(uvc);
>-	/*
>-	 * Drop uvc->state to CONNECTED if it was streaming before.
>-	 * This ensures that the usb_requests are no longer queued
>-	 * to the controller.
>-	 */
>-	if (uvc->state =3D=3D UVC_STATE_STREAMING)
>-		uvc->state =3D UVC_STATE_CONNECTED;
>-
> 	uvcg_video_enable(&uvc->video, 0);
> 	uvcg_free_buffers(&uvc->video.queue);
> 	uvc->func_connected =3D false;
>diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/=
function/uvc_video.c
>index b62b3de79153..05b89b5b6c48 100644
>--- a/drivers/usb/gadget/function/uvc_video.c
>+++ b/drivers/usb/gadget/function/uvc_video.c
>@@ -227,6 +227,9 @@ uvc_video_encode_isoc(struct usb_request *req, struct =
uvc_video *video,
>  * Request handling
>  */
>
>+/**
>+ * Must be called with req_lock held as it modifies the list ureq is held=
 in
>+ */
> static void
> uvc_video_free_request(struct uvc_request *ureq, struct usb_ep *ep)
> {
>@@ -271,9 +274,25 @@ uvc_video_complete(struct usb_ep *ep, struct usb_requ=
est *req)
> 	struct uvc_request *ureq =3D req->context;
> 	struct uvc_video *video =3D ureq->video;
> 	struct uvc_video_queue *queue =3D &video->queue;
>-	struct uvc_device *uvc =3D video->uvc;
>+	struct uvc_buffer *last_buf =3D NULL;
> 	unsigned long flags;
>
>+	spin_lock_irqsave(&video->req_lock, flags);
>+	if (!video->is_enabled) {
>+		/*
>+		 * When is_enabled is false, uvc_video_disable ensures that
>+		 * in-flight uvc_buffers are returned, so we can safely
>+		 * call free_request without worrying about last_buf.
>+		 */
>+		uvc_video_free_request(ureq, ep);
>+		spin_unlock_irqrestore(&video->req_lock, flags);
>+		return;
>+	}
>+
>+	last_buf =3D ureq->last_buf;
>+	ureq->last_buf =3D NULL;
>+	spin_unlock_irqrestore(&video->req_lock, flags);
>+
> 	switch (req->status) {
> 	case 0:
> 		break;
>@@ -295,17 +314,26 @@ uvc_video_complete(struct usb_ep *ep, struct usb_req=
uest *req)
> 		uvcg_queue_cancel(queue, 0);
> 	}
>
>-	if (ureq->last_buf) {
>-		uvcg_complete_buffer(&video->queue, ureq->last_buf);
>-		ureq->last_buf =3D NULL;
>+	if (last_buf) {
>+		spin_lock_irqsave(&queue->irqlock, flags);
>+		uvcg_complete_buffer(&video->queue, last_buf);
>+		spin_unlock_irqrestore(&queue->irqlock, flags);
> 	}
>
> 	spin_lock_irqsave(&video->req_lock, flags);
>-	list_add_tail(&req->list, &video->req_free);
>-	spin_unlock_irqrestore(&video->req_lock, flags);
>-
>-	if (uvc->state =3D=3D UVC_STATE_STREAMING)
>+	/*
>+	 * Video stream might have been disabled while we were
>+	 * processing the current usb_request. So make sure
>+	 * we're still streaming before queueing the usb_request
>+	 * back to req_free
>+	 */
>+	if (video->is_enabled) {
>+		list_add_tail(&req->list, &video->req_free);
> 		queue_work(video->async_wq, &video->pump);
>+	} else {
>+		uvc_video_free_request(ureq, ep);
>+	}
>+	spin_unlock_irqrestore(&video->req_lock, flags);
> }
>
> static int
>@@ -391,20 +419,22 @@ static void uvcg_video_pump(struct work_struct *work)
> 	struct uvc_video_queue *queue =3D &video->queue;
> 	/* video->max_payload_size is only set when using bulk transfer */
> 	bool is_bulk =3D video->max_payload_size;
>-	struct uvc_device *uvc =3D video->uvc;
> 	struct usb_request *req =3D NULL;
> 	struct uvc_buffer *buf;
> 	unsigned long flags;
> 	bool buf_done;
> 	int ret;
>
>-	while (uvc->state =3D=3D UVC_STATE_STREAMING && video->ep->enabled) {
>+	while(true) {

Missing space after "while".

>+		if (!video->ep->enabled)
>+			return;
>+
> 		/*
>-		 * Retrieve the first available USB request, protected by the
>-		 * request lock.
>+		 * Check is_enabled and retrieve the first available USB
>+		 * request, protected by the request lock.
> 		 */
> 		spin_lock_irqsave(&video->req_lock, flags);
>-		if (list_empty(&video->req_free)) {
>+		if (!video->is_enabled || list_empty(&video->req_free)) {
> 			spin_unlock_irqrestore(&video->req_lock, flags);
> 			return;
> 		}
>@@ -486,9 +516,78 @@ static void uvcg_video_pump(struct work_struct *work)
> 		return;
>
> 	spin_lock_irqsave(&video->req_lock, flags);
>-	list_add_tail(&req->list, &video->req_free);
>+	if (video->is_enabled)
>+		list_add_tail(&req->list, &video->req_free);
>+	else
>+		uvc_video_free_request(req->context, video->ep);
>+	spin_unlock_irqrestore(&video->req_lock, flags);
>+}
>+
>+/*
>+ * Disable video stream
>+ */
>+static int
>+uvcg_video_disable(struct uvc_video *video) {
>+	unsigned long flags;
>+	struct list_head inflight_bufs;
>+	struct usb_request *req, *temp;
>+	struct uvc_buffer *buf, *btemp;
>+	struct uvc_request *ureq, *utemp;
>+
>+	INIT_LIST_HEAD(&inflight_bufs);
>+	spin_lock_irqsave(&video->req_lock, flags);
>+	video->is_enabled =3D false;
>+
>+	/*
>+	 * Remove any in-flight buffers from the uvc_requests
>+	 * because we want to return them before cancelling the
>+	 * queue. This ensures that we aren't stuck waiting for
>+	 * all complete callbacks to come through before disabling
>+	 * vb2 queue.
>+	 */
>+	list_for_each_entry(ureq, &video->ureqs, list) {
>+		if (ureq->last_buf) {
>+			list_add_tail(&ureq->last_buf->queue, &inflight_bufs);
>+			ureq->last_buf =3D NULL;
>+		}
>+	}
> 	spin_unlock_irqrestore(&video->req_lock, flags);
>-	return;
>+
>+	cancel_work_sync(&video->pump);
>+	uvcg_queue_cancel(&video->queue, 0);
>+
>+	spin_lock_irqsave(&video->req_lock, flags);
>+	/*
>+	 * Remove all uvc_reqeusts from from ureqs with list_del_init
>+	 * This lets uvc_video_free_request correctly identify
>+	 * if the uvc_request is attached to a list or not when freeing
>+	 * memory.
>+	 */
>+	list_for_each_entry_safe(ureq, utemp, &video->ureqs, list)
>+		list_del_init(&ureq->list);
>+
>+	list_for_each_entry_safe(req, temp, &video->req_free, list) {
>+		list_del(&req->list);
>+		uvc_video_free_request(req->context, video->ep);
>+	}
>+
>+	INIT_LIST_HEAD(&video->ureqs);
>+	INIT_LIST_HEAD(&video->req_free);
>+	video->req_size =3D 0;
>+	spin_unlock_irqrestore(&video->req_lock, flags);
>+
>+	/*
>+	 * Return all the video buffers before disabling the queue.
>+	 */
>+	spin_lock_irqsave(&video->queue.irqlock, flags);
>+	list_for_each_entry_safe(buf, btemp, &inflight_bufs, queue) {
>+		list_del(&buf->queue);
>+		uvcg_complete_buffer(&video->queue, buf);
>+	}
>+	spin_unlock_irqrestore(&video->queue.irqlock, flags);
>+
>+	uvcg_queue_enable(&video->queue, 0);
>+	return 0;
> }
>
> /*
>@@ -497,28 +596,22 @@ static void uvcg_video_pump(struct work_struct *work)
> int uvcg_video_enable(struct uvc_video *video, int enable)
> {
> 	int ret;
>-	struct uvc_request *ureq;
>
> 	if (video->ep =3D=3D NULL) {
> 		uvcg_info(&video->uvc->func,
> 			  "Video enable failed, device is uninitialized.\n");
> 		return -ENODEV;
> 	}
>-
>-	if (!enable) {
>-		cancel_work_sync(&video->pump);
>-		uvcg_queue_cancel(&video->queue, 0);
>-
>-		list_for_each_entry(ureq, &video->ureqs, list) {
>-			if (ureq->req)
>-				usb_ep_dequeue(video->ep, ureq->req);
>-		}
>-
>-		uvc_video_free_requests(video);
>-		uvcg_queue_enable(&video->queue, 0);
>-		return 0;
>-	}
>-
>+	if (!enable)
>+		return uvcg_video_disable(video);

Could you refactor this code as it is to an separate
function and prepand this change as an extra patch
to this one? It would make the changes in the functions
more obvious and better to review.

>+
>+	/*
>+	 * Safe to access request related fields without req_lock because
>+	 * this is the only thread currently active, and no other
>+	 * request handling thread will become active until this function
>+	 * returns.
>+	 */
>+	video->is_enabled =3D true;

Add an extra empty line.

> 	if ((ret =3D uvcg_queue_enable(&video->queue, 1)) < 0)
> 		return ret;
>
>@@ -544,6 +637,7 @@ int uvcg_video_enable(struct uvc_video *video, int ena=
ble)
>  */
> int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc)
> {
>+	video->is_enabled =3D false;
> 	INIT_LIST_HEAD(&video->ureqs);
> 	INIT_LIST_HEAD(&video->req_free);
> 	spin_lock_init(&video->req_lock);
>--
>2.42.0.609.gbb76f46606-goog
>
>

Reviewed-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Tested-by: Michael Grzeschik <m.grzeschik@pengutronix.de>


--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--1sv+Q8p5KINhrMnO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmUv2SwACgkQC+njFXoe
LGThRA/8DHI1OB19SEtUoniNF0R/ijUOfnrLmoWu7T+06rOpAIRmwMhpSHzB4ruR
1Dn8dmPQqY4oh/8rmL2rM4dgdDApNjVTO9r0QxGpZSegxe8k+uHcJbVaai8MjcKm
3+E2yiArBJwY24DKQ44if2gmTDJRYVEYXPpnKTeQkQ2GDB7b82ADS+Ww+VoMLlQ2
JzRpEkEojaV3cbO5scozBTC9q6y0sq0060XpwDUS6I3TQqLi6W/UvztvI/9+21BO
hYj10zZlndeFZstycPWGcZyV89c8WvDEsLvHwTQ351IKXKy0yXjJc41nQY/eckc3
3ZqpDNGEe7FzsswIhPXs5SCcRFvA4eDa5kjLSkIZqGy34xUAr+oyy1+fVDlp6vYN
fpVUuipm3z9bK5n6m+hLCLICJ4Yjm0jnD3l+Nx6+5AP2kN7AmtT6RKCCbPrdcYzm
c92xkaFEm32y0rbwYJnrf/7bOehktRnthIsBiEOjsvbZ/eqIeUDNURkwD6CFcuB/
JZ1WicFTyTGnZoQqLj6J658YLytQLQ7ONxrwnJgu6wYOgOTsG0oG3gqkcPeiaABe
FOL2FnXkStBku0es1rvi1YJEXrgO0IzKjZ2WMPEfRxj59CHqBKAOecx+LiOEDYs/
G6s0sS4wNPMRFE2W0QWacAYZDYi7pN6MajUm7F9sQP5tP1mveCw=
=585t
-----END PGP SIGNATURE-----

--1sv+Q8p5KINhrMnO--
