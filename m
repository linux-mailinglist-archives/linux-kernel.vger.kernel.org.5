Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAAB7BA92D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjJEScl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjJEScf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:32:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2661136;
        Thu,  5 Oct 2023 11:32:26 -0700 (PDT)
Date:   Thu, 5 Oct 2023 20:32:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696530744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MUo9RhQVur54rsjTLOuSsct8U7o4ZE+cBz7J5uH7cuw=;
        b=c7nh+q3lE619/MY2Gn0kPk/2pTzBjfteYxWuWVyvZu58K1YxwgG1cL5suTg+1sxc2B7fbp
        WStnIgl9tobbVAAGNS6BoZjiMn7SwemmpMSmiiJivYYVXwYJcZ7yRsUp47/nNPb8zclVQV
        c2yIKOHxuPZ3I19wO330UK1BXLye0JKMWGyKnyiKqj9457Si87tMh/tqcw1sIdnbMHXXb9
        gPcarp4pmxZaZ9CPwHjjxZfMwCKPZ3m02xzdFI6OhgdH3xmq+KLPyNzBgSVk4UAwy/0ciu
        ZRDFhXFV6zcS+7zEmhKcOevmnzYgyv1jqU4c71qlilPFzOhX3hzs2R6Gh8DP7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696530744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MUo9RhQVur54rsjTLOuSsct8U7o4ZE+cBz7J5uH7cuw=;
        b=/55xMi1jpa9RR/nZD9UDy4EKUl9ohkicbxdLqrtEcDJkiapPp0gFNWOmiWUQZpT1wUcOVJ
        bbamNhkeJf36abDA==
From:   Benedikt Spranger <b.spranger@linutronix.de>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: [PATCH 1/1] clk: socfpga: gate: Fix of by factor 2 for serial
 console
Message-ID: <20231005203202.08b5d1cf@mitra>
In-Reply-To: <qpskbgigcaoyjuhzeguz366cjukv3ij7utlbkra5edhwn6uzh4@bdedm6vs62y5>
References: <20231005095927.12398-1-b.spranger@linutronix.de>
        <20231005095927.12398-2-b.spranger@linutronix.de>
        <qpskbgigcaoyjuhzeguz366cjukv3ij7utlbkra5edhwn6uzh4@bdedm6vs62y5>
Organization: Linutronix GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2023 13:34:01 +0200
Maxime Ripard <mripard@kernel.org> wrote:

