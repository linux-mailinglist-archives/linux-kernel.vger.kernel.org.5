Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F69F7E3B2D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjKGLka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjKGLk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:40:28 -0500
X-Greylist: delayed 65 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Nov 2023 03:40:24 PST
Received: from esa2.ltts.com (unknown [14.140.155.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BAE10A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 03:40:24 -0800 (PST)
IronPort-SDR: vZskKhWkhoRlNPyPhDTWyfDGqfphpKEfQVJ89sBo1eQ3eM9yA0Emtl32lLQHyQAeq57XK/VSLw
 kwt0uHE2XkXw==
Received: from unknown (HELO BLTSP01651.lnties.com) ([10.20.120.98])
  by esa2.ltts.com with ESMTP; 07 Nov 2023 17:09:15 +0530
From:   Gairuboina Sirisha <sirisha.gairuboina@Ltts.com>
To:     jpanis@baylibre.com
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        linux-kernel@vger.kernel.org, sirisha.gairuboina@Ltts.com,
        Gairuboina Sirisha <sirisha.gairuboina@ltts.com>
Subject: Re: [PATCH v1 0/3] TPS65224 PMIC driver
Date:   Tue,  7 Nov 2023 17:07:40 +0530
Message-Id: <20231107113740.1034738-1-sirisha.gairuboina@Ltts.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b9449689-73da-41a8-a94e-f82686ab0bb0@baylibre.com>
References: <b9449689-73da-41a8-a94e-f82686ab0bb0@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gairuboina Sirisha <sirisha.gairuboina@ltts.com>

> On 10/26/23 15:32, Gairuboina Sirisha wrote:
> > Added support for TPS65224 PMIC in linux.
> > This patch set includes driver for core, i2c and pfsm.
> > The driver was tested on TI's custom AM62A EVM.
> >
> > Gairuboina Sirisha (3):
> >    drivers: mfd: Add support for TPS65224
> >    drivers: mfd: Add support for TPS65224 i2c driver
> >    drivers: misc: Add support for TPS65224 pfsm driver
> >
> >   drivers/mfd/Kconfig                |  19 +
> >   drivers/mfd/Makefile               |   2 +
> >   drivers/mfd/tps65224-core.c        | 291 ++++++++++++
> >   drivers/mfd/tps65224-i2c.c         | 245 ++++++++++
> >   drivers/misc/Kconfig               |  12 +
> >   drivers/misc/Makefile              |   1 +
> >   drivers/misc/tps65224-pfsm.c       | 290 ++++++++++++
> >   include/linux/mfd/tps65224.h       | 735 +++++++++++++++++++++++++++++
> >   include/uapi/linux/tps65224_pfsm.h |  36 ++
> >   9 files changed, 1631 insertions(+)
> >   create mode 100644 drivers/mfd/tps65224-core.c
> >   create mode 100644 drivers/mfd/tps65224-i2c.c
> >   create mode 100644 drivers/misc/tps65224-pfsm.c
> >   create mode 100644 include/linux/mfd/tps65224.h
> >   create mode 100644 include/uapi/linux/tps65224_pfsm.h
>
> Hi Sirisha,
>
> These drivers strongly look like TPS6594 drivers.
>
> Instead of submitting new drivers, you should consider reusing and
> modifying the existing ones for TPS6594. You might add your new 'compatible'
> entry ("ti,tps65224-q1") in TPS6594 dt-bindings (see 'ti,tps6594.yaml' file)
> to identify your TPS65224 PMIC. This new 'compatible' would also be added
> in the existing 'tps6594_i2c_of_match_table'. You can have a look at
> 'tps->chip_id' in 'tps6594-core.c' and see how we use it to deal with slight
> differences between different PMIC IDs.

Thanks for the response. While the TPS65224 drivers follow the format and
structure of TPS6594, the register maps, masks, and ADC feature differ.
The two PMICs have overlapping features but TPS65224 is not treated as a subset.
TPS65224 is treated as a separate and independent driver instead of adding
compatibility to the existing TPS6594 driver that would then support 3 PMICS.
This separation will better support our differing PMICs.

Thanks & Regards,
Sirisha G.
