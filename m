Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BA778E788
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 10:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239913AbjHaID7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 04:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238060AbjHaID5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 04:03:57 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159A3CED;
        Thu, 31 Aug 2023 01:03:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCWJpo0RU6L005zWSAzQafpa4LAlw3Jp1CVHrCUQawIetOJgG6Y21aKQp1esO7ovwlY4BJAnaKngq/H0zNw6fIZjuTe0GkOCAMGElHC5twcaCyPBVkFE0sw5uwo1Abv/+owREp0xB55hiYKy9YtZKxQymGr0hDtPOXe0cJ819cB9Wf/xY96nm0lojb06dXw4I5xUKaDOAxdjp7UB5LOUIp8GxGB2QdRjrFo2TQwI7PLeE56lgNQmx4zSssD+OqHaX6OpT8jf9hxYXASVtsdsm7M+KUOw0KzOO+HMfP7RwhtKwcLghkLD/JXYuYlThJCubLTHAQRie6UPmEEhRcUYOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b20B8hcWNqfgcipu5JWxgwMxydRBNmSwZ8U8FBGAWaw=;
 b=CCu5ZoADPRIoQalcAz56Pe/eP6G/HhajBqk2brT5KBHEYjTgbVdAzEXpw7/BWKYez55afuPaFttkwxTgfhGpeS6BHvDFX2c3zKIlQ1fbs0DIuh+ccwKOlTpgV1StUbMx8XndItuI6ZruAU8T5JViq7A5qbVxBsIQo/DROz6Tg5A4QNpda8LCA6V4oGHGTWoT3H6BIUZYWmUiZ9phIu2uH/blCrMSs8xry8hTu40jW365Rry9diyD3EEVxLDzFLfYs1xcICdEuoFzRfCpzxbUJSmfFwtuGuYtOtoX8yhDtR9TTIk3r5vOXpaIKFpRS7H7cTHcO9adpmxKN/cZjw77Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b20B8hcWNqfgcipu5JWxgwMxydRBNmSwZ8U8FBGAWaw=;
 b=SArddcCRYcqMjWHvjUoRmDQOJo56/XQqNC3MXShiWw+sn5xcpUM1GIo6v4ADhyda/Sn+mPCc292VRubqQNM5q5eA2L9063XBGfwf2w5zrJSM0aKU6r6R7pxK93Frs2f2hFf0aFss0dsjgIg6wkwkMufP/6jpNASmnsfLoPJMph7rLi27T5BTn2PjSwBegud0D+aAUtgu2GFbElfIekXP/Mo3nM6TGsvCH7WeW5oeLA6e+ExqizBatMpkdoD5p03sE0+D1F0dEU53rMaIE/tu/pEeKtk7s8uxmNYn3+N2uykZ5HLHeDDIcLVCYviod/CW44W5N4Kc5tP7nBgvMwaKtw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 08:03:47 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f55b:c44f:74a7:7056]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f55b:c44f:74a7:7056%4]) with mapi id 15.20.6745.015; Thu, 31 Aug 2023
 08:03:47 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests v4 0/3] Introduce nvmet target setup/cleanup
 helpers
Thread-Topic: [PATCH blktests v4 0/3] Introduce nvmet target setup/cleanup
 helpers
Thread-Index: AQHZ2yMp/xEgd+pf7U2R0d+SWiSdBLADroOAgABejYA=
Date:   Thu, 31 Aug 2023 08:03:47 +0000
Message-ID: <f0e73932-1ef5-1792-383f-7e516a7b8446@nvidia.com>
References: <20230830092019.9846-1-dwagner@suse.de>
 <yhnyazgqmgbzsa5irt4cu3735qxuvbl5czicsaxl7zm6ckjkzf@2cs7fpg2qvpb>
