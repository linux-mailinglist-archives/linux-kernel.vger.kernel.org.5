Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6545D7C7A2F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 01:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443193AbjJLXEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 19:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443090AbjJLXD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 19:03:59 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44D5116;
        Thu, 12 Oct 2023 16:03:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHQzsryaYx/ZEs4ISrnMF1NB/HSDfMPteewfMfuS/aH0kIhGHycNvMYZQd+awBGRrcMaOO2faOM/ge+ASlkktITliAIfCGsdRdYHYpeGvdhFy0+1HQN5yWqt6+U2ujUOvlRPGfIYI1eurIbuMsPt04qaR2vgyOn3Xsz5nYOBFi6ZP9zGTKOBnzD7lKXZZNEWRenKKm1AE3e7AXtsWLEfImkNxEZ2LhtzJkEYSMAjpFwEMXu/eTdlx9VOkIE8XkeJoNhjabKwVSYPVkXUIBzkIL+pqroD7LXng2qWj+A21o3Rod+kJT3GrQAQaJWis5GyMxjBJ3N1nxrWgcFlpZ3Z2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBs9kupXf+yFEvYy0Jb5C/qK4hAysqVLeeTKtn9ywoY=;
 b=Ym+UdOPsMSG/mIGMoac1HKHoUdyjyjsmwXrVd5g0wgbvYh+AVY9wq0WMIThEBBTDMVwNA4yWDkHFAlP6ySyhXAFWUq6BNeq8KohSWSYSiYzSHIvnyGG849GaSA9MX95jUu/TGkDPS35n7Ysbkp6Y3ULBPKu/cc4VRKvVrJgYfvEAlpw/NOYa5DC6ZzNX/xIWd3Dm1pZkUhxpeimHFAuqBlE4X2UhAo02BcOPEBcTU31/qgyNTvmmLtHT04P0xjoN5478zbUVY6z1TjBiPNgzpKU/NGAVeH/QXNuqy70+f/RENu8fH5fhzV0KDW76FtTmi9kJpoKpdyQYPlU45tR2bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBs9kupXf+yFEvYy0Jb5C/qK4hAysqVLeeTKtn9ywoY=;
 b=WWwsy+BdylzLwp2JNXaLUUUIl6g7n4gY9z841Nq1g2ySK8hK9/4ATZYcbzqep+jZ6XKR3RplINHimcu+s4rqnSLU2w0uOOpqDbu229cdZ1o8QyRy42pc14lWElsGg6HXD5h7FRWaKbXKOmICU3ttQNzjcslCdOWDICEft85SpOt+x12LWX6b115MkkdiL6hiSn2ozJRhToMc0tW1GFkUkXuVBZoFRLfXi8MpTyqrpkb4y/EKOeXZukitxrizzZA4BTTVCFWBKtT1LRzCmLkGoNBhNPGngu/+tEbwYmGXR6z9sUAjPbEIlBOb5JfwcBgXU6lvg9qMz0+lX5AapZ3AFA==
