Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A687FF4F0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjK3QY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjK3QYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:24:25 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D347196;
        Thu, 30 Nov 2023 08:24:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHg1Pq53hxGEoFy6JsKH+TI6VX7hKWkvO64pDxwhw1FJkfgfTy3HNnHzak7sz4fhV9lSnMBORXEtOWO7AciHMSd6ZRQDOWnQ4Yp3xBnVsPN2+4hwx8kbqoUqI+9ErtKqDd4OK6Z84o24qzGdNEyCDb/BJOz3KhQYGOxik2PKl0DWBhBS7YE6/3UmsqD13MP5U02oniK8GRel/W/WS2Al0QgEnLbvOyf3LnimYM0dVbZC5Oc8FodhD9tPNrIUNl1bMOAqFcDEiCow1sykw3rmx6JHdNkWEBAdLGKwfA3r9DJMV+1RFtAQSGBQzDkDDeAsbh/SXUJ/e5Ek6PR8+Po26w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOMhi43pDGeHyx/gNPb4L0elIN9+vRL8EiLUknPi9qA=;
 b=MV6zFcjQY4PTxGqVCKxWgsrCrM60uv2FiNdB060QV8HPS2HdAd7Dd3iN+MvLyTpRaOYILT5NzJvk7Gnu+daSvLvnQ92NWLl5Ncd0R08QtNimzkXKRwNXaFhcJDwMyxSVmiP8GQzIwM50jOMwniTCsm9+RjKjcy6ymH3SYeYgdmWFRrlK9qhddMnQGxYx1DvX6vOQY03fewFfNQuRJ06aH5V3N0DzbmnyMrPnxf1J7kuzbuhu2lsTFiJE2QLvLMah3ZHeoiBgyPqhmLUciye4MXV3E1QH32pdbMGP1F59wqd0lyVXlHCh31HGlrURT2EZhkfloGKaX9XJDSiT0WXbng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOMhi43pDGeHyx/gNPb4L0elIN9+vRL8EiLUknPi9qA=;
 b=uebhcLpBCmF6Dp2XGg8PG+H79OFRUkW1RpuphqDf75v7Qprfomo/9khyQVaTm+H9cANMAY3at3IqEBx631wq3fsf6N6l1iXr1CO0GmENA1UesCLORN/K7YjL/KSD5WADt54Wrecxzb7ZSPmHR30kUs0I2wNcBTTMbHcVXmlIHTcA42awvU9UI2JNlHxdHkGRMuPDH9E/vg+7gAtVtt5NnA6LU8lb+DQ8WqHV62PLWhMnjE2FER002WynYGEP6xjoh+3VuhtPLi1ALRqUVYCzeTinRR5lKjuR17Na9FOIqrTy0Cpmg5Y0v0BVwjHM9aq8eSq80x+Nr5ewujYscG2QhQ==
