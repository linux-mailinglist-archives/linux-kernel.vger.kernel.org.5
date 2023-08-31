Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9605C78E56E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 06:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244508AbjHaEbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 00:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjHaEbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 00:31:32 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F32C0;
        Wed, 30 Aug 2023 21:31:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VyqO/J9K+kM8tbBesWtnlH/igLWdCsNtpTWHiD0YslAcbn7WYBJi7piTV5R8sV0YbEPD5ZhGdxnMDNJINBeWL8uIFQM5/jnrIA7CqLt//0P/PNmuv9ItzUwMqGCfTD53mkVariMJwKV/Ww1qZjx5e2PYmeupyCMmPkreu5Ls7Y/mwXOrYcMBpmlb3PZjUyRsU6rs/w7RW1HJIXEAQdR4vDEP4GS9hQ4On+U9Oa7Ivk8ZfxiNJDTGTBc51NhStUekhVwObGwmYEEVMJ13zdb2pBW+FgaKvG3eM/VKNJdOGQTpHOCsxz8W3M7pINH0MFlwyD2PO2Q2cYB1ZX5aWFuGpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYvYv/cxYy0zwhbd28u3/7nylhLVQPQl6t1uaOOrTXw=;
 b=l7ShQadRTT4eX7wL9EiqhGhlAKo4o2R/vK9AYv2uQbODB+55AY+Q+Zmc199yeLVHw5B7GlIDZCjMEWh7/lrLpgGC3NKIg/xLG5qijCujb0zFfWbMrMDpeIGjn3F5o1de3LhEcEMl00D1z6TEcR076JKp21yURtkALSUW2larGP/tgAn8Y5f1FSYJb0BeMc1nTq8uKOTP1+LdfPSMNGVWViRzVGz/puf/bmSAZKeXyuzPDjNxpC2JdsD++6YcCYoevQwFUr7BGCNaWpo00gucNDp8B3w8G5mOBwqWn/g5SIwsoBMfBwLCojfnAmg1cVYye89116bDWn44vRll96aZsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYvYv/cxYy0zwhbd28u3/7nylhLVQPQl6t1uaOOrTXw=;
 b=VtQbP6Tca3/iEOwijIUf1h+U2qS9PkFxGuEMphQrQ2VCDzCNWHWehX6csV+tWh2rfBSQ8qwi4AjcIjupD1PPQWNYHQKgMBZLQKefyAMgQScmxQpHlaGF/WPxrIEOkMNoRw39K4QZyP0Q4hmTlNgveB8p2SSD/uvbhfhaHkHDtzHqEk6SX33agxR8gbELPvu5KAW50P+weCBQV+3ZfAR8LiSEO0BrL2X3LkcqHTYxGRB+jbIFo8Uh51YSD6PnxqyaGel4Qb6DTvVOZIK39WNs/FGWKZbET8mGSRv5Gti93DIzT7cIfGPdTKDdaFlbhKZ6SYOhVL1ePn1XSt+KohgrVg==
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by BN9PR12MB5098.namprd12.prod.outlook.com (2603:10b6:408:137::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 04:31:23 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::243b:8750:5259:ed1a]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::243b:8750:5259:ed1a%4]) with mapi id 15.20.6745.015; Thu, 31 Aug 2023
 04:31:23 +0000
From:   Shravan Ramani <shravankr@nvidia.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] EDAC/bluefield_edac: Use ARM SMC for EMI access
Thread-Topic: [PATCH v1] EDAC/bluefield_edac: Use ARM SMC for EMI access
Thread-Index: AQHZ2zCpRf1x7qMn9kqXtDw6ai8vqrACtXWAgAEWLI0=
Date:   Thu, 31 Aug 2023 04:31:23 +0000
Message-ID: <DM4PR12MB5136B7483D9E76625B2BDCA1C0E5A@DM4PR12MB5136.namprd12.prod.outlook.com>
References: <7a67e5fd25664f4c2277283e15b438e826b3c163.1693392576.git.shravankr@nvidia.com>
 <20230830113421.GBZO8pPUILVoBUVlki@fat_crate.local>
