Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5CC766D26
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbjG1MYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236661AbjG1MW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:22:56 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17F6525D;
        Fri, 28 Jul 2023 05:20:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5RIUMNFzNF38sEK6zc08wlUqPDF19OtdzoiRpe00MpHuHwevLmr7VuGqOZ1LsQB8GCnMm45Go8A2vsqyobeqgMEMQHig9X2qX19VDogsYKjnj8gMam1dq0CpcyeUIMHIyLLGk+FXapKnxpoySm/N13yaNfS4zX6aFfXaPvvjrlzv2E9GBPP4mvoM/gn/yLR54DIdQdlAWnqRpaX9rn/fouAdabCszl1eINKxqtIDmf+pHxWB8uWJIr7GHe9jYiT3hHAOUAPhuE2bqq4MVPNxVYSG8p4Etv1CdPtYmroqrRaQpv2YJzA5omjKbuy8KkhTBZ/Gtz/zBB2gEjHWGH/Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olMf0Xiy7RQGCch6lQVNughpxU6x5opW4xu48ANkVb4=;
 b=ocGVzKz3LhX6HBYPBNcGwzaiiaFJU7wah1vBNRVIsrQ7Q/a/wzOOJnKr3nF/c54COI8vLCZ8WohyX+m7zHoWB+/lXk8mREBCsWgbwdph/J2QA4lBWO6oP37TuGDdfUrZaJnRxpr0WU6+g1n6jRS4VZtz/FeuE/4Wr6ZHXk5tjrnDzvscOecevEmCzrS/8eVku/k5Roj4TZCOx+kcA7AlNyYzPC7DQBpJpcBQSKypxNg1VrfeVh7Gbsfj+mtkGIS/t5qrZTd73KXk/4u3bTCQ7lfLWlAe575XtXQlrvgPDEQQwshOCeK4yDJvlSEvw6XovYq5jvgls5US/dlZMT0Vsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olMf0Xiy7RQGCch6lQVNughpxU6x5opW4xu48ANkVb4=;
 b=nPlD3FYbHYzz6JZo92LA55bPxd5UMESrSua45y0xR8LxKmYMaNEKKaypOMFo+cVDH7eyS93LLn5BuTsVYOBUB/1u8OElJWlATBG45Dm7MA3FlJUptAnU7vUcifoVNVA58dppOV+5FtDIbEBBWZI0alUsUHy/u4kjE9pTuxyOiLiNr6lSrvt0jMH/WSKEz9mBzFdKu+Q2Pr+YefSuCO96E+usm6ICyDJd14/ez9RktuDsnxH0x2ufagkEr0ghEzz5Z1rZQjAw+D4v+oMIuQ/NBtKX6wBB3Sr16eJE2SGKDSLQdromonrZH96R0hNieYbdd7kEFq0tV4b2n6lq2tt50Q==
