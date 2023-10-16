Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28AF7CA4BB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjJPKG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPKGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:06:25 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F6DAC;
        Mon, 16 Oct 2023 03:06:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8MFXGZ2ajq7ozAb/yfSgdzmHgq+t305RLhD1zcsF7qLI+FDA1Kp/Br7bVw0kne/nACOPON23yftmtg/5IWckeWoOWRcPEeJb2GQ3xOz8yZdYeu8cUcCBEsHJp9ZfT2/PEl9EqcrnS5XIUnpCQm0AVkJHgoOVtWYlmf6PQVkTSbKuGCoFHPRxMdBlr2OVT25qZnq3Khl26lHmlP5Dy3WuQc1hsiDw19zWTaDN3csdx2LUjeUKTICVGBLG4uHfH414mmfY1+l6N/PSkdinvwEpBtSfR1AnEXzzL+0Bjt/fT+UcDhkYsBYO7yHdNx8tx9b3+ffib7AazC1yZqn0apjDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNZ6G2z/XHsD9+nIjnbc27lYfk58yeeHSfL5hN3NHCE=;
 b=M7wwu/4wmgB1ZY5hlsx5lUlnQXtfjHO8CB8+Jo2nOCqHTm28GFlQrSdI73yylJzYcLfr0zu9T+S5lzGqndDE6G1vUUgxYX/7aAm+Ne68i76B+XAxV1Qr6BiHRieQSoUxWrvqiRIvHoI8AE2fo7F8QJJZGFNV2r+PsD9AD5GgJu67ONPd4/Boo6ttXe440w0VuwEio/Wd3np3KEUk/ARbEY57ysipdn94lJi5IS+YgoYQUKINogrZrtjxebba5ae0bRoojBF0V+MOjsrUyQrVCMczgLQZqzxoAcQPIXLEn9zw/60p/fh0uOivfp7/TAqm3xxah0bl6P7AWzybekrGzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNZ6G2z/XHsD9+nIjnbc27lYfk58yeeHSfL5hN3NHCE=;
 b=os2vdGPVXaYck1a/dcgPnSVRRS5XfuJxkZIO+LBwDU7uVHTMkpxRnBRoWB7FhzB1lvnPDNae7k9pSxKDuBCMG2t62xXGfbd4QtkiQHGBwIgGx0ytYkVsHHHfSg/DEuYMECDMzZWCzqa5qMIv+wgYGW48BPEpL4bkPVJSK3j11bI=
