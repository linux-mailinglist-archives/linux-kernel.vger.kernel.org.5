Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF2379D784
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbjILR0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjILR0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:26:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B63A10E9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694539553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ITgoIWLjrCTnPogKL1G4MPNVe08xbouyawnvHOqvqwk=;
        b=TJJF+fPITJXZCBWULr9uqbAGDaypbmLdxJ2LLY4lKvEx9/zaYzvsjj85nuF+YTkqVJ+qiP
        xnmeOd0JmyGf9SiVGLUeRgyC31K0Z0eY4w5EDN1hLEeEffBa0atDbIu7CdvAINRwv6nqY3
        mrLUpJtitU1gW/aySyzoEi/kQ2yu+6o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-Z0wdmpr6OQKwK5DwWqQEqg-1; Tue, 12 Sep 2023 13:25:52 -0400
X-MC-Unique: Z0wdmpr6OQKwK5DwWqQEqg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9ad7037b0f3so42822166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694539551; x=1695144351;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ITgoIWLjrCTnPogKL1G4MPNVe08xbouyawnvHOqvqwk=;
        b=SOOBpsKP9EZmwDLvoc+Qq5UvyMZZaVIHFq/jjUJbRbfOrdAgMKGwgDZVxDwkrn+heD
         H73JK/b2QFbDLYWq612gW8CnlZ/PzWZ4AZ65AHN+0sSgqCmXtBAcZPw7NOL/XK8TA3ta
         cECM+4Z5aJlbMbkmCKbZ8Vms/hkHFnokFY3ACctuUfWKJGqJe0gz08r43GJLNhsjAaRO
         G8zWjWxjM/khJ5jnIAt0fIk9ImPhEVhloY8D2D+JSjQumDXDZjgkeU6eCTJVlLMK4Tmm
         8kZFVeRmNaCB0yuLLOQDR0GSdJz4NEK7J/H+J0zlGOsdMU5LIvubzAXbvpYvpUUFwrOw
         EaJQ==
X-Gm-Message-State: AOJu0Ywjc1OT3JxBpfg/94+TQxXcHbRxPZxofg2P0RxaUmFxxH4Shxc8
        X05JX+le7iTcIJMJeBTKIo2xfKgRfLEL8pU4kWZj/hwieYXkf6+QiV71DGaTIAGp42Fyp9bUrsJ
        uk7eJkUgeez0d+vHQor+Z8gkR
X-Received: by 2002:a17:907:7817:b0:9a9:f7c3:c178 with SMTP id la23-20020a170907781700b009a9f7c3c178mr9063586ejc.7.1694539550889;
        Tue, 12 Sep 2023 10:25:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjWsSi4r6zPsRAGz2JlJmvUW1iHKo5jRoGzLpuhxy30ingNuuICP4j4pOrh1ukiGFoBi/ABw==
X-Received: by 2002:a17:907:7817:b0:9a9:f7c3:c178 with SMTP id la23-20020a170907781700b009a9f7c3c178mr9063576ejc.7.1694539550493;
        Tue, 12 Sep 2023 10:25:50 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-249-231.dyn.eolo.it. [146.241.249.231])
        by smtp.gmail.com with ESMTPSA id gs9-20020a170906f18900b0099bd5d28dc4sm7186063ejb.195.2023.09.12.10.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 10:25:50 -0700 (PDT)
Message-ID: <32a8715a63b686aa0ac19fdae22b5d605d47ae35.camel@redhat.com>
Subject: Re: [PATCH net-next v1 2/2] net: core: Sort headers alphabetically
From:   Paolo Abeni <pabeni@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Date:   Tue, 12 Sep 2023 19:25:48 +0200
In-Reply-To: <ZQCaMHBHp/Ha29ao@smile.fi.intel.com>
References: <20230911154534.4174265-1-andriy.shevchenko@linux.intel.com>
         <20230911154534.4174265-2-andriy.shevchenko@linux.intel.com>
         <20230912152031.GI401982@kernel.org> <ZQCTXkZcJLvzNL4F@smile.fi.intel.com>
         <20f57b1309b6df60b08ce71f2d7711fa3d6b6b44.camel@redhat.com>
         <ZQCaMHBHp/Ha29ao@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-09-12 at 20:04 +0300, Andy Shevchenko wrote:
> On Tue, Sep 12, 2023 at 06:53:23PM +0200, Paolo Abeni wrote:
> > On Tue, 2023-09-12 at 19:35 +0300, Andy Shevchenko wrote:
> > > On Tue, Sep 12, 2023 at 05:20:31PM +0200, Simon Horman wrote:
> > > > On Mon, Sep 11, 2023 at 06:45:34PM +0300, Andy Shevchenko wrote:
> > > > > It's rather a gigantic list of heards that is very hard to follow=
.
> > > > > Sorting helps to see what's already included and what's not.
> > > > > It improves a maintainability in a long term.
> > > > >=20
> > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com=
>
> > > >=20
> > > > Hi Andy,
> > > >=20
> > > > At the risk of bike shedding, the sort function of Vim, when operat=
ing
> > > > with the C locale, gives a slightly different order, as experssed b=
y
> > > > this incremental diff.
> > > >=20
> > > > I have no objections to your oder, but I'm slightly curious as
> > > > to how it came about.
> > >=20
> > > !sort which is external command.
> > >=20
> > > $ locale -k LC_COLLATE
> > > collate-nrules=3D4
> > > collate-rulesets=3D""
> > > collate-symb-hash-sizemb=3D1303
> > > collate-codeset=3D"UTF-8"
> >=20
> > I'm unsure this change is worthy. It will make any later fix touching
> > the header list more difficult to backport, and I don't see a great
> > direct advantage.
>=20
> As Rasmus put it here
> https://lore.kernel.org/lkml/5eca0ab5-84be-2d8f-e0b3-c9fdfa961826@rasmusv=
illemoes.dk/
> In short term you can argue that it's not beneficial, but in long term it=
's given
> less conflicts.
>=20
> > Please repost the first patch standalone.
>=20
> Why to repost, what did I miss? It's available via lore, just run
>=20
>   b4 am -slt -P _ 20230911154534.4174265-1-andriy.shevchenko@linux.intel.=
com
>=20
> to get it :-)

It's fairly better if actions (changes) on patches are taken by the
submitter: it scales way better, and if the other path take places we
can be easily flooded with small (but likely increasingly less smaller)
requests that will soon prevent any other activity from being taken.

Please, repost the single patch, it would be easier to me.

Thanks!

Paolo

