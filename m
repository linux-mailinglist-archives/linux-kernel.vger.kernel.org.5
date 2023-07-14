Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AB175445F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 23:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjGNVnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 17:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGNVne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 17:43:34 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CD11BDA;
        Fri, 14 Jul 2023 14:43:33 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-3460e9f2376so10863045ab.1;
        Fri, 14 Jul 2023 14:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689371012; x=1691963012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2iRVOWuFG5CSavPgNPM0rD9zBfEzQVEcWQXV3fkSWk=;
        b=gQvhll804QGcXkSeF0zAwJB26XCaFd9zRFwx121UFE6AmVmBr2X/xY4VUk9jvfzXyZ
         /lMMbnP9X8BqPvtTKKlgFMNKzwgEpBn6nNEyS9qnb2d/CTf24SjtqUQbilF9S5BS4IJy
         lTiiQqh+TBvVkxYrm6uldiZWoTE2eJ27xi3G2OEmgjAmt4y5cOwvaF3LKlAgWLFioz77
         DOULRvqnMxLT2QbOjtP3Jk4w/39vwE/tE8HZWAGEWSv9LGS+k7aYRlr51CXi58cAsRnp
         LO3frNloCJhOD7IgHEcsBcGotrXdi3chKbDCzhXMQVXk151zbsAKKuoTTDZRwq6VmXaj
         pFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689371012; x=1691963012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p2iRVOWuFG5CSavPgNPM0rD9zBfEzQVEcWQXV3fkSWk=;
        b=BN4EX1xu9O7yaO5GuScyNuCLw5up2VmoXug00KMXHzLuGEBAqGg+MGPJNJIAx/1reI
         4O3SLE10YtFO7z334HAnuooryKPV1qSvJ2MFaB63QaN6gkAC7k3INC45pP/SwIg/NK4n
         bs1/eigfkMWznvNR0B97p6xHQmfDwer36rhIr242hy79NGL5tq4z6g4Ms/EJcWGzkxv7
         qGiO+rueb6pceyrh9J9ztONEF/WTNZww/xkoGkxdXPR99vK8sUKUS64gdlCs9tnWo+nj
         h6O4aigQC5JdAwPaJPNGXdoLA0AleYjcAYJyXeaZSVv9V5m6Ba2qFdof/WUA7rplqs0D
         AKtA==
X-Gm-Message-State: ABy/qLYgWYs0tDc1jBWZG6t7QUnbLb9IUwnVI/duCjh7KifAGJJi3kfy
        xBOJS28FFRWttWH2O3owF2nDsQgAMcDlmR8+pPM=
X-Google-Smtp-Source: APBJJlHSpz8aatIwLDKTbGuGdVxohFYXrOiOqAvPGaCZTqAuJ+AILMG67RK2M/stGksfS7DqaeJc5CNQgJhI3+kWu20=
X-Received: by 2002:a92:c944:0:b0:345:d58d:9ae5 with SMTP id
 i4-20020a92c944000000b00345d58d9ae5mr5841824ilq.7.1689371012540; Fri, 14 Jul
 2023 14:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230714074011.20989-1-qiang.zhang1211@gmail.com>
