Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B5D7C74DB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347366AbjJLRfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347392AbjJLRfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:35:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D71572B4;
        Thu, 12 Oct 2023 10:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697131708; x=1728667708;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=4v+H0O0IXD5YGkRVSviC2erq+UMEGDFbWdbWf2xYauc=;
  b=bZXt6ullIF4qNWO/f6u2KGhu8k9JmyCejMz3LsS+kuy3L62/a4epAPFc
   xPRmjvBgFJkwNPBcgN4HoS5dFVYOApMemenifatMKo2U47sgZ/hsJoGQU
   eXQzAB644MoLjshU908hvjpp3h54/pzQgUgpj25shuG3r/8B1qFmD6FDO
   1C2ybBQB5XMbEdxRaAfST/bbbyV6n01pgdWGEvG3/MDQyJQvPw/JOkvW2
   WCOqhSl70AAlKnDpUAW5sHSkziCavDbq1pIiBs400xZeah2ZXYqfs5fSG
   f5jGLrc985r5ewEyaGOUXssEsQwYkjl7Vr2CDODBdx3uWEp/T13J+Jr8O
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="365249842"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="365249842"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 10:28:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="731021869"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="731021869"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 10:28:27 -0700
Received: from [10.54.75.156] (debox1-desk1.jf.intel.com [10.54.75.156])
        by linux.intel.com (Postfix) with ESMTP id 77FAE5807A3;
        Thu, 12 Oct 2023 10:28:27 -0700 (PDT)
Message-ID: <0bd97aed259d9ec0ff4d8c95f63d5db65550b893.camel@linux.intel.com>
Subject: Re: [PATCH V3 10/16] platform/x86/intel/pmc: Split
 pmc_core_ssram_get_pmc()
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Date:   Thu, 12 Oct 2023 10:28:27 -0700
In-Reply-To: <c66f2061-a7e6-8df7-928-da2a14a3cb49@linux.intel.com>
References: <20231012023840.3845703-1-david.e.box@linux.intel.com>
         <20231012023840.3845703-11-david.e.box@linux.intel.com>
         <c66f2061-a7e6-8df7-928-da2a14a3cb49@linux.intel.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-10-12 at 18:14 +0300, Ilpo J=C3=A4rvinen wrote:
> On Wed, 11 Oct 2023, David E. Box wrote:
>=20
> > On supported hardware, each PMC may have an associated SSRAM device for
> > accessing additional counters.=C2=A0 However, only the SSRAM of the fir=
st
> > (primary) PMC is discoverable as a PCI device to the OS. The remaining
> > (secondary) devices are hidden but their BARs are still accessible and
> > their addresses are stored in the BAR of the exposed device. Clean up t=
he
> > code handling the SSRAM discovery. Create two separate functions for
> > accessing the primary and secondary SSRAM devices.
> >=20
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > ---
> > V3 - New patch split from previous PATCH 2
> > =C2=A0=C2=A0 - Update changelog
> > =C2=A0=C2=A0 - Use cleanup.h to cleanup ioremap
> >=20
> > V2 - no change
> >=20
> > =C2=A0drivers/platform/x86/intel/pmc/core_ssram.c | 93 ++++++++++++++--=
-----
> > =C2=A01 file changed, 61 insertions(+), 32 deletions(-)
> >=20
> > diff --git a/drivers/platform/x86/intel/pmc/core_ssram.c
> > b/drivers/platform/x86/intel/pmc/core_ssram.c
> > index 815950713e25..af405d11919f 100644
> > --- a/drivers/platform/x86/intel/pmc/core_ssram.c
> > +++ b/drivers/platform/x86/intel/pmc/core_ssram.c
> > @@ -8,6 +8,7 @@
> > =C2=A0 *
> > =C2=A0 */
> > =C2=A0
> > +#include <linux/cleanup.h>
> > =C2=A0#include <linux/pci.h>
> > =C2=A0#include <linux/io-64-nonatomic-lo-hi.h>
> > =C2=A0
> > @@ -21,6 +22,8 @@
> > =C2=A0#define SSRAM_IOE_OFFSET=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A00x68
> > =C2=A0#define SSRAM_DEVID_OFFSET=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x70
> > =C2=A0
> > +DEFINE_FREE(pmc_core_iounmap, void __iomem *, iounmap(_T));
> > +
>=20
> Was it that adding
>=20
> DEFINE_FREE(iounmap, void __iomem *, iounmap(_T));
>=20
> into some header did not work for some reason or why this? (Perhaps=20
> because iounmap is also defined?)

No, I didn't think to add it. I'll try and send in the next version.

David

>=20

