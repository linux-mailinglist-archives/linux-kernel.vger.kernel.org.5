Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B836D768C08
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 08:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjGaGbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 02:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjGaGbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 02:31:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877D01BC
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 23:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690785020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9F90Lb2s6G0ugGSS8D5PR3Nu2cqZtzEuNKJh0Awsb80=;
        b=iVT8dpg0TDxtbhOmiE+agqWIezsII3xOVtBNgyTN0e3alPuwLbN+yo8ysuIUKi8nsy9D/Y
        E3ZnRhxAJWTCDjcsivKylK3s06hdnYpKNwV1IIGFYajhD5mUN/Uzs7zwKs4eqef8khxs9j
        s7i3EaCA3CeByX92RU8j5Ii6evqJzk0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-AAAIOZJxMtiDKl_zzvTPGg-1; Mon, 31 Jul 2023 02:30:18 -0400
X-MC-Unique: AAAIOZJxMtiDKl_zzvTPGg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b9c548bc66so33571991fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 23:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690785016; x=1691389816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9F90Lb2s6G0ugGSS8D5PR3Nu2cqZtzEuNKJh0Awsb80=;
        b=C9wwcLjB8jFXHFedash1CJvGzlE3rcPUsZMtg0llPxYT0xRCNbOTE9WZ8BwEW6xius
         GFn+Jgwis/B0rPhLHZL37hIItmwEGj3arK0Zgm373Zh0ALVJMXpNbbaTnSa/DjXJLAiK
         Mddrn+nt7Ba/cDCJU2BMeKH5eT68XtQ5TfQWn2GB+V2Jz3M68da3408UUc0rWrXHihXW
         OvrFj8PIRhKryC05GRwq05LL0MAXAZfk/CmckKBTvJ708l/iCSlKcS5F4ZH+NrzLL7fg
         ZTQ2ud8sUUxw0JaBY1HCITcISLcfaZedd2nVoQqQ/sap662bqIpOhXLioLCZy+ANxO5Z
         1VFA==
X-Gm-Message-State: ABy/qLY9wcPNk7rlYllYKGePrcjfrMIYi5c70si/GWIbOJetlJcrOXKH
        Z+Scyf+JwFVpfEk8lGTMsdyIiUbvz7fVNVIVnnd/YCrBbEVfFca7C1QUGQ1XiAEphjjc1NEJyKr
        12BgrI4aoYnGNUt51wwNMIGDr6Gpj8JaufE51wI2v
X-Received: by 2002:a2e:99c5:0:b0:2b9:df53:4c2a with SMTP id l5-20020a2e99c5000000b002b9df534c2amr2649455ljj.20.1690785016712;
        Sun, 30 Jul 2023 23:30:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGsf5BI9a89FmPfuA62UfQe/Gu3jAK6ZoAvqPzg14jDYGNtWJh1aM8aKl3uXlnUoU1eNeut1vEJYkKShriZjKE=
X-Received: by 2002:a2e:99c5:0:b0:2b9:df53:4c2a with SMTP id
 l5-20020a2e99c5000000b002b9df534c2amr2649436ljj.20.1690785016410; Sun, 30 Jul
 2023 23:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com>
 <CACGkMEv1B9xFE7-LrLQC3FbH6CxTZC+toHXoLHFvJWn6wgobrA@mail.gmail.com>
 <20230724025720-mutt-send-email-mst@kernel.org> <CACGkMEs7zTXk77h-v_ORhvbtQ4FgehY6w6xCfFeVTeCnzChYkw@mail.gmail.com>
 <20230725033506-mutt-send-email-mst@kernel.org> <CACGkMEuAHeA4SqFCzY2v0EFcL9J07msXgDO-jTAWVy6OXzs=hA@mail.gmail.com>
 <20230726073453-mutt-send-email-mst@kernel.org> <CACGkMEv+CYD3SqmWkay1qVaC8-FQTDpC05Y+3AkmQtJwLMLUjQ@mail.gmail.com>
 <20230727020930-mutt-send-email-mst@kernel.org> <CACGkMEuEFG-vT0xqddRAn2=V+4kayVG7NFVpB96vmecy0TLOWw@mail.gmail.com>
 <20230727054300-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230727054300-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 31 Jul 2023 14:30:04 +0800
Message-ID: <CACGkMEvbm1LmwpiOzE0mCt6YKHsDy5zYv9fdLhcKBPaPOzLmpA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Maxime Coquelin <maxime.coquelin@redhat.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

On Thu, Jul 27, 2023 at 5:46=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Jul 27, 2023 at 04:59:33PM +0800, Jason Wang wrote:
> > > They really shouldn't - any NIC that takes forever to
> > > program will create issues in the networking stack.
> >
> > Unfortunately, it's not rare as the device/cvq could be implemented
> > via firmware or software.
>
> Currently that mean one either has sane firmware with a scheduler that
> can meet deadlines, or loses ability to report errors back.
>
> > > But if they do they can always set this flag too.
> >
> > This may have false negatives and may confuse the management.
> >
> > Maybe we can extend the networking core to allow some device specific
> > configurations to be done with device specific lock without rtnl. For
> > example, split the set_channels to
> >
> > pre_set_channels
> > set_channels
> > post_set_channels
> >
> > The device specific part could be done in pre and post without a rtnl l=
ock?
> >
> > Thanks
>
>
> Would the benefit be that errors can be reported to userspace then?
> Then maybe.  I think you will have to show how this works for at least
> one card besides virtio.

Even for virtio, this seems not easy, as e.g the
virtnet_send_command() and netif_set_real_num_tx_queues() need to
appear to be atomic to the networking core.

I wonder if we can re-consider the way of a timeout here and choose a
sane value as a start.

Thanks

>
>
> --
> MST
>

