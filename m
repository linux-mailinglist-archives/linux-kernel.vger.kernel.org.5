Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58ED1768DF5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 09:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjGaHTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 03:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjGaHRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:17:53 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on20619.outbound.protection.outlook.com [IPv6:2a01:111:f400:7ea9::619])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A304EE6;
        Mon, 31 Jul 2023 00:16:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RYN3RQSmgfr+bj7xwCn/nBxiOVKxo7PkUoo5EonAFYA1nzLe1j1IZDvu51xFxOXCZxH3tXKBQ9f4AogJnqWgTgReNsIOD7NlJzb2cx9NiJSgACqWtXeWax9hLQfGYnBmtPIc/jbUj46eCS8gHUAkutsemckzF3QgjuZ7uVFSGPod666fFnE2yxF3tbP85rv0Hw9vV4XCfkJn/llD1RF4yB37CF/GIhzSCRaW3p8vqOg+C1aWwHi3kqWYA+KyFRaE7btB5FRttIdbUPq6X9lJuo1BQmLr24oybI9y6ikh96HOgS0hneSjvNlUNGg8f2P2sAHz1zl5j1NDS8wrWhNrkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvTqG4ubeHJCxR10EHUX2HN6/OEgnKcAJH0sXpMleIU=;
 b=LHumprmHcg/1nqmrqL7V7B/iuPmtGa89Bk4QhhdBQX+lFYaIPzWDRQ+LYLW3Po7uHUbHOBIVQINILFW0OHfzqM4/xpv69RorIsbBaQIz4M3COBBEvsyRagpcsBSmTJeWUtgLTwhh3xFnRtt6eQdSl4Z9U9RKMGTktcAjvSPYthkdL2zRWSyhswgrOhd8PGxn1HrquYOVdpScYCyGJJEkwWGdorQ+ZDnSenEZ9BrcFeNk5nFjki8j/VWBTurZsQkL5pVwKnPaTqYjcb9x48Myng3a/6w0x4QYRV8XpuCIg2zo82EnAgXNR0KJL1RFimfN/RCkmLm9X/ZLZl08E4FoBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvTqG4ubeHJCxR10EHUX2HN6/OEgnKcAJH0sXpMleIU=;
 b=aRtXqe9cVuVa/WH96LekgL27MWFNdLo63e71j+5UVkRsfJd+MGEADQu/64EIF6dQWG9U158kVSnPmEREc2+9hXrlGsMUw4+3bDuYKP9pesu1NLkqK9QcLFGDLWA/Lwj+jVmvJJfu6c+2sKhCrSafP+SK4DF4WyWXK+Dth1cN3YoIK5q7E9aYSdGwvUMaK4PLjisKcuR4wuMqROVuo4Msj/KT5A8gmVREJx17zeKAyrIcDs4ybH/d3Ccq3n7Og5ihOjFZtpG2l/mjnMn7w1hQYwMiB1GAb08Cwy9fUQr+yzlW/n9+e1/iI8am/Ww5lnhcwkP1qH8IjQTf/+q9cjYPZw==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by PH7PR12MB7260.namprd12.prod.outlook.com (2603:10b6:510:208::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 07:15:31 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::40dc:9f89:895c:8667]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::40dc:9f89:895c:8667%4]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 07:15:31 +0000
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     "mst@redhat.com" <mst@redhat.com>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] vdpa/mlx5: Fix crash on shutdown for when no ndev exists
Thread-Topic: [PATCH] vdpa/mlx5: Fix crash on shutdown for when no ndev exists
Thread-Index: AQHZv/SESZp4mdZfpESAhZmcsTYGMq/Mbh0AgAFZZYCAAAdcgIAFrswA
Date:   Mon, 31 Jul 2023 07:15:31 +0000
Message-ID: <b97484f15824c86f5cee4fe673794f17419bcb1b.camel@nvidia.com>
References: <20230726190744.14143-1-dtatulea@nvidia.com>
         <20230726152258-mutt-send-email-mst@kernel.org>
         <3ae9e8919a9316d06d7bb507698c820ac6194f45.camel@nvidia.com>
         <20230727122633-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230727122633-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|PH7PR12MB7260:EE_
