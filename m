Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F91080CB4B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343634AbjLKNpD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Dec 2023 08:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbjLKNpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:45:02 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8288AD;
        Mon, 11 Dec 2023 05:45:08 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6da06c505ccso470126a34.1;
        Mon, 11 Dec 2023 05:45:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702302308; x=1702907108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JuMgu00NLAwah5dEifMlDlKfcOMiONZuqYgJcIiGOM8=;
        b=i+iRV5V6qyTFUIOc4PMslxyJAy+OSs2yBAcLez0WBYLvDItzVs79T3W36VxNe0jOXw
         Xls/vjH+aqV+e/LGYQJO6C3afCf3rg6TaUNmT7BaETe4oHH3KxPnoIQGWLq6qyg7qzTt
         vOcsb1ygdjozEDkpuc73lFzisQUfqqgA0Eb7rhhYhf9v80aLtgTJyQKY60loI0r0sLQ2
         63magvwBUUm7N8BxeJ4AMnTP2AUs0Tc2bAgreEWaS74jSsQenYBooig2qkwVnaNLF4mO
         OCk6I8lpYO4QOMzp6pAVdqXgcwPi3RYDxhTD27bqL/S2h0GsUX6/yKz3RZfo3xdhA9jc
         fXbA==
X-Gm-Message-State: AOJu0Yxaubv0EP4fZ8nxcdAVhoDmk8qCBbdYfrGYtXjMBSaADU83ApgR
        dtUIMYWCU5Dnugnzq51ZbKOZQhn9mRhE4kKBIIA=
X-Google-Smtp-Source: AGHT+IGpVo/RGKXFZCViZPQ7IBpVlFW6xo6IlTjrh3Sd3P8kFOK+vhAun4TccGy7fygLfPuC+ozfhofEy7Ae0nR8fXs=
X-Received: by 2002:a05:6870:9607:b0:1fb:23ec:3318 with SMTP id
 d7-20020a056870960700b001fb23ec3318mr8409458oaq.0.1702302308012; Mon, 11 Dec
 2023 05:45:08 -0800 (PST)
MIME-Version: 1.0
References: <1880915.tdWV9SEqCh@kreacher> <a317fd5b-85df-409f-96e2-8123eea6ca73@arm.com>
In-Reply-To: <a317fd5b-85df-409f-96e2-8123eea6ca73@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 11 Dec 2023 14:44:51 +0100
Message-ID: <CAJZ5v0g3exHkX6FLsmbYUcOJHstWOfVf_QnEnm8KmqoYCYwdjA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] thermal: core: Remove thermal zones during unregistration
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Mon, Dec 11, 2023 at 2:37 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Rafael,
>
> On 12/8/23 19:11, Rafael J. Wysocki wrote:
> > Hi All,
> >
> > This patch series adds a mechanism to guarantee that
> > thermal_zone_device_unregister() will not return until all of the active
> > references to the thermal zone device object in question have been dropped
> > and it has been deleted (patch [1/3]).
> >
> > This supersedes the approach used so far in which all thermal zone sysfs
> > attribute callbacks check if the zone device is still registered under the
> > zone lock, so as to return early if that is not the case, as it means that
> > device_del() has been called for the thermal zone in question (and returned).
> > It is not necessary to do that any more after patch [1/3], so patch [2/3]
> > removes those checks from the code and drops zone locking that is not
> > necessary any more either.
> >
> > Patch [3/3] uses the observation that the thermal subsystem does not need to
> > check if a thermal zone device is registered at all, because it can use its
> > own data to determine whether or not the thermal zone is going away and so
> > it may not be worth updating it, for example.
> >
> > Please refer to the patch changelogs for details.
> >
> > The series depends on new thermal material in linux-next, but it should not
> > substantially depend on any changes that have not made it into linux-next yet.
> >
> > Thanks!
> >
> >
> >
>
> I like the concept with completion thing for this.
> I have tired to stress test these patches with my mock
> thermal zone module load/unload and it works good.
>
> The test was doing the these bits:
> for i in $(seq 1 1000000) ; do cat
> /sys/class/thermal/thermal_zone2/trip_point_0_temp > /dev/null 2>&1 ; done &
> for i in $(seq 1 10000) ; do insmod /data/selftest_ipa.ko ; rmmod
> selftest_ipa ; done &
>
> I couldn't trigger any issues in reading from this
> trip temp file in background, which should go now w/o the
> locking. I thought it would be nice test, since we have
> direct call to trips array 'tz->trips[trip_id].temperature'.
> Let me know if you think about other scenario for stress testing it.
> (I have also checked the 'temp' sysfs read, where the mutex for
> tz is used - also no issues).
>
> Feel free to add to all patches:
>
> Reviewed-and-tested-by: Lukasz Luba <lukasz.luba@arm.com>

Thank you!
