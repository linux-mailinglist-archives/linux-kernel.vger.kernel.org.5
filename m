Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1642800629
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377912AbjLAIsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377905AbjLAIsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:48:11 -0500
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125CFD1
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 00:48:16 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id DB72220645;
        Fri,  1 Dec 2023 09:48:13 +0100 (CET)
Date:   Fri, 1 Dec 2023 09:48:09 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Nishanth Menon <nm@ti.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Francesco Dolcini <francesco@dolcini.it>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Tero Kristo <kristo@kernel.org>
Subject: Re: [PATCH] arm64: defconfig: increase SERIAL_8250_NR_UARTS
Message-ID: <ZWmdyenBpqI1S8HG@francesco-nb.int.toradex.com>
References: <20231130231657.12715-1-francesco@dolcini.it>
 <20231201060346.GE5169@atomide.com>
 <20231201064919.5mbmqo5fco7n3rgq@endnote>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201064919.5mbmqo5fco7n3rgq@endnote>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 12:49:19AM -0600, Nishanth Menon wrote:
> On 08:03-20231201, Tony Lindgren wrote:
> > * Francesco Dolcini <francesco@dolcini.it> [231130 23:17]:
> > > Increase CONFIG_SERIAL_8250_NR_UARTS from 4 to 8, the current legacy value
> > > is not adequate for embedded systems that use SoCs where it's common to
> > > have a large number of serial ports.
> > > 
> > > No need to change CONFIG_SERIAL_8250_RUNTIME_UARTS, see commit 9d86719f8769
> > > ("serial: 8250: Allow using ports higher than SERIAL_8250_RUNTIME_UARTS").
> > > 
> > > This enables using the UART connected Bluetooth device on Verdin AM62
> > > board.
> > 
> > OK makes sense for distro use.
> > 
> > Disabling unused ports leads into port names shifting, which we still can't
> > easily tolerate until we have the DEVNAME:0.0 style addressing available for
> > ports. So for now we still depend CONFIG_SERIAL_8250_NR_UARTS, eventually
> > that too should become just a legacy ISA port array.. Meanwhile:
> > 
> > Reviewed-by: Tony Lindgren <tony@atomide.com>
> 
> I'd prefer to get Arnd's view on the topic as well (I kind of
> recollect some historic discussion which I am not failing to trace
> that there usage model doesn't exceed 4 and aliases could be used to
> map these as required for the platform).

The usage model that triggered this change exceed 4, we >4 uart in
use at the same time.

And the issue is not really "distro use", and I do not think anything
about aliases matter (the BT device is described as a child of the uart
in the DT).

  &main_uart5 {
    bluetooth {
      compatible = "nxp,88w8987-bt";
    };
  };

The change here is required to have basic hardware functionalities
working for kernel development and debugging using the in-tree
defconfig.


> Now 8 or 5 (which seems to be the relevant need) is subjective :(

Correct.

Francesco

