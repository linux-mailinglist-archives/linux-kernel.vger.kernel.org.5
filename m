Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4D6813887
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443983AbjLNR2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjLNR2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:28:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6072A121
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:28:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9B0C433C9;
        Thu, 14 Dec 2023 17:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702574930;
        bh=P8WIww2274+m+ez0eGWOb23W8iwkilWxoapMNkXmSoI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XSEj/glB2zBkw6SiLPvUtM7upEYS6XnUikmteJZhAXnZflzbW9uW2qbKlLuj8JaR3
         UhCXpC+lFeRGOw1IH9McsmcQIHs88KaO0Zm++1VMWO0glWqQbsdtsF9It0QV/TVoeK
         tizuaDJFXwxG+GqeCFsx5zJVqjTyuJt7syIyQXYW+tgvVRDUw022BVmN4duObs3PK0
         gx3rV4ogqff+iZhJ3WSTWwtSNdqoH8GuBE9oNeW9qYcb7dHFDqtBzlcgFPhTQOu9um
         BUFF59MaswASLf/oCfWgvWtd1L4cH6+ERTkVa6W5wGNh642111BGBanJ0MsJQLXH4g
         QX8Sj6bAewScw==
Date:   Thu, 14 Dec 2023 11:28:48 -0600
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
Message-ID: <20231214172848.GA1095194@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb42db34f456c3a157cc574893fd73d877b85b75.camel@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 03:39:24PM -0800, David E. Box wrote:
> On Wed, 2023-12-13 at 14:45 -0600, Bjorn Helgaas wrote:
> ...

> > I'd be shocked if Windows treated the BIOS config as a "do not exceed
> > this" situation, so my secret hope is that some of these "broken"
> > devices are really caused by defects in the Linux ASPM support or the
> > driver, and that we can fix them if we find out about them.
> > 
> > But I have no details about any of these alleged broken devices, so
> > it's hard to make progress on them.  
> 
> I don't have a sense of the scope either. But I could see BIOS not
> enabling features that would provide no added power savings benefit.
> We use ASPM to manage package power. There are Intel devices that
> certainly don't require L1SS for the SoC to achieve the deepest
> power savings. L1 alone is fine for them. I don't know what the test
> coverage is for unenabled features. I've sent these questions to
> our BIOS folks.

Once upon a time there was a push to make it so firmware only had to
enumerate boot and console devices and it could skip enumeration and
configuration of other devices.  But I don't think we've made much
progress on that, at least for x86, possibly because Linux depends so
much on BIOS resource assignment.  IMO that's a Linux deficiency.

Bjorn
