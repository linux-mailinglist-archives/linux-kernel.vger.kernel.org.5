Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406CA7ECA9F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 19:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjKOSjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 13:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjKOSja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 13:39:30 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166069B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 10:39:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eG7k1qnG4rdgUgBOtcN/s2PtVLHl3zM/XOaAXzdChj3xvec5rkzA5H9O+cSJxWxbCyxlLiEFcOXmz79rHoX0xFf3Q4SW/osd3vJwsW0XU3F5W+C/lMPNlzle68f6kBv56psoFSn7iby4kzrD/bFe+VRndHSIOKfZvv+Ssh0OhIGmOpKL2BZ0TkbydGNUq8ChLtjD3AL5ROM0vty+fbv3GCZednIxPfvkhf63KMBvq3jkPN/nKojD82VYKL7aXxvQtUfhBvUuvZhnG7fevTdtVgPkXC5WWnwt1oyM7N9rZDHvXOvvMoyr9szIyNAug1ZAAeq0TosjEAQSBs8nce2Kig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qtaln+G1Z+cw+p6r4Z+I8GVnCNsrNnNWjgFyIL3hQYc=;
 b=AvcWDcT7pMHnwA/tKADmZLPdw7vsfQsdq19GKugGf0OJIsoeXyzL8ZN9Sx791/dQvsmHIY41DdhMuCkNE8OOsq0b6rRlJai6NTT0umumQdb4ozoli3j4YOuzO+XaOBKYZltv/Ige+E1GKq7/1NMvw1Ne2mFzFIRsviAfUO56LQXPMfbqUgP9QZOywmtyi607ge8zsm6x21grS8Q05NLJNmXc63h4hd/X3UNC7/bQRP2sad7ISPc8aWEsWw+nywRxtTVWKZozqhUT/u/NYN+/udpO+9Ka088x7fGYSNsTvlB5cpYtVSE+CPOaV+ZyQ6BFfgBkYSHM5BsruxlPv8EkXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qtaln+G1Z+cw+p6r4Z+I8GVnCNsrNnNWjgFyIL3hQYc=;
 b=unAedNsD2re7Sg1ijYW+uSGGIC5fV1hBeDZUareOosVMUXSKJcUD52+5uBpTYuDYlsQd0iFjOB84W42ss8RrB9+2lobJmdxc++cCurSao14rULijzolnBxbfaS0Uq2s0Ra64Bl2dE3br6LAqFjYGMRjsciTSDD9CDbaabvJNpJ0=
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 IA1PR12MB8496.namprd12.prod.outlook.com (2603:10b6:208:446::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 18:39:13 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::868d:4157:e79a:360]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::868d:4157:e79a:360%6]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 18:39:12 +0000
From:   "Lee, Alvin" <Alvin.Lee2@amd.com>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>
CC:     "Wu, Hersen" <hersenxs.wu@amd.com>,
        "Wheeler, Daniel" <Daniel.Wheeler@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: RE: regression/bisected/6.7rc1: Instead of desktop I see a horizontal
 flashing bar with a picture of the desktop background on white screen
Thread-Topic: regression/bisected/6.7rc1: Instead of desktop I see a
 horizontal flashing bar with a picture of the desktop background on white
 screen
Thread-Index: AQHaFukkIScshd5TeEuAyfTbKn5ADLB7sFB8gAABD4CAAAIigIAAA/xw
Date:   Wed, 15 Nov 2023 18:39:12 +0000
Message-ID: <DM8PR12MB5400EAB81E5FA10F4309A732D1B1A@DM8PR12MB5400.namprd12.prod.outlook.com>
References: <CABXGCsNRb0QbF2pKLJMDhVOKxyGD6-E+8p-4QO6FOWa6zp22_A@mail.gmail.com>
 <CABXGCsOqbLRHSkiz79NkVQ-wUtR7y-ZFHvhMw0+JJ_cY2AZmSw@mail.gmail.com>
 <CABXGCsPE9=Qp3Jg5hkRsTQoNgODnS_cXFU1d+hg3Baob40AaAA@mail.gmail.com>
 <edc5b75b-c08d-4c62-ae5e-089ffac27772@amd.com>
 <CABXGCsO=pdxorK9pO7qBPJM-xvgPPtpZqxLvQO4t2AK5qW3vcA@mail.gmail.com>
