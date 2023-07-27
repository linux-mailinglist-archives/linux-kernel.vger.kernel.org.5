Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1E276440F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 04:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjG0C4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 22:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjG0C4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 22:56:46 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C831BC6;
        Wed, 26 Jul 2023 19:56:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZDXqF0GCzYnbtxuE30+9z/f0wjLltlhCETLD6FZqPpezIwshSY90aF4/5p+acGQkE6u1ak0t7JUHDXdSgHJN96KR2pa+vO+fvjrUgac9vLvJXNTcGlOhwW3eY2R36/UeIJ5p64ZtpLdrW5W4rjPFY+bVG5LNkJpDuwrPVWnqxjRoI2hj+QDqZi42cqEsyuK7xN0VZLhlqedjRx1RA0dGZo7b/a1k3OMBhQCBIG7QGqK6AcqZVqAqYezErlYjnV4P14sgsaWf4aqH0i5LIlhDO45wEnlEgz1YwhKUbAWQ8EnKX2AQ9NEY7lLweW5vc590XC+45IQP7VmnjLXPMoXHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KR1SczWhlotauKjBWSbFE6xx/Lfj5pymw9COYwoTka8=;
 b=GOD5f+IPLlGTmE7gUcgn1t45QMiQ5pYQn0GWFbuAOgTNlGhiyMk5Is+KvDqHEX+0hCCIN5sXyDuTmlVqiukPGtBBe5D7UwykdolGwiVBd4A3l+Mu3rcAu/B2qRusmr484rwAqRbfFdo56zgoXacvC3E7E0YgQEN/q4yISbDclx6v2oLqDNZMhoaLebl7xnu4+bdvlQ2lEnztOxssqFfV0s3kX7b8BVjxzclSh7ro1a2AVpFiGGm5SxnAMfd0W8iR5QDn03fs2qjHmkKyQGrkHbHKjSoZ2tzBFr5vK1aHJd3qyrUgInqsXltjSw3BwMtNagA/Z3AJt35maB+ZyFkBPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KR1SczWhlotauKjBWSbFE6xx/Lfj5pymw9COYwoTka8=;
 b=1loB9kvMPuoQe5owRisCiLiGpymtzOs71Y3nF0HQEJd2nFPzlrncJrdEJSJHnTwVFyTw8dg/W/u6i24nUidvdzeXWSJPVmuMeoKOQUUnlIzO3gtDK7nMH5V6yp+04va4vAi4hLuwKyJEBXEzHCImmPFHOIibnHEvbjVx3M6TiR0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB6942.namprd12.prod.outlook.com (2603:10b6:a03:449::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 27 Jul
 2023 02:56:31 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 02:56:31 +0000
Message-ID: <d3179d08-d513-a7e4-9ddb-416e50578957@amd.com>
Date:   Wed, 26 Jul 2023 21:56:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [REGRESSION] IRQ override revert breaks keyboard on Lenovo Yoga 7
 14ARB7
Content-Language: en-US
To:     August Wikerfors <git@augustwikerfors.se>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
References: <596b9c4a-fb83-a8ab-3a44-6052d83fa546@augustwikerfors.se>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <596b9c4a-fb83-a8ab-3a44-6052d83fa546@augustwikerfors.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR01CA0021.prod.exchangelabs.com (2603:10b6:5:296::26)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: f224569b-7c0a-4ee0-6fdd-08db8e4d147b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4qxkHUqTKb07r3voe07eOavrvcn6Me8co4UbnRgQWA/W2n+yZtgivd0bNPqDeXvC1SqTLDwboygT7YnHs/6xs+3EZ+6nA1efQJmqS2in4t9fdARAJyPQ5BJhO1ptafJ+ZH7KChdm0CuvtPBgtEXomUUvfQBkoLThSs29WC1x32Af77mF6lkGtvIwZJKoyZjj7G+eQCfkvy6ODnQIe/qeCP5kpQ7eOUoHkBCe5FaqzA2jV5YyNsTsOsoZ1nCaXrQG7oK3ZWt9K6sj4RKM7As/l0HXmL4AAoM2SS78Javodswg5seCDPcHc714bPJR8Dh6nINPOjYh6dxQ/RCV6O/ptnZEoKjh5Tn9RIavCwbmfLSJo3SBlA2uoMdrlivqkrMOs5StEMSQYWANLJJeyeTAx7t3hslsOxwwoxX8ABbgQUhMwTP/2lzBFktTMZoZg3VcvzZexyPSQvpfuwqqhYyZILnIUI5iVtnVxwgmnzyE/39go8yZJMsZ+YRgsjIKjWY9BghG4N+rSPfI5SnC7Ejl6+Fa4af7qJ2BKcAYi5zI0VHs3+5WMW/pjNdec2g4ihvdyI4tVw6fMj/+HMCymDDM29RX4f+FHY/dNAEhzfmaYl733ggPhwuPVVDIYa/6dtc+b6AjDvlcRFadGlwgo2wopg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(451199021)(31686004)(8676002)(8936002)(44832011)(5660300002)(41300700001)(316002)(4326008)(2906002)(66946007)(66556008)(66476007)(966005)(53546011)(186003)(6486002)(6512007)(478600001)(110136005)(6506007)(86362001)(31696002)(66574015)(36756003)(83380400001)(6666004)(38100700002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Skl1cTd5VS9YL1pOS3BHZ3VEdmdHUDc3empyWmNIVVF3OEt4WitUT1RVbGNL?=
 =?utf-8?B?L0JheEh0RldUMFltMlExZjVSblIvL3EzbzVXQkpKY2xqcXF4NG1RU3JnUkg2?=
 =?utf-8?B?cmszLzk2N0tGWXRRYkJ3R2d3MGlzclZxU2FZRmx1OU1zdmVNYll6TklnNGI1?=
 =?utf-8?B?V0FGdk0wcWRhbEhKdXFvS1ByR2c2MGJzL0hDVTBQZi9zbGhlL3huVFRpaTQv?=
 =?utf-8?B?cGFSeTJLbGVpNk5kKzhUR3Z6TmJMS28wY3Z6dWR4T09LcEc3Z1h4b0thdlZD?=
 =?utf-8?B?K1UyVUk4YTFtVDFrQlBxRjhCWEZaYjRoY1p4U203VkhSdUFydnNtM1RRZHhT?=
 =?utf-8?B?elFmQWlxWk9wOE9WTXBWeWNjakhBVys5WmNud3dwS3NVWExrYjEwbWlGRnNQ?=
 =?utf-8?B?anoyNFN6RDJiN2lCM3MzKzY4b1B1R25sRE1kMklaUzMyRUpiZHF4UEJWMnBP?=
 =?utf-8?B?MWptd0VYMTdldDlCdENtS3dLYjBsblB4d3BHVTJPdW1IcFhvcEgrN3RvQVlq?=
 =?utf-8?B?SjZGdEt4MDI5MzdiV292TVlVVFVkdlVXNlVaVVExYXlVQ3U3a1BaQnYzR0di?=
 =?utf-8?B?TG1qSnlraE1zdHJNa21nUjd2a2NDclNWdXFFdE1jNWYwRVRIU204N2htVWZP?=
 =?utf-8?B?TDJnZ2ZPUUprVTV5MmxxZ085eHJHNWdCYW90bmJwWlg0Y2hmOVNKQmF3d3c5?=
 =?utf-8?B?QUhCckp4M2QzT3pIaHRiemhnS3NSellKZ3ZySFRiZFYvMGFwWUI1MkN2dlNv?=
 =?utf-8?B?dWwySjR0dDF1L0o2TjZoTlk0Yk9uN3BmdURLSm9aVEsvNTJ1S3VQVjN6bGdY?=
 =?utf-8?B?NlZjYzI4OTNYRjY5cGhNOUNtWnRpSk5EaUwyNWs3aE9nVTlHbWJ5d1RMRmZo?=
 =?utf-8?B?YS80dERxSkRrWFRiaHdHb05YcDQ2THNKSEdUcHBadk5aaXVHdlY1ditBVDFn?=
 =?utf-8?B?UEdEWGhoWDRac09pR052Tm01eks5VXFxV24zSGVyUVBRYmJNR3MwTUE1Ym8y?=
 =?utf-8?B?cjYydEVUdE5wcW9tTVJOSzUzRE1JMEVpbll3STRIa3pjL3RpbDAvQnJEamd1?=
 =?utf-8?B?b1l6VzMwZytoTGZ2TE05VjhEY3FBQ2loTTlxTTZpYXBjYnI1cWpZU0hhS0JG?=
 =?utf-8?B?dEl5cVZrVnlKekw3cTN6bWdzTTFxK0JYVkN0V3Bnb2hxb1NSZk4vUjVvbHNu?=
 =?utf-8?B?WVBqT3ZTbkhhc0U2b2ZyUGJ4bHk5cWppV0daNXRDRWtPVFQrYlNKR0FzQUlx?=
 =?utf-8?B?VVZ3NnJBVmc3ckMzcGhxUThKaHJEejFWWHpuS1RPZHpQVWhGeDBJT0Nsc1dz?=
 =?utf-8?B?V2V6WW1pODAydnhpVU9qTGprMVNBdXNvYTBRb1VaQjh0ZXpLSzVkcmJjVmZW?=
 =?utf-8?B?YWJidU53cXl4V2FkTE9BeHpMcG91MUtnU1BLcEhpUEVsdzdnUllEcEI4ZFdy?=
 =?utf-8?B?TmpXeEYwSHJRdUNjbjdmOEVNS2lyU245Mk82aWd6UXpyVzZmQVVaeW5oYjA2?=
 =?utf-8?B?Z2xvbjZpNUIxZ3hKN2xycTJTSGtkbmVBWFlwdGdjMmhBQVFrS3AvSFZMRnZs?=
 =?utf-8?B?eDJRcWhvdkxtVDA4QWRtTnhEZUZqYWx3NmpLVjB5dmdQYlhtbWtTbXQ1ZmFu?=
 =?utf-8?B?UTd0WjIvN1IwbUpjYlUzRVBZeSs3RG5XK0FHbVU4MytVdGUrcmlMcU1UK3FI?=
 =?utf-8?B?MVRSU3NXa1g4MUdUd1Z6SzBPSzNPQm5TSGhreWRFZzlCRThac0dmaE1VNVJO?=
 =?utf-8?B?L3R6V29YL1dRWFBUUnA4M1E0RWFYQkdvVWg1YkZYKzB3SmpQTmo1VDZuMFpF?=
 =?utf-8?B?Rm5BQnU1b1RmUmVUZXZtQ1QveTR0YmdROXRsK3J2YjlpNFNUWElGNHpYOXZ6?=
 =?utf-8?B?d3hmbjdPSVhEY05uYmdDWSs2R0lYM0dLYVh4RkdYUmNXbmE3Mmd5aFpLWGdN?=
 =?utf-8?B?QmFRMDI3eUxOWUJ2aUd2dGtmNzZzem9JMFE1MytIY25xQ0FxVW5yK0s3WDV0?=
 =?utf-8?B?Q1FMTXk2b3ZScXUyblg5bGNKSVJ2NFNzcHNjY21WS2g1dnVwL0VTWHpSYXBr?=
 =?utf-8?B?RC9DRmt2RVdTeUptSFpkK2gvNVV5a0RaeHhKUFRibEpXTXVuVG9VMzloU0tZ?=
 =?utf-8?B?bnozb1pEajV6aytiZjZjYlBRdDYvWEFRWTZId3F3cjMwRnI3UnVKUmpoTSts?=
 =?utf-8?B?RXc9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f224569b-7c0a-4ee0-6fdd-08db8e4d147b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 02:56:31.1871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K1wpZC3H8E2QllOtMPb6bAM0Xyt7c97tNPNCsUMLNGDeGD4SiP/hcGum09c0qvqrGVKY4YuuWoyMBQM9kP2IpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6942
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/23 17:54, August Wikerfors wrote:
> Hi,
> 
> Since v6.5-rc1 the keyboard on this laptop no longer works. This problem
> also existed before v6.0-rc1 commit 9946e39fe8d0 ("ACPI: resource: skip
> IRQ override on AMD Zen platforms"), so I suspected the cause to be
> a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks")
> which reverted that commit. Reverting a9c4a912b7dc confirmed this theory.
> 
> #regzbot introduced: a9c4a912b7dc
> 
> My specs are:
> Laptop model: Lenovo Yoga 7 14ARB7
> BIOS: K5CN40WWT66 (latest beta from [1])
> CPU: AMD Ryzen 5 6600U
> Kernel config: [2]
> Distribution: Arch Linux
> 
> The issue has been confirmed by at least one other user with this
> laptop: [3]
> 
> [1] 
> https://forums.lenovo.com/t5/Lenovo-Yoga-Series-Laptops/Yoga-7-14ARB7-keyboard-lag-when-on-certain-websites-or-when-Vantage-is-opened/m-p/5174991?page=28#5974742
> [2] 
> https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/raw/d4a56a1e994201b6c607199922aa22e4337b56c9/config
> [3] https://github.com/tomsom/yoga-linux/issues/47
> 
> Regards,
> August Wikerfors

This is unfortunate.  Before we go adding more quirks for your system, 
can you please check for a BIOS upgrade for your system?  If it's 
happening with the latest BIOS, then can you please open a kernel 
bugzilla with an acpidump and dmidecode included?
