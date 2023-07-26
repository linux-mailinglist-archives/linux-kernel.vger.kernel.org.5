Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92505763597
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbjGZLtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbjGZLta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:49:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35641A8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690372066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z3mFhfUODa9AHBePAn5JuvXf3BuDvAQZgN52GslCR8I=;
        b=GARhhQkhsFuHW5WDFrzi0do6/IOcPcRfhvA6temtK8BSj0Y5+RvJ66vLIgPCbIPWHfqym2
        1i49pd3QYAKwpkBN7l2M6Xr2bA6edSDdRO6I/mGlcJ+4jdbDGmfD/GgtaF2ewJzQ6g0fti
        +UTzipA5bZ1OWvwh8ljxqv0J8I17LxE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-n49NSQHBO9ydnTvAF-obEw-1; Wed, 26 Jul 2023 07:47:43 -0400
X-MC-Unique: n49NSQHBO9ydnTvAF-obEw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b701c82e83so56533441fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690372062; x=1690976862;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z3mFhfUODa9AHBePAn5JuvXf3BuDvAQZgN52GslCR8I=;
        b=KUTyrnrcAUmn3kf1uQ56el0Wlk6VldzcUX/tw8pEZx7WaaG3K1ZiLpzO+oQL1NhCdM
         9IURGK8QMMGKVWhd+anHXiPMFKXKT3sWFNlbP5fN/5nOmN4fKx73L/Jh/C2gjs1Tl7IV
         1cEAqsGOeq7z7U432TbdrvWJM0G30OeRR93wXjHEI7Ob7H9/fWkxhWM/BB4BFWvGZlcp
         CE9D5uVBvzgxb0ja/7MXCbgYtredoRLSuP2XxutJb7viUiBKO5aLBs36q0k4CrAPmTyz
         C9136QwC8UDJIjK1VC5W54XVjJwLw32uNcj6Ei/6DvAeWSyZeuE4xC84S1K/cHXyuD2J
         2zLQ==
X-Gm-Message-State: ABy/qLbTusw2b4nnFVek5hqAx/e+IaiuqFnCb5Eze0dDnTvUSHqH9tTP
        rZ/8jZTyw4KLef34CVyVk3e69meIuAbCS8WTXko0FEM4d3aHJvcWqJHDGVmXsWjN+mmSLp41Cen
        lwjLtHC01DjLTBEAii9aSKOIx
X-Received: by 2002:a2e:9010:0:b0:2b6:df71:cff1 with SMTP id h16-20020a2e9010000000b002b6df71cff1mr1183836ljg.52.1690372061941;
        Wed, 26 Jul 2023 04:47:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGZIYBUdk56Yixlv7wviIYYWzDYfAykO70CSNJ5wRKXhKuZmsrVQQWEhJ444sYuY777oK81Vg==
X-Received: by 2002:a2e:9010:0:b0:2b6:df71:cff1 with SMTP id h16-20020a2e9010000000b002b6df71cff1mr1183817ljg.52.1690372061563;
        Wed, 26 Jul 2023 04:47:41 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:be95:2796:17af:f46c:dea1])
        by smtp.gmail.com with ESMTPSA id u23-20020a2e8557000000b002b6e13fcedcsm4149437ljj.122.2023.07.26.04.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 04:47:36 -0700 (PDT)
Date:   Wed, 26 Jul 2023 07:47:26 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "linma@zju.edu.cn" <linma@zju.edu.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eli Cohen <elic@nvidia.com>,
        "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
        Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH v1] vdpa: Complement vdpa_nl_policy for nlattr length
 check
Message-ID: <20230726074710-mutt-send-email-mst@kernel.org>
References: <20230723050656-mutt-send-email-mst@kernel.org>
 <729f5c17.e4079.18982192866.Coremail.linma@zju.edu.cn>
 <8ecec51.e40ad.1898226c545.Coremail.linma@zju.edu.cn>
 <20230723055820-mutt-send-email-mst@kernel.org>
 <CACGkMEuGHMu6te3jRfEhhwTrWR1mpqp3hbVhDKQiXK9tgwz3qw@mail.gmail.com>
 <56aa7d5c6d5840aedef83d3dc39f0bb3162bbb58.camel@nvidia.com>
 <20230724050005-mutt-send-email-mst@kernel.org>
 <280068e9c684f0ae644d195d3a4d3f5a1351c366.camel@nvidia.com>
 <20230724160836-mutt-send-email-mst@kernel.org>
 <00e14bc9e9a1f3749be62cbefc7adfaa1ba2d81c.camel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00e14bc9e9a1f3749be62cbefc7adfaa1ba2d81c.camel@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 08:26:32AM +0000, Dragos Tatulea wrote:
