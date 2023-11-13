Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30EE7E9B65
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 12:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjKMLuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 06:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMLuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 06:50:22 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0012DD6F;
        Mon, 13 Nov 2023 03:50:18 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-58a0d0cdcc1so1924927eaf.1;
        Mon, 13 Nov 2023 03:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699876218; x=1700481018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJv19RflNFLxseNOK5bYIxlZ6toHV0s8aNrsbjGGC8I=;
        b=FzvV1sLk0kuOSxwuq8RSLGMLFBFXnRqOjFqwr466JW8C6sp/miu7lhM3TGS83HP+c0
         yB34eM5drRNnQqZ9ojcx8zxMzey1RxnEIII7l9EP1b15pA41rwgL1KyXyGXa4qV/v/if
         G3p2ChtSCEsXyNOyTZt2YMxsGpajBKiF/TZnMoNRoDUz78aOPIBlrGNtmPEPNYzfl2hA
         2gjTxTdggjUq4CS42ht0tEoZXMAFQ2wywlKPEB/oZ4l2AHp3weha1oydrYfbogG7hRlN
         KlUcpDPrrsG8EjERxk+faYc9aQus/zZtkYz7Y4p3VaPm4Nwno0uiLWcu9UdSOdCDFBYs
         bfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699876218; x=1700481018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJv19RflNFLxseNOK5bYIxlZ6toHV0s8aNrsbjGGC8I=;
        b=DFS3aTZesV47XcB+5pjWjzN5hMUbFs6nwEuxk30vp8FJAvqZuU0tsoMT4bdvcszYrk
         i305Q5Txq4dNHTtUNiIDwtoZYWk7yUp5QBv7VCIf02F7dK5m/CO1w85OyUmILevf7ic/
         Ffe1tV9AKF+hIRSbZxsKnRSRdE3i+nyVl9gnA17b+OmJKFA7uLADfLsT9l9fyeuBEJcA
         euLOk8hhE5dHYM1BWTStmb75gzUYM1itZtS4i1zjF/OFSEw3zK2UZIFCKC32o5/p0yPo
         KSpyODTRbFuq8rztrLidR+yc/M/a970YWa9Y/AG5xRtJGbRMcrVM7xtgZOudY92FLmvk
         7Nqw==
X-Gm-Message-State: AOJu0Yzdsxdx/fl4e60X9crgmOs4V0ij6TitvKWeD65qEPgx8i/FYJO+
        lI7e2WNPy9oM65mIH3SlAvRUYbSpMwwQIR2HL14=
X-Google-Smtp-Source: AGHT+IHaQW9yVbQqvx8mz5VCkHHc0JZhxCp8WU54TkZGAVf4bej+T4u3NgXQXZs44zjHw7w8THD6Hy4r+Qb7KBGoOzY=
X-Received: by 2002:a4a:d2d9:0:b0:589:d576:b9fd with SMTP id
 j25-20020a4ad2d9000000b00589d576b9fdmr6546119oos.5.1699876218207; Mon, 13 Nov
 2023 03:50:18 -0800 (PST)
MIME-Version: 1.0
References: <20231101071421.29462-1-xingxing.luo@unisoc.com> <2023110105-saggy-gladiator-b3b0@gregkh>
In-Reply-To: <2023110105-saggy-gladiator-b3b0@gregkh>
From:   xingxing luo <xingxing0070.luo@gmail.com>
Date:   Mon, 13 Nov 2023 19:50:06 +0800
Message-ID: <CANnj+8TVhUgHp9SWK9zftL4J+JHfRS1GUZm4+7z4o95nB2_OyQ@mail.gmail.com>
Subject: Re: [PATCH V2] usb: musb: Check requset->buf before use to avoid
 crash issue
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Xingxing Luo <xingxing.luo@unisoc.com>, b-liu@ti.com,
        keescook@chromium.org, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev, Zhiyong.Liu@unisoc.com,
        Cixi.Geng1@unisoc.com, Orson.Zhai@unisoc.com, zhang.lyra@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 1, 2023 at 3:31=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Wed, Nov 01, 2023 at 03:14:21PM +0800, Xingxing Luo wrote:
