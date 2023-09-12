Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328ED79DAFF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 23:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236487AbjILVcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 17:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjILVcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:32:48 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0890F10D0;
        Tue, 12 Sep 2023 14:32:45 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230912213244usoutp02abef0275c3abcc3cb5a187e4a5bc77af~ERDdOl2mR1550215502usoutp02t;
        Tue, 12 Sep 2023 21:32:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230912213244usoutp02abef0275c3abcc3cb5a187e4a5bc77af~ERDdOl2mR1550215502usoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694554364;
        bh=QgJzk0LFw6AGu8v5Ju1ew6zxSY87McNCclcicOQTPz0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=iRVV4YwyIRtfKSq3XsWaO1+iXASqUexqg1MXXqDxfsa9jBhNnIfD4ta+gFOuP39+5
         3zsn3NfnldKYXuTVCgVE8respffxDfq9bA5DmvwYV1G7JC4ovcx7vVwCTT1rWBLuLP
         0wNQWXm8jrI+7QoEA61aSjPe/63SirVwQDg0NE1s=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230912213243uscas1p2082313b51d35971208ee5bedb3e44ff2~ERDc73jUX1320613206uscas1p2p;
        Tue, 12 Sep 2023 21:32:43 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id D7.CC.50148.BF8D0056; Tue,
        12 Sep 2023 17:32:43 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230912213243uscas1p17fa844630bf6caf6af9119c651e4759b~ERDcintwd2491324913uscas1p1N;
        Tue, 12 Sep 2023 21:32:43 +0000 (GMT)
X-AuditID: cbfec36d-7bdff7000002c3e4-73-6500d8fba816
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 33.22.31410.BF8D0056; Tue,
        12 Sep 2023 17:32:43 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Tue, 12 Sep 2023 14:32:42 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
        12 Sep 2023 14:32:42 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Fan Ni <fan.ni@gmx.us>, Dan Williams <dan.j.williams@intel.com>,
        "Navneet Singh" <navneet.singh@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 03/18] cxl/mem: Read Dynamic capacity
 configuration from the device
Thread-Topic: [PATCH RFC v2 03/18] cxl/mem: Read Dynamic capacity
        configuration from the device
