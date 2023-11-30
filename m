Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9D17FFD52
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376838AbjK3VPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376818AbjK3VPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:15:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E09C4;
        Thu, 30 Nov 2023 13:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701378960; x=1732914960;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=KlbfcOErqRwf01qlZ8573Egc0BMQKulLdYLjiwyGZgc=;
  b=KxM7h4a/2ZBLdyO1ZQYZmeKe/Vd7MLQSvJAM/eySLxwesb4lc1B97c09
   EoaSdJiTetz5DbahHOr2yXfMCKr7wTaiGDFJFEfnQ9ILBcUwPri35hbYq
   45iZsrQ6dhuU4wVkdWINCdRgW8bh1WdONzWKqMu0W7lvhNLRU45T/wOtW
   BJUzKVnBEOsTP4m1mqnJ18geZa9Uhn3WbrIhdhXpLvTOuXmo0+Z7pcBQI
   3TDAal7JtcckxQg++8NdXLqZ3RGkzAL40ZkrpYNuTLUghzMR0N0z4kJ7x
   VSIQ+jhNFnDVk1bTmui9F2oRsvF36Cd+V3IcivTnU6m+au4rvSfGfdY3m
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="373577153"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="373577153"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 13:15:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="719257143"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="719257143"
Received: from rwwalter-mobl.amr.corp.intel.com (HELO [10.212.92.184]) ([10.212.92.184])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 13:15:58 -0800
Message-ID: <77585d9d2eacf025408330d55a27e7e359c75e4d.camel@linux.intel.com>
Subject: Re: [PATCH 2/6] platform/x86/intel/tpmi: Don't create devices for
 disabled features
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 30 Nov 2023 16:15:57 -0500
In-Reply-To: <73dac17ee9019c77c3258218ff6bf6d434959ece.camel@linux.intel.com>
References: <20231128185605.3027653-1-srinivas.pandruvada@linux.intel.com>
         <20231128185605.3027653-3-srinivas.pandruvada@linux.intel.com>
         <9603f75-3adb-8eba-9322-cbd9551668c8@linux.intel.com>
         <29cf2ab24e5d63e2b1268516ad7ab2b1beb44c91.camel@linux.intel.com>
         <84eafa2c-27e3-1a55-39df-edb4a87f5eb1@linux.intel.com>
         <ZWieZa7huhCbrq7L@smile.fi.intel.com>
         <73dac17ee9019c77c3258218ff6bf6d434959ece.camel@linux.intel.com>
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

On Thu, 2023-11-30 at 10:00 -0500, srinivas pandruvada wrote:
> On Thu, 2023-11-30 at 16:38 +0200, Andy Shevchenko wrote:
> > On Thu, Nov 30, 2023 at 04:33:00PM +0200, Ilpo J=C3=A4rvinen wrote:
> > > On Thu, 30 Nov 2023, srinivas pandruvada wrote:
> > > > On Thu, 2023-11-30 at 14:26 +0200, Ilpo J=C3=A4rvinen wrote:
> > > > > On Tue, 28 Nov 2023, Srinivas Pandruvada wrote:
> >=20
> > ...
> >=20
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!feature_state.e=
nabled)
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EOPNOTSUPP;
> > > > >=20
> > > > > -ENODEV sounds more appropriate.=C2=A0=20
> > > >=20
> > > > The -EOPNOTSUPP is returned matching the next return statement,
> > > > which
> > > > causes to continue to create devices which are supported and
> > > > not
> > > > disabled. Any other error is real device creation will causes
> > > > driver
> > > > modprobe to fail.
> > >=20
> > > Oh, I see... I didn't look that deep into the code during my
> > > review
> > > (perhaps note that down into the commit message?).
> >=20
> > Maybe we should even use -ENOTSUPP (Linux internal error code), so
> > it will be clear that it's _not_ going to user space?
>=20
> That will be better. I will change and resubmit.
The checkpatch gives error with this.


WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
#25: FILE: drivers/platform/x86/intel/tpmi.c:613:
+		return -ENOTSUPP;

Thanks,
Srinivas
>=20
> Thanks,
> Srinivas
>=20
> >=20
>=20

