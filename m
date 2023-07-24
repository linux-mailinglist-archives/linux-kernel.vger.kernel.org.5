Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2CD75EEE1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 11:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjGXJRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 05:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjGXJRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 05:17:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F8F12A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690190191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=icRPVMyvz00tO2C7RCJF1Tux1aykT12dt3mhAkPzG2Q=;
        b=SihXq1ghOuWfXab+3414j8fYBPTivasO9/EMvlkERDJRo7AMGXcnoa/j/FQSBt2GEtzM+R
        Y1zN9ej2etiTtiBqUq5Syet9RLY7ZcqfHsWYb15vElfO4ZXv6ERTACTrI8kuCqD3xq+ZFm
        ywxEaJbbsYqGgEcmdVHtJP/Cq9y7O58=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-SXOUBiIhMM-mNFsKZWIbaQ-1; Mon, 24 Jul 2023 05:16:30 -0400
X-MC-Unique: SXOUBiIhMM-mNFsKZWIbaQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fa8f8fb7b3so24822555e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690190189; x=1690794989;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=icRPVMyvz00tO2C7RCJF1Tux1aykT12dt3mhAkPzG2Q=;
        b=EeHsAk5pZa53t+iY2OmPiwNQR3EOjKouquPInLwH85Jyzdc7Yo89ouoeWQfN0UrHzm
         80lKtG5xr2vKWDHEOwkPAjRK+TEr/36tQHIHpLTzqkDY03TEoozhonrcshFlyNNlpiVg
         yNQjXaxJxUur2BRY9a0oCzVM4MuGOelNnpzDjHGY+kol0kf0tHbhwiR2WhrWG1gxDgUt
         FOWwT1vxAavUC7b25l0aCxA/apN0jCee4TSFCMIYU1Y+J+O/HVoJbu7Y7eflToXwzIpE
         k3rZtUbhqJFxgkUuLnMH7dD7YIeF/rC2quoIA75pZfnd8jnePhRAbzjTfE05Nlc96/a2
         +mDQ==
X-Gm-Message-State: ABy/qLb7rnenvFiAFYqO1MsIPqk1UVci4L0WcRrfN/ix9pN6poR5gyw8
        TVETGYgHo8gwjcvT3Vp8BCJkiSwP+Kdkf3fFsuS8sPhdD91Iwe1YNp+7GdKp6EvOGU/RA9wuF7o
        KaxWns7eQu2oSgCq+Ww77sV1e
X-Received: by 2002:a7b:c8cc:0:b0:3fb:a100:2581 with SMTP id f12-20020a7bc8cc000000b003fba1002581mr7384034wml.14.1690190189043;
        Mon, 24 Jul 2023 02:16:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEyl2PbEYyYEdIUkJYNgJkkvw8hwzDzPetupE0xaqyfvR+woA7PyBQlcGetBSagDtFB50Mn8Q==
X-Received: by 2002:a7b:c8cc:0:b0:3fb:a100:2581 with SMTP id f12-20020a7bc8cc000000b003fba1002581mr7384013wml.14.1690190188706;
        Mon, 24 Jul 2023 02:16:28 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e0:3800:a16e:b2a0:7d06:58aa])
        by smtp.gmail.com with ESMTPSA id f14-20020a7bcd0e000000b003fc01f7b415sm12536095wmj.39.2023.07.24.02.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:16:27 -0700 (PDT)
Date:   Mon, 24 Jul 2023 05:16:25 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Dragos Tatulea <dtatulea@nvidia.com>
Cc:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linma@zju.edu.cn" <linma@zju.edu.cn>, Eli Cohen <elic@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
        Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH v1] vdpa: Complement vdpa_nl_policy for nlattr length
 check
Message-ID: <20230724050005-mutt-send-email-mst@kernel.org>
References: <20230723080507.3716924-1-linma@zju.edu.cn>
 <20230723050656-mutt-send-email-mst@kernel.org>
 <729f5c17.e4079.18982192866.Coremail.linma@zju.edu.cn>
 <8ecec51.e40ad.1898226c545.Coremail.linma@zju.edu.cn>
 <20230723055820-mutt-send-email-mst@kernel.org>
 <CACGkMEuGHMu6te3jRfEhhwTrWR1mpqp3hbVhDKQiXK9tgwz3qw@mail.gmail.com>
 <56aa7d5c6d5840aedef83d3dc39f0bb3162bbb58.camel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56aa7d5c6d5840aedef83d3dc39f0bb3162bbb58.camel@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 08:38:04AM +0000, Dragos Tatulea wrote:
> 
> On Mon, 2023-07-24 at 15:11 +0800, Jason Wang wrote:
> > On Sun, Jul 23, 2023 at 6:02 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > 
> > > On Sun, Jul 23, 2023 at 05:48:46PM +0800, Lin Ma wrote:
> > > > 
> > > > > Sure, that is another undergoing task I'm working on. If the nlattr is
> > > > > parsed with
> > > > > NL_VALIDATE_UNSPEC, any forgotten nlattr will be rejected, therefore
> > > > > (which is the default
> > > > > for modern nla_parse).
> > > > 
> > > > For the general netlink interface, the deciding flag should be
> > > > genl_ops.validate defined in
> > > > each ops. The default validate flag is strict, while the developer can
> > > > overwrite the flag
> > > > with GENL_DONT_VALIDATE_STRICT to ease the validation. That is to say,
> > > > safer code should
> > > > enforce NL_VALIDATE_STRICT by not overwriting the validate flag.
> > > > 
> > > > Regrads
> > > > Lin
> > > 
> > > 
> > > Oh I see.
> > > 
> > > It started here:
> > > 
> > > commit 33b347503f014ebf76257327cbc7001c6b721956
> > > Author: Parav Pandit <parav@nvidia.com>
> > > Date:   Tue Jan 5 12:32:00 2021 +0200
> > > 
> > >     vdpa: Define vdpa mgmt device, ops and a netlink interface
> > > 
> > > which did:
> > > 
> > > +               .validate = GENL_DONT_VALIDATE_STRICT |
> > > GENL_DONT_VALIDATE_DUMP,
> > > 
> > > 
> > > which was most likely just a copy paste from somewhere, right Parav?
> > > 
> > > and then everyone kept copying this around.
> > > 
> > > Parav, Eli can we drop these? There's a tiny chance of breaking something
> > > but I feel there aren't that many users outside mlx5 yet, so if you
> > > guys can test on mlx5 and confirm no breakage, I think we are good.
> > 
> > Adding Dragos.
> > 
> I will check. Just to make sure I understand correctly: you want me to drop the
> .validate flags all together in all vdpa ops and check, right?
> 
> Thanks,
> Dragos

yes - I suspect you will then need this patch to make things work.

-- 
MST

