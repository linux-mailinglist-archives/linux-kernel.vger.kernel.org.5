Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DED77264B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbjHGNoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234321AbjHGNnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:43:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E2222136;
        Mon,  7 Aug 2023 06:43:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 811DE1FB;
        Mon,  7 Aug 2023 06:43:23 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06E863F64C;
        Mon,  7 Aug 2023 06:42:38 -0700 (PDT)
Date:   Mon, 7 Aug 2023 14:42:29 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>,
        Shengyu Qu <wiagn233@outlook.com>,
        Martin Botka <martin.botka@somainline.org>,
        Martin Botka <martin@biqu3d.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] dt-bindings: mfd: x-powers,axp152: make interrupt
 optional for more chips
Message-ID: <20230807144229.5710738d@donnerap.manchester.arm.com>
In-Reply-To: <20230804153432.GA1388331-robh@kernel.org>
References: <20230802141829.522595-1-andre.przywara@arm.com>
        <20230804153432.GA1388331-robh@kernel.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2023 09:34:32 -0600
Rob Herring <robh@kernel.org> wrote:

Hi,

> On Wed, Aug 02, 2023 at 03:18:29PM +0100, Andre Przywara wrote:
> > All X-Powers PMICs described by this binding have an IRQ pin, and so
> > far (almost) all boards connected this to some NMI pin or GPIO on the SoC
> > they are connected to.
> > However we start to see boards that omit this connection, and technically
> > the IRQ pin is not essential to the basic PMIC operation.
> > The existing Linux driver allows skipping an IRQ pin setup for some
> > chips already, so update the binding to also make the DT property
> > optional for these chips, so that we can actually have DTs describing
> > boards with the PMIC interrupt not wired up.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> > Hi,
> > 
> > arguably the IRQ functionality is optional for many more PMICs,
> > especially if a board doesn't use GPIOs or a power key.
> > So I wonder if the interrupts property should become optional for all?
> > After all it's more a board designer's decision to wire up the IRQ pin
> > or not, and nothing that's really related to a particular PMIC.  
> 
> I would say yes. Particularly if it gets rid of a conditional schema.

I see your point, and we might get there, but after some digging extending
this to more/all PMICs needs more work, see below.
Given that I was wondering if we can merge this patch now, as this
blocks multiple DTs from being merged (and Connor already ACKed it).
I sent an MFD driver fix to make this actually work for the AXP313a:
https://lore.kernel.org/lkml/20230807133930.94309-1-andre.przywara@arm.com/

For supporting this on more PMICs:
Currently many Linux (sub-)drivers registered by the MFD driver crash when
there is no valid interrupt registered, and we so far just special cased
the very simple PMICs to skip just the power key driver registration,
which works for those chips. However this affects more drivers (I tested
ac-power-supply), so it's not clear if that's really something useful for
the other PMICs providing more functionality. I guess we can postpone this
until either there is actually a use case for those other PMICs (boards
without the IRQ line connected), or when this list of exceptions grows too
large.

Cheers,
Andre
