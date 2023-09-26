Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9DE7AEF4D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbjIZPGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbjIZPGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:06:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F99510A;
        Tue, 26 Sep 2023 08:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695740768; x=1727276768;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=pn0F+kwsoTyRCnoC07T8ZrXe1y1Q9keK+1limegx/Wo=;
  b=nrx6WWc2IhIJwfqAyLuCIgGqTLSLHVvyMXepPSPelrwP7PLhSgiYhAu1
   sXE0HqWcJ/cc9Z7JRAbVRJt85ddgZifGE0YNDzHzXoF0e+O0gNjaVxRgE
   qdjN/UHzN1ErmEF8QinZ0y+x0mnjcFuog/8NQLabynYUjjYIVpdBspHBv
   CKH+/n58tdZKn2K4lYKmOainyXSgZ8dF04BB9heKQwzSJwgt2pZYUxJp7
   8vTgQpvB9b1laMj/ju2GmTzplnNzNwYpJiAGFij5MaP0YtSscFRYj+1r7
   2etlv/1lYnNdZfrH7yBqw7hT1ISZxGtqntZtKaQ49cQPWmBDjgbSENJXE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="378864419"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="378864419"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 08:04:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="839058453"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="839058453"
Received: from spandruv-desk1.amr.corp.intel.com ([10.212.206.185])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 08:04:47 -0700
Message-ID: <9cab732f92d529d76b9e40f91ede1460320f1da4.camel@linux.intel.com>
Subject: Re: [PATCH 3/3] platform/x86: intel_speed_select_if: Remove
 hardcoded map size
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 26 Sep 2023 08:04:46 -0700
In-Reply-To: <ZRLZmDmIkOo0YVz6@smile.fi.intel.com>
References: <20230925194555.966743-1-srinivas.pandruvada@linux.intel.com>
         <20230925194555.966743-4-srinivas.pandruvada@linux.intel.com>
         <ZRLZmDmIkOo0YVz6@smile.fi.intel.com>
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

On Tue, 2023-09-26 at 16:16 +0300, Andy Shevchenko wrote:
> On Mon, Sep 25, 2023 at 12:45:55PM -0700, Srinivas Pandruvada wrote:
> > The driver is using 256 as the size while calling devm_ioremap().
> > The
> > maximum offset is already part of struct isst_mmio_range. Use the
> > maximum offset (end field of the struct) plus 4 as the map size to
> > remove
> > hardcoded value of 256.
>=20
> ...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0punit_dev->mmio_range =3D (s=
truct isst_mmio_range *) ent-
> > >driver_data;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0punit_dev->punit_mmio =3D de=
vm_ioremap(&pdev->dev, base_addr,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 punit_dev-
> > >mmio_range[1].end + sizeof(u32));
>=20
> Can we rather fix the mmio_range driver data to have end be actually
> not the
> offset of the last dword? (Better maybe to keep length there.)
>=20
We can. But that has to be separate patch on top as there are other
places this range is used.


> With help of
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct resource r;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0...
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0r =3D DEFINE_RES_MEM(base=
_addr, mmio_range.beg +
> mmio_range.len);
>=20
> you can switch to devm_ioremap_resource() API.
What is the advantage of creating a resource and then call
devm_ioremap_resource()?

Thanks,
Srinivas

>=20

