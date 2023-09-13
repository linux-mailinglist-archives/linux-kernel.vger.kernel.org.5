Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FE979F16C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjIMSx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjIMSxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:53:53 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9FD170F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:53:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5L3TRuZC3QdAfFTBgi+5IDaz/vQj/phg2Bmues7Yb252iuB7o4O8RSAHV9tni/YyW+rUoF43mk+iPfp0e27PwqCaqWlQDGp1Ye+r6Os0Iz58GysRazhbCA3wTe8VwAAVnhpUWfpMomJ9PJB/REFY3IkLDGWXIGPlGDCxlSUGl5oaprvVI/nbp/yilcV/LzS9RTgJT+p6IEECq65JDG5+lWCKtF9EsX8ZjEHx4HV7wxe8PDZg1P8RPNNxFR6nGkOtVB1bzc7C9bKcQ+9/ISWyvKXCJ6CIiRPTmbqS6gAgb+bu0F5ovDCmWnp0+b2XS+tDAHOT/fjRMstpatQwHK2TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcOtQ0L0AfqgvhoRuQ+7+3Ag77H/92rdEpcf+H2AKEw=;
 b=Oxlcvr7izU555m1krIbvs5ns0okKhrI3ekQkDuQtOh/Srm/8hZ5gEUV6qruWhGRxPP54e0eRZlY3sdiObJyw3UJbP1yUosOwPxV3DaGgEPt1gd34ruDqj76oAWUkgeTm+kE+W3NoTWNTqWnPrVgw8bt8M4uCjA1jKtcqP6alYDFetFGULHoLcHZ6Fuzj67srv7M3YACjykRYI7+YZu5IvNICH/70Px6WWwHCuylkOvV5dg7QAPHva6yM1QwvumILkdrBrt+JnK7Ct2EIuS0ZSRCPX4PJz3KFYw6p0JTK1+oe8+B3DfmVqX/6WLRL+Rc2Q/FVMWyFxq3+Dvsnf6qtkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcOtQ0L0AfqgvhoRuQ+7+3Ag77H/92rdEpcf+H2AKEw=;
 b=ivtzo09sw5YAmbcCZFcnb8wCrnvVLddVjz0sBhgHcDkDICTIc2pkhlU7chQOiCN19qwgDveQLPssuQTWoU4S5QZxNPMSv0tswkGhVXdtot8jdq5ioTtaRwMdgDfMfbV65vPLKEB98UXMNny0oT1dyvVPHe/p9Zsu2vjufIyblASfD2g4MxCX15BydLfG94QbiBGe/xU7jrTJ5C8hnmgfVaD0N7iL0cF5txSMrIqkjJrE4asCfMj+gyTUIpzXZHlwekB1Q3E104A6qBiNchW3fhk89/5wlgSEAjBQzLCZUa7jfwy0PAKFITPzNFZWtQ3LOj5/0IHheYKgrXknqvPrrQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH7PR12MB8795.namprd12.prod.outlook.com (2603:10b6:510:275::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 18:53:46 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::80bb:9b5c:2c07:a983]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::80bb:9b5c:2c07:a983%7]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 18:53:46 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Ping Gan <jacky_gam_2001@163.com>
