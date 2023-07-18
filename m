Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC32757597
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjGRHnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjGRHnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:43:53 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2376EB5;
        Tue, 18 Jul 2023 00:43:52 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36I7JBMe002557;
        Tue, 18 Jul 2023 00:43:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        PPS06212021; bh=5Qt1nYzoJfM7z8b3Pr2fvrGAbMZd70QZJ+qiWLTDuI8=; b=
        HeB+NA1jYql84UjJdStzl/DxUtV0KVy7401Y3WTWk7pWmv47pHHRd1TEYbkwH8rh
        kOvsL4HrY978pdS+UbISSJs2mEqSz9y6MaW0mdVNMjMGL9NvjLPN1xYYJv8Nwtsp
        K0xZGbacmP9zGRoQDSokZ9+82RUozMjdcONZGSTxf5odmFDSY/28wCISRNgINAFN
        ruKzNyuwq32g2gKvMZHBN19c9na8uHuS4pWny2BcnUX+x1TtoCL4litxAb5ZMMgC
        QuII/bPlY6Z2TaU3TeZIXhQhOXEFFAqDjVOQKq0SFSAR4AiFW1N8+1fT6JjWK93D
        H2Y/knqzUSveYQMFmseZZA==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3rupqyabxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 00:43:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4nhuNfweGt7bhwexQfloPmmyvjaS/e+1Ubt+v9GlRc/FwNenxZaoiVfFu5YNnl7oO6vUFPlN7KOa/B1dnEf+2yiAqKGujGH5dmmZk0jImVcIFbzUjASkP+RR2kU0iNcROj0DGbCHTIyNp4PyDanCl0jxglArcOTm+01LwynpjXqrjat16vJ52ZNRuo79JjFvRBateI6vrZvT0eR5e1a21z6sSezJwSK4HkaaTi7VLD/0OaBzK6gbe74D2ngg4YOyowSxEr9zIdUMaTf8VtousWwTxtoBvEBJbgJfEBwK0IusHK1UOEzCT2vEyJqSizek9hE1Q+3+Ge/Io6nUmujpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Qt1nYzoJfM7z8b3Pr2fvrGAbMZd70QZJ+qiWLTDuI8=;
 b=PTwjlrksj5Ge7DEkI0k10952d2NEf2NbBig4rpWvIfMbqM0si5jqajNMKt5VZfFhsBuH856qYtnzmjLylujoPkU4Ku2g2bw3Rh54zcNPTrrVCdG7tUUIcekqqk+ylInONmmz5sFIZlkqSUtwCjtixgrN0rx7pmIFk1ytcRLGMXszPYaAfyj6enzZVHY9S4x3/pPVuYmjdQWAW21DWSwkDAhaFlqTR8JzYaDVE31vcObn+FGYwITFAEOz4POKXaglerN/Uv4EyqVJ8LzetLbCa42WTHp2H6av0aBrImpOULYp74hrtAnD7bgR3hmAkLUabpw4p1szuEqrLgWII2kIDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by BL3PR11MB6531.namprd11.prod.outlook.com (2603:10b6:208:38e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 07:43:42 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e4:3974:df17:77c9]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e4:3974:df17:77c9%3]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 07:43:41 +0000
From:   "Li, Meng" <Meng.Li@windriver.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: dwc2: add new compatible for Intel SoCFPGA Stratix10
 platform
Thread-Topic: [PATCH] usb: dwc2: add new compatible for Intel SoCFPGA
 Stratix10 platform
Thread-Index: AQHZuSU8yVYCfJPY5kO596WmvUeacK+/CwIAgAAZMCA=
Date:   Tue, 18 Jul 2023 07:43:41 +0000
Message-ID: <PH0PR11MB519187156E9F27AA52C87063F138A@PH0PR11MB5191.namprd11.prod.outlook.com>
References: <20230718030851.2014306-1-Meng.Li@windriver.com>
 <78b06bf0-ab71-acdf-5799-1f6d849e7ead@linaro.org>
