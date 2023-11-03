Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB2A7E012C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjKCK3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 06:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbjKCK3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 06:29:35 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA6113E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 03:29:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1qyrQY-0007Mi-Vi; Fri, 03 Nov 2023 11:29:22 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mgr@pengutronix.de>)
        id 1qyrQX-006IAj-Ci; Fri, 03 Nov 2023 11:29:21 +0100
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <mgr@pengutronix.de>)
        id 1qyrQX-004QHV-2z; Fri, 03 Nov 2023 11:29:21 +0100
Date:   Fri, 3 Nov 2023 11:29:21 +0100
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Jayant Chowdhary <jchowdhary@google.com>
Cc:     Dan Scally <dan.scally@ideasonboard.com>,
        stern@rowland.harvard.edu, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org, Thinh.Nguyen@synopsys.com,
        arakesh@google.com, etalvala@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v3] usb:gadget:uvc Do not use worker thread to queue isoc
 usb requests
Message-ID: <ZUTLgfRRkUOna//G@pengutronix.de>
References: <20231026215635.2478767-1-jchowdhary@google.com>
 <20231102060120.1159112-1-jchowdhary@google.com>
 <915ef27a-11c8-49ba-8f8a-b4524b85c75a@ideasonboard.com>
 <b6732f9f-f77f-449a-8934-f23a7f5b3177@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="etqknRciQZpSUrcI"
