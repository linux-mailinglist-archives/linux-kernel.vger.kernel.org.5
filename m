Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804887B57AA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238428AbjJBQKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238418AbjJBQKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:10:32 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4478E;
        Mon,  2 Oct 2023 09:10:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzuE8QNw/UddlZpup3//FJfr1qH4kLGVlVYBU849yPXnQoWmrm9Li7omAKIM1cAcupImXGxCnbjm85VceZwGr46FXRhOUl6qHihojXCHFFwX12hJllyJ0fPtE50VT0cKj1cDsBo2+9WZ4/Aq7+S9ziMht/qssDod0208KTdQ2YsgjOG4PcnG2JYt1Nao0l/Fjkyq95RB3UdlBsfclFauLNLl7hOwxJJe5E23BVTQWTFwLlAqKE0JVnMVhobTFoOEB3dLd2fo7CDyUkkdt0STSPMmtsECyDsf8FL1ePrB6zNQMtTOeDqlwNB76y0k1+TxaM7nC822rBgXweSyAkVMVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRzYjJzFkmQVsb3qKgarOaomzEeDacqXRxlkfwKncc8=;
 b=X5KuamVOl69V+JQYtjGRxfNRZoJHhRf1k3ljBJZ8f+SSQsuzqNpcE/Z/tBk9gl4k4kGCgKON+DmiWRMUwy/LBx853I7HsjZDI3LvZxgrfinGNHaeWsDAUNMcrhgwDUxh/4/6DeW54TGaVMr5iesuJYE7r2lVmiliTIDjKrMOR3YMiqsNH7vGAO5F/5H0BFWCqJfyGC/HKgwkQbdoUX6URjjqv1vpknCOCpTLrcL8lVmEy//Wx3B1caszUZt1DnhHcf7cS1UzXo0m/DqRqESDDEDNRF8ZUl2uQCHVf7IEX+Rdz0UI/Pe+T/dh56glfBv+MQ1PHAesPyqZj70o3ab5qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRzYjJzFkmQVsb3qKgarOaomzEeDacqXRxlkfwKncc8=;
 b=Ye9fPzPD87uW0dmjwBGqocZeDHBwum5fOtaXx93aNPjpkKJHh2RY0gbRFoclXLF2jAtQ/ei1WR3BJ/3c1ZmTt8lYavvr5m5omDlXlhLVwdZXk/qa9O5PtqIpz+2Z5vmq0RCfNf/+f3WWEBj3z87q34xhGFPhaAUCDi7n59yiD2KAQjVUoHLzNZDUvyFIy/ywlSsmnfd35eoVJZuKRWHqsVWTq2Jr0fUmzPBORJjO55xGvNmcMH5oEBrtzzZ1X6PlK64HTS0IqKGNPACceFEScV16WJqSGp7Ll20OjpnB8Ay93Lpx+Sg8Z90vjoZBqcJo0y4z8NDc3Np13AvBapHumg==
