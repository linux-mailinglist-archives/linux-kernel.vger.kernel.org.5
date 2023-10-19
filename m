Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF467CF568
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjJSKct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjJSKcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:32:47 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B3C129;
        Thu, 19 Oct 2023 03:32:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+Vz1kjV0C1OSfoQKkzRZqm5WtgKIe7jN5KQaHs2aywYH6pp2/NOXYdMHVLlhZKkMAvDChcGr+luNoSeNtbDs8y5PCoozPkDOzRs0eYnKrnezsdgRsSd9JvCaMEjBBVLCxWkG/TPIJnLUh13VsY35vtZU6IjEhpAHywxmEUnyK1gDZAU4w5yAUrPjRcwxuV/es0AErKpIvdksmM1P1qsFfnf1B05sxXCKjH93QCGXsrBnNLpYkKyQOLCaPTW8BZeFHL5ex/KvGBG+n0Kf2HK2y35RgsMxQPOjb65VOfn3p4WKlS/xXGXvb2ySg9wYGJIjBE+YRAwUeapYe86ZCgD+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sSJjwkKQUbzNEYzEehEjeGxrYgYC7zzGe7NwWvvaEc=;
 b=ni7LPQMxXQl6VFm6Lrm0XBbhuBirEirfrr8K6iNb0ZgflCzDz2Av2wOstMjfzaJScyeGH1oOXiSZHVJPCnTjZVJXRJlRumRsBRCIuS/vxcc6QgH/J4BULvjuZuhGvSIsnlGc7cIE+Xw7pa1aTzClZLxp28VMvY7P4ivd8QeayBLXii7WPjWbAdIY8O6B7WKIwQDl/4v3ZWh7tt9eoh+tZTuLw/9xueK7tKZVMLbxIsDzeBFyuABoUw0rgs0FdugXbR6YT1Slgzz+cjjKjXJDMumpQaoXo2szsCkBwQFoKAVndPUHRmlqElUTt08lAz4x3HAYB3qxCw0y5qQXXgb+5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sSJjwkKQUbzNEYzEehEjeGxrYgYC7zzGe7NwWvvaEc=;
 b=hgADqg9EcRIg1N8VG5vnfyA7cvOvjYELdNRbbVIHIHXFg5ItSwGykPTFv817VFPUqC8KlcdrJag8I7q4rg6NrhV/JsHNlr38ltWZvEYVbgl2IY8Pvf+H64jzOVdmzW9q5on45/U1J7iNl9bZ+/X6BEr+zbyggLewp+dQbiMSv/I=
Received: from BYAPR12MB3207.namprd12.prod.outlook.com (2603:10b6:a03:135::10)
 by DM4PR12MB5278.namprd12.prod.outlook.com (2603:10b6:5:39e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 19 Oct
 2023 10:32:43 +0000
Received: from BYAPR12MB3207.namprd12.prod.outlook.com
 ([fe80::7898:321:2239:77b9]) by BYAPR12MB3207.namprd12.prod.outlook.com
 ([fe80::7898:321:2239:77b9%2]) with mapi id 15.20.6886.034; Thu, 19 Oct 2023
 10:32:42 +0000
From:   "Kundanala, Praveen Teja" <praveen.teja.kundanala@amd.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 3/5] arm64: zynqmp: Add ZynqnMP nvmem nodes
Thread-Topic: [PATCH V2 3/5] arm64: zynqmp: Add ZynqnMP nvmem nodes
Thread-Index: AQHaAlKW/s3Ct/HanU28MF9iZBMnOLBQ2F6AgAAEKaA=
Date:   Thu, 19 Oct 2023 10:32:42 +0000
Message-ID: <BYAPR12MB3207FC23425007B129ED4D3ECBD4A@BYAPR12MB3207.namprd12.prod.outlook.com>
References: <20231019060651.23341-1-praveen.teja.kundanala@amd.com>
 <20231019060651.23341-4-praveen.teja.kundanala@amd.com>
 <1fa867b2-3930-4ff3-90cd-022d855036c7@linaro.org>
