Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0E180AA07
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574171AbjLHRGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574185AbjLHRGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:06:23 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACAF171D;
        Fri,  8 Dec 2023 09:06:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUlayxfNGWb2zrmnUy9+Z8skvEYFX2JMvlOQbLZmQaFVHNd5eQtaS4eg39M8oXuye1UiNxLWvMDO+dsdbPtjlk2omNqmfq4W0Ww06bRCXfIuG+hMgnKl6FYHYq6oCPSkMbBJBHP71ld6RMEoJR4UmmA/NxhgcqPhDX+7RNaTfGOytulRiWlBLRrQZZQYpxzmfg4XkCXJ9sxFWV8Sh5/VU0QXQLcUEUgM6bnI7tunU1I1sUeNrEjYeHWJqmrvBg1nZkJSHsNcLxHBb4m7aTWOJvgx7gDv0jbdXN25thV3/8cIZFrftFTXLjfmMQZ1FR/+xr7103hP8HNTrOK2knlhGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3koL2KXWeRIPSIfturxjqO3lbK0MmkVxq81KyfENJk=;
 b=MxL6sLVNbiAtb2ADUH8b4TVgPu3s9lovmJ/s0exN8u2hpbBSYZjo/W2ayDQb6RhIQ2viB80IFmLj6rd4nLNseoVGOM7QHYI8tdrtXHp/WBKhGeUCywK6fYp2bl3kqZEzPWB/qE3doWtx/a8+Xq704Q3Pvz4bk8161iPs5KzkWtt3J7saHfjz9R7m50YbAtCkFsCj/A1Wrn01ASV2ONvjoGNYuZ6J+ISDeuUY++35Sp4lEGaygg0w9+ltywg9FlZgzAjr+Yeazyk0CzNElV/h3vMxz995Mj015qsQxicvhOFFwl4KgBAJBmt8WECx5eKwSQW4Ju02FtmelMl5073mUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3koL2KXWeRIPSIfturxjqO3lbK0MmkVxq81KyfENJk=;
 b=o8jkyptLx3zvhXiMh4WEvVXPKdKECw9kiPCp18fFq1CM9PRDrQ2p+GwWUvdeeg9hZqeUyYfdYbLxM6ubEa+ZlrFGQ+4uvKDHZ0vPwXSoV/KB4LxAYb9QTw5KdPivLmIiWct7HKtGTIOARxfc+ylurXZS6XgYRxUBoU63UaoRqjw=
Received: from BN7PR12MB2802.namprd12.prod.outlook.com (2603:10b6:408:25::33)
 by DM4PR12MB8557.namprd12.prod.outlook.com (2603:10b6:8:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 17:06:24 +0000
Received: from BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::2a35:852d:bc78:ed64]) by BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::2a35:852d:bc78:ed64%7]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 17:06:24 +0000
From:   "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "pratyush@kernel.org" <pratyush@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "sbinding@opensource.cirrus.com" <sbinding@opensource.cirrus.com>,
        "lee@kernel.org" <lee@kernel.org>,
        "james.schulman@cirrus.com" <james.schulman@cirrus.com>,
        "david.rhodes@cirrus.com" <david.rhodes@cirrus.com>,
        "rf@opensource.cirrus.com" <rf@opensource.cirrus.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "claudiu.beznea@tuxon.dev" <claudiu.beznea@tuxon.dev>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>
Subject: RE: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
Thread-Topic: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
Thread-Index: AQHaH4D9pFM5xtDoeEuMNIpXuxvtzbCcYmwAgAAD2QCAA0mkcA==
Date:   Fri, 8 Dec 2023 17:06:24 +0000
Message-ID: <BN7PR12MB2802C8279CA95FA08F8DDCF2DC8AA@BN7PR12MB2802.namprd12.prod.outlook.com>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <20231125092137.2948-8-amit.kumar-mahapatra@amd.com>
 <e2305642-55f1-4893-bea3-b170ac0a5348@linaro.org>
 <9f577482-30d9-4e1d-9469-812d323b18c6@linaro.org>
