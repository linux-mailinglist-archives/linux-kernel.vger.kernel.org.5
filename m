Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4894B7DC7BA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343870AbjJaHzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343861AbjJaHy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:54:59 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF54D126;
        Tue, 31 Oct 2023 00:54:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQ+iJsRE4Mxsfyae96S/0BfC3MNHu5XE2Hqm/V7aaBWwpoDBXpk2Iv11uedHZRahav16NAMA8O4PoGxwSsvgbs4tAnNIjENATFnVNWuPul2vmkbf1k2nq/L6f7HPsHgu6OYI81vFy4iES1EQX+IzVteYpXpk+iYGAmFfDNUJCZDzpuqdPGp4+1GJkF6SwIX0gPQblVyk0x3Uve0yQ49WJBM0zHE9x1Q4c2qWtt65tGmcxBvH1tw5kLiO9c6n7o+a1QzNemev2eBCQilXLpTOxl1XN5WvmhlmCBhFputc2Z2dobMEh4oWB3tyKv1wVn42OLtr+BlA0ttoeRk1c70mRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RICAv0lYWkOkGsNXzoGsoxmODna1/4RPI++roDz4L4s=;
 b=ke8lYD+Fb9agP5AwzqXE5/kEHrlHAY6ON2eGJpO9F9Oyk/RYbMakQTJZqBGX9GZUuJJvM9NKkGmBumlvJ+HSuIgfKhFxOn+47D/CApJxYdlfbYvlkBqBgW+4TrEG8LDAtbPk1cykOks2OE5PRDqCmOEsz7eYRWJND+qay58Ilp440bJI34TjFMOUO6OL9hteqgRPteo/WcXf82C9Srk+JQJutmJM7t0Kn/uTPHHqOPWCfWvsghcDXX4xMrcdcCWvum7QxojWF4wjsmY3LkhTBOfn/2WmjbpFMKR5RkCLLpt5vvjuI9XjRSnxn8g3i2fh1ole3p7mS94biuWsX7sJDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RICAv0lYWkOkGsNXzoGsoxmODna1/4RPI++roDz4L4s=;
 b=Mpiyng/D4NC+Jjs0CVWiGZSXLj+WYHcv6zdxmfk4RGDbXMXV9IIEgNkkwp8SUv8sbBNhfEEjPDn3ULCqkPCb5osCzhgXe+iJRlrWwmd5PFms3jJOZXuGlsmCdG+dcFiyaDBt5EfY/fpNSIrCVchWIuAW+96xpAbbi1F7ezGMraI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by PH7PR12MB7890.namprd12.prod.outlook.com (2603:10b6:510:268::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Tue, 31 Oct
 2023 07:54:52 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ef5c:c073:d1f9:e649]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ef5c:c073:d1f9:e649%4]) with mapi id 15.20.6933.029; Tue, 31 Oct 2023
 07:54:22 +0000
Message-ID: <8f1b5075-6b12-4fa8-a173-804d4657415e@amd.com>
Date:   Tue, 31 Oct 2023 13:23:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] platform/x86/amd/pmc: Get smu version before reading
 dram size
To:     Mark Hasemeyer <markhas@chromium.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Sanket Goswami <Sanket.Goswami@amd.com>,
        platform-driver-x86@vger.kernel.org
References: <20231027212916.1035991-1-markhas@chromium.org>
 <2b8335a7-4b9b-825-c1b8-84158aaf2c42@linux.intel.com>
 <CANg-bXCcNPjmQC9vgd1JJcV4QoruhhbeEg8o=S9K-22kb746kQ@mail.gmail.com>
