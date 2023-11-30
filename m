Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5D47FF989
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346723AbjK3Shz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjK3Shv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:37:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBDC10F4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:37:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11F4C433C7;
        Thu, 30 Nov 2023 18:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701369477;
        bh=KTVhbWtyOj5CHYptB/YZKupH8RBoVdAwyN+Tqnv2IoU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eQGSObfEQXMLIIKR6qHyTIIAkvri7MN76Pfg66IW6uLH1LHSD5zbVupZEwxvYUxXE
         wDl4+SKwotJbMzkQH3H8p1iDblk8ocNDsu2RGzoYuoTVU2AP36Kr2+1YJZ+OXxr5mE
         UJi6QFIr70DZVNBcg46d6209zrswsp/0gl7QdKdOog9MwYDuPTU4VIzF/Nk3QxslF4
         iH5iO+rT67b8SU74Yzo6wUrRaE0uMjSKoRKCLGnHqrbLyy+kpPhnR0Y9caBCDxQXNU
         YmpOF4uSi3tplWADKJ3XC1AdZ3iy4lCiCxmts2fi7IP6Qq1PPTC5JX+Nx5BAvQVfBD
         MIXmEeOarJ+9A==
Date:   Thu, 30 Nov 2023 12:37:55 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Shuai Xue <xueshuai@linux.alibaba.com>,
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
Message-ID: <20231130183755.GA487634@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2aeaf4-8960-8967-ce7b-663f9d77260@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 12:52:20PM +0200, Ilpo Järvinen wrote:
> On Wed, 29 Nov 2023, Bjorn Helgaas wrote:
> > On Mon, Nov 27, 2023 at 09:34:05AM +0800, Shuai Xue wrote:
> > > On 2023/11/22 21:14, Ilpo Järvinen wrote:
> > > > On Tue, 21 Nov 2023, Shuai Xue wrote:
> > > > 
> > > >> The clear and set pattern is commonly used for accessing PCI config,
> > > >> move the helper pci_clear_and_set_dword() from aspm.c into PCI header.
> > > >> In addition, rename to pci_clear_and_set_config_dword() to retain the
> > > >> "config" information and match the other accessors.
> > > >>
> > > >> No functional change intended.
> 
> > > >> +
> > > >> +void pci_clear_and_set_config_dword(const struct pci_dev *dev, int pos,
> > > >> +				    u32 clear, u32 set)
> > > > 
> > > > Just noting that annoyingly the ordering within the name is inconsistent 
> > > > between:
> > > >   pci_clear_and_set_config_dword()
> > > > and
> > > >   pcie_capability_clear_and_set_dword()
> > > > 
> > > > And if changed, it would be again annoyingly inconsistent with 
> > > > pci_read/write_config_*(), oh well... And renaming pci_read/write_config_* 
> > > > into the hierarchical pci_config_read/write_*() form for would touch only 
> > > > ~6k lines... ;-D
> > > 
> > > I think it is a good question, but I don't have a clear answer. I don't
> > > know much about the name history.  As you mentioned, the above two
> > > accessors are the foundation operation, may it comes to @Bjorn decision.
> > > 
> > > The pci_clear_and_set_config_dword() is a variant of below pci accessors:
> > > 
> > >     pci_read_config_dword()
> > >     pci_write_config_dword()
> > > 
> > > At last, they are consistent :)
> > 
> > "pcie_capability_clear_and_set_dword" is specific to the PCIe
> > Capability, doesn't work for arbitrary config space, and doesn't
> > include the word "config".
> > 
> > "pci_clear_and_set_config_dword" seems consistent with the arbitrary
> > config space accessor pattern.
> > 
> > At least "clear_and_set" is consistent across both.
> > 
> > I'm not too bothered by the difference between "clear_and_set_dword"
> > (for the PCIe capability) and "clear_and_set_config_dword" (for
> > arbitrary things).
> > 
> > Yes, "pcie_capability_clear_and_set_config_dword" would be a little
> > more consistent, but seems excessively wordy (no pun intended).
> > 
> > But maybe I'm missing your point, Ilpo.  If so, what would you
> > propose?
> 
> What I was hoping for a way to (eventually) have consistency in naming 
> like this (that is, the place where "config" or "capabilitity" appears 
> in the name):
> 
> pci_config_read_dword()
> pci_config_clear_and_set_dword()
> pcie_capability_read_dword()
> pcie_capability_clear_and_set_dword()

Ah, I see, thanks.

> But thanks to pci_read_config_dword() & friends being there since dawn of 
> time and with 6k+ instances, I guess I'm just dreaming of impossible 
> things.

Yeah, I think so.

Bjorn
