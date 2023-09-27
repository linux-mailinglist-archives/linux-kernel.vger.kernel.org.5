Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C467B0D67
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 22:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjI0U1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 16:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjI0U1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 16:27:11 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146B6CDC;
        Wed, 27 Sep 2023 13:26:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lpi1bVwLmJggizR0fHImyOxVd8jBAASEXx3JGMPa87r88fXrs/Nt4/a/7v3FNpZDdUwJ2MhoeD5xKjP6wPwmHJmdnuKj1c9OsPta4etyuffVs0PSflJ5zEUVGKrZy1fOsvWEJwMx9IC1VnV/3NpvVmTVFnE106OVa08M57NBaHdvHDD2dABPw8AzDedtfBdynfzFsDD2PhQa76FL34wbGfG2TQlSfXvo6mJAm1gpDiFt0oLQHjfZtjxQyYMuzQqrh9KrJIxglL+s+h3KaFGY4n7FeJX0BeDUevnZGu37lFIlKspuX68SrhiWGdlPSwzjTnG/4OqpPFyab/yWKoLRTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sfpTjXKnogKWKlt+Z//L0ddILnTOkgCzMSd+0UW2y4=;
 b=UBExDl5RJrkKfkrUB29YZpIQQfFwJ1E0XRMsqp0DUdfjcT7piC0iaLQZdkRbDuGdrMs+KydY7lixZRDusLc057i0rnQO7iPjH35abyJS/dL5ofOv7UReSPCVMSAsdyDEH1ULRYHyrwMzpM2+PDwIu7zwv+cMAxF9SO+UmvDBnmW6GNmcv0IRFymJTFKt3mQpy6yfJNq+7NzhOsj3A+MWcGuif0JAjhlYV89xymv9lgaZeeYDPBCiSqab6EZuVxehYfOeKhfWmeCVNv1jEUEYqlw5BQXkSFlIg9tSmkL5rRxfQ3F+yqvDM6oNR6KNF5BkT018CJl8yDRShzj50s4D9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sfpTjXKnogKWKlt+Z//L0ddILnTOkgCzMSd+0UW2y4=;
 b=gp7J6lETy87GW4MQJnLhrI2yvT6dfHrhOjRATbyp/bu1MHv9MqZeE45peVx2k/lSaftjHO1uhGfZT9Kb1gkwEw+FrlNs9oJknhYsTCWkxQP4oakXNYqWDXWA9eeRjm+sPCUVXn7YSlE/8ZkV6laftigFHnQBwcGt47qmcGocA8n4yr70VfzRo/AwMcEj5KjKX0OfU7vzPmbB1Hy7EzYH30yWktdODVWkO4GyikVkkXqqs/gtWxj+yzbmeTMKblW19hqCWKKihZSHleExbuVto3sFAv6erUgDjQJF9dSQ/vyfeqfVSp5lGNEA1Anc6UtXNmEVl49FwZ+wdONToeKshQ==
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 by SA1PR12MB8597.namprd12.prod.outlook.com (2603:10b6:806:251::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 27 Sep
 2023 20:26:50 +0000
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::b6bd:1fee:8929:c8c]) by SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::b6bd:1fee:8929:c8c%6]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 20:26:50 +0000
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     James Clark <james.clark@arm.com>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        Richard Wiley <rwiley@nvidia.com>, Yifei Wan <YWan@nvidia.com>
Subject: RE: [PATCH] perf cs-etm: Fix missing decoder for per-process trace
Thread-Topic: [PATCH] perf cs-etm: Fix missing decoder for per-process trace
Thread-Index: AQHZ60s/plmF0ru4nEi9jJXXWgBImrAs+aeAgAIpUyA=
Date:   Wed, 27 Sep 2023 20:26:50 +0000
Message-ID: <SJ0PR12MB567675310F0904A350873438A0C2A@SJ0PR12MB5676.namprd12.prod.outlook.com>
References: <20230919224553.1658-1-bwicaksono@nvidia.com>
 <71403f39-5894-154d-022a-f42fb344e488@arm.com>
