Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C629D7F1722
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbjKTPSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbjKTPSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:18:17 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368D6CF;
        Mon, 20 Nov 2023 07:18:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0rj4bByg3NAKlomzHVG+XzvalON+ehlCT3p13lgDx0cppl64/wMcZGGZZTZ429AYHvVQPi/geZYWE1/Im+ZsZxkqb67ioOs/lLEj8vxGFulGkGfV32nNEmGw7oE26xNw3RC3QMElVcl0rk0jhroHDg8UPrhtLLb+7dseSCu1KV+FeA4ZyQP/TQ6B9pmZAXkJViypbxWQVQo+02dPYUMEifx96+hxa6CtzBX1BZtxo3H2hLG6G9yQMNROZN69YeYK/JCu078L5McB35FoLetOEJ84K0JzKhjDojX4QCP21xREFtPy6M0mXttJjEFdO+OR9GpCSM/ET6Vyf5OCovakg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlXzs6KbuBNnwEs44TINsSdV/pCvNRsz71kK1sMVjH0=;
 b=EaMYJd3infyTU7nCKwP0jo5Zq2p+vPMPdDfDXY6+Szz2V9ugvbefjmHCAXHmKNpxbsBR22ULQ564ZNbBF/AjHlI9vU5cVYQagFEr7G/4za6MQAmcwVZqFP/PgfwnzXMLkv+oIQXrL6vF6OrraWR8YIKq+9Nkds7q4uYocYRQQODsoa58a045bCGzaDMq6CsOb7RbeDzwGCQrwS/3qTJxjSNXros2IQotRiSAhIYfj1n4CZ1353TKpK5w82Bpm1rmdba79z8e++m8I+mIc3PwDEVb10WDPIHcSYP6Ctx99iMjL5kOuOOu/JAPz8XampngnYf6hL3mHbVoU9LNjE6ieA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlXzs6KbuBNnwEs44TINsSdV/pCvNRsz71kK1sMVjH0=;
 b=YkUAM42held8O33RgEqphLcOnU+8B/EHNGyJIASbErLMU6Svz1C7zN/vF6rpZvnUWs93G0jicHfFvo2gb0tllcRFIxaRJCCGf/n08S41C7eWCMJDGzFqEJ9rJ9smwvUsXLevzv8MSfAg3EBmva7zAi5egv/cxX8etC6d1a2VDeFKHJhJu3v55nOQIK4cl5FeyKSeZdy/2P/c7MX/8ReXMHYzRrFsm8qTjCHR/I0fmYUV+Qr5e0+q79GRTsyKkZApoGPuTItVTnAi4YIrA/bFVbxlavldiPFPlEdDtZtL7WTgUIyruYmQvItVSIWPrmP5mBcc0Ay8aSdzyfZLmCc5Yg==
Received: from BN9PR12MB5068.namprd12.prod.outlook.com (2603:10b6:408:135::21)
 by CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 15:18:11 +0000
Received: from BN9PR12MB5068.namprd12.prod.outlook.com
 ([fe80::126b:b22c:51cc:c996]) by BN9PR12MB5068.namprd12.prod.outlook.com
 ([fe80::126b:b22c:51cc:c996%6]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 15:18:10 +0000
From:   Liming Sun <limings@nvidia.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Thompson <davthompson@nvidia.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/1] mmc: sdhci-of-dwcmshc: Enable timeout quirk for
 BlueField-3 SoC
Thread-Topic: [PATCH v1 1/1] mmc: sdhci-of-dwcmshc: Enable timeout quirk for
 BlueField-3 SoC
Thread-Index: AQHaGiWuyqF2YA89PESSY+mtaOAx97CCxxAAgAB3dGA=
Date:   Mon, 20 Nov 2023 15:18:10 +0000
Message-ID: <BN9PR12MB50688354602B03E9E637C02FD3B4A@BN9PR12MB5068.namprd12.prod.outlook.com>
References: <6082b74cbc681e8c24354828941361f4f4294242.1700315051.git.limings@nvidia.com>
 <47367cdc-f512-4f0d-958f-2d8fbe450cbf@intel.com>