In-Reply-To: <78b06bf0-ab71-acdf-5799-1f6d849e7ead@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5191:EE_|BL3PR11MB6531:EE_
x-ms-office365-filtering-correlation-id: 8f825419-e154-4568-5cc3-08db8762b4c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3dO2Qj4R/Kn2DOd6D0pGuEpSRufgzzxSPsC8mmzhgM5wYVibWEb2iqCqyQ/SojsRNg2JMgquMH75bnCY8sHcdhOMmesUyvq+ZpWE4bEAMeRUbWjSmS1A3ndAJvS+7zhA5zeBCtFLkT5RCWxgYoHpo9kQ9LZvOhS1W+w9+gE4euoa4xIt+JugnoJmKMBdNJGqvQbN5j0UwqJqRHEMM876O0NTYL6Xp3zo8yGhhtsGM78SA8k0JggjFNPRQQZMfqrKIYDEYWIEV5gSiPx3tTR7bmJwhhP2BX9ybgatuNovbK1y57Mq54q5yCkbj/7HPPP4YGmtXbT9y/iqIS+LUQRQ3FCUG2vuLcdo7e+qkaX+P0NzMyV4Bh/8cicLmMtBE1bXRnz3Mkwa5BVQrknhH4dES+5NkOXMYaYkfyeEShoYTdcupPjbU88PZXNpMvGlerpwY9g9x1ZtY2AfDEbypoO8CZ+fJwiltNSvHGqF438MPTMqA/IYH5ZHVibsF+c/gZUz+vVrA/csvbFWR0KjkVi3feQayNDb3+LFdmXjxV8bAjRQCEpYsr6PXnQP50J69Y7YzROgf4U8WGaL38WQGDl884QNGW/GLo4FewNpu1Q8aQn1TagIsK1OSjckXuvoutjI7C+hxLhWjZaFKuruIJgm6FfrSeRHu4RDRRaAG5ZdgGw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(136003)(39850400004)(376002)(451199021)(86362001)(2906002)(8936002)(38070700005)(66446008)(66476007)(5660300002)(66556008)(64756008)(52536014)(4326008)(41300700001)(8676002)(66946007)(76116006)(38100700002)(316002)(110136005)(186003)(122000001)(6506007)(478600001)(53546011)(83380400001)(33656002)(71200400001)(7696005)(55016003)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzM2cVdyUmF3RmdHdmdDMVBzTFUrbFUxNXBMbzJaei95OGpoVkxjQlFucEJ4?=
 =?utf-8?B?cTQ2UnpkOG9TbVJEZC93ck5oRUIzVkdJVUYrSU43dVdDdUxSUjEwQzRBbG02?=
 =?utf-8?B?N1YwWnNQSCszZ0VjZmh0eXZYdzRORDRHaGhOUjRJUVI0S2RUMTMyNG96cXRx?=
 =?utf-8?B?VUZEcTN5NlRTZkJXVE81T0t3YWdoRm1IZStJR2ZFSHhUOHkwSjc1Y2hzaDJh?=
 =?utf-8?B?VithSG15NWhIMFhnZUZYN0Qxa1BTUlB6aGR3OWRnbm9UdHdiV3Jib3ZDeFBm?=
 =?utf-8?B?cStmMkl2S2lwckNnQ1FFdUxtU1ZtWGVxVlp0bTZ0d1F6b1daTnZSN0lDbCs2?=
 =?utf-8?B?WkJHZ2xnNkFreU82WlZpVitTSjdTemtualFqSGN6MjZYMlhTTDhUN2htWlVD?=
 =?utf-8?B?OWZ0T0tSUnM4RHBGWkp3UnB3SWFHdlVXQ25ycmNnL1BFOUtZeGFnOEd0L1RH?=
 =?utf-8?B?YnN0aVdKd1NUcDMxWDlWMkFVL012Sk1HZERFTW5LT1VYbFk4ZHdlcXFmbHUw?=
 =?utf-8?B?N2hnWHJmcmV4RUlCRWk3cTlPTVBvQ2htWXFUVGhuRnpnSHVkMEZOYlR0MnRn?=
 =?utf-8?B?cnRTbUtCZUV3UFdmMlM0VnJQL2lwZFg1YlB3MEFibDBZekJzYjRuRmp6eDhL?=
 =?utf-8?B?ZHB0T2pqYm9OQlFHb3drdDJ0NVZ0REphUnQ0U3NlNmFVcUY0RWZYdXg1ekU0?=
 =?utf-8?B?dzJzVG1oL0FOVDFtQkd3NXIwYTlqM21vbTlhSEc2M3pRWmRVekV2VElpaFNs?=
 =?utf-8?B?Zk1CR2JyMlYwRWpoRm5leVpOQmphNFd3cTdiOEZrTWRQOXZxQTdja09YWE5T?=
 =?utf-8?B?ZHMyV3VBNDQxQWkrdWFKZTZKN2VvbFlnUWlkWWhuQkFNWnlKUWN5cEowRWlN?=
 =?utf-8?B?TDNocTF3YjNyNzBWQ2wwRXgrczNvaXVORFF2R3I1d3V0NGY4L0k2dDQ2YStY?=
 =?utf-8?B?QXZTbnBlUTNTREs0MERSdTRmSFV4VnlyTmVscDJVNEk3UHhETGxPaFFmNGRC?=
 =?utf-8?B?Ty9ZQkpKWEl4SUhESzR1TFhybkp5ajFkR2hvOXI0blBGeEdXVUFVdER5Tnp1?=
 =?utf-8?B?VnlISjBqQnRpeVZJbmNuUDBPWWsrRnhHeGJvMkZLVDQzV2UyRG5ZVnZOV1RX?=
 =?utf-8?B?WVNBWjFpNWtTQm1qUXBTSUJWczJqL0dzMnpGd0NTQVorb0c4V3ViTVlmYnVU?=
 =?utf-8?B?ci9YRC8vYzB1TklXSXRpY1QrQnNVeGJpeEd4UjAwVjU0VElPdlNmN0M5TFFN?=
 =?utf-8?B?VnJXVndlRk1zcWtOTGxBUkt4V3RYT0dwTVd4ZjFNZktVN3UyVkRwWGpQU3dp?=
 =?utf-8?B?WUxZdFNZT2dMUTl3Z3FIaFVDajBVdXkyYldrT2F3ZnU0TGN5cWV6OVYzUEd2?=
 =?utf-8?B?d0pFbHNXMnZycFZGdEJkNGtqaVl5b2c4K1NhS2V1bk96eXRNWE9EZUVkZzd5?=
 =?utf-8?B?dGtHT1pyS0EyWklKSjdGdmNOZFp2c2VlTWthbVA5SnlvbFFQN2h6T1dFa3h1?=
 =?utf-8?B?eURKcHNPMWVicTR0cmdKU3hJR3I5WE9vdC9MZGFRcmg3ZFdhNDdVaTBWV0Ny?=
 =?utf-8?B?dzhnWWxPbmx5djA3NUZIVVliV3g0TnpUZ3NWRGJKcXlPYUNLL3NROTRqZ3Bk?=
 =?utf-8?B?c09adXExRHR2Zno0NmRic3dROHcvbWROUUpnMGhKYkNqZFdSaGhHMkxJLzlj?=
 =?utf-8?B?Z1cyWGh1OFZ0azhSWmhvUkZGWlh5WENYQmFzaDB5TldIZHVKNGV1emN0OGZ5?=
 =?utf-8?B?UGt6Sno1MVRGTUd1eGl1Z0sra2h0SWZPRWltZlR3cDdjd29nUXJjNi9PYXlB?=
 =?utf-8?B?TjA4cXQ2TXcrVjBQSzdoWm5DTlNvUVZSbjQ1eVErU0J0emZKQjZzMWlSVEdn?=
 =?utf-8?B?K0VOUzQ0NVBXS3dJNFVGKzNiK3E3cksrdFgyM2NES0czWXRqR3ByQ2lVcHFk?=
 =?utf-8?B?cUtiUDJXVWk3akt4Uy9jaHJXeXhKUUNTdnpYd3M5YlJCemtNSWFSckRUaGhJ?=
 =?utf-8?B?WGw3ek81Y2NSWkRFblVMaDFNSXVOVWkzMlhyNmxuVUs3OFVqV2tTeUZLc1NQ?=
 =?utf-8?B?Ym1sTHZPUENRMjVPaDdaL2lrZWIxemJ2ZEdCNmFqLzlyTGxoaG1yNU15WFJm?=
 =?utf-8?Q?dOrM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f825419-e154-4568-5cc3-08db8762b4c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 07:43:41.2166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dnYOeR5o3voPEfSZrhA49Ue3Z5gkpSIdPRaSB8yeIzxAKGLB4OnwCoBjsoygEy98ZyhqFby/+Yw3DxBYxVccyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6531
