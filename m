Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5DF75DD0F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 17:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjGVPD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 11:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGVPDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 11:03:24 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DE110F5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 08:03:22 -0700 (PDT)
Received: from pps.filterd (m0174677.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36ME9V0d005193;
        Sat, 22 Jul 2023 15:03:09 GMT
Received: from eur02-vi1-obe.outbound.protection.outlook.com (mail-vi1eur02lp2046.outbound.protection.outlook.com [104.47.11.46])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3s0f8k0558-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Jul 2023 15:03:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LB/dBvEqsnFJmPeGzo3/ccJ5l7KfVIx0RdBOyKB+s4mo3dOqcQROTZBq+dsa5qYcZkABz762L3PTLs2hd+wTx3XGFEDFk5RMN8U6TQHkO2jzjis8eqZQEJD0yq1a37M7pxs7fVffib+YgWIVtt/NOggI1WFIBjA8xe+S//q2f7vogNE4VMkeVpLvbxj4YBxPqeqs7rHSjiQ6za/FvmyWnZC2SEmFAAZKQTJx+baAMV/yETQCwC8EpEZdw4mD7op2XA2jf1DbMGGORUReXmDFH8fbdxwxMJixxsKNOBWrv6D2ZB1Gg5kESF/6xiydb4CN69I3t+org0qd810nVa/aVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+R4ajVG3h6SMNFqmYuOHuTKxByn6UKJrQ1FcwGYWYAM=;
 b=M1zHdZl5Vee6Tq6+gX+LGMKr2EKKEJK8CWZUAKmz+rYbVan+FnHMMcMXZEDcWv/XNkLdeKW2vtJreWkq9FEgtlR1Mn4PXuIY4wu5H9HQRRJfq91ROfaD9k4kG5E96TgyzzysNY24btuTbqLRvRUa0aOkhoXzFIOn8YZr8f7n3Vz08j65Z8mwfGSU363/JcnXX0giFW1f4dYmWxMdqlqlUW2pc84Rd/Y2OgJdWT2NRILK2b8zHU64Ir+UBFlH3HUQ/3eFONGBJvLNWCcYqjurJu5p8cWKpgm8HbMyHQsY9p1mjUMZOn8lK7fy99cADzNzU3pzlOaECOE5+m3UrDEaFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+R4ajVG3h6SMNFqmYuOHuTKxByn6UKJrQ1FcwGYWYAM=;
 b=W02NSaxKUY8ovifrsVK1b0R4S+XRiutjtFY7lib1BFQMbErNl9y5hp6Pw3nqJpZYKbAUWradFTl/I3SCLStlgWstyrFLGZXNv9xRFSUf3qCWUEpdIsmwFDOR/6qiGcitqLUrDHTKeEtinyT+BPSn1JzI7cKPMxirBEpbMfNDsJLLWagqkRF6EVYKqWPrP8Oiz2ve9uCt80RH5qhgUb+9ePWH6OIjB8DJq8HXkXGeLqkOo1ursFdGZu+dlZktEybU2zKPuIxN/yw1rowClW7z7FfqA4kAiqMTEFQ8zfyC+ZsgnGo8+NWEgnYkEUo+Kf2et44VNS7yQX3Lb9xUope6Xg==
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com (2603:10a6:10:ed::15)
 by PAXPR03MB8226.eurprd03.prod.outlook.com (2603:10a6:102:24d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Sat, 22 Jul
 2023 15:03:05 +0000
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::11f9:615a:4d9a:a5d2]) by DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::11f9:615a:4d9a:a5d2%6]) with mapi id 15.20.6588.027; Sat, 22 Jul 2023
 15:03:05 +0000
From:   Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     Vincent Guittot <vincent.guittot@linaro.org>,
        =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        "stratos-dev@op-lists.linaro.org" <stratos-dev@op-lists.linaro.org>,
        Erik Schilling <erik.schilling@linaro.org>,
        Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Juergen Gross <jgross@suse.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH V2 1/2] xen: Update dm_op.h from Xen public header
