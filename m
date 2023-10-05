Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86A27BAE97
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 00:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjJEWFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 18:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjJEWFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 18:05:35 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B939E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 15:05:34 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1qoWTJ-00039q-VF; Fri, 06 Oct 2023 00:05:29 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mgr@pengutronix.de>)
        id 1qoWTJ-00BNLj-92; Fri, 06 Oct 2023 00:05:29 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <mgr@pengutronix.de>)
        id 1qoWTI-00FI2n-Vm; Fri, 06 Oct 2023 00:05:29 +0200
Date:   Fri, 6 Oct 2023 00:05:28 +0200
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Avichal Rakesh <arakesh@google.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jchowdhary@google.com, etalvala@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] usb: gadget: uvc: stability fixes on STREAMOFF.
Message-ID: <ZR8zKHQv1dkyLosv@pengutronix.de>
References: <20230930184821.310143-1-arakesh@google.com>
 <ZRv2UnKztgyqk2pt@pengutronix.de>
 <20231005082327.GC13853@pendragon.ideasonboard.com>
 <ZR6Me5WsAbjvc2hk@pengutronix.de>
 <53300d24-b558-428d-b52f-316b2e456313@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bKGQ3CYWzkfbylp5"
Content-Disposition: inline
In-Reply-To: <53300d24-b558-428d-b52f-316b2e456313@google.com>
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bKGQ3CYWzkfbylp5
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Avichal,

