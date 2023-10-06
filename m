Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48D77BC1FB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 00:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbjJFWEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 18:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbjJFWEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 18:04:14 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1650BF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 15:04:09 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1qosvV-0002l6-WE; Sat, 07 Oct 2023 00:04:06 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mgr@pengutronix.de>)
        id 1qosvV-00BcCv-6U; Sat, 07 Oct 2023 00:04:05 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <mgr@pengutronix.de>)
        id 1qosvU-00Gj07-TP; Sat, 07 Oct 2023 00:04:04 +0200
Date:   Sat, 7 Oct 2023 00:04:04 +0200
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Avichal Rakesh <arakesh@google.com>
Cc:     dan.scally@ideasonboard.com, gregkh@linuxfoundation.org,
        laurent.pinchart@ideasonboard.com, etalvala@google.com,
        jchowdhary@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 1/3] usb: gadget: uvc: prevent use of disabled endpoint
Message-ID: <ZSCEVOZbdPQRpoxl@pengutronix.de>
References: <20230930184821.310143-1-arakesh@google.com>
 <20231005180814.3278050-1-arakesh@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WOGjcAmyrQ2IDO+m"
Content-Disposition: inline
In-Reply-To: <20231005180814.3278050-1-arakesh@google.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WOGjcAmyrQ2IDO+m
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2023 at 11:08:12AM -0700, Avichal Rakesh wrote:
>Currently the set_alt callback immediately disables the endpoint and queues
>the v4l2 streamoff event. However, as the streamoff event is processed
>asynchronously, it is possible that the video_pump thread attempts to queue
>requests to an already disabled endpoint.
>
>This change moves disabling usb endpoint to the end of streamoff event
>callback. To be consistent with the actual streaming state, uvc->state
>is now toggled between CONNECTED and STREAMING from the v4l2 event
>callback only.
>
>Link: https://lore.kernel.org/20230615171558.GK741@pendragon.ideasonboard.=
com/
>Link: https://lore.kernel.org/20230531085544.253363-1-dan.scally@ideasonbo=
ard.com/
>Signed-off-by: Avichal Rakesh <arakesh@google.com>
>---
>v1 -> v2: Rebased to ToT and reworded commit message.
>v2 -> v3: Fix email threading goof-up
>
> drivers/usb/gadget/function/f_uvc.c    | 11 +++++------
> drivers/usb/gadget/function/f_uvc.h    |  2 +-
> drivers/usb/gadget/function/uvc.h      |  2 +-
> drivers/usb/gadget/function/uvc_v4l2.c | 21 ++++++++++++++++++---
> 4 files changed, 25 insertions(+), 11 deletions(-)
>
>diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/func=
tion/f_uvc.c
>index faa398109431..75c9f9a3f884 100644
>--- a/drivers/usb/gadget/function/f_uvc.c
>+++ b/drivers/usb/gadget/function/f_uvc.c
>@@ -263,10 +263,13 @@ uvc_function_setup(struct usb_function *f, const str=
uct usb_ctrlrequest *ctrl)
> 	return 0;
> }
>
>-void uvc_function_setup_continue(struct uvc_device *uvc)
>+void uvc_function_setup_continue(struct uvc_device *uvc, int disable_ep)
> {
> 	struct usb_composite_dev *cdev =3D uvc->func.config->cdev;
>
>+	if (disable_ep && uvc->video.ep) {
>+		usb_ep_disable(uvc->video.ep);
>+	}

Could you drop the extra braces and add one spare line here.

> 	usb_composite_setup_continue(cdev);
> }
>
>@@ -337,15 +340,11 @@ uvc_function_set_alt(struct usb_function *f, unsigne=
d interface, unsigned alt)
> 		if (uvc->state !=3D UVC_STATE_STREAMING)
> 			return 0;
>
>-		if (uvc->video.ep)
>-			usb_ep_disable(uvc->video.ep);
>-
> 		memset(&v4l2_event, 0, sizeof(v4l2_event));
> 		v4l2_event.type =3D UVC_EVENT_STREAMOFF;
> 		v4l2_event_queue(&uvc->vdev, &v4l2_event);
>
>-		uvc->state =3D UVC_STATE_CONNECTED;
>-		return 0;
>+		return USB_GADGET_DELAYED_STATUS;
>
> 	case 1:
> 		if (uvc->state !=3D UVC_STATE_CONNECTED)
>diff --git a/drivers/usb/gadget/function/f_uvc.h b/drivers/usb/gadget/func=
tion/f_uvc.h
>index 1db972d4beeb..e7f9f13f14dc 100644
>--- a/drivers/usb/gadget/function/f_uvc.h
>+++ b/drivers/usb/gadget/function/f_uvc.h
>@@ -11,7 +11,7 @@
>
> struct uvc_device;
>
>-void uvc_function_setup_continue(struct uvc_device *uvc);
>+void uvc_function_setup_continue(struct uvc_device *uvc, int disale_ep);
>
> void uvc_function_connect(struct uvc_device *uvc);
>
>diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/functi=
on/uvc.h
>index 6751de8b63ad..989bc6b4e93d 100644
>--- a/drivers/usb/gadget/function/uvc.h
>+++ b/drivers/usb/gadget/function/uvc.h
>@@ -177,7 +177,7 @@ struct uvc_file_handle {
>  * Functions
>  */
>
>-extern void uvc_function_setup_continue(struct uvc_device *uvc);
>+extern void uvc_function_setup_continue(struct uvc_device *uvc, int disab=
le_ep);
> extern void uvc_function_connect(struct uvc_device *uvc);
> extern void uvc_function_disconnect(struct uvc_device *uvc);
>
>diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/f=
unction/uvc_v4l2.c
>index 3f0a9795c0d4..3d3469883ed0 100644
>--- a/drivers/usb/gadget/function/uvc_v4l2.c
>+++ b/drivers/usb/gadget/function/uvc_v4l2.c
>@@ -451,7 +451,7 @@ uvc_v4l2_streamon(struct file *file, void *fh, enum v4=
l2_buf_type type)
> 	 * Complete the alternate setting selection setup phase now that
> 	 * userspace is ready to provide video frames.
> 	 */
>-	uvc_function_setup_continue(uvc);
>+	uvc_function_setup_continue(uvc, 0);
> 	uvc->state =3D UVC_STATE_STREAMING;
>
> 	return 0;
>@@ -463,11 +463,19 @@ uvc_v4l2_streamoff(struct file *file, void *fh, enum=
 v4l2_buf_type type)
> 	struct video_device *vdev =3D video_devdata(file);
> 	struct uvc_device *uvc =3D video_get_drvdata(vdev);
> 	struct uvc_video *video =3D &uvc->video;
>+	int ret =3D 0;
>
> 	if (type !=3D video->queue.queue.type)
> 		return -EINVAL;
>
>-	return uvcg_video_enable(video, 0);
>+	uvc->state =3D UVC_STATE_CONNECTED;
>+	ret =3D uvcg_video_enable(video, 0);
>+	if (ret < 0) {
>+		return ret;
>+	}

Please drop those extra braces.

>+
>+	uvc_function_setup_continue(uvc, 1);
>+	return 0;
> }
>
> static int
>@@ -500,6 +508,14 @@ uvc_v4l2_subscribe_event(struct v4l2_fh *fh,
> static void uvc_v4l2_disable(struct uvc_device *uvc)
> {
> 	uvc_function_disconnect(uvc);
>+	if (uvc->state =3D=3D UVC_STATE_STREAMING) {
>+		/*
>+		 * Drop uvc->state to CONNECTED if it was streaming before.
>+		 * This ensures that the usb_requests are no longer queued
>+		 * to the controller.
>+		 */
>+		uvc->state =3D UVC_STATE_CONNECTED;
>+	}

Could you write the comment above the check
and also remove the extra braces.

> 	uvcg_video_enable(&uvc->video, 0);
> 	uvcg_free_buffers(&uvc->video.queue);
> 	uvc->func_connected =3D false;
>@@ -647,4 +663,3 @@ const struct v4l2_file_operations uvc_v4l2_fops =3D {
> 	.get_unmapped_area =3D uvcg_v4l2_get_unmapped_area,
> #endif
> };
>-
>--
>2.42.0.609.gbb76f46606-goog


With this you can add my:

Reviewed-by: <m.grzeschik@pengutronix.de>

Thanks

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--WOGjcAmyrQ2IDO+m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmUghFIACgkQC+njFXoe
LGTc/Q//adZosXC8N27hjLgQm5kh+qqWuFrAOY7Wu94h2U2dRJAsYbO3k0XkzLXt
KZJTbfrJG1YG4OECoGiCo6aB5RwpZ5+8YdlLkjDsUjuPOk1tbxYYOHqVpI6t+wUf
O+HZ9VyFNS3Mi/5/NkovZoRKO1uMup/MorKWVgqG9cx25+/+QwOuKiubqA1zMInu
KYewtxgfaWtwECOp5brt8EfVZoISPfs+aVRVXN2UOk6bSeJrtLvJqsyGcfXl0X7N
mnXinKKc0ay3jhhyf7AglSeAfSrhSS/Mq1zmDLP39LMzo/ArDaOh9bZNSswqO+qv
zDFixO+24bdPEsFX2yM1VllnGldhyiG5D2BLb50HWZtriQmNQk2RdDkWs8/3Ylno
WuaBlsoGE7ePJehZmFyGrgPP+NK+CzX2Uz/qYN4IatAYAK+OFepUGLtYtFpR9jyT
zB/vxSfyGHj9ICvG5MXB4fHkVq8bsarzpGzGOq88IsD67zwSDjRz2dDGn8RkJLUj
ZNzKemWaurQNSYAZZok5Ii7SlWg/TOoOrjW4892WILpEEDgRoCrp62Vtw+uCh3AJ
LO/1dBMLouEjQXuw7lPrOOjHjqT6VWr7kdm1n2W6Pts9kg1jThIqkpwp7IwkYVYU
UZ/eJlSGtM8eedSb85pL5mS2qdWQPH0ilvvxvENQw1XnL3LER0g=
=GHnC
-----END PGP SIGNATURE-----

--WOGjcAmyrQ2IDO+m--
