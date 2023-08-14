Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5184177BB5D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjHNORG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbjHNOQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:16:38 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFDE173E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:16:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXfttPtJij8/Y21xS1QbZfOXxhA3MuhyBB3MyzwfHMsGyNwJcvCxzrbLW0mau5RaBuLeem8IAYB2gtx8LUcmWwArLJt/kyhaUCC3NKGFUzcgK5/BcUo+dPeu+suhZbowd/4t+gNmGiir08Yjvsa816ZYCz8Gh5pUoojTzgd1ozU6qOnbxRdby/Y3zdjXhYh3m1sPohf47WiMlTwgp7ITD5pTB/x/CoBrLnqA8ZXS4Ullt0+qD4YMn/GfYx+3zHAwk/3P23DZtgY0/o6sQq5NYotuuGfqfSF5aCqLKiiW7PHTorbgHL2cG8LNowgT44I2Jre1IO6ohF3ittwe+Bi+VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNqkKdy0DMIHkuC18Jo7i8d/bPVuEwO5g2E8UErrEKk=;
 b=XBlO2rQ/JdKjVk1CXzryLNYl9hEHynNsxkRKwT/eqjyrHfHuPdNRHklJy3sC8abEyBCxdy3V0fT9moMULLX2JXkUhUXuWeCGaChMNRXlC24/VBjP80Rv8HhQ7ZQ8t6n0O5i/jcb83NDQBA2ambcSgoiSB8ScL9UtmNM2KLKu8lvhhqC4IxrwikIvbrVDoH+iWAfK1T5rbBCcdef7sW9BvVetX9nXG3RLPZeSHkcm5nXizjWoQpmQie64+VRowHiXefP4ne6nNoAGtBIVlVR4xU+UWAir+lRrk4+6WTIELYYv3nYh4oI2AOkcVUh4uNbwosq8gEP+ZzhKUHWNyyKnjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNqkKdy0DMIHkuC18Jo7i8d/bPVuEwO5g2E8UErrEKk=;
 b=i6oYlvhfzRMVeIGhMsqZVCAcrAt1pscM7Wdzeneu2igmp9jbvrHI4nRbg1apAgNRz+Sl4P0duBsiT8n9dxkHx2Jpt35fNT298YDj66M9JCQE9/p9LNa2W6hbPNOk3fFg9mrvl8sDziK1rWERDl4qJn1PpsUnOzcWKn2QUCnWBDEMGJhJ6Bl65me4jZMOeBFTIWlJWvryxRT7UNGRk1JOHlkh+FDVoVJK1wmWDIw1XCAOYT7zNvWQ7yo059KWdgzgZtpNNmN1oG85YXUkr5kBc6oSJPWGqCNZIs8GXhwNk5kfdf1zcskC5SpjxoQH5sWQQwNzPWKPUHMgLhPBWrvVUw==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by SN7PR12MB7956.namprd12.prod.outlook.com (2603:10b6:806:328::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 14:15:40 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::40dc:9f89:895c:8667]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::40dc:9f89:895c:8667%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 14:15:40 +0000
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     "jasowang@redhat.com" <jasowang@redhat.com>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gal Pressman <gal@nvidia.com>,
        "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 1/2] vdpa/mlx5: Fix mr->initialized semantics
Thread-Topic: [PATCH 1/2] vdpa/mlx5: Fix mr->initialized semantics
Thread-Index: AQHZxWScYzQYP2l8TkunB6gTY1iBgK/YN0cAgAA8kgCAB0mWgIAASmEAgAEy9wCACK4KgA==
Date:   Mon, 14 Aug 2023 14:15:40 +0000
Message-ID: <8316b7a41f80d9a0b03795e33201be02b3be756e.camel@nvidia.com>
References: <20230802171231.11001-1-dtatulea@nvidia.com>
         <20230802171231.11001-3-dtatulea@nvidia.com>
         <CACGkMEsE45k+fqv-biYfOX5VbqZLo_drQV5rPYByuLJZK03hWQ@mail.gmail.com>
         <b31737724cdcf0cc63fbec56209b7288dc8fcfce.camel@nvidia.com>
         <CACGkMEvoE=1ac1EGxPd14AwCfuOTiZYzYgDQC_qZjSubt891sA@mail.gmail.com>
         <83ca86a42041248f8db717cdc858b7f973cbd85b.camel@nvidia.com>
         <CACGkMEt95WsDxuc-vGWNhZfZ5G9AGUykV5+kV8oDcGZQ4jD-Lg@mail.gmail.com>
