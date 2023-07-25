Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FB87606C8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 05:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjGYDkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 23:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjGYDks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 23:40:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A43F173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 20:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690256401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GISuUr8VKD3+R5zYA0JDar9R1Gto/+3V5HYVR91I9wg=;
        b=EytyoMnxQuOw+exMeOUAnX3keOv+g2Uv2TxVxywQGAwfQL2Ovw42eSel4/Yt3+e2l1UfLv
        LnKEL288dGgkfcHzzDqmTDDDC4UpLUXyla271UePPdXmPxONieByWCs+91CgEv5Igh7DDg
        Rads8xAA4Mcp2yvdYzoC+9vRQXtXM2g=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-RCv9EOMiMvyZroo6V3fgYQ-1; Mon, 24 Jul 2023 23:39:58 -0400
X-MC-Unique: RCv9EOMiMvyZroo6V3fgYQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b8405aace3so42459111fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 20:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690256397; x=1690861197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GISuUr8VKD3+R5zYA0JDar9R1Gto/+3V5HYVR91I9wg=;
        b=ZY+x3dKKbrtCJahlVyZEGLAKKG1jxWk9UkotPB74Pq1dnv9KY+MMsvgaknaYs6Ct8M
         BmQFMGahA1jK2+VjEsmezfLNrf8YfII94MDkP+H1RMpa2hQW6abjIuk1BI+EHjP+wKId
         4WnT7GnV5ak4CMq614bbpWh0+1b6k3iD19UaZa5HzD+6OVuY78EySX9MXEGxIqdaoF+q
         p/XExGOC0GaLubYnZYPWnItn0vis7aUfZLy95T1vBTdv1FPAdvnEnTocN3cccnAsCCcK
         MURZRkH9w4BbUOonF+PgNUEfEBD+wctXQ+QQUgBViqY6aXtg2mZYtIunnYR0XjhLjOiI
         D3Vw==
X-Gm-Message-State: ABy/qLZ2HeRwZu+FNE9j3K8n6OkRppMNUl7gOID8BVWk4ThkTY9tA0Zg
        /TC3awPg9UoA3fb+Qfl/GZno+oqOplDz8v+BseLrnKwPmeNQdmkZBfH9iqEw+HkZ4z8Q2nMExHA
        mRIvuksSSza/DVO0Wnz5VSjRYEeLOo26DNUOaQgZI
X-Received: by 2002:a2e:a0cc:0:b0:2b9:20fe:4bc4 with SMTP id f12-20020a2ea0cc000000b002b920fe4bc4mr6712993ljm.40.1690256397226;
        Mon, 24 Jul 2023 20:39:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFAZsBRP+Cx9Rj7r5jrD6td5p8IVRIg7B6cy0snnenBCqMo5IsS1kwAaaIV25dcC36SsUrktKHa01Fvrdsb4oo=
X-Received: by 2002:a2e:a0cc:0:b0:2b9:20fe:4bc4 with SMTP id
 f12-20020a2ea0cc000000b002b920fe4bc4mr6712982ljm.40.1690256396951; Mon, 24
 Jul 2023 20:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230724221326.384-1-andrew.kanner@gmail.com> <20230724221326.384-2-andrew.kanner@gmail.com>
In-Reply-To: <20230724221326.384-2-andrew.kanner@gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 25 Jul 2023 11:39:46 +0800
Message-ID: <CACGkMEt+LW8FBNwcn6f0cBwTOuKy+ZPy3Smg6fJgo9OrCUAOjQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers: net: prevent tun_can_build_skb() to exceed
 xdp size limits
To:     Andrew Kanner <andrew.kanner@gmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org, brouer@redhat.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 6:15=E2=80=AFAM Andrew Kanner <andrew.kanner@gmail.=
com> wrote:
>
> Tested with syzkaller repro with reduced packet size. It was
> discovered that XDP_PACKET_HEADROOM is not checked in
> tun_can_build_skb(), although pad may be incremented in
> tun_build_skb().
>
> Fixes: 7df13219d757 ("tun: reserve extra headroom only when XDP is set")
> Link: https://syzkaller.appspot.com/text?tag=3DReproC&x=3D12b2593ea80000
> Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
> ---
>  drivers/net/tun.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 18ccbbe9830a..cdf2bd85b383 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1582,7 +1582,13 @@ static void tun_rx_batched(struct tun_struct *tun,=
 struct tun_file *tfile,
>  static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *t=
file,
>                               int len, int noblock, bool zerocopy, int *s=
kb_xdp)
>  {
> -       if (SKB_DATA_ALIGN(len + TUN_RX_PAD) +
> +       int pad =3D TUN_RX_PAD;
> +       struct bpf_prog *xdp_prog =3D rcu_dereference(tun->xdp_prog);

This misses rcu read lock.

I wonder if things could be simpler if we move the limit check from
tun_can_build_skb() to tun_build_skb():

rcu_read_lock();
xdp_prog =3D rcu_dereference(tun->xdp_prog);
        if (xdp_prog)
                pad +=3D XDP_PACKET_HEADROOM;
buflen +=3D SKB_DATA_ALIGN(len + pad);
rcu_read_unlock();

Thanks

> +
> +       if (xdp_prog)
> +               pad +=3D XDP_PACKET_HEADROOM;
> +
> +       if (SKB_DATA_ALIGN(len + pad) +
>             SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) > PAGE_SIZE) {
>                 *skb_xdp =3D 0;
>                 return false;
> --
> 2.39.3
>

