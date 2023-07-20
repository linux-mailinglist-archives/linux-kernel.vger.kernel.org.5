Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B80E75B195
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 16:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjGTOtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 10:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjGTOs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:48:59 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC9926B8;
        Thu, 20 Jul 2023 07:48:54 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 631C661E5FE01;
        Thu, 20 Jul 2023 16:47:49 +0200 (CEST)
Message-ID: <2f9858b0-88e2-736a-f16a-f4fbe549e389@molgen.mpg.de>
Date:   Thu, 20 Jul 2023 16:47:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/4] peci: Add peci-npcm controller driver
Content-Language: en-US
To:     Iwona Winiarska <iwona.winiarska@intel.com>
Cc:     avifishman70@gmail.com, Benjamin Fair <benjaminfair@google.com>,
        tmaimon77@gmail.com, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, venture@google.com,
        warp5tw@gmail.com, conor+dt@kernel.org, openbmc@lists.ozlabs.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
References: <20230719220853.1029316-1-iwona.winiarska@intel.com>
 <20230719220853.1029316-3-iwona.winiarska@intel.com>
 <dfda43af-e9b4-85bf-e165-02127e02fbf0@molgen.mpg.de>
 <9a6eb22ef6b7a6a686250ed83894e8d37de30baa.camel@intel.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <9a6eb22ef6b7a6a686250ed83894e8d37de30baa.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Iwona,


Thank you for the quick reply.

Am 20.07.23 um 10:38 schrieb Winiarska, Iwona:
> On Thu, 2023-07-20 at 08:20 +0200, Paul Menzel wrote:

>> Am 20.07.23 um 00:08 schrieb Iwona Winiarska:
>>> From: Tomer Maimon <tmaimon77@gmail.com>
>>>
>>> Add support for Nuvoton NPCM BMC hardware to the Platform Environment
>>> Control Interface (PECI) subsystem.
>>
>> Please elaborate on the implementation, and document the used datasheets.
> 
> As far as I know, there is no publicly available documentation.

Too bad. Documenting the datasheet name and version is still important, 
so developers could request it, and it can be mapped, once they are made 
public.

>> Additionally, please document how you tested this.
> 
> Are you asking to include this information in the commit message?

Yes.

> That would be unusual.
> But in general - it's a controller driver, it allows PECI subsystem to detect
> devices behind it and for PECI drivers to bind to those devices.

Having a test line in the commit message is not unusual at. So people 
with systems where it doesn’t work, could replicate the test setup to at 
least verify that it works in that configuration.