In-Reply-To: <1fa867b2-3930-4ff3-90cd-022d855036c7@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=2c9e0f18-85e1-440c-b916-cfffde98a817;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-19T09:42:34Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3207:EE_|DM4PR12MB5278:EE_
x-ms-office365-filtering-correlation-id: 1be64a47-5f97-4a0b-899b-08dbd08eb9aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bCr8W7sZj9sEhV616U7QPBZ3oPB00cT9LD8UU1OwZZOFpuPJFytLVlzNkVqhjhv226MkpgDj3qflaMLkTsCcV26aip6Zg445D40lWe+vAAHEYwD8UzFcNXUW0EuLGmxzh2K9tXB3nn48tY9AE2ongd3xsrRMOqEsdMsMhHKSAigsREWOTFviSZGXTXWZuKToFD04KmL9qmHjXHtyCURx9BFMSSzUMuwYZkVJHAjsS3KlXG69rZh/E9gPlRa5F9VBz0Bly39lQU30Gl7KPu3LMzRIL/Y4kWPLXyZvKXU8xoFyJeso6lQAZAHBM4kgjgIZl9xBcm05a6g3WbIbV40iOwKZ8G0JMx9RSlY8+mwZarjLpUslswjm6n4RH0XAXKcAVsy/qZVrGZdYXc9X9i9EhpbvHk4rC/Y7f7t2+c5SqhSXKYzPchi0baJwMyDIO/Kapu8QGuPpmP+H8p8B8DgJduSK9LSNmRMyi2vL9Tpi64UWZMvYdIZPCUU0E7xYtj8SFxB2B0h4FGjyGo1z7YokmUnXYiY7YYv+LXk4A714tQnGhhik3QUajuKxubGZ6C4wt3D9q1FnOxRJSTvqjUFKHSWSU3voguuHQgphgaZNaAM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(346002)(366004)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(86362001)(55016003)(66476007)(66946007)(66446008)(110136005)(76116006)(66556008)(64756008)(316002)(71200400001)(966005)(478600001)(8936002)(8676002)(33656002)(5660300002)(41300700001)(52536014)(4326008)(7696005)(2906002)(6506007)(38100700002)(38070700005)(53546011)(83380400001)(26005)(122000001)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2FST20rMW5sem1FSjRncE5HV2ZQdVpJYTZTcFErU3QyRnE0c3JwK0tabGl4?=
 =?utf-8?B?ckp6Z2lFdGZzSkY5Q3NKbENtbUZPNC9wYXd0YUhqeVlHcTE4UnNndTNET1kr?=
 =?utf-8?B?aWN3UnBkNWtZQnRjK0Yra2x0VzIrZGp6ejVmclF6Y1I3WTF2S2NtWEpUeXpw?=
 =?utf-8?B?MVFJQ3NUY2J1Nk9DOUxKZkFJczB4SFAvNG5WZDRubEMzVllqYzk3ZEI0eVpL?=
 =?utf-8?B?UVVIL0hDcHl5S2hCKy9KSHFNSzVUV0VySGdEaG1mYWp0S3BFL2NxcFdKdERP?=
 =?utf-8?B?cVNUdGFXVVFIZFByTFdEL1Q1TTNMeFFVZXprM0ZGMlBHWWpSNlMwWkVvSm1C?=
 =?utf-8?B?M0VaZHowNFdFdFJTb2JINmswdnhLK0diTjdzL28wVWlpTmdlRndzZGVTSHdV?=
 =?utf-8?B?Rno0UmhtMk1naDJORDNzalU0Y0xyTmhDTWowTGd0UUtSWDdhV3RlcVAyRVNn?=
 =?utf-8?B?dS9zRVdTVFVQOGY4Nm1RK1ExQUxJQzk5dlEwVWxFZVU4ekVWZjVSdWZlRzZ3?=
 =?utf-8?B?anMzZ2pCL2lTM20xZ09qZDhPL1BwbHE0cGQxU3VoRHZqQzIyQk1zK2hzS0xJ?=
 =?utf-8?B?MHM4bmN0V0JycEM4QXc0anNKSEJnZlhwKytYcFBPWnREVmtOdG1jRUNRekZQ?=
 =?utf-8?B?Q0FFSFFOT2sySVR5OTVCbWU0N3A4bDA5dENzcExYaHcrVDZvR25FRC9FdG04?=
 =?utf-8?B?aERlbTJsZ2ZMWWc1eUJTSlRXbFNSSU42THMrNkdaQkU1R3BKREwxdEVuZXVF?=
 =?utf-8?B?cHhQaUYrVW1NZ2VZa0l5ZTRQK01iUjI4YmtSa08zV1RjWG03cWxDckYzQXNh?=
 =?utf-8?B?aXI5cm15Ri9DSVA2RFBobERtRy9kZFB3NHdFWnF1a0JRRzlnWFJENXIrM3dh?=
 =?utf-8?B?bFIwdmswNTN0ZnQ2cExRdVUxMUJvVUIxeCszUW5LK0VuQjVYRWRpKzdYZmlm?=
 =?utf-8?B?eVhFMTY5VHNuRTJ0ODV4c3JLR1BTTXhpQUdkZDJCMEp4d1BGaFpObStmaTR4?=
 =?utf-8?B?Rk1CUjVDeFZ2QUpOSlJsZ3hxZkZvQlJERG4vMGhZaG16WVgyYTlpaVdwY2V2?=
 =?utf-8?B?R09FUkRJZkF4ekxmOWNJLzJzTnA4Yjg2TjJUTnlzdmQ3THkyOFlPU2dOY2xP?=
 =?utf-8?B?TFArZ1BZTlVXNjVWTkZEdFJ6UEpRSUlOeUZ0dHQ5aU92UlgwS3Q5dXZ1N3FE?=
 =?utf-8?B?R1lTUVNzekV2T1Z6ZDVzc2hrRlFTemhEbEVaTW1iNzBaUjZLMDNpazRSQ3pB?=
 =?utf-8?B?TEkwdWdoMHJ4WWtKOTloVldzV3V3dEZkUXk4SjJmQTBTTDJkREQzV1ZleHBK?=
 =?utf-8?B?Q05CRU9SNW9wLzBRSE1BUkc3clF3Z0tBdG1zOHg2UU4yREh0WldSTzZvMlFz?=
 =?utf-8?B?NksybG83MXdZNGxPOHJLY1F5Vjh0aEZPWjRCWXpHK1oxSjJKTWVhdTRIT3Bm?=
 =?utf-8?B?aEV6eFQwSUR3QzNvUXlZSlNGUjZFamIwUkMwVEpjRWVGbXNZZTRlb0VlRDFR?=
 =?utf-8?B?VTZJQ1JyTmtDRUYxZndwLzhrY1ByMUIrVklKZ3EyZ2NQK1FJUDZNZzhvZ3k0?=
 =?utf-8?B?Y0tEZmh4UWNuNXV3eTVYT3VxOHVNOFlrV3hZQ2xFeGoxRnRiU3V6Tys5elc2?=
 =?utf-8?B?UHhZTnVXVUpiTk9oWTQwZDVMdnR4azZUYUl4d1Y0YVh2RTVxcXltM0Q4c1Jz?=
 =?utf-8?B?LzZpRkt2bzhwdzJCWWlHZElmU1ZNdmZUaUUwT1p0L2I4M0owVE5qWXcvMm53?=
 =?utf-8?B?RERsRkVGYytPZXF0eVhicFBzSzZoK1NzRWRuSmlhM1VUcnlWcVI0ejdiQ0dO?=
 =?utf-8?B?UmhVQ05XelFQNkVwUWFRbVZ4aWQ3NWJJTmpxZVl5cU9aVXRkRTMvL2cvSkln?=
 =?utf-8?B?VTlXS1RkYXlCdjBmQ1QzVmlXOFdTUTEzb2hJamcvSEhzRm15V2kvbisyK0JX?=
 =?utf-8?B?YTgwRFhjaFZ6V2JtUXdqN2t4ajJiQWE0RjU4ZE84em9yQU1sdjZXVWpMMHRN?=
 =?utf-8?B?Q2pyM2ZvNkhsVm1GaytSamQrb3V4bC9sY3NrTUxXTkkyOEJjS1BwRW15Z0hx?=
 =?utf-8?B?cFp3MU9RNStpTVBueXRMSkNUSlVFNDVXRTgrc0NUSFdnSitMVllrU2lPcHpt?=
 =?utf-8?Q?mR/k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be64a47-5f97-4a0b-899b-08dbd08eb9aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 10:32:42.1638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eXc0U0wNECkKOEntTd+fbLYMa2QlYX91eWR3kBMmz6K+XDu1jfcda4h0aWe9H8aEMwe2jyCjxV7me3E6cpg49g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5278
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIEtvemxvd3NraSwNCg0KPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxr
cnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVy
IDE5LCAyMDIzIDI6NTggUE0NCj4gVG86IEt1bmRhbmFsYSwgUHJhdmVlbiBUZWphIDxwcmF2ZWVu
LnRlamEua3VuZGFuYWxhQGFtZC5jb20+Ow0KPiBzcmluaXZhcy5rYW5kYWdhdGxhQGxpbmFyby5v
cmc7IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4ga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8u
b3JnOyBjb25vcitkdEBrZXJuZWwub3JnOyBTaW1laywgTWljaGFsDQo+IDxtaWNoYWwuc2ltZWtA
YW1kLmNvbT47IEt1bmRhbmFsYSwgUHJhdmVlbiBUZWphDQo+IDxwcmF2ZWVuLnRlamEua3VuZGFu
YWxhQGFtZC5jb20+OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLQ0KPiBr
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYyIDMvNV0gYXJtNjQ6IHp5bnFtcDogQWRkIFp5
bnFuTVAgbnZtZW0gbm9kZXMNCj4NCj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQg
ZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2UuIFVzZSBwcm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5p
bmcgYXR0YWNobWVudHMsIGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBP
biAxOS8xMC8yMDIzIDA4OjA2LCBQcmF2ZWVuIFRlamEgS3VuZGFuYWxhIHdyb3RlOg0KPiA+IEFk
ZCBudm1lbSBEVCBub2RlcyBmb3IgWnlucU1QIFNPQw0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
UHJhdmVlbiBUZWphIEt1bmRhbmFsYSA8cHJhdmVlbi50ZWphLmt1bmRhbmFsYUBhbWQuY29tPg0K
PiA+IC0tLQ0KPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL3hpbGlueC96eW5xbXAuZHRzaSB8IDU5
DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDU3
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJj
aC9hcm02NC9ib290L2R0cy94aWxpbngvenlucW1wLmR0c2kNCj4gPiBiL2FyY2gvYXJtNjQvYm9v
dC9kdHMveGlsaW54L3p5bnFtcC5kdHNpDQo+ID4gaW5kZXggYjYxZmM5OWNkOTExLi5iNzQzM2U2
YjlkNmMgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy94aWxpbngvenlucW1w
LmR0c2kNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL3hpbGlueC96eW5xbXAuZHRzaQ0K
PiA+IEBAIC0xOTQsMTQgKzE5NCw2OSBAQCB6eW5xbXBfcG93ZXI6IHp5bnFtcC1wb3dlciB7DQo+
ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWJveC1uYW1lcyA9ICJ0eCIsICJyeCI7
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgIH07DQo+ID4NCj4gPiAtICAgICAgICAgICAgICAg
ICAgICAgbnZtZW1fZmlybXdhcmUgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBudm1lbS1m
aXJtd2FyZSB7DQo+DQo+IE5vZGUgbmFtZXMgc2hvdWxkIGJlIGdlbmVyaWMuIFNlZSBhbHNvIGFu
IGV4cGxhbmF0aW9uIGFuZCBsaXN0IG9mIGV4YW1wbGVzDQo+IChub3QgZXhoYXVzdGl2ZSkgaW4g
RFQgc3BlY2lmaWNhdGlvbjoNCj4gaHR0cHM6Ly9kZXZpY2V0cmVlLXNwZWNpZmljYXRpb24ucmVh
ZHRoZWRvY3MuaW8vZW4vbGF0ZXN0L2NoYXB0ZXIyLWRldmljZXRyZWUtDQo+IGJhc2ljcy5odG1s
I2dlbmVyaWMtbmFtZXMtcmVjb21tZW5kYXRpb24NCltLdW5kYW5hbGEsIFByYXZlZW4gVGVqYV0g
T2theQ0KPg0KPg0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUg
PSAieGxueCx6eW5xbXAtbnZtZW0tZnciOw0KPg0KPiBJdCBkb2VzIG5vdCBsb29rIGxpa2UgeW91
IHRlc3RlZCB0aGUgRFRTIGFnYWluc3QgYmluZGluZ3MuIFBsZWFzZSBydW4gYG1ha2UNCj4gZHRi
c19jaGVjayBXPTFgIChzZWUgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3dyaXRp
bmctc2NoZW1hLnJzdA0KPiBvciBodHRwczovL3d3dy5saW5hcm8ub3JnL2Jsb2cvdGlwcy1hbmQt
dHJpY2tzLWZvci12YWxpZGF0aW5nLWRldmljZXRyZWUtDQo+IHNvdXJjZXMtd2l0aC10aGUtZGV2
aWNldHJlZS1zY2hlbWEvDQo+IGZvciBpbnN0cnVjdGlvbnMpLg0KW0t1bmRhbmFsYSwgUHJhdmVl
biBUZWphXSBNaXNzZWQgaXQsIFdpbGwgcnVuIGFuZCBzZW5kIFYzLg0KPg0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICNzaXplLWNlbGxzID0gPDE+Ow0KPiA+DQo+ID4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc29jX3JldmlzaW9uOiBzb2NfcmV2aXNpb25AMCB7DQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc29jX3JldmlzaW9uOiBzb2MtcmV2aXNp
b25AMCB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8
MHgwIDB4ND47DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfTsNCj4NCj4gV2Fz
bid0IHRoaXMgZml4ZWQgYWxyZWFkeSBieSBNaWNoYWw/DQpbS3VuZGFuYWxhLCBQcmF2ZWVuIFRl
amFdIFRvb2sgYmFzZSBvbiBTcmluaXZhcyBmb3ItbmV4dCByZXBvIGFuZCBNaWNoYWwncyBjaGFu
Z2VzIHdlcmUgbm90IHJlZmxlY3RlZCBpbiB0aGF0IHJlcG8uDQo+DQo+DQo+IEJlc3QgcmVnYXJk
cywNCj4gS3J6eXN6dG9mDQoNCg==
