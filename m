Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5368976EC24
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbjHCOPr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Aug 2023 10:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbjHCOPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:15:42 -0400
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3B2F5;
        Thu,  3 Aug 2023 07:15:40 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-56c9237e0ffso163727eaf.0;
        Thu, 03 Aug 2023 07:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691072140; x=1691676940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRiKMMmW2cEh5SQhqz+TDBIJiAGKEt6yCzvh8wO3g0Q=;
        b=IfUzMcDRF8vy3w/MZ69syqMOBqX6gzCN89jz/HwVCsgglMbAdEUWsa1HlEgyr0iLWS
         Y7U/aunF4vDjEe52kCwIMsWbxFUzi6P7U25vr/n3ALBWP3WStvsWVtUo9HJMSd1sLezV
         bl1eURZlLHsxiGig3TdtfSfcre2Ns8s1dcBCq1TQe5E1JzLOgG96bcD3gDfHQ794+dbA
         G79D1UXINkiLEcJfkP5KWWMWV4bZAzOC3Cq1lHFExDd0ydBqjv91Or1Zpv7ay87cP1TN
         eBKjQO2n26zsubC+mkyeVoze7SszsMOqRt02qP4gnIzIHp56lmv6AoCj/gdTJcgwd7gJ
         fpdQ==
X-Gm-Message-State: ABy/qLZ+tSIZIueHXuyT1JKc8NKVfHKyKp1lce6ngA3lrcOtt8tsjWtX
        Xut5uWDYOL7kUksOJ2KNgJtVd3hODzFIldBTwHw=
X-Google-Smtp-Source: APBJJlEjUzlnvDlpJA0bjJJrB1Phr7tRT8XoTuEBC/RX7OM90RU+G2NLk/hA31g2l3iw1O2CNpnVKwqXXMgK2DQ5VHw=
X-Received: by 2002:a05:6820:2108:b0:56c:5e21:c72d with SMTP id
 cd8-20020a056820210800b0056c5e21c72dmr13696474oob.1.1691072140128; Thu, 03
 Aug 2023 07:15:40 -0700 (PDT)
MIME-Version: 1.0
References: <13318886.uLZWGnKmhe@kreacher> <12254967.O9o76ZdvQC@kreacher>
 <4501957.LvFx2qVVIh@kreacher> <2d0315d4-35b4-84db-4dcb-c9528abad825@linaro.org>
 <CAJZ5v0iQDOsTOqWFvbf5nom-b3-pbHPRzJQC-1DM9eoh=0AKjg@mail.gmail.com>
 <eb279cf1-0605-3b87-5cb6-241a91977455@linaro.org> <CAJZ5v0i48=oawDJHoaHhiZRaO_CJokKsOHyNvu2v4PUbS6CH_Q@mail.gmail.com>
 <f8029547-6851-7e0c-00e6-4963ccbc2702@linaro.org> <CAJZ5v0gDQMNSeEU1J7ooJk4Ec=Hw_JuZAtL5k215v7Lf67iTgg@mail.gmail.com>
 <5c93d78d-835e-c740-280b-9d76456aaeda@linaro.org>
In-Reply-To: <5c93d78d-835e-c740-280b-9d76456aaeda@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 3 Aug 2023 16:15:28 +0200
Message-ID: <CAJZ5v0gtkZTwt-qP0uwvTJNx8cpO1o1esmW9BfVxB67X3Yt++w@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] thermal: core: Add mechanism for connecting trips
 with driver data
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 3:06 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 02/08/2023 18:48, Rafael J. Wysocki wrote:
>
> [ ... ]
>
> >> Let me check if I can do something on top of your series to move it in
> >> the ACPI driver.
> >
> > It doesn't need to be on top of my series, so if you have an idea,
> > please just let me know what it is.
> >
> > It can't be entirely in the ACPI driver AFAICS, though, because
> > trips[i] need to be modified on updates and they belong to the core.
> > Hence, the driver needs some help from the core to get to them.  It
> > can be something like "this is my trip tag and please give me the
> > address of the trip matching it" or similar, but it is needed, because
> > the driver has to assume that the trip indices used by it initially
> > may change.
>
> May be I'm missing something but driver_ref does not seems to be used
> except when assigning it, no?

It is used on the other side.  That is, the value assigned to the trip
field in it is accessed via trip_ref in the driver.

The idea is that the driver puts a pointer to its local struct
thermal_trip_ref into a struct thermal_trip and the core stores the
address of that struct thermal_trip in there, which allows the driver
to access the struct thermal_trip via its local struct
thermal_trip_ref going forward.

Admittedly, this is somewhat convoluted.

I have an alternative approach in the works, just for illustration
purposes if nothing else, but I have encountered a problem that I
would like to ask you about.

Namely, zone disabling is not particularly useful for preventing the
zone from being used while the trips are updated, because it has side
effects.  First, it triggers __thermal_zone_device_update() and a
netlink message every time the mode changes, which can be kind of
overcome.  But second, if the mode is "disabled", it does not actually
prevent things like __thermal_zone_get_trip() from running and the
zone lock is the only thing that can be used for that AFAICS.

So by "disabling" a thermal zone, did you mean changing its mode to
"disabled" or something else?
