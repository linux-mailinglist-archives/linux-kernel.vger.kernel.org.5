Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92CB755BC2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjGQGek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjGQGej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:34:39 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2074.outbound.protection.outlook.com [40.107.14.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733DED9;
        Sun, 16 Jul 2023 23:34:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mg591heIiU74FDgGRtqHlhl/BoNzsYDu9PUdJ9YrGlyzdASFLkPky+Meg95k1XmP7MhkllTDMlRGTn8HOU0UU3F1eUvRv2bOsUpbH7HRuA/ERR42lfoFusZnhIS5P/g5dgIuIkvaYzUSwGxV9I6CNqWq6c3/lgm8jkwXdBSYrifFWIZbt4ZdHG1gu2T0HZ99mDOE3qwuMVu72+GU/EqU3kO1Swf9gayB9mO4Qz1TLHnd7RHOEAwWhw+7Nn9FzQUkvVU1t1Bu75lVsjjsZWyqX8BLtS7srkzsA4xIk9lEn5vC+OxR/t0WAHbvpI9RIBB1BiyTCSJqqZCr/sWcSmwdQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6yR5bKG0Rp3XLnuqlIJ1EGpHGr+e0i4APjs7GC+N48=;
 b=CIy0lEvQ9m7GGbUH/51xsz1grA0NuMDx3UZ0eIs0uv820QjUyRy4UfIZy/jVZytMvFn/ka/YrWaqmCfBSCEY7bJMjG1eOuOiwtvu7A73yVNbBJ2h6RHJn9C5boY+75o4THyLBM4GQybTN3KVZRyif29w8p9dY1uOWSIa7Wh24A0IwOaebwn+obN3KNaiY1Yb2Rs0/8H+NkL/6x/aBN/+G50xzEGaMae4+hab+ISSr6tPqD0gl3WuR4XXOahwvIhIRS5aJD+N2fMGonX2DXzaICyP0cddBo9Iea1mbDP4ATUzvDL3ACOBvaDjvj/S/WE+LaCXp181UXCjytjaRqYKkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=linux-watchdog.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6yR5bKG0Rp3XLnuqlIJ1EGpHGr+e0i4APjs7GC+N48=;
 b=wNV+pCx99dIoWBcAdPVqvALtoEFRPOg7SHinxXN2en+ZeqrdfEvxCNuoW6BmYNTUA5I4pHDl/as9BiSQsdYGMFRyWtUmQDmmvuC27AQrsNFNFARQudWvu6KpIRH8evSYNqLpHl0Jbv9GEvks6oskDjj24fZm65QJ+RrqPzbYjBkWVpeO8M/XJ3Zsat0q0FmimFh689YofvfAhnY7G6XHTRn31UBYa6zb21HizeQWOukJEJZo5+MiVJUSI3Isj07Eda+nEK5ZMx6p5HWLQCz4KLRC5pFsin/reGyKle9BYyPePxFKlIAF+h8r9dkGCTCBrr4fcRgpAYWZZK287uvrkA==
Received: from GVYP280CA0029.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:f9::7) by
 AS2PR10MB7108.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:60f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.32; Mon, 17 Jul 2023 06:34:35 +0000