Received: from BN9PR12MB5068.namprd12.prod.outlook.com (2603:10b6:408:135::21)
 by DM3PR12MB9435.namprd12.prod.outlook.com (2603:10b6:0:40::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Fri, 28 Jul 2023 12:20:25 +0000
Received: from BN9PR12MB5068.namprd12.prod.outlook.com
 ([fe80::f077:3948:e6e6:a0f8]) by BN9PR12MB5068.namprd12.prod.outlook.com
 ([fe80::f077:3948:e6e6:a0f8%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 12:20:25 +0000
From:   Liming Sun <limings@nvidia.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] mmc: sdhci-of-dwcmshc: Add runtime PM operations
Thread-Topic: [PATCH v4] mmc: sdhci-of-dwcmshc: Add runtime PM operations
Thread-Index: AQHZhP3LlCCL3Av6cUO4jqWcK/X0x69hnxmAgG3u+/A=
Date:   Fri, 28 Jul 2023 12:20:24 +0000
Message-ID: <BN9PR12MB5068790086E15C24AC975EAFD306A@BN9PR12MB5068.namprd12.prod.outlook.com>
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
 <20230512181527.189345-1-limings@nvidia.com>
 <9094e3c9-77fd-081f-244a-9454b81bd3b6@intel.com>
In-Reply-To: <9094e3c9-77fd-081f-244a-9454b81bd3b6@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5068:EE_|DM3PR12MB9435:EE_
x-ms-office365-filtering-correlation-id: 6bdc37d9-791b-494a-332f-08db8f65058c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qtkIgQoQkRlvxVysdDbY6OdeWD1MN0xIvIUzgaCCvuj/snJIxEvfhyBURHxy4u8ebbGUwAewP/2HXjZam5JfvDJrFdZTwBW9iF7+0KnseNUf97y/ovu/lRC/WV17Byq5B6R6Tx97YxcweTDv2e3sl/VWgbM+QV/2HrZrnNooyXnudidkx7N0bRi1tjj5iWbBZMb2Nshu0BeE5TQhDuubO9n7rr+GbFHNWkz85pNchMyfeX8ZJBx/qCrLAv5CR/0qmSYpjYOOc6v+WHNBTeIp9Pn5akuctW6VsBQT6aE+qmRoJvF+8YmMdhBIvpYMCTxSqv7o5v6MpYPIJg9fBrlvKwHhT/zs2ik+YxIsNMsYhBHuMcRDH2zcDxRjDPtyjHFAqe0P87jbNCiaHrtCybE1gwKA1KsRg6K6s15NwtLTKknvvtXobd5UjD/OZ8R2odGRItKwoQUhNoTfYwFftwCaZNsuAZXlSOo6ymGyl+ORqRmpkM+/ideKycrfYhEjSN1gBMHvro9P940eWygRjMM+QQcG3ZJ6rxqCEBUfo3EKQxe/gKlGKbgmtafJ2gmJbXiyV4SLWQh27x7uyqTtWIAjhn5KCNwdACZphviQMUkbaYkux/XQMQMnxmilIj6bKdoUbZfukOcHFxIVP964hBReEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5068.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199021)(55016003)(316002)(110136005)(7696005)(122000001)(9686003)(54906003)(38100700002)(478600001)(5660300002)(52536014)(41300700001)(66556008)(8676002)(66446008)(66476007)(64756008)(71200400001)(66946007)(8936002)(76116006)(4326008)(83380400001)(26005)(6506007)(186003)(53546011)(86362001)(33656002)(38070700005)(2906002)(133343001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjNSQmJXY2ZpQm5ybEFWandWQkl4UzRrZHZCQmdyZFF0UndHZVZodDBpQzVD?=
 =?utf-8?B?Nnp6dTU5c1pvZ2VPQ2o0V25HTlRQQ1pPdlFuUnovSE9nck1oUVZsYW9IZlY3?=
 =?utf-8?B?cnJ6dlFlU3hoOWZ1NklZanQzWUYzTjI3VTF5SlpSUlNBeS9JMXBhZlcvV1pW?=
 =?utf-8?B?R0VMYTFiRWwxbHFJNGNKMzNabGExUUVUUWNVb00vM3k4eXp5QmFVdzg1QlRz?=
 =?utf-8?B?OXM3d05LcXNyeXFPV0dlV20rR3NOYjVoNEozSlRIM0d6bXdGVURPNkZwME9M?=
 =?utf-8?B?T0FPY3VWWTRFZGoya0UxOTVYQ3pITlZoVDVaVmE5MzJqNU1rL3lZdXlVTGdT?=
 =?utf-8?B?cWhyNDh3blhZbFU1dkRVb0ZmK25TWXFsazE3ZXg4anJLN3g4VHFSSnNJRTdQ?=
 =?utf-8?B?SlVaUUJkdGRzZzBJZ2JJc0Myc3VJU2JNUHJTOGpmc3BFSjZPM1E2T1JiWlQ3?=
 =?utf-8?B?Uk9JelJ1VEp0dm0vYVFxYWIwd3lVdlNHK2l4ZkdZcDF6MTg3d1A1Nm9hUHRT?=
 =?utf-8?B?RnduZ3Z6QU9HWlFkd01kWWRQbHZkZGw3alA5S29YQUlLVVd1UHRCcUdoMnJu?=
 =?utf-8?B?djRGSWpNMVdvNnVpMy9ZRitsTmtqUTVwM0l1MHVyQ3FZSHZ0NHRQSnJHYjBW?=
 =?utf-8?B?Z1dGdlYvc2lxdlozY0F0NDhaRk9abmFsSUE4Yk9aWTh3cjg1UEJPdE40dkg4?=
 =?utf-8?B?R2xIZTRYOUsybytETUVxLzdyOWZpYmx3OXVrWGVyT0QyM1IzUXJVdk5Mc3Z1?=
 =?utf-8?B?NkdxYlloYnBGZHRzdCtoRGMvNy9WZE92QlduUFl5NUxaZUpRbU8xckVxMmxL?=
 =?utf-8?B?MmxEeVd0aW1BMGpYOFVXWWw5Vk9la3FHalZHbjhLRGoza2I5clhWbUsyaE9P?=
 =?utf-8?B?Vk56aGRlR0JtbFRsMDRNc2twVExreGsvcDB6dVRrL1kyRStrSk1mQjJUdlY2?=
 =?utf-8?B?TXNuTHBxQWFiV1I4Nm41dDcrdDMzbzNBVXdrRGVKS1p3QjlucjhlVFRXdnJ6?=
 =?utf-8?B?WlIzcmRGWFhmeXg5U0srZU04TW55VkVoYmFRNW1ZU2c3RFMreExYQWxqd0lK?=
 =?utf-8?B?NVQ3MDIrWlhVWllSS0o1cDZSVHp6SmhZRlJ0Zy9SazFsOVZibGhxR1R3Zlpj?=
 =?utf-8?B?UEQ0R2txcTAwMUR0M0U0SGtGYkRlZmYxajVKaVZvdEZWdTBHMjBGcmpMMHFi?=
 =?utf-8?B?c21HM0pRR0xBL3JDK0lnVzJUVW5lWC9Db2M1Ry9oYUVxSGpTSHMwei8xbmR6?=
 =?utf-8?B?elpuSXJPSGRRYUh1Q0xtVldQSzhBMVphVWRVOFh2ZnBkcVlHU3k5dGtQTG9m?=
 =?utf-8?B?ZmlIT2JrNVVocFlWYVhJNlR4M3djTFJjMHRtaUxZWEJzVWlzbmRzOFNsS0xJ?=
 =?utf-8?B?amZkdGhYalpMUnliSm9xZ3hLUmdKY3hucE1XTmliSm03b29xV29QbDZmZ1ZY?=
 =?utf-8?B?SUltNVRUK29YbVp3MkYvY2thUllXT0hxWlJCTUZiNDh4Y29ubkdCcGEwaUl4?=
 =?utf-8?B?dVphK0JaeXlhTkl1K2RGUFE2MjlDbEp0UkhYeldxVG1mdm9qem5lREFQc2NK?=
 =?utf-8?B?TTgwbUZvcnBMYyttK3JiaUlkZVAyREt3NmQ2Mkg1NnBkMWhDbW1obXBrWjR3?=
 =?utf-8?B?VlFtcmRPYm5wVFVwN2pnTW9jK1lsd0ltcnVHaUtwNkJ0ZFJjVmtWb21OM2lp?=
 =?utf-8?B?QmFpNlA2RCtBZyt3cTlvU3ZJMk1sQi90Ui8yTUhCd21INEREVUhodmtZa001?=
 =?utf-8?B?eHc4d2dXZWhxY1lSMjFrMm1FbGdGM2VpcGp2NC9KRlo4Skg0RjBSajNVbkFC?=
 =?utf-8?B?U1BPaHZtaUE2aFk0SDc5NkxiUVdMamxOcGxKdnRxVzh6UmNqRlBPWW41UzJ5?=
 =?utf-8?B?TTZmUkh2WmFPNzRwSnJVOGFKbk5BTnV0K08wSHBXclNndzMvRExZWk0rbytG?=
 =?utf-8?B?OXdwSjJ5azEzOE1hV0hPVmdIcWNiZ2k3b3VEVUxuTUZMeWdNdFlMbFUzQVBY?=
 =?utf-8?B?TDB0SUJjMVFNYUk0dG9SZ04yWXdnYnFzRGo3OTJDclJCWkZBb3hGU1d5T0NV?=
 =?utf-8?B?NlI2UHdlV1EzNFN0TlpJUDFCTmR3eWNnS2tEcEVsSkZVT1ZmUDI3WWRFRzFj?=
 =?utf-8?Q?buX8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5068.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bdc37d9-791b-494a-332f-08db8f65058c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 12:20:25.0467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l8tGy4lY3i/rdKF4OA5XTKKs4gqLozxOoYho4VIDhZOjPtBg+TZJJnekLc77nRRpJGp4LTkbW9CN98h9CMFbmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9435
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RG9uZSwgdXBkYXRlZCBpbiB2NS4NCihzb3JyeSwgbm90IHN1cmUgaG93IEkgbWlzc2VkIHRoaXMg
Y29tbWVudCBlYXJsaWVyKS4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBBZHJpYW4gSHVudGVyIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT4NCj4gU2VudDogRnJpZGF5
LCBNYXkgMTksIDIwMjMgOToxOSBBTQ0KPiBUbzogTGltaW5nIFN1biA8bGltaW5nc0BudmlkaWEu
Y29tPjsgVWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+Ow0KPiBEYXZpZCBUaG9t
cHNvbiA8ZGF2dGhvbXBzb25AbnZpZGlhLmNvbT47IFNoYXduIExpbiA8c2hhd24ubGluQHJvY2st
DQo+IGNoaXBzLmNvbT4NCj4gQ2M6IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NF0gbW1jOiBzZGhj
aS1vZi1kd2Ntc2hjOiBBZGQgcnVudGltZSBQTSBvcGVyYXRpb25zDQo+IA0KPiBPbiAxMi8wNS8y
MyAyMToxNSwgTGltaW5nIFN1biB3cm90ZToNCj4gPiBUaGlzIGNvbW1pdCBpbXBsZW1lbnRzIHRo
ZSBydW50aW1lIFBNIG9wZXJhdGlvbnMgdG8gZGlzYWJsZSBlTU1DDQo+ID4gY2FyZCBjbG9jayB3
aGVuIGlkbGUuDQo+ID4NCj4gPiBSZXZpZXdlZC1ieTogRGF2aWQgVGhvbXBzb24gPGRhdnRob21w
c29uQG52aWRpYS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTGltaW5nIFN1biA8bGltaW5nc0Bu
dmlkaWEuY29tPg0KPiA+IC0tLQ0KPiA+IHYzLT52NDoNCj4gPiAgICAgLSBGaXggY29tcGlsaW5n
IHJlcG9ydGVkIGJ5ICdrZXJuZWwgdGVzdCByb2JvdCc7DQo+ID4gdjItPnYzOg0KPiA+ICAgICAt
IFJldmlzZSB0aGUgY29tbWl0IG1lc3NhZ2U7DQo+ID4gdjEtPnYyOg0KPiA+ICAgICBVcGRhdGVz
IGZvciBjb21tZW50cyBmcm9tIFVsZjoNCj4gPiAgICAgLSBNYWtlIHRoZSBydW50aW1lIFBNIGxv
Z2ljIGdlbmVyaWMgZm9yIHNkaGNpLW9mLWR3Y21zaGM7DQo+ID4gdjE6IEluaXRpYWwgdmVyc2lv
bi4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1kd2Ntc2hjLmMgfCA1
NA0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
NTMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtZHdjbXNoYy5jIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhj
aS0NCj4gb2YtZHdjbXNoYy5jDQo+ID4gaW5kZXggZTY4Y2Q4Nzk5OGM4Li4yZDc4MGE1YmM4ZmIg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1kd2Ntc2hjLmMNCj4g
PiArKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWR3Y21zaGMuYw0KPiA+IEBAIC0xNSw2
ICsxNSw3IEBADQo+ID4gICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gPiAgI2luY2x1ZGUg
PGxpbnV4L29mLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4NCj4gPiArI2lu
Y2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3Jlc2V0Lmg+
DQo+ID4gICNpbmNsdWRlIDxsaW51eC9zaXplcy5oPg0KPiA+DQo+ID4gQEAgLTU0Niw2ICs1NDcs
OCBAQCBzdGF0aWMgaW50IGR3Y21zaGNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAq
cGRldikNCj4gPiAgCQlzZGhjaV9lbmFibGVfdjRfbW9kZShob3N0KTsNCj4gPiAgI2VuZGlmDQo+
ID4NCj4gPiArCXBtX3J1bnRpbWVfZW5hYmxlKGRldik7DQo+IA0KPiBJcyB0aGVyZSBhIHJlYXNv
biB0byBjYWxsIGl0IHRoaXMgZWFybHk/ICBUaGF0IHJhaXNlcyBxdWVzdGlvbnMNCj4gYWJvdXQg
cnVudGltZSBQTSByYWNpbmcgd2l0aCB0aGUgcmVzdCBvZiB0aGUgaG9zdCBpbml0aWFsaXphdGlv
bi4NCj4gUGVyaGFwcyBiZWxvdyBpbnN0ZWFkIChub3RlIGFsc28gdXNpbmcgZGV2bSk6DQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1kd2Ntc2hjLmMgYi9kcml2
ZXJzL21tYy9ob3N0L3NkaGNpLQ0KPiBvZi1kd2Ntc2hjLmMNCj4gaW5kZXggMmQ3ODBhNWJjOGZi
Li41Y2VlNDJkNzIyNTcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2Yt
ZHdjbXNoYy5jDQo+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtZHdjbXNoYy5jDQo+
IEBAIC01NDcsOCArNTQ3LDYgQEAgc3RhdGljIGludCBkd2Ntc2hjX3Byb2JlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ICAJCXNkaGNpX2VuYWJsZV92NF9tb2RlKGhvc3QpOw0K
PiAgI2VuZGlmDQo+IA0KPiAtCXBtX3J1bnRpbWVfZW5hYmxlKGRldik7DQo+IC0NCj4gIAlob3N0
LT5tbWMtPmNhcHMgfD0gTU1DX0NBUF9XQUlUX1dISUxFX0JVU1k7DQo+IA0KPiAgCWVyciA9IHNk
aGNpX3NldHVwX2hvc3QoaG9zdCk7DQo+IEBAIC01NjIsNiArNTYwLDggQEAgc3RhdGljIGludCBk
d2Ntc2hjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ICAJaWYgKGVy
cikNCj4gIAkJZ290byBlcnJfc2V0dXBfaG9zdDsNCj4gDQo+ICsJZGV2bV9wbV9ydW50aW1lX2Vu
YWJsZShkZXYpOw0KPiArDQo+ICAJcmV0dXJuIDA7DQo+IA0KPiAgZXJyX3NldHVwX2hvc3Q6DQo+
IA0KPiANCj4gPiArDQo+ID4gIAlob3N0LT5tbWMtPmNhcHMgfD0gTU1DX0NBUF9XQUlUX1dISUxF
X0JVU1k7DQo+ID4NCj4gPiAgCWVyciA9IHNkaGNpX3NldHVwX2hvc3QoaG9zdCk7DQo+ID4gQEAg
LTY0Niw3ICs2NDksNTYgQEAgc3RhdGljIGludCBkd2Ntc2hjX3Jlc3VtZShzdHJ1Y3QgZGV2aWNl
ICpkZXYpDQo+ID4gIH0NCj4gPiAgI2VuZGlmDQo+ID4NCj4gPiAtc3RhdGljIFNJTVBMRV9ERVZf
UE1fT1BTKGR3Y21zaGNfcG1vcHMsIGR3Y21zaGNfc3VzcGVuZCwNCj4gZHdjbXNoY19yZXN1bWUp
Ow0KPiA+ICsjaWZkZWYgQ09ORklHX1BNDQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBkd2Ntc2hj
X2VuYWJsZV9jYXJkX2NsayhzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCkNCj4gPiArew0KPiA+ICsJ
dTE2IGN0cmw7DQo+ID4gKw0KPiA+ICsJY3RybCA9IHNkaGNpX3JlYWR3KGhvc3QsIFNESENJX0NM
T0NLX0NPTlRST0wpOw0KPiA+ICsJY3RybCB8PSBTREhDSV9DTE9DS19DQVJEX0VOOw0KPiA+ICsJ
c2RoY2lfd3JpdGV3KGhvc3QsIGN0cmwsIFNESENJX0NMT0NLX0NPTlRST0wpOw0KPiA+ICt9DQo+
ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBkd2Ntc2hjX2Rpc2FibGVfY2FyZF9jbGsoc3RydWN0IHNk
aGNpX2hvc3QgKmhvc3QpDQo+ID4gK3sNCj4gPiArCXUxNiBjdHJsOw0KPiA+ICsNCj4gPiArCWN0
cmwgPSBzZGhjaV9yZWFkdyhob3N0LCBTREhDSV9DTE9DS19DT05UUk9MKTsNCj4gPiArCWN0cmwg
Jj0gflNESENJX0NMT0NLX0NBUkRfRU47DQo+ID4gKwlzZGhjaV93cml0ZXcoaG9zdCwgY3RybCwg
U0RIQ0lfQ0xPQ0tfQ09OVFJPTCk7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgZHdj
bXNoY19ydW50aW1lX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICt7DQo+ID4gKwlz
dHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiA+ICsJaW50
IHJldCA9IDA7DQo+ID4gKw0KPiA+ICsJcmV0ID0gc2RoY2lfcnVudGltZV9zdXNwZW5kX2hvc3Qo
aG9zdCk7DQo+ID4gKwlpZiAoIXJldCkNCj4gPiArCQlkd2Ntc2hjX2Rpc2FibGVfY2FyZF9jbGso
aG9zdCk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIHJldDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3Rh
dGljIGludCBkd2Ntc2hjX3J1bnRpbWVfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiAr
ew0KPiA+ICsJc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsN
Cj4gPiArCWludCByZXQgPSAwOw0KPiA+ICsNCj4gPiArCWR3Y21zaGNfZW5hYmxlX2NhcmRfY2xr
KGhvc3QpOw0KPiA+ICsJcmV0ID0gc2RoY2lfcnVudGltZV9yZXN1bWVfaG9zdChob3N0LCAwKTsN
Cj4gPiArDQo+ID4gKwlyZXR1cm4gcmV0Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICsjZW5kaWYNCj4g
PiArDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyBkd2Ntc2hjX3Btb3BzID0g
ew0KPiA+ICsJU0VUX1NZU1RFTV9TTEVFUF9QTV9PUFMoZHdjbXNoY19zdXNwZW5kLCBkd2Ntc2hj
X3Jlc3VtZSkNCj4gPiArCVNFVF9SVU5USU1FX1BNX09QUyhkd2Ntc2hjX3J1bnRpbWVfc3VzcGVu
ZCwNCj4gPiArCQkJICAgZHdjbXNoY19ydW50aW1lX3Jlc3VtZSwgTlVMTCkNCj4gPiArfTsNCj4g
Pg0KPiA+ICBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBzZGhjaV9kd2Ntc2hjX2RyaXZl
ciA9IHsNCj4gPiAgCS5kcml2ZXIJPSB7DQoNCg==
