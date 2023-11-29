Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52337FE41C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 00:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343649AbjK2XPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 18:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK2XPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 18:15:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B788D54
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 15:15:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6817CC433C9;
        Wed, 29 Nov 2023 23:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701299757;
        bh=eZ85cA7Ik1tM1F3uhz1PsvW2kqzGygwIuLJ/hwc0ym8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lsmYRCtmKFcBu1rcXaomCG95v4pA6taD5qmHpyLOrgRIDlZ1SOWv5L+WIZ8hyBMum
         laxg0oycsMQQkuO1QeJIcjlqYNWqmEBqXg/4gz5SspvN0xpYzYOM0siFTlJG8ryyHp
         vljciukoKJwsG8RuHFositnwxAh75YOMaei6kmhKKGyL00wIYrEovNqm+rR2+AHcW7
         ORb0aQ0cGLdsnPAfKE/rnH8Yfiu7CQ7WO+/Qa3Arr5beMLLBhhoTr/hdY5+35TE1Bh
         QIi8nDG56bIgOx8PQbM11gjbmbRnQ1j3Jj2msYgAFjW6uGlvOcwym5mBzcfNulMSfa
         im9jbRW+GrMtA==
Date:   Wed, 29 Nov 2023 17:15:55 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        ilkka@os.amperecomputing.com, kaishen@linux.alibaba.com,
        yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com, chengyou@linux.alibaba.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        rdunlap@infradead.org, mark.rutland@arm.com,
        zhuo.song@linux.alibaba.com, renyu.zj@linux.alibaba.com
Subject: Re: [PATCH v11 3/5] PCI: Move pci_clear_and_set_dword() helper to
 PCI header
Message-ID: <20231129231555.GA443895@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71fa699f-5130-401a-bf4a-3271579a8dda@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 09:34:05AM +0800, Shuai Xue wrote:
> On 2023/11/22 21:14, Ilpo Järvinen wrote:
> > On Tue, 21 Nov 2023, Shuai Xue wrote:
> > 
> >> The clear and set pattern is commonly used for accessing PCI config,
> >> move the helper pci_clear_and_set_dword() from aspm.c into PCI header.
> >> In addition, rename to pci_clear_and_set_config_dword() to retain the
> >> "config" information and match the other accessors.
> >>
> >> No functional change intended.
> >>
> >> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> >> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> >> Tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> >> ---
> >>  drivers/pci/access.c    | 12 ++++++++
> >>  drivers/pci/pcie/aspm.c | 65 +++++++++++++++++++----------------------
> >>  include/linux/pci.h     |  2 ++
> >>  3 files changed, 44 insertions(+), 35 deletions(-)
> >>
> >> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> >> index 6554a2e89d36..6449056b57dd 100644
> >> --- a/drivers/pci/access.c
> >> +++ b/drivers/pci/access.c
> >> @@ -598,3 +598,15 @@ int pci_write_config_dword(const struct pci_dev *dev, int where,
> >>  	return pci_bus_write_config_dword(dev->bus, dev->devfn, where, val);
> >>  }
> >>  EXPORT_SYMBOL(pci_write_config_dword);
> >> +
> >> +void pci_clear_and_set_config_dword(const struct pci_dev *dev, int pos,
> >> +				    u32 clear, u32 set)
> > 
> > Just noting that annoyingly the ordering within the name is inconsistent 
> > between:
> >   pci_clear_and_set_config_dword()
> > and
> >   pcie_capability_clear_and_set_dword()
> > 
> > And if changed, it would be again annoyingly inconsistent with 
> > pci_read/write_config_*(), oh well... And renaming pci_read/write_config_* 
> > into the hierarchical pci_config_read/write_*() form for would touch only 
> > ~6k lines... ;-D
> 
> I think it is a good question, but I don't have a clear answer. I don't
> know much about the name history.  As you mentioned, the above two
> accessors are the foundation operation, may it comes to @Bjorn decision.
> 
> The pci_clear_and_set_config_dword() is a variant of below pci accessors:
> 
>     pci_read_config_dword()
>     pci_write_config_dword()
> 
> At last, they are consistent :)

"pcie_capability_clear_and_set_dword" is specific to the PCIe
Capability, doesn't work for arbitrary config space, and doesn't
include the word "config".

"pci_clear_and_set_config_dword" seems consistent with the arbitrary
config space accessor pattern.

At least "clear_and_set" is consistent across both.

I'm not too bothered by the difference between "clear_and_set_dword"
(for the PCIe capability) and "clear_and_set_config_dword" (for
arbitrary things).

Yes, "pcie_capability_clear_and_set_config_dword" would be a little
more consistent, but seems excessively wordy (no pun intended).

But maybe I'm missing your point, Ilpo.  If so, what would you
propose?

Bjorn
