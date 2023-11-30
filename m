Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CD97FF34E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346176AbjK3PSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjK3PSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:18:14 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0A410D5;
        Thu, 30 Nov 2023 07:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701357500; x=1732893500;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=10fw+r5XbxUYA5SnJKr/duWs+Vhz0TMSzhkjID0W420=;
  b=GJXFB4CbgvGFTlp8q1gPOhKjKxDUWPhtI1eIM7Hs6MLWiZ/3vPloI5Bm
   s5e1gY0nzHcyoLQR0oyhaYXZLzG9lQ875FyIRl+hw84duB9hSxGzULvvT
   n2QMtPO8NEZJaRIxautD330A0Gt66S3ugv3iH4kCkEMgwb6xE683ieGhY
   Vb8MC6UX6vTKANq15azrQ9G/HLdCPhWVyYQVDR4uaZfWQqlhVUghb7TOo
   PU9siSzGH0FeIjP3bAp+m3Jr7dJ3SVo8j/uh5/atgMsG/dfnsjnHYYj3V
   FwYgKrhOdb6yUkgYaedbn0RdWYrYSHy9I+cGCP04CLKyUFKwX+gozrpX3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="383734059"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="383734059"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 07:18:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="17434854"
Received: from rafaelfl-mobl.amr.corp.intel.com ([10.212.26.103])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 07:18:19 -0800
Message-ID: <29ea34917cbfabf2b98b4957b7770683f5994873.camel@linux.intel.com>
Subject: Re: [PATCH v10 14/14] dmaengine: idxd: Add support for device/wq
 defaults
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "vkoul@kernel.org" <vkoul@kernel.org>
Cc:     "Jiang, Dave" <dave.jiang@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>,
        "Guilford, James" <james.guilford@intel.com>,
        "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>,
        "Gopal, Vinodh" <vinodh.gopal@intel.com>,
        "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Date:   Thu, 30 Nov 2023 09:18:17 -0600
In-Reply-To: <IA1PR11MB6097D7EE44240E62DEA9AC769B82A@IA1PR11MB6097.namprd11.prod.outlook.com>
References: <20231127202704.1263376-1-tom.zanussi@linux.intel.com>
         <20231127202704.1263376-15-tom.zanussi@linux.intel.com>
         <00aa3b9f-d81e-3dc2-3fb0-bb79e16564d3@intel.com>
         <e0d1e4441dc7976450efd07322be0fe5a7526efe.camel@linux.intel.com>
         <IA1PR11MB6097D7EE44240E62DEA9AC769B82A@IA1PR11MB6097.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua,

On Thu, 2023-11-30 at 00:31 +0000, Yu, Fenghua wrote:
> Hi, Tom,
>=20
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* set name to "iaa_cryp=
to" */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memset(wq->name, 0, WQ_N=
AME_SIZE + 1);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0strscpy(wq->name, "iaa_c=
rypto", WQ_NAME_SIZE + 1);
> > >=20
> > > Is strcpy(wq->name, "iaa_crypto") simpler than memset() and
> > > strscpy()?
> >=20
> > That's what I originally had, but checkpatch complained about it,
> > suggesting
> > strscpy, so I changed it to make checkpatch happy.
>=20
> Why is size WQ_NAME_SIZE+1 instead of WQ_NAME_SIZE? Will
> WQ_NAME_SIZE+1 cause mem corruption because wq->name is defined as a
> string with WQ_NAME_SIZE?

No, wq->name actually is:

        char name[WQ_NAME_SIZE + 1];

This code is doing the same thing as elsewhere in the idxd driver
except instead of sprintf() it uses strscpy().

> >=20
> > >=20
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* set driver_name to "c=
rypto" */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memset(wq->driver_name, =
0, DRIVER_NAME_SIZE + 1);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0strscpy(wq->driver_name,=
 "crypto", DRIVER_NAME_SIZE +
> > > > 1);
> > >=20
> > > Is strcpy(wq->driver_name, "crypto") simpler?
> >=20
> > Same here.
>=20
> Ditto.
>=20

Same.

Tom

> Thanks.
>=20
> -Fenghua

