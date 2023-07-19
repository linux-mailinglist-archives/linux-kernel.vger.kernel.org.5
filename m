Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499A07596F1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjGSNeG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 19 Jul 2023 09:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjGSNeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:34:05 -0400
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45083113;
        Wed, 19 Jul 2023 06:34:04 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2b951a1a03bso6194601fa.0;
        Wed, 19 Jul 2023 06:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689773642; x=1692365642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ch5QBOhh4FZKc92//FFcj4rG6CE12dmRlZdD1fLxA40=;
        b=L07nUKD+/ml8+7b5I0twxAypEacuMgj7lNsOwNq6nXY1SBnxmtbK0tJ/NDlE2TVC28
         eiGfF1PA+XmnJCwdru6XdpH5NiColQVwhNICjtgO8+LoO0grbSzZrdneD4y06IqfAbpW
         UJFcLRgcz9T5k0+kqi5N4N9OFI4qrVL7fyZ3mXyHmF8TlXy5GD5RpI7+PrRDSmQMGd71
         IRgbNfTj6hRrYlFX0CJ9COhRvBWTnIl1+23dWtZkK5oPDR6IDMNCuBgR4DJjm5vlf+Y7
         qaJuLAna59b/rv2YPMR/c6oM5aljchdJymfZdGoJYuaAZQU2Wx28PWjhfijTw3OvQZwX
         N3Fg==
X-Gm-Message-State: ABy/qLaTx6LKhC0t11kAAUvtkn4q2pLGM8p/YSpkyMGe6K+VFlkchyAn
        DnYw0i1GYnfHJjJqGpzVYxQpAPS8enNluDUKvLey3ZwX
X-Google-Smtp-Source: APBJJlEVZcLjenwjTLNBPdv1a9AnoryDrpjTyoR3PbXJbY0i44z3kMPeXQEUrIF64jlEoHPGcZlMtK95X3C3x1VdX3E=
X-Received: by 2002:a2e:1655:0:b0:2b9:4bc3:c367 with SMTP id
 21-20020a2e1655000000b002b94bc3c367mr1416178ljw.5.1689773642193; Wed, 19 Jul
 2023 06:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <13318886.uLZWGnKmhe@kreacher> <8b89f009-bcfe-3a90-f19e-0b5894a5ebd1@linaro.org>
In-Reply-To: <8b89f009-bcfe-3a90-f19e-0b5894a5ebd1@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Jul 2023 15:33:50 +0200
Message-ID: <CAJZ5v0j1gF15vXKw7EdLLh629wisNr8niXQ8eYPY56rvzyNSKw@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] ACPI: thermal: Use trip point table to register
 thermal zones
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 12:46 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> On 18/07/2023 20:01, Rafael J. Wysocki wrote:
> > Hi Everyone,
> >
> > This patch series makes the ACPI thermal driver register thermal zones
> > with the help of thermal_zone_device_register_with_trips(), so it
> > doesn't need to use the thermal zone callbacks related to trip points
> > any more (and they are dropped in the last patch).
>
> Yay!
>
> > The approach presented here is quite radically different from the
> > previous attempts, as it doesn't really rearrange the driver's
> > internal data structures, but adds the trip table support on top of
> > them.  For this purpose, it uses an additional field in struct thermal_trip
> > introduced in the first patch.
> >
> > I have run it on my test-bed systems, but this is not too representative,
> > because they each have only one ACPI thermal zone with only one (critical)
> > trip point in it.
>
> Rui created some ACPI fake tables I was able to run them in a KVM
> machine with fake thermal zones.
>
> I can share the setup if you are interested in

Yes, please!