In-Reply-To: <9f577482-30d9-4e1d-9469-812d323b18c6@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR12MB2802:EE_|DM4PR12MB8557:EE_
x-ms-office365-filtering-correlation-id: 0b4e3074-7ea6-4e6e-8fd7-08dbf810021e
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qnxq/xDhTRh7V6XIvdREG0WcnM43lfWw94jE5zp+32RHWqai9Lj5bExwPwSbFU5p8VNE36Aeu4HrtCa3ZUmhpHCCfgXtoqsZKXBMFhvlRXoGs5QwQQrk3kDVJfDxpLqWi0XIO48w61C2EZyVLHxy0xjyGygcbLimSREwH6M/JvuM8JCLACNE5CKr1UaZ1AXRKi6H+SuWIf9jxoY1BkmWqax3iaDO6wXRPrQz2XoqtXJ6xtbx9vMjdFyom/NhrlkxvR2/0rBUXPHarjXVyGKrVRZhufV+NE4ApLs8cwKnBK3Vyzn5126qGSznAV0NSAOGx0bEALBM2SaQ1umw4T9aF6j7XLefkbmzvcJmOodI1ISbyqqTdThcT8rW7ejJc0nVr8FgCvedVCZ3DwcQ1tDzmCjDDNPaZ5s2nxtwjB1jHf3mton7Qi/I9epgUsrg4GG2lE0NEY/2Bk7ynhgqopItj7cG9rUa2sjvXcivbY6QBlj62EDlCxj67ahQf3imcG7iSTwEwT3foHGCfybEF8IeNGloSf/TlTAnuVEFH1RGB+44/z3CDDh7W4BuogqP+RgbT7RY8rwNLV4NF3nD58MrQKjr1ZmO7NFNQY3/RjIKctUEsaH7GsoNSp1oKUvZoANv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR12MB2802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(136003)(346002)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(55016003)(41300700001)(122000001)(38100700002)(2906002)(7416002)(316002)(38070700009)(921008)(5660300002)(4326008)(8676002)(8936002)(966005)(33656002)(76116006)(9686003)(53546011)(71200400001)(6506007)(7696005)(26005)(478600001)(64756008)(86362001)(54906003)(66556008)(66476007)(66946007)(66446008)(110136005)(52536014)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUVtZVFhZ2xlRlZlNDZSaUF0K2FxZjRha2t2dkQ4MGluSHFBTkkrM2d3MDJp?=
 =?utf-8?B?a2RRMklNdWpKelYrd0NQZ3NUVkpBMWZPOVVJVXJJQWQ0bkhFZ010TXRHd1lo?=
 =?utf-8?B?MXVlc2FXN3p1UGtQMDFLS09Jd3RKek1YbFpjbG5ZRXVCNnFieTZBZ2NEamR5?=
 =?utf-8?B?ZWlWN01PbXRHVUxNMG4wMVI2WEVydDhzeTNPN25OMXRzWnhpOWY2NHlZSHlX?=
 =?utf-8?B?czliNitTZVZybDBLT3ovMTlNV1VsL24xTnhqYisvT3Rkb3lRay9CRVNtQ3Qv?=
 =?utf-8?B?N1oySWRGYlpBdzlSZmlQKytlbTE4eG4wQnBBSnR0NmcyV1ZTWThpdWFpeTZ0?=
 =?utf-8?B?RXdEOWlyVkI0SlY0V3FSVlJRSkNpbDZpaWx5ejdxRldQOGkyRERKa3VOMlgz?=
 =?utf-8?B?a004YzA4SElpRGNvVmNCZDJRZDIzakN5U1dna0RMSHZZdWhCdVdKWUFZeUVv?=
 =?utf-8?B?K0J5ZFJEbG9pVXVPNU83VERYVEdaTWYzLzhEaGJHS3JTMHRXekN4S01neXg5?=
 =?utf-8?B?Z0x4M0Q3QWcrTlllT1NKcytnV2tsc1p2TzVuVTBOZTZGY1lzR3RwcTVoK0o4?=
 =?utf-8?B?NndsVWEvdlZ6U3ZPekJDSXh4cmNJZkpLVk5kbmwrYUlybXUrb2tGdmRqVVNT?=
 =?utf-8?B?TWRvaU93NFN0WHFFQ015NWhjR2tHK1pBNjl6a3lnU3pZSTU3bWF5blVyWnVa?=
 =?utf-8?B?S2RVVytBeEM0dy9TeWJTQ0xyUGJJVG1ZYVppNHdSd0t6Z3d5T01Rb1Yyb0kx?=
 =?utf-8?B?SmwzOVJzTjV2TW5MOXNNZS85aGtpTTJTT0xNKzhNald5cUYzSnJwWXBzREVt?=
 =?utf-8?B?VFBWZHBYbXROWHBVeHFhM3k1RFVPWmxuSzkrNUgwL3BZVTdlcnZDOGFqbzlY?=
 =?utf-8?B?WUFaVmsxSksvcm9pQlVOVXozNWdFMHF2cUpmbVdRMFJPZUgrU3E4QU53ZXY5?=
 =?utf-8?B?WWRuU0JNdnU5cGYwUHpuN1lNeEpXcG4yVkQ5TmxjTnhFVGdYNmowK1pmNXdn?=
 =?utf-8?B?QXcyOGFlLy9zTkFZaWhqdEJCVUFLenlHdzQxc2tkK29lL0V3bEszaXhKQUFt?=
 =?utf-8?B?VkNGYXNTTTFNYU5FSnBBWUxYZGJUUXZ1VStiYXFxckJZZk0xZm9OeDEvMWU3?=
 =?utf-8?B?YnRoTzBrUUtRTzBDRy9mQy8rQVRCWURnR0VDeGowZXJtU0lVd2ZaMUNSZ0R1?=
 =?utf-8?B?TytLRXhOcDllS0lUNUpBa0RMcWZ5OUxsOWJmaDkvY3ZGZm0rSGg4QlF2bEdo?=
 =?utf-8?B?TVF2Mk1Sd2laMHFJOFg4THhiUWtrdjRQNlhtQjgxV01lNmpQWkVMWURiTndD?=
 =?utf-8?B?NHBtMHk2ci9IV1lQdS9kY1pESDdQR21SQVFmampxcG42NW5yVFMyZ3JYM1ph?=
 =?utf-8?B?cDZLcWJVcytTZW9SdW1QNUJuTk1md00rUVpYWVhQb0pXRUgwNW03R2dGcGpT?=
 =?utf-8?B?SzA2T2FPWUNVUEFvVzJGYmh0c3VtaEwyVWgvS24zMExvaHd6MXJrRStTUCtr?=
 =?utf-8?B?NnU5TUE5b2FHcVk5bG5YM1pwcDRndHo1SWoxM0FNc2lMWWJpY2xyNzg5T3Qw?=
 =?utf-8?B?biszMW9CRGFtdlJ1dnNGYTRmZU85UEh6bDZmY3ZzdzBKNlQwTE10QnBnS1I2?=
 =?utf-8?B?bHdMNURrUU9SUWsvbFJXUmpjMjk2di9Sc3VBbEYyNVpiOVhDZFJYS3YyZmMv?=
 =?utf-8?B?N3JncjRJSnN1YzVMRXdGRjFKVFB6eEtBMjhBWUowV1R0K2cxY3A0RWFJUzh4?=
 =?utf-8?B?dnVFbG1vZTEySlFOQ2c1SDV2dVo2Uyt5ZWd5Y21Yb1pGQUdKbXhiNmdsQ2FJ?=
 =?utf-8?B?eEo5bTlYVWl3NFJKQ2hsUmU0dTUvNCtRM3hFcWg0T2dneTZjTndHUVp5ZWpS?=
 =?utf-8?B?T0FtVVlHT1Rwc2VJZHYyTmZYRkcwdk1JWnhZc0RYenlaSjRPS0ZKU2d6WWkv?=
 =?utf-8?B?ejI4Z280OGNxWTZIdkJJT2FDVzY0SVFjQUhMR053blc1T1d6Qy9NUjh4UHFZ?=
 =?utf-8?B?Wjh0eUo1eDNvdUorMWtHOGVZWW5Nanp5NzNzY0tJamtndmVIcW5raHdHYlkr?=
 =?utf-8?B?ckEzenBaemVmMXpxajQvTitnczRYUUZTNHpYOG9PL04wMGhKcnE1TVgwdmV5?=
 =?utf-8?Q?UPWI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4e3074-7ea6-4e6e-8fd7-08dbf810021e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 17:06:24.1561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yb0UVu5Wzw7GsFHO0S3GcT7vTiASRp0hJbS1jU6vbe6HjUu6KJdGQrJ0CHAT0MXN3Mc+6K1sOoSeGB80K+USBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8557
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gVHVkb3IsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVHVk
b3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXks
IERlY2VtYmVyIDYsIDIwMjMgODoxNCBQTQ0KPiBUbzogTWFoYXBhdHJhLCBBbWl0IEt1bWFyIDxh
bWl0Lmt1bWFyLW1haGFwYXRyYUBhbWQuY29tPjsNCj4gYnJvb25pZUBrZXJuZWwub3JnOyBwcmF0
eXVzaEBrZXJuZWwub3JnOyBtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tOw0KPiByaWNoYXJkQG5v
ZC5hdDsgdmlnbmVzaHJAdGkuY29tOyBzYmluZGluZ0BvcGVuc291cmNlLmNpcnJ1cy5jb207DQo+
IGxlZUBrZXJuZWwub3JnOyBqYW1lcy5zY2h1bG1hbkBjaXJydXMuY29tOyBkYXZpZC5yaG9kZXNA
Y2lycnVzLmNvbTsNCj4gcmZAb3BlbnNvdXJjZS5jaXJydXMuY29tOyBwZXJleEBwZXJleC5jejsg
dGl3YWlAc3VzZS5jb20NCj4gQ2M6IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IG1pY2hhZWxAd2FsbGUuY2M7IGxpbnV4LW10ZEBsaXN0
cy5pbmZyYWRlYWQub3JnOw0KPiBuaWNvbGFzLmZlcnJlQG1pY3JvY2hpcC5jb207IGFsZXhhbmRy
ZS5iZWxsb25pQGJvb3RsaW4uY29tOw0KPiBjbGF1ZGl1LmJlem5lYUB0dXhvbi5kZXY7IFNpbWVr
LCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsgbGludXgtDQo+IGFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZzsgYWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnOw0KPiBwYXRjaGVz
QG9wZW5zb3VyY2UuY2lycnVzLmNvbTsgbGludXgtc291bmRAdmdlci5rZXJuZWwub3JnOyBnaXQg
KEFNRC0NCj4gWGlsaW54KSA8Z2l0QGFtZC5jb20+OyBhbWl0cmtjaWFuMjAwMkBnbWFpbC5jb20N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTEgMDcvMTBdIG10ZDogc3BpLW5vcjogQWRkIHN0YWNr
ZWQgbWVtb3JpZXMgc3VwcG9ydA0KPiBpbiBzcGktbm9yDQo+IA0KPiANCj4gDQo+IE9uIDEyLzYv
MjMgMTQ6MzAsIFR1ZG9yIEFtYmFydXMgd3JvdGU6DQo+ID4gSGksIEFtaXQsDQo+ID4NCj4gPiBP
biAxMS8yNS8yMyAwOToyMSwgQW1pdCBLdW1hciBNYWhhcGF0cmEgd3JvdGU6DQo+ID4+IEVhY2gg
Zmxhc2ggdGhhdCBpcyBjb25uZWN0ZWQgaW4gc3RhY2tlZCBtb2RlIHNob3VsZCBoYXZlIGEgc2Vw
YXJhdGUNCj4gPj4gcGFyYW1ldGVyIHN0cnVjdHVyZS4gU28sIHRoZSBmbGFzaCBwYXJhbWV0ZXIg
bWVtYmVyKCpwYXJhbXMpIG9mIHRoZQ0KPiA+PiBzcGlfbm9yIHN0cnVjdHVyZSBpcyBjaGFuZ2Vk
IHRvIGFuIGFycmF5ICgqcGFyYW1zWzJdKS4gVGhlIGFycmF5IGlzDQo+ID4+IHVzZWQgdG8gc3Rv
cmUgdGhlIHBhcmFtZXRlcnMgb2YgZWFjaCBmbGFzaCBjb25uZWN0ZWQgaW4gc3RhY2tlZA0KPiBj
b25maWd1cmF0aW9uLg0KPiA+Pg0KPiA+PiBUaGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiBhc3N1
bWVzIHRoYXQgYSBtYXhpbXVtIG9mIHR3byBmbGFzaGVzIGFyZQ0KPiA+PiBjb25uZWN0ZWQgaW4g
c3RhY2tlZCBtb2RlIGFuZCBib3RoIHRoZSBmbGFzaGVzIGFyZSBvZiBzYW1lIG1ha2UgYnV0DQo+
ID4+IGNhbiBkaWZmZXIgaW4gc2l6ZXMuIFNvLCBleGNlcHQgdGhlIHNpemVzIGFsbCBvdGhlciBm
bGFzaCBwYXJhbWV0ZXJzDQo+ID4+IG9mIGJvdGggdGhlIGZsYXNoZXMgYXJlIGlkZW50aWNhbC4N
Cj4gPg0KPiA+IERvIHlvdSBwbGFuIHRvIGFkZCBzdXBwb3J0IGZvciBkaWZmZXJlbnQgZmxhc2hl
cyBpbiBzdGFja2VkIG1vZGU/IElmDQo+ID4gbm90LCB3b3VsZG4ndCBpdCBiZSBzaW1wbGVyIHRv
IGhhdmUganVzdCBhbiBhcnJheSBvZiBmbGFzaCBzaXplcw0KPiA+IGluc3RlYWQgb2YgZHVwbGlj
YXRpbmcgdGhlIGVudGlyZSBwYXJhbXMgc3RydWN0Pw0KPiA+DQo+ID4+DQo+ID4+IFNQSS1OT1Ig
aXMgbm90IGF3YXJlIG9mIHRoZSBjaGlwX3NlbGVjdCB2YWx1ZXMsIGZvciBhbnkgaW5jb21pbmcN
Cj4gPj4gcmVxdWVzdCBTUEktTk9SIHdpbGwgZGVjaWRlIHRoZSBmbGFzaCBpbmRleCB3aXRoIHRo
ZSBoZWxwIG9mDQo+ID4+IGluZGl2aWR1YWwgZmxhc2ggc2l6ZSBhbmQgdGhlIGNvbmZpZ3VyYXRp
b24gdHlwZSAoc2luZ2xlL3N0YWNrZWQpLg0KPiA+PiBTUEktTk9SIHdpbGwgcGFzcyBvbiB0aGUg
Zmxhc2ggaW5kZXggaW5mb3JtYXRpb24gdG8gdGhlIFNQSSBjb3JlICYNCj4gPj4gU1BJIGRyaXZl
ciBieSBzZXR0aW5nIHRoZSBhcHByb3ByaWF0ZSBiaXQgaW4NCj4gPj4gbm9yLT5zcGltZW0tPnNw
aS0+Y3NfaW5kZXhfbWFzay4gRm9yIGV4YW1wbGUsIGlmIG50aCBiaXQgb2YNCj4gPj4gbm9yLT5z
cGltZW0tPnNwaS0+Y3NfaW5kZXhfbWFzayBpcyBzZXQgdGhlbiB0aGUgZHJpdmVyIHdvdWxkDQo+
ID4+IGFzc2VydC9kZS1hc3NlcnQgc3BpLT5jaGlwX3NsZWN0W25dLg0KPiA+Pg0KPiA+PiBTaWdu
ZWQtb2ZmLWJ5OiBBbWl0IEt1bWFyIE1haGFwYXRyYSA8YW1pdC5rdW1hci0NCj4gbWFoYXBhdHJh
QGFtZC5jb20+DQo+ID4+IC0tLQ0KPiA+PiAgZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMgIHwg
MjcyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQ0KPiA+PiAgZHJpdmVycy9t
dGQvc3BpLW5vci9jb3JlLmggIHwgICA0ICsNCj4gPj4gIGluY2x1ZGUvbGludXgvbXRkL3NwaS1u
b3IuaCB8ICAxNSArLQ0KPiA+PiAgMyBmaWxlcyBjaGFuZ2VkLCAyNDAgaW5zZXJ0aW9ucygrKSwg
NTEgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGkt
bm9yL2NvcmUuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+ID4+IGluZGV4IDkzYWU2
OWI3ZmY4My4uZTk5MGJlN2M3ZWI2IDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL210ZC9zcGkt
bm9yL2NvcmUuYw0KPiA+PiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPiA+DQo+
ID4gY3V0DQo+ID4NCj4gPj4gQEAgLTI5MDUsNyArMzAwNywxMCBAQCBzdGF0aWMgdm9pZCBzcGlf
bm9yX2luaXRfZml4dXBfZmxhZ3Moc3RydWN0DQo+ID4+IHNwaV9ub3IgKm5vcikgIHN0YXRpYyBp
bnQgc3BpX25vcl9sYXRlX2luaXRfcGFyYW1zKHN0cnVjdCBzcGlfbm9yDQo+ID4+ICpub3IpICB7
DQo+ID4+ICAJc3RydWN0IHNwaV9ub3JfZmxhc2hfcGFyYW1ldGVyICpwYXJhbXMgPSBzcGlfbm9y
X2dldF9wYXJhbXMobm9yLA0KPiAwKTsNCj4gPj4gLQlpbnQgcmV0Ow0KPiA+PiArCXN0cnVjdCBk
ZXZpY2Vfbm9kZSAqbnAgPSBzcGlfbm9yX2dldF9mbGFzaF9ub2RlKG5vcik7DQo+ID4+ICsJdTY0
IGZsYXNoX3NpemVbU05PUl9GTEFTSF9DTlRfTUFYXTsNCj4gPj4gKwl1MzIgaWR4ID0gMDsNCj4g
Pj4gKwlpbnQgcmMsIHJldDsNCj4gPj4NCj4gPj4gIAlpZiAobm9yLT5tYW51ZmFjdHVyZXIgJiYg
bm9yLT5tYW51ZmFjdHVyZXItPmZpeHVwcyAmJg0KPiA+PiAgCSAgICBub3ItPm1hbnVmYWN0dXJl
ci0+Zml4dXBzLT5sYXRlX2luaXQpIHsgQEAgLTI5MzcsNiArMzA0Miw0NCBAQA0KPiA+PiBzdGF0
aWMgaW50IHNwaV9ub3JfbGF0ZV9pbml0X3BhcmFtcyhzdHJ1Y3Qgc3BpX25vciAqbm9yKQ0KPiA+
PiAgCWlmIChwYXJhbXMtPm5fYmFua3MgPiAxKQ0KPiA+PiAgCQlwYXJhbXMtPmJhbmtfc2l6ZSA9
IGRpdjY0X3U2NChwYXJhbXMtPnNpemUsIHBhcmFtcy0NCj4gPm5fYmFua3MpOw0KPiA+Pg0KPiA+
PiArCW5vci0+bnVtX2ZsYXNoID0gMDsNCj4gPj4gKw0KPiA+PiArCS8qDQo+ID4+ICsJICogVGhl
IGZsYXNoZXMgdGhhdCBhcmUgY29ubmVjdGVkIGluIHN0YWNrZWQgbW9kZSBzaG91bGQgYmUgb2Yg
c2FtZQ0KPiBtYWtlLg0KPiA+PiArCSAqIEV4Y2VwdCB0aGUgZmxhc2ggc2l6ZSBhbGwgb3RoZXIg
cHJvcGVydGllcyBhcmUgaWRlbnRpY2FsIGZvciBhbGwgdGhlDQo+ID4+ICsJICogZmxhc2hlcyBj
b25uZWN0ZWQgaW4gc3RhY2tlZCBtb2RlLg0KPiA+PiArCSAqIFRoZSBmbGFzaGVzIHRoYXQgYXJl
IGNvbm5lY3RlZCBpbiBwYXJhbGxlbCBtb2RlIHNob3VsZCBiZSBpZGVudGljYWwuDQo+ID4+ICsJ
ICovDQo+ID4+ICsJd2hpbGUgKGlkeCA8IFNOT1JfRkxBU0hfQ05UX01BWCkgew0KPiA+PiArCQly
YyA9IG9mX3Byb3BlcnR5X3JlYWRfdTY0X2luZGV4KG5wLCAic3RhY2tlZC1tZW1vcmllcyIsDQo+
IGlkeCwNCj4gPj4gKyZmbGFzaF9zaXplW2lkeF0pOw0KPiANCj4gYWxzbywgaXQncyBub3QgY2xl
YXIgdG8gbWUgd2h5IHlvdSByZWFkIHRoaXMgcHJvcGVydHkgbXVsdGlwbGUgdGltZXMuDQo+IEhh
dmUgeW91IHNlbnQgYSBkZXZpY2UgdHJlZSBwYXRjaCBzb21ld2hlcmU/IEl0IHdpbGwgaGVscCBt
ZSB1bmRlcnN0YW5kDQo+IHdoYXQgeW91J3JlIHRyeWluZyB0byBhY2hpZXZlLg0KDQpNaXF1ZWwg
c3VibWl0dGVkIHRoZSBkZXZpY2UgdHJlZSBwYXRjaDsgaGVyZSBpcyB0aGUgc2VyaWVzLg0KaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjIwMTI2MTEyNjA4Ljk1NTcyOC0xLW1pcXVlbC5y
YXluYWxAYm9vdGxpbi5jb20vDQoNClJlZ2FyZHMsDQpBbWl0DQo+IA0KPiA+DQo+ID4gVGhpcyBp
cyBhIGxpdHRsZSBsYXRlIGluIG15IG9waW5pb24sIGFzIHdlIGRvbid0IGhhdmUgYW55IHNhbml0
eSBjaGVjaw0KPiA+IG9uIHRoZSBmbGFzaGVzIHRoYXQgYXJlIHN0YWNrZWQgb24gdG9wIG9mIHRo
ZSBmaXJzdC4gV2Ugc2hhbGwgYXQgbGVhc3QNCj4gPiByZWFkIGFuZCBjb21wYXJlIHRoZSBJRCBm
b3IgYWxsLg0KPiA+DQo+ID4gQ2hlZXJzLA0KPiA+IHRhDQo=
