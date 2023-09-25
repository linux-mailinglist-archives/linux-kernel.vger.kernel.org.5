Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD47F7AD476
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbjIYJZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbjIYJZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:25:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9609EC0;
        Mon, 25 Sep 2023 02:24:56 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F3E29660730D;
        Mon, 25 Sep 2023 10:24:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695633895;
        bh=oXTaqU/0LXroHDCun0xPazJHzuVfyWQ2PEcIzKjQkvs=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=PbOPNH80AdQXwUOL0kxh7xO3v3mWaQrI+BzKISdy27F3UsXJUs2gJzQDR8VvIe4KY
         TkiN/NTsAYrbzGxc0dIilRHQ4DhbC/tbmxKV8gDHHP4KnnZOQiAB5qo3mNwRQTS3dm
         4y8yJ9cC+8QZguVKOWusq6tbmawqS4QWE6x5jFx4ZynLog0SPSp0yAKbkdnTZG0CiQ
         9CqvRU7MzFS3LClIvxQ4dux35Ghw9ymEvsAWFEjSDtyQkhLOVYQMs8ikQ3D9SFsTYB
         rnQCuVYwxwjdqpmIh0xxB/lHoDCTVMXyxtaS+lkav7K45NcOBZYkDuXzYdNcFIkV6/
         9W9VTRp1e1qGw==
Message-ID: <0faf957c-ebfe-3f2f-acb8-6dfcd7fd0d60@collabora.com>
Date:   Mon, 25 Sep 2023 11:24:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v1] mmc: mtk-sd: Use readl_poll_timeout_atomic in
 msdc_reset_hw
Content-Language: en-US
To:     Pablo Sun <pablo.sun@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230922095348.22182-1-pablo.sun@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230922095348.22182-1-pablo.sun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 22/09/23 11:53, Pablo Sun ha scritto:
> Use atomic readl_poll_timeout_atomic, because msdc_reset_hw
> may be invoked in IRQ handler in the following context:
> 
>    msdc_irq() -> msdc_cmd_done() -> msdc_reset_hw()
> 
> The following kernel BUG stack trace can be observed on
> Genio 1200 EVK after initializing MSDC1 hardware during kernel boot:
> 
> [    1.187441] BUG: scheduling while atomic: swapper/0/0/0x00010002
> [    1.189157] Modules linked in:
> [    1.204633] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.15.42-mtk+modified #1
> [    1.205713] Hardware name: MediaTek Genio 1200 EVK-P1V2-EMMC (DT)
> [    1.206484] Call trace:
> [    1.206796]  dump_backtrace+0x0/0x1ac
> [    1.207266]  show_stack+0x24/0x30
> [    1.207692]  dump_stack_lvl+0x68/0x84
> [    1.208162]  dump_stack+0x1c/0x38
> [    1.208587]  __schedule_bug+0x68/0x80
> [    1.209056]  __schedule+0x6ec/0x7c0
> [    1.209502]  schedule+0x7c/0x110
> [    1.209915]  schedule_hrtimeout_range_clock+0xc4/0x1f0
> [    1.210569]  schedule_hrtimeout_range+0x20/0x30
> [    1.211148]  usleep_range_state+0x84/0xc0
> [    1.211661]  msdc_reset_hw+0xc8/0x1b0
> [    1.212134]  msdc_cmd_done.isra.0+0x4ac/0x5f0
> [    1.212693]  msdc_irq+0x104/0x2d4
> [    1.213121]  __handle_irq_event_percpu+0x68/0x280
> [    1.213725]  handle_irq_event+0x70/0x15c
> [    1.214230]  handle_fasteoi_irq+0xb0/0x1a4
> [    1.214755]  handle_domain_irq+0x6c/0x9c
> [    1.215260]  gic_handle_irq+0xc4/0x180
> [    1.215741]  call_on_irq_stack+0x2c/0x54
> [    1.216245]  do_interrupt_handler+0x5c/0x70
> [    1.216782]  el1_interrupt+0x30/0x80
> [    1.217242]  el1h_64_irq_handler+0x1c/0x2c
> [    1.217769]  el1h_64_irq+0x78/0x7c
> [    1.218206]  cpuidle_enter_state+0xc8/0x600
> [    1.218744]  cpuidle_enter+0x44/0x5c
> [    1.219205]  do_idle+0x224/0x2d0
> [    1.219624]  cpu_startup_entry+0x30/0x80
> [    1.220129]  rest_init+0x108/0x134
> [    1.220568]  arch_call_rest_init+0x1c/0x28
> [    1.221094]  start_kernel+0x6c0/0x700
> [    1.221564]  __primary_switched+0xc0/0xc8
> 
> Fixes: ffaea6ebfe9c ("mmc: mtk-sd: Use readl_poll_timeout instead of open-coded polling")
> Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioachino.delregno@collabora.com>

