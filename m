Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3789E7C7504
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379592AbjJLRoQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Oct 2023 13:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344050AbjJLRoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:44:14 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27491C9;
        Thu, 12 Oct 2023 10:44:13 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-57ddba5ba84so133367eaf.0;
        Thu, 12 Oct 2023 10:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697132652; x=1697737452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pe7bpLJT3uvTuZB09KxlybQ/Xw31ItduIV6kQwN3xO4=;
        b=VQswEwKWNUlZSkEKh00OKM3ZYfk5bgn2keF0F4k5tOFEQC/JPOkkh10A7qIKkR2gFP
         haGNsw/swUypTQ+e8kJEXnPxbVAxD1LCFf6UxjNAldYzg0xcVrFtodTpMtO9ELyw7FvF
         LtXVuEth5IXymvreOWqnq3E66GgpbLkdfr0f5EKAD5VHAYDfqXsZnhTCTO1p99YGjck8
         nSwulXneOLyjP9wcnwF4Ilmu87m9BiY5ZYCVvFO6Vsssxwlf5nFILTLBdFSxsvILQtv2
         79SQXBmziYH9EO9r76cavfuC8gP6TLxu/uUov5Lh7IeZ71R/tVm4Fj+Pc1tUUQ1SS28F
         fR9A==
X-Gm-Message-State: AOJu0YyyF/zb1L0Y6FTRYyo/INzdqX7mv0ccoLNeWTxTpoWtD2axZ5ki
        52pvFD8C0rTc3XTc2obotEv0G2qyJAOlCDdEdMs=
X-Google-Smtp-Source: AGHT+IGlh8ZNkVDw3rsaT4gXeZ10Ykb1ZWW62xdRl0XywCfW3u729x88z0FDpJ/m29/7Vgx6qeThdP3okBG4epcI/eA=
X-Received: by 2002:a05:6820:390:b0:57c:6e35:251e with SMTP id
 r16-20020a056820039000b0057c6e35251emr23653110ooj.1.1697132652457; Thu, 12
 Oct 2023 10:44:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231012102700.2858952-1-daniel.lezcano@linaro.org>
 <a6b51de7-4f56-4db9-a7dd-60555ac6c37f@arm.com> <d9f3bd7b-a5db-4d37-bb1f-f97e40c8a63a@linaro.org>
In-Reply-To: <d9f3bd7b-a5db-4d37-bb1f-f97e40c8a63a@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 Oct 2023 19:44:01 +0200
Message-ID: <CAJZ5v0gC4+Jam0a4KpEr7onydn8Sp8MkN2yzVxm0W9qDpmEoDw@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal/core: Hardening the self-encapsulation
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>, rafael@kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 3:14 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Lukasz,
>
> On 12/10/2023 14:01, Lukasz Luba wrote:
> > Hi Daniel,
> >
> > On 10/12/23 11:26, Daniel Lezcano wrote:
> >> The thermal private header has leaked all around the drivers which
> >> interacted with the core internals. The thermal zone structure which
> >> was part of the exported header led also to a leakage of the fields
> >> into the different drivers, making very difficult to improve the core
> >> code without having to change the drivers.
> >>
> >> Now we mostly fixed how the thermal drivers were interacting with the
> >> thermal zones (actually fixed how they should not interact). The
> >> thermal zone structure will be moved to the private thermal core
> >> header. This header has been removed from the different drivers and
> >> must belong to the core code only. In order to prevent this private
> >> header to be included again in the drivers, make explicit only the
> >> core code can include this header by defining a THERMAL_CORE_SUBSYS
> >> macro. The private header will contain a check against this macro.
> >>
> >> The Tegra SoCtherm driver needs to access thermal_core.h to have the
> >> get_thermal_instance() function definition. It is the only one
> >> remaining driver which need to access the thermal_core.h header, so
> >> the check will emit a warning at compilation time.
> >>
> >> Thierry Reding is reworking the driver to get rid of this function [1]
> >> and thus when the changes will be merged, the compilation warning will
> >> be converted to a compilation error, closing definitively the door to
> >> the drivers willing to play with the thermal zone device internals.
> >
> > That looks like a good idea. Although, shouldn't we avoid the
> > compilation warnings and just first merge the fixes for drivers?
>
> Yes, we should but there is the series for nvidia (pointed in the
> changelog) which need a slight refresh for the bindings AFAIR. That
> series is since March 2023 and Thierry seems busy [1]. I'm holding the
> hardening since then.
>
> So I don't know how to make progress on this? I was assuming we can
> merge this series and let the compiler recall what has to be fixed.
>
> [1] https://lore.kernel.org/all/ZK14edZUih1kH_sZ@orome/
>
> and as soon as it is fixed, we convert the WARNING to ERROR :P

To be honest, I'm not sure if anything needs to be done along the
lines of this patch right now or even at all.

The only concern here would be that some new drivers would include
thermal_core.h while we were waiting for the remaining existing
abusers to be fixed, but since this hasn't happened for the last 6
months, I'm not worried.

It would be good to add a notice to thermal_core.h that this file is
for internal use in the thermal core only, though.
