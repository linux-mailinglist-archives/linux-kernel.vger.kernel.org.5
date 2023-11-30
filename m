Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73977FF158
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345883AbjK3OKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345844AbjK3OKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:10:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A683283;
        Thu, 30 Nov 2023 06:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701353422; x=1732889422;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=kN5I9HQ5x9SAa/HfKyTGxyzRxa4iwChsWjzT0RrfCnc=;
  b=dfhGNfZu5R1PNdK1AwcGN67T7nKvLUycpNMWw1zBLRWrmucjKOZmSDRG
   H32McCZrbfz3k42BvlUIkKDBhsihXtmQ/vxume+smR1SVwTBH2G9GV9W1
   Nc61FDuVKIJvwe774J2EpiCTE1pXVbTJxRt/ek7FzPMGFGcLSnskxGaKi
   eMoB0Pq/XquTRHslto+Nns1EUy2nChG1A8Bpik/8CyYy9mdqBU8eaElv6
   sfjCN8ILP1Fx5aY7tWH0bMGUnKVyEksVO1LVOdO+oq2ftGy2HmIS+EVGJ
   5iA8xwlPMNRjmqARRt70DXZ34ZVKNvzpi6WuvWJnRaRv8GdBQP7pbs9SS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="457649167"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="457649167"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 06:10:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="913208696"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="913208696"
Received: from rwwalter-mobl.amr.corp.intel.com (HELO [10.212.92.184]) ([10.212.92.184])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 06:10:21 -0800
Message-ID: <2c3966b13ac5bb2db879aa2872e5a0a9728bc708.camel@linux.intel.com>
Subject: Re: [PATCH 1/6] platform/x86/intel/tpmi: Add additional TPMI header
 fields
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 30 Nov 2023 09:10:20 -0500
In-Reply-To: <57956e96-449e-979e-dda0-fe1d1639f8a4@linux.intel.com>
References: <20231128185605.3027653-1-srinivas.pandruvada@linux.intel.com>
         <20231128185605.3027653-2-srinivas.pandruvada@linux.intel.com>
         <57956e96-449e-979e-dda0-fe1d1639f8a4@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-11-30 at 14:33 +0200, Ilpo J=C3=A4rvinen wrote:
> On Tue, 28 Nov 2023, Srinivas Pandruvada wrote:
>=20
> > TPMI information header added additional fields in version 2. Some
> > of the
> > reserved fields in version 1 are used to define new fields.
> > Parse new fields and export as part of platform data. These fields
> > include:
> > - PCI segment ID
> > - Partition ID of the package, useful when more than one Intel VSEC
> > PCI
> > device per package
> > - cdie_mask: Mask of all compute dies in this partition
> >=20
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> > ---
> > =C2=A0drivers/platform/x86/intel/tpmi.c | 11 ++++++++++-
> > =C2=A0include/linux/intel_tpmi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 6 ++++++
> > =C2=A02 files changed, 16 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/platform/x86/intel/tpmi.c
> > b/drivers/platform/x86/intel/tpmi.c
> > index 311abcac894a..c89aa4d14bea 100644
> > --- a/drivers/platform/x86/intel/tpmi.c
> > +++ b/drivers/platform/x86/intel/tpmi.c
> > @@ -128,6 +128,9 @@ struct intel_tpmi_info {
> > =C2=A0 * @dev:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PCI device numb=
er
> > =C2=A0 * @bus:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PCI bus number
> > =C2=A0 * @pkg:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CPU Package id
> > + * @segment: PCI segment id
> > + * @partition: Package Partition id
> > + * @cdie_mask: Bitmap of compute dies in the current partition
> > =C2=A0 * @reserved:=C2=A0=C2=A0Reserved for future use
> > =C2=A0 * @lock:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0When set to 1 the re=
gister is locked and becomes
> > read-only
> > =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0until next reset. Not for use by the OS driver.
> > @@ -139,7 +142,10 @@ struct tpmi_info_header {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 dev:5;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 bus:8;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 pkg:8;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 reserved:39;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 segment:8;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 partition:2;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 cdie_mask:16;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 reserved:13;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 lock:1;
> > =C2=A0} __packed;
> > @@ -684,6 +690,9 @@ static int tpmi_process_info(struct
> > intel_tpmi_info *tpmi_info,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpmi_info->plat_info.bu=
s_number =3D header.bus;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpmi_info->plat_info.de=
vice_number =3D header.dev;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpmi_info->plat_info.fu=
nction_number =3D header.fn;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpmi_info->plat_info.cdie_ma=
sk =3D header.cdie_mask;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpmi_info->plat_info.partiti=
on =3D header.partition;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpmi_info->plat_info.segment=
 =3D header.segment;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iounmap(info_mem);
> > =C2=A0
> > diff --git a/include/linux/intel_tpmi.h
> > b/include/linux/intel_tpmi.h
> > index ee07393445f9..939663bb095f 100644
> > --- a/include/linux/intel_tpmi.h
> > +++ b/include/linux/intel_tpmi.h
> > @@ -14,7 +14,10 @@
> > =C2=A0
> > =C2=A0/**
> > =C2=A0 * struct intel_tpmi_plat_info - Platform information for a TPMI
> > device instance
> > + * @cdie_mask:=C2=A0Mask of all compute dies in the partition
> > =C2=A0 * @package_id:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CP=
U Package id
> > + * @partition:=C2=A0 Package partition id when multiple VSEC PCI
> > devices per package
> > + * @segment: PCI segment ID
> > =C2=A0 * @bus_number:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PC=
I bus number
> > =C2=A0 * @device_number: PCI device number
> > =C2=A0 * @function_number: PCI function number
> > @@ -23,7 +26,10 @@
> > =C2=A0 * struct is used to return data via tpmi_get_platform_data().
> > =C2=A0 */
> > =C2=A0struct intel_tpmi_plat_info {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u16 cdie_mask;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 package_id;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 partition;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 segment;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 bus_number;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 device_number;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 function_number;
>=20
> I've a number of questions about this patch...
>=20
> - There no version check anywhere, yet commit message talks about v2?
>=20
No need to check, as the other fields will be 0s in v1.

> - What will those fields have in v1?
They are 0s as they were reserved for future use.

>=20
> - Entirely unrelated to the rest of this serie? So no users for
> these?
> =C2=A0 Why not send this along with the patches containing the actual
> users
> =C2=A0 so it'd have been easier to find the answers from the patches?
>=20
This is the core changes, so submitted as changes done in specs.
But fine to bundle with next series. I limit number of changes per
kernel release in the order of importance in the current products.

Thanks,
Srinivas


