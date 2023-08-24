Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F102F786ECA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241299AbjHXMLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbjHXMLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:11:01 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67E1E7D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 05:10:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDqiLs+3iTW1fOgJdCHqmZUmwXEjdeLbsNBC5BoVLG1zvA1VunfJC+7qcnfp01m8857WEA3n/IDRBO3TYv4OziR/N6m89rPn0iaUKboDPEFikOM0aoZ0b3mbz6xXMWkKPOohdteXgD9ZYmnU/Qjjnen1vi+/XclFq2g5gWvWd0IoQ32wk1ELTxD44GTfRNZ5gbGcvAqw2GnIg3QAtwUxk5kSOPmhOvV/tsGrZNs0W3L+0irwI+OMqLiimZssiRbUZNQIqpDERyeXMfcT+MntxtC03n0UXn12xA7HroXPVEvmXjzCKmSAt20w6qVfJeB3VWuGiTOTWbkhpk9jsYr+fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARk48sZZuqDZIhWXsWai6KZrp+qZ9Ur2y+CQYqkPe8A=;
 b=d9vpbknu2GpLWzxkkk8ujl3Bbg5+CjOL4DnLenitzH4VHrowu5JokGfFQFLQJmEaAs+z5P3MAavR4o2v7SxCEBtYOVyNlhgpmIxXtZ8F4rVgIxbq9TwReEDE193x3FApXJYDJe6oA1K2vZFW/aFEQJxaZ7nLRMtdZrGIbIQSIlQCzj90C+qTFd6zChZPV62xPF2UOvuwWut+HOF0kZP8VlTbXJZOhevOotEBzOI8v2Tai1GsPLBr+FNxdlNA+28oAlpsZ/pSi8atDvHCQNQyYUL8nui69dFQsWguo1P2u9+ggLiIPeNHTcKJyeYHIPSDOAsGnZPO/xRZk2nKM2uMOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARk48sZZuqDZIhWXsWai6KZrp+qZ9Ur2y+CQYqkPe8A=;
 b=UIfORfE60TDDloAJFdBYJQQHpvKu6iKgXR8Ags0CjjNRw/Cgo7i4IVH6Bnawg0cRCf9V/zr+Ofomy8dvItwWtW0u+ug22URja/THbY22x6MjVtckKfcww6N31pMX7B5KLDDnr+iiUIBhp1WTS1yWgwQvvTiLjGKeevJSRKu9Cms=
Received: from DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) by
 BN9PR12MB5116.namprd12.prod.outlook.com (2603:10b6:408:119::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 12:10:56 +0000
Received: from DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::787e:9003:7c48:4f5b]) by DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::787e:9003:7c48:4f5b%5]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 12:10:55 +0000
From:   "Gangurde, Abhijit" <abhijit.gangurde@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gupta, Nipun" <Nipun.Gupta@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Gupta, Puneet (DCG-ENG)" <puneet.gupta@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>
Subject: RE: [PATCH v3 1/5] cdx: Remove cdx controller list from cdx bus
 system
Thread-Topic: [PATCH v3 1/5] cdx: Remove cdx controller list from cdx bus
 system
Thread-Index: AQHZzplPY3FbKoc8SESGrB7e8WI2ha/2ZmAAgAFT3FA=
Date:   Thu, 24 Aug 2023 12:10:55 +0000
Message-ID: <DM4PR12MB7765CC9DA9EAC441CE389A278F1DA@DM4PR12MB7765.namprd12.prod.outlook.com>
References: <20230814102223.418046-1-abhijit.gangurde@amd.com>
 <20230814102223.418046-2-abhijit.gangurde@amd.com>
 <2023082207-humped-unclasp-6058@gregkh>
In-Reply-To: <2023082207-humped-unclasp-6058@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ActionId=9e51405c-00c4-4f3a-ba05-e6f6bd2773bf;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ContentBits=0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Enabled=true;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Method=Privileged;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Name=Non-Business-AIP
 2.0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SetDate=2023-08-24T12:09:14Z;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB7765:EE_|BN9PR12MB5116:EE_
