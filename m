Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CE67DB1DA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 02:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjJ3Bwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 21:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjJ3Bwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 21:52:37 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1091DBF;
        Sun, 29 Oct 2023 18:52:35 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6ce2d4567caso2672613a34.2;
        Sun, 29 Oct 2023 18:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698630754; x=1699235554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJ+pIWIK5pOKr5v7Th3ehIjIup5GsTCljwwiL98MF64=;
        b=h8nN7NrHUIeb+RwKD+pAw6dMGmv/YPhIoQR+aDDpfIu+hvd0x4hc4AlW25mdcnJHfF
         YwDyrbcpaDMhpQL/utgRQ7Wz73xlTCnOLigy6W6tS9a5827YAtV2NIlHQ3vC9lWrWKpZ
         ZX724qR5SMcBWhF7O0ZIkWam+PjMEyB7Be5irVVayR0qxjUsYOzaiNI8noSduS8qcP5s
         UZk0jAruhcLUWMRDHk6uNNwze4gNWCN2iZ9gdyiTzAA5wy4c67MNgEOOj7rB3cCIh1kE
         ilg2qO5aisohIefqyJuv61PoaIqU+6p330SL/8DkplGLoVRIBAKx5cZT7ErEkfhdBhNS
         f0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698630754; x=1699235554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJ+pIWIK5pOKr5v7Th3ehIjIup5GsTCljwwiL98MF64=;
        b=xPEn4EgL8umyVINUf+DextiD/WETDEm3avwcvUgL0PAzjwov5i11GmvYw3NhzzWIQD
         RowwPLnJ1VS0CejLewtI3gma+RpSfafnVyxs9mYAw7e/alau0lNdpe3LkeL0BQnR3AM1
         Cm24+DOswrZeobsvbmtOXKNnKKrwcpJw3Tz6lvaxACYDDBhDN+PQMMKNKHJqaZOqfPUx
         BTpOtlA8fNkGKnwqGKoMlgjzm5BU8owEF4OpyuGm+z9oT2UtLu/nGIf5G3IDia6U9mkj
         w2zyCWMpPwFW8KGbu36YUPyXAE2NKPfr2ukHtwtktWaSPJ2acclW/8l4LhoaU5ixb3FV
         I/Hw==
X-Gm-Message-State: AOJu0Yy+f/+h39pljf6rzl1mHRQEy9YOGRVjghlZ1T/sdUXXTL/ZApfQ
        LZ7uD1kKhVFdYic7obvs83RtgWrqgLT1Ft2VE5v2MNUVWrLPNQ==
X-Google-Smtp-Source: AGHT+IGOxAwPaVwOBP/Wap5IdwrcWWEJS4GXQ0wRZqb24RIPJmCnkv6adRSjpinw61qITu6EW6YpIualSnps/Zd9aYA=
X-Received: by 2002:a05:6830:43a7:b0:6b7:30cc:6419 with SMTP id
 s39-20020a05683043a700b006b730cc6419mr10720384otv.1.1698630754290; Sun, 29
 Oct 2023 18:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231023093153.6748-1-xingxing.luo@unisoc.com> <2023102742-barmaid-doorframe-3731@gregkh>
In-Reply-To: <2023102742-barmaid-doorframe-3731@gregkh>
From:   xingxing luo <xingxing0070.luo@gmail.com>
Date:   Mon, 30 Oct 2023 09:52:22 +0800
Message-ID: <CANnj+8Q1-5OX1BOM_12zA2v7D38y8rJctXn2_ja71P6UkzEyfw@mail.gmail.com>
Subject: Re: [PATCH] usb: musb: Check requset->buf before use to avoid crash issue
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 6:54=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Oct 23, 2023 at 05:31:53PM +0800, Xingxing Luo wrote:
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
> > Signed-off-by: Xingxing Luo <xingxing.luo@unisoc.com>
> > ---
> >  drivers/usb/musb/musb_gadget_ep0.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/usb/musb/musb_gadget_ep0.c b/drivers/usb/musb/musb=
_gadget_ep0.c
> > index 6d7336727388..5d0629866128 100644
> > --- a/drivers/usb/musb/musb_gadget_ep0.c
> > +++ b/drivers/usb/musb/musb_gadget_ep0.c
> > @@ -531,6 +531,11 @@ static void ep0_txstate(struct musb *musb)
> >
> >       request =3D &req->request;
> >
> > +     if (!requset->buf) {
> > +             musb_dbg(musb, "request->buf is NULL");
> > +             return;
> > +     }
> > +
> >       /* load the data */
> >       fifo_src =3D (u8 *) request->buf + request->actual;
> >       fifo_count =3D min((unsigned) MUSB_EP0_FIFOSIZE,
> > --
> > 2.17.1
>
> This patch does not even build, how did you test it?
>

I have verified this patch on our platform, which is unisoc, and it
can fix the kernel crash problem. However, it seems that there is a
spelling error in this patch, I will fix it in the next version.

> And what commit id does this fix?

commit id: 550a7375fe720924241f0eb76e4a5c1a3eb8c32f

>
> thanks,
>
> greg k-h
