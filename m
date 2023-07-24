Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0FB760048
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 22:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbjGXUJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 16:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjGXUJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 16:09:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB3C10E0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 13:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690229341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kOK3VNMDEhYbwTWfQtq0KlS34ajRoQ4mypTKeCUsMYk=;
        b=TSW0nrtPR6VuO+gOQ6uoIoc7AKaM6FlWpYxeFce38FaD4txujelrq0vhRo6bW5fWbibKdG
        AmUlmge5YUUm8xBqNvgEHj0omqp7qIVzHlEE9ues9OVAZrzLt+GYVcSw4EHsFxmme4FhMZ
        ZY35fmGkXgWpO46wzsr40NbycpXo8Ag=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-DDEIwmPXPUexBd4KN3NBTQ-1; Mon, 24 Jul 2023 16:08:59 -0400
X-MC-Unique: DDEIwmPXPUexBd4KN3NBTQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-98e1085308eso200454266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 13:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690229338; x=1690834138;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kOK3VNMDEhYbwTWfQtq0KlS34ajRoQ4mypTKeCUsMYk=;
        b=IqJSbVwChPvj57b7H0ZyXr2XMX+DFs6i8RLGMo+TplWv17ODS/T37UJrK4FQYPagTu
         ek4mIogJT1gP4o3EixIisHVFHgzg04zk+qhItfN5Tuic0iZQ/thcQT5Y8mbl08bNgYiP
         xgMPhhFcbhFxsHNJqYKB2eCNPXWeOASKr0CBG5kJQ3c5j4n4AGf/zx+Zgwi6V8kurqmm
         VKZJRhU3z7uHB3QLD6GWawSxwUU5ddzqtZOHYkAjzGFQekkvNgBU2gZ+Jurg2fDTmRRd
         WNuUPmYLJZ3P35uarzfxHwD+0VWJTbuV7DoAyT0fayrIKulMQcYtbwiBMZnBzlo0spKy
         cRHQ==
X-Gm-Message-State: ABy/qLbuZ2M9ptK2xAPzmbTXrHJ4utTEmYBYdtytWohOvB6KofPN2rR8
        YzP8eXlxubRRZ1FcAoKIGEdtMDf+IQ+9tu2xu7j9ILFBUYGlpITWlaerG9QwBUHzzEcxk4nUcLV
        ukdEpfFjdDRJEvzYLu8/ntltMwNNJ99+G
X-Received: by 2002:a17:907:7842:b0:993:da0b:8783 with SMTP id lb2-20020a170907784200b00993da0b8783mr267688ejc.3.1690229337974;
        Mon, 24 Jul 2023 13:08:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGrvXhzOPkOHGgAkG8J2sNtDRwC7cMGTPcbiWhXRtw55DcqDqX8Mw31Z+/l2pn2sf19GTmPPA==
X-Received: by 2002:a17:907:7842:b0:993:da0b:8783 with SMTP id lb2-20020a170907784200b00993da0b8783mr267670ejc.3.1690229337700;
        Mon, 24 Jul 2023 13:08:57 -0700 (PDT)
Received: from redhat.com ([2.55.164.187])
        by smtp.gmail.com with ESMTPSA id lc28-20020a170906dffc00b0098e422d6758sm7145529ejc.219.2023.07.24.13.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 13:08:57 -0700 (PDT)
Date:   Mon, 24 Jul 2023 16:08:53 -0400
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
Message-ID: <20230724160836-mutt-send-email-mst@kernel.org>
References: <20230723080507.3716924-1-linma@zju.edu.cn>
 <20230723050656-mutt-send-email-mst@kernel.org>
 <729f5c17.e4079.18982192866.Coremail.linma@zju.edu.cn>
 <8ecec51.e40ad.1898226c545.Coremail.linma@zju.edu.cn>
 <20230723055820-mutt-send-email-mst@kernel.org>
 <CACGkMEuGHMu6te3jRfEhhwTrWR1mpqp3hbVhDKQiXK9tgwz3qw@mail.gmail.com>
 <56aa7d5c6d5840aedef83d3dc39f0bb3162bbb58.camel@nvidia.com>
 <20230724050005-mutt-send-email-mst@kernel.org>
 <280068e9c684f0ae644d195d3a4d3f5a1351c366.camel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <280068e9c684f0ae644d195d3a4d3f5a1351c366.camel@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 11:42:42AM +0000, Dragos Tatulea wrote:
> On Mon, 2023-07-24 at 05:16 -0400, Michael S. Tsirkin wrote:
> > On Mon, Jul 24, 2023 at 08:38:04AM +0000, Dragos Tatulea wrote:
> > > 
> > > On Mon, 2023-07-24 at 15:11 +0800, Jason Wang wrote:
> > > > On Sun, Jul 23, 2023 at 6:02 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > 
> > > > > On Sun, Jul 23, 2023 at 05:48:46PM +0800, Lin Ma wrote:
> > > > > > 
> > > > > > > Sure, that is another undergoing task I'm working on. If the nlattr
> > > > > > > is
> > > > > > > parsed with
> > > > > > > NL_VALIDATE_UNSPEC, any forgotten nlattr will be rejected, therefore
> > > > > > > (which is the default
> > > > > > > for modern nla_parse).
> > > > > > 
> > > > > > For the general netlink interface, the deciding flag should be
> > > > > > genl_ops.validate defined in
> > > > > > each ops. The default validate flag is strict, while the developer can
> > > > > > overwrite the flag
> > > > > > with GENL_DONT_VALIDATE_STRICT to ease the validation. That is to say,
> > > > > > safer code should
> > > > > > enforce NL_VALIDATE_STRICT by not overwriting the validate flag.
> > > > > > 
> > > > > > Regrads
> > > > > > Lin
> > > > > 
> > > > > 
> > > > > Oh I see.
> > > > > 
> > > > > It started here:
> > > > > 
> > > > > commit 33b347503f014ebf76257327cbc7001c6b721956
> > > > > Author: Parav Pandit <parav@nvidia.com>
> > > > > Date:   Tue Jan 5 12:32:00 2021 +0200
> > > > > 
> > > > >     vdpa: Define vdpa mgmt device, ops and a netlink interface
> > > > > 
> > > > > which did:
> > > > > 
> > > > > +               .validate = GENL_DONT_VALIDATE_STRICT |
> > > > > GENL_DONT_VALIDATE_DUMP,
> > > > > 
> > > > > 
> > > > > which was most likely just a copy paste from somewhere, right Parav?
> > > > > 
> > > > > and then everyone kept copying this around.
> > > > > 
> > > > > Parav, Eli can we drop these? There's a tiny chance of breaking
> > > > > something
> > > > > but I feel there aren't that many users outside mlx5 yet, so if you
> > > > > guys can test on mlx5 and confirm no breakage, I think we are good.
> > > > 
> > > > Adding Dragos.
> > > > 
> > > I will check. Just to make sure I understand correctly: you want me to drop
> > > the
> > > .validate flags all together in all vdpa ops and check, right?
> > > 
> > > Thanks,
> > > Dragos
> > 
> > yes - I suspect you will then need this patch to make things work.
> > 
> Yep. Adding the patch and removing the .validate config on the vdpa_nl_ops
> seems to work just fine.
> 
> Thanks,
> Dragos

OK, post a patch?

-- 
MST

