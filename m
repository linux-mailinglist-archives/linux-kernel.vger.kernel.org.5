Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85ADA7DD363
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376300AbjJaQzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346998AbjJaQxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:53:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE502198B
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698771048; x=1730307048;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=V93zJ/7bFgDUz2hS0FSBlAz1jK8utvg5e/zgGR4Xx38=;
  b=B7vL6y90TeSawZaDSN4AExLTd79iAQdKYTU/GlHnZb4dJO1Wme4mKxxt
   ZFmLJ2mkJq8+1Qm0Yk3UPpVJ5dVpJI2K3NKj55OOqw9KtkVba5VN2FRhg
   X2KUpjStTeeomBIP1nXomh0s8o6TIyUwGnKMAYiFrfl/nu77VmnVvhw6S
   oU6mNNTqOUVwLCzgsSAs1UyAdZEfXfI4HHFbE6vcu4OGrM5ZkPGamycxj
   biSq9koBtdWRtFnslIMo9RAub/SN8JKZkjj0D31PX1KUsb9cPJS18Ml1K
   v06UCf6Yj9EWCCVcZnOPRIyqM6zuftBQKHLoz8INYQ7IUWoAQ6UsvHX03
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="1176849"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="1176849"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 09:50:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="760682191"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="760682191"
Received: from olindum-mobl1.ger.corp.intel.com (HELO [10.249.254.59]) ([10.249.254.59])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 09:50:43 -0700
Message-ID: <6cf7459aa0332d6fc3c4764f66a83c6a3825348f.camel@linux.intel.com>
Subject: Re: [PATCH drm-misc-next v7 4/7] drm/gpuvm: add an abstraction for
 a VM / BO combination
From:   Thomas =?ISO-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>
To:     Danilo Krummrich <dakr@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>, airlied@gmail.com,
        daniel@ffwll.ch, matthew.brost@intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith@gfxstrand.net
Cc:     nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Date:   Tue, 31 Oct 2023 17:50:41 +0100
In-Reply-To: <1e2acafb-fbc3-4256-b1e1-3fe6c47b1ef2@redhat.com>
References: <20231023201659.25332-1-dakr@redhat.com>
         <20231023201659.25332-5-dakr@redhat.com>
         <f00a4975cf32c3ae28124343a2c994acda083829.camel@linux.intel.com>
         <87zfzz3thp.fsf@intel.com>
         <1e2acafb-fbc3-4256-b1e1-3fe6c47b1ef2@redhat.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-10-31 at 17:30 +0100, Danilo Krummrich wrote:
> On 10/31/23 12:45, Jani Nikula wrote:
> > On Tue, 31 Oct 2023, Thomas Hellstr=C3=B6m
> > <thomas.hellstrom@linux.intel.com> wrote:
> > > On Mon, 2023-10-23 at 22:16 +0200, Danilo Krummrich wrote:
> > > > + * Returns: a pointer to the &drm_gpuvm_bo on success, NULL on
> > >=20
> > > Still needs s/Returns:/Return:/g
> >=20
> > FWIW, both work to accommodate the variance across the kernel,
> > although
> > I think only the latter is documented and recommended. It's also
> > the
> > most popular:
> >=20
> > =C2=A0=C2=A0 10577 Return
> > =C2=A0=C2=A0=C2=A0 3596 Returns
>=20
> I'd like to keep "Returns", since that's what GPUVM uses already
> everywhere else.

Ok. It looks like the Returns: are converted to Return in the rendered
output so I guess that's why it's the form that is documented.

I pointed this out since in the last review you replied you were going
to change it, and also when the code starts seeing updates from other,
it might become inconsistent if those patches follow the documented
way.

But I'm OK either way.

/Thomas


>=20
> > =C2=A0=C2=A0=C2=A0 1104 RETURN
> > =C2=A0=C2=A0=C2=A0=C2=A0 568 return
> > =C2=A0=C2=A0=C2=A0=C2=A0 367 returns
> > =C2=A0=C2=A0=C2=A0=C2=A0 352 RETURNS
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 RETURNs
> >=20
> > BR,
> > Jani.
> >=20
> >=20
>=20