X-Proofpoint-GUID: yH3WBAJmVaNZUGyLTUrzw5qbflQ0f6rk
X-Proofpoint-ORIG-GUID: yH3WBAJmVaNZUGyLTUrzw5qbflQ0f6rk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2307180069
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBK
dWx5IDE4LCAyMDIzIDI6MTEgUE0NCj4gVG86IExpLCBNZW5nIDxNZW5nLkxpQHdpbmRyaXZlci5j
b20+OyBkaW5ndXllbkBrZXJuZWwub3JnOw0KPiByb2JoK2R0QGtlcm5lbC5vcmc7IGtyenlzenRv
Zi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4gZGV2aWNl
dHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcN
Cj4gU3ViamVjdDogUmU6IFtQQVRDSF0gdXNiOiBkd2MyOiBhZGQgbmV3IGNvbXBhdGlibGUgZm9y
IEludGVsIFNvQ0ZQR0EgU3RyYXRpeDEwDQo+IHBsYXRmb3JtDQo+IA0KPiBDQVVUSU9OOiBUaGlz
IGVtYWlsIGNvbWVzIGZyb20gYSBub24gV2luZCBSaXZlciBlbWFpbCBhY2NvdW50IQ0KPiBEbyBu
b3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0
aGUgc2VuZGVyIGFuZA0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiBPbiAxOC8w
Ny8yMDIzIDA1OjA4LCBNZW5nIExpIHdyb3RlOg0KPiA+IEludGVsIFN0cmF0aXgxMCBpcyB2ZXJ5
IHRoZSBzYW1lIHdpdGggQWdpbGV4IHBsYXRmb3JtLCB0aGUgRFdDMiBJUCBvbg0KPiA+IHRoZSBT
dHJhdGl4IHBsYXRmb3JtIGFsc28gZG9lcyBub3Qgc3VwcG9ydCBjbG9jay1nYXRpbmcuIFRoZSBj
b21taXQNCj4gPiAzZDhkMzUwNGQyMzMoInVzYjogZHdjMjogQWRkIHBsYXRmb3JtIHNwZWNpZmlj
IGRhdGEgZm9yIEludGVsJ3MNCj4gPiBBZ2lsZXgiKSBoYWQgZml4ZWQgdGhpcyBpc3N1ZS4gU28s
IGFkZCB0aGUgZXNzZW50aWFsIGNvbXBhdGlibGUgdG8NCj4gPiBhbHNvIHVzZSB0aGUgc3BlY2lm
aWMgZGF0YSBvbiBTdHJhdGl4MTAgcGxhdGZvcm0uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBN
ZW5nIExpIDxNZW5nLkxpQHdpbmRyaXZlci5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtNjQv
Ym9vdC9kdHMvYWx0ZXJhL3NvY2ZwZ2Ffc3RyYXRpeDEwLmR0c2kgfCA0ICsrLS0NCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2FsdGVyYS9zb2NmcGdhX3N0cmF0aXgxMC5k
dHNpDQo+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2FsdGVyYS9zb2NmcGdhX3N0cmF0aXgxMC5k
dHNpDQo+ID4gaW5kZXggZWE3ODhhOTIwZWFiLi5iOGRkNTUwOWMyMTQgMTAwNjQ0DQo+ID4gLS0t
IGEvYXJjaC9hcm02NC9ib290L2R0cy9hbHRlcmEvc29jZnBnYV9zdHJhdGl4MTAuZHRzaQ0KPiA+
ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvYWx0ZXJhL3NvY2ZwZ2Ffc3RyYXRpeDEwLmR0c2kN
Cj4gPiBAQCAtNDkwLDcgKzQ5MCw3IEBAIHVzYnBoeTA6IHVzYnBoeUAwIHsNCj4gPiAgICAgICAg
ICAgICAgIH07DQo+ID4NCj4gPiAgICAgICAgICAgICAgIHVzYjA6IHVzYkBmZmIwMDAwMCB7DQo+
ID4gLSAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAic25wcyxkd2MyIjsNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJpbnRlbCxzb2NmcGdhLWFnaWxleC1o
c290ZyIsDQo+ID4gKyAic25wcyxkd2MyIjsNCj4gDQo+IFlvdSBtaXNzIFNvQyBzcGVjaWZpYyBj
b21wYXRpYmxlLg0KPiANCg0KU29ycnkhIEkgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0IGRvIHlvdSBt
ZWFuIGFib3V0IFNvQyBzcGVjaWZpYyBjb21wYXRpYmxlLg0KSSB0aGluayBhZ2lsZXggaXMgdGhl
IHNvYyBzcGVjaWZpYy4NCkNvdWxkIHlvdSBwbGVhc2Ugc2hvdyB5b3VyIGV4YW1wbGU/DQoNClRo
YW5rcywNCkxJbWVuZw0KDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==
