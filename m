Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144987860F7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 21:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238387AbjHWTsL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Aug 2023 15:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238393AbjHWTsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 15:48:07 -0400
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D2EE67;
        Wed, 23 Aug 2023 12:48:04 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-56e280cc606so830753eaf.1;
        Wed, 23 Aug 2023 12:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692820084; x=1693424884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mUbM/KdpGCgimFPfXr+6AV3VyC3hBFQTEUDZY4ceXN4=;
        b=F32X19K/uPD2/LWG9TqPD4uwOFEoETRB8qdRCTYTUVnMNOFbHeauSuvrlv38dwo8w5
         tCKrre3fHY5Ov30v6BtDoPzIXlfP6D5DpLLO8RvqT2Gb/56fIy0uKpCS8eyGr//aTH+S
         WMLs7QYTnW8+Vy9ROw4X/No4OrptYvtRQ8o83mO03Zofl3ThKjnDl8kqVz8HeoLA0zz+
         B64GLCR1A+O2rE0IGQuayswdMW0cqGwpThY5C4Anq+7c89lAV6JgjBm1EXiIgOWTGz0Z
         00LDlFiU02kHf0EQMv14UoCg07xRsBENS8sxzVQg0+pHQ8RFrIgi6C+J/2AnI/ayzUiR
         wGmQ==
X-Gm-Message-State: AOJu0YyXzF9OcpKtRPSpTs4JHzIkhyF8pVua2Xap7ES1CHzrZ/hYhzys
        fZDRmwwVjo6V1FTxhJs1ABIyiE6SGUcZjATObKG0uMrqgqI=
X-Google-Smtp-Source: AGHT+IGXcR0z6U8SimjrfPnSLkQuU9h9dwB9H4avyPrSARyBB0ZMENS7MS0f4fTm026nuB2Y2BXva4BKLY/sneB3Nx0=
X-Received: by 2002:a4a:bc82:0:b0:569:a08a:d9c5 with SMTP id
 m2-20020a4abc82000000b00569a08ad9c5mr12326345oop.0.1692820083931; Wed, 23 Aug
 2023 12:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230817121708.53213-1-ilpo.jarvinen@linux.intel.com> <20230817121708.53213-10-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20230817121708.53213-10-ilpo.jarvinen@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Aug 2023 21:47:53 +0200
Message-ID: <CAJZ5v0jZvKTMmjgb+iSdJaHpiwpWnB1fNxgreRteCyyUBS194Q@mail.gmail.com>
Subject: Re: [PATCH 09/10] thermal: Add PCIe cooling driver
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Alex Deucher <alexdeucher@gmail.com>
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

On Thu, Aug 17, 2023 at 2:18 PM Ilpo Järvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> Add a thermal cooling driver to provide path to access PCIe bandwidth
> controller using the usual thermal interfaces.
>
> A cooling device is instantiated for controllable PCIe ports from the
> bwctrl service driver.
>
> The thermal side state 0 means no throttling, i.e., maximum supported
> PCIe speed.
>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