In-Reply-To: <71403f39-5894-154d-022a-f42fb344e488@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB5676:EE_|SA1PR12MB8597:EE_
x-ms-office365-filtering-correlation-id: 7d8e3055-1a98-4d2c-6cc6-08dbbf9814ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HdJBcOk7ucKav0PNFkkcLf30sHmrTHtWOLBaz01GF61rTqUE6bBTUOvahlDX7tf+dy21wY6NwoEQIVjn14irTFj2gCNweoAn96Ibcj+28Wrqz0tZf3EqbHTSvagC6Wa3+rKqHWi8Zh4CZixbMxNBYDrFsgaJvfANl+NW/o86Y1H10yYdKdHZqqNV9IQnBjbbyuj5N6lc7ZTqziiktgUOb/8ldrJ0GX6aedtATrT1rP5Uhukk9zLj7V5f2irUO1wRtQe8ul6iwJ9T53A28/kEyVM4qRUReLNvwIZGn4eBKFTLJK+8+u0ev5eHbhT5EqPwJZhkUMpyX7dq0c14cgJAGENRstRmAA1u/YrOAFKjsvH4phrJquQq89YJi7FcaxJDXAsEZ62yLQkxqT2CvDi9jeJMR1pIRKLky9lDMu7soyAlUc/joMOH6V52ocd5w2eDY11Tuw0k83KYn3xDFnhv+LqucRAduonXrCju8AMb22F5WAXRfN67/p2UIiG3twxu6C0Z33paOa4EQOWujvmD9tTx9hWYeW04pWb8JljEPtw88O70UDVKqMq1WtBs7pPkMwYNuE/cTAq1fgjDdklONaEg0lnrINvq+3M/8TqArxeVbW4AVXsQswKL0M49vkyo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5676.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(39860400002)(366004)(230922051799003)(186009)(1800799009)(451199024)(55016003)(83380400001)(53546011)(38070700005)(122000001)(76116006)(66946007)(110136005)(316002)(64756008)(54906003)(66556008)(66446008)(478600001)(66476007)(2906002)(7696005)(6506007)(52536014)(8676002)(86362001)(41300700001)(71200400001)(4326008)(5660300002)(8936002)(38100700002)(9686003)(26005)(107886003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QklZamNpenk0VXgralJKQWRnZ3F4bXJoa3N0bGZJdzZmQnhUWmc4eWtidzF1?=
 =?utf-8?B?R2ZnVE1SeVhqcUpyYjhXclNaUzE3a2pCZUlXZzRWMzBVQyt5ZHR0cnpQV0VV?=
 =?utf-8?B?a2p2RFN4YU9leldJWDRCZFpSa1BJRkhPeHdIRkE5RG5GUHA0Y3pMUUhndnVz?=
 =?utf-8?B?Q0Q0dFdLdmF2SmNidXNrVjdvYU03SmdZd1lHblJ3TXhTUnZiTHRWNlFSWHg0?=
 =?utf-8?B?RzFjZmVKcmFiS1lSSUR5bzZRZFlLOWgzK0krZzhzYkpWaXFEMTdNRkNxYWNI?=
 =?utf-8?B?U0VPWDFrU2pMQzJNeG9aTlJzYk1VT1lpeXc4WWUwdUpXWSsrM2dFaFVFdzZG?=
 =?utf-8?B?aEFSRnIyK2R4K2pRMlEwcm51dTkwZ01tbTQzampxRDFuZE5hdUcvYmxPdzk2?=
 =?utf-8?B?aHo5NERXay8xYWtqbExBd3MxQldyS0FwYlJJaWI3WUY5aDJ5bDUvemZMQit3?=
 =?utf-8?B?S3pEL1FuYW5BcW5Scnoyclk3N2tHc2M3Ym5ZNkRsMnl5dGJUNWMzTnA4Qk5w?=
 =?utf-8?B?cmdadjEzMlc5ek5qQU15OFlmeVdTMC8xNVlYaUZxamplT0RnMEowOU9tb2lr?=
 =?utf-8?B?Vkg0ZS9pdXMxai9QaHU3cGt0NlFiN2ZUdDhhaVpyYTR0aEpmMUg5VnJjSjBX?=
 =?utf-8?B?YkZLNWZwaXRiZXdGOEpGS1VmMWlrL2RobXNJMk5DdVhOQUN0bXhDTU15MGR1?=
 =?utf-8?B?ZWpVWVhaTzdvZnN4djJOR3Q3bGpYV1Vwb2I0NFhJcUpVeklVcDZMZWZnaGEv?=
 =?utf-8?B?UDczSWFOeEtzZDdpblRQKzVOc3RSQ2IxbnE0OGxvQ3p3WCt5Y0hoL01SSE9J?=
 =?utf-8?B?Y3JCQXVuRHpmenRTSS9QOWVvdENVRlE0ZEpiSnNtOUtHbUMxRmdzU21QM1A2?=
 =?utf-8?B?WVRCMS8yVTZRUEFSSzFCMVYvNEFubXMzZUptb0pDZVUvTW9UMzY5WStlQTNE?=
 =?utf-8?B?QVRCY3MybmZEZTdpcVFmZXYvOWtRekRFSlMveFJkZWJLaGRHcWcwaFdYMXN0?=
 =?utf-8?B?elBrUHlkMHlZMXIrMmpsQTJ2WnoxaE1BWVJBV1kzR2t1Q3ovY1hLNnpHSFJa?=
 =?utf-8?B?RkNoZ1YzT3hhaWJIeDdrTGRSeUpMaEZLTmozTkVoSll4K0JXQWtEd1F5OHF3?=
 =?utf-8?B?akRib1U3dkg5RE1UY01YWmpCS1FrSU5CU054bzJnVmxoUFozVlNyQWJTdEQx?=
 =?utf-8?B?TGUwQ1R2OVVkNllFMTNzVlU4ZEpiQkdHcmFqZEh2dTMzSnBnVjRGc1VCcWM2?=
 =?utf-8?B?ZEEwNEJpaTh5Wk9yVXZXMWozaHAvSEtKdDloZ0xwY2p1clMweTBRdHhJUzlh?=
 =?utf-8?B?V0JCOFh0R2x1cnpNRUUzUjBvb00zNHBrRWxqWHFLR240Q2hLWktMcXVzTzRq?=
 =?utf-8?B?YzN6YmdNNURKMExLVW9yVmE2N1pzLzhHMjF3blBtSU1tWHV2WHRxR2lBcDZj?=
 =?utf-8?B?M21Yb085bmh3clBIc3JjamVIOEpQM1Bqd3N0V2pWaENuSjVGa0FaTFhHQjhJ?=
 =?utf-8?B?SjI1elJRd3lsb3NlenNoeTJhREcrK0dYZUE4WXdNT2oveE9Oa25aNEFQWFQv?=
 =?utf-8?B?cjMxWWJnQnVhSXBmWXJMQUIvU0xJZ0hnS1cyWHRyZUd1VTNyRlJzdDIvdC9M?=
 =?utf-8?B?RGFmcTN3WW0xaVpKYUFxVWNnNm04aU53L1JaVnliM1VpQ3VMdW11VlRDbHVV?=
 =?utf-8?B?aGV2V2FQY0s1cmRpc25ES1BxNys2U3JtaGhReG42VFF6Q0o5Ym1URFJtM2Nl?=
 =?utf-8?B?MC9FWUg0TjlQR3JSdnk0b0NTVk96TE1vNFREZmZqZnJCL3pIUzR4ZmpMbU5m?=
 =?utf-8?B?R0dEZTcrbDZubUJ0NU94WlJTODRraCt1OVJZbzc2RjhIRjFWbmU0QW9IM29E?=
 =?utf-8?B?alZDU2NYNmx5NHlPeEVqTEpqZkIxeGRFK0oweW5FNDVMNDdYenFKVEtsUEw4?=
 =?utf-8?B?MS9NM3BjaFBSN1Q5NVBvcVVNRTd0clBLU1R3RjYzRDNkR1FrNmE5UW15RHhr?=
 =?utf-8?B?WkdwOFNKcHlxcmh1Q3FxelhSbDljdHlCUmVyQjVEdVVQSE5wNlJlWXRyMXpK?=
 =?utf-8?B?RjNoT1htWTZ2ZTFkamNSLzZQeGpYR1dlMERnN0RlNzdURHR0RVk1eUlaSXJR?=
 =?utf-8?Q?JRQl+8vBaunx6x2nefsDqZYqD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8e3055-1a98-4d2c-6cc6-08dbbf9814ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 20:26:50.7722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KrU5rOglBfuALQWSYe2cZyhqdbaBOSQXHLv1zbh4WcloxVsirstS1VfBTPsQClRsz9Hos9sUxKmdDwGIN5iBQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8597
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFtZXMsDQoNClBsZWFzZSBzZWUgbXkgY29tbWVudCBpbmxpbmUuDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFtZXMgQ2xhcmsgPGphbWVzLmNsYXJrQGFybS5j
b20+DQo+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAyNiwgMjAyMyA1OjU3IEFNDQo+IFRvOiBC
ZXNhciBXaWNha3Nvbm8gPGJ3aWNha3Nvbm9AbnZpZGlhLmNvbT47IG1pa2UubGVhY2hAbGluYXJv
Lm9yZzsNCj4gc3V6dWtpLnBvdWxvc2VAYXJtLmNvbQ0KPiBDYzogbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBjb3Jl
c2lnaHRAbGlzdHMubGluYXJvLm9yZzsgbGludXgtdGVncmFAdmdlci5rZXJuZWwub3JnOyBUaGll
cnJ5IFJlZGluZw0KPiA8dHJlZGluZ0BudmlkaWEuY29tPjsgSm9uYXRoYW4gSHVudGVyIDxqb25h
dGhhbmhAbnZpZGlhLmNvbT47IFZpa3JhbQ0KPiBTZXRoaSA8dnNldGhpQG52aWRpYS5jb20+OyBS
aWNoYXJkIFdpbGV5IDxyd2lsZXlAbnZpZGlhLmNvbT47IFlpZmVpIFdhbg0KPiA8eXdhbkBudmlk
aWEuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBwZXJmIGNzLWV0bTogRml4IG1pc3Npbmcg
ZGVjb2RlciBmb3IgcGVyLXByb2Nlc3MgdHJhY2UNCj4gDQo+IEV4dGVybmFsIGVtYWlsOiBVc2Ug
Y2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gT24gMTkvMDkv
MjAyMyAyMzo0NSwgQmVzYXIgV2ljYWtzb25vIHdyb3RlOg0KPiA+IFRoZSBkZWNvZGVyIGNyZWF0
aW9uIGZvciByYXcgdHJhY2UgdXNlcyBtZXRhZGF0YSBmcm9tIHRoZSBmaXJzdCBDUFUuDQo+ID4g
T24gcGVyLXByb2Nlc3MvcGVyLXRocmVhZCB0cmFjZXMsIHRoZSBmaXJzdCBDUFUgaXMgQ1BVMC4g
SWYgQ1BVMCB0cmFjZQ0KPiA+IGlzIG5vdCBlbmFibGVkLCBpdHMgbWV0YWRhdGEgd2lsbCBiZSBt
YXJrZWQgdW51c2VkIGFuZCB0aGUgZGVjb2RlciBpcw0KPiA+IG5vdCBjcmVhdGVkLiBQZXJmIHJl
cG9ydCBkdW1wIHNraXBzIHRoZSBkZWNvZGluZyBwYXJ0IGJlY2F1c2UgdGhlDQo+ID4gZGVjb2Rl
ciBpcyBtaXNzaW5nLg0KPiA+DQo+IA0KPiBIaSBCZXNhciwNCj4gDQo+IEl0J3Mgbm90IGp1c3Qg
cGVyLXByb2Nlc3MgdHJhY2UsIHRoZSBidWcgaXMgYWxzbyBpbiBwZXItY3B1IG1vZGUgYnV0IGl0
DQo+IG1lYW5zIHRoYXQgdGhlIG1ldGFkYXRhIGZyb20gQ1BVIDAgaXMgdXNlZCBmb3IgZXZlcnkg
ZGVjb2RlciB3aGljaCBpcw0KPiB3cm9uZy4gQWx0aG91Z2ggeW91ciBjaGFuZ2UgYWxzbyBmaXhl
cyB0aGlzIGlzc3VlLg0KPiANCg0KR290IGl0LCBJIHdpbGwgdXBkYXRlIHRoZSBjb21taXQgbWVz
c2FnZSBvbiBWMi4NCg0KPiA+IFRvIGZpeCB0aGlzLCB1c2UgbWV0YWRhdGEgb2YgdGhlIENQVSBh
c3NvY2lhdGVkIHdpdGggc2FtcGxlIG9iamVjdC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJl
c2FyIFdpY2Frc29ubyA8YndpY2Frc29ub0BudmlkaWEuY29tPg0KPiA+IC0tLQ0KPiA+ICB0b29s
cy9wZXJmL3V0aWwvY3MtZXRtLmMgfCAxMzAgKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0t
LS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3NyBpbnNlcnRpb25zKCspLCA1MyBkZWxl
dGlvbnMoLSkNCj4gPg0KPiANCj4gWy4uLl0NCj4gDQo+ID4gKyAgICAgaWYgKCFmb3JtYXR0ZWQp
IHsNCj4gPiArICAgICAgICAgICAgIC8qDQo+ID4gKyAgICAgICAgICAgICAgKiBUaGVyZSBpcyBv
bmx5IG9uZSBkZWNvZGVyIHdoZW4gdW5mb3JtYXR0ZWQuIFVzZSBtZXRhZGF0YSBvZg0KPiA+ICsg
ICAgICAgICAgICAgICogc2FtcGxlIEFVWCBjcHUuDQo+ID4gKyAgICAgICAgICAgICAgKi8NCj4g
PiArICAgICAgICAgICAgIHRfcGFyYW0gPSB0X3BhcmFtczsNCj4gPiArICAgICAgICAgICAgIG1l
dGFkYXRhID0gZ2V0X2NwdV9kYXRhKGV0bSwgc2FtcGxlX2NwdSk7DQo+ID4gKyAgICAgICAgICAg
ICBpZiAoIW1ldGFkYXRhKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHByX2VycigiQ1Nf
RVRNOiBpbnZhbGlkIHNhbXBsZSBDUFU6ICVkXG4iLCBzYW1wbGVfY3B1KTsNCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gICAgICAgICAgICAgICB9DQo+IA0K
PiBBcGFydCBmcm9tIE1pa2UncyBjb21tZW50cywgdGhpcyBsb29rcyBvay4gVGhhbmtzIGZvciBm
aXhpbmcgdGhpcyBpdCBoYXMNCj4gYmVlbiBvbiBvdXIgbGlzdCBmb3IgYSB3aGlsZS4NCj4gDQo+
IE9uZSBpc3N1ZSB3aXRoIGNhbGxpbmcgZ2V0X2NwdV9kYXRhKCkgd2l0aCB0aGUgc2FtcGxlIENQ
VSBJRCBpcyB0aGF0IGl0DQo+IHdvbid0IHdvcmsgd2l0aCBvbGQgZmlsZXMgdGhhdCBkb24ndCBo
YXZlIHRoZSBDUFUgc2FtcGxlIGZsYWcgc2V0LiBNaWtlDQo+IGFkZGVkIHRoZSBzYW1wbGUgZmxh
ZyBmYWlybHkgcmVjZW50bHksIGFuZCBJIGRvbid0IHRoaW5rIHRoYXQgd2FzIGENCj4gYnJlYWtp
bmcgY2hhbmdlIGZvciBvbGQgZmlsZXMgYXQgdGhhdCB0aW1lLiBJdCBzaG91bGQgYmUgZWFzeSB0
byBhdm9pZA0KPiB0aGF0IGJ5IHN0aWxsIHJldHVybmluZyB0aGUgbWV0YWRhdGEgZnJvbSBDUFUg
MCB3aGVuIENQVSA9IC0xIChXaGljaA0KPiBpc24ndCBjb3JyZWN0IGJ1dCBpcyA5OSUgbGlrZWx5
IHRvIHdvcmspLg0KPiANCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2ssIEkgd2lsbCBhZGQgdGhp
cyBjaGVjayBhbmQgZGVidWcgbWVzc2FnZSB0byBpbmRpY2F0ZQ0KdGhlIG1pc3NpbmcgY3B1IGlk
Lg0KDQo+IEkgY2hlY2tlZCB0aGUgQ29yZXNpZ2h0IHRlc3RzIGFuZCB0aGV5J3JlIGFsbCBwYXNz
aW5nLCBhdCBsZWFzdCBvbiBhDQo+IHN5c3RlbSB3aXRob3V0IEVURS4gSWYgeW91IGNvdWxkIG1h
a2Ugc3VyZSB0aGV5J3JlIGFsbCBwYXNzaW5nIGZvciB5b3UNCj4gYXMgd2VsbCB0aGF0IHdvdWxk
IGJlIGdyZWF0Og0KPiANCj4gICBzdWRvIC4vcGVyZiB0ZXN0IGNvcmVzaWdodA0KPiANCj4gSSB0
aGluayB0aGV5IGN1cnJlbnRseSBvbmx5IHdvcmsgZnJvbSBhbiBpbiBzb3VyY2UgYnVpbGQsIGlm
IHlvdSBnZXQNCj4gc3R1Y2sgdGhlcmUuDQo+IA0KDQpUaGUgdGVzdCBsb29rcyBvayBvbiBteSBz
eXN0ZW0uIEhlcmUgaXMgd2hhdCBJIGdvdDoNCg0KNzQ6IENvcmVTaWdodCAvIEFTTSBQdXJlIExv
b3AgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA6IE9rDQogNzU6IENvcmVT
aWdodCAvIE1lbWNweSAxNmsgMTAgVGhyZWFkcyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICA6IE9rDQogNzY6IENvcmVTaWdodCAvIFRocmVhZCBMb29wIDEwIFRocmVhZHMgLSBDaGVjayBU
SUQgICAgICAgICAgICAgICAgICA6IE9rDQogNzc6IENvcmVTaWdodCAvIFRocmVhZCBMb29wIDIg
VGhyZWFkcyAtIENoZWNrIFRJRCAgICAgICAgICAgICAgICAgICA6IE9rDQogNzg6IENvcmVTaWdo
dCAvIFVucm9sbCBMb29wIFRocmVhZCAxMCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA6
IE9rDQoxMDM6IENoZWNrIEFybSBDb3JlU2lnaHQgdHJhY2UgZGF0YSByZWNvcmRpbmcgYW5kIHN5
bnRoZXNpemVkIHNhbXBsZXM6IE9rDQoNClRoYW5rcywNCkJlc2FyDQo=
