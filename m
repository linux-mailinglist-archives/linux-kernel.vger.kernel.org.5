Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0E9808140
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 07:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjLGGyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 01:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjLGGx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 01:53:58 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5764510F0;
        Wed,  6 Dec 2023 22:54:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i087DXGu8reFzZK+3Dd4BZPdIOXcUst5pgZtxR/qMk5Qf+b1M9P0pDORmoGjs44xtwrAI4NvRM3fQ3mOzTzzM3mjw3kVKKeG5UFZQtOBuiN7HnzZgdjVDTjBZFLYiF3obzDtObuM3h99oZ0x1r91kxLGMJnS96zbbaxq/r0c4uHluVjbnjgDpk4GnRbSvd8FrUYa4X5mTm08i2+sODgEG/ojE1lBnqj1Cor4UjNDaJPh22B17qHpFMosh0dQH4vchJQpro+BPVOewD0vRkqSZ0LabYHzhW0uRppuwojHTbo3HNdmxl1VQJnsJlAjAKyDDhuVSy6N3NgI+nb5HYTXIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4uBzfCufjBmlAvJypxGrTzGc83IJBYRbTbC8zuYvb0=;
 b=imhs71+iXObC3SqICkX+fxoHbBFLKyRGzEeU5xqLi5F9QqA0BYowhfeDu3Oo2QQx+Y/1qQIx+XLDUbTWKrI9xtz30OE45WKnIwNHclBRFB3h6I7TbZYA02hzX4mEne48QB8QkUqzHjA1tq05/cvbhOqjwpWPrE7PonxPqPCNKpdqXSaNcbwVfABB7+h/Q/Hh9UVrKRd7n2PQLGGMFedpmLD0tq/8Zy+ZIEPqAFy3lyi3xjjQCIWA9h9PWVN5AfAiZAQUCJO2T8FrGSdM7BXoXl5v45b1swguFc9acNUMTmVyOoj8YR6Bs+6tyWKnyXM8jqH9fUWIjzqHwsc0UlI4Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4uBzfCufjBmlAvJypxGrTzGc83IJBYRbTbC8zuYvb0=;
 b=FQZ7eR26fGpIMq78fi2fVu3dtSTWeC3hzW5HM+yEuwNfJfAsfEVslSS05ccHz6yQf9xIt1FPYIgxIpbF3Cjm6nYjIfhfI0OohK1UMB3fV6fGEYE6wXcvcuQKtOY0VUW1bh594Z8jAbu/bBx0kh1TeLtO0/5jWpSlcfZH4Qbomik3JCJiRJv2Qj78ZD41O7gGHMPWsbl0Cueg8SzXzf7VHA8hX5KfeeHjAeNUXNruka88/8vWejbpxufIhKwtlYcveP40z8wOYatSF+8xe4qOLHCygjFGTlFGFp6avNhmgIIOOMJQcna8j1Pz3o+3r/A9wMi1U2+nyEPdy7ukXnt1bQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MN0PR12MB6271.namprd12.prod.outlook.com (2603:10b6:208:3c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 06:53:59 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762%7]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 06:53:59 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Li Feng <fengli@smartx.com>, Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO BLOCK AND SCSI DRIVERS" 
        <virtualization@lists.linux.dev>
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
Thread-Topic: [PATCH] virtio_blk: set the default scheduler to none
Thread-Index: AQHaKMZ7r4KRZS/zvEOlcT827vufd7CdYsAA
Date:   Thu, 7 Dec 2023 06:53:59 +0000
Message-ID: <9b963af6-0a3f-4957-9227-43673e70b720@nvidia.com>
References: <20231207043118.118158-1-fengli@smartx.com>
In-Reply-To: <20231207043118.118158-1-fengli@smartx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MN0PR12MB6271:EE_
x-ms-office365-filtering-correlation-id: b23f2703-82be-4029-5b62-08dbf6f149ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KbjZ1p5FsGd48u/84MGFQ+i9vx0OKaRzvc7joxNLKETMU17E3kESSXriryoins2X+GmK1DKypPbmuWNdRWd1o3StSNC77/HpfxXAegeQgHjH9871lFa09wfE09XW3RZc4ucFJbMSHAvyo/9CFf/bubbSH/MDdxXaQDyRmLC6rtRtGUvAu+3iVDZs4F6UPBtafLiM0T1uFi8GL+Rn7PS+CLzLsvxaDqOItXdyCY0MhhJiwD0m5cco3EjbMQS0SrcoWvCzyQW75IF/uV8zZ+abEc7qKq0SEmbpgWqhtowz7hXcHUXxYVLXjIDwVw+ZOqFSf9ofpnnZJ+jsa1kWQDCCVXObLv7Bszw/hjYQxSO6rM1bAqNoCBVPt00Z51KpjyajOywbN9n/dFgG/FlCEf/Lhe3gPCiD+kbCioTTmikeawYsYuUuu2z/OHpiS18baXbxnKP0bZ0NUB0QMGOk6FQK9japzYol8udlHTsPXAdAK/Mts4Ile+nDYKxKh1TzUPMbq6TzFMN6+gn8PdQXcMvQ8hLuoHwAnbeaBOqAFrvqRO/WrNLEZ1U16afITcq/TN53HNjjuJOXoE3lgbwCUDF1PCshBCAdhxSAs2ZVMr+5ucg2MkUHu4O9Wmny9sqSWV8QQGDcXMxki/avijR7WB9FW7drcXUvUg+5E3IVarig+g4C/1w5slLXx/men7V/ysemmFEfcvlNHX95tLD17K+n/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(136003)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(31686004)(122000001)(38100700002)(41300700001)(4744005)(7416002)(5660300002)(2906002)(36756003)(8676002)(921008)(316002)(38070700009)(110136005)(478600001)(71200400001)(53546011)(6512007)(6506007)(2616005)(76116006)(86362001)(31696002)(64756008)(66446008)(66476007)(66556008)(91956017)(66946007)(8936002)(83380400001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUFNWnRMRFRNVzBKZy9LUlMxREY5RUM2a3dteTd4Zis3dVp6K3dRS2g2SnAr?=
 =?utf-8?B?TWtjNFpGZitHT2psbW1iWjQzZFhjSmJua0laYWMvR21wUVZJMzBiMndzQ3VF?=
 =?utf-8?B?dGhXa05iUW0rR1JWOUx2VWo2MG95VUlsdEdrbEV5QkUvRTlXN0xlanNOQ0hX?=
 =?utf-8?B?bVBxdytJK1RKREtORUx6WWRLZ2x3enNVWnZKS05XYWRuZi9CMGFpTFpHUUVa?=
 =?utf-8?B?NE5zOTBMaDhMM080L21Gdk9CaWx4R2tISnM2dEpyVFl0cEN3Q1hsYlFvM2Fx?=
 =?utf-8?B?ZStjMFM0RjlzM2V1dzR4TFM5d2ZtUHkreTJhcURIQTkvSHE5VWlEQWZLK0ln?=
 =?utf-8?B?K1BLSGVpVEVKRVcxdmJZSXZVaTNxT2RvY3RkZ3FzWXlZL0FjWXZxenBwVkFq?=
 =?utf-8?B?QUNLVi9ZS2ZPYTk5M3ZjQ0tSVGI4b3lYbHhtOEo0cUlLRkhlMEtRTEoybUtl?=
 =?utf-8?B?VWltK3Q2cGdkL2xkMmpqNTJBTlBNS1I3emtIZUswYUFqWDRWeUw0emltd0Zq?=
 =?utf-8?B?S0MyUGtkQkxlTStBRjBuMllIcDhydWJWb3EzMnI1Z0JYSnY2VnlHV1RkRTVC?=
 =?utf-8?B?ZkhZc0EzNmZZTTlRTVRuU3lUWTJzdXR4Tjk2c1RTMzhoMXNDZTNweldUUWdN?=
 =?utf-8?B?RkNubjdOL2p2TGtieUUyMTEwVDFlK25VUlZ1dFFjMEdzQWQ3cVlxeHI0Y3Jy?=
 =?utf-8?B?SDNKRmxoQnByUHQxdFZjSGp3L3VQcXZyME9OK3dNMVZpS0hVenVZdXRuZ2hv?=
 =?utf-8?B?Vlo2cUxsWWxKSmJJMDZtWmlvSXdzV3puUmFobHZGVitZcldtalFDMjlWYlJB?=
 =?utf-8?B?SGM0a3B0TFBSUThNKzErWmRyRVAycDRFajFTSGQ5WGxVeUZ0dldvY3pqOUdB?=
 =?utf-8?B?aHpIaGsrdk9aYTVwcTM3ODFjSnJMazZCeHdTMW82S29UT1dlK2V6VnJCaE9N?=
 =?utf-8?B?M25VQ3ducnVwUzg2Q1krdXR4Z2R6OEZSQ0pCUkpHTXRiWTJrdzcyRDJ2L0ds?=
 =?utf-8?B?d1gzdlFYWGF6QVQ3YTd5SzBhZVNhSGRWSDRyMGtxNjZSMHh0TmFyNzkvRGxR?=
 =?utf-8?B?bzF1Unp6MHF4UGkrZVFlbER3Rmlmb1RRTWhBelFGRmpNcWRDK0p1UWNSR0Ri?=
 =?utf-8?B?RGVWRFVtdkMyM3h3WnZkeEM0UW82YnZoWVVKaDlYMU5qVjNYVUh0ajlLWnBh?=
 =?utf-8?B?dlR4VGhTUmlLYkxncW5TYkxJck4wRFU5czNkcjNRbHJObFdZQnhVSTZSNHpi?=
 =?utf-8?B?Kzl3QXZheGdPWnNtMjc1SDVjOHZTRXl1OFNWRndhNlIrdmhQN1l4Q21iamJp?=
 =?utf-8?B?YTUzUlM4M2t0UGpoenVBZzlxSTc3ZUN0VVFxS28vNDB2b2daNHRLTGhLQWd0?=
 =?utf-8?B?TGJQTGYrS21wM2h1RDk2UlZwUEFhMGV0c3paYm9sdnM5WUtwNU5LZFRVaXRh?=
 =?utf-8?B?cTNBL3VGOHduRFhjRnpUSDRuajd1ZHdNR1YrQi81SDM1TGo2RXFUTzR4U1Vh?=
 =?utf-8?B?Y2JWZk5pOXhERnJKNWhqdm9XT0ZVSmlIYzZUQjU0ZFpqTlpYR24xZUFBZXdx?=
 =?utf-8?B?dkhRb2gzZHQ3RWpjYThIN0pNQjA1S2pQN3M4YTFhTXplSmVPSk9BYWhhTHUy?=
 =?utf-8?B?U2VtVHF4UEUzWFhaMTRCZlpscGNHVHZUN01hQmd2dE5aeTk0RTlpRGJBRkV1?=
 =?utf-8?B?UGxLK1NOeTRDNFNqKzQ5ZW1nZjUzTTh4dUxiZGx1TU5PenQrV0crTWtZV2Fs?=
 =?utf-8?B?eXc1TXA5ZHpLUFMxcHJkUElET1BRT1NoSGNJb1dDZUk0Um5RYkwyRWxHc1J4?=
 =?utf-8?B?TFA4dGJuUG83d0s3OFMySTJ1MGNLV3pxdjM1eFhMNkQ4aDBlZnQ1TWc3aTBa?=
 =?utf-8?B?WGdzb1YveEdYaFVCQVB6eEt2dXhBREIrTEh5SlQ3RURhMjV6d3BLOGxyRlN5?=
 =?utf-8?B?YkxpTUFVWi84S3NxdTRSTDUwekdvZEVFVXRqMnIwVllsZzlndGxiYWhuSU1a?=
 =?utf-8?B?UEZaY1ByY295cUhCSkRNZDlqdkRyWmtnUWp4Vk4xMDRLZnAwcUFIUTVoc3dI?=
 =?utf-8?B?bWxEc0NYYnVFSlRobDg0bUQ1d1h2TFRyYUVnUmc2STdyZEg0bWd6VlBZM0tJ?=
 =?utf-8?B?RGZXcENpdDE0MklkNzJrM1ZGY2tuOWFCRHY3TXIrZEVqdkJUcDhyTFUwTGV4?=
 =?utf-8?Q?7wnbCIxgwclVj+O1yuLyl6CXSn14V7WllIxJ8uECYdI1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FC97F4C61169A4785C66D7F0E7852B0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b23f2703-82be-4029-5b62-08dbf6f149ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 06:53:59.0587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 21VLKYZ1qJ/9MspqI98cKIPJEH2a38CpPThm+cqz5V0BYGvimGZ7HUUjO9Z9/ihqkT7GoMa/5L1PvpyhbP1cAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6271
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvNi8yMyAyMDozMSwgTGkgRmVuZyB3cm90ZToNCj4gdmlydGlvLWJsayBpcyBnZW5lcmFs
bHkgdXNlZCBpbiBjbG91ZCBjb21wdXRpbmcgc2NlbmFyaW9zLCB3aGVyZSB0aGUNCj4gcGVyZm9y
bWFuY2Ugb2YgdmlydHVhbCBkaXNrcyBpcyB2ZXJ5IGltcG9ydGFudC4gVGhlIG1xLWRlYWRsaW5l
IHNjaGVkdWxlcg0KPiBoYXMgYSBiaWcgcGVyZm9ybWFuY2UgZHJvcCBjb21wYXJlZCB0byBub25l
IHdpdGggc2luZ2xlIHF1ZXVlLiBJbiBteSB0ZXN0cywNCj4gbXEtZGVhZGxpbmUgNGsgcmVhZHJl
YWQgaW9wcyB3ZXJlIDI3MGsgY29tcGFyZWQgdG8gNDUwayBmb3Igbm9uZS4gU28gaGVyZQ0KPiB0
aGUgZGVmYXVsdCBzY2hlZHVsZXIgb2YgdmlydGlvLWJsayBpcyBzZXQgdG8gIm5vbmUiLg0KPg0K
PiBTaWduZWQtb2ZmLWJ5OiBMaSBGZW5nIDxmZW5nbGlAc21hcnR4LmNvbT4NCj4gLS0tDQo+DQoN
ClRoaXMgcGF0Y2ggbG9va3MgZ29vZCB0byBtZSwgaG93ZXZlciBJJ2QgdXBkYXRlIHRoZSBjb21t
aXQgbG9nIGFuZCBhZGQNCnBlcmZvcm1hbmNlIG51bWJlcnMgZm9yIHRoZSBub24tbXEgY2FzZSBh
bHNvLCBqdXN0IGluLWNhc2UgdG8gc2hvdyB0aGF0IHdlDQphcmUgbm90IGJyZWFraW5nIG5vbi1t
cSBzZXR1cC4NCg0KQmVpbmcgc2FpZCB0aGF0LCBpbiBjYXNlIHdlIHdhbnQgdG8gYmUgZnV0dXJl
IHByb29mLCB3ZSBjYW4gYWxzbyB0aGluayBvZg0KYWRkaW5nIGEgbW9kdWxlIHBhcmFtIHNvIGlm
IHNvbWVvbmUgY29tZXMgd2l0aCBhIHNjZW5hcmlvIHdoZXJlIE5PX1NDSEVEIGlzDQpub3QgcHJv
dmlkaW5nIHRoZSBwZXJmb3JtYW5jZSB0aGVuIHRoZXkgY2FuIGp1c3QgdXNlIHRoZSBtb2R1bGUg
cGFyYW1ldGVyDQppbnN0ZWFkIG9mIGFnYWluIGVkaXRpbmcgdGhlIGNvZGUsIGlycmVzcGVjdGl2
ZSBvZiB0aGF0IDotDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlk
aWEuY29tPg0KDQotY2sNCg0KDQo=