From the cooling device interface perspective

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  MAINTAINERS                    |   1 +
>  drivers/pci/pcie/bwctrl.c      |  11 ++++
>  drivers/thermal/Kconfig        |  10 +++
>  drivers/thermal/Makefile       |   2 +
>  drivers/thermal/pcie_cooling.c | 107 +++++++++++++++++++++++++++++++++
>  include/linux/pci-bwctrl.h     |  15 +++++
>  6 files changed, 146 insertions(+)
>  create mode 100644 drivers/thermal/pcie_cooling.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d2eed2883a43..a0b40253fd5a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16421,6 +16421,7 @@ PCIE BANDWIDTH CONTROLLER
>  M:     Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>  S:     Supported
>  F:     drivers/pci/pcie/bwctrl.c
> +F:     drivers/thermal/pcie_cooling.c
>  F:     include/linux/pci-bwctrl.h
>
>  PCIE DRIVER FOR AMAZON ANNAPURNA LABS
> diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
> index e3172d69476f..13c73546244e 100644
> --- a/drivers/pci/pcie/bwctrl.c
> +++ b/drivers/pci/pcie/bwctrl.c
> @@ -34,9 +34,11 @@
>  /**
>   * struct bwctrl_service_data - PCIe Port Bandwidth Controller
>   * @set_speed_mutex: serializes link speed changes
> + * @cdev: thermal cooling device associated with the port
>   */
>  struct bwctrl_service_data {
>         struct mutex set_speed_mutex;
> +       struct thermal_cooling_device *cdev;
>  };
>
>  static bool bwctrl_valid_pcie_speed(enum pci_bus_speed speed)
> @@ -253,8 +255,16 @@ static int pcie_bandwidth_notification_probe(struct pcie_device *srv)
>         pcie_enable_link_bandwidth_notification(port);
>         pci_info(port, "enabled with IRQ %d\n", srv->irq);
>
> +       data->cdev = pcie_cooling_device_register(port, srv);
> +       if (IS_ERR(data->cdev)) {
> +               ret = PTR_ERR(data->cdev);
> +               goto disable_notifications;
> +       }
>         return 0;
>
> +disable_notifications:
> +       pcie_disable_link_bandwidth_notification(srv->port);
> +       kfree(data);
>  free_irq:
>         free_irq(srv->irq, srv);
>         return ret;
> @@ -264,6 +274,7 @@ static void pcie_bandwidth_notification_remove(struct pcie_device *srv)
>  {
>         struct bwctrl_service_data *data = get_service_data(srv);
>
> +       pcie_cooling_device_unregister(data->cdev);
>         pcie_disable_link_bandwidth_notification(srv->port);
>         free_irq(srv->irq, srv);
>         mutex_destroy(&data->set_speed_mutex);
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 19a4b33cb564..7deda3a0237d 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -219,6 +219,16 @@ config DEVFREQ_THERMAL
>
>           If you want this support, you should say Y here.
>
> +config PCIE_THERMAL
> +       bool "PCIe cooling support"
> +       depends on PCIEPORTBUS
> +       select PCIE_BW
> +       help
> +         This implements PCIe cooling mechanism through bandwidth reduction
> +         for PCIe devices.
> +
> +         If you want this support, you should say Y here.
> +
>  config THERMAL_EMULATION
>         bool "Thermal emulation mode support"
>         help
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 058664bc3ec0..065972a08c84 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -30,6 +30,8 @@ thermal_sys-$(CONFIG_CPU_IDLE_THERMAL)        += cpuidle_cooling.o
>  # devfreq cooling
>  thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
>
> +thermal_sys-$(CONFIG_PCIE_THERMAL) += pcie_cooling.o
> +
>  obj-$(CONFIG_K3_THERMAL)       += k3_bandgap.o k3_j72xx_bandgap.o
>  # platform thermal drivers
>  obj-y                          += broadcom/
> diff --git a/drivers/thermal/pcie_cooling.c b/drivers/thermal/pcie_cooling.c
> new file mode 100644
> index 000000000000..d86265c03e80
> --- /dev/null
> +++ b/drivers/thermal/pcie_cooling.c
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * PCIe cooling device
> + *
> + * Copyright (C) 2023 Intel Corporation.
> + */
> +
> +#include <linux/build_bug.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/pci-bwctrl.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/thermal.h>
> +
> +#define COOLING_DEV_TYPE_PREFIX                "PCIe_Port_"
> +
> +struct pcie_cooling_device {
> +       struct pci_dev *port;
> +       struct pcie_device *pdev;
> +};
> +
> +static int pcie_cooling_get_max_level(struct thermal_cooling_device *cdev, unsigned long *state)
> +{
> +       struct pcie_cooling_device *pcie_cdev = cdev->devdata;
> +
> +       /* cooling state 0 is same as the maximum PCIe speed */
> +       *state = pcie_cdev->port->subordinate->max_bus_speed - PCIE_SPEED_2_5GT;
> +
> +       return 0;
> +}
> +
> +static int pcie_cooling_get_cur_level(struct thermal_cooling_device *cdev, unsigned long *state)
> +{
> +       struct pcie_cooling_device *pcie_cdev = cdev->devdata;
> +
> +       /* cooling state 0 is same as the maximum PCIe speed */
> +       *state = cdev->max_state -
> +                (pcie_cdev->port->subordinate->cur_bus_speed - PCIE_SPEED_2_5GT);
> +
> +       return 0;
> +}
> +
> +static int pcie_cooling_set_cur_level(struct thermal_cooling_device *cdev, unsigned long state)
> +{
> +       struct pcie_cooling_device *pcie_cdev = cdev->devdata;
> +       enum pci_bus_speed speed;
> +
> +       /* cooling state 0 is same as the maximum PCIe speed */
> +       speed = (cdev->max_state - state) + PCIE_SPEED_2_5GT;
> +
> +       return bwctrl_set_current_speed(pcie_cdev->pdev, speed);
> +}
> +
> +static struct thermal_cooling_device_ops pcie_cooling_ops = {
> +       .get_max_state = pcie_cooling_get_max_level,
> +       .get_cur_state = pcie_cooling_get_cur_level,
> +       .set_cur_state = pcie_cooling_set_cur_level,
> +};
> +
> +struct thermal_cooling_device *pcie_cooling_device_register(struct pci_dev *port,
> +                                                           struct pcie_device *pdev)
> +{
> +       struct pcie_cooling_device *pcie_cdev;
> +       struct thermal_cooling_device *cdev;
> +       size_t name_len;
> +       char *name;
> +
> +       pcie_cdev = kzalloc(sizeof(*pcie_cdev), GFP_KERNEL);
> +       if (!pcie_cdev)
> +               return ERR_PTR(-ENOMEM);
> +
> +       pcie_cdev->port = port;
> +       pcie_cdev->pdev = pdev;
> +
> +       name_len = strlen(COOLING_DEV_TYPE_PREFIX) + strlen(pci_name(port)) + 1;
> +       name = kzalloc(name_len, GFP_KERNEL);
> +       if (!name) {
> +               kfree(pcie_cdev);
> +               return ERR_PTR(-ENOMEM);
> +       }
> +
> +       snprintf(name, name_len, COOLING_DEV_TYPE_PREFIX "%s", pci_name(port));
> +       cdev = thermal_cooling_device_register(name, pcie_cdev, &pcie_cooling_ops);
> +       kfree(name);
> +
> +       return cdev;
> +}
> +
> +void pcie_cooling_device_unregister(struct thermal_cooling_device *cdev)
> +{
> +       struct pcie_cooling_device *pcie_cdev = cdev->devdata;
> +
> +       thermal_cooling_device_unregister(cdev);
> +       kfree(pcie_cdev);
> +}
> +
> +/* For bus_speed <-> state arithmetic */
> +static_assert(PCIE_SPEED_2_5GT + 1 == PCIE_SPEED_5_0GT);
> +static_assert(PCIE_SPEED_5_0GT + 1 == PCIE_SPEED_8_0GT);
> +static_assert(PCIE_SPEED_8_0GT + 1 == PCIE_SPEED_16_0GT);
> +static_assert(PCIE_SPEED_16_0GT + 1 == PCIE_SPEED_32_0GT);
> +static_assert(PCIE_SPEED_32_0GT + 1 == PCIE_SPEED_64_0GT);
> +
> +MODULE_AUTHOR("Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>");
> +MODULE_DESCRIPTION("PCIe cooling driver");
> diff --git a/include/linux/pci-bwctrl.h b/include/linux/pci-bwctrl.h
> index 46026fa25deb..366445517b72 100644
> --- a/include/linux/pci-bwctrl.h
> +++ b/include/linux/pci-bwctrl.h
> @@ -15,4 +15,19 @@ struct thermal_cooling_device;
>
>  int bwctrl_set_current_speed(struct pcie_device *srv, enum pci_bus_speed speed);
>
> +#ifdef CONFIG_PCIE_THERMAL
> +struct thermal_cooling_device *pcie_cooling_device_register(struct pci_dev *port,
> +                                                           struct pcie_device *pdev);
> +void pcie_cooling_device_unregister(struct thermal_cooling_device *cdev);
> +#else
> +static inline struct thermal_cooling_device *pcie_cooling_device_register(struct pci_dev *port,
> +                                                                         struct pcie_device *pdev)
> +{
> +       return NULL;
> +}
> +static inline void pcie_cooling_device_unregister(struct thermal_cooling_device *cdev)
> +{
> +}
> +#endif
> +
>  #endif
> --
> 2.30.2
>