In-Reply-To: <yhnyazgqmgbzsa5irt4cu3735qxuvbl5czicsaxl7zm6ckjkzf@2cs7fpg2qvpb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH7PR12MB5685:EE_
x-ms-office365-filtering-correlation-id: 1515061e-673b-4110-5457-08dba9f8ce06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qW9SBm+BSjn60255cpfrFXPrSpWqYtak7qXNc86BjldPOAMd3bl2Slv5Vu//77e/Zc481F8W2c78c7PAMNv70qgjaDmSPGz1tcwRNrHGf4mSOXI3ypRrrlw8Lz8tUyEFU6Apz6UDQUo/igF3Hbh99sKl3Pz4y+9l/ESUiedChVKsvDMZGhhLoQe57OVhnPe505boZi7uXBHEiKIGCrYkznZeYNofYpkUrTrzt/efeAalgA4bVRSvfb/eAsX1w+DEBIZ/OfkYCj4zZhcnSmKUmG1vP6aAuazDleCMZDREzK+lbjiuZcazCP+wYqQQFJtjxb9OHykRPQjM8uafyA8AL2FcwCLwsYuQY9iTzOHsd462CLHJKstV3HyYKmWBL9/XDYD01lYL/V3Y6fVU6mzRDmJNo/LpCYuCpzPbqh2MZMbHFGSOi1pBnw8tZi43JOknKZJEayHQ2vHY37F2HD1V83csiY908YqnjBmxr9cFW7Oz1fBqhqdSiFT+RjSMhF8WuCoCk+G3xQptZTrURdTfgHqOHXUup1+wayJiAtqP1jxFspVESn1RvPZepQGHl3oFtNEjpKI8xSstNR/4t8vzDNW63Nk8x1A3xQXiiY4qWRuvXTqImzsV6U4YGCT+hMo69xJoQ4bWXju6opnb6KzYRRgXWx2ACeYVtIUSv6LEabunGs2AwpCKRSgPjtgSW52hFk+Fgy6WK83++jvcG39D8eFP8EVbN89BVXjWA02/nEA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(376002)(396003)(186009)(451199024)(1800799009)(478600001)(66556008)(66946007)(66476007)(66446008)(76116006)(54906003)(64756008)(316002)(110136005)(38070700005)(966005)(38100700002)(122000001)(2906002)(91956017)(4744005)(31696002)(41300700001)(8936002)(8676002)(5660300002)(86362001)(4326008)(2616005)(6512007)(6506007)(6486002)(71200400001)(26005)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3JBU1lQTVhpV3NzbEJUY2VMN3dTTUxKZElWZ1ZzK1V6N0p2bmhhY3BxZTV1?=
 =?utf-8?B?TDJmV3FtZkRZMDFwZGp5bkI0Tkx5OEZVQXRJZ3VOd3laM1QyeEdRMWp1ZFFP?=
 =?utf-8?B?ODZZMzE0cUNIRDkrL2FHSlUzL3JUME1nNlNvRVY5b3FPS2p0QVdjTkkvcE1E?=
 =?utf-8?B?S0hpOXZJUG5GSUtlcXlYR3BQdm5JVWdkTWlmd1ovanhrcytzVGtwK1NKa2oy?=
 =?utf-8?B?KzYzcVpEbkcvOU01anorc3RzWmtmOFRWRWt5TmNWN3RwcnhvZE04Nnl2blNF?=
 =?utf-8?B?WUZsaENEWXBDV1ZITXJ3bzROU2pRYkxSSFRVWkxzaW0xQWFPbUVpbWRBVlVi?=
 =?utf-8?B?R2pKZ3UremQ3eS82dXFISUZtTjlrM24zRG5qL1l6M2tNRElHdUZxUFR6dVRl?=
 =?utf-8?B?dGhxUkp1SDhudWI4dW5CKzRNcWljK2dGNThvRSsrQTIzbXRJbUNvMkpoN25P?=
 =?utf-8?B?NCt4bHRwemtKNG1kOGN1Q3E4YVdrMURLa2R3ZUhmdjVQV1dBVTY4aHFMcFlt?=
 =?utf-8?B?amhBYndYZVd5dCsybnFvVUx2ZFVSejVFUHFIc0pjUUVRWTV4QWJvcUd6S3Bj?=
 =?utf-8?B?YjRpWlFuT1o3cnh0eS9EREpQMlJDL1lJT3E2ZVZ3T1JXcEpzYjlGek1HQzBG?=
 =?utf-8?B?NHQzN2h0dG5iK0ZHVmFKMEFjRXNHMnpmMDlGSE1DOGNtSDEvSnd1UGZKZHVu?=
 =?utf-8?B?YnFmU3lIMFZSTHFnZGVKVllZS3pWbk9wSGk3dHlIWjR2dzZFQTNJNFFESDJs?=
 =?utf-8?B?MXJ3UHVWWkJVb3dXUUFlbStOQWZlekFRTVVkenlrKzJKRFZ1Vk1xR2RwWk1I?=
 =?utf-8?B?SWtoTzk1eFI3cm1EeEFzOEJ3VzA3OE9xb2xibW5GRnRCbm1PdTk0Z2hFR3hQ?=
 =?utf-8?B?RmpzekRDZUxpZ2FSTVRrTVc0b2lKeWJhNDBEQmF2VGJjM3R6OWlqUW04d0tL?=
 =?utf-8?B?VWlJT1VGOTM5OTAzUjM5RlQrWDdXT1F0cm5pemoxM2R2bGZEenBrcWZ5dHZF?=
 =?utf-8?B?cHlIVFpxaFhidGZaaHM3eU9PZUwvQ2lCclFPUk83Z2ozQnlmTENRWnRDa0hv?=
 =?utf-8?B?emV5enhSTEE1MGNwYnBIMDkyR1E3MnBsc0ZZcW9mVElsWVRHNTRuMWdDTnNF?=
 =?utf-8?B?RTRsY3NlajhoZHU3MHFKK1NrcDhUWkZER2J2QnpHWC9MWFVDSEpGRXFoU1pU?=
 =?utf-8?B?bnlmSmVXaEJJTjVxOWJlY2I0d2pMclFzTW5hbWlkMDNBR2owcFQ0QmFGR2hH?=
 =?utf-8?B?RDZjMytvcUg1THFZbmREdVZrRThLb01iSlBqbjNlVG9sZ2N4L01EMEdhR3Jw?=
 =?utf-8?B?TlNpQVNSVWtSOGlUbXJjRDZUQ0F4K2VMNm5OVHkzVEVnZTF6dGk2c3E5cnlM?=
 =?utf-8?B?QUFwZWdPZUszbDVTQnI3bktxcGdpcHZQdWpRQkExYnhlMjdkOXJjZXZFeXR1?=
 =?utf-8?B?Y0FvK0FyNUhjSUsrcnFDbHFPT1I2SFNFSVBhWHZEOW1SRVRyN2tGZndrRXBV?=
 =?utf-8?B?T21WQXR1dFMzTmVZQzZpNDUrWXN1M0VaSWpObVhxQlIvYklZVkxKdjA3OWkx?=
 =?utf-8?B?L1lSWHhsOFZ5UnF0d3hZRnR3Y2JPb3VBSVZ2OSt2TmhPWXAreXRWM210SnB2?=
 =?utf-8?B?LzdCS01EV3g2cmJRZ016RWtZWWdmUys3dGRwSnl2eGVXSUlVSHF5YnJKeUhj?=
 =?utf-8?B?cmdEZ2ZrVlNjSGxCNit2c3hGR1o0anoxaDhvMmlCcXhIZE02SlN2T081K28x?=
 =?utf-8?B?VEZIQ3oxdGFBVnJYYnZuNXBXVFR4TGlPaHoveVhrK2JBK0ptZ2cvSEpvcjNp?=
 =?utf-8?B?UHVmY2s0dkl6YnhaZi90MjQ0MUg0a3IrVlU5aHBMT3hsQVgySForQ1E1T0RE?=
 =?utf-8?B?d1lYZmpvR2lGR1ovSUpiYVN6UG53VzlDLzZrclVTQ0lERG4rYWZFdW5hVEEx?=
 =?utf-8?B?OUh3dy8rZmh6YU91YWU3OHpubE14Y3cvTHE4VHpsaWoyS0trQXgrYTRSNDJh?=
 =?utf-8?B?UDFCRVdFUUNZczlXVmhJdi95UGk4alBHdi9VL1QweGZUOHlsSkRjbVFDTG9i?=
 =?utf-8?B?cnJhTWFlbzhOVythL0dwVHpHSzZNOUhaTGFmYjJHNHNqRlVZL0hlTUVOb2ZZ?=
 =?utf-8?Q?VKOo/aVOxsSL5CMN1WhXebTZy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6954A6BD7DC88B46877F3A73CBE2231F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1515061e-673b-4110-5457-08dba9f8ce06
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 08:03:47.6295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mf8/VbT4f5USgOP89MhGZ5wO3BTZG+2fVjY0iWRnt8sPpX1+DGS1Fa4Y+eF/SORKoOhYusLhXy8Z/kY2mm7bFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5685
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+PiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbnZtZS81aDMzM2VxaHR3MjUy
c2p3NmF4amV3bGI1YmJiNXplN2F3ZWtjenhlM2tpZTJsbmh3NkBtYW55ZXI0MmtoY3QvDQo+IA0K
PiBJJ3ZlIGFwcGxpZWQgdGhlIHNlcmllcyB3aXRoIHRoZSBmaXggbm90ZWQgZm9yIHRoZSAzcmQg
cGF0Y2guIEkgYWxzbyByZXZlcnRlZA0KPiB0aGUgY29tbWl0IDI2NjY0ZGZmMTdiNiB0b2dldGhl
ci4gVGhhbmtzIGFnYWluIGZvciB0aGlzIGNsZWFuIHVwIDopDQoNClNlcmlvdXNseSB0aGFua3Mg
YWdhaW4sIGl0IHdhcyBkdWUgbG9uZyB0aW1lIGFnby4NCg0KLWNrDQo=
