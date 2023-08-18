Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63E078123B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 19:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379161AbjHRRmD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Aug 2023 13:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379164AbjHRRl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:41:58 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B077930F1;
        Fri, 18 Aug 2023 10:41:54 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-56e9b517f85so95282eaf.0;
        Fri, 18 Aug 2023 10:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692380514; x=1692985314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wscjGTGPXjfzpIU1s8QS1Sla/Qw0NsziElX9VCZixic=;
        b=Ji8EVD1WqHFv7IcP9FXE6G4wVHvlDbMjXL7W0fltb+l1ywoLT5ZGQwy7HKR8dvAXmT
         NvYeigsIswsBJ7n1oJGfeXUG9T4foA8M20MXjUFRRNZi3VKppd8b7BH5JrLihrpWRdNX
         Cox6KKsOzjPpz349vfiXncKeVKIoa73LRDYJaQj8ZDX2hKq0V7zgq3lb52xITd7yqPxw
         j6nsYyfEDVC1FJRQ2QZB+VcVmZC4nYz4GLkBlDyhdYhZbXQJeJ1fYHDk6t5gMT/KFCn6
         Uflwb/b0zWD5nxf7LTOtjuYIwiJULU6Km3Aln0+rZ2Tsy/6BQq7s0TxBnjEzRqHxRMRZ
         KTRw==
X-Gm-Message-State: AOJu0Yw9dHIhDiBtC08vFk9YMetoRoVf9cAintmb41ip1NHVQ0y6aS5i
        1Bfgv9lZ1yjsxApC01z1T6mpPTZxOkpbyXFRHFc=
X-Google-Smtp-Source: AGHT+IHAblietyc1vcOqHUgsKERIhrb2or18rieZ9j2UCPZUKcXJ1R4vhCJl/wMZs1fZK3bDfHbxL98JIcr2CFE0yNk=
X-Received: by 2002:a4a:e706:0:b0:566:951e:140c with SMTP id
 y6-20020a4ae706000000b00566951e140cmr3627723oou.1.1692380513785; Fri, 18 Aug
 2023 10:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230818032619.3341234-1-evan.quan@amd.com> <20230818032619.3341234-3-evan.quan@amd.com>
In-Reply-To: <20230818032619.3341234-3-evan.quan@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Aug 2023 19:41:42 +0200
Message-ID: <CAJZ5v0gEiXvDnPZY___TWeFEmFQtSQ+FFqVTbD4jsguWg7G-dg@mail.gmail.com>
Subject: Re: [V9 2/9] drivers core: add ACPI based WBRF mechanism introduced
 by AMD
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 5:27 AM Evan Quan <evan.quan@amd.com> wrote:
>
> AMD has introduced an ACPI based mechanism to support WBRF for some
> platforms with AMD dGPU + WLAN. This needs support from BIOS equipped
> with necessary AML implementations and dGPU firmwares.

This needs a problem statement in the first place: What exactly caused
AMD to come up with this design?

> For those systems without the ACPI mechanism and developing solutions,
> user can use/fall-back the generic WBRF solution for diagnosing potential
> interference issues.
>
> And for the platform which does not equip with the necessary AMD ACPI
> implementations but with CONFIG_WBRF_AMD_ACPI built as 'y', it will
> fall back to generic WBRF solution if the `wbrf` is set as "on".

OK, so I suppose that the patch implements support for the AMD WBRF
firmware interface?  That needs to be stated somewhere.

From patch reverse-engineering it looks like the generic WBRF code is
updated by it to hook up to the ACPI implementation if supported.  If
my understanding is correct, it would be nice to state that in the
changelog too.

> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Co-developed-by: Evan Quan <evan.quan@amd.com>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> --
> v4->v5:
>   - promote this to be a more generic solution with input argument taking
>     `struct device` and provide better scalability to support non-ACPI
>     scenarios(Andrew)
>   - update the APIs naming and some other minor fixes(Rafael)
> v5->v6:
>   - make the code more readable and some other fixes(Andrew)
> v6->v8:
>   - drop CONFIG_WBRF_GENERIC(Mario)
>   - add `wbrf` kernel parameter for policy control(Mario)
> v8->v9:
>   - correct some coding style(Simon)
> ---
>  drivers/acpi/Makefile         |   2 +
>  drivers/acpi/amd_wbrf.c       | 294 ++++++++++++++++++++++++++++++++++
>  drivers/base/Kconfig          |  20 +++
>  drivers/base/wbrf.c           | 135 +++++++++++++---
>  include/linux/acpi_amd_wbrf.h |  25 +++
>  5 files changed, 452 insertions(+), 24 deletions(-)
>  create mode 100644 drivers/acpi/amd_wbrf.c
>  create mode 100644 include/linux/acpi_amd_wbrf.h
>
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 3fc5a0d54f6e..9185d16e4495 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -133,3 +133,5 @@ obj-$(CONFIG_ARM64)         += arm64/
>  obj-$(CONFIG_ACPI_VIOT)                += viot.o
>
>  obj-$(CONFIG_RISCV)            += riscv/
> +
> +obj-$(CONFIG_WBRF_AMD_ACPI)    += amd_wbrf.o
> diff --git a/drivers/acpi/amd_wbrf.c b/drivers/acpi/amd_wbrf.c
> new file mode 100644
> index 000000000000..0e46de3dfac7
> --- /dev/null
> +++ b/drivers/acpi/amd_wbrf.c
> @@ -0,0 +1,294 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Wifi Band Exclusion Interface (AMD ACPI Implementation)
> + * Copyright (C) 2023 Advanced Micro Devices
> + *

It would be nice to have a description of the firmware interface here,
at least in general terms.

In particular, the terminology used throughout the code must be explained.

Without it, qualifying the validity and/or usefulness of the code is
rather hard.

> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/acpi_amd_wbrf.h>
> +
> +#define ACPI_AMD_WBRF_METHOD   "\\WBRF"
> +
> +/*
> + * Functions bit vector for WBRF method
> + *
> + * Bit 0: Supported for any functions other than function 0.
> + * Bit 1: Function 1 (Add / Remove frequency) is supported.
> + * Bit 2: Function 2 (Get frequency list) is supported.
> + */
> +#define WBRF_ENABLED                           0x0
> +#define WBRF_RECORD                            0x1
> +#define WBRF_RETRIEVE                          0x2
> +
> +/* record actions */
> +#define WBRF_RECORD_ADD                0x0
> +#define WBRF_RECORD_REMOVE     0x1
> +
> +#define WBRF_REVISION          0x1
> +
> +/*
> + * The data structure used for WBRF_RETRIEVE is not natually aligned.

"naturally"

> + * And unfortunately the design has been settled down.
> + */
> +struct amd_wbrf_ranges_out {
> +       u32                     num_of_ranges;
> +       struct exclusion_range  band_list[MAX_NUM_OF_WBRF_RANGES];
> +} __packed;
> +
> +static const guid_t wifi_acpi_dsm_guid =
> +       GUID_INIT(0x7b7656cf, 0xdc3d, 0x4c1c,
> +                 0x83, 0xe9, 0x66, 0xe7, 0x21, 0xde, 0x30, 0x70);
> +
> +static int wbrf_dsm(struct acpi_device *adev, u8 fn,
> +                   union acpi_object *argv4,
> +                   union acpi_object **out)
> +{
> +       union acpi_object *obj;
> +       int rc;
> +
> +       obj = acpi_evaluate_dsm(adev->handle, &wifi_acpi_dsm_guid,
> +                               WBRF_REVISION, fn, argv4);
> +       if (!obj)
> +               return -ENXIO;
> +
> +       switch (obj->type) {
> +       case ACPI_TYPE_BUFFER:
> +               *out = obj;
> +               return 0;
> +
> +       case ACPI_TYPE_INTEGER:
> +               rc =  obj->integer.value ? -EINVAL : 0;
> +               break;
> +
> +       default:
> +               rc = -EOPNOTSUPP;
> +       }
> +
> +       ACPI_FREE(obj);
> +
> +       return rc;
> +}

The calling convention of this function isn't particularly straightforward.

