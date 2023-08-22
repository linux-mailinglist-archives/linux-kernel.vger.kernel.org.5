Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167CE7848D5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 19:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjHVRzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 13:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjHVRzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 13:55:23 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669EB270E;
        Tue, 22 Aug 2023 10:54:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lU6l02fxaG7R1+bRUejwBDyFnFuKvaztixvgs28GrmAUtyP1m4LSNpoOL8QVxEGZcIc1tgt6DcpNEuyFjmPEFEUxznfPSXzT4klm93tvLs+xxvZKURlp1gE/2U29nUn5VdttCAUWu3vGsfRePPy1M1lIT0vwhqtTGPCIRAZ/rwjAOHughYxxdihjVAxJzDAuGvQTla6k81t+kpqlT8c8YUcUe8Bz3YTyqxo6fXRBBosCrGYeVte6JQrjiFDlnO+6o/wn7FvPSO/bUW5YT0FkN7d5salGlkfhLL85cUtPSshm4yZgvbtIgMfIPXsQUVlkrujpTRi3YVOBQ4seNhnSNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b72g56+PY+gKvyrSK23icUbp+SsD5ND7PTIWHDq9nZ0=;
 b=gOCkG9Unfml7T4+xXlFtfY1hIxL9R7yvBWthqOB2eMX/bt8rVhGrkXVXI7/s6mdAqRJJ+VLbYVFJP9CrX1LW59/va4eyeqDM9lkTWhnBdtKbSqr2PeHT7yipQEWa/Iv86H86C78CpeNSDPXPXieILXMRAULLdVl56hJP/+7DZGLZHAdLl9G1jELjrIlNyY1icYD/tKaRnzzjbs8fay0Om+60SiXrGDkSHDznBsgY2ZuqX+tqRUwN+txdiEbowK3UJ2Ro4jEU2XPYHqAMO0vOZ3dRV+IT+7WJeQg8SOBd6ASnPrJTJRw1a8osNPxKEUJnoatXU4skBFw3UniaMqyRHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b72g56+PY+gKvyrSK23icUbp+SsD5ND7PTIWHDq9nZ0=;
 b=jooHKdCZbV5RrRnYmUt6ll1GSwKYhsNxmdfOyUN4ShZt18sl1ondVq/0dv8zXp91i9p8EP1kYAlM7CSb6njETh5Yj7rBgQaWUWs1qg6ZV4TkTFi734b/8BJJOfBzcpj/gjkiV0mb75Z4fGhxWPLezoZKq3IkhoNDbIKW0NLy+Qtr1xu7zIsBDnq/sC7e05lcoz3yodBlsk+uq7HHNT5DnDmm12HDzZ1dTqwRykuaEcIHisAh5dfcvZ7v6TeFgX5FvraOh8+XuyBIF8OG+IbtxLGB3UZ7Ezx91UyVMdha9q/MkFztEV+DsiRwuhdvjniJFp6hhAsbej3QV8axF9HoXA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH7PR12MB6979.namprd12.prod.outlook.com (2603:10b6:510:1b9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 17:54:49 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f55b:c44f:74a7:7056]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f55b:c44f:74a7:7056%4]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 17:54:48 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH blktests v3 0/3] Introduce nvmet target setup/cleanup
 helpers
Thread-Topic: [PATCH blktests v3 0/3] Introduce nvmet target setup/cleanup
 helpers
