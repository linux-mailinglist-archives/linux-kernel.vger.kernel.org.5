Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD4A803EDD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbjLDT5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbjLDT5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:57:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A9E109;
        Mon,  4 Dec 2023 11:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701719844; x=1733255844;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=3CLNd2G2DCVMLRKln5jkEWTRHdR30ylbSU2rEr66LTI=;
  b=ilT6xb0HMiAV90cMPPHPuD8aLPWspauV8lA5C/qahNhipE9F30x0FLw/
   Gi3OtC5ouHHPDVn5Kj8tJIa/mzO/QzrFw0ZXES7tGrl6d0Ztg8bCqAo/T
   DnvnE+gtnlw4pRFisMc8NMC5tK12B50TN9Y6Ucc1Ble/N845H2FyVLpxV
   FA+BlfCBAABqQFPYmBlIS/13Rl6Qf/jNax0XZiKvzjVSnHE+BwyQ66TGq
   1gipHz7kbnbJx30fUZH6Sllf01tT5HzbnXWBdJYsG4BPgMYyU+gN5Pgiw
   d6jnkZD/JLWYqAXNlMOkZSnQEGnpVxToVp80zyOtyq4HOQwGKf8aBagVu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="634472"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="634472"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 11:57:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="943998609"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="943998609"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 11:57:22 -0800
Received: from vbchikar-mobl1.amr.corp.intel.com (unknown [10.209.80.154])
        by linux.intel.com (Postfix) with ESMTP id C5123580DA0;
        Mon,  4 Dec 2023 11:57:22 -0800 (PST)
Message-ID: <198aadd7a91152393ec56d421fa042d30378af40.camel@linux.intel.com>
Subject: Re: [PATCH V6 01/20] platform/x86/intel/vsec: Fix xa_alloc memory
 leak
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Hans de Goede <hdegoede@redhat.com>,
        Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com
Date:   Mon, 04 Dec 2023 11:57:22 -0800
In-Reply-To: <f2a3bab9-296c-43a1-9b7e-944c5044feaf@redhat.com>
References: <20231129222132.2331261-1-david.e.box@linux.intel.com>
         <20231129222132.2331261-2-david.e.box@linux.intel.com>
         <5c21230-1176-4168-f31f-a0c1f1713ca8@linux.intel.com>
         <f2a3bab9-296c-43a1-9b7e-944c5044feaf@redhat.com>
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

Hi Hans,

