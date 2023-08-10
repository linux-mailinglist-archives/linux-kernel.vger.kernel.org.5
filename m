Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785AF7773A4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbjHJJEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbjHJJEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:04:21 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B58211F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:04:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7We5XNZBmv/6LfZmZeZ2N7CQ78UrxAopLI7a85YBkdGK5SBcqTuBLFUs3a9s+130Jf3HSZ9HlMxESFlJVmQZe9SsWD/G80YunsMawtvRINRgn8WLW5S+0uv2SXsXDXL+gd8OLS4WP1Qp4lRGxj/+a8DaqUx3J1sP9bf+WkJtouNx44qN2iLzMQtjt2JFa59Qy1CTfjn+VdwaCks+w+xSlsx3rETlgD3cn3J8xSxltvZwdPFeyRKlW6+bU7oWhlAVLYntU1/wq1hh2QHPp06cA5krPJjhDAVQuhl3QgOV8PA9z8ORt0fJ+IhxlENwN7NsuRzQFODiOs/1C4feHZiiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3FFrKAgaQ5pRfSm9Gr4mZBKZomK1XvWPnad2hN99Kk=;
 b=iTlg9A5pZK2CWfFl4RYR67nc495yTOtAgxoHA0sboL4YEH+PYdYdsS7SMpH0mwXOE8sph88pCZ/JvNQUAG+3TKbMO7ERcAQer9gtsagMvbSFWA+MkNn0oVWWbCh4vUvg4Fkp7woW4dITghEwrxxQVzYb1naeMonJV9rXAjQhMB4bjeVUI/q6Gb6/frfZ2QuxOaTjKi6blDFMFiPvZrsim8XV8UdX4+Cl+WZU2dLXIWPNjVMZoIXlH32Mwhw0+fQme59YqNBA7oYE0RBXrqVLQaY2xlu9M4JCyNU+DpD+WhecQ1tPAZkkxWXFJvtVdYR8eqdhm0HoFRUTs5pbR99Dpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3FFrKAgaQ5pRfSm9Gr4mZBKZomK1XvWPnad2hN99Kk=;
 b=GkP0VISZazUQxKLRV12RgMXbzW/Kmig7ZGL7Y/7UP+cnkMTYX7T+VADICeBoiDogrGi9X0d/8KL68CSVyCUEPlF4iSgbiXBlYR/Up6nAoAtSDCqwbpTETWmqfPjOqdZpR3bjuCu2EuQ/ipqIYROwVdXOfVNg0hQ1Ad0QZsqSLpNZTYqbFm51HW8s/ju2N7Ei7XyvCO+iw/sfwJN9XQa84k+asbe5buctwc3zyWC4i4NRvE9WZe4uuY2ujceEMLcIhmbbCCZ+jrL2dEjubJc2vQ3hgkpAA3wwGWWTbZduOTZcZkejExBhu4LSiPI1a+jZaH0BtV7e/Iln+0Q4/BiAmQ==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by LV8PR12MB9229.namprd12.prod.outlook.com (2603:10b6:408:191::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 09:04:18 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::40dc:9f89:895c:8667]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::40dc:9f89:895c:8667%4]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 09:04:18 +0000
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     "mst@redhat.com" <mst@redhat.com>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 0/2] vdpa/mlx5: Fixes for ASID handling
Thread-Topic: [PATCH 0/2] vdpa/mlx5: Fixes for ASID handling
Thread-Index: AQHZxWSSVrs/cfwr9kynpI0hGlVAJK/jRbaAgAACyYA=
Date:   Thu, 10 Aug 2023 09:04:18 +0000
Message-ID: <8b54ca6e948246f1a2bb327bc5cc2c8d8246da58.camel@nvidia.com>
References: <20230802171231.11001-1-dtatulea@nvidia.com>
         <20230810045328-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230810045328-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|LV8PR12MB9229:EE_