Received: from DM6PR12MB3371.namprd12.prod.outlook.com (2603:10b6:5:116::27)
 by DS0PR12MB7825.namprd12.prod.outlook.com (2603:10b6:8:14d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Mon, 2 Oct
 2023 16:10:27 +0000
Received: from DM6PR12MB3371.namprd12.prod.outlook.com
 ([fe80::ed2:99a4:2e77:89bc]) by DM6PR12MB3371.namprd12.prod.outlook.com
 ([fe80::ed2:99a4:2e77:89bc%5]) with mapi id 15.20.6768.029; Mon, 2 Oct 2023
 16:10:26 +0000
From:   Jeshua Smith <jeshuas@nvidia.com>
To:     "Luck, Tony" <tony.luck@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gpiccoli@igalia.com" <gpiccoli@igalia.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: RE: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices
Thread-Topic: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices
Thread-Index: AQHZtREytrmSwIEvT06Ibqr95x6guq/abXNggAAKnoCAAI5FkIAVd3TwgCWuaxCAIP94MA==
Date:   Mon, 2 Oct 2023 16:10:26 +0000
Message-ID: <DM6PR12MB3371083F4E6BCE4A8D2389E7DBC5A@DM6PR12MB3371.namprd12.prod.outlook.com>
References: <20230712223448.145079-1-jeshuas@nvidia.com>
 <DM6PR12MB3371BA50E3B76D2266273901DB09A@DM6PR12MB3371.namprd12.prod.outlook.com>
 <SJ1PR11MB6083426D3C663F47E707CF1AFC09A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <DM6PR12MB3371D86F80417641B8479B28DB0EA@DM6PR12MB3371.namprd12.prod.outlook.com>
 <DM6PR12MB3371FA3AEEA4D17D94C889D5DB1BA@DM6PR12MB3371.namprd12.prod.outlook.com>
 <DM6PR12MB337153EE2DDDB427096446F0DBF2A@DM6PR12MB3371.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB337153EE2DDDB427096446F0DBF2A@DM6PR12MB3371.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3371:EE_|DS0PR12MB7825:EE_
x-ms-office365-filtering-correlation-id: f4214681-1543-4a81-996e-08dbc3621747
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O3T1hrl/aDdo7uJw3770Be2nvdZ6mlpJ8IBLpRKiep9jSM3dOfbDQejtichh9iovm0Hwj1FdpiCglUZivPm4z1lPEHcXQJaA7b65Am4Un1GfW38b/wmbb+Q3yDhLb2WLHKUBA7ww0JDyXTjYV00YwtQLsx957qs48B1Fp5TWj5h6Rou2VHTjCAeVzgdsSKWANdc1y5J3dGB257R3jNgHMr7fV6YiGv1J9/yIIDA2E9OC5k//URgs5Wz+So3wqTT5UmjUP79RqyxTCmLgNfyULKyg0JmQX6J4v94kggtr1HfJFPTHMEBMEx0CtLeek1l9qQmWRBGiFEz49+v96v6wuc+GCc/N5OUSMX4+xiOB84Ck4McucHIrcbwC7zzevdxfx4rUswHVFxO8rAOiBSSTarbwsFf8k5EZJUty4Zno6lAlYUDbC0n2qZwvf7h3oUovyPS649LYRZuG0UBa8LxJVE0EdD95P/nnQeof531O0Q40SwCeCnfe2AWZmpHKOCo+jeqJj8ajnYIhW+FGQhgl2ImCqSNG2IaxrpmwWAYMqdrosIP5xNzxWgBSG+w4NIEdW8dZjuRf4ufiIKf/kxkT45R2PlHQKDB2E0ao3nJt7SFteAb1GwFEg3h8TFQbuyPm1xzoQnI5ry0TRMuYsMHyxKizN4ye+GhL8ebpVPBG9UQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3371.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(966005)(478600001)(86362001)(107886003)(26005)(9686003)(122000001)(38070700005)(38100700002)(83380400001)(33656002)(55016003)(71200400001)(66446008)(6506007)(7696005)(53546011)(110136005)(316002)(7416002)(76116006)(64756008)(54906003)(66946007)(66556008)(5660300002)(66476007)(41300700001)(8936002)(8676002)(4326008)(52536014)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9cWxQx/F/2utvFUc/MzaR6JM9UU9VM+BRnG3ub9F6LXj3FyRH2V34YL9ZGjO?=
 =?us-ascii?Q?2RRcV18gv+LVUgyhiUdIi5WBd1Ez8unVrDHwpHXAmiSmZhN42XxSqtNbwKfs?=
 =?us-ascii?Q?GercaxKvtNh3ijBxsyEa4iGPijrgzUhQMzeCbIpal8fDMUlTfPCS86RQwtj5?=
 =?us-ascii?Q?6GHfdkD3ECgSCtHOTtsCthwR3W+qP/uzcX2Pg1+Mo0ceKo1LBVky2aqsWpa5?=
 =?us-ascii?Q?xb1xkh5Tb5uy17aRTzQIO6czQeJ97/JdDHeB/Q7O3IhWiT9KumM+TYAShjrN?=
 =?us-ascii?Q?7pID9U2tiRB8Nc4bWzh8Y0Hp3By0c9rPhoAixgqT5UETzJL2GEg3iRJ6ceLt?=
 =?us-ascii?Q?mc3i7t2VQyhAtkuNw3X45w+o+pR1hCfQsOTAZzvc4RpbUdqzXL3CNrqqZVgU?=
 =?us-ascii?Q?tKSXH3Ovx4Qzw3OOjcOSKWyQzv19LPtAQPYLois082RiE6JP5s2t9pp+l55G?=
 =?us-ascii?Q?adujstbuffHvz1ubV1xZjqTBefqyW33dXIDOeni0sWYHituWlPwcpJWDHlKK?=
 =?us-ascii?Q?5vODWhaMHAxR1CzAG1MYapeIo1Q6jMHK7SM0clkRlxN2cGMh1GCcy+pcZD+l?=
 =?us-ascii?Q?ODZmA1UQF72sI9B9o+n2D4Do6E8wbVRghgEQkP6grA63WKitkSRspGA/w1mN?=
 =?us-ascii?Q?RgqRQMSX45RjnGR8GpmXTryKlS//E8FfQQZH+q5WmIA0PchJTVZvViYX1kw8?=
 =?us-ascii?Q?T35BceGD1dfDPgOcNil6+9JLimegDEP167I76v5zP6+WhnHQCiD/Loi+E0yC?=
 =?us-ascii?Q?TWm62a5BEg6L0EgFozDrVMNd70GU1crqCqWJUwcRK6wX2OTD2GOW6kYZgUhP?=
 =?us-ascii?Q?QIdM+WYzeud1pN2D/bmk6paM7fAIT3tgTRLDcrHvGFFFXpmwHr0lSwQemnG9?=
 =?us-ascii?Q?X3MghThSW9tmJg+p2YCofSs1N/QSaPecp88qkrcDV1CTn89T+BHsDxOVt/ew?=
 =?us-ascii?Q?x4xcxOusfywmOIdiia0+uyQvL3gxey+C8IKkl9EvEZI/Wff0NrO1ufcjqk9I?=
 =?us-ascii?Q?IQqGFgbapBw+zrWv4bSXoNXTKv0K20Q6amuW2SlDZCJsqxFBvFWFdEMsB0Bk?=
 =?us-ascii?Q?6A2kUxIM/M0A5uyHFEh8MGode63s7Gosc+vtJsB2Y7TudzciHjLhajvIbelp?=
 =?us-ascii?Q?8YlXce0crVuBvgFajdy220/m+DwiQyXEXKt5pkFXu8BDq9yaMxdzstdYIQaV?=
 =?us-ascii?Q?8NdK34OEm1To/nRjZp3SMfNOU3CyNUDER6hqJ52MMm7ZbcahJQ52Xw8wbaz0?=
 =?us-ascii?Q?oiZcIHWcgUSmHrdZBCbUCX9sNTB98zXG0fBUsyo56FmAqes9VapA3zWXBg+q?=
 =?us-ascii?Q?zcN1If+UjStx/7gmSg41TaK/AnZh0zP936wUe8c53GrGRDGBDaTAZYsD5tKb?=
 =?us-ascii?Q?nzp+kIrE1h5Os6XJsamOF2Ne+u/NSxPzp2qhLYZPp3AIQZGSXYqmOOStkYRl?=
 =?us-ascii?Q?03/pvE8y/poKqKJVMb0n8j038yD7kJ5Gc80CzYLRL75rcsh6y5+AhKSit9hE?=
 =?us-ascii?Q?LjE1QjAEnctJkBR/JggvfzrIUB06tCOg48HRR6XisLsoUTYkr/h00NA2IrLz?=
 =?us-ascii?Q?UWrw1DDC0wY3HHqHMFtjjy1Rr0xqY/XcMzw3T3X3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3371.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4214681-1543-4a81-996e-08dbc3621747
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 16:10:26.7301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CHlhrTWLmn8JwyOqQMACyXdEJl5LfgHqlQnDL3pazPgjKnaUkk20eZZK4DdLuYl7EIGRx8uRqFxd7lTdnWyIug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7825
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending due to lack of responses.

-----Original Message-----
From: Jeshua Smith=20
Sent: Monday, September 11, 2023 10:16 AM
To: Luck, Tony <tony.luck@intel.com>; keescook@chromium.org; gpiccoli@igali=
a.com; rafael@kernel.org; lenb@kernel.org; james.morse@arm.com; bp@alien8.d=
e
Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-hardeni=
ng@vger.kernel.org; linux-tegra@vger.kernel.org; Thierry Reding <treding@nv=
idia.com>; Jonathan Hunter <jonathanh@nvidia.com>
Subject: RE: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices

Any further questions? Anything else holding up this patch?

-----Original Message-----
From: Jeshua Smith <jeshuas@nvidia.com>=20
Sent: Friday, August 4, 2023 7:05 PM
To: Luck, Tony <tony.luck@intel.com>; keescook@chromium.org; gpiccoli@igali=
a.com; rafael@kernel.org; lenb@kernel.org; james.morse@arm.com; bp@alien8.d=
e
Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-hardeni=
ng@vger.kernel.org; linux-tegra@vger.kernel.org; Thierry Reding <treding@nv=
idia.com>; Jonathan Hunter <jonathanh@nvidia.com>
Subject: RE: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices

Thanks for the reply.

It's not very easy to see. It's just a bit down from the link you sent. It'=
s the last possible action in the Serialization Actions table:
https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#serializa=
tion-actions

18.5.1.1. Serialization Actions

GET_EXECUTE-_OPERATION_TIMINGS

Returns an encoded QWORD:
[63:32] value in microseconds that the platform expects would be the maximu=
m amount of time it will take to process and complete an EXECUTE_OPERATION.
[31:0] value in microseconds that the platform expects would be the nominal=
 amount of time it will take to process and complete an EXECUTE_OPERATION.

-----Original Message-----
From: Luck, Tony <tony.luck@intel.com>=20
Sent: Friday, August 4, 2023 10:31 AM
To: Jeshua Smith <jeshuas@nvidia.com>; keescook@chromium.org; gpiccoli@igal=
ia.com; rafael@kernel.org; lenb@kernel.org; james.morse@arm.com; bp@alien8.=
de
Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-hardeni=
ng@vger.kernel.org; linux-tegra@vger.kernel.org; Thierry Reding <treding@nv=
idia.com>; Jonathan Hunter <jonathanh@nvidia.com>
Subject: RE: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices

External email: Use caution opening links or attachments


> Can the maintainers please respond to my patch?

Can you give a reference to the ACPI spec where this timing information is =
documented? I'm looking at ACPI 6.5 and don't see anything about this.

https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#error-ser=
ialization

-Tony
