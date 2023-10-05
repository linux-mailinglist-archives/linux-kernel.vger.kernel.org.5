Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02447BA336
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbjJEPwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbjJEPvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:51:03 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E4B8EA1
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:09:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUTwaC42EG5SiBTZSc8JgL04VjSGd9oyoypxiiiWA2fD9btay27ahhkPOfDrjGuJkInEmsKQHKxdPbf8WIFB3UIIuI52qm+Da3/G2NC3oBh4tBkMAkLnJ9Ju9N0MurUNHA+FRogFbpPDHjEp9Z9pzdj/xZ9ETlJdBeSCaOPSvsUc5xJ2/odDjToPZnoOIPPUjgKOEt+cXSLVHM8X0P8X7TAf2HAJNkvfqBUGZq8HLcS5+Y0waW7ZOI9jeUqj/RBnKY2kpHrOCvARoZbPaIe1k1BktzYzQJsv/Ac034yXh8jklW07s6d9LPGdX5NaRcZq5JwxnQDD3R0TFozU/2+GXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W21Uwlm8x1aO2mz2cJMlr7Yrc8jM4dqvXMjcI49w27w=;
 b=I7J8z4FdRoW8gwqw2+WNTZfv8HFBui27F8CsAzbolgVLKldcufgxrDoOjgHDU2saqT2F4M2UxvL4UAcfWKuF0XvUM/ce2UyGWkMOkWn8ngGJAnGQmeH/Lx05YnWo5WAgjWBGEPVbQjAT1NA98NxIUr2dhXSLCBeXbSnN6XAzn/UcETCTZl9FVo79wdv7pItDg5jkyK1HPxsPuXTdIQzAZULnioc6e5lYqDo1nYCltdYqCs9Be6u5SHRxSYlfdIrM3wLxpMIEzGzV9szTyfMzdWVbK6eq3zqePqEJl1uI+OidGwfzMYN+LdFj2qktetxNzOn0Kos9tSDSocVth2eizQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W21Uwlm8x1aO2mz2cJMlr7Yrc8jM4dqvXMjcI49w27w=;
 b=ke5WHSb4gMLh8aQYJZHT5jKv8szs6cKgcXleP/HDSTCP5cKZgH9DOuUhyVzGEyNiEJE2TWN71U9hBSnPG+VHPH1YpC6BcgHAe2rWsMIW6aYEUp9hnhD55btWL2sQBgomH1WLLfo9OR5riFiwEgYDOBaY/viWjHmpBxUnI0soCCw=
