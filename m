Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DFC7C9AF9
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 21:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjJOTTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 15:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjJOTTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 15:19:00 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2241EDD;
        Sun, 15 Oct 2023 12:18:57 -0700 (PDT)
Received: from [10.20.0.66] (unknown [62.214.178.66])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id AE40E61E5FE04;
        Sun, 15 Oct 2023 21:18:08 +0200 (CEST)
Message-ID: <998aa6dd-6c21-48c8-a069-3b8cc8df2bb3@molgen.mpg.de>
Date:   Sun, 15 Oct 2023 21:18:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] usb: chipidea: Add support for NPCM
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     peter.chen@kernel.org, gregkh@linuxfoundation.org,
        avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        j.neuschaefer@gmx.net, openbmc@lists.ozlabs.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231012230057.3365626-1-tmaimon77@gmail.com>
 <20231012230057.3365626-4-tmaimon77@gmail.com>
 <7add0297-709f-4836-832f-f8fbd412eca5@molgen.mpg.de>
 <CAP6Zq1g0eT0X5UvQ6Zok=JdOb2WOJ89qFW2MtUQh_z737F7F1A@mail.gmail.com>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CAP6Zq1g0eT0X5UvQ6Zok=JdOb2WOJ89qFW2MtUQh_z737F7F1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Tomer,


Am 15.10.23 um 19:21 schrieb Tomer Maimon:

> On Fri, 13 Oct 2023 at 16:18, Paul Menzel <pmenzel@molgen.mpg.de> wrote:

>> Am 13.10.23 um 01:00 schrieb Tomer Maimon:
>>> Add Nuvoton NPCM BMC SoCs support to USB ChipIdea driver.
>>> NPCM SoC include ChipIdea IP block that used for USB device controller
>>
>> include*s*
>> “that *is* used” or just “… used for”
> Will do
>>
>>> mode.
>>
>> Please add a line, how you tested this patch.
> I don't recall "how you tested the patch" done in the commit message,
> I can add it in the cover letter

In my opinion, adding a separate paragraph to the commit message would 
be best.

