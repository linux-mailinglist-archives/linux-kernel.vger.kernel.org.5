Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A04578103A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378594AbjHRQXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378613AbjHRQWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:22:38 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04EA30F1;
        Fri, 18 Aug 2023 09:22:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfqbhJYcO2cnY2nkCucOVe5UYEy+gKr3wPBfxizG9nVR8OYoVOzoBvkN6qX68QsotL395VMADxO5RMqM3EVTFSLAT+RZJqyMzHit+WZX2hyeikfl5JBTrD4KM6DL6pSQyYh1JlD8E4/eLjiRmSiuP1tnDq8BMKXjdoRDPdyOoz7F+IQV3JjIVu9CRKPTONXMtVW1tx2uNHRaq9I0GCJmCyb3t8s+Iqj1m0QXj204KUauh0B8DbREa7DR5INqpRfLt2ZeRIKhXvksdP/CFyCD+eflW1NRY6adeTn0X9WRO4GnVlbKG0u9hlapt60UFf+J6AKur/skNrG6pSm+1ssKGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNrhzVQlwY9xjcGczycK0aP7PMZE4c70Ht1ss8Avv2Y=;
 b=RO5Qk5SVTzEwcYQuMZ2fXAhf/SZCO+8fLxM3ET7wzpp/ev6KY/6sFcMy/8qO1Yg/fqjcUuBwVWzD8wCFw53K+AdqpwDotRORbAjk3A4nt3pb1oyDhxpepbs2/AN0mnHtIpHGFK0mLdyK8jQqV9dstNosN2/dKsSbG5QF9pZLDCZFK05byJCDTgOhh3E3aosesv1BB8qANXOmcMbHqe/WJdn415T+h0iNkkvC+0twYEIZVfilC3pr8mf3/njKu1MVwpaPodIgZplM6msbG+U3ogm8zgFzgLtuEzWszAWPdEnmkIYnqhSZQZkQTNazcyN/jpYDCGx7Skit6Fw+mqka7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNrhzVQlwY9xjcGczycK0aP7PMZE4c70Ht1ss8Avv2Y=;
 b=B/LanWm4/tD33LRV2UKss1dKJNlBlXpi37bNJ0SbzBGFDEbL3HCkv5gd6WtCWsrwnJVRoX24aOfNkW9mpOAvrMoBVuY0pu9alkkzWzYHpkW2Ds9x+c0NUj8K+CSxwMl5MSCs08UlpsM5t1KazUwazfXs9jwTir6/jjtH87vesyhlMFzKR8Bkjkeqyq7IIss5DRP7S+koanyMnmgMeFEZUkXXnC1uHVJ0Yf5IiC7eiUDyedzZfubpc5RHD2rHN3ELoiyAB6v+ie1Uz39PS6HwlLxQC4SRWhfxyYsKY6+98CBRwtGGdy3T7tcK1KK7WK7WAqWnwZ2PTf7phIZU2Mj8NQ==
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 by IA1PR12MB8358.namprd12.prod.outlook.com (2603:10b6:208:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 16:22:30 +0000
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::9e01:4d19:224d:219]) by SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::9e01:4d19:224d:219%7]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 16:22:30 +0000
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     Will Deacon <will@kernel.org>
CC:     "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        Richard Wiley <rwiley@nvidia.com>,
        Eric Funsten <efunsten@nvidia.com>
Subject: RE: [PATCH v5] perf: arm_cspmu: Separate Arm and vendor module
Thread-Topic: [PATCH v5] perf: arm_cspmu: Separate Arm and vendor module
Thread-Index: AQHZry4xzcjbD21RhUuAD3F0nYoHCq/wfUkAgAAALoCAAAOWkA==
Date:   Fri, 18 Aug 2023 16:22:30 +0000
Message-ID: <SJ0PR12MB5676F8FC98DBA22EC462C1A8A01BA@SJ0PR12MB5676.namprd12.prod.outlook.com>
References: <20230705104745.52255-1-bwicaksono@nvidia.com>
 <20230818160536.GA16119@willie-the-truck>
 <20230818160614.GB16119@willie-the-truck>