x-ms-office365-filtering-correlation-id: e87726f4-8eb1-40e4-e6a5-08dba49b2b5a
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N7qitCHGM+JC1PYeCUD92vEl2rDKGT+7NjLlW+LGIJBqm+mCvjQz/C4h48p+RCXmESO2KuVV0199/+NjaI1XDxtd4J1rsNjRaUM6UqSqWB3zJVMbhnvLvBeQGgip5wViAaXNjkJHL0TXs7o+yMcE/K+xy2FVpaPpbpqLlIxcFFhTvPPfyRT5XqdMMJ5YOwoEfY2MDgThUlsg+Ini/YII/A/IyV77NxlGthlsbEmw1UysIQ1P1go2CYiHW1HxKfIu0Rg+h0iNW+CleTkdJ5OfYtGbclSQ8ybTQuIC6XCnFVZoob65Xb/MDE3rRF/FmMIV6/ZgtvS0QcC8PnqXCHDAgDcMz9hMbbN1i7qg3a2OBP5jLOhkdK+IFUQBtQg1yY3jEEO87HJVqdEaC9Zj+AQwolnzEMwp6Bj7f4qjWiVM1U+VrP6mrogNyDFM2ga37D99c5QRD4fwqlQpZcDrm873omr/e8aFPBbkhveGqj/f64cDNhJowRl0rWWqy+ZzErXXS44oyyJY0iHJSFwlDINy1rsNxA74GTUl1thNasi6yVmKIvJMOpIwRpraHhJ5VeE65yxRRmdmbO1OLA1QfpXZtX9OXHd03uSkjeZQvEnj0CYF6+D+1Fjrcc1o/xaJbThq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7765.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(186009)(1800799009)(451199024)(52536014)(5660300002)(8676002)(8936002)(4326008)(83380400001)(33656002)(7696005)(55016003)(26005)(71200400001)(38070700005)(38100700002)(122000001)(66556008)(66946007)(66476007)(66446008)(54906003)(64756008)(6916009)(76116006)(316002)(478600001)(41300700001)(2906002)(9686003)(6506007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aWmGCt6r7Qs3z20vva0OH7c4EhtsafnGO0d+Xw+pWQ4CHdWul8pqRTWrI3xu?=
 =?us-ascii?Q?gZBua6EPKmB72pwthsLNGzF+jJ5woP2yKbIhFCO556yrHfXRsJgOQ+kQ+dt0?=
 =?us-ascii?Q?5wRR3KFtaMFFdflTiB/bqI8+4OHNLXQZue3hIp5h4KIcW9r4OkmsavGfzUYj?=
 =?us-ascii?Q?2xFIEZwvReA3VSC7/VwZqTN2vOjBOZBaa0zYbqjnOs5Do2dizDhGRtJw/s8C?=
 =?us-ascii?Q?XTeLRogWhXcRDsJckLSmes20lnQkS/Y4skX9n4MdOJO+LNTG0Uj4b/ZKwfZE?=
 =?us-ascii?Q?G+d7aWn3RH/+fMatFeeKWdbFrOZtdSAe/49kW6cyq2AvUIVbbBHWT0B6iWJh?=
 =?us-ascii?Q?yl9Zm6GjWUUFEqebjZ0VHN6eY/qUdBmVjHnPlg1t4Y57lFD+JvmwSR8Mtj3V?=
 =?us-ascii?Q?4nSwNyVz2r+gdpQsU0ouZdKF5VBc9jYJzaQZUfTbOYkqkpK50UGYXSQvXg66?=
 =?us-ascii?Q?VrwbptTATeEdjR/oZhSeBs3hgghsgaHZkloTi7ZWVeP7HhDMpNJy8zucFKut?=
 =?us-ascii?Q?fSrLu11L/DYafysIw9Y9CsLjVbDymeKIgtj11a5uBdsUIJNU3wbv2KEZYWjr?=
 =?us-ascii?Q?GtXLqLQqI5XzqqgMezHtw3gt9n86c71Y88Ohzs2uWV/Em79PEtVoO/faT95n?=
 =?us-ascii?Q?J8BPAiEmW+o/YZcu6589o7HQIZNvVB+CDoXtW8bpO1wNFTUPbUdE94fEpCLJ?=
 =?us-ascii?Q?/8UJv1StgQFPB7xQb6lcARbddrJ7ZIlf66DcpcSY8ebo6DrNvcra2NqkZLDc?=
 =?us-ascii?Q?7hfBw4eJBb7WTYDsQSrxgiPzsJQJPGC2aQh/oPKV3y3ZVIILG8kXSOiKs+Fh?=
 =?us-ascii?Q?DTu+GdNpS/8AFdjiUqQxjFPlP45ptGIf3xDa96JvWzBIwkWPCgGDqrz+ENUY?=
 =?us-ascii?Q?U4LVrUO10cJ+JPmEpWBhD2z9rMjbqJXVY7EL5pq4djleOK9Cl7Sfetyb5DQR?=
 =?us-ascii?Q?W5WUoIpCd1PsLrXpzVjmUnLtWPQxg9LTf4KkcZVX9L2ePPEzBWkbKj0ia4rY?=
 =?us-ascii?Q?AnkBFXLTqltrFEekRklmPQ/Ip0PvAjftrRBAOOhITuW/K80yS56NzrXl4Ntf?=
 =?us-ascii?Q?znOGJKBDeCDo4TRNWQ1yeUYXHl1dfmedmGtmjkNdEkunCqFbEpPGRp/ZVeuS?=
 =?us-ascii?Q?LARdbsaIwFRiiqDYmnqAFN6HlXqT7PIuAyHeVEERaeb/4uetCSO1QY5MgWIH?=
 =?us-ascii?Q?3gzm2Vdrb+7rODRsab+G/Mtvh7epixPOthhCZioCLlk9c6mIMHMVsQjDqaG4?=
 =?us-ascii?Q?Qts9hxhclKbYln3H8tIZJV0jcVeBKGq+ycG1UaPYiPpnJsdkWlngNIpJaQzG?=
 =?us-ascii?Q?VT/+wqx9ZOG8QJS+WQhzjTE5kINbeuwaks0fyg+uuF3yiRWKVeTkpr3y2X/Q?=
 =?us-ascii?Q?I7kIUiRWHsW66+p7A84OW9g2xv31cSbftM+B7fcLZbR+jaOOUzL/4aKtbc6E?=
 =?us-ascii?Q?UQNZm0gFwEo0yPnGfXIFK/yfYzPGunBiYnnvaH3FVsHmoBXl3XMTeCnhtDkV?=
 =?us-ascii?Q?uwk3kseN5KXwoxhjRYHhyp22DcVuFQC4s6jqDwy/MkhUc4ugdXl9tvJOU8xV?=
 =?us-ascii?Q?1OV3TEM83JEJYAbxvN4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7765.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e87726f4-8eb1-40e4-e6a5-08dba49b2b5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 12:10:55.7148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tFXA2SQig0Ah7AmogerW6Ppr/GQAue4A5IopoaCBxACgpnGbEFZnWCaCF68y4fikr+BY8d7OaEFCENiWiMFpUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5116
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Aug 14, 2023 at 03:52:19PM +0530, Abhijit Gangurde wrote:
> > Remove xarray list of cdx controller. Instead, use platform bus
> > to locate the cdx controller using compat string used by cdx
> > controller platform driver.
>=20
> You also now use an ida instead, right?  Do you need to mention that
> here?

Yes. Will add it in the description.

>=20
> > Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> > ---
> >  drivers/cdx/cdx.c           | 39 ++++++++++++++++++++++++-------------
> >  include/linux/cdx/cdx_bus.h |  2 ++
> >  2 files changed, 28 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> > index d2cad4c670a0..1c0f76cf4f15 100644
> > --- a/drivers/cdx/cdx.c
> > +++ b/drivers/cdx/cdx.c
> > @@ -60,7 +60,7 @@
> >  #include <linux/of_device.h>
> >  #include <linux/slab.h>
> >  #include <linux/mm.h>
> > -#include <linux/xarray.h>
> > +#include <linux/idr.h>
> >  #include <linux/cdx/cdx_bus.h>
> >  #include <linux/iommu.h>
> >  #include <linux/dma-map-ops.h>
> > @@ -70,8 +70,10 @@
> >  #define CDX_DEFAULT_DMA_MASK	(~0ULL)
> >  #define MAX_CDX_CONTROLLERS 16
> >
> > -/* CDX controllers registered with the CDX bus */
> > -static DEFINE_XARRAY_ALLOC(cdx_controllers);
> > +/* IDA for CDX controllers registered with the CDX bus */
> > +DEFINE_IDA(cdx_controller_ida);
>=20
> Why is this now a global variable?

This should have been static. Will correct this in next version.

>=20
> thanks,
>=20
> > +
> > +static char *compat_node_name =3D "xlnx,versal-net-cdx";
> >
> >  /**
> >   * cdx_dev_reset - Reset a CDX device
> > @@ -384,7 +386,8 @@ static ssize_t rescan_store(const struct bus_type
> *bus,
> >  			    const char *buf, size_t count)
> >  {
> >  	struct cdx_controller *cdx;
> > -	unsigned long index;
> > +	struct platform_device *pd;
> > +	struct device_node *np;
> >  	bool val;
> >
> >  	if (kstrtobool(buf, &val) < 0)
> > @@ -397,12 +400,19 @@ static ssize_t rescan_store(const struct bus_type
> *bus,
> >  	cdx_unregister_devices(&cdx_bus_type);
> >
> >  	/* Rescan all the devices */
> > -	xa_for_each(&cdx_controllers, index, cdx) {
> > -		int ret;
> > +	for_each_compatible_node(np, NULL, compat_node_name) {
> > +		if (!np)
> > +			return -EINVAL;
> >
> > -		ret =3D cdx->ops->scan(cdx);
> > -		if (ret)
> > -			dev_err(cdx->dev, "cdx bus scanning failed\n");
> > +		pd =3D of_find_device_by_node(np);
> > +		if (!pd)
> > +			return -EINVAL;
> > +
> > +		cdx =3D platform_get_drvdata(pd);
> > +		if (cdx && cdx->controller_registered && cdx->ops->scan)
> > +			cdx->ops->scan(cdx);
> > +
> > +		put_device(&pd->dev);
>=20
> What handles the locking here?  What if a new device is added , or
> removed, while you iterate this?
>=20
> And what about racing with the controller_registered flag?  Are you sure
> that's needed?
>=20

As you highlighted, locking is introduced in patch 2 of this series.

Thanks,
Abhijit