>>> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>>> Signed-off-by: Tyrone Ting <warp5tw@gmail.com>
>>> Co-developed-by: Iwona Winiarska <iwona.winiarska@intel.com>
>>> Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
>>> ---
>>>    drivers/peci/controller/Kconfig     |  16 ++
>>>    drivers/peci/controller/Makefile    |   1 +
>>>    drivers/peci/controller/peci-npcm.c | 298 ++++++++++++++++++++++++++++
>>>    3 files changed, 315 insertions(+)
>>>    create mode 100644 drivers/peci/controller/peci-npcm.c
>>>
>>> diff --git a/drivers/peci/controller/Kconfig
>>> b/drivers/peci/controller/Kconfig
>>> index 2fc5e2abb74a..4f9c245ad042 100644
>>> --- a/drivers/peci/controller/Kconfig
>>> +++ b/drivers/peci/controller/Kconfig
>>> @@ -16,3 +16,19 @@ config PECI_ASPEED
>>>    
>>>            This driver can also be built as a module. If so, the module will
>>>            be called peci-aspeed.
>>> +
>>> +config PECI_NPCM
>>> +       tristate "Nuvoton NPCM PECI support"
>>> +       depends on ARCH_NPCM || COMPILE_TEST
>>> +       depends on OF
>>> +       select REGMAP_MMIO
>>> +       help
>>> +         This option enables PECI controller driver for Nuvoton NPCM7XX
>>> +         and NPCM8XX SoCs. It allows BMC to discover devices connected
>>> +         to it and communicate with them using PECI protocol.
>>> +
>>> +         Say Y here if you want support for the Platform Environment
>>> Control
>>> +         Interface (PECI) bus adapter driver on the Nuvoton NPCM SoCs.
>>> +
>>> +         This support is also available as a module. If so, the module
>>> +         will be called peci-npcm.
>>> diff --git a/drivers/peci/controller/Makefile
>>> b/drivers/peci/controller/Makefile
>>> index 022c28ef1bf0..e247449bb423 100644
>>> --- a/drivers/peci/controller/Makefile
>>> +++ b/drivers/peci/controller/Makefile
>>> @@ -1,3 +1,4 @@
>>>    # SPDX-License-Identifier: GPL-2.0-only
>>>    
>>>    obj-$(CONFIG_PECI_ASPEED)     += peci-aspeed.o
>>> +obj-$(CONFIG_PECI_NPCM)                += peci-npcm.o
>>> diff --git a/drivers/peci/controller/peci-npcm.c
>>> b/drivers/peci/controller/peci-npcm.c
>>> new file mode 100644
>>> index 000000000000..3647e3628a17
>>> --- /dev/null
>>> +++ b/drivers/peci/controller/peci-npcm.c
>>> @@ -0,0 +1,298 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +// Copyright (c) 2019 Nuvoton Technology corporation.
>>
>> No dot/period at the end.
>>
>> […]
>>
>>> +static int npcm_peci_xfer(struct peci_controller *controller, u8 addr, struct peci_request *req)
>>> +{
>>> +       struct npcm_peci *priv = dev_get_drvdata(controller->dev.parent);
>>> +       unsigned long timeout = msecs_to_jiffies(priv->cmd_timeout_ms);
>>> +       unsigned int msg_rd;
>>> +       u32 cmd_sts;
>>> +       int i, ret;
>>> +
>>> +       /* Check command sts and bus idle state */
>>> +       ret = regmap_read_poll_timeout(priv->regmap, NPCM_PECI_CTL_STS, cmd_sts,
>>> +                                      !(cmd_sts & NPCM_PECI_CTRL_START_BUSY),
>>> +                                      NPCM_PECI_IDLE_CHECK_INTERVAL_USEC,
>>> +                                      NPCM_PECI_IDLE_CHECK_TIMEOUT_USEC);
>>> +       if (ret)
>>> +               return ret; /* -ETIMEDOUT */
>>> +
>>> +       spin_lock_irq(&priv->lock);
>>> +       reinit_completion(&priv->xfer_complete);
>>> +
>>> +       regmap_write(priv->regmap, NPCM_PECI_ADDR, addr);
>>> +       regmap_write(priv->regmap, NPCM_PECI_RD_LENGTH, NPCM_PECI_WR_LEN_MASK & req->rx.len);
>>> +       regmap_write(priv->regmap, NPCM_PECI_WR_LENGTH, NPCM_PECI_WR_LEN_MASK & req->tx.len);
>>> +
>>> +       if (req->tx.len) {
>>> +               regmap_write(priv->regmap, NPCM_PECI_CMD, req->tx.buf[0]);
>>> +
>>> +               for (i = 0; i < (req->tx.len - 1); i++)
>>> +                       regmap_write(priv->regmap, NPCM_PECI_DAT_INOUT(i), req->tx.buf[i + 1]);
>>> +       }
>>> +
>>> +#if IS_ENABLED(CONFIG_DYNAMIC_DEBUG)
>>> +       dev_dbg(priv->dev, "addr : %#02x, tx.len : %#02x, rx.len : %#02x\n",
>>> +               addr, req->tx.len, req->rx.len);
>>> +       print_hex_dump_bytes("TX : ", DUMP_PREFIX_NONE, req->tx.buf, req-tx.len);
>>> +#endif
>>
>> The preprocessor guards are not needed, as it’s taken care of in
>> `include/linux/printk.h`. Also in other parts of the patch.
> 
> Since this is dumping the raw contents of PECI messages, it's going to be quite
> verbose. The idea behind preprocessor guard is that we don't ever want this to
> be converted to regular printk. If there's no dynamic debug available - this
> won't be printed unconditionally (even with -DDEBUG).

How will it be converted to a regular printk?

     #if defined(CONFIG_DYNAMIC_DEBUG) || \
         (defined(CONFIG_DYNAMIC_DEBUG_CORE) && 
defined(DYNAMIC_DEBUG_MODULE))
     #define print_hex_dump_debug(prefix_str, prefix_type, rowsize,      \
                              groupsize, buf, len, ascii)        \
         dynamic_hex_dump(prefix_str, prefix_type, rowsize,      \
                          groupsize, buf, len, ascii)
     #elif defined(DEBUG)
     #define print_hex_dump_debug(prefix_str, prefix_type, rowsize, 
         \
                              groupsize, buf, len, ascii)                \
         print_hex_dump(KERN_DEBUG, prefix_str, prefix_type, rowsize,    \
                        groupsize, buf, len, ascii)
     #else
     static inline void print_hex_dump_debug(const char *prefix_str, int 
prefix_type,
                                         int rowsize, int groupsize,
                                         const void *buf, size_t len, 
bool ascii)
     {
     }
     #endif

>> […]
>>
>>> +module_platform_driver(npcm_peci_driver);
>>> +
>>> +MODULE_AUTHOR("Tomer Maimon <tomer.maimon@nuvoton.com>");
>>> +MODULE_DESCRIPTION("NPCM PECI driver");
>>> +MODULE_LICENSE("GPL");
>>> +MODULE_IMPORT_NS(PECI);
>>
>> Also add an entry to `MAINTAINERS`, if Tomer is going to be the maintainer?
> 
> All of the newly added files should already be covered by either ARM/NUVOTON
> NPCM ARCHITECTURE or PECI SUBSYSTEM.

Good to know. Thank you.


Kind regards,

Paul
