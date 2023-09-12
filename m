Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5150079D9B8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237717AbjILToR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjILToQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:44:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438BF115;
        Tue, 12 Sep 2023 12:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694547852; x=1726083852;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=+iTvmA7SKg2BWLnibSpTO7nLR6MbvDS5waDLBgWXs9E=;
  b=cyyWbQilj2SPiM8fYlbrHmCJzVwmQEWN6wriEpgxG83XrYZFmIHIR1hQ
   IPs1/Dc4OpLOpvxhtTrgzxpkNsu/6XBRUqp6QYzGPsHEKptCfxeJp7yAA
   375ggtxLvoZnQuKoM7miX09FB9N5ks42uq5P7DI6QY/NqkGH39bkulD8v
   B3LJefayaaWBHcGRYh0Bu0G9o+w6iMvzAD3Po5JHHGe4OpnX0m4LY48N4
   RNMsssL1CA6nJRI+6Dj6jCPdtDS7Jpd9c2cFqksWTh/rRG/P6tziK+Hq2
   nmi2HyVUY+jXVvv6ZREhuCZmIzIvFXdhtEPIBKTjnTFA1tJV2xc4KbA+h
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="409425017"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="409425017"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 12:44:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="809396182"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="809396182"
Received: from spandruv-desk1.amr.corp.intel.com ([10.209.66.7])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 12:44:11 -0700
Message-ID: <275e34c2e67a85c087ff983354bf74b5257b2fc4.camel@linux.intel.com>
Subject: Re: [PATCH v3 0/7] thermal: processor_thermal: Suport workload hint
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     daniel.lezcano@linaro.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Sep 2023 12:44:10 -0700
In-Reply-To: <CAJZ5v0jrKSUOGG72w-EdzhQqC==CA7zYUofNSEW1wV-58TOnLw@mail.gmail.com>
References: <20230829002346.2104251-1-srinivas.pandruvada@linux.intel.com>
         <CAJZ5v0jrKSUOGG72w-EdzhQqC==CA7zYUofNSEW1wV-58TOnLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Tue, 2023-09-12 at 16:09 +0200, Rafael J. Wysocki wrote:
> On Tue, Aug 29, 2023 at 2:23=E2=80=AFAM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >=20
> >=20

[...]

> > --
>=20
> There is a slight issue with the patch ordering in this series,
> because the interface to enable the interrupt should only be provided
> after implementing the interrupt handlers.=C2=A0 I don't think that anyon=
e
> will apply the series partially and try to enable the feature,
> though.
Thanks!

>=20
> Also, I'm not actually sure if proc_thermal_wt_intr_callback() can
> run
> safely against the work item scheduled in proc_thermal_irq_handler()
> in case the workload hint one triggers along with a thermal threshold
> one.=C2=A0 I think that the access to MMIO is cached, so what if they bot=
h
> try to update the same cache line at the same time?=C2=A0 Or are they
> guaranteed to be different cache lines?
These two registers are 90 cache lines apart. Looking at all the
registers on this bar for status offsets, they are several cache lines
apart. Also this bar is non prefetchable, so continuous data can't be
fetched ahead.


>=20
> Anyway, tentatively applied as 6.7 material, but I've changed the
> second patch somewhat, because I couldn't convince myself that the
> implicit type conversions in
> processor_thermal_mbox_interrupt_config()
> would always do the right thing regardless of the numbers involved,
> so
> please check the result in my bleeding-edge branch.
>=20
If I diff, there is only one change in processor_thermal_mbox.c. Tested
that change and works fine.

Thanks,
Srinivas


> Thanks!

