Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A5B80AAEB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbjLHRja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjLHRj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:39:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE251994
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 09:39:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46BEC433C8;
        Fri,  8 Dec 2023 17:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702057173;
        bh=Z1QJunFWmvP8Ozi9c83wdN1Wu0Ksv55A8wwkLTDgsxE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KTwcJWCdXdJkedS9sruBSnLdKvns4uoenFlFRNHT1IyXZ5UgV0/e24pFD2gurpl7V
         qptyZ0rYWcTH+qGwzVFCUzyZrCXNDoeQO9L4TOFWt05no7tFPjjSTSfXiCdydoXe24
         vmRgbwSZe2pyyoyB+rxHAvHib8HH5b8jGy3hBgimblIcWnpmqjkoX2l9QzMWG6wX6I
         Ix2iyoOlfS1LdZYMo/xrjVVVW7ylOcB7O5l7pG9SGl7SISnbNIt0CePsjL4c06Fujt
         HXWxLIkH3Lqu9AoIT/zO/mkFvLT7RcHLPFrtnjPxnHXvX1M32Cjr8fudI0KI5Fs7WF
         lfGmJcBeC4eCg==
Date:   Fri, 8 Dec 2023 11:39:32 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Johan Hovold <johan@kernel.org>
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
Message-ID: <20231208173932.GA798089@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXLNONZRafTkOk9U@hovoldconsulting.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 09:00:56AM +0100, Johan Hovold wrote:
> On Thu, Dec 07, 2023 at 02:47:16PM -0600, Bjorn Helgaas wrote:
> > On Tue, Nov 28, 2023 at 09:15:07AM +0100, Johan Hovold wrote:
> > > Add a helper for enabling link states that can be used in contexts where
> > > a pci_bus_sem read lock is already held (e.g. from pci_walk_bus()).
> > > 
> > > This helper will be used to fix a couple of potential deadlocks where
> > > the current helper is called with the lock already held, hence the CC
> > > stable tag.
> 
> > As far as I can see, we end up with pci_enable_link_state() defined
> > but never called and pci_enable_link_state_locked() being called only
> > by pcie-qcom.c and vmd.c.
> 
> Correct, I mentioned this in the cover letter.

Ah, right.  I really don't like these exported locked/unlocked
interfaces because pci_bus_sem is internal to the PCI core, and the
caller shouldn't need to know or be able to specify whether it is held
or not.  They exist for now, but I think we should try to get rid of
them.

> > Can we just rename pci_enable_link_state() to
> > pci_enable_link_state_locked() and assert that pci_bus_sem is held, so
> > we don't end up with a function that's never used?
> 
> That would work too. I went with adding a new helper to facilitate
> stable backports and to mirror pci_disable_link_state(). The variants
> are simple wrappers around the implementation so there's no real cost to
> having the unused one.

Makes good sense.  There's no real machine cost to the unused one; I'm
more concerned about the human cost here.

> But it seems like you think there will never be a need to call this
> helper outside of pci_walk_bus() and if so we can drop the unlocked
> variant right away.
> 
> Would you prefer basically squashing the first three patches and mark
> the result for stable even though that patch will fail to apply to older
> kernels as the Qualcomm bits went into -rc1?
> 
> Or should I send a follow-on patch removing the unused helper after
> merging this series?

I think you did the right thing.

Bjorn
