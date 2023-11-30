Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DB07FF1C3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjK3O26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjK3O25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:28:57 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8EF93;
        Thu, 30 Nov 2023 06:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701354544; x=1732890544;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=hXj3e7gGmEEWHyxWsMV9NkuES8lLXdm3RqsuPAIq0GE=;
  b=KBRHTYIVHj88JqV+t92OkKPwj8UE06p+kL1mkD2UcsWH9eIiNySz2pJx
   uIsgTuLXhY968v04F76LAUEcpOJJZaL2IwYw+scK0YYCNuXAEt3pHPVXo
   IozkYqPUfgFuShBZgnJKiODPwcDBeS2ypg2UoSmybLRKD4D6XyPlHuyBl
   RwZSsiBTmdyiQM2uJ5yOxdU38kZ4P9y/3KV+dd9gaZ3uzaZ6hQEf+5eBO
   jIdVOQaTcVNepRYucqpI5acpLpBfrKKZD9OLrS1L1mFl9qDrQqKJthLFc
   u7zQKyvU4k46nE1Wt3UTsbGE7lAPxOUJgRqzY+eyVHiK1KL6Wccq5+hIz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="392194125"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="392194125"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 06:29:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="887260085"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="887260085"
Received: from rwwalter-mobl.amr.corp.intel.com (HELO [10.212.92.184]) ([10.212.92.184])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 06:29:03 -0800
Message-ID: <29cf2ab24e5d63e2b1268516ad7ab2b1beb44c91.camel@linux.intel.com>
Subject: Re: [PATCH 2/6] platform/x86/intel/tpmi: Don't create devices for
 disabled features
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 30 Nov 2023 09:29:02 -0500
In-Reply-To: <9603f75-3adb-8eba-9322-cbd9551668c8@linux.intel.com>
References: <20231128185605.3027653-1-srinivas.pandruvada@linux.intel.com>
         <20231128185605.3027653-3-srinivas.pandruvada@linux.intel.com>
         <9603f75-3adb-8eba-9322-cbd9551668c8@linux.intel.com>
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

On Thu, 2023-11-30 at 14:26 +0200, Ilpo J=C3=A4rvinen wrote:
> On Tue, 28 Nov 2023, Srinivas Pandruvada wrote:
>=20
> > If some TPMI features are disabled, don't create auxiliary devices.
> > In
> > this way feature drivers will not load.
> >=20
> > While creating auxiliary devices, call tpmi_read_feature_status()
> > to
> > check feature state and return if the feature is disabled without
> > creating a device.
> >=20
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> > ---
> > =C2=A0drivers/platform/x86/intel/tpmi.c | 10 +++++++++-
> > =C2=A01 file changed, 9 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/platform/x86/intel/tpmi.c
> > b/drivers/platform/x86/intel/tpmi.c
> > index c89aa4d14bea..4edaa182db04 100644
> > --- a/drivers/platform/x86/intel/tpmi.c
> > +++ b/drivers/platform/x86/intel/tpmi.c
> > @@ -604,9 +604,17 @@ static int tpmi_create_device(struct
> > intel_tpmi_info *tpmi_info,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct intel_vsec_devic=
e *vsec_dev =3D tpmi_info->vsec_dev;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0char feature_id_name[TP=
MI_FEATURE_NAME_LEN];
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct intel_vsec_devic=
e *feature_vsec_dev;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct tpmi_feature_state fe=
ature_state;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct resource *res, *=
tmp;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const char *name;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int i;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int i, ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D tpmi_read_feature_st=
atus(tpmi_info, pfs-
> > >pfs_header.tpmi_id, &feature_state);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return ret;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!feature_state.enabled)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return -EOPNOTSUPP;
>=20
> -ENODEV sounds more appropriate.=C2=A0=20
The -EOPNOTSUPP is returned matching the next return statement, which
causes to continue to create devices which are supported and not
disabled. Any other error is real device creation will causes driver
modprobe to fail.

Thanks,
Srinivas

