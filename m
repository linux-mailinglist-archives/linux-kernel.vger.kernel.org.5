Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052EF7EB11B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbjKNNpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjKNNpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:45:23 -0500
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F211A1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:45:20 -0800 (PST)
Received: from pps.filterd (m0174677.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AED9naX019983;
        Tue, 14 Nov 2023 13:45:06 GMT
Received: from eur01-db5-obe.outbound.protection.outlook.com (mail-db5eur01lp2051.outbound.protection.outlook.com [104.47.2.51])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3uc9hmr3vq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 13:45:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Filxshp0E9icVNGm3qXt/JCK+Dju2kC1ndACBX3t4SOsLAUjeyAC7oKSmN3FloJkUxZegR3zJt2rfhZe8xgK8DvqRK01QHZBXNqF1rBx7wAjEV2J5LJ1XdeONBxlD0s+Fyh26Hit+3y8+FmQLrUoYd6Mx+JfSraLrMl1NF3g+xdPioHGyHY0S7BXCehcEr7hHnEps2JbnQpIUYKX6dTVoOB1L5hj9FRSkwPTIS7RyNMyn7PaEnuew19V/CnfztguOhWYV4KrRLmUWGfvHWUaq6kXYcRoQ0srIiUO8bfnhOHRSHBj5Tb86pJU5N4gMQMp26hXZX1uXCoUrGolz67zkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvgIiY4anEDmHl5y9qpBSp8F3QqO/H3y5kFh1jYTFtA=;
 b=MndvonmgYfKA+bPZ2PC/5yrnR6asSjBHx/gVFZXQXdI0H7meysUwZps9RkhnCk4XggyopcVMEQ3CJSrNRI2uSsUXmVEMCJb8OZqOwlQV8mKyLQkKr4LQCb/HMV9T4yUXJAf+aDAeKS7wX9PEUsZ3pyEvsL5CucKT4fNMn6qibMRKsDg895UKRewk3J2DlUebHe5vjPttvIAvlF0kM4hzsi4UdYV1x9lH+Q/ngSGqFdVFKFZX2KT90Ro4fv2zkYeEhGe4oPCNk4MFZtLPsucvMaSV5PmwJbU72+YDhXRIE6vlYm9JF4NN70s1v8gLkVdVaStV+ceD2X41UXHxuruAww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvgIiY4anEDmHl5y9qpBSp8F3QqO/H3y5kFh1jYTFtA=;
 b=YLkpBe/yi/yWsoJg0AIxi6RosnuTOmRaTaItCfptJ6sN8P1xOpC8nTDV0th39v74UigZrELK38P6CgrBcxoYxHYa5laSib1t9+BqgkR9+xYt/zRFIi1VMbyJQZPWY+JBnfaCGwARAOO3aQmIlAd0tUO4GtUdvCaVO4o9Bvvud7oIfNF6mQOjJErBoK1JoQ6G2APgu33+mZ2XlGdN1yoVME/2/pzRdq5JrLbeK7r2dlJCd2hx3XW8cQ4igDilNhYaLmt8STC7hQP1yzRACsSiLl06fQ5kM1FWPHzXhTeR6995SawdOVaKKosrFvnnhUU9GIYakrfcuvmsII56WCSBvA==
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com (2603:10a6:10:ed::15)
 by AS8PR03MB8858.eurprd03.prod.outlook.com (2603:10a6:20b:536::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.26; Tue, 14 Nov
 2023 13:45:02 +0000
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::fea9:8f02:fb13:fd44]) by DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::fea9:8f02:fb13:fd44%6]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 13:45:02 +0000
From:   Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
To:     Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 6/7] xen/events: modify internal [un]bind interfaces
Thread-Topic: [PATCH 6/7] xen/events: modify internal [un]bind interfaces
Thread-Index: AQHZ//oVz+DyHlClAkeSP+z9zQ/ubLB6AZEA
Date:   Tue, 14 Nov 2023 13:45:02 +0000
Message-ID: <8e3a25c3-e355-47d4-a9ce-d38e8a9375d4@epam.com>
References: <20231016062831.20630-1-jgross@suse.com>
 <20231016062831.20630-7-jgross@suse.com>