In-Reply-To: <CACGkMEt95WsDxuc-vGWNhZfZ5G9AGUykV5+kV8oDcGZQ4jD-Lg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|SN7PR12MB7956:EE_
x-ms-office365-filtering-correlation-id: c16cbbe7-0746-42e6-8dc9-08db9cd0f09d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tP7nmK/U/8ltqUYLMP/H6w3d7hIhvvuiMtpT2PCs8HxAtllaRrhdtP7md2emHV1iCp6/CfdZBy9l5gKvQPn1AM4yglmch8Yuw6wJKR9azsuvpyfAGABok6sqD48c/bZhy7r7KCtAH7qsNITdDrEcmXC42cWErcjbEcSltUQhuwLDTL1EXMor0KuQ+LNdSY1UUx+u4+xI2U7g1ljWp93GmhYoItW3Cwc1ad4q6iM8pJc4uxjPaiB4oMGc6xqirHG5mdSNtKrNOBeah1MfXlvUPoRS5WPZJVvEVUUvA5GM/aG5pL1ASSISQ63rKNHCWJeAmZA8HwUXcPumMhE3YY+Q63YFS/s+bBiBrfxyu/OPEkbDF0PPWFn28XxVB8GssavVtUO+im//812w+jf5HE5UP+pORJGRKlv6wb8FpJC1yAjJpdxgY2B9JNBZHVW8D8cJPHCceVcZ0lyOWcVTgCwQKbxxpKmr6qckmMZyicTCB409dbkr/unyY9p2qdETKbYwldIU6JMx63FVoCWMAL9W7Kzw9YazYcns8NXmAjcFnzvPSw/ODdabYacXX2xdQ170LmFi8hJdZ2I1nmAuoatPjW2Gg6P6w33VybGktlJ1zk9RN3ZkH7biHEADbOBlZBaM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(136003)(39860400002)(346002)(186006)(1800799006)(451199021)(83380400001)(36756003)(66574015)(86362001)(38100700002)(41300700001)(478600001)(38070700005)(91956017)(66946007)(54906003)(66476007)(6512007)(66446008)(64756008)(66556008)(76116006)(6916009)(122000001)(316002)(8676002)(5660300002)(4326008)(8936002)(2616005)(6506007)(6486002)(2906002)(53546011)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akY5RnVURExrVU9QcTJkbk1BSENRMys1bEszWmt4NmY4bDA5YUE2R1NMcXU0?=
 =?utf-8?B?b0xYWjBOYWIxRXJ6ZmNjd215b0NTMmZUNDhMMVRVd09XNm1xWEY4eGt0V3po?=
 =?utf-8?B?UzFSWE9DYnpDR29FalJBOEtlZnEwY0N3OVlkOXp1Q29WcFp5SFJ5djZ0VUhp?=
 =?utf-8?B?Qi9VTjZqbGZZS3l4eUd3ZVhjWmRwQVlReFB5THphSFh5VUZNSjFidEZWVXhB?=
 =?utf-8?B?WkVENzNmK0c4UjFJNmpZa1Zzd3BpODBPanMvM09KdDVXVm1lTy9LSVY3YjZw?=
 =?utf-8?B?YnMzdXpKR0oydGg2bXovdWNsL3JaclZuS3dVS1Mzd1VOd0pUMUQ4elhnbU5V?=
 =?utf-8?B?TVZKZVJXUTNzRTBtZ0R0cFE4VENPc2RMaWgzZG02MXp2eGk5ZXg0dEFaNkhX?=
 =?utf-8?B?RG5KTUFQaTllTGt6czFuVzlsZUVOSzkxVzJvcUFHNjh6eXN3MDJBTGZFeU1P?=
 =?utf-8?B?NkV3c00zUlpxUkl3czVxeXdKcUJSVC9WekFTSmw3VnlxUG1pd1hrNW1Yb0ZR?=
 =?utf-8?B?OE5IOHl4S3U4YVZyUmFDMWtrMFZqSkFhckdmRnoyUnVBdE93MDkyczh0VWtC?=
 =?utf-8?B?UU5MZGJqQ04rNk9mZlJhalZ1MDBEZWVHSzhsMWNhOGZ2OGRxN2w5Qmg4VHlD?=
 =?utf-8?B?TS9CZnBLZEo1UmdkNVVNa1lhODZKUVFIK1duV1Uvam00cm1SNkl5N0xYdUFZ?=
 =?utf-8?B?NFlkQlB0ME4zQUNtMnBUZUU3cDdvTWFjb1pNTFBlL2gycWd5cGZTb2hDV1Rj?=
 =?utf-8?B?UE1vTU5kOS90WmNOb0IrUlBuZS9LdVJvajE2RlZ5OVo4K2VzZkJpN2pTeERn?=
 =?utf-8?B?T0hwWlBnaTVvNHN2RHVFbFhjUm90UTVsbXVJUENxUE9ZN1JlNlo0S3pXWDFS?=
 =?utf-8?B?WCtSZ1ZzNVlRakRlLzIvWmlNcmFOZUZlL2JjU1htRExMQi96VUJqRlVtbnZG?=
 =?utf-8?B?MWl0Sm9iMlREWnpQbE15ckFDajI3ZXdHbWp4N25pVFlJK1Y2R2Jhb2JoZ3pX?=
 =?utf-8?B?dFdxVHRVNldYWTVHMnpkejEzWEVtRnF4d0hDWGNQWFVkQ0pPc1VjMjFwL1gx?=
 =?utf-8?B?ODBYQjNILzRwR2xjeWk0ZDhMQ0xIYmUvR1pHYzQvNkxnTGxxMGpGNUVJU0U3?=
 =?utf-8?B?cVk4ZkU2NUtzOXVpVnFTTWkrUC8zNkRXeG1jdDZqWDJ4SWFodkFJZzR6UXpI?=
 =?utf-8?B?VzlXWVpiZGZZT0s3bjhzeXJCSGJkTHpUVkRkQWM0b3NMZDNzT3pId1pzb0dI?=
 =?utf-8?B?U04yMTltTmlCZVZkQWRtaDNFTDBOanY5Z1A0MjNyNndUcmdpOFdPUWMvYUZi?=
 =?utf-8?B?cDNhL2FxNXVWTGJPNjVkbG5oZjZoYVRQUGMrUkMycURrMVJtVEJYTE5EdFFx?=
 =?utf-8?B?dzNtbkkxZmIrNTI2RGtrTVJNRXdWUDF1VWs3UmZhb3FJcURTQm1jZDcwdktF?=
 =?utf-8?B?VTlCSWNMeVdNSzZCTVpkRWhTQ29vWUNWMC9FN1p3NmdEOWNERWR5dmVndkRG?=
 =?utf-8?B?ZUcyalcyMC9ZamJRejRmb1g0Q3BuTVJXTXh2K1FsTnNXMjBYcC9qajZYazdI?=
 =?utf-8?B?UXJicjVZSEtESTgzV3JicU4xYTNOY2VTRDF5TEY2VkxWQlpjNm1QL3JERlcw?=
 =?utf-8?B?NE9yU2w1WEd6UGhORWZONkF2UGtqVVJFTmRqc09XdTkvZ2Z2M2FZS2pMVStt?=
 =?utf-8?B?UGlMVGFUTTRpNkRpY3RkSXViRWsvRytKbG40TkJ6ck9BbDBCUm56MzNYZUN0?=
 =?utf-8?B?QUwwZm5vMWVQS3ZMczdwdjNxOGs0MW8yWTlrYkNEV0N4OTNsSHJ6Ym9NNDU1?=
 =?utf-8?B?WDExR2dyVkUyRWlnT2d1eCtiYTRCYmZva2djQ05MMXBnSU96RDZaZ3FFYU5P?=
 =?utf-8?B?Y09XWXczcmVla2oxL25PZDdtWllVbmdONkQyTExXdktlbjlaUTVaaFdxc3F3?=
 =?utf-8?B?Rm9oc01vQUJTUEJVeDNsR1JLZnAraUZ3aWlSVktFNnNNNjdvYjJTVVBTbU9B?=
 =?utf-8?B?bjd4U0ZMWmlGaklnOXl2N3ZNVk92U3F3eHc2NkhEbUQ4eWYyZ3h5WFZDYzRC?=
 =?utf-8?B?cVdFL2hzVHQ0bDBzcU1KSnlGTFdobHpRNkV1QWhiZHpxOWZJMWcxTHh6MGRQ?=
 =?utf-8?B?VEhFTGg3ZFF1cktJaTh6alQ5Y3E4UTgzWVlTcW1yem1ORlFNWHV6M0I0bW9B?=
 =?utf-8?Q?lSptwBZ3sHB3RaPDcE/yReLmLXP3vz/d756NRIHLmtxz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72D3309DDA1CFA4EBF5E7D290DC30BFE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c16cbbe7-0746-42e6-8dc9-08db9cd0f09d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 14:15:40.6566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q74ae8hoLW9TDaS/LTLDkTkpz58z/m5bX8Je9UmOIfMS3HY2qQGpvKTDu4CJ1XjCv0oCki2VgkSZ4z+Av6mV3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7956
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA4LTA5IGF0IDA5OjQyICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOg0KPiBP
biBUdWUsIEF1ZyA4LCAyMDIzIGF0IDM6MjTigK9QTSBEcmFnb3MgVGF0dWxlYSA8ZHRhdHVsZWFA
bnZpZGlhLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gVHVlLCAyMDIzLTA4LTA4IGF0IDEwOjU3
ICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOg0KPiA+ID4gT24gVGh1LCBBdWcgMywgMjAyMyBhdCA3
OjQw4oCvUE0gRHJhZ29zIFRhdHVsZWEgPGR0YXR1bGVhQG52aWRpYS5jb20+IHdyb3RlOg0KPiA+
ID4gPiANCj4gPiA+ID4gT24gVGh1LCAyMDIzLTA4LTAzIGF0IDE2OjAzICswODAwLCBKYXNvbiBX
YW5nIHdyb3RlOg0KPiA+ID4gPiA+IE9uIFRodSwgQXVnIDMsIDIwMjMgYXQgMToxM+KAr0FNIERy
YWdvcyBUYXR1bGVhIDxkdGF0dWxlYUBudmlkaWEuY29tPg0KPiA+ID4gPiA+IHdyb3RlOg0KPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBUaGUgbXItPmluaXRpYWxpemVkIGZsYWcgaXMgc2hhcmVk
IGJldHdlZW4gdGhlIGNvbnRyb2wgdnEgYW5kIGRhdGENCj4gPiA+ID4gPiA+IHZxDQo+ID4gPiA+
ID4gPiBwYXJ0IG9mIHRoZSBtciBpbml0L3VuaW5pdC4gQnV0IGlmIHRoZSBjb250cm9sIHZxIGFu
ZCBkYXRhIHZxIGdldA0KPiA+ID4gPiA+ID4gcGxhY2VkDQo+ID4gPiA+ID4gPiBpbiBkaWZmZXJl
bnQgQVNJRHMsIGl0IGNhbiBoYXBwZW4gdGhhdCBpbml0aWFsaXppbmcgdGhlIGNvbnRyb2wgdnEN
Cj4gPiA+ID4gPiA+IHdpbGwNCj4gPiA+ID4gPiA+IHByZXZlbnQgdGhlIGRhdGEgdnEgbXIgZnJv
bSBiZWluZyBpbml0aWFsaXplZC4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gVGhpcyBwYXRj
aCBjb25zb2xpZGF0ZXMgdGhlIGNvbnRyb2wgYW5kIGRhdGEgdnEgaW5pdCBwYXJ0cyBpbnRvDQo+
ID4gPiA+ID4gPiB0aGVpcg0KPiA+ID4gPiA+ID4gb3duIGluaXQgZnVuY3Rpb25zLiBUaGUgbXIt
PmluaXRpYWxpemVkIHdpbGwgbm93IGJlIHVzZWQgZm9yIHRoZQ0KPiA+ID4gPiA+ID4gZGF0YSB2
cQ0KPiA+ID4gPiA+ID4gb25seS4gVGhlIGNvbnRyb2wgdnEgY3VycmVudGx5IGRvZXNuJ3QgbmVl
ZCBhIGZsYWcuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFRoZSB1bmluaXRpYWxpemluZyBw
YXJ0IGlzIGFsc28gdGFrZW4gY2FyZSBvZjogbWx4NV92ZHBhX2Rlc3Ryb3lfbXINCj4gPiA+ID4g
PiA+IGdvdA0KPiA+ID4gPiA+ID4gc3BsaXQgaW50byBkYXRhIGFuZCBjb250cm9sIHZxIGZ1bmN0
aW9ucyB3aGljaCBhcmUgbm93IGFsc28gQVNJRA0KPiA+ID4gPiA+ID4gYXdhcmUuDQo+ID4gPiA+
ID4gPiANCj4gPiA+ID4gPiA+IEZpeGVzOiA4ZmNkMjBjMzA3MDQgKCJ2ZHBhL21seDU6IFN1cHBv
cnQgZGlmZmVyZW50IGFkZHJlc3Mgc3BhY2VzDQo+ID4gPiA+ID4gPiBmb3INCj4gPiA+ID4gPiA+
IGNvbnRyb2wgYW5kIGRhdGEiKQ0KPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogRHJhZ29zIFRh
dHVsZWEgPGR0YXR1bGVhQG52aWRpYS5jb20+DQo+ID4gPiA+ID4gPiBSZXZpZXdlZC1ieTogRXVn
ZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+DQo+ID4gPiA+ID4gPiBSZXZpZXdlZC1i
eTogR2FsIFByZXNzbWFuIDxnYWxAbnZpZGlhLmNvbT4NCj4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4g
PiA+ID4gwqBkcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oIHzCoCAxICsNCj4gPiA+
ID4gPiA+IMKgZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jwqDCoMKgwqDCoMKgwqAgfCA5NyAr
KysrKysrKysrKysrKysrKysrKystLS0tLS0NCj4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4g
wqAyIGZpbGVzIGNoYW5nZWQsIDcxIGluc2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQ0KPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvY29y
ZS9tbHg1X3ZkcGEuaA0KPiA+ID4gPiA+ID4gYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVf
dmRwYS5oDQo+ID4gPiA+ID4gPiBpbmRleCAyNWZjNDEyMGI2MTguLmEwNDIwYmU1MDU5ZiAxMDA2
NDQNCj4gPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgN
Cj4gPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4NV92ZHBhLmgNCj4g
PiA+ID4gPiA+IEBAIC0zMSw2ICszMSw3IEBAIHN0cnVjdCBtbHg1X3ZkcGFfbXIgew0KPiA+ID4g
PiA+ID4gwqDCoMKgwqDCoMKgwqAgc3RydWN0IGxpc3RfaGVhZCBoZWFkOw0KPiA+ID4gPiA+ID4g
wqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBudW1fZGlyZWN0czsNCj4gPiA+ID4gPiA+IMKg
wqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgbnVtX2tsbXM7DQo+ID4gPiA+ID4gPiArwqDCoMKg
wqDCoMKgIC8qIHN0YXRlIG9mIGR2cSBtciAqLw0KPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqAg
Ym9vbCBpbml0aWFsaXplZDsNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKg
wqAgLyogc2VyaWFsaXplIG1rZXkgY3JlYXRpb24gYW5kIGRlc3RydWN0aW9uICovDQo+ID4gPiA+
ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvY29yZS9tci5jDQo+ID4gPiA+ID4g
PiBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYw0KPiA+ID4gPiA+ID4gaW5kZXggMDNlNTQz
MjI5NzkxLi40YWUxNGEyNDhhNGIgMTAwNjQ0DQo+ID4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3Zk
cGEvbWx4NS9jb3JlL21yLmMNCj4gPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L2Nv
cmUvbXIuYw0KPiA+ID4gPiA+ID4gQEAgLTQ4OSw2MCArNDg5LDEwMyBAQCBzdGF0aWMgdm9pZCBk
ZXN0cm95X3VzZXJfbXIoc3RydWN0DQo+ID4gPiA+ID4gPiBtbHg1X3ZkcGFfZGV2DQo+ID4gPiA+
ID4gPiAqbXZkZXYsIHN0cnVjdCBtbHg1X3ZkcGFfbXIgKm1yDQo+ID4gPiA+ID4gPiDCoMKgwqDC
oMKgwqDCoCB9DQo+ID4gPiA+ID4gPiDCoH0NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gLXZv
aWQgbWx4NV92ZHBhX2Rlc3Ryb3lfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2KQ0KPiA+
ID4gPiA+ID4gK3N0YXRpYyB2b2lkIF9tbHg1X3ZkcGFfZGVzdHJveV9jdnFfbXIoc3RydWN0IG1s
eDVfdmRwYV9kZXYgKm12ZGV2LA0KPiA+ID4gPiA+ID4gdW5zaWduZWQNCj4gPiA+ID4gPiA+IGlu
dCBhc2lkKQ0KPiA+ID4gPiA+ID4gK3sNCj4gPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqAgaWYgKG12
ZGV2LT5ncm91cDJhc2lkW01MWDVfVkRQQV9DVlFfR1JPVVBdICE9IGFzaWQpDQo+ID4gPiA+ID4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo+ID4gPiA+ID4gPiArDQo+
ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgIHBydW5lX2lvdGxiKG12ZGV2KTsNCj4gPiA+ID4gPiA+
ICt9DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArc3RhdGljIHZvaWQgX21seDVfdmRwYV9k
ZXN0cm95X2R2cV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsDQo+ID4gPiA+ID4gPiB1
bnNpZ25lZA0KPiA+ID4gPiA+ID4gaW50IGFzaWQpDQo+ID4gPiA+ID4gPiDCoHsNCj4gPiA+ID4g
PiA+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBtbHg1X3ZkcGFfbXIgKm1yID0gJm12ZGV2LT5tcjsN
Cj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gLcKgwqDCoMKgwqDCoCBtdXRleF9sb2NrKCZtci0+
bWtleV9tdHgpOw0KPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoCBpZiAobXZkZXYtPmdyb3VwMmFz
aWRbTUxYNV9WRFBBX0RBVEFWUV9HUk9VUF0gIT0gYXNpZCkNCj4gPiA+ID4gPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsNCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+
IMKgwqDCoMKgwqDCoMKgIGlmICghbXItPmluaXRpYWxpemVkKQ0KPiA+ID4gPiA+ID4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBvdXQ7DQo+ID4gPiA+ID4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IC3C
oMKgwqDCoMKgwqAgcHJ1bmVfaW90bGIobXZkZXYpOw0KPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKg
wqAgaWYgKG1yLT51c2VyX21yKQ0KPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGRlc3Ryb3lfdXNlcl9tcihtdmRldiwgbXIpOw0KPiA+ID4gPiA+ID4gwqDCoMKgwqDC
oMKgwqAgZWxzZQ0KPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRl
c3Ryb3lfZG1hX21yKG12ZGV2LCBtcik7DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IMKgwqDC
oMKgwqDCoMKgIG1yLT5pbml0aWFsaXplZCA9IGZhbHNlOw0KPiA+ID4gPiA+ID4gLW91dDoNCj4g
PiA+ID4gPiA+ICt9DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArc3RhdGljIHZvaWQgbWx4
NV92ZHBhX2Rlc3Ryb3lfbXJfYXNpZChzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYsDQo+ID4g
PiA+ID4gPiB1bnNpZ25lZA0KPiA+ID4gPiA+ID4gaW50IGFzaWQpDQo+ID4gPiA+ID4gPiArew0K
PiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3QgbWx4NV92ZHBhX21yICptciA9ICZtdmRl
di0+bXI7DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgIG11dGV4X2xv
Y2soJm1yLT5ta2V5X210eCk7DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArwqDCoMKgwqDC
oMKgIF9tbHg1X3ZkcGFfZGVzdHJveV9kdnFfbXIobXZkZXYsIGFzaWQpOw0KPiA+ID4gPiA+ID4g
K8KgwqDCoMKgwqDCoCBfbWx4NV92ZHBhX2Rlc3Ryb3lfY3ZxX21yKG12ZGV2LCBhc2lkKTsNCj4g
PiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIG11dGV4X3VubG9jaygmbXIt
Pm1rZXlfbXR4KTsNCj4gPiA+ID4gPiA+IMKgfQ0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiAt
c3RhdGljIGludCBfbWx4NV92ZHBhX2NyZWF0ZV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZk
ZXYsDQo+ID4gPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIsIHVuc2lnbmVk
DQo+ID4gPiA+ID4gPiBpbnQNCj4gPiA+ID4gPiA+IGFzaWQpDQo+ID4gPiA+ID4gPiArdm9pZCBt
bHg1X3ZkcGFfZGVzdHJveV9tcihzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYpDQo+ID4gPiA+
ID4gPiArew0KPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoCBtbHg1X3ZkcGFfZGVzdHJveV9tcl9h
c2lkKG12ZGV2LCBtdmRldi0NCj4gPiA+ID4gPiA+ID4gZ3JvdXAyYXNpZFtNTFg1X1ZEUEFfQ1ZR
X0dST1VQXSk7DQo+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgIG1seDVfdmRwYV9kZXN0cm95X21y
X2FzaWQobXZkZXYsIG12ZGV2LQ0KPiA+ID4gPiA+ID4gPiBncm91cDJhc2lkW01MWDVfVkRQQV9E
QVRBVlFfR1JPVVBdKTsNCj4gPiA+ID4gPiA+ICt9DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4g
PiArc3RhdGljIGludCBfbWx4NV92ZHBhX2NyZWF0ZV9jdnFfbXIoc3RydWN0IG1seDVfdmRwYV9k
ZXYgKm12ZGV2LA0KPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCB2aG9zdF9pb3RsYiAq
aW90bGIsDQo+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50IGFzaWQpDQo+ID4g
PiA+ID4gPiArew0KPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoCBpZiAobXZkZXYtPmdyb3VwMmFz
aWRbTUxYNV9WRFBBX0NWUV9HUk9VUF0gIT0gYXNpZCkNCj4gPiA+ID4gPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOw0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4g
K8KgwqDCoMKgwqDCoCByZXR1cm4gZHVwX2lvdGxiKG12ZGV2LCBpb3RsYik7DQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gVGhpcyB3b3JyaWVzIG1lIGFzIGNvbmNlcHR1YWxseSwgdGhlcmUgc2hvdWxk
IGJlIG5vIGRpZmZlcmVuY2UgYmV0d2Vlbg0KPiA+ID4gPiA+IGR2cSBtciBhbmQgY3ZxIG1yLiBU
aGUgdmlydHF1ZXVlIHNob3VsZCBiZSBsb29zZWx5IGNvdXBsZWQgd2l0aCBtci4NCj4gPiA+ID4g
PiANCj4gPiA+ID4gQXJlIHlvdSB3b3JyaWVkIGJ5IHRoZSBjaGFuZ2VzIGluIHRoaXMgcGF0Y2gg
b3IgYWJvdXQgdGhlIHBvc3NpYmlsaXR5IG9mDQo+ID4gPiA+IGhhdmluZw0KPiA+ID4gPiANCj4g
PiA+ID4gVGhlIHJlYXNvbiBmb3IgdGhpcyBjaGFuZ2UgaXMgdGhhdCBJIG5vdGljZWQgaWYgeW91
IGNyZWF0ZSBvbmUgbXIgaW4gb25lDQo+ID4gPiA+IGFzaWQNCj4gPiA+ID4geW91IGNvdWxkIGJl
IGJsb2NrZWQgb3V0IGZyb20gY3JlYXRpbmcgYW5vdGhlciBvbmUgaW4gYSBkaWZmZXJlbnQgYXNp
ZA0KPiA+ID4gPiBkdWUNCj4gPiA+ID4gdG8NCj4gPiA+ID4gbXItPmluaXRpYWxpemVkIGJlaW5n
IHRydWUuIFRvIG1lIHRoYXQgc2VlbWVkIHByb2JsZW1hdGljLiBJcyBpdCBub3Q/DQo+ID4gPiAN
Cj4gPiA+IE15IGZlZWxpbmcgaXMgdGhhdCBtci5jIHNob3VsZCBiZSBkZXZpY2UgYWdub3N0aWMu
IEl0IG5lZWRzIHRvIGtub3cNCj4gPiA+IG5vdGhpbmcgYWJvdXQgdGhlIGRldmljZSBkZXRhaWxz
IHRvIHdvcmsuIEJ1dCB0aGlzIHBhdGNoIHNlZW1zIHRvDQo+ID4gPiBicmVhayB0aGUgbGF5ZXIu
DQo+ID4gPiANCj4gPiBCdXQgdGhlIHNhbWUgbG9naWMgd2FzIHRoZXJlIGJlZm9yZSAod2l0aCB0
aGUgZXhjZXB0aW9uIG9mIGN2cSBub3QgaGF2aW5nIGFuDQo+ID4gaW5pdCBmbGFnIGFueW1vcmUp
LiBTbyB3aGF0IGFtIEkgbWlzc2luZyBoZXJlPw0KPiANCj4gTm90aGluZywgSSB0aGluayB5b3Un
cmUgcmlnaHQuDQo+IA0KPiBJIHRoaW5rIHdlIGNhbiBoYXZlIHRoaXMgcGF0Y2ggZ28gZmlyc3Qg
YW5kIHR3ZWFrIG9uIHRvcCBieSBtb3ZpbmcgQ1ZRDQo+IGF3YXJlIGxvZ2ljIGludG8gdGhlIG5l
dCBzcGVjaWZpYyBjb2Rlcy4NCj4gDQpJcyB0aGlzIGFueXRoaW5nIG1vcmUgdGhhbiBhIHJlLW9y
Zz8gTXkgcGxhbiBpcyB0byBtb3ZlIHRoZSBjdnEgbXIgcGFydCBmcm9tDQptbHg1X3ZkcGFfZGV2
IGludG8gbWx4NV92ZHBhX25ldC4gSXMgdGhlcmUgYW55dGhpbmcgZWxzZSB0aGF0IHlvdSB3ZXJl
IGV4cGVjdGluZw0KaGVyZT8NCg0KVGhhbmtzLA0KRHJhZ29zDQo=
