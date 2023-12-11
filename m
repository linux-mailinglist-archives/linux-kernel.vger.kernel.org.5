Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF0680D9C5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 19:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344699AbjLKS4t convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Dec 2023 13:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344513AbjLKRzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:55:17 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5BC139;
        Mon, 11 Dec 2023 09:55:06 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6d9db92bd71so599770a34.1;
        Mon, 11 Dec 2023 09:55:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702317305; x=1702922105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5DEOgtWQGmkZPDn7q8GGAWjC29BJ9Cak4Iie+5uKU4=;
        b=MYsuzVVtoHz6N5IK8rbqy4BQ2+ZyNMx6lsm5bXiHGUnNftMoli6PyjFSJkDSAOePni
         IH0G1j8oCXRiHIT6f5Uj1NQdEMen4k/T//RS9rUx34nN0J6Djdi6tYqCPPcAJAOHTbd5
         FHpk7itV97O8llPlCoMm6FoHCm9zxlmhn3wV1YxwjpNaogLijTScTh2kOvJ1sDkvr/TA
         EdxKDhDtguhsJ0SNiYHfEXqxIFCo4e53toUB1MnlzEBcI9MqdAeSA5cjuGSa6o2Hu/Fu
         49/MtUsXRuJRPUostZ43sGW5psAZEOmCITxbKznFZ9kxUbpJAKHY+Y8WpUHksp5nAxii
         4Srg==
X-Gm-Message-State: AOJu0Yxh0Ujjq4NfIUk77IpMmx/a3UL64GqwIrnDrJU3SPp8y8T7WIn7
        nJtiiXKILqGDbltEBOojtdAh+4cNMl7MvkLCVY4=
X-Google-Smtp-Source: AGHT+IET71n0JJ2tueY9OJljlWzKGRyqqLWCLUFMrm8MKmbmYZ0jyJuvpQjW8E8xN6iFZjazIAM6wlyajDazJ34JV3I=
X-Received: by 2002:a05:6871:2284:b0:1fb:648:5207 with SMTP id
 sd4-20020a056871228400b001fb06485207mr9535232oab.2.1702317305527; Mon, 11 Dec
 2023 09:55:05 -0800 (PST)
MIME-Version: 1.0
References: <1880915.tdWV9SEqCh@kreacher> <13414639.uLZWGnKmhe@kreacher>
 <0a0d5dd4-6b7a-428b-8ef1-bb6aff76fb51@linaro.org> <CAJZ5v0jebeWzUb-q-_xThRwZgUzaUfqS4YTGmsvbsOPrqFcYTQ@mail.gmail.com>
 <535558f8-096b-4917-92d2-b0defed42b15@linaro.org>
In-Reply-To: <535558f8-096b-4917-92d2-b0defed42b15@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 11 Dec 2023 18:54:54 +0100
Message-ID: <CAJZ5v0heWWM8Jt-8ksVDF8R4Uc6FvsspEOAEeN-nQDgwPfHU8Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] thermal: core: Make thermal_zone_device_unregister()
 return after freeing the zone
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
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

On Mon, Dec 11, 2023 at 6:35 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 11/12/2023 17:42, Rafael J. Wysocki wrote:
> > On Mon, Dec 11, 2023 at 5:28 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 08/12/2023 20:13, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> Make thermal_zone_device_unregister() wait until all of the references
> >>> to the given thermal zone object have been dropped and free it before
> >>> returning.
> >>>
> >>> This guarantees that when thermal_zone_device_unregister() returns,
> >>> there is no leftover activity regarding the thermal zone in question
> >>> which is required by some of its callers (for instance, modular driver
> >>> code that wants to know when it is safe to let the module go away).
> >>>
> >>> Subsequently, this will allow some confusing device_is_registered()
> >>> checks to be dropped from the thermal sysfs and core code.
> >>>
> >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>> ---
> >>
> >> Definitively agree on the change
> >>
> >> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >
> > Thanks!
> >
> >> Would it make sense to use kref_get/put ?
> >
> > Why and where?
>
> Well it is a general question. Usually this kind of removal is tied with
> a refcount

It is tied to a refcount already, but the problem is that the last
reference can be dropped from a thread concurrent to the removal one.

The completion effectively causes the removal thread to wait for the
refcont to become 0.
