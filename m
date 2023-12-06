Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7778063BC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 01:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376377AbjLFA5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 19:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjLFA5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 19:57:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25AE181
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 16:57:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B1DC433C8;
        Wed,  6 Dec 2023 00:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701824230;
        bh=FulCScgGUlz7vGN5w8rjh+EHnbhrdoBbyFWfMX8lZL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IwL7Y27Mk96BIqr4hQ4RtCykz11lDw3NRt3dTEf3vlkNVl5F9pF7HYHPx1jOCrlVq
         Q7c1Gt8eFmRM5jjqXNAv/g2vWCcr1LhiBeVyifhEf49NACVlNB7UqD9CIyKxEAGUyr
         YCkREqdgbw/QRL6+Vq7uIotTqwmeUt9tmNjb1qDkS75DeGgqb6eHAC1gsCm5FYBlNM
         2P4F6IwltpBE9L6urSNpgNuMftnttkJPBwIgQzOJ2ff/q4guHo7DOEhFL9/s4sDDqQ
         kbIdWX1pqWv+takddRESftDVv7eFn3me83wvqCeEl27m4Uu7Y5UO5lWAEfY8HFXCeX
         Nw6eZezFMKMAQ==
Date:   Wed, 6 Dec 2023 08:57:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Xiaolei Wang <xiaolei.wang@windriver.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Frank.Li@nxp.com, marcel.ziswiler@toradex.com,
        qiangqing.zhang@nxp.com, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8qm: Add imx8qm's own pm to avoid panic
 during startup
Message-ID: <20231206005704.GL236001@dragon>
References: <20231110072531.1957891-1-xiaolei.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110072531.1957891-1-xiaolei.wang@windriver.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 03:25:31PM +0800, Xiaolei Wang wrote:
> Add imx8qm's own pm, otherwise the following panic will
> occur during the startup process:
> 
>  Kernel panic - not syncing: Asynchronous SError Interrupt
>  Hardware name: Freescale i.MX8QM MEK (DT)
>  Workqueue: events_unbound deferred_probe_work_func
>  Call trace:
>   dump_backtrace+0x98/0xf0
>   show_stack+0x18/0x24
>   dump_stack_lvl+0x60/0xac
>   dump_stack+0x18/0x24
>   panic+0x340/0x3a0
>   nmi_panic+0x8c/0x90
>   arm64_serror_panic+0x6c/0x78
>   do_serror+0x3c/0x78
>   el1h_64_error_handler+0x38/0x50
>   el1h_64_error+0x64/0x68
>   fsl_edma_chan_mux+0x98/0xdc
>   fsl_edma_probe+0x278/0x898
>   platform_probe+0x68/0xd8
>   really_probe+0x110/0x27c
>   __driver_probe_device+0x78/0x12c
>   driver_probe_device+0x3c/0x118
>   __device_attach_driver+0xb8/0xf8
>   bus_for_each_drv+0x84/0xe4
>   __device_attach+0xfc/0x18c
>   device_initial_probe+0x14/0x20
> 
> Fixes: e4d7a330fb7a ("arm64: dts: imx8: add edma[0..3]")
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>

Applied, thanks!
