Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B57804ACF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 07:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344584AbjLEG7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 01:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344545AbjLEG7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 01:59:14 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A05FA;
        Mon,  4 Dec 2023 22:59:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhWCPZ8CZ5bmoVMmMcMFB7NyfHZi5Fft9dBk+rJM9vDn3wSjPz9z2pZXr24yZoXIc96disNi52acfzOdkpjRt2TsayvvHamQZch+ZM18Gmx8bGDSjSca9/EkNv4tRG8yiCX9BSMOJmRPtxoj4G/502I2ftrh4Zihmb73OoGKpn7OX7j16H7WQZ8esxZ3Efu1yLlfbudtZKkuglcm/0X9kHWLhFUCUzM/c/EckR3DdgPPIrLjsZfpJUkA6gcxj7llZO4UDPokNpFaofcRFftbTyZN1GMPQwwtbvW5g9wKhY6R59Y9xQBuYtbIL8/bHwzZdNKrlqloP7vN1u9ewYBqwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUFMWE6PUk8+M59G1oan/bVcRn978NHjqAt6bJTeho0=;
 b=Ac3s4wJFEsZS7IOx2oLbx22/7M1mL9nVfnfXuVrATv2EdIcAMk00O9ZJ3l8/PwxlAdJSZ6BVGueNPou4oMzfIlFXdbgPn3ubSiHoVTHChU8/WTxbgre1mOwpwnq8UNE8gXh0l0vdD1xe6kBf6mEmU91z8izzjJxLv3JI+BHbGpybY0T97D4U0wahH0MrRyzvhTN3BexzRHiZfBfQ25u9IQdvAbeVG4N8L3vvegOg/1wsa7C0t6rPH3m+2zbAHNoVmyVqR5NnjfbhZ04a0xgqyDtqStiIcW+MXGWOA/2bxgaxg30AzJ6fZfQZcwIs7eOfyN1RmGeToskfKYalB7UnRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUFMWE6PUk8+M59G1oan/bVcRn978NHjqAt6bJTeho0=;
 b=ulbhh//4Si2qjBxsDO48SGEs1Oi4s81CuHEYseZ/Dj1bTypK/dC0bO0/e2HusL2zkwgyx1Kp6YACEWQlMKMt3tIH45UuYavQ7f+OSek0inlDPnIH7HIdpvsnzPz3emfSpGSDUDbD2EwPBLUNOwbRyPQGP/wVcdinPLaa1vKNvwIo/yIW2OKJSn6A5fNbKbJimizN1vc9ou2mrPIvO7ng9SuqmHdf4Iof1Qv62s+utxADUR8ni+jcdhcGlTF6MQB3tGMxweXlRBJra4YGiFEbMb+805fo2aK6Q7juYiT59H8bWyYBZCwj+TGBaXBLp0eDaVCiVYoiFwLqU1EGUv2aVw==
Received: from CYXPR12MB9386.namprd12.prod.outlook.com (2603:10b6:930:de::20)
 by DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 06:59:17 +0000