Thread-Index: AQHZ1NP3n57h8HfHO02ZwNZwaW00oK/2mdMA
Date:   Tue, 22 Aug 2023 17:54:48 +0000
Message-ID: <f51b5ea8-a9e7-8bb2-983f-b46b44eb3776@nvidia.com>
References: <20230822083812.24612-1-dwagner@suse.de>
In-Reply-To: <20230822083812.24612-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH7PR12MB6979:EE_
x-ms-office365-filtering-correlation-id: 9ff6142a-25b5-479a-2163-08dba338e0c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vo/BvT/f+1urITaZOTTUOIrKcRtvP0DOPTyKHv2d+UmQUQb+hFPYkzJayKaCqbbHZOYyhdzIfRwC1uz/8+MMag3MQ4urVGW779NxsC+7zTiNqt4PydgFMbi7dxob+1C0Kv5OzrYmtxjsr/dIMh0TESa2lSDl5aaCm2BtmeB67VbyWUM/KZH0eFczK4lmApg7WDNWoiHvy10/0nY5lS0bx3BHsbw2JzyrLDfPzNKGmwMqiKo+dkicL/WY0wZH9MwPVAOvnTpC4+4GALWS4O8CkISp713Iw7oTG10T0U52RJqoqJxdqhM1eR98H/4DkL/x6fD2grajjtK8AVauJRUungvD+/TbGa5JXJrGUs8Fk2T0f6WAwtPM1M33Gcd/Khy2WldRQidul+7wfHaTuOBonYAzFpFson1SNpMw9vMJR2jNfvosxOT+vd6f5AW+n/dvGJ+9DGVpM2xsvl01Vw/RNXayHDm0jtny3YMOamCWO3NTi29sae1Acc1MS0Wzr/GQbg+HmRIXnjPkT+LXp7qfnuFzRmrrvg1chZpYP39t6XMSrmn8rJphpqkeeqYXvoWzaHBoLOIJvo0ySEAsA4OJ2es6ui+dOBV979M25tTrGDwYk4VklCb+6Wbah12+c23lct6w5LyRq86vr7I6LbhxOdwSBJq4Ygkxj3vWDziepWjUJr/8OmTKZkZ+9XI1liVeK/MRJRHitI2PdlWqYTuYqg1/HN/t9brUpAJrS3kp0/o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199024)(186009)(1800799009)(2906002)(38070700005)(38100700002)(6506007)(53546011)(6486002)(83380400001)(5660300002)(31696002)(31686004)(86362001)(8676002)(2616005)(8936002)(4326008)(966005)(316002)(66946007)(64756008)(6512007)(54906003)(76116006)(66556008)(66446008)(66476007)(110136005)(91956017)(478600001)(122000001)(71200400001)(36756003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVRFU3p4VmVwekRua0VQMkoxTHlEUy9rQm5VeW42cTBpY1FCVjkzVU05RWFD?=
 =?utf-8?B?WHVnckFtNlFSYnZFaldKaC80amJFbTdwTlhnUDNiMzFsQnVpQmxCUXFvZ2kv?=
 =?utf-8?B?NDJvY3IxMzVZSU9pQTFncjlUdVZ4N2ZkSVFsMmQ4MnhnZTU4TFIwZXBGMVN6?=
 =?utf-8?B?ZXZKZnZ1RG5Lc1B2UVZjOUpPeEpTRTRKNzMvdWZwenViSkdRSEZZd1MrYkpX?=
 =?utf-8?B?Sm1KMU5Sb0RTNFRtRjQySGhVTG9pOWhDVGZJbFRzK2Rrc3FidGgyWitMODlB?=
 =?utf-8?B?OEZZMXNDTkhoVHJWbVR6NmxVZzkwN3ZjMDQyWElrVVdqemJUVzBzYUNLbW5X?=
 =?utf-8?B?bEVzaGlVVFJ2N0Y2ZU5VUGUyeWVlZDFLL29CZUVBQ1ErbmovekFxNUJKUEtI?=
 =?utf-8?B?WXF0T1VvRW5UTGRId2VWUXhnWkNONlM2a0RQaDVMZlN4dDMwd25XSGt3VlRx?=
 =?utf-8?B?YUh5VW9zbEIrYmdRdGtqMTdKQXN5ZDJMR25zWDlwREZBMTYwd3BEM1htRG40?=
 =?utf-8?B?N0REUzhXUW1KSndySHJRb0dENEdGWkxLYmpVbzZmM0lvMk9yOHVwOGVmRlVJ?=
 =?utf-8?B?K3plc0lKanZLbzFwbjE3YjB3WmREYlpDWVVEenlKcTRPUVBlVDNDeFlKanJ6?=
 =?utf-8?B?Y0oydlAyNjVLczdrZ1BPWWF5NzdEWjUxa0IxdHQyNXpPbGlWUmxzK0VxTHph?=
 =?utf-8?B?am01S0RNVmo4VXUzcjhuNVA2WTdjclRFRlhFTVJyYjlkMmhMSDZUWWhDcjRm?=
 =?utf-8?B?ZFoxOEFhUjRIUUlXRE1zeFZzUUVLWHM4V2lvb2N6K00zaVNZRnJaMHgzMHgx?=
 =?utf-8?B?RTg3VldkbUhEb0JOSmNuL2ZQbk4zbGhQKy84WFFST3d6M3VHVHlMQUgwN3E3?=
 =?utf-8?B?NllSSUZzTTExNVpmZ3JFUFJQQWR5ZE1aNGlFUG5sS2hSZGhLSXJYaEdBYndN?=
 =?utf-8?B?T050TlJadVlzdngrcTJTR0ozc1NNYmw4eWhyVHlacDhxYytXejkxay90MFpM?=
 =?utf-8?B?L1FzVWxLWFl4YTVlTmEybHZTZkhoR0lveFpnd003RWFyZ3dkNGNNZHRSRzRF?=
 =?utf-8?B?ZHZrZVNtL01PZ1pKbUI5SmJBWDVYMFl0Y3E3czMzU3ZBenNwdDMvdmZoZXVE?=
 =?utf-8?B?TmRHNWJobzRtNFdDRUhzOEFvYUJFaE15OTBGTjEvZ2FLT1kyZzlwMU9vUkZv?=
 =?utf-8?B?WDFzVzFnZVF4SjMzV3liUnJlU1l2cHo5bG9YNUJOWHF3K3ZRMjgzY2lQdjI4?=
 =?utf-8?B?YXFaNUR3ZENva25SdnVyYTdDYUo5VHh5NFloeDI5RFNHZXZrdEozbkQwL05h?=
 =?utf-8?B?N2NRUkoxcHpnSWJpRGVDN0EwWmxDQVpFK1JYMGFDWVAvTzVHZDk0bENib1RX?=
 =?utf-8?B?dXV1SzgvcUtMOXBrb08vODRzTFZqK3d6cHNTd1VsVU9Mc2VRaE9WeGtCYzI5?=
 =?utf-8?B?dm1aUktvWXVWeTM4SjZXUGYzaWdDQlRzeW5nYzJxK3J5UVJXUGxVTi9UNzlo?=
 =?utf-8?B?bldaOVNLenJhK2xVMGFHZCtHcHpDb3BGeHJzUVQ1c0V2bmdMalduNlIvdDVD?=
 =?utf-8?B?QTI4ZzVDMHhKT1lJSkJFSlBadm1JRVhrOHl0WHJFODk2UUxZT290NlcyTUZm?=
 =?utf-8?B?ajlERXdXQW1wL1ZIYkhhN3F5NXFHaGF5TkZvazZubWpNT21VRTlZMWV4STVo?=
 =?utf-8?B?MUZsOE82VFVUdU5jOVpyU0MyYXlCcnVZNGtuVTlhTzZvdWpaTFZnMWdPN0hh?=
 =?utf-8?B?Z2MwdXNkTU5lZVFkeUYwK0RLRTN5SGJSNWM1VTMxb0k2QnR0YnB0ZTNiekor?=
 =?utf-8?B?c0EwWElTTUdBWm1yMjczRjdYZEI0bU12MTFUK3pSb25hZlBKdUtBTzNFWUkz?=
 =?utf-8?B?RVF1ejVmczFYc1VnTHRqZVNIelo2amhPQ2NyRUxxczFsSUllZWJ1MzBuNDls?=
 =?utf-8?B?bVFGRVlhSEJ1QnpoTXFiZWoxSlB4OXplOU9valhpVnVobTFnZllXNy8xeVZt?=
 =?utf-8?B?U09PT0hlN21tdVhPZ0VCRUNURkwxOWhYaC94Q0ZZTDY4SDBpQjk1VEhxbHlD?=
 =?utf-8?B?cjRSTzZFMHFBNHQ4VXo3ajdzZFFBUVFLV1o4M21ZazgxRm5Bc0ZNRmtGeTdW?=
 =?utf-8?B?cllwS1AwZm1zWkFtdktjRVQyMlVvQ2xPZzI4THVZU25HbUlwVW1jOHpIZHpj?=
 =?utf-8?Q?PvymHAZRoFmsfhGpyMPwsKZbRDq6NV8wsbKVMSKm1PIe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73AA5D2AD8A5DD4EBC8198D0AA678F23@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff6142a-25b5-479a-2163-08dba338e0c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 17:54:48.6829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wrXtxXLUWxH7Kbu+kYbEXAH85NlGiDJ5omsc0yDuuq0Edk4exaCb7El2joEy5d9JGqS0er6EOISaI043VF9L8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6979
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8yMi8yMyAwMTozOCwgRGFuaWVsIFdhZ25lciB3cm90ZToNCj4gQWRkcmVzc2VkIFNhZ2kn
cyBmZWVkYmFjayBhbmQgZHJvcHBlZCB0aGUgZXhwbGljaXQgLS1ibGtkZXY9ZGV2aWNlIGFyZ3Vt
ZW50IGZyb20NCj4gdGhlIF9udm1ldF90YXJnZXRfc2V0dXAgY2FsbHMsIGFzIGl0IGlzIHRoZSBk
ZWZhdWx0Lg0KPg0KPg0KPg0KPiBvcmlnaW5hbCBjb3ZlciBsZXR0ZXI6DQo+DQo+IEludHJvZHVj
ZSBoZWxwZXJzIHRvIHNldHVwIG52bWV0IHRhcmdldHMuIFRoaXMgaXMgc3BpbiBvZmYgZnJvbSB0
aGUgcmVmYWN0b3JpbmcNCj4gcGF0Y2hlcyBhbmQgdGhlIGFsbG93ZWRfaG9zdCBwYXRjaGVzIFsx
XS4NCj4NCj4gU2FnaSBzdWdnZXN0ZWQgdG8gcmVjb3JkIGFsbCByZXNvdXJjZXMgYWxsb2NhdGVk
IGJ5IG52bWV0X3RhcmdldF9zZXR1cCBhbmQgdGhlbg0KPiBsYXRlciBjbGVhbiB0aGVtIHVwIGlu
IG52bWV0X3RhcmdldF9jbGVhbnVwLiBJIG9wdGVkIHRvIGZpZ3VyZSBvdXQgaW4NCj4gbnZtZXRf
dGFyZ2V0X2NsZWFudXAgd2hhdCB3YXMgYWxsb2NhdGVkIHZpYSB0aGUgbmV3bHkgaW50cm9kY3Vk
ZWQgX2dldF9udm1ldF9wb3J0cw0KPiBoZWxwZXIuIFRoZSByZWFzb24gYmVpbmcsIEhhbm5lcyB0
b2xkIG1lIG9mZmxpbmUgdGhhdCBoZSB3b3VsZCBsaWtlIHRvIGFkZCBBTkENCj4gdGVzdHMgd2hp
Y2ggd2lsbCBhZGQgc29tZSBtb3JlIHBvcnRzIHRvIHRoZSBzdWJzeXN0ZW0uIEkgaG9wZSB3aXRo
IHRoaXMNCj4gdGhlIGNvZGUgaXMgbW9yZSBmdXR1cmUgcHJvb2YuDQo+DQo+IEJUVywgd2hpbGUg
bG9va2luZyBhdCB0aGlzIEkgc2F3IHRoYXQgdGhlIHBhc3N0aHJ1IGNvZGUgaXMgdXNpbmcgdGhl
IGF3a3dhcmQNCj4gcmV0dXJuIHZhbHVlIHBvcnQgd2hlbiBjYWxsaW5nIG52bWV0X3Bhc3N0aHJ1
X3RhcmdldF9zZXR1cC4gSXQgc2VlbXMgc29tZQ0KPiBtb3JlIHJlZmFjdG9yaW5nIGlzIGluIG9y
ZGVyLi4uDQo+DQo+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1udm1lLzVoMzMz
ZXFodHcyNTJzanc2YXhqZXdsYjViYmI1emU3YXdla2N6eGUza2llMmxuaHc2QG1hbnllcjQya2hj
dC8NCj4NCj4NCj4gY2hhbmdlcw0KPg0KPiB2MzoNCj4gICAtIHJlYmFzZWQvcmV0ZXN0ZWQNCj4g
ICAtIHVzZSB0aGUgZGVmYXVsdCB3aXRoIF9udm1ldF90YXJnZXRfc2V0dXANCj4NCj4gdjI6DQo+
ICAgLSBkcm9wIGxvY2FsIHN1YnN5cyB2YXJpYWJsZSBpbiBwYXNzdGhydSB0ZXN0cw0KPiAgIC0g
ZG8gbm90IHVzZSBwb3J0IGFzIGhhbmRsZSBpbiBwYXNzdGhydSB0ZXN0cw0KPiAgIC0gZnJlZSBw
b3J0IGFmdGVyIHVucmVnaXN0ZXJpbmcgZnJvbSBzdWJzeXMNCj4gICAtIGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xpbnV4LW52bWUvMjAyMzA4MTgxNDE1MzcuMjIzMzItMS1kd2FnbmVyQHN1c2Uu
ZGUvDQo+DQo+IHYxOg0KPiAgIC0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbnZtZS8y
MDIzMDgxODA5NTc0NC4yNDYxOS0xLWR3YWduZXJAc3VzZS5kZS8NCj4NCj4gRGFuaWVsIFdhZ25l
ciAoMyk6DQo+ICAgIG52bWUvezAzMywwMzQsMDM1LDAzNn06IHVzZSBkZWZhdWx0IHN1YnN5c25x
biB2YXJpYWJsZSBkaXJlY3RseQ0KPiAgICBudm1lL3swMzMsMDM0LDAzNSwwMzYsMzd9OiBkcm9w
IHBvcnQgaGFuZGxlIGJldHdlZW4gcGFzc3RocnUgdGFyZ2V0DQo+ICAgICAgc2V0dXAgYW5kIGNs
ZWFudXANCj4gICAgbnZtZTogaW50cm9kdWNlIG52bWV0X3RhcmdldF97c2V0dXAvY2xlYW51cH0g
Y29tbW9uIGNvZGUNCj4NCj4NCg0KSSByZWFsbHkgYXBwcmVjaWF0ZSB5b3UgZG9pbmcgdGhpcyBj
bGVhbnVwLCBpdCB3YXMgbG9uZyBkdWUuDQoNClRoYW5rcyBhIGxvdCwgZm9yIHRoaXMgc2VyaWVz
IDotDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0K
DQotY2sNCg0KDQo=
