Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DD27F06E2
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 15:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjKSOew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 09:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjKSOeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 09:34:50 -0500
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F6DBA;
        Sun, 19 Nov 2023 06:34:47 -0800 (PST)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5845213c583so2007482eaf.0;
        Sun, 19 Nov 2023 06:34:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700404487; x=1701009287;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wbAOew7EQhvdTMrxu7VzSwL0APRrGG2LAuJjAHyG3Ic=;
        b=lMHTbeIY3keviR+eGP7t/elfJXZo1af0Fe+0LhKk/NDFBV2f9uY8Q/mjU/h3wLrwBM
         vFQC+5krCaiIKKp6QKREGlLewVS2whA90Ia9UWFwKW7bm2oPNauEnzVBea5QNa1mL9Pk
         11w0OJHf5CxlrYcBz2kIayHKVcMYSUM0XhhGyv4YxHvbIXSdQnq2VcGOIx6KcxMzOCAd
         NQ/KHqIHWOeaiT4EcW6ZuJ0NNSjhalYQ7ydT4vcGMUchfXdFSjQ/4E9nimBzzIVcdhn6
         PT2UaD5LcCSHqEXQbEScfXjplqylU0AYPfaHKYns1KnKRnX0YwEZwoeMEJs9KNmQWv6+
         Q2qA==
X-Gm-Message-State: AOJu0YxDuZq7pJGqQ+U3jAMysBxKfPv0QmXKJ1TYSi8V4Z/7O/lJhpds
        UNzvGMOquSlMbqxmidlKmg==
X-Google-Smtp-Source: AGHT+IFb+T9RykUaRT49skiYcMHAWrA0Yrdg/vQdhUJcpftXjvADNdhiMeRf/RUyq/2tEoqOp1kpfg==
X-Received: by 2002:a05:6820:2290:b0:57b:3b48:6f11 with SMTP id ck16-20020a056820229000b0057b3b486f11mr5163096oob.4.1700404486826;
        Sun, 19 Nov 2023 06:34:46 -0800 (PST)
Received: from herring.priv ([2607:fb90:45e3:889f:15b4:1348:6d64:224b])
        by smtp.gmail.com with ESMTPSA id w18-20020a4ae4d2000000b00581fc1af0a7sm1055669oov.28.2023.11.19.06.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 06:34:45 -0800 (PST)
Received: (nullmailer pid 173773 invoked by uid 1000);
        Sun, 19 Nov 2023 14:34:41 -0000
Date:   Sun, 19 Nov 2023 08:34:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        andriy.shevchenko@linux.intel.com, Jiri Kosina <jikos@kernel.org>,
        linus.walleij@linaro.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        james.clark@arm.com, james@equiv.tech, keescook@chromium.org,
        petr.tesarik.ext@huawei.com, rafael@kernel.org, tglx@linutronix.de,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: Re: [RFC PATCH v2 0/7] of: Introduce hardware prober driver
Message-ID: <20231119143441.GA157654-robh@kernel.org>
References: <20231109100606.1245545-1-wenst@chromium.org>
 <859ac058-c50a-4eb8-99b6-3011ef4e7529@collabora.com>
 <CAL_JsqK64w3+r_LJZoh50PzAUcsvH6ahSDCqgSiKrD3LBAXE9g@mail.gmail.com>
 <CAD=FV=VUZy9DaZgKafSpXXopD5k8ExGSR97BjAqC5tupPoxNfQ@mail.gmail.com>
 <CAL_Jsq+puq20EWkQg1RTs2zfmh4DGbqz1krp+19c=wPXnLT5dA@mail.gmail.com>
 <CAD=FV=X-17COQ2-tycV1bSuCrGy7MJ88Un8nA-a-ODexvgi9TQ@mail.gmail.com>
 <CAL_JsqKR_YD6hm4Lv+OuCKms8Ha61BZRKUuiLYPgSkz3_3NCFA@mail.gmail.com>
 <CAD=FV=XO5VNuaVKwBHLQC1ukdpHQO0-XTaKnRM=rigbcdOytgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XO5VNuaVKwBHLQC1ukdpHQO0-XTaKnRM=rigbcdOytgQ@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 05:13:50PM -0500, Doug Anderson wrote:
