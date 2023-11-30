Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C637FF1C8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjK3Oar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjK3Oap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:30:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D435BD;
        Thu, 30 Nov 2023 06:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701354652; x=1732890652;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=PwlpPtfS0HkAlGQkdyt5xqvlLSCwuyy6PwyODlZYJvE=;
  b=fzXh3bVNyVwED687QQ0zF88qnMoBlI8zRGjg5YPdXtt0mX0EjNPk/+X3
   PRwy5z6L2+c/bok+acSpK4MjgKUNKJJME+nDjb00gye778AyyeornHfwW
   Vsz2BOWw1FaCMNqC2wpGlL0RkdG0mP1592QzPbBsVipqJbxZ8XR/3pLAl
   xpaFRjGkrYnHyFZCiWSZpZrI+NBAlOFBjP5hwBum2gbViyIg4vPR//KpF
   EaIJ1VKNvB/YtzQLH0jDDEizyHNH7meiK8HicED1p9OvF/B12TCC1VMkx
   c7Y66/LubhnNOV2TL6E/vHXUOp7s+/CjQLGHtpOAOAfDcwDk/xX6tCnN7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="392194606"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="392194606"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 06:30:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="913217870"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="913217870"
Received: from rwwalter-mobl.amr.corp.intel.com (HELO [10.212.92.184]) ([10.212.92.184])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 06:30:51 -0800
Message-ID: <0c2b6e18a95d92a1a8a8ce4f8a110f23391f42ee.camel@linux.intel.com>
Subject: Re: [PATCH 5/6] platform/x86: ISST: Process read/write blocked
 feature status
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 30 Nov 2023 09:30:50 -0500
In-Reply-To: <853032f0-f49-465b-f164-d49baca51c7b@linux.intel.com>
References: <20231128185605.3027653-1-srinivas.pandruvada@linux.intel.com>
         <20231128185605.3027653-6-srinivas.pandruvada@linux.intel.com>
         <853032f0-f49-465b-f164-d49baca51c7b@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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

On Thu, 2023-11-30 at 14:20 +0200, Ilpo J=C3=A4rvinen wrote:
> On Tue, 28 Nov 2023, Srinivas Pandruvada wrote:
>=20
> > When a feature is read blocked, don't continue to read SST
> > information
> > and register with SST core.
> >=20
> > When the feature is write blocked, continue to offer read interface
> > for
> > SST parameters, but don't allow any operation to change state. A
> > state
> > change results from SST level change, feature change or class of
> > service
> > change.
> >=20
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> > ---
> > =C2=A0.../intel/speed_select_if/isst_tpmi_core.c=C2=A0=C2=A0=C2=A0 | 25
> > +++++++++++++++++++
> > =C2=A01 file changed, 25 insertions(+)
> >=20
> > diff --git
> > a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> > b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> > index 0b6d2c864437..ed3a04d6c99c 100644
> > --- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> > +++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> > @@ -514,6 +516,9 @@ static long isst_if_clos_param(void __user
> > *argp)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!power_domain_info)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (power_domain_info->write=
_blocked)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return -EPERM;
> > +
>=20
> I don't understand this, doesn't this now -EPERM both
> _write_cp_info() AND
> _read_cp_info()??? Does _read_cp_info() also change state??
You have a point here. Unlike other SST features, CP access is useful
for OS as it know workloads and priorities.
But I will change for consistency.

Thanks,
Srinivas

>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (clos_param.get_set)=
 {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0_write_cp_info("clos.min_freq",
> > clos_param.min_freq_mhz,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (SST_CLOS_CONFIG_0_OFFSET +
> > clos_param.clos * SST_REG_SIZE),
> > @@ -602,6 +607,9 @@ static long isst_if_clos_assoc(void __user
> > *argp)
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0power_domain_info =3D &sst_inst-
> > >power_domain_info[punit_id];
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (power_domain_info->write_blocked)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=
 -EPERM;
>=20
> Same here, this blocks also the get path?
>=20
>=20