Received: from BN9PR12MB5381.namprd12.prod.outlook.com (2603:10b6:408:102::24)
 by BL1PR12MB5079.namprd12.prod.outlook.com (2603:10b6:208:31a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Thu, 30 Nov
 2023 16:24:27 +0000
Received: from BN9PR12MB5381.namprd12.prod.outlook.com
 ([fe80::a02:fa08:8729:c1bb]) by BN9PR12MB5381.namprd12.prod.outlook.com
 ([fe80::a02:fa08:8729:c1bb%4]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 16:24:27 +0000
From:   Vadim Pasternak <vadimp@nvidia.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Yu Sun <u202112062@hust.edu.cn>
CC:     Hans de Goede <hdegoede@redhat.com>,
        =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        "hust-os-kernel-patches@googlegroups.com" 
        <hust-os-kernel-patches@googlegroups.com>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Dan Carpenter <error27@gmail.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] platform/mellanox: mlxreg-lc: Check before variable
 dereferenced
Thread-Topic: [PATCH] platform/mellanox: mlxreg-lc: Check before variable
 dereferenced
Thread-Index: AQHaI3IAXNMSfTcbw0m69hFV3lr+TLCSvxgAgABMu6A=
Date:   Thu, 30 Nov 2023 16:24:27 +0000
Message-ID: <BN9PR12MB5381385579AF6DC7C9E63640AF82A@BN9PR12MB5381.namprd12.prod.outlook.com>
References: <20231130094409.3963-1-u202112062@hust.edu.cn>
 <4109f017-f07c-4755-bc1b-ec4cb30b0760@suswa.mountain>
In-Reply-To: <4109f017-f07c-4755-bc1b-ec4cb30b0760@suswa.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5381:EE_|BL1PR12MB5079:EE_
x-ms-office365-filtering-correlation-id: 01c6ad2f-f725-4eb8-dd50-08dbf1c0d2f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3gaUaSMJiDO1Jz+8HfVL2Z6nFst+5bAh0ixervOyBAmdLTGG3k+A/Y6N/k4tAbh61t77PjGY+ZN1nANPkUmTRufTKLvpSQ29BfgR6NYNIK4XWXesXVDgxeWxMjbYX0lAVkrnMZlpMtQISiQQi3IRp04Lw7OhctYeoDSk818z5tQ2PoGXNuGukwKs6gbrrhRiQn806pY/oe+YsT859RiB5o5I5ffA42f30vbQ2rM1l3neszNWaiZOSicGc1N1rXpomTjiAPsa1njf+AL/82ukUbHIFEycwwUYLOIAteysg4wZ83NTUDBLGnBn/kZJW+PgCtVM0lVuj2oErppd3IwZV6nwCe2g5rAZssCV7GdNv9W8u8ZwGd2IRKVbjO59aNEU51My7o3rwhGCcpNYCIrrfiAt+9tz20kl9VL5yhY9QcqUljtZh2+XTYYyCmxyo4L8H0OrkgydcSMrE7KSnofocUMKezW99ZRJ95yWLfbecxLcLqmvIbthH9iUIYCV9SB1USHD0IALRnKuta3vEzAi5iSLSpKn7mexxebca/L7pPavc5Kig7lU+6NInUJLeZXf4RiO2wX7Tni1pnBarj4w/F6i7YRkcf74SG2xAXi0oUYcg7EJjjGLU65eByINAhFh1wpQHNvi/wGn2cu1g29yTyHBqBT3rxiCWlBtjLqdg5PmZJEEAKMe7m5GN9JQVbIb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5381.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(39860400002)(366004)(376002)(230922051799003)(230273577357003)(230173577357003)(186009)(451199024)(1800799012)(64100799003)(66574015)(55016003)(122000001)(38100700002)(7416002)(83380400001)(316002)(2906002)(5660300002)(4326008)(86362001)(110136005)(52536014)(8676002)(8936002)(66476007)(66446008)(66556008)(64756008)(66946007)(54906003)(966005)(7696005)(71200400001)(9686003)(6506007)(478600001)(41300700001)(19627235002)(76116006)(53546011)(33656002)(38070700009)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWp2SEJ6OEdGQ2cyL3gzM2NNS2F1TS9iT1kwNVJmMGRPa2FVUFNXMHg3V1l4?=
 =?utf-8?B?dHdralpFaCsyMG55dXpGZWF0N2djUXFwTkwzNzNLekxZcmx4ZU8rWTFMcWJN?=
 =?utf-8?B?cXZnT0p2WWZLV2hTNGxuckJCQ3FXNTdrd0F1UzVLV2RidlljNjBNczI4a1NR?=
 =?utf-8?B?Umlxak5RRDByTEIyOHBmcVJRVHl6V2RtcDVRZkdzU2hwNlZCRjVOejdpOEdM?=
 =?utf-8?B?SGt0dGhUZnNCVEZQMndHRmRaQ012dEJhbzFxUyttc2xEaC9kUXA0cmpodmtx?=
 =?utf-8?B?c0luK3ltdjR5UzZLZllVcXZaUlNCUDNmVGcveXZTSGZLTGJTTnpndlBWQWdk?=
 =?utf-8?B?ZlVNd3VXWUhTZ0tVdjFYUjYzbmRxRWZPR1lTWnpMbXp0Zm00cFJCWHJLQ1F0?=
 =?utf-8?B?ODBDREZNa0hOamJkSllweUZlbk1PSWpuVnY3QjZLeVE5RllFNldXOUxGZmti?=
 =?utf-8?B?eWNlVUZKdWlGVlYvazFZd3d5dG92bFgwaE1ZZlZSYTNSY2dnZnBVWXJaZkdP?=
 =?utf-8?B?K2J6ZFpNQjZFc1VXVjR3WFZ5aEgrL1dkemc2RXZuSnplelQ2WWZzMlRSYTJm?=
 =?utf-8?B?WmRXcjdyNWVQU1FxbmEwV1lQYURGNWNRMHA1WTFoU1RSNFgzdlV1RVE4SmJh?=
 =?utf-8?B?MGxlU1pzZ2UvS0YvSmY0dzNmVWJaN01nU1I2ajdjTlV1L0xQeG56eHR6S0hp?=
 =?utf-8?B?eHFXUVI2T2IvVyt1VzhPb0FXMHNXZWpoUWhuQVRwNUVsV0Z6VExoQzdncHV6?=
 =?utf-8?B?c2dSYzhtby8wNzBlaTNtVFFsak9sZHkxS1hSRkdSN0RIcWhrRWhBbFNnTXBF?=
 =?utf-8?B?dVVqL3R2ZStyblRFNUdjNjFtRkI2NDNxWDV4NGNxQzNRUkZHaVluaXpkZnYv?=
 =?utf-8?B?V2JqTjFBZnorOVBrcXVDaS91blBGVFFhM3ZhdXkzQU1aVzF0ZHVmNW9zb3lG?=
 =?utf-8?B?ejVROHFaNzFnRWwyWjlPZjdjVXNJSVpvK1ZWMkx4M0ZyaVFHNmdRa3JvcStR?=
 =?utf-8?B?bmlSSms2a3FkMk5LY2lNVjBEZGhBNGVNOTh2bHFPSTE4RXd0aGNxNVZQMlRy?=
 =?utf-8?B?QzY4R2ZyOW8yK0J5aENlTHZxZE9uckhyMjRLRzlFNTl2b05WTWcwcDFGS3Ev?=
 =?utf-8?B?QzNLOTV0WmU2YlpDUUN1dkpydisxemlYNmVXTW5zS2I3aDdXdmJWM1FraTQ0?=
 =?utf-8?B?WlZPYndrMk5Lekd2Y0pBbzl6NmNkanU5alp5WDcxQU5yQ3dsanpZY3JnTS8w?=
 =?utf-8?B?Q0VKNUpheHA1THQvUDlZcTFuanVPclEvL21HNnUyTzJ5M0pWclpCYmxVQ05Y?=
 =?utf-8?B?SFo2UG9uc05Ud3R6dDNkOU1vRDRza09odmJYVmorNVhYUXFieHpxN3BaZnIv?=
 =?utf-8?B?d1IzSTR4RTFnZDhrczdMOGVRNjgzYlY3RGhPWTF2UWJWMHhBdVBnVG0wL2VQ?=
 =?utf-8?B?TmJxakJwa0ZMZHAwSWFiUmlkMmFlb3RhSGF5WTc5Z0Q5b0g5SUM1VzlDMjVx?=
 =?utf-8?B?K05OaUZySEMwRVppWHdzQ0xQNEtnV2o2K2owQ1IwV3hNcy9SQXlpS1Rpd1BM?=
 =?utf-8?B?dStRY1RIV3pLM1lYVXl4UUpycFVEL3dBSFhoR3ZXRXhPa2NZVlkrdjI3U0JU?=
 =?utf-8?B?NlVPc1dnQVp1S3ZGWmpPNTZLTml5UjlCS2V4cEsrMXNQY2FSRGxrSlZVWXps?=
 =?utf-8?B?Y1h0UGdIWmVPUWlUQ2JrMHNkMmhkeFREV1pDUnY0WVBua3daRDIyaWxiQnlo?=
 =?utf-8?B?S1k2ZFJ6V0xiVFM5dmZzbERWWGZpT1VVZnhObGZtUjdhNFpLdkl6M21xMVhx?=
 =?utf-8?B?ekdGYUs3SmJ6eGtTV2xreExTRzRpcEhsN0twSkFxMmxSL1pCSm1OREt1VjRh?=
 =?utf-8?B?OE11QkJSeUpmdEJsVlhxbWc4R0R5c0pRaTR2Wi9YS2tSRjVGNEx6LzdDSHR1?=
 =?utf-8?B?Z091YnlQeXZxMDFhZEVTV3Y5Q2RkSlZqengwak8zQ3VYWWRtcGl1ajBROEVx?=
 =?utf-8?B?N2labVZCc2xhYzl2cmhaWERhZDNmSFBEUUtrMXExNEw2S1V4MENUTjRlb3Jt?=
 =?utf-8?B?aEd3aTdRNkJyY2h0dFNtQ0o1bER3QWU4UGRnQThCK3hGYU9Rc3RFVnV3b3R4?=
 =?utf-8?Q?e010=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5381.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c6ad2f-f725-4eb8-dd50-08dbf1c0d2f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 16:24:27.8051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V6663JEE9e0pQWNg6cXSDEApLDdyWmMqpWvNfn8yuZ7L5LExDHUtuS+cMJKpwZd7axGFF/dt+1spDWiMFwVB0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5079
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhbiBDYXJw
ZW50ZXIgPGRhbi5jYXJwZW50ZXJAbGluYXJvLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIDMwIE5v
dmVtYmVyIDIwMjMgMTM6NDcNCj4gVG86IFl1IFN1biA8dTIwMjExMjA2MkBodXN0LmVkdS5jbj4N
Cj4gQ2M6IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+OyBJbHBvIErDpHJ2aW5l
bg0KPiA8aWxwby5qYXJ2aW5lbkBsaW51eC5pbnRlbC5jb20+OyBNYXJrIEdyb3NzIDxtYXJrZ3Jv
c3NAa2VybmVsLm9yZz47IFZhZGltDQo+IFBhc3Rlcm5hayA8dmFkaW1wQG52aWRpYS5jb20+OyBo
dXN0LW9zLWtlcm5lbC0NCj4gcGF0Y2hlc0Bnb29nbGVncm91cHMuY29tOyBEb25nbGlhbmcgTXUg
PGR6bTkxQGh1c3QuZWR1LmNuPjsgRGFuDQo+IENhcnBlbnRlciA8ZXJyb3IyN0BnbWFpbC5jb20+
OyBwbGF0Zm9ybS1kcml2ZXIteDg2QHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gcGxhdGZvcm0vbWVsbGFub3g6
IG1seHJlZy1sYzogQ2hlY2sgYmVmb3JlIHZhcmlhYmxlDQo+IGRlcmVmZXJlbmNlZA0KPiANCj4g
T24gVGh1LCBOb3YgMzAsIDIwMjMgYXQgMDU6NDQ6MDdQTSArMDgwMCwgWXUgU3VuIHdyb3RlOg0K
PiA+IHRoZXJlIGlzIGEgd2FybmluZyBzYXlpbmcgdmFyaWFibGUgZGVyZWZlcmVuY2VkIGJlZm9y
ZSBjaGVjaw0KPiA+ICdkYXRhLT5ub3RpZmllcicgaW4gbGluZSA4MjguDQo+ID4gYWRkICJmb3Io
ZGF0YS0+bm90aWZpZXIpIiBiZWZvcmUgdmFyaWFibGUgZGVmZXJlbmNlZC4NCj4gICAgICAgIF5e
Xg0KPiBTaG91bGQgaGF2ZSBiZWVuICJpZiAoZGF0YS0+bm90aWZpZXIpIi4NCj4gDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBZdSBTdW4gPHUyMDIxMTIwNjJAaHVzdC5lZHUuY24+DQo+ID4gUmV2
aWV3ZWQtYnk6IERvbmdsaWFuZyBNdSA8ZHptOTFAaHVzdC5lZHUuY24+DQo+ID4gUmV2aWV3ZWQt
Ynk6IERhbiBDYXJwZW50ZXIgPGVycm9yMjdAZ21haWwuY29tPg0KPiANCj4gSSBkaWRuJ3QgcmVh
bGx5IGV4cGxpY2l0bHkgZ2l2ZSBhIFJldmlld2VkLWJ5IHRhZyBmb3IgdGhpcyBwYXRjaC4NCj4g
aHR0cHM6Ly9ncm91cHMuZ29vZ2xlLmNvbS9nL2h1c3Qtb3Mta2VybmVsLQ0KPiBwYXRjaGVzL2Mv
YzVoVWFZSURjSUkvbS9oNGFGUzdQa0NRQUoNCj4gSSBhbHNvIHNhaWQgdGhhdCBJIHRob3VnaHQg
aXQgbG9va2VkIGNvcnJlY3QgYnV0IHRoYXQgaXQgbmVlZGVkIGEgRml4ZXM6DQo+IHRhZyBob3dl
dmVyIHRoZSBGaXhlcyB0YWcgSSBzdWdnZXN0ZWQgd2FzIHdyb25nLg0KPiANCj4gTG9va2luZyBh
dCBpdCBub3csIHRoZSBjb3JyZWN0IEZpeGVzIHRhZyB3b3VsZCBiZToNCj4gRml4ZXM6IDFjOGVl
MDZiNjM3ZiAoInBsYXRmb3JtL21lbGxhbm94OiBSZW1vdmUgdW5uZWNlc3NhcnkgY29kZSIpDQo+
IA0KPiBUaGF0IGNvbW1pdCBzYXlzIHRoYXQgdGhlIE5VTEwgY2hlY2sgaXMgbm90IHJlcXVpcmVk
LiAgU28gbm93IEknbSBjb25mdXNlZC4NCj4gT24gdGhlIG9uZSBoYW5kLCB0aGUgaW1wdWxzZSBp
cyB0byB0cnVzdCB0aGUgbWFpbnRhaW5lciwgYnV0IG9uIHRoZSBvdGhlciBoYW5kDQo+IG15IHJl
dmlldyBzdWdnZXN0ZWQgdGhhdCB0aGUgTlVMTCBjaGVjayBtaWdodCBiZSByZXF1aXJlZC4NCg0K
WWVzLCBpdCBpbmRlZWQgcmVxdWlyZWQuDQpNeSBtaXN0YWtlLg0KDQpUaGFuayB5b3UgZm9yIHlv
dXIgY29tbWVudHMuDQoNCj4gDQo+IHJlZ2FyZHMsDQo+IGRhbiBjYXJwZW50ZXINCj4gDQoNCg==