> Hi,
> 
> On Thu, Oct 05, 2023 at 11:59:27AM +0200, Benedikt Spranger wrote:
> > Commit 9607beb917df ("clk: socfpga: gate: Add a determine_rate
> > hook") introduce a specific determine_rate hook. As a result the
> > calculated clock for the serial IP is off by factor 2 after that
> > i.e. if the system configures a baudrate of 115200 it is set
> > physicaly to 57600.  
> 
> Where is that factor 2 coming from?
In drivers/tty/serial/8250/8250_dw.c p->uartclk is set twice as high,
as it should be: 

dw8250_set_termios() is called and rate is evaluated to 20000000 in the
bad and 10000000 in the good case. As a result p->uartclk is set to
20000000 in the bad case.

> > Change the determine_rate hook to the reparent variant
> > __clk_mux_determine_rate() to fix the issue.  
> 
> It's also not clear to me why that would fix anything. This patch
> should only make the old behaviour explicit, could you expand a bit
> on what happens?
Booting the kernel with console=ttyS0,115200 result in a corrupted
character output. Setting the serial terminal application to 57600
make the serial console working.

I dug deeper and added some debug output (see patch below):

trace output (good - determine_rate = __clk_mux_determine_rate):
# tracer: nop
#
# entries-in-buffer/entries-written: 237/237   #P:2
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 462500000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: div_reg: div = 2
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 231250000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: div_reg: div = 2
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 115625000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: div_reg: div = 1
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 6250000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: div_reg: div = 2
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 3125000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: div_reg: div = 1
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 6250000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 6250000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 97368421
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 97368421
          <idle>-0       [000] d....     0.000000: socfpga_clk_get_parent: socfpga_clk_get_parent: name = l4_mp_clk
          <idle>-0       [000] d....     0.000000: socfpga_clk_get_parent: socfpga_clk_get_parent: l4_mp_clk = 1
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: div_reg: div = 2
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 100000000
          <idle>-0       [000] d....     0.000000: socfpga_clk_get_parent: socfpga_clk_get_parent: name = l4_sp_clk
          <idle>-0       [000] d....     0.000000: socfpga_clk_get_parent: socfpga_clk_get_parent: l4_sp_clk = 1
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: div_reg: div = 2
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 100000000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 1953125
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 250000000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: div_reg: div = 1
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 200000000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: div_reg: div = 1
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 200000000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: div_reg: div = 5
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 40000000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: div_reg: div = 5
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 40000000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: div_reg: div = 6250
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 32000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 50000000
          <idle>-0       [000] d....     0.000000: socfpga_clk_get_parent: socfpga_clk_get_parent: name = sdmmc_clk
          <idle>-0       [000] d....     0.000000: socfpga_clk_get_parent: socfpga_clk_get_parent: sdmmc_clk = 2
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 200000000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: fixed_div: div = 4
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 50000000
          <idle>-0       [000] d....     0.000000: socfpga_clk_get_parent: socfpga_clk_get_parent: name = nand_x_clk
          <idle>-0       [000] d....     0.000000: socfpga_clk_get_parent: socfpga_clk_get_parent: nand_clk / nand_x_clk = 2
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 200000000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 200000000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: fixed_div: div = 4
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 50000000
          <idle>-0       [000] d....     0.000000: socfpga_clk_get_parent: socfpga_clk_get_parent: name = qspi_clk
          <idle>-0       [000] d....     0.000000: socfpga_clk_get_parent: socfpga_clk_get_parent: qspi_clk = 1
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 3613281
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 400000000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 800000000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 400000000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 133333333
          <idle>-0       [000] d....     0.000000: clk_prepare: osc1
          <idle>-0       [000] d....     0.000000: clk_prepare_complete: osc1
          <idle>-0       [000] d....     0.000000: clk_prepare: main_pll
          <idle>-0       [000] d....     0.000000: clk_prepare_complete: main_pll
          <idle>-0       [000] d....     0.000000: clk_prepare: mpuclk
          <idle>-0       [000] d....     0.000000: clk_prepare_complete: mpuclk
          <idle>-0       [000] d....     0.000000: clk_prepare: mpu_periph_clk
          <idle>-0       [000] d....     0.000000: clk_prepare_complete: mpu_periph_clk
          <idle>-0       [000] d....     0.000000: clk_enable: osc1
          <idle>-0       [000] d....     0.000000: clk_enable_complete: osc1
          <idle>-0       [000] d....     0.000000: clk_enable: main_pll
          <idle>-0       [000] d....     0.000000: clk_enable_complete: main_pll
          <idle>-0       [000] d....     0.000000: clk_enable: mpuclk
          <idle>-0       [000] d....     0.000000: clk_enable_complete: mpuclk
          <idle>-0       [000] d....     0.000000: clk_enable: mpu_periph_clk
          <idle>-0       [000] d....     0.000000: clk_enable_complete: mpu_periph_clk
          <idle>-0       [000] d....     0.000000: clk_prepare: periph_pll
          <idle>-0       [000] d....     0.000000: clk_prepare_complete: periph_pll
          <idle>-0       [000] d....     0.000000: clk_prepare: per_base_clk
          <idle>-0       [000] d....     0.000000: clk_prepare_complete: per_base_clk
          <idle>-0       [000] d....     0.000000: clk_prepare: l4_sp_clk
          <idle>-0       [000] d....     0.000000: clk_prepare_complete: l4_sp_clk
          <idle>-0       [000] d....     0.000000: clk_enable: periph_pll
          <idle>-0       [000] d....     0.000000: clk_enable_complete: periph_pll
          <idle>-0       [000] d....     0.000000: clk_enable: per_base_clk
          <idle>-0       [000] d....     0.000000: clk_enable_complete: per_base_clk
          <idle>-0       [000] d....     0.000000: clk_enable: l4_sp_clk
          <idle>-0       [000] d....     0.000000: clk_enable_complete: l4_sp_clk
            init-1       [000] .n...     0.033332: clk_prepare: mainclk
            init-1       [000] .n...     0.033338: clk_prepare_complete: mainclk
            init-1       [000] .n...     0.033339: clk_prepare: l4_main_clk
            init-1       [000] .n...     0.033341: clk_prepare_complete: l4_main_clk
            init-1       [000] dn...     0.033344: clk_enable: mainclk
            init-1       [000] dn...     0.033345: clk_enable_complete: mainclk
            init-1       [000] dn...     0.033346: clk_enable: l4_main_clk
            init-1       [000] dn...     0.033349: clk_enable_complete: l4_main_clk
            init-1       [000] d....     0.033420: clk_disable: l4_main_clk
            init-1       [000] d....     0.033424: clk_disable_complete: l4_main_clk
            init-1       [000] d....     0.033425: clk_disable: mainclk
            init-1       [000] d....     0.033426: clk_disable_complete: mainclk
            init-1       [000] .....     0.033430: clk_unprepare: l4_main_clk
            init-1       [000] .....     0.033431: clk_unprepare_complete: l4_main_clk
            init-1       [000] .....     0.033432: clk_unprepare: mainclk
            init-1       [000] .....     0.033434: clk_unprepare_complete: mainclk
            init-1       [001] .....     0.116063: clk_rate_request_start: l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
            init-1       [001] .....     0.116089: clk_rate_request_done: l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
            init-1       [001] .....     0.116096: dw8250_set_termios: dw8250_set_termios: rate = 4294967274 newrate = 1843200
            init-1       [001] .....     0.116098: dw8250_set_termios: dw8250_set_termios: before: uartclk = 100000000
            init-1       [001] .....     0.116100: dw8250_set_termios: dw8250_set_termios: after: uartclk = 100000000
            init-1       [001] .....     0.920389: clk_prepare: emac1_clk
            init-1       [001] .....     0.920395: clk_prepare_complete: emac1_clk
            init-1       [001] .....     0.920396: clk_prepare: emac_1_clk
            init-1       [001] .....     0.920398: clk_prepare_complete: emac_1_clk
            init-1       [001] d....     0.920401: clk_enable: emac1_clk
            init-1       [001] d....     0.920403: clk_enable_complete: emac1_clk
            init-1       [001] d....     0.920404: clk_enable: emac_1_clk
            init-1       [001] d....     0.920407: clk_enable_complete: emac_1_clk
     kworker/1:1-36      [001] d....     1.041458: clk_disable: emac_1_clk
     kworker/1:1-36      [001] d....     1.041465: clk_disable_complete: emac_1_clk
     kworker/1:1-36      [001] d....     1.041466: clk_disable: emac1_clk
     kworker/1:1-36      [001] d....     1.041468: clk_disable_complete: emac1_clk
     kworker/1:1-36      [001] .....     1.041471: clk_unprepare: emac_1_clk
     kworker/1:1-36      [001] .....     1.041473: clk_unprepare_complete: emac_1_clk
     kworker/1:1-36      [001] .....     1.041474: clk_unprepare: emac1_clk
     kworker/1:1-36      [001] .....     1.041475: clk_unprepare_complete: emac1_clk
            init-1       [001] .....     1.041519: clk_prepare: usb_mp_clk
            init-1       [001] .....     1.041521: clk_prepare_complete: usb_mp_clk
            init-1       [001] d....     1.041524: clk_enable: usb_mp_clk
            init-1       [001] d....     1.041526: clk_enable_complete: usb_mp_clk
    kworker/u6:1-33      [001] .....     1.093644: clk_prepare: l4_mp_clk
    kworker/u6:1-33      [001] .....     1.093649: clk_prepare_complete: l4_mp_clk
    kworker/u6:1-33      [001] d....     1.093652: clk_enable: l4_mp_clk
    kworker/u6:1-33      [001] d....     1.093654: clk_enable_complete: l4_mp_clk
    kworker/u6:1-33      [001] .....     1.093663: clk_prepare: per_nand_mmc_clk
    kworker/u6:1-33      [001] .....     1.093665: clk_prepare_complete: per_nand_mmc_clk
    kworker/u6:1-33      [001] .....     1.093666: clk_prepare: sdmmc_clk
    kworker/u6:1-33      [001] .....     1.093667: clk_prepare_complete: sdmmc_clk
    kworker/u6:1-33      [001] .....     1.093669: clk_prepare: sdmmc_clk_divided
    kworker/u6:1-33      [001] .....     1.093670: clk_prepare_complete: sdmmc_clk_divided
    kworker/u6:1-33      [001] d....     1.093672: clk_enable: per_nand_mmc_clk
    kworker/u6:1-33      [001] d....     1.093673: clk_enable_complete: per_nand_mmc_clk
    kworker/u6:1-33      [001] d....     1.093674: clk_enable: sdmmc_clk
    kworker/u6:1-33      [001] d....     1.093676: clk_enable_complete: sdmmc_clk
    kworker/u6:1-33      [001] d....     1.093678: clk_enable: sdmmc_clk_divided
    kworker/u6:1-33      [001] d....     1.093679: clk_enable_complete: sdmmc_clk_divided
    kworker/u6:1-33      [001] .....     1.235194: clk_prepare: mainclk
    kworker/u6:1-33      [001] .....     1.235200: clk_prepare_complete: mainclk
    kworker/u6:1-33      [001] .....     1.235202: clk_prepare: l4_main_clk
    kworker/u6:1-33      [001] .....     1.235203: clk_prepare_complete: l4_main_clk
    kworker/u6:1-33      [001] d....     1.235206: clk_enable: mainclk
    kworker/u6:1-33      [001] d....     1.235207: clk_enable_complete: mainclk
    kworker/u6:1-33      [001] d....     1.235209: clk_enable: l4_main_clk
    kworker/u6:1-33      [001] d....     1.235212: clk_enable_complete: l4_main_clk
            init-1       [001] .n...     1.279697: clk_rate_request_start: l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
            init-1       [001] .n...     1.279706: clk_rate_request_done: l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
            init-1       [001] .n...     1.279712: dw8250_set_termios: dw8250_set_termios: rate = 4294967274 newrate = 1843200
            init-1       [001] .n...     1.279715: dw8250_set_termios: dw8250_set_termios: before: uartclk = 100000000
            init-1       [001] .n...     1.279717: dw8250_set_termios: dw8250_set_termios: after: uartclk = 100000000
     kworker/1:1-36      [001] d....     1.285954: clk_disable: l4_main_clk
     kworker/1:1-36      [001] d....     1.285960: clk_disable_complete: l4_main_clk
     kworker/1:1-36      [001] d....     1.285962: clk_disable: mainclk
     kworker/1:1-36      [001] d....     1.285963: clk_disable_complete: mainclk
   (udev-worker)-83      [000] .....     1.849061: clk_prepare: emac1_clk
   (udev-worker)-83      [000] .....     1.849068: clk_prepare_complete: emac1_clk
   (udev-worker)-83      [000] .....     1.849070: clk_prepare: emac_1_clk
   (udev-worker)-83      [000] .....     1.849071: clk_prepare_complete: emac_1_clk
   (udev-worker)-83      [000] d....     1.849075: clk_enable: emac1_clk
   (udev-worker)-83      [000] d....     1.849077: clk_enable_complete: emac1_clk
   (udev-worker)-83      [000] d....     1.849078: clk_enable: emac_1_clk
   (udev-worker)-83      [000] d....     1.849082: clk_enable_complete: emac_1_clk
     kworker/0:1-10      [000] d....     1.850179: clk_disable: emac_1_clk
     kworker/0:1-10      [000] d....     1.850187: clk_disable_complete: emac_1_clk
     kworker/0:1-10      [000] d....     1.850193: clk_disable: emac1_clk
     kworker/0:1-10      [000] d....     1.850194: clk_disable_complete: emac1_clk
     kworker/0:1-10      [000] .....     1.850198: clk_unprepare: emac_1_clk
     kworker/0:1-10      [000] .....     1.850200: clk_unprepare_complete: emac_1_clk
     kworker/0:1-10      [000] .....     1.850202: clk_unprepare: emac1_clk
     kworker/0:1-10      [000] .....     1.850203: clk_unprepare_complete: emac1_clk
            init-1       [000] .....     2.730939: clk_rate_request_start: l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
            init-1       [000] .....     2.730947: clk_rate_request_done: l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
            init-1       [000] .....     2.730953: dw8250_set_termios: dw8250_set_termios: rate = 4294967274 newrate = 1843200
            init-1       [000] .....     2.730956: dw8250_set_termios: dw8250_set_termios: before: uartclk = 100000000
            init-1       [000] .....     2.730958: dw8250_set_termios: dw8250_set_termios: after: uartclk = 100000000
   (udev-worker)-229     [000] .....     4.222397: clk_prepare: emac1_clk
   (udev-worker)-229     [000] .....     4.222404: clk_prepare_complete: emac1_clk
   (udev-worker)-229     [000] .....     4.222405: clk_prepare: emac_1_clk
   (udev-worker)-229     [000] .....     4.222407: clk_prepare_complete: emac_1_clk
   (udev-worker)-229     [000] d....     4.222410: clk_enable: emac1_clk
   (udev-worker)-229     [000] d....     4.222412: clk_enable_complete: emac1_clk
   (udev-worker)-229     [000] d....     4.222413: clk_enable: emac_1_clk
   (udev-worker)-229     [000] d....     4.222416: clk_enable_complete: emac_1_clk
     kworker/0:1-10      [000] d....     4.222472: clk_disable: emac_1_clk
     kworker/0:1-10      [000] d....     4.222476: clk_disable_complete: emac_1_clk
     kworker/0:1-10      [000] d....     4.222477: clk_disable: emac1_clk
     kworker/0:1-10      [000] d....     4.222479: clk_disable_complete: emac1_clk
     kworker/0:1-10      [000] .....     4.222482: clk_unprepare: emac_1_clk
     kworker/0:1-10      [000] .....     4.222484: clk_unprepare_complete: emac_1_clk
     kworker/0:1-10      [000] .....     4.222485: clk_unprepare: emac1_clk
     kworker/0:1-10      [000] .....     4.222486: clk_unprepare_complete: emac1_clk
   (udev-worker)-229     [000] .....     4.225917: clk_prepare: emac1_clk
   (udev-worker)-229     [000] .....     4.225924: clk_prepare_complete: emac1_clk
   (udev-worker)-229     [000] .....     4.225925: clk_prepare: emac_1_clk
   (udev-worker)-229     [000] .....     4.225927: clk_prepare_complete: emac_1_clk
   (udev-worker)-229     [000] d....     4.225931: clk_enable: emac1_clk
   (udev-worker)-229     [000] d....     4.225932: clk_enable_complete: emac1_clk
   (udev-worker)-229     [000] d....     4.225933: clk_enable: emac_1_clk
   (udev-worker)-229     [000] d....     4.225937: clk_enable_complete: emac_1_clk
     kworker/0:1-10      [000] d....     4.225993: clk_disable: emac_1_clk
     kworker/0:1-10      [000] d....     4.225997: clk_disable_complete: emac_1_clk
     kworker/0:1-10      [000] d....     4.225998: clk_disable: emac1_clk
     kworker/0:1-10      [000] d....     4.226000: clk_disable_complete: emac1_clk
     kworker/0:1-10      [000] .....     4.226003: clk_unprepare: emac_1_clk
     kworker/0:1-10      [000] .....     4.226005: clk_unprepare_complete: emac_1_clk
     kworker/0:1-10      [000] .....     4.226006: clk_unprepare: emac1_clk
     kworker/0:1-10      [000] .....     4.226008: clk_unprepare_complete: emac1_clk
   (udev-worker)-229     [000] .....     4.227357: clk_prepare: emac1_clk
   (udev-worker)-229     [000] .....     4.227362: clk_prepare_complete: emac1_clk
   (udev-worker)-229     [000] .....     4.227363: clk_prepare: emac_1_clk
   (udev-worker)-229     [000] .....     4.227365: clk_prepare_complete: emac_1_clk
   (udev-worker)-229     [000] d....     4.227368: clk_enable: emac1_clk
   (udev-worker)-229     [000] d....     4.227370: clk_enable_complete: emac1_clk
   (udev-worker)-229     [000] d....     4.227371: clk_enable: emac_1_clk
   (udev-worker)-229     [000] d....     4.227374: clk_enable_complete: emac_1_clk
     kworker/0:1-10      [000] d....     4.227507: clk_disable: emac_1_clk
     kworker/0:1-10      [000] d....     4.227513: clk_disable_complete: emac_1_clk
     kworker/0:1-10      [000] d....     4.227514: clk_disable: emac1_clk
     kworker/0:1-10      [000] d....     4.227516: clk_disable_complete: emac1_clk
     kworker/0:1-10      [000] .....     4.227519: clk_unprepare: emac_1_clk
     kworker/0:1-10      [000] .....     4.227521: clk_unprepare_complete: emac_1_clk
     kworker/0:1-10      [000] .....     4.227522: clk_unprepare: emac1_clk
     kworker/0:1-10      [000] .....     4.227523: clk_unprepare_complete: emac1_clk
              ip-777     [001] .....     8.834235: clk_prepare: emac1_clk
              ip-777     [001] .....     8.834241: clk_prepare_complete: emac1_clk
              ip-777     [001] .....     8.834242: clk_prepare: emac_1_clk
              ip-777     [001] .....     8.834243: clk_prepare_complete: emac_1_clk
              ip-777     [001] d....     8.834246: clk_enable: emac1_clk
              ip-777     [001] d....     8.834248: clk_enable_complete: emac1_clk
              ip-777     [001] d....     8.834249: clk_enable: emac_1_clk
              ip-777     [001] d....     8.834252: clk_enable_complete: emac_1_clk
           getty-1284    [001] .....    19.510813: clk_rate_request_start: l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
           getty-1284    [001] .....    19.510822: clk_rate_request_done: l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
           getty-1284    [001] .....    19.510828: dw8250_set_termios: dw8250_set_termios: rate = 4294967274 newrate = 1843200
           getty-1284    [001] .....    19.510830: dw8250_set_termios: dw8250_set_termios: before: uartclk = 100000000
           getty-1284    [001] .....    19.510832: dw8250_set_termios: dw8250_set_termios: after: uartclk = 100000000

trace output (bad - determine_rate = clk_hw_determine_rate_no_reparent):
# tracer: nop
#
# entries-in-buffer/entries-written: 285/285   #P:2
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 462500000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: div_reg: div = 2
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 231250000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: div_reg: div = 2
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 115625000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: div_reg: div = 1
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 6250000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: div_reg: div = 2
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 3125000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: div_reg: div = 1
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 6250000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 6250000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 97368421
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 97368421
          <idle>-0       [000] d....     0.000000: socfpga_clk_get_parent: socfpga_clk_get_parent: name = l4_mp_clk
          <idle>-0       [000] d....     0.000000: socfpga_clk_get_parent: socfpga_clk_get_parent: l4_mp_clk = 1
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: div_reg: div = 2
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 100000000
          <idle>-0       [000] d....     0.000000: socfpga_clk_get_parent: socfpga_clk_get_parent: name = l4_sp_clk
          <idle>-0       [000] d....     0.000000: socfpga_clk_get_parent: socfpga_clk_get_parent: l4_sp_clk = 1
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: div_reg: div = 2
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 100000000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 1953125
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 250000000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: div_reg: div = 1
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 200000000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: div_reg: div = 1
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 200000000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: div_reg: div = 5
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 40000000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: div_reg: div = 5
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 40000000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: div_reg: div = 6250
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 32000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 50000000
          <idle>-0       [000] d....     0.000000: socfpga_clk_get_parent: socfpga_clk_get_parent: name = sdmmc_clk
          <idle>-0       [000] d....     0.000000: socfpga_clk_get_parent: socfpga_clk_get_parent: sdmmc_clk = 2
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 200000000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: fixed_div: div = 4
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 50000000
          <idle>-0       [000] d....     0.000000: socfpga_clk_get_parent: socfpga_clk_get_parent: name = nand_x_clk
          <idle>-0       [000] d....     0.000000: socfpga_clk_get_parent: socfpga_clk_get_parent: nand_clk / nand_x_clk = 2
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 200000000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 200000000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: fixed_div: div = 4
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 50000000
          <idle>-0       [000] d....     0.000000: socfpga_clk_get_parent: socfpga_clk_get_parent: name = qspi_clk
          <idle>-0       [000] d....     0.000000: socfpga_clk_get_parent: socfpga_clk_get_parent: qspi_clk = 1
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 3613281
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 400000000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 800000000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 400000000
          <idle>-0       [000] d....     0.000000: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 133333333
          <idle>-0       [000] d....     0.000000: clk_prepare: osc1
          <idle>-0       [000] d....     0.000000: clk_prepare_complete: osc1
          <idle>-0       [000] d....     0.000000: clk_prepare: main_pll
          <idle>-0       [000] d....     0.000000: clk_prepare_complete: main_pll
          <idle>-0       [000] d....     0.000000: clk_prepare: mpuclk
          <idle>-0       [000] d....     0.000000: clk_prepare_complete: mpuclk
          <idle>-0       [000] d....     0.000000: clk_prepare: mpu_periph_clk
          <idle>-0       [000] d....     0.000000: clk_prepare_complete: mpu_periph_clk
          <idle>-0       [000] d....     0.000000: clk_enable: osc1
          <idle>-0       [000] d....     0.000000: clk_enable_complete: osc1
          <idle>-0       [000] d....     0.000000: clk_enable: main_pll
          <idle>-0       [000] d....     0.000000: clk_enable_complete: main_pll
          <idle>-0       [000] d....     0.000000: clk_enable: mpuclk
          <idle>-0       [000] d....     0.000000: clk_enable_complete: mpuclk
          <idle>-0       [000] d....     0.000000: clk_enable: mpu_periph_clk
          <idle>-0       [000] d....     0.000000: clk_enable_complete: mpu_periph_clk
          <idle>-0       [000] d....     0.000000: clk_prepare: periph_pll
          <idle>-0       [000] d....     0.000000: clk_prepare_complete: periph_pll
          <idle>-0       [000] d....     0.000000: clk_prepare: per_base_clk
          <idle>-0       [000] d....     0.000000: clk_prepare_complete: per_base_clk
          <idle>-0       [000] d....     0.000000: clk_prepare: l4_sp_clk
          <idle>-0       [000] d....     0.000000: clk_prepare_complete: l4_sp_clk
          <idle>-0       [000] d....     0.000000: clk_enable: periph_pll
          <idle>-0       [000] d....     0.000000: clk_enable_complete: periph_pll
          <idle>-0       [000] d....     0.000000: clk_enable: per_base_clk
          <idle>-0       [000] d....     0.000000: clk_enable_complete: per_base_clk
          <idle>-0       [000] d....     0.000000: clk_enable: l4_sp_clk
          <idle>-0       [000] d....     0.000000: clk_enable_complete: l4_sp_clk
            init-1       [000] .n...     0.033336: clk_prepare: mainclk
            init-1       [000] .n...     0.033341: clk_prepare_complete: mainclk
            init-1       [000] .n...     0.033343: clk_prepare: l4_main_clk
            init-1       [000] .n...     0.033344: clk_prepare_complete: l4_main_clk
            init-1       [000] dn...     0.033347: clk_enable: mainclk
            init-1       [000] dn...     0.033349: clk_enable_complete: mainclk
            init-1       [000] dn...     0.033350: clk_enable: l4_main_clk
            init-1       [000] dn...     0.033352: clk_enable_complete: l4_main_clk
            init-1       [000] d....     0.033421: clk_disable: l4_main_clk
            init-1       [000] d....     0.033424: clk_disable_complete: l4_main_clk
            init-1       [000] d....     0.033425: clk_disable: mainclk
            init-1       [000] d....     0.033426: clk_disable_complete: mainclk
            init-1       [000] .....     0.033430: clk_unprepare: l4_main_clk
            init-1       [000] .....     0.033431: clk_unprepare_complete: l4_main_clk
            init-1       [000] .....     0.033432: clk_unprepare: mainclk
            init-1       [000] .....     0.033434: clk_unprepare_complete: mainclk
            init-1       [001] .....     0.125643: clk_rate_request_start: l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
            init-1       [001] .....     0.125651: clk_rate_request_done: l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
            init-1       [001] .....     0.125657: dw8250_set_termios: dw8250_set_termios: rate = 200000000 newrate = 1843200
            init-1       [001] .....     0.125660: dw8250_set_termios: dw8250_set_termios: before: uartclk = 100000000
            init-1       [001] .....     0.125662: clk_rate_request_start: l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
            init-1       [001] .....     0.125664: clk_rate_request_done: l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
            init-1       [001] .....     0.125666: clk_rate_request_start: l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
            init-1       [001] .....     0.125668: clk_rate_request_done: l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
            init-1       [001] .....     0.125673: clk_set_rate: l4_sp_clk 200000000
            init-1       [001] .....     0.125675: clk_set_rate_complete: l4_sp_clk 200000000
            init-1       [001] .....     0.125678: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: div_reg: div = 2
            init-1       [001] .....     0.125681: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 100000000
            init-1       [001] .....     0.125683: dw8250_set_termios: dw8250_set_termios: after: uartclk = 200000000
            init-1       [001] .n...     1.732756: clk_prepare: emac1_clk
            init-1       [001] .n...     1.732761: clk_prepare_complete: emac1_clk
            init-1       [001] .n...     1.732763: clk_prepare: emac_1_clk
            init-1       [001] .n...     1.732764: clk_prepare_complete: emac_1_clk
            init-1       [001] dn...     1.732767: clk_enable: emac1_clk
            init-1       [001] dn...     1.732769: clk_enable_complete: emac1_clk
            init-1       [001] dn...     1.732770: clk_enable: emac_1_clk
            init-1       [001] dn...     1.732773: clk_enable_complete: emac_1_clk
     kworker/1:1-36      [001] d....     1.952366: clk_disable: emac_1_clk
     kworker/1:1-36      [001] d....     1.952373: clk_disable_complete: emac_1_clk
     kworker/1:1-36      [001] d....     1.952374: clk_disable: emac1_clk
     kworker/1:1-36      [001] d....     1.952376: clk_disable_complete: emac1_clk
     kworker/1:1-36      [001] .....     1.952379: clk_unprepare: emac_1_clk
     kworker/1:1-36      [001] .....     1.952381: clk_unprepare_complete: emac_1_clk
     kworker/1:1-36      [001] .....     1.952382: clk_unprepare: emac1_clk
     kworker/1:1-36      [001] .....     1.952383: clk_unprepare_complete: emac1_clk
            init-1       [001] .....     1.952436: clk_prepare: usb_mp_clk
            init-1       [001] .....     1.952438: clk_prepare_complete: usb_mp_clk
            init-1       [001] d....     1.952441: clk_enable: usb_mp_clk
            init-1       [001] d....     1.952443: clk_enable_complete: usb_mp_clk
    kworker/u6:1-33      [001] .....     2.053196: clk_prepare: l4_mp_clk
    kworker/u6:1-33      [001] .....     2.053201: clk_prepare_complete: l4_mp_clk
    kworker/u6:1-33      [001] d....     2.053203: clk_enable: l4_mp_clk
    kworker/u6:1-33      [001] d....     2.053207: clk_enable_complete: l4_mp_clk
    kworker/u6:1-33      [001] .....     2.053215: clk_prepare: per_nand_mmc_clk
    kworker/u6:1-33      [001] .....     2.053217: clk_prepare_complete: per_nand_mmc_clk
    kworker/u6:1-33      [001] .....     2.053218: clk_prepare: sdmmc_clk
    kworker/u6:1-33      [001] .....     2.053220: clk_prepare_complete: sdmmc_clk
    kworker/u6:1-33      [001] .....     2.053221: clk_prepare: sdmmc_clk_divided
    kworker/u6:1-33      [001] .....     2.053222: clk_prepare_complete: sdmmc_clk_divided
    kworker/u6:1-33      [001] d....     2.053224: clk_enable: per_nand_mmc_clk
    kworker/u6:1-33      [001] d....     2.053225: clk_enable_complete: per_nand_mmc_clk
    kworker/u6:1-33      [001] d....     2.053227: clk_enable: sdmmc_clk
    kworker/u6:1-33      [001] d....     2.053228: clk_enable_complete: sdmmc_clk
    kworker/u6:1-33      [001] d....     2.053230: clk_enable: sdmmc_clk_divided
    kworker/u6:1-33      [001] d....     2.053232: clk_enable_complete: sdmmc_clk_divided
    kworker/u5:1-27      [000] .....     2.319334: clk_prepare: mainclk
    kworker/u5:1-27      [000] .....     2.319339: clk_prepare_complete: mainclk
    kworker/u5:1-27      [000] .....     2.319341: clk_prepare: l4_main_clk
    kworker/u5:1-27      [000] .....     2.319342: clk_prepare_complete: l4_main_clk
    kworker/u5:1-27      [000] d....     2.319345: clk_enable: mainclk
    kworker/u5:1-27      [000] d....     2.319346: clk_enable_complete: mainclk
    kworker/u5:1-27      [000] d....     2.319348: clk_enable: l4_main_clk
    kworker/u5:1-27      [000] d....     2.319350: clk_enable_complete: l4_main_clk
     kworker/0:2-50      [000] d....     2.374974: clk_disable: l4_main_clk
     kworker/0:2-50      [000] d....     2.374980: clk_disable_complete: l4_main_clk
     kworker/0:2-50      [000] d....     2.374981: clk_disable: mainclk
     kworker/0:2-50      [000] d....     2.374986: clk_disable_complete: mainclk
            init-1       [000] .n...     2.404394: clk_rate_request_start: l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
            init-1       [000] .n...     2.404402: clk_rate_request_done: l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
            init-1       [000] .n...     2.404408: dw8250_set_termios: dw8250_set_termios: rate = 200000000 newrate = 1843200
            init-1       [000] .n...     2.404411: dw8250_set_termios: dw8250_set_termios: before: uartclk = 100000000
            init-1       [000] .n...     2.404413: clk_rate_request_start: l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
            init-1       [000] .n...     2.404415: clk_rate_request_done: l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
            init-1       [000] .n...     2.404418: clk_rate_request_start: l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
            init-1       [000] .n...     2.404419: clk_rate_request_done: l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
            init-1       [000] .n...     2.404429: clk_set_rate: l4_sp_clk 200000000
            init-1       [000] .n...     2.404431: clk_set_rate_complete: l4_sp_clk 200000000
            init-1       [000] .n...     2.404435: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: div_reg: div = 2
            init-1       [000] .n...     2.404437: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 100000000
            init-1       [000] .n...     2.404440: dw8250_set_termios: dw8250_set_termios: after: uartclk = 200000000
   (udev-worker)-86      [001] .....     3.002615: clk_prepare: emac1_clk
   (udev-worker)-86      [001] .....     3.002621: clk_prepare_complete: emac1_clk
   (udev-worker)-86      [001] .....     3.002623: clk_prepare: emac_1_clk
   (udev-worker)-86      [001] .....     3.002624: clk_prepare_complete: emac_1_clk
   (udev-worker)-86      [001] d....     3.002628: clk_enable: emac1_clk
   (udev-worker)-86      [001] d....     3.002629: clk_enable_complete: emac1_clk
   (udev-worker)-86      [001] d....     3.002631: clk_enable: emac_1_clk
   (udev-worker)-86      [001] d....     3.002635: clk_enable_complete: emac_1_clk
     kworker/1:2-45      [001] d....     3.012426: clk_disable: emac_1_clk
     kworker/1:2-45      [001] d....     3.012437: clk_disable_complete: emac_1_clk
     kworker/1:2-45      [001] d....     3.012439: clk_disable: emac1_clk
     kworker/1:2-45      [001] d....     3.012440: clk_disable_complete: emac1_clk
     kworker/1:2-45      [001] .....     3.012445: clk_unprepare: emac_1_clk
     kworker/1:2-45      [001] .....     3.012449: clk_unprepare_complete: emac_1_clk
     kworker/1:2-45      [001] .....     3.012453: clk_unprepare: emac1_clk
     kworker/1:2-45      [001] .....     3.012456: clk_unprepare_complete: emac1_clk
   (udev-worker)-86      [001] .....     3.018662: clk_prepare: emac1_clk
   (udev-worker)-86      [001] .....     3.018668: clk_prepare_complete: emac1_clk
   (udev-worker)-86      [001] .....     3.018670: clk_prepare: emac_1_clk
   (udev-worker)-86      [001] .....     3.018671: clk_prepare_complete: emac_1_clk
   (udev-worker)-86      [001] d....     3.018675: clk_enable: emac1_clk
   (udev-worker)-86      [001] d....     3.018677: clk_enable_complete: emac1_clk
   (udev-worker)-86      [001] d....     3.018678: clk_enable: emac_1_clk
   (udev-worker)-86      [001] d....     3.018681: clk_enable_complete: emac_1_clk
     kworker/1:2-45      [001] d....     3.019794: clk_disable: emac_1_clk
     kworker/1:2-45      [001] d....     3.019801: clk_disable_complete: emac_1_clk
     kworker/1:2-45      [001] d....     3.019803: clk_disable: emac1_clk
     kworker/1:2-45      [001] d....     3.019804: clk_disable_complete: emac1_clk
     kworker/1:2-45      [001] .....     3.019808: clk_unprepare: emac_1_clk
     kworker/1:2-45      [001] .....     3.019810: clk_unprepare_complete: emac_1_clk
     kworker/1:2-45      [001] .....     3.019811: clk_unprepare: emac1_clk
     kworker/1:2-45      [001] .....     3.019813: clk_unprepare_complete: emac1_clk
            init-1       [000] .....     3.955433: clk_rate_request_start: l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
            init-1       [000] .....     3.955440: clk_rate_request_done: l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
            init-1       [000] .....     3.955446: dw8250_set_termios: dw8250_set_termios: rate = 200000000 newrate = 1843200
            init-1       [000] .....     3.955449: dw8250_set_termios: dw8250_set_termios: before: uartclk = 200000000
            init-1       [000] .....     3.955452: clk_rate_request_start: l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
            init-1       [000] .....     3.955453: clk_rate_request_done: l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
            init-1       [000] .....     3.955455: clk_rate_request_start: l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
            init-1       [000] .....     3.955457: clk_rate_request_done: l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
            init-1       [000] .....     3.955465: clk_set_rate: l4_sp_clk 200000000
            init-1       [000] .....     3.955467: clk_set_rate_complete: l4_sp_clk 200000000
            init-1       [000] .....     3.955471: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: div_reg: div = 2
            init-1       [000] .....     3.955473: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 100000000
            init-1       [000] .....     3.955476: dw8250_set_termios: dw8250_set_termios: after: uartclk = 200000000
   (udev-worker)-228     [000] .....     5.422835: clk_prepare: emac1_clk
   (udev-worker)-228     [000] .....     5.422842: clk_prepare_complete: emac1_clk
   (udev-worker)-228     [000] .....     5.422843: clk_prepare: emac_1_clk
   (udev-worker)-228     [000] .....     5.422845: clk_prepare_complete: emac_1_clk
   (udev-worker)-228     [000] d....     5.422848: clk_enable: emac1_clk
   (udev-worker)-228     [000] d....     5.422850: clk_enable_complete: emac1_clk
   (udev-worker)-228     [000] d....     5.422851: clk_enable: emac_1_clk
   (udev-worker)-228     [000] d....     5.422855: clk_enable_complete: emac_1_clk
     kworker/0:2-50      [000] d....     5.432702: clk_disable: emac_1_clk
     kworker/0:2-50      [000] d....     5.432710: clk_disable_complete: emac_1_clk
     kworker/0:2-50      [000] d....     5.432712: clk_disable: emac1_clk
     kworker/0:2-50      [000] d....     5.432714: clk_disable_complete: emac1_clk
     kworker/0:2-50      [000] .....     5.432718: clk_unprepare: emac_1_clk
     kworker/0:2-50      [000] .....     5.432719: clk_unprepare_complete: emac_1_clk
     kworker/0:2-50      [000] .....     5.432721: clk_unprepare: emac1_clk
     kworker/0:2-50      [000] .....     5.432722: clk_unprepare_complete: emac1_clk
   (udev-worker)-228     [000] .....     5.444087: clk_prepare: emac1_clk
   (udev-worker)-228     [000] .....     5.444092: clk_prepare_complete: emac1_clk
   (udev-worker)-228     [000] .....     5.444094: clk_prepare: emac_1_clk
   (udev-worker)-228     [000] .....     5.444095: clk_prepare_complete: emac_1_clk
   (udev-worker)-228     [000] d....     5.444098: clk_enable: emac1_clk
   (udev-worker)-228     [000] d....     5.444100: clk_enable_complete: emac1_clk
   (udev-worker)-228     [000] d....     5.444101: clk_enable: emac_1_clk
   (udev-worker)-228     [000] d....     5.444105: clk_enable_complete: emac_1_clk
     kworker/0:2-50      [000] d....     5.444435: clk_disable: emac_1_clk
     kworker/0:2-50      [000] d....     5.444441: clk_disable_complete: emac_1_clk
     kworker/0:2-50      [000] d....     5.444443: clk_disable: emac1_clk
     kworker/0:2-50      [000] d....     5.444444: clk_disable_complete: emac1_clk
     kworker/0:2-50      [000] .....     5.444448: clk_unprepare: emac_1_clk
     kworker/0:2-50      [000] .....     5.444450: clk_unprepare_complete: emac_1_clk
     kworker/0:2-50      [000] .....     5.444451: clk_unprepare: emac1_clk
     kworker/0:2-50      [000] .....     5.444452: clk_unprepare_complete: emac1_clk
   (udev-worker)-228     [000] .....     5.463489: clk_prepare: emac1_clk
   (udev-worker)-228     [000] .....     5.463494: clk_prepare_complete: emac1_clk
   (udev-worker)-228     [000] .....     5.463496: clk_prepare: emac_1_clk
   (udev-worker)-228     [000] .....     5.463497: clk_prepare_complete: emac_1_clk
   (udev-worker)-228     [000] d....     5.463501: clk_enable: emac1_clk
   (udev-worker)-228     [000] d....     5.463503: clk_enable_complete: emac1_clk
   (udev-worker)-228     [000] d....     5.463504: clk_enable: emac_1_clk
   (udev-worker)-228     [000] d....     5.463507: clk_enable_complete: emac_1_clk
     kworker/0:2-50      [000] d....     5.465073: clk_disable: emac_1_clk
     kworker/0:2-50      [000] d....     5.465084: clk_disable_complete: emac_1_clk
     kworker/0:2-50      [000] d....     5.465085: clk_disable: emac1_clk
     kworker/0:2-50      [000] d....     5.465087: clk_disable_complete: emac1_clk
     kworker/0:2-50      [000] .....     5.465091: clk_unprepare: emac_1_clk
     kworker/0:2-50      [000] .....     5.465093: clk_unprepare_complete: emac_1_clk
     kworker/0:2-50      [000] .....     5.465094: clk_unprepare: emac1_clk
     kworker/0:2-50      [000] .....     5.465096: clk_unprepare_complete: emac1_clk
              ip-777     [001] .....    11.417588: clk_prepare: emac1_clk
              ip-777     [001] .....    11.417594: clk_prepare_complete: emac1_clk
              ip-777     [001] .....    11.417596: clk_prepare: emac_1_clk
              ip-777     [001] .....    11.417597: clk_prepare_complete: emac_1_clk
              ip-777     [001] d....    11.417600: clk_enable: emac1_clk
              ip-777     [001] d....    11.417602: clk_enable_complete: emac1_clk
              ip-777     [001] d....    11.417603: clk_enable: emac_1_clk
              ip-777     [001] d....    11.417606: clk_enable_complete: emac_1_clk
           getty-1283    [001] .....    19.978213: clk_rate_request_start: l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
           getty-1283    [001] .....    19.978220: clk_rate_request_done: l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
           getty-1283    [001] .....    19.978226: dw8250_set_termios: dw8250_set_termios: rate = 200000000 newrate = 1843200
           getty-1283    [001] .....    19.978229: dw8250_set_termios: dw8250_set_termios: before: uartclk = 200000000
           getty-1283    [001] .....    19.978231: clk_rate_request_start: l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
           getty-1283    [001] .....    19.978233: clk_rate_request_done: l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
           getty-1283    [001] .....    19.978235: clk_rate_request_start: l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
           getty-1283    [001] .....    19.978237: clk_rate_request_done: l4_sp_clk min 0 max 4294967295, parent per_base_clk (200000000)
           getty-1283    [001] .....    19.978245: clk_set_rate: l4_sp_clk 200000000
           getty-1283    [001] .....    19.978247: clk_set_rate_complete: l4_sp_clk 200000000
           getty-1283    [001] .....    19.978251: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: div_reg: div = 2
           getty-1283    [001] .....    19.978254: socfpga_clk_recalc_rate: socfpga_clk_recalc_rate: rate = 100000000
           getty-1283    [001] .....    19.978256: dw8250_set_termios: dw8250_set_termios: after: uartclk = 200000000

---
 drivers/clk/socfpga/clk-gate.c      | 43 ++++++++++++++++++++++-------
 drivers/tty/serial/8250/8250_dw.c   |  3 ++
 drivers/tty/serial/8250/8250_port.c |  2 ++
 3 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/socfpga/clk-gate.c b/drivers/clk/socfpga/clk-gate.c
index 47500976f987..48e5c241f528 100644
--- a/drivers/clk/socfpga/clk-gate.c
+++ b/drivers/clk/socfpga/clk-gate.c
@@ -31,26 +31,39 @@ static u8 socfpga_clk_get_parent(struct clk_hw *hwclk)
 	u32 l4_src;
 	u32 perpll_src;
 	const char *name = clk_hw_get_name(hwclk);
+	u8 ret;
+
+	trace_printk("%s: name = %s\n", __func__, name);
 
 	if (streq(name, SOCFPGA_L4_MP_CLK)) {
 		l4_src = readl(clk_mgr_base_addr + CLKMGR_L4SRC);
-		return l4_src & 0x1;
+		ret = l4_src & 0x1;
+		trace_printk("%s: l4_mp_clk = %d\n", __func__, ret);
+		return ret;
 	}
 	if (streq(name, SOCFPGA_L4_SP_CLK)) {
 		l4_src = readl(clk_mgr_base_addr + CLKMGR_L4SRC);
-		return !!(l4_src & 2);
+		ret = !!(l4_src & 2);
+		trace_printk("%s: l4_sp_clk = %d\n", __func__, ret);
+		return ret;
 	}
 
 	perpll_src = readl(clk_mgr_base_addr + CLKMGR_PERPLL_SRC);
-	if (streq(name, SOCFPGA_MMC_CLK))
-		return perpll_src & 0x3;
+	if (streq(name, SOCFPGA_MMC_CLK)) {
+		ret = perpll_src & 0x3;
+		trace_printk("%s: sdmmc_clk = %d\n", __func__, ret);
+		return ret;
+	}
 	if (streq(name, SOCFPGA_NAND_CLK) ||
-	    streq(name, SOCFPGA_NAND_X_CLK))
-		return (perpll_src >> 2) & 3;
-
+	    streq(name, SOCFPGA_NAND_X_CLK)) {
+		ret = (perpll_src >> 2) & 3;
+		trace_printk("%s: nand_clk / nand_x_clk = %d\n", __func__, ret);
+		return ret;
+	}
 	/* QSPI clock */
