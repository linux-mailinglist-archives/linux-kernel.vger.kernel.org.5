Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70273786ECC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239189AbjHXMLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjHXMLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:11:15 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A86198B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 05:11:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPM6F3rWqt2EaCh7TSureXI6SxImGaj1vvFFWROPmi1u+0f+iHo3JViEcU4ONQScljAqDHWC33GzbpqL1FchqJk212LZACW0cUFj3PDQzTtnw7xSprP6PVJVlFHlWX8KNraZi2voEloZmzN6SKb9CApJVbd/BRpo8KcvLWO6MagCIdDz1YG/VgzngMbsScQJpIbFwBYvUuUlXYDLyNLWnkl67hUHJZmJXBQG7kwvomAmeUHf+fwACwTrgwW5dUZj9FTcLjuVwzIgXzi6vhcfNQgpysoSC6Opdq0TJdr0CW/o54LGIpzEgJGX9WLmMFwBY/T9PN9+wV12+UPVfiTZBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CP5mPO/IJrqEcAJegGeqsRzEO3ZAnA9OlRJBTaEl/wE=;
 b=VwAp+jhoVIrH7DFkLc2qhkQCcgWymNj7yDxN0faVcSRxarlh1nuZTBnBCOHGEBYg5VV7XQ8fw5x3xHMigPjx6cOYrhG0png5CE9QTdDaWiCLcR+h3AUovL6nXIMXsqIHHRX3xTSEACm+reCdEbgmCsDWdrCUwkDJ5JETC765E99Txwr/cnaVIwDUC2zRCSbKKt/E/rLZMaZ/5nKgmxtDuAmicL6an+nW9Et14osJxNYTEjE+ZcHEAErfhAqcGI4eAQ2Pz4SOZNcpDtFT0L5tARTLd7LsNdYwt28qu9jcnBlJQ+3zgpC0gMyfSDHKHeZSA2qelAoNzoO0UCddiPNbyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CP5mPO/IJrqEcAJegGeqsRzEO3ZAnA9OlRJBTaEl/wE=;
 b=YdaC229tcYFyuVrwwbV6uwaYV6hrvx8788tUUDNmYKlz4zXVovVO8N5vpnYfLG3Y65zYeP8fgCZ0lEVV1wG4vsfgQUqbs0P/xXJ+AKyqzhe+cz8M3KushN9Ovl3eB2r1iz/unHKDf2M9TOvRNhhd1YPVdcvg9N5x6OLXuBMtkLo=
