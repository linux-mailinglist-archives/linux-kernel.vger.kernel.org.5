Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5F28002F7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 06:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377364AbjLAFUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 00:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjLAFUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 00:20:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B7510FA
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 21:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701408028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X88JSiziG/o7myWzNFddeB9QrNNoNgpJlb1gQar3PoQ=;
        b=hTF7kSho2PW7k/yLjqQzIZgVJ5SG6AlneOXtkZAwTWsY9Yybl6GwJ6X/r1ICGLKGEi4GFB
        1sFizwwy/MIAV0m7Ss0QzZ6svkRyvrakmJFBsnKf/XI2iifs0/T4wm90tzwYfkA1wJXipS
        i9S+EHwLi6LMEfr1nAng8jQiRGTw+FI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-WpZprg2PPPS0JKopCQH_9Q-1; Fri, 01 Dec 2023 00:20:26 -0500
X-MC-Unique: WpZprg2PPPS0JKopCQH_9Q-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50bc6704477so1671466e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 21:20:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701408025; x=1702012825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X88JSiziG/o7myWzNFddeB9QrNNoNgpJlb1gQar3PoQ=;
        b=bx+g3ZFeCEMnKUwcuGAhR59mTih6v5rserftNj3lpK6FLRj2EoHFK3aFB7U1RxPrKS
         +oYQTvRM6VALktft24BtdffpRg3Q3DiIFb9JdcXjguZTBm1I6wFZj07t7DjhJukGJtxD
         lFqe69c9TGY4ngQP8MZGzqf7mfeu/Dnfy3cr7Qlp9vj253kHCfEJ4DK936bfW9IEi39r
         fgfBfckKTwwmgcPlTKsKkN3yrPMNOCHmWGsASZm4rPCV4gGyuYHBKoORI8iJ7ZEj0kiB
         vbQGo/xZzf7dSistke7snPrSZO3H4jPz41M1zsy+r2pBLd5agNMuCbWdQySJQObri6l0
         2rzw==
X-Gm-Message-State: AOJu0YwSB2hr8o/iU+nB2XDBYsxsGwRXWkx+ZGxMt5i4V+C6QOyQ2/el
        zWlG6rCzxAQUqveLFDyLuqxkdFgKFdgZwQzmQ5cWcNoXuMNMtIHDlui9Lt+KsG9TPSNMz1kx4Jp
        9KJuhNDVEc82xLzZkwf8AXR5tIYrR1mglXUBbHK7M
X-Received: by 2002:a19:a408:0:b0:50b:c9b6:3216 with SMTP id q8-20020a19a408000000b0050bc9b63216mr343634lfc.8.1701408025513;
        Thu, 30 Nov 2023 21:20:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESdjRg/qOdpcOoc9ha3XIN7XwU3jvK2LnYcltjH/CQeP85eYFX50MTqViiFNs+mh7TXHCkLsXficufvdwpKuo=
X-Received: by 2002:a19:a408:0:b0:50b:c9b6:3216 with SMTP id
 q8-20020a19a408000000b0050bc9b63216mr343629lfc.8.1701408025249; Thu, 30 Nov
 2023 21:20:25 -0800 (PST)
MIME-Version: 1.0
References: <20231130113001.29154-1-jirislaby@kernel.org>
In-Reply-To: <20231130113001.29154-1-jirislaby@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 1 Dec 2023 13:20:14 +0800
Message-ID: <CACGkMEtc962wXcFP7kQFcyxRqqyXAF55kpZwv-tQbcCWuOHGTw@mail.gmail.com>
Subject: Re: [PATCH] tty: virtio: drop virtio_cons_early_init()
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, Amit Shah <amit@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        linux-alpha@vger.kernel.org, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 7:31=E2=80=AFPM Jiri Slaby (SUSE) <jirislaby@kernel=
.org> wrote:
>
> The last user of virtio_cons_early_init() was dropped in commit
> 7fb2b2d51244 ("s390/virtio: remove the old KVM virtio transport").
>
> So now, drop virtio_cons_early_init() and the logic and headers behind
> too.
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: Amit Shah <amit@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Cc: linux-alpha@vger.kernel.org
> Cc: virtualization@lists.linux.dev
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