In-Reply-To: <20230818160614.GB16119@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB5676:EE_|IA1PR12MB8358:EE_
x-ms-office365-filtering-correlation-id: b29e4b27-d4e9-4f4b-3dee-08dba0075201
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EEhSN+SCwsARfliJzCzerIp7id7RTWZ3fAL7QToqxmTyzL8Er3VH1dGB72bYHjjoJxyPQGVw6H9FsKNG6oDTTZYP2u2dp4Uj54OD/ANW4CTNOeSc8N7IPgfNxxcBwrP8uCUNAd+dxkiasjC+fRo8RNtdiPVSZQOl/zq0ymJh5mFenQTwwlOn6boAPaUyoSzRlSn/UzuT5pSaHqsp5CME38TOg3HnCFNF+5myJpUQD1iOsBAazOaMzaqOm36ueygivorPy0ur9QpODnrz5b9Z0WtByqxsMVZXRxGRvNMYTfWwj1yjVUCeXT5DuAAMYChIv0D+J/aGa845I429fEVKesxvVNwqfSk5fhF51+nbf6KIU8XRYTawMVWb9Dcqua/WToRS5MdUgBhyedP5y9fUP0MtR5gkd51F5VpPF5LQ+dAep0sNsKvvUOlPlq2c/G2lwwfphERD+/TaxpSJ2quwadio9GBEaE8erzzpf0Uz5lUhiMu+UlT3FoPak1MtjTRkKsL6p5/ESL9B1Oh6DSOPZcKFnaUn2sxI0325OvgGWa/NenAyn/57IA7kZbCs0KTioThq5YoH4rjcWtk1AHwzCOeSBU/3NIDutGG2G0D5kW9AJJPosnplTtUCA6FOpJrKqIovewoFqLh0TrnyV6R3aIn/hwsMKAN9YsDd41ydTts=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5676.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(396003)(39860400002)(186009)(1800799009)(451199024)(71200400001)(7696005)(6506007)(38070700005)(38100700002)(9686003)(122000001)(53546011)(86362001)(107886003)(55016003)(26005)(83380400001)(33656002)(2906002)(54906003)(64756008)(66476007)(66446008)(66556008)(316002)(6916009)(66946007)(41300700001)(76116006)(5660300002)(8676002)(4326008)(52536014)(8936002)(478600001)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MrNeLiOx/y6zEBTMvuiKhLW6JIBBl81Gk8BxmLMDw02mRcy63KsRC05S6BcL?=
 =?us-ascii?Q?+R/6MCfumxhhRSlpSJ1qMxqSaCrilUB3ZUz/PR2CGUwXa9qtFEctGQyXGwMd?=
 =?us-ascii?Q?VrKnqwhYDD0hfmBfWrbtDb/cD3wxO3B+YTCVCxDTZ4n7qO+T+8g0NL0LDS49?=
 =?us-ascii?Q?24kYaqqI2Sp0FG7tRrQsatU+5fI8hONA5z9XKKU7dgkTMJmbt7TKm+0WTRtr?=
 =?us-ascii?Q?/X7/P3KC2ii8aeU+imVT6Xu79ErQGhoj52Gc9nkAFonFNGbAXL/lGo/5TtJB?=
 =?us-ascii?Q?z6JfYknNcCX+nWb6U9sNtIwlLwP16u8PvpJgTlQKqK+mlYiTqU+2c8Uj1xdG?=
 =?us-ascii?Q?hup1TIeGC1cJgOHcWxrW1sr8xBurINsact8AdDB/uWshkBz1QgWteLeLEQPS?=
 =?us-ascii?Q?axasQTcdyGDI20Q9/Wf4/qsfTqHP5VhFkUGD1FvymXVJrxwPlqoA2H68ESzn?=
 =?us-ascii?Q?pIeprkGf0PvKFOJUdLPKSqIXYpXEan9u5IlmoRsVg/DO7W56o7N/09+XcOWx?=
 =?us-ascii?Q?q8igotzkirQtR9yZScXhiiurMRUFESGDnCO9+GjEnjqYXEsbSU5iPS/MzV14?=
 =?us-ascii?Q?54xBnLyfos2tZNRVP9YnDrWYj0USYbXcDXB9k/yp+ObRjWV0gsV1Dh2WqpPx?=
 =?us-ascii?Q?hMNbJtDmotPm2vXrJ77eNuGE9NA+QJIzTjHk6S7umZTTCeh1317ONJiDZlrC?=
 =?us-ascii?Q?xwfCo7usYzFyKvpgrjCV1zkxi3MV97Za3AQkcO48lmgfHYvnAFV8BG+Gf5Fh?=
 =?us-ascii?Q?Olz7e4rv20Tmo3RePzW0KZs9IL/OUVBDsXHSl72eBVeNgefQBeoQjKRRv5pI?=
 =?us-ascii?Q?DFXSLudON+TM0SwbkVczKin+g1qtZ9oVRdrmKE/CmuKRyab7XvBfKb2IcDuk?=
 =?us-ascii?Q?HSb0Zpa/FHo68+N4xu7nfJ9+yawzXBjgWdZf33FPklDkGFDMzPwoStAHgrXQ?=
 =?us-ascii?Q?HYnkXfpWZHgRMAgFPAGpyM9NHDr73zFCofTOIabBQ5qLV6g8p7Mfvnp66ZOk?=
 =?us-ascii?Q?3BHo9LefaNkqXJQsQo5OIjFTqaovLLhNHKVq3xvOFYx7SkLI2VH0rC2iTPUj?=
 =?us-ascii?Q?5lWXDtLdaaL6ZfYrF7/huGqLMCgZVPcPMeAUUprHMV6KBo9Eq+DsI0sl7fTT?=
 =?us-ascii?Q?MYdEzwdLSDIz2IJobD6Nnj7I11576kUk0+lfrMdjxzJuiWghlV5SRkk/5uC1?=
 =?us-ascii?Q?nZs5Qd8GHE/FUITt3naMvVagxyN7nbhJpW3fohW49syeqajtsFRWzO+n3NRr?=
 =?us-ascii?Q?C/nyT9IE/N3n4Te4SioI4jfjjKGuOZXmo401d8nLOAJQC4bVgGuVCAJME785?=
 =?us-ascii?Q?omawbrFhqM45bGEG76YC61JvmxKN9MtM6nyTP0bWK/9cQEPGeMh1jJrqL3Hi?=
 =?us-ascii?Q?ZToCzgV383irnxPO8eM8ks1dHXTn0nEzlW0SMYAao84uquKwSJ8r6pfR+YgT?=
 =?us-ascii?Q?FukVqUld5jBmn4oMdkQzk9NVEoiqmIoSSTUOgXXWXhI7esasgyfqvjf6h9uy?=
 =?us-ascii?Q?0auUEKe9WKNBEvPCCKT1d/ujmJDhawfZzRlsB4IX3X7fWdL52bErwlPujcHQ?=
 =?us-ascii?Q?XVlYy9GYlA0jTMQTWw3+MhtzEmDCM1fGxihj9ub8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b29e4b27-d4e9-4f4b-3dee-08dba0075201
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 16:22:30.3856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /CDliKDxXgWASCpb44022GvyxvXTSHpHCIX8NLL5otKLfjw7m1G2o8OR1FDVPHgROZQqV+yFQeRpYecc410z5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8358
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,


