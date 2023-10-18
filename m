Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944D37CEAF8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 00:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjJRWHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 18:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjJRWHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 18:07:03 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9198B6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:06:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1qtEgp-0005K1-AB; Thu, 19 Oct 2023 00:06:55 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mgr@pengutronix.de>)
        id 1qtEgo-002eVT-NS; Thu, 19 Oct 2023 00:06:54 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <mgr@pengutronix.de>)
        id 1qtEgo-00GYlb-Dr; Thu, 19 Oct 2023 00:06:54 +0200
Date:   Thu, 19 Oct 2023 00:06:54 +0200
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Avichal Rakesh <arakesh@google.com>
Cc:     dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        etalvala@google.com, gregkh@linuxfoundation.org,
        jchowdhary@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v4 3/3] usb: gadget: uvc: Fix use-after-free for inflight
 usb_requests
Message-ID: <ZTBW/o3tT/ukdbbi@pengutronix.de>
References: <20230930184821.310143-1-arakesh@google.com>
 <20231012002451.254737-1-arakesh@google.com>
 <20231012002451.254737-3-arakesh@google.com>
 <ZS/ZL8RMix7zppcP@pengutronix.de>
 <f45e7eab-4d49-41bb-b515-dd036f40a8d8@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="D7zng1y5j/j/D5U1"
Content-Disposition: inline
In-Reply-To: <f45e7eab-4d49-41bb-b515-dd036f40a8d8@google.com>
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


