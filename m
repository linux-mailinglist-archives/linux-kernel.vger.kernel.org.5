Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553BA7EC10B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 12:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343548AbjKOLBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 06:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjKOLBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 06:01:15 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2078.outbound.protection.outlook.com [40.107.8.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B88E9F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 03:01:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaVl6y40hqlcDPpHhRsrvPzsjh2eKMBuUjc8YSjsad4GtEC7tZ8dow8pZB9pyjao0rMjp5diWa4GJO2HIg7+hzBJwVjBnNjyjbcVyFIEGadxpiWJn9xscus5bYweusaqImCS4f/t2WtM1mGg3A47IxMkYIRKML9a6dQ2wJwvpbX8xcw9JEIbSh+3MfEkWd4spMHiR75Z2SLgIor0CQYwiEajX8aunCz2x5QycndVG8Beqi7/V1tScBSddJDENZOm0QoWLkZuk3wuR1S68nkd7w9yGBxJEpF/ZZOtIWfhSP4gQFDO+jI6/mPMynkPL/2vAKY5nLyguC4eSa607MJ/Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSuHpc3c1Tw3OckWlmrCuT7dZZyQFQ0h63QNL1DV+ew=;
 b=XRpHFhRs6VOi/kSReTt7/9aqfygnKTz/Vsavj+WS8F1fCR55BFXWd/7slAsW8c2t/sOnP4y3COncjp01YAYBzkEuiVS+s8cBh0HZGqaYT9EZPQk0ScH0c86r0e3NiTkPJnGZsOo2HKUDiZ8yWRfu5ON71jjYZuTZJzhhDoumgsPNjAhOkX1JvTM34Pa6MYgqirdLF3sKYq7t7cTxFZng4TmiMEsqjP84EoD3rOzCiSvsWu8/vHbD9eq58OX9p/BE6yPQjBqtNgiHsGfTBhiHwKwiVCWMbOnXimREQwlptzQT63mwdzvkuhLQs1SSXZlw0bk0ipsiINBzIYcccZnQ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSuHpc3c1Tw3OckWlmrCuT7dZZyQFQ0h63QNL1DV+ew=;
 b=ggif7s4lsI++nsjifJxdKLSctzv36CxbfE5ixNphWE0lGmXSN8iP0oqO5mrCAoig0Tykg205TVexfru1s38X/WzliW7oY7nGBRmcWajzZONK4cLFKcKw8WDxj/yfVBAzKXF+ryJ+nXaLdNvLL/vHRP07KWjNWtqATxSQABt6u6U=
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com (2603:10a6:10:368::16)
 by AS1PR04MB9429.eurprd04.prod.outlook.com (2603:10a6:20b:4db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Wed, 15 Nov
 2023 11:01:09 +0000
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::4f4c:ffd8:df89:52dd]) by DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::4f4c:ffd8:df89:52dd%3]) with mapi id 15.20.7002.015; Wed, 15 Nov 2023
 11:01:08 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "treding@nvidia.com" <treding@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] iommu: map reserved memory as cacheable if device is
 coherent
Thread-Topic: [PATCH v3] iommu: map reserved memory as cacheable if device is
 coherent
