Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E4E7E5D53
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 19:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjKHSfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 13:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKHSfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 13:35:30 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CDB2102;
        Wed,  8 Nov 2023 10:35:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RlfzFyW+wdPT7WkUPG+I8BsUX8JYdeUCZZuNoBo2S6bAk6J0FyV3wPaF6aUFcQLB8Y/J07ci8T/4r8DaMdh1bvb3/u1fYLyFYcMjMms03z0WExX395zqJ081KTFLlVmvFnsk4J3UMN0WZ1tWDqah1vF06J4UlqRk2BepOe0GNLepztB1z7Umxt5lc0aAfilHP1Ru7CXy3TF0mr4TrAZUaudGBlYdqPJXcI7ClCPU+JdGe4sByj5nPC6tHva0HDgprocDF2JZ7QvJanf0Xqe+fsAuVBtEjjvQAD/yuWZgHpOVZIf6DvexFalieW5bYQCg+7aXFd4TvV75xu57KY2U4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4XABRoRHl9i6EUraLOSg1e9sWZ5uslUE2GTqeuF3Wc=;
 b=HGgClvX31lRKk/cbhhdnzAWnpCkCZ932YK4w9Th0a4aN5mU32LdtlSyiCv2pjOgqbU+X2OhiiQJO0x/7/WMAvXXOso59g8UX8Oa3fvyNtiujg1Mk7ny7GA5KbXp559vagF5zQ54LFrFZ5kksBCkCOfc5D+2hYkFO33Bm46KedOBtwt6ITD3Gz8sgjaYBKOyRcG2RBUFJxOSVA1KuDE4NeAWimqpYeg8+zSO4eayM0MP5Mr4RRX5SA4AXTZDPjzEPmkYuhTdVaFvhsQUMj3A9xHF7/jnfyOY+MgyFh7YUldicpc8iKo+e6JHGZifGh4pqgB4AXb2/FzMjUkZFMBVFpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4XABRoRHl9i6EUraLOSg1e9sWZ5uslUE2GTqeuF3Wc=;
 b=hawzqf1GwECWWSONXdGrhU7wLmhIgobF74IqkHwLrtQ1TX6U8zihGkqga+3ttS2HvPX6IJMuPDtf3B27glLrNQIada/tpokemhGXR6v2qNXWoGZhm1723NCbYqE9o0rqo0V0QzTk/Y2+Vue3jYNvJr97dC2/AUJOE/G//1sBEfQ=
