Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DAA770C66
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 01:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjHDX3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 19:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHDX31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 19:29:27 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20608.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7AA10D2;
        Fri,  4 Aug 2023 16:29:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gjy/ffJqBwhp1AYKGWwJEv+jZPsNSxZW+DHv5aIVn9ZX9KqFuPQF7qqsXZ6wP9Ozd7yEv8qC0UDdUbG1NeLh5LUcEvvqMf4rAK37EW9LI2SunwfYHKW7x6O00hdZClq3JNx+s70zn/XFtqjwziTukPPURclRPpl8PuJc4cKm1M0C5E84NXv1xbpUkjF6hW256JOYZ9FdH5xeTG72EcJYVP5AJXwacFyV1a+TNeGIxWg126XT7F57yozKEL308d+Gc7RXeIpdCMjQ8+ogdMgdyqV4BaPQnEsf+fLrp24P1m0Om1IcjRFVXPeBid2mNaqXhbS9nqnCJ0/zcD/wp2Sj+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyerzq1Gt+Qa5o5BsVCp5spOG76KEP+0Qw6E+mbqwNU=;
 b=JQzGiIRIhyYXcvL9Rd9cPCPPJcvks7jqPbjJGXg4dHODQntbcd+2O2e5jcvc2n9jdcgPXI/7ntiolTGdIf7kkh8zBl3PxTuUNKYzDcRJIOUEp66oi1s3U2RaosOvfh63OZwKn2l4GslHr9PXpUZgH9mKAKvET8EnSFSZCCb0rzDIXhP7FTgR7RcutydEVPRio86dJOwbd8AyFJbIxwSyCW5wSPL/xqie7lLHPfw6kQ8Wm9jm2BAqxrncxoDTI5B+aNgUm1Djd5raPjom21TUtpq1rf60vYBpvKeOCUgaOrYm7aAwcseOchs07xyV8cXTNVvIqi03DEXrAIx7t2k8hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyerzq1Gt+Qa5o5BsVCp5spOG76KEP+0Qw6E+mbqwNU=;
 b=DW1xSKRDSG7zxhfbPrMgOoaSrvDBoJvD/hTIoDddUxDErhtysv7nKnWqCLCqBdr5pmcdXfp9f7kmv+KCn0LOqatf+/YzHQIAPkSRODwjlYl8G3GepCbae7m1FKi3pBKYznS5Y0JcQLy3TV7JI859MT2ECaJ8TFKZ5emD6H+e6cazJNhVe+3lYHCxzKd1HMZACk23XbxJFnrKCuhNzZxCDXKVHi1pi8TqfHseIBLlG+L899sHsyK5c1YxaURnLPyuiftR2MpPdwHATfL0k9Dc4aaocnV6LktoKnEsg2smXFKhlzboCuXsy2BFhov9+4ShUeH63S7ewrRub6UQCGCeHQ==
Received: from BN9PR12MB5068.namprd12.prod.outlook.com (2603:10b6:408:135::21)
 by IA1PR12MB7638.namprd12.prod.outlook.com (2603:10b6:208:426::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 23:29:21 +0000
Received: from BN9PR12MB5068.namprd12.prod.outlook.com
 ([fe80::acc8:7a8:c30d:eec8]) by BN9PR12MB5068.namprd12.prod.outlook.com
 ([fe80::acc8:7a8:c30d:eec8%7]) with mapi id 15.20.6652.021; Fri, 4 Aug 2023
 23:29:21 +0000
From:   Liming Sun <limings@nvidia.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5] mmc: sdhci-of-dwcmshc: Add runtime PM operations
Thread-Topic: [PATCH v5] mmc: sdhci-of-dwcmshc: Add runtime PM operations
Thread-Index: AQHZwU3/2pxcQ1dVwkmPONYtfA1jx6/VmVQAgAU5KKA=
Date:   Fri, 4 Aug 2023 23:29:21 +0000
Message-ID: <BN9PR12MB5068D7952AEA5DFF84B02A5BD309A@BN9PR12MB5068.namprd12.prod.outlook.com>
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
 <20230728122052.296488-1-limings@nvidia.com>
 <c1830d80-c8b2-19ec-fbfd-6bc3d2c806ce@intel.com>