In-Reply-To: <20230714074011.20989-1-qiang.zhang1211@gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Fri, 14 Jul 2023 23:43:21 +0200
Message-ID: <CA+fCnZfxLLLVJdPZmVKg5w4YY+i09ZRz-wu+TAXBaroRgGsAsQ@mail.gmail.com>
Subject: Re: [PATCH] USB: gadget: Fix the memory leak in raw_gadget driver
To:     Zqiang <qiang.zhang1211@gmail.com>, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 9:40=E2=80=AFAM Zqiang <qiang.zhang1211@gmail.com> =
wrote:
>
> Currently, increasing raw_dev->count happens before invoke the
> raw_queue_event(), if the raw_queue_event() return error, invoke
> raw_release() will not trigger the dev_free() to be called.
>
> [  268.905865][ T5067] raw-gadget.0 gadget.0: failed to queue event
> [  268.912053][ T5067] udc dummy_udc.0: failed to start USB Raw Gadget: -=
12
> [  268.918885][ T5067] raw-gadget.0: probe of gadget.0 failed with error =
-12
> [  268.925956][ T5067] UDC core: USB Raw Gadget: couldn't find an availab=
le UDC or it's busy
> [  268.934657][ T5067] misc raw-gadget: fail, usb_gadget_register_driver =
returned -16
>
> BUG: memory leak
>
> [<ffffffff8154bf94>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1076
> [<ffffffff8347eb55>] kmalloc include/linux/slab.h:582 [inline]
> [<ffffffff8347eb55>] kzalloc include/linux/slab.h:703 [inline]
> [<ffffffff8347eb55>] dev_new drivers/usb/gadget/legacy/raw_gadget.c:191 [=
inline]
> [<ffffffff8347eb55>] raw_open+0x45/0x110 drivers/usb/gadget/legacy/raw_ga=
dget.c:385
> [<ffffffff827d1d09>] misc_open+0x1a9/0x1f0 drivers/char/misc.c:165
>
> [<ffffffff8154bf94>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1076
> [<ffffffff8347cd2f>] kmalloc include/linux/slab.h:582 [inline]
> [<ffffffff8347cd2f>] raw_ioctl_init+0xdf/0x410 drivers/usb/gadget/legacy/=
raw_gadget.c:460
> [<ffffffff8347dfe9>] raw_ioctl+0x5f9/0x1120 drivers/usb/gadget/legacy/raw=
_gadget.c:1250
> [<ffffffff81685173>] vfs_ioctl fs/ioctl.c:51 [inline]
>
> [<ffffffff8154bf94>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1076
> [<ffffffff833ecc6a>] kmalloc include/linux/slab.h:582 [inline]
> [<ffffffff833ecc6a>] kzalloc include/linux/slab.h:703 [inline]
> [<ffffffff833ecc6a>] dummy_alloc_request+0x5a/0xe0 drivers/usb/gadget/udc=
/dummy_hcd.c:665
> [<ffffffff833e9132>] usb_ep_alloc_request+0x22/0xd0 drivers/usb/gadget/ud=
c/core.c:196
> [<ffffffff8347f13d>] gadget_bind+0x6d/0x370 drivers/usb/gadget/legacy/raw=
_gadget.c:292
>
> This commit therefore invoke kref_get() under the condition that
> raw_queue_event() return success.
>
> Reported-by: syzbot+feb045d335c1fdde5bf7@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dfeb045d335c1fdde5bf7
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> ---
>  drivers/usb/gadget/legacy/raw_gadget.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/=
legacy/raw_gadget.c
> index 2acece16b890..e549022642e5 100644
> --- a/drivers/usb/gadget/legacy/raw_gadget.c
> +++ b/drivers/usb/gadget/legacy/raw_gadget.c
> @@ -310,13 +310,15 @@ static int gadget_bind(struct usb_gadget *gadget,
>         dev->eps_num =3D i;
>         spin_unlock_irqrestore(&dev->lock, flags);
>
> -       /* Matches kref_put() in gadget_unbind(). */
> -       kref_get(&dev->count);
> -
>         ret =3D raw_queue_event(dev, USB_RAW_EVENT_CONNECT, 0, NULL);
> -       if (ret < 0)
> +       if (ret < 0) {
>                 dev_err(&gadget->dev, "failed to queue event\n");
> +               set_gadget_data(gadget, NULL);
> +               return ret;
> +       }
>
> +       /* Matches kref_put() in gadget_unbind(). */
> +       kref_get(&dev->count);
>         return ret;
>  }
>
> --
> 2.17.1

Indeed, if gadget_bind fails due to a raw_queue_event failure, the
core gadget code will never call gadget_unbind.

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Tested-by: Andrey Konovalov <andreyknvl@gmail.com>

Thanks!