Thread-Topic: [PATCH V2 1/2] xen: Update dm_op.h from Xen public header
Thread-Index: AQHZuuzPfJ0NTGNckUyWY+5pgNmcK6/F5WEA
Date:   Sat, 22 Jul 2023 15:03:05 +0000
Message-ID: <8fa45eb3-93d8-15bc-d963-57abf1fed16f@epam.com>
References: <c923befe0a016891e7dee3e1ccb3c00d676f2b3d.1689845210.git.viresh.kumar@linaro.org>
In-Reply-To: <c923befe0a016891e7dee3e1ccb3c00d676f2b3d.1689845210.git.viresh.kumar@linaro.org>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR03MB6108:EE_|PAXPR03MB8226:EE_
x-ms-office365-filtering-correlation-id: 02e3ccad-ea71-4e6f-9820-08db8ac4c091
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B7GX8foOLleKn3Es9VdiHrltkmt3iYaOXOEy4Q8NdlGRjISReyIZllPSupBbR2vjL0pHY80xov/YVFw1Egh9f3lYLIGnN8/uqDF19GoNrGhjqlDI281YTmc49bugdGSDYWudhU3+cqanv5d/vEomNl3fp/IHDvxfjL/b5SeeGECKI/HC4EBQeDFMUeDbo6UAzN29DXcW11ASTWF9ua5phR17KNoE1rAExo75VdyK+bWOC5KYkJEW+Zk2JapWGKj3iADVZe9m6zhd8oLHzmSxQFC01ZXtfLdAOVXtNHMlYPCLCqLHT3VGCFC7PIJO+FFQIophhJs3h0quUR43su+s7ksdUjbQeSUAiDaFoz663AvVJnxT9OABluRJ4xBSqgaQseQ9nd4cAhzRKgSreNhfmvFePd3aIvpp/bgzBBSATIMp6Ve3VFoODsev+wno6UD7o0LiIswHXwtNHkslNiMltPS0ucdwFJTiQBm5QOJ9pwI3DECrf1hiwD+bkfEZhh0ntMySQ5xw3JaLy29VH/72NnScjuqPglV9cqPTxSdQdNRlTTmoh0RWxPnbxjG7s/0F7lG9s9LLWZLD61pvZFv6LANMJB4rv4+UCyb8VRYQ9BruHfeihjzbdalM/oJ7U6VHI6bUCo/gsI8S9Lyws2U2RHzUfZ6LeRBxN19h69D8kTE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR03MB6108.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199021)(38100700002)(71200400001)(38070700005)(2616005)(66574015)(36756003)(15650500001)(83380400001)(54906003)(4326008)(66446008)(91956017)(66946007)(6916009)(66556008)(66476007)(2906002)(64756008)(316002)(76116006)(966005)(6512007)(478600001)(6486002)(26005)(7416002)(41300700001)(186003)(5660300002)(8676002)(8936002)(6506007)(53546011)(122000001)(31696002)(86362001)(31686004)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlhyVXFHZFBMV29wSmlneks4RFBWcGN2Z0ZqV1hrY1NJVDVaNVovK0kyZjhk?=
 =?utf-8?B?Vm9CWlphKzRhNUhXUEEzUGJ0akU5YnBzM2h0K3pJa1VBNEthWjVHbEs4RXBM?=
 =?utf-8?B?YnFTNFJ2cS9rc1ZTT01ranBxSGswNUxhWXUvclVnTFhOVlBWSjNvcHNrTzE1?=
 =?utf-8?B?OSs3U1dzdGUzalJybXQwRTNKcXBLUmRIV1BtL0JsOXNwWG0vRTNscUNHcmV1?=
 =?utf-8?B?Zk9KWW1oSnhmMERQbGEzV3RqUUhYVThjOU1abWliWEVrZ2lVVVJ3WlpIMjVh?=
 =?utf-8?B?MkRBZnhMQ2c5Q1Y0emlWNzFnVXFmR2xBRG9YVVEyelQzY2YvVExPdU4rYXpS?=
 =?utf-8?B?YjErS3BsL01EZE5XRlZmZzREOWtaVm5ibkpnYzFxeG90RVVvTFRmWTNPR29u?=
 =?utf-8?B?SnNOMmJkaTRTMU00VFJqUEVROUZWeEJoTnl1S2pGY0srTjg5czdMeW1Wdjc4?=
 =?utf-8?B?YzJMUGp0NjZwS1dvcUlyWGFVQWR6UWcxTThHWVh5U2hnbmFhTEduUGtKS3Bx?=
 =?utf-8?B?Qk5tbGpsdXZPZU5XeU5Fb3BQNFRhcXBPQnJMYVcwTGxSSEsyUG9WL3VHU1VG?=
 =?utf-8?B?WXdtR054ZXg3MzhaNHc5bWJuTldWN2d0TWV1U2pBSUE2cHhOOWZ5U0J2VjFz?=
 =?utf-8?B?UjhISFdOK0pQdURCU3BYQ0VDUVFyL2R0RVpQbDFnYzI3ZEs5VFpoV01aZ0Zv?=
 =?utf-8?B?ZXZlQmhRanBGenRUMktzUjhzVTdrTWdML2xCc25IRE9rNjJncU4wdXlpVzFu?=
 =?utf-8?B?TW84U0hreGcyS1RUcStQYklqRlJQV2M2KzREenFiMitwQmpCVEVDcGo3M2VD?=
 =?utf-8?B?NTlvWnVwWDlnUDZGcDF5WVdJZVFjN09UTlh4TGowRVc3L0pMcXgrVWhLME4v?=
 =?utf-8?B?SHRuTDZCcGYybU5nOUJWOHFjZC8vZTNLcTgxYjVTNWJFcFZJa2RyL3MyaGR0?=
 =?utf-8?B?TE9ENUtqVnhobzk5d0pZQ2YxbTBjTlJIODVIeXhVTDBORzAwSjNQNHJXcUIz?=
 =?utf-8?B?aTYzWTgxdGM2ZW43bFgzRWJ2bmFHVTQ2cUJyK1NWYkpQenl1aEFneHdyTUwx?=
 =?utf-8?B?elM4d0huZjVydXJwSitwUmJsVXlnZjlLcEdVNTVMSjVwVzBoLzYyWVA4aGor?=
 =?utf-8?B?bjV2OWlOcStYWUJYbGxTVk1yWVhMNXpjUU9KaGJCVVlYWUc1T3J1dW1BdDBa?=
 =?utf-8?B?bG5CMmxhSld4NWhpMlNMeUFDUll5dVY3c2VZdG1Dc3lhdVJ0SFFudWV5UXVD?=
 =?utf-8?B?WXpITUFMUnF5ZjJqNHFMaGVJVUxRQXhmUHE5V2dhU1pHc1BNUkVlVjdNeG1M?=
 =?utf-8?B?UkROZGIvM3hVOWR3Zy9hYm1LdmdPRjB2aW9ESk1GS1VKVWYvTG5NVWRnUDJ3?=
 =?utf-8?B?MGxlYXpwRzN6aVhqNXZrVWZoOVgrZVdsWEM3MUExRGhWRnp2c3VGWGZxajNl?=
 =?utf-8?B?azNPbVgrUDJBcW9jV3QrREdUNG5OSWF5MTUzMzNiNGZPdVRZRWdiV0N3bDlK?=
 =?utf-8?B?NFgrTzRXaHF5cTJuVkpTdUl2SWZDMm5UVVZYbHNmVVRvdUVGUHlMajY1Zkc1?=
 =?utf-8?B?QzlZWUJxVnBjVVR5RmVLWlpxOFVTZVR0NTNNVEVKM29Bd2k0V0U1MzFkWi80?=
 =?utf-8?B?dWp5TGloMWVYR090NjBIdmxXVUgwcU5KY1VVOGkwRUFsUC9Mbi9zNWM1QUZP?=
 =?utf-8?B?WmpETStPdDVLb2Z4cFp6cEZDZjRWcjJXSmdDcm5MY3Y1RUZyL0dJVmgzZWlJ?=
 =?utf-8?B?RmNZaGl6YnpWdmdaa09wVUsxQlVtWHZhUXl3Q3pzZ05iNnp4SVB1N0JaL0E0?=
 =?utf-8?B?UmZNQWZrQTVISDREaEhDZ1A5cEt4a28zZW5aRUpBRXpYQlhKNU1aMEZjUmRl?=
 =?utf-8?B?TDh4TlNKT3FhZW9Pb280T1JPWGFzRWVSQnZkbXdHSFFFcTNyYStLWDBxRGNJ?=
 =?utf-8?B?VjVzbHVpT0lOMUNYTUhNOGY4NTNPcWZPVDlZTHZPMVJiZ0pIMkswdzEwVi9P?=
 =?utf-8?B?ZUcrM2ZzT2U3YzF1b21xNUQrZ1ZtaE05SVZtTjZmSnY1NTc1WXh4bCtwdnMr?=
 =?utf-8?B?N2ozU1ZQYU9YWXBrYUtYczRBVlpBRjhrZVpKbFZNaWZsaDI0L1g5a0s1Wk9k?=
 =?utf-8?B?eU8wcjZqZFFOdFgwRUI0MXdSRTNEUnNMdFpKL245WEEweG45dUI2Zk0vOWxB?=
 =?utf-8?Q?QEv32NuQ/NVV/SfOBa+w/G8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F20B45FF40744548859B03E143B09FBD@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR03MB6108.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e3ccad-ea71-4e6f-9820-08db8ac4c091
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2023 15:03:05.1520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rPR72xM7FTtF1XTlFiTk7rwLY/fVDiQDL33v68MQc9+MP8g/XytzyTe5ZPuOb/eD+vGwJn3HQkgjbKxvJ6qe4l1H+fktl2NP5SCFGRcCfL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB8226
X-Proofpoint-GUID: Yj7-gXBjD7xu9IQURSG_3ZFdmPrhdLy9
X-Proofpoint-ORIG-GUID: Yj7-gXBjD7xu9IQURSG_3ZFdmPrhdLy9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-22_06,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=949 lowpriorityscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307220135
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIwLjA3LjIzIDEyOjMwLCBWaXJlc2ggS3VtYXIgd3JvdGU6DQoNCkhlbGxvIFZpcmVz
aA0KDQoNCj4gVXBkYXRlIHRoZSBkZWZpbml0aW9ucyBpbiBkbV9vcC5oIGZyb20gWGVuIHB1Ymxp
YyBoZWFkZXIuDQoNCkkgdGhpbmssIGl0IHdvdWxkIGJlIGdvb2QgdG8gbWVudGlvbiBleGFjdCBY
ZW4gdmVyc2lvbiAoY29tbWl0KSB3ZSBhcmUgDQpiYXNlZCBvbi4NCg0KSW4gZ2VuZXJhbCBwYXRj
aCBsb29rcyBnb29kIHRvIG1lLCBqdXN0IGEgbm90ZS4NCg0KSSBjb21wYXJlZCB3aXRoIFhlbidz
IHB1YmxpYy9odm0vZG1fb3AuaCBhbmQgbm90aWNlZCBkaWZmZXJlbmNlcy4gSSANCnVuZGVyc3Rh
bmQsIHRoaXMgY2Fubm90IGJlIDEwMCUgdmVyYmF0aW0gY29weSwgYmVjYXVzZSBvZiBoZWFkZXJz
IA0KbG9jYXRpb24sIGVtYWNzIG1hZ2ljcywgR1VFU1RfSEFORExFIHZzIFhFTl9HVUVTVF9IQU5E
TEUuIFRoZSBMaW51eCANCmhlYWRlciBkb2Vzbid0IGNvbnRhaW4gYW55IGFsaWFzZXMgdGhlIFhl
biBoZWFkZXIgaGFzIGZvciBlYWNoICJzdHJ1Y3QgDQp4ZW5fZG1fb3BfeHh4IiwgZm9yIGV4YW1w
bGUgLi4uDQoNCltzbmlwXQ0KDQoNCj4NCj4gKy8qDQo+ICsgKiBYRU5fRE1PUF9jcmVhdGVfaW9y
ZXFfc2VydmVyOiBJbnN0YW50aWF0ZSBhIG5ldyBJT1JFUSBTZXJ2ZXIgZm9yIGENCj4gKyAqICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNlY29uZGFyeSBlbXVsYXRvci4NCj4gKyAqDQo+
ICsgKiBUaGUgPGlkPiBoYW5kZWQgYmFjayBpcyB1bmlxdWUgZm9yIHRhcmdldCBkb21haW4uIFRo
ZSB2YWx1ciBvZg0KPiArICogPGhhbmRsZV9idWZpb3JlcT4gc2hvdWxkIGJlIG9uZSBvZiBIVk1f
SU9SRVFTUlZfQlVGSU9SRVFfKiBkZWZpbmVkIGluDQo+ICsgKiBodm1fb3AuaC4gSWYgdGhlIHZh
bHVlIGlzIEhWTV9JT1JFUVNSVl9CVUZJT1JFUV9PRkYgdGhlbiAgdGhlIGJ1ZmZlcmVkDQo+ICsg
KiBpb3JlcSByaW5nIHdpbGwgbm90IGJlIGFsbG9jYXRlZCBhbmQgaGVuY2UgYWxsIGVtdWxhdGlv
biByZXF1ZXN0cyB0bw0KPiArICogdGhpcyBzZXJ2ZXIgd2lsbCBiZSBzeW5jaHJvbm91cy4NCj4g
KyAqLw0KPiArI2RlZmluZSBYRU5fRE1PUF9jcmVhdGVfaW9yZXFfc2VydmVyIDENCj4gKw0KPiAr
c3RydWN0IHhlbl9kbV9vcF9jcmVhdGVfaW9yZXFfc2VydmVyIHsNCj4gKyAgICAvKiBJTiAtIHNo
b3VsZCBzZXJ2ZXIgaGFuZGxlIGJ1ZmZlcmVkIGlvcmVxcyAqLw0KPiArICAgIHVpbnQ4X3QgaGFu
ZGxlX2J1ZmlvcmVxOw0KPiArICAgIHVpbnQ4X3QgcGFkWzNdOw0KPiArICAgIC8qIE9VVCAtIHNl
cnZlciBpZCAqLw0KPiArICAgIGlvc2VydmlkX3QgaWQ7DQo+ICt9Ow0KDQouLi4gdGhpcyBvbmU6
DQoNCnR5cGVkZWYgc3RydWN0IHhlbl9kbV9vcF9jcmVhdGVfaW9yZXFfc2VydmVyIA0KeGVuX2Rt
X29wX2NyZWF0ZV9pb3JlcV9zZXJ2ZXJfdDsNCg0KQW5kICJzdHJ1Y3QgeGVuX2RtX29wIiBkb3du
IHRoZSBmaWxlIHVzZXMgdGhlc2UgYWxpYXNlcyBpbnNpZGUgYSB1bmlvbi4NCg0KSSBhc3N1bWUs
IHdlIGhhdmUgdG8gZGl2ZXJnZSBoZXJlIGluIG9yZGVyIHRvIGZvbGxvdyBhIHJlY29tbWVuZGF0
aW9uDQp0byBhdm9pZCB0eXBlZGVmJ2luZyBzdHJ1Y3RzIGF0IFsxXSwgYW0gSSDRgW9ycmVjdD8g
T3IgaXMgdGhlcmUgYW5vdGhlciANCnJlYXNvbj8NCg0KSSB0aGluaywgaXQgd291bGQgYmUgZ29v
ZCB0byBtZW50aW9uIGEgcmVhc29uIGluIHRoZSBkZXNjcmlwdGlvbi4NCg0KWzFdIGh0dHBzOi8v
d3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvdjYuNC9wcm9jZXNzL2NvZGluZy1zdHlsZS5odG1sI3R5
cGVkZWZzDQoNCg0K
