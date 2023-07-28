Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29747766171
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 03:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjG1BnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 21:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbjG1Bmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 21:42:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C992701
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 18:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690508534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+B8/dh9FxUlYlsfj6c2Az3RVvE6Mk5Zpo699JVAL0Us=;
        b=UCrkxbwTTj/NOaU+mujwbU4bv7w4azAAj/C59hBh27WyxcysgBHUHSyRfaLsD3OuoIZwwH
        WSc6nro4Z7msCDddyTazjNwrr2lXBpgsMi/nevq+AfnBNHr9UqQ0HMt40nudfm1fg9RIQ4
        AQU8Qm2qNYQShi4eKJ0VtgU+lskOwhM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-zRbB6d3gNBK4tyqJlwo3qg-1; Thu, 27 Jul 2023 21:42:12 -0400
X-MC-Unique: zRbB6d3gNBK4tyqJlwo3qg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4fe08e088d5so1400362e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 18:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690508531; x=1691113331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+B8/dh9FxUlYlsfj6c2Az3RVvE6Mk5Zpo699JVAL0Us=;
        b=RQBzMeNxMCpqkTvidU5IOcYrd7aqhQEAGSf9wt3kTQbmykZn47Bv5kwt3kL1fgp7G4
         +QgBBt3UWG7A1SYy/c4FQ5k4uT4Hr61IEUxt13nMvHZmLFdSigf40iHrP8nrvl99iZMd
         mYTtlA1LIT/W51OQwJL+aMx9L1F0QHFX7gK/60XZe0mVKkBMlTVAt7RI5NiYvuXRuBvk
         mkBII5Hj9jLzv80IVtkZHRVa/+xnylCdRzpllDd56eT8dAb00ntYrbLe+3/Qvuhusr7J
         O25LlftNoDFo4MV3hzWnwTLrMdrVW7kJgNzZ3fDkUmOMvgr/UHL6uBTGOfSX6HZrTFnl
         KFXg==
X-Gm-Message-State: ABy/qLZ0oeHqiiAI84XcvVxH+6eqQF3B4oI92jZWYPhvI36VFmknsc1N
        futjXFxbbSdfJSpgX/Ytz1XNtLuzkZQ+PeewG+p8yoBmooRsiQEqkDz7hxwm+qVO7sJ3NYZqXe/
        eK6LSEPacRYZid7lOewa0wKnGiwefs768mpFEVrjQ
X-Received: by 2002:a05:6512:1591:b0:4fb:893e:8ffc with SMTP id bp17-20020a056512159100b004fb893e8ffcmr676871lfb.17.1690508531484;
        Thu, 27 Jul 2023 18:42:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHY6/ERBGZV6AEAlBJS5xI4dIRaHz1bMCv6qrVkYLdcfZ1S0GvRrifqu9u3Yc1vreyW0L0NNEbcznbuvGQrl6o=
X-Received: by 2002:a05:6512:1591:b0:4fb:893e:8ffc with SMTP id
 bp17-20020a056512159100b004fb893e8ffcmr676854lfb.17.1690508531188; Thu, 27
 Jul 2023 18:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230725130709.58207-1-gavinl@nvidia.com> <20230725130709.58207-3-gavinl@nvidia.com>
 <f5823996fffad2f3c1862917772c182df74c74e7.camel@redhat.com>
In-Reply-To: <f5823996fffad2f3c1862917772c182df74c74e7.camel@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 28 Jul 2023 09:42:00 +0800
Message-ID: <CACGkMEs4wUh0TydcXSMR2GdBSTk+H-Tkbhn53BywEeiK9cA9Gg@mail.gmail.com>
Subject: Re: [PATCH net-next V4 2/3] virtio_net: support per queue interrupt
 coalesce command
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Gavin Li <gavinl@nvidia.com>, mst@redhat.com,
        xuanzhuo@linux.alibaba.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
        jiri@nvidia.com, dtatulea@nvidia.com, gavi@nvidia.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Heng Qi <hengqi@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 9:28=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Tue, 2023-07-25 at 16:07 +0300, Gavin Li wrote:
> > Add interrupt_coalesce config in send_queue and receive_queue to cache =
user
> > config.
> >
> > Send per virtqueue interrupt moderation config to underlying device in
> > order to have more efficient interrupt moderation and cpu utilization o=
f
> > guest VM.
> >
> > Additionally, address all the VQs when updating the global configuratio=
n,
> > as now the individual VQs configuration can diverge from the global
> > configuration.
> >
> > Signed-off-by: Gavin Li <gavinl@nvidia.com>
> > Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> > Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> FTR, this patch is significantly different from the version previously
> acked/reviewed, I'm unsure if all the reviewers are ok with the new
> one.

Good point, and I plan to review this no later than next Monday and
offer my ack if necessary. Please hold this series now.

Thanks

>
> [...]
>
> >  static int virtnet_set_coalesce(struct net_device *dev,
> >                               struct ethtool_coalesce *ec,
> >                               struct kernel_ethtool_coalesce *kernel_co=
al,
> >                               struct netlink_ext_ack *extack)
> >  {
> >       struct virtnet_info *vi =3D netdev_priv(dev);
> > -     int ret, i, napi_weight;
> > +     int ret, queue_number, napi_weight;
> >       bool update_napi =3D false;
> >
> >       /* Can't change NAPI weight if the link is up */
> >       napi_weight =3D ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : =
0;
> > -     if (napi_weight ^ vi->sq[0].napi.weight) {
> > -             if (dev->flags & IFF_UP)
> > -                     return -EBUSY;
> > -             else
> > -                     update_napi =3D true;
> > +     for (queue_number =3D 0; queue_number < vi->max_queue_pairs; queu=
e_number++) {
> > +             ret =3D virtnet_should_update_vq_weight(dev->flags, napi_=
weight,
> > +                                                   vi->sq[queue_number=
].napi.weight,
> > +                                                   &update_napi);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             if (update_napi) {
> > +                     /* All queues that belong to [queue_number, queue=
_count] will be
> > +                      * updated for the sake of simplicity, which migh=
t not be necessary
>
> It looks like the comment above still refers to the old code. Should
> be:
>         [queue_number, vi->max_queue_pairs]
>
> Otherwise LGTM, thanks!
>
> Paolo
>