Received: from BN9PR12MB5068.namprd12.prod.outlook.com (2603:10b6:408:135::21)
 by SA1PR12MB6947.namprd12.prod.outlook.com (2603:10b6:806:24e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 23:03:34 +0000
Received: from BN9PR12MB5068.namprd12.prod.outlook.com
 ([fe80::e00:7275:f848:ae4b]) by BN9PR12MB5068.namprd12.prod.outlook.com
 ([fe80::e00:7275:f848:ae4b%3]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 23:03:34 +0000
From:   Liming Sun <limings@nvidia.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Vadim Pasternak <vadimp@nvidia.com>,
        David Thompson <davthompson@nvidia.com>,
        Mark Gross <markgross@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
CC:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/1] platform/mellanox: mlxbf-tmfifo: Fix a warning
 message
Thread-Topic: [PATCH v1 1/1] platform/mellanox: mlxbf-tmfifo: Fix a warning
 message
Thread-Index: AQHZ94YFlBkdvRjGj0Cl1AIVKIdf4LA8uTSAgAAv4sCAABbRgIAE3BeggADWHwCABB9KsA==
Date:   Thu, 12 Oct 2023 23:03:33 +0000
Message-ID: <BN9PR12MB5068E2E10585B910E712AF37D3D3A@BN9PR12MB5068.namprd12.prod.outlook.com>
References: <bb8bc77e6ecc2287fc9110cfa08caa48eb2a0385.1696508228.git.limings@nvidia.com>
 <35467b21-941f-c829-1ad8-b4e7319dbc04@redhat.com>
 <BN9PR12MB50687C00EDAFC2B1A058E1E3D3C9A@BN9PR12MB5068.namprd12.prod.outlook.com>
 <4d40eacb-382a-f0e9-2dcd-9f9e8c7ca9fd@redhat.com>
 <BN9PR12MB5068173E789479AA99FDF725D3CEA@BN9PR12MB5068.namprd12.prod.outlook.com>
 <81fb9a8a-0cb4-7799-7f47-603d88e08659@redhat.com>
In-Reply-To: <81fb9a8a-0cb4-7799-7f47-603d88e08659@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5068:EE_|SA1PR12MB6947:EE_
x-ms-office365-filtering-correlation-id: f1fd1211-1c60-4a1c-1817-08dbcb7775b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c5m+K4gpBR270l59t8c8asLldj9yHipAbN+p/zvHXlot5QfHrGNw3nXXAEhk29gnp40K0UfL0E+HqvMrEhUJ8MWBuEdRlSCgPDAJE38nBd7H9a90M+AA/shvGJsH+lt8y+XkJq9Uw7qhcto6hR3qtLk6E1BI3ogZW/OW/TgZhpPiM6n0E6Dewls+QJEb7mdvYLIicLTcDpf12zpv9orQbKyTDEJtwaontqQldzWflKHIAR+y+ot2xCIWyLhQm5MNjpMp3MFNy8p+lNssU+NEAgHmJVt1MNZZC7OUXVZSmIdmhQzEUH3gl6FswUjTe0bRCL/RrfBbVQOLhUZwE/1tenJhig2LPrwQ8lAkQ0zmPW/wWRxRBV4FD7wr4F3Ko+R917MUQjuCbAzfnSgdNvXu8jRSoqyY9IOp1r2nUZDD+nGqe8UUp9hzRLt0MDWQqB2nRY9jOWZ+J0cRRXVnRJ4FQerl3F+yvUFZgYGp+I4fOgC+RI3mSc/B2RaqiuDo0vATFQpuJjJZkPvOhijP93aWaPBdLeqO3jjlw6Kd0s67fg62dhxtfp5nVkiZxBI1fkN5QXCuMQqFGES15/563tdWOblwEdonRR0B9wPNvrIAa8xXvYe3SFTifPaQD2AhkiGO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5068.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(83380400001)(316002)(52536014)(55016003)(110136005)(38100700002)(8676002)(122000001)(76116006)(38070700005)(8936002)(86362001)(33656002)(54906003)(4326008)(66446008)(66476007)(64756008)(66556008)(66946007)(6506007)(7696005)(53546011)(2906002)(41300700001)(71200400001)(15650500001)(9686003)(5660300002)(26005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1EvRmtNOTAxb2dGbzN6OVVrZStjMmtqZ1RrNDRwZkp6Z20veDBKRFVlaVI0?=
 =?utf-8?B?K2hCZDJLakZvMDV1Q1FOQmxpSklpQ2hUcG5BZ3pGV1ZIZktFOEpDUHJORk1O?=
 =?utf-8?B?alN3Tm83dWUrTWF5eW0vdW1kNmZxMWovbjZzYjlTMjhDVk8wdlA1ZlZVZ0lx?=
 =?utf-8?B?UHdsL2hTbGRDR0ZxcGJCTVh2cW1ROGRERkh2cWdKZW5IVzZldnd5dlEzNEYr?=
 =?utf-8?B?NkxpUzRHY0tIRmRCZTlScC9UVXB1YURSNThTTklJUWpFQlJlNThtMmdEWmt5?=
 =?utf-8?B?WGlFbmo0MnBnMDRaU2o3TzhUbEh4YTVNNG4vQXV1d1NTT1MyQWlleUdRRWtG?=
 =?utf-8?B?bUpjTGh4c0pGYTQrSmpnWkNWS2dtcjU4dm9BajIxR29wNXhYMkl4cGNkMFBT?=
 =?utf-8?B?QWtQelJxVWpKY0l3azVvU1lxT0o3UDdpTnQ0QzJWcTFaWkxEY1UvQllUY1o1?=
 =?utf-8?B?MUNudHBVME8rRk5pSFdBTWdkVlFPb0tzL2pBcGZtL3R5dE00R012aXJjOG1G?=
 =?utf-8?B?aURsMTJKSGpsYUwrS1YwZ3lnNWRnZENSK2hoMGhhdm50SE1PKytTOTZIbDRW?=
 =?utf-8?B?Y3BqRjJ0d3F2OWxRTUpHZkcwN1JmMUI5Yy9lQXJNWlhrdld2ZHRGUy9jbkhL?=
 =?utf-8?B?eUhDSXg3VEFROWYxWUpTaVJMeGlBZWJQTnlOeUpzaUczMmtHbFFvTkcxM2pt?=
 =?utf-8?B?bUJyMTBBU2I1Z1pmSmRoTHFCSTAwa0x1dU5XNGx5WWs1cVl0eHAyN0JCUjk1?=
 =?utf-8?B?eW1jUWIzc2prYitaRlJhYURtZzlQOHVZdXZyNzYrZE9IcWpmZTFJd2NNc2xy?=
 =?utf-8?B?aGp0NGhyWU1VS25pbmhSdklmU1FiTStNT1JRK1VrY1dvR0JzV0hodTZLeTFl?=
 =?utf-8?B?bktVbEsvek5mNW1OcWc4UzNvWDhHY0ExaG1pZU1PeGNHZWZtT3NFTjh4RkZz?=
 =?utf-8?B?Um9FOUsyQzJ4blVBcHVzWVNzWkgramM5OWNmK1p2c0pzb2xUUWs4Y3RBWmg3?=
 =?utf-8?B?V3JHR3pKa0RQalRYUDQ2ejBHdTVrcEV5aEZ5OThZODlJdkZuWTRIenJHbHFw?=
 =?utf-8?B?eE9oNWRvUks0QjRvUkphd281SS9wNWhZUWpReVZ3d0lIcEM5dndlOWxSdG51?=
 =?utf-8?B?MHMrNXluTWFkTitiT0ZwWkd3MzRwZjQwb1BRRnBmMUQwejNnQzFVNlVFU1Zi?=
 =?utf-8?B?aHFYeUt5VUh2Yk82ODlxWDNScWJuS3kvVXBTcTUzWmVVK2hGbTR3NW1HY2k0?=
 =?utf-8?B?eHA5WmYxQmpmclNseHFGK2FCdTJmVFdXRkQvZHBUUTFtUW41bEh3TjZIRkdW?=
 =?utf-8?B?TDkwTmpoK3E3cEU2OG5KS3pMb2YzenNvcTVQRGgrNm56UjF5bFdEWUVobkNr?=
 =?utf-8?B?dEtiSkRNRzJnSFRIN3pjWjBuMkJ0WEZRMVhYL2xpTStHSjI4N253YUxRUGxp?=
 =?utf-8?B?c2NFZjVpV3BBUHhIM3o5OEJGT3RqaFlMRWcyYzJYTHNjRWgzS29HSU5nYVBN?=
 =?utf-8?B?dzZwVDFiS0RHdVpwSDF4Q2lXNVo5SnpieE1vNm45bE1QeW5meWdaaTEzL2R0?=
 =?utf-8?B?TTM0U0ZqR2tEdUIzVDkyM1FJN1hyU3cwd09sRVFmTWJpaDUxTDNnZitsQ2xW?=
 =?utf-8?B?S1JPY2lDNFBwdmdwZUNLN3BqaENid2lNcGxqQzA2bEV5ZUdoMmZ3RU1pWFcz?=
 =?utf-8?B?cFNXZThBK0RDdzgzMUlJSjBkTzR6WHJNajFqNDhqLzNpK1ViT2VoblFVRnNE?=
 =?utf-8?B?ZkRlRnhzZytXN2x5S20xbzVLRUNHNmpHaXNxWkFPRHMxRCt6ZWJ3aU9SYkpW?=
 =?utf-8?B?bnNCcWs5UVZQM1EvZFJYQTRvWkNoa0wyb3pKVWFKOHp5aDRKOTUyR2hYTklX?=
 =?utf-8?B?YTk5NG1ybEZmWDhXUU03ZFRoTTFYZGxDa2lmSzhISm5DWWdkVWNFSTFYR20r?=
 =?utf-8?B?QTBDMmdhRFVEVmpUbnJVMXFnMjlTNUFzWG5BOExRK21MTWlGY1VJc0g4ZVdX?=
 =?utf-8?B?YXMwSGtUb3cxejZyck96S1N1M2NaUnlWclIvd20wcTB6ZHJvN3V2NTc5ckFY?=
 =?utf-8?B?cVNPM0FHVHFkYVJPcmJDdXAyNEVqdU9kd015S3VCQ2pOU09uQ1BKQzdnbDRj?=
 =?utf-8?Q?JF/4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5068.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1fd1211-1c60-4a1c-1817-08dbcb7775b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 23:03:33.9149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QqIUIhC2Dq6FStOoPSqKmzbDo4Bs/bCy+LzsiMI4muEdSXZW9zXx5SmpWcSbLoOvdmSDTph6EgwbI3Tj2R2EuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6947
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGFucyBkZSBHb2VkZSA8
aGRlZ29lZGVAcmVkaGF0LmNvbT4NCj4gU2VudDogVHVlc2RheSwgT2N0b2JlciAxMCwgMjAyMyA0
OjA2IEFNDQo+IFRvOiBMaW1pbmcgU3VuIDxsaW1pbmdzQG52aWRpYS5jb20+OyBWYWRpbSBQYXN0
ZXJuYWsNCj4gPHZhZGltcEBudmlkaWEuY29tPjsgRGF2aWQgVGhvbXBzb24gPGRhdnRob21wc29u
QG52aWRpYS5jb20+OyBNYXJrDQo+IEdyb3NzIDxtYXJrZ3Jvc3NAa2VybmVsLm9yZz47IERhbiBD
YXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAbGluYXJvLm9yZz4NCj4gQ2M6IHBsYXRmb3JtLWRyaXZl
ci14ODZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMS8xXSBwbGF0Zm9ybS9tZWxsYW5veDogbWx4YmYtdG1maWZv
OiBGaXggYSB3YXJuaW5nDQo+IG1lc3NhZ2UNCj4gDQo+IEhpLA0KPiANCj4gT24gMTAvOS8yMyAy
MToyOCwgTGltaW5nIFN1biB3cm90ZToNCj4gPg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+ID4+IEZyb206IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+
DQo+ID4+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciA2LCAyMDIzIDE6MDcgUE0NCj4gPj4gVG86IExp
bWluZyBTdW4gPGxpbWluZ3NAbnZpZGlhLmNvbT47IFZhZGltIFBhc3Rlcm5haw0KPiA+PiA8dmFk
aW1wQG52aWRpYS5jb20+OyBEYXZpZCBUaG9tcHNvbiA8ZGF2dGhvbXBzb25AbnZpZGlhLmNvbT47
DQo+IE1hcmsNCj4gPj4gR3Jvc3MgPG1hcmtncm9zc0BrZXJuZWwub3JnPjsgRGFuIENhcnBlbnRl
ciA8ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3JnPg0KPiA+PiBDYzogcGxhdGZvcm0tZHJpdmVyLXg4
NkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MSAxLzFdIHBsYXRmb3JtL21lbGxhbm94OiBtbHhiZi10bWZpZm86
IEZpeCBhIHdhcm5pbmcNCj4gPj4gbWVzc2FnZQ0KPiA+Pg0KPiA+PiBIaSBMaW1pbmcsDQo+ID4+
DQo+ID4+IE9uIDEwLzYvMjMgMTc6NTAsIExpbWluZyBTdW4gd3JvdGU6DQo+ID4+PiBUaGFua3Mg
SGFucy4NCj4gPj4+DQo+ID4+PiBCZWxvdyBpcyB0aGUgbG9naWM6DQo+ID4+Pg0KPiA+Pj4gSVNf
VlJJTkdfRFJPUCgpIGlzIE9OTFkgc2V0IHRvIFRSVUUgZm9yIFJ4LCB3aGljaCBpcyBkb25lIGlu
IHR3byBwbGFjZXM6DQo+ID4+PiBMaW5lIDY5NjogICpkZXNjID0gJnZyaW5nLT5kcm9wX2Rlc2M7
DQo+ID4+PiBMaW5lIDc0MjogZGVzYyA9ICZ2cmluZy0+ZHJvcF9kZXNjOw0KPiA+Pj4NCj4gPj4+
IFNvIGxpbmUgNjM0IGJlbG93IHdpbGwgbmV2ZXIgaGFwcGVuIHdoZW4gSVNfVlJJTkdfRFJPUCgp
IGlzIFRSVUUgZHVlDQo+IHRoZQ0KPiA+PiBjaGVja2luZyBvZiBsaW5lIDYzMy4NCj4gPj4+IDYz
MyAgICAgICAgIGlmICghaXNfcngpDQo+ID4+PiAgNjM0ICAgICAgICAgICAgICAgICB3cml0ZXEo
ZGF0YSwgZmlmby0+dHguZGF0YSk7DQo+ID4+Pg0KPiA+Pj4gUGxlYXNlIGNvcnJlY3QgbWUgaWYg
aXQncyBteSBtaXN1bmRlcnN0YW5kaW5nLg0KPiA+Pg0KPiA+PiBJZiBJU19WUklOR19EUk9QKCkg
aXMgT05MWSBzZXQgdG8gVFJVRSBmb3IgUngsIHRoZW4gaXQNCj4gPj4gc2hvdWxkIHNpbXBseSAq
bm90KiBiZSBjaGVja2VkICphdCBhbGwqIGluIHRoZSB0eCBwYXRocy4NCj4gPg0KPiA+IElTX1ZS
SU5HX0RST1AoKSBpdHNlbGYgaXMgYWN0dWFsbHkgbm90IGNoZWNrZWQgaW4gdGhlIFR4IHBhdGgu
ICBJdCBpcyB0aGUgIiENCj4gSVNfVlJJTkdfRFJPUCgpIiB0aGF0IGNoZWNrcyB0aGUgUngvVHgs
IHNvbWV0aGluZyBsaWtlOg0KPiA+DQo+ID4gaWYgKCFJU19WUklOR19EUk9QKHZyaW5nKSkgew0K
PiA+IAlpZiAoaXNfcngpDQo+ID4gCQkuLi4NCj4gPiAJZWxzZQ0KPiA+IAkJLi4uDQo+ID4gfQ0K
PiA+DQo+ID4gVGhlIHJlYXNvbiBpcyB0aGF0IEkgdGhvdWdodCB3ZSBtaWdodCByZXVzZSB0aGUg
JyBJU19WUklOR19EUk9QJyBmb3IgVHgNCj4gbGF0ZXIuDQo+ID4NCj4gPiBIb3dldmVyLCBpZiB0
aGUgbG9naWMgbG9va3MgY29uZnVzaW5nLCBJIGNvdWxkIHJldmlzZSBpdCB0byBzb21ldGhpbmcg
bGlrZToNCj4gPg0KPiA+IGlmIChpc19yeCkgew0KPiA+IAlpZiAoIUlTX1ZSSU5HX0RST1AodnJp
bmcpKQ0KPiA+IAkJLi4uDQo+ID4gfSBlbHNlIHsNCj4gPiAJCS4uLg0KPiA+IH0NCj4gDQo+IFll
cyBwbGVhc2UgcmV2aXNlIHRoZSBsb2cgdG8gbG9vayBsaWtlIHRoaXMsIHRoaXMgc2hvdWxkIGFs
c28NCj4gZml4IHRoZSB3YXJuaW5nIHdpdGhvdXQgbmVlZGluZyB0byBpbml0aWFsaXplIGRhdGEg
dG8gMC4NCj4gDQo+IFNpbmNlIG5vdyBpbiB0aGUgdHggcGF0aCB5b3UgYXJlIGd1YXJhbnRlZWQg
dG8gZmlyc3QgZmlsbA0KPiBkYXRhIGJlZm9yZSBzZW5kaW5nIGl0Lg0KDQpUaGFua3MsIGRvbmUu
IFVwZGF0ZWQgaW4gdjIuDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IA0KPiBIYW5zDQo+IA0KPiANCj4g
DQo+ID4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4+PiBGcm9tOiBIYW5zIGRl
IEdvZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPg0KPiA+Pj4+IFNlbnQ6IEZyaWRheSwgT2N0b2Jl
ciA2LCAyMDIzIDg6NTQgQU0NCj4gPj4+PiBUbzogTGltaW5nIFN1biA8bGltaW5nc0BudmlkaWEu
Y29tPjsgVmFkaW0gUGFzdGVybmFrDQo+ID4+Pj4gPHZhZGltcEBudmlkaWEuY29tPjsgRGF2aWQg
VGhvbXBzb24gPGRhdnRob21wc29uQG52aWRpYS5jb20+Ow0KPiA+PiBNYXJrDQo+ID4+Pj4gR3Jv
c3MgPG1hcmtncm9zc0BrZXJuZWwub3JnPjsgRGFuIENhcnBlbnRlcg0KPiA8ZGFuLmNhcnBlbnRl
ckBsaW5hcm8ub3JnPg0KPiA+Pj4+IENjOiBwbGF0Zm9ybS1kcml2ZXIteDg2QHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+Pj4+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjEgMS8xXSBwbGF0Zm9ybS9tZWxsYW5veDogbWx4YmYtdG1maWZvOiBGaXggYQ0KPiB3
YXJuaW5nDQo+ID4+Pj4gbWVzc2FnZQ0KPiA+Pj4+DQo+ID4+Pj4gSGkgTGltaW5nLA0KPiA+Pj4+
DQo+ID4+Pj4gT24gMTAvNS8yMyAxNDoxOCwgTGltaW5nIFN1biB3cm90ZToNCj4gPj4+Pj4gVGhp
cyBjb21taXQgZml4ZXMgdGhlIHNtYXRjaCBzdGF0aWMgY2hlY2tlciB3YXJuaW5nIGluDQo+ID4+
Pj4+IG1seGJmX3RtZmlmb19yeHR4X3dvcmQoKSB3aGljaCBjb21wbGFpbnMgZGF0YSBub3QgaW5p
dGlhbGl6ZWQgYXQNCj4gPj4+Pj4gbGluZSA2MzQgd2hlbiBJU19WUklOR19EUk9QKCkgaXMgVFJV
RS4gVGhpcyBpcyBub3QgYSByZWFsIGJ1ZyBzaW5jZQ0KPiA+Pj4+PiBsaW5lIDYzNCBpcyBmb3Ig
VHggd2hpbGUgSVNfVlJJTkdfRFJPUCgpIGlzIG9ubHkgc2V0IGZvciBSeC4gU28gdGhlcmUNCj4g
Pj4+Pj4gaXMgbm8gY2FzZSB0aGF0IGxpbmUgNjM0IGlzIGV4ZWN1dGVkIHdoZW4gSVNfVlJJTkdf
RFJPUCgpIGlzIFRSVUUuDQo+ID4+Pj4+DQo+ID4+Pj4+IFRoaXMgY29tbWl0IGluaXRpYWxpemVz
IHRoZSBsb2NhbCBkYXRhIHZhcmlhYmxlIHRvIGF2b2lkIHVubmVjZXNzYXJ5DQo+ID4+Pj4+IGNv
bmZ1c2lvbiB0byB0aG9zZSBzdGF0aWMgYW5hbHl6aW5nIHRvb2xzLg0KPiA+Pj4+Pg0KPiA+Pj4+
PiBTaWduZWQtb2ZmLWJ5OiBMaW1pbmcgU3VuIDxsaW1pbmdzQG52aWRpYS5jb20+DQo+ID4+Pj4+
IC0tLQ0KPiA+Pj4+PiAgZHJpdmVycy9wbGF0Zm9ybS9tZWxsYW5veC9tbHhiZi10bWZpZm8uYyB8
IDIgKy0NCj4gPj4+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQ0KPiA+Pj4+Pg0KPiA+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wbGF0Zm9ybS9tZWxs
YW5veC9tbHhiZi10bWZpZm8uYw0KPiA+Pj4+IGIvZHJpdmVycy9wbGF0Zm9ybS9tZWxsYW5veC9t
bHhiZi10bWZpZm8uYw0KPiA+Pj4+PiBpbmRleCBmMzY5NmE1NGEyYmQuLmNjYzRiNTFkMzM3OSAx
MDA2NDQNCj4gPj4+Pj4gLS0tIGEvZHJpdmVycy9wbGF0Zm9ybS9tZWxsYW5veC9tbHhiZi10bWZp
Zm8uYw0KPiA+Pj4+PiArKysgYi9kcml2ZXJzL3BsYXRmb3JtL21lbGxhbm94L21seGJmLXRtZmlm
by5jDQo+ID4+Pj4+IEBAIC01OTUsOCArNTk1LDggQEAgc3RhdGljIHZvaWQgbWx4YmZfdG1maWZv
X3J4dHhfd29yZChzdHJ1Y3QNCj4gPj4+PiBtbHhiZl90bWZpZm9fdnJpbmcgKnZyaW5nLA0KPiA+
Pj4+PiAgew0KPiA+Pj4+PiAgCXN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2ID0gdnJpbmctPnZx
LT52ZGV2Ow0KPiA+Pj4+PiAgCXN0cnVjdCBtbHhiZl90bWZpZm8gKmZpZm8gPSB2cmluZy0+Zmlm
bzsNCj4gPj4+Pj4gKwl1NjQgZGF0YSA9IDA7DQo+ID4+Pj4+ICAJdm9pZCAqYWRkcjsNCj4gPj4+
Pj4gLQl1NjQgZGF0YTsNCj4gPj4+Pj4NCj4gPj4+Pj4gIAkvKiBHZXQgdGhlIGJ1ZmZlciBhZGRy
ZXNzIG9mIHRoaXMgZGVzYy4gKi8NCj4gPj4+Pj4gIAlhZGRyID0gcGh5c190b192aXJ0KHZpcnRp
bzY0X3RvX2NwdSh2ZGV2LCBkZXNjLT5hZGRyKSk7DQo+ID4+Pj4NCj4gPj4+Pg0KPiA+Pj4+IFRo
aXMgd2lsbCBmaXggdGhlIHdhcm5pbmcgYnV0IG5vdCB0aGUgaXNzdWUgYXQgaGFuZC4gQXMgRGFu
IHBvaW50ZWQNCj4gPj4+PiBvdXQgaW4gaGlzIG9yaWdpbmFsIGJ1ZyByZXBvcnQsIHRoZSBpc3N1
ZSBpcyB0aGF0IGFmdGVyOg0KPiA+Pj4+DQo+ID4+Pj4gNzgwMzRjYmVjZTc5ICgicGxhdGZvcm0v
bWVsbGFub3g6IG1seGJmLXRtZmlmbzogRHJvcCB0aGUgUnggcGFja2V0IGlmDQo+IG5vDQo+ID4+
Pj4gZGVzY3JpcHRvcnMiKQ0KPiA+Pj4+DQo+ID4+Pj4gV2Ugbm93IGhhdmUgdGhpcyBJU19WUklO
R19EUk9QKCkgY2hlY2sgaW4gdGhlIHBhdGgsIHdoaWNoIGRlc3BpdGUNCj4gPj4+PiB0aGUgc3Vi
amVjdCB3cml0ZXEoZGF0YSwgZmlmby0+dHguZGF0YSk7aXMgY3VycmVudGx5IGJlaW5nIGFwcGxp
ZWQgdG8gYm90aA0KPiByeA0KPiA+PiBhbmQNCj4gPj4+PiB0eCB2cmluZy1zDQo+ID4+Pj4gYW5k
IHdoZW4gdGhpcyByZXR1cm5zIHRydWUgdGhlIG1lbWNweSBmcm9tIHRoZSByaW5nIHRvICZkYXRh
DQo+ID4+Pj4gd2lsbCBub3QgaGFwcGVuLCBidXQgdGhlIGNvZGUgd2lsbCBzdGlsbCBkbzoNCj4g
Pj4+Pg0KPiA+Pj4+IHdyaXRlcShkYXRhLCBmaWZvLT50eC5kYXRhKTsNCj4gPj4+Pg0KPiA+Pj4+
IFNvIHlvdSBtYXkgaGF2ZSBzaWxlbmNlZCB0aGUgd2FybmluZyBub3csIGJ1dCB5b3Ugd2lsbCBz
dGlsbCB3cml0ZQ0KPiA+Pj4+IGRhdGEgbm90IGNvbWluZyBmcm9tIHRoZSB2cmluZyB0byB0cmFu
c21pdC4gVGhlIG9ubHkgZGlmZmVyZW5jZQ0KPiA+Pj4+IGlzIHlvdSBhcmUgbm93IGd1YXJhbnRl
ZWQgdG8gd3JpdGUgYWxsIHplcm9lcy4NCj4gPj4+Pg0KPiA+Pj4+IE5vdGUgYW5vdGhlciBvbGRl
ciBpc3N1ZSBpcyB0aGF0IGlmIHlvdSBoaXQgdGhlIG5vdCBlbm91Z2ggc3BhY2UNCj4gPj4+PiBw
YXRoOg0KPiA+Pj4+DQo+ID4+Pj4gICAgICAgIH0gZWxzZSB7DQo+ID4+Pj4gICAgICAgICAgICAg
ICAgIC8qIExlZnRvdmVyIGJ5dGVzLiAqLw0KPiA+Pj4+ICAgICAgICAgICAgICAgICBpZiAoIUlT
X1ZSSU5HX0RST1AodnJpbmcpKSB7DQo+ID4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgaWYg
KGlzX3J4KQ0KPiA+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWVtY3B5KGFk
ZHIgKyB2cmluZy0+Y3VyX2xlbiwgJmRhdGEsDQo+ID4+Pj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgbGVuIC0gdnJpbmctPmN1cl9sZW4pOw0KPiA+Pj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgIGVsc2UNCj4gPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIG1lbWNweSgmZGF0YSwgYWRkciArIHZyaW5nLT5jdXJfbGVuLA0KPiA+Pj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxlbiAtIHZyaW5nLT5jdXJfbGVuKTsNCj4g
Pj4+PiAgICAgICAgICAgICAgICAgfQ0KPiA+Pj4+ICAgICAgICAgICAgICAgICB2cmluZy0+Y3Vy
X2xlbiA9IGxlbjsNCj4gPj4+PiAgICAgICAgIH0NCj4gPj4+Pg0KPiA+Pj4+IFRoZW4gZXZlbiBp
ZiBJU19WUklOR19EUk9QKCkgcmV0dXJucyB0cnVlIHlvdSBhcmUgb25seSBpbml0aWFsaXppbmcg
c29tZQ0KPiA+PiBieXRlcw0KPiA+Pj4+IG9mIHRoZSA4IGJ5dGVzIGRhdGEgdmFyaWFibGUgYW5k
IHRoZSBvdGhlciBieXRlcyB3aWxsIHN0YXkgYXQgd2hhdGV2ZXINCj4gPj4gcmFuZG9tDQo+ID4+
Pj4gdmFsdWUgdGhleSBoYWQgYmVmb3JlIGFuZCB5b3UgZW5kIHVwIHdyaXRpbmcgdGhpcyByYW5k
b20gYnl0ZXMgd2hlbg0KPiA+PiBkb2luZzoNCj4gPj4+Pg0KPiA+Pj4+IHdyaXRlcShkYXRhLCBm
aWZvLT50eC5kYXRhKTsNCj4gPj4+Pg0KPiA+Pj4+IFJlZ2FyZHMsDQo+ID4+Pj4NCj4gPj4+PiBI
YW5zDQo+ID4+Pj4NCj4gPj4+Pg0KPiA+Pj4+DQo+ID4+Pg0KPiA+DQoNCg==