Thread-Index: AQHZ2jkK/pP/klWxW0KG5oR5AqJrLLAD1zsAgA435ICABjMaAA==
Date:   Tue, 12 Sep 2023 21:32:42 +0000
Message-ID: <20230912213242.GD2859961@sjcvldevvm72>
In-Reply-To: <64fba59f73319_1e8e78294e2@iweiny-mobl.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E5E5A3975330C243BEF1F709F73946DF@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsWy7djXc7q/bzCkGtz5rmtx9/EFNovpUy8w
        Wpy42chmsfrmGkaLW6cOM1rsf/qcxWLVwmtsFudnnWKxuLxrDpvF8TUTWC1uTTjG5MDt8Wz3
        OmaPliNvWT0W73nJ5DF1dr3H501yAaxRXDYpqTmZZalF+nYJXBmLZt1hLDgtU7H46UvWBsb5
        Yl2MnBwSAiYSB39uYu1i5OIQEljJKLHo3EZGCKeVSeL49wOsMFXb3vVDJdYySnx++hTK+cQo
        0XL6PpSzjFHi9J+JjCAtbAKKEvu6trOB2CICyhKn/11lAyliFjjCLHH1yFYmkISwQILEl7ub
        oYoSJdqm/GTpYuQAsp0k1kxPBQmzCKhKvH33iB3E5hUwlnjQ0wdmcwrYSPxtuAhmMwqISXw/
        tQZsJLOAuMStJ/OZIM4WlFg0ew8zhC0m8W/XQzYIW1Hi/veX7BD1OhILdn9ig7DtJB5s2MEM
        YWtLLFv4mhlir6DEyZlPWCB6JSUOrrjBAvKLhMAXDommk/OglrlInJu0HGqBtMT0NZfBfpEQ
        SJZY9ZELIpwjMX/JFqg51hIL/6xnmsCoMgvJ2bOQnDQLyUmzkJw0C8lJCxhZVzGKlxYX56an
        FhvmpZbrFSfmFpfmpesl5+duYgSmsdP/DufuYNxx66PeIUYmDsZDjBIczEoivCWH/qYI8aYk
        VlalFuXHF5XmpBYfYpTmYFES5zW0PZksJJCeWJKanZpakFoEk2Xi4JRqYNoYf1s+WU45u7Bb
        bmGDpKTijSIVTYPzRcJhaWn53hufSlqwbt16VrbR5VxfdQH3Dj6l6umtxccDWQ8+urNw0o6s
        qESHC2d/Lc1dsd/e/F7k9v+qDVeD6pZfuPFts+uhWyGnXZynT/0RXJN6fuFztyMsdTVGq1fW
        dL0x+JsWe1jkamd/TJDQsf36G9dPEbuddSDwlMqnnYIuExdeZmrP3/jE2lrJxXytzJICszk/
        27xNjkZqX2tm3rBlJ3dF0NzpO/7EFombvXt1KiZxGYuo+LZvLQlvMl3VX3EX3P0hdCUl65hy
        9rGkwLr3u7jiEr6414t0B57IFb+zwCGpv0r80KK5zLtqG6oPqHG13RbJV2Ipzkg01GIuKk4E
        AL1Y3SrSAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsWS2cA0Uff3DYZUg2cThS3uPr7AZjF96gVG
        ixM3G9ksVt9cw2hx69RhRov9T5+zWKxaeI3N4vysUywWl3fNYbM4vmYCq8WtCceYHLg9nu1e
        x+zRcuQtq8fiPS+ZPKbOrvf4vEkugDWKyyYlNSezLLVI3y6BK2PRrDuMBadlKhY/fcnawDhf
        rIuRk0NCwERi27t+RhBbSGA1o8Tj7ypdjFxA9idGiSXTnrJBOMsYJbat+Q1WxSagKLGvazsb
        iC0ioCxx+t9VsCJmgSPMEse23WcFSQgLJEi83vuQEaIoUWLL6adANgeQ7SSxZnoqSJhFQFXi
        7btH7CA2r4CxxIOePnaIZYuZJF7f/AGW4BSwkfjbcBHMZhQQk/h+ag0TiM0sIC5x68l8JogX
        BCSW7DnPDGGLSrx8/I8VwlaUuP/9JTtEvY7Egt2f2CBsO4kHG3YwQ9jaEssWvmaGOEJQ4uTM
        JywQvZISB1fcYJnAKDELybpZSEbNQjJqFpJRs5CMWsDIuopRvLS4ODe9otg4L7Vcrzgxt7g0
        L10vOT93EyMwBZz+dzhmB+O9Wx/1DjEycTAeYpTgYFYS4S059DdFiDclsbIqtSg/vqg0J7X4
        EKM0B4uSOO+OKRdThATSE0tSs1NTC1KLYLJMHJxSDUzpa+fKd3rGXclVvCome3FCB3fBBZO1
        UwQFrLLy2fmOtv9nUfVIWqYnX35ga9iJBwIVlS0WinHe+Wf8L6z56Hh8753jhXnSWy66F6/Y
        5LS8eJqZOsd8Vsmbucqhrmli1lfal6jwB2tEe3JPyP+7Tm+Xk475C/l7XkFHlghcOLxZpWwX
        8yfn/xUqPL+06hZXzF6zOOu5bMhKy+0MlZqn7c7+bv/X9eJEQs7WjBmvlvHN/i087wXnROFr
        G2NelvyLZUhfF1a13oxry98TrdUBSZx/N2S8Su6/GJ2f+zXXcB2nVkrU2XUdfqy7C1yl2Hew
        bOftcn/527OzN/Ke3oyuxA+aXPPKPtyMr6jZP2eFuRJLcUaioRZzUXEiAKq+4olwAwAA
X-CMS-MailID: 20230912213243uscas1p17fa844630bf6caf6af9119c651e4759b
CMS-TYPE: 301P
X-CMS-RootMailID: 20230908225229uscas1p2f1013a8dd9977718cbd19e6433adef57
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
        <20230604-dcd-type2-upstream-v2-3-f740c47e7916@intel.com>
        <ZO+4Qql0rOslp0bl@debian>
        <CGME20230908225229uscas1p2f1013a8dd9977718cbd19e6433adef57@uscas1p2.samsung.com>
        <64fba59f73319_1e8e78294e2@iweiny-mobl.notmuch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 03:52:15PM -0700, Ira Weiny wrote:

