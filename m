Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393287A7BDE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 13:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbjITL4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 07:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbjITL4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:56:13 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA79BE0;
        Wed, 20 Sep 2023 04:56:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vx2FrMF3KnLKUbEgmu4RKBXJYKRDMO+oSnSJ4+HEkkQIJhzzgC0NjfRhcDo7aEJULVwquV9Ps9G9m1Zz12MpyrIeFgHB2Ep3I5DL+KGgfMFYY3G9soJLe5JwG3JDas9/rAxid22O6viJgtyrAx1oF7vffqbfXQuqQV8CYuInn5uTHSxklZsztYFiP9+6+zoAJtUs50j3OuoUJXrUcMI8iENAAjZ+H5zctL9jyMJaMVLxzAAS54xJtVsqWyBW4RS7vMya/9n3WRAgy2+wzWsUP5DYiK0uNV72pdOy/VHTR8wuGk4dUfrpjmwvsGHs6vj/Mh3uhpqEI1PiriEkBaMDeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nhDFUP9fFx4LmhneM1+bm1OHZLs3grE8JD+yGg0jyI=;
 b=TMEq5XT3Sz/YsTMH3dvPMhUi/MuTAxlWV1s3l7dPhKx9C2ynW0ZDLoZYnP3vkmnnABVUISK5id9epvKDvOhEFancv9ZqR2hcZQU2kczmD1zGo0uMtLko+w2eChgFP1OPddEckrA2bkbNGR8Zg4YxbwlHN/AK5njQ0N44ERPEh8kFwh25HagLm/6OqRjL8PbH2tMvB5syIEb7FgYJGtXapuXivcQQAd7a2Fklnjq13tVd7S65FYs49LgqWeronPsnKAyt+P9b47sg4EpS4G/tIkw1OC5AAEpoLkZdzkcK0hv4qN/O/ehqCuA6SmChrM4kqjbAShwMpTb4tcnNpsBs5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nhDFUP9fFx4LmhneM1+bm1OHZLs3grE8JD+yGg0jyI=;
 b=mjtYXKyGAz/ssod1lcknYYnnj7/fsgpHSI1jfqD/FHiCJGpJw/oARj0RIMKCpRRW9U2QR+4QO54Y7jazoaRD8z5kYAnsUMqyk6d9nL6/eK1IE3Gb68Fsa/DgaIItNDjjYq9hBrX6xKy7sS3WHpzFuQNz1e4PAJbjYvd0roC6MYE=
