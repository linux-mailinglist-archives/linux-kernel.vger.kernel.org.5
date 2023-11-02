Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1427DF503
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbjKBO3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjKBO3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:29:06 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470C3194
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:28:59 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5079f3f3d7aso1237794e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 07:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698935337; x=1699540137; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P3lmLdjQaNimcJWA3Fr+Yw1sTpIlS4jtMo4awig5S1k=;
        b=vSrRzwKd/7GhL0+Wrrd9PVyxDzAwja2Eow30R/qcLDwdm9XkRMEjLHOn9/8Gb7t41w
         PEITx14RHg4e/VAcajYt3hjwgwcsk4IfhvIAdLOqJvqb1vcmAieZrQ2Wi8Whprno762+
         OPGSV5XZ+1AO7D9j+HpEc7VA6Yt3Tf16+MnFzJI6PPMtvKJmlOSqKBzyaKU2uzJ5HRYO
         dssXH/hXpJNu4cHLArNrs9qqlmkDLJOVathKAwDzMkQbHmeHx95EnTFtdD6i8oxK/ucm
         CP4jL6P+cLOZ+xYynsn8IbX8leWQ3rKPx+fe1TesXCJKM19pWNsxoAXu+kRTKB0dZS8y
         LqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698935337; x=1699540137;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P3lmLdjQaNimcJWA3Fr+Yw1sTpIlS4jtMo4awig5S1k=;
        b=GYjJFfAWE5R3dk5xxTP9QS+tVb80GqF1YWMCwPqZllAoYFJbUkmR7Peh6K1w5mWvAo
         SPukB7ErVFbbkyg7TutF8Hhpr0r111iX2Z6Dzwv/8M04j2BoTOIwJICuPt3DHHwo3xk7
         5btR3cI/EzyAUoaa8rkEuc9yWI/waEe+iN+mwFv7NIjcnZ8bMUWAWkWgEGM4yZ1ZxV/e
         n0qmzW4wyTv7VtRMrTkw4rpiNz2jFlC6/R85IukmFAbT/9ddemwnb0v6xSwqTLwN7q6W
         xr/tnYQJ4Sjy8K97oDHSR61PVgBvAVxvnJvPn4vrlEGPQNzWWKiO7U/kDmhKosIH/Oay
         GtVA==
X-Gm-Message-State: AOJu0YwTIiK90+rELv6qVq/bqtVAEYMYMyzSubDMb0MLKCiH3NrYZ8ag
        sW6P2ogw1wEyegr1mOm+j4uT1N6UaABpopvNzUAIVw==
X-Google-Smtp-Source: AGHT+IGs0t6q6TkBlLPGWqM1z4pytxSxeS3aX2awqyyZpcVQDz0zPYHXf6fCdagD0an24H9BwKAbRVXQU1WJvefrHxQ=
X-Received: by 2002:ac2:4571:0:b0:509:43c8:f5d9 with SMTP id
 k17-20020ac24571000000b0050943c8f5d9mr3025234lfm.49.1698935337467; Thu, 02
 Nov 2023 07:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231102073056.174480-1-sumit.garg@linaro.org> <20231102073056.174480-2-sumit.garg@linaro.org>
In-Reply-To: <20231102073056.174480-2-sumit.garg@linaro.org>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Thu, 2 Nov 2023 16:28:21 +0200
Message-ID: <CAC_iWjL_DLrKqbxvnWPmOYxLULjC46LMca5cF_sza1LDyifuWA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] tee: optee: Fix supplicant based device enumeration
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     jens.wiklander@linaro.org, op-tee@lists.trustedfirmware.org,
        jan.kiszka@siemens.com, arnd@linaro.org, ardb@kernel.org,
        jerome.forissier@linaro.org, masahisa.kojima@linaro.org,
        maxim.uvarov@linaro.org, jarkko.sakkinen@linux.intel.com,
        linux-kernel@vger.kernel.org, diogo.ivo@siemens.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumit,

