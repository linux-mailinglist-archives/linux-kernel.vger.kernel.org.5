Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35617D7D1F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 08:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjJZG64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 02:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZG6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 02:58:54 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA0D191
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 23:58:51 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1qvuKO-0005Sc-D8; Thu, 26 Oct 2023 08:58:48 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mgr@pengutronix.de>)
        id 1qvuKN-004Lis-9N; Thu, 26 Oct 2023 08:58:47 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <mgr@pengutronix.de>)
        id 1qvuKM-00AJdr-W9; Thu, 26 Oct 2023 08:58:47 +0200
Date:   Thu, 26 Oct 2023 08:58:46 +0200
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Jayant Chowdhary <jchowdhary@google.com>
Cc:     "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "dan.scally@ideasonboard.com" <dan.scally@ideasonboard.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: [PATCH] usb:gadget:uvc Do not use worker thread to pump usb
 requests
Message-ID: <ZToOJhyOFeGCGUFj@pengutronix.de>
References: <99384044-0d14-4ebe-9109-8a5557e64449@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uhOVRvhjA5b0Dp6s"
Content-Disposition: inline
In-Reply-To: <99384044-0d14-4ebe-9109-8a5557e64449@google.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uhOVRvhjA5b0Dp6s
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 03:59:10PM -0700, Jayant Chowdhary wrote:
>This patch is based on top of
>https://lore.kernel.org/linux-usb/20230930184821.310143-1-arakesh@google.c=
om/T/#t:
>
>When we use an async work queue to perform the function of pumping
>usb requests to the usb controller, it is possible that thread scheduling
>affects at what cadence we're able to pump requests. This could mean usb
>requests miss their uframes - resulting in video stream flickers on the ho=
st
>device.
>
>In this patch, we move the pumping of usb requests to
>1) uvcg_video_complete() complete handler for both isoc + bulk
>   endpoints. We still send 0 length requests when there is no uvc buffer
>   available to encode.
>2) uvc_v4l2_qbuf - only for bulk endpoints since it is not legal to send
>   0 length requests.
>
>Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>Suggested-by: Jayant Chowdhary <jchowdhary@google.com>
>Suggested-by: Avichal Rakesh <arakesh@google.com>
>Tested-by: Jayant Chowdhary <jchowdhary@google.com>
>---
> drivers/usb/gadget/function/f_uvc.c     |  4 --
> drivers/usb/gadget/function/uvc.h       |  4 +-
> drivers/usb/gadget/function/uvc_v4l2.c  |  5 +-
> drivers/usb/gadget/function/uvc_video.c | 72 ++++++++++++++++---------
> drivers/usb/gadget/function/uvc_video.h |  2 +
> 5 files changed, 52 insertions(+), 35 deletions(-)
>
>diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/func=
tion/f_uvc.c
>index ae08341961eb..53cb2539486d 100644
>--- a/drivers/usb/gadget/function/f_uvc.c
>+++ b/drivers/usb/gadget/function/f_uvc.c
>@@ -959,14 +959,10 @@ static void uvc_function_unbind(struct usb_configura=
tion *c,
> {
> 	struct usb_composite_dev *cdev =3D c->cdev;
> 	struct uvc_device *uvc =3D to_uvc(f);
>-	struct uvc_video *video =3D &uvc->video;
> 	long wait_ret =3D 1;
>
> 	uvcg_info(f, "%s()\n", __func__);
>
>-	if (video->async_wq)
>-		destroy_workqueue(video->async_wq);
>-
> 	/*
> 	 * If we know we're connected via v4l2, then there should be a cleanup
> 	 * of the device from userspace either via UVC_EVENT_DISCONNECT or
>diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/functi=
on/uvc.h
>index be0d012aa244..498f344fda4b 100644
>--- a/drivers/usb/gadget/function/uvc.h
>+++ b/drivers/usb/gadget/function/uvc.h
>@@ -88,9 +88,6 @@ struct uvc_video {
> 	struct uvc_device *uvc;
> 	struct usb_ep *ep;
>
>-	struct work_struct pump;
>-	struct workqueue_struct *async_wq;
>-
> 	/* Frame parameters */
> 	u8 bpp;
> 	u32 fcc;
>@@ -116,6 +113,7 @@ struct uvc_video {
> 	/* Context data used by the completion handler */
> 	__u32 payload_size;
> 	__u32 max_payload_size;
>+	bool is_bulk;
>
> 	struct uvc_video_queue queue;
> 	unsigned int fid;
>diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/f=
unction/uvc_v4l2.c
>index f4d2e24835d4..678ea6df7b5c 100644
>--- a/drivers/usb/gadget/function/uvc_v4l2.c
>+++ b/drivers/usb/gadget/function/uvc_v4l2.c
>@@ -414,10 +414,7 @@ uvc_v4l2_qbuf(struct file *file, void *fh, struct v4l=
2_buffer *b)
> 	ret =3D uvcg_queue_buffer(&video->queue, b);
> 	if (ret < 0)
> 		return ret;
>-
>-	if (uvc->state =3D=3D UVC_STATE_STREAMING)
>-		queue_work(video->async_wq, &video->pump);
>-
>+	uvcg_video_pump_qbuf(video);
> 	return ret;
> }
>
>diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/=
function/uvc_video.c
>index ab3f02054e85..143453e9f003 100644
>--- a/drivers/usb/gadget/function/uvc_video.c
>+++ b/drivers/usb/gadget/function/uvc_video.c
>@@ -24,6 +24,8 @@
>  * Video codecs
>  */
>
>+static void uvcg_video_pump(struct uvc_video *video);
>+
> static int
> uvc_video_encode_header(struct uvc_video *video, struct uvc_buffer *buf,
> 		u8 *data, int len)
>@@ -329,7 +331,9 @@ uvc_video_complete(struct usb_ep *ep, struct usb_reque=
st *req)
> 	 */
> 	if (video->is_enabled) {
> 		list_add_tail(&req->list, &video->req_free);
>-		queue_work(video->async_wq, &video->pump);
>+		spin_unlock_irqrestore(&video->req_lock, flags);
>+		uvcg_video_pump(video);
>+		return;
> 	} else {
> 		uvc_video_free_request(ureq, ep);
> 	}
>@@ -409,20 +413,32 @@ uvc_video_alloc_requests(struct uvc_video *video)
>  * Video streaming
>  */
>
>+void uvcg_video_pump_qbuf(struct uvc_video *video)
>+{
>+	if (video->is_bulk) {
>+		/*
>+		 * Only call uvcg_video_pump() from qbuf, for bulk eps since
>+		 * for isoc, the complete handler will call uvcg_video_pump()
>+		 * consistently. Calling it for isoc eps, while correct
>+		 * will increase contention for video->req_lock since the
>+		 * complete handler will be called more often.
>+		 */

Could you move the comment above the condition and remove the extra
braces here.
>+		uvcg_video_pump(video);
>+	}
>+}
>+
> /*
>  * uvcg_video_pump - Pump video data into the USB requests
>  *
>  * This function fills the available USB requests (listed in req_free) wi=
th
>  * video data from the queued buffers.
>  */
>-static void uvcg_video_pump(struct work_struct *work)
>+static void uvcg_video_pump(struct uvc_video *video)
> {
>-	struct uvc_video *video =3D container_of(work, struct uvc_video, pump);
> 	struct uvc_video_queue *queue =3D &video->queue;
>-	/* video->max_payload_size is only set when using bulk transfer */
>-	bool is_bulk =3D video->max_payload_size;
> 	struct usb_request *req =3D NULL;
>-	struct uvc_buffer *buf;
>+	struct uvc_request *ureq =3D NULL;
>+	struct uvc_buffer *buf =3D NULL, *last_buf =3D NULL;
> 	unsigned long flags;
> 	bool buf_done;
> 	int ret;
>@@ -455,7 +471,8 @@ static void uvcg_video_pump(struct work_struct *work)
> 		if (buf !=3D NULL) {
> 			video->encode(req, video, buf);
> 			buf_done =3D buf->state =3D=3D UVC_BUF_STATE_DONE;
>-		} else if (!(queue->flags & UVC_QUEUE_DISCONNECTED) && !is_bulk) {
>+		} else if (!(queue->flags & UVC_QUEUE_DISCONNECTED) &&
>+				!video->is_bulk) {
> 			/*
> 			 * No video buffer available; the queue is still connected and
> 			 * we're transferring over ISOC. Queue a 0 length request to
>@@ -500,18 +517,30 @@ static void uvcg_video_pump(struct work_struct *work)
> 			req->no_interrupt =3D 1;
> 		}
>
>-		/* Queue the USB request */
>-		ret =3D uvcg_video_ep_queue(video, req);
> 		spin_unlock_irqrestore(&queue->irqlock, flags);
>-
>+		spin_lock_irqsave(&video->req_lock, flags);
>+		if (video->is_enabled) {
>+			/* Queue the USB request */
>+			ret =3D uvcg_video_ep_queue(video, req);
>+			/* Endpoint now owns the request */
>+			req =3D NULL;
>+			video->req_int_count++;
>+		} else {
>+			ret =3D  -ENODEV;
>+			ureq =3D req->context;
>+			last_buf =3D ureq->last_buf;
>+			ureq->last_buf =3D NULL;
>+		}
>+		spin_unlock_irqrestore(&video->req_lock, flags);
> 		if (ret < 0) {
>+			if (last_buf !=3D NULL) {
>+				// Return the buffer to the queue in the case the
>+				// request was not queued to the ep.
>+				uvcg_complete_buffer(&video->queue, last_buf);
>+			}
> 			uvcg_queue_cancel(queue, 0);
> 			break;
> 		}
>-
>-		/* Endpoint now owns the request */
>-		req =3D NULL;
>-		video->req_int_count++;
> 	}
>
> 	if (!req)
>@@ -556,7 +585,6 @@ uvcg_video_disable(struct uvc_video *video)
> 	}
> 	spin_unlock_irqrestore(&video->req_lock, flags);
>
>-	cancel_work_sync(&video->pump);
> 	uvcg_queue_cancel(&video->queue, 0);
>
> 	spin_lock_irqsave(&video->req_lock, flags);
>@@ -626,14 +654,16 @@ int uvcg_video_enable(struct uvc_video *video, int e=
nable)
> 	if (video->max_payload_size) {
> 		video->encode =3D uvc_video_encode_bulk;
> 		video->payload_size =3D 0;
>-	} else
>+		video->is_bulk =3D true;
>+	} else {
> 		video->encode =3D video->queue.use_sg ?
> 			uvc_video_encode_isoc_sg : uvc_video_encode_isoc;
>+		video->is_bulk =3D false;
>+	}
>
> 	video->req_int_count =3D 0;
>
>-	queue_work(video->async_wq, &video->pump);
>-
>+	uvcg_video_pump(video);
> 	return ret;
> }
>
>@@ -646,12 +676,6 @@ int uvcg_video_init(struct uvc_video *video, struct u=
vc_device *uvc)
> 	INIT_LIST_HEAD(&video->ureqs);
> 	INIT_LIST_HEAD(&video->req_free);
> 	spin_lock_init(&video->req_lock);
>-	INIT_WORK(&video->pump, uvcg_video_pump);
>-
>-	/* Allocate a work queue for asynchronous video pump handler. */
>-	video->async_wq =3D alloc_workqueue("uvcgadget", WQ_UNBOUND | WQ_HIGHPRI=
, 0);
>-	if (!video->async_wq)
>-		return -EINVAL;
>
> 	video->uvc =3D uvc;
> 	video->fcc =3D V4L2_PIX_FMT_YUYV;
>diff --git a/drivers/usb/gadget/function/uvc_video.h b/drivers/usb/gadget/=
function/uvc_video.h
>index 03adeefa343b..29c6b9a2e9c3 100644
>--- a/drivers/usb/gadget/function/uvc_video.h
>+++ b/drivers/usb/gadget/function/uvc_video.h
>@@ -18,4 +18,6 @@ int uvcg_video_enable(struct uvc_video *video, int enabl=
e);
>
> int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc);
>
>+void uvcg_video_pump_qbuf(struct uvc_video *video);
>+
> #endif /* __UVC_VIDEO_H__ */
>--=20
>
>

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--uhOVRvhjA5b0Dp6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmU6DiYACgkQC+njFXoe
LGTGMxAAiC1uvBAL3xTD0NWTvDzVoUO2TYgSy4AaNnAI4eOffrBQJgtCUdPhxY98
7gXf+n5jyTpHEgsLegOqPomtaL/FKJDA/AMmnMl2tuXty0118jm92MrLKlxgqsv7
eXaaLMtJ+XPaIh2d4/JPaEO/BCcLHG/APDLDRJwW2Xp5YiehwRBDvLnrBKigO0uU
CZS64IRN0jBLqakAYQcJoblUzIN6ZWnDhSGzpJU2P3MJ9ApEwLgjvjB7WLikysT4
G5IGPVtWkPitah9ek8X3WrV9XszqgoSYI8yBpuYEUlMvvUAd8t3g7zSBTYvnuDml
TwL4C62TAANKBGlvwRNTWzGpaiibB5mo4WSxfUp/nZ64MwBYJqMu+yo2/wVIAL/R
61oagXpDe47tffyhELz0W+vulMESlYW3eJLUQ3B3GX3SLT2qsqd62ZgXW8X32dWF
/7O72Z7xuzJcq4Hy4EFaEkx6SFPmRfdalzEelrLlGTlFdKlNE0IUsPKMHvSykKy9
YOsx7jia3ctCfgaUmf6Jxqfd20yLdE4OP5mJzwF2Bbfi+PujPcDjxYLu+ZjylNUY
Bmfj44KkutQc93ZABC8HtRgEMqBBmYDAitf9a4kEWhu2nYpfbFvu2o8VAFjtSM+x
azukmByTA5Gd4LHj5G00O/tEnCMPtfiZ26elDr5FcN+bLWaNRxU=
=NWOI
-----END PGP SIGNATURE-----

--uhOVRvhjA5b0Dp6s--
