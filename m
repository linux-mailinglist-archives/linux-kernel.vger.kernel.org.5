Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E21D7E8009
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbjKJSD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235827AbjKJSCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:02:53 -0500
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4723F38E85;
        Fri, 10 Nov 2023 06:19:23 -0800 (PST)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 1EA8D20641;
        Fri, 10 Nov 2023 15:19:19 +0100 (CET)
Date:   Fri, 10 Nov 2023 15:19:15 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Nishanth Menon <nm@ti.com>
Cc:     =?iso-8859-1?Q?Jo=E3o_Paulo_Silva_Gon=E7alves?= 
        <joao.goncalves@toradex.com>,
        "faiz_abbas@ti.com" <faiz_abbas@ti.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: SDHCI AM654 driver delaying boot time
Message-ID: <ZU4748HsFFMx/bsT@francesco-nb.int.toradex.com>
References: <0e81af80de3d55e72f79af83fa5db87f5c9938f8.camel@toradex.com>
 <20231109175159.wylup6z45h7mgxji@clump>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231109175159.wylup6z45h7mgxji@clump>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nishant,

On Thu, Nov 09, 2023 at 11:51:59AM -0600, Nishanth Menon wrote:
> On 18:56-20231108, João Paulo Silva Gonçalves wrote:
> > Hello all, 
> > 
> > We are trying to minimize boot time for our AM62 devices.
> > Unfortunately, we have identified a delay of approximately 1.5
> > seconds caused by the sdhci_am654 driver. This delay is a result of
> > a timeout within the driver (MAX_POWER_ON_TIMEOUT) and was
> > introduced in commit 7ca0f16 ("mmc: sdhci_am654: Add workaround for
> > card detect debounce timer"). This issue arises only when there is
> > no SD card present in the MMC slot.  We tested the driver with a
> > lower timeout value and everything worked. However, as indicated in
> > the commit message, this timeout may be related to the way the sdhci
> > controller hardware IP works. Currently, the driver employs a sort
> > of a "busy loop" to wait for this timeout to pass delaying the boot.
> > Why is need to busy loop for this timeout? Is it possible to wait
> > for it in the backgroud? Am I am missing something here? 
> 
> I am not an mmc expert, but, Isn't this sequence part of the programmer
> manual in the TRM[1]?

Probably original question from Joao was not fully understood.

It is clear why the code is waiting for the CD, the issue we are
experiencing is that the whole boot is delayed by 1.5 seconds because of
that piece of code for no reason.

- SD card exists in the system, but it's not used and the card slot is empty
- We boot from eMMC (that has no CD pin)
- Boot is delayed by 1.5 second because of that piece of code

Francesco

