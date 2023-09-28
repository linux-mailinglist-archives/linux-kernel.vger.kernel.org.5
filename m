Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AA97B1610
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjI1Ics (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjI1Ico (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:32:44 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E87B7;
        Thu, 28 Sep 2023 01:32:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDhDa6bG12q3KOOjRTi9ZTeklV2ZjyR4ytaxxUxDQ+VeVkkZ9lrXyzwqm5IcGBAhlhSWLk74IayTIrbj4ImkSLR4EkKw7lP/IdqcVd3rgRUV14wuJRz9JuRHvGTmQIS4UrldvtC0uFyLA9wpCSbUF0FXHr6q0LicTAGt712kFBm8AElLF9GrxmJMrzAtVVT6Z+IfOu8jbL93e6PUW3+hPJd2e/pah/vj+jPOGLixIGkP1Zv41RgErte7mwWajVcKwedjIvYign0RyeRVkEdf87iw4cPz7Lwbjv8OfczaE7ymlqKibo1RAANw6qUm8JPxej5h+XZ/FpZ5ioHjie/9YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COkbDdPYRtM10+beVO4UPM+zmSlYMBRpZ5UsfgxeBPE=;
 b=W9KpMUcr7aXfoRQOrT7pTFcJfUXh7QcxDcRtttP5iu3c4RArPhdEZJefBoJ5hRCH6yiAIPbuls4T/WewnPzMFISYkRKvxEmmYttMmVphqQJmOYdMosCbBAr0gFpzGPG1U8Om1oCvxGVHMc2jSWn0gcApAPfJHw25JYGqF23vSU9Xh1YeS8vdu6ACmegnwG6JI0Mdf4nb1Xn46D+jIfLBgCbQxDTyjUXhAFJE+O/H+udqF0EShPw6oHrtBNJ7vM9zkVai1tABDPQZgfelDJ223aqJZS/IkmP713nzclfxbHrYHEW8inkrK9RLCEiLm7qg9zPo1WtwCF1oV1y/YMAPng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COkbDdPYRtM10+beVO4UPM+zmSlYMBRpZ5UsfgxeBPE=;
 b=G+aUleRA2dDbSLyvRzPogAhAYC4VtpIdluQvIE3nsrkhqGyA02FV+vFlp2RDSICf/X1vuIo4n35rrFbDxcJln6cMwMUikN8V/Ciy/NzWqGomNH3MV+IjEMkalL7RnZMnOffBekAlv//AJuYYAgD0VAVEVBG/wT30OH//VPF2FX4=
Received: from BY5PR12MB4902.namprd12.prod.outlook.com (2603:10b6:a03:1dd::9)
 by BN9PR12MB5195.namprd12.prod.outlook.com (2603:10b6:408:11c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Thu, 28 Sep
 2023 08:32:39 +0000
Received: from BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::48af:8d18:40f3:a43a]) by BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::48af:8d18:40f3:a43a%7]) with mapi id 15.20.6838.024; Thu, 28 Sep 2023
 08:32:39 +0000
From:   "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     "Neeli, Srinivas" <srinivas.neeli@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        Andy Shevchenko <andy@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 22/23] gpio: xilinx: Convert to platform remove callback
 returning void
Thread-Topic: [PATCH 22/23] gpio: xilinx: Convert to platform remove callback
 returning void
Thread-Index: AQHZ8dprnzKuCFKFtkyR69WDpzHScbAv6MwA
Date:   Thu, 28 Sep 2023 08:32:39 +0000
Message-ID: <BY5PR12MB49022A125E22C62E4BE1B2BB81C1A@BY5PR12MB4902.namprd12.prod.outlook.com>
References: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
 <20230928070706.2290137-23-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230928070706.2290137-23-u.kleine-koenig@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=27bca6d6-faf9-4b9e-a01d-7f1e32e96bd2;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-28T08:32:01Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4902:EE_|BN9PR12MB5195:EE_
