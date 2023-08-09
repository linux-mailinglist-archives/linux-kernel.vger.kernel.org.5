Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACA27764C2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjHIQN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHIQN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:13:27 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C40BC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 09:13:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1HoFJpV7twRF51wvrNxypLb9UJnv3kkvbb+2CYn0E3+u7jd6dw4YCpCGy8Osr9Y5KDFKdSJZAcJY3H+zdTTUmH0bQmbPfBMfOLMyD7fA8Ir91xwb+Jz9PcOQjeT5vYPMLFPry8hS6nxqVXMS3BW/OTGojG7ukRwUn/L+c48/AHwjGAAERYcI2yEkexeEbZbitoQh0FEBahObXL8PxnAXe4BNuY6a4CxTR0Oxt1joWy4hItzZpvsgIQfr7ngofOc6wGfGrjuxavnovDbPozge4rwvCFHvxCL3Wy7qaLJ8mpQapMhzWUj3fbgXXInoZFXVDsuBDIIYHoRV63jZwh7GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+c5M1GBaTAFJcc1JDbIdSiilB4W2v/bnc/la3RqsoM=;
 b=EwVZBdwprTtECWnwGQBItizHvFyOlvtASEojVowRzAQHEinWTGqlVrTEwdNe9oxEieGuHGipJUcg1MsnKu78f3BRiSt+PlFpAkmvKChhpLzsx372vwhxgWFWRwf/+9M5NZtuui6KLzBrT9Vlxh8OHwniZDQ+eVk1YR6qwNQVLZ0UaYatAzfFccJtF7GXDO72lDNicjNEgd+Go+FjP000DScYhtodUSMo2n0RuCO4MKbes90F4m29lQp9cWONVk36Z9w6AVZT1cvevtCk2oRZFV7GQ74BdQreob5ArKYlNfb83LciMc1TflZx0TbjhcqE47EQUWWPGJG+NQhLP6tYkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+c5M1GBaTAFJcc1JDbIdSiilB4W2v/bnc/la3RqsoM=;
 b=AaTGRlKbeqQqLjQF+8iKlfH2ZgJNYxZ5ixGWwpH4upqob0ZdElS/rFCd6ukDkVuVwwn2FzcTZSR73abz6hjTYt+iKvlfSpdHgsMjYpkE5YYuCRd9A/zC93QQCFSck+IUAJ0cZv6HD57f8stsiC9HnONUPnwGOjoAQONSUbgwftM7TO/FoPWDmXSQQ7V774PnkKGIsV8XimnmRUtgU+HMmS/BKbLC32wI/pK5+8949vKSXFlLX+jV/JAUVkB4JKZ89i+tXluwXeh9SMTUbfAS1ukEsQjNALtRk29ucAKdFDUvi6JaF4MAyGErveUT5NL0MGJH5nwzBbaG9YhgQSV6Og==
Received: from MN2PR12MB3902.namprd12.prod.outlook.com (2603:10b6:208:169::23)
 by CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 16:13:23 +0000
Received: from MN2PR12MB3902.namprd12.prod.outlook.com
 ([fe80::149d:ff18:9f37:af72]) by MN2PR12MB3902.namprd12.prod.outlook.com
 ([fe80::149d:ff18:9f37:af72%7]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 16:13:23 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Vadim Pasternak <vadimp@nvidia.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/2] mlxbf-bootctl: Support the large icmc write/read
Thread-Topic: [PATCH v1 1/2] mlxbf-bootctl: Support the large icmc write/read
Thread-Index: AQHZysv0JhhUdbnH7EimkizeivEMTK/iB3SAgAAbixA=
Date:   Wed, 9 Aug 2023 16:13:23 +0000
Message-ID: <MN2PR12MB39020C538F982DB0B1F0434CD712A@MN2PR12MB3902.namprd12.prod.outlook.com>
References: <20230809141513.9058-1-asmaa@nvidia.com>
 <20230809141513.9058-2-asmaa@nvidia.com>
 <BN9PR12MB5381D4AB689C24165F3EE3A3AF12A@BN9PR12MB5381.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5381D4AB689C24165F3EE3A3AF12A@BN9PR12MB5381.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB3902:EE_|CH3PR12MB7763:EE_
