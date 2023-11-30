Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF467FF972
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjK3SfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjK3SfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:35:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AB1C4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:35:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AFDC433C7;
        Thu, 30 Nov 2023 18:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701369307;
        bh=1KLmnXj3oH57djjg5RXbttA8qHBNJ7pmAovpuDi+A9Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FvXPQNeyANpdmDNj5C/xy3Or4/5l8FHT4OClrcmkIXl+IxeILBCmrYKMT/ITT2Vd7
         WBUKG7691rCWWVy0fuIUU5av1YqoToCl8SJQ09wF44UlcbPry22JAQv8DTgK/hWqr/
         sd6y+3qCGKh/e0NOwr7b+PFT6vrmHAwtlzPNVF5C+IzFQ59e2QLY+zhJKQbj0NS2nB
         yYcVu/0EiQSLL66ltpF92a4eDtClUrxhRN/vbsI5riJmgHUb82ylPOohbY/AYK/5Zp
         D4ENY0bTlquG7xTJpDXs8aOKLVBMmXRFitDd9X8QwbN+3HvTRx3wxA2PYbDPYaWqFN
         nYFsAuY8e0wHQ==
Date:   Thu, 30 Nov 2023 12:35:04 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kevin Xie <kevin.xie@starfivetech.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mason.huo@starfivetech.com,
        leyfoon.tan@starfivetech.com, minda.chen@starfivetech.com
Subject: Re: [PATCH v1] PCI: Add PCIE_CONFIG_REQUEST_WAIT_MS waiting time
 value
Message-ID: <20231130183504.GA487377@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0844a59-7534-4195-b656-eb51586cbff6@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 06:03:55PM +0800, Kevin Xie wrote:
> On 2023/11/30 7:21, Bjorn Helgaas wrote:
> > On Fri, Nov 24, 2023 at 09:45:08AM +0800, Kevin Xie wrote:
> >> Add the PCIE_CONFIG_REQUEST_WAIT_MS marco to define the minimum waiting
> >> time between sending the first configuration request to the device and
> >> exit from a conventional reset (or after link training completes).
> > 
> > s/marco/macro/
> > 
> > List the first event before the second one, i.e., the delay is from
> > exit from reset to the config request.
> 
> OK，I will use "from A to B" instead of "between A and B".

That's not my point.

My point was you said "between B (config request) and A (exit from
reset)".  "A" happens first, so it should be mentioned first.

> > I assume there are follow-on patches that actually use this?  Can we
> > make this the first patch in a series so we know we don't have an
> > unused macro lying around?
> 
> Yes, we will use the marco in the next version of our PCIe controller patches.
> Here is the link of current version patch series:
> https://lore.kernel.org/lkml/20231115114912.71448-20-minda.chen@starfivetech.com/T/#u 
> 
> Do you mean that I should put this patch back to the above series as
> one of the separate patches?

Yes, please.  Handling them as a group is less overhead and helps
avoid merge issues (if they're all in a series there's no possibility
that the user gets merged before the macro itself).

Bjorn