In-Reply-To: <c1830d80-c8b2-19ec-fbfd-6bc3d2c806ce@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5068:EE_|IA1PR12MB7638:EE_
x-ms-office365-filtering-correlation-id: 62ea7628-7eb6-4141-a717-08db9542a1c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wWG93lIF1ppP2aL13ruq4JFeXjT8iJKvR4Q9mNoIQd5XaoRK/+Z9IqlsKqOJAXcGY9jwQjctAVUdnsUEXhp9PpBhu/xXdQycnQ+4fJGw9PIdCbK8owLuNMRbv/SbW6yinsEG8okTczp1vp8ebBWSsZqJD1QsIlqaN7wpWZKefyrvSEAa0m77nHm0G4Uc+YIrhqVjVERdAoaJb8JFkoUNUiCnJ4/Sw1VwGiD2LkHx3AkaTE2bb1fc7m+4WetPwLnozIwpyUucI8+gIdK+fDyKZjs30UrWABX9vqdxPe09wczj23SK02vqVA3yuAJpduKnKPv40bqylclYVmO9CaFpNH/pr99deireTbNf6gmRnRA666XLx5Uax/QLBetCZiE24JE4xd3bN8D/En3XX1nWepnUa84HdjR1cMfK0gl3ux7Ns7gOAYULOxgDkooNzIrk7yEgz/z2K430mJvt4ZMAaZjK7FRTMQUFNnPZ7dGgTs8RI18OnnmRsETTe0O81qLolGRlKfcYf4aTJGBTFYEQ1iRp9M2Yvwf1EwXfjr/9fKby7f0qlQBRgpcyCqrBDL9OZMHL7cUjRErdaJTpeYOUYkQmDHPmZlXISFt2rmyq5b266uZMokUUNi0lu3efyo+RvTul/3XaAyX1XuC+MCMrqVjnoAzODcrR61d/skroVkT6ETYaKIUqqEw4i6GLgcar
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5068.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(186006)(1800799003)(451199021)(66476007)(66446008)(66946007)(66556008)(110136005)(54906003)(4326008)(76116006)(64756008)(478600001)(38070700005)(316002)(53546011)(26005)(6506007)(71200400001)(55016003)(33656002)(41300700001)(8676002)(8936002)(966005)(7696005)(9686003)(83380400001)(5660300002)(52536014)(2906002)(86362001)(38100700002)(122000001)(133343001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkMxTU9iVmFWQW1QREZxczdEOGNHWkVpMVFxQys3ZEtFbUZkemUxZVE3RUpT?=
 =?utf-8?B?NU5Qem1QemUxK2FxZEk3MUF4Z2UyUzM0d0lDK2VkVGFpVzJqblhDOWNBQVBr?=
 =?utf-8?B?WVg1S3BEbVNaQWRZdldyVVI0VlFzRnZMbEtzS1E2VUJIaUorLzkxN0lSTFFl?=
 =?utf-8?B?T1NCbmFyT3Fscjk5czVFYks4U0NuWTJldG1wQzNHM3pXKzhqQVlDVDdadDJ2?=
 =?utf-8?B?OVltQjl0WDY3U1NIVmFUaHBzQVF3bE5iSEZaczErU0s5OHVhbE5vSm8vVnBU?=
 =?utf-8?B?QmJBSkRLRXBZWkUvbWtLSTloWHd3VXVpdkRMdS8rd2dXVFd0cVBRRDQxUmpl?=
 =?utf-8?B?Z2lBUElRWGZ6WTB0Szd0T3htZ2N3UGdlanhsNXUvVFlsYmYzVXBPcXU0NVBX?=
 =?utf-8?B?NjI2TCtRTjhZbzVCZ2svdlhuVGxLeGt3UjkzMWhrc29PQzladmsrdFNpb2Nq?=
 =?utf-8?B?cTYxSno0dG5mUFJtNytWU1NHVENxUW9ac1ltdTd1Y2lFNHEwWEVWUm9ybGpS?=
 =?utf-8?B?YXVxd3ZsMnhHKzdrWlc5Q3hFUG9maUU2d05kRnJtYzh3NzVsUjJvVWxOK1VC?=
 =?utf-8?B?TUNKMnIxSXpSSitEbmQwSFhHZ1F0V0RFekVQcE5vRmJ3WlpTWnJaK1k4YVZI?=
 =?utf-8?B?QTVZOE1nbkpwS3VlRmdsbjNvckNhZFlMcUJKMDA2ekV6MGIzaVBPVXpHRklY?=
 =?utf-8?B?dVBqQWNwSndyaEZ1MnplS1ZCY2thWStxSlEvcWVhczdnTXhQcG8wZ3pYMXZt?=
 =?utf-8?B?Q1lOZERKY1VDVVdSS2pIbnVtc2NwOTdFMCtUSXFDSmVSMVVJazcyUU1KTlJQ?=
 =?utf-8?B?YktxcktSd3dkS2h0S2Y2VWVvazc1ZmFzeFg2eU9XWmVsSlRBaU54bFRldDNO?=
 =?utf-8?B?ZElIUjhhb3l2VTM0ZUtwVFdpcnpnVWtOOS82S0hQNndBd2trTkY3M3IvL0dL?=
 =?utf-8?B?QmZKVFdRRzR5RjhPODFnYStZTE1vTGd0bmora2FsUnFBSnBYM2tyZW54bUdM?=
 =?utf-8?B?aFNGYmUraUxFYXZOOGl3TFpFUXhjZEt3MVV3S1IxNGo0bHgvY3dwdWxBVUV6?=
 =?utf-8?B?b3JtOTYxMDNDL0NleDVpU2djdVhjR2Q4SklkMFpsay9hdWhCQ3E0MERaQytD?=
 =?utf-8?B?Y1krM3lzTEk0UzNGVjRKUEVLcHV1YW5iZGxaQmRnS3gxWEp2b09hTHVMMUFh?=
 =?utf-8?B?SkhraG1VWHFldzVqNVlHYUFHUmRsYnhqUUFrejBnMjJtZFRlbkxnL1Y3eGpN?=
 =?utf-8?B?cVRzTWFJY0E4Q2oyV2lOb1VNd1hUMllobHdRVDU2Vk50aHd0TW0vcWMySW9t?=
 =?utf-8?B?ZGFOeFZYQkNsZEFyOUFqNjVlaTh4L1ZBQkxMODFucEw0YldRcEROd1BtWHRQ?=
 =?utf-8?B?bkdRYlN1VWRPK1lhb3BmUGY2UmgwZFl6SHkrak9NMDhjUVpNOXFNMjhFbW1p?=
 =?utf-8?B?SFdoaGhWMVQxbFpHVGRlaW5pSExqSUovMjAwdEZVRGduUkJsMmFGNjNUMEpa?=
 =?utf-8?B?U3VKNzJrTEFrMmNYcW4yUlZoRzBBZGdIcVBJRGdCTjc3aEhVL3BBczh0NUFh?=
 =?utf-8?B?OHBPQk1LWmJZVFlHZStPZ29UUjd6ZGhvREpxQlUzU0Vxd2ZUbGZ4MmVOdE1i?=
 =?utf-8?B?N0F5TzI1L1lHelRkWkU4bWF4WkdCdUF4U29mVTBaNEVtRWJWaERWUG9qdit4?=
 =?utf-8?B?dEVNbm1pMlVkQ25WRnlJelFVSEN6alllYzYydlVjeUVQbnp5dm01WXZZQUJv?=
 =?utf-8?B?cDBuT0Y1TWp3OG5IR29jeU0vY1ZaZlM1ZlVDbzZXZHhmeThsdnRkMGUvdnFk?=
 =?utf-8?B?dm1RZDlLdUxoZmVYS0Jjd1p4WEJSWXJNOVowUGtncE8xcDBrTHdGUmtFcmdo?=
 =?utf-8?B?MVRraDFhWFBaSmc4MGl2enJPUnJEZjNWdUdVdDZBU250Wmd3QW1jZXNvSldu?=
 =?utf-8?B?OWdQTjNXdDBMOC9TbS84elNFbXFPZjg2eXp4aTRaNHlHNXhLNHVQYU9STnIy?=
 =?utf-8?B?WVdBNFRsc3J5NC9xTEd1eUxSQzZrVjhsTG1nS3NvUG5ib1VaWFRjVHRkV0dO?=
 =?utf-8?B?dm1sczNQT2Y3dEU4WjFmZENUZWxtTno2L1pGTDJub0lZbkVXVGx5bUFvMU5r?=
 =?utf-8?Q?fex0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5068.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ea7628-7eb6-4141-a717-08db9542a1c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 23:29:21.7573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zyGInY7Gup5QaixlS+PrJ74PItBrgjZdbGdGU4bmKQ7DpHZxBVakxOJ/uON/A15bd6tvx32lytbT//EP9SAEvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7638
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWRyaWFuIEh1bnRlciA8
YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEF1Z3VzdCAxLCAyMDIz
IDExOjM3IEFNDQo+IFRvOiBMaW1pbmcgU3VuIDxsaW1pbmdzQG52aWRpYS5jb20+OyBVbGYgSGFu
c3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz47DQo+IERhdmlkIFRob21wc29uIDxkYXZ0aG9t
cHNvbkBudmlkaWEuY29tPjsgU2hhd24gTGluIDxzaGF3bi5saW5Acm9jay0NCj4gY2hpcHMuY29t
Pg0KPiBDYzogbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1XSBtbWM6IHNkaGNpLW9mLWR3Y21zaGM6
IEFkZCBydW50aW1lIFBNIG9wZXJhdGlvbnMNCj4gDQo+IE9uIDI4LzA3LzIzIDE1OjIwLCBMaW1p
bmcgU3VuIHdyb3RlOg0KPiA+IFRoaXMgY29tbWl0IGltcGxlbWVudHMgdGhlIHJ1bnRpbWUgUE0g
b3BlcmF0aW9ucyB0byBkaXNhYmxlIGVNTUMNCj4gPiBjYXJkIGNsb2NrIHdoZW4gaWRsZS4NCj4g
Pg0KPiA+IFJldmlld2VkLWJ5OiBEYXZpZCBUaG9tcHNvbiA8ZGF2dGhvbXBzb25AbnZpZGlhLmNv
bT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBMaW1pbmcgU3VuIDxsaW1pbmdzQG52aWRpYS5jb20+DQo+
ID4gLS0tDQo+ID4gdjQtPnY1Og0KPiA+ICAgICAtIEFkZHJlc3MgQWRyaWFuJ3MgY29tbWVudCB0
byBtb3ZlIHRoZSBwbV9lbmFibGUgdG8gdGhlIGVuZCB0bw0KPiA+ICAgICAgIGF2b2lkIHJhY2U7
DQo+ID4gdjMtPnY0Og0KPiA+ICAgICAtIEZpeCBjb21waWxpbmcgcmVwb3J0ZWQgYnkgJ2tlcm5l
bCB0ZXN0IHJvYm90JzsNCj4gPiB2Mi0+djM6DQo+ID4gICAgIC0gUmV2aXNlIHRoZSBjb21taXQg
bWVzc2FnZTsNCj4gPiB2MS0+djI6DQo+ID4gICAgIFVwZGF0ZXMgZm9yIGNvbW1lbnRzIGZyb20g
VWxmOg0KPiA+ICAgICAtIE1ha2UgdGhlIHJ1bnRpbWUgUE0gbG9naWMgZ2VuZXJpYyBmb3Igc2Ro
Y2ktb2YtZHdjbXNoYzsNCj4gPiB2MTogSW5pdGlhbCB2ZXJzaW9uLg0KPiA+IC0tLQ0KPiA+ICBk
cml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWR3Y21zaGMuYyB8IDU0DQo+ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1MyBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhj
aS1vZi1kd2Ntc2hjLmMgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLQ0KPiBvZi1kd2Ntc2hjLmMN
Cj4gPiBpbmRleCBlNjhjZDg3OTk4YzguLjVjZWU0MmQ3MjI1NyAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWR3Y21zaGMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1j
L2hvc3Qvc2RoY2ktb2YtZHdjbXNoYy5jDQo+ID4gQEAgLTE1LDYgKzE1LDcgQEANCj4gPiAgI2lu
Y2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4gPiAg
I2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvcG1fcnVu
dGltZS5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvcmVzZXQuaD4NCj4gPiAgI2luY2x1ZGUgPGxp
bnV4L3NpemVzLmg+DQo+ID4NCj4gPiBAQCAtNTU5LDYgKzU2MCw4IEBAIHN0YXRpYyBpbnQgZHdj
bXNoY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiA+ICAJaWYgKGVy
cikNCj4gPiAgCQlnb3RvIGVycl9zZXR1cF9ob3N0Ow0KPiA+DQo+ID4gKwlkZXZtX3BtX3J1bnRp
bWVfZW5hYmxlKGRldik7DQo+IA0KPiBCeSBkZWZhdWx0LCBydW50aW1lIFBNIHJlZ2FyZHMgdGhl
IGRldmljZSBhcyBub3QgYWN0aXZlLCBzbw0KPiB0eXBpY2FsbHkgZHJpdmVycyB3aWxsIHVzZSBz
b21ldGhpbmcgbGlrZSBwbV9ydW50aW1lX3NldF9hY3RpdmUoKQ0KPiBwcmlvciB0byBwbV9ydW50
aW1lX2VuYWJsZShkZXYpDQo+IA0KPiBJbiBmYWN0IGl0IGlzIGJldHRlciB0byBlbmFibGUgYmVm
b3JlIGFkZGluZyB0aGUgaG9zdCBidXQNCj4gaW5jcmVtZW50IHRoZSB1c2FnZSBjb3VudCB0byBw
cmV2ZW50IHJ1bnRpbWUgc3VzcGVuZC4gIFRoYXQNCj4gbWVhbnMgYWRkaW5nIHNvbWUgZ2V0L3B1
dHMsIGVuZGluZyB1cCB3aXRoIHNvbWV0aGluZyBsaWtlOg0KPiANCj4gKwlwbV9ydW50aW1lX2dl
dF9ub3Jlc3VtZShkZXYpOw0KPiArCXBtX3J1bnRpbWVfc2V0X2FjdGl2ZShkZXYpOw0KPiArCXBt
X3J1bnRpbWVfZW5hYmxlKGRldik7DQo+IA0KPiAJZXJyID0gc2RoY2lfc2V0dXBfaG9zdChob3N0
KTsNCj4gCWlmIChlcnIpDQo+IC0JCWdvdG8gZXJyX2NsazsNCj4gKwkJZ290byBlcnJfcnBtOw0K
PiANCj4gCWlmIChya19wcml2KQ0KPiAJCWR3Y21zaGNfcmszNXh4X3Bvc3Rpbml0KGhvc3QsIHBy
aXYpOw0KPiANCj4gCWVyciA9IF9fc2RoY2lfYWRkX2hvc3QoaG9zdCk7DQo+IAlpZiAoZXJyKQ0K
PiAJCWdvdG8gZXJyX3NldHVwX2hvc3Q7DQo+IA0KPiArCXBtX3J1bnRpbWVfcHV0X3N5bmMoZGV2
KTsNCj4gDQo+IAlyZXR1cm4gMDsNCj4gDQo+IGVycl9zZXR1cF9ob3N0Og0KPiAJc2RoY2lfY2xl
YW51cF9ob3N0KGhvc3QpOw0KPiArIGVycl9ycG06DQo+ICsJcG1fcnVudGltZV9kaXNhYmxlKGRl
dik7DQo+ICsJcG1fcnVudGltZV9wdXRfbm9pZGxlKGRldik7DQo+IGVycl9jbGs6DQo+IAljbGtf
ZGlzYWJsZV91bnByZXBhcmUocGx0Zm1faG9zdC0+Y2xrKTsNCj4gCWNsa19kaXNhYmxlX3VucHJl
cGFyZShwcml2LT5idXNfY2xrKTsNCj4gCWlmIChya19wcml2KQ0KPiAJCWNsa19idWxrX2Rpc2Fi
bGVfdW5wcmVwYXJlKFJLMzV4eF9NQVhfQ0xLUywNCj4gCQkJCQkgICBya19wcml2LT5yb2NrY2hp
cF9jbGtzKTsNCj4gZnJlZV9wbHRmbToNCj4gCXNkaGNpX3BsdGZtX2ZyZWUocGRldik7DQo+IAly
ZXR1cm4gZXJyOw0KPiANCg0KVXBkYXRlZCBpbiB2Ni4NCg0KPiA+ICsNCj4gPiAgCXJldHVybiAw
Ow0KPiA+DQo+ID4gIGVycl9zZXR1cF9ob3N0Og0KPiA+IEBAIC02NDYsNyArNjQ5LDU2IEBAIHN0
YXRpYyBpbnQgZHdjbXNoY19yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICB9DQo+ID4g
ICNlbmRpZg0KPiA+DQo+ID4gLXN0YXRpYyBTSU1QTEVfREVWX1BNX09QUyhkd2Ntc2hjX3Btb3Bz
LCBkd2Ntc2hjX3N1c3BlbmQsDQo+IGR3Y21zaGNfcmVzdW1lKTsNCj4gPiArI2lmZGVmIENPTkZJ
R19QTQ0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgZHdjbXNoY19lbmFibGVfY2FyZF9jbGsoc3Ry
dWN0IHNkaGNpX2hvc3QgKmhvc3QpDQo+ID4gK3sNCj4gPiArCXUxNiBjdHJsOw0KPiA+ICsNCj4g
PiArCWN0cmwgPSBzZGhjaV9yZWFkdyhob3N0LCBTREhDSV9DTE9DS19DT05UUk9MKTsNCj4gDQo+
IFlvdSBjb3VsZCBzYXZlIGFuIG1taW8gd3JpdGU6DQo+IA0KPiAJaWYgKGN0cmwgJiBTREhDSV9D
TE9DS19JTlRfRU4gJiYgIShjdHJsICYgU0RIQ0lfQ0xPQ0tfQ0FSRF9FTikpIHsNCj4gDQo+ID4g
KwljdHJsIHw9IFNESENJX0NMT0NLX0NBUkRfRU47DQo+ID4gKwlzZGhjaV93cml0ZXcoaG9zdCwg
Y3RybCwgU0RIQ0lfQ0xPQ0tfQ09OVFJPTCk7DQo+IA0KPiAJfQ0KDQpVcGRhdGVkIGluIHY2Lg0K
DQo+IA0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBkd2Ntc2hjX2Rpc2FibGVfY2Fy
ZF9jbGsoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QpDQo+ID4gK3sNCj4gPiArCXUxNiBjdHJsOw0K
PiA+ICsNCj4gPiArCWN0cmwgPSBzZGhjaV9yZWFkdyhob3N0LCBTREhDSV9DTE9DS19DT05UUk9M
KTsNCj4gDQo+IFlvdSBjb3VsZCBzYXZlIGFuIG1taW8gd3JpdGU6DQo+IA0KPiAJaWYgKGN0cmwg
JiBTREhDSV9DTE9DS19DQVJEX0VOKSB7DQo+IA0KPiA+ICsJY3RybCAmPSB+U0RIQ0lfQ0xPQ0tf
Q0FSRF9FTjsNCj4gPiArCXNkaGNpX3dyaXRldyhob3N0LCBjdHJsLCBTREhDSV9DTE9DS19DT05U
Uk9MKTsNCj4gDQo+IAl9DQoNClVwZGF0ZWQgaW4gdjYuDQoNCj4gDQo+ID4gK30NCj4gPiArDQo+
ID4gK3N0YXRpYyBpbnQgZHdjbXNoY19ydW50aW1lX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2
KQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCA9IGRldl9nZXRfZHJ2ZGF0
YShkZXYpOw0KPiA+ICsJaW50IHJldCA9IDA7DQo+IA0KPiByZXQgZG9lc24ndCBuZWVkIGluaXRp
YWxpemF0aW9uDQoNClVwZGF0ZWQgaW4gdjYuDQoNCj4gDQo+ID4gKw0KPiA+ICsJcmV0ID0gc2Ro
Y2lfcnVudGltZV9zdXNwZW5kX2hvc3QoaG9zdCk7DQo+IA0KPiBJZiB5b3UgKm9ubHkqIHdhbnQg
dG8gZGlzYWJsZSB0aGUgY2FyZCBjbG9jaywgdGhlbg0KPiBpdCBpcyBwcm9iYWJseSBub3QgbmVj
ZXNzYXJ5IHRvIGNhbGwgc2RoY2lfcnVudGltZV9zdXNwZW5kX2hvc3QoKQ0KPiBhbmQgc2RoY2lf
cnVudGltZV9yZXN1bWVfaG9zdCgpLg0KPiANCg0KSWYsIG9ubHkgY2FyZXMgYWJvdXQgdGhlIGNh
cmQgY2xvY2suIFRlc3RlZCBhbmQgcmVtb3ZlZCB0aGUgDQpzZGhjaV9ydW50aW1lX3N1c3BlbmRf
aG9zdCgpIGFuZCBzZGhjaV9ydW50aW1lX3Jlc3VtZV9ob3N0KCkNCnRvIGtlZXAgaXQgc2ltcGxl
LiANCg0KPiA+ICsJaWYgKCFyZXQpDQo+ID4gKwkJZHdjbXNoY19kaXNhYmxlX2NhcmRfY2xrKGhv
c3QpOw0KPiA+ICsNCj4gPiArCXJldHVybiByZXQ7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRp
YyBpbnQgZHdjbXNoY19ydW50aW1lX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gK3sN
Cj4gPiArCXN0cnVjdCBzZGhjaV9ob3N0ICpob3N0ID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+
ID4gKwlpbnQgcmV0ID0gMDsNCj4gDQo+IHJldCBpc24ndCBuZWVkZWQNCg0KUmVtb3ZlZCBpbiB2
Ni4NCg0KPiANCj4gPiArDQo+ID4gKwlkd2Ntc2hjX2VuYWJsZV9jYXJkX2Nsayhob3N0KTsNCj4g
PiArCXJldCA9IHNkaGNpX3J1bnRpbWVfcmVzdW1lX2hvc3QoaG9zdCwgMCk7DQo+IA0KPiBqdXN0
DQo+IAlyZXR1cm4gc2RoY2lfcnVudGltZV9yZXN1bWVfaG9zdChob3N0LCAwKTsNCg0KVXBkYXRl
ZCBpbiB2Ni4NCg0KPiANCj4gPiArDQo+ID4gKwlyZXR1cm4gcmV0Ow0KPiA+ICt9DQo+ID4gKw0K
PiA+ICsjZW5kaWYNCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyBk
d2Ntc2hjX3Btb3BzID0gew0KPiA+ICsJU0VUX1NZU1RFTV9TTEVFUF9QTV9PUFMoZHdjbXNoY19z
dXNwZW5kLCBkd2Ntc2hjX3Jlc3VtZSkNCj4gDQo+IFR5cGljYWxseSB5b3UgbmVlZCBhIHdheSB0
byBjb29yZGluYXRlIHJ1bnRpbWUgUE0gYW5kIHN5c3RlbSBQTSwgcmVmZXI6DQo+IA0KPiBodHRw
czovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9wb3dlci9ydW50aW1lX3BtLmh0bWwj
cnVudGltZS0NCj4gcG0tYW5kLXN5c3RlbS1zbGVlcA0KDQpUaGFua3MuIEFkZGVkIHBtX3J1bnRp
bWVfZm9yY2Vfc3VzcGVuZCgpIGFuZA0KcG1fcnVudGltZV9mb3JjZV9yZXN1bWUoKSBpbiB0aGUg
c3lzdGVtIHNsZWVwKCkgDQphbmQgcmVzdW1lKCkgZnVuY3Rpb24gdG8gbWFrZSB0aGUgdHdvIHN0
YXRlcyBjb25zaXN0ZW50Lg0KDQo+IA0KPiA+ICsJU0VUX1JVTlRJTUVfUE1fT1BTKGR3Y21zaGNf
cnVudGltZV9zdXNwZW5kLA0KPiA+ICsJCQkgICBkd2Ntc2hjX3J1bnRpbWVfcmVzdW1lLCBOVUxM
KQ0KPiA+ICt9Ow0KPiA+DQo+ID4gIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIHNkaGNp
X2R3Y21zaGNfZHJpdmVyID0gew0KPiA+ICAJLmRyaXZlcgk9IHsNCg0K