On Thu, Oct 05, 2023 at 11:30:32AM -0700, Avichal Rakesh wrote:
>On 10/5/23 03:14, Michael Grzeschik wrote:
>> On Thu, Oct 05, 2023 at 11:23:27AM +0300, Laurent Pinchart wrote:
>>> On Tue, Oct 03, 2023 at 01:09:06PM +0200, Michael Grzeschik wrote:
>>>> On Sat, Sep 30, 2023 at 11:48:18AM -0700, Avichal Rakesh wrote:
>>>> > We have been seeing two main stability issues that uvc gadget driver
>>>> > runs into when stopping streams:
>>>> >=A0 1. Attempting to queue usb_requests to a disabled usb_ep
>>>> >=A0 2. use-after-free issue for inflight usb_requests
>>>> >
>>>> > The three patches below fix the two issues above. Patch 1/3 fixes the
>>>> > first issue, and Patch 2/3 and 3/3 fix the second issue.
>>>> >
>>>> > Avichal Rakesh (3):
>>>> >=A0=A0 usb: gadget: uvc: prevent use of disabled endpoint
>>>> >=A0=A0 usb: gadget: uvc: Allocate uvc_requests one at a time
>>>> >=A0=A0 usb: gadget: uvc: Fix use-after-free for inflight usb_requests
>>>> >
>>>> > drivers/usb/gadget/function/f_uvc.c=A0=A0=A0=A0 |=A0 11 +-
>>>> > drivers/usb/gadget/function/f_uvc.h=A0=A0=A0=A0 |=A0=A0 2 +-
>>>> > drivers/usb/gadget/function/uvc.h=A0=A0=A0=A0=A0=A0 |=A0=A0 6 +-
>>>> > drivers/usb/gadget/function/uvc_v4l2.c=A0 |=A0 21 ++-
>>>> > drivers/usb/gadget/function/uvc_video.c | 189 +++++++++++++++++-----=
--
>>>> > 5 files changed, 164 insertions(+), 65 deletions(-)
>>>>
>>>> These patches are not applying on gregkh/usb-testing since
>>>> Greg did take my patches first. I have already rebased them.
>>>
>>> I think they got merged too soon :-( We could fix things on top, but
>>> there's very little time to do so for v6.7.
>>
>> Agreed. I was jumping from one workaround to another one, since this
>> is not easy to fix in a proper way. And still after this long discussion
>> with Avichal I don't think we are there yet.
>>
>>
>> So far the first two patches from Avichal look legit. But the overall
>> Use-After-Free fix is yet to be done properly.
>>
>> The "abondoned" method he suggested is really bad to follow and will
>> add too much complexity and will be hard to debug.
>>
>> IMHO it should be possible to introduce two cleanup pathes.
>>
>> One path would be in the uvc_cleanup_requests that will cleanup the
>> requests that are actually not used in the controller and are registered
>> in the req_free list.
>>
>> The second path would be the complete functions that are being run
>> from the controller and will ensure that the cleanup will really free
>> the requests from the controller after they were consumed.
>>
>> What do you think?
>
>I am not sure I follow. Patch 3/3 does exactly what you say here.

Yes, it was just to summ up what the latest state of the idea was,
so Laurent does not read the whole thread in detail. Sorry for not
being clear enough about that.

>There are two cleanup paths:
>  1. uvcg_video_disable cleans up only the requests in req_free, and
>  2. complete handler cleans up the in-flight requests.
>
>The "abandoned" flag is simply to let the completion handler know
>which requests to clean up and which ones to re-queue back to
>the gadget driver.

What I don't get is, why in the case of shutdown there needs to
be something re-queued back to the gadget driver. There should not
need to be any sort of barrier flag for the requests. Just the
complete handler running past a barrier where it knows that the
whole device is stopped. So every call on complete should then clean
that exact request it is touching currently.

I don't know where the extra complexity comes from.

>The other "complications" are around making sure we can trust
>the values in an inherently racey situation. The reasoning
>can admittedly be difficult to follow at a glance, which incidentally
>is why I went with a simple to prove timed wait in the past
>(https://lore.kernel.org/20230912041910.726442-3-arakesh@google.com).
>
>I am not suggesting we go back to a timed wait, but please do look
>at the patch and let me know which parts don't make sense, or are
>difficult to understand. We can add more documentation about our
>assumptions there, or if you have a way to do this that you
>think is simpler to reason about, then please let me know and I'll
>be more than happy to use that!

I really try to spin my head around the idea of the is_abondoned flag
you are using. Unfortunatly for now I am out to debug the issues I see
with your series.

So I did try these patches you send. Yes the deadlock error is gone with
v3. But the linked list is still running into cases where
dwc3_gadget_giveback(complete) is touching requests that are already
freed.

[   61.408715] ------------[ cut here ]------------
[   61.413897] kernel BUG at lib/list_debug.c:56!
=2E..
[   61.590762] Call trace:
[   61.596890]  __list_del_entry_valid+0xb8/0xe8
[   61.603408]  dwc3_gadget_giveback+0x3c/0x1b0
[   61.607594]  dwc3_remove_requests.part.0+0xcc/0x100
[   61.612948]  __dwc3_gadget_ep_disable+0xbc/0x1b8
[   61.621019]  dwc3_gadget_ep_disable+0x48/0x100
[   61.627925]  usb_ep_disable+0x3c/0x138
[   61.638230]  uvc_function_setup_continue+0x3c/0x60
[   61.645040]  uvc_v4l2_streamoff+0x5c/0x80
[   61.659812]  v4l_streamoff+0x40/0x60
[   61.668950]  __video_do_ioctl+0x344/0x420
[   61.679548]  video_usercopy+0x1d0/0x788
[   61.685677]  video_ioctl2+0x40/0x70
[   61.697439]  v4l2_ioctl+0x68/0xa0
[   61.709200]  __arm64_sys_ioctl+0x304/0xda0
[   61.720768]  invoke_syscall.constprop.0+0x70/0x130

Regards,
Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--bKGQ3CYWzkfbylp5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmUfMyYACgkQC+njFXoe
LGQwCw/+KuWq5eCCRs2wyNmR2Ojt7Y9Hv/dzvZFZFjyeNbVP6JStp1NWiu9Stew3
wln/VdjiRrceDZ1+afj1l3AaSQ210JAcLaEuqUv54LL2JJvun4sKHN5bCspNWDEA
kOKym+oDUNNTU3reZwEXh30GYdrh567uNh++m2+9b9+KV7GEshGXxvAHzW9Br9zz
my93O7pahJSBUvfkpYQVuw2yiXibecgO+AUsAS9dYs2N69KwefZpF1s/kQ1XrBHl
+I6Aivl+Tus/qYnjvAt1s2+L+ygHGZaZYYJM8v9yY4B+ADRhl3jPub72OwXS5emS
HAl1oE+lx7me3tVDgfp+B1r8PjQYBzRLPT8A8wtqFjv7hcjpEVHSSY1LQTaut1U+
bvAcSHM236A5a3bmkgVEsZ9nITn7j66S+OUVn+gmIYW7iTPXxhRyRvp+V7HPhR2z
dkeuH/Rk4braWAmuQP5SH9EBWi9oR1kbTJq8QNk7I/On1QPJaXMQ045n2/U1s8ID
9QbIcNdz7h0aoTMGpSNC3GVX0cZXbYyyALbu0F4RFp8Dt4uY1YY80yK9DL5rDv/X
muvSiVPN/SZ6ZwYG5zDJ/GYEqYQ4uEAL6uA7zWv4DyFmKN6KxYx/Jj0z7Csreb22
6ECjCqk25qBDr4JqwHorq5eJZUBnraFJXQc3oIWqZsszF3I1yM4=
=YVlC
-----END PGP SIGNATURE-----

--bKGQ3CYWzkfbylp5--