> On Mon, 2023-07-24 at 16:08 -0400, Michael S. Tsirkin wrote:
> > On Mon, Jul 24, 2023 at 11:42:42AM +0000, Dragos Tatulea wrote:
> > > On Mon, 2023-07-24 at 05:16 -0400, Michael S. Tsirkin wrote:
> > > > On Mon, Jul 24, 2023 at 08:38:04AM +0000, Dragos Tatulea wrote:
> > > > > 
> > > > > On Mon, 2023-07-24 at 15:11 +0800, Jason Wang wrote:
> > > > > > On Sun, Jul 23, 2023 at 6:02 PM Michael S. Tsirkin <mst@redhat.com>
> > > > > > wrote:
> > > > > > > 
> > > > > > > On Sun, Jul 23, 2023 at 05:48:46PM +0800, Lin Ma wrote:
> > > > > > > > 
> > > > > > > > > Sure, that is another undergoing task I'm working on. If the
> > > > > > > > > nlattr
> > > > > > > > > is
> > > > > > > > > parsed with
> > > > > > > > > NL_VALIDATE_UNSPEC, any forgotten nlattr will be rejected,
> > > > > > > > > therefore
> > > > > > > > > (which is the default
> > > > > > > > > for modern nla_parse).
> > > > > > > > 
> > > > > > > > For the general netlink interface, the deciding flag should be
> > > > > > > > genl_ops.validate defined in
> > > > > > > > each ops. The default validate flag is strict, while the developer
> > > > > > > > can
> > > > > > > > overwrite the flag
> > > > > > > > with GENL_DONT_VALIDATE_STRICT to ease the validation. That is to
> > > > > > > > say,
> > > > > > > > safer code should
> > > > > > > > enforce NL_VALIDATE_STRICT by not overwriting the validate flag.
> > > > > > > > 
> > > > > > > > Regrads
> > > > > > > > Lin
> > > > > > > 
> > > > > > > 
> > > > > > > Oh I see.
> > > > > > > 
> > > > > > > It started here:
> > > > > > > 
> > > > > > > commit 33b347503f014ebf76257327cbc7001c6b721956
> > > > > > > Author: Parav Pandit <parav@nvidia.com>
> > > > > > > Date:   Tue Jan 5 12:32:00 2021 +0200
> > > > > > > 
> > > > > > >     vdpa: Define vdpa mgmt device, ops and a netlink interface
> > > > > > > 
> > > > > > > which did:
> > > > > > > 
> > > > > > > +               .validate = GENL_DONT_VALIDATE_STRICT |
> > > > > > > GENL_DONT_VALIDATE_DUMP,
> > > > > > > 
> > > > > > > 
> > > > > > > which was most likely just a copy paste from somewhere, right Parav?
> > > > > > > 
> > > > > > > and then everyone kept copying this around.
> > > > > > > 
> > > > > > > Parav, Eli can we drop these? There's a tiny chance of breaking
> > > > > > > something
> > > > > > > but I feel there aren't that many users outside mlx5 yet, so if you
> > > > > > > guys can test on mlx5 and confirm no breakage, I think we are good.
> > > > > > 
> > > > > > Adding Dragos.
> > > > > > 
> > > > > I will check. Just to make sure I understand correctly: you want me to
> > > > > drop
> > > > > the
> > > > > .validate flags all together in all vdpa ops and check, right?
> > > > > 
> > > > > Thanks,
> > > > > Dragos
> > > > 
> > > > yes - I suspect you will then need this patch to make things work.
> > > > 
> > > Yep. Adding the patch and removing the .validate config on the vdpa_nl_ops
> > > seems to work just fine.
> > > 
> > > Thanks,
> > > Dragos
> > 
> > OK, post a patch?
> > 
> Sure, but how do I make it depend on this patch? Otherwise it will break things.
> 
> Thanks,
> Dragos

Send a patch series with this as patch 1/2 that one 2/2.


