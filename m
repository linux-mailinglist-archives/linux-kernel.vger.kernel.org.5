Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C1E7810A7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378611AbjHRQma convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Aug 2023 12:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378865AbjHRQmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:42:06 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5B446BC;
        Fri, 18 Aug 2023 09:41:45 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-56d67c5e87cso193360eaf.0;
        Fri, 18 Aug 2023 09:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692376905; x=1692981705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79qiflmIcqsS7DT/xXbMIdUQb1Omg1LDyvKgyYWC4Wg=;
        b=Ahmy+tdfpJR8BLHW899O0XBGdaF+RBrZGlXAS20K2GdrT9tERHnUoM/fknKfAVQYSv
         +fKuuYCXI+aFq4QQJ2yqylRny0+AwXwJFXdaEPFLoNJcoZTDisgxgIRm+qvS591rVX2P
         6vklf8i4v+hNjPzuUZicaaqurpY4d/Xo1fc0hURK46Pa5nWa5n4+gmpSvFDTVApVXlAg
         3VQGkA3x2IoB15U9+muXTC+FvIPFxImS7hp9lgdXgCpGtznB7J4AOkPGtF+hfQ8aNZ5S
         6CwVMY+fzX7ab01A2Go0gYw72etrf6/8n8cr/uZCYUqNLxSEyaJlrf5Rxku6uPt+BB3h
         nNyw==
X-Gm-Message-State: AOJu0YzBxh0GKsvQ6LeQvLfCf5cYeGyhjbWLJOe7+6IOhJ0G01O462dL
        suFBPMrj4OjzsPK65XZRm7FcUwjCOre9gkhpyQI=
X-Google-Smtp-Source: AGHT+IGq0ClH5XmhZ/aBsrau9IjCmR3xeCyFXHcIlTxxN8ouMy4KkGLcQ9AFr5SPbdrOhdMhQpOEL3Y4Jv7zn6gdt1E=
X-Received: by 2002:a05:6820:44a:b0:563:3b56:5dc1 with SMTP id
 p10-20020a056820044a00b005633b565dc1mr3290968oou.0.1692376904867; Fri, 18 Aug
 2023 09:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230818032619.3341234-1-evan.quan@amd.com> <20230818032619.3341234-2-evan.quan@amd.com>
In-Reply-To: <20230818032619.3341234-2-evan.quan@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Aug 2023 18:41:33 +0200
Message-ID: <CAJZ5v0hEBpHfYnQ4aKRE4viTt4CCH=XeY=uFJFwzMGq6k4Kvgg@mail.gmail.com>
Subject: Re: [V9 1/9] drivers core: Add support for Wifi band RF mitigations
To:     Evan Quan <evan.quan@amd.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org, lenb@kernel.org,
        johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        alexander.deucher@amd.com, andrew@lunn.ch, rdunlap@infradead.org,
        quic_jjohnson@quicinc.com, horms@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>
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

On Fri, Aug 18, 2023 at 5:27 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Due to electrical and mechanical constraints in certain platform designs
> there may be likely interference of relatively high-powered harmonics of
> the (G-)DDR memory clocks with local radio module frequency bands used
> by Wifi 6/6e/7.
>
> To mitigate this, AMD has introduced a mechanism that devices can use to
> notify active use of particular frequencies so that other devices can make
> relative internal adjustments as necessary to avoid this resonance.
>
> In order for a device to support this, the expected flow for device
> driver or subsystems:
>
> Drivers/subsystems contributing frequencies:
>
> 1) During probe, check `wbrf_supported_producer` to see if WBRF supported
>    for the device.
> 2) If adding frequencies, then call `wbrf_add_exclusion` with the
>    start and end ranges of the frequencies.
> 3) If removing frequencies, then call `wbrf_remove_exclusion` with
>    start and end ranges of the frequencies.
>
> Drivers/subsystems responding to frequencies:
>
> 1) During probe, check `wbrf_supported_consumer` to see if WBRF is supported
>    for the device.
> 2) Call the `wbrf_register_notifier` to register for notifications of
>    frequency changes from other devices.
> 3) Call the `wbrf_retrieve_exclusions` to retrieve the current exclusions
>    range on receiving a notification and response correspondingly.
>
> Meanwhile a kernel parameter `wbrf` with default setting as "auto" is
> introduced to specify what the policy is.
>   - With `wbrf=on`, the WBRF features will be enabled forcely.
>   - With `wbrf=off`, the WBRF features will be disabled forcely.
>   - With `wbrf=auto`, it will be up to the system to do proper checks
>     to determine the WBRF features should be enabled or not.
>
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Co-developed-by: Evan Quan <evan.quan@amd.com>
> Signed-off-by: Evan Quan <evan.quan@amd.com>