Received: from DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) by
 BN9PR12MB5116.namprd12.prod.outlook.com (2603:10b6:408:119::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 12:11:11 +0000
Received: from DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::787e:9003:7c48:4f5b]) by DM4PR12MB7765.namprd12.prod.outlook.com
 ([fe80::787e:9003:7c48:4f5b%5]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 12:11:11 +0000
From:   "Gangurde, Abhijit" <abhijit.gangurde@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gupta, Nipun" <Nipun.Gupta@amd.com>,
        "Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
        "Gupta, Puneet (DCG-ENG)" <puneet.gupta@amd.com>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Jansen Van Vuuren, Pieter" <pieter.jansen-van-vuuren@amd.com>
Subject: RE: [PATCH v3 3/5] cdx: add support for bus enable and disable
Thread-Topic: [PATCH v3 3/5] cdx: add support for bus enable and disable
Thread-Index: AQHZzplq7lRGp4S0HEWkrJRDjYa1Kq/2ZwOAgAFTwZA=
Date:   Thu, 24 Aug 2023 12:11:11 +0000
Message-ID: <DM4PR12MB776585C1E9E15943CABF8CE08F1DA@DM4PR12MB7765.namprd12.prod.outlook.com>
References: <20230814102223.418046-1-abhijit.gangurde@amd.com>
 <20230814102223.418046-4-abhijit.gangurde@amd.com>
 <2023082201-silenced-exfoliate-e6a6@gregkh>
In-Reply-To: <2023082201-silenced-exfoliate-e6a6@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ActionId=947619d6-656c-408a-9ba5-718d88a0eec0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ContentBits=0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Enabled=true;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Method=Privileged;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Name=Non-Business-AIP
 2.0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SetDate=2023-08-24T12:10:15Z;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB7765:EE_|BN9PR12MB5116:EE_
x-ms-office365-filtering-correlation-id: 9c2a993b-bff3-4ca1-27a0-08dba49b3491
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: epGjeL7eFY5+yCOSXxDreD+wUZGdKfRvwQZAH3lO0MY+9UZ/F3ASLcssrXLdREP1eyg/+twCPRTFa41bOYTlUaf52pF3b+FUiTqlcA4fibpMrXyiOx/H1V9y1Uy3BHf3oZi4y/HaFcCi0A6xsm/ZkZ6g6StCe1L0WaHtSPYK1w71dkkfVRw4gykFDqiZuyYIRalbFg12dHXb2MXhGeryvaQyOgfFNRyTh8VOChQFo2aGNpj2mZO4TMeK5kLfd8zu+OS/RqgiDb2fSNnxXwPotKN56Nrc4z3dGYQOt7UCmpfLsrysVd0e9zQUCEszleR7OQAZWkBOOe2H4yDyAm51QiyECX63yUk0mVpIHwoBXJjeFX7GMJS9ZSvSNBzOCmq7BsXN3q5tcyDVLB61wtBzY/Hwf1qWUDU2ID9OeswfPQo+MW+GP52niH9wm+EASLXZxAnheTXwArmaqW5dUN7PTp/ypUMJZIq7fUbjrUt7CAekMnPBtvl855hWS2ATX3zkkV/l2eFhsvGvlFehVu0NRggxwqa+fEuyN8giAold7aOw8/JK/gDT1+qgoIM87T1nRz+e12xcGYA5gjeh4d/1h42pHx/iSDUhGL93FI1TngjAFvjWCFqi9hx7mMt/yXig
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7765.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(186009)(1800799009)(451199024)(52536014)(5660300002)(8676002)(8936002)(4326008)(83380400001)(33656002)(7696005)(55016003)(26005)(71200400001)(38070700005)(38100700002)(122000001)(66556008)(66946007)(66476007)(66446008)(54906003)(64756008)(6916009)(76116006)(316002)(478600001)(41300700001)(2906002)(9686003)(6506007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6sO1UjoZM72Jk8JlTxIrmIbZ3P3h2h0sisaH8D+ehhBTCE33fCi43Wd6tgD1?=
 =?us-ascii?Q?BHvNQSi8iVlIwrxGJLCOPWCGelLO+xfFdXdK1rAgpznApCgz38zr/39C3YGk?=
 =?us-ascii?Q?JLpaPyXNta8X59Ddc7GAncBBr6+aM3gluz9ITDmqp/ywAhrRIMteu+2Y6IRH?=
 =?us-ascii?Q?2tQlxkl4BfvCu5dcAnLJtu7WfEBUAbJuIbdk2K9b21CzbU058CbTRIl6DEQ5?=
 =?us-ascii?Q?2E5nNBgOH39P5GRfdhOFAuN5LSx6nit9YBCVD87AWsqTtneT/agfb6modYlh?=
 =?us-ascii?Q?tpgt4WNyFHHul7BLDyWP4RrQR3Ig5dqfqml9e//I2INyBuo8HqaKoSYMSSfC?=
 =?us-ascii?Q?Br8FWyzU6MrF27yfg5dKjn3Lff+WHFl1qIFb2G3jzjHpz8yHTPnD4+U32Cpq?=
 =?us-ascii?Q?FfrEZP4QtpEQaNVdj+EiBXREPCtmVhgVtsSstFKB4JBAmcpDIQi9CexTht7y?=
 =?us-ascii?Q?irBtV1K/p4T8c49IJnniIIcYMeuJ7vnsxdOfjriIXw/UF9yi8Lzs4hPOt3xd?=
 =?us-ascii?Q?WKKKp6OfQo3ZdoQkTW1W4vFUgGOl5PG0ASO3XQ6Haz9StH23zruD5ej0DvnN?=
 =?us-ascii?Q?lsh05Q3zA0j/qLGyYtXT4PVqbftqoGBb3axL6NLjrQ6xPL+7IvzKbZtPC4EU?=
 =?us-ascii?Q?bJ/nLvxd+htkFvUDsb1EAR2+mTixnOmW355pLFEBq5IEqnYK817KUNtc9TeD?=
 =?us-ascii?Q?bpvGJrwDUcbmDzdYchDhV2l7UViSd/h5kmZdOOpBYNQ9ZI98oeApmaMRx4/l?=
 =?us-ascii?Q?ASvqeNdYRyVkfC2PHtq46KLoNPTQMNTiskMPyq76tquJ3X27sN/m4nxks54c?=
 =?us-ascii?Q?gwjAAfPV1Ju5oSNQqbb4O5HK9PdnxzvVDbKkKaCGSdSxcvLesMLjDQ10Kv94?=
 =?us-ascii?Q?RdoCsWVwiBtewsDfct2n15ZDOU9LEDy9og0cH6DHTFR6r5bzrOT1/V6tMbgX?=
 =?us-ascii?Q?/r+0v8k+MqaCcrXI4z9XjFhSmFkpjiTXnhAFDXaFD4awWRSzlQg+GBQB+Xxl?=
 =?us-ascii?Q?LRysruV81B646OsqWz3plJBMaZUgEwf+E3bE3zWyY9ciZvdTsIiu6D68tPTT?=
 =?us-ascii?Q?8efM83sH5t2At1fHstWCcRDhZB3XgXZxh+/sANcUEzpcEfc53L9lr5pLSeqe?=
 =?us-ascii?Q?hmNYL3dbqhsQIdLm9NBvXERkHktMfGmII7JOyU6cbMq3+b7naOuhpaU0juYM?=
 =?us-ascii?Q?CtNGkpViyGmrKUxu90S9FileDbdRbp8XApWj5NTgvr2GxlUe8EaaDGtHoHd2?=
 =?us-ascii?Q?cnWo4xeKDienjFWbEJB/VBZV2TTi8uz4GgTMrB74HTkVoflk9Rce9YyweQYd?=
 =?us-ascii?Q?b82IXzXUgS3kp/ZiG7nkxMP1IUj1HDgriM0Da8ADVu+9QIX3Zy1pq3vXzNvs?=
 =?us-ascii?Q?cHUpGQBFua5xJhmMz6KXSTPPR3pgWFKsm/sfF/lrSQ6aHInffc3R2zRbg0xe?=
 =?us-ascii?Q?aLMoj/3vEt8k217bUgbIt8pGvxX+uVLv43nqtlBOPGSh/uYejr8ZBe4+oMUI?=
 =?us-ascii?Q?oSXSM2l8DCBLr8Dj0wBZIUUDOSWvIydRq4F4dQu4PYyy9rzCDGqL2CHQ6DGE?=
 =?us-ascii?Q?glwbURkuhyqW+A1SmHg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7765.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2a993b-bff3-4ca1-27a0-08dba49b3491
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 12:11:11.1749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WPaOZD/h51mpXgugM0Rf1tkSJgM7vMI/HX2+NI2KBdjgowhtQbXveCXwMoX+IvzkvQVTQ27QX/dLJmQ72WmxZQ==
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

> On Mon, Aug 14, 2023 at 03:52:21PM +0530, Abhijit Gangurde wrote:
> > CDX bus needs to be disabled before updating/writing devices
> > in the FPGA. Once the devices are written, the bus shall be
> > rescanned. This change provides sysfs entry to enable/disable the
> > CDX bus.
> >
> > Co-developed-by: Nipun Gupta <nipun.gupta@amd.com>
> > Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> > Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> > Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-
> vuuren@amd.com>
> > Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cdx | 27 +++++++
> >  drivers/cdx/cdx.c                       | 94 +++++++++++++++++++++++++
> >  drivers/cdx/controller/cdx_controller.c | 50 +++++++++++++
> >  drivers/cdx/controller/mc_cdx_pcol.h    | 54 ++++++++++++++
> >  drivers/cdx/controller/mcdi_functions.c | 24 +++++++
> >  drivers/cdx/controller/mcdi_functions.h | 18 +++++
> >  include/linux/cdx/cdx_bus.h             | 12 ++++
> >  7 files changed, 279 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cdx
> b/Documentation/ABI/testing/sysfs-bus-cdx
> > index 7af477f49998..04c8dfe7e201 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cdx
> > +++ b/Documentation/ABI/testing/sysfs-bus-cdx
> > @@ -11,6 +11,33 @@ Description:
> >
> >  		  # echo 1 > /sys/bus/cdx/rescan
> >
> > +What:		/sys/bus/cdx/enable
> > +Date:		July 2023
> > +Contact:	nipun.gupta@amd.com
> > +Description:
> > +		Writing bus number in hex to this file will attempt to enable
> > +		the CDX bus. The bus number for the cdx devices can be found
> > +		at /sys/bus/cdx/devices/cdx-BB:DD, where BB denotes the
> bus
> > +		number for the respective device.
> > +
> > +		For example ::
> > +
> > +		  # echo 00 > /sys/bus/cdx/enable
> > +
> > +What:		/sys/bus/cdx/disable
> > +Date:		July 2023
> > +Contact:	nipun.gupta@amd.com
> > +Description:
> > +		Writing bus number in hex to this file will attempt to disable
> > +		the CDX bus. CDX bus should be disabled before updating the
> > +		devices in FPGA. The bus number for the cdx devices can be
> > +		found at /sys/bus/cdx/devices/cdx-BB:DD, where BB denotes
> the
> > +		bus number for the respective device.
> > +
> > +		For example ::
> > +
> > +		  # echo 00 > /sys/bus/cdx/disable
> > +
> >  What:		/sys/bus/cdx/devices/.../vendor
> >  Date:		March 2023
> >  Contact:	nipun.gupta@amd.com
> > diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
> > index 50df061f4537..411beb035fdd 100644
> > --- a/drivers/cdx/cdx.c
> > +++ b/drivers/cdx/cdx.c
> > @@ -70,6 +70,10 @@
> >  #define CDX_DEFAULT_DMA_MASK	(~0ULL)
> >  #define MAX_CDX_CONTROLLERS 16
> >
> > +#define CONTROLLER_ID(X)	\
> > +	(((X) & CDX_CONTROLLER_ID_MASK) >>
> CDX_CONTROLLER_ID_SHIFT)
> > +#define BUS_ID(X) ((X) & CDX_BUS_NUM_MASK)
> > +
> >  /* IDA for CDX controllers registered with the CDX bus */
> >  DEFINE_IDA(cdx_controller_ida);
> >  /* Lock to protect controller ops */
> > @@ -384,6 +388,94 @@ static struct attribute *cdx_dev_attrs[] =3D {
> >  };
> >  ATTRIBUTE_GROUPS(cdx_dev);
> >
> > +static struct cdx_controller *cdx_find_controller(u8 controller_id)
> > +{
> > +	struct cdx_controller *cdx =3D NULL;
> > +	struct platform_device *pd;
> > +	struct device_node *np;
> > +
> > +	for_each_compatible_node(np, NULL, compat_node_name) {
> > +		if (!np)
> > +			return NULL;
> > +
> > +		pd =3D of_find_device_by_node(np);
> > +		if (!pd)
> > +			return NULL;
> > +
> > +		cdx =3D platform_get_drvdata(pd);
> > +		if (cdx && cdx->controller_registered && cdx->id =3D=3D
> controller_id) {
> > +			put_device(&pd->dev);
> > +			break;
> > +		}
> > +
> > +		put_device(&pd->dev);
>=20
> Where is the locking if a platform device is removed?

If platform device is removed, it is expected that controller would be
unregistered in its exit process. And controller unregistering is already
under the lock.

>=20
> > +	}
> > +
> > +	return cdx;
> > +}
> > +
> > +static ssize_t enable_store(const struct bus_type *bus,
> > +			    const char *buf, size_t count)
> > +{
> > +	unsigned long controller_id;
> > +	struct cdx_controller *cdx;
> > +	u8 bus_id;
> > +	int ret;
> > +
> > +	if (kstrtou8(buf, 16, &bus_id))
> > +		return -EINVAL;
> > +
> > +	controller_id =3D CONTROLLER_ID(bus_id);
> > +	bus_id =3D BUS_ID(bus_id);
> > +
> > +	mutex_lock(&cdx_controller_lock);
> > +
> > +	cdx =3D cdx_find_controller(controller_id);
>=20
> You lock before you call this function?  Is the lock required before you
> call it?  If so, please document that and enforce it with the proper
> sparse marking.

Yes. Lock would be requiring for cdx_find_controller() to keep it in sync w=
ith
register and unregister. Will document it and add the sparse marking in
next version.

Thanks,
Abhijit.
