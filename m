Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13D6812028
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 21:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442628AbjLMUpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 15:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLMUpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 15:45:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D54EAF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 12:45:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0203C433C8;
        Wed, 13 Dec 2023 20:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702500314;
        bh=CctU/GXFsJ6lkzjLDWKmTw9Q8WHFXHMPsA3fF1u3ins=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jU0biiVwBqqCmMPRcXhKvCDlf5/4gMNy06byWaEFkVgA+mOoYcSVBKhWycLe60QTE
         dPvQSQLQjGzSLvS8QGPNwrQeuVTpyPReHAkMKGJHFmX3rdhvv+dELhJDUMEAfJ+HLk
         GfQEns7Arnq4/Oi6o4IGLO3QDuXI/fTGO4yFdypXzodmQkGQ9fsdMFqWZxhmnRbq4G
         kqD/6D/kkoyBkuYABDuS1FFHFSZVuQ9ijv9eyXeC9LaJF++Bh6LghOcFJNzH783MG3
         TAmWPGpxmnmCqlnxz7pJfrPrJYSqJ1EnfQw2WlUR5D2ABvELju644Ai3BM7nvbUoc+
         NiS6BH/jeSW0g==
Date:   Wed, 13 Dec 2023 14:45:12 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Johan Hovold <johan+linaro@kernel.org>,
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
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2 1/6] PCI/ASPM: Add locked helper for enabling link
 state
Message-ID: <20231213204512.GA1056289@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <970144d9b5c3d36dbd0d50f01c1c4355cd42de89.camel@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 11:48:41AM -0800, David E. Box wrote:
> On Tue, 2023-12-12 at 15:27 -0600, Bjorn Helgaas wrote:
> > On Tue, Dec 12, 2023 at 11:48:27AM +0800, Kai-Heng Feng wrote:
> > > On Fri, Dec 8, 2023 at 4:47 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > ...
> > 
> > > > I hope we can obsolete this whole idea someday.  Using pci_walk_bus()
> > > > in qcom and vmd to enable ASPM is an ugly hack to work around this
> > > > weird idea that "the OS isn't allowed to enable more ASPM states than
> > > > the BIOS did because the BIOS might have left ASPM disabled because it
> > > > knows about hardware issues."  More history at
> > > > https://lore.kernel.org/linux-pci/20230615070421.1704133-1-kai.heng.feng@canonical.com/T/#u
> > > > 
> > > > I think we need to get to a point where Linux enables all supported
> > > > ASPM features by default.  If we really think x86 BIOS assumes an
> > > > implicit contract that the OS will never enable ASPM more
> > > > aggressively, we might need some kind of arch quirk for that.
> > > 
> > > The reality is that PC ODM toggles ASPM to workaround hardware
> > > defects, assuming that OS will honor what's set by the BIOS.
> > > If ASPM gets enabled for all devices, many devices will break.
> > 
> > That's why I mentioned some kind of arch quirk.  Maybe we're forced to
> > do that for x86, for instance.  But even that is a stop-gap.
> > 
> > The idea that the BIOS ASPM config is some kind of handoff protocol is
> > really unsupportable.
> 
> To be clear, you are not talking about a situation where
> ACPI_FADT_NO_ASPM or _OSC PCIe disallow OS ASPM control, right?
> Everyone agrees that this should be honored? The question is what to
> do by default when the OS is not restricted by these mechanisms?

Exactly.  The OS should respect ACPI_FADT_NO_ASPM and _OSC.

I think there are a couple exceptions where we want to disable ASPM
even if the platform said the OS shouldn't touch ASPM at all, but
that's a special case.

> Reading the mentioned thread, I too think that using the BIOS config
> as the default would be the safest option, but only to avoid
> breaking systems, not because of an implied contract between the
> BIOS and OS. However, enabling all capable ASPM features is the
> ideal option. If the OS isn't limited by ACPI_FADT_NO_ASPM or _OSC
> PCIe, then ASPM enabling is fully under its control.  If this
> doesn't work for some devices then they are broken and need a quirk.

Agreed.  It may not be practical to identify such devices, so we may
need a broader arch-based and/or date-based quirk.

I'd be shocked if Windows treated the BIOS config as a "do not exceed
this" situation, so my secret hope is that some of these "broken"
devices are really caused by defects in the Linux ASPM support or the
driver, and that we can fix them if we find out about them.

But I have no details about any of these alleged broken devices, so
it's hard to make progress on them.  Maybe we should log a debug note
if the device advertises ASPM support that BIOS didn't enable.

Bjorn
