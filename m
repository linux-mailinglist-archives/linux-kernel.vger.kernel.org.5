Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC027AB369
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbjIVOTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbjIVOTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:19:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AA0AB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 07:19:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F660C433CD;
        Fri, 22 Sep 2023 14:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695392341;
        bh=12oCvWbL7GVkVaF2lDVNNaYc8c3U2x/MoFyMoNfWqd4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ael4AXfQLoALna5lsccFDiscjl2lrWYJmN0RiDUJWLHpMyuex8ErISlcT9vhQIQ4+
         ghf42W8cA1Vfbf8ehlhQnId0zEIF+9DNsj/A79HZwkUr5xaSXgDihT5bE+A4YB7Bvs
         eTxhWAw70+E1aSxjiTCjphPZOmQ8R73dii5bpX2q/cNVwAgVtLQFwSkXDujD7a89xa
         K8LtBhNFyDSUxXUTHBYLmhcR21fPD8v2ndMZd7a9SY4ecXWTNJBUuwRLCGY4+wvdnm
         303HVrfn5pfrEc0KUmhp9mrFZNt4svhUT91dgJFztlsxtVbUYYSP43wi/au/wgrDVy
         QI5lrYR66etkw==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5042f391153so2656769e87.1;
        Fri, 22 Sep 2023 07:19:01 -0700 (PDT)
X-Gm-Message-State: AOJu0YxIa5o+u2Vp3412AGpcFvSxdIHpDeL+ZfZJ1SNNF8OcEOhpvug8
        dRn/Q/y+5Aid+GImfGhDM/aax2OSQY5H6ofaZA==
X-Google-Smtp-Source: AGHT+IEG+UVkd2jk9aYQtqYua03sdwlV3Cyq2FPbY/EeX2TU1i3epa418SxNV24CYkFC2r/E9vv86Hgd91/sZRSVRxg=
X-Received: by 2002:a05:6512:33d0:b0:503:224f:9c55 with SMTP id
 d16-20020a05651233d000b00503224f9c55mr1234508lfg.8.1695392339696; Fri, 22 Sep
 2023 07:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230824162654.2890992-1-andriy.shevchenko@linux.intel.com>
 <ZQn+IMMuPpwwZGPp@smile.fi.intel.com> <ZQn+UVgBTgFco6hT@smile.fi.intel.com>
In-Reply-To: <ZQn+UVgBTgFco6hT@smile.fi.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 22 Sep 2023 09:18:47 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJAjxoCctHd4Eo+Hq0SBvc0G3RaEbC4P_jPsPq0LZYHzQ@mail.gmail.com>
Message-ID: <CAL_JsqJAjxoCctHd4Eo+Hq0SBvc0G3RaEbC4P_jPsPq0LZYHzQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] amba: bus: balance firmware node reference counting
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Frank Rowand <frowand.list@gmail.com>,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 3:02=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Sep 19, 2023 at 11:01:37PM +0300, Andy Shevchenko wrote:
> > On Thu, Aug 24, 2023 at 07:26:54PM +0300, Andy Shevchenko wrote:
> > > Currently the ACPI code doesn't bump the reference count of
> > > the firmware node, while OF counter part does. Not that it's
> > > a problem right now, since ACPI doesn't really use the reference
> > > counting for firmware nodes, it still makes sense to make code
> > > robust against any changes done there. For this,
> > >  - switch ACPI case to use device_set_node() to be unified with OF
> > >  - move reference counting to amba_device_add()
> > >  - switch to use firmware nodes instead of OF ones
> > >
> > > In the result we will have reference counting done in the same module
> > > for all callers independently on the nature of firmware node behind.
> >
> > Any comment on this? I would like to have this applied so I can do some=
thing
> > similar to the platform driver code.
>
> Ah, I see, I missed LKP run on this, I'll send a v2 perhaps later on this=
 week.

What's the relationship/dependency with this and the other patches
dealing with refcounting? Did the AMBA one land?

Rob
