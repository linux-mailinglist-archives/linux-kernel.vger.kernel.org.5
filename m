Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EC57B4046
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 14:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjI3MnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 08:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjI3Mm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 08:42:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E60DD;
        Sat, 30 Sep 2023 05:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696077776; x=1727613776;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=5urvBY4emHp1M0EMsX37rukrChBkKlVneACQRGlJHCg=;
  b=MJFemsHeRCujLTMxyIN8Im5xBg8CnoVyma3VIynarr3/iiQ2G+Z70D/3
   WnkjO9AqJ1XfnAbNAHE6xJJ4Oo4w7sUbzJ3tIJN0isYYnFd8uf0sqZYPG
   yV8Rf0stD0cJounF+PjGNSWHWPaa/nQAlMlCx/Mvh/9D1UP8cVUOMpK8g
   TbkRGT6WHYLtt2gc5IM5vUGxUzBacpoJ4E34oeTLrleWTN3vvffGZJjRs
   8bZqcIkZDvM8MeBN8xkcR4s8hNrCnLmaCxYrzXqENJYyrH3kLWR/2nHp8
   X/QTyFM3AWL9daEVmcbGqd6OjJQfsFeAbnz4F9Voym7y0qaN4vPcNZBs3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="446602132"
X-IronPort-AV: E=Sophos;i="6.03,190,1694761200"; 
   d="scan'208";a="446602132"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2023 05:42:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="997185450"
X-IronPort-AV: E=Sophos;i="6.03,190,1694761200"; 
   d="scan'208";a="997185450"
Received: from spandruv-desk.jf.intel.com (HELO spandruv-desk.amr.corp.intel.com) ([10.54.75.14])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2023 05:42:55 -0700
Message-ID: <72a2766bc7bb4f9d6b3d5f2ff114f0af1b6646a4.camel@linux.intel.com>
Subject: Re: [PATCH 2/3] platform/x86: ISST : Check major minor version
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sat, 30 Sep 2023 05:42:47 -0700
In-Reply-To: <f82fcfc9-eb41-56cb-93e1-abf9cf7413@linux.intel.com>
References: <20230925194338.966639-1-srinivas.pandruvada@linux.intel.com>
         <20230925194338.966639-3-srinivas.pandruvada@linux.intel.com>
         <f82fcfc9-eb41-56cb-93e1-abf9cf7413@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-09-29 at 17:28 +0300, Ilpo J=C3=A4rvinen wrote:
> On Mon, 25 Sep 2023, Srinivas Pandruvada wrote:
>=20
> > Parse major and minor version number from the version field. If
> > there
> > is a mismatch for major version, exit from further processing for
> > that
> > domain.
> >=20
> > If there is mismatch in minor version, driver continue to process
> > with
> > an error message.
>=20
> This sentence sounds odd.
What is the suggestion here?

>=20
> > Minor version change doesn't change offsets and bit
> > structures of TPMI fields.
> >=20
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> > ---
> > =C2=A0.../x86/intel/speed_select_if/isst_tpmi_core.c=C2=A0=C2=A0 | 16
> > ++++++++++++----
> > =C2=A01 file changed, 12 insertions(+), 4 deletions(-)
> >=20
> > diff --git
> > a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> > b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> > index 63faa2ea8327..37f17e229419 100644
> > --- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> > +++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> > @@ -30,7 +30,8 @@
> > =C2=A0#include "isst_if_common.h"
> > =C2=A0
> > =C2=A0/* Supported SST hardware version by this driver */
> > -#define ISST_HEADER_VERSION=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01
> > +#define ISST_MAJOR_VERSION=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00
> > +#define ISST_MINOR_VERSION=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01
> > =C2=A0
> > =C2=A0/*
> > =C2=A0 * Used to indicate if value read from MMIO needs to get
> > multiplied
> > @@ -352,12 +353,19 @@ static int sst_main(struct auxiliary_device
> > *auxdev, struct tpmi_per_power_domai
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pd_info->sst_header.cp_=
offset *=3D 8;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pd_info->sst_header.pp_=
offset *=3D 8;
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (pd_info->sst_header.inte=
rface_version !=3D
> > ISST_HEADER_VERSION) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0dev_err(&auxdev->dev, "SST: Unsupported
> > version:%x\n",
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pd_inf=
o->sst_header.interface_version);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (pd_info->sst_header.inte=
rface_version =3D=3D
> > TPMI_VERSION_INVALID)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return -ENODEV;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (TPMI_MAJOR_VERSION(pd_in=
fo-
> > >sst_header.interface_version) !=3D ISST_MAJOR_VERSION) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0dev_err(&auxdev->dev, "SST: Unsupported major
> > version:%lx\n",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0TPMI_M=
AJOR_VERSION(pd_info-
> > >sst_header.interface_version));
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ENODEV;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (TPMI_MINOR_VERSION(pd_in=
fo-
> > >sst_header.interface_version) !=3D ISST_MINOR_VERSION)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0dev_err(&auxdev->dev, "SST: Ignore: Unsupported
> > minor version:%lx\n",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0TPMI_M=
INOR_VERSION(pd_info-
> > >sst_header.interface_version));
>=20
> Why is this dev_err(), wouldn't dev_info() be more appropriate since=20
> after this patch it's no longer an error?

The distro run with minimum log level. So it is important that they
notice and upgrade as they may be missing some new additions.

Thanks,
Srinivas


>=20
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Read SST CP Header *=
/
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*((u64 *)&pd_info->cp_h=
eader) =3D readq(pd_info->sst_base +
> > pd_info->sst_header.cp_offset);
> > =C2=A0
> >=20
>=20

