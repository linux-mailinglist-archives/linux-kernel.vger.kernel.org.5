Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849897A2AED
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 01:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237976AbjIOXQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 19:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238008AbjIOXQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 19:16:40 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B648E50
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 16:16:35 -0700 (PDT)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1qhI35-0007jC-QB; Sat, 16 Sep 2023 01:16:32 +0200
Received: from mgr by pty.whiteo.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <mgr@pengutronix.de>)
        id 1qhI35-003sY4-DK; Sat, 16 Sep 2023 01:16:31 +0200
Date:   Sat, 16 Sep 2023 01:16:31 +0200
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Avichal Rakesh <arakesh@google.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <ZQTlz9Koe2CQIsrC@pengutronix.de>
References: <20230912041910.726442-1-arakesh@google.com>
 <CAMHf4WLeSC9m05XOU54yL=2xUcSqbWP0f7evM0rZRsJ=J-btWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q9JWgXnV+XEfBRBA"
Content-Disposition: inline
In-Reply-To: <CAMHf4WLeSC9m05XOU54yL=2xUcSqbWP0f7evM0rZRsJ=J-btWw@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:2:b01:1d::c5
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH v1 0/2] usb: gadget: uvc: stability fixes when stopping
 streams
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on metis.whiteo.stw.pengutronix.de)
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q9JWgXnV+XEfBRBA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Avichal

On Thu, Sep 14, 2023 at 04:05:36PM -0700, Avichal Rakesh wrote:
>On Mon, Sep 11, 2023 at 9:19=E2=80=AFPM Avichal Rakesh <arakesh@google.com=
> wrote:
>>
>> We have been seeing two main bugs when stopping stream:
>> 1. attempting to queue usb_requests on a disabled usb endpoint, and
>> 2. use-after-free problems for inflight requests
>>
>> Avichal Rakesh (2):
>>   usb: gadget: uvc: prevent use of disabled endpoint
>>   usb: gadget: uvc: prevent de-allocating inflight usb_requests
>>
>>  drivers/usb/gadget/function/f_uvc.c     | 11 ++++----
>>  drivers/usb/gadget/function/f_uvc.h     |  2 +-
>>  drivers/usb/gadget/function/uvc.h       |  5 +++-
>>  drivers/usb/gadget/function/uvc_v4l2.c  | 21 ++++++++++++---
>>  drivers/usb/gadget/function/uvc_video.c | 34 +++++++++++++++++++++++--
>>  5 files changed, 60 insertions(+), 13 deletions(-)
>>
>
>Bumping this thread up. Laurent, Dan, and Michael could you take a look?

I tested the patches against my setup and it did not help.

In fact I saw two different issues when calling the streamoff event.

One issue was a stalled pipeline after the streamoff from the host came in.
The streaming application did not handle any events anymore.

The second issue was when the streamoff event is triggered sometimes the
following trace is shown, even with your patches applied.


[  104.202689] Unable to handle kernel paging request at virtual address 00=
5bf43a692a5fd5
[  104.235122] Mem abort info:
[  104.238257]   ESR =3D 0x0000000096000004
[  104.242449]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[  104.248391]   SET =3D 0, FnV =3D 0
[  104.251803]   EA =3D 0, S1PTW =3D 0
[  104.255313]   FSC =3D 0x04: level 0 translation fault
[  104.260765] Data abort info:
[  104.263982]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
[  104.270114]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
[  104.275760]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[  104.281698] [005bf43a692a5fd5] address between user and kernel address r=
anges
[  104.290042] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[  104.297060] Dumping ftrace buffer:
[  104.300869]    (ftrace buffer empty)
[  104.304862] Modules linked in: st1232 hantro_vpu v4l2_vp9 v4l2_h264 uio_=
pdrv_genirq fuse [last unloaded: rockchip_vpu(C)]
[  104.312080] panfrost fde60000.gpu: Panfrost Dump: BO has no sgt, cannot =
dump
[  104.317137] CPU: 0 PID: 465 Comm: irq/46-dwc3 Tainted: G         C      =
   6.5.0-20230831-2+ #5
