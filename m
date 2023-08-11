Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933D9778561
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 04:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjHKCYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 22:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjHKCYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 22:24:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963B82D55
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 19:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691720611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7D37ElFMOkv2Rqdz6YAnt7dHay6F9maPARWJ5mfivcc=;
        b=XRkelhicmqTJCQHWN27JegOXGCpaMnIC+aTrSZV3xMOiibyq2fgoVU/k/OA7+VC43QbrCs
        y88cD3YqyVLzmf8M/CtKeFm6VkKzujhmHooALYmdDh22RlczTMLC/jv8xbgW9SJnPnIeUj
        i9WmJlaU8UKWOkYK6jfOqYhSTJBfHmQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-u9U6thQ4NwmTQddOHuMyvw-1; Thu, 10 Aug 2023 22:23:30 -0400
X-MC-Unique: u9U6thQ4NwmTQddOHuMyvw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4fe0fe8dfe0so1578591e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 19:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691720607; x=1692325407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7D37ElFMOkv2Rqdz6YAnt7dHay6F9maPARWJ5mfivcc=;
        b=NHZFcpsYxrWPvdBX04sveka4/rGDDQktGafET2q/PvwyS7EubjyAgvCOcfBPYUiS2U
         G1LDiLw4eQ6VRoeBa+O7GzPo253DkQCF56GTQbSm168pxLBWtzhlE2lkBsdDKrflbTi3
         XAnAzD4uDu5S7ryjfH1rn05P+Ngq+OqCMTmv0l9J8JgYZEH1NZUms+iD5EN7q3LyWbXn
         zOneluBeI1K/FTeVgkZkW1CkXMh8Wu2FsLvxHIHbK7aBu7hQocG+xbXNZQ6GCJG4tvZX
         0qh6O8+gEjcv1Ms6KD5MZGaOEeVCdfL4GCtf6wkLvlR6eP9kCkN4Tb7dUCyP0ROYb7Yt
         Yi4A==
X-Gm-Message-State: AOJu0YyYS4Tl6Jo2wA3wx7t0LMTspzWQA1axRjGkMwiD1ScBJvVAVRud
        cV272eExvWHmwBRR+WEczPhV8xgkiI3OyzVHxjAofCIQx49gI8Ux8gyvEpYglw6XagXPqxyxzPk
        by9AFGgCYuyBgMa8cAd2oSHPoW9frGE4E/Gt8Qo7iSaf0Qxpq
X-Received: by 2002:a05:6512:304e:b0:4fe:2528:8c69 with SMTP id b14-20020a056512304e00b004fe25288c69mr1494421lfb.17.1691720607281;
        Thu, 10 Aug 2023 19:23:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9bhvRnWdFdZzH2mLHHS/f9qS8dsddE0dVWoiLOjokFCRtwhM9EwRnP5PT2q5ckgU0A6v+qiyAldx3w+fyy9Y=
X-Received: by 2002:a05:6512:304e:b0:4fe:2528:8c69 with SMTP id
 b14-20020a056512304e00b004fe25288c69mr1494412lfb.17.1691720606914; Thu, 10
 Aug 2023 19:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <CACGkMEs7zTXk77h-v_ORhvbtQ4FgehY6w6xCfFeVTeCnzChYkw@mail.gmail.com>
 <20230725033506-mutt-send-email-mst@kernel.org> <CACGkMEuAHeA4SqFCzY2v0EFcL9J07msXgDO-jTAWVy6OXzs=hA@mail.gmail.com>
 <20230726073453-mutt-send-email-mst@kernel.org> <CACGkMEv+CYD3SqmWkay1qVaC8-FQTDpC05Y+3AkmQtJwLMLUjQ@mail.gmail.com>
 <20230727020930-mutt-send-email-mst@kernel.org> <CACGkMEuEFG-vT0xqddRAn2=V+4kayVG7NFVpB96vmecy0TLOWw@mail.gmail.com>
 <20230727054300-mutt-send-email-mst@kernel.org> <CACGkMEvbm1LmwpiOzE0mCt6YKHsDy5zYv9fdLhcKBPaPOzLmpA@mail.gmail.com>
 <CACGkMEs6ambtfdS+X_9LF7yCKqmwL73yjtD_UabTcdQDFiF3XA@mail.gmail.com> <20230810153744-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230810153744-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 11 Aug 2023 10:23:15 +0800
Message-ID: <CACGkMEvVg0KFMcYoKx0ZCCEABsP4TrQCJOUqTn6oHO4Q3aEJ4w@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 3:41=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Aug 08, 2023 at 10:30:56AM +0800, Jason Wang wrote:
> > On Mon, Jul 31, 2023 at 2:30=E2=80=AFPM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Thu, Jul 27, 2023 at 5:46=E2=80=AFPM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Thu, Jul 27, 2023 at 04:59:33PM +0800, Jason Wang wrote:
> > > > > > They really shouldn't - any NIC that takes forever to
> > > > > > program will create issues in the networking stack.
> > > > >
> > > > > Unfortunately, it's not rare as the device/cvq could be implement=
ed
> > > > > via firmware or software.
> > > >
> > > > Currently that mean one either has sane firmware with a scheduler t=
hat
> > > > can meet deadlines, or loses ability to report errors back.
> > > >
> > > > > > But if they do they can always set this flag too.
> > > > >
> > > > > This may have false negatives and may confuse the management.
> > > > >
> > > > > Maybe we can extend the networking core to allow some device spec=
ific
> > > > > configurations to be done with device specific lock without rtnl.=
 For
> > > > > example, split the set_channels to
> > > > >
> > > > > pre_set_channels
> > > > > set_channels
> > > > > post_set_channels
> > > > >
> > > > > The device specific part could be done in pre and post without a =
rtnl lock?
> > > > >
> > > > > Thanks
> > > >
> > > >
> > > > Would the benefit be that errors can be reported to userspace then?
> > > > Then maybe.  I think you will have to show how this works for at le=
ast
> > > > one card besides virtio.
> > >
> > > Even for virtio, this seems not easy, as e.g the
> > > virtnet_send_command() and netif_set_real_num_tx_queues() need to
> > > appear to be atomic to the networking core.
> > >
> > > I wonder if we can re-consider the way of a timeout here and choose a
> > > sane value as a start.
> >
> > Michael, any more input on this?
> >
> > Thanks
>
> I think this is just mission creep. We are trying to fix
> vduse - let's do that for starters.
>
> Recovering from firmware timeouts is far from trivial and
> just assuming that just because it timed out it will not
> access memory is just as likely to cause memory corruption
> with worse results than an infinite spin.

Yes, this might require support not only in the driver

>
> I propose we fix this for vduse and assume hardware/firmware
> is well behaved.

One major case is the re-connection, in that case it might take
whatever longer that the kernel virito-net driver expects.

So we can have a timeout in VDUSE and trap CVQ then VDUSE can return
and fail early?

> Or maybe not well behaved firmware will
> set the flag losing error reporting ability.

This might be hard since it means not only the set but also the get is
unreliable.

Thanks

>
>
>
> > >
> > > Thanks
> > >
> > > >
> > > >
> > > > --
> > > > MST
> > > >
>

