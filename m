Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3591E7B26FB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjI1VEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjI1VEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:04:22 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4C1B7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 14:04:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1qlyBE-0002LI-1n; Thu, 28 Sep 2023 23:04:16 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mgr@pengutronix.de>)
        id 1qlyBD-009et9-GL; Thu, 28 Sep 2023 23:04:15 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <mgr@pengutronix.de>)
        id 1qlyBD-005E4u-6v; Thu, 28 Sep 2023 23:04:15 +0200
Date:   Thu, 28 Sep 2023 23:04:15 +0200
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Avichal Rakesh <arakesh@google.com>
Cc:     dan.scally@ideasonboard.com, etalvala@google.com,
        gregkh@linuxfoundation.org, jchowdhary@google.com,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 2/2] usb: gadget: uvc: prevent de-allocating inflight
 usb_requests
Message-ID: <ZRXqT/pIPwCxrk2+@pengutronix.de>
References: <20230920200335.63709-1-arakesh@google.com>
 <20230928201904.454229-1-arakesh@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fYsXicxS4fOLjbMg"
Content-Disposition: inline
In-Reply-To: <20230928201904.454229-1-arakesh@google.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fYsXicxS4fOLjbMg
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Avichal

Thanks for the patch!

On Thu, Sep 28, 2023 at 01:19:04PM -0700, Avichal Rakesh wrote:
>Currently, when stopping the stream, uvcg_video_enable immediately
>deallocates the usb_requests after calling usb_ep_dequeue. However,
>usb_ep_dequeue is asynchronous and it is possible that it a request
>that is still in use by the controller. This can lead to some hard
>to reproduce crashes with double frees and general memory
>inconsistencies.
>
>This patch sets up some stronger guarantees around when a request should
>be deallocated. To that extent, this patch does the following:
>1. When stream is stopped only the currently owned uvc_requests are freed
>   and all in-flight uvc_requests are marked 'abandoned'
>2. uvc_video_complete callback is made responsible for freeing up the
>   abandoned requests. No uvc specific logic is triggered when handling
>   abandoned requests.
>
>This ensures that the ownership of uvc_request (and its corresponding
>usb_request) is never ambiguous, and uvc_requests are always freed
>regardless of when the requests are returned to the gadget driver.
>
>Other changes in the patch are required to decouple the allocated
>uvc_requests from uvc_video that allocated them.


Unfortunatly the format of this patch is relly heavy to review. You are
changing to much at once. Could you please finegrain your changes in
smaller overall topics.

Starting with the transition from the one big kcalloc to the chaned
list. This patch will be easy to review.

After that you could address this issue you are refering to.

This will help the review alot. I already saw some changes that are
probably even completely unrelated.


