Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C817BB9FC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjJFOL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjJFOL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:11:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B709E;
        Fri,  6 Oct 2023 07:11:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2613DC433C8;
        Fri,  6 Oct 2023 14:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696601517;
        bh=HF1mlt3JfTnZ6zzC1XqcWAhuLUIXosajTn5u998VX00=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ErZqtQTYQ89s7bu3kxbgj6kc+cONc+TH8XubUr1UWWFDFJwsB2Pt2BkNnZcr+yNyS
         54tDU/86q3bFunK96rQzHcUh8GFbZPk/kXbw1XEkEUkwg7Pn0SONJmNJiOQP3kS1cw
         eGKbKsPVv4cUne2JfmXB5ExHVC9/D6uBQ2HxRjFnxKvMYBh9BPaUGh3PiYfsU3g1As
         Mg+shI9m+mmXmKXX9SXKdhARfUmzN3YQyLr6FHGIE4ePFWPKrjoTxPTBsilLahBv30
         XiV8A1QvNchqmRfUgM8Y473/Li/+L5uxgHitd7WZ/P6tfGT0dK9+//ltGMjFN9u2oB
         s1dDyOkJlqwCg==
Date:   Fri, 6 Oct 2023 09:11:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the pci tree
Message-ID: <20231006141155.GA851474@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006115604.42971aa0@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 11:56:04AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the pci tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> arch/x86/pci/fixup.c: In function 'amd_rp_pme_suspend':
> arch/x86/pci/fixup.c:929:13: error: 'pm_suspend_target_state' undeclared (first use in this function)
>   929 |         if (pm_suspend_target_state == PM_SUSPEND_ON)
>       |             ^~~~~~~~~~~~~~~~~~~~~~~
> arch/x86/pci/fixup.c:929:13: note: each undeclared identifier is reported only once for each function it appears in
> arch/x86/pci/fixup.c:929:40: error: 'PM_SUSPEND_ON' undeclared (first use in this function); did you mean 'RPM_SUSPENDING'?
>   929 |         if (pm_suspend_target_state == PM_SUSPEND_ON)
>       |                                        ^~~~~~~~~~~~~
>       |                                        RPM_SUSPENDING
> arch/x86/pci/fixup.c: In function 'amd_rp_pme_resume':
> arch/x86/pci/fixup.c:951:27: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
>   951 |         rp->pme_support = FIELD_GET(PCI_PM_CAP_PME_MASK, pmc);
>       |                           ^~~~~~~~~
> 
> Caused by commit
> 
>   624306d2c241 ("x86/PCI: Avoid PME from D3hot/D3cold for AMD Rembrandt and Phoenix USB4")

How embarrassing.  I moved this from drivers/pci to arch/x86 and
obviously didn't even compile it afterwards.  Should be fixed now.

Bjorn
