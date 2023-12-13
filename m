Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893A7811F96
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377931AbjLMT7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLMT7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:59:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16842EB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:59:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650E4C433C8;
        Wed, 13 Dec 2023 19:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702497589;
        bh=n4y6guQRV12k+liN2WHD+wd3QSw9JETlMI+NEhFXEvM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YYft67voJWxpBtLm5xqPzprpXz2B1yCo7ZrhnnWakz/NJaoH0i821cOvZiF4YISQq
         0Q5We9nWveoWSKZ1Ls+/RwyeFWXqWP1oXDrohPmOejUE68ozgge5vUbTZ//8Wo7Kig
         SztMPmEXg5mIRfwuf/IBtYuhHER0buqy5Pq+PVEPLpZ9ajKkyMG/i9hzW5inTtGP3H
         VbTJ6Dm5zDFrcl03Ovd1h/frFO+I7g4CpBLSzIhYmQBA0N4ApyTAa15Id3QHyPMiFR
         GxGz4Mlxhi1xmwmBRpZwWPPQUIRKqOufiLnSAFjQ+dB6/49i1AvZalL+ShevNK+yTW
         ZoXcLjK3/VSZA==
Date:   Wed, 13 Dec 2023 13:59:47 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     Cyril Brulebois <kibi@debian.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Conor Dooley <conor+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Jim Quinlan <jim2101024@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v8 0/2] PCI: brcmstb: Configure appropriate HW CLKREQ#
 mode
Message-ID: <20231213195947.GA1056194@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae49227b-5026-43a4-8e19-aeeb63865a6a@broadcom.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 03:51:12PM -0800, Florian Fainelli wrote:
> On 11/26/23 12:19, Cyril Brulebois wrote:
> > Hi Jim,
> > 
> > Jim Quinlan <james.quinlan@broadcom.com> (2023-11-13):
> > > V8 -- Un-advertise L1SS capability when in "no-l1ss" mode (Bjorn)
> > >     -- Squashed last two commits of v7 (Bjorn)
> > >     -- Fix DT binding description text wrapping (Bjorn)
> > >     -- Fix incorrect Spec reference (Bjorn)
> > >           s/PCIe Spec/PCIe Express Mini CEM 2.1 specification/
> > >     -- Text substitutions (Bjorn)
> > >           s/WRT/With respect to/
> > >           s/Tclron/T_CLRon/
> > > 
> > > v7 -- Manivannan Sadhasivam suggested (a) making the property look like a
> > >        network phy-mode and (b) keeping the code simple (not counting clkreq
> > >        signal appearances, un-advertising capabilites, etc).  This is
> > >        what I have done.  The property is now "brcm,clkreq-mode" and
> > >        the values may be one of "safe", "default", and "no-l1ss".  The
> > >        default setting is to employ the most capable power savings mode.
> > 
> > Still:
> > 
> > Tested-by: Cyril Brulebois <cyril@debamax.com>
> 
> Thanks Cyril! Bjorn, Lorenzo, any chance this can be applied soon? Thanks!

Seems OK to me if Lorenzo or Krzysztof W. are OK with it.
