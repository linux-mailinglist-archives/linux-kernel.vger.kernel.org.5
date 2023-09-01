Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E245F7901B0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 19:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348541AbjIAR7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 13:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbjIAR66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 13:58:58 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C6992;
        Fri,  1 Sep 2023 10:58:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jaYKTkvyIui+/SYE+DCHkLRvcNNlmJox3C73xkFRxLHhA33NWdvCB7Pjo19bY3gHtAUonCBckYzFMtCmiTZZkdrN/7UvKach+fJedYMLOE7OZJ75oZwtoU9nGfzQ7CPea5WnSM7RNrm4joRMGjzBfkOM2RdXXoTaTv5dA1HkgVlnbtxfw5HrOh7HfEMk8qN3NO6o81yPnVWt196CQDIiutmKBeCEmnU9gF2aIhG8RO8gJH6wUxqvw9tEF2Br9F4jZ3DXp1pxn6JMWDuz2cN1hMl68oyUz6Fx+Akdafd1k2b+PweynCkR3RBe7m9ssdknWaxVE2SAn+6jh77dwlCZ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PU+JoDzDssQYH6WW6Kb2qgbKlqRlAgFO7UPkzJAoz4=;
 b=dZpGhpSAZvsMgMfkHkRAlXhPFdDExtV9w2l2Anse+EZNg8NaJBm8r31toty8KDG/P+3UXU2ESe9b+8ssBZZiXGroOHSkC6ru4DZLKE+VlK50pYS7NDyOM/O8yxavDLuqkR7xMjb+EQIHhnzUGvlu0Sf5I2QOL4Eoy2DWn0lEzTiBb530cjjo9Ezp7BnQRSOF5Cyvst2uowvyOg/koDeZrvWdYKLBRrli1l0rv7r6aw6VHSX8vWmEAaI+EET9EIHMQ6klCcNd8w83KfkuapbO0TSpsvvl+tpmNdp3d2yKOS5cbtdCMpyNz7wZ9MpdpOK8+9CyQC56WKqU3Z2b47FuMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PU+JoDzDssQYH6WW6Kb2qgbKlqRlAgFO7UPkzJAoz4=;
 b=dUT303y6xLPPPnBBLJ8CEh8oUBiX39SxJf7SRGHgqlZ7K/DMBAS7knojyjltsH+vNvzdxAYz/6Mea1QlMCEE0rmnd+gbEWphzzyU39XHrY0p3JuziLX0+QHzr8RSVsSA0VViCymU/Y3DFXyk4mVKlOD0Y/8QfhDiwdbtMZtpSqKXAMA+SyM1etlKfScSAz2xh7v7InQsP7rfBRjSaHLxsOAV84to+IvTnDPiILVLdrNmPnurDhh2W+1G80OmOtBQsAOWW2vEzpM0KQC1wbnws9OQBxsje79R/y/KnnTKnFFMGy7yVLK9ldAJu/ZlgLLKLO6SB2gBTv/0VOelWe7Dug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Fri, 1 Sep
 2023 17:58:52 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1d1b:2ca4:1600:a865]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1d1b:2ca4:1600:a865%4]) with mapi id 15.20.6745.023; Fri, 1 Sep 2023
 17:58:52 +0000
Message-ID: <cff32150-36cc-0f33-7629-4362baadf582@nvidia.com>
Date:   Fri, 1 Sep 2023 18:58:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Patch v2 1/2] cpufreq: tegra194: save CPU data to avoid repeated
 SMP calls