--D7zng1y5j/j/D5U1
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 02:50:08PM -0700, Avichal Rakesh wrote:
>
>
>On 10/18/23 06:10, Michael Grzeschik wrote:
>> On Wed, Oct 11, 2023 at 05:24:51PM -0700, Avichal Rakesh wrote:
>>> Currently, the uvc gadget driver allocates all uvc_requests as one array
>>> and deallocates them all when the video stream stops. This includes
>>> de-allocating all the usb_requests associated with those uvc_requests.
>>> This can lead to use-after-free issues if any of those de-allocated
>>> usb_requests were still owned by the usb controller.
>>>
>>> This is patch 2 of 2 in fixing the use-after-free issue. It adds a new
>>> flag to uvc_video to track when frames and requests should be flowing.
>>> When disabling the video stream, the flag is tripped and, instead
>>> of de-allocating all uvc_requests and usb_requests, the gadget
>>> driver only de-allocates those usb_requests that are currently
>>> owned by it (as present in req_free). Other usb_requests are left
>>> untouched until their completion handler is called which takes care
>>> of freeing the usb_request and its corresponding uvc_request.
>>>
>>> Now that uvc_video does not depends on uvc->state, this patch removes
>>> unnecessary upates to uvc->state that were made to accomodate uvc_video
>>> logic. This should ensure that uvc gadget driver never accidentally
>>> de-allocates a usb_request that it doesn't own.
>>>
>>> Link: https://lore.kernel.org/7cd81649-2795-45b6-8c10-b7df1055020d@goog=
le.com
>>> Suggested-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>>> Signed-off-by: Avichal Rakesh <arakesh@google.com>
>>> ---
>>> v1 -> v2: Rebased to ToT, and fixed deadlock reported in
>>> =A0=A0=A0=A0=A0=A0=A0=A0 https://lore.kernel.org/all/ZRv2UnKztgyqk2pt@p=
engutronix.de/
>>> v2 -> v3: Fix email threading goof-up
>>> v3 -> v4: re-rebase to ToT & moved to a uvc_video level lock
>>> =A0=A0=A0=A0=A0=A0=A0=A0 as discussed in
>>> =A0=A0=A0=A0=A0=A0=A0=A0 https://lore.kernel.org/b14b296f-2e08-4edf-aee=
a-1c5b621e2d0c@google.com/
>>
>> I tested this and I no longer saw any use after free
>> errors anymore! :)
>
>Yay! Glad to hear!
>
>>
>> Here comes some more review:
>>
>>> drivers/usb/gadget/function/uvc.h=A0=A0=A0=A0=A0=A0 |=A0=A0 1 +
>>> drivers/usb/gadget/function/uvc_v4l2.c=A0 |=A0 12 +-
>>> drivers/usb/gadget/function/uvc_video.c | 156 +++++++++++++++++++-----
>>> 3 files changed, 128 insertions(+), 41 deletions(-)
>>>
>
>>> +
>>> +/*
>>> + * Disable video stream
>>> + */
>>> +static int
>>> +uvcg_video_disable(struct uvc_video *video) {
>>> +=A0=A0=A0 unsigned long flags;
>>> +=A0=A0=A0 struct list_head inflight_bufs;
>>> +=A0=A0=A0 struct usb_request *req, *temp;
>>> +=A0=A0=A0 struct uvc_buffer *buf, *btemp;
>>> +=A0=A0=A0 struct uvc_request *ureq, *utemp;
>>> +
>>> +=A0=A0=A0 INIT_LIST_HEAD(&inflight_bufs);
>>> +=A0=A0=A0 spin_lock_irqsave(&video->req_lock, flags);
>>> +=A0=A0=A0 video->is_enabled =3D false;
>>> +
>>> +=A0=A0=A0 /*
>>> +=A0=A0=A0=A0 * Remove any in-flight buffers from the uvc_requests
>>> +=A0=A0=A0=A0 * because we want to return them before cancelling the
>>> +=A0=A0=A0=A0 * queue. This ensures that we aren't stuck waiting for
>>> +=A0=A0=A0=A0 * all complete callbacks to come through before disabling
>>> +=A0=A0=A0=A0 * vb2 queue.
>>> +=A0=A0=A0=A0 */
>>> +=A0=A0=A0 list_for_each_entry(ureq, &video->ureqs, list) {
>>> +=A0=A0=A0=A0=A0=A0=A0 if (ureq->last_buf) {
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 list_add_tail(&ureq->last_buf->queue=
, &inflight_bufs);
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ureq->last_buf =3D NULL;
>>> +=A0=A0=A0=A0=A0=A0=A0 }
>>> +=A0=A0=A0 }
>>> =A0=A0=A0=A0spin_unlock_irqrestore(&video->req_lock, flags);
>>> -=A0=A0=A0 return;
>>> +
>>> +=A0=A0=A0 cancel_work_sync(&video->pump);
>>> +=A0=A0=A0 uvcg_queue_cancel(&video->queue, 0);
>>> +
>>> +=A0=A0=A0 spin_lock_irqsave(&video->req_lock, flags);
>>> +=A0=A0=A0 /*
>>> +=A0=A0=A0=A0 * Remove all uvc_reqeusts from from ureqs with list_del_i=
nit
>>> +=A0=A0=A0=A0 * This lets uvc_video_free_request correctly identify
>>> +=A0=A0=A0=A0 * if the uvc_request is attached to a list or not when fr=
eeing
>>> +=A0=A0=A0=A0 * memory.
>>> +=A0=A0=A0=A0 */
>>> +=A0=A0=A0 list_for_each_entry_safe(ureq, utemp, &video->ureqs, list)
>>> +=A0=A0=A0=A0=A0=A0=A0 list_del_init(&ureq->list);
>>> +
>>> +=A0=A0=A0 list_for_each_entry_safe(req, temp, &video->req_free, list) {
>>> +=A0=A0=A0=A0=A0=A0=A0 list_del(&req->list);
>>> +=A0=A0=A0=A0=A0=A0=A0 uvc_video_free_request(req->context, video->ep);
>>> +=A0=A0=A0 }
>>> +
>>> +=A0=A0=A0 INIT_LIST_HEAD(&video->ureqs);
>>> +=A0=A0=A0 INIT_LIST_HEAD(&video->req_free);
>>> +=A0=A0=A0 video->req_size =3D 0;
>>> +=A0=A0=A0 spin_unlock_irqrestore(&video->req_lock, flags);
>>> +
>>> +=A0=A0=A0 /*
>>> +=A0=A0=A0=A0 * Return all the video buffers before disabling the queue.
>>> +=A0=A0=A0=A0 */
>>> +=A0=A0=A0 spin_lock_irqsave(&video->queue.irqlock, flags);
>>> +=A0=A0=A0 list_for_each_entry_safe(buf, btemp, &inflight_bufs, queue) {
>>> +=A0=A0=A0=A0=A0=A0=A0 list_del(&buf->queue);
>>> +=A0=A0=A0=A0=A0=A0=A0 uvcg_complete_buffer(&video->queue, buf);
>>> +=A0=A0=A0 }
>>> +=A0=A0=A0 spin_unlock_irqrestore(&video->queue.irqlock, flags);
>>> +
>>> +=A0=A0=A0 uvcg_queue_enable(&video->queue, 0);
>>> +=A0=A0=A0 return 0;
>>> }
>>>
>>> /*
>>> @@ -497,28 +596,22 @@ static void uvcg_video_pump(struct work_struct *w=
ork)
>>> int uvcg_video_enable(struct uvc_video *video, int enable)
>>> {
>>> =A0=A0=A0=A0int ret;
>>> -=A0=A0=A0 struct uvc_request *ureq;
>>>
>>> =A0=A0=A0=A0if (video->ep =3D=3D NULL) {
>>> =A0=A0=A0=A0=A0=A0=A0 uvcg_info(&video->uvc->func,
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "Video enable failed, device is=
 uninitialized.\n");
>>> =A0=A0=A0=A0=A0=A0=A0 return -ENODEV;
>>> =A0=A0=A0=A0}
>>> -
>>> -=A0=A0=A0 if (!enable) {
>>> -=A0=A0=A0=A0=A0=A0=A0 cancel_work_sync(&video->pump);
>>> -=A0=A0=A0=A0=A0=A0=A0 uvcg_queue_cancel(&video->queue, 0);
>>> -
>>> -=A0=A0=A0=A0=A0=A0=A0 list_for_each_entry(ureq, &video->ureqs, list) {
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ureq->req)
>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usb_ep_dequeue(video->ep=
, ureq->req);
>>> -=A0=A0=A0=A0=A0=A0=A0 }
>>> -
>>> -=A0=A0=A0=A0=A0=A0=A0 uvc_video_free_requests(video);
>>> -=A0=A0=A0=A0=A0=A0=A0 uvcg_queue_enable(&video->queue, 0);
>>> -=A0=A0=A0=A0=A0=A0=A0 return 0;
>>> -=A0=A0=A0 }
>>> -
>>> +=A0=A0=A0 if (!enable)
>>> +=A0=A0=A0=A0=A0=A0=A0 return uvcg_video_disable(video);
>>
>> Could you refactor this code as it is to an separate
>> function and prepand this change as an extra patch
>> to this one? It would make the changes in the functions
>> more obvious and better to review.
>
>Sure I can send a follow up patch, but I am curious why you think this
>needs to be a separate function? Refactoring into a function would
>have the functions structured something like:
>
>uvcg_video_disable(video) {
>    // ...
>    // disable impl
>    // ...
>}
>
>uvcg_video_enable(video) {
>    // ...
>    // enable impl
>    // ...
>}
>
>uvcg_video_enable(video, enable) {
>    // ep test
>
>    if (!enable)
>        return uvcg_video_disable(video);
>
>    return uvc_video_enable(video);
>}
>
>instead of the current structure:
>
>uvcg_video_disable(video) {
>    // ...
>    // disable impl
>    // ...
>}
>
>uvcg_video_enable(video, enable) {
>    // ep test
>
>    if (!enable)
>        return uvcg_video_disable(video);
>
>    // ...
>    // enable impl
>    // ...
>}
>
>I am not sure if one is more readable than the other.

I think you misunderstood. The second structure is all right.

What I did want you to do is as follows.

Lets look at your series:

patch 0/3
patch 1/3
patch 2/3

<--- add a patch here that does the refactoring of the separate
      function uvcg_video_disable without changing the functional
      content of it:

uvcg_video_disable(video) {
     // ...
     // disable impl
     // ...
}

uvcg_video_enable(video, enable) {
     // ep test

     if (!enable)
         return uvcg_video_disable(video);

     // ...
     // enable impl
     // ...
}

patch 3/3

This way in the patch 3/3 the functional changes you introduce to the
uvcg_video_diable will get better to review.

Regards,
Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--D7zng1y5j/j/D5U1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmUwVvsACgkQC+njFXoe
LGRZcQ//VXKP6uSr3VmJF1m7CCvnkzqJ4G+Vsw/3KGvnwgHbVjy3tZKTDWe6Y1kB
1o42S8ZBRl8oA3URZuiA4XfFKpWmOMmqXkDahy74jbEdRa3uK/H+2fj7ujeEY1EA
j55JXqsMCotH++krzaXNAsCEWUht9oB1cPC/S7wpMWujuuxG8aGaesJsBwYeEPx5
LJbTq/kL3x7QGcBLo+tUo3j7WzmPbvVRzmkYEcJBm+VlFkwZ3edfKmJ62BkYLjWa
+0gQmya0siwHqBcu1SP1IU6ppISp/6sHQ8d5bOxsbcZ27Plbmf78uXkWC6J+Lqpz
EBlV6kTxkCewZmOpTj3c4krGM8EqeX9Y72Le4hH8vN0Oi6LUTCIIVhcRdNW77+Hk
46yFl/r37BL4sVS0AsrPPBA/vcrxzr46TwJ+YkA1Wv4euVby3sSvVw89To7hFIgf
XxK39eZz13eGZ5wIVehwFhOTZZ+V13jf05vKD7yNBqDrFSJoFNciLx21z6dlEK4V
iupGN+y9sBLK/56T/T65JQS1+c/7DVFeXL+7dWw36zN3XI22v/Rzv1aCrdPK5qup
IJ1lOAsZYqhplvfgwJRU89QDP0KbgFn8W10wIsnotb2tREok8hcDRW2YxozzXxsp
WnqkSXOkHbxf/S4ItUjSl5eCN0R2pAbcqsXpGiJIk4y7xSij/cA=
=LLGP
-----END PGP SIGNATURE-----

--D7zng1y5j/j/D5U1--