In-Reply-To: <20231016062831.20630-7-jgross@suse.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR03MB6108:EE_|AS8PR03MB8858:EE_
x-ms-office365-filtering-correlation-id: d6ebb366-391c-4f03-abe1-08dbe517e6e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jQsFO13Tda/cGgwxC2/sXQvzxT1Bkyhrla42+JdxPIRt/2WuG0TKcqKoNie0L6y6KRNEMJq3uVsQAXX3sieUbX4tGQE5lXht3SX1gw/By7tJ4L1CSDhYNWyceRRireq27w7sKUg+FtSiY9FS7qmKY2LqNLGHnozEO5K1WOeWRYXeywIMI1g79CJKyB5FKjE/Hc3z3AFS37nhbL/pBdR6pr2Z4ETjQ8SPCCHN85n9rk1fNr2vAtdH68HBUOGmh9pWi3s2sgRXblHDx3K40JiBIs3iwZEsWpr6bf++6H7jD4i4oKcrVzIg1RwVYRzLZTYmf0ckPE0Q3IpoCyxxpIIv1p+Ha8IY+4h7PNFjTyInPZYleoW+MDDFA6AT2cYWLONeOcIhlqOh76Qn3tFK9v9RcekVOhuUPMjyUKXfV/jilQXLKL+sk02i98ZAcaLZk9Fpxr3GlveXZG159xAxuitY+gwpAcFzfBcbIgRDaZVvut9Ic4mbyAtVJ2nLJCze0b49b+bPh897W15O/V9V0APegde32URuMc+jLwmRtmasQXs9QV63n00rFLbVdbiOVGudvLEWYtNlR/mc7tgBA39YC0G4iF5Zxno3K7X+65GA2tVcFnRxG1KYh5ZyC5/R0c2GdB92FVmBXo6PqOC1HzJqag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR03MB6108.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(26005)(122000001)(38100700002)(83380400001)(86362001)(5660300002)(2616005)(38070700009)(31686004)(6512007)(6506007)(53546011)(31696002)(478600001)(71200400001)(6486002)(36756003)(66946007)(316002)(76116006)(110136005)(54906003)(66446008)(66556008)(64756008)(91956017)(66476007)(8676002)(8936002)(4326008)(4744005)(2906002)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3M1V1k3N2ZlSEp4WXA3ajlTbk5yMGxHU3dLRmFTTTVyODJoSjd3MDliQ0Mx?=
 =?utf-8?B?dGdpaVJUOVhpRk9aeXdmeWF1WUpIZUZDSUxUdTRBSjNKWHBya3FnQm9ZRUpj?=
 =?utf-8?B?WXNLRSs2bVlVUndXSjdvYnJjUGYvUEFLODM5aGRlWnFISWhvWlV4V2NOdjl2?=
 =?utf-8?B?emJHU2xPRlJ0clN3VEVEVjY4VGNFK21lV2FtSVZtZ3ZjT0hTajhRWTFNMFV4?=
 =?utf-8?B?VE9FQm43ajJ1RkdNandGc1hXNEFpV3U3YWdZRTFCVVJ0ZjB2bnJ4U3hYUmwz?=
 =?utf-8?B?N1Y4K3VwL3V3eXprVko4ZjZiQmU0UDdiemZsbkVYZzExT2xhTEhWOFhkOEdF?=
 =?utf-8?B?ZkRuQ1M3dThRTVFxN2JWTk1HSlZDK0lQVnhIV0lTemtEazFnUVZ2cFQrWmlL?=
 =?utf-8?B?eWQrcTY4YU5tVTFEbjRBUWpHNG9yelBnVThHNndvN1ZkaWVOaWljY3lGTjBW?=
 =?utf-8?B?dXM1aEJWQzltZFhlTkdEVTN0MGhZWEdCclg5Q2JRRUk2Tmp2MzNBd1kxVFBq?=
 =?utf-8?B?WGpCNUhMb09MYzJEMlMzeDdhTi85RDFwT1EyR09DSlBwVjlHUVdlVWtpZDAz?=
 =?utf-8?B?dExHdGxUTm4rU0N5dit1dEZmdzFjZWRGRlZtWDYyQk9HSWgxelJxUUlKSUts?=
 =?utf-8?B?Y3NoNkxxMmVqYUdOSDJaVzMrWkZsbC9rNjlkQjRnQll4VisvSCtSVW5hZGhL?=
 =?utf-8?B?RVhsTGk4WVBsRzUvS3lRU1o0dzN2S0k3Q1dDNk9VTUdPZFdCWE1YYVh5b1JH?=
 =?utf-8?B?bndsd1U2OGhpWDYybk5NbXg0aE9WeHBac0JYTU0yTFE1UU1SdXVDWTdyTTJr?=
 =?utf-8?B?S25uM2hEc3NpKzZjbkZCZ2E0U1J0OWR4NjBZTEdvVHpSa09yajM2SWcranFG?=
 =?utf-8?B?ZUdXN0NyYkRVMEZqa1UwYm12YVJ3RUVtcFZDSENXQzhEQ1pGcFY1S1l1U1Qz?=
 =?utf-8?B?VFo0d2hpTkZLVmNjWmRrSHE5QXpGQTZ1UTFRSU9iTUJiQ041UGxkbDZjRkdm?=
 =?utf-8?B?ZEorVm1CL2ZJVzJlcTVqVUZUN1FybEZ1K044aU1hZTJ4QzFVOC9aZlhGVWRz?=
 =?utf-8?B?eXVDdkRFRms2a1YwV0JucDVFN1NidExIOERhQk1qYm1DWTEwaWVpM2NRS2Zi?=
 =?utf-8?B?Q2RpMHBBZkpaaFBVNXE3dmhqNW1PalNFKzMwQlpBT0U4R3k1QnpsQUlIOFJZ?=
 =?utf-8?B?bHNsMUJodXdPSlBiY28xRmZ5b1dzV2pab3M4UGR4amNRYVVzaVNVRnFxTlQ5?=
 =?utf-8?B?SWhieUtySU52bWJGWkhuR1hnUG5KWjRPNFcrY3A0SkJZc0tNK3ZjY3V2Y2FE?=
 =?utf-8?B?YzlPb0lRcFZJd3RRN2xVTGpBcnVmL3BCQW42OTFtbDNuQ24xeTRaOXdzZEd6?=
 =?utf-8?B?NFg5aEFZRW5jc3RvcXRnd09wRExmTVpWN2N5Q2lHUENsRUdlOUx2eHVjYStL?=
 =?utf-8?B?Z2RXdnpTVHZYV3VSMENwaG5EMDRKWVpOUHBhcU9QTC9YVEhFU1l2VnFSNUxT?=
 =?utf-8?B?ZVZEbG90cUdQT3RpY1RING55VTRTaTV0NmpDbzlVanB4b1hyWWR2YStOam1W?=
 =?utf-8?B?bGw4ay8xQk15eXdYV25Uay9RYXlXcE8yek9oazVaS2JhRXI4TlhNdlNHdzBr?=
 =?utf-8?B?NUhUQ3hBSVJMeUdjaitJV0gvL25YZ3QrbFBmNktxaXkxTGt0RjcwbUpSbFFD?=
 =?utf-8?B?REc5V1VMeHhSSm1GNS9TaWdFZjB4QWJlTWN6RU52eGNod3BWaFRBRzF4VzZG?=
 =?utf-8?B?MkJoMXQ2Q05VR2NGZEdXVzV4czVmNC94UXo1alBsdk5IY2VlTVJ6NGVoazI0?=
 =?utf-8?B?SDJZRHFvSHVmcS83VlRvbUZYT1UyNnJGTTcyQnNvQSsyTDJWZjhBMEJSZXQ2?=
 =?utf-8?B?Z2Q3eWVacmM4NkZJaGdjcEhzS28vbHo0Qk9xbmpyU09oYXBZekFJeUhiejVm?=
 =?utf-8?B?UW51OGVSVHJkZWwzRzVCVkRFSGFKdzN2QnZZclJ2bGZvb1BoRkdvSEU0TXJT?=
 =?utf-8?B?VVNES2tzeks1V3lmZFQ1blEvNngyR0JJeFpKWXpEYTVsRmt3emk2Wm5CQnRm?=
 =?utf-8?B?ZTd1M2pURVVEblFILzEvaGpqQkJxcnpPOVpvSkRDb2RkZHZjckY3Nyt2VU4y?=
 =?utf-8?B?ckJ3WjgwK3V4L1p2czFFMXBsNUlQZHI4RmQwd2JvREFTWTVzRkJPcWxvc0RX?=
 =?utf-8?Q?09FJQR8yO3l2k86mHKDnrus=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A7D687F77FE104798F613C0417FD91D@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR03MB6108.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ebb366-391c-4f03-abe1-08dbe517e6e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 13:45:02.3486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f9JDS8zJfgZgu7Xs1SzIFoYh7fAXYr4p87rfwjwNnunMdHmSK78UMqPDw3///pvQq5IPF/X9Wn0kAh1uP/mhvut/0A/2q/upu/I4/UlwDVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8858