Received: from DM6PR12MB2666.namprd12.prod.outlook.com (2603:10b6:5:4d::11) by
 BN9PR12MB5308.namprd12.prod.outlook.com (2603:10b6:408:105::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 18:35:25 +0000
Received: from DM6PR12MB2666.namprd12.prod.outlook.com
 ([fe80::6e40:ba51:d4b7:9ea5]) by DM6PR12MB2666.namprd12.prod.outlook.com
 ([fe80::6e40:ba51:d4b7:9ea5%5]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 18:35:25 +0000
From:   "Keryell, Ronan (XILINX LABS)" <ronan.keryell@amd.com>
To:     Rob Herring <robh@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "git@xilinx.com" <git@xilinx.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH] dt-bindings: riscv: cpus: Add AMD MicroBlaze V compatible
Thread-Topic: [PATCH] dt-bindings: riscv: cpus: Add AMD MicroBlaze V
 compatible
Thread-Index: AQHaEKWtAFUIQ2k7oEumWIc06MYNBrBwrBeAgAAXSQA=
Date:   Wed, 8 Nov 2023 18:35:25 +0000
Message-ID: <5d2563a8-dd26-417b-a3ba-1b12b6c37bae@amd.com>
References: <d442d916204d26f82c1c3a924a4cdfb117960e1b.1699270661.git.michal.simek@amd.com>
 <20231108171203.GA2434548-robh@kernel.org>
In-Reply-To: <20231108171203.GA2434548-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2666:EE_|BN9PR12MB5308:EE_
x-ms-office365-filtering-correlation-id: 5d4395d9-6209-4529-24dd-08dbe089792d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fxraDz89581vw2jcdoz7slWmaZcJZF9e+kIIVd6gHYzfrtdU6xKApk9tSt466yqM+gw+h76Ah07s9SnxyLn/oXkkOVsgDyi9cxsarwatkuCjNaeTnfPlbVsHT0qG9cd2DM4IwF5c/vS+rnEJrDzdJzfulP3iACcD2a9yfVJInc+OOAthoXyaxdVVC4Su3lkgRw1pNYeqqfgoHIr37HABbsSQZJVuqciwsI6BaErwPCDYkOsGYeyNqtbBU0G70Mx2BI25GJrtVvIVhVndpQ5a3BLswkNSzhgMe1XeJrl8oOed19BpS/AabjYdMq1yn5qTF/1qe21r9YEISU84gO29YrAUa1HhnNq0pWivjwB11L4vJmZJBfZEmO6YBO6raB89jStTzIwRzZT84pbZdjmobAFJ1G/Dq4trEWuBhGps0K8lUjTP63y011hv/wGAS5KUWq+r+PhtV6Y1z0wF4ylrRj6/iT2U3dTk5Qr+1tdjdHVPw1vw1hvuP+yKUaG2+E5iG1hU21iT5qFM5VoW092ekKqLZviWmbNdjC1sJenSeCNZs410rmj0MEI8VPavdn6Y1Ws29h3C+/T53ejwCmpIN+7koiPlf/O6CJ0DYHOdyEaCHXAoKl54pzslnnXxPAxSBnt0Vob+YTvA/zuwfdaOPhJqOgMmxjZRIeYO3ytjFxSIK+f17TqEDzSCNRPX/lvy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2666.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(376002)(346002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(53546011)(6512007)(71200400001)(26005)(6506007)(2616005)(64756008)(478600001)(6636002)(316002)(66446008)(66556008)(4326008)(91956017)(8936002)(8676002)(36756003)(38100700002)(76116006)(110136005)(2906002)(66946007)(4744005)(41300700001)(66476007)(86362001)(5660300002)(7416002)(31696002)(31686004)(122000001)(6486002)(54906003)(38070700009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUk0RXRCTW4yYkp2ZVlUcU81UlBWd2dYTWt5Nzd6QzJEcXlQYnh6UFpmdHVG?=
 =?utf-8?B?bjR0YXRpVlF1U09TbEs0anhoVEtBVmdldTZ0RE9HMTZNV0w0SW5qaGl0dldm?=
 =?utf-8?B?RXJvK2J4c3ZIS2d4ZXdpVzlHSTUxMFhyb3NhOURpVTJxQnptbSs0cWd5cFJF?=
 =?utf-8?B?a21JL09Xb2trZEZEb1UxWUNrOENsYkF0Zkg0SnBpenpMRDc4MGNPVkQ5N0V5?=
 =?utf-8?B?RUdPSlprOHlzZ1l0VGRUeW10VjZsRk5taXJpZk5HUHFWUm9ZQTIwaXJseWpJ?=
 =?utf-8?B?SVVyQ0lCbTM4QzViUEd0ZDhkS2lEL29YMlBXMW5QQ1BaL3dXdSs0QjJWYmU4?=
 =?utf-8?B?RzlZaWpYdXplSU5pNTY1NnlGNzNwYldWSFdFRTFjVEFQL1pjSHNYbkZOYnkw?=
 =?utf-8?B?YkxuZWRqSmNDNk9hZDVJbWdMNVlLS1FDbm1rTGJ5K3BPb2dJY2hPQk1NbGU3?=
 =?utf-8?B?MWNMQjRuR3dvY2sxbGx6dEVnQWpuWFdjb1BUNnBlek9ZSWlYa0FzS0Mvb2J4?=
 =?utf-8?B?Z3dWWHZQRk5MRzlLZnE0UWo5S0RpSitTMDRzN1lpQ3U3QXQrczZFS0thbHNy?=
 =?utf-8?B?Y1BzWU1SUFIxVTMxVGI2Yy9RazhzVjF3Sk12TWw2REFnRUpJTlVQZ0g1V3R0?=
 =?utf-8?B?ekxsUVFTTWYrS3JSNVhtcnpVUk1GNmZraU96UjhNb0lzcEVCMXRLbXlGUWkr?=
 =?utf-8?B?TjFqR3FrRVVieUhqZUJTYkZ5ZlJML3Q2OGsyUlVLWFdieEt6L0ZWTUQybndM?=
 =?utf-8?B?Y2JaT2NWdFN3S214UzBaVWcwZU9EL2xJa3d5M0RRdzlXTGdLVjdSSEV0aTFM?=
 =?utf-8?B?Q1lrTnVXbHFBMWQ1WnZ6VGszU0JRd0NxdkIxeDIwTjAwSDRtZ0R3Y0lBOWsv?=
 =?utf-8?B?a3BtOTNURjFXZmtySzBiYkV0Zkh4eENZdW5PcUQ1cDMwM1dJTzVzRWZwRjht?=
 =?utf-8?B?T3NmS2xEUnBjK1l4dkl4MG1yZTRxMmhmOEIwUHRSTVZYMlN5NytKWFY3NC84?=
 =?utf-8?B?bHFHc1dldE42cnlnanlId0t2T3pDRDFVdi8xdmlKYy9BQzZBZGtaOWJiK1hJ?=
 =?utf-8?B?QUxOcXFmSGFITWxlQnE5SEdiQ0srTEJNQlJZaXVQTW5KWm1qZTV6RFBOd2NC?=
 =?utf-8?B?UHYzNjRpNzJCVFRENUVaeGthOEo4WWFsTHJMSDJuQkpBYWpZODhPUHJLd25K?=
 =?utf-8?B?aDlwZE1VYWJHSjlydUk2ODREcTcrNmkxZ0JpQWJXb3ZkU21GTHNQS09WUEN1?=
 =?utf-8?B?WGhBSG1sTEdHU0ZKemtvL2l5NnpkaExEdFRBUUV1YWNhQiszRnlJa2VnUjVN?=
 =?utf-8?B?WHdPU2pDK1VZYUhVOWdQMjhwVkFPWjlIUHhRY0UxQTU2b21nYmo0WWdTS1Iv?=
 =?utf-8?B?bVpDcFppZW40V0k5NkhXcUxFS0pDVi80SkwrekZyTnNkUlE1RHZENVZKUUVI?=
 =?utf-8?B?M0lvM2hBeFNvU0hHT25mTzllTmFwMVd2bjNwRlRqbGoxMVRxc1oxbDNnSCtV?=
 =?utf-8?B?WW81b0h1UlkrVloyR1dkYXhwbWUyTmczR1UvWGtKVnE0YlFseHE3d09oTy8w?=
 =?utf-8?B?QVhXbU42YlRGRUcyMFpkTmdFQ3NUMGNkMHp4QU5oT3JUOTl5MG1MNjNDZWd4?=
 =?utf-8?B?a1Z4MVJ5c2Z4S3p3WW9UZkNYQTRuQ0Q3ZjdSVmEwQldZenN6cm4reG9EOHVy?=
 =?utf-8?B?V3NLODRyTG94S3IrbjZ6akdUbkpxVlpvU2VEcHJBUjU5Y3poOUg1bTZLenAw?=
 =?utf-8?B?WDVGd3c1T0k2aE5PMkZ0REt2TlRRZXdXZFpKVm95Y2xuSms0akE0aktIYWNy?=
 =?utf-8?B?Qit0ZUMzOEw2MndDVjNvUG5kYU5Xa3pwaUt1U2hZNTRBZXlwZWxzYXlrYVUz?=
 =?utf-8?B?TlpYZWkvaVBpZ3ptSU15ejNzUWRVYTh3Mkpsd3RWUlZHclN4TS9LRUNoWS9m?=
 =?utf-8?B?Z3pvd1Nua1BLdDNwRDhBUWxibzE2ZEY3WklFODhWbGM4SkRpZFV3dVR4NExM?=
 =?utf-8?B?aFNvem5UVDNrUXYxbGFxZm5nbk9icVpvcTRyVHY3UEVjMEdyN3RkTTc3OGFV?=
 =?utf-8?B?aWRhclZlNFVrVGo5dFdoVTB3Y014YVppRTdyQm12Mk1UMis3bVNPZjk5L0pZ?=
 =?utf-8?Q?MozA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B8BD3BF40BD4204D87FA49D4B149D9E9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2666.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4395d9-6209-4529-24dd-08dbe089792d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 18:35:25.0874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ASsEdCr/sx3saKfFgrpAXhccVHHmgggngRDfhvUff01veEhEVgW0JmFWs1NKRk4J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5308
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvOC8yMyAwOToxMiwgUm9iIEhlcnJpbmcgd3JvdGU6DQoNCj4gT24gTW9uLCBOb3YgMDYs
IDIwMjMgYXQgMTI6Mzc6NDdQTSArMDEwMCwgTWljaGFsIFNpbWVrIHdyb3RlOg0KPj4gTWljcm9C
bGF6ZSBWIGlzIG5ldyBBTUQvWGlsaW54IHNvZnQtY29yZSAzMmJpdCBSSVNDLVYgcHJvY2Vzc29y
IElQLg0KPj4gSXQgaXMgaGFyZHdhcmUgY29tcGF0aWJsZSB3aXRoIGNsYXNzaWMgTWljcm9CbGF6
ZSBwcm9jZXNzb3IuDQo+IA0KPiBIb3cgaXMgdGhhdCBwb3NzaWJsZT8gSXQncyBhIGRpZmZlcmVu
dCBpbnN0cnVjdGlvbiBzZXQsIHJpZ2h0PyBJIHN1cHBvc2UNCj4gdGhlIElQIGludGVyZmFjZXMg
KHNpZ25hbHMpIGFyZSB0aGUgc2FtZS9jb21wYXRpYmxlLg0KDQpDb2luY2lkZW50YWxseSwgSSBh
c2tlZCBteXNlbGYgdGhlIHNhbWUgcXVlc3Rpb24sIHNvIEkgYXNrZWQgbXkgZm9ybWVyIA0KbWFu
YWdlciB3aG8gZGVzaWduZWQgdGhlIGFuY2VzdG9yIG9mIHRoaXMgcHJvY2Vzc29yLiBUaGUgYW5z
d2VyIGlzDQoNCnwgSXQgaXMgc3RpbGwgdGhlIHNhbWUgTWljcm9CbGF6ZSBwaXBlbGluZSBqdXN0
IHdpdGggYSBkaWZmZXJlbnQNCnwgaW5zdHJ1Y3Rpb24gZGVjb2RlciB1cCBmcm9udC4gVGhlIOKA
nG1hY3JvIG9wc+KAnSBhcmUgbm93IFJJU0MgVg0KfCBpbnN0cnVjdGlvbnMsIHRoZSDigJxtaWNy
by1vcHPigJ0gYXJlIHN0aWxsIHRoZSBzYW1lIG9wZXJhdGlvbnMgaW4gdGhlDQp8IHZhcmlvdXMg
TWljcm9CbGF6ZSBwaXBlbGluZSBzdGFnZXMuDQoNClNvLCB5ZXMsIGFsbCB0aGUgaGFyZHdhcmUg
aW50ZXJmYWNlIGlzIHRoZSBzYW1lLg0KLS0gDQpSb25hbiBLRVJZRUxMLCBSZXNlYXJjaCBMYWJz
IC8gU2FuIEpvc8OpLCBDYWxpZm9ybmlhLg0KQU1EIFJlc2VhcmNoIGFuZCBBZHZhbmNlZCBEZXZl
bG9wbWVudC4NCg0K
