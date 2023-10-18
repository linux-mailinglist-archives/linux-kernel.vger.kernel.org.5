Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3DA7CDC8C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjJRNDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjJRNDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:03:11 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27FE106
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 06:03:07 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1qt6CT-0001xG-9l; Wed, 18 Oct 2023 15:03:01 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mgr@pengutronix.de>)
        id 1qt6CS-002Z9l-RJ; Wed, 18 Oct 2023 15:03:00 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <mgr@pengutronix.de>)
        id 1qt6CS-00GSw6-Hl; Wed, 18 Oct 2023 15:03:00 +0200
Date:   Wed, 18 Oct 2023 15:03:00 +0200
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Avichal Rakesh <arakesh@google.com>
Cc:     dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        etalvala@google.com, gregkh@linuxfoundation.org,
        jchowdhary@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v4 2/3] usb: gadget: uvc: Allocate uvc_requests one at a
 time
Message-ID: <ZS/XhFNvnevol9MP@pengutronix.de>
References: <20230930184821.310143-1-arakesh@google.com>
 <20231012002451.254737-1-arakesh@google.com>
 <20231012002451.254737-2-arakesh@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Uw2wfuFtST6tVRQh"
Content-Disposition: inline
In-Reply-To: <20231012002451.254737-2-arakesh@google.com>
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


--Uw2wfuFtST6tVRQh
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

A short second review.

