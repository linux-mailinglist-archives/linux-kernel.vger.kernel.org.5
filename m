Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE1E7FF447
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346572AbjK3QB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346496AbjK3QBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:01:53 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B72C10F1;
        Thu, 30 Nov 2023 08:01:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRTnNQYvC83aTPaaPGzRi2sQwx0bSSI9n31yZFkdInv3CDFXPCDh2EC6Roigz+OZ6haflIPnko4/ePL8ID8gRYmJJwtaIG58WH9mbYVPylxrTBZm8IJYdQ0YqYwbEOvZgrnSkUfFnozZc24Tzp+Fe4lrMbX7KHIsnpIqL9imJHF03XE9cijYQY5894quFRHbkT9gYXL8bYsEJ9H5r/aE/wtWucU5/foA03uYtJ7OF+f+8RZBySJpLO8cBHV7Wqm3zVPsfvpodcHco3QrPV1cZ/XjghjQcwawX/KXfxNHt42efcQ/FF0NN//F8rvM7rljvXUNF9p1hwlry430+pFy3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tn+WANNb21q+puwXfFioJmB9aRr2BRBHgrCSOfD1Jw4=;
 b=OrB874vD7byV636aYj1cmxZAIiuRnbzDguuPIR8L4nbz+4Rr+AdEW0gaXfp8FWoEiE9HZ9xQD9MtAhHp5qHo1t9WnKcxwq2fGKHi9QKJXTpla1Y3FIriZaIO4nKEOUK6R8FOloNWJrm7yApTVgUDEV5Dv0n5UhWRgyDoZCNBJaODlKFHh1hsVCD4hyB9hYFFBcvIFHoUW5yEYAltYky7kmmO5ei6mUZQhH+/a+9lSRsouOFrVXlh7OCnP6cCipjKy8ayM7S5sH8rkrwzQnZlxdbjkqLzruXCUVEKIPAmlTIauIvZfyvqDPz6ukGKk691v1FitsdHlDqemuwQ55YL3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tn+WANNb21q+puwXfFioJmB9aRr2BRBHgrCSOfD1Jw4=;
 b=oxvMOa9A530dzxADcUHFGdtnRIka89ItCXi7p+bGRbEC4syXgIMz152XyKJdZ7iLoILNPUcgr/Do3f2qaxdSdi/L9Fl9cKYABx4eXlzFZUVrjMXd/3vFieFDqX5L+KXtSisrMOzw49ARaOgXXHtEmIUoRWr/emFsNnjpG38vWFkOnmXFhkuy1CjN/7gVQqlK0r8f2u4/EeX+ZZYbfbSp7T7nImRKiaZfj9AzF5BLhTWbkPNfgIYrlTuGLBnAZRrrskDarYIFVCI0ggA9mYStjKUkp1jsEqFhYdgQi6SlSb1QsPJ7p7W8p2ZBObmTGA1ylpYS904iL+GOPE2hQYm3Kw==