Content-Language: en-US
To:     Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     treding@nvidia.com, bbasu@nvidia.com, amiettinen@nvidia.com
References: <20230901164113.29139-1-sumitg@nvidia.com>
 <20230901164113.29139-2-sumitg@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20230901164113.29139-2-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0162.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:347::16) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CH3PR12MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: ec07541c-07f6-4927-0dce-08dbab1519d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wXOM/n/n1cze1EIMyXjHVb0Jq2yUOiSrKovToy4BOOkEMfA1m9RKbOj3cQ3Q8E57eFajlIIw1K8/pSGoSNVCVzbXxJ8GHYSL4nWMBpymkQ4VqeLSgRJhPbSctMKC7ATK42gI9kJMamJellyMFxvL/nLZAk0hJNNcqarpGVL9yS7MfqBuvqCPeu7OHWly+QyuYn8i0Gh5rM418Bcvu69QrnyhZujra0Eo0J7Bwg80sxhfCiismfjON96HRVsg97bTN2Jw3yZ3VUew0bt+uwN/IBtEnvw41ptGSWUJQCmE1lExshmX2ns93np/pF1l9p7cbhN6jehOE6E9eWPjoPnBQzBSQTCpeFUTzy9mhuz4BeSvQMtbXvnUtBEY5sV6xLkMwafHl95TBCFL4EQUNQJfZC8HEltufSKk2YKyLyiMpn1tWm47x5doAtsrY9Gut55u+IKfmu4PaO0vTq1ehkJcB0lrnJPEYX+mCKZqG8sQ3T3nA1ao7XRUUpYiLHoJw/1VaRLS10V6Nxehl5srGw4gRB2xTolhwVbm8o4An2ECYM8/M3DITB3snxzT/hk5pSfUvLY6uxMCioHEpVTh0Gbc22KKFsF29qqEZ99StXiFkJj6GJykI8vwWXP9R/RnLlwEp2QmjMWLYEVEP48Ih6m4bA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(366004)(39860400002)(186009)(1800799009)(451199024)(478600001)(8936002)(6666004)(55236004)(66946007)(53546011)(31686004)(66476007)(6506007)(66556008)(6486002)(38100700002)(316002)(41300700001)(6512007)(31696002)(86362001)(8676002)(26005)(36756003)(2616005)(83380400001)(107886003)(4744005)(2906002)(5660300002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWM5K2MrdlBnaG5WWUFSVi9QbGVsbFdpZWh0NnlkekZKbCs3VVNST3R0Umsy?=
 =?utf-8?B?Y1NaYS9aVjVWZDdCQU9jbFZRVkRNeVFHb0VUMVRIVzViZXRXbkE5V0NVS0lN?=
 =?utf-8?B?enF4MnJDNHlsWXZxcXlPWmxvM0pnS2xxa0VaWHl5ZWJFeUUrUUNhZWFIaVVS?=
 =?utf-8?B?VXhzcE1TSHRlVHJPS0oxU0RaSHRETmpNWW5OdzY0K3RKa0t1NWNwVlZXdHpt?=
 =?utf-8?B?RktkYzYrRUs3czlGRWJqVVdBdFU1ckNIUDBhZ0tzNUdaWTA0ZnJRRkM5c0NC?=
 =?utf-8?B?TE5qMnZWeCswWnJ1amZOSHNqNHY3Y0hwREVYMVpPbGRlM0p2OTdYaXJJcWY5?=
 =?utf-8?B?cHB1eUlqNzVhRkQ2ZE9hQ0lOalBGd3ZaSkQrcEpKdHZqOU9FV0YxQ3lpY0Ns?=
 =?utf-8?B?QXlaaHk5bTdJM0tLaGpyYjc2VTNMQ2JxZ05rT0tEQ0gwOGNMUXltRzBwa1Ew?=
 =?utf-8?B?WWlEL0lrTXZ0STJxWURmeklBeWRrSW8rNUxpS2ZMMWRVWDhNc0pYeUJ6M3Vw?=
 =?utf-8?B?OWlYUXZFWXFsNnd1ZW5aazdDK3FNcDdlOHZUQ1RrN0VDVGRzeVFYd0ZPZk5y?=
 =?utf-8?B?UDNqc1FZRkZWN0NnL1NBQ014RzNiYk5nYlo4bndoSEQyUHlVSGJtZjJSTG4w?=
 =?utf-8?B?NkJEYURSUmUwTm5QUFBJa0NscW1mRlhjTElONGNQemhCY1ord21hRFlhV0xQ?=
 =?utf-8?B?QTZ0aXlYdm1XYVhhYkZlVHovMWxISTVkeWk2QnBNS0RJdHg4YTMzczNOY3Mx?=
 =?utf-8?B?dEZNQU5Ua1RZYlFUbytJYkNxT2ZEbWM0QnpVc095L3phV0F3eDlNSUYwV0tI?=
 =?utf-8?B?Z2tCN0paaE10dEFmcWR3a3E2SitpNE5saHhiMnNiK2pSS2VES0N2dkRCK0FS?=
 =?utf-8?B?RzMxb0RPOHJPR0czbEEvZ3d1RHU0Nms2ZVlGK3p6N0J6QlV4ZnRXWjdvZXJZ?=
 =?utf-8?B?YitKQ3dLMEJCMGVMU1VCL201ejRyQ3FjMHozeFA1dENjd2hOSTRJazMyS3F5?=
 =?utf-8?B?U3l1NEpIUVlIVWhnZ1ZJMlhucFB1b0djWjNHU3lRTlhGSXhWYXhBTDcvelhO?=
 =?utf-8?B?WGJMY3NIa0s5S2Q2Mk96bkswN2xTYTFTV2VUMjloSEZVZ1FtZGU5aForbWMz?=
 =?utf-8?B?ZVdqRXE3YTBvbEFyNCszQ3R0eWZhcGEyRGJ4aS85NGE1YUNzdk1jYi9jdWtG?=
 =?utf-8?B?NGNDVmUzMXI1T081RU1OdVIyT1JDQ0RxSVh2c1BKRVp5RWcwZ3hhdUZ0QXAz?=
 =?utf-8?B?WDVQb0NWNExmbVJjdVFCcTVQWUVmYU1zMWNOUWNQTkc4NnFubStmMS9uVURk?=
 =?utf-8?B?SllBZERTU3FqaGlwSEZhNGRFRUpiZ3dDSDU3bnhXUjhmMHhBRnpndGtnVGpD?=
 =?utf-8?B?N0xwR0crZjhJWU51V1R6YXl2QTdUR2xVMDlZSjRpYnA0OUNGVmxuMDlzN0wy?=
 =?utf-8?B?cGwrNEsyRFNuWVZ2b1RRL3BkWTFTOWNsQlR6dmxwV1loMERiNjdPTDJ5dGQ5?=
 =?utf-8?B?dWthdUJ3LysyUVdxdTRUc0l6NFlvb1kyM3FxM3RLK2pJOFZCY2lTSVk1ckRR?=
 =?utf-8?B?V0g2eU5zaEcxNitabSswZXNVODErekN2cUZqYTc4a2p6cFFocHRPb09MT0Nj?=
 =?utf-8?B?aUs4Z2Vhczd1cGdldTI3aXRkbkVYWkx2ZEwza08rS0VSRUFZNXdrZm1EeUJk?=
 =?utf-8?B?bUt4bmx4Qmw0dDFKTFE2NUJ1WWN1Z0ErcFdnMUNnT1hqdS9CZFE4WkJHcWkz?=
 =?utf-8?B?cEN6U0tHSFI3YU1JVm1hWmZ4VXpJRnp6L0pqQ2dObkRlRTdTWkRPSVFWbkF6?=
 =?utf-8?B?OGh5Nnhrd3pQakp0bzF0R1hTRks1b0VaczBDSUo4dDlZdkdISXJveWJiWmxB?=
 =?utf-8?B?UlEveFlqNlBaWGlFU3NOMjhkamhJSlMvQ0lDY0IwNVdvdUZLWFRQM1ZwSUdM?=
 =?utf-8?B?OWl3SmVQQXhzVTNLRTlBcTVTVzlIVGlDVDE0Q2tCbHVCNVMvQ1JnSG9WNjdw?=
 =?utf-8?B?N2NnaTZnRHJCcHhVOGQyYWFyWVNjVmdSZFk1NExpekxNYUdvdEtDZ1dMMm1D?=
 =?utf-8?B?dFNqWGQrZ1VWUlBjY2dZT0ZsNFR5a0pldWtZQUN4RUFjN0lrZ2o0dGwyYVJm?=
 =?utf-8?B?bkZJVmdRVTJqWEtyRE1YNGNmYU0zUEd0ZU9LMzhxL2RFelVwdW9KbVpqelFP?=
 =?utf-8?B?OWc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec07541c-07f6-4927-0dce-08dbab1519d6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 17:58:52.0666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4HuPYqrDwbepprU47rkOMhvygY9T7pWTNC0qiN+3wXNnEnf6lsRr7KhPwR3swLY53mrjXIlJipsl+1iaES5V2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7763
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/09/2023 17:41, Sumit Gupta wrote:
> Currently, we make SMP call on every frequency set request to get the
> physical 'CPU ID' and 'CLUSTER ID' for the target CPU. This change
> optimizes the repeated calls by storing the physical IDs and the per
> core frequency register offset for all CPUs during boot. Later this
> info is used directly when required to set the frequency or read it
> from ACTMON counters.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---

You should list the changes you made in V2 under the above '---' so it 
is clear to the reviewers what has changed. I believe in this case you 
simply change the subject but please clarify.

Jon

-- 
nvpublic
