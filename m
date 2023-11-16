Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784907EDD1C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 09:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjKPIvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 03:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjKPIvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 03:51:01 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9046182;
        Thu, 16 Nov 2023 00:50:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLq7IjxxmFUN1DpgJmZ0lcG1uWY/bINl6Uk4NWifd7JGdNJKiEkG1J2HYLn2lDlYtCZY8Jb97XFgDHSmv4Gs/lDrW3ciPGPTqnuv63yqmw5d/TzQLtl2hj3dnjaFWHnTdt15jOQz2IJtvDnmR3Obe9fMNZHK2EkW4m0TJOhmhqqKMDC7+0EXHLPdlFoNiX2u6NuvGsEUoYT504u63G7J1MvoGsrgJ7covIVCHGDyrgIU31mjdwplxjn4U3C+mvekh5YgpWMMT2AJtEgOKeges1fk2mBpJLl4RJxmkoFPcb/l7aHMDBVoYeFsc3nzVCc56TPgUUULOINfZQl1dAv+0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xV9hmTe1yHsYPgdSdOcy0zU+FTubwgoQjreNsx1q7Lw=;
 b=MbURMed15WTOafpnjcfoDbayojyk9BWIJ5FFwuFkzF7rG677HMDOT5imwpqwZ8Zugyk1SARmlOmmlwpaBxlHPmCFI7fbeSQQuWsnGbPkhh+cmfF1HbZW4ybyaxglKGw8cZekzUYy+15nxDciSTjUXkRv+QqwaWA9beKIPZw1y/NdpwiBAN+s2id7502gpfKe10P6IBKrSZqbbV3i80yG8ocD3TL17QwTHIkEECx7ftG8UMMsVYQGT+MwGDpuKuYHqkjhbctzDAJ+xrbDZHyasupa59xmtqyRES924NhXt8RQqOCN86F3LjBANHzmqqZ6Z41Aoicu1WMuTkS+xjtWRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xV9hmTe1yHsYPgdSdOcy0zU+FTubwgoQjreNsx1q7Lw=;
 b=fo35qanlJpWeANfhZZXmD1gOINOUHlOhYmmqlpO2d7o2TfCBTgl3erlo6ulHrlBl7SGs4WRtkV+sQLkTa4/gXF6JmGCzKKqOTNvBLeJQ8/NbQmNrha/SwhV+4ECHOY6H06sIJEeHDKjweVvSSwBeC1E819G3BhmSECOGQIfx0UI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3407.namprd12.prod.outlook.com (2603:10b6:208:c5::18)
 by SJ2PR12MB7961.namprd12.prod.outlook.com (2603:10b6:a03:4c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Thu, 16 Nov
 2023 08:50:55 +0000
Received: from MN2PR12MB3407.namprd12.prod.outlook.com
 ([fe80::8b27:b871:419:2466]) by MN2PR12MB3407.namprd12.prod.outlook.com
 ([fe80::8b27:b871:419:2466%5]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 08:50:54 +0000
Message-ID: <7f063086-186b-4a7b-a1de-f9a21aa75306@amd.com>
Date:   Thu, 16 Nov 2023 08:50:50 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] w1: Add AXI 1-wire host driver for AMD
 programmable logic IP core
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        thomas.delev@amd.com, michal.simek@amd.com, robh+dt@kernel.org,
        conor+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com
References: <20231107180814.615933-1-kris.chaplin@amd.com>
 <170008228111.6293.10665140667009011469.b4-ty@linaro.org>
Content-Language: en-GB
From:   Kris Chaplin <kris.chaplin@amd.com>
In-Reply-To: <170008228111.6293.10665140667009011469.b4-ty@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0508.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3da::12) To MN2PR12MB3407.namprd12.prod.outlook.com
 (2603:10b6:208:c5::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3407:EE_|SJ2PR12MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ffc0dc2-3a65-42bd-e98a-08dbe68124e0
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tX/oDh569F1KcGsRG63waPSRMqR6Av/MMeQKygy7GvU65d+PYK4G7EWZ+mCKd98ClWf5ZYk0+wTVHlzb3xwgp1RYGVSUoX+MdQhSFnJshFfuGbtO9j9W0bQJMdzU1xcLfawnvSWRgeW50MCxpe/39o8WF1qputop15laixZ6g7e0oF262yYZVSdYPRHNdGLwFMXz0NxfADUtTcs5Ak8Rl9yYzzfLX5dRoZOP1VyNdTJIGnAAtRb6D/NSTztc1dS+YpFQOKhL4C4qHzjFHi7+mHD22vaf3Ei8xDNVn2Jo5SpBsCDvmblkDxcf+WJmMl2YJsHUIBfD/AR5lCRoG8UA7VWFarkAkvxGAQo2So33pNsVV6Cbypi9vWI9Nu8p2wSvT9sHY8gqUJEh/qdiZhaLY7J8lyPtzC6HWWjhbCHply64WdJEoK/9DJlUTpBQpQn6iW1EYJTjc8sXhaMO1/BdlBUCQ8qW9egGKcZs17feRv+RcR+KUilWdhiXG/NqB/t/yvrJGjIxsMhgMV+fRPPhSSP4E5zK21etvraCBog9T+wjzMylD7pQB5B8fYaMaiCkgtkwYcKg5qwofrPzhlsuTRkirHgt6YcDH9tio54Yu8jlVDEHT5OOvpvCC9LOcGa6e7GIiLxJ9peKm212uOfrFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3407.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(376002)(346002)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(2616005)(2906002)(31696002)(558084003)(36756003)(41300700001)(86362001)(4326008)(38100700002)(8936002)(8676002)(6506007)(478600001)(53546011)(6512007)(44832011)(31686004)(66946007)(316002)(66476007)(66556008)(5660300002)(6666004)(6486002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmkvV0ROM3p4eXpVZVRZN1JoQVA4YTRWZ1RRVFVHVzREZVAzZUFLbFRqK204?=
 =?utf-8?B?THFsQXZtYUhmVzhwcXFZbGpXbXljYUl0YlR5cFNQdjEvb1hjNzQxMUc2ZUg1?=
 =?utf-8?B?LzNkZVh0WHNEcnpOUHdIamJORXhhUEsrbUwyT3hhSXRhcy9lODdSbjlSMThH?=
 =?utf-8?B?U1kxYVYwRGU0dVFHcE1IYkgyZ25nZVZmTFV5ZnlaUzFlaitySEt6WkhLOVF4?=
 =?utf-8?B?VDhGRDVoaW5IeGpMTllVRkI2SXFWVW00M0tkano5Wk8wZTRiYmlMbktCYU5n?=
 =?utf-8?B?aHZJdEozdmJlL0FpbjFmWTdzaEY0TWg3QjcyN3ZiUFBFRHpDaTJ4RXcyQmUx?=
 =?utf-8?B?U0xERGpZUG9JUks3YVBldjNCSnp2MjRvd0pJWTlkVU56eUJmcmtrVU9rZTdG?=
 =?utf-8?B?T3dOSUR5cm03cjBtQjJHMkpvcFE0K1JRWjJNOW1rT1pQT3ZNdFhTemppZjVC?=
 =?utf-8?B?KytmZFVYSjZyaDlkVXM3SktIMjUrck44dlBhRUg5cUtLM2VaclF5TUttQTFF?=
 =?utf-8?B?VktPUTFFbkNvUHlUZkwrbmMzR25CYWZsWVhiSGpDVW80TDNuUHBzVnVhY0ZK?=
 =?utf-8?B?V0lZVkcyWjFjcnVxYmxSUUhKY0MyMU5IdXF5S0t5Vy9uMjBQUzVMSUs2djBj?=
 =?utf-8?B?RDlnVXYxbVluOTB2NkdnRkhWWjdBK0Z1OFZ1VGg3K0dKbkVIZVhWYTE5WC9T?=
 =?utf-8?B?bGZsUm45M3l5b0tzWTVEdTd0M0ZaRkZzaEt0Nk5RdmRvZW81elZ4VEJjUTVP?=
 =?utf-8?B?ek4wTlZ1OGc5cisrZFNxRGw4aUpMTmk4Mi85bmtMa0dwdnp2a1B1Q0FnalZO?=
 =?utf-8?B?My9JS3JnTGsvQVg5UDZJUzUyd0NacjBZK2dOSnN3eGE0d0wxQVlacFArQUVP?=
 =?utf-8?B?N0M5NTdtd1FsdWczUkZqYndVbDNKZ3p6RXpvbjh4RlN0OGJqZkRLNVNUV0h2?=
 =?utf-8?B?YzFrbUtBSGV0N0l0UUFQaUtOUC9zS0dsSS9xMGZ2QUZzYTM5YU56R1BFN1pz?=
 =?utf-8?B?aVpsSzF6VW80Si9SQUVEdHg2cTZTN3NZVWZDdlBiUzd2Z1pRU3QzRHhXVlM1?=
 =?utf-8?B?VDVsZzBSL0Z0RHlSSE9VVXc5alFLbzdYWFpEcmhBS3V1MnFiNU84TDcwSGtV?=
 =?utf-8?B?WWYxdzFkN0tqaTVXNjRIUlUyY2FtQmwrOXQxYVEwSFp1TVlYcFZ1d2I0K0Nw?=
 =?utf-8?B?Z01pY3QrNzloMENDYjFnUDJoaXo5ajZJdEpobENJSkwyOUk3dDgzbXV6c1NE?=
 =?utf-8?B?ZWI3WEpaa3NDSjJTaUYvMkRQZ2xzWFl1VitpbW5UdTZ0emRDc0NyT2JIVXkx?=
 =?utf-8?B?REJNV3NJU2ZabFJRY09TdE0vMWs0dk5WZFRCVDEwZDN2Tkt5NHFKV0pZZHVn?=
 =?utf-8?B?UWdWNFBGc21HRkdPVGU0RmZkcjZXbS9qdW1yR25RRHhVNXVuNUZDM1FmdThD?=
 =?utf-8?B?b004Wi9YL0h0Nm5ZUCtQU3VubVpKOUZUK2Y5R3dFNUxLUmltak00dmIxOGM0?=
 =?utf-8?B?cEZybmUyZUc5NTcvYk81MjQrU3RSZ2xXaVNjZnFvMjkrdE1XZUtTUFA1akdM?=
 =?utf-8?B?a0ZxN3hlWmxJNk5velNhNVZOYmRXK2VsUXdrY2QyV0FwZG8ySDh0ZGdubEh2?=
 =?utf-8?B?cjdVVkx3a3dlTnBXRjNaaFl1eEU4b2ZGZnlQUW4rUFVLOU16TkNxVlZ3RSs4?=
 =?utf-8?B?emRucEZadHNYYS90cjh3a3hMb21KbHloL1BaeHVxR1hTUmdQcVhhZWdaa1k5?=
 =?utf-8?B?NkJqODMxL3htdmNaaHFGTW5ybHNCTlRXMHoyU3E0Qk1hVTQ2R0lpcVEwT3kw?=
 =?utf-8?B?TSs0WjhkM21UdWx2N0NFaGtXditmaU1ZVHEzL1hNUGdjZlRLdnVUbW5CT3JJ?=
 =?utf-8?B?b3RucTRqd0pwcG1ORHd0bmtwOWFVOXREdTBRRU94N01SSjUyOUFWNStxMTBh?=
 =?utf-8?B?ckZTZ3d5QWRxOWUyWXJHRFhQMHd0djluaUFRQzJ2cXN4MHZ1SVhmdkM5dE82?=
 =?utf-8?B?Y3doTERoZWxncHgvVTFpOHZZQld4QStFZEFUb0NndUJ5ZlJ6NnIydGZlZ1JL?=
 =?utf-8?B?ZUdmVk9EaVVOL0N3MGV1WkpMSGhWVDhyTVZGWlBLNEQ2WmFXbEZEdmJJcnA1?=
 =?utf-8?Q?BP5o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ffc0dc2-3a65-42bd-e98a-08dbe68124e0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3407.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 08:50:54.9163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HWPvxiyOO8CqDdnGBhISngvcYh+O+/jQ3VomV/4uG1BMx+vrPY/BWNW+MW0cluYj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7961
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Krzysztof,

On 15/11/2023 21:04, Krzysztof Kozlowski wrote:

> 
> Applied, thanks!
> 

Really appreciate all the assistance from you, Michal, Thomas, Conor and 
Rob.

Regards
Kris