Received: from BN9PR12MB5381.namprd12.prod.outlook.com (2603:10b6:408:102::24)
 by PH8PR12MB6891.namprd12.prod.outlook.com (2603:10b6:510:1cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Thu, 30 Nov
 2023 16:01:54 +0000
Received: from BN9PR12MB5381.namprd12.prod.outlook.com
 ([fe80::a02:fa08:8729:c1bb]) by BN9PR12MB5381.namprd12.prod.outlook.com
 ([fe80::a02:fa08:8729:c1bb%4]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 16:01:54 +0000
From:   Vadim Pasternak <vadimp@nvidia.com>
To:     =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>,
        Kunwu Chan <chentao@kylinos.cn>,
        David Thompson <davthompson@nvidia.com>
CC:     Hans de Goede <hdegoede@redhat.com>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        Shravan Ramani <shravankr@nvidia.com>,
        "kunwu.chan@hotmail.com" <kunwu.chan@hotmail.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] platform/mellanox: Add a null pointer check in
 mlxbf_pmc_create_groups
Thread-Topic: [PATCH] platform/mellanox: Add a null pointer check in
 mlxbf_pmc_create_groups
Thread-Index: AQHaIPwCDaGwCe5qCEqlEQ8ZVohNWLCSoX9UgABfdQCAAAaFIA==
Date:   Thu, 30 Nov 2023 16:01:54 +0000
Message-ID: <BN9PR12MB5381030454E0A19315002F2DAF82A@BN9PR12MB5381.namprd12.prod.outlook.com>
References: <20231127063433.1549064-1-chentao@kylinos.cn>
 <1701224213463629.329.seg@mailgw>
 <bf29c39f-8d9f-465a-bbc2-45bdb77711b8@kylinos.cn>
 <55c5987b-c991-aa8-a226-c5b1638b474@linux.intel.com>
In-Reply-To: <55c5987b-c991-aa8-a226-c5b1638b474@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5381:EE_|PH8PR12MB6891:EE_
x-ms-office365-filtering-correlation-id: 137f75ee-9ea5-419b-bfeb-08dbf1bdac4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JI1iN8rDb9m2pNG5fX9P2A73Ehelahy9xgP4lxO9IUgSMAEkd7LVC7J6EcT243l0l/dEOXSjQdTFd3VgCjgNh1po77vi250LiwVpfqAp7B6MSi37Nunceshr6IuWn0I0M8soUs69ZQIZZStAQqnQIsZCoWdjVa5vkHOhYrXQhi0XgwQSq5RS42QvSmFlwGzNi304zzB99FmiDd8WoGkyB9gyCYV8cjt7ADT3sgjpqgnnRgZc3ZOzcRvJXd8eXqr2EDcKNHJUQ9CeI0Tm63zUhhyO8GW+yMga3LWUNBNaAxtbGBnU0oLQ4fQvAef1OGLzlFqCBKL875Zy/AfviywpZv4bzMRizl9wbRp/daoy5g89AW7kKhceumC1yBzGi5FBvdrY4wehCzubTI0kTMOn8TpoJ67tZDKBqp/BvMVSfWUIeNMtnQx9B7MrQUUfYC0mYkUNzo22lFdtKslcM5H5PyWyv+ApDGMoP0eA42U3gB0IKwiORPuZJ0OfeWZexD4CGgAI6xic0oSvAtwZoptFVAMQLtp7T/v9rU7jmfJhjMTzxEjYvu8ClgmTQdeGJb3KgcN1m0s/osJwfTK9Uv5a4yUxw4H44DuiZX3LD8Gsk3+iVLkOYdJbwiCb4kOldvt6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5381.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(396003)(376002)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(2906002)(52536014)(53546011)(7696005)(9686003)(66556008)(6506007)(41300700001)(76116006)(110136005)(66946007)(54906003)(8676002)(66446008)(64756008)(316002)(66476007)(8936002)(4326008)(55016003)(45080400002)(5660300002)(71200400001)(478600001)(83380400001)(26005)(66574015)(6636002)(66899024)(38100700002)(122000001)(86362001)(38070700009)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXFMenVXekdlbzUyMkJLYkkzeUM4aC9jSHhOOGxKZ1BNMzc2ek9QQ0JuaGJm?=
 =?utf-8?B?eTY2N2tERnVmT0VkRzQ5YTI3T2M2TGlVNjlXdFdNWGZmRENDUXJvTVZCbmlI?=
 =?utf-8?B?U2hLTXhtdVk2WTlNMlNPMGdVM0x1NTc0bUQzSEVhWm4rWSt4U05GZnFDclFY?=
 =?utf-8?B?cFVhaU9GNkg2MU40QXpFNkVtRXVlOHhpUmhkcVE1LzFuSmZpOW1BU3NIL1JS?=
 =?utf-8?B?Yjk4U2Z5bGRPcmJJOUI0SFJOM0orNW9YekJmRDBRb1hNbkE0MHVac1NFL0VO?=
 =?utf-8?B?T0VhQnZNaktnSk5XOWZKQ0NuYkdmWCtkWlYwZEM3WmdHOEwya1Y0Z0JnLzgv?=
 =?utf-8?B?VE1XWVJ2RWw2OERmeWJLRTZvMVllRE5iT0tjOHNIT1MwUmxmakh2YmZ3NXVk?=
 =?utf-8?B?TUZMQnIvK3lRbWtXQnExcWRZQlA4UE1iKzdURW8vSDhJUnRNWVVXNlBhWTJY?=
 =?utf-8?B?Tk1uaWNraDd0Rk02bzNMcTZEYVJqTk5wa0pweTh3VkloSzJMbHU1K2V5aUtS?=
 =?utf-8?B?Q094dU84RmZmUGFLV3hSWW94WnNzSnNMWENtUGlSRUxVOWJYcFN4ZDl1V3hV?=
 =?utf-8?B?ejBBWUxIU0J1aVFRN2FpVStLdmp5eTNUOEVuMjE5TENPYnd6b01RblZubnpa?=
 =?utf-8?B?ekhMdGIrbzNmMC8zUWptcnNEKzFLV2NFdE9NOE14WG0vUlpEVGxmbVBLRXVn?=
 =?utf-8?B?R0xjSVZlWEVEWmQ2N01LRmk1VW5iWWtOUFVKZ1h1RWRTVHBvakRZUVM1cG1Z?=
 =?utf-8?B?bU5QUS9UcHdKR2Q2aVB0eUFVWjYwdW9hTXBGWmUyVng4ZlFpVFBZQXJlRmw1?=
 =?utf-8?B?LzM0OHlvYnVYdUlxbkdWY09jM2pEWGZPZGVWNEo1N0IxSzhlMGZ4aGV5UHdV?=
 =?utf-8?B?TzF2NE40cSs2TmVyT3ZSK1FkMExIWW0rSlk5em52dGFwR3RxWG0reVpuZWdT?=
 =?utf-8?B?aGpPUnJJNFF6dGVOQmxjR0FkdGJyemVGam5lTng0Q2FVTXoya3FRL1Z6Qzg1?=
 =?utf-8?B?WUd3ZmZBeWNSbklRSFRSdUxOOWd6Um1LbFppZFhmOFYyTDVvYzBOMjZhdGpo?=
 =?utf-8?B?WituN0ZSelJ6a0pqTml2K2NXN3F1VGZpVlZzSm0xQTc1dHNCYlU4emRCcW1P?=
 =?utf-8?B?Vmd4SFpxVW4yVzFBa3p2M1RMbFJONlBMWHY3M3V1M1N4WlJZQzNhMWdWZU9C?=
 =?utf-8?B?bkxYMXlHeWo2cm1OV0l2d0E3QUFNcmpaRW1FZXBzS3ZkMG5jdnJpUWJ6K0FG?=
 =?utf-8?B?V1grV2VYZlpEbS85ZW9xQzFJZFd4OWdpOXlpRElKbzd0R2JnbzdHeE9MZnR2?=
 =?utf-8?B?dUZHV0hoUVI2UU8rdTg3Z3pnT3Q2TnBmakFuaUVlaDlEQXNPalZySGprTGh3?=
 =?utf-8?B?QVU1R1h1bnFBVEIxZC9xUm1oUTErSWdreEFDSHZrSGhkcEJ6VEFlOVpRR0NK?=
 =?utf-8?B?akRJNkQ1TWxDNkNxK0pJSmh0eWgzUEcvYk02azY0T09iMW9PR2hQYUJvWkY4?=
 =?utf-8?B?V1MyV01nNDRvT01mSXNqL0lvVVpBMjErYkN2Ums5S0MrWGIxRkJzVUgxK0FL?=
 =?utf-8?B?Z2FEWkVLeWc4NVJTY0VmZmY0a1dkQWlYQ1gwU1hCMGRNQ3ZEY3VpSWloWjVG?=
 =?utf-8?B?Y1lweUJRejllZFhyVzQ2MnNlbGlLSVJUOERMa3Y3a2NvczlBQUF6OExtRGdq?=
 =?utf-8?B?VGtIUDRrUnVjZnZBcGZlVGFzdFZ2Z3Q5c2c1UnAzWGNGTU14SVVuQ3AzOWx0?=
 =?utf-8?B?MXJBTk5KeHFHNHBiWlM1N2dDVTNucElYWFh6dzVQMHZ6VHZqRm05UUFiTWdY?=
 =?utf-8?B?d1NzNm1rRDFCc0FiVC9TSFNHQ2RaQ05uZUloS1dXSXJHNzJSS3JtdkJRMkxj?=
 =?utf-8?B?TEhYcWlmNGRLM3ovQUxpYmdNTFJaN1hjc1hRZHc5Nnkrb1oxSUduOXpudHhH?=
 =?utf-8?B?d0lzdjZ4NThaNGdENVhGaWo2RG1SM0ozZC92RU9UUXNQdkZtWDNNdG1PRElI?=
 =?utf-8?B?ZG02NTM2RzV2NTlXQlYrRCszdk5ZcFRKaGt5eUR5Y3ZqNlp3Zit6SnFWd3dT?=
 =?utf-8?B?UDJXSWZ2d1dkMWlBTmhLcGx3d29jRFZvbnNnY2NDQkNEOG51SUp3UThXekFU?=
 =?utf-8?Q?Rt/w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5381.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 137f75ee-9ea5-419b-bfeb-08dbf1bdac4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 16:01:54.4569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ErxJ/vBQ/NKB1N2QRXPsUXloh8AQumbiNBnaZVv/H4Dr6U8vskTCX/+7ImGe/6QWexTlpPSJJk69Gl9JfbFGPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6891
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSWxwbyENCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbHBvIErD
pHJ2aW5lbiA8aWxwby5qYXJ2aW5lbkBsaW51eC5pbnRlbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5
LCAzMCBOb3ZlbWJlciAyMDIzIDE3OjI2DQo+IFRvOiBLdW53dSBDaGFuIDxjaGVudGFvQGt5bGlu
b3MuY24+OyBWYWRpbSBQYXN0ZXJuYWsNCj4gPHZhZGltcEBudmlkaWEuY29tPg0KPiBDYzogSGFu
cyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT47IGppcmlAcmVzbnVsbGkudXM7IFNocmF2
YW4NCj4gUmFtYW5pIDxzaHJhdmFua3JAbnZpZGlhLmNvbT47IGt1bnd1LmNoYW5AaG90bWFpbC5j
b207IHBsYXRmb3JtLQ0KPiBkcml2ZXIteDg2QHZnZXIua2VybmVsLm9yZzsgTEtNTCA8bGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gcGxhdGZvcm0v
bWVsbGFub3g6IEFkZCBhIG51bGwgcG9pbnRlciBjaGVjayBpbg0KPiBtbHhiZl9wbWNfY3JlYXRl
X2dyb3Vwcw0KPiANCj4gSGkgVmFkaW0sDQo+IA0KPiBDb3VsZCB5b3UgcGxlYXNlIHRha2UgYSBs
b29rIGF0IHRoaXMgYW5kIGdpdmUgYWR2aWNlIHRvIEt1bnd1IHNvIHdlIGNhbiBnZXQgYWxsDQo+
IG9mIHRoZW0gc3F1YXNoZWQgaW4gb25lIGdvLg0KDQpJdCBzZWVtcyB0aGVyZSBhcmUgc2l4IGNh
bGxzIGRldm1fa2FzcHJpbnRmKCksIHdoaWNoIHJlcXVpcmVzIGNoZWNraW5nIHBvaW50ZXIuDQoN
CkkgZ3Vlc3MsIGl0IGlzIGNvcnJlY3QgdG8gcmV0dXJuICctRU5PTUVNJyBmb3IgYW55IGZhaWx1
cmUuDQoNCkkgc2VlIHRoZXJlIGlzIGFub3RoZXIgcHJvYmxlbSBpbiBtbHhiZl9wbWNfcHJvYmUo
KSAtIGl0IGxhY2tzIGVycm9yIGZsb3cgZm9yOg0KCXBtYy0+aHdtb25fZGV2ID0gZGV2bV9od21v
bl9kZXZpY2VfcmVnaXN0ZXJfd2l0aF9ncm91cHMoDQoJCWRldiwgImJmcGVyZiIsIHBtYywgcG1j
LT5ncm91cHMpOw0KCQ0KTmVlZCB0byBhZGQ6DQoJaWYgKElTX0VSUihwbWMtPmh3bW9uX2Rldikp
DQoJCXJldHVybiBQVFJfRVJSKHBtYy0+aHdtb25fZGV2KTsNCg0KU2hhcnZhbiwgRGF2aWQsDQpD
b3VsZCB5b3UsIHBsZWFzZSwgaGF2ZSBsb29rPw0KDQo+IA0KPiBPbiBUaHUsIDMwIE5vdiAyMDIz
LCBLdW53dSBDaGFuIHdyb3RlOg0KPiANCj4gPiBUaGFua3MgZm9yIHlvdXIgcmVwbHkuDQo+ID4N
Cj4gPiBDYXVzZSBpIGRvbid0IGtub3cgaG93IHRvIGRlYWwgd2l0aCBpbiBzb21lIHNjZW5hcmlv
77yMc3VjaCBhcyBpbg0KPiA+ICdtbHhiZl9wbWNfaW5pdF9wZXJmdHlwZV9jb3VudGVyJywgd2hl
biAnYXR0ci0+ZGV2X2F0dHIuYXR0ci5uYW1lJyBpcw0KPiA+IG51bGwsIHNob3VsZCByZXR1cm4g
Jy1FTk9NRU0nIG9yICdjb250aW51ZScgdGhlIGxvb3A/DQo+IA0KPiBJJ2QgaGF2ZSB0aG91Z2h0
IHJldHVybmluZyAtRU5PTUVNIHdvdWxkIGJlIHNhZmUgYmVjYXVzZSBpdCBqdXN0IGVuZHMgdXAN
Cj4gZmFpbGluZyBwcm9iZSgpPyAuLi5BbmQgaXQncyBub3QgdGhhdCBsaWtlbHkgdG8gb2NjdXIg
aW4gdGhlIGZpcnN0IHBsYWNlLg0KPiANCj4gLS0NCj4gIGkuDQo+IA0KPiA+DQo+ID4gU28gSSdt
IGdvaW5nIHRvIHNvbHZlIGl0IG9uZSBieSBvbmUuDQo+ID4NCj4gPiBUaGFua3MgYWdhaW4sDQo+
ID4gS3Vud3UNCj4gPg0KPiA+IE9uIDIwMjMvMTEvMjggMTc6NTEsIElscG8gSsOkcnZpbmVuIHdy
b3RlOg0KPiA+ID4gT24gTW9uLCAyNyBOb3YgMjAyMywgS3Vud3UgQ2hhbiB3cm90ZToNCj4gPiA+
DQo+ID4gPiA+IGRldm1fa2FzcHJpbnRmKCkgcmV0dXJucyBhIHBvaW50ZXIgdG8gZHluYW1pY2Fs
bHkgYWxsb2NhdGVkIG1lbW9yeQ0KPiA+ID4gPiB3aGljaCBjYW4gYmUgTlVMTCB1cG9uIGZhaWx1
cmUuDQo+ID4gPiA+DQo+ID4gPiA+IEZpeGVzOiAxYTIxOGQzMTJlNjUgKCJwbGF0Zm9ybS9tZWxs
YW5veDogbWx4YmYtcG1jOiBBZGQgTWVsbGFub3gNCj4gPiA+ID4gQmx1ZUZpZWxkIFBNQyBkcml2
ZXIiKQ0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBLdW53dSBDaGFuIDxjaGVudGFvQGt5bGlub3Mu
Y24+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgIGRyaXZlcnMvcGxhdGZvcm0vbWVsbGFub3gvbWx4
YmYtcG1jLmMgfCAyICsrDQo+ID4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wbGF0Zm9ybS9tZWxsYW5v
eC9tbHhiZi1wbWMuYw0KPiA+ID4gPiBiL2RyaXZlcnMvcGxhdGZvcm0vbWVsbGFub3gvbWx4YmYt
cG1jLmMNCj4gPiA+ID4gaW5kZXggMGI0MjdmYzI0YTk2Li41OWJiZTVlMTNmNmIgMTAwNjQ0DQo+
ID4gPiA+IC0tLSBhL2RyaXZlcnMvcGxhdGZvcm0vbWVsbGFub3gvbWx4YmYtcG1jLmMNCj4gPiA+
ID4gKysrIGIvZHJpdmVycy9wbGF0Zm9ybS9tZWxsYW5veC9tbHhiZi1wbWMuYw0KPiA+ID4gPiBA
QCAtMTg4Miw2ICsxODgyLDggQEAgc3RhdGljIGludCBtbHhiZl9wbWNfY3JlYXRlX2dyb3Vwcyhz
dHJ1Y3QNCj4gPiA+ID4gZGV2aWNlICpkZXYsIGludCBibGtfbnVtKQ0KPiA+ID4gPiAgIAlwbWMt
PmJsb2NrW2Jsa19udW1dLmJsb2NrX2F0dHJfZ3JwLmF0dHJzID0NCj4gPiA+ID4gcG1jLT5ibG9j
a1tibGtfbnVtXS5ibG9ja19hdHRyOw0KPiA+ID4gPiAgIAlwbWMtPmJsb2NrW2Jsa19udW1dLmJs
b2NrX2F0dHJfZ3JwLm5hbWUgPSBkZXZtX2thc3ByaW50ZigNCj4gPiA+ID4gICAJCWRldiwgR0ZQ
X0tFUk5FTCwgcG1jLT5ibG9ja19uYW1lW2Jsa19udW1dKTsNCj4gPiA+ID4gKwlpZiAoIXBtYy0+
YmxvY2tbYmxrX251bV0uYmxvY2tfYXR0cl9ncnAubmFtZSkNCj4gPiA+ID4gKwkJcmV0dXJuIC1F
Tk9NRU07DQo+ID4gPiA+ICAgCXBtYy0+Z3JvdXBzW3BtYy0+Z3JvdXBfbnVtXSA9ICZwbWMtDQo+
ID5ibG9ja1tibGtfbnVtXS5ibG9ja19hdHRyX2dycDsNCj4gPiA+ID4gICAJcG1jLT5ncm91cF9u
dW0rKzsNCj4gPiA+DQo+ID4gPiBJJ20gdG90YWxseSBsb3N0LCB3aHkgZGlkIHlvdSBmaXggb25s
eSBvbmUgZGV2bV9rYXNwcmludGYoKSBsb2NhdGlvbj8NCj4gPiA+IERvbid0IGFsbCBvZiB0aGVt
IG5lZWQgdGhpcyBjaGVjaz8NCj4gPiA+DQo+ID4NCg==
