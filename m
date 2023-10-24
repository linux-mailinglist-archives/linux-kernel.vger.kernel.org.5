Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB667D5B4E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 21:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344235AbjJXTPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 15:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344021AbjJXTPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 15:15:52 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631C1109;
        Tue, 24 Oct 2023 12:15:50 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3b2ea7cc821so3393621b6e.1;
        Tue, 24 Oct 2023 12:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698174949; x=1698779749;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fc7wsu+Ez53X61VDpaWVir82UtYO/AqwmwLE+WTcs7o=;
        b=Ympkgw82amTwWMA7C8Sh93ah33FrMYi8aLpgaRRRxltyRb6tJuNXWzFUQ2B/YHuBel
         6hACTWs9dHYkLHdHUyHNsqIPe82p5aGezlWKBF5jwaY58ojq6TXFiOXatAccCWQOAUx4
         GdqEcuVCCw+7LffSEYWCATvmnxATyBL83wLjUomtjrpQNGTMGXYlYhRPESuq8ac+cKbl
         tBPkU6qQm/rxDtrBRhut/gNDb8wOuZSi7JU+5JGW98oB5z1fAQY2UGC0aJ2WcND3aJ1L
         GDr2TnpYi9jS1e42iQJo2Pr+CWtR/4pP6896cCDifvf5zMWbyqM88RUlyDCNOAVwuPzM
         HK0A==
X-Gm-Message-State: AOJu0YwUHxZTgUE3Hzulnered2bHQrQQf69XVjCcVx6crwRjcjRnGKEq
        5D/YVjURPn80iv/GK2/GyA==
X-Google-Smtp-Source: AGHT+IER1+W8thq+jVs5LXcjlTIf2E/TkcDrEDQn3qMEpjU+x8WiOWdAZMsl5sTg8R2Hr324uf0jDg==
X-Received: by 2002:a05:6808:181:b0:3ab:8574:e8ab with SMTP id w1-20020a056808018100b003ab8574e8abmr14532474oic.21.1698174949695;
        Tue, 24 Oct 2023 12:15:49 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j5-20020a056830270500b006ce46212341sm1399103otu.54.2023.10.24.12.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 12:15:49 -0700 (PDT)
Received: (nullmailer pid 403998 invoked by uid 1000);
        Tue, 24 Oct 2023 19:15:48 -0000
Date:   Tue, 24 Oct 2023 14:15:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, frowand.list@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kernel@quicinc.com
Subject: Re: [RFC PATCH 1/3] of: reserved_mem: Change the order that
 reserved_mem regions are stored
Message-ID: <20231024191548.GA358703-robh@kernel.org>
References: <20231019184825.9712-1-quic_obabatun@quicinc.com>
 <20231019184825.9712-2-quic_obabatun@quicinc.com>
 <CAL_Jsq+pUv29277spzXB7QJ=OZTwGy_FmW55CzQPWYLPktA0EA@mail.gmail.com>
 <7e6ddffc-81a5-4183-9e59-7060776c936a@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e6ddffc-81a5-4183-9e59-7060776c936a@quicinc.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 03:45:37PM -0700, Oreoluwa Babatunde wrote:
> 
> On 10/19/2023 12:46 PM, Rob Herring wrote:
> > On Thu, Oct 19, 2023 at 1:49 PM Oreoluwa Babatunde
> > <quic_obabatun@quicinc.com> wrote:
> >> The dynamic allocation of the reserved_mem array needs to be done after
> >> paging_init() is called because memory allocated using memblock_alloc()
> >> is not writeable before that.


> >> --- a/arch/arm64/kernel/setup.c
> >> +++ b/arch/arm64/kernel/setup.c
> >> @@ -27,6 +27,8 @@
> >>  #include <linux/proc_fs.h>
> >>  #include <linux/memblock.h>
> >>  #include <linux/of_fdt.h>
> >> +#include <linux/of_reserved_mem.h>
> >> +
> >>  #include <linux/efi.h>
> >>  #include <linux/psci.h>
> >>  #include <linux/sched/task.h>
> >> @@ -346,6 +348,8 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
> >>
> >>         paging_init();
> >>
> >> +       fdt_init_reserved_mem();
> >> +
> > You removed this call from the common code and add it to arm64 arch
> > code, doesn't that break every other arch?
> Yes, the same changes will be needed for every other arch. I was hoping to
> get some feedback on the RFC before implementing this on other archs which
> is why the change is currently only in arm64.
> > The very next thing done here is unflattening the DT. So another call
> > from the arch code to the DT code isn't needed either.
> Yes, I see that unflatten_device_tree() is being called right after here.
> Just to clarify, are you suggesting to move fdt_init_reserved_mem() into the
> unflatten_device_tree() call?

In general, I want fewer calls between arch code and DT core and for the 
DT core to be more in control of the ordering that things happen. Your 
series does the opposite.

Rob
