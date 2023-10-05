Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E62B7BA323
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbjJEPwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbjJEPu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:50:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFD84C1F;
        Thu,  5 Oct 2023 07:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696514895; x=1728050895;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=0Tq9eA/QxMDW3W69me2+EdhY679btO9W9v2DGaUbaQ0=;
  b=Gc6bGUI5yI1wR49tZxHGe1b9389CjxZYTl0NcxKx+94mO4ZQbg0mDwzQ
   4j6r6j/CSQig6x1FzH+GWbw7d05W7hfTaKTjaXBDDNOk8K1cGzda/gYsZ
   B0+wAEOuEMcoVbCMukDtpvkdTSqgK0l/JaOgKHruHVLTr2Fm3F9zgX8Qn
   tasm/YceIAPX2B6o7ueHCQa6MEoaJFlBsyhby7oiDqSKEyJFIl8Ks2gih
   qNcAHcnvjy25xK59GfJhlWvEFeCLY5fn77tPeo3Xqk/wOryJQIKqnawvN
   57ZxWPbjJG8SmB96jyfb+aCdCTaZ4u7pCkfHUV7Rp1rmJoFfk4ggmT193
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="380784670"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="380784670"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 07:07:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="842402965"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="842402965"
Received: from spandruv-desk1.amr.corp.intel.com ([10.212.218.87])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 07:07:59 -0700
Message-ID: <5dda866185a286e61f949a48e04ff1ea6b3a5b03.camel@linux.intel.com>
Subject: Re: [UPDATE][PATCH] platform/x86/intel-uncore-freq: Conditionally
 create attribute for read frequency
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 05 Oct 2023 07:07:58 -0700
In-Reply-To: <e84bc80e-1fd9-f07b-526a-b4eb4780ea9b@redhat.com>
References: <20231004181915.1887913-1-srinivas.pandruvada@linux.intel.com>
         <e84bc80e-1fd9-f07b-526a-b4eb4780ea9b@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,


On Thu, 2023-10-05 at 09:03 +0200, Hans de Goede wrote:
> Hi Srinivas,
>=20
> On 10/4/23 20:19, Srinivas Pandruvada wrote:
> > When the current uncore frequency can't be read, don't create
> > attribute
> > "current_freq_khz" as any read will fail later. Some user space
> > applications like turbostat fail to continue with the failure. So,
> > check
> > error during attribute creation.
> >=20
> > Fixes: 414eef27283a ("platform/x86/intel/uncore-freq: Display
> > uncore current frequency")
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> > ---
> > Added fixes tag which added current_freq_khz. But after this
> > tag there is reorg of code, so need manual backport for some
> > versions.
> > I will separately submit to stable trees after merge.
>=20
> Can you for future updated patches please use the ususal [PATCH v2],
> [PATCH v3], etc. prefix ?
>=20
Sorry about this. I usually do with code change. But will keep in mind.

Thanks,
Srinivas


> Also please document the changes per version after the cutline, e.g.
> :
>=20
> ```
> ---
> Changes in v2:
> - Added fixes tag which added current_freq_khz. Note after this
> =C2=A0 tag there is reorg of code, so need manual backport for some
> versions.
> =C2=A0 I will separately submit to stable trees after merge.
> ```
>=20
> Regards,
>=20
> Hans
>=20
>=20
>=20
>=20
> >=20
> > =C2=A0.../x86/intel/uncore-frequency/uncore-frequency-common.c=C2=A0 | =
8
> > ++++++--
> > =C2=A01 file changed, 6 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-
> > frequency-common.c b/drivers/platform/x86/intel/uncore-
> > frequency/uncore-frequency-common.c
> > index 1152deaa0078..33ab207493e3 100644
> > --- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-
> > common.c
> > +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-
> > common.c
> > @@ -176,7 +176,7 @@ show_uncore_data(initial_max_freq_khz);
> > =C2=A0
> > =C2=A0static int create_attr_group(struct uncore_data *data, char *name=
)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret, index =3D 0;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret, freq, index =3D 0;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0init_attribute_rw(max_f=
req_khz);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0init_attribute_rw(min_f=
req_khz);
> > @@ -197,7 +197,11 @@ static int create_attr_group(struct
> > uncore_data *data, char *name)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0data->uncore_attrs[inde=
x++] =3D &data-
> > >min_freq_khz_dev_attr.attr;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0data->uncore_attrs[inde=
x++] =3D &data-
> > >initial_min_freq_khz_dev_attr.attr;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0data->uncore_attrs[inde=
x++] =3D &data-
> > >initial_max_freq_khz_dev_attr.attr;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0data->uncore_attrs[index++] =
=3D &data-
> > >current_freq_khz_dev_attr.attr;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D uncore_read_freq(dat=
a, &freq);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!ret)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0data->uncore_attrs[index++] =3D &data-
> > >current_freq_khz_dev_attr.attr;
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0data->uncore_attrs[inde=
x] =3D NULL;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0data->uncore_attr_group=
.name =3D name;
>=20