Received: from BYAPR12MB4773.namprd12.prod.outlook.com (2603:10b6:a03:109::17)
 by BN9PR12MB5114.namprd12.prod.outlook.com (2603:10b6:408:137::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Wed, 20 Sep
 2023 11:56:02 +0000
Received: from BYAPR12MB4773.namprd12.prod.outlook.com
 ([fe80::be44:31c5:714a:21f3]) by BYAPR12MB4773.namprd12.prod.outlook.com
 ([fe80::be44:31c5:714a:21f3%7]) with mapi id 15.20.6813.017; Wed, 20 Sep 2023
 11:56:02 +0000
From:   "Katakam, Harini" <harini.katakam@amd.com>
To:     "Katakam, Harini" <harini.katakam@amd.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jakub Kicinski <kuba@kernel.org>,
        Jonas Suhr Christensen <jsc@umbraculum.org>
CC:     Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Haoyue Xu <xuhaoyue1@hisilicon.com>,
        huangjunxian <huangjunxian6@hisilicon.com>,
        Wang Qing <wangqing@vivo.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Esben Haabendal <esben@geanix.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Neeli, Srinivas" <srinivas.neeli@amd.com>,
        "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Subject: RE: RE: [PATCH net v2 1/2] net: ll_temac: Fix DMA resources leak
Thread-Topic: RE: [PATCH net v2 1/2] net: ll_temac: Fix DMA resources leak
Thread-Index: AQHZOZ4bIaLXD56kTU6BDUgiXUw8vK7DWxGAgAACc4CAAHb+AIA1bdoAgAADVwCAAK4eMIC21ZQAgAKjbYCAcZFrIA==
Date:   Wed, 20 Sep 2023 11:56:00 +0000
Message-ID: <BYAPR12MB4773956747F15A526249645B9EF9A@BYAPR12MB4773.namprd12.prod.outlook.com>
References: <20230205201130.11303-1-jsc@umbraculum.org>
 <20230205201130.11303-2-jsc@umbraculum.org>
 <5314e0ba3a728787299ca46a60b0a2da5e8ab23a.camel@redhat.com>
 <135b671b1b76978fb147d5fee1e1b922e2c61f26.camel@redhat.com>
 <20230207104204.200da48a@kernel.org>
 <bd639016-8a9c-4479-83b4-32306ad734ac@app.fastmail.com>
 <20230313114858.54828dda@kernel.org>
 <BYAPR12MB47736214A6B4AAF524752A8B9EBE9@BYAPR12MB4773.namprd12.prod.outlook.com>
 <19369234-8785-575b-ff24-9a21a9e82f0e@wanadoo.fr>
 <BYAPR12MB4773DCF723E65BCBFAF3AEF29E30A@BYAPR12MB4773.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB4773DCF723E65BCBFAF3AEF29E30A@BYAPR12MB4773.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4773:EE_|BN9PR12MB5114:EE_
x-ms-office365-filtering-correlation-id: 49a7861e-2d9d-4ed2-c5f3-08dbb9d08f30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6aLkZe72BSc/rrbT8uWPAivOowEMQ9g53zHdyptX2XChD0vQ6K9CMNDIOCdX0sDTWSLea6l9PEQh0r1JTXhNYP4hyord2DevhcK269DaAXt7My2t1SGcQtB0fPZlInoe60fqabnSVExkgXzF4gbPHOZfSGHIO18RjBRxpWng2DQsV95c/Fc859uW/GZ5a7YmbkaHVqrT3HM2pWROmwzOkXT1jzcPDRGH/ifMv9RzCl37/yOpSghBja4jwF1V9MlAFKqOXDFzIROzu/zRESkHH/JfJn+0fDyJyTRwopzC+JrElGm4CaTVYVLk2nxf4jM/un1RUzXSEREfB7yIhUtyekcHJFOshyksmsAIqOZryC8SLT59TQhsFL84cfoU8kbefLyXh+9DhZ3JVDJXyNTP0veVdcV6wdXZm96EDNarjYR/SPmtPC7J2HmQg/sWG3yheOx4M8s1RDnSuHeuo5n814/TAgzeC0URxW7d+waJivonk+eQhTbp9DupbZzhA1LE54S0BooXreFADh65xrapt1BjwRKqSkZpzsB2xJnwoTmSVfj4LjCaZrB1OZsawNZ40urLOyb1LPtFbDmoqTScRYtbqhLQVcUvmKv6hArJeTtSSlZFRvHY2nmGdUXGB9dw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4773.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(366004)(39860400002)(376002)(1800799009)(186009)(451199024)(478600001)(6506007)(7696005)(53546011)(71200400001)(9686003)(52536014)(26005)(2906002)(76116006)(66946007)(66446008)(54906003)(66556008)(64756008)(66476007)(316002)(8676002)(110136005)(4326008)(5660300002)(41300700001)(8936002)(7416002)(55016003)(33656002)(86362001)(83380400001)(122000001)(38100700002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVJMVUh4MUhNbWNsUHh2VXFzRHNnRXo0TU1EVXFmcmI5SEJPMDZTYm03R2tr?=
 =?utf-8?B?VEVSR3p4WDlTU0pJTTFoa3NJTHdBRFZiUEtqQlA3aDVuQ0JhdERnVU1nUXNt?=
 =?utf-8?B?bVRqdzBQVTZKKzBYRTl6Q2NsZ2gzT3VnM3N3T2M5YUZCRytWVkIrem5ObTlZ?=
 =?utf-8?B?dDBLY3FHcXlFRzYwTzBuVUNocklobWdVVlFYKzM3Y2UyaUx6blB4Z3NlVjBT?=
 =?utf-8?B?bVgzTEFvZjlWQUVUczl2dmMwQ1E1NzU0clVvT2VxSTZySnkwZlkzdy9RQUpr?=
 =?utf-8?B?cHVpSTFNcXIvMWRXbko0WElwajBaOVc3ZURzditvemxkQkZ1dEZMUzZpbDl5?=
 =?utf-8?B?RGczdlN0Q3ZKdldlbjNML1NzVWJOOHhYY2U2Wm9FT1Z6MDBuOU1lZGYwM1RI?=
 =?utf-8?B?UVZ2czVOd2l5cm4wTDRzMHhOTVp5eTFpZS9WS3o3ZjRyUHVWTmF6R3Rzak5U?=
 =?utf-8?B?ZnBUS1FpZXZDUVo5UDcxS3Y3K3pIOE56L1dVOEE2UGp0anh2dUxzeTVldHpV?=
 =?utf-8?B?aXVUZ1JVK3VGN0I2OVVZOUcrTi9JVm54bzZMUHRqWXVGbEMvUGVwTW1aQW9M?=
 =?utf-8?B?MlAwZmliUlp5aU1KYkt4SlNKVE5GUmZpUE1uZDB2QVhkVzhqUjBPK2RQS3pt?=
 =?utf-8?B?b01DWVJBM0ZNem93SlQ3cHQ3VFRHVzU4UEw4ZWdZQ1c4dCtnS3dWTUNkbHZ1?=
 =?utf-8?B?TkVhQkRHd2hINW1RMmtmeXBJVXlWOXVKdnA3d0F0elptcEF2NTBaS2tySkxQ?=
 =?utf-8?B?N2ZCdHpERjJlTEVvcDQ1UC82MTFkMXd6M3QwdHNETmNpRXVUT213TGFrZit1?=
 =?utf-8?B?TnZpOG05eTRZN2dacHYvV3FjTzR4MFc4MTNiMW5PTnNHMFdqQU9CTWx1QXU2?=
 =?utf-8?B?N0JrcVgxMGg5Wno2UFZoa0duUmZkYk5qQU8xeHFoUWtCeHl6SXJ3K3FwRERO?=
 =?utf-8?B?aVRlWXJkOThtNG5qWWNEKzluU2xtQzI5TDJHSzNqWHBZRTIwN1Q5c3pVWXgw?=
 =?utf-8?B?OXpvSVhzdzJXUllWYmJtQW1PM0FXd1FHZEU3K2I5VStzeWJTSUthYzdUOC9i?=
 =?utf-8?B?VlRmbkZDc1F6d3F5SEZ4ZmJsTzgzUXVReHBwSk1Vc29HUXRZQTQ1VFNNUlFm?=
 =?utf-8?B?M2pmTVlMK0F6Sk85TTErSElRT01COGppMXVaME5GeWMzNWtqcGJSNW9YRWIr?=
 =?utf-8?B?UjhUK1Z6dEx2WEsvbmFvWTk0VnhIWm1DRWt2Rkpnc3ZWcS9zZ2pPdjdmUElk?=
 =?utf-8?B?R3JRME8wK3JFU0hOQTdReFl3V2JOS08ybWdna3pDR3d2K0VocUNIVHVYTGY4?=
 =?utf-8?B?T1BJUWZJNVlUc3ZaODFtQitwWU5iNkdxdjduL3NGSEcvMkVqUDNiVDdkU29C?=
 =?utf-8?B?NnE1N2pFZm9vWEYrV3ZvQTYxMEFOU2U4ZzNqRUJWVFpVeGovWUVNeVptRFZ0?=
 =?utf-8?B?SXJLUS80elU2bG9ra21aRnNiNWgreHEzdVRoQWdrYitZVCtqc0xjNnU0VHl5?=
 =?utf-8?B?YXMxVVBTVFQyRXNYb3N3ZjhPaUtIZ2M4SDhzWXo2K3RjZW1BVjVpbncrUlFn?=
 =?utf-8?B?dmwwSlZoQUFjOEtNMC9hdkl4T3lyeCt0TGEwZHgvdEtXRW82VWJJNWRxTzZC?=
 =?utf-8?B?cm9xTEp2WFZCd3Bzc1VwY2V1VUFYUFFsdFdoNWoyWVErYzZTU1hBeU9iaklR?=
 =?utf-8?B?eDVrWFVmOHpjZUwrZVNkYWJTNjV0OWRCNmxkVnF1MkdGT2Zsd2JoNWExL21X?=
 =?utf-8?B?c1MzZ09iNk5yb2tOSkh6MVhkNUpBUGR2Y0o0V0RrOU4xMDZtUk9MNFA2Q0Jv?=
 =?utf-8?B?SExtbWF2Zlc0cy94eCs1MWs4bXdpTjhYTzdZVVhpanlobWxpbnRaRFR5T21s?=
 =?utf-8?B?L3lNS2FEZ1ZYVTBWREdvM25YQVQxSE1zbFRwdWhvS2ZSaEl5d1BpZFJCM2lH?=
 =?utf-8?B?MGFGa0QrQXUyZFpUZGRHejlHclM3aGZhRFU0bWt0VU4wdHJzT1p3alUzQ3Np?=
 =?utf-8?B?MlM0eERoY3NRQm1HV3dkbjVER1dzYXpOWDBPdjkvUy9qMzREdVVCOEQzdTlj?=
 =?utf-8?B?dkwxai9OK2Q1YXNCd3ppNk44VnpLcFYxY2lRenhlL0pGaldQU2Y2ZGFkZWhV?=
 =?utf-8?Q?LB9o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4773.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a7861e-2d9d-4ed2-c5f3-08dbb9d08f30
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 11:56:00.9569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yWNQz/MbYghqxvJT3YVlQpG2ZuSjn7Zp5QOh6reVCQEJpfDEGe1H42Hbrbk2Y+wg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5114
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2F0YWthbSwgSGFy
aW5pIDxoYXJpbmkua2F0YWthbUBhbWQuY29tPg0KPiBTZW50OiBNb25kYXksIEp1bHkgMTAsIDIw
MjMgMTE6MjEgQU0NCj4gVG86IENocmlzdG9waGUgSkFJTExFVCA8Y2hyaXN0b3BoZS5qYWlsbGV0
QHdhbmFkb28uZnI+OyBKYWt1YiBLaWNpbnNraQ0KPiA8a3ViYUBrZXJuZWwub3JnPjsgSm9uYXMg
U3VociBDaHJpc3RlbnNlbiA8anNjQHVtYnJhY3VsdW0ub3JnPg0KPiBDYzogUGFvbG8gQWJlbmkg
PHBhYmVuaUByZWRoYXQuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgRGF2aWQgUy4NCj4g
TWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29n
bGUuY29tPjsNCj4gTWljaGFsIFNpbWVrIDxtaWNoYWwuc2ltZWtAeGlsaW54LmNvbT47IEhhb3l1
ZSBYdQ0KPiA8eHVoYW95dWUxQGhpc2lsaWNvbi5jb20+OyBodWFuZ2p1bnhpYW4gPGh1YW5nanVu
eGlhbjZAaGlzaWxpY29uLmNvbT47DQo+IFdhbmcgUWluZyA8d2FuZ3FpbmdAdml2by5jb20+OyBZ
YW5nIFlpbmdsaWFuZw0KPiA8eWFuZ3lpbmdsaWFuZ0BodWF3ZWkuY29tPjsgRXNiZW4gSGFhYmVu
ZGFsIDxlc2JlbkBnZWFuaXguY29tPjsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBOZWVsaSwNCj4gU3Jpbml2YXMg
PHNyaW5pdmFzLm5lZWxpQGFtZC5jb20+OyBQYW5kZXksIFJhZGhleSBTaHlhbQ0KPiA8cmFkaGV5
LnNoeWFtLnBhbmRleUBhbWQuY29tPg0KPiBTdWJqZWN0OiBSRTogUkU6IFtQQVRDSCBuZXQgdjIg
MS8yXSBuZXQ6IGxsX3RlbWFjOiBGaXggRE1BIHJlc291cmNlcyBsZWFrDQo+IA0KPiBIaSBDaHJp
c3RvcGhlLA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IENo
cmlzdG9waGUgSkFJTExFVCA8Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI+DQo+ID4gU2Vu
dDogU2F0dXJkYXksIEp1bHkgOCwgMjAyMyA2OjQ2IFBNDQo+ID4gVG86IEthdGFrYW0sIEhhcmlu
aSA8aGFyaW5pLmthdGFrYW1AYW1kLmNvbT47IEpha3ViIEtpY2luc2tpDQo+ID4gPGt1YmFAa2Vy
bmVsLm9yZz47IEpvbmFzIFN1aHIgQ2hyaXN0ZW5zZW4gPGpzY0B1bWJyYWN1bHVtLm9yZz4NCj4g
PiBDYzogUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsgbmV0ZGV2QHZnZXIua2VybmVs
Lm9yZzsgRGF2aWQgUy4NCj4gPiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBFcmljIER1
bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+Ow0KPiA+IE1pY2hhbCBTaW1layA8bWljaGFsLnNp
bWVrQHhpbGlueC5jb20+OyBIYW95dWUgWHUNCj4gPiA8eHVoYW95dWUxQGhpc2lsaWNvbi5jb20+
OyBodWFuZ2p1bnhpYW4NCj4gPGh1YW5nanVueGlhbjZAaGlzaWxpY29uLmNvbT47DQo+ID4gV2Fu
ZyBRaW5nIDx3YW5ncWluZ0B2aXZvLmNvbT47IFlhbmcgWWluZ2xpYW5nDQo+ID4gPHlhbmd5aW5n
bGlhbmdAaHVhd2VpLmNvbT47IEVzYmVuIEhhYWJlbmRhbCA8ZXNiZW5AZ2Vhbml4LmNvbT47DQo+
IGxpbnV4LQ0KPiA+IGFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgTmVlbGksDQo+ID4gU3Jpbml2YXMgPHNyaW5pdmFzLm5lZWxpQGFt
ZC5jb20+DQo+ID4gU3ViamVjdDogUmU6IFJFOiBbUEFUQ0ggbmV0IHYyIDEvMl0gbmV0OiBsbF90
ZW1hYzogRml4IERNQSByZXNvdXJjZXMNCj4gPiBsZWFrDQo+ID4NCjxzbmlwPg0KPiA+ID4+DQo+
ID4gPj4gSGFyaW5pLCBhcmUgeW91IHRoZSBkZXNpZ25hdGVkIG1haW50YWluZXIgZm9yIHRoaXMg
ZHJpdmVyPyBDb3VsZA0KPiA+ID4+IHlvdSBhZGQgYSBNQUlOVEFJTkVSUyBlbnRyeSBmb3IgaXQ/
IEkgZG9uJ3Qgc2VlIG9uZSByaWdodCBub3cuDQo+ID4gPj4gQW5kIHBvc3NpYmx5IHBpY2sgdXAg
dGhlc2UgcGF0Y2hlcyAvIGZpeCB0aGUgcHJvYmxlbSwgaWYgeW91IGhhdmUgdGhlDQo+IGN5Y2xl
cz8NCj4gPiA+DQo+ID4gPiBTdXJlLCBTcmluaXZhcyAoY2NlZCkgd2lsbCBwaWNrIHVwIHRoaXMg
c2VyaWVzIGFuZCBzZW5kIGEgdjMuDQo+ID4gPiBJJ2xsIGdldCBiYWNrIG9uIHRoZSBzdGF0ZSBv
ZiB0aGlzIElQL2RyaXZlciBmb3IgdGhlIG1haW50YWluZXJzIGxpc3QuDQo+ID4gPiBXaWxsIGlu
Y2x1ZGUgdGhhdCBwYXRjaCBpbiB0aGUgYmVnaW5uaW5nIG9mIHRoZSBzZXJpZXMgYXMgd2VsbC4N
Cj4gPiA+DQo+ID4gPiBSZWdhcmRzLA0KPiA+ID4gSGFyaW5pDQo+ID4gPg0KPiA+DQo+ID4gSGks
DQo+ID4NCj4gPiB0aGlzIHBhdGNoLCBvciBhbiB1cGRhdGVkIHZlcnNpb24sIGhhcyBub3QgcmVh
Y2hlZCAtbmV4dCB5ZXQuDQo+ID4NCj4gPiBEb2VzIHNvbWVvbmUgc3RpbGwgd29ya2luZyBvbiBp
dCwgb3IgZGlkIGl0IGdvdCBsb3N0Pw0KPiANCj4gQXBvbG9naWVzLCB3ZSBkaW50IGdldCBhIGNo
YW5jZSB0byBjbG9zZSBvbiB0aGlzLiBXZSdsbCBmaXggYW5kIHJlLXNwaW4gbmV4dA0KPiBtb250
aC4NCj4gVGhpcyBJUCBhbmQgZHJpdmVyIGFyZSBpbiBtaW5pbWFsIHN1cHBvcnQgbW9kZSByaWdo
dCBub3cuDQo+IFdlJ2xsIHVwZGF0ZSB0aGUgbWFpbnRhaW5lcnMgZW50cnkuDQoNCldlIGNoZWNr
ZWQgaW50ZXJuYWxseSBmb3IgaGFyZHdhcmUgdG8gdGVzdCB0aGlzIGFuZCBjb25jbHVkZWQgdGhh
dCB0aGlzIElQDQppcyBubyBsb25nZXIgc3VwcG9ydGVkIGFuZCBkcml2ZXIgY2Fubm90IGJlIG1h
aW50YWluZWQuDQpJIGhhdmUganVzdCBzZW50IGEgcGF0Y2ggdG8gYWRkIGFuIG9ic29sZXRlIE1B
SU5UQUlORVJTIGVudHJ5IGZvciB0aGlzIGRyaXZlci4NCkFwb2xvZ2llcyBmb3Igbm90IHVwZGF0
aW5nIHRoZSBzdGF0ZSBlYXJsaWVyLg0KDQpSZWdhcmRzLA0KSGFyaW5pDQo=
