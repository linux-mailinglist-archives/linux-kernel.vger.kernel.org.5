Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613FE793F03
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241698AbjIFOgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjIFOgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:36:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4ED992;
        Wed,  6 Sep 2023 07:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694010971; x=1725546971;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=67tDKqd+pCKzysEtHzaE8M1ZDSoV6ABSx5BlTkxv2ZU=;
  b=GRgg+bDbvBMpDrZhhhBNr9gIbw+b5GeCK8MhmPEv7wznKMO0PbupHuvn
   fSFkKmrMax+g1Y/FOq88SFjoYI1Mp5oRoh8UTwZ9E0CLh9IG3YWV1T6zq
   fWw70O3JqnA46/HB+IWpitwnQZylOsh37dPPDICHo8S8cUIm7/bLDSyQL
   u5F3P/gdWjoTZVje1RjzsC+xFxMgPaC1IlQ3ps595ARtBzHG+Wnz2kgWj
   eFw9qVjRMgJ4q1+mVwPLCxGrnAaikgjLMrSMLM8Zv++HBayHxF4cS8ift
   lWVsVkVFqtf/Y7EwZoAbuygc5WTwTMRTDZpkYNKeRj0Uz6S5OP3XjzDF9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="408086075"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="408086075"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 07:36:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="744697096"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="744697096"
Received: from spandruv-desk1.amr.corp.intel.com ([10.209.14.101])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 07:36:11 -0700
Message-ID: <b7ec9c4cc181f3fac2d51dff6708913043acc4cb.camel@linux.intel.com>
Subject: Re: [PATCH] powercap: intel_rapl: Fix setting of Power Limit 4 to 0
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Pawnikar, Sumeet R" <sumeet.r.pawnikar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Date:   Wed, 06 Sep 2023 07:36:10 -0700
In-Reply-To: <8fc7d9236bfa968b5f202d458e99e2e729fed343.camel@intel.com>
References: <20230906000640.2919607-1-srinivas.pandruvada@linux.intel.com>
         <8fc7d9236bfa968b5f202d458e99e2e729fed343.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rui,

On Wed, 2023-09-06 at 02:20 +0000, Zhang, Rui wrote:
> Hi, Srinivas,
>=20
> Thanks for the patch.
>=20
> On Tue, 2023-09-05 at 17:06 -0700, Srinivas Pandruvada wrote:
> > System runs at minimum performance, once powercap RAPL package
> > domain
> > "enabled" flag is toggled.
> >=20
> > Setting RAPL package domain enabled flag to 0, results in setting
> > of
> > power limit 4 (PL4) MSR 0x601 to 0.
>=20
> This is the bug. Setting enabled flag should only affect the Enable
> bit
> but not the other bits.
>=20
> > =C2=A0This implies disabling PL4 limit.
> > The PL4 limit controls the peak power. This can significantly
> > change
> > the performance. Even worse, when the enabled flag is set to 1
> > again.
> > This will set PL4 MSR value to 0x01, which means reduce peak power
> > to
> > 0.125W. This will force the system to run at the lowest possible
> > performance.
> >=20
> > This is caused by a change which assumes that there is an enable
> > bit
> > in the PL4 MSR like other power limits.
>=20
> MSR RAPL doesn't have PL4 enable bit, but TPMI RAPL does have per
> power
> limit enable bit.
That is correct, but not sure that in practice used or not.

>=20
> >=20
> > In functions set_floor_freq_default() and rapl_remove_package(),
> > call
> > rapl_write_pl_data with PL_ENABLE and PL_CLAMP for only power limit
> > 1
> > and 2. Similarly don't read PL_ENABLE for PL4 to check the presence
> > of
> > power limit 4.
>=20
> IMO, the rootcause is that we expose an non-exits PL4_ENABLE
> primitive
> for MSR Interface, and even worse we expose it wrongly that the
> primitive uses the power limit bits.
>=20
> Commit 9050a9cd5e4c ("powercap: intel_rapl: Cleanup Power Limits
> support") pokes the MSR interface PL4_ENABLE primitive and exposes
> this
> bug.
>=20
> Sumeet is testing the below fix right now, and I suppose he will give
> some update soon.
>=20
> thanks,
> rui
>=20
> diff --git a/drivers/powercap/intel_rapl_common.c
> b/drivers/powercap/intel_rapl_common.c
> index 8fac57b28f8a..d407f918876f 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -658,8 +658,6 @@ static struct rapl_primitive_info
> rpi_msr[NR_RAPL_PRIMITIVES] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT,
> 0),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[PL2_CLAMP] =3D PRIMITIVE=
_INFO_INIT(PL2_CLAMP,
> POWER_LIMIT2_CLAMP, 48,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 RAPL_DOMAIN_REG_LIMIT, ARBITRARY_UNIT,
> 0),
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[PL4_ENABLE] =3D PRIMITIVE_INF=
O_INIT(PL4_ENABLE,
> POWER_LIMIT4_MASK, 0,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0RAPL_DOMAIN_REG_PL4, ARBITRARY_UNIT,
> 0),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[TIME_WINDOW1] =3D PRIMIT=
IVE_INFO_INIT(TIME_WINDOW1,
> TIME_WINDOW1_MASK, 17,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 RAPL_DOMAIN_REG_LIMIT, TIME_UNIT, 0),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[TIME_WINDOW2] =3D PRIMIT=
IVE_INFO_INIT(TIME_WINDOW2,
> TIME_WINDOW2_MASK, 49,
>=20
>=20
Let me try this, but this is not enough. The enable/disable is also
gets checked for presence of PL4.

Thanks,
Srinivas

>=20

