Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FFB7CC53F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343960AbjJQNy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343928AbjJQNyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:54:55 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BCDEA;
        Tue, 17 Oct 2023 06:54:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9qbJWjPBhnPtlvLrn1z1EEDRS+l6KCthTPEM5lmzp5J7hwCsNZsE36n9nSTqqE5bkXIgsZ07w2GsHpxyZrraufFu8Beu6SxYoEgQ1cFf4ESUfcsRptJ7jAOH91nf7OD0obIniJsRKxJ9PdC0EkBaBSGfjeYiko2dyms70lRAoaaTbV4miuolmVA7cydMhqdVXViOuowaVp3ZYA0L/+DiL3uLbZEGESKAz6mCe/v8QX50+vS/YFbXiyGi9kYae1lfxNqnozjtO+AlmuF3MBL6YAkrs8ErWYVsg33W5UpWeMqDygiFpORPr4JusCWfjq8L0D8qXM/rY1sdQiYksyHcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqSl2OPtO36vm2m0zPKncD98FEjbd4qAuRXPX8PXa44=;
 b=ncc7Cj8js51OtmYv7PQXhDBe+j6JAA5LaNxXdK9n3HidY6dHcqoulA+iXDmtEKEVwDcHIm7RFQDV9Oe9GLZOh1c8bPEAS4HkbJ/By5Y9QSKkR/ObHNcGV3eJUZi923IUk5B6ygtQIgBBNwY1xd2MBLhGZzYqtuF3zc6NGukCrBYMtRSgSeNhbdfrFrFj2LnaiJBF9UHzYYqumyKvcJzc2vhQpp72aG2Xiev2S4eobK0zgQea8yvCn2Dg1ZFjhMbjdVs6xcSfUDj+fNnDs1UaOWBBOPIj1Tg/3NeLdXvWuFDYKcFPgthyfyFihkLRZNF/zjdHbzZGJ3jVKP40h8Hodg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqSl2OPtO36vm2m0zPKncD98FEjbd4qAuRXPX8PXa44=;
 b=1a/CmgtjjhNLbFZ4xhzppNAy/vm5C06RWmlscPSYgyhlWlZYKMRhQzeBVUtL4N2u0v/Tb+iqcI+hzpyfhHnBX2R1Tp9BFC5M2OEj6Rwp/vXXkU2JQl8YBlY16zrdxQaB0nYMmpp3aH1ZYVBTXCdUSrl+QGZ1UjsUkCQ0avzUTTc=