In the first place, this requires quite a bit of driver API
documentation that is missing.

To a minimum, it should explain what the interface is for and how it
is supposed to be used by drivers (both "producers" and "consumers").

And how to determine whether or not a given device is a "producer" or
"consumer" from the WBRF perspective.

> --
> v4->v5:
>   - promote this to be a more generic solution with input argument taking
>     `struct device` and provide better scalability to support non-ACPI
>     scenarios(Andrew)
>   - update the APIs naming and some other minor fixes(Rafael)
> v6->v7:
>   - revised the `struct wbrf_ranges_out` to be naturally aligned(Andrew)
>   - revised some code comments(Andrew)
> v8->v9:
>   - update the document to be more readable(Randy)
> ---
>  .../admin-guide/kernel-parameters.txt         |   8 +
>  drivers/base/Makefile                         |   1 +
>  drivers/base/wbrf.c                           | 280 ++++++++++++++++++
>  include/linux/wbrf.h                          |  47 +++
>  4 files changed, 336 insertions(+)
>  create mode 100644 drivers/base/wbrf.c
>  create mode 100644 include/linux/wbrf.h
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a1457995fd41..5566fefeffdf 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -7152,3 +7152,11 @@
>                                 xmon commands.
>                         off     xmon is disabled.
>
> +       wbrf=           [KNL]
> +                       Format: { on | auto (default) | off }
> +                       Controls if WBRF features should be forced on or off.
> +                       on      Force enable the WBRF features.
> +                       auto    Up to the system to do proper checks to
> +                               determine the WBRF features should be enabled
> +                               or not.
> +                       off     Force disable the WBRF features.

Well, how's a casual reader of this file supposed to find out what
WBRF is and whether or not they should care?

> diff --git a/drivers/base/Makefile b/drivers/base/Makefile
> index 3079bfe53d04..7b3cef898c19 100644
> --- a/drivers/base/Makefile
> +++ b/drivers/base/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_GENERIC_MSI_IRQ) += platform-msi.o
>  obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) += arch_topology.o
>  obj-$(CONFIG_GENERIC_ARCH_NUMA) += arch_numa.o
>  obj-$(CONFIG_ACPI) += physical_location.o
> +obj-y                  += wbrf.o
>
>  obj-y                  += test/
>
> diff --git a/drivers/base/wbrf.c b/drivers/base/wbrf.c
> new file mode 100644
> index 000000000000..678f245c12c6
> --- /dev/null
> +++ b/drivers/base/wbrf.c
> @@ -0,0 +1,280 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Wifi Band Exclusion Interface
> + * Copyright (C) 2023 Advanced Micro Devices
> + *

I would expect some explanation of the interface design and purpose here.

So I don't have to wonder what WBRF_POLICY_MODE is or what the
"exclusion ranges" are below.

