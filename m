Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E059B80AB38
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574519AbjLHRxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574510AbjLHRxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:53:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB5C1985
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 09:53:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9017C433C9;
        Fri,  8 Dec 2023 17:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702057994;
        bh=WF3sxOQXZ3wLw83HJCehVvDgBYIVEarCTX/DeEoTsgg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eGxycqgj63COmF0qtUQFBePJ0mPdT2BJNNnDWkCgHzbJ2siwtIgN1SHMUtVWygUGR
         ppDKj0ShIsRzytOd4fDSO6nHoubQbLjF7lqT4IcYvpmlVxzeZHo1znch1/4reOSwMm
         tPODYcSTifUfHzs/1ewcVh4pFM5iyntUJOwdiPUGixyMVuvqQkIirJ9RUZ3JA9I65n
         QFsYz4sHOBnW9E8sU4hjCYRLTphTNG+d8LxV8R89PSHYcIJFcVhYLnzKOeAF4xvzXr
         +8VH94qPGsSeZVClZprqW/ygYUhbBpfuZDdFZkk38/h1PfzlDyCHZLGruP2GpLEVip
         iQuuY5jkbVeKQ==
Date:   Fri, 8 Dec 2023 11:53:12 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] PCI: Fix deadlocks when enabling ASPM
Message-ID: <20231208175312.GA803148@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128081512.19387-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 09:15:06AM +0100, Johan Hovold wrote:
> The pci_enable_link_state() helper is currently only called from
> pci_walk_bus(), something which can lead to a deadlock as both helpers
> take a pci_bus_sem read lock.
> 
> Add a new locked helper which can be called with the read lock held and
> fix up the two current users (the second is new in 6.7-rc1).
> 
> Note that there are no users left of the original unlocked variant after
> this series, but I decided to leave it in place for now (e.g. to mirror
> the corresponding helpers to disable link states).
> 
> Included are also a couple of related cleanups.
> 
> Johan
> 
> 
> Changes in v2
>  - fix up the function name in a kernel doc comment as reported by the
>    kernel test robot <lkp@intel.com>
> 
> 
> Johan Hovold (6):
>   PCI/ASPM: Add locked helper for enabling link state
>   PCI: vmd: Fix deadlock when enabling ASPM
>   PCI: qcom: Fix deadlock when enabling ASPM
>   PCI: qcom: Clean up ASPM comment
>   PCI/ASPM: Clean up disable link state parameter
>   PCI/ASPM: Add lockdep assert to link state helper
> 
>  drivers/pci/controller/dwc/pcie-qcom.c |  7 ++-
>  drivers/pci/controller/vmd.c           |  2 +-
>  drivers/pci/pcie/aspm.c                | 65 +++++++++++++++++++-------
>  include/linux/pci.h                    |  3 ++
>  4 files changed, 56 insertions(+), 21 deletions(-)

Applied to for-linus for v6.7, thanks, Johan!
