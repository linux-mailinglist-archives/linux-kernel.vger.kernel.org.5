Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D378B811F4B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379004AbjLMTsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbjLMTsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:48:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA429C;
        Wed, 13 Dec 2023 11:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702496923; x=1734032923;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=aA4k2O4QxXBzZN4A6Xdv+7/OCMnepuyXKc9VbGVRZF4=;
  b=UYs4BEp19kcR+yRy4vlWPCepMONrNnvgdWQxqvAroSEIsnlpwUNM7yjB
   fK8QwVvVbNnToOWmAxThBEBYZzBUcsNuE5fkW4teXDbDStqlKgbu4GzT0
   mqDF+vXKGFMUSwtLUXx33CkkgB1oBKXJ7MNJzuQv/7xADOYqbHssuxAwW
   3hE8T7xLHCM4woBfHZcYf7nn4dDughXWE2o6tbDjYhtpZ8JXOfcR/YiGr
   L9pBhuoY0TqQg3L1MJNcCkV6zcDdirnz8LsS/BwF57Z7kHxdnq9kt4cRB
   ZV588yHRZb1+6NM7fbc7EDlYcTyPJLHTapsjehjYjn0z5oPCl0cl2XcKA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="8412616"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="8412616"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 11:48:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="864730997"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="864730997"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 11:48:42 -0800
Received: from acharris-mobl.amr.corp.intel.com (unknown [10.255.228.183])
        by linux.intel.com (Postfix) with ESMTP id DFF9B580DA9;
        Wed, 13 Dec 2023 11:48:41 -0800 (PST)
Message-ID: <970144d9b5c3d36dbd0d50f01c1c4355cd42de89.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/6] PCI/ASPM: Add locked helper for enabling link
 state
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
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
Date:   Wed, 13 Dec 2023 11:48:41 -0800
In-Reply-To: <20231212212707.GA1021099@bhelgaas>
References: <20231212212707.GA1021099@bhelgaas>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-12-12 at 15:27 -0600, Bjorn Helgaas wrote:
> On Tue, Dec 12, 2023 at 11:48:27AM +0800, Kai-Heng Feng wrote:
> > On Fri, Dec 8, 2023 at 4:47=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.or=
g> wrote:
> > ...
>=20
> > > I hope we can obsolete this whole idea someday.=C2=A0 Using pci_walk_=
bus()
> > > in qcom and vmd to enable ASPM is an ugly hack to work around this
> > > weird idea that "the OS isn't allowed to enable more ASPM states than
> > > the BIOS did because the BIOS might have left ASPM disabled because i=
t
> > > knows about hardware issues."=C2=A0 More history at
> > > https://lore.kernel.org/linux-pci/20230615070421.1704133-1-kai.heng.f=
eng@canonical.com/T/#u
> > >=20
> > > I think we need to get to a point where Linux enables all supported
> > > ASPM features by default.=C2=A0 If we really think x86 BIOS assumes a=
n
> > > implicit contract that the OS will never enable ASPM more
> > > aggressively, we might need some kind of arch quirk for that.
> >=20
> > The reality is that PC ODM toggles ASPM to workaround hardware
> > defects, assuming that OS will honor what's set by the BIOS.
> > If ASPM gets enabled for all devices, many devices will break.
>=20
> That's why I mentioned some kind of arch quirk.=C2=A0 Maybe we're forced =
to
> do that for x86, for instance.=C2=A0 But even that is a stop-gap.
>=20
> The idea that the BIOS ASPM config is some kind of handoff protocol is
> really unsupportable.

To be clear, you are not talking about a situation where ACPI_FADT_NO_ASPM =
or
_OSC PCIe disallow OS ASPM control, right? Everyone agrees that this should=
 be
honored? The question is what to do by default when the OS is not restricte=
d by
these mechanisms?

Reading the mentioned thread, I too think that using the BIOS config as the
default would be the safest option, but only to avoid breaking systems, not
because of an implied contract between the BIOS and OS. However, enabling a=
ll
capable ASPM features is the ideal option. If the OS isn't limited by
ACPI_FADT_NO_ASPM or _OSC PCIe, then ASPM enabling is fully under its contr=
ol.
If this doesn't work for some devices then they are broken and need a quirk=
.

David