> + */
> +
> +#include <linux/wbrf.h>
> +
> +static BLOCKING_NOTIFIER_HEAD(wbrf_chain_head);
> +static DEFINE_MUTEX(wbrf_mutex);
> +static enum WBRF_POLICY_MODE {
> +       WBRF_POLICY_FORCE_DISABLE,
> +       WBRF_POLICY_AUTO,
> +       WBRF_POLICY_FORCE_ENABLE,
> +} wbrf_policy = WBRF_POLICY_AUTO;
> +
> +static int __init parse_wbrf_policy_mode(char *p)
> +{
> +       if (!strncmp(p, "auto", 4))
> +               wbrf_policy = WBRF_POLICY_AUTO;
> +       else if (!strncmp(p, "on", 2))
> +               wbrf_policy = WBRF_POLICY_FORCE_ENABLE;
> +       else if (!strncmp(p, "off", 3))
> +               wbrf_policy = WBRF_POLICY_FORCE_DISABLE;
> +       else
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +early_param("wbrf", parse_wbrf_policy_mode);
> +
> +static struct exclusion_range_pool {
> +       struct exclusion_range  band_list[MAX_NUM_OF_WBRF_RANGES];
> +       u64                     ref_counter[MAX_NUM_OF_WBRF_RANGES];
> +} wbrf_pool;
> +
> +static int _wbrf_add_exclusion_ranges(struct wbrf_ranges_in *in)
> +{
> +       int i, j;
> +
> +       for (i = 0; i < ARRAY_SIZE(in->band_list); i++) {
> +               if (!in->band_list[i].start &&
> +                   !in->band_list[i].end)
> +                       continue;
> +
> +               for (j = 0; j < ARRAY_SIZE(wbrf_pool.band_list); j++) {
> +                       if (wbrf_pool.band_list[j].start == in->band_list[i].start &&
> +                           wbrf_pool.band_list[j].end == in->band_list[i].end) {
> +                               wbrf_pool.ref_counter[j]++;
> +                               break;
> +                       }
> +               }
> +               if (j < ARRAY_SIZE(wbrf_pool.band_list))
> +                       continue;
> +
> +               for (j = 0; j < ARRAY_SIZE(wbrf_pool.band_list); j++) {
> +                       if (!wbrf_pool.band_list[j].start &&
> +                           !wbrf_pool.band_list[j].end) {
> +                               wbrf_pool.band_list[j].start = in->band_list[i].start;
> +                               wbrf_pool.band_list[j].end = in->band_list[i].end;
> +                               wbrf_pool.ref_counter[j] = 1;
> +                               break;
> +                       }
> +               }
> +               if (j >= ARRAY_SIZE(wbrf_pool.band_list))
> +                       return -ENOSPC;
> +       }
> +
> +       return 0;
> +}
> +
> +static int _wbrf_remove_exclusion_ranges(struct wbrf_ranges_in *in)
> +{
> +       int i, j;
> +
> +       for (i = 0; i < ARRAY_SIZE(in->band_list); i++) {
> +               if (!in->band_list[i].start &&
> +                   !in->band_list[i].end)
> +                       continue;
> +
> +               for (j = 0; j < ARRAY_SIZE(wbrf_pool.band_list); j++) {
> +                       if (wbrf_pool.band_list[j].start == in->band_list[i].start &&
> +                           wbrf_pool.band_list[j].end == in->band_list[i].end) {
> +                               wbrf_pool.ref_counter[j]--;
> +                               if (!wbrf_pool.ref_counter[j]) {
> +                                       wbrf_pool.band_list[j].start = 0;
> +                                       wbrf_pool.band_list[j].end = 0;
> +                               }
> +                               break;
> +                       }
> +               }
> +       }
> +
> +       return 0;

It never returns anything else.  Should it be void?

> +}
> +
> +static int _wbrf_retrieve_exclusion_ranges(struct wbrf_ranges_out *out)
> +{
> +       int out_idx = 0;
> +       int i;
> +
> +       memset(out, 0, sizeof(*out));
> +
> +       for (i = 0; i < ARRAY_SIZE(wbrf_pool.band_list); i++) {
> +               if (!wbrf_pool.band_list[i].start &&
> +                   !wbrf_pool.band_list[i].end)
> +                       continue;
> +
> +               out->band_list[out_idx].start = wbrf_pool.band_list[i].start;
> +               out->band_list[out_idx++].end = wbrf_pool.band_list[i].end;
> +       }
> +
> +       out->num_of_ranges = out_idx;
> +
> +       return 0;

Same here.

> +}
> +
> +/**
> + * wbrf_supported_system - Determine if the system supports WBRF features
> + *
> + * WBRF is used to mitigate devices that cause harmonic interference.
> + * This function will determine if the platform is able to support the
> + * WBRF features.

The code doesn't quite match the description above.  I guess the code
is temporary?

> + */
> +static bool wbrf_supported_system(void)
> +{
> +       switch (wbrf_policy) {
> +       case WBRF_POLICY_FORCE_ENABLE:
> +               return true;
> +       case WBRF_POLICY_FORCE_DISABLE:
> +               return false;
> +       case WBRF_POLICY_AUTO:
> +               return false;
> +       }
> +
> +       return false;
> +}
> +
> +/**
> + * wbrf_supported_producer - Determine if the device should report frequencies
> + *
> + * @dev: device pointer
> + *
> + * WBRF is used to mitigate devices that cause harmonic interference.
> + * This function will determine if this device should report such frequencies.

It is not clear how "harmonic interference" is related to "such
frequencies" from the above.

> + */
> +bool wbrf_supported_producer(struct device *dev)
> +{
> +       if (!wbrf_supported_system())
> +               return false;
> +
> +       return true;
> +}
> +EXPORT_SYMBOL_GPL(wbrf_supported_producer);
> +
> +/**
> + * wbrf_add_exclusion - Add frequency ranges to the exclusion list
> + *
> + * @dev: device pointer
> + * @in: input structure containing the frequency ranges to be added
> + *
> + * Add frequencies into the exclusion list for supported consumers
> + * to react to.

Well, the above isn't particularly helpful IMV.

What's "the exclusion list"?  What are "supported consumers" and how
are they going to "react" and to what exactly (the exclusion list or
the frequencies)?

Why is the notifier chain not mentioned in the kerneldoc description
of the function?

> + */
> +int wbrf_add_exclusion(struct device *dev,
> +                      struct wbrf_ranges_in *in)
> +{
> +       int r;
> +
> +       mutex_lock(&wbrf_mutex);
> +
> +       r = _wbrf_add_exclusion_ranges(in);
> +
> +       mutex_unlock(&wbrf_mutex);
> +       if (r)
> +               return r;
> +
> +       blocking_notifier_call_chain(&wbrf_chain_head, WBRF_CHANGED, NULL);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(wbrf_add_exclusion);
> +
> +/**
> + * wbrf_remove_exclusion - Remove frequency ranges from the exclusion list
> + *
> + * @dev: device pointer
> + * @in: input structure containing the frequency ranges to be removed
> + *
> + * Remove frequencies from the exclusion list for supported consumers
> + * to react to.

This has the same problems as the above.

> + */
> +int wbrf_remove_exclusion(struct device *dev,
> +                         struct wbrf_ranges_in *in)
> +{
> +       int r;
> +
> +       mutex_lock(&wbrf_mutex);
> +
> +       r = _wbrf_remove_exclusion_ranges(in);
> +
> +       mutex_unlock(&wbrf_mutex);
> +       if (r)
> +               return r;
> +
> +       blocking_notifier_call_chain(&wbrf_chain_head, WBRF_CHANGED, NULL);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(wbrf_remove_exclusion);
> +
> +/**
> + * wbrf_supported_consumer - Determine if the device should react to frequencies
> + *
> + * @dev: device pointer
> + *
> + * WBRF is used to mitigate devices that cause harmonic interference.

What does this mean?  How can a device be "mitigated" and what
"harmonic interference" is this about?

> + * This function will determine if this device should react to reports from
> + * other devices for such frequencies.

What are "such frequencies"?

> + */
> +bool wbrf_supported_consumer(struct device *dev)
> +{
> +       if (!wbrf_supported_system())
> +               return false;
> +
> +       return true;
> +}
> +EXPORT_SYMBOL_GPL(wbrf_supported_consumer);
> +
> +/**
> + * wbrf_register_notifier - Register for notifications of frequency changes
> + *
> + * @nb: driver notifier block
> + *
> + * WBRF is used to mitigate devices that cause harmonic interference.
> + * This function will allow consumers to register for frequency notifications.

What's a "frequency notification"?

> + */
> +int wbrf_register_notifier(struct notifier_block *nb)
> +{
> +       return blocking_notifier_chain_register(&wbrf_chain_head, nb);
> +}
> +EXPORT_SYMBOL_GPL(wbrf_register_notifier);
> +
> +/**
> + * wbrf_unregister_notifier - Unregister for notifications of frequency changes
> + *
> + * @nb: driver notifier block
> + *
> + * WBRF is used to mitigate devices that cause harmonic interference.
> + * This function will allow consumers to unregister for frequency notifications.
> + */
> +int wbrf_unregister_notifier(struct notifier_block *nb)
> +{
> +       return blocking_notifier_chain_unregister(&wbrf_chain_head, nb);
> +}
> +EXPORT_SYMBOL_GPL(wbrf_unregister_notifier);
> +
> +/**
> + * wbrf_retrieve_exclusions - Retrieve the exclusion list
> + *
> + * @dev: device pointer
> + * @out: output structure containing the frequency ranges to be excluded

Excluded from what?

> + *
> + * Retrieve the current exclusion list

What's "the current exclusion list"?

> + */
> +int wbrf_retrieve_exclusions(struct device *dev,
> +                            struct wbrf_ranges_out *out)
> +{
> +       int r;
> +
> +       mutex_lock(&wbrf_mutex);
> +
> +       r = _wbrf_retrieve_exclusion_ranges(out);
> +
> +       mutex_unlock(&wbrf_mutex);
> +
> +       return r;
> +}
> +EXPORT_SYMBOL_GPL(wbrf_retrieve_exclusions);
> diff --git a/include/linux/wbrf.h b/include/linux/wbrf.h
> new file mode 100644
> index 000000000000..476a28fec27a
> --- /dev/null
> +++ b/include/linux/wbrf.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Wifi Band Exclusion Interface
> + * Copyright (C) 2023 Advanced Micro Devices
> + */
> +
> +#ifndef _LINUX_WBRF_H
> +#define _LINUX_WBRF_H
> +
> +#include <linux/device.h>
> +
> +/* Maximum number of wbrf ranges */
> +#define MAX_NUM_OF_WBRF_RANGES         11
> +
> +struct exclusion_range {
> +       /* start and end point of the frequency range in Hz */

I would put the comment above the whole struct definition and use the
kerneldoc format for it.

> +       u64             start;
> +       u64             end;
> +};
> +
> +struct wbrf_ranges_in {
> +       /* valid entry: `start` and `end` filled with non-zero values */

Same here.

> +       struct exclusion_range  band_list[MAX_NUM_OF_WBRF_RANGES];
> +};
> +
> +struct wbrf_ranges_out {
> +       u64                     num_of_ranges;
> +       struct exclusion_range  band_list[MAX_NUM_OF_WBRF_RANGES];
> +};
> +
> +enum wbrf_notifier_actions {
> +       WBRF_CHANGED,
> +};

No description.

> +
> +bool wbrf_supported_producer(struct device *dev);
> +int wbrf_add_exclusion(struct device *adev,
> +                      struct wbrf_ranges_in *in);
> +int wbrf_remove_exclusion(struct device *dev,
> +                         struct wbrf_ranges_in *in);
> +int wbrf_retrieve_exclusions(struct device *dev,
> +                            struct wbrf_ranges_out *out);
> +bool wbrf_supported_consumer(struct device *dev);
> +
> +int wbrf_register_notifier(struct notifier_block *nb);
> +int wbrf_unregister_notifier(struct notifier_block *nb);
> +
> +#endif /* _LINUX_WBRF_H */
> --

Overall, readers should be able to understand stuff they read.  The
above doesn't follow this rule IMO.
