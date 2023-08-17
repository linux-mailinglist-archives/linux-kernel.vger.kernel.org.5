Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941EE77FC0D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353018AbjHQQ0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353733AbjHQQ0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:26:02 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC6A3ABC;
        Thu, 17 Aug 2023 09:25:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7e4l1jpjtDRJcqtFNsDEZQ2TOlrre7bPZ1+Ai/Xi7zWsUMMQ72Xg27UtW3zHss9hZ2zGMaykksKaGEaTtMTmvfxC1cxgGRyc/XpalhHsJgwVPuvJLbvGc8pOID+gsnTCaBALtLKoX9pNLN4zM2cf6w1p0JjlVcYfZzXgFgBj46FunMcR6qTViUXMcA6W72g81yyZWdjE4Q9pmqUpL+H8Rm7MUvcLXuR6TftZOs+W+lXWELL6ebtogsE6HSCIdwpyWTdHETFkzBG2aR7VkF6JjtFOQ2dnNjeCJaygKowl+/O6Y0t676Xq2rbLNWrfqbXLMU40HEbqu3NRJnhpihIYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oXVoZIprjijixi9DFm3y4XTcZNihSBJOfMRBKz/Gmw=;
 b=HS20p+oJuVKWF8eYgysWGJSLnyZI+36vM6cPsodaIJtHGvcpfGlJwBOYp3TdT2T66RIbHKtehih4Bg2qsP5pK4GmvRZ8xNmfVl6jfqR9bWO1XaSJm1+GwewC9SFzHVDmZa7rCeWVZcPm84Xg3rEnQWbSFxOwKx0r4wekjfoy0kfKXTuRvC18YnycuqU5F//8/pWs2DenW5ubyah5RHYAnjNOgls2X3JCusSJHzY7u5msPE/6ueLay8mbilUJsvmP9nJc5b3e0jalykppjPw8oIskq5ZNf5HVXLN7+aZFPbUh/e2XJL7SAq8abiJ2xSwjvxHCsmIO6S9jSXBxRnotWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oXVoZIprjijixi9DFm3y4XTcZNihSBJOfMRBKz/Gmw=;
 b=uydwjvcictNWL5b/EBd2yS9XG6gctgjw9HMguj4BlREFtCOnyYjdQ9hYgGGhvBrjwOLDJh3LvyQRF4ArPrHSiSJ4TvaZ4Ywz2I2HmfIFxdjFREGHxvSRJP5blpNn9HnpeVI5xDKJ4+UuKVol9EBnuft1hLYuDFnnRu0fW8BMveQ=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH2PR12MB5001.namprd12.prod.outlook.com (2603:10b6:610:61::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 16:25:10 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 16:25:10 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        August Wikerfors <git@augustwikerfors.se>,
        Hans de Goede <hdegoede@redhat.com>
Subject: RE: [PATCH] ACPI: resource: Add a quirk for Lenovo Yoga 7 14ARB7
Thread-Topic: [PATCH] ACPI: resource: Add a quirk for Lenovo Yoga 7 14ARB7
Thread-Index: AQHZwYV1Rtet55lVZky5tmm7zxZKUK/uy4QAgAAAL0A=
Date:   Thu, 17 Aug 2023 16:25:10 +0000
Message-ID: <MN0PR12MB610129485F9ACA8DF1321B26E21AA@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230728183921.17230-1-mario.limonciello@amd.com>
 <CAJZ5v0iDJtTjZXB3HLZgLX2tLF5DW8Da2-S77zDLsBvH1A1kpA@mail.gmail.com>
In-Reply-To: <CAJZ5v0iDJtTjZXB3HLZgLX2tLF5DW8Da2-S77zDLsBvH1A1kpA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=98e48f04-f454-4c52-bed8-d3b700a1ddd1;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-17T16:25:01Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|CH2PR12MB5001:EE_
x-ms-office365-filtering-correlation-id: 69515fda-2d25-460b-1dd1-08db9f3e86f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KfVOs7qfo+Umw5tixvZ8r1a+GAx3zDbdcMY3DOXxTu/XYW/0BhrcD3hyHW++2JGSzn/pptKnaA1+nT8zyJzVwkCiBq5iyBd/nb+Jj7jtzyDed6BQFD4WpRy+MfQSyTvxgdeS/sANgDrc1nR8ChYUap81jNpE7nm/tzyqd/W9C7c1insVYz+5iekYSfkBWZcpBCuoZNuvcJmj4QWPfva1Ku4Ce/0a6t4PLtAjzGosn38AcU2hsu3c0DTXRlFKXliieHXJbIxKFQrgytv3jXqLlNXmz6i9AWqFZG3tizDoUDYtTgTi00v7F0lk8p/xO+WI1c1Zm3li50gXsVfHvM6YCBT7AX8YUGsLeRE0mGwGfK5Sgozgulwpao6OPK1u+A6vtNGXd+abM8gMioAWcAKRKkNJ6ZDq2iJWYgJSAg/fbawmEtHnGLUMhi/xWZvIADkHqagFg58gMWbdbo5TZFXm9KHcHBaJDZJ01rKLeiFYMcFasD7mfChNCvsC+yxtdIUG4tp/dTAmQYoXkv8sK5vlISLy3qv1/qjDvDOLSIhfrUzyU5IRrR3fTPWZR5LMIyK60GMd4bOSGACuaykaU3u+WX+fsq6BbTSTbdaouedLE3c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(366004)(136003)(376002)(1800799009)(451199024)(186009)(55016003)(83380400001)(38100700002)(66476007)(38070700005)(66556008)(66446008)(64756008)(54906003)(6916009)(316002)(66946007)(76116006)(478600001)(122000001)(966005)(2906002)(41300700001)(8936002)(8676002)(4326008)(52536014)(5660300002)(53546011)(9686003)(6506007)(7696005)(71200400001)(26005)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enRabyt4anVLTS9xWUxHOXZlR0NjNnJSWm1UTmxYVDMwOWNybnFQbzF3QVlm?=
 =?utf-8?B?bzdxclRaM3BkeXcwY1AyZHQvV0EweUNnYWtMaUdHM2pVeExCVC82UnMxcWls?=
 =?utf-8?B?Tk1ieDlHRmh5dUlYQy9tcGs1RisyVm1XR0h6K2M1TnNhN1BKUjZXNnJHNEli?=
 =?utf-8?B?TjJyOG1VR2hZVjYrbm1yNnZvdzRyZzk4dGlwOEdMa2dHdGU4a1VzUUhkRWJR?=
 =?utf-8?B?OTZLaGVmLzByV25sVVgySU5ueDVwd2YrcEJXLzU5SVBEWm5XZEl1WlNRYzRz?=
 =?utf-8?B?MnF5cmFrdnBIVGp0dlJEdzRVUCtkV3h1WGw4cHFyV3JvRzZDUFdDbDZGeXd0?=
 =?utf-8?B?WWlOQ0YwRnNyQnJaRW15MVE0cndPUDhWcGw4M3VKbVpzWXNYYWhqMFVIQUNB?=
 =?utf-8?B?YjJ4bkJUd0EzSTRubXRzcW8raHQ3YUkzeTFSdUhwMGY1SnhyazBJNEp1UENR?=
 =?utf-8?B?YTlQUWJsbVkrckFMa1VNcUdHOTBEdWZGSjQ1RmxSSkM0R2w2UERhM0w1Uk5n?=
 =?utf-8?B?YnFjc1MxemloL09hUFRBdjJsMHBnNU9NYUNIMFF2dkR0UlFDcTVsaFF5SmZh?=
 =?utf-8?B?Q0NnWjZjQUdBdWpmeXZLY1ErNnVYUS9qcEF5MzA4dDJ6VVl2dGU0a2RJYy8y?=
 =?utf-8?B?Z3dYYjJqY1J3UUJjalI3Z2ZqNXd4RmdGQ25HblB4cWpCaVlDUm9DSmZ3dmtR?=
 =?utf-8?B?MUhHL0UvQTlIWmx2aUtDNktLWmtncGpKWHV6NHM1QVZTb1BndzBiV251TVdL?=
 =?utf-8?B?TFJFZ05nVk4xWUxSdFRoSE16dVJLanEzdmpuS3ZKZlRVQlhWdjdsVUhPSmZL?=
 =?utf-8?B?T1ZvMVJXSzUvak1PWXY4NmZVaDRYaFlqNjZvcWlCeWpKYmhCUGdPNktSZUN6?=
 =?utf-8?B?Y2ttdXVrbW1ud2FlOVBxNk1aNFJMQVMrVjVUQnE3ODBLTUlNbVF2OFBDcTFQ?=
 =?utf-8?B?UFVlZlljK2pGTURTNytzSGVieE1PV0hnY1AzcW9YNjdtME1tUkhZdW1FSDcv?=
 =?utf-8?B?R1hmQ09SbzR2N0I5eHo4NklTVUpPZlllNnAzZHFscENLYWFxUjNXOVQyaDBL?=
 =?utf-8?B?M1VKWXp0RWc0THdFbCtWVjhCa3BMZUR2U2dsUm5kY1ErUlNnS0pEaTJJL3ZU?=
 =?utf-8?B?WGJnUGhSdDNJZmdHYlBRNDg5eHVDZWUzcWYveFBXZUxyTnE0ck53T3ZLYUJq?=
 =?utf-8?B?VzNpVjIxbDY3QWJ0WjI1d2pHaU4vL1UrMlpmRDQ1T0xHUHZ6MitlODB1bVRY?=
 =?utf-8?B?MHZiOElCa09JWHRFTVBPUVF1SmZxc0MycXhpZks3SUwvZ2IzSHZzbHRZV29h?=
 =?utf-8?B?dnNxMkUyM3ZBWDYza3Qwd2pzdlVNZU4xYXZUV0hjZTJnTUVDYU16d2k0bHlv?=
 =?utf-8?B?aVBhbmU4Q1N0TEJvQlVOYkRHY2ZpQ1drNTdMSjZwbEwwMTJiMmNkMnIxaXlM?=
 =?utf-8?B?dnhiSnBZYk1yYW5WYi9HUFRzZDE0bFJObUNEQVBDcUErUTY1OCtnNmxGUE9L?=
 =?utf-8?B?WWwweEt3bkx6L3l1VGcrOXcvekprVXlPZ3Y1eUhTWjZFWXNvTmllTWM3Y3d5?=
 =?utf-8?B?ME5ZVEdibGpsdDFLM29DeUNvU3pvWjZtTWFLME16ZjVHNUVLemIxUVFkMk5P?=
 =?utf-8?B?dmgvQ0Q5WGlmOVVWU2pFMEJkU3Y3MEo0Zm5xU2JJcEZrZ1ovMGE2NVdKM2xx?=
 =?utf-8?B?Tmh2b3ZNaWhob3hmeStVYlpYZVFOTmo5VEw5bnpZdG9Jd29xMEdKSHJKU1Ru?=
 =?utf-8?B?Ym5qeC9sZTA5akdKU2Zpa1grRTVTRFU3a2hObWZtcXVmMjhLRFNFSVpFQ3pK?=
 =?utf-8?B?THBGa2hqM3lNYmxOS05SYXFjdlMxRWJNUUxmS2ZkQlJuYWlEQzNGV0dmWjNh?=
 =?utf-8?B?bUwvWTZFSWhMK0NQMU1XR2FUMjVhbkVvQ0M3K2tEM2FnbW9CL29VcWJQa0I5?=
 =?utf-8?B?bWp6dnF0Z2RuMDI1RXlMcStibVdIbVdLUFVSenczcmZQenpncjVqL1orUUNU?=
 =?utf-8?B?RFZTVFc3YkxRUGVibG9sdFRMeWlESlZSbkZzMFVFQzJGZ2ZDZlpMeHBzVFpi?=
 =?utf-8?B?TitZODVLcHpxS3pQWFVOdGpSQWtjRUFkcWJQUTIvbnMrMXpMTWVXU1pkdmlh?=
 =?utf-8?Q?SPCc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69515fda-2d25-460b-1dd1-08db9f3e86f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 16:25:10.3857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e0HzaSUx6L7k/LJIW8IulIFSMeava2UZk98/CDDkHLJqzpPH/LFNEp8l3UUD1k4gzOOg+L9HbeU8pNgpOS1aLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5001
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPg0K
PiBTZW50OiBUaHVyc2RheSwgQXVndXN0IDE3LCAyMDIzIDExOjI0IEFNDQo+IFRvOiBMaW1vbmNp
ZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+DQo+IENjOiByYWZhZWxAa2Vy
bmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGFjcGlAdmdl
ci5rZXJuZWwub3JnOyByZWdyZXNzaW9uc0BsaXN0cy5saW51eC5kZXY7IEF1Z3VzdCBXaWtlcmZv
cnMNCj4gPGdpdEBhdWd1c3R3aWtlcmZvcnMuc2U+OyBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUBy
ZWRoYXQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBBQ1BJOiByZXNvdXJjZTogQWRkIGEg
cXVpcmsgZm9yIExlbm92byBZb2dhIDcgMTRBUkI3DQo+DQo+IE9uIEZyaSwgSnVsIDI4LCAyMDIz
IGF0IDg6NTjigK9QTSBNYXJpbyBMaW1vbmNpZWxsbw0KPiA8bWFyaW8ubGltb25jaWVsbG9AYW1k
LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBMZW5vdm8gWW9nYSA3IG5lZWRzIHRvIGhhdmUga2V5Ym9h
cmQgaW50ZXJydXB0IHNpZ25hbGluZyBwb2xhcml0eQ0KPiA+IGlzIGluY29ycmVjdCBpbiB0aGUg
TUFEVCBhbmQgdGhlIHZhbHVlIGZyb20gdGhlIERTRFQgc2hvdWxkIGJlIHVzZWQuDQo+ID4NCj4g
PiBSZXBvcnRlZC1ieTogQXVndXN0IFdpa2VyZm9ycyA8Z2l0QGF1Z3VzdHdpa2VyZm9ycy5zZT4N
Cj4gPiBDbG9zZXM6IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9
MjE3NzE4DQo+ID4gRml4ZXM6IGE5YzRhOTEyYjdkYyAoIkFDUEk6IHJlc291cmNlOiBSZW1vdmUg
IlplbiIgc3BlY2lmaWMgbWF0Y2ggYW5kDQo+IHF1aXJrcyIpDQo+ID4gU2lnbmVkLW9mZi1ieTog
TWFyaW8gTGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+DQo+DQo+IElzIHRo
aXMgc3RpbGwgbmVlZGVkIGFmdGVyIHRoZSByZWNlbnQgY2hhbmdlcyBmcm9tIEhhbnM/DQoNCk5v
LCBpdCdzIG5vdCB0aGFua3MgZm9yIGNoZWNraW5nLg0KDQo+DQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvYWNwaS9yZXNvdXJjZS5jIHwgMTIgKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAxMiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL3Jl
c291cmNlLmMgYi9kcml2ZXJzL2FjcGkvcmVzb3VyY2UuYw0KPiA+IGluZGV4IDFkZDhkNWFlYmY2
NzguLjFhODI2NDE5ZDU4MzcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9hY3BpL3Jlc291cmNl
LmMNCj4gPiArKysgYi9kcml2ZXJzL2FjcGkvcmVzb3VyY2UuYw0KPiA+IEBAIC00ODEsNiArNDgx
LDE3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZG1pX3N5c3RlbV9pZCBsZ19sYXB0b3BbXSA9IHsN
Cj4gPiAgICAgICAgIHsgfQ0KPiA+ICB9Ow0KPiA+DQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qg
ZG1pX3N5c3RlbV9pZCBsZW5vdm9fbGFwdG9wW10gPSB7DQo+ID4gKyAgICAgICB7DQo+ID4gKyAg
ICAgICAgICAgICAgIC5pZGVudCA9ICJMZW5vdm8gWW9nYSA3IDE0QVJCNyIsDQo+ID4gKyAgICAg
ICAgICAgICAgIC5tYXRjaGVzID0gew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIERNSV9N
QVRDSChETUlfU1lTX1ZFTkRPUiwgIkxFTk9WTyIpLA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgIERNSV9NQVRDSChETUlfUFJPRFVDVF9OQU1FLCAiODJRRiIpLA0KPiA+ICsgICAgICAgICAg
ICAgICB9LA0KPiA+ICsgICAgICAgfSwNCj4gPiArICAgICAgIHsgfQ0KPiA+ICt9Ow0KPiA+ICsN
Cj4gPiAgc3RydWN0IGlycV9vdmVycmlkZV9jbXAgew0KPiA+ICAgICAgICAgY29uc3Qgc3RydWN0
IGRtaV9zeXN0ZW1faWQgKnN5c3RlbTsNCj4gPiAgICAgICAgIHVuc2lnbmVkIGNoYXIgaXJxOw0K
PiA+IEBAIC00OTQsNiArNTA1LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpcnFfb3ZlcnJpZGVf
Y21wDQo+IG92ZXJyaWRlX3RhYmxlW10gPSB7DQo+ID4gICAgICAgICB7IG1lZGlvbl9sYXB0b3As
IDEsIEFDUElfTEVWRUxfU0VOU0lUSVZFLCBBQ1BJX0FDVElWRV9MT1csIDAsIGZhbHNlDQo+IH0s
DQo+ID4gICAgICAgICB7IGFzdXNfbGFwdG9wLCAxLCBBQ1BJX0xFVkVMX1NFTlNJVElWRSwgQUNQ
SV9BQ1RJVkVfTE9XLCAwLCBmYWxzZSB9LA0KPiA+ICAgICAgICAgeyBsZ19sYXB0b3AsIDEsIEFD
UElfTEVWRUxfU0VOU0lUSVZFLCBBQ1BJX0FDVElWRV9MT1csIDAsIGZhbHNlIH0sDQo+ID4gKyAg
ICAgICB7IGxlbm92b19sYXB0b3AsIDEsIEFDUElfTEVWRUxfU0VOU0lUSVZFLCBBQ1BJX0FDVElW
RV9MT1csIDEsDQo+IGZhbHNlfQ0KPiA+ICB9Ow0KPiA+DQo+ID4gIHN0YXRpYyBib29sIGFjcGlf
ZGV2X2lycV9vdmVycmlkZSh1MzIgZ3NpLCB1OCB0cmlnZ2VyaW5nLCB1OCBwb2xhcml0eSwNCj4g
PiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo=