x-ms-office365-filtering-correlation-id: 4f8010fe-903e-4aaf-58b0-08db98f38e6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1gN3eXa+8DurOTCfxrUVP2AkiyxiXgDfQs8QpBNHd8eTxZjbpapC0ZLgWsNaUGs2sU9dt9Yfwsqw7dv6opJ1rzLd139DRdB5MFHdnRSvNcqUVxnqcNm0bqH26qGEVovhDDsg99k0xnglPc/t2CWcXPJlLukjLB8/0ZCI0yVF6huWcN3qB6yoUG615sylAWUZZ8oXw1M0cowm8x8IioqLNLUWYEWCOvwhbp0IqtjbdEeDw5+vf8HVz6zdkdYYPqC1mD7aDrMmjoZS+rpxZWR+3cFlnGlEMbm83WGYiicQOnheLIj/G3C2YI8dDfbLW+kEXjcg5ikO6srzcgJZD3usTtA/+t5Hov1hhkgvD0dt3I0oqiYcx/fvZVbUoDafxlmKfdAXX84nLr1L5/s9Mrp7sdQISyIUqxcpR+eAZCG6Ys1I3LBAH9tHhFNEDw0VstPfYgBsxYD5aaAJxny6uHGVZZ9WamPNKrsYL60r2oZfZW8PQJh1LM3xi/sgVEwRfN1q9rhUE+1TICLPQMvqubJmixnDlaDLAUn8krl2CiCZc293AgYvJMVwdV22vhHJrY8fwgR9mB7/8aN0l4oM8tU6IHCnc3oN5U4DxBszEtspoOFlXHjMb1ka+5hhqQnxPhgr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3902.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(366004)(376002)(136003)(186006)(1800799006)(451199021)(8676002)(8936002)(5660300002)(52536014)(38070700005)(41300700001)(66946007)(76116006)(66476007)(66556008)(66446008)(64756008)(316002)(86362001)(33656002)(4744005)(2906002)(55016003)(71200400001)(9686003)(7696005)(6506007)(26005)(38100700002)(110136005)(122000001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QndIRXMwQmduL0JDZnJ5VmpPQjFySnRZMzVYNzYwME5ieXdRM0UwTVo3ZlR1?=
 =?utf-8?B?MndrcGhLWk1ET3hyZzBaM216RTNiRmFlN2tBWnBROGVCMW9GT2pUVjBrK2JD?=
 =?utf-8?B?WFd5aW9QS2lKOHFsRUI3SzUzY3lRVHIvNXZiVGloVVV3dHM4ZW1mWTNiS0U3?=
 =?utf-8?B?NGxCbGFhbzFnamVhRnVlT2NqWEMyYm92aitWaUtYT0dWTjFZZm1tSE5mdWwz?=
 =?utf-8?B?c0V4S0hMMmNwUGkySHFPc2pMS2pHb3VPOS9RcEdvR3NYY1QyaHZrcXhMZDNU?=
 =?utf-8?B?ZzYwOFpOcTN6VUxaMUZ1Yks0MVY3QzJJSTd0RWNqalNrNUZDcDNEYm9yOExV?=
 =?utf-8?B?VlFndXROYjUydEVYNWZNMi9lY3RRbVAzTlhrTGpDL1d4eEpaVEd3MGdxMGtE?=
 =?utf-8?B?SXYyVi8wZW1WZVE0a0tOQkNORms2K3hOVDVXcCtVbWdrWEw2N2o0NEhveGV4?=
 =?utf-8?B?RENoSVlicGhsNXAzSjJlQWk0a2tmeCtFbVF4MmE2VEpRUVFFSmhDUEM2K05x?=
 =?utf-8?B?dVJjSG9DRmJjQmZxT2dXV1VhelcwUGVIUWk2elhVSDhvd0VUK3pPT2J4SHQw?=
 =?utf-8?B?SW9mWGNmNmFMU2w3VkJsYWxYeXB6VXhoeVZubFdDRkNhck5ReHNha2czVEJD?=
 =?utf-8?B?bHlVNHEyeXNEQk9TNjd5YXJNcjNCVzM0NWZBN0JRSkJPdFdPcThpQlUweWgx?=
 =?utf-8?B?Qm1IVWRrYzRaZ0t1b3NoQi80QUdEU3ZhR1dmSkFwLzdDL2pqbGdvZG51Z0dT?=
 =?utf-8?B?ZHlyQkNHTFR6NWxzem4wcU42WFNjQUNMUFV3SHBUSWI3djZudVVXRmo4eHpx?=
 =?utf-8?B?YXZGWGVnaElPSnVlenJFcjN2ZTYrVjBoYUFWeHRhOGo3VWpjNlE4RGpRK2Ni?=
 =?utf-8?B?dVM2YUJRdFByS1B6cDVPM0REMWRKZm1uZlVhbHE4K3YxTWVwS3I0bDhxSTRR?=
 =?utf-8?B?VlV6bWpiUjg0REZmd2VLVnk3dzdPeGI5Z1UzblNRWWExUEowQ3JBUit5TkYz?=
 =?utf-8?B?bjQ1YStocm1DaE51NDhZbmI4Unl6N2FFSjRNVGZ0V3lSNTNoT2g3eWxkQ2RI?=
 =?utf-8?B?cWovd3ZrQU9RMjFoMmYwWG1wSitHZGJqNTR3d0JOdEhURzl2SEtIVnZFeSsy?=
 =?utf-8?B?NmVOZms4KzZnTWUzTmpsNG4yRFB3TDZpekViam1JaGxJWVRTSUwremt5RVkw?=
 =?utf-8?B?MXpoRnczOTM4NytyZ0ZCOW5pZmE0TDJxRCtNNWFRQ3Jmd0xNQitOcjRZRkJa?=
 =?utf-8?B?czdCMXIzSUtZZlJRYi94VXVjcEd2TGhQT1RTM1lvZVQrUU5KZ0JWcTBOR3Nn?=
 =?utf-8?B?OTBUV3VHR081ekNPSHVTdEpVOUFrSzhsemNMZWEzUzMrL0tpeCtDVmhLT1d0?=
 =?utf-8?B?d3RpWVBLMmxmcnVjVzVuOHM5SlVUcHB4Qi9yeTRMMFZMdWN2NFpUTEdqaDVw?=
 =?utf-8?B?QlAwc2dib0x3ZGVJUjlDcW9XQXdjZTd4WmM5dElBTEV1K3BCVUQ2RlUyczlJ?=
 =?utf-8?B?c2tFYUMwQ2I1aCt3WXBWZU0zcnFGVHM5SnFkdGJDRkY2MVBDZzF4L3B3K05Z?=
 =?utf-8?B?WUhKc2I4OVRKemMxYVZsbmt6amlCdXduT2tQL01XSVpVWnpuT3FJYmR3RkpM?=
 =?utf-8?B?ckZrM1VlT2VaU1Z1c29ucUxLOGlucm4ybW1wb3cvUE9DZXVvamVyMlpITDda?=
 =?utf-8?B?VkF1cHFtZit3QkliSGZaazdyeTZsTXR1eGZMZlhGTXlUWm9jMTZuR0NYUVJ3?=
 =?utf-8?B?eE5JenJWekdIRVlWMlRhVUV5b2EycW4xWWVoc0pQK0trMlh3L3RscUR1SVp4?=
 =?utf-8?B?NHh4d0I3Y2RycFBuY3BNbmp4NkJabWgrY2xnaGg3OHlXRVlOOUVtc0hMRndC?=
 =?utf-8?B?MTdHSnlTMDBhUHNvSzg1TWlwKy9LMzkzcjBIZ0VvN0NtZEQwSzJUNkNnUXZq?=
 =?utf-8?B?RXJCeXEwV2lvN2gwcWRhWUMrdlFIbGZ4YnpUNi94UnFLa0ZMNEVqa3ZHTXQv?=
 =?utf-8?B?SDAvQ2hkS2lWWUE0Q1B1TGtDTElnVU56U203USs3SmNsU1ZyT0VSTTNCOTE1?=
 =?utf-8?B?MWtOamF5amd0SUxNMG9TSGRrS1dTNEo3Y0tEWUhBTmtvRjhFK2FCa0hhV1V2?=
 =?utf-8?Q?ILp8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8010fe-903e-4aaf-58b0-08db98f38e6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 16:13:23.7189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UASOMNhCzxXiA7tJr/Rdecj+qkqH/U2nLb59L0wg25D9KJO+VTSHiC/9cGk0yW/s3AdFHzKeV8dC73YAKTRcTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7763
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICsJZXJyID0ga3N0cnRvdWwoYnVmLCAxNiwgJmljbV9kYXRhKTsNCj4gPiArCWlmIChlcnIp
DQo+ID4gKwkJcmV0dXJuIGVycjsNCj4gDQo+IEkgc3VnZ2VzdCB1c2luZyBkZWZpbmUgaW5zdGVh
ZCBvZiAxNi4NCkRvbmUuDQo+ID4gKw0KPiA+ICsJaWYgKCgoaWNtX2RhdGEgIT0gMCkgJiYgKGlj
bV9kYXRhIDwgMHg4MCkpIHx8DQo+ID4gKwkgICAgKGljbV9kYXRhID4gMHgxMDAwMDApIHx8IChp
Y21fZGF0YSAlIDEyOCkpDQo+ID4gKwkJcmV0dXJuIC1FUEVSTTsNCj4gDQo+IFlvdSBjYW4gcmVt
b3ZlIHJlZHVjZSAnKCknIGFuZCBJIHN1Z2dlc3QgZm9yIHRvIHVzZSBmb3IgY29uc2lzdGVuY3kg
MTI4Og0KPiBJbnN0ZWFkIG9mIDEyOCBhbmQgMHg4MA0KPiAJSWYgKChpY21fZGF0YSA+IDAgJiYg
aWNtX2RhdGEgPCAxMjgpDQo+IA0KPiBQcm9iYWJseSBjb25zaWRlciB0byB1c2UgZGVmaW5lcyBh
bHNvIGZvciB0aGUgYWJvdmUgbWFnaWMuDQpEb25lLg0KDQoNCg==
