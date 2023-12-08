Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F50809DD1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 09:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573369AbjLHICD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 03:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbjLHIBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 03:01:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2141996
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 00:00:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED718C433C8;
        Fri,  8 Dec 2023 08:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702022408;
        bh=KHV0ZGPq3MX7s2HDIPDrsThZSX5szDZVhE9ErAHo8tU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AZ6Ap3slRyF3YOWOEdPCjpEcYV/WFG+MzvEYoskaV3JjcRPj/DXi4sJwrnDEfiROs
         /B8tYAoITAczfm+WZgkiHC3TQv1T9L/5HMBNuqayfsAA65hq5A1Dn0kko1JFRM4BOE
         arOc5GuDHJhI92B9guVaicWT2ktdtjJc+pRoPl1R65B60jIRjh69cN+g0NXzzCKtNP
         14DNELaKEs7cPaz2sOKer4ZCljM2Y6YAx7OLE7oZ1W++x9HEWedtLL9XtOlAFK/35X
         3J7QLVD28YI/w8ekJTrka6m1DE5vAYoQjE9QDLyR1S3uxsIIpbB4jioEdDzMgJ5jdN
         JKT96xnf21b9g==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1rBVn6-0001Vo-1K;
        Fri, 08 Dec 2023 09:00:57 +0100
Date:   Fri, 8 Dec 2023 09:00:56 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v2 1/6] PCI/ASPM: Add locked helper for enabling link
 state
Message-ID: <ZXLNONZRafTkOk9U@hovoldconsulting.com>
References: <20231128081512.19387-2-johan+linaro@kernel.org>
 <20231207204716.GA764883@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207204716.GA764883@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 02:47:16PM -0600, Bjorn Helgaas wrote:
> [+cc Kai-Heng]
> 
> On Tue, Nov 28, 2023 at 09:15:07AM +0100, Johan Hovold wrote:
> > Add a helper for enabling link states that can be used in contexts where
> > a pci_bus_sem read lock is already held (e.g. from pci_walk_bus()).
> > 
> > This helper will be used to fix a couple of potential deadlocks where
> > the current helper is called with the lock already held, hence the CC
> > stable tag.

> As far as I can see, we end up with pci_enable_link_state() defined
> but never called and pci_enable_link_state_locked() being called only
> by pcie-qcom.c and vmd.c.

Correct, I mentioned this in the cover letter.

> Can we just rename pci_enable_link_state() to
> pci_enable_link_state_locked() and assert that pci_bus_sem is held, so
> we don't end up with a function that's never used?

That would work too. I went with adding a new helper to facilitate
stable backports and to mirror pci_disable_link_state(). The variants
are simple wrappers around the implementation so there's no real cost to
having the unused one.

But it seems like you think there will never be a need to call this
helper outside of pci_walk_bus() and if so we can drop the unlocked
variant right away.

Would you prefer basically squashing the first three patches and mark
the result for stable even though that patch will fail to apply to older
kernels as the Qualcomm bits went into -rc1?

Or should I send a follow-on patch removing the unused helper after
merging this series?

The end-result will be identical.

Johan