Also, AFAICS, it has only one caller which passes NULL as the last
argument (which is not checked above when obj->type is
ACPI_TYPE_BUFFER, so I guess it's never been the case in practice) and
discards whatever is passed via arg4.

Why is arg4 even needed and why is the ACPI_TYPE_BUFFER case regarded
as a valid one?

> +
> +static int wbrf_record(struct acpi_device *adev, uint8_t action,
> +                      struct wbrf_ranges_in *in)
> +{
> +       union acpi_object argv4;
> +       union acpi_object *tmp;
> +       u32 num_of_ranges = 0;
> +       u32 num_of_elements;
> +       u32 arg_idx = 0;
> +       u32 loop_idx;
> +       int ret;
> +
> +       if (!in)
> +               return -EINVAL;
> +
> +       for (loop_idx = 0; loop_idx < ARRAY_SIZE(in->band_list);
> +            loop_idx++)
> +               if (in->band_list[loop_idx].start &&
> +                   in->band_list[loop_idx].end)
> +                       num_of_ranges++;
> +
> +       /*
> +        * Every range comes with two end points(start and end) and

Every range of what?

> +        * each of them is accounted as an element. Meanwhile the range
> +        * count and action type are accounted as an element each.
> +        * So, the total element count = 2 * num_of_ranges + 1 + 1.
> +        */
> +       num_of_elements = 2 * num_of_ranges + 1 + 1;
> +
> +       tmp = kcalloc(num_of_elements, sizeof(*tmp), GFP_KERNEL);
> +       if (!tmp)
> +               return -ENOMEM;
> +
> +       argv4.package.type = ACPI_TYPE_PACKAGE;
> +       argv4.package.count = num_of_elements;
> +       argv4.package.elements = tmp;
> +
> +       tmp[arg_idx].integer.type = ACPI_TYPE_INTEGER;
> +       tmp[arg_idx++].integer.value = num_of_ranges;
> +       tmp[arg_idx].integer.type = ACPI_TYPE_INTEGER;
> +       tmp[arg_idx++].integer.value = action;
> +
> +       for (loop_idx = 0; loop_idx < ARRAY_SIZE(in->band_list);
> +            loop_idx++) {
> +               if (!in->band_list[loop_idx].start ||
> +                   !in->band_list[loop_idx].end)
> +                       continue;
> +
> +               tmp[arg_idx].integer.type = ACPI_TYPE_INTEGER;
> +               tmp[arg_idx++].integer.value = in->band_list[loop_idx].start;
> +               tmp[arg_idx].integer.type = ACPI_TYPE_INTEGER;
> +               tmp[arg_idx++].integer.value = in->band_list[loop_idx].end;
> +       }
> +
> +       ret = wbrf_dsm(adev, WBRF_RECORD, &argv4, NULL);
> +
> +       kfree(tmp);
> +
> +       return ret;
> +}
> +
> +int acpi_amd_wbrf_add_exclusion(struct device *dev,
> +                               struct wbrf_ranges_in *in)
> +{
> +       struct acpi_device *adev = ACPI_COMPANION(dev);
> +
> +       if (!adev)
> +               return -ENODEV;
> +
> +       return wbrf_record(adev, WBRF_RECORD_ADD, in);
> +}
> +
> +int acpi_amd_wbrf_remove_exclusion(struct device *dev,
> +                                  struct wbrf_ranges_in *in)
> +{
> +       struct acpi_device *adev = ACPI_COMPANION(dev);
> +
> +       if (!adev)
> +               return -ENODEV;
> +
> +       return wbrf_record(adev, WBRF_RECORD_REMOVE, in);
> +}
> +
> +bool acpi_amd_wbrf_supported_system(void)
> +{
> +       acpi_status status;
> +       acpi_handle handle;
> +
> +       status = acpi_get_handle(NULL, ACPI_AMD_WBRF_METHOD, &handle);
> +
> +       return ACPI_SUCCESS(status);
> +}
> +
> +bool acpi_amd_wbrf_supported_producer(struct device *dev)
> +{
> +       struct acpi_device *adev = ACPI_COMPANION(dev);
> +
> +       if (!adev)
> +               return false;
> +
> +       return acpi_check_dsm(adev->handle, &wifi_acpi_dsm_guid,
> +                             WBRF_REVISION,
> +                             BIT(WBRF_RECORD));
> +}

All of the non-static functions need kerneldoc comments.  None of them has one.

> +
> +static union acpi_object *
> +acpi_evaluate_wbrf(acpi_handle handle, u64 rev, u64 func)
> +{
> +       acpi_status ret;
> +       struct acpi_buffer buf = {ACPI_ALLOCATE_BUFFER, NULL};
> +       union acpi_object params[4];
> +       struct acpi_object_list input = {
> +               .count = 4,
> +               .pointer = params,
> +       };
> +
> +       params[0].type = ACPI_TYPE_INTEGER;
> +       params[0].integer.value = rev;
> +       params[1].type = ACPI_TYPE_INTEGER;
> +       params[1].integer.value = func;
> +       params[2].type = ACPI_TYPE_PACKAGE;
> +       params[2].package.count = 0;
> +       params[2].package.elements = NULL;
> +       params[3].type = ACPI_TYPE_STRING;
> +       params[3].string.length = 0;
> +       params[3].string.pointer = NULL;
> +
> +       ret = acpi_evaluate_object(handle, "WBRF", &input, &buf);
> +       if (ACPI_SUCCESS(ret))
> +               return (union acpi_object *)buf.pointer;
> +
> +       return NULL;

I would do it the other way around, that is

if (ACPI_FAILURE(ret))
        return NULL;

return buf.pointer;

and the pointer cast is not necessary, because buf.pointer is void anyway.

> +}
> +
> +static bool check_acpi_wbrf(acpi_handle handle, u64 rev, u64 funcs)
> +{
> +       int i;
> +       u64 mask = 0;
> +       union acpi_object *obj;
> +
> +       if (funcs == 0)
> +               return false;
> +
> +       obj = acpi_evaluate_wbrf(handle, rev, 0);
> +       if (!obj)
> +               return false;
> +
> +       if (obj->type != ACPI_TYPE_BUFFER)
> +               return false;
> +
> +       /*
> +        * Bit vector providing supported functions information.
> +        * Each bit marks support for one specific function of the WBRF method.
> +        */
> +       for (i = 0; i < obj->buffer.length && i < 8; i++)
> +               mask |= (((u64)obj->buffer.pointer[i]) << (i * 8));

The parens in the above expression are all redundant AFAICS.

And why does this need to be so complicated?  There's only one caller
that passes only one bit in funcs, so why is this processing needed at
all?  It looks like it would be better to fold this into its caller.

> +
> +       ACPI_FREE(obj);
> +
> +       if ((mask & BIT(WBRF_ENABLED)) &&
> +           (mask & funcs) == funcs)
> +               return true;
> +
> +       return false;

return mask & BIT(WBRF_ENABLED) && (mask & funcs) == funcs;

> +}
> +
> +bool acpi_amd_wbrf_supported_consumer(struct device *dev)
> +{
> +       struct acpi_device *adev = ACPI_COMPANION(dev);
> +
> +       if (!adev)
> +               return false;
> +
> +       return check_acpi_wbrf(adev->handle,
> +                              WBRF_REVISION,
> +                              BIT(WBRF_RETRIEVE));
> +}
> +
> +int acpi_amd_wbrf_retrieve_exclusions(struct device *dev,
> +                                     struct wbrf_ranges_out *out)
> +{
> +       struct acpi_device *adev = ACPI_COMPANION(dev);
> +       struct amd_wbrf_ranges_out acpi_out = {0};
> +       union acpi_object *obj;
> +
> +       if (!adev)
> +               return -ENODEV;
> +
> +       obj = acpi_evaluate_wbrf(adev->handle,
> +                                WBRF_REVISION,
> +                                WBRF_RETRIEVE);
> +       if (!obj)
> +               return -EINVAL;
> +
> +       /*
> +        * The return buffer is with variable length and the format below:
> +        * number_of_entries(1 DWORD):       Number of entries
> +        * start_freq of 1st entry(1 QWORD): Start frequency of the 1st entry
> +        * end_freq of 1st entry(1 QWORD):   End frequency of the 1st entry
> +        * ...
> +        * ...
> +        * start_freq of the last entry(1 QWORD)
> +        * end_freq of the last entry(1 QWORD)
> +        *
> +        * Thus the buffer length is determined by the number of entries.
> +        * - For zero entry scenario, the buffer length will be 4 bytes.
> +        * - For one entry scenario, the buffer length will be 20 bytes.
> +        */
> +       if (obj->buffer.length > sizeof(acpi_out) ||
> +           obj->buffer.length < 4) {
> +               dev_err(dev, "BIOS FUBAR, ignoring wrong sized WBRT information");

What does FUBAR mean here?

Why is it printed with dev_err()?

> +               ACPI_FREE(obj);
> +               return -EINVAL;

This can jump to a label instead of doing a duplicate ACPI_FREE(obj).

> +       }
> +       memcpy(&acpi_out, obj->buffer.pointer, obj->buffer.length);
> +
> +       out->num_of_ranges = acpi_out.num_of_ranges;
> +       memcpy(out->band_list, acpi_out.band_list, sizeof(acpi_out.band_list));

While using memcpy() here seems nicer, I would copy the list in a
proper loop item by item.  Then it wouldn't be necessary to match the
sizes of elements of the source and destination arrays.

> +
> +       ACPI_FREE(obj);
> +
> +       return 0;
> +}
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 2b8fd6bb7da0..feb6f5625728 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -242,4 +242,24 @@ config FW_DEVLINK_SYNC_STATE_TIMEOUT
>           command line option on every system/board your kernel is expected to
>           work on.
>
> +menu "Wifi band RF mitigation mechanism"
> +
> +config WBRF_AMD_ACPI
> +       bool "ACPI based mechanism introduced by AMD"
> +       depends on ACPI
> +       help
> +         Wifi band RF mitigation mechanism allows multiple drivers from
> +         different domains to notify the frequencies in use so that hardware

s/notify/report/ I think.

> +         can be reconfigured to avoid harmonic conflicts.
> +
> +         AMD has introduced an ACPI based mechanism to support WBRF for some
> +         platforms with AMD dGPU and WLAN. This needs support from BIOS equipped
> +         with necessary AML implementations and dGPU firmwares.
> +
> +         Before enabling this ACPI based mechanism, it is suggested to confirm
> +         with the hardware designer/provider first whether your platform
> +         equipped with necessary BIOS and firmwares.

The above is completely unworkable for distro kernel providers who
release one binary kernel that needs to work on all platforms.

> +
> +endmenu
> +
>  endmenu
> diff --git a/drivers/base/wbrf.c b/drivers/base/wbrf.c
> index 678f245c12c6..751e252d0039 100644
> --- a/drivers/base/wbrf.c
> +++ b/drivers/base/wbrf.c
> @@ -6,9 +6,25 @@
>   */
>
>  #include <linux/wbrf.h>
> +#include <linux/acpi_amd_wbrf.h>
>
>  static BLOCKING_NOTIFIER_HEAD(wbrf_chain_head);
> +
>  static DEFINE_MUTEX(wbrf_mutex);
> +
> +static struct exclusion_range_pool {
> +       struct exclusion_range  band_list[MAX_NUM_OF_WBRF_RANGES];
> +       u64                     ref_counter[MAX_NUM_OF_WBRF_RANGES];
> +} wbrf_pool;
> +
> +enum WBRF_SUPPORT_CHECK {
> +       WBRF_SUPPORT_UNCHECKED,
> +       WBRF_SUPPORT_NONE,
> +       WBRF_SUPPORT_GENERIC,
> +       WBRF_SUPPORT_OTHERS,
> +};
> +static atomic_t wbrf_support_check = ATOMIC_INIT(WBRF_SUPPORT_UNCHECKED);
> +
>  static enum WBRF_POLICY_MODE {
>         WBRF_POLICY_FORCE_DISABLE,
>         WBRF_POLICY_AUTO,
> @@ -30,11 +46,6 @@ static int __init parse_wbrf_policy_mode(char *p)
>  }
>  early_param("wbrf", parse_wbrf_policy_mode);
>
> -static struct exclusion_range_pool {
> -       struct exclusion_range  band_list[MAX_NUM_OF_WBRF_RANGES];
> -       u64                     ref_counter[MAX_NUM_OF_WBRF_RANGES];
> -} wbrf_pool;
> -

So the previous patch should not add this definition here, should it?

>  static int _wbrf_add_exclusion_ranges(struct wbrf_ranges_in *in)
>  {
>         int i, j;
> @@ -121,20 +132,45 @@ static int _wbrf_retrieve_exclusion_ranges(struct wbrf_ranges_out *out)
>   *
>   * WBRF is used to mitigate devices that cause harmonic interference.
>   * This function will determine if the platform is able to support the
> - * WBRF features.
> + * WBRF features. For example, for AMD ACPI implementation it should say
> + * true only when the necessary AML code/logic supporting wbrf feature
> + * available.

The additional kerneldoc text doesn't seem to be particularly useful to me.

>   */
> -static bool wbrf_supported_system(void)
> +static enum WBRF_SUPPORT_CHECK wbrf_supported_system(void)
>  {
> +       enum WBRF_SUPPORT_CHECK support_check;
> +
> +       support_check = atomic_read(&wbrf_support_check);
> +       if (support_check != WBRF_SUPPORT_UNCHECKED)
> +               return support_check;
> +
> +       support_check = WBRF_SUPPORT_NONE;
> +
>         switch (wbrf_policy) {
>         case WBRF_POLICY_FORCE_ENABLE:
> -               return true;
> +#if IS_ENABLED(CONFIG_WBRF_AMD_ACPI)

No #if here, please.

> +               if (acpi_amd_wbrf_supported_system()) {
> +                       support_check = WBRF_SUPPORT_OTHERS;
> +                       break;
> +               }
> +               pr_warn_once("Force WBRF w/o acpi_amd_wbrf support\n");
> +               pr_warn_once("Fall back to generic version\n");
> +#endif
> +               support_check = WBRF_SUPPORT_GENERIC;
> +               break;
>         case WBRF_POLICY_FORCE_DISABLE:
> -               return false;
> +               break;
>         case WBRF_POLICY_AUTO:
> -               return false;
> +#if IS_ENABLED(CONFIG_WBRF_AMD_ACPI)

And same here.

> +               if (acpi_amd_wbrf_supported_system())
> +                       support_check = WBRF_SUPPORT_OTHERS;
> +#endif
> +               break;
>         }
>
> -       return false;
> +       atomic_set(&wbrf_support_check, support_check);
> +
> +       return support_check;
>  }
>
>  /**
> @@ -144,13 +180,22 @@ static bool wbrf_supported_system(void)
>   *
>   * WBRF is used to mitigate devices that cause harmonic interference.
>   * This function will determine if this device should report such frequencies.
> + * For example, for AMD ACPI implementation it should say true only when the
> + * necessary AML code/logic supporting wbrf feature available for this device.

Again, the usefulness of the added kerneldoc text is quite questionable IMV.

>   */
>  bool wbrf_supported_producer(struct device *dev)
>  {
> -       if (!wbrf_supported_system())
> +       switch (wbrf_supported_system()) {
> +       case WBRF_SUPPORT_GENERIC:
> +               return true;
> +       case WBRF_SUPPORT_OTHERS:
> +#if IS_ENABLED(CONFIG_WBRF_AMD_ACPI)

Again, no #if here, please.

> +               return acpi_amd_wbrf_supported_producer(dev);
> +#endif
> +               fallthrough;
> +       default:
>                 return false;
> -
> -       return true;
> +       }
>  }
>  EXPORT_SYMBOL_GPL(wbrf_supported_producer);
>
> @@ -166,11 +211,22 @@ EXPORT_SYMBOL_GPL(wbrf_supported_producer);
>  int wbrf_add_exclusion(struct device *dev,
>                        struct wbrf_ranges_in *in)
>  {
> -       int r;
> +       int r = -ENODEV;
>
>         mutex_lock(&wbrf_mutex);
>
> -       r = _wbrf_add_exclusion_ranges(in);
> +       switch (wbrf_supported_system()) {
> +       case WBRF_SUPPORT_OTHERS:
> +#if IS_ENABLED(CONFIG_WBRF_AMD_ACPI)

Same here.

> +               r = acpi_amd_wbrf_add_exclusion(dev, in);
> +#endif
> +               break;
> +       case WBRF_SUPPORT_GENERIC:
> +               r = _wbrf_add_exclusion_ranges(in);
> +               break;
> +       default:
> +               break;
> +       }
>
>         mutex_unlock(&wbrf_mutex);
>         if (r)
> @@ -194,11 +250,22 @@ EXPORT_SYMBOL_GPL(wbrf_add_exclusion);
>  int wbrf_remove_exclusion(struct device *dev,
>                           struct wbrf_ranges_in *in)
>  {
> -       int r;
> +       int r = -ENODEV;
>
>         mutex_lock(&wbrf_mutex);
>
> -       r = _wbrf_remove_exclusion_ranges(in);
> +       switch (wbrf_supported_system()) {
> +       case WBRF_SUPPORT_OTHERS:
> +#if IS_ENABLED(CONFIG_WBRF_AMD_ACPI)

Same here.

> +               r  = acpi_amd_wbrf_remove_exclusion(dev, in);
> +#endif
> +               break;
> +       case WBRF_SUPPORT_GENERIC:
> +               r = _wbrf_remove_exclusion_ranges(in);
> +               break;
> +       default:
> +               break;
> +       }
>
>         mutex_unlock(&wbrf_mutex);
>         if (r)
> @@ -217,14 +284,23 @@ EXPORT_SYMBOL_GPL(wbrf_remove_exclusion);
>   *
>   * WBRF is used to mitigate devices that cause harmonic interference.
>   * This function will determine if this device should react to reports from
> - * other devices for such frequencies.
> + * other devices for such frequencies. For example, for AMD ACPI implementation
> + * it should say true only when the necessary AML code/logic supporting wbrf
> + * feature available for this device.
>   */
>  bool wbrf_supported_consumer(struct device *dev)
>  {
> -       if (!wbrf_supported_system())
> +       switch (wbrf_supported_system()) {
> +       case WBRF_SUPPORT_GENERIC:
> +               return true;
> +       case WBRF_SUPPORT_OTHERS:
> +#if IS_ENABLED(CONFIG_WBRF_AMD_ACPI)

Same here.

> +               return acpi_amd_wbrf_supported_consumer(dev);
> +#endif
> +               fallthrough;
> +       default:
>                 return false;
> -
> -       return true;
> +       }
>  }
>  EXPORT_SYMBOL_GPL(wbrf_supported_consumer);
>
> @@ -267,11 +343,22 @@ EXPORT_SYMBOL_GPL(wbrf_unregister_notifier);
>  int wbrf_retrieve_exclusions(struct device *dev,
>                              struct wbrf_ranges_out *out)
>  {
> -       int r;
> +       int r = -ENODEV;
>
>         mutex_lock(&wbrf_mutex);
>
> -       r = _wbrf_retrieve_exclusion_ranges(out);
> +       switch (wbrf_supported_system()) {
> +       case WBRF_SUPPORT_OTHERS:
> +#if IS_ENABLED(CONFIG_WBRF_AMD_ACPI)

Same here.

> +               r = acpi_amd_wbrf_retrieve_exclusions(dev, out);
> +#endif
> +               break;
> +       case WBRF_SUPPORT_GENERIC:
> +               r = _wbrf_retrieve_exclusion_ranges(out);
> +               break;
> +       default:
> +               break;
> +       }
>
>         mutex_unlock(&wbrf_mutex);
>
> diff --git a/include/linux/acpi_amd_wbrf.h b/include/linux/acpi_amd_wbrf.h
> new file mode 100644
> index 000000000000..40c59e9f626d
> --- /dev/null
> +++ b/include/linux/acpi_amd_wbrf.h
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Wifi Band Exclusion Interface (AMD ACPI Implementation)
> + * Copyright (C) 2023 Advanced Micro Devices
> + *
> + */
> +
> +#ifndef _ACPI_AMD_WBRF_H
> +#define _ACPI_AMD_WBRF_H
> +
> +#include <linux/wbrf.h>
> +
> +#if IS_ENABLED(CONFIG_WBRF_AMD_ACPI)
> +bool acpi_amd_wbrf_supported_system(void);
> +bool acpi_amd_wbrf_supported_consumer(struct device *dev);
> +bool acpi_amd_wbrf_supported_producer(struct device *dev);
> +int acpi_amd_wbrf_remove_exclusion(struct device *dev,
> +                                  struct wbrf_ranges_in *in);
> +int acpi_amd_wbrf_add_exclusion(struct device *dev,
> +                               struct wbrf_ranges_in *in);
> +int acpi_amd_wbrf_retrieve_exclusions(struct device *dev,
> +                                     struct wbrf_ranges_out *out);

#else

Empty subs for all of the requisite functions go here.

> +#endif
> +
> +#endif /* _ACPI_AMD_WBRF_H */
> --