>>> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>>> Acked-by: Peter Chen <peter.chen@kernel.org>
>>> ---
>>>    drivers/usb/chipidea/Kconfig        |   4 +
>>>    drivers/usb/chipidea/Makefile       |   1 +
>>>    drivers/usb/chipidea/ci_hdrc_npcm.c | 114 ++++++++++++++++++++++++++++
>>>    3 files changed, 119 insertions(+)
>>>    create mode 100644 drivers/usb/chipidea/ci_hdrc_npcm.c
>>>
>>> diff --git a/drivers/usb/chipidea/Kconfig b/drivers/usb/chipidea/Kconfig
>>> index c815824a0b2d..bab45bc62361 100644
>>> --- a/drivers/usb/chipidea/Kconfig
>>> +++ b/drivers/usb/chipidea/Kconfig
>>> @@ -43,6 +43,10 @@ config USB_CHIPIDEA_MSM
>>>        tristate "Enable MSM hsusb glue driver" if EXPERT
>>>        default USB_CHIPIDEA
>>>
>>> +config USB_CHIPIDEA_NPCM
>>> +     tristate "Enable NPCM hsusb glue driver" if EXPERT
>>> +     default USB_CHIPIDEA
>>> +
>>>    config USB_CHIPIDEA_IMX
>>>        tristate "Enable i.MX USB glue driver" if EXPERT
>>>        depends on OF
>>> diff --git a/drivers/usb/chipidea/Makefile b/drivers/usb/chipidea/Makefile
>>> index 71afeab97e83..718cb24603dd 100644
>>> --- a/drivers/usb/chipidea/Makefile
>>> +++ b/drivers/usb/chipidea/Makefile
>>> @@ -13,6 +13,7 @@ ci_hdrc-$(CONFIG_USB_OTG_FSM)               += otg_fsm.o
>>>
>>>    obj-$(CONFIG_USB_CHIPIDEA_GENERIC)  += ci_hdrc_usb2.o
>>>    obj-$(CONFIG_USB_CHIPIDEA_MSM)              += ci_hdrc_msm.o
>>> +obj-$(CONFIG_USB_CHIPIDEA_NPCM)              += ci_hdrc_npcm.o
>>>    obj-$(CONFIG_USB_CHIPIDEA_PCI)              += ci_hdrc_pci.o
>>>    obj-$(CONFIG_USB_CHIPIDEA_IMX)              += usbmisc_imx.o ci_hdrc_imx.o
>>>    obj-$(CONFIG_USB_CHIPIDEA_TEGRA)    += ci_hdrc_tegra.o
>>> diff --git a/drivers/usb/chipidea/ci_hdrc_npcm.c b/drivers/usb/chipidea/ci_hdrc_npcm.c
>>> new file mode 100644
>>> index 000000000000..37b64a3dbd96
>>> --- /dev/null
>>> +++ b/drivers/usb/chipidea/ci_hdrc_npcm.c
>>> @@ -0,0 +1,114 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +// Copyright (c) 2023 Nuvoton Technology corporation.
>>> +
>>> +#include <linux/module.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/pm_runtime.h>
>>> +#include <linux/usb/chipidea.h>
>>> +#include <linux/clk.h>
>>> +#include <linux/io.h>
>>> +#include <linux/reset-controller.h>
>>> +#include <linux/of.h>
>>> +
>>> +#include "ci.h"
>>> +
>>> +struct npcm_udc_data {
>>> +     struct platform_device  *ci;
>>> +     struct clk              *core_clk;
>>> +     struct ci_hdrc_platform_data pdata;
>>> +};
>>> +
>>> +static int npcm_udc_notify_event(struct ci_hdrc *ci, unsigned event)
>>> +{
>>> +     struct device *dev = ci->dev->parent;
>>> +
>>> +     switch (event) {
>>> +     case CI_HDRC_CONTROLLER_RESET_EVENT:
>>> +             /* clear all mode bits */
>>> +             hw_write(ci, OP_USBMODE, 0xffffffff, 0x0);
>>> +             break;
>>> +     default:
>>> +             dev_dbg(dev, "unknown ci_hdrc event\n");
>>
>> Please print it out.
> Do you mean instead dev_dbg to use dev_info? in that case, each event
> that didnt handled will cause a print.

Sorry for not being clear. I meant print out `event`.

>>> +             break;
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int npcm_udc_probe(struct platform_device *pdev)
>>> +{
>>> +     int ret;
>>> +     struct npcm_udc_data *ci;
>>> +     struct platform_device *plat_ci;
>>> +     struct device *dev = &pdev->dev;
>>> +
>>> +     ci = devm_kzalloc(&pdev->dev, sizeof(*ci), GFP_KERNEL);
>>> +     if (!ci)
>>> +             return -ENOMEM;
>>> +     platform_set_drvdata(pdev, ci);
>>> +
>>> +     ci->core_clk = devm_clk_get_optional(dev, NULL);
>>> +     if (IS_ERR(ci->core_clk))
>>> +             return PTR_ERR(ci->core_clk);
>>> +
>>> +     ret = clk_prepare_enable(ci->core_clk);
>>> +     if (ret)
>>> +             return dev_err_probe(dev, ret, "failed to enable the clock: %d\n", ret);
>>> +
>>> +     ci->pdata.name = dev_name(dev);
>>> +     ci->pdata.capoffset = DEF_CAPOFFSET;
>>> +     ci->pdata.flags = CI_HDRC_REQUIRES_ALIGNED_DMA |
>>> +             CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS;
>>> +     ci->pdata.phy_mode = USBPHY_INTERFACE_MODE_UTMI;
>>> +     ci->pdata.notify_event = npcm_udc_notify_event;
>>> +
>>> +     plat_ci = ci_hdrc_add_device(dev, pdev->resource, pdev->num_resources,
>>> +                                  &ci->pdata);
>>> +     if (IS_ERR(plat_ci)) {
>>> +             ret = PTR_ERR(plat_ci);
>>> +             dev_err(dev, "failed to register HDRC NPCM device: %d\n", ret);
>>> +             goto clk_err;
>>> +     }
>>> +
>>> +     pm_runtime_no_callbacks(dev);
>>> +     pm_runtime_enable(dev);
>>> +
>>> +     return 0;
>>> +
>>> +clk_err:
>>> +     clk_disable_unprepare(ci->core_clk);
>>> +     return ret;
>>> +}
>>> +
>>> +static int npcm_udc_remove(struct platform_device *pdev)
>>> +{
>>> +     struct npcm_udc_data *ci = platform_get_drvdata(pdev);
>>> +
>>> +     pm_runtime_disable(&pdev->dev);
>>> +     ci_hdrc_remove_device(ci->ci);
>>> +     clk_disable_unprepare(ci->core_clk);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static const struct of_device_id npcm_udc_dt_match[] = {
>>> +     { .compatible = "nuvoton,npcm750-udc", },
>>> +     { .compatible = "nuvoton,npcm845-udc", },
>>> +     { }
>>> +};
>>> +MODULE_DEVICE_TABLE(of, npcm_udc_dt_match);
>>> +
>>> +static struct platform_driver npcm_udc_driver = {
>>> +     .probe = npcm_udc_probe,
>>> +     .remove = npcm_udc_remove,
>>> +     .driver = {
>>> +             .name = "npcm_udc",
>>> +             .of_match_table = npcm_udc_dt_match,
>>> +     },
>>> +};
>>> +
>>> +module_platform_driver(npcm_udc_driver);
>>> +
>>> +MODULE_DESCRIPTION("NPCM USB device controller driver");
>>> +MODULE_AUTHOR("Tomer Maimon <tomer.maimon@nuvoton.com>");
>>
>> Should that address also be recorded as the patch author?
> I prefer to use this e-mail since this is my main e-mail.

Alright, if it’s fine with your employer that’s great.

>>> +MODULE_LICENSE("GPL v2");


Kind regards,

Paul
