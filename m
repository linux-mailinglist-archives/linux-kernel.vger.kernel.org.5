Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88387FF0F6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345767AbjK3Nzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345937AbjK3Nz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:55:28 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FF11B3;
        Thu, 30 Nov 2023 05:55:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ja51zvteE+gjGgjpYKiO++1sGSwH0UK1OfiEZIbAse4Xx39kdLNdnUcFuMvo0fqhtQgZLw7/lC8Lfnqq+k5a+xUi2X9EOAJ3OPFI32hdR/odAPXeTD4jwjk68f3vMV5tKCd43d3mgGAOyhGCmhdOSyLMe88VWoT9YVaVHqkKC6UI7qJ6oEJVcNX1alZFTGIOY71WODk1DTCiwqLMwmpFQ4IzEoS1yFal8o+T5k91h3FUwCXJwrujFkqDsI9BN9bS5AKXPkBx+pT2g0THq4wRfhRd6lFsode43PnWDiI2+Nsx2zOj+Nl91nSm5TOexrOt3sX689sGAVTjZ6NQojIBeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtek7g6kM7XsinjCODCas4KVSO4wVTPxu3a7sy+P0c8=;
 b=MfTrUhM4OF7Zn7oFftr6p0hI4ZJ2DJnoDKl3KEvdXiu/bYfivgOKpsAtoEqLyWheppJWX88D/DQnXXeEAiwjoECo3/lvOIZCKJvr3CWeAIShUpn8moYLnunozzXRMt+gZxSB4wI3ztBkhUg6q4aNTD24wDyrGKLGOksR60SCJGPHYz+oZdNoMsivhp8NpxUHveriNKOWxNzdvFRpCVS/QNZ/Sk5/+0MYgCeMo1zCwOsXAHFiKe75ExZ/aGHWUmvVstBofgSbTlRnmEWFqGdKR0yOZNOjKrqWSyBa89C8+v/Qf7tYmdZ0h3ljbG7s1i5Q7WpZ6HLgRxHF79EteOMAIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtek7g6kM7XsinjCODCas4KVSO4wVTPxu3a7sy+P0c8=;
 b=E4JJ7mmIvTWXTJc9lOI5OvotMNs8KxIlYA4Eq5aVo1kmdyLnj6hH6VNMPUGGuYM+JRwMK1IUa3JxCCOOq/1VcMtAnXBJAeEMLkCULApOhJByZd4rYJmoOglE5KMxniRmUpkI4ftHEbF/qxf6hCvwIUVH7x6qBHE0oMPd1eSN8PRAMDdHT5KRMcQLVvwUSerk7lZcV7XBwqP9dAgGQyGcE7+sNZiZTLb9llgZ+G9gLQp8AjV9XbfDSvEOFVjM59JYw7FHTneOPOj4vYmIy1FBW4E/n52N10CBYoKQemxa4HwZtrKW7IFUkzJ+xWmMd7qqmdhvT+C1R/tR2w3FBwhvfQ==
