Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061F07F6C56
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 07:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjKXGfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 01:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjKXGfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 01:35:18 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1F0B0;
        Thu, 23 Nov 2023 22:35:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gq7QYuxaFDuZ7AJ6zk1EIOcWNS+E3i6kmh8LPI2AsKBTqAh8lsmWOo5FDQl2lyMM8Vd9Q4P6FjvCaPz0rOm6kzX8qTWK6dLaFtD7PoEwpP1VpCFJPjd7y5USc9oXROrEUAJvLQZCyV5HpDAbEhV44ITy7A/lUnqnXUWjvdeQHMb9KBpVE1owh0SUTAl1wd8hXHLAp7wpBLnGdMRmYBgw4/UysyFLT/qk7DxOqtAVhtWMn/m54KY92NdxtTVIj7o4Ixy3D88ulOmT9gY6hoFMYa36t5BZdsl1Q7eqtJPjijww8Fj1RkZ3dvsvXA+amh4wkx7oOrmqGC/WJ42B/z2Jpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MoBSCkKTywvQ8o4Hh3/8hti2am3zM/KoOwKHCTFJXM=;
 b=D+zp2vnrvzoeeZT6BVdA1IfMFGDVh3EdDwImA86WU8Iw/KZ8cQNCesv6R/E1H+3hEJH9Re1cDHjpTzeEGSoQ6xhXw2eCBvhntn2UDDanp/EAXnMg+/7VT75KCuw1osWlVr+WWmpLpMQe/OM7sBeEEoc9qZZWEivu9YYCAbpNiaRVxV6dY8fQ4ZLtNnAcNv+s8t9J4zNI2DE6yLKp2NvcEqJTZ6ZurXqIlAXxC2AuNq/0PPVcme8qo7eLurLeuNbnL/yFmf7c3svTXdF2bFhJ4Z/YtlctW0ovWuVp/kHuUwkXZ9y6B8njF0hrNhhV/0L4b+i0e59EQ7daumOxouQ5EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MoBSCkKTywvQ8o4Hh3/8hti2am3zM/KoOwKHCTFJXM=;
 b=rfZCn7CadHm1a4yDgGVRd1L+rnWZi3FEaw5eAvv5P0dUdXklXaa1+/5AmKK8K1fiChqL7vtsCtW6g/LlOSDXNl5k/pci9FZISmD13Hs56axBGyxGS/obEo8G6l03E5WkGSxMVbAogo1EwaAVeRSEjUylA66U3Wpvq7we+1t1zTQ=
Received: from DM6PR12MB3993.namprd12.prod.outlook.com (2603:10b6:5:1c5::29)
 by LV8PR12MB9358.namprd12.prod.outlook.com (2603:10b6:408:201::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Fri, 24 Nov
 2023 06:35:21 +0000
Received: from DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::84b0:e6f4:7a63:a7d0]) by DM6PR12MB3993.namprd12.prod.outlook.com
 ([fe80::84b0:e6f4:7a63:a7d0%6]) with mapi id 15.20.7025.021; Fri, 24 Nov 2023
 06:35:21 +0000
From:   "Manne, Nava kishore" <nava.kishore.manne@amd.com>
To:     Conor Dooley <conor@kernel.org>
CC:     "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "yilun.xu@intel.com" <yilun.xu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "Levinsky, Ben" <ben.levinsky@amd.com>,
        "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>,
        "Shah, Tanmay" <tanmay.shah@amd.com>,
        "dhaval.r.shah@amd.com" <dhaval.r.shah@amd.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [RFC PATCH 1/3] dt-bindings: fpga: Add support for user-key
 encrypted bitstream loading
Thread-Topic: [RFC PATCH 1/3] dt-bindings: fpga: Add support for user-key
 encrypted bitstream loading
Thread-Index: AQHaHQbtT53kdGnijEqYhh3CEPIjE7CGjfuAgAJ15QA=
Date:   Fri, 24 Nov 2023 06:35:19 +0000
Message-ID: <DM6PR12MB3993F0EC4930E68C54299B36CDB8A@DM6PR12MB3993.namprd12.prod.outlook.com>
References: <20231122054404.3764288-1-nava.kishore.manne@amd.com>
 <20231122054404.3764288-2-nava.kishore.manne@amd.com>
 <20231122-exert-gleeful-e4476851c489@spud>