X-Proofpoint-ORIG-GUID: GR72j6sx8WMhs1kumAaNvH5XHJgf7B2v
X-Proofpoint-GUID: GR72j6sx8WMhs1kumAaNvH5XHJgf7B2v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_13,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140106
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDE2LjEwLjIzIDA5OjI4LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KDQoNCkhlbGxvIEp1
ZXJnZW4NCg0KPiBNb2RpZnkgdGhlIGludGVybmFsIGJpbmQtIGFuZCB1bmJpbmQtaW50ZXJmYWNl
cyB0byB0YWtlIGEgc3RydWN0DQo+IGlycV9pbmZvIHBhcmFtZXRlci4gV2hlbiBhbGxvY2F0aW5n
IGEgbmV3IElSUSBwYXNzIHRoZSBwb2ludGVyIGZyb20NCj4gdGhlIGFsbG9jYXRpbmcgZnVuY3Rp
b24gZnVydGhlciB1cC4NCj4gDQo+IFRoaXMgd2lsbCByZWR1Y2UgdGhlIG51bWJlciBvZiBpbmZv
X2Zvcl9pcnEoKSBjYWxscyBhbmQgbWFrZSB0aGUgY29kZQ0KPiBtb3JlIGVmZmljaWVudC4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCg0KDQpJ
IGRpZG4ndCBzcG90IG9idmlvdXMgaXNzdWVzIHdpdGggY3VycmVudCBwYXRjaCwgb3RoZXIgdGhh
biBqdXN0IHRoZSANCmZhY3QgdGhhdCBwYXRjaCBuZWVkcyByZWJhc2luZyAoc29tZSBodW5rcyBj
YW5ub3QgYmUgYXBwbGllZCBiZWNhdXNlIG9mDQoiZTY0ZTdjNzRiOTllIHhlbi9ldmVudHM6IGF2
b2lkIHVzaW5nIGluZm9fZm9yX2lycSgpIGluIA0KeGVuX3NlbmRfSVBJX29uZSgpIiB3ZW50IGlu
KS4NCg0KSSB3YXMgZ29pbmcgdG8gYXNrIHdoeSAicGlycV9xdWVyeV91bm1hc2soKS9waXJxX2Zy
b21faXJxKCkiIHdhc24ndA0KY29udmVydGVkIHRvIHRha2UgYSBzdHJ1Y3QgaXJxX2luZm8gcGFy
YW1ldGVyIGFzIHdlbGwsIGJ1dCBsb29raW5nIGF0IA0KdGhlIHJlc3QgSSBub3RpY2VkIHRoaXMg
d2FzIGFscmVhZHkgZG9uZSBpbiBzdWJzZXF1ZW50IGNvbW1pdC4NCg0KV2l0aCBwcm9wZXIgcmVi
YXNpbmc6DQpSZXZpZXdlZC1ieTogT2xla3NhbmRyIFR5c2hjaGVua28gPG9sZWtzYW5kcl90eXNo
Y2hlbmtvQGVwYW0uY29tPg0KDQoNCltzbmlwXQ==