> -----Original Message-----
> From: Will Deacon <will@kernel.org>
> Sent: Friday, August 18, 2023 11:06 AM
> To: Besar Wicaksono <bwicaksono@nvidia.com>
> Cc: suzuki.poulose@arm.com; robin.murphy@arm.com;
> ilkka@os.amperecomputing.com; catalin.marinas@arm.com;
> mark.rutland@arm.com; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; linux-tegra@vger.kernel.org; Thierry Reding
> <treding@nvidia.com>; Jonathan Hunter <jonathanh@nvidia.com>; Vikram
> Sethi <vsethi@nvidia.com>; Richard Wiley <rwiley@nvidia.com>; Eric Funste=
n
> <efunsten@nvidia.com>
> Subject: Re: [PATCH v5] perf: arm_cspmu: Separate Arm and vendor module
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Fri, Aug 18, 2023 at 05:05:36PM +0100, Will Deacon wrote:
> > On Wed, Jul 05, 2023 at 05:47:45AM -0500, Besar Wicaksono wrote:
> > > Arm Coresight PMU driver consists of main standard code and
> > > vendor backend code. Both are currently built as a single module.
> > > This patch adds vendor registration API to separate the two to
> > > keep things modular. The main driver requests each known backend
> > > module during initialization and defer device binding process.
> > > The backend module then registers an init callback to the main
> > > driver and continue the device driver binding process.
> > >
> > > Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
> > > ---
> > >
> > > Changes from v4:
> > >  * Fix warning reported by kernel test robot
> > > v4: https://lore.kernel.org/linux-arm-kernel/20230620041438.32514-1-
> bwicaksono@nvidia.com/T/#u
> >
> > Do you plan to send a v5 addressing Suzuki's comments? This series is
> > blocking the Ampere work from Ilkka.
>=20
> s/v5/v6/ !
>=20

Sorry for the delay.
I will send a follow up patch soon.

Regards,
Besar