x-ms-office365-filtering-correlation-id: 2603ea85-355a-42e5-3854-08db9195ecc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bCc/DymmRTBivqfb7SJV7nod/XGfmHKfD29DhGCGDN0veHlAnzACB/BKj06msUE2N0f1Fm5NOfWNPcnmc6Kqsf3jffWqJwgVGQo8Ky/PRTEO2NcGiOk6FyjmqKFFYohud7kO1vHrxJCPA6VbMyFUN8ZcF74hOZoy9Ihz/b/XkSLiCfJm0ny5Qastzezm4bBb7qEZTKO4tP+p/pFUqodfGXPplE9DgMEgOltcY2M4jYrGgaxHo6WMJV2//d7OHKA40iwMPaKP71E1hXnow3eZ8Avhi7ICGifONZlj3qYNTUSv1Gg4Ee/LAfkAIYvEY4claP4/+Q0un+QWyTau3YjVVNRYyqQIUHULZQMITWsrxQ/DGUPTliCTpMDoeVUuyroEWol+rlstB+yW2NhAyAbpGF3rHwZsGXMYWGaVknnHJ0KroX9eTgH9rYnU6YCxiFeKwQtqPTqihOYsgMZB450mHpiFimceDf5WbwkMEDYgeU6tm2kjSOYCyCwxXqT7bVtiwQoUEqIei3s3zXlTxqyXUmmBdppKWE0WAaRjoQMDYY9DzuOh86VCFfAbZZ49hC6ascy01jHB6fuPV5xisL+9gwOCjPhQL50M64l3VcSUrLso01vUfh42VHcCYG9HdgLCmyfyxhezyZ7+4EIDllVz8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199021)(38100700002)(122000001)(86362001)(38070700005)(36756003)(6512007)(966005)(478600001)(71200400001)(6486002)(2616005)(186003)(6506007)(8676002)(8936002)(5660300002)(76116006)(91956017)(4326008)(6916009)(64756008)(66446008)(2906002)(66476007)(66556008)(66946007)(54906003)(41300700001)(316002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTA2S3hWUG5kdHhTWXE2bUxJc1NUU1Q2dzUzWHE3dC9pVVlobDdVWVlySXk1?=
 =?utf-8?B?YUVBa08xR3BJT1ZrQUxtWmxHMkNob3YrQzhNN1RxeitjcXJmZzc2NHIwQXZC?=
 =?utf-8?B?Zlc5M0o3Si8xT2kvYTJzcXBxRTdvYTQ5Z3hvREc3blJMTTlTeW9QcUduK0Va?=
 =?utf-8?B?SzFqeGc5M25zM2RxR1NGVm9OMjQ1WE81Zmx0eWZ0RFpTaU14Qk5HN0JWMS9U?=
 =?utf-8?B?OWw0NDBybFNySTEvWExCcWppVjNKZXpMR3B6YTFveHhjT0pWcHAwQ3psQlBH?=
 =?utf-8?B?eVNRRnU0aXFZK2YyNTZDMHpMd0ZFTU5pa3J0TU5QRTYya2JQTUtWZEtpWVdU?=
 =?utf-8?B?TnJKQUZpMVdEc2tSZE9TLzhuSVNKOE5iVVJoV3U3QzFvQS81UGk1djdEeTZq?=
 =?utf-8?B?N1ZMVnFlcGJ1VUdpaysxWXpNaEoyV3c1ODcvSThrWkFaSVoxQ0JlVkZCV0dm?=
 =?utf-8?B?dS8zNktrbnhJY0VHdVN2QkRuWUw3dUlFU3ZqMndLN0FPTFpGUFJTMnFsTXJa?=
 =?utf-8?B?b2RnU0ZtazhYWWR3a1lickg5bmVIWE1PdWsyUitjMzY2dlRiQ0tlRkhCdmd1?=
 =?utf-8?B?WlZIc3NKZ1ptRHVrZUwxUHg5bWt3ZnY1bU9UNVk0TEdHajVQMWFCeGo3bWxR?=
 =?utf-8?B?MFIyaHdZUEpaNmJLSGQrVS84eXN6Q0VRc2toMlNDUUpGeEpkSUlVNUsvUHEr?=
 =?utf-8?B?Smg2Kzl3Rk1UWG1Nc21kMmJsblV2RkdVcS9JZ2g0RWJZdWU3eEhNMG1wRjUr?=
 =?utf-8?B?Q2pPOGFRZWQ5eGhIQVdiTGZ4YTVFRDFLOE9TdHNlUllSTEd2MGorc0QrQXBS?=
 =?utf-8?B?VStWNWZCZ3pVUjNsL3lsOGc4MCtsUXFNcktZZGpUMWJFazNBNkFIMEV6VUtQ?=
 =?utf-8?B?YXdLSFVpSFRnTnRiLzFTR3ZHTFNrWlNENDBLZjNGRnpCUmZUK3AxaHhodjYy?=
 =?utf-8?B?am1wa1lManRLMmpUSjZQMUFsZGVYZ2dFcDl1Z0lIbmMrVGxSTVpTR0w5SEl6?=
 =?utf-8?B?NWlOTDdvNnlHK29Ya256ZVo0UU9MdkpTZVQySHowNDM5M01aQ1EyVWppVlhV?=
 =?utf-8?B?cG5DY0ZBZkNXeTVsWHcrb0cvZUFOYm8wSHJWRUdqc1Z0dkRRbktnd05nclRV?=
 =?utf-8?B?SG00ZmhENlNvaVFOVTNUN0VSLzdIWko2MkZhS2g3VFZXTzB5dlhGbURlUGdt?=
 =?utf-8?B?VHhDWTd6Wk9GZjVZNkNlUXFHNzVnVlhJenRNOHVoMmtwQUZuWUlqbHpaeERE?=
 =?utf-8?B?bE5PSGtTT3owU3Z6a3VYMlQ3VGFCUzVMV1dna0dJNTl2T3d2cU5UMXgyYXZU?=
 =?utf-8?B?cmRkd05DM3VMQ0hBNVA1cEpMdlFwb3V6Uld6NVhKU0dab1FIdldPV2ozWXoy?=
 =?utf-8?B?ZktwbVNhVGhFMnowKzNpdnBubFJCcU92Q01nOEh6eHo2S0NzRDlIVlZhWkV4?=
 =?utf-8?B?WUNzVmROblFwWjdmLzlvQWs1dE5FUmh6MWxoTlBNVnoxcnNobjhtZFlBdlp1?=
 =?utf-8?B?TnlvWlBvVnBKOVdZV1VBVkEzREdUOXAyUERYcmlvRHZJVERmUHAxTVg5MWt6?=
 =?utf-8?B?Mlo0VHZOQ0JyRzZmQU5UZjIvRitxVjc1RkE3ckZxaUJaWjNBR0YyeGx0bk5z?=
 =?utf-8?B?aEJpSXdpVmJIaEI5TTFwckw5UnpjSHhXT1NxMS85WHhsU1F0eGRNZ0wxUm5w?=
 =?utf-8?B?QVZ6SEdWNE4vVHJMekZCbWRQRG9PTVIxYkxVRm9ac2sxTVNvbDNjRUJkSnNQ?=
 =?utf-8?B?UnpubWpHZTNGQW1FRDNxUVVucDhTUHBhdnI0aGpyVlJkTEhmQ0xiVHRaTWFV?=
 =?utf-8?B?NUY0VGhGVy95aFptYlF3d0FUTmsrcGxsbnFZSUJZdVRibkRUdGNrN3ZZcUhB?=
 =?utf-8?B?cnZqRjczNVk1NWdCN3AzdjFZNWxpMGVlZTF4dy85alRDNWhFRnB2ZTlwSzVt?=
 =?utf-8?B?c1N2R0hRWmZKNlB4aU1oT1BTS3hYNUxJUi9QOHBtQ1ZaNTVuR0tSSlA3dnFM?=
 =?utf-8?B?NlVsSDhET3U1N0Z3QXVvWExLWVBCeXBMemw5MUdpWVlnZlpSMTJGMXp3QVdZ?=
 =?utf-8?B?VXQ2NFdMK3lURjl6SXcxaXFqZW11OXVEeXRNSE1qR1NTQjJQRk9KWEF5Q2xi?=
 =?utf-8?B?WFBoWE1kT1FjQjJZcHZOd1ZFcERLMkNXUzdTMTZMVXFMbEQ1VXR5SmxTQXVC?=
 =?utf-8?Q?5acmnTjR4rau2iif9+EC6pwTH20ECo6SbQy6eAHb8Zc1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4C7C109D34629438C3BC8111522DBAF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2603ea85-355a-42e5-3854-08db9195ecc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 07:15:31.0806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 75Sq2GLdFjMBVfC5JnNAvRGlPIs9P+U07QlM/4ZkVtnAa6BwdyArzI3aMaCp9XOCGfYEKmMWUdLfgatx0LrTlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7260
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA3LTI3IGF0IDEyOjI4IC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3Jv
dGU6DQo+IE9uIFRodSwgSnVsIDI3LCAyMDIzIGF0IDA0OjAyOjE2UE0gKzAwMDAsIERyYWdvcyBU
YXR1bGVhIHdyb3RlOg0KPiA+IE9uIFdlZCwgMjAyMy0wNy0yNiBhdCAxNToyNiAtMDQwMCwgTWlj
aGFlbCBTLiBUc2lya2luIHdyb3RlOg0KPiA+ID4gT24gV2VkLCBKdWwgMjYsIDIwMjMgYXQgMTA6
MDc6MzhQTSArMDMwMCwgRHJhZ29zIFRhdHVsZWEgd3JvdGU6DQo+ID4gPiA+IFRoZSBuZGV2IHdh
cyBhY2Nlc3NlZCBvbiBzaHV0ZG93biB3aXRob3V0IGEgY2hlY2sgaWYgaXQgYWN0dWFsbHkgZXhp
c3RzLg0KPiA+ID4gPiBUaGlzIHRyaWdnZXJlZCB0aGUgY3Jhc2ggcGFzdGVkIGJlbG93LiBUaGlz
IHBhdGNoIHNpbXBseSBhZGRzIGEgY2hlY2sNCj4gPiA+ID4gYmVmb3JlIHVzaW5nIG5kZXYuDQo+
ID4gPiA+IA0KPiA+ID4gPiDCoEJVRzoga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSwg
YWRkcmVzczogMDAwMDAwMDAwMDAwMDMwMA0KPiA+ID4gPiDCoCNQRjogc3VwZXJ2aXNvciByZWFk
IGFjY2VzcyBpbiBrZXJuZWwgbW9kZQ0KPiA+ID4gPiDCoCNQRjogZXJyb3JfY29kZSgweDAwMDAp
IC0gbm90LXByZXNlbnQgcGFnZQ0KPiA+ID4gPiDCoFBHRCAwIFA0RCAwDQo+ID4gPiA+IMKgT29w
czogMDAwMCBbIzFdIFNNUA0KPiA+ID4gPiDCoENQVTogMCBQSUQ6IDEgQ29tbTogc3lzdGVtZC1z
aHV0ZG93IE5vdCB0YWludGVkIDYuNS4wLQ0KPiA+ID4gPiByYzJfZm9yX3Vwc3RyZWFtX21pbl9k
ZWJ1Z18yMDIzXzA3XzE3XzE1XzA1ICMxDQo+ID4gPiA+IMKgSGFyZHdhcmUgbmFtZTogUUVNVSBT
dGFuZGFyZCBQQyAoUTM1ICsgSUNIOSwgMjAwOSksIEJJT1MgcmVsLTEuMTMuMC0wLQ0KPiA+ID4g
PiBnZjIxYjVhNGFlYjAyLXByZWJ1aWx0LnFlbXUub3JnIDA0LzAxLzIwMTQNCj4gPiA+ID4gwqBS
SVA6IDAwMTA6bWx4NXZfc2h1dGRvd24rMHhlLzB4NTAgW21seDVfdmRwYV0NCj4gPiA+ID4gwqBS
U1A6IDAwMTg6ZmZmZjg4ODEwMDNiZmRjMCBFRkxBR1M6IDAwMDEwMjg2DQo+ID4gPiA+IMKgUkFY
OiBmZmZmODg4MTAzYmVmYmEwIFJCWDogZmZmZjg4ODEwOWQyODAwOCBSQ1g6IDAwMDAwMDAwMDAw
MDAwMTcNCj4gPiA+ID4gwqBSRFg6IDAwMDAwMDAwMDAwMDAwMDEgUlNJOiAwMDAwMDAwMDAwMDAw
MjEyIFJESTogZmZmZjg4ODEwOWQyODAwMA0KPiA+ID4gPiDCoFJCUDogMDAwMDAwMDAwMDAwMDAw
MCBSMDg6IDAwMDAwMDBkM2EzYTM4ODIgUjA5OiAwMDAwMDAwMDAwMDAwMDAxDQo+ID4gPiA+IMKg
UjEwOiAwMDAwMDAwMDAwMDAwMDAwIFIxMTogMDAwMDAwMDAwMDAwMDAwMCBSMTI6IGZmZmY4ODgx
MDlkMjgwMDANCj4gPiA+ID4gwqBSMTM6IGZmZmY4ODgxMDlkMjgwODAgUjE0OiAwMDAwMDAwMGZl
ZTFkZWFkIFIxNTogMDAwMDAwMDAwMDAwMDAwMA0KPiA+ID4gPiDCoEZTOsKgIDAwMDA3ZjQ5Njll
MGJlNDAoMDAwMCkgR1M6ZmZmZjg4ODUyYzgwMDAwMCgwMDAwKQ0KPiA+ID4gPiBrbmxHUzowMDAw
MDAwMDAwMDAwMDAwDQo+ID4gPiA+IMKgQ1M6wqAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6
IDAwMDAwMDAwODAwNTAwMzMNCj4gPiA+ID4gwqBDUjI6IDAwMDAwMDAwMDAwMDAzMDAgQ1IzOiAw
MDAwMDAwMTA1MWNkMDA2IENSNDogMDAwMDAwMDAwMDM3MGViMA0KPiA+ID4gPiDCoERSMDogMDAw
MDAwMDAwMDAwMDAwMCBEUjE6IDAwMDAwMDAwMDAwMDAwMDAgRFIyOiAwMDAwMDAwMDAwMDAwMDAw
DQo+ID4gPiA+IMKgRFIzOiAwMDAwMDAwMDAwMDAwMDAwIERSNjogMDAwMDAwMDBmZmZlMGZmMCBE
Ujc6IDAwMDAwMDAwMDAwMDA0MDANCj4gPiA+ID4gwqBDYWxsIFRyYWNlOg0KPiA+ID4gPiDCoCA8
VEFTSz4NCj4gPiA+ID4gwqAgPyBfX2RpZSsweDIwLzB4NjANCj4gPiA+ID4gwqAgPyBwYWdlX2Zh
dWx0X29vcHMrMHgxNGMvMHgzYzANCj4gPiA+ID4gwqAgPyBleGNfcGFnZV9mYXVsdCsweDc1LzB4
MTQwDQo+ID4gPiA+IMKgID8gYXNtX2V4Y19wYWdlX2ZhdWx0KzB4MjIvMHgzMA0KPiA+ID4gPiDC
oCA/IG1seDV2X3NodXRkb3duKzB4ZS8weDUwIFttbHg1X3ZkcGFdDQo+ID4gPiA+IMKgIGRldmlj
ZV9zaHV0ZG93bisweDEzZS8weDFlMA0KPiA+ID4gPiDCoCBrZXJuZWxfcmVzdGFydCsweDM2LzB4
OTANCj4gPiA+ID4gwqAgX19kb19zeXNfcmVib290KzB4MTQxLzB4MjEwDQo+ID4gPiA+IMKgID8g
dmZzX3dyaXRldisweGNkLzB4MTQwDQo+ID4gPiA+IMKgID8gaGFuZGxlX21tX2ZhdWx0KzB4MTYx
LzB4MjYwDQo+ID4gPiA+IMKgID8gZG9fd3JpdGV2KzB4NmIvMHgxMTANCj4gPiA+ID4gwqAgZG9f
c3lzY2FsbF82NCsweDNkLzB4OTANCj4gPiA+ID4gwqAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9o
d2ZyYW1lKzB4NDYvMHhiMA0KPiA+ID4gPiDCoFJJUDogMDAzMzoweDdmNDk2OTkwZmI1Ng0KPiA+
ID4gPiDCoFJTUDogMDAyYjowMDAwN2ZmZmM3YmRkZTg4IEVGTEFHUzogMDAwMDAyMDYgT1JJR19S
QVg6IDAwMDAwMDAwMDAwMDAwYTkNCj4gPiA+ID4gwqBSQVg6IGZmZmZmZmZmZmZmZmZmZGEgUkJY
OiAwMDAwMDAwMDAwMDAwMDAwIFJDWDogMDAwMDdmNDk2OTkwZmI1Ng0KPiA+ID4gPiDCoFJEWDog
MDAwMDAwMDAwMTIzNDU2NyBSU0k6IDAwMDAwMDAwMjgxMjE5NjkgUkRJOiBmZmZmZmZmZmZlZTFk
ZWFkDQo+ID4gPiA+IMKgUkJQOiAwMDAwN2ZmZmM3YmRlMWQwIFIwODogMDAwMDAwMDAwMDAwMDAw
MCBSMDk6IDAwMDAwMDAwMDAwMDAwMDANCj4gPiA+ID4gwqBSMTA6IDAwMDAwMDAwMDAwMDAwMDAg
UjExOiAwMDAwMDAwMDAwMDAwMjA2IFIxMjogMDAwMDAwMDAwMDAwMDAwMA0KPiA+ID4gPiDCoFIx
MzogMDAwMDdmZmZjN2JkZGYxMCBSMTQ6IDAwMDAwMDAwMDAwMDAwMDAgUjE1OiAwMDAwN2ZmZmM3
YmRlMmI4DQo+ID4gPiA+IMKgIDwvVEFTSz4NCj4gPiA+ID4gwqBDUjI6IDAwMDAwMDAwMDAwMDAz
MDANCj4gPiA+ID4gwqAtLS1bIGVuZCB0cmFjZSAwMDAwMDAwMDAwMDAwMDAwIF0tLS0NCj4gPiA+
ID4gDQo+ID4gPiA+IEZpeGVzOiBiYzlhMmIzZTY4NmUgKCJ2ZHBhL21seDU6IFN1cHBvcnQgaW50
ZXJydXB0IGJ5cGFzc2luZyIpDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IERyYWdvcyBUYXR1bGVh
IDxkdGF0dWxlYUBudmlkaWEuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gwqBkcml2ZXJzL3Zk
cGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCAzICsrLQ0KPiA+ID4gPiDCoDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+ID4gDQo+ID4gPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMNCj4gPiA+ID4gYi9kcml2
ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMNCj4gPiA+ID4gaW5kZXggOTEzOGVmMmZiMmM4
Li5lMmU3ZWJkNzE3OTggMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25l
dC9tbHg1X3ZuZXQuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92
bmV0LmMNCj4gPiA+ID4gQEAgLTM1NTYsNyArMzU1Niw4IEBAIHN0YXRpYyB2b2lkIG1seDV2X3No
dXRkb3duKHN0cnVjdCBhdXhpbGlhcnlfZGV2aWNlDQo+ID4gPiA+ICphdXhkZXYpDQo+ID4gPiA+
IMKgwqDCoMKgwqDCoMKgwqBtZ3RkZXYgPSBhdXhpbGlhcnlfZ2V0X2RydmRhdGEoYXV4ZGV2KTsN
Cj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoG5kZXYgPSBtZ3RkZXYtPm5kZXY7DQo+ID4gPiA+IMKg
DQo+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoGZyZWVfaXJxcyhuZGV2KTsNCj4gPiA+ID4gK8KgwqDC
oMKgwqDCoMKgaWYgKG5kZXYpDQo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBmcmVlX2lycXMobmRldik7DQo+ID4gPiA+IMKgfQ0KPiA+ID4gPiDCoA0KPiA+ID4gDQo+ID4g
PiBzb21ldGhpbmcgSSBkb24ndCBnZXQ6DQo+ID4gPiBpcnFzIGFyZSBhbGxvY2F0ZWQgaW4gbWx4
NV92ZHBhX2Rldl9hZGQNCj4gPiA+IHdoeSBhcmUgdGhleSBub3QgZnJlZWQgaW4gbWx4NV92ZHBh
X2Rldl9kZWw/DQo+ID4gPiANCj4gPiBUaGF0IGlzIGEgZ29vZCBwb2ludC4gSSB3aWxsIHRyeSB0
byBmaW5kIG91dC4gSSBhbHNvIGRvbid0IGdldCB3aHkgZnJlZV9pcnENCj4gPiBpcw0KPiA+IGNh
bGxlZCBpbiB0aGUgdmRwYSBkZXYgLmZyZWUgb3AgaW5zdGVhZCBvZiBtbHg1X3ZkcGFfZGV2X2Rl
bC4gTWF5YmUgSSBjYW4NCj4gPiBjaGFuZ2UNCj4gPiB0aGF0IGluIGEgZGlmZmVyZW50IHJlZmFj
dG9yaW5nLg0KPiANCj4gYXMgaXQgaXMgSSBoYXZlIG5vIGlkZWEgd2hldGhlciBlLmcuIG5kZXYg
Y2FuIGNoYW5nZQ0KPiBiZXR3ZWVuIHRoZXNlIHR3byBjYWxsIHNpdGVzLiB0aGF0IHdvdWxkIG1h
a2UgdGhlIGNoZWNrDQo+IHBvaW50bGVzcy4NCj4gDQo+ID4gPiB0aGlzIGlzIHdoYXQncyBjcmVh
dGluZyBhbGwgdGhpcyBtZXNzLg0KPiA+ID4gDQo+ID4gPiANCj4gPiBOb3QgcXVpdGU6IG1seDVf
dmRwYV9kZXZfZGVsICh3aGljaCBpcyBhIC5kZXZfZGVsIG9mIGZvciBzdHJ1Y3QNCj4gPiB2ZHBh
X21nbXRkZXZfb3BzKSBkb2Vzbid0IGdldCBjYWxsZWQgb24gc2h1dGRvd24uIEF0IGxlYXN0IHRo
YXQncyB3aGF0IEkNCj4gPiBzZWUuIE9yDQo+ID4gYW0gSSBtaXNzaW5nIHNvbWV0aGluZz8NCj4g
DQo+IGFuZCB3aHkgZG8gd2UgY2FyZSB3aGV0aGVyIGlycXMgYXJlIGZyZWVkIG9uIHNodXRkb3du
Pw0KPiANCkhhZCB0byBhc2sgYXJvdW5kIGEgYml0IHRvIGZpbmQgb3V0IHRoZSBhbnN3ZXI6IHRo
ZXJlIGNhbiBiZSBpc3N1ZXMgd2l0aCBrZXhlYw0KSVJRIGFsbG9jYXRpb24gb24gc29tZSBwbGF0
Zm9ybXMuIEl0IGlzIGRvY3VtZW50ZWQgaGVyZSBbMF0gZm9yIG1seDVfY29yZS4NCg0KaHR0cHM6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXgu
Z2l0L3RyZWUvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL21haW4uYyNu
MjEyOQ0KDQpUaGFua3MsDQpEcmFnb3MNCg==