-	return (perpll_src >> 4) & 3;
-
+	ret = (perpll_src >> 4) & 3;
+	trace_printk("%s: qspi_clk = %d\n", __func__, ret);
+	return ret;
 }
 
 static int socfpga_clk_set_parent(struct clk_hw *hwclk, u8 parent)
@@ -63,23 +76,28 @@ static int socfpga_clk_set_parent(struct clk_hw *hwclk, u8 parent)
 		src_reg &= ~0x1;
 		src_reg |= parent;
 		writel(src_reg, clk_mgr_base_addr + CLKMGR_L4SRC);
+		trace_printk("%s: l4_mp_clk: src_reg = %d\n", __func__, src_reg);
 	} else if (streq(name, SOCFPGA_L4_SP_CLK)) {
 		src_reg = readl(clk_mgr_base_addr + CLKMGR_L4SRC);
 		src_reg &= ~0x2;
 		src_reg |= (parent << 1);
 		writel(src_reg, clk_mgr_base_addr + CLKMGR_L4SRC);
+		trace_printk("%s: l4_sp_clk: src_reg = %d\n", __func__, src_reg);
 	} else {
 		src_reg = readl(clk_mgr_base_addr + CLKMGR_PERPLL_SRC);
 		if (streq(name, SOCFPGA_MMC_CLK)) {
 			src_reg &= ~0x3;
 			src_reg |= parent;
+			trace_printk("%s: sdmmc_clk: src_reg = %d\n", __func__, src_reg);
 		} else if (streq(name, SOCFPGA_NAND_CLK) ||
 			streq(name, SOCFPGA_NAND_X_CLK)) {
 			src_reg &= ~0xC;
 			src_reg |= (parent << 2);
+			trace_printk("%s: nand_clk: src_reg = %d\n", __func__, src_reg);
 		} else {/* QSPI clock */
 			src_reg &= ~0x30;
 			src_reg |= (parent << 4);
+			trace_printk("%s: qspi_clk: src_reg = %d\n", __func__, src_reg);
 		}
 		writel(src_reg, clk_mgr_base_addr + CLKMGR_PERPLL_SRC);
 	}
