Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDF97FED89
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjK3LKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjK3LKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:10:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B879D50
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:10:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A491AC433C8;
        Thu, 30 Nov 2023 11:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701342622;
        bh=SjhlINoIwso49e7CMCFoGN/qtMdMriRoe6RxeuRtQik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C9dzChacAES531HEvRBhF4PlksKboYYXj6iZr4/Nfv68Pc1zacj1a5A7bUbDv7D09
         +4cM70at56yxNfqA2dIc5vLkInq04CdjMY5mcEP6pWIljlyVT0jS4vTmgj9hHHBskv
         IcdO0u8KfSarVg3hgSLQNZR5bQgetbIuegpAEURQ=
Date:   Thu, 30 Nov 2023 11:10:19 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, Wasim Khan <wasim.khan@nxp.com>,
        Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>
Subject: Re: [PATCH pci] PCI: remove the PCI_VENDOR_ID_NXP alias
Message-ID: <2023113014-preflight-roundish-d796@gregkh>
References: <20231122154241.1371647-1-vladimir.oltean@nxp.com>
 <20231129233827.GA444332@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129233827.GA444332@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 05:38:27PM -0600, Bjorn Helgaas wrote:
> [+cc Greg because these mergers & spinoffs happen all the time, and
> pci_ids.h doesn't necessarily need to keep up, so maybe there's
> precedent for what to do here]

Yes, the precedent is to leave it alone.

> On Wed, Nov 22, 2023 at 05:42:41PM +0200, Vladimir Oltean wrote:
> > What is today NXP is the result of some mergers (with Freescale) and
> > spin-offs (from Philips).
> > 
> > New NXP hardware (for example NETC version 4.1 of the NXP i.MX95
> > SoC) uses PCI_VENDOR_ID_PHILIPS. And some older hardware uses
> > PCI_VENDOR_ID_FREESCALE.
> > 
> > If we have PCI_VENDOR_ID_NXP as an alias for PCI_VENDOR_ID_FREESCALE,
> > we end up needing something like a PCI_VENDOR_ID_NXP2 alias for
> > PCI_VENDOR_ID_PHILIPS. I think this is more confusing than just spelling
> > out the vendor ID of the original company that claimed it.
> > 
> > FWIW, the pci.ids repository as of today has:
> > 1131  Philips Semiconductors
> > 1957  Freescale Semiconductor Inc
> > 
> > so this makes the kernel code consistent with that, and with what
> > "lspci" prints.
> 
> Hmm.  I can't find the 0x1957 Vendor ID here:
> https://pcisig.com/membership/member-companies, which is supposed to
> be the authoritative source AFAICS.
> 
> Also, that page lists 0x1131 as "NXP Semiconductors".
> 
> There's a contact email on that page if it needs updates.
> 
> I don't quite understand the goal here.  The company is now called
> "NXP", and this patch removes PCI_VENDOR_ID_NXP (the only instance of
> "NXP" in pci_ids.h) and uses PCI_VENDOR_ID_FREESCALE (which apparently
> does not exist any more)?
> 
> Why would we remove name of the current company and use the name of a
> company that doesn't exist any more?

Yes, this seems very odd.  What is the reason for any of this other than
marketing?  Kernel code doesn't do marketing :)

thanks,

greg k-h