Received: from MN2PR12MB4486.namprd12.prod.outlook.com (2603:10b6:208:263::23)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 13:55:07 +0000
Received: from MN2PR12MB4486.namprd12.prod.outlook.com
 ([fe80::8e49:a604:559e:6962]) by MN2PR12MB4486.namprd12.prod.outlook.com
 ([fe80::8e49:a604:559e:6962%7]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 13:55:07 +0000
From:   Shachar Kagan <skagan@nvidia.com>
To:     "edumazet@google.com" <edumazet@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>, Ido Kalir <idok@nvidia.com>,
        Topaz Uliel <topazu@nvidia.com>,
        Shirly Ohnona <shirlyo@nvidia.com>,
        Ziyad Atiyyeh <ziyadat@nvidia.com>
Subject: Bug report connect to VM with Vagrant
Thread-Topic: Bug report connect to VM with Vagrant
Thread-Index: AdojlBh7YzKl9vsWRhaqwSQXl5yh5w==
Date:   Thu, 30 Nov 2023 13:55:06 +0000
Message-ID: <MN2PR12MB44863139E562A59329E89DBEB982A@MN2PR12MB4486.namprd12.prod.outlook.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4486:EE_|DM6PR12MB4483:EE_
x-ms-office365-filtering-correlation-id: c78cad25-3628-4efa-af72-08dbf1abf5e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hrk+t/965vzdC1BISPq3Jx8OfmQ4iSHQ6QLXBxmxn02S/VnHEZrdaXyryEWnZTzf7yy3XnUcHHPxuCyLX1+kZ+9+XJfZ5alpPazYTWYsXqZYdh2lMq+Gc8NPLdwl4VqgpxoBRfgaK/t92eTzDHg6aioMiSDgx+WUUjZstTQ2YU6xmJ9Pb+3TNob3+JUjzkM1RiNwHZ9adQsp1ybXOiCTkl04vS+saJaPwshkJewMUeaNna4/2qOaWL5xqsNH+QJqs2SvJN71ziVFHafZ+gCe2bi6gR9KYCJZsTDsVCc4RnKoRPSehmYi1GnsAzJniRMb4VH+upYGiA/6Z+fJt5KkIBR+G51SInxGWi1pQCq0Hjk9tx6d1MfXpjtM/1j+x1p6Z3SfAqOrHUElU5zKBORUQODtAUVW8b+047q1nQIZjHR734h3JRLFYZ76F9BKI7CArh70r8BB8GeD45++JEITbj7ToKuFcH0tx+Xfi6jr2lmgp8nnzC7VSalBgHUNeoMfzUzvWIH46aBQ2LPhjN+LtIGpB+5Lac44JrYwSzFR6Rr24/pTU55QNmP4tINgpauDIgR9/IbeJYBfbWl6uVzMg6b49F66DoujHTvm3pSF1i00U6xf9TSGPxGUrGbd0CWUHs6vxOVT33+9LR9z4+sG7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(38070700009)(55016003)(33656002)(122000001)(2906002)(41300700001)(5660300002)(86362001)(83380400001)(71200400001)(9686003)(38100700002)(6506007)(7696005)(107886003)(26005)(478600001)(76116006)(52536014)(66476007)(66946007)(64756008)(4326008)(8676002)(8936002)(66446008)(66556008)(54906003)(6916009)(316002)(17993001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmJwem8vcEY2MW5CNGVINWRsQSs5eVZwUWdWVWdxdFpIeGZYWnJXVWZHRnVQ?=
 =?utf-8?B?UFZFaUdxTEdBdGpjbGJHMWxQSzB4ekhPK2p0ZXMva1JNSFlST2gyNXdWM0pa?=
 =?utf-8?B?MVBleExCL0c5WlFUNk9zeWFteVMwaXRVMm5YeWtBTFZCQllRc3M2cFJCb0hY?=
 =?utf-8?B?VTJUTU84Q3ltVkljSjBGVnZMbzJSNnRPYVJheEFuYXh6b2tNVnphZG9uRGlV?=
 =?utf-8?B?ZVduK3dHTnp4RWpoWG9BU1NFcmduZG9tdmphd25DSGtUTmhNL2c0TEZLUlFT?=
 =?utf-8?B?dk9IdUpORFh1ZFE0czFQWkJsYjFjNnQ3TWtTbDI0LzRQaFZ5OGZ5UkZRSm1j?=
 =?utf-8?B?SndpbzNKTXkyZ0o3T2FJdnlIUVRHWW5xbjZaZlVxRUQxYldPQ2xrd09wUGNB?=
 =?utf-8?B?TnVmRDJjRmhUM1dOTU51d2xBRHYvR0J3QzNSZFNIQlRZRXMrVnB3MDVXbC8w?=
 =?utf-8?B?SmQwSENJVDYzb3FiNHZIQVR6UkxLQkhZenBiWG9uM1R1L3BhQkZLamYwa1VV?=
 =?utf-8?B?dkhWLzRpQ1lVODZ4Z0Q0QS9HY1VYV3g3TVhGVGFVdEdmQWtNMEtIYVpzNGNE?=
 =?utf-8?B?UjNPY09DMjA5RnplSERQZUtWdG5NVERkRFlEVWhQUjQxVlFGYXVUNm80MDhU?=
 =?utf-8?B?M0ZqWitSVFNsc3lDY2pUeHNkbmtBSlU4QWREU0dhOFovQ0xoUlhBdmp1TlVp?=
 =?utf-8?B?K1pBN3hzVkw2aDBZaDhuZUJXKzlSUnRHZnYxOHJCazcyRGZTOThQRDRLVWxZ?=
 =?utf-8?B?bWxVd2ZTQW9OUmxqaXFEejk0bjdoTElQUUpCNGwrckRiR21qWVV4enZtZnhN?=
 =?utf-8?B?QWJiUS9DVlJTZlpuQ0F5S1dsekg0VFZMaDZURjFNZ05vMklXY0liWE5tbUJB?=
 =?utf-8?B?YWNyOXVwR01rbDJYOVpzaVJTNFBxNERUNGM3NE1DSC80ZFNJRzdWUnNodjV6?=
 =?utf-8?B?TndDeW05Tzg1cExYbEYyMW1kdWVWazZNaXlXQWh4MmIvbkgrU1lxUUdCNHhG?=
 =?utf-8?B?TEdiV0czNHYvKzh4YmZwbml5aVpXMTFXR0plbVIzVmpUYjUyQWRpUUtrRlNa?=
 =?utf-8?B?NXV4UWhOVDZ6T1RWNTRxNnIxbWpyUlBMeS9DZnZqUjkwTnVTbEUxeFczcGN5?=
 =?utf-8?B?NWNUeEZlTTluSkFHNnJBTCtMcmFCVkhPczY2WjlOd3hCU3VOZVF3bGwwZnRH?=
 =?utf-8?B?VkwxNVI2VVh5YzFFTjhmTE5LNDA0K3A2ZXVGZWpXVEtnalU0N0oyK09FZ2ZV?=
 =?utf-8?B?QlBYajhPbDNsRjNLVjQyU3BxeVg4YW5OVS9GMThsclVBV0tmV1Z2TU54bHJy?=
 =?utf-8?B?OGlxUjlSMWpoYjhQdERtaVhnMGlTZDIwdlJGY1B4WjBrVURsWlZKd01jeDhj?=
 =?utf-8?B?RHlqWUE3MlYvNHhweFRyZjErc0oyZGg3KzdRT2tubCt6SEhyamVHdnp0NlZ2?=
 =?utf-8?B?R0MwYit4UEJOUnZJcVVTOTNPYisvNFc1RHFobkttdEJpQjZQckY1WElSRmZk?=
 =?utf-8?B?SExwRjV3MG9kclo0TEhWOGxoa2lhRGd6UnpITHZGWjA2TklsK2t6MFRXbFJW?=
 =?utf-8?B?ZkxuSFhBbmZWMGdZREpmcGprc29FT0F6YzBSN2J6REVORzlDcmUzSTNSS3c5?=
 =?utf-8?B?WmJLVGk0L09tR0VJdGxMQWJjeU9FeWY0Nlp6V0ZObTJ6MUs4TURwNEFScHNT?=
 =?utf-8?B?Z2F3OWZRRVVUUDQ5bitZUlRkaVN6c0xabmNieFF1NklVUlZEM2xSYUgrRGhL?=
 =?utf-8?B?d1dpMElCVmdhTk1WKzF2Ymcvd1c4NmJkaW10VisrdkJuK3kwM0dKQWQrK2c1?=
 =?utf-8?B?Q2tFZE5Qb1JhUU0vZ1F5amxObWlPN0ZEa1MvNjk4eWh1SUQ5L2RDWjlCN1Mz?=
 =?utf-8?B?cXpzYmtmZnNMVU9WYnZ2cU81MlA0cnBVc1l3M09HRUZ1c250K1BSSCs3UjdN?=
 =?utf-8?B?RGlhanFhYzM3KzVvQUZYTXMzZzcyYlBLWVhuUjQ3OUMwWnF1T0txb291Tlgz?=
 =?utf-8?B?NzhLT2U0NFBPc3Y2bmxMYkovY0NkWDlkNmJSUVFtMkNXUkJkRWEzUTVtQXFE?=
 =?utf-8?B?ZGRuTnhXSC8rY0ZIUkdEQmpLc0lOU1Rpd0tHSWYyRkRINmN2Mk9GbkNkeDJD?=
 =?utf-8?Q?XUJ4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c78cad25-3628-4efa-af72-08dbf1abf5e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 13:55:06.9643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YxxAGYgYtFhPvtDBFLoQGIGD78KyRgANTBykKJJQCM9mkm8qTibp/dOlQS3naPk1amGgTdr/Y/j1224SFH6oRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRXJpYywNCg0KSSBoYXZlIGFuIGlzc3VlIHRoYXQgYmlzZWN0aW9uIHBvaW50ZWQgYXQgdGhp
cyBwYXRjaDoNCmNvbW1pdCAwYThkZTM2NGZmN2ExNDU1OGU5Njc2ZjQyNDI4MzE0ODExMDM4NGQ2
DQp0Y3A6IG5vIGxvbmdlciBhYm9ydCBTWU5fU0VOVCB3aGVuIHJlY2VpdmluZyBzb21lIElDTVAN
Cg0KRnVsbCBjb21taXQgbWVzc2FnZSBhdCBbMV0uDQogICAgDQpUaGUgaXNzdWUgYXBwZWFycyB3
aGlsZSB1c2luZyBWYWdyYW50IHRvIG1hbmFnZSBuZXN0ZWQgVk1zLg0KVGhlIHN0ZXBzIGFyZToN
CiogY3JlYXRlIHZhZ3JhbnQgZmlsZQ0KKiB2YWdyYW50IHVwDQoqIHZhZ3JhbnQgaGFsdCAoVk0g
aXMgY3JlYXRlZCBidXQgc2h1dCBkb3duKQ0KKiB2YWdyYW50IHVwIC0gZmFpbA0KDQpUdXJuIG9u
IGEgVk0gd2l0aCDigJhWYWdyYW50IHVw4oCZIGZhaWxzIHdoZW4gdGhlIFZNIGlzIGluIGhhbHQg
c3RhdGUuIFdoZW4gdGhlIFZNIGhhc24ndCBiZWVuIGNyZWF0ZWQgeWV0LCAnVmFncmFudCB1cCcg
cGFzc2VzLg0KVGhlIGZhaWx1cmUgb2NjdXJzIGluIHRoZSBOZXQtU1NIIGNvbm5lY3Rpb24gdG8g
dGhlIFZNIHN0ZXAuDQpWYWdyYW50IGVycm9yIGlzIOKAmEd1ZXN0IGNvbW11bmljYXRpb24gY291
bGQgbm90IGJlIGVzdGFibGlzaGVkISBUaGlzIGlzIHVzdWFsbHkgYmVjYXVzZSBTU0ggaXMgbm90
IHJ1bm5pbmcsIHRoZSBhdXRoZW50aWNhdGlvbiBpbmZvcm1hdGlvbiB3YXMgY2hhbmdlZCwgb3Ig
c29tZSBvdGhlciBuZXR3b3JraW5nIGlzc3VlLicNCldlIHVzZSBhIG5ldyB2ZXJzaW9uIG9mIHZh
Z3JhbnQtbGlidmlydC4NClR1cm4gb24gdGhlIFZNIHdpdGggdmlyc2ggaW5zdGVhZCBvZiB2YWdy
YW50IHdvcmtzLg0KDQpTdGRvdXRbMl0gYmVsbG93Lg0KDQpBbnkgaWRlYSB3aGF0IG1heSBjYXVz
ZSB0aGUgZXJyb3Igd2l0aCB5b3VyIHBhdGNoPw0KDQpUaGFua3MsDQpTaGFjaGFyIEthZ2FuDQoN
ClsxXQ0KY29tbWl0IDBhOGRlMzY0ZmY3YTE0NTU4ZTk2NzZmNDI0MjgzMTQ4MTEwMzg0ZDYNCkF1
dGhvcjogRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPg0KRGF0ZTogICBUdWUgTm92
IDE0IDE3OjIzOjQxIDIwMjMgKzAwMDANCg0KICAgIHRjcDogbm8gbG9uZ2VyIGFib3J0IFNZTl9T
RU5UIHdoZW4gcmVjZWl2aW5nIHNvbWUgSUNNUA0KICAgIA0KICAgIEN1cnJlbnRseSwgbm9uIGZh
dGFsIElDTVAgbWVzc2FnZXMgcmVjZWl2ZWQgb24gYmVoYWxmDQogICAgb2YgU1lOX1NFTlQgc29j
a2V0cyBkbyBjYWxsIHRjcF9sZF9SVE9fcmV2ZXJ0KCkNCiAgICB0byBpbXBsZW1lbnQgUkZDIDYw
NjksIGJ1dCBpbW1lZGlhdGVseSBjYWxsIHRjcF9kb25lKCksDQogICAgdGh1cyBhYm9ydGluZyB0
aGUgY29ubmVjdCgpIGF0dGVtcHQuDQogICAgDQogICAgVGhpcyB2aW9sYXRlcyBSRkMgMTEyMiBm
b2xsb3dpbmcgcmVxdWlyZW1lbnQ6DQogICAgDQogICAgNC4yLjMuOSAgSUNNUCBNZXNzYWdlcw0K
ICAgIC4uLg0KICAgICAgICAgICAgICBvICAgIERlc3RpbmF0aW9uIFVucmVhY2hhYmxlIC0tIGNv
ZGVzIDAsIDEsIDUNCiAgICANCiAgICAgICAgICAgICAgICAgICAgIFNpbmNlIHRoZXNlIFVucmVh
Y2hhYmxlIG1lc3NhZ2VzIGluZGljYXRlIHNvZnQgZXJyb3INCiAgICAgICAgICAgICAgICAgICAg
IGNvbmRpdGlvbnMsIFRDUCBNVVNUIE5PVCBhYm9ydCB0aGUgY29ubmVjdGlvbiwgYW5kIGl0DQog
ICAgICAgICAgICAgICAgICAgICBTSE9VTEQgbWFrZSB0aGUgaW5mb3JtYXRpb24gYXZhaWxhYmxl
IHRvIHRoZQ0KICAgICAgICAgICAgICAgICAgICAgYXBwbGljYXRpb24uDQogICAgDQogICAgVGhp
cyBwYXRjaCBtYWtlcyBzdXJlIG5vbiAnZmF0YWwnIElDTVBbdjZdIG1lc3NhZ2VzIGRvIG5vdA0K
ICAgIGFib3J0IHRoZSBjb25uZWN0aW9uIGF0dGVtcHQuDQogICAgDQogICAgSXQgZW5hYmxlcyBS
RkMgNjA2OSBmb3IgU1lOX1NFTlQgc29ja2V0cyBhcyBhIHJlc3VsdC4NCiAgICANCiAgICBTaWdu
ZWQtb2ZmLWJ5OiBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+DQogICAgQ2M6IERh
dmlkIE1vcmxleSA8bW9ybGV5ZEBnb29nbGUuY29tPg0KICAgIENjOiBOZWFsIENhcmR3ZWxsIDxu
Y2FyZHdlbGxAZ29vZ2xlLmNvbT4NCiAgICBDYzogWXVjaHVuZyBDaGVuZyA8eWNoZW5nQGdvb2ds
ZS5jb20+DQogICAgU2lnbmVkLW9mZi1ieTogRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxv
ZnQubmV0Pg0KDQpbMl0NClZhZ3JhbnQgdXAgc3Rkb3V0Og0KQnJpbmdpbmcgbWFjaGluZSAncGxh
eWVyMScgdXAgd2l0aCAnbGlidmlydCcgcHJvdmlkZXIuLi4NCj09PiBwbGF5ZXIxOiBDcmVhdGlu
ZyBzaGFyZWQgZm9sZGVycyBtZXRhZGF0YS4uLg0KPT0+IHBsYXllcjE6IFN0YXJ0aW5nIGRvbWFp
bi4NCj09PiBwbGF5ZXIxOiBEb21haW4gbGF1bmNoaW5nIHdpdGggZ3JhcGhpY3MgY29ubmVjdGlv
biBzZXR0aW5ncy4uLg0KPT0+IHBsYXllcjE6ICAtLSBHcmFwaGljcyBQb3J0OiAgICAgIDU5MDAN
Cj09PiBwbGF5ZXIxOiAgLS0gR3JhcGhpY3MgSVA6ICAgICAgICAxMjcuMC4wLjENCj09PiBwbGF5
ZXIxOiAgLS0gR3JhcGhpY3MgUGFzc3dvcmQ6ICBOb3QgZGVmaW5lZA0KPT0+IHBsYXllcjE6ICAt
LSBHcmFwaGljcyBXZWJzb2NrZXQ6IDU3MDANCj09PiBwbGF5ZXIxOiBXYWl0aW5nIGZvciBkb21h
aW4gdG8gZ2V0IGFuIElQIGFkZHJlc3MuLi4NCj09PiBwbGF5ZXIxOiBXYWl0aW5nIGZvciBtYWNo
aW5lIHRvIGJvb3QuIFRoaXMgbWF5IHRha2UgYSBmZXcgbWludXRlcy4uLg0KICAgIHBsYXllcjE6
IFNTSCBhZGRyZXNzOiAxOTIuMTY4LjEyMy42MToyMg0KICAgIHBsYXllcjE6IFNTSCB1c2VybmFt
ZTogdmFncmFudA0KICAgIHBsYXllcjE6IFNTSCBhdXRoIG1ldGhvZDogcHJpdmF0ZSBrZXkNCj09
PiBwbGF5ZXIxOiBBdHRlbXB0aW5nIGdyYWNlZnVsIHNodXRkb3duIG9mIFZNLi4uDQo9PT4gcGxh
eWVyMTogQXR0ZW1wdGluZyBncmFjZWZ1bCBzaHV0ZG93biBvZiBWTS4uLg0KPT0+IHBsYXllcjE6
IEF0dGVtcHRpbmcgZ3JhY2VmdWwgc2h1dGRvd24gb2YgVk0uLi4NCiAgICBwbGF5ZXIxOiBHdWVz
dCBjb21tdW5pY2F0aW9uIGNvdWxkIG5vdCBiZSBlc3RhYmxpc2hlZCEgVGhpcyBpcyB1c3VhbGx5
IGJlY2F1c2UNCiAgICBwbGF5ZXIxOiBTU0ggaXMgbm90IHJ1bm5pbmcsIHRoZSBhdXRoZW50aWNh
dGlvbiBpbmZvcm1hdGlvbiB3YXMgY2hhbmdlZCwNCiAgICBwbGF5ZXIxOiBvciBzb21lIG90aGVy
IG5ldHdvcmtpbmcgaXNzdWUuIFZhZ3JhbnQgd2lsbCBmb3JjZSBoYWx0LCBpZg0KICAgIHBsYXll
cjE6IGNhcGFibGUuDQo9PT4gcGxheWVyMTogQXR0ZW1wdGluZyBkaXJlY3Qgc2h1dGRvd24gb2Yg
ZG9tYWluLi4uDQoNCg0K
