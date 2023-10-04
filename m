Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855227B77D6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 08:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241378AbjJDGdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 02:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjJDGdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 02:33:45 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7B9AD;
        Tue,  3 Oct 2023 23:33:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQY0rX4+inENYfgTOAcMH2cw/ZRnVnM/q6GGaPIvUmCm4WAYqyjt2+AJpQgHIHIk5+Y8Qhkt1210WoWso6dcuJfkhnU5Ovii0a276lvOxtHQtE4XvJ0tfaw4KuESrsu77v132jSNi1oW5o82h35M2NjEAziQFxMr818C4byuPuRCLKmscMGaQWBcovMFYi3XDtVvVZP8Ua2m2z2vU2jU+hM83I4eGIE9DpfrufUnHa2fs6P9ph7N5niw3ooAkXSNZdq1RnBc/jicuRN0jUT4Bv5jc1Od+vsZGbKUqGsWUeEUc+I9r3hr0Rtiswgo881rrrF/3A+oEroVs+VZuEX/Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycS5XG8eIhFuyjR0N5qhGQ2FeSgALcMcFjMIn/MXtVU=;
 b=Q3lm4lIfb+ba8MZ7BDsdy7Jvd4SP2cvxyJRYI0e9YPohYhZM9Wz7S8CVTYSuDnCvo/1g6vIoH5gzwDO+jaZUjiS3GQ6iIJkmfF0oIBTV55YdM2j0Qr3W0B+deozusKD046j2ofPJA9AiZ6ag0vmVorKtXp5Y6KYc5uhFsi2GMWdtOrM8JFSEuEx/HlNz1MMjQe77cEuTmhsAQSYxoyKjVrGuzMQfMbREhHP9fT7EYJRXjc8PP3A6GgS7cxSU2TNI18QlVWSmor+Z3anoCKyU627WrkQSNSi6QFw7HY5cXB6tIbbiTIfViwG1qV1ypWUdjcj3uxo5hq+Qxdm2sadlmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycS5XG8eIhFuyjR0N5qhGQ2FeSgALcMcFjMIn/MXtVU=;
 b=lOLNO7niwP+ADNitwUXrLx84vNG5zSD7yqJPDdOTZWXa0u0VGjrlgDCXN029ClaCzY+MoJE8GBTyoJj18+GKu6e30EmhIVD18BkqixZfStLrtxYiwO/7gMkTYsJOZK6YEU3JfqCulOjzhJ1OOoy9a8DRDge55QiXDkyKXFDKKUvX9wTyHZLcToyVDhxbUWUlE35DVzgx7tZSMztDRlu+cXfTkV6bf0e6O1efsGO+4XgPgobFXu8Yp/TDgL7nHi0cb67XILAz36IkCLHRlfZfvnZhSOwu7qEQfVc6j6HuANwqpL2z4H3i0GI/p9HGGMflgOTAMqwSSONNIOfqmT+92w==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM4PR12MB5376.namprd12.prod.outlook.com (2603:10b6:5:39f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 06:33:40 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::74fa:9ccf:a8e4:2e79]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::74fa:9ccf:a8e4:2e79%7]) with mapi id 15.20.6813.017; Wed, 4 Oct 2023
 06:33:38 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Kees Cook <keescook@chromium.org>,
        James Smart <james.smart@broadcom.com>
CC:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [PATCH] nvmet-fc: Annotate struct nvmet_fc_tgt_queue with
 __counted_by
Thread-Topic: [PATCH] nvmet-fc: Annotate struct nvmet_fc_tgt_queue with
 __counted_by
