Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A427A8CE8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjITTaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjITT37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:29:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48819CD4;
        Wed, 20 Sep 2023 12:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695238177; x=1726774177;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=aiq472JWLWXdIz5Cjfz8QekXdY4FBzRQ9k7JBMwVEVs=;
  b=ja6QT85wuCUisPI4pXmiTi4nMaTc1pVdPtI7ZqPEJ2njbxqvgargovy4
   uvU7+6mglj0J1zu8B3dQ8iZ6pdx5Vw2oZQfFXVGtTDbQHmI0igOOFGzhX
   RIrmuzdhBwhfa/ue0tcDnYeYPGzayGUMY26C7G9C/JyQ8zG7MWm9SFzPb
   nnY1sUIVr1lfzariIpoJFXYauB8mq/JS5E67HNo5TFAzRIYPxnBwLmWmT
   JmG/ly1fA2HFrSotxgBxn9IEA3QbrRJurBlt2EZoL5sHXm1IbHoFPEebU
   mP4XZ9LV+YF3My2ex7j4HfYs0GCdaM7XvEesa1HZ8YV+FkuxxPoGrY0+i
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="360568671"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="360568671"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 12:29:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="817041802"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="817041802"
Received: from spandruv-desk1.amr.corp.intel.com ([10.212.142.24])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 12:29:32 -0700
Message-ID: <51b3a2f115b2392557331442460c2a52432f399d.camel@linux.intel.com>
Subject: Re: [PATCH linux-next] thermal: int340x: processor_thermal: Ack all
 PCI interrupts
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     daniel.lezcano@linaro.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 20 Sep 2023 12:29:31 -0700
In-Reply-To: <CAJZ5v0jLms5iUM8CXDWNCPcXSQgLv9_XJzqx9RwReqGGUKFL_Q@mail.gmail.com>
References: <20230920185153.613706-1-srinivas.pandruvada@linux.intel.com>
         <CAJZ5v0jLms5iUM8CXDWNCPcXSQgLv9_XJzqx9RwReqGGUKFL_Q@mail.gmail.com>
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

On Wed, 2023-09-20 at 21:21 +0200, Rafael J. Wysocki wrote:
> On Wed, Sep 20, 2023 at 8:52=E2=80=AFPM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >=20
> > All interrupts from the processor thermal PCI device requires ACK.
> > This
> > is done by writing 0x01 at offset 0xDC in the config space. This is
> > already done for the thereshold interrupt. Extend this for the
> > workload
> > hint interrupt.
> >=20
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
>=20
> Is this a fix for one of the commits in linux-next?=C2=A0 If so, which
> one?
This is on top of workload hints patches.  I marked linux-next as they
are not in mainline kernel.

This can alternatively merged to=20
e682b86211a1 thermal: int340x: Handle workload hint interrupts

But not sure how to mark the commit id as they will change.
Whatever you prefer.

Thanks,
Srinivas



>=20
> > ---
> > =C2=A0.../intel/int340x_thermal/processor_thermal_device_pci.c=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 3
> > ++-
> > =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git
> > a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pc
> > i.c
> > b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pc
> > i.c
> > index 44b179ce9bc9..3c5ced79ead0 100644
> > ---
> > a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pc
> > i.c
> > +++
> > b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pc
> > i.c
> > @@ -154,10 +154,11 @@ static irqreturn_t
> > proc_thermal_irq_handler(int irq, void *devid)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (status) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* Disable enable interrupt flag */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 proc_thermal_mmio_write(pci_info,
> > PROC_THERMAL_MMIO_INT_ENABLE_0, 0);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 pci_write_config_byte(pci_info->pdev, 0xdc, 0x01);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 pkg_thermal_schedule_work(&pci_info->work);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_write_config_byte(pci_info->p=
dev, 0xdc, 0x01);
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > =C2=A0}
> >=20
> > --
> > 2.40.1
> >=20