CC:     "ping_gan@dell.com" <ping_gan@dell.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 0/4] nvmet: support polling queue task for bio request
Thread-Topic: [PATCH 0/4] nvmet: support polling queue task for bio request
Thread-Index: AQHZ5h1pVP/clEEvTUq2uCAcN4E7nLAZGwQA
Date:   Wed, 13 Sep 2023 18:53:46 +0000
Message-ID: <28949e52-7db7-4227-6bbd-cb8b627b390f@nvidia.com>
References: <cover.1694592708.git.jacky_gam_2001@163.com>
In-Reply-To: <cover.1694592708.git.jacky_gam_2001@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH7PR12MB8795:EE_
x-ms-office365-filtering-correlation-id: fffb6e43-c3cd-4123-4cc9-08dbb48ac28a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 140/DHDjDZfIPH4eVOtR0yFlF/UwloCb74HzMb5hLlVDtYi4pXXfCNCQ2GV7LHDb9vqp3cTMR2YuALsOR4oR5Svt35SiA0uHLlX3b57SoH6qaYaXwdX2ymd0eAnZflmSjSoU777Rujfa1H0eNtPgIYt3xvpftiIbcuWOZ+pIjqQ9zoXqHxVaIiV20ziFPdzDw58yDhEj6s5f5bYUhoy1vI9RE5jZ2ovdH/816fLxN57yUVcKQg2JPKcN0nFKBCQR4EPQRrkrV6sotl2wxa9jxcepSKAq+dYZofoHlYfkBoa8/fnRdkk0iiOyTf5aEU3UmKvKtaja00y5wMPluZuQhcxVERLU+HIKZxQ7Tdoahl1dwCwphvUsGkQB86/yWHd3a98ck+gPGaGNvFkY5NevlgTJ048oK7elXe3rmn3DJya17sgw8+tx//lq3HLpsYKxaA8Ei/FXZGujWKov4eudeZdWpE0GgyTi7Zdlshemq/YR9KuEe5fDT6pc0b51MSjw6CDmEM1mgfhoUT+vTlaPTo9XdVZDmV0J7i9HEyyg4gJYgXsL5HxDN6bcSZPXfTwHgbBjAUZ0hI2zvxen/3NFRGEMILBfZn2ZZ+Iaky40Y68ZbjDLdvCJDEAuSUhysKWpPN9lemz9CryVdC9pqyYgDXK/XbwQienIvjskAWBRDl8YHh7Uow6HoXTuUBKJ5CtJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(346002)(136003)(186009)(451199024)(1800799009)(4744005)(31686004)(38100700002)(6506007)(2906002)(54906003)(66446008)(66556008)(41300700001)(6916009)(4326008)(36756003)(8676002)(8936002)(66476007)(316002)(64756008)(5660300002)(76116006)(91956017)(6486002)(53546011)(38070700005)(6512007)(2616005)(71200400001)(66946007)(478600001)(86362001)(122000001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUVyUFdWYy8yejVLcHN1bnpUTkpGczhLSmoyZXdiZHNjK3JxSkxhVDI0dTFW?=
 =?utf-8?B?bkgzMmFnQ2VRZkpWZDNHM1dWd1JLTnJjZzhQbS9LdGFaNXNvQWdLYWEzQSsr?=
 =?utf-8?B?UDEwTFJiaGFDeFA2a2JrbXlHUWVqVkhUNFdveG4zMjFQRXM0ei81SndJWjcy?=
 =?utf-8?B?OHFZVVhBWFVXL3VkM0JyUWVxU3FJWVZPekh3UkFlUlNWLzM5S3RwaGxEVFI5?=
 =?utf-8?B?VTRWK0g0TDV0aVFNblQ3bmpSQWtjRTZnelZ6Nk8yWmpvRzZtTzBnOUFyeDZL?=
 =?utf-8?B?MWRpZkYzOHg2dmxvM0owTk5CKzVSbDhtWG10a2x2QjhIRmorLzJSMWxKbktn?=
 =?utf-8?B?SUFscTBNUG9WL0lVZ1lnMkE2emt2TW9pcjRBSk9wWEI2L3dwaFdWUUhpUU5G?=
 =?utf-8?B?U3p2Q0FvQW9McGYvUStBZGpZMUhub20zUmdjUGgvS0t1bllPM2pJMVFxSjhx?=
 =?utf-8?B?YWZJYW9EK1dYMjY1OFFPMGU1WS9uYllsU1RpbmlHalFNYXZrRGx5MzZPdlQ3?=
 =?utf-8?B?S1llbUViT3FsS0lJRWVzZXZVYktmV2hFQS9QZ1RKSy9ZRE5vSDZyMlpubTZH?=
 =?utf-8?B?MHh3eStZRm5hblplL3VqbkZqR0RBak5YNktRS0xJWnFieVErUFB5dkFEV3kr?=
 =?utf-8?B?U1Z6R0duWFp6TFhpN2FSSjI4SThlLzRrQTd2YmdLUytqdi8zN2RMMjN5QmpG?=
 =?utf-8?B?RXZvSlIxQkZJQlFTOEplMVg5VHlGaXgxc2l6SjQ0QlNtUUk5ajkyOTRFTXRR?=
 =?utf-8?B?S01hYjFWRWlFVFZjMmZpMWpJNDZCTmhkZ1ByUnVEcyt1cHl3cTBIL05qVmF1?=
 =?utf-8?B?dUd1Nzh2bVVSRU9wdHAxWU9YU2J2Z3Y1YzhKSXliODFwK1lCNFlabURFcFRO?=
 =?utf-8?B?QmhpL0NEMjFyaGtXNml0emVxQnc5eUMvMzVQeVZDdzlHYzdrMGliY3pFaFh0?=
 =?utf-8?B?QlMxMFlBdlZiQm9wUThHU1NaNGU4c01kMkpZZ0twZlo3NEJocDdsNUg0SWxr?=
 =?utf-8?B?enBnTTFMTlNtWCtNVXl6a21rV3hET05mckt3eEhhcm5OdkhpQTBRZitIc3g0?=
 =?utf-8?B?STBxeTFEZUUyWHFYa2lEOFJCUnZxczBLeldXem9KK2l6MEZqNkJlMFF6eENs?=
 =?utf-8?B?Y28zdGRUMHZYalVxWjgzajRjZEY3blBnZG8wcFNrSGMyYnJpbWliS3p3eWR0?=
 =?utf-8?B?RVI2RkdYTFI5SlA0NlovYjVaN054STJLNmtJV1o4TmVzWVNWTjQxckdYUEFQ?=
 =?utf-8?B?WjR6ZWtUNVYzQnVqa0RpcDBGSDRyMHB1TFl4VHVNTDg0NWc3VjI2MkwrbEFn?=
 =?utf-8?B?ak1zclI3UG1Ba0FHTTdrU25GZFh2S3RjcEFhN1JhbjdkWG9PSm5WU1V1ZXIx?=
 =?utf-8?B?bHkxK1Y1VjdmYU93WFBzc0FOdDVoQ0t0T2U5aVdma2RRcjAzVTVaeWlaWktG?=
 =?utf-8?B?cytEOWFZOVZndkF6YXNYVW1XNEN3dmZwUXR6Tkp0eFBUY003aWhmd2xXcmpX?=
 =?utf-8?B?Z1NBSHBOREdaZmRLcWFhbFFXejk4cWRZZkl4dmJKa25OYzNycjJDdmo2WFhx?=
 =?utf-8?B?Mk5jSlZmNEpITFExdHBsbWdncGxXSFFNSmZGdWd6aEZzUEJya3FBbS9Md0h4?=
 =?utf-8?B?SzRLZTFXSzJZNUJiT2s5WTNpbVdtVVRCYzVKeTVIS0NnTXhKZUdRWUFwZkRl?=
 =?utf-8?B?K1k4aTczTDhUU1ZXN1QrZWROeGQwQ3gvdU9FVkI3dWY4QkdJZ2dXajR0Q3ZH?=
 =?utf-8?B?OTdrZnZJZ1VEQTcxNSs0bmZyeWw0REZRa3FuZFl3Nm5jekU1NytZbTBGTUNW?=
 =?utf-8?B?SG0xYjhzaEU3ZGpkZmREemU2T25EdXVpSFI2dmtheGYxU0VUTEJRMFdGT3hr?=
 =?utf-8?B?amxMc3I4RjU1b21lOFplNHB5UUpkTi8yMERLYnM5RmRJOXEzU0xOck9oa1JC?=
 =?utf-8?B?eitYeFFXd2l5dmJSREtYd1NVRGhIYjBHTDB0ckVKbE9HbEhZcU1Pb0pmenBK?=
 =?utf-8?B?K0NackVPT2dlSEc4cTdiWmpPTUxZUzBpcEphbHpVMTFEMlFUTjkrTVo3WlJQ?=
 =?utf-8?B?UXVTYnJmZWcyVWhkVSt1Tkloc2s5aUV1MDV3Zll3ekRxM0tWYjVwWUNtSWRv?=
 =?utf-8?B?dzlNTExNVkpzTFJ3dzVkLzZIckdVWkRpYXBjTEtPRkwyL3h0RVNBcVJzU3FP?=
 =?utf-8?Q?pYdBE8NMP+1AivtTxhEFXvU4Acy4exlxh9XAWsuwX4VD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F3F336589C7C0458E93439FCA52C024@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fffb6e43-c3cd-4123-4cc9-08dbb48ac28a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 18:53:46.5041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sHb2trPNGk64E014rFT0sxjuqYXpnVFZ3b5YlxersBhOh/lFJTGK9iVSfIfZcslmdmoMZbZYpv6Zid7h/tEwcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8795
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8xMy8yMDIzIDE6MzQgQU0sIFBpbmcgR2FuIHdyb3RlOg0KPiBTaW5jZSBudm1lIHRhcmdl
dCBjdXJyZW50bHkgZG9lcyBub3Qgc3VwcG9ydCB0byBzdWJtaXQgYmlvIHRvIGEgcG9sbGluZw0K
PiBxdWV1ZSwgdGhlIGJpbydzIGNvbXBsZXRpb24gcmVsaWVzIG9uIHN5c3RlbSBpbnRlcnJ1cHQu
IEJ1dCB3aGVuIHRoZXJlDQo+IGlzIGhpZ2ggd29ya2xvYWQgaW4gc3lzdGVtIGFuZCB0aGUgY29t
cGV0aXRpb24gaXMgdmVyeSBoaWdoLCBzbyBpdCBtYWtlcw0KPiBzZW5zZSB0byBhZGQgcG9sbGlu
ZyBxdWV1ZSB0YXNrIHRvIHN1Ym1pdCBiaW8gdG8gZGlzaydzIHBvbGxpbmcgcXVldWUNCj4gYW5k
IHBvbGwgdGhlIGNvbXBsZXRpb24gcXVldWUgb2YgZGlzay4NCj4gDQo+DQoNCkkgZGlkIHNvbWUg
d29yayBpbiB0aGUgcGFzdCBmb3IgbnZtZXQgcG9sbGluZyBhbmQgc2F3IGdvb2QNCnBlcmZvcm1h
bmNlIGltcHJvdmVtZW50Lg0KDQpDYW4geW91IHBsZWFzZSBzaGFyZSBwZXJmb3JtYW5jZSBudW1i
ZXJzIGZvciB0aGlzIHNlcmllcyA/DQoNCi1jaw0KDQoNCg==