In-Reply-To: <CABXGCsO=pdxorK9pO7qBPJM-xvgPPtpZqxLvQO4t2AK5qW3vcA@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c4db4bac-b696-474f-95cb-271be7a11a1c;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-15T18:36:32Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5400:EE_|IA1PR12MB8496:EE_
x-ms-office365-filtering-correlation-id: f6c08d7b-812c-4112-cbe6-08dbe60a298b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E8wk5vnB4wnknL103s7UsNowDsG5TSuBH2CpOU3vFDYeQc/TTwp2iEzTFtZPkGreJv7n2ULL31d2aXzvFFAVDZctIPrfrxoHOZG6rXSvNnIhZzKy117HA671nFsIi4XfDDAKrd4/2Q9QsyfN1ltAfLfSmFNEiCF4gek2lFdgnpTX9KzFRTzNpzdjA3x6VmmJ0Fx4XgqEMGAcPDKK6bSDwoO6LPOVpXbWHrUdHPIB4eQBxuvXtabXvXIBeaqOXkXnYNahiCFhRglDD4ytg+p5A0Ib3wooEDL2hnF6ll4voUuuDS1cYnXhlzoVB2qiuFcQXLPD2REOnbuc8YTHFhmj1k/HDrabAplL6T4IhjazjtlXWjsmFr15DEIgpXOp1VU74pTSqjpPBCTkukq2Iai11pBDnbvSHWmAARMC3dME/d8CVOxmvw+maVYtf3gSeGOb4lheC1LDzQfVy+uDiQdTfvV4zhKdQg1cVb3KNx0mqinNg6XUbPXQhhGC4vUxJ5Wr+02YNvdyRmb2p6oUYrUjT+dOIJA3bsu4yO38/1Q+TqsyuSgKtFHb4r9bHoJOp4BE+KZ5qTm76tabf/WyiNuLz9dBUfHRiQvyNoT9yYbwKCGJDGAFAogyQ4YFPbowaOrv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(4326008)(6506007)(53546011)(86362001)(5660300002)(8936002)(8676002)(7696005)(38070700009)(38100700002)(2906002)(478600001)(66556008)(55016003)(9686003)(110136005)(66476007)(6636002)(316002)(54906003)(66946007)(76116006)(26005)(52536014)(66446008)(64756008)(71200400001)(41300700001)(33656002)(122000001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHNXaUlHQkFYdllmZndLbmdTdmVTY2JUbHpGZE9QaTJ3RUJERWRjSTFqbitT?=
 =?utf-8?B?NXl2ZWg4aGVjK2VtUGw3N2RDbGlwc29RY3BGeGg2YlV1L21KL3kxUEJLUThm?=
 =?utf-8?B?bExnL3M1UEZaYlpiMTFpMUs3V1N6WWZNdU9iQjNqdll0N2pBUmRkaWkwS0Ix?=
 =?utf-8?B?aWZLWkxzK00ycVdNYnRnNkNJYysxQlVBaUxUVkpCQkRXd2ZzdEFGbXUxUWZR?=
 =?utf-8?B?OUZpVTBhS0kyd3FOQlNJRVNoWC8wbXdpN1lLZGJ0Q3UzOWZXYjVOWS9KUERF?=
 =?utf-8?B?cEVFSGlYbm1zYVZvYWY3VnBhSE1pZW5TWStOUEh1akg2QlhvTDdMVXArcndR?=
 =?utf-8?B?MXhIQ3JHTzFPSVN1ZlpSeUt3azRMTVE4RkQxY0hVUFlDVU1VNytCS2dJRWhI?=
 =?utf-8?B?Tng2Y0ZXSDJvUEVmd3lIb093V3ZCaHh4dzJPUHgveEhLbkYrM1kzVFoxV2Nm?=
 =?utf-8?B?aWpUTWpsdXUzRXlXMGZKUHkrT2FUcHRQbUdwb0o4eGJGd3pNdUNyS2RTMnVO?=
 =?utf-8?B?Z1cvMkVpeEpLcjNQR01QY2NjeWpFUTJMUE1LMHRYYWppL2ZZVlI1NnRlNTdl?=
 =?utf-8?B?VndYanB4S3d3YlBabm1GZGhMR01hLy9SYVVTV0xRLyt3d2I2WXhjVkpjdVY0?=
 =?utf-8?B?U0REYmZOb3lpRFYvY3RpTHIva0syM3RrMXZqKzl0bWJQVDFKMytsUzJJYndk?=
 =?utf-8?B?dDFvVlVHSkswL0JjQkc3REc0eEdTOS9ja0c5cjM0dit6NGZ4QU9nOTMzTnVk?=
 =?utf-8?B?REIwdGlvUjdZOHlGbmdRbWZ3UnhQODBhTko0V3liUU5Ra3Q3YllrUldYclBn?=
 =?utf-8?B?bWFjQ3FJUi82cGZVM25MRTNHc2V3cXVrUTV1dDFzMGxFOWgzaCtrVDYwbTc1?=
 =?utf-8?B?aDdRQVBMWVlIYlhacU5VQlhsZnpuY00xTys4OHltOXIwYyswM2NtNllPNy9P?=
 =?utf-8?B?Nk9rbHRxc1c2NnVkeXNQSUZhMUNpUGM1cFh5TDkvalhHb25KcGdaMytFMVpy?=
 =?utf-8?B?bDRTUFNKZlRuUmQrSzFlNEJOSE5DNGg3MTc3Y2pTb205cFNjWlo3emgvNlFj?=
 =?utf-8?B?Wkt4SG81MFE5d3E5VjV0dzhXYzY5U1c2WGhMQlNDRXdFWUlsNjE0c05BNXFW?=
 =?utf-8?B?ZWZpWnAwZ1NERVpqZjRLd2QzSEJ0enk4azVxbWQ3N2xpZTNpUnZJZnlhS0xD?=
 =?utf-8?B?N25waHVzdWhoSStVbkFlK0NsUStMRnNRNmcvSnR4ejBPbGx5eW5hTHZ2OFU3?=
 =?utf-8?B?RXVDckZmVlFYQ2pjdzR0TktnUmpQbEdIRWxOSlNZV2VKeldrb3pkbGViMUxH?=
 =?utf-8?B?NVFHbTd6RjFXOXMrSkVjVlVTWjdaVGdoejdaZ0syWTh4T3lYQnpDaVJFUFRZ?=
 =?utf-8?B?QnlObUJ1dzBNOE5OOGlWNTc2WGE2TGdybnl1dHJ5S1ZzVVlmR0w1bitPYzY3?=
 =?utf-8?B?ellBNlBoYllWbHdOazRQU0Evc1FXWmJmUVVqTjl2UVVmdm05WUFGbkdjc2hn?=
 =?utf-8?B?TWtQUXZsbFBNQjl1UzR4aHlmaStOQTU1cjBVUVVUVndEc1p6MmVXeUZmaERn?=
 =?utf-8?B?MTJIamZQdnczMHNxVkpjdElEMEQ0eXYzM1hqRlhLYms1aE90VWd0SE44LzFX?=
 =?utf-8?B?YXJ0b0FxMEptWEh1aFBXMW5wSE13eHYyNGRUd3VSdEhhSjB3eDRaVGdRTmJi?=
 =?utf-8?B?dkRSOEt3UmhvV3FGdmEvSlIzaml5dDhZcVY3SWtUUEY5QmtubjNocmZaeEdz?=
 =?utf-8?B?N0dpZUkyNUcwQzJlM1V5U0dFMlNrRitQc0E2cmlGcXlydVdENStUcDB4NDlL?=
 =?utf-8?B?MVk1QlcwQ2s4S0FJZTlmb0N5bVlWWi85RkJKN0RRdDBsaE4xVWFZL1hYcmhJ?=
 =?utf-8?B?bnNHUHd2VWp3YVRJN1JVeTRqMnRLR0tzVG1xK0l5M2IxS0JRM1Q0d2Y4dCtI?=
 =?utf-8?B?amJFS280b3VML1lueXNGdlQ5bDk0d3JqZ0pJRWIwQXUrNDQzOGRlZ3V4bXk1?=
 =?utf-8?B?dXNDdUphbXgyaTJ4RU5ML281SHpNOXhWVk0yZmg4azAyRWxlOVp5Y0ZIbklT?=
 =?utf-8?B?VWVBVkJPb2ZJdmhWYVAzVFZUejU2S1p1dkh2L3Z1eW5CQXpBOEtWT2RaeVdh?=
 =?utf-8?Q?sM20=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c08d7b-812c-4112-cbe6-08dbe60a298b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 18:39:12.3536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TCwYmmooOtXTuQC8Y9jYOKJ01s0MQRyyPG8PkQt7GQ/U9vzzkOrQzFaqzhJ4hjTd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8496
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRoaXMgY2hhbmdlIGhhcyBhIERN
Q1VCIGRlcGVuZGVuY3kgLSBhcmUgeW91IGFibGUgdG8gdXBkYXRlIHlvdXIgRE1DVUIgdmVyc2lv
biBhcyB3ZWxsPw0KDQpUaGlzIHZlcnNpb24gbWlzbWF0Y2ggaXNzdWUgaXMgc29tZXRoaW5nIEkn
bGwgbmVlZCB0byBmaXggaW4gZHJpdmVyIGZvciBMaW51eC4NCg0KVGhhbmtzLA0KDQpBbHZpbg0K
DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTWlraGFpbCBHYXZyaWxvdiA8bWlr
aGFpbC52LmdhdnJpbG92QGdtYWlsLmNvbT4NClNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMTUs
IDIwMjMgMToyMiBQTQ0KVG86IE1haGZvb3osIEhhbXphIDxIYW16YS5NYWhmb296QGFtZC5jb20+
DQpDYzogTGVlLCBBbHZpbiA8QWx2aW4uTGVlMkBhbWQuY29tPjsgV3UsIEhlcnNlbiA8aGVyc2Vu
eHMud3VAYW1kLmNvbT47IFdoZWVsZXIsIERhbmllbCA8RGFuaWVsLldoZWVsZXJAYW1kLmNvbT47
IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IExpbnV4IExp
c3QgS2VybmVsIE1haWxpbmcgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBhbWQtZ2Z4
IGxpc3QgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPg0KU3ViamVjdDogUmU6IHJlZ3Jl
c3Npb24vYmlzZWN0ZWQvNi43cmMxOiBJbnN0ZWFkIG9mIGRlc2t0b3AgSSBzZWUgYSBob3Jpem9u
dGFsIGZsYXNoaW5nIGJhciB3aXRoIGEgcGljdHVyZSBvZiB0aGUgZGVza3RvcCBiYWNrZ3JvdW5k
IG9uIHdoaXRlIHNjcmVlbg0KDQpPbiBXZWQsIE5vdiAxNSwgMjAyMyBhdCAxMToxNOKAr1BNIEhh
bXphIE1haGZvb3ogPGhhbXphLm1haGZvb3pAYW1kLmNvbT4gd3JvdGU6DQo+DQo+IFdoYXQgdmVy
c2lvbiBvZiBETVVCIGZpcm13YXJlIGFyZSB5b3Ugb24/DQo+IFRoZSBlYXNpZXN0IHdheSB0byBm
aW5kIG91dCB3b3VsZCBiZSB1c2luZyB0aGUgZm9sbG93aW5nOg0KPg0KPiAjIGRtZXNnIHwgZ3Jl
cCBETVVCDQo+DQoNClNhcHBoaXJlIEFNRCBSYWRlb24gUlggNzkwMCBYVFggUFVMU0UgT0M6DQri
na8gZG1lc2cgfCBncmVwIERNVUINClsgICAxNC4zNDEzNjJdIFtkcm1dIExvYWRpbmcgRE1VQiBm
aXJtd2FyZSB2aWEgUFNQOiB2ZXJzaW9uPTB4MDcwMDIxMDANClsgICAxNC43MjU1NDddIFtkcm1d
IERNVUIgaGFyZHdhcmUgaW5pdGlhbGl6ZWQ6IHZlcnNpb249MHgwNzAwMjEwMA0KDQpSZWZlcmVu
Y2UgR0lHQUJZVEUgUmFkZW9uIFJYIDc5MDAgWFRYIDI0RzoNCuKdryBkbWVzZyB8IGdyZXAgRE1V
Qg0KWyAgIDExLjQwNTExNV0gW2RybV0gTG9hZGluZyBETVVCIGZpcm13YXJlIHZpYSBQU1A6IHZl
cnNpb249MHgwNzAwMjEwMA0KWyAgIDExLjc3MzM5NV0gW2RybV0gRE1VQiBoYXJkd2FyZSBpbml0
aWFsaXplZDogdmVyc2lvbj0weDA3MDAyMTAwDQoNCg0KLS0NCkJlc3QgUmVnYXJkcywNCk1pa2Ug
R2F2cmlsb3YuDQo=