Received: from SN6PR12MB2702.namprd12.prod.outlook.com (2603:10b6:805:6c::16)
 by IA1PR12MB8285.namprd12.prod.outlook.com (2603:10b6:208:3f6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Tue, 17 Oct
 2023 13:54:47 +0000
Received: from SN6PR12MB2702.namprd12.prod.outlook.com
 ([fe80::293a:d73e:e856:543a]) by SN6PR12MB2702.namprd12.prod.outlook.com
 ([fe80::293a:d73e:e856:543a%7]) with mapi id 15.20.6886.037; Tue, 17 Oct 2023
 13:54:47 +0000
From:   "Kaplan, David" <David.Kaplan@amd.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
CC:     Nathan Chancellor <nathan@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Thread-Topic: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Thread-Index: AQHZ/TSeSSFyryg+x0KeMifZktOt3rBM8AUAgAAFVACAAAUmAIAAarCQgAAV8gCAAI0A4A==
Date:   Tue, 17 Oct 2023 13:54:47 +0000
Message-ID: <SN6PR12MB27020AE045AFE7AFFD63839294D6A@SN6PR12MB2702.namprd12.prod.outlook.com>
References: <20231012141031.GHZSf+V1NjjUJTc9a9@fat_crate.local>
 <169713303534.3135.10558074245117750218.tip-bot2@tip-bot2>
 <20231016211040.GA3789555@dev-arch.thelio-3990X>
 <20231016212944.GGZS2rSCbIsViqZBDe@fat_crate.local>
 <20231016214810.GA3942238@dev-arch.thelio-3990X>
 <SN6PR12MB270273A7D1AF5D59B920C94194D6A@SN6PR12MB2702.namprd12.prod.outlook.com>
 <20231017052834.v53regh66hspv45n@treble>
In-Reply-To: <20231017052834.v53regh66hspv45n@treble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=786cca3e-82cf-4fc9-9e5f-d6df3a979528;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-17T13:53:12Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR12MB2702:EE_|IA1PR12MB8285:EE_
x-ms-office365-filtering-correlation-id: 62ff6003-b4eb-4f64-d9de-08dbcf18a000
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6d1A38RokXM2XJMuHkcre8WwJmdz25hKhpzvS1hLrVmc0T+NWeSB6jDJafWzNtAByyML+PzJkXq05CKK+rbc3zHZpZ/G4eMySpDRU+Cs5FKtf6pYg+m2ACQdv6Pt5gavN3SHPSRsupZBM/pXghcmvu1zQXZ5a+uj1MpUGI7cmN9aniqC9tHmOmtTsll4iW9aOLFVXYvXcjGEJb81fPWCUEmcWRV+2cqIWEHuI61wefxKzvzeIR/mPjrSDHbcq6fj5A762kuH7uNPSB014Oo6g7wBtcJXEpYoZn5lzTEQ62Axdog8qDVGh2Yn5IJhHTzNXhkG3HbYsXexqxGB1hKa8Fs3rovy4bpQxZ/wXbnSPEJizIjR/hNCXRY4Wfn4iQkmTDSUMqcGvMSOWMXIsO7Fy4fRFxBaDn7iavrqcbl5+w6CyHuVhsEjSS9nijBNt+SkiCR1A+JYEvBlrRX7YTXD1qSjTy+EE+AGQQkLjcuSyfGTcjDL1DBckqaEVl+iZr+rujcRuwyMWU1UNGur/DEtQ5YBguWITAoJLY+Sdu9yBK6Q8KllxLPr8+DZjlEI7Pd4lg18FtW/3aZLwzbcsNfO2RVxpuUAVpcpiy3VPGQ71wJWQK4fFMKnC15lrWOGCswI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2702.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(366004)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(122000001)(316002)(55016003)(6916009)(66556008)(66476007)(66446008)(64756008)(54906003)(66946007)(26005)(76116006)(71200400001)(478600001)(7696005)(6506007)(38070700005)(9686003)(53546011)(5660300002)(41300700001)(86362001)(52536014)(33656002)(2906002)(83380400001)(4326008)(8676002)(8936002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkJCb1Z4b1JXZjNMWWtiN3JBR3JzVHFvdE9rWEZCWEFuMjAyN1I2clJ1ZlVF?=
 =?utf-8?B?aVdEUitWSC9qeGY2WDUyNzJEOExNeTc4ZWZOdHlwbHJORVVueER0MmlYRU1R?=
 =?utf-8?B?TVYzaUR2a1UxbTNGUlVMb1M1bzB5cEE1ZnpRWTAwaG11ZEVLZnBMQmJBaDFh?=
 =?utf-8?B?ZTE5WWxmdnV2RUhCK1ZkTWpUMHJJTmFma1BWTkxuS3J3Vys0RERyY2p6aVNE?=
 =?utf-8?B?YWhXVTIzT2JvaXRYS1dnK2REMWkzbzNsRnNKT0M1blFucXVhYWkwdldxSG0z?=
 =?utf-8?B?SW1tR3F4UGM2UFFlSlZEQjVXQzZFdk5pVmdLcldQVTZEek5rNkJEdFdFR0U3?=
 =?utf-8?B?VmVGOUs4aEp0SVhxb2NHNDcxY0lBZXFSM2VrUDR1OHQreWhtamNwNDhNT05W?=
 =?utf-8?B?NUx0Tm1kRWk2RWpYZXpPYWE1NTBVZGRycVZlK1FFUk1qOCtmUEk3ejlHVmRk?=
 =?utf-8?B?QWxWaUtKM2hBRGE5cTArNEVIS1pRSUJkaHd6bG1oZ3FIYko4Q1diSnJ0U000?=
 =?utf-8?B?WnNGUmJBRW5hZlQ4OTNjSVN6L2xGOE1IL2dHT1N5RDU2aWJyRGNyUGp5RkpE?=
 =?utf-8?B?cGgzdzZZNjJWVzc4MjhtUlh2bnoxUjY1MkdXb04vcVBiTVpueFlPbERMV0RK?=
 =?utf-8?B?aUplZzRqT1prTWRtVXNHQTFOWWp6dzFQTlZhN1BsT2dMdUtHeVgvU0U4RTl0?=
 =?utf-8?B?K3MvZ092UlRUd0N3QU9oVTZvRldSUERhNjFhS2hYMm1oVUl5eVRJR0RScE1L?=
 =?utf-8?B?bE5rd2Nvb0tvYk8rUjVKWVRTRkVjaFkwZklCRGFGYnh2QUhFRnJjeVFOYnJo?=
 =?utf-8?B?NmRMSzQ1R1ZROC9KMC9ETUhjVk9hd1JiektLT2VuQWRNRWVId284MVhMNVVE?=
 =?utf-8?B?MlBTVTNCOU5DVmVRVzlwOHVRMzFpSENid0hobFhZaDluVHk4V29RYlJRRExB?=
 =?utf-8?B?YUlnV25PSDRzUTY4dEs5NUlRZlVTM09sRXgwZXhzTW0vMW80aitPTGwwOWVz?=
 =?utf-8?B?WWFJTnpKbkJCdGkwaTNZM0ExZkRlTzNwTGpxa3daSDJpWG1jSndEY0lFVlVs?=
 =?utf-8?B?MXhRcTJkaE54MjJGc0Z3L0NVbEFvMHA1QVBmYVpwd0hDVU9sR2oxb2licWdL?=
 =?utf-8?B?UENaNTJRWDZ2NGVLL2NkWWcwdTFxWHplclRIclNUNDlQZ0U1WnRaWEVyYmg1?=
 =?utf-8?B?a3BLVDJQRUxzdDNzdU1IQnIyWHE3cEJweS81dXcrQ0VFU1BlbENIcjAzbFJ6?=
 =?utf-8?B?elRqU0hOb0RxTm5TSk1xR2tZRnZPS1dvM1U2c0p4QjNtWGVuRVBDN1lneWlC?=
 =?utf-8?B?R3NEaDZEZWJuOXhVbWF5dXZFaDh4WGdJbXVRTjR6a0VHQ2pmeVV4SlgxVDNq?=
 =?utf-8?B?THJtNUo5OUpybzhKQ0xFcnBMUytUWjBtK2hBV0xvWGNaRFB1V3pXVGdwRDNM?=
 =?utf-8?B?ZWROU3pUWU9wSTFjZElwMWU1L3lmd2dhWCtlZHFWSzdzK0p5a2lYWVZkUE9B?=
 =?utf-8?B?MmRvamd4RHQ1akFKWWJlMG1oZGQ4VVl4ZWwzRWYvVURFNnBmZVlHZ1NJVVhI?=
 =?utf-8?B?WVJyTSt1K3Z6eHdFWllZKzJ1Lzd1VXphS0NIRjgrRFMwcHJvbkdMZDczTysv?=
 =?utf-8?B?dkRtQk5vZzdqVFBuMmM1aVpqLzlzdmZad2ZDOGYwM2xnWGZvM1lpR1dKUzA2?=
 =?utf-8?B?WTg2bDF4Zm11SzZraE9OcldvSG4xV04xT3FDR3hYdGdEY1pGU3RwTFpudEFi?=
 =?utf-8?B?cGdUeE0xQzZDN09ObHgxT1lrd2N3bGI5ZzdpcjlyQ1dpNDEzQ1puY2YwbmUr?=
 =?utf-8?B?ZmM2QW1iK2VUVEh0OVNOMEZPdWVFOE12RFNCdm9DVzllMFdDZjg0WVpSUFd4?=
 =?utf-8?B?cXh0Y2VoN1FRalRaUnBudko3ODArSzlsRE1hQlZQNEoySnQ3WG0zSENtRk9j?=
 =?utf-8?B?YTJDWEt0ZytjOFpTaXBTbVY5SE9FaHpaYXV4RkZ4KzQrWnN0WE5raml3NzJi?=
 =?utf-8?B?bEkvTkdOS2dCYVhRd20rTnQ0Y21CdS93Q1h6OGhRdlE5aFE1dXZ1SnEwODBw?=
 =?utf-8?B?VGxqU3FxamFsN1pUKzdhL1U2SWVRZE5zakJ6Rmc2NjVINDAwdmtNTTJEcTB4?=
 =?utf-8?Q?FKCc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2702.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ff6003-b4eb-4f64-d9de-08dbcf18a000
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 13:54:47.3057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HE2DsPGLEY1XMYlf58RIX/cGigY3RTXkQYLHWD7vJrDAMHbT4YFHk5N58/8NBvTZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8285
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
YWdlLS0tLS0NCj4gRnJvbTogSm9zaCBQb2ltYm9ldWYgPGpwb2ltYm9lQGtlcm5lbC5vcmc+DQo+
IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMTcsIDIwMjMgMTI6MjkgQU0NCj4gVG86IEthcGxhbiwg
RGF2aWQgPERhdmlkLkthcGxhbkBhbWQuY29tPg0KPiBDYzogTmF0aGFuIENoYW5jZWxsb3IgPG5h
dGhhbkBrZXJuZWwub3JnPjsgQm9yaXNsYXYgUGV0a292DQo+IDxicEBhbGllbjguZGU+OyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC10aXAtDQo+IGNvbW1pdHNAdmdlci5rZXJu
ZWwub3JnOyBJbmdvIE1vbG5hciA8bWluZ29Aa2VybmVsLm9yZz47IFBldGVyIFppamxzdHJhDQo+
IChJbnRlbCkgPHBldGVyekBpbmZyYWRlYWQub3JnPjsgeDg2QGtlcm5lbC5vcmc7IGxsdm1AbGlz
dHMubGludXguZGV2DQo+IFN1YmplY3Q6IFJlOiBbdGlwOiB4ODYvYnVnc10geDg2L3JldHBvbGlu
ZTogRW5zdXJlIGRlZmF1bHQgcmV0dXJuIHRodW5rIGlzbid0DQo+IHVzZWQgYXQgcnVudGltZQ0K
Pg0KPiBDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNv
dXJjZS4gVXNlIHByb3Blcg0KPiBjYXV0aW9uIHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xp
Y2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQo+DQo+DQo+IE9uIFR1ZSwgT2N0IDE3LCAyMDIz
IGF0IDA0OjMxOjA5QU0gKzAwMDAsIEthcGxhbiwgRGF2aWQgd3JvdGU6DQo+ID4gSSB0aGluayBJ
IGZvdW5kIHRoZSBwcm9ibGVtLCBhbHRob3VnaCBJJ20gbm90IHN1cmUgdGhlIGJlc3Qgd2F5IHRv
IGZpeCBpdC4NCj4gPg0KPiA+IFdoZW4gS0NTQU4gaXMgZW5hYmxlZCwgR0NDIGdlbmVyYXRlcyBs
b3RzIG9mIGNvbnN0cnVjdG9yIGZ1bmN0aW9ucw0KPiBuYW1lZCBfc3ViX0lfMDAwOTlfMCB3aGlj
aCBjYWxsIF9fdHNhbl9pbml0IGFuZCB0aGVuIHJldHVybi4gIFRoZSByZXR1cm5zDQo+IGluIHRo
ZXNlIGFyZSBnZW5lcmFsbHkgYW5ub3RhdGVkIG5vcm1hbGx5IGJ5IG9ianRvb2wgYW5kIGZpeGVk
IHVwIGF0IHJ1bnRpbWUuDQo+IEJ1dCBvYmp0b29sIHJ1bnMgb24gdm1saW51eC5vIGFuZCB2bWxp
bnV4Lm8gZG9lcyBub3QgaW5jbHVkZSBhIGNvdXBsZSBvZg0KPiBvYmplY3QgZmlsZXMgdGhhdCBh
cmUgaW4gdm1saW51eCwgbGlrZSBpbml0L3ZlcnNpb24tdGltZXN0YW1wLm8gYW5kDQo+IC52bWxp
bnV4LmV4cG9ydC5vLCBib3RoIG9mIHdoaWNoIGNvbnRhaW4gX3N1Yl9JXzAwMDk5XzAgZnVuY3Rp
b25zLiAgQXMgYQ0KPiByZXN1bHQsIHRoZSByZXR1cm5zIGluIHRoZXNlIGZ1bmN0aW9ucyBhcmUg
bm90IGFubm90YXRlZCwgYW5kIHRoZSBwYW5pYyBvY2N1cnMNCj4gd2hlbiB3ZSBjYWxsIG9uZSBv
ZiB0aGVtIGluIGRvX2N0b3JzIGFuZCBpdCB1c2VzIHRoZSBkZWZhdWx0IHJldHVybiB0aHVuay4N
Cj4gPg0KPiA+IFRoaXMgZGlmZmVyZW5jZSBjYW4gYmUgc2VlbiBieSBjb3VudGluZyB0aGUgbnVt
YmVyIG9mIHRoZXNlIGZ1bmN0aW9ucyBpbg0KPiB0aGUgb2JqZWN0IGZpbGVzOg0KPiA+ICQgb2Jq
ZHVtcCAtZCB2bWxpbnV4Lm98Z3JlcCAtYyAiPF9zdWJfSV8wMDA5OV8wPjoiDQo+ID4gMjYwMQ0K
PiA+ICQgb2JqZHVtcCAtZCB2bWxpbnV4fGdyZXAgLWMgIjxfc3ViX0lfMDAwOTlfMD46Ig0KPiA+
IDI2MDMNCj4gPg0KPiA+IElmIHRoZXNlIGZ1bmN0aW9ucyBhcmUgb25seSBydW4gZHVyaW5nIGtl
cm5lbCBib290LCB0aGVyZSBpcyBubyBzcGVjdWxhdGlvbg0KPiBjb25jZXJuLiAgTXkgZmlyc3Qg
dGhvdWdodCBpcyB0aGF0IHRoZXNlIHR3byBvYmplY3QgZmlsZXMgcGVyaGFwcyBzaG91bGQgYmUN
Cj4gYnVpbHQgd2l0aG91dCAtbWZ1bmN0aW9uLXJldHVybj10aHVuay1leHRlcm4uICBUaGUgdXNl
IG9mIHRoYXQgZmxhZyByZXF1aXJlcw0KPiBvYmp0b29sIHRvIGhhdmUgdGhlIGludGVuZGVkIGJl
aGF2aW9yIGFuZCBvYmp0b29sIGlzbid0IHNlZWluZyB0aGVzZSBmaWxlcy4NCj4gPg0KPiA+IFBl
cmhhcHMgYW5vdGhlciBvcHRpb24gd291bGQgYmUgdG8gbm90IGNvbXBpbGUgdGhlc2UgdHdvIGZp
bGVzIHdpdGgNCj4gS0NTQU4sIGFzIHRoZXkgYXJlIGFscmVhZHkgZXhjbHVkZWQgZnJvbSBLQVNB
TiBhbmQgR0NPViBpdCBsb29rcyBsaWtlLg0KPg0KPiBJIHRoaW5rIHRoZSBsYXR0ZXIgd291bGQg
YmUgdGhlIGVhc3kgZml4LCBkb2VzIHRoaXMgbWFrZSBpdCBnbyBhd2F5Pw0KPg0KPiBkaWZmIC0t
Z2l0IGEvaW5pdC9NYWtlZmlsZSBiL2luaXQvTWFrZWZpbGUNCj4gaW5kZXggZWM1NTdhZGEzYzEy
Li5jYmFjNTc2YzU3ZDYgMTAwNjQ0DQo+IC0tLSBhL2luaXQvTWFrZWZpbGUNCj4gKysrIGIvaW5p
dC9NYWtlZmlsZQ0KPiBAQCAtNjAsNCArNjAsNSBAQCBpbmNsdWRlL2dlbmVyYXRlZC91dHN2ZXJz
aW9uLmg6IEZPUkNFDQo+ICAkKG9iaikvdmVyc2lvbi10aW1lc3RhbXAubzogaW5jbHVkZS9nZW5l
cmF0ZWQvdXRzdmVyc2lvbi5oDQo+ICBDRkxBR1NfdmVyc2lvbi10aW1lc3RhbXAubyA6PSAtaW5j
bHVkZSBpbmNsdWRlL2dlbmVyYXRlZC91dHN2ZXJzaW9uLmgNCj4gIEtBU0FOX1NBTklUSVpFX3Zl
cnNpb24tdGltZXN0YW1wLm8gOj0gbg0KPiArS0NTQU5fU0FOSVRJWkVfdmVyc2lvbi10aW1lc3Rh
bXAubyA6PSBuDQo+ICBHQ09WX1BST0ZJTEVfdmVyc2lvbi10aW1lc3RhbXAubyA6PSBuDQo+IGRp
ZmYgLS1naXQgYS9zY3JpcHRzL01ha2VmaWxlLnZtbGludXggYi9zY3JpcHRzL01ha2VmaWxlLnZt
bGludXgNCj4gaW5kZXggM2NkNmNhMTVmMzkwLi5jOWYzZTAzMTI0ZDcgMTAwNjQ0DQo+IC0tLSBh
L3NjcmlwdHMvTWFrZWZpbGUudm1saW51eA0KPiArKysgYi9zY3JpcHRzL01ha2VmaWxlLnZtbGlu
dXgNCj4gQEAgLTE5LDYgKzE5LDcgQEAgcXVpZXRfY21kX2NjX29fYyA9IENDICAgICAgJEANCj4N
Cj4gIGlmZGVmIENPTkZJR19NT0RVTEVTDQo+ICBLQVNBTl9TQU5JVElaRV8udm1saW51eC5leHBv
cnQubyA6PSBuDQo+ICtLQ1NBTl9TQU5JVElaRV8udm1saW51eC5leHBvcnQubyA6PSBuDQo+ICBH
Q09WX1BST0ZJTEVfLnZtbGludXguZXhwb3J0Lm8gOj0gbg0KPiAgdGFyZ2V0cyArPSAudm1saW51
eC5leHBvcnQubw0KPiAgdm1saW51eDogLnZtbGludXguZXhwb3J0Lm8NCg0KWWVzLCB0aGF0IHdv
cmtlZCBmb3IgbWUuICBXaXRoIHRoaXMgdGhlIFZNIGJvb3RlZCBhbmQgdGhlIG51bWJlciBvZiB0
aGVzZSBzdWJfSV8wMDA5OV8wIGZ1bmN0aW9ucyB3YXMgY29uc2lzdGVudCBiZXR3ZWVuIHZtbGlu
dXgubyBhbmQgdm1saW51eC4NCg0KLS1EYXZpZCBLYXBsYW4NCg==