On Thu, 2 Nov 2023 at 09:31, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Currently supplicant dependent optee device enumeration only registers
> devices whenever tee-supplicant is invoked for the first time. But it
> forgets to remove devices when tee-supplicant daemon stops running and
> closes its context gracefully. This leads to following error for fTPM
> driver during reboot/shutdown:
>
> [   73.466791] tpm tpm0: ftpm_tee_tpm_op_send: SUBMIT_COMMAND invoke error: 0xffff3024
>
> Fix this by adding an attribute for supplicant dependent devices so that
> the user-space service can detect and detach supplicant devices before
> closing the supplicant:
>
> $ for dev in /sys/bus/tee/devices/*; do if [[ -f "$dev/need_supplicant" && -f "$dev/driver/unbind" ]]; \
>       then echo $(basename "$dev") > $dev/driver/unbind; fi done
>
> Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
> Link: https://github.com/OP-TEE/optee_os/issues/6094
> Fixes: 5f178bb71e3a ("optee: enable support for multi-stage bus enumeration")
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  .../ABI/testing/sysfs-bus-optee-devices         |  9 +++++++++
>  drivers/tee/optee/device.c                      | 17 +++++++++++++++--
>  2 files changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-optee-devices b/Documentation/ABI/testing/sysfs-bus-optee-devices
> index 0f58701367b6..d914f6629662 100644
> --- a/Documentation/ABI/testing/sysfs-bus-optee-devices
> +++ b/Documentation/ABI/testing/sysfs-bus-optee-devices
> @@ -6,3 +6,12 @@ Description:
>                 OP-TEE bus provides reference to registered drivers under this directory. The <uuid>
>                 matches Trusted Application (TA) driver and corresponding TA in secure OS. Drivers
>                 are free to create needed API under optee-ta-<uuid> directory.
> +
> +What:          /sys/bus/tee/devices/optee-ta-<uuid>/need_supplicant
> +Date:          July 2008

nit, date needs changing

> +KernelVersion: 6.7
> +Contact:       op-tee@lists.trustedfirmware.org
> +Description:
> +               Allows to distinguish whether an OP-TEE based TA/device requires user-space
> +               tee-supplicant to function properly or not. This attribute will be present for
> +               devices which depend on tee-supplicant to be running.
> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> index 64f0e047c23d..4b1092127694 100644
> --- a/drivers/tee/optee/device.c
> +++ b/drivers/tee/optee/device.c
> @@ -60,7 +60,16 @@ static void optee_release_device(struct device *dev)
>         kfree(optee_device);
>  }
>
> -static int optee_register_device(const uuid_t *device_uuid)
> +static ssize_t

(struct device *dev,
> +                                   struct device_attribute *attr,
> +                                   char *buf)
> +{
> +       return 0;
> +}
> +
> +static DEVICE_ATTR_RO(need_supplicant);
> +
> +static int optee_register_device(const uuid_t *device_uuid, u32 func)
>  {
>         struct tee_client_device *optee_device = NULL;
>         int rc;
> @@ -83,6 +92,10 @@ static int optee_register_device(const uuid_t *device_uuid)
>                 put_device(&optee_device->dev);
>         }
>
> +       if (func == PTA_CMD_GET_DEVICES_SUPP)
> +               device_create_file(&optee_device->dev,
> +                                  &dev_attr_need_supplicant);
> +
>         return rc;
>  }
>
> @@ -142,7 +155,7 @@ static int __optee_enumerate_devices(u32 func)
>         num_devices = shm_size / sizeof(uuid_t);
>
>         for (idx = 0; idx < num_devices; idx++) {
> -               rc = optee_register_device(&device_uuid[idx]);
> +               rc = optee_register_device(&device_uuid[idx], func);
>                 if (rc)
>                         goto out_shm;
>         }
> --
> 2.34.1
>

Other than that
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