Received: from HE1EUR01FT077.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:f9:cafe::45) by GVYP280CA0029.outlook.office365.com
 (2603:10a6:150:f9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Mon, 17 Jul 2023 06:34:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 HE1EUR01FT077.mail.protection.outlook.com (10.152.0.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.20 via Frontend Transport; Mon, 17 Jul 2023 06:34:34 +0000
Received: from CNPEK01M02MSX.ad011.siemens.net (139.24.237.215) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 17 Jul 2023 08:34:33 +0200
Received: from CNPEK01M03MSX.ad011.siemens.net (139.24.237.220) by
 CNPEK01M02MSX.ad011.siemens.net (139.24.237.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 17 Jul 2023 14:34:30 +0800
Received: from CNPEK01M03MSX.ad011.siemens.net ([139.24.237.220]) by
 CNPEK01M03MSX.ad011.siemens.net ([139.24.237.220]) with mapi id
 15.01.2507.027; Mon, 17 Jul 2023 14:34:30 +0800
From:   "Li, Hua Qian" <HuaQian.Li@siemens.com>
To:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "Su, Bao Cheng" <baocheng.su@siemens.com>,
        "kristo@kernel.org" <kristo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "huaqianlee@gmail.com" <huaqianlee@gmail.com>,
        "nm@ti.com" <nm@ti.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Kiszka, Jan" <jan.kiszka@siemens.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "vigneshr@ti.com" <vigneshr@ti.com>
Subject: Re: [PATCH v4 0/3] Add support for WDIOF_CARDRESET on TI AM65x
Thread-Topic: [PATCH v4 0/3] Add support for WDIOF_CARDRESET on TI AM65x
Thread-Index: AQHZuGQ+yWzLgdq38k6AjTC46fileq+89ZKAgAACDgCAAAEkgIAAAcyA
Date:   Mon, 17 Jul 2023 06:34:30 +0000
Message-ID: <b82847f51ec00d873a38eab21b7ada885593aeb8.camel@siemens.com>
References: <20230717040723.1306374-1-huaqian.li@siemens.com>
         <f5ff9616-c71c-f71e-ce4a-7b9fa7055bb4@linaro.org>
         <e57e5d8efc3107b5f2c4e66492650b9d0c17b898.camel@siemens.com>
         <625a92b8-b629-a4ef-6176-635e1b7885db@linaro.org>
In-Reply-To: <625a92b8-b629-a4ef-6176-635e1b7885db@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [139.24.108.35]
Content-Type: text/plain; charset="utf-8"
Content-ID: <926E4A268060DB46B1C8AA34319DA660@siemens.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT077:EE_|AS2PR10MB7108:EE_
X-MS-Office365-Filtering-Correlation-Id: 672bf754-2e98-4be9-98a4-08db868fe2d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XJd9X9MMTIYlhieJPMVHw+HmaQyybpXw2hJJs40+YuD3WgiY4Jkzdj+1qdR9aYaYFSzClE4Ir0UCATeBZ5mWt5f4rTnXoRDMBVm100iP1BgDR5WnWNX0vWRA9FTdtXpW4kn5C2bsD4XAFqN2Tyx+7EBSyQRm2P0Ao4WCQMkTtvQ9Cqleobe4Xtqt5RfXGkw/kxIFmmkvI54P4KWLjctUwGH7dIltdjtmgrYiBUIijQUKE+GB2vXTb0EMTBB/G8dNFaVNuoPCRAJwMwdH6fe3BYeMKY1R5s2t/eIm0xd/dtwGrVpB6yTlExBDBcUt0TEPZ+fo7XKKt8nK1azuyZ0o9GpYr9Ig8sqgLVruxmgCn348Il37V5nrrkq5I0VO+knBNsIi+f8dmjnbLOdJ83sw3ZM+0oZlWIIxDHFYYyPyLZ8WXPPyTSNLP+RfQDv/Sgnvob7zIYQ4+iqQTo3OJvPuvo58WsDw6+UfiHl/4YBLp+Ivfi06MtOtWeaFfNzCbH9xOpOyL/tn4gM2dhwXlhHxcCpYwHx41E8pl/b1FQTL17kLTT6Xs+z8dOdVi4hzbja+wxRPOO0WfJP8OIugoSv8ZMJvkgdyh2p7PMw+rCEqplkY/g5NrPQaXBeR0/D2UAGPLS6RS/3P7i0lu9ArkZiQlOns+LfTdyPh4denDSVGKCNEuk9nx34nb6My7aaG49vmqsWoB1z/OA9Z79CU92glhwP1FapVlrB6q99WJXaUVPrMkz9rkfkqIdzOoL+XxUyjhmxw3b1R/qnFC4c1N+9O3A==
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(8676002)(478600001)(45080400002)(8936002)(5660300002)(41300700001)(40480700001)(966005)(4326008)(316002)(26005)(186003)(7416002)(53546011)(110136005)(54906003)(70206006)(70586007)(956004)(2616005)(336012)(40460700003)(36860700001)(47076005)(2906002)(82960400001)(81166007)(356005)(82740400003)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 06:34:34.6420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 672bf754-2e98-4be9-98a4-08db868fe2d9
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT077.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7108
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA3LTE3IGF0IDA4OjI3ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxNy8wNy8yMDIzIDA4OjI0LCBMaSwgSHVhIFFpYW4gd3JvdGU6DQo+ID4gT24g
TW9uLCAyMDIzLTA3LTE3IGF0IDA4OjE2ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3Rl
Og0KPiA+ID4gT24gMTcvMDcvMjAyMyAwNjowNywgaHVhcWlhbi5saUBzaWVtZW5zLmNvbcKgd3Jv
dGU6DQo+ID4gPiA+IEZyb206IExpIEh1YSBRaWFuIDxodWFxaWFuLmxpQHNpZW1lbnMuY29tPg0K
PiA+ID4gPiANCj4gPiA+ID4gVGhlIHdhdGNoZG9nIGhhcmR3YXJlIG9mIFRJIEFNNjVYIHBsYXRm
b3JtIGRvZXMgbm90IHN1cHBvcnQNCj4gPiA+ID4gV0RJT0ZfQ0FSRFJFU0VUIGZlYXR1cmUsIGFk
ZCBhIHJlc2VydmVkIG1lbW9yeSB0byBzYXZlIHRoZQ0KPiA+ID4gPiB3YXRjaGRvZw0KPiA+ID4g
PiByZXNldCBjYXVzZSwgdG8ga25vdyBpZiB0aGUgYm9hcmQgcmVib290IGlzIGR1ZSB0byBhIHdh
dGNoZG9nDQo+ID4gPiA+IHJlc2V0Lg0KPiA+ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTog
TGkgSHVhIFFpYW4gPGh1YXFpYW4ubGlAc2llbWVucy5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4g
PiBDaGFuZ2VzIGluIHY0Og0KPiA+ID4gPiAtIEZpeCB0aGUgY29kaW5nIHN0eWxlLg0KPiA+ID4g
PiAtIEFkZCB1c2FnZSBub3RlIGZvciB0aGUgcmVzZXJ2ZWQgbWVtb3J5Lg0KPiA+ID4gPiAtIExp
bmsgdG8gdjM6DQo+ID4gPiA+IMKgDQo+ID4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xp
bnV4LXdhdGNoZG9nLzIwMjMwNzEzMDk1MTI3LjEyMzAxMDktMS1odWFxaWFuLmxpQHNpZW1lbnMu
Y29tDQo+ID4gPiANCj4gPiA+IE11Y2ggbW9yZSBjaGFuZ2VkLiBZb3UgYWRkZWQgZXhhbXBsZSBp
biB0aGUgYmluZGluZ3Mgd2hpY2ggbm8gb25lDQo+ID4gPiBhc2tlZA0KPiA+ID4gZm9yLiBUaGVu
IHlvdSBhZGRlZCBtdWx0aXBsZSBmYWtlIHJldmlldyB0YWdzIHRvIGFsbCB0aGUgcGF0Y2hlcy4N
Cj4gPiA+IA0KPiA+ID4gQmVzdCByZWdhcmRzLA0KPiA+ID4gS3J6eXN6dG9mDQo+ID4gPiANCj4g
PiBIaSwNCj4gPiANCj4gPiBTb3JyeSBmb3IgdGhlIHdyb25nIHN0YXRlbWVudC4gSSBtaXNzZWQg
c29tZSBrZXkgaW5mb3JtYXRpb24gYW5kDQo+ID4gbWlzc3VuZGVyc3Rvb2QgYFJldmlld2VkLWJ5
YCwgSSB0cmVhdGVkIGBSZXZpZXdlZC1ieWAgYXMgYFdobw0KPiA+IGhhcyByZXZpZXdlZGAuDQo+
IA0KPiBCdXQgeW91IGRvbid0IGhhdmUgZXZlbiB0aGF0IGluZm9ybWF0aW9uIHdobyBoYXMgcmV2
aWV3ZWQhIFdoZXJlIGRvDQo+IHlvdQ0KPiBzZWUgYW55IHJldmlld3MgY29taW5nIGZyb20gbWUg
Zm9yIHBhdGNoICMyPyBXaGVyZSBkbyB5b3Ugc2VlIHJldmlld3MNCj4gZnJvbSBSb2IgZm9yIHBh
dGNoICMzPw0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQpJIGdvdCB0aGVz
ZSBpbmZvcm1hdGlvbiBmcm9tIG15IGVtYWlsIHRocmVhZC4gQW55d2F5IEkgbWFkZSBhIHN0dXBp
ZA0KbWlzdGFrZSwgc29ycnkgZm9yIHdhc3RpbmcgeW91ciB0aW1lLg0KDQpCeSB0aGUgd2F5LCB3
aGVuIHlvdSB3cm90ZSB0aGUgZm9sbG93aW5nIGluICdbUEFUQ0ggdjMgMS8zXSBkdC0NCmJpbmRp
bmdzOiB3YXRjaGRvZzogdGkscnRpLXdkdDogQWRkIHN1cHBvcnQgZm9yIFdESU9GX0NBUkRSRVNF
VCcsIHlvdQ0Kd2VyZSBraW5kIG9mIHNheWluZyB0aGF0IGl0IGxvb2tzIGdvb2QgdG8geW91IGlm
IEkgcmVtb3ZlIHRoZSBleHRyYQ0KZW1wdHkgbGluZSwgcmlnaHQ/DQoNCkluIGFueSBjYXNlOg0K
UmV2aWV3ZWQtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGlu
YXJvLm9yZz4NCg0KQmVzdCByZWdhcmRzLA0KTGkgSHVhIFFpYW4NCg==
