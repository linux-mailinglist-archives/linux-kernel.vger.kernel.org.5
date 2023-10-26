Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2423C7D7F01
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344690AbjJZIzE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 26 Oct 2023 04:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbjJZIyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:54:51 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8180AD4C;
        Thu, 26 Oct 2023 01:54:32 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1d542f05b9aso88955fac.1;
        Thu, 26 Oct 2023 01:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698310471; x=1698915271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJBpOf233+yopPlepXZVOesYvg63ifr+iPe/TQKxFsU=;
        b=e4PuMMkfYKmOoDLQF/cbBdpB2nxEdPDeCC3cpiMS28VdSNSALNbua0Qs/8dUdJkaDz
         6+OSTspn7RiC9r3I5kMGjAR0p9voxcZi5kxt3R/AzV5bVyBdNgE//vKR24PGSSlf8Zbm
         1JeD65VVaVio7kjL9DahQEgWm16Fgh9dFCjoid97FmeeNdIcAdeolLPF1+7frdlHS4oU
         BV/eW+rz4siNFTGMf09gL29iOgetBtcilmLC6t7IDc+rZ2tVnUAXw61SW7afWkXxow7V
         MuQkAj2OfN0pKmxfgEwyIvx8Sxc1rT0qmWABDy3f48c3qsaJhLRkGZKwgPzydw+lf3Fy
         3OPA==
X-Gm-Message-State: AOJu0YyBiaD1BGbSczOp8buGQEViB8JSe4qu5zwOgdoncZaHv724+sWX
        wJrJKgXMPDB/9Az/5sHfX2FuLEQT7SZtkrYJu8A=
X-Google-Smtp-Source: AGHT+IHVzrR+8RXsnZG1qtBgse4jbzcb9JTiKw+8kC9DGQakYWn6zEsHWTpc5DVgDihroHVH9Mu3Oyf/zqoTES03ipg=
X-Received: by 2002:a4a:b985:0:b0:586:7095:126d with SMTP id
 e5-20020a4ab985000000b005867095126dmr7403490oop.0.1698310471356; Thu, 26 Oct
 2023 01:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20231025192225.468228-1-lukasz.luba@arm.com>
In-Reply-To: <20231025192225.468228-1-lukasz.luba@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 26 Oct 2023 10:54:19 +0200
Message-ID: <CAJZ5v0gniBtFduwjhDku+OZzjvkCaFK7ew0uJTfW254XKTOyyw@mail.gmail.com>
Subject: Re: [PATCH 0/7] Minor cleanup for thermal gov power allocator
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org, linux-pm@vger.kernel.org, rui.zhang@intel.com
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

On Wed, Oct 25, 2023 at 9:21 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi all,
>
> The patch set does some small clean up for Intelligent Power Allocator.
> Those changes are not expected to alter the general functionality. They just
> improve the code reading. Only patch 3/7 might improve the use case for
> binding the governor to thermal zone (very unlikely in real products, but
> it's needed for correctness).
>
> The changes are based on top of current PM thermal branch, so with the
> new trip points.
>
> Regards,
> Lukasz
>
> Lukasz Luba (7):
>   thermal: gov_power_allocator: Rename trip_max_desired_temperature
>   thermal: gov_power_allocator: Setup trip points earlier
>   thermal: gov_power_allocator: Check the cooling devices only for
>     trip_max
>   thermal: gov_power_allocator: Rearrange the order of variables
>   thermal: gov_power_allocator: Use shorter variable when possible
>   thermal: gov_power_allocator: Remove unneeded local variables
>   thermal: gov_power_allocator: Clean needed variables at the beginning
>
>  drivers/thermal/gov_power_allocator.c | 123 ++++++++++++++------------
>  1 file changed, 64 insertions(+), 59 deletions(-)
>
> --

The series looks good to me overall, but I'd prefer to make these
changes in the 6.8 cycle, because the 6.7 merge window is around the
corner and there is quite a bit of thermal material in this cycle
already.