Received: from DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17)
 by CY8PR12MB7290.namprd12.prod.outlook.com (2603:10b6:930:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 5 Oct
 2023 14:09:39 +0000
Received: from DM6PR12MB4465.namprd12.prod.outlook.com
 ([fe80::ac8d:39d3:c560:3c81]) by DM6PR12MB4465.namprd12.prod.outlook.com
 ([fe80::ac8d:39d3:c560:3c81%4]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 14:09:39 +0000
From:   "Buddhabhatti, Jay" <jay.buddhabhatti@amd.com>
To:     "Simek, Michal" <michal.simek@amd.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     "Shah, Tanmay" <tanmay.shah@amd.com>,
        "Manne, Nava kishore" <nava.kishore.manne@amd.com>,
        "Levinsky, Ben" <ben.levinsky@amd.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "marex@denx.de" <marex@denx.de>,
        "Shaikh, Izhar Ameer" <izhar.ameer.shaikh@amd.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "ruanjinjie@huawei.com" <ruanjinjie@huawei.com>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Kannan, Arun Balaji" <arun.balaji.kannan@amd.com>
Subject: RE: [PATCH v2 6/6] drivers: soc: xilinx: update maintainer of event
 manager driver
Thread-Topic: [PATCH v2 6/6] drivers: soc: xilinx: update maintainer of event
 manager driver
Thread-Index: AQHZ9qcuCiY/b8yPY0qIylvRj4e2XbA5jA+AgAAQioCAAAitAIAADUwAgAGKjUA=
Date:   Thu, 5 Oct 2023 14:09:39 +0000
Message-ID: <DM6PR12MB4465D25826A74C22B3FC4C1F9DCAA@DM6PR12MB4465.namprd12.prod.outlook.com>
References: <20231004094116.27128-1-jay.buddhabhatti@amd.com>
 <20231004094116.27128-7-jay.buddhabhatti@amd.com>
 <2023100446-jokester-uncrushed-c9b2@gregkh>
 <48bc9520-fd5f-43fc-9adf-2a9e0493109a@amd.com>
 <2023100444-dose-laziness-d488@gregkh>
 <d4ee1dc7-d642-4cbc-a2a6-200cd1fcc96f@amd.com>
In-Reply-To: <d4ee1dc7-d642-4cbc-a2a6-200cd1fcc96f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4465:EE_|CY8PR12MB7290:EE_
x-ms-office365-filtering-correlation-id: 03f638c4-6af3-4b4b-dc4f-08dbc5acb6d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5V4YV3SuxV02vMkQtPp7mlS4nJ7USbYQOHYnbMdbW9vfTY2r3Lozd0ZPrhMhd8KN60xQGIxJXoa2tsTTrjG2zXe8RfcPu/YIMDjMUjdM/xu2C1Ts/9GNm2eVDwtBWNteY5JKeSGIP4Rn82Z/VbOCeXNdAI+WyND+YnHN7x1yoDvcgp/1TGXz86I1mJRg4WIH40mrTB9r9DHM2BUUbQWqlwpL0dNdKEKPoUwJvT8U736gPoKzFNRTLgmLcRWIFWKa0Jxc4C3JDZd3WidVXGDskoz1bUOAOscxdZ4iTKI+2PxL+e0TZrVXHmttpqit1kaLHgc5Ln8LsZ1q3IP5x7U5MEB3uKgU4YwcINZkMGgjOY5TzWvgjYU+p95vPDK8XzIUpckc0u/UMrNqaWHgm8jh7U3EWQgyBBbAi/7ybjqB5eDxEijL8f3FvmqYpLroMAoyTY1yvdpw+Xo8J6TzVo31R80PH5UHK9Q+jrCCsOdDIvR18QAyH/BFpnTMnhiOls6hiw2r8yCmaUrltrYuF+s7jF+LkRVWT1VDaDs6yjjJXLw6jnA2FZnVODCzPZjs0okUApoMtA577e7AnZAQXrbEZNWbrawaD2anI7mnFqE2YVqDrNsr+lwoTp8CeCiBNC1o
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4465.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(7696005)(9686003)(53546011)(478600001)(6506007)(71200400001)(83380400001)(26005)(2906002)(15650500001)(5660300002)(110136005)(66476007)(66946007)(66446008)(76116006)(64756008)(8676002)(4326008)(41300700001)(52536014)(8936002)(316002)(54906003)(122000001)(86362001)(33656002)(38100700002)(38070700005)(55016003)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkJxU3ZQS0ZuKzZjMFhpeHhUWU9UTDMyOExNdllOVFRYaVNXQ1dGYTFGZ3M3?=
 =?utf-8?B?Tk1tbjJrb1ZXYStLbG5iNkd1T0pWMUc1STA0d2wzWkIyY1ZwUXdsNFRwR2N2?=
 =?utf-8?B?RGxINWt6aWVjMlc5eVFiYUZaRkJzaXBYd3Faa3JJT2JpcFZwRWMxQWtzeUR0?=
 =?utf-8?B?bzFCdDRHSHp3SFdHNm5SQzJLQk55MmorNTlCVUxUSHlNTEJaWUdSZlJWWWIr?=
 =?utf-8?B?Y1c3eXJUTVFIS3pUcE9jOENyOEVFa25WRkxLNkIrazl5Qm04SCt1aU1FdkxH?=
 =?utf-8?B?OWdWaDY1Y0V3Ny9TYWNpWnJRbk9EMktEYWxKQlZuZ1QvekRlTEJ0dERnWDZi?=
 =?utf-8?B?eEVXU0lQbU81VTRNM29pdE94cXI1M0hmMUloWWNzL2ZsZGgwbDhnVFV5eWhq?=
 =?utf-8?B?M095R2l0UWc2Nk1yS3FKa01uVXUxWW9GT3cwRWhjTVFldjlHRVppc0tLYlhP?=
 =?utf-8?B?MTk1QTM3Y3V5bEl5L0J6cml0YXJBc1dZQWsvVXVzQjZYUFo3NEE2L0Z5bXpl?=
 =?utf-8?B?cHRPM3JmVUJvV2tTcU1MekoxYjBtem1yQzlxNUZzUzhNZEFSR0EvVmZSakt5?=
 =?utf-8?B?dHRZYzAwNUZpTjFyU0FmYTM3c0dpaGVoM0swRGJCT3l0TGJxSVUra29WZ2Vk?=
 =?utf-8?B?czBKUmhVRmJyZXQvVGFzaG11aXZSYUF2aXBZVG5NdjVvdktHbkpHdGJjWnJ1?=
 =?utf-8?B?YzhTNndnMVV2NGlaUklYaE1nWFdSWTNHZUNvQkNsbEpnalVuTGc5RzlPaWYz?=
 =?utf-8?B?cms5ZkpxdDlaS2VtYTYwNVVsaEtmQzBvLzRkd082WkEzRjVWZDR5N1FlVy9o?=
 =?utf-8?B?TXVOVUd6NXlYSXVXNERxcUJ5dGd2Yk5WODVvRkNYZGY0d2d2V0MxaUtBYWxr?=
 =?utf-8?B?M0w0TURQNVlpdjk0dzFYcS93MWZmdkU2dzRPSk5DWWRDanVHTGliVU9hcGdM?=
 =?utf-8?B?T2FGZjZoZnlTM3dITndDVlZYRFhtUWVNSnR0QXZrQjBmVjl4ZWFyS0M0Sy9S?=
 =?utf-8?B?aW9Gc0tROC9VNkp3QWpzcjFweit6NFkvMmZtS1RLOTQvSm14RWoxcU1vQ0Zs?=
 =?utf-8?B?RHBOZzZSS3U0QVljc1ZrZWc3RDFTMHYxME9LenBkRnBZRk04bGUyL1ZrSzZQ?=
 =?utf-8?B?YWdwcHF1K1pyTElpSGVaZjFSaEluRUpQUVNNdjBqdFRiem1ERmE2Z2xpU0hZ?=
 =?utf-8?B?RU90S0tQR1lQM2xKY2FsSFNPOXVVNlhzaFRrajMrMDUyNnZ3S25oS2Z3Qm9m?=
 =?utf-8?B?elJrQkRSVjNSckxRR2ZwZmd6b1lOSFZxRVA1bEpqWWs2VW5UcjJvWC9ZY21S?=
 =?utf-8?B?RzVORVpTK2ttVnM3TlJTU1dYZGw2TnRKbDUraXFEMDdvaHFXTGtZVXFlemxI?=
 =?utf-8?B?eDlhQmhrb252Mmg2WlZYVVBDS0lTQmNIRmhUSE9RSWJRZ1pLN0U1U1J3OG9N?=
 =?utf-8?B?UDRvTURXRGNDVEtEQVQxVUlzNlBhR01uRklVdGlwdmtqd09OdnlWUTExQTNT?=
 =?utf-8?B?T0JrU1hRb1RwV1YyTDdNZmZDcnNBdWNqbG10YnFUOGRHcWwwLzlaMmFhRk96?=
 =?utf-8?B?V3VleGh1VTh4SjlKTnNvamJMUVFnb2owcjM1cmFNK3hGWVNidlYyN2I1NWxt?=
 =?utf-8?B?c3I2WHp4S1ZKalp5Qjlja2IrL0lIVzZzM2E3aVBYR2lUNlBPUHpHUmZFNjRM?=
 =?utf-8?B?clJNZFNxcEdROS94QVVKcXArTzFNaVBFckNsRWF3WlJjKzA0bHVqUGYwWkhm?=
 =?utf-8?B?VUp4R0lOQWJHUlNpRnBtSlZDcFVmeXhnS1pyN0JxeTU3MTBhSm9yeFVvTzAr?=
 =?utf-8?B?VEs2UXBxdFpnd2oxQXlvZlJ2WGcvQ1hiUWtmSFdFQjlPRjhka1RiUnMvcVVh?=
 =?utf-8?B?cWpOb3NJZ05iR0MvOEdlQjBhVWZLL0ZKYWFwNUorR0tBYVJHVjJGcVRjUStu?=
 =?utf-8?B?MVhTZ2dLSTkwZDlZMlFvTmNzMmlNWVkzZWl0RUNOdHpFQ1R1UnduNFJtWmUw?=
 =?utf-8?B?eHVnUGtaR1RXTGl5QUZvUytWRVoyb2xmSWMyWjRiNmdKeHJHa0lJNzZMd0lE?=
 =?utf-8?B?dlMrYXZHc1pldEFvUHpaSXUrWkVrQjZ2bFVYclNGSzBiam9EdTJQRmhLc3Nw?=
 =?utf-8?Q?r2ZQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4465.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f638c4-6af3-4b4b-dc4f-08dbc5acb6d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 14:09:39.5638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9JfMPCmoNQGdh48gspZ4H3IhD2BKAlaLOuxkKbgjjsIL50cUgjPKjT8+mILcC6kBkLjhY40dPk0C8DxMFJK4Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7290
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaW1laywg
TWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVy
IDQsIDIwMjMgODowNSBQTQ0KPiBUbzogR3JlZyBLSCA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5v
cmc+DQo+IENjOiBCdWRkaGFiaGF0dGksIEpheSA8amF5LmJ1ZGRoYWJoYXR0aUBhbWQuY29tPjsg
U2hhaCwgVGFubWF5DQo+IDx0YW5tYXkuc2hhaEBhbWQuY29tPjsgTWFubmUsIE5hdmEga2lzaG9y
ZQ0KPiA8bmF2YS5raXNob3JlLm1hbm5lQGFtZC5jb20+OyBMZXZpbnNreSwgQmVuIDxiZW4ubGV2
aW5za3lAYW1kLmNvbT47DQo+IHJvYmhAa2VybmVsLm9yZzsgZGhhdmFsLnIuc2hhaEBhbWQuY29t
OyBtYXJleEBkZW54LmRlOyBTaGFpa2gsIEl6aGFyDQo+IEFtZWVyIDxpemhhci5hbWVlci5zaGFp
a2hAYW1kLmNvbT47IGFybmRAYXJuZGIuZGU7DQo+IHJ1YW5qaW5qaWVAaHVhd2VpLmNvbTsgbWF0
aGlldS5wb2lyaWVyQGxpbmFyby5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MiA2LzZdIGRyaXZlcnM6IHNvYzogeGlsaW54OiB1cGRhdGUgbWFpbnRhaW5lciBvZiBl
dmVudA0KPiBtYW5hZ2VyIGRyaXZlcg0KPiANCj4gDQo+IA0KPiBPbiAxMC80LzIzIDE1OjQ3LCBH
cmVnIEtIIHdyb3RlOg0KPiA+IE9uIFdlZCwgT2N0IDA0LCAyMDIzIGF0IDAzOjE2OjE1UE0gKzAy
MDAsIE1pY2hhbCBTaW1layB3cm90ZToNCj4gPj4NCj4gPj4NCj4gPj4gT24gMTAvNC8yMyAxNDox
NywgR3JlZyBLSCB3cm90ZToNCj4gPj4+IE9uIFdlZCwgT2N0IDA0LCAyMDIzIGF0IDAyOjQxOjE2
QU0gLTA3MDAsIEpheSBCdWRkaGFiaGF0dGkgd3JvdGU6DQo+ID4+Pj4gQWRkZWQgTWljaGFsIGFz
IGEgbWFpbnRhaW5lciBvZiBldmVudCBtYW5hZ2VyIGRyaXZlciBhcyBBYmh5dWRheSBpcw0KPiA+
Pj4+IG5vIGxvbmdlciBpbiBBTUQtWGlsaW54Lg0KPiA+Pj4+DQo+ID4+Pj4gU2lnbmVkLW9mZi1i
eTogSmF5IEJ1ZGRoYWJoYXR0aSA8amF5LmJ1ZGRoYWJoYXR0aUBhbWQuY29tPg0KPiA+Pj4+IEFj
a2VkLWJ5OiBNaWNoYWwgU2ltZWsgPG1pY2hhbC5zaW1la0BhbWQuY29tPg0KPiA+Pj4+IC0tLQ0K
PiA+Pj4+ICAgIE1BSU5UQUlORVJTIHwgMiArLQ0KPiA+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+Pj4+DQo+ID4+Pj4gZGlmZiAtLWdpdCBh
L01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMgaW5kZXgNCj4gPj4+PiAzNTk3N2IyNjlkNWUuLmYz
NmZlZmQ3MDMyYiAxMDA2NDQNCj4gPj4+PiAtLS0gYS9NQUlOVEFJTkVSUw0KPiA+Pj4+ICsrKyBi
L01BSU5UQUlORVJTDQo+ID4+Pj4gQEAgLTIzNjcyLDcgKzIzNjcyLDcgQEAgRjoNCj4gCURvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvY2FuL3hpbGlueCxjYW4ueWFtbA0KPiA+
Pj4+ICAgIEY6CWRyaXZlcnMvbmV0L2Nhbi94aWxpbnhfY2FuLmMNCj4gPj4+PiAgICBYSUxJTlgg
RVZFTlQgTUFOQUdFTUVOVCBEUklWRVINCj4gPj4+PiAtTToJQWJoeXVkYXkgR29kaGFzYXJhIDxh
Ymh5dWRheS5nb2RoYXNhcmFAeGlsaW54LmNvbT4NCj4gPj4+PiArTToJTWljaGFsIFNpbWVrIDxt
aWNoYWwuc2ltZWtAYW1kLmNvbT4NCj4gPj4+DQo+ID4+PiBGb3Igb2J2aW91cyByZWFzb25zLCB3
ZSBuZWVkIGFuIGFjayBmcm9tIEFiaHl1ZGF5Lg0KPiA+Pg0KPiA+PiBIZSBubyBsb25nZXIgd29y
a3MgZm9yIFhpbGlueC9BTUQgYnV0IEkgaGF2ZSBhc2tlZCBoaW0gb24gc2lkZQ0KPiA+PiBjaGFu
bmVsIHRvIHJlcGx5IGFuZCBsZXQncyBzZWUgaWYgdGhpcyBpcyBnb2luZyB0byBoYXBwZW4gb3Ig
bm90Lg0KPiA+DQo+ID4gTWFudGFpbmVyc2hpcHMgZm9sbG93IHBlb3BsZSwgbm90IGNvbXBhbmll
cywgc28gaWYgaGUgd2FudHMgdG8ga2VlcA0KPiA+IGJlaW5nIHRoZSBtYWludGFpbmVyLCBoZSBj
YW4gYmUsIHRoZXJlJ3Mgbm8gcmVxdWlyZW1lbnQgZm9yIGhpbSB0bw0KPiA+IHN0ZXAgZG93bi4N
Cj4gDQo+IE5vIGRvdWJ0IGFib3V0IGl0IGJ1dCBub3JtYWxseSBpbiB0aGVzZSBjYXNlcyBwZW9w
bGUgc2VuZCBhIHBhdGNoIHRvIHN0YXJ0IHRvDQo+IHVzZSB0aGVpciBuZXcgZW1haWwgYWRkcmVz
cyB3aGljaCBpcyB3aGF0IGRpZG4ndCBoYXBwZW4gZm9yIHF1aXRlIGEgbG9uZyB0aW1lDQo+IGlu
IHRoaXMgY2FzZS4NCj4gSSBhbSBkZWZpbml0ZWx5IGhhcHB5IHRvIHdhaXQgc29tZSB0aW1lIGlm
IGhlIHJlYWN0cyBidXQgaWYgdGhlcmUgaXMgbm8gcmVhY3Rpb24NCj4gZm9yIHNvbWUgdGltZSB3
ZSBzaG91bGQgZml4IGl0Lg0KDQpbSmF5XSBJIGdvdCBpbmZvcm1hdGlvbiB0aGF0IEFiaHl1ZGF5
IGlzIGF3YXJlIGFib3V0IHRoaXMsIGJ1dCBoZSBpcyBub3QgZ29pbmcgdG8gcmVhY3Qgb24gaXQu
DQoNClRoYW5rcywNCkpheQ0KPiANCj4gVGhhbmtzLA0KPiBNaWNoYWwNCg==
