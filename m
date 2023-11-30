Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A7D7FF31D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346083AbjK3PAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjK3PAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:00:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DFF112;
        Thu, 30 Nov 2023 07:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701356439; x=1732892439;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ixv6/LUQ5nxsoa7eLxLTC6v2jXjnrcrritVMBTOWA9k=;
  b=ghEXJt4PoXGKj9bQAC5tUnWZLPdXbuzdYzv7XsyNx04Cpa4YB90AfKYV
   x2J9LUi056wmnYBIxuvgtP4Kds9HIaHm3vSzZwukW+quBu+PO1VcQUGEA
   fMT7W2P9GTTdAnnMScl0JXWNfvOmy0Sh3gqqqxjWI5YGMosXNhUjG5hhj
   whzgYDVz4HCI35jXr1fQ+Eolii2g0lbqG4cWNqGz7IjobwApmIgNWWLCF
   Damh3cbC6VF4XqpgsfO0n0F+cGcxlAReBj9gGbUi+3FFlbGIWqQ328CuW
   SnDwINDj1P6VSdZDMrEJEWgQv6xKmvtRMhuJdCcWkXJCLGP8sQFVYig7n
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="373518228"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="373518228"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 07:00:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="1100960447"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="1100960447"
Received: from rwwalter-mobl.amr.corp.intel.com (HELO [10.212.92.184]) ([10.212.92.184])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 07:00:38 -0800
Message-ID: <73dac17ee9019c77c3258218ff6bf6d434959ece.camel@linux.intel.com>
Subject: Re: [PATCH 2/6] platform/x86/intel/tpmi: Don't create devices for
 disabled features
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 30 Nov 2023 10:00:37 -0500
In-Reply-To: <ZWieZa7huhCbrq7L@smile.fi.intel.com>
References: <20231128185605.3027653-1-srinivas.pandruvada@linux.intel.com>
         <20231128185605.3027653-3-srinivas.pandruvada@linux.intel.com>
         <9603f75-3adb-8eba-9322-cbd9551668c8@linux.intel.com>
         <29cf2ab24e5d63e2b1268516ad7ab2b1beb44c91.camel@linux.intel.com>
         <84eafa2c-27e3-1a55-39df-edb4a87f5eb1@linux.intel.com>
         <ZWieZa7huhCbrq7L@smile.fi.intel.com>
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

On Thu, 2023-11-30 at 16:38 +0200, Andy Shevchenko wrote:
> On Thu, Nov 30, 2023 at 04:33:00PM +0200, Ilpo J=C3=A4rvinen wrote:
> > On Thu, 30 Nov 2023, srinivas pandruvada wrote:
> > > On Thu, 2023-11-30 at 14:26 +0200, Ilpo J=C3=A4rvinen wrote:
> > > > On Tue, 28 Nov 2023, Srinivas Pandruvada wrote:
>=20
> ...
>=20
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!feature_state.ena=
bled)
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EOPNOTSUPP;
> > > >=20
> > > > -ENODEV sounds more appropriate.=C2=A0=20
> > >=20
> > > The -EOPNOTSUPP is returned matching the next return statement,
> > > which
> > > causes to continue to create devices which are supported and not
> > > disabled. Any other error is real device creation will causes
> > > driver
> > > modprobe to fail.
> >=20
> > Oh, I see... I didn't look that deep into the code during my review
> > (perhaps note that down into the commit message?).
>=20
> Maybe we should even use -ENOTSUPP (Linux internal error code), so
> it will be clear that it's _not_ going to user space?

That will be better. I will change and resubmit.

Thanks,
Srinivas

>=20