Received: from CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::78d0:a51c:4795:9f64]) by CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::78d0:a51c:4795:9f64%4]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 06:59:17 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
CC:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        Jason Wang <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Suwan Kim <suwan.kim027@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] virtio_blk: fix snprintf truncation compiler warning
Thread-Topic: [PATCH] virtio_blk: fix snprintf truncation compiler warning
Thread-Index: AQHaJrtLnXj0iDZgFkOkqTing0Ls27CaQ6mA
Date:   Tue, 5 Dec 2023 06:59:17 +0000
Message-ID: <3b2bfd2f-5306-4a70-b1d9-6c41e72cd939@nvidia.com>
References: <20231204140743.1487843-1-stefanha@redhat.com>
In-Reply-To: <20231204140743.1487843-1-stefanha@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYXPR12MB9386:EE_|DM4PR12MB6136:EE_
x-ms-office365-filtering-correlation-id: fcaf174e-cf7b-4a7f-d9e5-08dbf55fb2bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fdijXTgU01v6Dg1sGdw0+qr65+xjG1u8h8bEW11JR0nIRdsOBVTvL6piUwcS8MQBr5r6XFejWAGs3KB7VvzsuT3eXyHnKIPYvxF8xK+094HlJRGPkZSuGKXVpV8ki5Y1pla4CbKvlxgHzV1wtAnb4K3ZxvR7va0LOyNw04s7MzRXWeWMgGHAMbG3prZ+xwnDtpWpiEBzsG8d6HUQ+aDMZ2T5rn0gN+Kfqve1TzTjsBjA+ycXyodRHDXwrmrpGEPAi1y98Kvu29+PblB9q0NVG9c2DKLl5fYOZACAiMNxVLh/VLaLDQeP3OtmpxlU69sN+c+BVq+lVg3/m4ex0HiOvWRH0D8bCJ1IjotpwaxoLbx6MlHQotgl+O21Ynw0wpPCRaljKFRcKYG717dqMvourjdP38WEi9XaxB0qgbG4pEJoFZJ8fK1iIFMbAg9fZ5PXd0gX7hQa8NeK3ooeRkOCRCmOfWnYuQhUQd/5S2gPU+1OoLDfiU9IMxUQPCDhmL8SDNjlkgftwHz+O/8AGazt9nfbgzvK0wgKV8XmC7QvYDyspo6U/OmAecKHiB8FLsUW5mr5mJl7STT+zlM3p3BAijgOzixFfDfSoynK4v+oIbFBAMybUKCXc2HF/7M58poPLkfM2VAiZKM8ekr1E4Iz4J8MJju2w4V2LnyXUO9my2OMLPPmNVjGspcx8javLxncY7Yi207acXj5lbRLdR4hzdCjN1sCfaPHJ9LR5Cg1M6GykIF3OvTeUCJfImBDh+B5IwBWqTk+wsbFxIUbMEpT8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9386.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39860400002)(230273577357003)(230922051799003)(230173577357003)(1800799012)(451199024)(186009)(64100799003)(6486002)(966005)(83380400001)(478600001)(6512007)(2616005)(53546011)(6506007)(26005)(71200400001)(316002)(110136005)(66476007)(91956017)(66446008)(64756008)(54906003)(66556008)(76116006)(66946007)(86362001)(8676002)(41300700001)(36756003)(4326008)(8936002)(38070700009)(7416002)(2906002)(31696002)(5660300002)(122000001)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2NUVi9kR2hWUGVvR0pRM0tyWm9qZUFLdW1IK3BscTFWOHJ3bHRld2p3SzNE?=
 =?utf-8?B?NjRLT3Z5WHRnMVJPSTAxVGNPT3lIYngrZkYwbHNHVEJXNG5PbFh0enpoeFo0?=
 =?utf-8?B?Vk1idmZjc01QdUlEakZWbjRpK2wyTzl6SUVhTEVhVythaHFrZTdXMzBnVWN4?=
 =?utf-8?B?WFd5Nk1YRzljODlRK2VNd0lCSzJHU1hEcFhCVlg4Mkd1bzRCV1RSa0t3SUsw?=
 =?utf-8?B?UEc2U3AxWXIrUkhNdjdQamlkek1ZRjRVYnpWMmdHdnlLMWg5L0U1T0dJNHFF?=
 =?utf-8?B?RGdnNUU3MGVicWU1eWRadmhCTjZSbmNSMXBYYnR0bnhhYVhTbkJWU2h1dTMw?=
 =?utf-8?B?UnJ1V1U5MXdnRzFGK0RIWkpheDZmYnJONWlvTHBUTHdQd0czMDladmFZTTFu?=
 =?utf-8?B?bVBxTDJpV1cydGp0YkIzckVKYUM0MzV3NUUzTFoxbGpPZzFMZFFTUXlGN0pu?=
 =?utf-8?B?aHNIcDFCZC9JRmNnQVJPY2VlOEVTbjJQQVhlT1VZM3Zjb0srTjZOVlFVN1Mw?=
 =?utf-8?B?VW5lVGpXa0JUOVZ4K2pkZFdrcVZMVlZ1dmxYRkJjYkRqbUdaK2drR3dKQmpC?=
 =?utf-8?B?eDBkU0xRSmd3YlZUME1SeEgvY0ZMTlU3UGJ1K0lLbkF4VCs0YTI3bTB3NHcv?=
 =?utf-8?B?TGZTbzZUZTlsVFdValgwZmxQOTEyOU9NU1IwN3lCdXg0LzFsTkw3WVdPbmE1?=
 =?utf-8?B?QmVCK01QUUZWQk5MQ3ZRSEg0YUE3cWFneDBuTFQwcG83dHJaTUM4cmlrWmpo?=
 =?utf-8?B?eng5SC92NnplTWpHcm15TEtRQUJ1TmhJSC9mcGJOL01pMU9LU01lZXFMMDAr?=
 =?utf-8?B?ZlF6cFBScWpQYmY1dm5kTFpKTWg1eUFtTWxhV1pDQUZNdlViV2xaRmhLTnds?=
 =?utf-8?B?R0xUL3pMTEN0Wnc0RUZtbzY2Tm5zS3dPZk5CcWhaZ25EM1huVHozTmZ5bVJX?=
 =?utf-8?B?cVFpZXNCOU9YelEzcHBudkJXVE83ZlZMMVJ1VVpwTGlxa1kzYWJTay84azZE?=
 =?utf-8?B?dXFxbEdJVHBBNi9ITFpRRDBWMjRNMDN5amNUR3NZS2ZaekZHQlBuNXFlbWpi?=
 =?utf-8?B?MlE1ejBsNEdqaGZ0OEhxOVFKdnM3d0hIOTV6dEZhbVdXTzhESnFzZVpjY3hN?=
 =?utf-8?B?b0NnVjNXWkR5YWNZSWdNQXR3alAycjFMaFBvLzB5WUhQM2gxeHlEbjczVmM2?=
 =?utf-8?B?diszMDRsYnUySDVpWlRJK1Ayc0dLODVXdm45TTJpaGJyVTJQTWxOSlZlTzds?=
 =?utf-8?B?NW1SdkhoU2cydDFCVUgvdlBuWjRMWW5CSlF2cE1CcWxObmVFTFYyRXJ2U2Uw?=
 =?utf-8?B?eG85YU1tWEQ2UmVhK1ovTTZ3MzlPZWN3S3NqeEkzK2l0YTA2UXN2dFVldGky?=
 =?utf-8?B?RDY5eER6QWVLNXd6YlVkYm5KaEJ6Q2IrT0k0ZTVPRkdFQUpuWjRuSFpyTE9t?=
 =?utf-8?B?MldhOFZYbzhlU3V0ZlFlTDRJZHViY0ViSnJaeFQzdkZTRFc3S1NwTzBJMWdn?=
 =?utf-8?B?MDhLeUx6Ulorbm9KUWdBUjR4NE1KaTJiM1BTRWl4NythZkNsUngxbzJTL1c0?=
 =?utf-8?B?cWxqcHE5MVJNS2JCTFpzK21PSk4xck0wd1JKQlRoUzZOR0dTZXlSbXhkcEFm?=
 =?utf-8?B?UUdiZlViNjgra3l6aS9HYXpWbk5vRmYwcXg3a2x1MzFIR0VtcnlwLy9vSXNF?=
 =?utf-8?B?QzFhMmRaSFV6MjBVNzZuWTUyUktXZjZnNUl6QWg0cFZ4ZFFxVkpoYThsNEw1?=
 =?utf-8?B?S2pPQk50ZExHMjJseUhpSkFkRjhleXBiVi9MWEpSRHZSclR1b3ZGcTVoZFJ0?=
 =?utf-8?B?WTFWTjVKcW9ZUEwySDFtRUFhYWRSZ3FRNFNrQjRMWXk4VXhsK1F2ejBtd2Na?=
 =?utf-8?B?Y3l4Z2wvRzBYRm5rQlhFN2duenZzRytrUittSXAzcmVvcnlVWFJBNE0wSE0v?=
 =?utf-8?B?QnBZdUdTa1NhNkVPNCt4N2taVHp5YjZubndHQklFWFQ1a1hPU2pjdUNFcG1s?=
 =?utf-8?B?KzV6Snl5RHBWVTcxNVdlaVZaVDlKVnhDUjNXYWs0eFpCcHpJL21acWZncDBu?=
 =?utf-8?B?bEhROFZVQVlOTUZUYXQ4Z0ZIOWVibkl6eUpCOWtGa1RNcDA5ZEtETjUweXpj?=
 =?utf-8?Q?YbnEyAEwvaZwYAqJ4tW3DiUvx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D272939CF7C694EB0568164FF21AD53@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9386.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcaf174e-cf7b-4a7f-d9e5-08dbf55fb2bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 06:59:17.2432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: smp4DaYjIwO+2rT+PvZS3Gn3jREdhJ6hCA5qtjOakYZU2T+IgFNxjVakeGInG3dAjxa+JHtFBy2pAEqBjE+auw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvNC8yMDIzIDY6MDcgQU0sIFN0ZWZhbiBIYWpub2N6aSB3cm90ZToNCj4gQ29tbWl0IDRl