@@ -93,8 +111,10 @@ static unsigned long socfpga_clk_recalc_rate(struct clk_hw *hwclk,
 	struct socfpga_gate_clk *socfpgaclk = to_socfpga_gate_clk(hwclk);
 	u32 div = 1, val;
 
-	if (socfpgaclk->fixed_div)
+	if (socfpgaclk->fixed_div) {
 		div = socfpgaclk->fixed_div;
+		trace_printk("%s: fixed_div: div = %d\n", __func__, div);
+	}
 	else if (socfpgaclk->div_reg) {
 		val = readl(socfpgaclk->div_reg) >> socfpgaclk->shift;
 		val &= GENMASK(socfpgaclk->width - 1, 0);
@@ -103,8 +123,11 @@ static unsigned long socfpga_clk_recalc_rate(struct clk_hw *hwclk,
 			div = val + 1;
 		else
 			div = (1 << val);
+		trace_printk("%s: div_reg: div = %d\n", __func__, div);
 	}
 
+	trace_printk("%s: rate = %ld\n", __func__, parent_rate / div);
+
 	return parent_rate / div;
 }
 
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index f4cafca1a7da..1e21ef8b046c 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -359,6 +359,8 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 
 	clk_disable_unprepare(d->clk);
 	rate = clk_round_rate(d->clk, newrate);
+	trace_printk("%s: rate = %ld newrate = %ld\n", __func__, rate, newrate);
+	trace_printk("%s: before: uartclk = %d\n", __func__, p->uartclk);
 	if (rate > 0) {
 		/*
 		 * Note that any clock-notifer worker will block in
@@ -368,6 +370,7 @@ static void dw8250_set_termios(struct uart_port *p, struct ktermios *termios,
 		if (!ret)
 			p->uartclk = rate;
 	}
+	trace_printk("%s: after: uartclk = %d\n", __func__, p->uartclk);
 	clk_prepare_enable(d->clk);
 
 	dw8250_do_set_termios(p, termios, old);
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 141627370aab..61f278e8d41b 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2758,6 +2758,8 @@ void serial8250_update_uartclk(struct uart_port *port, unsigned int uartclk)
 
 	uart_update_timeout(port, termios->c_cflag, baud);
 
+	trace_printk("%s: %s: uartclk: %d baud: %d quot: %d frac: %d\n",
+		     __func__, port->name, uartclk, baud, quot, frac);
 	serial8250_set_divisor(port, baud, quot, frac);
 	serial_port_out(port, UART_LCR, up->lcr);
 
-- 
2.30.2