On Wed, Oct 11, 2023 at 05:24:50PM -0700, Avichal Rakesh wrote:
>Currently, the uvc gadget driver allocates all uvc_requests as one array
>and deallocates them all when the video stream stops. This includes
>de-allocating all the usb_requests associated with those uvc_requests.
>This can lead to use-after-free issues if any of those de-allocated
>usb_requests were still owned by the usb controller.
>
>This patch is 1 of 2 patches addressing the use-after-free issue.
>Instead of bulk allocating all uvc_requests as an array, this patch
>allocates uvc_requests one at a time, which should allows for similar
>granularity when deallocating the uvc_requests. This patch has no
>functional changes other than allocating each uvc_request separately,
>and similarly freeing each of them separately.
>
>Link: https://lore.kernel.org/7cd81649-2795-45b6-8c10-b7df1055020d@google.=
com
>Suggested-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>Reviewed-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>Signed-off-by: Avichal Rakesh <arakesh@google.com>
>---
>v1 -> v2: Rebased to ToT
>v2 -> v3: Fix email threading goof-up
>v3 -> v4: Address review comments & re-rebase to ToT
>
> drivers/usb/gadget/function/uvc.h       |  3 +-
> drivers/usb/gadget/function/uvc_video.c | 87 ++++++++++++++-----------
> 2 files changed, 50 insertions(+), 40 deletions(-)
>
>diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/functi=
on/uvc.h
>index 989bc6b4e93d..993694da0bbc 100644
>--- a/drivers/usb/gadget/function/uvc.h
>+++ b/drivers/usb/gadget/function/uvc.h
>@@ -81,6 +81,7 @@ struct uvc_request {
> 	struct sg_table sgt;
> 	u8 header[UVCG_REQUEST_HEADER_LEN];
> 	struct uvc_buffer *last_buf;
>+	struct list_head list;
> };
>
> struct uvc_video {
>@@ -102,7 +103,7 @@ struct uvc_video {
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
>index c334802ac0a4..b62b3de79153 100644
>--- a/drivers/usb/gadget/function/uvc_video.c
>+++ b/drivers/usb/gadget/function/uvc_video.c
>@@ -227,6 +227,24 @@ uvc_video_encode_isoc(struct usb_request *req, struct=
 uvc_video *video,
>  * Request handling
>  */
>
>+static void
>+uvc_video_free_request(struct uvc_request *ureq, struct usb_ep *ep)
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
>+		list_del_init(&ureq->list);
>+
>+	kfree(ureq);
>+}
>+
> static int uvcg_video_ep_queue(struct uvc_video *video, struct usb_reques=
t *req)
> {
> 	int ret;
>@@ -293,27 +311,12 @@ uvc_video_complete(struct usb_ep *ep, struct usb_req=
uest *req)
> static int
> uvc_video_free_requests(struct uvc_video *video)
> {
>-	unsigned int i;
>+	struct uvc_request *ureq, *temp;
>
>-	if (video->ureq) {
>-		for (i =3D 0; i < video->uvc_num_requests; ++i) {
>-			sg_free_table(&video->ureq[i].sgt);
>-
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
>-	}
>+	list_for_each_entry_safe(ureq, temp, &video->ureqs, list)
>+		uvc_video_free_request(ureq, video->ep);
>
>+	INIT_LIST_HEAD(&video->ureqs);
> 	INIT_LIST_HEAD(&video->req_free);
> 	video->req_size =3D 0;
> 	return 0;
>@@ -322,6 +325,7 @@ uvc_video_free_requests(struct uvc_video *video)
> static int
> uvc_video_alloc_requests(struct uvc_video *video)
> {
>+	struct uvc_request *ureq;
> 	unsigned int req_size;
> 	unsigned int i;
> 	int ret =3D -ENOMEM;
>@@ -332,29 +336,32 @@ uvc_video_alloc_requests(struct uvc_video *video)
> 		 * max_t(unsigned int, video->ep->maxburst, 1)
> 		 * (video->ep->mult);
>
>-	video->ureq =3D kcalloc(video->uvc_num_requests, sizeof(struct uvc_reque=
st), GFP_KERNEL);
>-	if (video->ureq =3D=3D NULL)
>-		return -ENOMEM;
>+	INIT_LIST_HEAD(&video->ureqs);
>+	for (i =3D 0; i < video->uvc_num_requests; i++) {
>+		ureq =3D kzalloc(sizeof(struct uvc_request), GFP_KERNEL);
>+		if (ureq =3D=3D NULL)
>+			goto error;
Please add an empty line here.
>+		INIT_LIST_HEAD(&ureq->list);

Please add an empty line here.

>+		list_add_tail(&ureq->list, &video->ureqs);
>
>-	for (i =3D 0; i < video->uvc_num_requests; ++i) {
>-		video->ureq[i].req_buffer =3D kmalloc(req_size, GFP_KERNEL);
>-		if (video->ureq[i].req_buffer =3D=3D NULL)
>+		ureq->req_buffer =3D kmalloc(req_size, GFP_KERNEL);
>+		if (ureq->req_buffer =3D=3D NULL)
You could also use if (!ureq->req_buffer)

> 			goto error;
>
>-		video->ureq[i].req =3D usb_ep_alloc_request(video->ep, GFP_KERNEL);
>-		if (video->ureq[i].req =3D=3D NULL)
>+		ureq->req =3D usb_ep_alloc_request(video->ep, GFP_KERNEL);
>+		if (ureq->req =3D=3D NULL)
> 			goto error;
>
>-		video->ureq[i].req->buf =3D video->ureq[i].req_buffer;
>-		video->ureq[i].req->length =3D 0;
>-		video->ureq[i].req->complete =3D uvc_video_complete;
>-		video->ureq[i].req->context =3D &video->ureq[i];
>-		video->ureq[i].video =3D video;
>-		video->ureq[i].last_buf =3D NULL;
>+		ureq->req->buf =3D ureq->req_buffer;
>+		ureq->req->length =3D 0;
>+		ureq->req->complete =3D uvc_video_complete;
>+		ureq->req->context =3D ureq;
>+		ureq->video =3D video;
>+		ureq->last_buf =3D NULL;
>
>-		list_add_tail(&video->ureq[i].req->list, &video->req_free);
>+		list_add_tail(&ureq->req->list, &video->req_free);
> 		/* req_size/PAGE_SIZE + 1 for overruns and + 1 for header */
>-		sg_alloc_table(&video->ureq[i].sgt,
>+		sg_alloc_table(&ureq->sgt,
> 			       DIV_ROUND_UP(req_size - UVCG_REQUEST_HEADER_LEN,
> 					    PAGE_SIZE) + 2, GFP_KERNEL);
> 	}
>@@ -489,8 +496,8 @@ static void uvcg_video_pump(struct work_struct *work)
>  */
> int uvcg_video_enable(struct uvc_video *video, int enable)
> {
>-	unsigned int i;
> 	int ret;
>+	struct uvc_request *ureq;
>
> 	if (video->ep =3D=3D NULL) {
> 		uvcg_info(&video->uvc->func,
>@@ -502,9 +509,10 @@ int uvcg_video_enable(struct uvc_video *video, int en=
able)
> 		cancel_work_sync(&video->pump);
> 		uvcg_queue_cancel(&video->queue, 0);
>
>-		for (i =3D 0; i < video->uvc_num_requests; ++i)
>-			if (video->ureq && video->ureq[i].req)
>-				usb_ep_dequeue(video->ep, video->ureq[i].req);
>+		list_for_each_entry(ureq, &video->ureqs, list) {
>+			if (ureq->req)
>+				usb_ep_dequeue(video->ep, ureq->req);
>+		}
>
> 		uvc_video_free_requests(video);
> 		uvcg_queue_enable(&video->queue, 0);
>@@ -536,6 +544,7 @@ int uvcg_video_enable(struct uvc_video *video, int ena=
ble)
>  */
> int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc)
> {
>+	INIT_LIST_HEAD(&video->ureqs);
> 	INIT_LIST_HEAD(&video->req_free);
> 	spin_lock_init(&video->req_lock);
> 	INIT_WORK(&video->pump, uvcg_video_pump);
>--
>2.42.0.609.gbb76f46606-goog
>
>

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--Uw2wfuFtST6tVRQh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmUv14EACgkQC+njFXoe
LGQsXxAAgJzuAfJI4eaYoBkWZnw+RJT0FyIK3gGZBHGMtsnIdkGZBx5wlFSW38SJ
/ckyn+QdUy0gIBO4XCfQdkLcRM2W3IoUrT0R7I/0nMVDxCjt+FUE3hU27miGiDcn
RN6usaLp9mp/dupy/KRxWct//TchEji8xP7JzBXnrKSzMqfbe8C8c1NFTECueyo+
IZq6SvtlkDI1unMXU/SabSpgin8JrvQ7f8geC63y2ypGhVLa9o2+INrefDM4USO6
vCOKziXRJsmyjWYVAOISsFLtSSIV3PXBM0F3kkpnPvpvaKTRfK7jL5/AZEYiNeO0
EVH4mIdYPhnTNHlLe2F5Aj3bEqD+RysAp9Xx8vfCOslQdWQdcUUbUBIis5QiEL/k
MPqKsDWshM/YZKSd/Udas+01kZpOtdqYquEIpEmWvSwC1QCEYsaCY6+s5OAGa5to
7qsHcNvJETD8nipzH1JKrQNbUsgJ+wRcHOH+ovktnywq6tqKzbKn7e/B29Df8rEf
PDQvl0BECUJQU1YCY7z0007e8WCaWyR1E5PggXhqCkWJLtmVkE12d8rqdgXNRosf
VZFru5YScyk6SwAFki1CH07j1C7DS70l/Oro3RpzAupf/5P/1StPkTznLfYZu5SY
M1SvSDyFZGfM9KZdy/Yz5qbBln7EiO7q8nDP8YsmS2UrdvF3OtU=
=1ddM
-----END PGP SIGNATURE-----

--Uw2wfuFtST6tVRQh--