> Fan Ni wrote:
> > On Mon, Aug 28, 2023 at 10:20:54PM -0700, ira.weiny@intel.com wrote:
> > > From: Navneet Singh <navneet.singh@intel.com>
> > >
>=20
> [snip]
>=20
> > >
> > > +static int cxl_dc_save_region_info(struct cxl_memdev_state *mds, int=
 index,
> > > +				   struct cxl_dc_region_config *region_config)
> > > +{
> > > +	struct cxl_dc_region_info *dcr =3D &mds->dc_region[index];
> > > +	struct device *dev =3D mds->cxlds.dev;
> > > +
> > > +	dcr->base =3D le64_to_cpu(region_config->region_base);
> > > +	dcr->decode_len =3D le64_to_cpu(region_config->region_decode_length=
);
> > > +	dcr->decode_len *=3D CXL_CAPACITY_MULTIPLIER;
> > > +	dcr->len =3D le64_to_cpu(region_config->region_length);
> > > +	dcr->blk_size =3D le64_to_cpu(region_config->region_block_size);
> > > +	dcr->dsmad_handle =3D le32_to_cpu(region_config->region_dsmad_handl=
e);
> > > +	dcr->flags =3D region_config->flags;
> > > +	snprintf(dcr->name, CXL_DC_REGION_STRLEN, "dc%d", index);
> > > +
> > > +	/* Check regions are in increasing DPA order */
> > > +	if (index > 0) {
> > > +		struct cxl_dc_region_info *prev_dcr =3D &mds->dc_region[index - 1]=
;
> > > +
> > > +		if ((prev_dcr->base + prev_dcr->decode_len) > dcr->base) {
> > > +			dev_err(dev,
> > > +				"DPA ordering violation for DC region %d and %d\n",
> > > +				index - 1, index);
> > > +			return -EINVAL;
> > > +		}
> > > +	}
> > > +
> > > +	/* Check the region is 256 MB aligned */
> > > +	if (!IS_ALIGNED(dcr->base, SZ_256M)) {
> > > +		dev_err(dev, "DC region %d not aligned to 256MB: %#llx\n",
> > > +			index, dcr->base);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	/* Check Region base and length are aligned to block size */
> > > +	if (!IS_ALIGNED(dcr->base, dcr->blk_size) ||
> > > +	    !IS_ALIGNED(dcr->len, dcr->blk_size)) {
> > > +		dev_err(dev, "DC region %d not aligned to %#llx\n", index,
> > > +			dcr->blk_size);
> > > +		return -EINVAL;
> > > +	}
> >=20
> > Based on on cxl 3.0 spec: Table 8-126, we may need some extra checks
> > here:
> > 1. region len <=3D decode_len
> > 2. region block size should be power of 2 and a multiple of 40H.
>=20
> Thanks for pointing these additional checks out!  I've added these.
>=20
> >=20
> > Also, if region len or block size is 0, it mentions that DC will not be
> > available, we may also need to handle that.
>=20
> I've just added checks for 0 in region length, length and block size.
>=20
> I don't think we need to handle this in any special way.  Any of these
> checks will fail the device probe.  From my interpretation of the spec
> reading these values as 0 would indicate an invalid device configuration.
>=20
> That said I think the spec is a bit vague here.  On the one hand the
> number of DC regions should reflect the number of valid regions.
>=20
> Table 8-125 'Number of Available Regions':
> 	"This is the number of valid region configurations returned in
> 	this payload."
>=20
> But it also says:
> 	"Each region may be unconfigured or configured with a different
> 	block size and capacity."
>=20
> I don't believe that a 0 in the Region Decode Length, Region Length, or
> Region Block Size is going to happen with the code structured the way it
> is.  I believe these values are used if the host specifically requests th=
e
> configuration of a region not indicated by 'Number of Available Regions'
> through the Starting Region Index in Table 8-163.  This code does not do
> that.
>=20
> Would you agree with this?

Agreed.

Fan
>=20
> Thanks again,
> Ira=