> > When connecting USB to PC, there is a very low probability of kernel
> > crash. The reason is that in ep0_txstate(), the buf member of struct
> > usb_request used may be a null pointer. Therefore, it needs to
> > determine whether it is null before using it.
> >
> > [ 4888.071462][T597@C0] Call trace:
> > [ 4888.071467][T597@C0]  musb_default_write_fifo+0xa0/0x1ac [musb_hdrc]
> > [ 4888.087190][T597@C0]  musb_write_fifo+0x3c/0x90 [musb_hdrc]
> > [ 4888.099826][T597@C0]  ep0_txstate+0x78/0x218 [musb_hdrc]
> > [ 4888.153918][T597@C0]  musb_g_ep0_irq+0x3c4/0xe10 [musb_hdrc]
> > [ 4888.159663][T597@C0]  musb_interrupt+0xab4/0xf1c [musb_hdrc]
> > [ 4888.165391][T597@C0]  sprd_musb_interrupt+0x1e4/0x484 [musb_sprd]
> > [ 4888.171447][T597@C0]  __handle_irq_event_percpu+0xd8/0x2f8
> > [ 4888.176901][T597@C0]  handle_irq_event+0x70/0xe4
> > [ 4888.181487][T597@C0]  handle_fasteoi_irq+0x15c/0x230
> > [ 4888.186420][T597@C0]  handle_domain_irq+0x88/0xfc
> > [ 4888.191090][T597@C0]  gic_handle_irq+0x60/0x138
> > [ 4888.195591][T597@C0]  call_on_irq_stack+0x40/0x70
> > [ 4888.200263][T597@C0]  do_interrupt_handler+0x50/0xac
> > [ 4888.205196][T597@C0]  el1_interrupt+0x34/0x64
> > [ 4888.209524][T597@C0]  el1h_64_irq_handler+0x1c/0x2c
> > [ 4888.214370][T597@C0]  el1h_64_irq+0x7c/0x80
> > [ 4888.218525][T597@C0]  __check_heap_object+0x1ac/0x1fc
> > [ 4888.223544][T597@C0]  __check_object_size+0x10c/0x20c
> > [ 4888.228563][T597@C0]  simple_copy_to_iter+0x40/0x74
> > [ 4888.233410][T597@C0]  __skb_datagram_iter+0xa0/0x310
> > [ 4888.238343][T597@C0]  skb_copy_datagram_iter+0x44/0x110
> > [ 4888.243535][T597@C0]  netlink_recvmsg+0xdc/0x364
> > [ 4888.248123][T597@C0]  ____sys_recvmsg.llvm.16749613423860851707+0x35=
8/0x6c0
> > [ 4888.255045][T597@C0]  ___sys_recvmsg+0xe0/0x1dc
> > [ 4888.259544][T597@C0]  __arm64_sys_recvmsg+0xc4/0x10c
> > [ 4888.264478][T597@C0]  invoke_syscall+0x6c/0x15c
> > [ 4888.268976][T597@C0]  el0_svc_common.llvm.12373701176611417606+0xd4/=
0x120
> > [ 4888.275726][T597@C0]  do_el0_svc+0x34/0xac
> > [ 4888.279795][T597@C0]  el0_svc+0x28/0x90
> > [ 4888.283603][T597@C0]  el0t_64_sync_handler+0x88/0xec
> > [ 4888.288548][T597@C0]  el0t_64_sync+0x1b4/0x1b8
> > [ 4888.292956][T597@C0] Code: 540002c3 53027ea8 aa1303e9 71000508 (b840=
452a)
> > [ 4888.299789][T597@C0] ---[ end trace 14a301b7253e83cc ]---
> >
> > Fixes: 550a7375fe72 ("USB: Add MUSB and TUSB support")
> > Signed-off-by: Xingxing Luo <xingxing.luo@unisoc.com>
> > ---
> > v1 -> v2: - Fixed a spelling error
> >           - Add the fixed commit id
> >
> >  drivers/usb/musb/musb_gadget_ep0.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/usb/musb/musb_gadget_ep0.c b/drivers/usb/musb/musb=
_gadget_ep0.c
> > index 6d7336727388..19eb7a5e1fdc 100644
> > --- a/drivers/usb/musb/musb_gadget_ep0.c
> > +++ b/drivers/usb/musb/musb_gadget_ep0.c
> > @@ -531,6 +531,11 @@ static void ep0_txstate(struct musb *musb)
> >
> >       request =3D &req->request;
> >
> > +     if (!request->buf) {
> > +             musb_dbg(musb, "request->buf is NULL");
>
> Why is this debug line needed?
>
> > +             return;
>
> Shouldn't we be reporting an error here somehow?
>

This is a good suggestion, I will add it in the next version.

> And why has this issue never been seen before in this driver?  This is a
> very old driver, with millions, if not billions, of working systems with
> it.  What caused this to suddenly start happening?
>

This problem occurs in a special scenario and is also a very
low-probability problem.
When our machine is used as a device and connected to the computer, due to =
some
unknown reason, the USB cable is not pulled out, but the USB driver is
notified to
pull out. Out, the gadget is processing the unbind process. When the
execution is
completed, request->buf is released and points to NULL. At the same
time, since the
USB is not physically disconnected at this time, the USB will receive
an interrupt and
use ep0 for control transmission. The request->buf of ep0 used at this
time has been
used in the gadget unbind process. It is released and points to NULL,
thus using a null
pointer, causing the kernel to crash. Therefore, we think it would be
better to determine
whether it is null before using request->buf.

> thanks,
>
> greg k-h