MDQwMDUyNTY5MSAoInZpcnRpby1ibGs6IHN1cHBvcnQgcG9sbGluZyBJL08iKSB0cmlnZ2VycyB0
aGUNCj4gZm9sbG93aW5nIGdjYyAxMyBXPTEgd2FybmluZ3M6DQo+IA0KPiBkcml2ZXJzL2Jsb2Nr
L3ZpcnRpb19ibGsuYzogSW4gZnVuY3Rpb24g4oCYaW5pdF92ceKAmToNCj4gZHJpdmVycy9ibG9j
ay92aXJ0aW9fYmxrLmM6MTA3Nzo2ODogd2FybmluZzog4oCYJWTigJkgZGlyZWN0aXZlIG91dHB1
dCBtYXkgYmUgdHJ1bmNhdGVkIHdyaXRpbmcgYmV0d2VlbiAxIGFuZCAxMSBieXRlcyBpbnRvIGEg
cmVnaW9uIG9mIHNpemUgNyBbLVdmb3JtYXQtdHJ1bmNhdGlvbj1dDQo+ICAgMTA3NyB8ICAgICAg
ICAgICAgICAgICBzbnByaW50Zih2YmxrLT52cXNbaV0ubmFtZSwgVlFfTkFNRV9MRU4sICJyZXFf
cG9sbC4lZCIsIGkpOw0KPiAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn4NCj4gZHJpdmVycy9ibG9jay92
aXJ0aW9fYmxrLmM6MTA3Nzo1ODogbm90ZTogZGlyZWN0aXZlIGFyZ3VtZW50IGluIHRoZSByYW5n
ZSBbLTIxNDc0ODM2NDgsIDY1NTM0XQ0KPiAgIDEwNzcgfCAgICAgICAgICAgICAgICAgc25wcmlu
dGYodmJsay0+dnFzW2ldLm5hbWUsIFZRX05BTUVfTEVOLCAicmVxX3BvbGwuJWQiLCBpKTsNCj4g
ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXn5+fn5+fn5+fn5+fg0KPiBkcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYzoxMDc3
OjE3OiBub3RlOiDigJhzbnByaW50ZuKAmSBvdXRwdXQgYmV0d2VlbiAxMSBhbmQgMjEgYnl0ZXMg
aW50byBhIGRlc3RpbmF0aW9uIG9mIHNpemUgMTYNCj4gICAxMDc3IHwgICAgICAgICAgICAgICAg
IHNucHJpbnRmKHZibGstPnZxc1tpXS5uYW1lLCBWUV9OQU1FX0xFTiwgInJlcV9wb2xsLiVkIiwg
aSk7DQo+ICAgICAgICB8ICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+IA0KPiBUaGlzIGlzIGEgZmFsc2Ug
cG9zaXRpdmUgYmVjYXVzZSB0aGUgbG93ZXIgYm91bmQgLTIxNDc0ODM2NDggaXMNCj4gaW5jb3Jy
ZWN0LiBUaGUgdHJ1ZSByYW5nZSBvZiBpIGlzIFswLCBudW1fdnFzIC0gMV0gd2hlcmUgMCA8IG51
bV92cXMgPA0KPiA2NTUzNi4NCj4gDQo+IFRoZSBjb2RlIG1peGVzIGludCwgdW5zaWduZWQgc2hv
cnQsIGFuZCB1bnNpZ25lZCBpbnQgdHlwZXMgaW4gYWRkaXRpb24NCj4gdG8gdXNpbmcgIiVkIiBm
b3IgYW4gdW5zaWduZWQgdmFsdWUuIFVzZSB1bnNpZ25lZCBzaG9ydCBhbmQgIiV1Ig0KPiBjb25z
aXN0ZW50bHkgdG8gc29sdmUgdGhlIGNvbXBpbGVyIHdhcm5pbmcuDQo+IA0KPiBDYzogU3V3YW4g
S2ltIDxzdXdhbi5raW0wMjdAZ21haWwuY29tPg0KPiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qg
cm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
b2Uta2J1aWxkLWFsbC8yMDIzMTIwNDE1MDkuREl5dkV0OWgtbGtwQGludGVsLmNvbS8NCj4gU2ln
bmVkLW9mZi1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPg0KPiAtLS0N
Cg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52
aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
