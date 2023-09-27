Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130D37B09B8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjI0QOW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 27 Sep 2023 12:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjI0QOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:14:19 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA93A91;
        Wed, 27 Sep 2023 09:14:18 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-57bc11c197aso830668eaf.1;
        Wed, 27 Sep 2023 09:14:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695831258; x=1696436058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1ahmo9waRUqjCTDTV6N3TPA6RbVuxWOLI3ShINewQQ=;
        b=tR7o3/xpvI3DyNjTFPiwxEmR/RP6ShPh8MNrF2m2WrwLPeupDP47bAaBKN2DRYsVCp
         s7sBy8uVnlURWsIWpbAN0oH08UOC0W/QDWBmFuuNAcZKx0XAsGPb5Vyo1FdHEYsRKiW2
         Q+zxyILRYg1IAEyc7ICqsi4zFG2G6cGZ2cXcw2R7r7uHnjEuP2CGEsf0IuPP63DyVzAR
         zuRyEkawH2OrMMAkYmK5eOOmjt1kTpsOAHBnZPEjWX8NSYa6EAuk16ckz7vi+q+1v4Mg
         JwDhRABizYe96L4fhdVvbChkGWCwcDMokRYKNg+rcrOiNxrpTCj0f3Gp3mt0wCxA2n7r
         Nmgw==
X-Gm-Message-State: AOJu0YysxsXtVmev/kwxdfPBl4vRHmgMtKv+cn1WQ+ssv80Z099NqZnG
        P0cZJEOlZ9yINQOHWImKdugOIDQYd/szXmeM/lA=
X-Google-Smtp-Source: AGHT+IFBpFosaX2K+I5sHnXh1LWvPJSn6Sr5sxXngfz5rSCyc+9SiiFyG1qQYhJMi9AUVgv/Q02VhqmrWlAFmv+zlEs=
X-Received: by 2002:a4a:ee18:0:b0:56e:94ed:c098 with SMTP id
 bd24-20020a4aee18000000b0056e94edc098mr3051244oob.0.1695831257895; Wed, 27
 Sep 2023 09:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <1957441.PYKUYFuaPT@kreacher> <2590280.Lt9SDvczpP@kreacher>
 <9f1374db-f866-ff52-e86c-99fecee24d1b@linaro.org> <CAJZ5v0hw3LGByW=18tiFEB7JQ9rOVo6TqCGhzxWcrUQYb+VGEw@mail.gmail.com>
 <f193e4a5-b315-a1bd-7488-7ea0d5e267f8@linaro.org>
In-Reply-To: <f193e4a5-b315-a1bd-7488-7ea0d5e267f8@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 Sep 2023 18:14:06 +0200
Message-ID: <CAJZ5v0h_HB6DX3NemyojE8aZrQeH05aAsdKLE-q-gp4UC+NBJQ@mail.gmail.com>
Subject: Re: [PATCH v1 07/13] thermal: gov_power_allocator: Use trip pointers
 instead of trip indices
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 5:46 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 27/09/2023 17:27, Rafael J. Wysocki wrote:
> > On Wed, Sep 27, 2023 at 5:10 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 21/09/2023 19:55, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> Eliminate the __thermal_zone_get_trip() usage that adds unnecessary
> >>> overhead (due to pointless bounds checking and copying of trip point
> >>> data) from the power allocator thermal governor and generally make it
> >>> use trip pointers instead of trip indices where applicable.
> >>
> >> Actually the __thermal_zone_get_trip() change was done on purpose to
> >> replace the 'throttle' callback index parameter by the trip pointer and
> >> removing those call to __thermal_zone_get_trip() while the code was
> >> using the trip pointer.
> >>
> >> IMO, the changes should focus on changing the trip_index parameter by
> >> the trip pointer directly in the throttle ops.
> >
> > So you would like .throttle() to take a trip pointer argument instead
> > of an index?
> >
> > The difficulty here is that the user space governor needs to expose
> > the index to user space anyway, so it would need to find it if it gets
> > a trip pointer instead.
> >
> > Not a big deal I suppose, but a bit of extra overhead.
> >
> > Also it is easier to switch the governors over to using trip pointers
> > internally and then change the .throttle() argument on top of that.
> >
> >> The pointer can be
> >> retrieved in the handle_thermal_trip() function and passed around for
> >> the rest of the actions on this trip point
> >
> > Right, except for the user space governor which needs a trip index.
> > And the indices are used for tracing too.
>
> Given the userspace governor is going obsolete and the notifications are
> for the userspace, which is slow, we can retrieve the index from the
> throttling ops

OK

Given that patches [01-05/13] are not controversial, I'll respon the
governor patches into a separate series on top of them.

I would much appreciate it if you could take a look at patch [10/13]
and the remaining ACPi thermal patches in this series [11-13/13].
They don't depend on the governor changes.
