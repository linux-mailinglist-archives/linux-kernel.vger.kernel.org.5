Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823A778B75B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjH1Sj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbjH1Sjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:39:47 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2083.outbound.protection.outlook.com [40.107.13.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317A2C1;
        Mon, 28 Aug 2023 11:39:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZ64YiQ306GiWLjknYxw+xDwR6Or66N5V3yyNQiSrV+x/lnVmijhdAhu9UJhNugbTI1To3R3kJD2p/5nuf4vEP406+jSamUoDNgwGKFrGj9vOe440MWr6JjfHy58nCqZuvwL28kBdjmHz6Pp2wqer+ZQz4RCcSwPQnh/SQM++pNtCKRvHbHUqLNNcE0TMFwFmgg0fA7Trtt7+5nlxkl2oAAVtkVD8xgzJzILhk4xQ8rS9TCle+dmRy2GCATwi26jkTgQFfOVPfD5r4qabUswQH3dOEA15GmTZo+HB58SBS8cQ7xcU61V70826tclAB1nLZz2fNo+85HUe9KpiIJQfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsszLg8sRjYKsLfzdvkgfaX0AmHnx+WML4j0KBVRfY0=;
 b=FIHJEsLQHcx07oxEzT/LVohmZzuZOK+zAQB12QibmUedk/66DrAN6quhsBidurRF08LRDMEVMTIfmcwtCQNMVJfY2+ehiYaiKZI1yH8G7PAUDp2e2Ssw5uRGMHz2MX1kcoc5BwexmZN19EbLMYk5lywEoKa4e2i3GmRKMneF5iv2yCoUuobVg5lF/oGND47vYgxNrOH/HgXju5VBjo0M/3mLNFJ98bs1yttNzTpVilH4MSMh1ePCIvVXYTlrZA6tJV2i+pLFqt6fagkrB7OdB4N0SQwNvDtL5zAj1MNufJz4TWYmh55MRftXwndecDdnugkVAs3sruBu17jSfk3DPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsszLg8sRjYKsLfzdvkgfaX0AmHnx+WML4j0KBVRfY0=;
 b=Gjz+5fX0iD0uE9R6c3j8mv00SS8g8YQV+agdkyvJ0T8L4rds0Ne0Qi7MBD1muaoBEcVOiQoENcQ0gyDE1eHT7LznDBrJf7yJMtu46CMwPfe7Dwy5EryjgYaxUtCr3+dpKDIeOAUOrprpYrDfLjlKuNt4VwuUyf1uR8cWPoE5IAA=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AM8PR04MB7987.eurprd04.prod.outlook.com (2603:10a6:20b:24d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Mon, 28 Aug
 2023 18:39:42 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 18:39:41 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
Thread-Topic: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
Thread-Index: AQHZ2d8BxP1dr3Vo70mQavqKyJSRFA==
Date:   Mon, 28 Aug 2023 18:39:41 +0000
Message-ID: <PAXPR04MB9185DC79721E78E631F9889589E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20230818153446.1076027-1-shenwei.wang@nxp.com>
 <CAPDyKFqsn6kVjPFUdVyRxNDiOaHO9hq=9c+6eAK4N-v-LVWUPw@mail.gmail.com>
 <PAXPR04MB91858254554272C90822FED1891DA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <CAPDyKFoV2Z=-WUiF3SgXqhF+K+r5QqsLgz8_hau0WKfZxTzYpg@mail.gmail.com>
 <PAXPR04MB9185F6AA20B0440B8FAB847789E3A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <4e2c18e3-b1ed-6361-3998-5de060d2bcf0@linaro.org>
 <PAXPR04MB9185957B729588D3E7CA3A5089E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <51fe3126-16ba-ade6-b106-e3683f96ad26@linaro.org>
In-Reply-To: <51fe3126-16ba-ade6-b106-e3683f96ad26@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|AM8PR04MB7987:EE_
x-ms-office365-filtering-correlation-id: e1b39489-0ce4-43fc-74ef-08dba7f6247c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4/Ch5GoJC80BUz8ZzyFKIwy3D4Vi5KFxriXlszXRoyrajf2xXv60OtSGjRN8ZF7LChzDEoc7CdB9ckZCW0NbtoGlGXhRwV+1EuWExEhR3OOUFrptPT6+jRZOOM6IomgUmQtSj0Ig7KGwtTIBh3HL4EES/YlCnNIKixW2RBQT3pVsB98HkOw/bb6WYYJjGuqAtrOkxHGTiP+pd0dJ/vejbR5eO/Yhrgj2X1Kh1tXEPSRhUrIWGTUBsY/ztUTGvWZDgBkvtvnN32qKfOQqxEzn/wx2+yv5eYGriUn/FTl6PWM3IjIFWzoF/tPj5rfBPY9IbtEy41UO+l3kJkA7BwOVamdMfn16v4PmO/1IONNVyImR3jy9UX6Kmd3PjEFidnEb2U3SUTYczLKjgclyq83iVBacgiLkNGaUpCJQrgmhRqI01yzgeOuzJPgL3fQ44WzTX8Ia3pslZUjBKRRAqckpppRkBkoTE6nfs6+KsnEDFNLjfWc9bwtYaxwRHgwTZiIv7ogZqC2+TT7rYv9tAKavO67olUqbMqrdMApdeNrhYVy4Ut+eQX/J38UwiT7Jm++Ydfmj9Fwm+xjXTLA24DEzrT9rWRa109PwLLEDViUdKiAX1TOx34rtiS8egHt+kWHB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(366004)(346002)(1800799009)(186009)(451199024)(66899024)(6506007)(7696005)(71200400001)(9686003)(33656002)(86362001)(38100700002)(38070700005)(122000001)(55016003)(83380400001)(2906002)(26005)(53546011)(55236004)(478600001)(76116006)(110136005)(52536014)(66946007)(66556008)(66476007)(4326008)(8676002)(8936002)(5660300002)(44832011)(41300700001)(7416002)(66446008)(54906003)(316002)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkhJWWdLV2FvRlJqbzdtcUVNbGZNVDZ5RUZnalBBa0t5c1I4MDdmRUZyUEpQ?=
 =?utf-8?B?eEhwREFqYkdDU1VNUGRMZHFuTWduMmw4Qll1enA2Z2phZlpQQWRNYllKWGpL?=
 =?utf-8?B?eUJaT2E5bjlLZHRDS2pHNlBQSGM4OWZKTEEzbmI3NGwydEJ4MCs2aXdjOTVq?=
 =?utf-8?B?dGIwMjhESDkwbnN6RnN1dmdaMVhvKzJoU3FxSFJBREIzTjhMamVJd0VnaFg1?=
 =?utf-8?B?RkxYaGkwQlh3eitGYTZ6aU82dTdTMVhYYmZ2ajdNZ1pYNGdRRWFjZkU5ZGpO?=
 =?utf-8?B?WktHUUg2cWZaSzJ1eHowSTdjUnJHMFhORnd1YUxheXdLSlBLK3pFY1RQR2tO?=
 =?utf-8?B?WnMrNlhnazhqYlorQ0xsbk5hcGI5SGl2dTJ0R3I2Q2NJUGZ1U0tMM1RtU0E4?=
 =?utf-8?B?YUlnNGcyeXVwakhrVVBpZFdzdzArenpjb28wUGFOTnhqQnBKSUxiOHlJWEdm?=
 =?utf-8?B?MTRud2lweEhwYmQwcGRWcFFhamtxM09maGRlendzYWZpUnNYaER4U2Z0dU8z?=
 =?utf-8?B?NllGVm9EcnVYcXBJWFpmTGdXZ29CUHJQQTRyeU4rQndJZExuVVJseUJjMXhP?=
 =?utf-8?B?ODRCa3hjVzFxaU9pQS95ek5TcmdOenVMbWEzUngvemZsZmFkY1IxdzFmVEcz?=
 =?utf-8?B?TnBTeHhaNCtBQ21VVU1BN3hlTU9oeUxVZWdjK2JkTkgzVStjMHhCazN3SWE1?=
 =?utf-8?B?UENSL0hpMWt5ZkhhQ0R6c2xNT1ZRclNaaFkrTElCRkNFNmJGQ1h4WXZXbnMw?=
 =?utf-8?B?NVBqUEdmYjlZdCtpQUljVnlJbFYyalNpdTdwZFpocnZsbWFDYjZSMWN5MTNW?=
 =?utf-8?B?a2lydjNWMmZOU3JEL3dGMzh1ZkVHdFFhaGt0aXUvT3VINnNvYlRVWnVXbUZG?=
 =?utf-8?B?a3RhVHFjT2dGNG1sdGNSUzhaOEdYbnRDbW1uU3phUFJQUlhaditmcFFDeHd3?=
 =?utf-8?B?SmxRZUp4YzlHZDV1T0FMNUQzYUlkb3VBSlg1NEp2MTBVdGpKckFIY0Q1eWZR?=
 =?utf-8?B?eFJLN1l5N1N2T2tueE5YRFVBL3VlbktBS21vOWxFT3lCdExQQ093WkNPclRO?=
 =?utf-8?B?ampvbXJTcWducGpMRkhlZFRRcmFsQ0g5cVBGNkNMelFURVlJOWhsQWdZa2Qv?=
 =?utf-8?B?TTFqS2ZndTk5cEVVZTZvNG9zSTJ2czBqWkZ5OUgvT1o5T09wajh3UEJ5ZGtM?=
 =?utf-8?B?WWJYTHIvR2VWbExuMUtEZEFGUnN4NmxzdGN3Q0ZpTVd2UTd0LzhVOU11U3Rm?=
 =?utf-8?B?L2ZET3UrVHpobnc2eXhJK2xOMlJDTTA2RDFtVFdseklZOHBLWFQ2d1VnSTBu?=
 =?utf-8?B?NzM1aUJwZkdsYUZYQUJxODhpQjVJUVhZZ3hzQmpCY2Z5dXdhTllLUFovdkZz?=
 =?utf-8?B?OXVna3p1cDBFMnFUemwza2Z1cTRCaFEvY3pLS2U2ZFM2TUVUekkvclpZTHpB?=
 =?utf-8?B?Q2Judmc2dkRXZ21OaEZSNVl1c3FBbkxvM0ZYdnFVVlh2ZkYwL05pQmpaY01w?=
 =?utf-8?B?dkZ6anNLRTZrRHpsNWxNYXg0dWhOSCtiYXUvUDhTandFMlI4WnZxeUt1NDRO?=
 =?utf-8?B?c0h0UUNsK3AxK1dtYzEyRk1aZVBVaEhEZ2hGc3dhbmtmWmtQeFJtSnZTVm9z?=
 =?utf-8?B?alROdDNjcjh2RjhoUUZyZUxiQkdaTHNEV1VyVHcyVWVpS0ZxZU9ydWhURDBj?=
 =?utf-8?B?ODd2VUhZTEw1TFIwYnJpcHFCa2IxakhFV3hCYmttNkovOFZWL2EyTXFLbTk3?=
 =?utf-8?B?TDRPVEVUZGpDN1RmMU9rYnk5TjZWd3IxeDBKNEY1NWpmOFZ5b295ZTRVeVh5?=
 =?utf-8?B?bWRZcHEzSmhQTldYREpKWi9OY0tqWmRHUHlvUEduU05BMzYvdHBKbXlsTTBV?=
 =?utf-8?B?a2NEaUVxc0ltd1kwRW1JbVJSRGRvUldsbUIyWnlhOWZpclZNcnVITVhXY2lQ?=
 =?utf-8?B?eFFocGhCV0dQQkxlRGF2clhoS3E4ZFQvdFc2VXZyNytwZVl3WUpIa05jV3VI?=
 =?utf-8?B?dmF5K0FZL09iV2JCa0lDZUF2bHE2WDA2WmRDbUwwZnplblcwQTZTd3RJd1FS?=
 =?utf-8?B?ZWtMTENqQllQUHJwWWZ3T0Z1NUplOGN3eDZWMEdUdVN3UVJrSmJyUmFYdGZk?=
 =?utf-8?Q?FsK7BFev/v8AAoW060fHHNU5S?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b39489-0ce4-43fc-74ef-08dba7f6247c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 18:39:41.8944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 156MbI/0yokG0tlTB4xb5zvLJoHir5HriKianPDeeFFO3BG8N3OB82C2jwhLvWOXDD9r8PsAImwTtpzDb3aXSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7987
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBNb25kYXksIEF1
Z3VzdCAyOCwgMjAyMyAxMjoxMSBQTQ0KPiBUbzogU2hlbndlaSBXYW5nIDxzaGVud2VpLndhbmdA
bnhwLmNvbT47IFVsZiBIYW5zc29uDQo+IDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KPiBDYzog
Um9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IEtyenlzenRvZiBLb3psb3dza2kNCj4g
PGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZz47IENvbm9yIERvb2xleSA8Y29ub3Ir
ZHRAa2VybmVsLm9yZz47DQo+IExpYW0gR2lyZHdvb2QgPGxnaXJkd29vZEBnbWFpbC5jb20+OyBN
YXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+Ow0KPiBpbXhAbGlzdHMubGludXguZGV2OyBk
ZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsN
Cj4gZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogW0VYVF0gUmU6
IFtQQVRDSCAxLzJdIGR0LWJpbmRpbmdzOiBwb3dlcjogQWRkIHJlZ3VsYXRvci1wZCB5YW1sIGZp
bGUNCj4gT24gMjgvMDgvMjAyMyAxNjowNCwgU2hlbndlaSBXYW5nIHdyb3RlOg0KPiANCj4gPj4+
IEFyZSB5b3Ugc3VnZ2VzdGluZyB0byBtb3ZlIHRoZSByZWd1bGF0b3ItcGQgdG8gdGhlIGlteCBk
aXJlY3RvcnkgYW5kDQo+ID4+PiBhZGQgYSBjb21wYW55IHByZWZpeCB0byB0aGUgY29tcGF0aWJs
ZSBzdHJpbmc/DQo+ID4+DQo+ID4+IFRoZXJlIGlzIG5vIHN1Y2ggcGFydCBvZiBpTVggcHJvY2Vz
c29yIGFzIHN1Y2gNCj4gPj4gcmVndWxhdG9yLXBvd2VyLWRvbWFpbiwgc28gSSBkb24ndCByZWNv
bW1lbmQgdGhhdCBhcHByb2FjaC4gRFRTIG5vZGVzDQo+ID4+IHJlcHJlc2VudCBoYXJkd2FyZSwg
bm90IHlvdXIgU1cgbGF5ZXJzLg0KPiA+Pg0KPiA+DQo+ID4gVGhhdCdzIG5vdCBhbHdheXMgdGhl
IGNhc2UsIGFzIHdlIGRvIHNvbWV0aW1lcyBuZWVkIGEgdmlydHVhbCBkZXZpY2UuDQo+ID4gQXMg
YW4gZXhhbXBsZSwgdGhlICJyZWd1bGF0b3ItZml4ZWQiIGFjdHMgYXMgYSBzb2Z0d2FyZSBhYnN0
cmFjdGlvbg0KPiA+IGxheWVyIHRvIGNyZWF0ZSB2aXJ0dWFsIHJlZ3VsYXRvciBkZXZpY2VzIGJ5
IGludGVyZmFjaW5nIHdpdGggdGhlIHVuZGVybHlpbmcNCj4gR1BJTyBkcml2ZXJzLg0KPiANCj4g
Tm90IHRydWUuIFRoaXMgaXMgYSByZWFsIHJlZ3VsYXRvciBkZXZpY2UuIFJlYWwgaGFyZHdhcmUg
b24gdGhlIGJvYXJkLg0KPiBZb3UgY2FuIGV2ZW4gc2VlIGFuZCB0b3VjaCBpdC4NCj4gDQoNClRo
ZSBwaHlzaWNhbCBoYXJkd2FyZSBjb21wb25lbnQgaXMgdGhlIEdQSU8gcGluLCB3aGljaCBpcyB3
aGF0IHlvdSBjYW4gb25seSB0b3VjaC4gDQpUaGUgcmVndWxhdG9yIGZ1bmN0aW9ucyB2aXJ0dWFs
bHkgdGhyb3VnaCBzb2Z0d2FyZSBsYXllciBhYm92ZSBvZiB0aGUgR1BJTyBkcml2ZXIuIFdoaWxl
IA0Kd2UgbWF5IGNhbGwgaXQgYSAicmVndWxhdG9yIiBvciB3aGF0ZXZlciBlbHNlLCB0aGlzIGNh
bm5vdCBvYnNjdXJlIHRoZSBmYWN0IHRoYXQgdGhlIHVuZGVybHlpbmcgDQpoYXJkd2FyZSBpcyBq
dXN0IGEgR1BJTyBwaW4gYmVpbmcgdXNlZCBpbiBhIHNwZWNpYWxpemVkIHdheS4NCg0KVGhhbmtz
LA0KU2hlbndlaQ0KDQo+ID4gU2ltaWxhcmx5LCAicmVndWxhdG9yLXBkIiBwcm92aWRlcyBhIHNv
ZnR3YXJlIGFic3RyYWN0aW9uIGxheWVyIGZvcg0KPiA+IHZpcnR1YWwgUEQgZGV2aWNlcyBidWls
dCBvbiB0b3Agb2YgZXhpc3RpbmcgcmVndWxhdG9yIGRyaXZlcnMuDQo+IA0KPiBUaGlzIGlzIG5v
dCByZWxhdGVkIHRvIHJlZ3VsYXRvci1maXhlZCBhdCBhbGwuDQo+IA0KPiA+IFdoZW4gbG9va2lu
ZyBhdCB0aGUgY29uY2VwdHVhbCBwdXJwb3NlLCByZWd1bGF0b3ItZml4ZWQgYW5kDQo+ID4gcmVn
dWxhdG9yLXBkIGFyZSBjb21wYXJhYmxlIGluIHRoYXQgdGhleSBib3RoIG9mZmVyIHNvZnR3YXJl
IGFic3RyYWN0aW9uDQo+IGxheWVycyBmb3IgdmlydHVhbCBkZXZpY2VzLiINCj4gDQo+IE5vLiBy
ZWd1bGF0b3ItZml4ZWQgaXMgYSByZWFsIGRldmljZS4gWW91cnMgaXMgbm90Lg0KPiANCj4gDQo+
IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==
