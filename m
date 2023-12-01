Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A3B8013BA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 20:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379545AbjLATwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 14:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379522AbjLATws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 14:52:48 -0500
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5689F10C2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 11:52:51 -0800 (PST)
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 9316F221C6;
        Fri,  1 Dec 2023 20:52:49 +0100 (CET)
Received: from livingston (unknown [192.168.42.11])
        by gaggiata.pivistrello.it (Postfix) with ESMTP id 4686C7F9C0;
        Fri,  1 Dec 2023 20:52:49 +0100 (CET)
Received: from pivi by livingston with local (Exim 4.96)
        (envelope-from <francesco@dolcini.it>)
        id 1r99ZB-0001DT-0S;
        Fri, 01 Dec 2023 20:52:49 +0100
Date:   Fri, 1 Dec 2023 20:52:49 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Nishanth Menon <nm@ti.com>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Tero Kristo <kristo@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] arm64: defconfig: increase SERIAL_8250_NR_UARTS
Message-ID: <ZWo5kVMoLTzST6F5@livingston.pivistrello.it>
References: <20231201171544.1901-1-francesco@dolcini.it>
 <20231201191958.kmwkpmttmebsas47@kooky>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201191958.kmwkpmttmebsas47@kooky>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 01:19:58PM -0600, Nishanth Menon wrote:
> On 18:15-20231201, Francesco Dolcini wrote:
> > Increase CONFIG_SERIAL_8250_NR_UARTS from 4 to 8, the current legacy value
> > is not adequate for embedded systems that use SoCs where it's common to
> > have a large number of serial ports.
> > 
> > No need to change CONFIG_SERIAL_8250_RUNTIME_UARTS, see commit 9d86719f8769
> > ("serial: 8250: Allow using ports higher than SERIAL_8250_RUNTIME_UARTS").
> > 
> > The need to increase this value was noticed while working with Toradex
> > Verdin AM62, this board has 4 serial UART instances available to the user
> > plus an internal one that is connected to a Bluetooth module. Without this
> > change the fifth UART connected to the BT module is not instantiated and BT
> > is not working.
> > 
> > Instead of increasing the number to the bare minimum (5) that would be
> > required to solve this specific issue, we increase this to 8 which seems a
> > more reasonable number to have in the defconfig and should cover more valid
> > use cases.
> 
> To address Arnd's concern on size increase, it will be good to add:

I can and I will add it in a v3 - it takes less time to do it than reply to
this email and thanks for taking the time to provide the actual data.

With that said my understanding is that the goal of the arm64 defconfig is
to enable the supported arm64 hardware and the related kernel development.
It's not supposed to be a minimal config in size nor an optimal
configuration from the performance point of view. It's a single
configuration that includes support for each and every platform [1]
supported by Linux arm64 ...

To me Arnd was just stating a fact, not raising a concern that was supposed
to be addressed (just correct me if I'm wrong, of course).

[1] well, apart AMD Pensando and Bitmain, at the moment, but you get the
point, I'm sure ;-).

> ---
> With this change kernel image increases by ~3.2k. bloat-o-meter summary:
> add/remove: 1/1 grow/shrink: 7/0 up/down: 3220/-8 (3212)
> ---

Francesco