Received: from BYAPR12MB3207.namprd12.prod.outlook.com (2603:10b6:a03:135::10)
 by LV8PR12MB9264.namprd12.prod.outlook.com (2603:10b6:408:1e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Mon, 16 Oct
 2023 10:06:19 +0000
Received: from BYAPR12MB3207.namprd12.prod.outlook.com
 ([fe80::7898:321:2239:77b9]) by BYAPR12MB3207.namprd12.prod.outlook.com
 ([fe80::7898:321:2239:77b9%2]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 10:06:19 +0000
From:   "Kundanala, Praveen Teja" <praveen.teja.kundanala@amd.com>
To:     "Simek, Michal" <michal.simek@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/5] dt-bindings: nvmem: Convert xlnx,zynqmp-nvmem.txt to
 yaml
Thread-Topic: [PATCH 2/5] dt-bindings: nvmem: Convert xlnx,zynqmp-nvmem.txt to
 yaml
Thread-Index: AQHZ/cBQKoA6dOkRm0Wxp8h1X2vu2rBHk6sAgAAGggCAAAGHAIAAAe2AgAAC4gCAAAzQAIAAA1oAgAABFwCABGDEAIAAIAYA
Date:   Mon, 16 Oct 2023 10:06:17 +0000
Message-ID: <BYAPR12MB3207A21C727E6EEF41E2A863CBD7A@BYAPR12MB3207.namprd12.prod.outlook.com>
References: <20231013101450.573-1-praveen.teja.kundanala@amd.com>
 <20231013101450.573-3-praveen.teja.kundanala@amd.com>
 <02d3fa42-75a3-4f4f-ade6-204c8146d694@linaro.org>
 <91d61e1a-abb0-4b31-aa22-aff72d582ebe@amd.com>
 <b72e6fe0-2ba4-47ac-80a5-94ee4101ad2b@linaro.org>
 <013e44c6-45f5-44c1-94b3-536955fae78f@amd.com>
 <b5a2d37b-168c-4cc9-9dc0-68f131cdf3ad@linaro.org>
 <5a3b6efe-5884-4727-a1e1-e9b8b0658523@amd.com>
 <209334cd-c922-4bd6-b116-83297c7e8b79@linaro.org>
 <edbd1434-c05b-461f-96e5-f57775dcf915@amd.com>
 <a990fead-b7af-48e6-ab28-3a69ce07d248@linaro.org>
 <1da65bde-c64b-46cf-be49-3a687d6ffef1@amd.com>
In-Reply-To: <1da65bde-c64b-46cf-be49-3a687d6ffef1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b26e2cce-ec0d-4c76-8349-09e1e9953419;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-16T09:56:27Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3207:EE_|LV8PR12MB9264:EE_
x-ms-office365-filtering-correlation-id: f883b0f9-6b02-492e-8925-08dbce2f8a0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LoJGorwGFG6V6k8bGBXgOD6PkRDljutq67ZLZtCmEZtAOQQAC9Zn06ahPQE2WEeCLyN7JNLjXMjqSmwwCiOnnQ1n11YWqfQt2t52agq/Fou7YjeiQiIfJIZHavt5vzP3jf9wTnTUgq+5ptDkHOoHqjSTRADmcAulN2TyvwdquRGSt7e7az6VhChSI45SoUTYJdRBA7KZa/PGw0WAuMEi49+Pm+AS56DAHAFHXgH8Xr/IKf8FnC6kR15igcmr3G9Mxje9qgClRcZPekOA8BXvKlU0CvcQyF7n5FQa/Olp/n3IkjHHjLA6X5bYkkGF0oq4uLQsMh0VPqPx7e0wRqbLVsKCsoTTwMqgso7tKOHYaG0w0uyMvya5iuTGNyPw04eyEIiNGzMr8gWdsboqnZPRkqPN9HN6Mpdn6GuouIzozbFX9d3V6uXzYratPCA/EoLwRY0TLqxK4ze64v2HTOQNy6Y+jFTuWlhw38NiPgLibp1k3zzHxWAweYiSpHt2uDRhiIokuDtPE0nw0vaf6YhmOTIS2k78ze1UgdJOvN77/CsfLaOq7ey7Lw3hLgqnsmjbQiSpO12s++XdlhbJV6TbYthvyXFFu+yM908wdatmWnQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3207.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(396003)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(966005)(478600001)(4326008)(55016003)(8936002)(71200400001)(5660300002)(7696005)(52536014)(8676002)(64756008)(66476007)(110136005)(66446008)(66946007)(66556008)(76116006)(33656002)(41300700001)(316002)(38100700002)(2906002)(122000001)(38070700005)(86362001)(26005)(83380400001)(9686003)(6506007)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVg3bVJlU015bmF5M0pORFZ5d2Z0U2NQMXpIL2l2YWJOU2RxYUVtRkRNUng2?=
 =?utf-8?B?aUJ1VGdOT21mVUlwM1YrL3MzdENuZzl4R1ZEMmpQYnBuRDhYMmU5V0RFMmVs?=
 =?utf-8?B?dTdFZDg3RkdpdTgzN2ZNRitxS0VkelZDdnBkTWxldXk5VGFQenZjbGt3TUh5?=
 =?utf-8?B?bUlmazFFWGwra09yNUdjVG1KbDFURk5ZQXZpei9GQXZ0b0dZcENGM2U0U2Fx?=
 =?utf-8?B?c2NvbVVHWHo3WTEwYm5SUElTZjUrRmtnWHhSeXVNMUgvWVRLT2ZIRlVoMlJB?=
 =?utf-8?B?KzBVdHEvdXpaWnRSWWRMZnVuWDJwWFhSZ1FFM2F1RmR3OFVFTURZamxSdHV1?=
 =?utf-8?B?SEFweExEd1dib1o3V2xqS29Za3Y1L2lmMFR4K0pQVHNaMFVSZlRNbmlmeG1a?=
 =?utf-8?B?VlY2RDdvSHZMb3RvSFJQR094V0d4VTJDWUwva0daT0VKV3VadHF6NTVNQzRk?=
 =?utf-8?B?TUZXVXRRd0w1eWxDM2tNaEdrbDFFcS94aU0wajJUckl2Zy9NWi9YNjM2djZi?=
 =?utf-8?B?MWl1R3Y0aHVmUldzZVB1Qng2NURWcmREeklzRUZDTEcwUEtmNkdMTy9aSSs4?=
 =?utf-8?B?UUttY05PWThlUjdNTjJTaGc5Yld6ZnB1dFVDUHNBbmVIVjE1N1dWRVZVbXdq?=
 =?utf-8?B?MWZiVFg2ZFd4WTM1d3NoWG1sa2E4TjBTVVdaVEduZzhibGRvaEpVazN0ekFD?=
 =?utf-8?B?Qnczb3BaUmUvSW15VDk0Ni8welVIVmJlbTlTMzBpN0k5bkZSZ0MvMWtCT3Bm?=
 =?utf-8?B?M2pRWDhwQ3pVNk1BRWF6cGVLekQyVDFXalFLY1hQdndlRmFYVElDclNBcFNL?=
 =?utf-8?B?NUtKa0hlZmFHbFZXeXRlQllkS2kzSVZMZ0NYMldYR2g3WFBrdHQ1c2hvSUFL?=
 =?utf-8?B?TTk1UnBoQnE3M3RIdnd6MVdUclQxTnR4T25HMHp4Q1Rvc2FiQzZINjhQam03?=
 =?utf-8?B?d1d6ZGd0cS9pRU9sRTVTWnFsL1BRWUZEUDFWWklQWEg2Y1pJc2R3ZUR4N0dD?=
 =?utf-8?B?cFErYjU5THFHN3J3NVhMckp2VERGSmVQS3M2am9nekNXRDBmcE5ZbFA5SmFZ?=
 =?utf-8?B?M1ZXdnlWM0FYdU54WnNQaE0xa2ZJMi9jazUzUVU1SWJ4dGJ6MkRvRmJtalZU?=
 =?utf-8?B?YTV4THhaRmcxUVpJdGU3MVQ1Q2lYRUZXSVk4d1p2MDhzeEhBOHVXakdXY1Nj?=
 =?utf-8?B?Q0xtd0hDZVAwaGdQamdNckxOakllRHMzc0FuRklFZjVEQ3BBV01kZUhLVFFu?=
 =?utf-8?B?SjM2a2xZMEZMQnduQTdxNitHTE9JcEVWT1lTUGNqLzY4a0hidUY1c0xVZXlO?=
 =?utf-8?B?SWxxUUJiN0VPNDh2Znk4VkdpTlJ6MmRyZGpzVHRiRUFHelJLUnJVWVliTWd4?=
 =?utf-8?B?ZHh5Yjh5ZnNtYTNnYnJBNnZoWGp0cFNDS2dFMlNzU0g2aGxrcHdHVURmVHdD?=
 =?utf-8?B?NUZJdHl6VXZYOFpoWEhJMzhuL0VhTnY0NFNJVWlEVkU4RFZCaGg1OStROTJ2?=
 =?utf-8?B?MlVVMDl1MGExNkxTcjc4SmNZSHNXWDFXNmVRRHBGZkNwbEhheTJ0MGx1Nmpa?=
 =?utf-8?B?eVNiS1U5UzFkR0pGNFV6eEJHOVRjaXk4OHJYK1VSdGczOU5sRG12T2txSjhH?=
 =?utf-8?B?aXBQT2RKTGllUDl6ZlQweXpUb1R5WEZ4NFJQWFcvVVIzaFN1Vy9XUXdyK0pK?=
 =?utf-8?B?Z2hIN0huTzBYZEJ2RjBzUndwVTUybDd2R0l4SmpiVkRFUFVjOXFWcEhlL1kz?=
 =?utf-8?B?R2c3WnQwL216S21MRXhJVjNHSGovR09uUUZoMmk2c3hTVGtxSE92Q0U1K0xJ?=
 =?utf-8?B?STNFUEFVUFlFOXU3V2dMWlFPWDNnakp1THpsbCtaMm9CQjRZUUkyM2Q4NFpF?=
 =?utf-8?B?a3htZi9mSUtFWUs5bHA2aEJVbFdqdmxkMkRYZHBpNGJkeHBmUEQyZW8vRzFX?=
 =?utf-8?B?eTdXYmZPYzBOVGF1VGRrR2FVQTFtdUZZV3FPSkZuREZIdUZ5eWRvd2pvejQw?=
 =?utf-8?B?cHFYbjA2VCtmNStGWnBjQzZtTHUxVGRaTlhKbEt4eSt2ejlDTGV3RXhKVVk4?=
 =?utf-8?B?UE9tdFQyN2tvQXA2ckhZNitqZC9oeWM5RmZVZFhHYW85a0crRnZlZ0FNSWth?=
 =?utf-8?Q?sq1g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3207.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f883b0f9-6b02-492e-8925-08dbce2f8a0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2023 10:06:17.7601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WfJ8VTGMqnX8PbcFn/GpbIivoNrmhExS4GReqeOSAQlYLMAbLulDQSecb3xJvoNnGAZIX/kwZjzTSKr9BTbspw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9264
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogU2ltZWssIE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5jb20+DQo+
IFNlbnQ6IE1vbmRheSwgT2N0b2JlciAxNiwgMjAyMyAxOjMyIFBNDQo+IFRvOiBLcnp5c3p0b2Yg
S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+OyBLdW5kYW5hbGEsIFBy
YXZlZW4NCj4gVGVqYSA8cHJhdmVlbi50ZWphLmt1bmRhbmFsYUBhbWQuY29tPjsgc3Jpbml2YXMu
a2FuZGFnYXRsYUBsaW5hcm8ub3JnOw0KPiByb2JoK2R0QGtlcm5lbC5vcmc7IGtyenlzenRvZi5r
b3psb3dza2krZHRAbGluYXJvLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4gZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0K
PiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IDIvNV0gZHQtYmluZGluZ3M6IG52bWVtOiBDb252ZXJ0IHhsbngsenlucW1wLW52bWVtLnR4dA0K
PiB0byB5YW1sDQo+DQo+DQo+DQo+IE9uIDEwLzEzLzIzIDE1OjEwLCBLcnp5c3p0b2YgS296bG93
c2tpIHdyb3RlOg0KPiA+IE9uIDEzLzEwLzIwMjMgMTU6MDYsIE1pY2hhbCBTaW1layB3cm90ZToN
Cj4gPj4NCj4gPj4NCj4gPj4gT24gMTAvMTMvMjMgMTQ6NTQsIEtyenlzenRvZiBLb3psb3dza2kg
d3JvdGU6DQo+ID4+PiBPbiAxMy8xMC8yMDIzIDE0OjA4LCBNaWNoYWwgU2ltZWsgd3JvdGU6DQo+
ID4+Pj4NCj4gPj4+Pg0KPiA+Pj4+IE9uIDEwLzEzLzIzIDEzOjU4LCBLcnp5c3p0b2YgS296bG93
c2tpIHdyb3RlOg0KPiA+Pj4+PiBPbiAxMy8xMC8yMDIzIDEzOjUxLCBNaWNoYWwgU2ltZWsgd3Jv
dGU6DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IE9uIDEwLzEzLzIzIDEzOjQ2LCBLcnp5
c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiA+Pj4+Pj4+IE9uIDEzLzEwLzIwMjMgMTM6MjIsIE1p
Y2hhbCBTaW1layB3cm90ZToNCj4gPj4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+Pj4gKw0KPiA+Pj4+Pj4+
Pj4+ICtyZXF1aXJlZDoNCj4gPj4+Pj4+Pj4+PiArICAtIGNvbXBhdGlibGUNCj4gPj4+Pj4+Pj4+
DQo+ID4+Pj4+Pj4+PiByZXF1aXJlZDogYmxvY2sgZ29lcyBhZnRlciBwYXR0ZXJuUHJvcGVydGll
czogYmxvY2sNCj4gPj4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+Pj4gKw0KPiA+Pj4+Pj4+Pj4+ICtwYXR0
ZXJuUHJvcGVydGllczoNCj4gPj4+Pj4+Pj4+PiArICAiXnNvY19yZXZpc2lvbkAwJCI6DQo+ID4+
Pj4+Pj4+Pg0KPiA+Pj4+Pj4+Pj4gV2h5IGRvIHlvdSBkZWZpbmUgaW5kaXZpZHVhbCBtZW1vcnkg
Y2VsbHM/IElzIHRoaXMgcGFydCBvZiBhDQo+IGJpbmRpbmc/DQo+ID4+Pj4+Pj4+PiBJT1csIE9T
L0xpbnV4IHJlcXVpcmVzIHRoaXM/DQo+ID4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+IG52bWVtIGhhcyBp
biBrZXJuZWwgaW50ZXJmYWNlIHdoZXJlIHlvdSBjYW4gcmVmZXJlbmNlIHRvIG5vZGVzLg0KPiA+
Pj4+Pj4+PiBudm1lbV9jZWxsX2dldCgpIGNhbGxzLiBJdCBtZWFucyB5b3Ugc2hvdWxkIGJlIGFi
bGUgdG8gZGVzY3JpYmUNCj4gPj4+Pj4+Pj4gaW50ZXJuYWwgbGF5b3V0IHRoYXQncyB3aHkgbmFt
ZXMgYXJlIHVzZWQuIEFuZCBhZGRyZXNzIGluIG5hbWUNCj4gPj4+Pj4+Pj4gaXMgdGhlcmUgYmVj
YXVzZSBvZiByZWcgcHJvcGVydHkgaXMgdXNlZCB0byBkZXNjcmliZSBiYXNlIG9mZnNldCBhbmQN
Cj4gc2l6ZS4NCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+IFRoYXQncyBub3QgcmVhbGx5IHdoYXQgSSBh
bSBhc2tpbmcuIFdoeSBpbnRlcm5hbCBsYXlvdXQgb2YNCj4gPj4+Pj4+PiBtZW1vcnkgbXVzdCBi
ZSBwYXJ0IG9mIHRoZSBiaW5kaW5ncz8NCj4gPj4+Pj4+DQo+ID4+Pj4+PiBJdCBkb2Vzbid0IG5l
ZWQgdG8gYmUgYnV0IG9mZnNldHMgYXJlIGhhcmRjb2RlZCBpbnNpZGUgdGhlIGRyaXZlcg0KPiA+
Pj4+Pj4gaXRzZWxmIGFuZCB0aGV5IGNhbid0IGJlIGRpZmZlcmVudC4NCj4gPj4+Pj4NCj4gPj4+
Pj4gSG0sIHdoZXJlPyBJIG9wZW5lZCBkcml2ZXJzL252bWVtL3p5bnFtcF9udm1lbS5jIGFuZCBJ
IGRvIG5vdA0KPiBzZWUNCj4gPj4+Pj4gYW55IGhhcmQtY29kZWQgb2Zmc2V0cy4NCj4gPj4+Pg0K
PiA+Pj4+IEN1cnJlbnQgZHJpdmVyIHN1cHBvcnRzIG9ubHkgc29jIHJldmlzaW9uIGZyb20gb2Zm
c2V0IDAuDQo+ID4+Pj4gQnV0IGlmIHlvdSBsb29rIGF0IDUvNSB5b3UgbmVlZCB0byBkZWZpbmUg
b2Zmc2V0cyB3aGVyZSBpbmZvcm1hdGlvbiBpcw0KPiBwcmVzZW50Lg0KPiA+Pj4+ICsjZGVmaW5l
IFNPQ19WRVJTSU9OX09GRlNFVCAgICAgIDB4MA0KPiA+Pj4+ICsjZGVmaW5lIEVGVVNFX1NUQVJU
X09GRlNFVCAgICAgIDB4Qw0KPiA+Pj4+ICsjZGVmaW5lIEVGVVNFX0VORF9PRkZTRVQgICAgICAg
IDB4RkMNCj4gPj4+PiArI2RlZmluZSBFRlVTRV9QVUZfU1RBUlRfT0ZGU0VUICAweDEwMA0KPiA+
Pj4+ICsjZGVmaW5lIEVGVVNFX1BVRl9NSURfT0ZGU0VUICAgIDB4MTQwDQo+ID4+Pj4gKyNkZWZp
bmUgRUZVU0VfUFVGX0VORF9PRkZTRVQgICAgMHgxN0YNCj4gPj4+DQo+ID4+PiBUaGVyZSBpcyBu
b3RoaW5nIGxpa2UgdGhpcyBpbiBleGlzdGluZyBkcml2ZXIsIHNvIHRoZSBhcmd1bWVudCB0aGF0
DQo+ID4+PiAiSSBhbSBhZGRpbmcgdGhpcyB0byB0aGUgYmluZGluZyBkdXJpbmcgY29udmVyc2lv
biBiZWNhdXNlIGRyaXZlciBuZWVkcyBpdCINCj4gPj4+IGlzIG5vdCB0cnVlLiBDb252ZXJzaW9u
IGlzIG9ubHkgYSBjb252ZXJzaW9uLg0KPiA+Pg0KPiA+PiBDb252ZXJzaW9uIGluIDIvNSBpcyBh
ZGRpbmcgb25seSBzb2MgcmV2aXNpb24gd2hpY2ggaXMgYWxyZWFkeSB0aGVyZS4NCj4gPj4gSXQg
aXMgc3RhcnRpbmcgZnJvbSAwIGFuZCB3b3JsZCBzaXplIGlzIDEuIEFuZCAwIGlzIG5vdCBsaXN0
ZWQNCj4gPj4gYmVjYXVzZSB0aGF0J3Mgc3RhcnQgYWxsIHRoZSB0aW1lLg0KPiA+Pg0KPiA+PiBo
dHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9s
aW51eC5naXQvdHINCj4gPj4gZWUvZHJpdmVycy9udm1lbS96eW5xbXBfbnZtZW0uYz9oPXY2LjYt
cmM1I24zOQ0KPiA+DQo+ID4gVGhpcyBkZWZpbmVzIHRoZSBudm1lbSBjb25maWcsIG5vdCB3aGF0
IHNob3VsZCBiZSB3aGVyZS4NCj4gPg0KPiA+Pg0KPiA+PiBBbmQgc29jIHJldmlzaW9uIHdhcyBh
bHNvIGxpc3RlZCBpbiBvcmlnaW4gYmluZGluZyBleGFtcGxlLg0KPiA+DQo+ID4gRXhhbXBsZSBp
cyBub3QgYSBiaW5kaW5nLiBQbGVhc2UgZHJvcCBlbmZvcmNlbWVudCBvZiBzb21lIHNwZWNpZmlj
DQo+ID4gbm9kZXMgZnJvbSB0aGUgYmluZGluZy4NCj4NCj4gb2suIEZpbmUuDQo+IFByYXZlZW46
IFBsZWFzZSBkcm9wIHRoYXQgZGVzY3JpcHRpb25zIGFib3V0IHN1YiBub2Rlcy4NCj5bS3VuZGFu
YWxhLCBQcmF2ZWVuIFRlamFdIE9rYXkuDQo+DQo+IFRoYW5rcywNCj4gTWljaGFsDQo=
