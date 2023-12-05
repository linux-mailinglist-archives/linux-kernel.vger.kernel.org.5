Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C358049AB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 07:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344304AbjLEGCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 01:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjLEGCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 01:02:30 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF732C0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 22:02:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odIYlziJtgzY9prIh90ekeLCE/VpuDFddlXthXQFlnyOKgywqsuEQu6AOwrL2hbH4j3NxhdWJZzZeX3wFbJ8p/v5UrhGpju8K5TeW/krBBVHTso/0OKGcSPBvukE5v7HgsYqdkA22KBQHlG4FAlo9ozJtHHtGlQjEmSJLfatymXedxNBjGWQNqbQwEZsQaeaTaVCGhiyuDYpfgNKh2ZVCq0+rcdYf00EELHApAo/dcOaA2VEtKAshxeRksie+gPGnTZcUn5pJVs/ZS/XNlIqGNlkfAO0DeLMY/wocrQduFNHrBzgr/Xv9kUb79cFh7DshWgsFUTIrn4YEawMBG7wIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQCp2hf/70Gn5rxJkuZC/ORvFXhEtAwagxfBEN4iFMg=;
 b=hXqB59Dy9UKGEE/byhORhrR1rBQY4yWUu2S7tzXdTi+//4vM4LLDhVTpweWQZxtgoyFjnizTPogCKM3JIFm5by55CvnywG7geeawLWHXdLwXdjs/3zVTQnaAbMdQOW3Ctc1xoKno8FAf3GJ2uEJoUZdSonfS9I/6eKkfVn6AtkKuFTUUnG54SoxatCFmobRrNYPDg0H07dQDqUcbpKlZAL5Yb6hdbm6jfqoL5ZZ0RHlXZelo4EEttRvaBI5XJia626rhUS/jXR/+DN6rkiC0OThSskUdzXIFdJbV04FhnuKmP+5TtT4QUJN3f0wl/icCJBDKulf2KkEzFSuWLNbhvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQCp2hf/70Gn5rxJkuZC/ORvFXhEtAwagxfBEN4iFMg=;
 b=KcXhUZz75DYi2+jHg9XADnOOhpfoNoNdIYruYhbJsGYNURLuO5UJhwXmk3jemX8JaHhc4hn31oqvkmWc+9ytvX6qZftXkC3ogjaXbF+EPaeq2HDZmDyAy78PECW3J8xi9COOvlWpUF/wtT6cfTp87SKHSjsAgQMxEHpKwqZ3AtVh2EIayKTIc084I2cOSYKO3Mc10Rta9Remjk6+XBpNuzQJD6tuObWBSjab4ZEfqtpxk5RU67zGFysIrTs3/Psnllm28PHZLz/BrT9vBf6TBwZXQfaZmruZ5UxGepB3h1dkm34acho5QJN30882G9N/duhI3Vx1EOYzQtUSRLm19g==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB7637.namprd12.prod.outlook.com (2603:10b6:208:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Tue, 5 Dec
 2023 06:02:34 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762%7]) with mapi id 15.20.7046.033; Tue, 5 Dec 2023
 06:02:33 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC v2 3/3] nvme: add csi, ms and nuse to sysfs
Thread-Topic: [RFC v2 3/3] nvme: add csi, ms and nuse to sysfs
Thread-Index: AQHaJDi9n4Hi//BnoE2HLOC4/QdxS7CaONSA
Date:   Tue, 5 Dec 2023 06:02:33 +0000
Message-ID: <3736f00c-3019-4da0-acb8-95af338b3c88@nvidia.com>
References: <20231201092735.28592-1-dwagner@suse.de>
 <20231201092735.28592-4-dwagner@suse.de>