Thread-Index: AQHZ9lDgqNhZI9r33kumVu66D6XHHrA5LMeA
Date:   Wed, 4 Oct 2023 06:33:37 +0000
Message-ID: <8338ab4d-1c43-5530-ccf5-1bf808faaaef@nvidia.com>
References: <20231003232511.work.459-kees@kernel.org>
In-Reply-To: <20231003232511.work.459-kees@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM4PR12MB5376:EE_
x-ms-office365-filtering-correlation-id: b8aa0ae0-8d30-40f9-5f2f-08dbc4a3d7ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ogE7JZBY06Pu16gKrvVCDtasZ/Fm1qPDjRdqb5SknS2/Saa0DkM5NIpX6lFmmtCT+ZukCMkeRCWt/hcWaOJwO9MsLrCRK5QezWfuxnquhmzKZQbJQOnzUQ3xmpB+GG248otbP0ALQbZJUobaHbpVeEAKH3GVhwNx+23lbzSMAJZ9ZFAeWMbhhWRQUsf2JWH1tSvO2fregbxEmGyJUJPrU+McIZ1i3+1Ab75wLEqiC2RO4CcWALRiAPAdozllWTo/LRetOPD9NZutaFAiwpoildkWk8sniFbqOgDSsJTC7Du3CTi4rvRZ9uZ6+rvsRzUgcpmUZ9mbxQtnc9JhyL7g1nWCAEkp/p6PeTz6nymU2Tc4fL19mvX2CK4L9kDwMN5o7GQllOLTfKPAgPszpLDfpzDr3eCL6EXS9rlhm6TCpMV8X32XdgJ4EgaJ7Ih27cIKYxmr/9JVB2tLdXZNG3I/hbdCJ8B97ZDeX9O6z9zczeSOIVPxlktl0S1E0YpU/aY5cgV6aaPM8oU+SBHe2J9NKrkid63rR0VPwBJG+xgw12je0qEGN+/lXIqLVExGaE9C5I12UjoxHXxqm/41tr5Af+vx0hSFHUf23YJmUq8rhPOqvFlT1vn9wSDwqutEqK+HDHIcaD65Sj8C8NK6k1s34NHm5dphSyHb8Vm5UZdtVewvIAuD3hK4AkiyDjNs9Xl3Ds8Rsp7eLwSknHLL1DeXrc3zw0XWEtBLs4luyZLkimg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(41300700001)(110136005)(91956017)(6486002)(2616005)(966005)(66946007)(53546011)(6506007)(6512007)(316002)(66446008)(66556008)(64756008)(66476007)(76116006)(54906003)(8676002)(4326008)(8936002)(5660300002)(478600001)(31686004)(71200400001)(7416002)(2906002)(4744005)(83380400001)(38070700005)(122000001)(36756003)(38100700002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3V5TDhWWTZZVHVVMzBaMDZsNVYrbEd1bDJvcFl2MlpIME1hTk9hc0RkcnhT?=
 =?utf-8?B?SENjYkl2eUNNVUJmSGdYT2ZjcU1tZHpKOVFGcXYwTzZqa3ZhMjZWNVhYd0dQ?=
 =?utf-8?B?RVlWMDhHQlRNeFRXT3grTHZvVFZJVnZEc2JqblQyd1VLRFNXUnNOT0VwM2Fj?=
 =?utf-8?B?S3J3QkVSdlJJK0p6cFhsZ0dkRnZQKzdLLzlOUGxseU5YR1lNZUd5NGFETXFY?=
 =?utf-8?B?ZHU2TGpKRmlhcHdBaXduSjZza1MwaFpFMTJpQnNoMnA1czM2YW9EeExPejI2?=
 =?utf-8?B?TTZuRm1yQnhJWXZMem5MdjVCQjVDWmNadVU0azZudFBrdCtPYzRXalZ2ZTdI?=
 =?utf-8?B?L2ZoQ3N3TW5UUmt5aFJGQTBnZm03cWd4aUdnU2ZqZmhudFFyelFub2kyN25a?=
 =?utf-8?B?MGZ5ZDRYR09jUnZ5dDQvMStlbUp1dXhydDFUQjZPZm55V0dFNEppc1NHcll1?=
 =?utf-8?B?V3FLckxyYThYci9nZVFtVVlRenVPQTZqdXBWb0daOG44VCtnU21DWXkvWVdx?=
 =?utf-8?B?eXR6UmtYS3hha2xHQ3pUeVpQK3AxU1IzdllzbFMyZUpsbnBUYlk2Mld5WmJs?=
 =?utf-8?B?ZU9lb1A3ZUpNckxNbmR1NDd5NW55d3JDc2RJQllJZGdZRUJ1eUFmNjRhdzlI?=
 =?utf-8?B?c1FEeVNaWXFBclordWIyOXdNSGJNVGhWUGlkcVpxNllvSVQ4dzhmWkd3WXBI?=
 =?utf-8?B?OGVjN2Q1ZTB6bjB1RlF3Z3FNR1pZYXYyL3BzM0ZISDFhN3pwQjl2Vk91eTJm?=
 =?utf-8?B?OUd2aWNkVnpNV0Q1YzkxZi9NLy8vM2ZmczREUGFCalRHQU1jeitGa3diWERK?=
 =?utf-8?B?blRtSDlZUURZK3VXcFJQOXJ1SitWNzJmZWMxeXZDQjgza2RXdTlRclZQYzEr?=
 =?utf-8?B?cllxTzRPbkQxZkhwVE04M3h1RmtxTDNoakpHeC9wU1FsNkp1Nk9ua21VaVJK?=
 =?utf-8?B?blQ5KzVrUUxJTVU0NTB3M09oWlJTVGtWVk1hS0NPY0RtSVgwZmEwT05UWGhJ?=
 =?utf-8?B?bnF2OTRwaEFqTm81NmNPcm9vV1B4dk1LUlBqQ0tLb1VnLzU3QXkvRjMraTA2?=
 =?utf-8?B?NFV6eGV6eHpBc1NjTnF0RXBmZ2hjWmZRSFlNbzJEbWVoWWx5a3lWZjZIVXp5?=
 =?utf-8?B?ZFBtUWtDK0hZMmphQ2hFck5wbUNhNUNsUC9PK1lDWjYrdTVoUHlNMnoyWU9t?=
 =?utf-8?B?VEI2RHp2K1R0RHpKSTkvY0hjcjUwdlJ2dkZ3TDZVcTRTbStONVRqWFhFcE4x?=
 =?utf-8?B?Ynhhalg5MnQxNCtJb1B2Z0FOQSt0c1N3VkNpZENrRHZ6TXJTUXdZOXlpb0J0?=
 =?utf-8?B?NVNRWnkvVlRwMUhmQ1piMEVwdXNMYWJWaWtjc3hmVmJaeUpsbEJpb0d5YnBN?=
 =?utf-8?B?V2ZKaUhOM1VCMm1VQVprZ2RwWVJJOUJjWmY3cmo4RXJkU3lzNnp0ZWJPNWFI?=
 =?utf-8?B?aW1ZSTN1cHdpWlhHUkxTWWwxdUpvcnRmekQvMzJlVVF6WXlnZjNhZm5rbVd1?=
 =?utf-8?B?dGo1aHMvN2drdWxSblk2b0UxNzZtRmY0L0ZyaWozemV5QVhpWTFEOS9KTUlY?=
 =?utf-8?B?MG13QmxyK0dpbmtTc1huZTNqMjQ5K1NldUpsSzFLcStKOE13ZTl4dEpUOEtp?=
 =?utf-8?B?eUYxRjZGOUJGU20xMnAvMEIrUkZ4V3lRM1d4TFh2dDZ3MkVLbVhvTlIxVWd1?=
 =?utf-8?B?N2ZFdVZxWWNjMzR2eStJMjNqRXRYbnlXY3daM0I2TkxLbmtjQ3pkY1ZqejlW?=
 =?utf-8?B?c0hEZkRVU1daZ1BKanFtSDQyZFEyT1MyQWVzL3Jma3AzSUdmVkFLYjhrVXdk?=
 =?utf-8?B?K244S1hGYnhWdWRCZ0JobmRrU0tEbVpVelo5aDA0NjNoU3FwMkpYY2l3VXpm?=
 =?utf-8?B?eGFMams3cVI5Y3lNQjJxaWhVVFlhTEVTc200YytvbXpyQW1CUkhFYWdGV0RL?=
 =?utf-8?B?ZUo2UGFLMzJ5ZmpPRExFTjgrSENiczJSREhidDFZZnpZb1VGZFkzVFpQRHh3?=
 =?utf-8?B?eWJmbm1iMlhtb3RYMkp0NHFnWXdPTS9UcTNnZmZEWUdXRitPY3c4SkpkYzRq?=
 =?utf-8?B?WGpMNmZHMWljMTVkWVNDU0JEalpMa04rc2RNWnNCMEI0ZGRTMFlucWtOdG5p?=
 =?utf-8?B?ZVBLVFZuR0Q5UDZtSnRnWVp0d202VnRvb0huUU5Pc05aS1E1VGYxempmQVQz?=
 =?utf-8?Q?wegQ1pAVYxEd5tzXDnsiSnFX/UKAQFbby/m7Fg0HjSc4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3646057087D4C449B4AF022771EF916@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8aa0ae0-8d30-40f9-5f2f-08dbc4a3d7ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 06:33:37.9833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 97/HbSL1LIAw6wAvTGVBBHErNpx2f72OSyrfr1g/5mk8S2mctJkyIdgBZZrVV4oCNfOnQQMv6TDoa8ZaFGBYHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5376
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMy8yMyAxNjoyNSwgS2VlcyBDb29rIHdyb3RlOg0KPiBQcmVwYXJlIGZvciB0aGUgY29t
aW5nIGltcGxlbWVudGF0aW9uIGJ5IEdDQyBhbmQgQ2xhbmcgb2YgdGhlIF9fY291bnRlZF9ieQ0K
PiBhdHRyaWJ1dGUuIEZsZXhpYmxlIGFycmF5IG1lbWJlcnMgYW5ub3RhdGVkIHdpdGggX19jb3Vu
dGVkX2J5IGNhbiBoYXZlDQo+IHRoZWlyIGFjY2Vzc2VzIGJvdW5kcy1jaGVja2VkIGF0IHJ1bi10
aW1lIHZpYSBDT05GSUdfVUJTQU5fQk9VTkRTIChmb3INCj4gYXJyYXkgaW5kZXhpbmcpIGFuZCBD
T05GSUdfRk9SVElGWV9TT1VSQ0UgKGZvciBzdHJjcHkvbWVtY3B5LWZhbWlseQ0KPiBmdW5jdGlv
bnMpLg0KPg0KPiBBcyBmb3VuZCB3aXRoIENvY2NpbmVsbGVbMV0sIGFkZCBfX2NvdW50ZWRfYnkg
Zm9yIHN0cnVjdCBudm1ldF9mY190Z3RfcXVldWUuDQo+DQo+IENjOiBKYW1lcyBTbWFydCA8amFt
ZXMuc21hcnRAYnJvYWRjb20uY29tPg0KPiBDYzogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3Qu
ZGU+DQo+IENjOiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPg0KPiBDYzogQ2hhaXRh
bnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCj4gQ2M6IGxpbnV4LW52bWVAbGlzdHMuaW5m
cmFkZWFkLm9yZw0KPiBMaW5rOiBodHRwczovL2dpdGh1Yi5jb20va2Vlcy9rZXJuZWwtdG9vbHMv
YmxvYi90cnVuay9jb2NjaW5lbGxlL2V4YW1wbGVzL2NvdW50ZWRfYnkuY29jY2kgWzFdDQo+IFNp
Z25lZC1vZmYtYnk6IEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPg0KPiAtLS0NCj4g
ICANCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2No
QG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
