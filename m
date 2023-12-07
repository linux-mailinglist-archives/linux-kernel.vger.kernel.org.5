Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21156808919
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441815AbjLGNYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjLGNYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:24:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCD610CF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 05:24:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC5BC433C8;
        Thu,  7 Dec 2023 13:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701955450;
        bh=Jox1QVTW8FXBAFs6KYjS5LP35vS3J8LsKIserpsx4M4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gGDYoQUazfRrRuCGF4JdheCnrSUcHxAIAbG6QHlxeYxdA9W1ASLJ7tmX/W0IndNBP
         FzxogXB9Ae/rUfISxZEtYCtZ4HUei+hSYS3rK41aQ5sQmFzArfEQuH06HOV21MfZ+m
         dGY2Qwat3aSBQi3zaerNoRjURTPiEDsr2bKRSiiUzfKP34SJPriCH/UNJoPRvpUhhO
         /2zRt2YM9VrE8hJaOnMNQ1d+BlOOVel4X+NJgZABowrAjCZvH6s7sHRazn6hCvIIAo
         zJC+M2aJjfn0EA5EjH+gs7Ox0beesWs7tZ8dZ6lmceyc4KTBmsMvcljuOdNBPQgvjl
         hmiUksYrzbmvQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1rBENA-0000PW-0p;
        Thu, 07 Dec 2023 14:25:00 +0100
Date:   Thu, 7 Dec 2023 14:25:00 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@leemhuis.info
Subject: Re: [PATCH v2 0/6] PCI: Fix deadlocks when enabling ASPM
Message-ID: <ZXHHrCDKKQbGIxli@hovoldconsulting.com>
References: <20231128081512.19387-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128081512.19387-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi PCI maintainers,

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

> Johan Hovold (6):
>   PCI/ASPM: Add locked helper for enabling link state
>   PCI: vmd: Fix deadlock when enabling ASPM
>   PCI: qcom: Fix deadlock when enabling ASPM
>   PCI: qcom: Clean up ASPM comment
>   PCI/ASPM: Clean up disable link state parameter
>   PCI/ASPM: Add lockdep assert to link state helper

Could we get this merged for 6.7-rc5? Even if the risk of a deadlock is
not that great, this bug prevents using lockdep on Qualcomm platforms so
that more locking issues can potentially make their way into the kernel.

And for Qualcomm platforms, this is a regression in 6.7-rc1.

Johan


#regzbot introduced: 9f4f3dfad8cf
