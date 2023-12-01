Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630F9800949
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378457AbjLALFK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 1 Dec 2023 06:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378403AbjLALFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:05:07 -0500
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E085B193;
        Fri,  1 Dec 2023 03:05:13 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1fa1e17a0b1so251987fac.1;
        Fri, 01 Dec 2023 03:05:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701428713; x=1702033513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R4AG+bp1YwNTqKpkqmFk8uxVAl7UJkU/XsnQv7+d6Tk=;
        b=PlxUEzULwm05nYbLHjs7oFFnGR26ItvxDr7WMbEQVoaNMXAnrxFywhjmz0UEj4hMcJ
         phqo3j7GkdV9vwfKw6plLfWFwDRonBTDRCHAKfouQIh/MTLTWjqmAGlvCMB9K2uk9QjT
         pLxbAaFGfm3h3OiBlRSryJpBI0L0Q8JUuOsFwOUT6n5BJmtDaKd3IAUD/gYDgFJ4n9dB
         vrjC5YIH5f+p4Yoq8YbukOioCzxx/6IuylGFmSNdPX02/jRCDI7w7+7IEAVi2wTTlTrs
         066HQjaP/gGSNM37Lb7lkcmXDVrPBxxUXLvs7K+8ju4W3eDBaCEoeqsd4wSBI2LAN3Jw
         yAMw==
X-Gm-Message-State: AOJu0YwZ1yts9nsCCDQGecgDWK19OcVFdzG+3vNCTUXEOQsY+p2M03jI
        8z9cczhIdtM9P02nQx3POjgK0iQ2tBBbpnK4/Cg=
X-Google-Smtp-Source: AGHT+IGnXxlJSH7fWaAcjV0nmOenne1+gE1Ckqv5wB5pKRh6x/mG44y3XguGhkDYFerzwYgzpUtfnH2xvBP3lXnWdmA=
X-Received: by 2002:a05:6870:524e:b0:1fa:2d5b:f14f with SMTP id
 o14-20020a056870524e00b001fa2d5bf14fmr22007024oai.4.1701428713035; Fri, 01
 Dec 2023 03:05:13 -0800 (PST)
MIME-Version: 1.0
References: <5754079.DvuYhMxLoT@kreacher> <2933888.e9J7NaK4W3@kreacher> <c68cdec6-a3ba-491d-8193-0f3d13705d5f@linaro.org>
In-Reply-To: <c68cdec6-a3ba-491d-8193-0f3d13705d5f@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 1 Dec 2023 12:05:01 +0100
Message-ID: <CAJZ5v0jE9LOo2i-JBHEoJ+kGYA248=cUXhKGGCvoev_B05jR-w@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] thermal: sysfs: Eliminate unnecessary zone locking
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
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

On Fri, Dec 1, 2023 at 10:16 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 30/11/2023 19:37, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The _show() callback functions of the trip point sysfs attributes,
> > temperature, hysteresis and type, need not use thermal zone locking,
> > because the layout of the data structures they access does not change
> > after the thermal zone registration.
> >
> > Namely, they all need to access a specific entry in the thermal
> > zone's trips[] table that is always present for non-tripless thermal
> > zones and its size cannot change after the thermal zone has been
> > registered.  Thus it is always safe to access the trips[] table of a
> > registered thermal zone from each of the sysfs attributes in question.
> >
> > Moreover, the type of a trip point does not change after registering its
> > thermal zone, and while its temperature and hysteresis can change, for
> > example due to a firmware-induced thermal zone update, holding the zone
> > lock around reading them is pointless, because it does not prevent stale
> > values from being returned to user space.  For example, a trip point
> > temperature can always change ater trip_point_temp_show() has read it
> > and before the function's return statement is executed, regardless of
> > whether or not zone locking is used.
> >
> > For this reason, drop the zone locking from trip_point_type_show(),
> > trip_point_temp_show(), and trip_point_hyst_show().
>
> Isn't the lock used to protect against device_del() from
> thermal_zone_device_unregister() ?

Ah, I missed the zone locking around device_del() in there.

OK, please scratch this series for now.