Content-Disposition: inline
In-Reply-To: <b6732f9f-f77f-449a-8934-f23a7f5b3177@google.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--etqknRciQZpSUrcI
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 03, 2023 at 12:28:31AM -0700, Jayant Chowdhary wrote:
>Hi Dan,
>Thank you for the comments.
>I uploaded a new patch at https://lore.kernel.org/linux-usb/20231103071353=
=2E1577383-1-jchowdhary@google.com/T/#u.
>
>On 11/2/23 09:07, Dan Scally wrote:
>> Hi Jayant - thanks for the patch
>>
>> On 02/11/2023 06:01, Jayant Chowdhary wrote:
>>> When we use an async work queue to perform the function of pumping
>>> usb requests to the usb controller, it is possible that amongst other
>>> factors, thread scheduling affects at what cadence we're able to pump
>>> requests. This could mean isoc usb requests miss their uframes - result=
ing
>>> in video stream flickers on the host device.
>>>
>>> To avoid this, we make the async_wq thread only produce isoc usb_reques=
ts
>>> with uvc buffers encoded into them. The process of queueing to the
>>> endpoint is done by the uvc_video_complete() handler. In case no
>>> usb_requests are ready with encoded information, we just queue a zero
>>> length request to the endpoint from the complete handler.
>>>
>>> For bulk endpoints the async_wq thread still queues usb requests to the
>>> endpoint.
>>>
>>> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>>> Signed-off-by: Jayant Chowdhary <jchowdhary@google.com>
>>> Suggested-by: Avichal Rakesh <arakesh@google.com>
>>> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
>>> ---
>>> =C2=A0 Based on top of
>>> =C2=A0 https://lore.kernel.org/linux-usb/20230930184821.310143-1-arakes=
h@google.com/T/#t:
>>> =C2=A0 v1->v2: Added self Signed-Off-by and addressed review comments
>>> =C2=A0 v2->v3: Encode to usb requests in async_wq; queue to ep in compl=
ete handler
>>> =C2=A0=C2=A0=C2=A0=C2=A0 for isoc transfers.
>>>
>>> =C2=A0 drivers/usb/gadget/function/uvc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 8 +
>>> =C2=A0 drivers/usb/gadget/function/uvc_video.c | 187 ++++++++++++++++++=
+-----
>>> =C2=A0 2 files changed, 156 insertions(+), 39 deletions(-)
>>>
>>> diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/fun=
ction/uvc.h
>>> index e8d4c87f1e09..82c783410554 100644
>>> --- a/drivers/usb/gadget/function/uvc.h
>>> +++ b/drivers/usb/gadget/function/uvc.h
>>> @@ -105,7 +105,15 @@ struct uvc_video {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool is_enabled; /* tracks whether video=
 stream is enabled */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int req_size;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct list_head ureqs; /* all uvc_reque=
sts allocated by uvc_video */
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* USB requests video pump thread can encode into*/
>>
>> "USB requests that the video pump thread can encode into", and a space b=
efore the closing */ please (and the same a few more times below).
>
>Done.
>
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct list_head req_free;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * USB requests video pump thread has already =
encoded into. These are
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * ready to be queued to the endpoint.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 struct list_head req_ready;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spinlock_t req_lock;
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int req_int_count;
>>> diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadg=
et/function/uvc_video.c
>>> index 53feb790a4c3..c84183e9afcc 100644
>>> --- a/drivers/usb/gadget/function/uvc_video.c
>>> +++ b/drivers/usb/gadget/function/uvc_video.c
>>> @@ -268,6 +268,98 @@ static int uvcg_video_ep_queue(struct uvc_video *v=
ideo, struct usb_request *req)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> =C2=A0 }
>>> =C2=A0 +/* This function must be called with video->req_lock held*/
>>> +static int uvcg_video_usb_req_queue(struct uvc_video *video,
>>> +=C2=A0=C2=A0=C2=A0 struct usb_request *req, bool queue_to_ep) {
>> Brace on a new line please - same a few more times below
>
>Done.
>
>>> +=C2=A0=C2=A0=C2=A0 bool is_bulk =3D video->max_payload_size;
>> empty line here
>>> +=C2=A0=C2=A0=C2=A0 if (!video->is_enabled) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uvc_video_free_request(req-=
>context, video->ep);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENODEV;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 if (queue_to_ep) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct uvc_request *ureq =
=3D req->context;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * With USB3 handling =
more requests at a higher speed, we can't
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * afford to generate =
an interrupt for every request. Decide to
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * interrupt:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * - When no more requ=
ests are available in the free queue, as
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 this ma=
y be our last chance to refill the endpoint's
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 request=
 queue.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * - When this is requ=
est is the last request for the video
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 buffer,=
 as we want to start sending the next video buffer
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 ASAP in=
 case it doesn't get started already in the next
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 iterati=
on of this loop.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * - Four times over t=
he length of the requests queue (as
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 indicat=
ed by video->uvc_num_requests), as a trade-off
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 between=
 latency and interrupt load.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (list_empty(&video->req_=
free) || ureq->last_buf ||
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !(v=
ideo->req_int_count %
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DIV=
_ROUND_UP(video->uvc_num_requests, 4))) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vid=
eo->req_int_count =3D 0;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req=
->no_interrupt =3D 0;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req=
->no_interrupt =3D 1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 video->req_int_count++;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return uvcg_video_ep_queue(=
video, req);
>>> +=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If we're not queing to th=
e ep, for isoc we're queing
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * to the req_ready list, ot=
herwise req_free.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct list_head *list =3D
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is_=
bulk ? &video->req_free : &video->req_ready;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_add_tail(&req->list, l=
ist);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>> +}
>>> +
>>> +static int uvcg_video_ep_queue_zero_length(struct usb_request *req,
>>> +=C2=A0=C2=A0=C2=A0 struct uvc_video *video) {
>>> +=C2=A0=C2=A0=C2=A0 req->length =3D 0;
>>> +=C2=A0=C2=A0=C2=A0 return uvcg_video_ep_queue(video, req);
>>> +}
>> Not sure this is worth its own function
>
>Removed the function.
>
>>> +
>>> +/* Must only be called from uvcg_video_enable - since after that we on=
ly want to
>>> + * queue requests to the endpoint from the uvc_video_complete complete=
 handler.
>>> + * This function is needed in order to 'kick start' the flow of reques=
ts from
>>> + * gadget driver to the usb controller.
>>> + */
>>> +static void uvc_video_ep_queue_initial_requests(struct uvc_video *vide=
o) {
>>> +=C2=A0=C2=A0=C2=A0 struct usb_request *req =3D NULL;
>>> +=C2=A0=C2=A0=C2=A0 unsigned long flags =3D 0;
>>> +=C2=A0=C2=A0=C2=A0 unsigned int count =3D 0;
>>> +=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>>> +=C2=A0=C2=A0=C2=A0 /* We only queue half of the free list since we sti=
ll want to have
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * some free usb_requests in the free list for=
 the video_pump async_wq
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * thread to encode uvc buffers into. Otherwis=
e we could get into a
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * situation where the free list does not have=
 any usb requests to
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * encode into - we always end up queueing 0 l=
ength requests to the
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * end point.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 unsigned half_list_size =3D video->uvc_num_requests=
 / 2;
>>> +=C2=A0=C2=A0=C2=A0 spin_lock_irqsave(&video->req_lock, flags);
>>> +=C2=A0=C2=A0=C2=A0 /* Take these requests off the free list and queue =
them all to the
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * endpoint. Since we queue the requests with =
the req_lock held,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>
>> This comment seems to be incomplete? You also want an opening /* on its =
own line:
>
>Apologies I think I missed out completing this comment I will send out ano=
ther patch later.
>
>>
>>
>> /*
>> =C2=A0* Multi line comments
>> =C2=A0* look like this
>> =C2=A0*/
>>
>
>Done.
>
>>> +=C2=A0=C2=A0=C2=A0 while (count < half_list_size) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req =3D list_first_entry(&v=
ideo->req_free, struct usb_request,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_del(&req->list);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D uvcg_video_ep_queue=
_zero_length(req, video);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uvc=
g_queue_cancel(&video->queue, /*disconnect*/0);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bre=
ak;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 count++;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 spin_unlock_irqrestore(&video->req_lock, flags);
>>> +}
>>> +
>>
>> So if I'm understanding the new starting sequence right for an isoc endp=
oint there's an initial flight of half the requests (between 2 and 32) that=
 are queued as zero length - the very first one to .complete() being re-que=
ued as a zero length request before the workqueue is started and encodes da=
ta into the _other_ half of the requests which were left in req_free and pu=
tting them into req_ready. At that point the .complete()s being run start t=
o pick requests off req_ready instead and they get sent out with data...doe=
s that sound right?
>>
>>
>That is correct - the first half of number of usb requests allocated (2, 3=
2) are queued at zero length initially. We=E2=80=99ll have half of the requ=
ests being sent to the ep in flight and half in the free list yes.
>queue_work will actually start with either uvc_v4l2_qbuf (uvc_v4l2.c) or a=
t a zero length request being completed - whichever comes first.
>
>> What are the implications of those initial 3-33 zero length requests? Wh=
at kind of latency can that introduce to the start of the video stream?
>
>At the worst, we=E2=80=99ll have  a 32 x 125us(uframe period) =3D 4ms  del=
ay for the first frame of the uvc buffer stream being sent out to the usb c=
ontroller.
>After that, since uvc buffers are typically queued at a much lower rate th=
an usb requests being sent to the endpoint, we should be fine ?
>In my local testing, I don't see any delay observable to the naked eye.

You won't see the any effect in most cases, because what you actually
lose is potential bandwidth. Let's think of a possible scenario; you
have the hard limits of displaying a frame every 33ms. If the frame is
small enough to be transmitted in the remaining 29ms with the active
bandwidth tweaks in the usb endpoint (mult, burst), the streaming is
totally fine.

The only downside is that you loose possible 4ms of processing time
after the total frame did hit the host. But this only matters if the
presentation time stamp (PTS) is actually set and would take an effect.

Regards,
Michael

>>
>>> =C2=A0 static void
>>> =C2=A0 uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
>>> =C2=A0 {
>>> @@ -276,6 +368,8 @@ uvc_video_complete(struct usb_ep *ep, struct usb_re=
quest *req)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct uvc_video_queue *queue =3D &video=
->queue;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct uvc_buffer *last_buf =3D NULL;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long flags;
>>> +=C2=A0=C2=A0=C2=A0 bool is_bulk =3D video->max_payload_size;
>>> +=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_irqsave(&video->req_loc=
k, flags);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!video->is_enabled) {
>>> @@ -329,7 +423,38 @@ uvc_video_complete(struct usb_ep *ep, struct usb_r=
equest *req)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * back to req_free
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (video->is_enabled) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_add_tail(&req->list, &=
video->req_free);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Here we check wheth=
er any request is available in the ready
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * list. If it is, que=
ue it to the ep and add the current
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * usb_request to the =
req_free list - for video_pump to fill in.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Otherwise, just use=
 the current usb_request to queue a 0
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * length request to t=
he ep. Since we always add to the req_free
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * list if we dequeue =
=66rom the ready list, there will never
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * be a situation wher=
e the req_free list is completely out of
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * requests and cannot=
 recover.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct usb_request *to_queu=
e =3D req;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to_queue->length =3D 0;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!list_empty(&video->req=
_ready)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to_=
queue =3D list_first_entry(&video->req_ready,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 struct usb_request, list);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lis=
t_del(&to_queue->list);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* =
Add it to the free list. */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lis=
t_add_tail(&req->list, &video->req_free);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Queue to the endpoi=
nt. The actual queueing to ep will
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * only happen on one =
thread - the async_wq for bulk endpoints
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * and this thread for=
 isoc endpoints.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D uvcg_video_usb_req_=
queue(video, to_queue,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /*queue_to_ep*/!is_bulk);
>>
>>
>> In principle in-line comments are fine, but I don't think the parameter =
name is worth a comment
>
>Done.
>
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if(ret < 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uvc=
g_queue_cancel(queue, 0);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Queue work to the wq as =
well since its possible that a buffer
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * may not have been c=
ompleted.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>
>>
>> The phrasing of this implies this is a bit of defensive programming, but=
 if we don't queue to the wq here then doesn't that mean it'll never run?
>
>
>I've updated the comment here - it is possible that we hit a situation whe=
re the in-flight usb requests may not be enough to completely
>encode a uvc buffer. In that case if we don't call queue_work, we'll never=
 get the buffer marked as 'completed' and the buffer won't be
>returned to user-space. That'll prevent the dequeue->queue->dequeue loop a=
nd flow of buffers.
>
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 queue_work(video=
->async_wq, &video->pump);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uvc_video_free_r=
equest(ureq, ep);
>>> @@ -347,6 +472,7 @@ uvc_video_free_requests(struct uvc_video *video)
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INIT_LIST_HEAD(&video->ureqs);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INIT_LIST_HEAD(&video->req_free);
>>> +=C2=A0=C2=A0=C2=A0 INIT_LIST_HEAD(&video->req_ready);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 video->req_size =3D 0;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> =C2=A0 }
>>> @@ -424,8 +550,7 @@ static void uvcg_video_pump(struct work_struct *wor=
k)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct usb_request *req =3D NULL;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct uvc_buffer *buf;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long flags;
>>> -=C2=A0=C2=A0=C2=A0 bool buf_done;
>>> -=C2=A0=C2=A0=C2=A0 int ret;
>>> +=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (true) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!video->ep->=
enabled)
>>> @@ -454,7 +579,6 @@ static void uvcg_video_pump(struct work_struct *wor=
k)
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (buf !=
=3D NULL) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 video->encode(req, video, buf);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buf=
_done =3D buf->state =3D=3D UVC_BUF_STATE_DONE;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (!(que=
ue->flags & UVC_QUEUE_DISCONNECTED) && !is_bulk) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 /*
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 * No video buffer available; the queue is still connected a=
nd
>>> @@ -462,7 +586,6 @@ static void uvcg_video_pump(struct work_struct *wor=
k)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 * prevent missed ISOC transfers.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 req->length =3D 0;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buf=
_done =3D false;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 /*
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 * Either the queue has been disconnected or no video buffer
>>> @@ -473,45 +596,26 @@ static void uvcg_video_pump(struct work_struct *w=
ork)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 break;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * With USB3 handling =
more requests at a higher speed, we can't
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * afford to generate =
an interrupt for every request. Decide to
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * interrupt:
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * - When no more requ=
ests are available in the free queue, as
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 this ma=
y be our last chance to refill the endpoint's
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 request=
 queue.
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * - When this is requ=
est is the last request for the video
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 buffer,=
 as we want to start sending the next video buffer
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 ASAP in=
 case it doesn't get started already in the next
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 iterati=
on of this loop.
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * - Four times over t=
he length of the requests queue (as
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 indicat=
ed by video->uvc_num_requests), as a trade-off
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 between=
 latency and interrupt load.
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (list_empty(&video->req_=
free) || buf_done ||
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !(v=
ideo->req_int_count %
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 DIV_ROUND_UP(video->uvc_num_requests, 4))) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vid=
eo->req_int_count =3D 0;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req=
->no_interrupt =3D 0;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req=
->no_interrupt =3D 1;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Queue the USB request */
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D uvcg_video_ep_queue=
(video, req);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock_irqr=
estore(&queue->irqlock, flags);
>>> =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Queue the USB req=
uest.*/
>> I think just drop this - it was always superfluous.
>
>The uvcg_video_usb_req_queue function mentions that req_lock must be held =
while calling
>it - since its possible we might add to the req_ready list. We could say t=
he function
>should hold req_lock only when the queue_to_ep parameter is false - but th=
at doesn't
>seem as clean ?
>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_irqsave(&video->r=
eq_lock, flags);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* For bulk end points we q=
ueue from the worker thread
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * since we would pref=
erably not want to wait on requests
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * to be ready, in the=
 uvcg_video_complete() handler.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * For isoc endpoints =
we add the request to the ready list
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * and only queue it t=
o the endpoint from the complete handler.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D uvcg_video_usb_req_=
queue(video, req, is_bulk);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock_irqrestore(&vid=
eo->req_lock, flags);
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 uvcg_queue_cancel(queue, 0);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 break;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Endpoint now owns=
 the request */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* The request is owned by=
=C2=A0 the endpoint / ready list*/
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req =3D NULL;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 video->req_int_count++;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!req)
>>> @@ -567,7 +671,7 @@ uvcg_video_disable(struct uvc_video *video)
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_irqsave(&video->req_loc=
k, flags);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> -=C2=A0=C2=A0=C2=A0=C2=A0 * Remove all uvc_reqeusts from ureqs with lis=
t_del_init
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Remove all uvc_requests from ureqs with lis=
t_del_init
>> This should get fixed in the earlier series.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * This lets uvc_video_free_request=
 correctly identify
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * if the uvc_request is attached t=
o a list or not when freeing
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * memory.
>>> @@ -579,9 +683,13 @@ uvcg_video_disable(struct uvc_video *video)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_del(&req->l=
ist);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uvc_video_free_r=
equest(req->context, video->ep);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -
>> keep the empty line please
>
>Done.
>
>>> +=C2=A0=C2=A0=C2=A0 list_for_each_entry_safe(req, temp, &video->req_rea=
dy, list) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_del(&req->list);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uvc_video_free_request(req-=
>context, video->ep);
>>> +=C2=A0=C2=A0=C2=A0 }
>> and one here too.
>
>Done.
>
>Thanks!
>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INIT_LIST_HEAD(&video->ureqs);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INIT_LIST_HEAD(&video->req_free);
>>> +=C2=A0=C2=A0=C2=A0 INIT_LIST_HEAD(&video->req_ready);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 video->req_size =3D 0;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock_irqrestore(&video->req_lock,=
 flags);