>
>Link: https://lore.kernel.org/7cd81649-2795-45b6-8c10-b7df1055020d@google.=
com
>Suggested-by: Michael Grzeschik <mgr@pengutronix.de>
>Signed-off-by: Avichal Rakesh <arakesh@google.com>
>---
>v1 -> v2: Switched from a timed wait to free on complete model based
>          on discussions with Michael.
>v3 -> v3: Initialized ureqs at init to prevent accessing invalid
>          memory when no stream is created.
>
> drivers/usb/gadget/function/uvc.h       |   4 +-
> drivers/usb/gadget/function/uvc_video.c | 183 +++++++++++++++++-------
> 2 files changed, 134 insertions(+), 53 deletions(-)
>
>diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/functi=
on/uvc.h
>index 989bc6b4e93d..e69cfb7cced1 100644
>--- a/drivers/usb/gadget/function/uvc.h
>+++ b/drivers/usb/gadget/function/uvc.h
>@@ -81,6 +81,8 @@ struct uvc_request {
> 	struct sg_table sgt;
> 	u8 header[UVCG_REQUEST_HEADER_LEN];
> 	struct uvc_buffer *last_buf;
>+	struct list_head list;
>+	bool is_abandoned;
> };
>
> struct uvc_video {
>@@ -102,7 +104,7 @@ struct uvc_video {
>
> 	/* Requests */
> 	unsigned int req_size;
>-	struct uvc_request *ureq;
>+	struct list_head ureqs; /* all uvc_requests allocated by uvc_video */
> 	struct list_head req_free;
> 	spinlock_t req_lock;
>
>diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/=
function/uvc_video.c
>index 70ff88854539..aa5ef63e5540 100644
>--- a/drivers/usb/gadget/function/uvc_video.c
>+++ b/drivers/usb/gadget/function/uvc_video.c
>@@ -227,6 +227,23 @@ uvc_video_encode_isoc(struct usb_request *req, struct=
 uvc_video *video,
>  * Request handling
>  */
>
>+static void uvc_video_free_request(struct uvc_request *ureq, struct usb_e=
p *ep)
>+{
>+	sg_free_table(&ureq->sgt);
>+	if (ureq->req && ep) {
>+		usb_ep_free_request(ep, ureq->req);
>+		ureq->req =3D NULL;
>+	}
>+
>+	kfree(ureq->req_buffer);
>+	ureq->req_buffer =3D NULL;
>+
>+	if (!list_empty(&ureq->list))
>+		list_del(&ureq->list);
>+
>+	kfree(ureq);
>+}
>+
> static int uvcg_video_ep_queue(struct uvc_video *video, struct usb_reques=
t *req)
> {
> 	int ret;
>@@ -254,7 +271,21 @@ uvc_video_complete(struct usb_ep *ep, struct usb_requ=
est *req)
> 	struct uvc_video *video =3D ureq->video;
> 	struct uvc_video_queue *queue =3D &video->queue;
> 	struct uvc_device *uvc =3D video->uvc;
>+	struct uvc_buffer *last_buf;
> 	unsigned long flags;
>+	bool is_abandoned;
>+
>+	spin_lock_irqsave(&video->req_lock, flags);
>+	is_abandoned =3D ureq->is_abandoned;
>+	last_buf =3D ureq->last_buf;
>+	ureq->last_buf =3D NULL;
>+	spin_unlock_irqrestore(&video->req_lock, flags);
>+
>+	if (is_abandoned) {
>+		uvcg_dbg(&video->uvc->func, "Freeing abandoned request\n");
>+		uvc_video_free_request(ureq, ep);
>+		return;
>+	}
>
> 	switch (req->status) {
> 	case 0:
>@@ -277,15 +308,27 @@ uvc_video_complete(struct usb_ep *ep, struct usb_req=
uest *req)
> 		uvcg_queue_cancel(queue, 0);
> 	}
>
>-	if (ureq->last_buf) {
>-		uvcg_complete_buffer(&video->queue, ureq->last_buf);
>-		ureq->last_buf =3D NULL;
>+	if (last_buf) {
>+		spin_lock_irqsave(&video->queue.irqlock, flags);
>+		uvcg_complete_buffer(&video->queue, last_buf);
>+		spin_unlock_irqrestore(&video->queue.irqlock, flags);
> 	}

This change seems unrelated to the rest of the patch.

>
>+	/*
>+	 * request might have been abandoned while being processed.
>+	 * do a last minute check before queueing the request back.
>+	 */
> 	spin_lock_irqsave(&video->req_lock, flags);
>-	list_add_tail(&req->list, &video->req_free);
>+	is_abandoned =3D ureq->is_abandoned;
>+	if (!is_abandoned)
>+		list_add_tail(&req->list, &video->req_free);
> 	spin_unlock_irqrestore(&video->req_lock, flags);
>
>+	if (is_abandoned) {
>+		uvc_video_free_request(ureq, ep);
>+		return;
>+	}
>+

This whole check of is_abondoned is really hard to read and understand.
Could it be somehow simplified?

> 	if (uvc->state =3D=3D UVC_STATE_STREAMING)
> 		queue_work(video->async_wq, &video->pump);
> }
>@@ -293,25 +336,10 @@ uvc_video_complete(struct usb_ep *ep, struct usb_req=
uest *req)
> static int
> uvc_video_free_requests(struct uvc_video *video)
> {
>-	unsigned int i;
>-
>-	if (video->ureq) {
>-		for (i =3D 0; i < video->uvc_num_requests; ++i) {
>-			sg_free_table(&video->ureq[i].sgt);
>+	struct uvc_request *ureq, *temp;
>
>-			if (video->ureq[i].req) {
>-				usb_ep_free_request(video->ep, video->ureq[i].req);
>-				video->ureq[i].req =3D NULL;
>-			}
>-
>-			if (video->ureq[i].req_buffer) {
>-				kfree(video->ureq[i].req_buffer);
>-				video->ureq[i].req_buffer =3D NULL;
>-			}
>-		}
>-
>-		kfree(video->ureq);
>-		video->ureq =3D NULL;
>+	list_for_each_entry_safe(ureq, temp, &video->ureqs, list) {
>+		uvc_video_free_request(ureq, video->ep);

I thought we wanted to iterate over the req_free list in this function?

> 	}
>
> 	INIT_LIST_HEAD(&video->req_free);
>@@ -322,6 +350,7 @@ uvc_video_free_requests(struct uvc_video *video)
> static int
> uvc_video_alloc_requests(struct uvc_video *video)
> {
>+	struct uvc_request *ureq;
> 	unsigned int req_size;
> 	unsigned int i;
> 	int ret =3D -ENOMEM;
>@@ -332,35 +361,36 @@ uvc_video_alloc_requests(struct uvc_video *video)
> 		 * max_t(unsigned int, video->ep->maxburst, 1)
> 		 * (video->ep->mult);
>
>-	video->ureq =3D kcalloc(video->uvc_num_requests, sizeof(struct uvc_reque=
st), GFP_KERNEL);
>-	if (video->ureq =3D=3D NULL)
>-		return -ENOMEM;
>-
>-	for (i =3D 0; i < video->uvc_num_requests; ++i) {
>-		video->ureq[i].req_buffer =3D kmalloc(req_size, GFP_KERNEL);
>-		if (video->ureq[i].req_buffer =3D=3D NULL)
>+	INIT_LIST_HEAD(&video->ureqs);
>+	for (i =3D 0; i < video->uvc_num_requests; i++) {
>+		ureq =3D kzalloc(sizeof(struct uvc_request), GFP_KERNEL);
>+		if (ureq =3D=3D NULL)
> 			goto error;
>+		INIT_LIST_HEAD(&ureq->list);
>+		list_add_tail(&ureq->list, &video->ureqs);
>+	}
>
>-		video->ureq[i].req =3D usb_ep_alloc_request(video->ep, GFP_KERNEL);
>-		if (video->ureq[i].req =3D=3D NULL)
>+	list_for_each_entry(ureq, &video->ureqs, list) {
>+		ureq->req_buffer =3D kmalloc(req_size, GFP_KERNEL);
>+		if (ureq->req_buffer =3D=3D NULL)
> 			goto error;
>-
>-		video->ureq[i].req->buf =3D video->ureq[i].req_buffer;
>-		video->ureq[i].req->length =3D 0;
>-		video->ureq[i].req->complete =3D uvc_video_complete;
>-		video->ureq[i].req->context =3D &video->ureq[i];
>-		video->ureq[i].video =3D video;
>-		video->ureq[i].last_buf =3D NULL;
>-
>-		list_add_tail(&video->ureq[i].req->list, &video->req_free);
>+		ureq->req =3D usb_ep_alloc_request(video->ep, GFP_KERNEL);
>+		if (ureq->req =3D=3D NULL)
>+			goto error;
>+		ureq->req->buf =3D ureq->req_buffer;
>+		ureq->req->length =3D 0;
>+		ureq->req->complete =3D uvc_video_complete;
>+		ureq->req->context =3D ureq;
>+		ureq->video =3D video;
>+		ureq->last_buf =3D NULL;
>+		list_add_tail(&ureq->req->list, &video->req_free);
> 		/* req_size/PAGE_SIZE + 1 for overruns and + 1 for header */
>-		sg_alloc_table(&video->ureq[i].sgt,
>+		sg_alloc_table(&ureq->sgt,
> 			       DIV_ROUND_UP(req_size - UVCG_REQUEST_HEADER_LEN,
> 					    PAGE_SIZE) + 2, GFP_KERNEL);
> 	}

Please move these changes to an separate patch.
>
> 	video->req_size =3D req_size;
>-
> 	return 0;
>
> error:
>@@ -484,12 +514,68 @@ static void uvcg_video_pump(struct work_struct *work)
> 	return;
> }
>
>+/*
>+ * Disable video stream. This ensures that any inflight usb requests are =
marked
>+ * for clean up and video buffers are dropped up before returning.
>+ */
>+static void uvcg_video_disable(struct uvc_video *video)
>+{
>+	struct uvc_buffer *buf, *tmp_buf;
>+	struct uvc_request *ureq, *temp;
>+	struct list_head buf_list; /* track in-flight video buffers */
>+	struct usb_request *req;
>+	unsigned long flags;
>+
>+	cancel_work_sync(&video->pump);
>+	uvcg_queue_cancel(&video->queue, 0);
>+
>+	INIT_LIST_HEAD(&buf_list);
>+	spin_lock_irqsave(&video->req_lock, flags);
>+	/* abandon all usb requests */
>+	list_for_each_entry_safe(ureq, temp, &video->ureqs, list) {
>+		ureq->is_abandoned =3D true;
>+		if (ureq->last_buf) {
>+			list_add(&ureq->last_buf->queue, &buf_list);
>+			ureq->last_buf =3D NULL;
>+		}
>+		list_del_init(&ureq->list);
>+		if (ureq->req)
>+			usb_ep_dequeue(video->ep, ureq->req);
>+	}
>+	/*
>+	 * re-add uvc_requests currently owned by the gadget to
>+	 * video->ureqs to be deallocated
>+	 */
>+	list_for_each_entry(req, &video->req_free, list) {
>+		ureq =3D req->context;
>+		list_add_tail(&ureq->list, &video->ureqs);
>+	}
So what you actually do is moving the requests from the free list
to the ureqs list. Would it not be possible to separate the cleanup
on two locations instead?

>+	spin_unlock_irqrestore(&video->req_lock, flags);
>+
>+	/*
>+	 * drop abandoned uvc_buffers, as the completion handler
>+	 * no longer will
>+	 */
>+	if (!list_empty(&buf_list)) {
>+		spin_lock_irqsave(&video->queue.irqlock, flags);
>+		list_for_each_entry_safe(buf, tmp_buf,
>+						&buf_list, queue) {
>+			video->queue.flags |=3D UVC_QUEUE_DROP_INCOMPLETE;
>+			uvcg_complete_buffer(&video->queue, buf);
>+			list_del(&buf->queue);
>+		}
>+		spin_unlock_irqrestore(&video->queue.irqlock, flags);
>+	}
>+
>+	uvc_video_free_requests(video);
>+	uvcg_queue_enable(&video->queue, 0);
>+}
>+
> /*
>  * Enable or disable the video stream.
>  */
> int uvcg_video_enable(struct uvc_video *video, int enable)
> {
>-	unsigned int i;
> 	int ret;
>
> 	if (video->ep =3D=3D NULL) {
>@@ -499,15 +585,7 @@ int uvcg_video_enable(struct uvc_video *video, int en=
able)
> 	}
>
> 	if (!enable) {
>-		cancel_work_sync(&video->pump);
>-		uvcg_queue_cancel(&video->queue, 0);
>-
>-		for (i =3D 0; i < video->uvc_num_requests; ++i)
>-			if (video->ureq && video->ureq[i].req)
>-				usb_ep_dequeue(video->ep, video->ureq[i].req);
>-
>-		uvc_video_free_requests(video);
>-		uvcg_queue_enable(&video->queue, 0);
>+		uvcg_video_disable(video);
> 		return 0;
> 	}
>
>@@ -536,6 +614,7 @@ int uvcg_video_enable(struct uvc_video *video, int ena=
ble)
>  */
> int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc)
> {
>+	INIT_LIST_HEAD(&video->ureqs);
> 	INIT_LIST_HEAD(&video->req_free);
> 	spin_lock_init(&video->req_lock);
> 	INIT_WORK(&video->pump, uvcg_video_pump);
>--
>2.42.0.582.g8ccd20d70d-goog

Regards,
Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--fYsXicxS4fOLjbMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmUV6kwACgkQC+njFXoe
LGSpnA/8DWOXhnY1GAlnvIcdAD13MgDLyyF0Z3DT4LMJDqKM6FUQtTJwV6lzGWfc
We7AaMYqAoJf6AuWOPFY5FRdgUyNCCtvulR/Y41YBXVAz4IMthrr6fkhr55y+a6w
Q22uBOd4boREMOVhvgNjVekBHVTWoPfMioJ2Cu9pk9zGEA8vvoJk//yU0KamGR5q
MD/v1pdaMs67WnIojKxzw3RpkTy+Ugjro38q+IM9Iumopph+/dJHkdlLJC0Y6Zo9
qqFZ+OH3wSz1d5S6r3tVphBVTPt5G4y26gCFE/mMNyNl904/DBBUZ1qo5RldfAs9
t5tlEwgqUBFM4UKrW/Kc6NnddLAwT7p4Xpx1cTUqRFwgLXXLAxBLz70wmTCKQ8ov
YWpucAZtpwXRYigGF2XCYxvKT9MrF3Leh59IqqxcRnQZJWPI4DU3NcKNbB/F+bar
tXoLd+0Jophlc5F1bhZUobUhsrPT7mn1AepbqX1PEehu5liNJBFCp36m1tY88hYU
8vtw1vn4ZUy8b0faGNKMw8kBkM107xyqnkFTgvcGvI2iJYR8/1kGywvIjvvnwPjI
4Qn3cpi5PoysDLQs57jFOBng+00EBx9jAq22ntTv7mCD5T9K23bmgonxedrGupuf
2+ZVMFsFSqAm8WRYxFvjwVRo3Vpo+PA0jwTkAL5m5O0KC3Wt0EU=
=1+10
-----END PGP SIGNATURE-----

--fYsXicxS4fOLjbMg--
