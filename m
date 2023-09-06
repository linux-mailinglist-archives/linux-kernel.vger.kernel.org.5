Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9CE793EA5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238059AbjIFOWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239811AbjIFOWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:22:04 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D066B10F8;
        Wed,  6 Sep 2023 07:21:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Avd1uRnQNtTVrzCpmiZ8S33PS0bdqUEB039eAyaL8QSpDdcvlcjGQFVHX+LCFfuXU3neCw3NUQVWwLjonSk+fXjJkpxm4W3Asd/Btm4sN4wF2s1xFsglk++FxHENRNMIAwkAeMmlIJQP2J4i7tJul1ixymwu7+oVsQCPhF0+S1HS2M2wP0z+rIF1kbgp+9eTjBk9PpZaARjlSd422TH/ApJmXsZodkh0cOsTh++b6/JFpaZ+TYs2FA2inhHAi0lVx1Dj14l+M0H9+emDipqSD6OeSu0YY2Hk47cX2DCP263TtzdFwky99aco8zWxPPdSBUMVBsVpQJ5DStRIJThbXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgiJ/rxiQUmzg/gyg77r2AIGspeYrYNaBbYo10/Nr34=;
 b=MWpqwSdm/TAgfG2i7gPJFImpkwWON71xXlFo282rYIzh3YU+MiXcaocz79jYNhqaqd24edM7WMOAHzGBs14HfpZceJcOHQ+p5oSlx0wDEiENpsh6cY5CLv0T18Odq3PKW31v/zPxcrApBD0Yha7wGgprktnyX/+YCr4mLFzCfXD1pTC3rKpXEBOzt/UmBeXfbTh01exixswvVenjkd0pLVqdMLIl2S1kqqkXRYynYF8OsJT54Cr/tQoBXbOOYzdXDl1UdEX2yr4ki0AwHe5NwJqyKmxO5VbJgbCkXLef9sf+sBbQaeDsrs/EgklL5nv7I4gobYHDUsvTD9EgMOQ8Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgiJ/rxiQUmzg/gyg77r2AIGspeYrYNaBbYo10/Nr34=;
 b=afGbmNoocDRC4T68cpWhR2lfV1DfgrB1vAZl+69leAPwY7aDk7lxkj1tkFrszwfDr2uO8/Ii0YVfmuaa6xVCzYpkKhWYjSZKVlj64Jdf5SIhSRsNmyBk9yHgBn6MUHNwu8VAg1ABoOh625bl0Crd5q8julzLR01y9jaR0HM0wBA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3688.namprd12.prod.outlook.com (2603:10b6:610:28::33)
 by MN2PR12MB4565.namprd12.prod.outlook.com (2603:10b6:208:26b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 14:21:56 +0000
Received: from CH2PR12MB3688.namprd12.prod.outlook.com
 ([fe80::6268:19d9:8c1b:f448]) by CH2PR12MB3688.namprd12.prod.outlook.com
 ([fe80::6268:19d9:8c1b:f448%6]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 14:21:56 +0000
Message-ID: <9259e3f3-8e17-40da-a0e1-3f95b0879ba1@amd.com>
Date:   Wed, 6 Sep 2023 09:21:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] remoteproc: zynqmp: get TCM from device-tree
Content-Language: en-US
To:     =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@amd.com>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Ben Levinsky <ben.levinsky@amd.com>
References: <20230829181900.2561194-1-tanmay.shah@amd.com>
 <20230829181900.2561194-4-tanmay.shah@amd.com>
 <f6943509-25c5-b4fe-2218-638cc06a4e04@linaro.org>
 <a88a0240-30a2-4c99-baeb-091b44e4c2b7@amd.com>
 <dc5d4145-770f-3318-b026-5ce29483d384@linaro.org>
From:   Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <dc5d4145-770f-3318-b026-5ce29483d384@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0388.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::33) To CH2PR12MB3688.namprd12.prod.outlook.com
 (2603:10b6:610:28::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3688:EE_|MN2PR12MB4565:EE_
X-MS-Office365-Filtering-Correlation-Id: e7dec5ca-189d-4fe6-6da8-08dbaee49fa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jk7oRV3YE3j2IpEr+U5ihlHaKMKgy1PXiVT3COXDeXaLtWx1guS9BrT4nkvtXKXJpqmM5fQ7z+HAiXBqSVsoEHpb9bjDGo4P5FivmPttL5DteA/zxQjyxhKsk1gIsPZXWdfTnoDwLH1hagSnNRClCF4511L1EqIVLTQrslMdweOJj9QRVMf8JPqPoVHnsGlj7w/GnReI0DzwJkXeF3Eg5uXJdMDB5Nz27S3fd1b+oPJvGPXvqh8VEmSuqEFH9X4ce6Nt2UN6rWbS61mrl1vPIp7HIGo/NasLMVc5BHzZYyFhXCylNJBCeMz2jB/BupikFxAtLY1zHVTRSgzb+yCLAqYjlKXJR7vlUp5ZbPzi8f0SiYkRVNBWRTYMBRKNWgtZqdk4mqbdoT/xs6vP44D/1BDnUYiz9CYG4HXZvhlBM+ZU5vKYNFsYnesWw5XPoS+c8w+ojPfK2g4SNXjjFOHmeSNjL7iUByjyklFuOBZiP86Al2CRcB49gOlev1hfcpPs/5L5G/MuaJRRZrYCw6OuYeJvjLI3AUqfbTgzn8mD8l0eYhfsuYnbpKDO9P2a0DDO/oQMiUajyoImKhFp3cbUU39bJFGQMYXprm3r5M4nAPBeSrJXeI3pa08kHWMIcak0NSEjwNxzxTMvrlN/JkTd3ekz2WHKdRGtGWqCgUS2GPk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3688.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(136003)(376002)(366004)(186009)(1800799009)(451199024)(2616005)(921005)(38100700002)(26005)(6486002)(6506007)(53546011)(6512007)(36756003)(83380400001)(31696002)(86362001)(44832011)(5660300002)(7416002)(41300700001)(6636002)(54906003)(316002)(66556008)(66946007)(110136005)(66476007)(8936002)(4326008)(8676002)(31686004)(6666004)(478600001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUFCcnRVSDloNGV0R3FSWUpFMG1vSGxGL2VYMXRIVXFFMGZ2YUFkblF3MDFp?=
 =?utf-8?B?WXNjYlhQR1RkRG5vM2I3STl3Q3BDcTdQWXFGQ3Z4d0F2UVZwSE1CMGxBNERh?=
 =?utf-8?B?a1UrM2NORytVRTlsTFVpUm1sc3crbHlqWURXTkJQR0JmdHl1TThoLzJmL3Ry?=
 =?utf-8?B?WTZQQjhnMjE1STlIc0FQa3V1WmhrSTlrVE5MYmJKaDRFSTJjQ1g2V3lkUS9t?=
 =?utf-8?B?dVJtd3ZlRlFYQlQyU0ZBNzMzYU90Yld1YWhQSm04S0J3TWU4L25yZGZOTEo0?=
 =?utf-8?B?RVcvbWJEL2ZyUGo3RW01blIwTnRSc3l3REJFS2VDRHlNMWE4cWYyby96YkZp?=
 =?utf-8?B?QVJCMCtDWmdwSnFRNHp2ZTVvc3o1NVNMdHgrSGRLOCt5M3g4eGxpblUxVXJR?=
 =?utf-8?B?NXhPcVpQMjhLNzVsY3RYb3hxSnhmV0lqa1ltdkxQbjJWQTRITnUxM054MkxV?=
 =?utf-8?B?bWhDK0o0bzNib0tkeDhCek92dDJ1cEZZWGlWekJ5eUhYUndISXJ2MWlodFBW?=
 =?utf-8?B?a0xNSkpLbm5DcUdzQmhrZGVnejhabG5PSytjeDdDQmRKTHlGR0RIYVhIOHdl?=
 =?utf-8?B?R3Q2VG1GT1V6b3Q3VTQrOTN5UXYxdlJaMXQ2NWlpQTF2VVJZbUVVbzNXS1g4?=
 =?utf-8?B?NkVHdDhzZnZKUXRJbDVHbkJNUW12MTk5bWplQ3Nzek1PUjFBTHVhc1djNUpu?=
 =?utf-8?B?d3pJRSswMWhuRVJlMWZWdkV5Q0JYdDFjaGFYMEtNdjBCeUMrejRLMy9yYXht?=
 =?utf-8?B?UGN3R1Fsc0taR1ZQaFg5aHhyR2RVWVkxWE9hb2ZtNm9aMjBGVUo5U0gzc01T?=
 =?utf-8?B?Z3JlbzZwVFlrZjhoNmoxaERPekpWY3VHT0x0Slh2VHNmdGU0NHpjUlF1cUdO?=
 =?utf-8?B?RGhYTWtqcTB0a2IxVVZQNXNrZjFuSXJOQk04NU9EL1ZrTmk5RXFXQXJ0N2FB?=
 =?utf-8?B?SGRjanExUkI3OGJzR0VPbVhLNDhTNHgwWnpXTE16VkZ4eTZSZmNPa2s0LzRE?=
 =?utf-8?B?bUg4aXkvOEprZk50Q1ZsalNoNmh2ZkxTT3VMRm9pMEZUQzRTaXA1Z3dQdENV?=
 =?utf-8?B?Z3R1Mk9LYU1xZ1J2Mzd2Y3RwTXh2ZHZkNDV5a0VKTU5mY2YxL3ZFbWpFS3d5?=
 =?utf-8?B?MC9IMEpJT1ByQ1hRSnd6d0tqZWErNmNwV05KYktaQ1RwMm5wQzNZeVROWDc5?=
 =?utf-8?B?R0dQR2VNTnowZUo4ZGo5MGJWY1RKbXg3L1JDUVV6Q2h5REh2ZFZ5cUFKOEZW?=
 =?utf-8?B?VFNqaTMvM1B6Uzhyd0ZLSHJNQWdRQ3hvTU9SOXFJMmkrS0FZdzRKNnRuR1Vo?=
 =?utf-8?B?amZsM1hzRWxlYW92RjlweGVBUXlVTWRmSTlOb3BCRWRKUldBOHJHVUQrWWQv?=
 =?utf-8?B?NWZKM2QySUd1bWJpd0dlU0daZG5RTURKbjREY0ZOYzVHdXhoYXk4b0VWRkoz?=
 =?utf-8?B?NzJxMklDY2JUajZJRFF5blVRbnpCQmh6NXpkV3loVFk0Z0pBYUYvekRKRmxa?=
 =?utf-8?B?d2Q1T2c2Rm95WWQzRmVXQmkrenVxbnZDV1Ezc09zbS9NamxKV0ZnM1g1ZUdh?=
 =?utf-8?B?aTJibURyd0hLbzU2YkcyVVBxWjFTTGU2UXh5eFNqa2s3Y3BDWVpSNjZTa3Ir?=
 =?utf-8?B?TlREM0NhMHlTcndHaEVpYk16amFkZ0xZSTFsRUlNL0dNR0owRi8wczRUdjBZ?=
 =?utf-8?B?b3BhS2NaSE9RNFBCd0hMZy9PVGFkZGg2bG85RlJXbm4vT2t2YjVGbld1dStx?=
 =?utf-8?B?TjJJUkYxR1ZFNEt6MklYYkVCZzQwb1N3MWZFUDAvMUI2aXgyb2plZVBFQVpp?=
 =?utf-8?B?T3BONjZaZk5wSk9udWVmUDZuMHA1Vk5OQlBsc0JZVFVUMnZ4bmFyTmNqS1hl?=
 =?utf-8?B?WXdJYjU3Wm8xc2hWWlVrMkw5QnB4MDNlUTBrdUUwMk9jb3RjdXFncGlNOU1U?=
 =?utf-8?B?RnNrOFltRlk1eC9oTGhLcG9zckpKUEZSYTlyczBNcko3bU4xR09yN2VEczZB?=
 =?utf-8?B?WGNEL0ZPNlk2UzdTL3JZdEI1NjNHZ2sxQkhGSHRqSnFqT0tDMkdDc2FLK1FP?=
 =?utf-8?B?TDRjelRYVHpIbTgvUUlMeVhNY2lxK1BKczV5S09TWWRrRXlLRmVLNFZCTXI4?=
 =?utf-8?Q?b7GFgi6s9Tgtkvv506MF1wkTM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7dec5ca-189d-4fe6-6da8-08dbaee49fa7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3688.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 14:21:55.9423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PeMv7uvP16fpdmzlf299ELC0motW+by3Ps2OwhR2DzXnMAnfHr2WR0GMShqlel5K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4565
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/6/23 1:20 AM, Philippe Mathieu-Daudé wrote:
> On 5/9/23 23:48, Tanmay Shah wrote:
> > 
> > On 9/4/23 2:50 AM, Philippe Mathieu-Daudé wrote:
> >> Hi,
> >>
> >> On 29/8/23 20:19, Tanmay Shah wrote:
> >>> Use new dt bindings to get TCM address and size
> >>> information. Also make sure that driver stays
> >>> compatible with previous device-tree bindings.
> >>> So, if TCM information isn't available in device-tree
> >>> for zynqmp platform, hard-coded address of TCM will
> >>> be used.
> >>>
> >>> New platforms that are compatible with this
> >>> driver must add TCM support in device-tree as per new
> >>> bindings.
> >>>
> >>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> >>> ---
> >>>    drivers/remoteproc/xlnx_r5_remoteproc.c | 279 +++++++++++++++++++-----
> >>>    1 file changed, 221 insertions(+), 58 deletions(-)
> >>
> >>
> >>>    /**
> >>> @@ -75,11 +79,17 @@ struct mbox_info {
> >>>     * Hardcoded TCM bank values. This will be removed once TCM bindings are
> >>>     * accepted for system-dt specifications and upstreamed in linux kernel
> >>
> >> Just curious, for how long this fall back code has to be maintained?
> >> (When/how will we know we can remove it?)
> > 
> > 
> > I believe we should never remove it. It's important that driver works with old bindings as well.
>
> Do you mind posting a followup patch updating the comment,
> to clarify?


Sure I will post the follow up patch with comments updated.

I will wait for reviews from Mathieu on driver's patch then will address all the comments in v5.


>
> Thanks,
>
> Phil.
