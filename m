Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD9880CB21
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343699AbjLKNhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343657AbjLKNhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:37:09 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AEDDB;
        Mon, 11 Dec 2023 05:37:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmImDvT0bYrk7aJszdBNc4g8OkLmCSvjqAXCdQvFKqEyfOoPJ3YDSZ9i05KpBjhuQk9pxZ5soZiC9ceK+e07lbHKCbNpA+P1Il7kLboZVyytrynHDrIgPaQpIgt2dKudJKdU+EmMMK9omAxQTlq+WQ+jWGE6WqLlWhxg66v1CCWsvc47KnYWzo8W7wyFqHo4S3QODtOXsygrfl2shhosZ39oQne9GSgyAKMH3WhBwoE7CPUeEoa2r33S52BGLv9gJAFfj9X2u25hBEX4kTEU5mSTxCF29Brdku432uvf8gvg7p7c4N0VxDS1Dro21ARhP6lrx4X6ucQOgVr/asQ3YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ve7NVVNWf5Szhwu6+1uYkRg2fzITBmr9QSsBQJWs8tY=;
 b=eGB2tmNVTJd0JuF6qqAvbYyIx7wdxkZBbyRHmxyEcOFhdENopJy38QAhJ1hwEvtiqspGACgXCa9N7rg6GAYp6DwdUhi4Gma/b1taX3xuEbhEbkUxwwjyJ8TmP18r+4OdkKxNwrx9Cg9Ij3kd/Tdpo3pHluCLS06vzFdZ58kIhNi9w/2T9q9bNFORLfIPJ50hT7PyXotND+LwYLurehhefkBgAzEdlnQO8pK+++2bmEp8qsBxbegqygEmBln1XWFnl2QIfGLMXD6FQ5piolC4G5wTTa6F/5rrMi1z53afOApaGVrkUQksQP3haMVG37fV7xT7SIkPWRSS4FS5Lw8ZRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ve7NVVNWf5Szhwu6+1uYkRg2fzITBmr9QSsBQJWs8tY=;
 b=hkwHah+eGlT4BfMF+x6pbbEzvggQ39BY16qBRjtO9uWrJI0nhuqbgvexPbPmgVY+lIeo+pnSQbazlxZzMq0YVXKhfcXfgo1cNXMr+dCwI1E9ysVGTgeDZIJbT5J/ypr8t3GNTXn59OaTVTZ6o7e67L9hY3gc5/xMpsyAZ181q+k=
Received: from BN7PR12MB2802.namprd12.prod.outlook.com (2603:10b6:408:25::33)
 by DS7PR12MB8420.namprd12.prod.outlook.com (2603:10b6:8:e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 13:37:10 +0000
Received: from BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::2a35:852d:bc78:ed64]) by BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::2a35:852d:bc78:ed64%7]) with mapi id 15.20.7068.033; Mon, 11 Dec 2023
 13:37:10 +0000
From:   "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "pratyush@kernel.org" <pratyush@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "sbinding@opensource.cirrus.com" <sbinding@opensource.cirrus.com>,
        "lee@kernel.org" <lee@kernel.org>,
        "james.schulman@cirrus.com" <james.schulman@cirrus.com>,
        "david.rhodes@cirrus.com" <david.rhodes@cirrus.com>,
        "rf@opensource.cirrus.com" <rf@opensource.cirrus.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "claudiu.beznea@tuxon.dev" <claudiu.beznea@tuxon.dev>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>
Subject: RE: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
Thread-Topic: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
Thread-Index: AQHaH4D9pFM5xtDoeEuMNIpXuxvtzbCcYmwAgAEJ+aCABhoaAIAAMcLwgAAzdICAADdZAA==
Date:   Mon, 11 Dec 2023 13:37:10 +0000
Message-ID: <BN7PR12MB28029EB1A7D09882878499A2DC8FA@BN7PR12MB2802.namprd12.prod.outlook.com>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <20231125092137.2948-8-amit.kumar-mahapatra@amd.com>
 <e2305642-55f1-4893-bea3-b170ac0a5348@linaro.org>
 <BN7PR12MB2802BEDFB821A1748185794CDC8AA@BN7PR12MB2802.namprd12.prod.outlook.com>
 <f5a47024-514a-4846-bc16-08cf0f9af912@linaro.org>
 <BN7PR12MB2802BB3DA682D9C13EF7DE08DC8FA@BN7PR12MB2802.namprd12.prod.outlook.com>
 <5a6f6764-6779-42b0-b6c6-3f638b85ef78@linaro.org>