>>> =C2=A0 @@ -635,7 +743,7 @@ int uvcg_video_enable(struct uvc_video *vide=
o)
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 video->req_int_count =3D 0;
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 queue_work(video->async_wq, &video->pump);
>>> +=C2=A0=C2=A0=C2=A0 uvc_video_ep_queue_initial_requests(video);
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> =C2=A0 }
>>> @@ -648,6 +756,7 @@ int uvcg_video_init(struct uvc_video *video, struct=
 uvc_device *uvc)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 video->is_enabled =3D false;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INIT_LIST_HEAD(&video->ureqs);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INIT_LIST_HEAD(&video->req_free);
>>> +=C2=A0=C2=A0=C2=A0 INIT_LIST_HEAD(&video->req_ready);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_init(&video->req_lock);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INIT_WORK(&video->pump, uvcg_video_pump);
>>> =C2=A0
>

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--etqknRciQZpSUrcI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmVEy34ACgkQC+njFXoe
LGTRzg/+NYZuP/lTet1Rmk4LGfS5HX3UvvJLSx7EKGHfLoOI502LIE66t65CHypA
9mtL/jzxD7lJFAMiFgo66Xo9HhMoa9Jz1BT0gSUmVp2ZO9gLHK13Q/DkEEbB+CPO
K9qtWd7QNpb9cKuPGAYoZBpeUygYO1tOxBb7D/NErA43IMaiaOb8+GWYgJPO/l2u
jBGkNzAqhZvHBZQov9i7S6K8AN5uTGlnj9wzt07m04uEtKpiP24rDSuDxp0YSx1J
0X3xPpRmUBao+8hmg18IrwwhV3Gn+iVYOMz+BoowQnceXgve87307pHpanxSt8s9
GkpGbPpou28EYACkXLnavZJ2YjP0XhkodvvWLgmUdPaIAnLWJLIRhMAmE52KVGXw
GnafILnaAFBnTYeK5Nl8nAkh6Fsd9SUX6TNu8sfJztKr0yXA6j8x4J9c40DWw507
/12SSewIsYtyA6pByJGT69PkUW+GZXigGDlS6u4pBIwUUnrxAFYUiX6hpMApssVJ
jH1hKBxoJowfRIGOGEV/lkCY5YsinF4VIrnftIZ5mf3Gk8YbsemFuLDvRcwajZRo
B3tjoR5x/tLHsip7LvCK2j2VD3iFfdyaPBqt23o8+G6CxsaPtKXEEtYEYqLULmVd
jYzugFqZZ9wqOs5zT/KaFTM+5vRhtf/tHC6xBBxv7FZGBm3A39E=
=eHHq
-----END PGP SIGNATURE-----

--etqknRciQZpSUrcI--