x-ms-office365-filtering-correlation-id: c12a7649-aa02-46b2-e928-08dbbffd79cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F8E9Ry/9rqHSHDaisgHT5l+7kmvu5oDnQKIYIDyshBCCtIa7dPQmIral/SgU4+FvXUrEXiIO9bp0AA2M98ljh9eaFkUzQZrEkSipWpgnihJh+BjSfz5TBzy88LAUrGTd0MuPP9Lbhi4+jFpeu2mcvFiigIEQqs2XD6d6lD310O2YnzZ+zM0XDu3BcNIQSYyUasFlUATgesKcEtaEuTvVVZ3XP1n/zO9K+lQONKZgaMqiKZg7mUWqkaiEF5h2lsLbFo53wmh+NPxRHhCutLs48i+5j1xg09hKfxxqRnWRlwUOqR25CfNYw/CfwOytzIzbo/xzVYFJqp53dJ1BZPPFD2fLZp9CVfAi0N6S3gGcX4Li/ywdYJsLUddXl+XrUzuac9TeOFGSzH6/Zj0sDVRdvKS03uXAwzIKZqRi8v96Ai4zdpsK3HMkwWm+4rWc+Yg3A1M1cl2R3RPf5vR0Mewh2A/7WHmo+AfqmPWbmG7YslWmxcEqmiFoaUoR76W7S90myabTAycBCPzXpyckUM1sOzJH46NB0xEo9ydAfaUMj5uC4UDqDOs25P73YW4MVv4eY7o3UtY9A7RoPaj8fAyvDn0CUasSexaCnJjvPHHo1EHFxf4A0+1lVD3AHvdeKaQj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4902.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(346002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(86362001)(55016003)(9686003)(6506007)(7696005)(53546011)(2906002)(26005)(8676002)(64756008)(41300700001)(52536014)(66446008)(66476007)(66556008)(54906003)(66946007)(8936002)(33656002)(76116006)(316002)(4326008)(5660300002)(122000001)(478600001)(71200400001)(38100700002)(110136005)(38070700005)(83380400001)(66574015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEJ6ZU50Um56UnJVcDdsbFZaeVN4VzFQTU1rN0thRGpwRFdBVkF3NVg4TzRJ?=
 =?utf-8?B?Z1Rzd09OR1IwdUVNWjg4L0o3NXMvR3d3RlJmdm5iYnVJRGR1Zk11Q2kvRXQv?=
 =?utf-8?B?c0p3QnZpMzlaUWdnWVRXbHFpNi84aWVvYnJMV1ZJSzRZVFdLS0oyaWczNVJr?=
 =?utf-8?B?cUdPWk5Icnh6N0pVN21FbzZTSW1GRE1mYnZ6Y2FWaTh4bSswQzdmUGJzOHdE?=
 =?utf-8?B?dWNkSjcrcW9aUTRVb1JSUUQ2K0lHdjRFSks5aU9Ib2lONko3NXlGYjJqdlIw?=
 =?utf-8?B?RmYrRjBSejNJczZpTGhmMTY0SlA1NEM3OFVVNlNCZUhLeVZTaG1GR25FRUdh?=
 =?utf-8?B?NFZqR2E4T1VCQUV5T3BWTUJGK1E0UU4rdFp6OTdaSlhPVHlwL2drVkhPRHpW?=
 =?utf-8?B?ZTAyM2E4S0ZFS3FpRFBlNEo1Z0NUSXp6TmVpaGhsNVZ4NmdwK1AzNGVjM0lS?=
 =?utf-8?B?V2N4TWRYK29ST0tpZVoyMHVwMHk5dHZuRitHM3lUSlBQYTV4Z1BHM3lWU3Zv?=
 =?utf-8?B?ak5YbFJvamZFTVpya0xjeE1ic2xKM1lSbEJnV2JEZ05Sakp4dENLVE1Lbnht?=
 =?utf-8?B?OWRGZUJreVh1Q2ZMcW9zTGFnMGhsTjJtMlk4VjBiTzk4dU1XdEFReDVJVUZu?=
 =?utf-8?B?dEhmMjBsandoVkVWM2NhQXJsSWZvSjRpaDQzNHg4aVdTdFVmUVhEMGZ5SWFT?=
 =?utf-8?B?RXNLM0hWRWxpSlhzWHV2SmFSY2FZeW1QVXdlMEgvYnA5UlJWenBsQWRBcS9Y?=
 =?utf-8?B?TDhtQm5yK2pGK3VDc29oc3MvSEYyeHZlck0zVldBZVR3OHZJbDluZXVkVWFx?=
 =?utf-8?B?RERKa3drMHZFS0ErNUZKTURDNkVHdU1vek1wMVNSRDhMTjdOeHBta3FsZWRr?=
 =?utf-8?B?TXE3WVpEQWFoejh2L2JUd0phZGlaYk5sNFNCTHVWZlMwQzAwN3p0V1Y3d25r?=
 =?utf-8?B?YUQzekNQdTVIczFPK2ZkVDV4Z08raDcydzRhK3V0RkdYQnRvblhUTmo1WTEz?=
 =?utf-8?B?WnJsVE15MTlVZ3VIcHk5QlVnUDhEeldaclpOTE9Sc2RSdFBxaEU4SG11QTMz?=
 =?utf-8?B?RXNpUVhRSTFzdXhsK0NuYm1oaHBHdWQxRDZtWDEwZi9CdXJKK3ZvY2srZmx2?=
 =?utf-8?B?TFRpZVg3TzFlYlg5Nmk4R3FkMlJiKytHSWQyZGZ1eHNobU9FK2lRZzdjWjF0?=
 =?utf-8?B?aGkybExyOWZNUUsxU1JkNk1ZVS80aFFPWGhRRDYrNWFVNUpFaFZid0V2TXF6?=
 =?utf-8?B?S2ZLdklQV3NKWVoxRGp3YjNtT0E2QlVOYm1hQmxPanZRZzRETkl5djFQSlQr?=
 =?utf-8?B?Qys0YktCalFhUlMvei9BcjJOVmtQenZvUytzM2JWZHNtblRVNG1yUnBZbHNy?=
 =?utf-8?B?RjJ3eXo1UWNIcC9zY1dEdkR1VE9KTzZVS21nU1FPc1VDQlVQdW5Xd2NwcVpZ?=
 =?utf-8?B?cEM5N0lVZC9hazF3aVVGcDN1Q2VHbG80ajFrRmFPb0JsOE4yd1ZkeXlQanRG?=
 =?utf-8?B?b01ueVMyQW5kd1Zza1lHVEMxZFVhaHBaZDdUNU95ZUdSQWszdTBPYlljWExY?=
 =?utf-8?B?MGUwaEJYVFhycVFEWDFKTG5OUjlETWJkeVlEVlVaV29LMTd3N3ZrdUJIL0ll?=
 =?utf-8?B?dXR0MnBGb2JEK01VSENLNFR2bWNHQ3EwYXRRNzZnZnE1Y2kvV2R2bUkvVko0?=
 =?utf-8?B?SVlxb0NtWWdjbWM3MnhDbUxXZEMwUk95ZnZhZlp2SnAzL0pRSFJvZkJ5blQz?=
 =?utf-8?B?NTBWT0VHaFZYTlNTM0pzaWdiZ0lxamI3TE5RVTNDQitndFVtL0pIbDFqZy84?=
 =?utf-8?B?UFhlQTVHbmd5VU9JT0lJdHF1dkZ3ZWVsQWNTT3R1RW44c1hGU3poWUFObDBI?=
 =?utf-8?B?NXJxRUlCK1hYUURmbnN6aVlJUWRwaUhwK2VXUVR0ZW0zbTZZSWd1K21vY1Ri?=
 =?utf-8?B?R01LMW8rYUZqVzZFTVRMTjNsMDFSN3FVMWhYMzBTcGJmTCtuclpDeTcwT1N2?=
 =?utf-8?B?UE5wZ3JKVGhsZTJaUk5VSVNQd1NuNGMyVDQ3OVNoK0tRVUVrR3FLZW1VbGd3?=
 =?utf-8?B?YlJDeTByZStnSXNGaE83YXN4angvQlU1eVNUcCtCb2lIK21ML2x2b1ZjaUMx?=
 =?utf-8?Q?E4BQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c12a7649-aa02-46b2-e928-08dbbffd79cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 08:32:39.3802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VHugETfAYIXQfkhZVrYNxwRvPIadD+B5GpNmMvY66nF4zz2SOAWRyX7lJh5U13Kb6xSOU88v/yYP5zGt2MCDwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5195
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpICwNClRoYW5rcyBmb3IgdGhl
IHBhdGNoDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVXdlIEtsZWlu
ZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4NCj4gU2VudDogVGh1cnNk
YXksIFNlcHRlbWJlciAyOCwgMjAyMyAxMjozNyBQTQ0KPiBUbzogTGludXMgV2FsbGVpaiA8bGlu
dXMud2FsbGVpakBsaW5hcm8ub3JnPjsgQmFydG9zeiBHb2xhc3pld3NraQ0KPiA8YnJnbEBiZ2Rl
di5wbD4NCj4gQ2M6IERhdHRhLCBTaHViaHJhanlvdGkgPHNodWJocmFqeW90aS5kYXR0YUBhbWQu
Y29tPjsgTmVlbGksIFNyaW5pdmFzDQo+IDxzcmluaXZhcy5uZWVsaUBhbWQuY29tPjsgU2ltZWss
IE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyBBbmR5DQo+IFNoZXZjaGVua28gPGFuZHlA
a2VybmVsLm9yZz47IGxpbnV4LWdwaW9Admdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0tDQo+IGtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
IFN1YmplY3Q6IFtQQVRDSCAyMi8yM10gZ3BpbzogeGlsaW54OiBDb252ZXJ0IHRvIHBsYXRmb3Jt
IHJlbW92ZSBjYWxsYmFjaw0KPiByZXR1cm5pbmcgdm9pZA0KPg0KPiBDYXV0aW9uOiBUaGlzIG1l
c3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3BlciBjYXV0
aW9uDQo+IHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3Bv
bmRpbmcuDQo+DQo+DQo+IFRoZSAucmVtb3ZlKCkgY2FsbGJhY2sgZm9yIGEgcGxhdGZvcm0gZHJp
dmVyIHJldHVybnMgYW4gaW50IHdoaWNoIG1ha2VzIG1hbnkNCj4gZHJpdmVyIGF1dGhvcnMgd3Jv
bmdseSBhc3N1bWUgaXQncyBwb3NzaWJsZSB0byBkbyBlcnJvciBoYW5kbGluZyBieSByZXR1cm5p
bmcNCj4gYW4gZXJyb3IgY29kZS4gSG93ZXZlciB0aGUgdmFsdWUgcmV0dXJuZWQgaXMgaWdub3Jl
ZCAoYXBhcnQgZnJvbSBlbWl0dGluZyBhDQo+IHdhcm5pbmcpIGFuZCB0aGlzIHR5cGljYWxseSBy
ZXN1bHRzIGluIHJlc291cmNlIGxlYWtzLg0KPg0KPiBUbyBpbXByb3ZlIGhlcmUgdGhlcmUgaXMg
YSBxdWVzdCB0byBtYWtlIHRoZSByZW1vdmUgY2FsbGJhY2sgcmV0dXJuIHZvaWQuIEluDQo+IHRo
ZSBmaXJzdCBzdGVwIG9mIHRoaXMgcXVlc3QgYWxsIGRyaXZlcnMgYXJlIGNvbnZlcnRlZCB0byAu
cmVtb3ZlX25ldygpLCB3aGljaA0KPiBhbHJlYWR5IHJldHVybnMgdm9pZC4gRXZlbnR1YWxseSBh
ZnRlciBhbGwgZHJpdmVycyBhcmUgY29udmVydGVkLCAucmVtb3ZlX25ldygpDQo+IHdpbGwgYmUg
cmVuYW1lZCB0byAucmVtb3ZlKCkuDQo+DQo+IFRyaXZpYWxseSBjb252ZXJ0IHRoaXMgZHJpdmVy
IGZyb20gYWx3YXlzIHJldHVybmluZyB6ZXJvIGluIHRoZSByZW1vdmUgY2FsbGJhY2sNCj4gdG8g
dGhlIHZvaWQgcmV0dXJuaW5nIHZhcmlhbnQuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFV3ZSBLbGVp
bmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+DQpSZXZpZXdlZC1ieTog
U2h1YmhyYWp5b3RpIERhdHRhIDxzaHViaHJhanlvdGkuZGF0dGFAYW1kLmNvbT4NCg==