In-Reply-To: <47367cdc-f512-4f0d-958f-2d8fbe450cbf@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5068:EE_|CH3PR12MB8233:EE_
x-ms-office365-filtering-correlation-id: ec572181-15ed-4414-8f06-08dbe9dbe7f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mdVBy6LmL30Ym06MZFNnFa167ka9H3TkyiW/URGsNPPe69vN1yVyHoJPiRwLslDdctqCl4bvZVVEOwuzQFLjSMCB/KuEnoP/WOJXrRiyJSuIGBzg/0DFmLh7U4g130LMVrR2dH0/b0NXP5vw3KCH/HUDllyAQRLiNngamy2T6fy/VnuBPKfjpp/9f55ttDZJacOX04FqaSNEEUbMFtOcgg/RkLia9URebMKS828xMFse+3Z35dCerEfHAYrcfwW4Q5zs029agRGPMuzvoqh6nprRu5A9u/PaMC5jONuzII7lFsFN/Ja4DzG0BJW2V4gCEm9fphbdYD3pm7jc9vYZWyU3QO1Cy88R4iTA7Mkt5dG/L2aS0EmUQQp9Vca8JWhBjT9w0KYE1wTZLBTqZvRyPTCxKbJh8huZWtbBHvRd4Nd7u52ZoWOwRmU8oL63ql7UGS+teJ7t53pJIQuk3/JVnf3tuMdTr8ZQM/gm+tcttg5PpbhJ/o53aH+Eilb5M8DdH1Qc7FGn0AAMXR8nqfHJewP+E9agpjfB8gKDDNq3AiAVxOSMNuwlJbHg7sBI74c+SQ0Vw7IuhN8SAE+218JeepeWSnNsLvQuwtWbyOiq1YarolSwP4hxivcRO0JFHroMKJquvmw/Ved5qdJgNCjECA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5068.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(136003)(39860400002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(83380400001)(86362001)(33656002)(38100700002)(122000001)(38070700009)(6636002)(66946007)(110136005)(76116006)(66556008)(66476007)(66446008)(64756008)(54906003)(316002)(8676002)(4326008)(8936002)(52536014)(41300700001)(55016003)(5660300002)(2906002)(9686003)(6506007)(7696005)(53546011)(71200400001)(26005)(478600001)(133343001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVF5UEFyMkU1aE5DVU95QjhwLzMvckFYZ3E0VGhiWWxzbS8yd2d3Q2xHazY0?=
 =?utf-8?B?T1JzdjZrNU5jVEJnSG1WVkE5eVdUVkVOYTUzZ1k5SEM3NWxyTFpnd3BwcFls?=
 =?utf-8?B?ZnJtN0xiUVhLSUxlc2NSdk5NN0hFV3hJWjkwSGZ4UzU1U000eWh1eTNsRk12?=
 =?utf-8?B?STFQem0ydDBYa0pINmoraWVqMnYxeHFXVzhwN3FydWdIR0tWbXJNNjU0Qkla?=
 =?utf-8?B?dHBFcytZM0RZdVlGbzZORXdtMEtVZFBVSitvcHd5eHg1bXhySENWUGZDYzJ5?=
 =?utf-8?B?RjQ5MXRSNEtxY0xUeWR3QllNY3dTM29jYm84S205M2h5UkNJZzdrTSsvN0xQ?=
 =?utf-8?B?NWRCTFhjWGJ4N0ZEMGVVclNDVmVKOUpGeFJNNU1NSkhQWnNtMGhXYnhVYWxQ?=
 =?utf-8?B?aENIVTM3TlpVbldmZjYwMldndDZVQWZiUHlwZVc3THJwZUgxZDhKdVdLSmRP?=
 =?utf-8?B?angrdzRiYWtTYlVkOGtGN3UzRU5ydkhXZnJhdEw3S2duc3IwK2FUWVdjVkpk?=
 =?utf-8?B?aHR3Ynd2SnJnVjdFYWsyN2pQOUFRbWw3M1htMm5raW0wTExpRWFNQ3lXS3hw?=
 =?utf-8?B?TVVuaVRBcDdPeUo0OEpwc2ZlTks3R3RLU1EydS9EejVZbFp3ODIxdVZPbnJ2?=
 =?utf-8?B?bXp0TmNOSWxYRnlLQ2ZoK1d1L0l0bHA2WFluT1NhSy9acmtBbDAveGtXSzNn?=
 =?utf-8?B?cm4xLzBKT2hhZlAydE1laWRZc1VabVQycjRtK2pJSnZORFJSWnZpaG5uNTVX?=
 =?utf-8?B?b1lpbUR6QWJSQS9kZ2xjc0U5V3kyUC9TNmJxWFVyVzYwNlZqR1pxcVhxTXBY?=
 =?utf-8?B?a1ZqNTgzeXo1Y3lEZkVxbmVvb0t1a1k5SlhZbHFORGRTKzJKN1JkNDNjeE52?=
 =?utf-8?B?VEV2TzJPaExkc085aC9PZCs5Q0FqbDE4Q1JrUmNZSjBuQ0hSazMrTHpOVFF3?=
 =?utf-8?B?RXFMMzJsQy96K2dVNUVaYmNzSXhSQXBDZS9tU2gxRlo2alo0ditISk1aK1hX?=
 =?utf-8?B?YzNBaE1WYnZIUEUwb045eERvdGlPWW1walVjVzBJQUkvbW44QkdFVjA5QzlZ?=
 =?utf-8?B?ZW9uVm50UVpTSGdnWGNmSXNzQy9OcHlxRzdhc0s5MlFXY1BLK20yTzhoVHI2?=
 =?utf-8?B?UzlpVUZZS0syc3E2ekRwQ2xNYmVIVDhMYXkwa0h4NjJTUFJiN2pmNmV1cWpU?=
 =?utf-8?B?MG9mYXZuNVlVZHMyT2dKQ3FPSWxGMnpJYnFFeVU2d216dTFUMDZWRTJIYmdw?=
 =?utf-8?B?aE5LRklhNVZOdkNEWU5sNGpzV2RtWFViWnZmV1hNMUNJV09hK2x3N0tUUTlF?=
 =?utf-8?B?OUdOZDQwSlhyUVNjdTRlc05jY09XVmFWbTBOcUZGcTM5TXMyM1J2bUZncFBw?=
 =?utf-8?B?Wjc0YUxlcEljVGtjVUVjNWhveWYwWVcyUkZpMFNnYmp1QjVvbEtmRWZxK25Y?=
 =?utf-8?B?ck93N1hya2JDUzBBUFNuR0NLcEF4a0g1RjRWWWtpa3Uvdk9CQ2RkZWpVL1lT?=
 =?utf-8?B?a0ZtQWZJbmR5OUxRbjFFZjdBSFNodkxHL1p0ZU1MaDZFL0NTR3RTTFAzclh5?=
 =?utf-8?B?cWR6dzFWeE96OStFaTFUeWZTSW9DWGtRUXNXVCtPM1hnQVZkNVBiMjdOSnFI?=
 =?utf-8?B?T2lsU2dWcFFiL2EwY0VDZlJROEM0aHdjMFhBaDYzRWFkTzQwcjBvY1YzaVdR?=
 =?utf-8?B?dDRaSTJsNVdmQ2lGM205RjdrMHpSYzFpdk80bFdHL05Pa2xjVElZbVpDT1hN?=
 =?utf-8?B?TktpU0lxYnN5cHRuMWdJbFN3Kzl0N3hIYVMySHd4dzB0M054L2p3ZjR6eUp2?=
 =?utf-8?B?MzZtYW9ub1pQNXg5U1hsM3BUeUtUbVNYOTFVaWNDcmcrRnQybUdLMEtPRVdq?=
 =?utf-8?B?Q1FEcXY1cDBhT1VvL2VubjNtMGN1MVVJbTVKSUt6WU5vak1DTmJRMXo0bDZ5?=
 =?utf-8?B?ODdkdnQyM3JYWHJ1QktCalBrWXhGTFZ6aUM1elF6ejQzVGQzYU9iVUxhYVNL?=
 =?utf-8?B?ZkwvNEFvaEhYVTdZNmFuMUpSUFVac2x3alFJNklGZVk3M1phYXNtWGdqR1Ez?=
 =?utf-8?B?SldiakxwWXlWR2hoczR2QXE4U2lYY2pSL05Odm0vOHI4OEo2aVdRNjJVNUQ1?=
 =?utf-8?Q?Xnyk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5068.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec572181-15ed-4414-8f06-08dbe9dbe7f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 15:18:10.1200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: spxcBvafrWK6tauXECXkQwupo67h9uh/yUbl6Qsabczd0XE3QHz+xnLb4AdSuW6hYWbcoUCovr+9ym3KGy0V3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8233
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWRyaWFuIEh1bnRlciA8
YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgMjAsIDIw
MjMgMTo0OSBBTQ0KPiBUbzogTGltaW5nIFN1biA8bGltaW5nc0BudmlkaWEuY29tPjsgVWxmIEhh
bnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+Ow0KPiBEYXZpZCBUaG9tcHNvbiA8ZGF2dGhv
bXBzb25AbnZpZGlhLmNvbT4NCj4gQ2M6IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAxLzFdIG1t
Yzogc2RoY2ktb2YtZHdjbXNoYzogRW5hYmxlIHRpbWVvdXQgcXVpcmsgZm9yDQo+IEJsdWVGaWVs
ZC0zIFNvQw0KPiANCj4gT24gMTgvMTEvMjMgMTU6NDYsIExpbWluZyBTdW4gd3JvdGU6DQo+ID4g
VGhpcyBjb21taXQgZW5hYmxlcyBTREhDSV9RVUlSS19CUk9LRU5fVElNRU9VVF9WQUwgdG8gc29s
dmUgdGhlDQo+ID4gaW50ZXJtaXR0ZW50IGVNTUMgdGltZW91dCBpc3N1ZSByZXBvcnRlZCBvbiBz
b21lIGNhcmRzIHVuZGVyIGVNTUMNCj4gPiBzdHJlc3MgdGVzdC4NCj4gPg0KPiA+IFJlcG9ydGVk
IGVycm9yIG1lc3NhZ2U6DQo+ID4gICBkd2Ntc2hjIE1MTlhCRjMwOjAwOiBfX21tY19ibGtfaW9j
dGxfY21kOiBkYXRhIGVycm9yIC0xMTANCj4gDQo+IFdlcmUgeW91IGFibGUgdG8gZGV0ZXJtaW5l
IHRoZSByb290IGNhdXNlPyAgRm9yIGV4YW1wbGUsDQo+IGlzIHRoZSBob3N0IGNvbnRyb2xsZXIg
dGltZW91dCBjb3JyZWN0LCBpcyB0aGUgZU1NQw0KPiBwcm92aWRpbmcgY29ycmVjdCB0aW1lb3V0
IHZhbHVlcywgaXMgdGhlIG1tYyBzdWJzeXN0ZW0NCj4gY2FsY3VsYXRpbmcgYSBjb3JyZWN0IHZh
bHVlLCBpcyBzZGhjaSBwcm9ncmFtbWluZyBhIGNvcnJlY3QNCj4gdmFsdWU/DQo+IA0KPiBJZiB0
aGVyZSBhcmUgcHJvYmxlbXMgb3V0c2lkZSB0aGUgaG9zdCBjb250cm9sbGVyIHRoZW4gd2UNCj4g
bmVlZCB0byBhZGRyZXNzIHRoZW0gYWxzby4NCg0KSXQgaXMgY2F1c2VkIGJ5IHRoZSBob3N0IGNv
bnRyb2xsZXIgdGltZW91dCwgYnV0IGlzIGhhcmQgdG8gdGVsbCB3aGV0aGVyIHRoZQ0KY29uZmln
dXJhdGlvbiBwcm92aWRlZCBieSB0aGUgY2FyZCBpcyBnb29kIGVub3VnaCBzaW5jZSBpdCdzDQpp
bnRlcm1pdHRlbnQgdW5kZXIgc3RyZXNzIHRlc3QgdGhlIFNvQyBuZWVkcyB0byB3b3JrIHdpdGgg
ZGlmZmVyZW50IGVNTUMgdmVuZG9ycy4gDQpJbiBVRUZJIGVNTUMgZHJpdmVyIHNpbWlsYXIgbWF4
IHRpbWVvdXQgKDB4ZSkgaXMgdXNlZCB0byBhdm9pZCBzdWNoDQppc3N1ZS4gVGhpcyBjb21taXQg
dHJpZXMgdG8gdXNlIGV4aXN0aW5nIHF1aXJrLCB3aGljaCBJIHRoaW5rIHRoYXQgaXQgd291bGQg
d29yayANCmlmIHRoZXJlIGlzIGFub3RoZXIgd2F5IHRvIGFkanVzdCB0aGUgVE9VVF9DTlQgcmVn
aXN0ZXIuIEFueSBjb25jZXJuIG9yIHN1Z2dlc3Rpb25zPw0KDQo+IA0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogTGltaW5nIFN1biA8bGltaW5nc0BudmlkaWEuY29tPg0KPiANCj4gRml4ZXMgdGFn
Pw0KDQpXaWxsIHVwZGF0ZSBpdCBpbiB2Mi4NCg0KPiANCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9t
bWMvaG9zdC9zZGhjaS1vZi1kd2Ntc2hjLmMgfCAzICsrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9tbWMvaG9zdC9zZGhjaS1vZi1kd2Ntc2hjLmMNCj4gYi9kcml2ZXJzL21tYy9ob3N0L3Nk
aGNpLW9mLWR3Y21zaGMuYw0KPiA+IGluZGV4IDNhM2JhZTY5NDhhOC4uM2M4ZmU4YWVjNTU4IDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtZHdjbXNoYy5jDQo+ID4g
KysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1kd2Ntc2hjLmMNCj4gPiBAQCAtMzY1LDcg
KzM2NSw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc2RoY2lfcGx0Zm1fZGF0YQ0KPiBzZGhjaV9k
d2Ntc2hjX3BkYXRhID0gew0KPiA+ICAjaWZkZWYgQ09ORklHX0FDUEkNCj4gPiAgc3RhdGljIGNv
bnN0IHN0cnVjdCBzZGhjaV9wbHRmbV9kYXRhIHNkaGNpX2R3Y21zaGNfYmYzX3BkYXRhID0gew0K
PiA+ICAJLm9wcyA9ICZzZGhjaV9kd2Ntc2hjX29wcywNCj4gPiAtCS5xdWlya3MgPSBTREhDSV9R
VUlSS19DQVBfQ0xPQ0tfQkFTRV9CUk9LRU4sDQo+ID4gKwkucXVpcmtzID0gU0RIQ0lfUVVJUktf
Q0FQX0NMT0NLX0JBU0VfQlJPS0VOIHwNCj4gPiArCQkgIFNESENJX1FVSVJLX0JST0tFTl9USU1F
T1VUX1ZBTCwNCj4gPiAgCS5xdWlya3MyID0gU0RIQ0lfUVVJUksyX1BSRVNFVF9WQUxVRV9CUk9L
RU4gfA0KPiA+ICAJCSAgIFNESENJX1FVSVJLMl9BQ01EMjNfQlJPS0VOLA0KPiA+ICB9Ow0KDQo=