[  104.317144] Hardware name: WolfVision PF5 (DT)
[  104.317148] pstate: 604000c9 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[  104.317154] pc : __list_del_entry_valid+0x48/0xe8
[  104.352728] lr : dwc3_gadget_giveback+0x3c/0x1b0
[  104.357893] sp : ffffffc08381bc60
[  104.361593] x29: ffffffc08381bc60 x28: ffffff80047d4000 x27: ffffff80047=
de440
[  104.369576] x26: 0000000000000000 x25: ffffffc08135b2d0 x24: ffffffc0838=
1bd00
[  104.377559] x23: 00000000ffffff98 x22: ffffff8004204880 x21: ffffff80047=
d4000
[  104.385541] x20: ffffff800718dea0 x19: ffffff800718dea0 x18: 00000000000=
00000
[  104.393523] x17: 7461747320687469 x16: 7720646574656c70 x15: 6d6f6320747=
36575
[  104.401504] x14: 716572205356203a x13: 2e3430312d207375 x12: 74617473206=
87469
[  104.409486] x11: ffffffc0815c98f0 x10: 0000000000000000 x9 : ffffffc0808=
f4fa0
[  104.417468] x8 : ffffffc082415000 x7 : ffffffc0808f4e2c x6 : ffffffc0823=
d0928
[  104.425450] x5 : 0000000000000282 x4 : 0000000000000201 x3 : d85bf43a692=
a5fcd
[  104.433431] x2 : ffffff80047d4048 x1 : ffffff800718dea0 x0 : dead0000000=
00122
[  104.441413] Call trace:
[  104.444142]  __list_del_entry_valid+0x48/0xe8
[  104.449013]  dwc3_gadget_giveback+0x3c/0x1b0
[  104.453786]  dwc3_gadget_ep_cleanup_cancelled_requests+0xe0/0x170
[  104.460599]  dwc3_process_event_buf+0x2a8/0xbb0
[  104.465662]  dwc3_thread_interrupt+0x4c/0x90
[  104.470435]  irq_thread_fn+0x34/0xb8
[  104.474431]  irq_thread+0x1a0/0x290
[  104.478327]  kthread+0x10c/0x120
[  104.481933]  ret_from_fork+0x10/0x20

The error path triggering these list errors are usually in the
dwc3 driver handling the cancelled or completed list.

Regards,
Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--q9JWgXnV+XEfBRBA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAmUE5c8ACgkQC+njFXoe
LGRdJRAAj580qBvWF1tftaNM/7YxxbvMYTSKQt4a5/wXyxS5QUrggJ87woQ73E8z
kkPXezZBkibQZo/1CMjxwAib4F0lMS2/Srkvm3ctjoCcWWrhGUkBmMz4SCXVfI2j
Tv5ZiVaYqaasM8zQNU5aaixxNUJd+un8EddwIHznQF1z+hgRIqwnfjNIW3Hck2i9
5errJffT00gG8riFJ0i47Dzdltd+V69paHyDfCoeazFC3TMKDp3BZJ/iRU1TGFj7
Lv8RZ5qdyLJh4LDoH23VANdGvUMtz019adqarXLkeA4Sof9n5KsaZNm2mWxpw0of
j1imGD57qTa0KUk0gZAAplc2j80ZY9Ypd9bFeyF7xqc3z7vvJEyKVw+ImBy4bEJJ
JXm9PHvP6bRv/aEqAre9oKwTWd2HgB+W4BjLfOQ/VQlJx64rq+My4sUachBYjQmN
nv/RjU2T47WaEjhUr6hk9ZXesqg4kjYTsu61rm7gYVgZlNFEQCSDEnhxJSZ0EUNf
fKxxnObuDwjxjjWfrz2CQwwB0i8760Y6EyT41Y0rTyGzJoj28lDkRgXwWodfqqbX
fgAw99reXHxrmttO75DZ3L7ki4d0uDpYSqq0vNflxNbRZATC1xZ8cKyhWAa76Rkl
v/iw5q2JWRKW+//CRBGfIUYOu1y8ErWrRq/V2xZ4w7gfaFyRkjY=
=6z+2
-----END PGP SIGNATURE-----

--q9JWgXnV+XEfBRBA--