In-Reply-To: <20230830113421.GBZO8pPUILVoBUVlki@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5136:EE_|BN9PR12MB5098:EE_
x-ms-office365-filtering-correlation-id: 3b5778cd-e9c0-4b47-4f4a-08dba9db220e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bkSEGk2M2tUM/KQIrQ5ABSEKDKVvtqCgQxNRrJN10nBY9OEnezVA5MbptdMmumHEluyfQmkw9myTLedIhIn+NoCqopPirw9pBTpTV0qq9Bh18Ka2GgpbP+0DuWr1NIIKQDBu00EKbAOLQ9gov2G9GWc/JdWb3CjcvCIvWqQSmDxJUfY/gJLD3OOuQumG7067iJre5UPtXYyPrm+6i4CZZEUHuG52j3JRlXGaSZMp6uHVpzrpEix4cPpMKCpN98c8bQokTfexUjHru1aJV5iFQPigx9MM7WHYADGgB+RhLlUDLp9w9rXK7PiTTioE8N3VbdSoCNPSpXha3ywdmm+yNlBkmOQQW2qx/+3O2wpPhe9djDGOT2J4ITGd/TZ9EsGM2aA9sGos6reQONph5i0Zt4x/hvp/4igjURLe6q6E1RDvtHAP0G3kdqy5QgQuyhN1GLG1nuc4p5AIJR24X8+RLOdDXH6vMZeLz84c/gtxu27+qik54b1HHYqRGBkmvwP4NOYjuhwQW7TDbFydI8HIzkjZXUcdihn+hloLmSXTW31dZvj/5UsohCGaldcsb2+F2lFa7yP7SnTug2Y5ysqDui4OdahI2DzVbYb7FZfbf9FYwjM31NHkCZTL5s5evWRxRy4OeeFQUxvnFIG9Uo9UV7Jw7Zizq8g8KNqfKPwbM0Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5136.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(186009)(451199024)(1800799009)(33656002)(55016003)(83380400001)(4326008)(52536014)(41300700001)(86362001)(5660300002)(8936002)(8676002)(26005)(6506007)(71200400001)(7696005)(9686003)(38070700005)(966005)(91956017)(478600001)(4744005)(122000001)(76116006)(38100700002)(64756008)(2906002)(66946007)(66556008)(66476007)(66446008)(54906003)(6916009)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ydBzgznNk3odgClgrlUhaY4oIL+hiZaZ5vTPQ0Uj7MmEsw104X02CBcZyr?=
 =?iso-8859-1?Q?sXcwP+tRXrZG/6i58qd0W5gAOxIwg0fKKuOxsWuU3wsH2ligr1yDqr2MFx?=
 =?iso-8859-1?Q?BgWl+2SfprIXkuM9wW26NuUcoZ0O2hsek/ugKly0qCCW9Sj9/GrRRfQZH7?=
 =?iso-8859-1?Q?jX5Y3tqNVurmvJfbEW+QToAH4r3B/uCqXDNM6nsyKJ/709V2SN10AGP57M?=
 =?iso-8859-1?Q?DWRQYTYOuKucOKSPdN4YwBCon35riWlt/X1AZW3rnUC4lJ4IVO54xrTqVK?=
 =?iso-8859-1?Q?gZs03ZkDlhJN3X/WBmVNuYjuultNRX1xWaukl1zn66GHjM+Bw4Y+WVRbeB?=
 =?iso-8859-1?Q?moTHlFWGsPAlonUNutgBsghbcmbMB+Wqq5E0/EkvrCBoujnNTPYu85dNKA?=
 =?iso-8859-1?Q?YqJwUGSw1pAIdnIN2F8q04ibAvMEFd5RNAAAHMCjnsNSvFtl8fKv9qdBoB?=
 =?iso-8859-1?Q?0Zc4JoX2IKehG5OBKf1+6hGzY4GIV2Fy3VWcGv0VkEBvSY/N/iRTCuCm6c?=
 =?iso-8859-1?Q?havv851P4p27ledshSqwR/zT/88DZjazPH+jG1BtpF8LL8UrSI1MDiGE7m?=
 =?iso-8859-1?Q?HEPideoNVa75/n3OquEYgz4vY819u/y/0IGwMzJTigjU2mMQZDmJ+ASlk9?=
 =?iso-8859-1?Q?F+gKpKKPSRTyWcrIvkSVdRFGgA20dM3nuG4iVmXuxTYg7C01no4DYlo1gx?=
 =?iso-8859-1?Q?GyEwt6jh8cFWSYZJ6kIj2QsAuxIRVNHMl2BvukpadQU2oCuxWQFHnqqNr9?=
 =?iso-8859-1?Q?1dTxByk/S1g685z0yohkRiRozOsHbOiI7393V8RqAEY0TXWCpt2vm59jZW?=
 =?iso-8859-1?Q?MkX6LyS5bhN+6FnkR0jg2gmRJj/TdVcOeHuh9h1kTYjWDiLxKXmo9uXwfu?=
 =?iso-8859-1?Q?7R0TO+JO9g1EoD47/mSixdMJn2MU1aIaxNGkfpPW0H1186ozzk8oumA94D?=
 =?iso-8859-1?Q?v0yyMKRyl9vMfFp9XVRPNw8STwUnNaKFSctcd8O8Bz+xI5uJ0QYB1JWdp+?=
 =?iso-8859-1?Q?hcjKNzGO0LQ7NfS+C0qRmEYiv1fYURGMpC+f1lOM7HyOW9+T6FS2lxyHSi?=
 =?iso-8859-1?Q?NYkLpV30P2s3eGEeh0n3jbA/CxYyW2fN2DpDLh1C6P5LPxoHSfAxMiRwvY?=
 =?iso-8859-1?Q?nZFTI295KIhpI9dTRI+IZLymnbTPI7aBlJFkJluCjoBEnsn1iDeyxguZH/?=
 =?iso-8859-1?Q?iYD4Ya//yZ+yAFfvQarQgMSaYbcrUH06lNe8Z2QINQ7G/oFhL5Pd8FMNw5?=
 =?iso-8859-1?Q?4C7oy3YlxUbVMvlhrto1TcS751a0FS6WC1zi+3Tk1B3S8vCYcsjs95MQLO?=
 =?iso-8859-1?Q?5oyHqH1Sm8/9mBVl3pv8GCAMlmdSh39s3OMs0prDXfHWMh6xD2lL8c1Rjq?=
 =?iso-8859-1?Q?7gi8XVduwq0DqltrHormlQTYvl99uowPgtwoIQ10o0AsYf4Id9Orf+Hghp?=
 =?iso-8859-1?Q?gm35IccmW8nHk6Ms0wKeejiJMGLCPWYcK6FHOBxASRG16hc+ZE+0HARaJl?=
 =?iso-8859-1?Q?AJUh3PsEaOuZSEnz9fyUuZYo+8GcsyM2btVKjKq2mQFWpXJhz7oNSioSLq?=
 =?iso-8859-1?Q?SJHTxC5ubh80k4ePPqPDEGpAeD568AUQbv8Dgla4mfdkq3Xze+vetzCPOH?=
 =?iso-8859-1?Q?CDNeMsT7yT9l+oJpntOciYmeQV8OvTmNxU?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b5778cd-e9c0-4b47-4f4a-08dba9db220e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 04:31:23.6793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: duPpAtNPtJhfqIBsyX8Xf54ssN5rzyHxoHFd/U0GqAlErc8wHyWnh/ItiWZqrHDbw9V70Wk3Ibnin0DgMMnWuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5098
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Add secure read/write calls (arm_smccc_smc) to bluefield_edac.=0A=
>> The ACPI table entry decides whether SMC is need for accessing=0A=
>=0A=
> SMC? Self-Modifying Code?=0A=
=0A=
SMC stands for Secure Monitor Call. ARM documentation can be found=0A=
here: https://developer.arm.com/documentation/den0028/latest/=0A=
=0A=
SMC is needed by the driver to access certain HW blocks/registers which=0A=
can be accessed only from secure state. Whether a certain block requires=0A=
these secure calls or not is encoded in the ACPI table entry and passed=0A=
on to the driver.=0A=
=0A=
>=0A=
>> +static int edac_readl(void __iomem *addr, uint32_t *result,=0A=
>=0A=
> No "edac_" previxes to driver-local functions. They belong to the EDAC=0A=
> subsystem.=0A=
=0A=
Ack, will change the prefixes in v2.=0A=
=0A=
Thanks,=0A=
Shravan=