Content-Language: en-US
From:   Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <CANg-bXCcNPjmQC9vgd1JJcV4QoruhhbeEg8o=S9K-22kb746kQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0105.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::9) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|PH7PR12MB7890:EE_
X-MS-Office365-Filtering-Correlation-Id: e6ff52b2-b58f-420b-ea07-08dbd9e6736f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b6nl1DHRE8u87tlHwl+Uqu+eRy+AuvUqCjRmksX/gS0t15IhpzukBJiXQN/PLz3BSkpQjK0+1AKhWn1/1v6OxbfJXfRejh7Bfhc9EDoDoccv3jx8XqTwTXZ6TEslIf+CXenykxwvmDrCrbPy/Ikqzz52oG52K4OCjqvL94a58+6OCfCEuIdx1DCas6zA2D7l1WNV+Yd8cc3CUbXn4xaM5N1mbn3ojfWryyzRmopZtHHMl9MoQViFy2remVBfoQqXhE3ck3lqyMQIVdnhg3lU5CTp70X9XFQeTC8I65yG2Twa1bkkL7XYn+QhHAUiDDn4xkhC2KgfjFnnlskSh0oJYRVdc2L/hMke6gQHdIjuLfsCLppfmk/CBMoMvRz6mSa2NedAILVzX+ER3CvW2MK0ry2pW8SmRSmWSgeOEVL2qdcQ1ukyp6r29IuN9ig7pYeuR0AbdTvX2PqMHxLl4nILqxA6tWyFnw7WSfHXG9slQWHnvMQjYKZq7jZjceFwXzTw1MzrcY94HIi8PJBn4noBT7kNXfCbDBr2o6rapWaS6MInsM/O7RzBabpHasQKx6hSZAOAtubJVEpfKZ0vQZllg9it5wU1zQgyHvjR5TXX+HV5bJPkJWf4myTCgpRZXQUv2y9IsTygQmEiSO3Hvu0R7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2616005)(38100700002)(36756003)(26005)(6512007)(6506007)(53546011)(31686004)(31696002)(966005)(6486002)(8676002)(8936002)(41300700001)(86362001)(4326008)(5660300002)(316002)(2906002)(6666004)(54906003)(66946007)(110136005)(66556008)(478600001)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDNxcUU4RGRZU2E5c2xQdnc2L0tjR1VsclNEOHY3RXpRaE5GWnhkWTJ4QmN0?=
 =?utf-8?B?MGUzQ3dUU2Z6dU96dGltQ0hsQm1PdnBpd25BQ0lucGxFWWVQY0ZuYitLdkt0?=
 =?utf-8?B?Mmxrc3RyNmVDbVhKazdoRVQyRUQ4bjZ1NG1lbjEwM3F5ODF3czRXVGQxWnpU?=
 =?utf-8?B?NzNQSGN4N3RUd1kvY1pSbHo1ek5XckFPdmdYUmN0M0hic0k4T1BZSGtUdnZQ?=
 =?utf-8?B?akNqT0hxNHhqUTduS042aGxRSGlKN296QnYxR3B1SHB1a0ZhMnFTaGNvc0J5?=
 =?utf-8?B?QnJ1ZGRSMzJGTVZLVVlhV1BWQkhkN3pISUVmeUxvdkQzWWw5WVRHOHlVeEtR?=
 =?utf-8?B?RGhDN3o3eUlvY2RqR0VRTUdCUHdrdS9EdWQrRGJpd0h3bURHWmpqNHFRb3ky?=
 =?utf-8?B?Z3dvNjhuQWlMMUNxeENPV3FHd2RzWU92QzlzQnhuSGtEZGtvVjBkMzZ1R2lU?=
 =?utf-8?B?S2VRVWhtcVFEbU1VVVFKK2Y0U2JDeXg2ZDdlZUtJVmh3SFJuWjloaWd0UWNF?=
 =?utf-8?B?RVdmMkNNeXZOVm0zM2JPZGgvMHIrdk1BWEJMT253T0pxTU0zTlMwd2Q3WUs4?=
 =?utf-8?B?WlVUd3lIVXFsUXNNUy8zL2NFVFpjVld3ZXB3enlHcHlOZ1UvSjY4RkZ6SGo3?=
 =?utf-8?B?OFN6d1ZjNzE2aTE1OTNyMEc4VDdQTGtvNlFiWEtmd2dZRUhpb3JCQ1dmQSsx?=
 =?utf-8?B?UWpYVU9FMVVzNkFrZHAxOXZYVXNzSHRDb05qU0FYZm5saEhVR2RIQ1prTnV6?=
 =?utf-8?B?SVNoZktwcXpENzNKTTZHT1NiNjJvMnloOXlEdHA5bHAzSzJOZHQ0Z0IrSEJY?=
 =?utf-8?B?K0R3bFZrWGduRC84NE5mNjdNeTBoa3ovemVLc1dlc0V2M0VZc3FhNWF4azFR?=
 =?utf-8?B?RUNJdFREL2xGc01FQWNYRmhOM3dFQkpZRncyR04wdUtDbk8wTXA0Uml3SVQ5?=
 =?utf-8?B?V3ZBQzhGenl5NURzZEhlVytkVERZbGlPK1dYc3o0U0hHTFFRYWdHenMwdGhD?=
 =?utf-8?B?NDVxSklYMFJhZldUYlhtQnRla3B5MHVnQ3RYSGNLQnhpQjJSdVRiZFFyS0lW?=
 =?utf-8?B?VDRSdTFDaVNNdlUyZ1dwYTNycXNVQ3JVRjJCaExnTGYyNlpMRisvcCtmL0JE?=
 =?utf-8?B?R1JCRjdtQWQ5ekFIVTN4cEtBRTd0VkxNMDFlQUIrS25RWXY4aktWZWk3WllT?=
 =?utf-8?B?MkRkRkUrNlVnVkNDekk2N3l5ZnN1Q1Q3WStwQW8veVZ2MjJ0VDFGRzkwVHp4?=
 =?utf-8?B?bmNqMzkrQWFmQkgwL3RRMDVaQXFMMUZzUHM5T01CalhTb1I0S3h0cjhjM3F3?=
 =?utf-8?B?d0l4Q3k0OThCNzBOcUxpZ1BvVm1rcHNPMy9DTUFnaTlwaE5xVlNlQkhZdU14?=
 =?utf-8?B?SCtuTTNKT3NJMHdGOC9tUzFYR0RsMmtmSWU0ZjB1UWZ3Zm5LVmpzc29tUEhx?=
 =?utf-8?B?S0xmZmhIejhSZ0g3ckNFMlVzWmIrTFo1dFMrVFhRbzRQRk14NHdoYWl0V0h5?=
 =?utf-8?B?Z3ExcDJqSXhxNkhvN3NKMmZhQUdORWYxN1Q0S3E0OGltQ0VLc2FVTFREL2tC?=
 =?utf-8?B?ZnVrWHoyVGl5K1k1bzFvVFJ6cVlmck5oOWprNTdsZElIYnNYUXVSVHpwTmYx?=
 =?utf-8?B?cE8zdTExZzkzSXkrMHNlVENGL0FvcW1qWWc1anI2Vm9jRUpoYUNvV2c2S1p2?=
 =?utf-8?B?aysrenJ3SURUb1pKL1cvcFh5eUE1WldyZG1oMGIxT2ZxUGZYNTRVb3RrejRm?=
 =?utf-8?B?WHFnWWpvazJoZDFaZHR3YWUreU5oMDN5NGVqbGUvYUhwMml4cEJpSkFZSjRH?=
 =?utf-8?B?UW5Jenlsek9MRnVUT2tma0FHTTEwb1VtQTNFZ25ocTJXSVNxYVRZSlY4a3p3?=
 =?utf-8?B?RkJIVXZ4aWZHMU5oZC9XWlBpSmllTWNMQWpYemxZNFhIL1pxdTNheFdaemFt?=
 =?utf-8?B?WTJjZWVHWW9PcURlbUxsVU4rNDR6TlYzak5DNzl3dnlBa2pPVzJ6RmZZVlNS?=
 =?utf-8?B?WjJzRHFlclRXRWVRcGtjNjRMSE5UR0U0TUp5dmlwbUZ3KzNBYlNZRktVdkNv?=
 =?utf-8?B?cGxVWitweEMvR3NoOGl0Undoa0hENWJGa09kOHBCN1BwU1RvTytkM0lLQzJP?=
 =?utf-8?Q?3nIMKV8A8RLBW9r6D8YoDob+T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ff52b2-b58f-420b-ea07-08dbd9e6736f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 07:53:20.8650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O1p3MJZxk43UiHNj01hp19gXFSP284OyfLhgNRsi+sDa1OcqAVSdfkRi52QqV5mwyOfOx4wFUcqkestxiwjTEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7890
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark, Ilpo,

On 10/30/2023 9:39 PM, Mark Hasemeyer wrote:
>> Hi,
>>
>> Thank you for your patch. This has already come up but no acceptable patch
>> has emerged since. Please see this thread for what needs to be done if you
>> want to provide one (or maybe Shyam already has one which has just not
>> been sent out yet):

Yes. Was talking to FW team before I respin.

>>
>> https://lore.kernel.org/platform-driver-x86/3b224c62-a1d8-41bd-aced-5825f5f20e66@amd.com/
>>
>> (Since this dram size is on an init path that always needs SMU version,
>> the SMU version can just be called by the init unconditonally rather than
>> adding more of this lazy initialization everywhere).
> 
> Thanks for pointing me to that thread. I think Shyam/AMD can come up
> with a better long term solution, but it may be worth pushing this
> patch through for a couple reasons:
> 1. Probing of the driver currently fails on STB enabled systems with a
> Mendocino SoC. A slower boot time is better than the driver failing to
> load IMO.
> 2. This patch only affects Mendocino SoCs, and was a suggested
> solution from Mario in the thread you mentioned.
> 

I have a patch in place that should address the problem you are
mentioning. I will send that out next Monday after some tests.

Thanks,
Shyam

> That said, I can also just disable STB for now...