In-Reply-To: <20231122-exert-gleeful-e4476851c489@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3993:EE_|LV8PR12MB9358:EE_
x-ms-office365-filtering-correlation-id: f55a6893-d655-4508-7cbe-08dbecb7875d
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8iiYXFxwzJYR/2oVt9fGeyifw1UM5n2OL1JRvv7j4XBt7kIoxl/E36nm/Yk5Ta00PoTwBQO7NH7t+MW4/yKHXv4DW2BV2VqkaO+CBEo7dJqXv9/LWvROBawhPwGJqZTut3ntJh2/yf/ckhnj45O9BX6u3g9dq5/vD+maQP9j7An4RnaLxQrGyoMV0W5S8H73zsnbRHyg6CBAz0AYj2oEUcxt5n26+3Fcjdk+aDJPX9HxDYliliqHvz+ApFIWBhHqrRAdW7Zxezt7jR9TgU/aIBQ9XsXgKxkb4qLzcDKtaHgvOCA0CJdSr+gobtDpn6wCWdW4IqiqmLpc2266CAgkUUgGUiwrvILQef2+0E++sEHsd7+3T23+H9LKddtNTgB2Ij9n35KJi/Mj3rHDtGTmJEXHeT0/bzGYgpUfzMIj7nM23L9O/aVjqY3bOXTcdEt2Poxk6SIg9352CfQ5QcHXnKSzk/vdJHtuWe8f4fOYrFcwVyomEk76CkAA9e8UvOZTieWsGYIvfLDIscLnLqSl8IIBbevhM9xxXsU2XUQQNhj3ECw02CK7ykAqBSdL6pO8iXox9IkMOEgy4ExJDi/v5MDxf44N3hSPHypmMTeWAy1i1Zby9y/Xwfv+949nmfPE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3993.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(396003)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(83380400001)(38100700002)(86362001)(33656002)(38070700009)(122000001)(316002)(6916009)(8676002)(8936002)(54906003)(76116006)(4326008)(64756008)(66446008)(41300700001)(66946007)(66476007)(66556008)(55016003)(5660300002)(52536014)(2906002)(7416002)(26005)(53546011)(9686003)(478600001)(71200400001)(6506007)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bk91VjNENTJ3TFkzS3FQQ0NVWGplc0NYNzJ3bGlqN0VaaHB6TnUyMWZ5TURa?=
 =?utf-8?B?cXF3ZWlTSG43VGpYSWxxRExvcGE3VFNEaFJRNXNSMWF1bW9Cd1RPZG5icVBM?=
 =?utf-8?B?eUFDSlF5U3B6cXNTaWNoNCtyNEx6bGUxNU9oN2U2c0NsN2lLNWlhaTNjL1dQ?=
 =?utf-8?B?bkRRNEdsTm1CRUtweVoyY3BvS012b2dUdDlnak1mS040c3dWWmF2TlZtN1Q5?=
 =?utf-8?B?RDAzTElnbElNY291cXU4TnpIQ2FNTHdNMGxOREx4Wjkra0p3RzdIeE9WREl0?=
 =?utf-8?B?WkFYVXJld1l0VlpHc2Rmd0R6NytPbFJnb2xnODBPaVQ1Q3lXNTVEY1RDSnZB?=
 =?utf-8?B?VElQSTVuUGU0WEhNUDJONFpnZ1ZGWWZib0lBMmRvNmRtaXpRQXRKZWRPVWlD?=
 =?utf-8?B?L0UzQWJMc200UGZWa1VXS08wYTl5VTI4dU9CL3JGQkVtYWw2SU1YY25rRjdN?=
 =?utf-8?B?c04xUjBlb3VWUlY0L1JIT29wNWhWYW1SdXJqbkFQcWpmdDdxQzFsNXNscTgw?=
 =?utf-8?B?ajNCanFLNkZIQXBmQzVuTlZ1RjBVVGZSTE9pd3ZiMDBuMG51N1ZOaUg1L2hS?=
 =?utf-8?B?Q3RlSFF3dEpkbVF4cWRtS3IxbU95MStEb2dkbzVFcVdodUhteWRlenRpZlVD?=
 =?utf-8?B?OXdEOS8ySkdVdE5PRDh0YTU3K1I5NHQ5NVhWVGxmSUN2MlluZzI5RmYrbTZX?=
 =?utf-8?B?YkpHQWZqNHlmOXlCbjBvOVZ5bkF6ZzJtSUVub0R0RnlhWnNrUGlScGl4UEdY?=
 =?utf-8?B?V1VzUmp1d2ZnZk1yOUxTOHJMT1QzNHJIT3M0dGxUYTlYQmdzNUxSbWRzTzlm?=
 =?utf-8?B?YnMwc1hhMHJ0R0IwM1N3R253ZEZycEwvcExFcHRVeUVZeitNSDVCOEZpRUxL?=
 =?utf-8?B?RG9FSEd2TVNXS09IWnQxVjMzUUV2NjNMV3FUR2RxaU1nUWZSRVRWWjlKRUpR?=
 =?utf-8?B?dGRpSEN0TmJvQzlmUjBkNGt3OGRxMGhQYXZNUkVPUnJUcDYrQkZRaStGZGFJ?=
 =?utf-8?B?SHU4SVlWTUJ5b2JmT3BrNDhaVDV5TmFqNlVTWWxHdlFFcDRoc05yRkhMMEtX?=
 =?utf-8?B?dFp5RVFxdzE1Q2NuTzF4SmtleWQyeENCNElZOVdsL0kvcVBmVGdWbUgwb2oz?=
 =?utf-8?B?VGZtTW9UcGY1VVl3NEZHZkVTaDE1UEtSTWZDdEZVem5QNmpTUWpOdHU0bmdY?=
 =?utf-8?B?TExTMGJjL2dtbThEWnFoaXgyc1lxVVdlYzcwUUg4ZElEcHBDWXFXbEVocElj?=
 =?utf-8?B?TCtsaEl5SHhyRWpLVWV4ZlFMWklFSWZVRW02RG91OWh0ZkgrYTd3QnI3QkVP?=
 =?utf-8?B?cHA4RzdRbm9TK0JHdkVBc3lDeVlzdnAvTWpBR0VGRFhUam10cTE4K2tjdzdy?=
 =?utf-8?B?MkJRanI4U2RQcHlHZmREOGE3ZUtEd0JYa3hvZk5PV2hrVXRSalNubk9SSjh0?=
 =?utf-8?B?bFN1M0FoUDVRa09LQ041TFN2SVd4RW9JbEZ4bGJYcDVkbFlrMGYzZlN1UUE0?=
 =?utf-8?B?dGI5Q3kzZXZYQWN4dTc3VXErRkpJVkFDbnBjYXVTVHpMYlVoZFRsQTZSa2h6?=
 =?utf-8?B?QlQ0a1JQdU4xZnU0RWk5VkdiVTFkVGN3U0M0VjN4YXhXUkQwMXRDMTdMMzZz?=
 =?utf-8?B?QThrbENhaFBDblpxUXMxODlRbGs5UGliVFdITCtrL0o5SUFsVWVySlZPMitG?=
 =?utf-8?B?SDNSTzRKTDc1UGR3UTgzN0FvZW9Yd2Jhc08rWkNLRzVkZS90T0FJdVdpZ29O?=
 =?utf-8?B?RklCNElyY0NRR1pCVk5DYUpMUnpKVGJEa2UvOUFsN0VyeUswWG1QcFVQcWho?=
 =?utf-8?B?eFVjVldkTUdQR1pPTXYvVXc0dElraVJwSTFhRVpGRkxRNjNQM1cxdW4rODhM?=
 =?utf-8?B?Tmk5ZDB1L1BFTlNtQmZabGhWNUd0ZTJRU2h6WTd4allpemlwRkQ0OUJyZndN?=
 =?utf-8?B?UTRMWm9QWHJEMmtKVVdLQkpTcHJkWmRpOEVob1duZHNNTEd5YmhaeGFqSHlW?=
 =?utf-8?B?QmM2Lzk4dmdUQkllVkptZ3puOXlDdmpyajhxdUdMbmcwNGVoc2NNUjE4TTNi?=
 =?utf-8?B?RDM3aUt3ZjZLWUxmbWlKMlg2aXdibTNZUTlxTHNJNDFjek9xQThuWkRTb1lw?=
 =?utf-8?Q?Y7hM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3993.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f55a6893-d655-4508-7cbe-08dbecb7875d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2023 06:35:19.7010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XYKkmT2XFFbY+NBPUiiNi0Xd2byMdwcEyhI9V89FnAjAFmvVEayOVGtbOuuaVbbn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9358
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ29ub3IsDQoNCglUaGFua3MgZm9yIHByb3ZpZGluZyB0aGUgcmV2aWV3IGNvbW1lbnRzLg0K
UGxlYXNlIGZpbmQgbXkgcmVzcG9uc2UgaW5saW5lLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IENvbm9yIERvb2xleSA8Y29ub3JAa2VybmVsLm9yZz4NCj4gU2VudDog
V2VkbmVzZGF5LCBOb3ZlbWJlciAyMiwgMjAyMyAxMDoyMSBQTQ0KPiBUbzogTWFubmUsIE5hdmEg
a2lzaG9yZSA8bmF2YS5raXNob3JlLm1hbm5lQGFtZC5jb20+DQo+IENjOiBtZGZAa2VybmVsLm9y
ZzsgaGFvLnd1QGludGVsLmNvbTsgeWlsdW4ueHVAaW50ZWwuY29tOw0KPiB0cml4QHJlZGhhdC5j
b207IHJvYmgrZHRAa2VybmVsLm9yZzsga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3Jn
Ow0KPiBjb25vcitkdEBrZXJuZWwub3JnOyBTaW1laywgTWljaGFsIDxtaWNoYWwuc2ltZWtAYW1k
LmNvbT47DQo+IG1hdGhpZXUucG9pcmllckBsaW5hcm8ub3JnOyBMZXZpbnNreSwgQmVuIDxiZW4u
bGV2aW5za3lAYW1kLmNvbT47DQo+IFBvdHRodXJpLCBTYWkgS3Jpc2huYSA8c2FpLmtyaXNobmEu
cG90dGh1cmlAYW1kLmNvbT47IFNoYWgsIFRhbm1heQ0KPiA8dGFubWF5LnNoYWhAYW1kLmNvbT47
IGRoYXZhbC5yLnNoYWhAYW1kLmNvbTsgYXJuZEBhcm5kYi5kZTsNCj4gRGF0dGEsIFNodWJocmFq
eW90aSA8c2h1YmhyYWp5b3RpLmRhdHRhQGFtZC5jb20+OyBsaW51eC0NCj4gZnBnYUB2Z2VyLmtl
cm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IFN1
YmplY3Q6IFJlOiBbUkZDIFBBVENIIDEvM10gZHQtYmluZGluZ3M6IGZwZ2E6IEFkZCBzdXBwb3J0
IGZvciB1c2VyLWtleQ0KPiBlbmNyeXB0ZWQgYml0c3RyZWFtIGxvYWRpbmcNCj4gDQo+IE9uIFdl
ZCwgTm92IDIyLCAyMDIzIGF0IDExOjE0OjAyQU0gKzA1MzAsIE5hdmEga2lzaG9yZSBNYW5uZSB3
cm90ZToNCj4gPiBBZGRzIOKAmGVuY3J5cHRlZC1rZXktbmFtZeKAmSBwcm9wZXJ0eSB0byBzdXBw
b3J0IHVzZXIta2V5IGVuY3J5cHRlZA0KPiA+IGJpdHN0cmVhbSBsb2FkaW5nIHVzZSBjYXNlLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTmF2YSBraXNob3JlIE1hbm5lIDxuYXZhLmtpc2hvcmUu
bWFubmVAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvZnBn
YS9mcGdhLXJlZ2lvbi50eHQgIHwgMzINCj4gPiArKysrKysrKysrKysrKysrKysrDQo+IA0KPiBJ
cyB0aGVyZSBhIHJlYXNvbiB0aGF0IHRoaXMgaGFzIG5vdCB5ZXQgYmVlbiBjb252ZXJ0ZWQgdG8g
eWFtbD8NCj4gDQpJIGFtIG5vdCBzdXJlIGFib3V0IHRoZSBjb21wbGljYXRpb24gaW52b2x2ZWQg
aGVyZSB3aHkgaXQncyBub3QgY29udmVydGVkIHRvIHlhbWwgZm9ybWF0Lg0KRHVlIHRvIHRpbWUg
Y29uc3RyYWludHMsIEkgY291bGRu4oCZdCBzcGVuZCBtdWNoIHRpbWUgc28gSSBoYXZlIHVzZWQg
dGhpcyBleGlzdGluZyBsZWdhY3kgZm9ybWF0DQp0byBhZGQgbXkgY2hhbmdlcy4NCg0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9mcGdhL2ZwZ2EtcmVnaW9uLnR4dA0KPiA+
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ZwZ2EvZnBnYS1yZWdpb24udHh0
DQo+ID4gaW5kZXggNTI4ZGY4YTBlNmQ4Li4zMDkzMzQ1NThiM2YgMTAwNjQ0DQo+ID4gLS0tIGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ZwZ2EvZnBnYS1yZWdpb24udHh0DQo+
ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ZwZ2EvZnBnYS1yZWdp
b24udHh0DQo+ID4gQEAgLTE3Nyw2ICsxNzcsOSBAQCBPcHRpb25hbCBwcm9wZXJ0aWVzOg0KPiA+
ICAJaXQgaW5kaWNhdGVzIHRoYXQgdGhlIEZQR0EgaGFzIGFscmVhZHkgYmVlbiBwcm9ncmFtbWVk
IHdpdGggdGhpcw0KPiBpbWFnZS4NCj4gPiAgCUlmIHRoaXMgcHJvcGVydHkgaXMgaW4gYW4gb3Zl
cmxheSB0YXJnZXRpbmcgYW4gRlBHQSByZWdpb24sIGl0IGlzIGENCj4gPiAgCXJlcXVlc3QgdG8g
cHJvZ3JhbSB0aGUgRlBHQSB3aXRoIHRoYXQgaW1hZ2UuDQo+ID4gKy0gZW5jcnlwdGVkLWtleS1u
YW1lIDogc2hvdWxkIGNvbnRhaW4gdGhlIG5hbWUgb2YgYW4gZW5jcnlwdGVkIGtleSBmaWxlDQo+
IGxvY2F0ZWQNCj4gPiArCW9uIHRoZSBmaXJtd2FyZSBzZWFyY2ggcGF0aC4gSXQgd2lsbCBiZSB1
c2VkIHRvIGRlY3J5cHQgdGhlIEZQR0ENCj4gaW1hZ2UNCj4gPiArCWZpbGUgd2l0aCB1c2VyLWtl
eS4NCj4gDQo+IEkgbWlnaHQgYmUgbWlzcmVhZGluZyB0aGluZ3MsIGJ1dCB5b3VyIGRyaXZlciBj
b2RlIHNlZW1zIHRvIGFzc3VtZSB0aGF0IHRoaXMNCj4gaXMgYW4gYWVzIGtleS4gTm90aGluZyBo
ZXJlIHNlZW1zIHRvIGRvY3VtZW50IHRoYXQgdGhpcyBpcyBzdXBwb3NlZCB0byBiZSBhDQo+IGtl
eSBvZiBhIHBhcnRpY3VsYXIgdHlwZS4NCj4gDQoNClllcywgdGhlc2UgY2hhbmdlcyBhcmUgaW50
ZW5kZWQgdG8gYWRkIHRoZSBzdXBwb3J0IGZvciBBZXMgdXNlci1rZXkgZW5jcnlwdGVkIGJpdHN0
cmVhbSBsb2FkaW5nIHVzZSBjYXNlLg0KV2lsbCBmaXggaXQgaW4gdjIsIHNvbWV0aGluZyBsaWtl
IGJlbG93Lg0KYWVzLWtleS1maWxlLW5hbWUgOiBTaG91bGQgY29udGFpbiB0aGUgQUVTIGtleSBm
aWxlIG5hbWUgb24gdGhlIGZpcm13YXJlIHNlYXJjaCBwYXRoLg0KCQkgICAgICBUaGUga2V5IGZp
bGUgY29udGFpbnMgdGhlIEFFUyBrZXkgYW5kIGl0IHdpbGwgYmUgdXNlZCB0byBkZWNyeXB0IHRo
ZSBGUEdBIGltYWdlLg0KDQpSZWdhcmRzLA0KTmF2YWtpc2hvcmUuDQo=