> Hi,
> 
> On Wed, Nov 15, 2023 at 4:35 PM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Wed, Nov 15, 2023 at 2:45 PM Doug Anderson <dianders@chromium.org> wrote:
> > >
> > > Hi,
> > >
> > > On Wed, Nov 15, 2023 at 2:28 PM Rob Herring <robh+dt@kernel.org> wrote:
> > > >
> > > > > So if we're searching the whole device tree for "failed-needs-probe"
> > > > > then we need to figure out which devices are related to each other. If
> > > > > a given board has second sources for MIPI panels, touchscreens, and
> > > > > trackpads then we need to know which of the "failed-needs-probe"
> > > > > devices are trackpads, which are touchscreens, and which are MIPI
> > > > > panels. Do you have any suggestions for how we should do that? Maybe
> > > > > it was in some other thread that I missed? I guess we could have a
> > > > > board-specific table mapping (compatible + node name + reg) to a
> > > > > class, but that feels awkward.
> > > >
> > > > Node name is supposed to correspond to device class, so why not use
> > > > that (no path or unit-address.) and nothing else (well, besides
> > > > "status")?
> > >
> > > One problem is that I could imagine having two second source trackpads
> > > that both have the same i2c address. That would give them the same
> > > name, right? I guess you could maybe come up with some sort of suffix
> > > rule? Like
> > >
> > > trackpad-1@10 {
> > >   compatible = "elan,blah";
> > >   ret = <0x10>;
> > >   status = "failed-needs-probe";
> > >   ...
> > > }
> > > trackpad-2@10 {
> > >   compatible = "goodix,gt7375p";
> > >   ret = <0x10>;
> > >   status = "failed-needs-probe";
> > >   ...
> > > }
> > >
> > > Then I guess the class would be "trackpad"?
> >
> > That issue is somewhat orthogonal because it is not following the spec.
> 
> I'm not sure why you say it's orthogonal. The whole reason why we get
> into the situation above is that we could have two devices, only one
> of which is present (hence the status of "failed-needs-probe"), that
> are the same type and have the same "reg" address.

I just mean that defining a node name for 2 devices of the same class 
and at same address is separate problem from selecting which one to 
enable.

> 
> Essentially the whole "failed-needs-probe" is extending the spec,
> right? While extending the spec, we also need to talk about what to do
> if some of the devices that we need to probe have the same class and
> the same "reg".
> 
> 
> > I'm not sure mixing the 2 styles of node names is a good idea. While
> > not used too much, matching by node name does ignore the unit-address,
> > but I'm not sure we could ignore a '-N'.
> >
> > I think our options are either add something to the unit-address or
> > use i2c-mux binding. Adding to the unit-address is not unprecedented.
> > I did that for some of the register bit level bindings where you have
> > a node for different bits at the same address. The downside is
> > unit-address is bus specific, so we'd have to add that for multiple
> > buses. For the i2c-mux, it's perhaps a bit complex and I'm not sure
> > what if anything you'd have to do to manage the mux that's not really
> > there.
> 
> Somehow it feels weird to use an i2c-mux because there's no real mux
> present, right? ...so this would be a virtual (bogus) device that
> doesn't really exist in hardware.

Yes, shrug... 


> ...though I guess if the "mux" type binding is OK then maybe we just
> use that as the HW prober, at least for i2c devices...

Except for any other case where it's different addresses or different 
buses. Maybe different addresses could still use the same thing. I 
suppose the same class of device is unlikely to be on a different bus.

An extension to the unit-address would be the simpler solution, so we 
should explore that first I think.

Rob