Thread-Index: AQHZ8I3HiIHmrRZNfEG+V4NHz2FFh7B6THUA
Date:   Wed, 15 Nov 2023 11:01:08 +0000
Message-ID: <DB9PR04MB93804D3ACA821792A5D2E94EECB1A@DB9PR04MB9380.eurprd04.prod.outlook.com>
References: <20230926152600.8749-1-laurentiu.tudor@nxp.com>
In-Reply-To: <20230926152600.8749-1-laurentiu.tudor@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: DU2PR04MB9211.eurprd04.prod.outlook.com
 (15.20.6977.003)
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9380:EE_|AS1PR04MB9429:EE_
x-ms-office365-filtering-correlation-id: cd9c69f8-a4ff-4bd3-c69d-08dbe5ca2bef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dYVP3x4Ox1quqzuJw6oN5trAAJF/3r00db+wXlB2KznyDFaZMRiK8Y3uUDJ95947tfmq67XYAhmJEa0lCZFy2n2v68EoUmR4TD/lqK+m1SM8cvGQxRtq60/ERZl5/88TuiX4Dmh0UIRKUTGWgWZVnJiYrH1pmsxpl7or6fBHaCISt/rsgY4eAWP4710Nn+7733g7LZeAtfM4ljy0BCj1bwNoe/ssqk2URv9agxNXMOc9ctsiS9741ubiK5UlaSfd5bwHYV8frU7fblMGkoLiVe2nIhHTAbfGYv0N6JOYhUdWxUcy0y4cC0BuXnndLxLaKBnVJNTk/0hxu7yxOAJei9In4wzG3413bCjHvjd7BxsOIHTBdvgL/z4qJlUqbLVYhgzL1d+i2VQUZJEwuNnIFEoxKPsJrwGAIcQpGG7ildJP4oi1TXeQtfLCJ4cvMBqUWvNCU+5dccTHuylCObX2oj4mrz0Wvkm9Nv3H4uThav9amkonVltvo0tiKuDVsiVKdPcMNqwtxNQkztDolcHTLgV4GG4QZFf9hRQXMTewQdGAb81LeY1V82SLiWFYbZT17fr8k4St5itRZIR6GL2OEqte3bcjRBHrLaTELT2h/0Q/4R2O15jLPOm/RhspDWjxvn2MAgE8uOxiu3MgKLgGaT9kureTqGeHrx65BfbGCKY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9380.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(346002)(376002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(55016003)(8936002)(8676002)(2906002)(66556008)(5660300002)(83380400001)(52536014)(44832011)(966005)(38070700009)(66476007)(64756008)(316002)(86362001)(66946007)(33656002)(66446008)(41300700001)(38100700002)(478600001)(55236004)(53546011)(6506007)(7696005)(71200400001)(9686003)(110136005)(76116006)(26005)(122000001)(65966003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUFway8ramFocUo2UGdJWXhpdnIvVnA3OTlUQnBNUnhtNTVKMUVDOGxPR09V?=
 =?utf-8?B?blVwTzgySTM5YkRqYVlNaXRlZ1A0KytRdU5Fb1pVUGVMVUtOOXh3UkJiVGc5?=
 =?utf-8?B?K282SXd2NGdCQlhod2dJSnhaNEM0WVZVZlpnM0RGd1NXcVVkUUxKcnhVNDJ0?=
 =?utf-8?B?eWFrc2NySC9tMm5JVFMzMVlIdkoveGRmbXBiaDFtR0Z4RkFxYTA1VEVlcWhv?=
 =?utf-8?B?VktDV1cvZjNwYzZvSUphQ3N6OGdYeHhWbm83RUdHTVAyOXlSNjllNWFDS3hV?=
 =?utf-8?B?b05JSEZoNmp6N1JVY0I3Sy9BNndGV0t0Tzl0RFhIaXpFYlF0ZENVOVAvUWhp?=
 =?utf-8?B?UVluWUw0SVdTZDV6SEppMlZkN3hUSmlUVldNbDFScW1BWHk0UlAxZnA5U3Bw?=
 =?utf-8?B?QTRvSFVYSytmNXFVMkd4N0NGeU8xTGNsUDM0ckFLQmdVbmdTUHlKSDRkb3kr?=
 =?utf-8?B?QmRvS3VlRGpIL0p1WVVqVnN1QVJRUHo1MVRQRmJtSjdNcnRjTnF3eUpUQ2Z4?=
 =?utf-8?B?c29wT3lJdSthTWZwWjRrbG1lanlITndZMjFRM2ZLWE8ycGY5ZlNrMWNiMlFl?=
 =?utf-8?B?TkMzTk5BQkMrbUFIZjh3K3F6bTBBSlcvanFxazJDQkxIbHVlRi9LVlZSNlBY?=
 =?utf-8?B?S0tnOVRJM3pWcVJjczIzQUdUZG9ySWRNMWF2SEVyU0taaElXeTFqdzEwb3BK?=
 =?utf-8?B?L2JTRFF4STZkQi9uamN0YVdJZjFRamUzb0FwTmd2MkNnbThhT21TZUkxTXFE?=
 =?utf-8?B?bWxia3hQak1xQ3drN2RsOThJajNZMFVPYloydGYzQWtKWFJEaHNSSzhjM1Z1?=
 =?utf-8?B?YjB0Qms3V1J4Z0tkNGRYUVNuengwamxqc0ZvUHp6ak1EY3JpbXhwQ25DYmRm?=
 =?utf-8?B?OWdYRnhOd3NnZGk0UkRJU1VrVWgvZUY5ajZ1Z1JWUUtkT1d4cXF3U2FaZUUz?=
 =?utf-8?B?dlhTZkN6L2ZhRHVoUTJBNmF4Z1phTmx1akppRno4TUhzU0kxbSsrL3piUms2?=
 =?utf-8?B?NjZUd0xMdDRNZUNDVU1DOVBWZ3BJRi9rRkk1UzRueit3WjdlR0xRdGpzTGtG?=
 =?utf-8?B?YzAzZkY0LzIvVUNqT2hOUHFFeWU4TXFlYit0WVd3OURjZGU3VlArd0Zkckgr?=
 =?utf-8?B?cEdtcUUxY0xKZ1lQTFlzVnRTcS9tcHhmQTEyOUZGUElQeG5oWXg0Y1QyNzYw?=
 =?utf-8?B?WEJYdHB5SURxcE1FQzFPZG9zS0pHRWdzb0M3TkJ2eUpzTDJtVXJMWGZLMUdV?=
 =?utf-8?B?M0FPeGpyOXo3SGhOTDRDaS9kR2c4ZDJBbFVwTGVRT00xN204S3F2cG5PUnBn?=
 =?utf-8?B?VEpGUE43czFQYytuV1Rlc1Rhc0FhSytTUlNYaU5QVmwzT0RDZDlHU09pNFM2?=
 =?utf-8?B?QjdsZ1dsajA0b09MRkhmWnkzbW43RVYzS0U2RU5UT3ZJaTVNMnkxRTEvSFRj?=
 =?utf-8?B?Y3VPa1dCZUROekJ4aGgzQWZEcDZDVEFCUUxMeWswbzFzTDVHRlY3b1Jqa0do?=
 =?utf-8?B?VkNJNGdXNHBYRWQ2YmxUbE9nMDROSllZS3VTWlFOTGE1TGFYK3lZZGYwWEVG?=
 =?utf-8?B?M3pjNUxzZ3d5YXBVRURnTys4ODBnVXR0dklIbERRdkppM1FVODQzQ09WRWl5?=
 =?utf-8?B?eHJsZVJhQWkyODdxTG1scXdvSXM2cW44dVR1aEhZZ1VCSnJvaDM0TGxBWmc0?=
 =?utf-8?B?WjhmbEVBdkJjbHVNbFJ0eCt6ZGFSZTlnQlROOXRKK2swK3RtMUtwelJUNUU2?=
 =?utf-8?B?M2FCN2ZtQTZDaklOb0p4cWpmVDNIcVF5MFFUNGROU1ZqOXVRV3M0UHZDMWtr?=
 =?utf-8?B?cVZnQ1Q1K2doVWpvY2hUY0JMOVBJWWZlRHZ2S3dRcnkvSHhzak1PWWkwaU1x?=
 =?utf-8?B?S2EwRGZLaXVKc1FwbzQ2RjF2V3RGdnVTSmVTZkVVazJsYUhUTWIxU0V2UHBa?=
 =?utf-8?B?WmFDQWhxc3U3L2FacmZsVXFZYzYzRUFJMTlwSk5NYlFOcXEzczE5U3NUZlVY?=
 =?utf-8?B?cFhDQlAzS1NIQ0RoNy9PajVFbS9EaktLNTRnNXlpT0x2QndmYnp5aTFWNlRL?=
 =?utf-8?B?WlI2ZkxwbUZEQzN2RklmWm5abWFtZHA5WU5XaytyYlp5WEdzNmRDN0ViWEg3?=
 =?utf-8?Q?kJ9y7tzufP2U0/kZFjFB0wdPS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC429AC62DDA1E4CA8B1A48305EC2D60@NXP1.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9380.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9c69f8-a4ff-4bd3-c69d-08dbe5ca2bef
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 11:01:08.6082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4JPe16cKXpX2SAJVNLbXwVmvrliXAOGRV0FbtWwJxMOcpOAN8bdRHmIlEj6JTLz2xifdlOOkiEZ9Tak1+i2xnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9429
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCkFueSBjaGFuY2Ugb2YgaGF2aW5nIHRoaXMgcGlja2VkIHVwPyBJdCBpcyB0aGUg
bGFzdCBtaXNzaW5nIGJpdCB0byBmaXggDQpib290aW5nIHZhbmlsbGEgaW1hZ2VzIG9uIHNvbWUg
TlhQIHBsYXRmb3JtcyAoTGF5ZXJzY2FwZSBMWDIxNjBBLCANCkxTMjA4OEEsIExTMTA4OEEpIGdp
dmVuIHRoYXQgdGhlIGJvb3Rsb2FkZXIgc2lkZSBvZiB0aGluZ3MgWzFdIHdhcyBhY2NlcHRlZC4N
ClRoYW5rIHlvdSENCg0KWzFdIGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC91
Ym9vdC9saXN0Lz9zZXJpZXM9Mzc1MTU0JnN0YXRlPSoNCg0KLS0tDQpCZXN0IFJlZ2FyZHMsIExh
dXJlbnRpdQ0KDQpPbiA5LzI2LzIwMjMgNjoyNiBQTSwgTGF1cmVudGl1IFR1ZG9yIHdyb3RlOg0K
PiBDaGVjayBpZiB0aGUgZGV2aWNlIGlzIG1hcmtlZCBhcyBETUEgY29oZXJlbnQgaW4gdGhlIERU
IGFuZCBpZiBzbywNCj4gbWFwIGl0cyByZXNlcnZlZCBtZW1vcnkgYXMgY2FjaGVhYmxlIGluIHRo
ZSBJT01NVS4NCj4gVGhpcyBmaXhlcyB0aGUgcmVjZW50bHkgYWRkZWQgSU9NTVUgcmVzZXJ2ZWQg
bWVtb3J5IHN1cHBvcnQgd2hpY2gNCj4gdXNlcyBJT01NVV9SRVNWX0RJUkVDVCB3aXRob3V0IHBy
b3Blcmx5IGJ1aWxkaW5nIHRoZSBQUk9UIGZvciB0aGUNCj4gbWFwcGluZy4NCj4gDQo+IEZpeGVz
OiBhNWJmM2NmY2U4Y2IgKCJpb21tdTogSW1wbGVtZW50IG9mX2lvbW11X2dldF9yZXN2X3JlZ2lv
bnMoKSIpDQo+IFNpZ25lZC1vZmYtYnk6IExhdXJlbnRpdSBUdWRvciA8bGF1cmVudGl1LnR1ZG9y
QG54cC5jb20+DQo+IFJldmlld2VkLWJ5OiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29t
Pg0KPiBBY2tlZC1ieTogVGhpZXJyeSBSZWRpbmcgPHRyZWRpbmdAbnZpZGlhLmNvbT4NCj4gLS0t
DQo+IENoYW5nZXMgaW4gdjM6DQo+ICAgLSBhZGRlZCBBY2tlZC1ieSB0YWcgKFRoaWVycnkpDQo+
IA0KPiBDaGFuZ2VzIGluIHYyOg0KPiAgIC0gYWRkZWQgUmV2aWV3ZWQtYnkgdGFnIChKYXNvbikN
Cj4gDQo+ICAgZHJpdmVycy9pb21tdS9vZl9pb21tdS5jIHwgMyArKysNCj4gICAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9v
Zl9pb21tdS5jIGIvZHJpdmVycy9pb21tdS9vZl9pb21tdS5jDQo+IGluZGV4IDE1N2IyODZlMzZi
Zi4uNWIzNjMxYmE1YTQ1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lvbW11L29mX2lvbW11LmMN
Cj4gKysrIGIvZHJpdmVycy9pb21tdS9vZl9pb21tdS5jDQo+IEBAIC0yNTQsNiArMjU0LDkgQEAg
dm9pZCBvZl9pb21tdV9nZXRfcmVzdl9yZWdpb25zKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0
IGxpc3RfaGVhZCAqbGlzdCkNCj4gICAJCQkJcGh5c19hZGRyX3QgaW92YTsNCj4gICAJCQkJc2l6
ZV90IGxlbmd0aDsNCj4gICANCj4gKwkJCQlpZiAob2ZfZG1hX2lzX2NvaGVyZW50KGRldi0+b2Zf
bm9kZSkpDQo+ICsJCQkJCXByb3QgfD0gSU9NTVVfQ0FDSEU7DQo+ICsNCj4gICAJCQkJbWFwcyA9
IG9mX3RyYW5zbGF0ZV9kbWFfcmVnaW9uKG5wLCBtYXBzLCAmaW92YSwgJmxlbmd0aCk7DQo+ICAg
CQkJCXR5cGUgPSBpb21tdV9yZXN2X3JlZ2lvbl9nZXRfdHlwZShkZXYsICZwaHlzLCBpb3ZhLCBs
ZW5ndGgpOw0KPiAgIA0K