x-ms-office365-filtering-correlation-id: 73bf256b-f598-4fce-950b-08db9980c742
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hMaFG3vYR7bFF56z7pa0LnXUCWs++39e6+xpcRymEckJr5j7rzQVv8AkgbKgHfCQQjMuQxuhqD8n1AzCHl03+1buF7z3QvjOlQiq3c26Tpdho1pcajT+PRFGblqGVwMTI+lw3jvQMbmKYh4p+l1IPUYg5dCA565JF+/zcPH5AYJRCJaywvtKtq4UIHzp5tAy0f5sr/jL0T6y4Z03HW1yAHyTh43vSSNNi3X1Yf5NhzD0G82EidY7K3WAAwRbMHrDle1Z3zreZdF6sugu4tAFNUBuNTIZq2AraBBGqVxvrtcdoa/f7EeXyGK/yEVMCngp6aKERecmkIwqazkJvG/YoOMr+DJpALMUWkVmzguCi1db5pHlvuGgUCLZ4lmmUyUmeHRm6TimBYW8SIacKnWZdjEmfkbzF91SAZPss5kKbid9Q9iYCL39A16ysPVMJM6Nllzb0SNtCgbgQ2L9PECKNx/KgbsmBcpZPfvOKV0AwsYSGI51TIg7oUNnEpBz6pErD0A/kWYaAWOvIrzB4EUkrMu/9SqYxBsL80ccSgkFcFqXyR9ua2a2UM1zPCTAQ7TPBwWzMvNGIDQUBb8STq9FbKJqrEmqBVGBYzL9lhpx9WDWCb41MstDovNkjU5TRR1v6JBB2J5qHnJ7xWgqawIckQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(396003)(376002)(39860400002)(1800799006)(186006)(451199021)(54906003)(36756003)(71200400001)(478600001)(76116006)(91956017)(6916009)(66946007)(66476007)(66446008)(64756008)(66556008)(6506007)(6512007)(6486002)(4326008)(966005)(2906002)(316002)(41300700001)(122000001)(8936002)(5660300002)(8676002)(38100700002)(38070700005)(86362001)(83380400001)(2616005)(66574015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjVBUTJPM2lvcFF4QVR6WFZUYXczM0Q0akNMOW1ZeWVvOWRZOWxUUzlmMTBK?=
 =?utf-8?B?NmRzT2lQZnZJR2E5Y1lUOUZtc1FaNXNtdEhwcnpyamlQOGx0Y0Zsb0ZiN1BC?=
 =?utf-8?B?bTlWeDBORVpIRHRheTA1WWVDMk1pN3h5NDZiVzdUc1dWMGFLa0FPZzhUK3Uz?=
 =?utf-8?B?VEREaC9PNjJuRWUyclkxWnFHY0gxcEdpZVovK2M3L01pRnVGcGNHNnVRaFF2?=
 =?utf-8?B?ZkNUK243VVJoVTl4dlBGaVN1VmFqRnR5VHlzaFVMRDZaMTc5b0YzZ0x4R2hQ?=
 =?utf-8?B?UjNTUzhvc25pV2Qwbmx4SDFQTUZWVWU0WlBTbkVEaHB4U0s4Z1lxeWhlUGVJ?=
 =?utf-8?B?eWxWcUc0emE4SkVrYUNkV2hEYm0yQm9qc3dmTkcrdk44OXg2T2RsaE1uUVFM?=
 =?utf-8?B?eFhsUG1ZbThGMmVFZFo0YWpWRDA1UDkrTHloQlRZY0tSQjd4QVVSL1pZd3JF?=
 =?utf-8?B?WUE5OGZkNUVhcWk5UElkdllYNGx0aXlOaGVMcTVtVmNCODVqeExqNm1KVzh3?=
 =?utf-8?B?MHMxQzNpaWlhVlRxMUloQXhReEJNNGovRHlhSzRGWncvMURMNEtYUGlTRHVv?=
 =?utf-8?B?ei9oRTFOSEdpWmFiRzlRemRRSEwxeUdxQnJrUWhadDhoQWNtNEhjZlhpamcx?=
 =?utf-8?B?aUhNUzAwZldRME9MNHlPblRFMEVrV3M2alo4KzdXMmROK29WUWNLQ0dtc0tL?=
 =?utf-8?B?cHZjd3dxTWVhTFBiWUFtTmZkZnNqVmx6OVBHbWk0My9PSVhQd3QvN1lJVjAz?=
 =?utf-8?B?OXNEbmJadzRaNU9LQVFneUowS0ZsSnRPb2ZSUlNVSExyK252T04zNDZjSGd3?=
 =?utf-8?B?L0pkNWNwdjdjbncvVjNlMHZnS0c5QldRU1B3NzIzOTVGNDc4ZTNMZXMvZksz?=
 =?utf-8?B?cWYzR2pHeG1XS3lCcVBTand3ZkphZ0NsblRHcG53YXhGeWY5cDNsWW5nTE1J?=
 =?utf-8?B?T1pVZUJtWGxwRUFwSVpCVnNsN0pvRGxtZHRSTWR2Y3NUSnhhbzVtNndTbkdw?=
 =?utf-8?B?dnQyWmFkQWpNemVxeWhWMExqQzI1U0lGcXlKamEzWVhIQXNLbmY2SGRmV3hR?=
 =?utf-8?B?emtFMS9RdkZIdVdkSCtWc3NGTi9RNDFidGliekNZakExWXVOUFFPbWY4WTBX?=
 =?utf-8?B?S2d4SGJ0YUtLR3M1NFlPdW5JTngvQnNKKzRwNkkwMU16MXFidWx6L3AvMmxj?=
 =?utf-8?B?OVJpOEloSGcwdTVyekJ6eUVDNjZ6cnd4TVc5bTc1QkJ4dk9EbVlKajlZS2l0?=
 =?utf-8?B?UVE0bzZ1cXZIdjN6SHlMQllJV0JpTHNKUjA3ZE5zYSszQkdQNlhuU20vMjZs?=
 =?utf-8?B?YjUzazBRYjVDeHZ5U0M5ZlZiT3IxMVV4T1U4cGNuWk1VNHYyRnY0M0Z2THNr?=
 =?utf-8?B?dVI2T2dBTUQ0dEZUdDNSMUZhdnZkMUwwbVpDUUxLTkFRVnVrKzZyUGVDbVFQ?=
 =?utf-8?B?YWdBRyt5eVVTZ1BVQXp6YUhNVkN2MWxyRXJaQ0xyMHp3TER6V3ExM3RNaGlN?=
 =?utf-8?B?SWgwdjkzbHFIWHoybVZSeFFVRzVrV1piYk16bnB4aW05MVc5RVlKYzdZQ0hE?=
 =?utf-8?B?UmZCWWY2bHlDdTJTZERTbDgrNVdHS3hwNmZyRy9tTGk3VUVubm8zQmRYcXBR?=
 =?utf-8?B?bllQczMvbzdLeEgwZW5CTC9wMDlWNjJ1Tk5CNzY4M1BPQytmR0drSU42dUlz?=
 =?utf-8?B?ZWRtVEFoVjAydEgwUHJESG5PWEJ2WnF0d1FaUmhUeHRKSHhxVmtKVGpkRzh0?=
 =?utf-8?B?cHp0VkI0ODl5cjdKajlnZTNSMURzRkhSdlZqSFhJWStYdmFGZjdLMjh3dGR6?=
 =?utf-8?B?T3V4bGxVMGYvR0F4eXZUbU5MSXVBS3cwV1daeEhhS1pxdklPcUpuYStvTDhz?=
 =?utf-8?B?dE9GVmJWWFJFWW9SOFZic3crYXFRZGdMcEpoYVZZUE1RbS9aTC9HcE9PTmxO?=
 =?utf-8?B?Zm1Zdk8rRlRxMkZFREo4R0xnK3FJYkMvRW0wSnVCV2k2bU5WS1c4eUd0MnNX?=
 =?utf-8?B?QzZQcDRLZmtJeERIa3BCQzlMWVJXRURsTDdqREFLbFM4MzVHSFVkR0FmSEVJ?=
 =?utf-8?B?VVo0R1BXeURVaWp4M2o0dGVza3lrcUlnaDRDS2NwWHlyMC8yOFRIYWt1M0tl?=
 =?utf-8?B?bEZpWm12VW9vcDcyNjlxTzBJODdZelVrQm1MMmQ1ekpRVkRJNkxZWTdBN1M2?=
 =?utf-8?Q?NuzvtRZ2vjibhpitqnf+8kGfaQ+r5NBW1W8p4m0mGo8M?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C31D25E8519F74CAA76CB20DF61D89E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73bf256b-f598-4fce-950b-08db9980c742
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 09:04:18.0532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T3LdhQJUti8LXjDxs8rOqOFqqrRdAPKkU+GTlAlOWCUwWFpyfpFE7P262xZ5wwO7jkNhhiOiWvxztaVyHomtAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9229
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA4LTEwIGF0IDA0OjU0IC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3Jv
dGU6DQo+IE9uIFdlZCwgQXVnIDAyLCAyMDIzIGF0IDA4OjEyOjE2UE0gKzAzMDAsIERyYWdvcyBU
YXR1bGVhIHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggc2VyaWVzIGlzIGJhc2VkIG9uIEV1Z2VuaW8n
cyBmaXggZm9yIGhhbmRsaW5nIENWUXMgaW4NCj4gPiBhIGRpZmZlcmVudCBBU0lEIFswXS4NCj4g
PiANCj4gPiBUaGUgZmlyc3QgcGF0Y2ggaXMgdGhlIGFjdHVhbCBmaXguDQo+ID4gDQo+ID4gVGhl
IG5leHQgMiBwYXRjaGVzIGFyZSBmaXhpbmcgYSBwb3NzaWJsZSBpc3N1ZSB0aGF0IEkgZm91bmQg
d2hpbGUNCj4gPiBpbXBsZW1lbnRpbmcgcGF0Y2ggMS4gVGhlIHBhdGNoZXMgYXJlIG9yZGVyZWQg
bGlrZSB0aGlzIGZvciBjbGFyaXR5Lg0KPiA+IA0KPiA+IFswXQ0KPiA+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xrbWwvMjAyMzAxMTIxNDIyMTguNzI1NjIyLTEtZXBlcmV6bWFAcmVkaGF0LmNv
bS8NCj4gDQo+IA0KPiBTbyB3aGF0IGFyZSB3ZSBkb2luZyB3aXRoIHRoaXMgcGF0Y2hzZXQ/IElm
IHdlIGFyZSBtZXJnaW5nIGFueXRoaW5nDQo+IGZvciB0aGlzIHJlbGVhc2UgaXQgaGFzIHRvIGhh
cHBlbiBub3cuDQo+IA0KSmFzb24gbWVudGlvbmVkIHRoYXQgd2FudGVkIGFuIGFkZGl0aW9uYWwg
Y2xlYW51cCBwYXRjaCB0byBtb3ZlIHRoZSBjdnEgc3BlY2lmaWMNCmNvZGUgdG8gdGhlIG5ldCBw
YXJ0IG9mIG1seDVfdmRwYS4gVGhhdCdzIHF1aXRlIGEgcmVmYWN0b3JpbmcgdGhvdWdoIGFuZCB3
b3VsZA0KbGlrZSB0byB0YWtlIG15IHRpbWUgdG8gZG8gYW4gUkZDIGZvciB0aGF0IGZpcnN0Lg0K
DQpJdCB3b3VsZCBiZSBnb29kIGlmIHRoaXMgZ290IG1lcmdlZCBub3cgYXMgaXQgZml4ZXMgYW4g
YWN0dWFsIHByb2JsZW0gLi4uDQoNCj4gPiBEcmFnb3MgVGF0dWxlYSAoMSk6DQo+ID4gwqAgdmRw
YS9tbHg1OiBGaXggbXItPmluaXRpYWxpemVkIHNlbWFudGljcw0KPiA+IA0KPiA+IEV1Z2VuaW8g
UMOpcmV6ICgxKToNCj4gPiDCoCB2ZHBhL21seDU6IERlbGV0ZSBjb250cm9sIHZxIGlvdGxiIGlu
IGRlc3Ryb3lfbXIgb25seSB3aGVuIG5lY2Vzc2FyeQ0KPiA+IA0KPiA+IMKgZHJpdmVycy92ZHBh
L21seDUvY29yZS9tbHg1X3ZkcGEuaCB8wqAgMiArDQo+ID4gwqBkcml2ZXJzL3ZkcGEvbWx4NS9j
b3JlL21yLmPCoMKgwqDCoMKgwqDCoCB8IDk3ICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
LQ0KPiA+IMKgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jwqAgfMKgIDQgKy0NCj4g
PiDCoDMgZmlsZXMgY2hhbmdlZCwgNzQgaW5zZXJ0aW9ucygrKSwgMjkgZGVsZXRpb25zKC0pDQo+
ID4gDQo+ID4gLS0gDQo+ID4gMi40MS4wDQo+IA0KDQo=