In-Reply-To: <20231201092735.28592-4-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB7637:EE_
x-ms-office365-filtering-correlation-id: 34b23bf7-5871-4f7d-9270-08dbf557c609
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p5U3myLuEMkVRAl2SDK7s0cJ/ffvLptArLMUAhTj9EA5Sc1aJLWhIjh/KLsEA4fwjC3n6hb8/jMb2iA4frInc3BQO4QYvCBnV0Z1tM1WmU3ZHLN3LyCQRkcWY1gEYZFPfcyTJpAeBetq2cWh0DZKnSf6h2BVO7c0GauvD2gnKJKEFt9chos0VDQ0rDfFcfvqgcnKo9F+9o86vFXiSxMSdLfPdxN1KfIWl281YLBi0+WW8r603TRvw/CCp6ofZZBbZeTX/jLsju5JqzPPtLfyeUb8KK4+ON16AfVX9zhhz0MD0YjzftPie4FXIsq+mQVt93Alo9Z1MivMrt4hoIy6S299dzTB0PCerFIjlWxK7jyCNzh6VBgK7/D2JaeiyvHAKZDyR+6akT3zNbekOdWkN7BXlWeHNMrZdoHoxr0KpKfTBAnefIWvlSNdzjHsT+84e7NL17ExFzkVtoqcY1iKwwiqSnppo9Q+CqPbYpSMIyUgs3cAipp/yE7EJst8iFY83ZfS847gJBs/VlRjDwLZbjMEL1b7k4o06yJgCCgBXAuQMnk31Tad48BqOc7XuB8Oyc9uSiaaE7J4/Dghckm6/QBJiZEzRZWvFrU+TygO8ufG2WFSXXkAZUYYfAxMObf+NC2Oe7uUcPaLezVG7PsqYSvRYIpWbOvv9VMM4o07IXepspF8G8VQEDq2LukPB7YU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(39860400002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(2616005)(122000001)(8676002)(8936002)(4326008)(6512007)(6506007)(53546011)(83380400001)(6486002)(71200400001)(478600001)(91956017)(66476007)(76116006)(64756008)(66946007)(54906003)(66556008)(66446008)(110136005)(38100700002)(316002)(2906002)(36756003)(41300700001)(38070700009)(86362001)(31696002)(4744005)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHhuNTZlcVBnRGhIQzZJUXErSnlvamc2TVFjTml4TXB0YkNybjlCSWNiV1JX?=
 =?utf-8?B?U2NGUTI1dDA1YjduZUZzTGwwK3grMWV2aE9qZkRxUFZSZllsdUpmZFpUekZH?=
 =?utf-8?B?eUtPbitzalhmWGl3MERILysvWFE2UGFxSnRKMTlyL1hiaURybnBYT0ljZWpH?=
 =?utf-8?B?VFhxS1lvRU5RVHZoeVQrRHRZSUxwOWRjVEliaDFFbmErMkUvRW5xK0NsRnY0?=
 =?utf-8?B?TkV1UjVTaFR2aU9STHVLYWJaWHlhai9Pb091ZFJHdUFVOEg3RzVobk1URURE?=
 =?utf-8?B?YmZVM0lCQldoSHpOajFHaUlHR0U5NzBCK3JZcko2Tmh2ZXQ0QmJDeXVOOXA1?=
 =?utf-8?B?dzJNYjcwbGJRbUdpVjN0dGVlWW1JZ1JBbkJvQ3JYVHFwN3cvVmdYcnBxNGlu?=
 =?utf-8?B?emdBSjRDNWhESjZKM3VGSXdzUTMxNjJYdEV1Ylg1aUxvaFg5YjlVVUpKc0JE?=
 =?utf-8?B?Y1VwSllFeXA2eXltZGd5eERTVFRJaUpHS2VDV21JZHhQcTg4eFRMeDhvbEVX?=
 =?utf-8?B?L1dTbjhqOUdTWUhGeGRCaVBRYm9jVzVhUXhUWXkrN1hLRExuaEthUHRIUDhh?=
 =?utf-8?B?WTROZ2owWkN3WnByU2ZHaUY4WFlReTF3ZHhFUExpZ0FKNnRiQnVuUnFYNUI4?=
 =?utf-8?B?M1VmZjRnbHRKSXNTanptTDE3REhxSkt3VWxLb0NHU3N1aUJZR2c3K0xpSmFm?=
 =?utf-8?B?VTJ1M202UXNVS2dDVzRSK25ueE9aTnVEb0UxSXUvZlkxUWtzSDdUVnBjNnRD?=
 =?utf-8?B?Q0dVY1E1eWZwaFp1UkxEeXVJeHk3VEF6VitRQU5UcHRYTUpzaE5kcjd1WGRz?=
 =?utf-8?B?aDZrdU1xeU9GK055bjlEL25IMVJjTGJ6YlZQK0xaWGw5QW1JaDZLZXJlVzYz?=
 =?utf-8?B?U1gzdUQ4S0F6bE4yRTVWcDFiSy9rRUJSbDRZT1RvQnRqN0JaSzhLODg0QVJT?=
 =?utf-8?B?S3NQYnVvNXZ1OEVZL3JCOXhTRWtUazlocnFLUEcza2QxbWZYVkR5dTZGRDFW?=
 =?utf-8?B?VUdaZFZQVUd3Y1hwYWszQWZPczQ1ajY3MzREMmoydENBbGtDeW1MdDB2N2V2?=
 =?utf-8?B?cXNYcmlwRnhsekpNeUY5SGplTmY0ZkhVMkE0QW5KbUxsQWdDbUVRVWRhSmpL?=
 =?utf-8?B?UUpsSFRZenpRVk1mNUlmc3pkSndMTUlrY1lsMk83MGloRTRBL0dsdUtCblZN?=
 =?utf-8?B?Vno5SEdiN0V5Vy9Kc1F3bU9maXRWK1c5OWoxbkZTazRHM1doM2JVWUdwMG5H?=
 =?utf-8?B?d1YwY2R1UzA2SGhvVGl2WHRCZG53Y2R2eGlsVjhGZ2I0Ukl6ZEdDZHVaRmxk?=
 =?utf-8?B?OTFDZlJwM2JoYjB1NkJJQlFBZjErQlhlcFkxV05VY2JBUXFLMzNYalZvSWxv?=
 =?utf-8?B?UW5hNVJ4QVRDVWZKVjRPY2xoR3BjUHAzb2FjaWlDdDdRaHFyUWlidmJ1NnNj?=
 =?utf-8?B?S05BRnFHMXBLODlPd0dRSUVHa0xpNGhyZkhENTdHMDg4dTBUdU5KOXVKUkhC?=
 =?utf-8?B?b08rb0xOSWpGZXVBVE8xYWF3b1hRWGExVlVoN3F3aUpsQ3g2S2xiK2Q2NnZj?=
 =?utf-8?B?em5Cd3Y1NUNLZ2VpazB4Ni9yMVhFU3o2UENtQXY4ZDl2Ris4U2x4VkZNSWl3?=
 =?utf-8?B?VWhOeXF2aE9FZUJrM3d6VngvVHRGNkJvaUhoam9wUFdWNGtVc2FlNGRBWmsy?=
 =?utf-8?B?cWJFalZ1T2JEc3VMcTI4U0dRbC9vL3ErR0t3bVhtQkx4aytNTjBhUWpsRXFQ?=
 =?utf-8?B?WXVsUm1MMk43NG1MQXZQUTdnSDVyKzVTRTdYZ2lGNTJhSzZlcTRINTBxQUlE?=
 =?utf-8?B?R0ZuQ1c4R3NVWlZNdDJqaER1YS9ZRmRReGtXUWJoalk3WHZhS1ArL2JwK1Ir?=
 =?utf-8?B?eFRiN2pXWXJTd1BQMkhEeHhBenI5TnhwK29EVHZPQkxFNnhUdDB5L3k3Unlu?=
 =?utf-8?B?U2YvL2ZURFJXcDhJUVc0cW5tR0RkYy9uRlVHUUxJQVVtVlpvZStZWi9Qeis0?=
 =?utf-8?B?QTl5bDlRcVFCeEpPYmFMaHlRRklrTWlnNnVxUldMTy83TEdaQjk1c3pTZHVH?=
 =?utf-8?B?cEVVSFUxZDk3NEVkeVNYOWNJc0p2ZTllL1B6d09UZ0xNK2dqQ3UxL2FLS0wv?=
 =?utf-8?B?NElzSjlvbGxNdlZnSEl2S0Q3aTdBTS9KN2dLcjF0MnNyTUR6L0l5U3VpSjdS?=
 =?utf-8?Q?8DFOqbEFJl5nEigvfI8fH7Tdpgy22IzrZmOJn2IWpZVu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <87B39B5A0AEA164D811CBC894DAD0BC1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b23bf7-5871-4f7d-9270-08dbf557c609
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 06:02:33.6211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XTYK2z2z3eD/okIvGHJlmVxMlZG9lOTgHYcUc5duVu03aBcJfHOr6q7n2/OSnGCOpHxuyBFj94pmwOZ+JvV2cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7637
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMS8yMyAwMToyNywgRGFuaWVsIFdhZ25lciB3cm90ZToNCj4gbGlibnZtZSBpcyB1c2lu
ZyB0aGUgc3lzZnMgZm9yIGVudW1hcmF0aW5nIHRoZSBudm1lIHJlc291cmNlcy4gVGhvdWdoDQo+
IHRoZXJlIGFyZSBmZXcgbWlzc2luZyBhdHRyaXRidXRlcyBpbiB0aGUgc3lzZnMuIEZvciB0aGVz
ZSBsaWJudm1lIGlzc3Vlcw0KPiBjb21tYW5kcyBkdXJpbmcgZGlzY292ZXJpbmcuDQo+DQo+IEFz
IHRoZSBrZXJuZWwgYWxyZWFkeSBrbm93cyBhbGwgdGhlc2UgYXR0cmlidXRlcyBhbmQgd2Ugd291
bGQgbGlrZSB0bw0KPiBhdm9pZCBsaWJudm1lIHRvIGlzc3VlIGNvbW1hbmRzIGFsbCB0aGUgdGlt
ZSwgZXhwb3NlIHRoZXNlIG1pc3NpbmcNCj4gYXR0cmlidXRlcy4NCj4NCj4gVE9ETzogdXBkYXRl
IG51c2Ugb24gcmVxdWVzdA0KDQpjYW4gd2UgcGxlYXNlIGF2b2lkIFRPRE8gaW4gdGhlIGNvbW1p
dCBsb2cgPyBpdCBsb29rcyByZWFsbHkgb2RkLg0KDQphbHNvIGNhbiB3ZSBhZGQgYSBwYXRjaCBp
biB0aGlzIHNlcmllcyBpdHNlbGYgdG8gYXZvaWQgYW55IFRPRE9zID8NCg0KdW5sZXNzIHRoaXMg
aGFzIGFscmVhZHkgYmVlbiBkaXNjdXNzZWQgYW5kIGFncmVlZCB1cG9uIHRvIGhhdmUgaXQNCnRo
ZW4gcGxlYXNlIGlnbm9yZSB0aGlzIGNvbW1lbnQuDQoNCi1jaw0KDQoNCg==
