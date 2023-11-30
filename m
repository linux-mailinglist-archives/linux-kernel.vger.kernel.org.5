Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3D27FED51
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345061AbjK3KwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjK3KwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:52:21 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32105E6;
        Thu, 30 Nov 2023 02:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701341548; x=1732877548;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2Loo84863mYt3Lh6biFrQxyHbhYSnUO9o1Ffbl3PYZc=;
  b=AfEDkE60VoTkDwD5QeHJyfmpVCKzjpFS6S8g+FeCWGYXMvkbYDXEGZXO
   cdChDKp/668eMINXNPkDB0DIFOGoIFsRDVSo26XTG3qWOKcsobWvHfUj9
   JWfKWBl++lcLNAUlZel4xx+WT5qJfQJ7GEtu3wHz97laiIUmLTJ8E+vOP
   c6HTR4MlgzzFyf1Fovcox7uCa36PhSYL6SI4Orh3foatB29cgxpKu80TI
   Nt0ZaUby2Xd0AorHuGiKEJx0Iqlzt16GzBWbE/lsHebMCbYsluG5PPu14
   gOv7+1uk02sGoNCxfhDlB1Gu3kyIK++fBkWsgFx7zqHZ2LPVnNm1Sl3Mp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="392171351"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="392171351"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 02:52:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="745594631"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="745594631"
Received: from bergler-mobl.ger.corp.intel.com ([10.249.33.30])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 02:52:23 -0800
Date:   Thu, 30 Nov 2023 12:52:20 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     Shuai Xue <xueshuai@linux.alibaba.com>,
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
In-Reply-To: <20231129231555.GA443895@bhelgaas>
Message-ID: <b2aeaf4-8960-8967-ce7b-663f9d77260@linux.intel.com>
References: <20231129231555.GA443895@bhelgaas>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1899874312-1701341547=:1808"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1899874312-1701341547=:1808
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 29 Nov 2023, Bjorn Helgaas wrote:

> On Mon, Nov 27, 2023 at 09:34:05AM +0800, Shuai Xue wrote:
> > On 2023/11/22 21:14, Ilpo Järvinen wrote:
> > > On Tue, 21 Nov 2023, Shuai Xue wrote:
> > > 
> > >> The clear and set pattern is commonly used for accessing PCI config,
> > >> move the helper pci_clear_and_set_dword() from aspm.c into PCI header.
> > >> In addition, rename to pci_clear_and_set_config_dword() to retain the
> > >> "config" information and match the other accessors.
> > >>
> > >> No functional change intended.

> > >> +
> > >> +void pci_clear_and_set_config_dword(const struct pci_dev *dev, int pos,
> > >> +				    u32 clear, u32 set)
> > > 
> > > Just noting that annoyingly the ordering within the name is inconsistent 
> > > between:
> > >   pci_clear_and_set_config_dword()
> > > and
> > >   pcie_capability_clear_and_set_dword()
> > > 
> > > And if changed, it would be again annoyingly inconsistent with 
> > > pci_read/write_config_*(), oh well... And renaming pci_read/write_config_* 
> > > into the hierarchical pci_config_read/write_*() form for would touch only 
> > > ~6k lines... ;-D
> > 
> > I think it is a good question, but I don't have a clear answer. I don't
> > know much about the name history.  As you mentioned, the above two
> > accessors are the foundation operation, may it comes to @Bjorn decision.
> > 
> > The pci_clear_and_set_config_dword() is a variant of below pci accessors:
> > 
> >     pci_read_config_dword()
> >     pci_write_config_dword()
> > 
> > At last, they are consistent :)
> 
> "pcie_capability_clear_and_set_dword" is specific to the PCIe
> Capability, doesn't work for arbitrary config space, and doesn't
> include the word "config".
> 
> "pci_clear_and_set_config_dword" seems consistent with the arbitrary
> config space accessor pattern.
> 
> At least "clear_and_set" is consistent across both.
> 
> I'm not too bothered by the difference between "clear_and_set_dword"
> (for the PCIe capability) and "clear_and_set_config_dword" (for
> arbitrary things).
> 
> Yes, "pcie_capability_clear_and_set_config_dword" would be a little
> more consistent, but seems excessively wordy (no pun intended).
> 
> But maybe I'm missing your point, Ilpo.  If so, what would you
> propose?

What I was hoping for a way to (eventually) have consistency in naming 
like this (that is, the place where "config" or "capabilitity" appears 
in the name):

pci_config_read_dword()
pci_config_clear_and_set_dword()
pcie_capability_read_dword()
pcie_capability_clear_and_set_dword()

(+ the omitted clear/set/write & size variants)

But thanks to pci_read_config_dword() & friends being there since dawn of 
time and with 6k+ instances, I guess I'm just dreaming of impossible 
things.

-- 
 i.

--8323329-1899874312-1701341547=:1808--