On Mon, 2023-12-04 at 14:51 +0100, Hans de Goede wrote:
> Hi,
>=20
> On 11/30/23 12:02, Ilpo J=C3=A4rvinen wrote:
> > On Wed, 29 Nov 2023, David E. Box wrote:
> >=20
> > > Commit 936874b77dd0 ("platform/x86/intel/vsec: Add PCI error recovery
> > > support to Intel PMT") added an xarray to track the list of vsec devi=
ces
> > > to
> > > be recovered after a PCI error. But it did not provide cleanup for th=
e
> > > list
> > > leading to a memory leak that was caught by kmemleak.=C2=A0 Do xa_all=
oc()
> > > before
> > > devm_add_action_or_reset() so that the list may be cleaned up with
> > > xa_erase() in the release function.
> > >=20
> > > Fixes: 936874b77dd0 ("platform/x86/intel/vsec: Add PCI error recovery
> > > support to Intel PMT")
> > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > ---
> > >=20
> > > V6 - Move xa_alloc() before ida_alloc() to reduce mutex use during er=
ror
> > > =C2=A0=C2=A0=C2=A0=C2=A0 recovery.
> > > =C2=A0=C2=A0 - Fix return value after id_alloc() fail
> > > =C2=A0=C2=A0 - Add Fixes tag
> > > =C2=A0=C2=A0 - Add more detail to changelog
> > >=20
> > > V5 - New patch
> > >=20
> > > =C2=A0drivers/platform/x86/intel/vsec.c | 24 ++++++++++++++----------
> > > =C2=A0drivers/platform/x86/intel/vsec.h |=C2=A0 1 +
> > > =C2=A02 files changed, 15 insertions(+), 10 deletions(-)
> > >=20
> > > diff --git a/drivers/platform/x86/intel/vsec.c
> > > b/drivers/platform/x86/intel/vsec.c
> > > index c1f9e4471b28..2d568466b4e2 100644
> > > --- a/drivers/platform/x86/intel/vsec.c
> > > +++ b/drivers/platform/x86/intel/vsec.c
> > > @@ -120,6 +120,8 @@ static void intel_vsec_dev_release(struct device =
*dev)
> > > =C2=A0{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct intel_vsec_dev=
ice *intel_vsec_dev =3D dev_to_ivdev(dev);
> > > =C2=A0
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0xa_erase(&auxdev_array, in=
tel_vsec_dev->id);
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&vsec_ida_=
lock);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ida_free(intel_vsec_d=
ev->ida, intel_vsec_dev->auxdev.id);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&vsec_id=
a_lock);
> > > @@ -135,19 +137,27 @@ int intel_vsec_add_aux(struct pci_dev *pdev, st=
ruct
> > > device *parent,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct auxiliary_devi=
ce *auxdev =3D &intel_vsec_dev->auxdev;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret, id;
> > > =C2=A0
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&vsec_ida_lock)=
;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D ida_alloc(intel_vs=
ec_dev->ida, GFP_KERNEL);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&vsec_ida_loc=
k);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D xa_alloc(&auxdev_a=
rray, &intel_vsec_dev->id, intel_vsec_dev,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PMT_XA_LIMIT, =
GFP_KERNEL);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret < 0) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(intel_vsec_dev->resource);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(intel_vsec_dev);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > =C2=A0
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&vsec_ida_lock)=
;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0id =3D ida_alloc(intel_vse=
c_dev->ida, GFP_KERNEL);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlock(&vsec_ida_loc=
k);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (id < 0) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0kfree(intel_vsec_dev->resource);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0kfree(intel_vsec_dev);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return id;
> >=20
> > Thanks, this looks much better this way around but it is missing=20
> > xa_alloc() rollback now that the order is reversed.
> >=20
> > Once that is fixed,
> >=20
> > Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> I have fixed this up, adding the missing:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0xa_erase(&auxdev_array, i=
ntel_vsec_dev->id);
>=20
> to this error-exit path while merging this.

Thanks. Does that include the rest of the series which was all reviewed by =
Ilpo?

>=20
> While looking into this I did find one other thing which
> worries me (different issue, needs a separate fix):
>=20
> intel_vsec_pci_slot_reset() uses
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 devm_release_action(&pdev->dev, intel_vsec_remove_aux,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &intel_vsec=
_dev->auxdev);
>=20
> and seems to assume that after this intel_vsec_remove_aux()
> has run for the auxdev-s. *But this is not the case*
>=20
> devm_release_action() only removes the action from the list
> of devres resources tied to the parent PCI device.
>=20
> It does *NOT* call the registered action function,
> so intel_vsec_remove_aux() is NOT called here.
>=20
> And then on re-probing the device as is done in
> intel_vsec_pci_slot_reset() a second set of aux
> devices with the same parent will be created AFAICT.
>=20
> So it seems that this also needs an explicit
> intel_vsec_remove_aux() call for each auxdev!
>=20
> ###
>=20
> This makes me wonder if the PCI error handling here
> and specifically the reset code was ever tested ?

I recall the code was tested using error injection to cause the slot reset =
to
occur and reprobe was confirmed. I'll have to find out the specific test so=
 that
we can check it again with the proposed fix and ensure no leaks.

>=20
> ###
>=20
> Note that simply forcing a reprobe using device_reprobe()
> will cause all the aux-devices to also get removed through
> the action on driver-unbind without ever needing
> the auxdev_array at all!

Okay. That would be a lot simpler.

>=20
> I guess that you want the removal to happen before
> the pci_restore_state(pdev) state though, so that
> simply relying on the removal on driver unbind
> is not an option ?

I'm not sure this is needed given the simplicity of the device. The array w=
as
added only to track the list of devices and reprobe the one that was reset.
We'll look at changing this to do driver_reprobe() instead. Thanks.

David


