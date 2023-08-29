Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDBD78CF6D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 00:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238277AbjH2WSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 18:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238714AbjH2WRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 18:17:54 -0400
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2093.outbound.protection.outlook.com [40.107.103.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3291291;
        Tue, 29 Aug 2023 15:17:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6yjy5zoT6G2dlI+oBIWpkpb2c4UaQlcMpsoNzed/68aIRaLTkNLo9AxU3HhA1bBaT16XeDj1xST8nCFgAczrL2TgeVWHtyN2j7mPJ6e0kiC1f5SZjwSb1nfZEnmaXiOU4uAcRLK4G1Z6V0+0SNtCiivHTZyvb4T52sID9bQQzZg3RHQhQI+7co6eqjoYv9xPI10T5Dtc5qQ0qKjNjGmHXiGfcEE+QnZqb22PcSrAFttEYnr4SImKlr//oTCV3/m5mu4PHdBMEPRRkiWZ0mwSlNU1shqspHGJ1O0AZym7BB3LAjcXdnYKQM8gOqTAsKyQygiOOqFO802hVbIzKWYuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6byeznUK1LTIpDXkupoStw02AqZrfEhLoFn9sY+avMc=;
 b=jJTRyoazSJtznDeOBFCDTGocGYFtrDguzaV43R249BO1GGupkXNAMe4UBjGK9WTb5+OgRIhVHUg6R/quvbxQCK69X3jPs47nsjJtb4kRg8unk6jUepNUmG59155j0vSDu/Q5i8b+2t7sZXgTqK3H87I99N3f1oXwxb4pYKMtj3v7UDZn/PZn3OoD4qSfNC7i4+z7U1FqfBtr7dV7vnl0ndkBXDCSTsFxW8AeB0jNhz2nHGAkvR99fBSwzfn3Yv/O1aNh56kujuPC83h5n6QuMB4Csaidsl9Op6gFdXi8x6vhi97WVmJQ43beEFdLfkRePk8ER5Y0zjJ0wm6EoBwyog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom-usa.com; dmarc=pass action=none
 header.from=silicom-usa.com; dkim=pass header.d=silicom-usa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6byeznUK1LTIpDXkupoStw02AqZrfEhLoFn9sY+avMc=;
 b=GvRg8X5RlbmeuK4jiYc1mGBz+dST3L9FnONJTAO65OcILcJINZhJyWj/y9vGkU0MGAL/9Rie8BW6pGnY/2nDg5ST2OKL0VKNM6ZEw3e7xByyimeC2Nd3+nzEQ0AtSxU2LB2g+RiRWc0fRkdl9PU9mUgoTzcbkZkbKGGKaCcHotc=
Received: from PA4PR04MB9222.eurprd04.prod.outlook.com (2603:10a6:102:2a1::18)
 by AS8PR04MB8293.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 22:17:47 +0000
Received: from PA4PR04MB9222.eurprd04.prod.outlook.com
 ([fe80::d62d:f67e:ba75:b5dc]) by PA4PR04MB9222.eurprd04.prod.outlook.com
 ([fe80::d62d:f67e:ba75:b5dc%4]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 22:17:47 +0000
From:   Huibin Shi <henrys@silicom-usa.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Henry Shi <henryshi2018@gmail.com>
CC:     "hbshi69@hotmail.com" <hbshi69@hotmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "hb_shi2003@yahoo.com" <hb_shi2003@yahoo.com>,
        Wen Wang <wenw@silicom-usa.com>
Subject: RE: [PATCH v5] Add Silicom Platform Driver
Thread-Topic: [PATCH v5] Add Silicom Platform Driver
Thread-Index: AQHZ2fZtG8yRMH1LA0m5IzEWUGUgdrAAbygAgAFcRYA=
Date:   Tue, 29 Aug 2023 22:17:47 +0000
Message-ID: <PA4PR04MB92225C42CC763DCBA622C6579AE7A@PA4PR04MB9222.eurprd04.prod.outlook.com>
References: <20230828212622.32485-1-henryshi2018@gmail.com>
 <15039461-6099-40a1-952f-fc31d65a0d3f@roeck-us.net>
In-Reply-To: <15039461-6099-40a1-952f-fc31d65a0d3f@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silicom-usa.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9222:EE_|AS8PR04MB8293:EE_
x-ms-office365-filtering-correlation-id: 840fe917-245f-4bbb-1697-08dba8ddc68f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yScQFLTQK7CrFnlA+9hg8qarW3a04oLxiIcRj8PZVu0Tt97Bvx/JnShG6aIzl7Rd7TxsA3aLEZ4ZPUs1H83K7M7ABssad9Yb7FrdJFr6Gh8EuecKROnuQwP29oc2swZBol4dkGv1BifOMzUjl+2St3rzc6LRz8PUP4b8TdOPvNrZQjpurMgOgs9GlWZrttv2QprukjemdeRWS/Hpwa8oYvFtc+51VncfUibOkJBjHvECoPl7na6SVpMFNbB2Lpjiwm960Y+v25uRFCbY0WDoEFd6inrlydPdN6wODTqGHJsokQCzqaYiCRnvXngLOZEJh+ClSGPpRBVfIMUbz9MRe8lk6el3g6uBa0Ev0rKItgd0nM44VtnHrBOMsCEEtg3trNAsfgkL7m7kqIQbG4Tt1WQ5RVEsZMX6O0HKKTuXhwqDlr4WWjVZaM1UQYPp3buLVCIriTv6QBBb2wWte82629YJNsL+AQZsvjS5iqGCmw24hv5u6VfnamojfkMPJEI2tLf0GrKUxtsnsePd5iHUNTAA/n+OgJQarklpoT/+HStYYpbbK6Fg+NL9h91TQEPQd6N/fRv4lhm58LqFD8ycHQIOnb3KLqy2nXphVKYLC0QF6KmnoWtYvAirbqhDOTOB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9222.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(136003)(376002)(396003)(366004)(1800799009)(186009)(451199024)(8936002)(122000001)(66946007)(478600001)(110136005)(76116006)(53546011)(6506007)(64756008)(7696005)(71200400001)(45080400002)(66446008)(54906003)(66556008)(66476007)(38070700005)(38100700002)(316002)(41300700001)(9686003)(8676002)(5660300002)(52536014)(55016003)(2906002)(107886003)(86362001)(83380400001)(7416002)(33656002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RxMc5i2LM1r6eGnefC+xDJZ1PJlMr6dyO7ym/PQajePgqdhdnztcRDdiAEpj?=
 =?us-ascii?Q?gsaBoAiUvsN6DhpHkqO+c6j3T48+AoWYWPnau9/LKSQevM3UBUF7kMvQ4/5j?=
 =?us-ascii?Q?k2R1ze/iHu6nBXqT89+kXoIta7JBA/2DZQVD7ELJHicBlQ7dQNOoLvBeulVF?=
 =?us-ascii?Q?WnPIgWdjGCBcytj6+3cnvlRsuYV2oPwA55kVN2EcOtYfyDjg+zUZd5P0mNMJ?=
 =?us-ascii?Q?RI0huMHRa684TYdA0F2YG0vobYbWyrmwOEgp+t4WULg7S6BSaQA03E4dSoaA?=
 =?us-ascii?Q?FK0Hdsx6ULc9ojRqqVYKdh0RHKkQ+DKhIIin+mMgvwL9D6PD/g2lDns1BzyS?=
 =?us-ascii?Q?8nUhTv+mzQg3360PUzZiSc16WVKMLLqHXVkM2ZkezC1hc2lh+vHJL3Ns/sL8?=
 =?us-ascii?Q?hxLyJmVUteZ8vXBkgSCO3mRDsSlePCcYNa0xZTatktSc5sWRrH27CA3e825w?=
 =?us-ascii?Q?biSm8u+t0MEVaWD2qhU+mTK+/Am5RYScB/vUJL+h+ma4C7Pg2Asv5Ga+nPOy?=
 =?us-ascii?Q?HtTxjZ4h5qT5+PvZ0WmCQC0ZqoBlF+EAGyX7yLo42BhMwPXk7ezSUh8IS7ti?=
 =?us-ascii?Q?jKSHC6rM+IIApnxXK8kYzt3qNXnteCAKAZGXK48skVNPygqp7Z/F3Yhs2rRl?=
 =?us-ascii?Q?RobWyKlBYgV/+hgrV+aauNseVLVtBKndvokoo8UqdbAlLcFm3GBdAMMa41QX?=
 =?us-ascii?Q?WUPmBQTW/wmEunTCcwX8+ikO7/iA+RHuD8NvsV4GZ1e3HHT1/snohjqByQ5N?=
 =?us-ascii?Q?N/9dV8FNylkBKN/7KIyqW9FiVBdes9ADkGPKN48srmBp3qls8TB5EkBSE9/S?=
 =?us-ascii?Q?JexAPOY/cX3qJ/C4VMDjQoPLHW5beC/sXdW4LTTz3uCKGfu52g42WKGmfihk?=
 =?us-ascii?Q?STkJHRNsnvo0dD+P3lhCSFlr9btra3/qaHqn0nYferw6pfXQaEvycLBK0pRd?=
 =?us-ascii?Q?u0p/+P/WXR2FYXw84q00/Hv56iUzD0sGnTwmqVEgymqqjtdRG+QNo0TAiBHq?=
 =?us-ascii?Q?p4RghVmc9Nk+OQHdOIBzk9HHVMfy8rsrlcu7kDVM62i71BJ3/esOF+8B4kh0?=
 =?us-ascii?Q?uAH/M6aS3rUW62HYg/o//ZIizkRI8NiE27LKhVEIJMqT2WLMS+QRl+RiMV6x?=
 =?us-ascii?Q?iEqSPVOsMdUoPtHIUKpHcw7TPdMTVIshxhLsQzSXxl71FrvdugOClH7Tam7m?=
 =?us-ascii?Q?sz674GEwaxekgsjnT86iOuBcffMruuKgu4T8rgGwLI/0ViVTCCmCceZVhaTh?=
 =?us-ascii?Q?YFMFrTLnlEICQ/19PTVPl8IgVUwaJOhQzLQ8ExudaASgrHYfBQk729iVCxhO?=
 =?us-ascii?Q?g4rAuuNCnknUAP7meH7T4FP+OLlZqCNAzzWw2YRYGulEp/FToFqBwI3uJvH2?=
 =?us-ascii?Q?1aSt7JIaemJIgW7Ogkbvtl8xnJc2Sr+Odj5hg4H/A3BON3T5f7bBlmgZSMY0?=
 =?us-ascii?Q?Mk/Rgs70sLqGTQoJsye6df1tP3+Vn5f4hf0bmKLCv9xf8ueQV/Dh3ypJLHJk?=
 =?us-ascii?Q?9YYXE6EPOS1+cb+lGjyb6QOWDfno/sPOWjjGigbkJfeLnf5+IAOxoUKur7Bd?=
 =?us-ascii?Q?dCLDrmRzY2nMm2Jx70Rl4bHC5+Fpl/1ptP9iCet2HGOQvq8MsM9frET/I2pW?=
 =?us-ascii?Q?emI01RLV1+aoFkyl7B1/dAmlMOJEvrWLiunHzSyAQKPV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silicom-usa.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9222.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 840fe917-245f-4bbb-1697-08dba8ddc68f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 22:17:47.5170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LT7qmm477lPb2lFF0qP0UoS4+yliTznHFwHtGEsFJfBFaODo1rZMk6nWfWKqE+j342VPhgfu+Dj+ep3pE8zQrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8293
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Appreciate your feedback. Please see my comments below.

Thanks
Henry

-----Original Message-----
From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
Sent: Monday, August 28, 2023 8:41 PM
To: Henry Shi <henryshi2018@gmail.com>
Cc: hbshi69@hotmail.com; tglx@linutronix.de; mingo@redhat.com; bp@alien8.de=
; dave.hansen@linux.intel.com; x86@kernel.org; hpa@zytor.com; hdegoede@redh=
at.com; markgross@kernel.org; jdelvare@suse.com; linux-kernel@vger.kernel.o=
rg; platform-driver-x86@vger.kernel.org; linux-hwmon@vger.kernel.org; hb_sh=
i2003@yahoo.com; Huibin Shi <henrys@silicom-usa.com>; Wen Wang <wenw@silico=
m-usa.com>
Subject: Re: [PATCH v5] Add Silicom Platform Driver

Caution: This is an external email. Please take care when clicking links or=
 opening attachments.


On Mon, Aug 28, 2023 at 05:26:22PM -0400, Henry Shi wrote:
> The Silicom platform (silicom-platform) Linux driver for Swisscom=20
> Business Box (Swisscom BB) as well as Cordoba family products is a=20
> software solution designed to facilitate the efficient management and=20
> control of devices through the integration of various Linux=20
> frameworks. This platform driver provides seamless support for device=20
> management via the Linux LED framework, GPIO framework, Hardware=20
> Monitoring (HWMON), and device attributes. The Silicom platform=20
> driver's compatibility with these Linux frameworks allows applications=20
> to access and control Cordoba family devices using existing software=20
> that is compatible with these frameworks. This compatibility=20
> simplifies the development process, reduces dependencies on=20
> proprietary solutions, and promotes interoperability with other=20
> Linux-based systems and software.
>
> Signed-off-by: Henry Shi <henryshi2018@gmail.com>

Again, my feedback is only for hwmon code.

[ ... ]

> +
> +static int silicom_fan_control_read(struct device *dev,
> +                                                                     enu=
m hwmon_sensor_types type,
> +                                                                     u32=
 attr, int channel,
> +                                                                    =20
> +long *val)

Excessively long continuation lines.
That seeme to be the case for almost all continuation lines, except where i=
t is too short. I'd suggest to run the patch through checkpatch --strict an=
d fix what it reports.

total: 0 errors, 9 warnings, 18 checks, 1077 lines checked

is really a bit much.

Henry: OK, I will fix those warnings.

[ ... ]

> +
> +     hwmon_dev =3D devm_hwmon_device_register_with_info(&device->dev, na=
me, NULL,
> +                             &silicom_chip_info, NULL);

Did you try to compile this with CONFIG_HWMON=3Dn or with CONFIG_HWMON=3Dm =
and SILICOM_PLATFORM=3Dy ?

Henry: Great question. I did not try that before. When I force "CONFIG_HWMO=
N=3Dm and SILICOM_PLATFORM=3Dy" and compile kernel, the build failed with m=
essage "silicom-platform.c:(.init.text+0x8ff5b): undefined reference to `de=
vm_hwmon_device_register_with_info'". I tried following change in drivers/p=
latform/x86/Kconfig:

config SILICOM_PLATFORM
	tristate "Silicom Edge Networking device support"
	depends on DMI
	select LEDS_CLASS_MULTICOLOR
	select GPIOLIB
	select HWMON  ----> added=20
	help
	  This option enables support for the LEDs/GPIO/etc downstream of the
	  embedded controller on Silicom "Cordoba" hardware and derivatives.

	  If you have a Silicom network appliance, say Y or M here.

After this change, kernel build can be completed. And "CONFIG_HWMON" was ch=
anged to "y" in .config file. Not sure whether there are any other better w=
ays to resolve CONFIG dependence in when adding a new kernel driver.=20




Guenter