In-Reply-To: <5a6f6764-6779-42b0-b6c6-3f638b85ef78@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR12MB2802:EE_|DS7PR12MB8420:EE_
x-ms-office365-filtering-correlation-id: 6a9f118e-dede-4c76-bc5f-08dbfa4e46d0
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZgwEJ/Ngg0/0WpJOvEbOQIw3Svfcn8NaeH3PtBVnMeZET10i45UEc5oxvOEfxJmPaZ+dY02uqgb60Gg7rmhOXrjGbKL8NT2Dt/y0LQEfZCluJ2/ladonTbWMOsCxrNf1nTlYiS+6tDUvusBrCbd7ng0RK8sWOMo23aNCDzJce3AB1MX1BjmARffGnNqbKwdqIosE1HIliBRqdgyWXPNdqbb6SI+7j6W59l2CBhib2r+1jEQG8BZDN8YWM4mqQzLzU3dykm2q0M/6ic9E0X69Xakj0iFvvU9sLIu/8fa8cYNainWRLcZ16ObSmZbFtS3eCWrfvxOd+nH0sR5AwitATiPM/2ohV5gAyxo1lUtaikgYlGyZaAcqpO2e9DjVcHR0kCha59sH2hreFpah2irJc7Ibr+K6KUlwU6+FHH0QpQbe7giOcwr4Evgg0/db8vk3g6o6pyBIB/CCkyNYF95h5IQMXtekhQWewMxuGS/nJCElSaiGCOVuahV/K4DizJa5ZRy/iDkRV6VdlwYyCuweJ5PI/UkIwE+2UmleFbD4JKStSX+B2nbq7BzMWGdKOHcsQtqzA1YutbdDL8NJSQa+aXpSOCuAF+eE04OMbmgh0rwEGkgDDlb80hHpAutHrcBE7NwUJYJa4/a62CDiWst+c3j5R68sEhhXT8lA6jSky8w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR12MB2802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(136003)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(26005)(6506007)(7696005)(71200400001)(9686003)(53546011)(5660300002)(83380400001)(7416002)(52536014)(41300700001)(2906002)(4326008)(478600001)(8676002)(8936002)(66946007)(110136005)(76116006)(316002)(66556008)(54906003)(64756008)(66446008)(66476007)(966005)(122000001)(33656002)(38100700002)(86362001)(38070700009)(921008)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0lwVWprcjFEU3BjbzlCWGlPVEpxZzBsZG9vam5rWXE3blpkcmRpRXBzc0pl?=
 =?utf-8?B?S1lwTVp2MjRZbDJPZHZXVFBjQ081NkZ6bUNCbmNnK0FPb2pXZW1WOEFWcHFs?=
 =?utf-8?B?YnlqY0phTkdFRms0ZklSSEZDZjNHSk5Fb1hsdkFydTErUFg2SERCd1RsKzRJ?=
 =?utf-8?B?WXpCUmFpOGVKWHRsS0FBSGNaWXlxWTdIb0dBelBMQjE0QUl4SnNDMEZ4K1Bt?=
 =?utf-8?B?Q3ZjUGoreVZnejliN1RqS09OeUI1UFNHek00S3JQM0ZmQS80VS9UVDRkOG9x?=
 =?utf-8?B?angwOTB1OFNuU1BieHdBUm1SVXJDOTN1UGJGeFBnamxoRFZLWGVOUWpNbVpt?=
 =?utf-8?B?WDVkSzBJK2lTN2tkdGV3M2h2N3paRlozdUFEeFFNMUF2NUFPdzF4Yy9MTk1C?=
 =?utf-8?B?b3M2ZUhyNHZadkN1b2N3MGFoMzJ6Q2UrREJTd05XaU1kUkQyK3J4Z2lsMkdI?=
 =?utf-8?B?cEJDSS9PaG1JWGg4VktqdzYwQi9ONDNBa1JMYVNBTW1ycTRnQm5aSkh4eGNh?=
 =?utf-8?B?am1FcExaSEVYbHRlbTFHdHd1R2VMWlYrakFRUFBXZUVaTDNYVGFyQTZ6ODJB?=
 =?utf-8?B?b21oYUVtTjVOaS9IdmRzb3VldWZiMko3aWdBY0V2bk5LTkorQ1I1Y1M2azIr?=
 =?utf-8?B?NmtndU9CZ2NQMzI0UjRHYnh3RHBvb1VMSFB0MHBZUFh1RkNzdU0zQnZyVkk3?=
 =?utf-8?B?dWdManQrS1VyZmpWRjFnYU04UUJod0FBYU5pc3IzdExYVGdjclJDVFp5TFVh?=
 =?utf-8?B?aUdBS3YyZWZUWGhIcXl5eEJkWkdZWGdtMHptd3ZzTkREMWtnblNhNUpHOW5P?=
 =?utf-8?B?YVgweE9jNHg3MUZycnFmeElub1hUUG8zSnVRS1g5b25TM2FBV1doSjFMNFVC?=
 =?utf-8?B?S1dnNWpnbkE0UzY2V25rVjFJRSswaWE2T25Gd00rdzdET3FLQ0l1cUN1MGQ3?=
 =?utf-8?B?bmRNbHp0OWNDOUE1ZmNJWDcyMmlLaVpyTFQ0dUZWR1lOY2xjdjBTWGkwbFM1?=
 =?utf-8?B?RGYyNEM0eGNkVjFqT0doVUpBaVZ0RTgxS2FPMXcxczBvM2hWTWwxeXUwZUxW?=
 =?utf-8?B?eVVLQzh6Y2xCZXdCdlRnWWphbk43cFg3Z1ZBUU1CaDZLNW4vbHVGakFLZFBq?=
 =?utf-8?B?d0w3czlQTFVxTEg3WTNnNlJwTDdDS1U3VERFNFljZFMxNDd3bUpqYjNLN2xm?=
 =?utf-8?B?MTRjbnVmb2V0cTZBeWJrNEVKLzJSS0ZNUm5wVHpZYTFQcm84QnZObDV6MXNF?=
 =?utf-8?B?c2dKSEtxRUI4Mjh3dVp4L1BJZFpkQjRqVE5XQnowaVdFdlVDbVUwVHk5WTNn?=
 =?utf-8?B?amNjYm83aWROZFJLK3gxMXF3U0k1WXdtcFRPS0NFSFh6MEZPMmNTRHRvSUdn?=
 =?utf-8?B?d1R4aHJZSW9mZU1hbVhSZ0Z1T3d1SHRQQ3JXM05TZ2tYUzNVWUZmeTlEc3F0?=
 =?utf-8?B?S1hSUEhSbXRDcEVRdnBMb3B1ZTV6K2V6K3A4S2JuSXNUU2RNdU5zd2cvN3Ax?=
 =?utf-8?B?bm85U1FQUWRxeWhtdmU2TEVNMkhyVDJ1RjQ4SlJvbDcyZHFoUlNxdlBKdkts?=
 =?utf-8?B?UTFCdnV2a1plZWNseFhTb0Z4SU9OZ1p0eitCckh3ZkZxbzRNUlU0enQ2SXhq?=
 =?utf-8?B?L3dsY0NoNFhTVno3bjlPVkwwb0FDb252clNCS1diZmFsUXFBL2VpcExUaVd1?=
 =?utf-8?B?d3dMZm9rbzVEcm1UM2VqYytLNEFjQnJjMUdteWhJZnd2cHZqWmVXNUNIcFRa?=
 =?utf-8?B?TFVYalpkU1ZLM0w4UURPdDRHYjhqR1V2RTNURS9VWU5JaW1xU3JRL00reDVT?=
 =?utf-8?B?MVIxZnhUMmZTY0lPL3FuUnNMeVk1OVBWSlBCa2RuRWhrcm1sbHVWc3ptR3l5?=
 =?utf-8?B?UmVyWEoxYjE1ajNZR3c2b2VNTHJmYjA1ZkthY2FXWjlmZ0ZtMHQ2cExid0Fh?=
 =?utf-8?B?dHEzdytBRWdjMjhIckhGenhmbzdDRGl3aU11bEZ6elBxTFV3cGlBbEZMUzls?=
 =?utf-8?B?NVpnUlUzcDNOUVNsZ0wzY1J4MmtDYzlSVy9CNFdVUk5aUWZpTndySDdCZSta?=
 =?utf-8?B?K0h4TjRtWE1qcXhVZFB3R2RZUlVVZHBQVWE2aUw4VzB4dHg1TFAxTlV4VzNE?=
 =?utf-8?Q?8Gd0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9f118e-dede-4c76-bc5f-08dbfa4e46d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 13:37:10.4940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wJyqlvxBGm+GSzTd4MmOdMZfpbqo/zkDjVEQLro1VFmv1+qRhgwkJv1v9dETZPL5F8awRn59Ajp9eUfwpIuoKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8420
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVHVkb3IgQW1iYXJ1cyA8
dHVkb3IuYW1iYXJ1c0BsaW5hcm8ub3JnPg0KPiBTZW50OiBNb25kYXksIERlY2VtYmVyIDExLCAy
MDIzIDM6MDUgUE0NCj4gVG86IE1haGFwYXRyYSwgQW1pdCBLdW1hciA8YW1pdC5rdW1hci1tYWhh
cGF0cmFAYW1kLmNvbT47DQo+IGJyb29uaWVAa2VybmVsLm9yZzsgcHJhdHl1c2hAa2VybmVsLm9y
ZzsgbWlxdWVsLnJheW5hbEBib290bGluLmNvbTsNCj4gcmljaGFyZEBub2QuYXQ7IHZpZ25lc2hy
QHRpLmNvbTsgc2JpbmRpbmdAb3BlbnNvdXJjZS5jaXJydXMuY29tOw0KPiBsZWVAa2VybmVsLm9y
ZzsgamFtZXMuc2NodWxtYW5AY2lycnVzLmNvbTsgZGF2aWQucmhvZGVzQGNpcnJ1cy5jb207DQo+
IHJmQG9wZW5zb3VyY2UuY2lycnVzLmNvbTsgcGVyZXhAcGVyZXguY3o7IHRpd2FpQHN1c2UuY29t
DQo+IENjOiBsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOw0KPiBtaWNoYWVsQHdhbGxlLmNjOyBsaW51eC1tdGRAbGlzdHMuaW5mcmFkZWFkLm9y
ZzsNCj4gbmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tOyBhbGV4YW5kcmUuYmVsbG9uaUBib290
bGluLmNvbTsNCj4gY2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2OyBTaW1laywgTWljaGFsIDxtaWNo
YWwuc2ltZWtAYW1kLmNvbT47IGxpbnV4LQ0KPiBhcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7IGFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZzsNCj4gcGF0Y2hlc0BvcGVuc291cmNlLmNp
cnJ1cy5jb207IGxpbnV4LXNvdW5kQHZnZXIua2VybmVsLm9yZzsgZ2l0IChBTUQtDQo+IFhpbGlu
eCkgPGdpdEBhbWQuY29tPjsgYW1pdHJrY2lhbjIwMDJAZ21haWwuY29tDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjExIDA3LzEwXSBtdGQ6IHNwaS1ub3I6IEFkZCBzdGFja2VkIG1lbW9yaWVzIHN1
cHBvcnQNCj4gaW4gc3BpLW5vcg0KPiANCj4gDQo+IA0KPiBPbiAxMi8xMS8yMyAwNjo1NiwgTWFo
YXBhdHJhLCBBbWl0IEt1bWFyIHdyb3RlOg0KPiA+DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BsaW5h
cm8ub3JnPg0KPiA+PiBTZW50OiBNb25kYXksIERlY2VtYmVyIDExLCAyMDIzIDk6MDMgQU0NCj4g
Pj4gVG86IE1haGFwYXRyYSwgQW1pdCBLdW1hciA8YW1pdC5rdW1hci1tYWhhcGF0cmFAYW1kLmNv
bT47DQo+ID4+IGJyb29uaWVAa2VybmVsLm9yZzsgcHJhdHl1c2hAa2VybmVsLm9yZzsgbWlxdWVs
LnJheW5hbEBib290bGluLmNvbTsNCj4gPj4gcmljaGFyZEBub2QuYXQ7IHZpZ25lc2hyQHRpLmNv
bTsgc2JpbmRpbmdAb3BlbnNvdXJjZS5jaXJydXMuY29tOw0KPiA+PiBsZWVAa2VybmVsLm9yZzsg
amFtZXMuc2NodWxtYW5AY2lycnVzLmNvbTsgZGF2aWQucmhvZGVzQGNpcnJ1cy5jb207DQo+ID4+
IHJmQG9wZW5zb3VyY2UuY2lycnVzLmNvbTsgcGVyZXhAcGVyZXguY3o7IHRpd2FpQHN1c2UuY29t
DQo+ID4+IENjOiBsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOw0KPiA+PiBtaWNoYWVsQHdhbGxlLmNjOyBsaW51eC1tdGRAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsNCj4gPj4gbmljb2xhcy5mZXJyZUBtaWNyb2NoaXAuY29tOyBhbGV4YW5kcmUuYmVs
bG9uaUBib290bGluLmNvbTsNCj4gPj4gY2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2OyBTaW1laywg
TWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47DQo+ID4+IGxpbnV4LSBhcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7IGFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZzsNCj4gPj4gcGF0
Y2hlc0BvcGVuc291cmNlLmNpcnJ1cy5jb207IGxpbnV4LXNvdW5kQHZnZXIua2VybmVsLm9yZzsg
Z2l0IChBTUQtDQo+ID4+IFhpbGlueCkgPGdpdEBhbWQuY29tPjsgYW1pdHJrY2lhbjIwMDJAZ21h
aWwuY29tDQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjExIDA3LzEwXSBtdGQ6IHNwaS1ub3I6
IEFkZCBzdGFja2VkIG1lbW9yaWVzDQo+ID4+IHN1cHBvcnQgaW4gc3BpLW5vcg0KPiA+Pg0KPiA+
Pg0KPiA+Pg0KPiA+PiBPbiAxMi84LzIzIDE3OjA1LCBNYWhhcGF0cmEsIEFtaXQgS3VtYXIgd3Jv
dGU6DQo+ID4+PiBIZWxsbyBUdWRvciwNCj4gPj4NCj4gPj4gSGkhDQo+ID4NCj4gPiBIZWxsbyBU
dWRvciwNCj4gPg0KPiANCj4gSGkhDQoNCkhlbGxvIFR1ZG9yLA0KPiANCj4gPj4NCj4gPj4+DQo+
ID4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4+PiBGcm9tOiBUdWRvciBBbWJh
cnVzIDx0dWRvci5hbWJhcnVzQGxpbmFyby5vcmc+DQo+ID4+Pj4gU2VudDogV2VkbmVzZGF5LCBE
ZWNlbWJlciA2LCAyMDIzIDg6MDAgUE0NCj4gPj4+PiBUbzogTWFoYXBhdHJhLCBBbWl0IEt1bWFy
IDxhbWl0Lmt1bWFyLW1haGFwYXRyYUBhbWQuY29tPjsNCj4gPj4+PiBicm9vbmllQGtlcm5lbC5v
cmc7IHByYXR5dXNoQGtlcm5lbC5vcmc7IG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb207DQo+ID4+
Pj4gcmljaGFyZEBub2QuYXQ7IHZpZ25lc2hyQHRpLmNvbTsgc2JpbmRpbmdAb3BlbnNvdXJjZS5j
aXJydXMuY29tOw0KPiA+Pj4+IGxlZUBrZXJuZWwub3JnOyBqYW1lcy5zY2h1bG1hbkBjaXJydXMu
Y29tOw0KPiBkYXZpZC5yaG9kZXNAY2lycnVzLmNvbTsNCj4gPj4+PiByZkBvcGVuc291cmNlLmNp
cnJ1cy5jb207IHBlcmV4QHBlcmV4LmN6OyB0aXdhaUBzdXNlLmNvbQ0KPiA+Pj4+IENjOiBsaW51
eC1zcGlAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+
Pj4+IG1pY2hhZWxAd2FsbGUuY2M7IGxpbnV4LW10ZEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+
Pj4+IG5pY29sYXMuZmVycmVAbWljcm9jaGlwLmNvbTsgYWxleGFuZHJlLmJlbGxvbmlAYm9vdGxp
bi5jb207DQo+ID4+Pj4gY2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2OyBTaW1laywgTWljaGFsIDxt
aWNoYWwuc2ltZWtAYW1kLmNvbT47DQo+ID4+Pj4gbGludXgtIGFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZzsgYWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnOw0KPiA+Pj4+IHBhdGNoZXNA
b3BlbnNvdXJjZS5jaXJydXMuY29tOyBsaW51eC1zb3VuZEB2Z2VyLmtlcm5lbC5vcmc7IGdpdA0K
PiA+Pj4+IChBTUQtDQo+ID4+Pj4gWGlsaW54KSA8Z2l0QGFtZC5jb20+OyBhbWl0cmtjaWFuMjAw
MkBnbWFpbC5jb20NCj4gPj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxMSAwNy8xMF0gbXRkOiBz
cGktbm9yOiBBZGQgc3RhY2tlZCBtZW1vcmllcw0KPiA+Pj4+IHN1cHBvcnQgaW4gc3BpLW5vcg0K
PiA+Pj4+DQo+ID4+Pj4gSGksIEFtaXQsDQo+ID4+Pj4NCj4gPj4+PiBPbiAxMS8yNS8yMyAwOToy
MSwgQW1pdCBLdW1hciBNYWhhcGF0cmEgd3JvdGU6DQo+ID4+Pj4+IEVhY2ggZmxhc2ggdGhhdCBp
cyBjb25uZWN0ZWQgaW4gc3RhY2tlZCBtb2RlIHNob3VsZCBoYXZlIGENCj4gPj4+Pj4gc2VwYXJh
dGUgcGFyYW1ldGVyIHN0cnVjdHVyZS4gU28sIHRoZSBmbGFzaCBwYXJhbWV0ZXINCj4gPj4+Pj4g
bWVtYmVyKCpwYXJhbXMpIG9mIHRoZSBzcGlfbm9yIHN0cnVjdHVyZSBpcyBjaGFuZ2VkIHRvIGFu
IGFycmF5DQo+ID4+Pj4+ICgqcGFyYW1zWzJdKS4gVGhlIGFycmF5IGlzIHVzZWQgdG8gc3RvcmUg
dGhlIHBhcmFtZXRlcnMgb2YgZWFjaA0KPiA+Pj4+PiBmbGFzaCBjb25uZWN0ZWQgaW4gc3RhY2tl
ZA0KPiA+Pj4+IGNvbmZpZ3VyYXRpb24uDQo+ID4+Pj4+DQo+ID4+Pj4+IFRoZSBjdXJyZW50IGlt
cGxlbWVudGF0aW9uIGFzc3VtZXMgdGhhdCBhIG1heGltdW0gb2YgdHdvIGZsYXNoZXMNCj4gPj4+
Pj4gYXJlIGNvbm5lY3RlZCBpbiBzdGFja2VkIG1vZGUgYW5kIGJvdGggdGhlIGZsYXNoZXMgYXJl
IG9mIHNhbWUNCj4gPj4+Pj4gbWFrZSBidXQgY2FuIGRpZmZlciBpbiBzaXplcy4gU28sIGV4Y2Vw
dCB0aGUgc2l6ZXMgYWxsIG90aGVyIGZsYXNoDQo+ID4+Pj4+IHBhcmFtZXRlcnMgb2YgYm90aCB0
aGUgZmxhc2hlcyBhcmUgaWRlbnRpY2FsLg0KPiA+Pj4+DQo+ID4+Pj4gRG8geW91IHBsYW4gdG8g
YWRkIHN1cHBvcnQgZm9yIGRpZmZlcmVudCBmbGFzaGVzIGluIHN0YWNrZWQgbW9kZT8NCj4gPj4+
PiBJZiBub3QsDQo+ID4+Pg0KPiA+Pj4gTm8sIGFjY29yZGluZyB0byB0aGUgY3VycmVudCBpbXBs
ZW1lbnRhdGlvbiwgaW4gc3RhY2tlZCBtb2RlLCBib3RoDQo+ID4+PiBmbGFzaGVzIG11c3QgYmUg
b2YgdGhlIHNhbWUgbWFrZS4NCj4gPj4+DQo+ID4+Pj4gd291bGRuJ3QgaXQgYmUgc2ltcGxlciB0
byBoYXZlIGp1c3QgYW4gYXJyYXkgb2YgZmxhc2ggc2l6ZXMgaW5zdGVhZA0KPiA+Pj4+IG9mIGR1
cGxpY2F0aW5nIHRoZSBlbnRpcmUgcGFyYW1zIHN0cnVjdD8NCj4gPj4+DQo+ID4+PiBZZXMsIHRo
YXQgaXMgYWNjdXJhdGUuIEluIGFsaWdubWVudCB3aXRoIG91ciBjdXJyZW50IHN0YWNrZWQgc3Vw
cG9ydA0KPiA+Pj4gdXNlIGNhc2Ugd2UgY2FuIGhhdmUgYW4gYXJyYXkgb2YgZmxhc2ggc2l6ZXMg
aW5zdGVhZC4NCj4gPj4+IFRoZSBwcmltYXJ5IHB1cnBvc2Ugb2YgaGF2aW5nIGFuIGFycmF5IG9m
IHBhcmFtcyBzdHJ1Y3Qgd2FzIHRvDQo+ID4+PiBmYWNpbGl0YXRlIHBvdGVudGlhbCBmdXR1cmUg
ZXh0ZW5zaW9ucywgYWxsb3dpbmcgdGhlIGFkZGl0aW9uIG9mDQo+ID4+PiBzdGFja2VkIHN1cHBv
cnQgZm9yIGRpZmZlcmVudCBmbGFzaGVzDQo+ID4+Pg0KPiA+Pg0KPiA+PiByaWdodC4gRG9uJ3Qg
ZG8gdGhpcyBjaGFuZ2UgeWV0LCBsZXQncyBkZWNpZGUgb24gdGhlIG92ZXJhbGwgYXJjaGl0ZWN0
dXJlIGZpcnN0Lg0KPiA+DQo+ID4gU3VyZS4NCj4gPj4NCj4gPj4+Pg0KPiA+Pj4+Pg0KPiA+Pj4+
PiBTUEktTk9SIGlzIG5vdCBhd2FyZSBvZiB0aGUgY2hpcF9zZWxlY3QgdmFsdWVzLCBmb3IgYW55
IGluY29taW5nDQo+ID4+Pj4+IHJlcXVlc3QgU1BJLU5PUiB3aWxsIGRlY2lkZSB0aGUgZmxhc2gg
aW5kZXggd2l0aCB0aGUgaGVscCBvZg0KPiA+Pj4+PiBpbmRpdmlkdWFsIGZsYXNoIHNpemUgYW5k
IHRoZSBjb25maWd1cmF0aW9uIHR5cGUgKHNpbmdsZS9zdGFja2VkKS4NCj4gPj4+Pj4gU1BJLU5P
UiB3aWxsIHBhc3Mgb24gdGhlIGZsYXNoIGluZGV4IGluZm9ybWF0aW9uIHRvIHRoZSBTUEkgY29y
ZSAmDQo+ID4+Pj4+IFNQSSBkcml2ZXIgYnkgc2V0dGluZyB0aGUgYXBwcm9wcmlhdGUgYml0IGlu
DQo+ID4+Pj4+IG5vci0+c3BpbWVtLT5zcGktPmNzX2luZGV4X21hc2suIEZvciBleGFtcGxlLCBp
ZiBudGggYml0IG9mDQo+ID4+Pj4+IG5vci0+c3BpbWVtLT5zcGktPmNzX2luZGV4X21hc2sgaXMg
c2V0IHRoZW4gdGhlIGRyaXZlciB3b3VsZA0KPiA+Pj4+PiBhc3NlcnQvZGUtYXNzZXJ0IHNwaS0+
Y2hpcF9zbGVjdFtuXS4NCj4gPj4+Pj4NCj4gPj4+Pj4gU2lnbmVkLW9mZi1ieTogQW1pdCBLdW1h
ciBNYWhhcGF0cmEgPGFtaXQua3VtYXItDQo+ID4+IG1haGFwYXRyYUBhbWQuY29tPg0KPiA+Pj4+
PiAtLS0NCj4gPj4+Pj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jICB8IDI3Mg0KPiA+Pj4+
PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tDQo+ID4+IC0tDQo+ID4+Pj4+ICBk
cml2ZXJzL210ZC9zcGktbm9yL2NvcmUuaCAgfCAgIDQgKw0KPiA+Pj4+PiAgaW5jbHVkZS9saW51
eC9tdGQvc3BpLW5vci5oIHwgIDE1ICstDQo+ID4+Pj4+ICAzIGZpbGVzIGNoYW5nZWQsIDI0MCBp
bnNlcnRpb25zKCspLCA1MSBkZWxldGlvbnMoLSkNCj4gPj4+Pj4NCj4gPj4+Pj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+ID4+Pj4+IGIvZHJpdmVycy9tdGQvc3Bp
LW5vci9jb3JlLmMgaW5kZXggOTNhZTY5YjdmZjgzLi5lOTkwYmU3YzdlYjYNCj4gPj4+Pj4gMTAw
NjQ0DQo+ID4+Pj4+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+ID4+Pj4+ICsr
KyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+ID4+Pj4NCj4gPj4+PiBjdXQNCj4gPj4+
Pg0KPiA+Pj4+PiBAQCAtMjkwNSw3ICszMDA3LDEwIEBAIHN0YXRpYyB2b2lkIHNwaV9ub3JfaW5p
dF9maXh1cF9mbGFncyhzdHJ1Y3QNCj4gPj4+Pj4gc3BpX25vciAqbm9yKSAgc3RhdGljIGludCBz
cGlfbm9yX2xhdGVfaW5pdF9wYXJhbXMoc3RydWN0IHNwaV9ub3INCj4gPj4+Pj4gKm5vcikgIHsN
Cj4gPj4+Pj4gIAlzdHJ1Y3Qgc3BpX25vcl9mbGFzaF9wYXJhbWV0ZXIgKnBhcmFtcyA9IHNwaV9u
b3JfZ2V0X3BhcmFtcyhub3IsDQo+ID4+Pj4gMCk7DQo+ID4+Pj4+IC0JaW50IHJldDsNCj4gPj4+
Pj4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gc3BpX25vcl9nZXRfZmxhc2hfbm9kZShub3Ip
Ow0KPiA+Pj4+PiArCXU2NCBmbGFzaF9zaXplW1NOT1JfRkxBU0hfQ05UX01BWF07DQo+ID4+Pj4+
ICsJdTMyIGlkeCA9IDA7DQo+ID4+Pj4+ICsJaW50IHJjLCByZXQ7DQo+ID4+Pj4+DQo+ID4+Pj4+
ICAJaWYgKG5vci0+bWFudWZhY3R1cmVyICYmIG5vci0+bWFudWZhY3R1cmVyLT5maXh1cHMgJiYN
Cj4gPj4+Pj4gIAkgICAgbm9yLT5tYW51ZmFjdHVyZXItPmZpeHVwcy0+bGF0ZV9pbml0KSB7IEBA
IC0yOTM3LDYgKzMwNDIsNDQNCj4gPj4+Pj4gQEAgc3RhdGljIGludCBzcGlfbm9yX2xhdGVfaW5p
dF9wYXJhbXMoc3RydWN0IHNwaV9ub3IgKm5vcikNCj4gPj4+Pj4gIAlpZiAocGFyYW1zLT5uX2Jh
bmtzID4gMSkNCj4gPj4+Pj4gIAkJcGFyYW1zLT5iYW5rX3NpemUgPSBkaXY2NF91NjQocGFyYW1z
LT5zaXplLCBwYXJhbXMtDQo+ID4+IG5fYmFua3MpOw0KPiA+Pj4+Pg0KPiA+Pj4+PiArCW5vci0+
bnVtX2ZsYXNoID0gMDsNCj4gPj4+Pj4gKw0KPiA+Pj4+PiArCS8qDQo+ID4+Pj4+ICsJICogVGhl
IGZsYXNoZXMgdGhhdCBhcmUgY29ubmVjdGVkIGluIHN0YWNrZWQgbW9kZSBzaG91bGQgYmUNCj4g
b2YNCj4gPj4+Pj4gK3NhbWUNCj4gPj4+PiBtYWtlLg0KPiA+Pj4+PiArCSAqIEV4Y2VwdCB0aGUg
Zmxhc2ggc2l6ZSBhbGwgb3RoZXIgcHJvcGVydGllcyBhcmUgaWRlbnRpY2FsIGZvciBhbGwNCj4g
dGhlDQo+ID4+Pj4+ICsJICogZmxhc2hlcyBjb25uZWN0ZWQgaW4gc3RhY2tlZCBtb2RlLg0KPiA+
Pj4+PiArCSAqIFRoZSBmbGFzaGVzIHRoYXQgYXJlIGNvbm5lY3RlZCBpbiBwYXJhbGxlbCBtb2Rl
IHNob3VsZCBiZQ0KPiBpZGVudGljYWwuDQo+ID4+Pj4+ICsJICovDQo+ID4+Pj4+ICsJd2hpbGUg
KGlkeCA8IFNOT1JfRkxBU0hfQ05UX01BWCkgew0KPiA+Pj4+PiArCQlyYyA9IG9mX3Byb3BlcnR5
X3JlYWRfdTY0X2luZGV4KG5wLCAic3RhY2tlZC0NCj4gbWVtb3JpZXMiLA0KPiA+Pj4+IGlkeCwN
Cj4gPj4+Pj4gKyZmbGFzaF9zaXplW2lkeF0pOw0KPiA+Pj4+DQo+ID4+Pj4gVGhpcyBpcyBhIGxp
dHRsZSBsYXRlIGluIG15IG9waW5pb24sIGFzIHdlIGRvbid0IGhhdmUgYW55IHNhbml0eQ0KPiA+
Pj4+IGNoZWNrIG9uIHRoZSBmbGFzaGVzIHRoYXQgYXJlIHN0YWNrZWQgb24gdG9wIG9mIHRoZSBm
aXJzdC4gV2Ugc2hhbGwNCj4gPj4+PiBhdCBsZWFzdCByZWFkIGFuZCBjb21wYXJlIHRoZSBJRCBm
b3IgYWxsLg0KPiA+Pj4NCj4gPj4+IEFscmlnaHQsIEkgd2lsbCBpbmNvcnBvcmF0ZSBhIHNhbml0
eSBjaGVjayBmb3IgcmVhZGluZyBhbmQgY29tcGFyaW5nDQo+ID4+PiB0aGUgSUQgb2YgdGhlIHN0
YWNrZWQgZmxhc2guIFN1YnNlcXVlbnRseSwgSSBiZWxpZXZlIHRoaXMgc3RhY2tlZA0KPiA+Pj4g
bG9naWMgc2hvdWxkIGJlIHJlbG9jYXRlZCB0byBzcGlfbm9yX2dldF9mbGFzaF9pbmZvKCkgd2hl
cmUgd2UNCj4gPj4+IGlkZW50aWZ5IHRoZSBmaXJzdCBmbGFzaC4gUGxlYXNlIHNoYXJlIHlvdXIg
dGhvdWdodHMgb24gdGhpcy4NCj4gPj4+IEFkZGl0aW9uYWxseSwgZG8geW91DQo+ID4+DQo+ID4+
IEknbSB3b25kZXJpbmcgd2hldGhlciB3ZSBjYW4gYWRkIGEgbGF5ZXIgb24gdG9wIG9mIHRoZSBm
bGFzaCB0eXBlIHRvDQo+ID4+IGhhbmRsZQ0KPiA+DQo+ID4gV2hlbiB5b3UgbWVudGlvbiAib24g
dG9wLCIgYXJlIHlvdSByZWZlcnJpbmcgdG8gaW5jb3Jwb3JhdGluZyBpdCBpbnRvDQo+ID4gdGhl
IE1URCBsYXllcj8gSW5pdGlhbGx5LCBNaXF1ZWwgaGFkIHN1Ym1pdHRlZCB0aGlzIHBhdGNoIHRv
IGFkZHJlc3MNCj4gDQo+IEkgbWVhbiBzb21ldGhpbmcgYWJvdmUgU1BJIE1FTSBmbGFzaGVzLCBi
ZSBpdCBOT1IsIE5BTkRzIG9yIHdoYXRldmVyLg0KPiBJbnN0ZWFkIG9mIHRyZWF0aW5nIHRoZSBz
dGFja2VkIGZsYXNoZXMgYXMgYSBtb25vbGl0aGljIGRldmljZSBhbmQgdHJlYXQgaW4gU1BJDQo+
IE5PUiBzb21lIGFycmF5IG9mIGZsYXNoZXMsIHRvIGhhdmUgYSBsYXllciBhYm92ZSB3aGljaCBw
cm9iZXMgdGhlIFNQSSBNRU0NCj4gZmxhc2ggZHJpdmVyIGZvciBlYWNoIHN0YWNrZWQgZmxhc2gu
IEluIHlvdXIgY2FzZSBTUEkgTk9SIHdvdWxkIGJlIHByb2JlZA0KPiB0d2ljZSwgYXMgeW91IHVz
ZSAyIFNQSSBOT1IgZmxhc2hlcy4NCj4gDQo+ID4gc3RhY2tlZC9wYXJhbGxlbCBoYW5kbGluZyBp
biB0aGUgTVREIGxheWVyLg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW10ZC8y
MDIwMDExNDE5MTA1Mi4wYTE2ZDExNkB4cHMxMy90Lw0KPiA+IEhvd2V2ZXIsIHRoZSBEZXZpY2Ug
VHJlZSBiaW5kaW5ncyB3ZXJlIGluaXRpYWxseSBub3QgYWNjZXB0ZWQuDQo+IA0KPiBPa2F5LCB0
aGFua3MgZm9yIHRoZSBwb2ludGVyLiBJJ2xsIHRha2UgYSBsb29rLg0KPiANCj4gPiBGb2xsb3dp
bmcgYSBzZXJpZXMgb2YgZGlzY3Vzc2lvbnMsIHRoZSBiZWxvdyBiaW5kaW5ncyB3ZXJlIGV2ZW50
dWFsbHkNCj4gPiBtZXJnZWQuDQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjIw
MTI2MTEyNjA4Ljk1NTcyOC00LW1pcXVlbC5yYXluYWxAYm9vdA0KPiA+IGxpbi5jb20vDQo+IA0K
PiBJIHNhdywgdGhhbmtzLg0KPiANCj4gPg0KPiA+PiB0aGUgc3RhY2tlZC9wYXJhbGxlbCBtb2Rl
cy4gVGhpcyB3YXkgZXZlcnl0aGluZyB3aWxsIGJlY29tZSBmbGFzaA0KPiA+PiB0eXBlIGluZGVw
ZW5kZW50LiBXb3VsZCBpdCBiZSBwb3NzaWJsZSB0byBzdGFjayAyIFNQSSBOQU5Ecz8gSG93DQo+
ID4+IGFib3V0IGEgU1BJIE5PUiBhbmQgYSBTUEkgTkFORD8NCj4gPj4NCj4gPj4gSXMgdGhlIGRh
dGFzaGVldCBvZiB0aGUgY29udHJvbGxlciBwdWJsaWM/DQo+ID4NCj4gPiBZZXMsDQo+ID4gaHR0
cHM6Ly9kb2NzLnhpbGlueC5jb20vci9lbi1VUy9hbTAxMS12ZXJzYWwtYWNhcC10cm0vUXVhZC1T
UEktQ29udHJvbA0KPiA+IGxlcg0KPiA+DQo+IA0KPiBXb25kZXJmdWwsIEknbGwgdGFrZSBhIGxv
b2suIEkgc2VlIHR3byBjbG9ja3MgdGhlcmUuIERvZXMgdGhpcyBtZWFuIHRoYXQgdGhlDQo+IHN0
YWNrZWQgZmxhc2hlcyBjYW4gYmUgb3BlcmF0ZWQgYXQgZGlmZmVyZW50IGZyZXF1ZW5jaWVzPyBE
byB5b3Uga25vdyBpZiB3ZQ0KDQpJbiBzdGFja2VkIGNvbmZpZ3VyYXRpb24sIGJvdGggZmxhc2hl
cyB1dGlsaXplIGEgY29tbW9uIGNsb2NrIChzaW5nbGUgDQpjbG9jayBsaW5lKS4gSW4gYSBwYXJh
bGxlbCBzZXR1cCwgdGhlIGZsYXNoZXMgc2hhcmUgdGhlIHNhbWUgY2xvY2sgYnV0IA0KaGF2ZSBk
aXN0aW5jdCBjbG9jayBsaW5lcy4gUGxlYXNlIHJlZmVyIHRoZSBkaWFncmFtcyBpbiB0aGUgc2Vj
dGlvbnMgDQpiZWxvdyBmb3IgcmVmZXJlbmNlLg0KaHR0cHM6Ly9kb2NzLnhpbGlueC5jb20vci9l
bi1VUy9hbTAxMS12ZXJzYWwtYWNhcC10cm0vUVNQSS1GbGFzaC1JbnRlcmZhY2UtRGlhZ3JhbXMN
Cj4gY2FuIGNvbWJpbmUgYSBTUEkgTk9SIHdpdGggYSBTUEkgTkFORCBpbiBzdGFja2VkIGNvbmZp
Z3VyYXRpb24/DQoNCk5vLCBYaWxpbngvQU1EIFFTUEkgY29udHJvbGxlcnMgZG9lc24ndCBzdXBw
b3J0IHRoaXMgY29uZmlndXJhdGlvbi4NCg0KUmVnYXJkcywNCkFtaXQNCj4gDQo+IEkgbmVlZCB0
byBzdHVkeSB0aGlzIGEgYml0LiBJJ2xsIHRyeSB0byBpbnZvbHZlIE1pY2hhZWwgYW5kIFByYXR5
dXNoIHRvby4NCj4gDQo+IENoZWVycywNCj4gdGENCg==
