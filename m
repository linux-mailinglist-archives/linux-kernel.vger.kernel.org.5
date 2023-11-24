Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B1E7F715C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345348AbjKXKZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234620AbjKXKZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:25:30 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979AE18E;
        Fri, 24 Nov 2023 02:25:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F331i8+x4VDOyk5Ejzg9rm7j3rWgtY01AW9dkLFy9KmAqM1Gfi7XffmLtBuDtJgF0ex16kR7/wZZEJz4k4Rl1lbJGZKR5g0FA5LvsEAOcp7ZcKxKf73XmoCaRgJ0W8pf9VN2twISGElD6fGCeU49draAiKxgjtP4tRx/iH76XIMNN8O5Tyr7HjZU42YLP95V8bzKAgGD8s19ZjHD68xP1Op5pfK/lFi8y8iALu9A+6RFP39PZzuvA0srkROLyQ25MWiTqZcHp83VH2w5KxLzYMTFoA+44YeiaPTWUxLno1G9tBuswPmyeyFffmVMajx1wDC9U47UeLb3DcJpDbrTZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RTKf/JCd3PMef1WvYV3AIcy7MyJ3kOl2XOg1WibvoRM=;
 b=YS7oiN65TZVxNpZF5yt1tN2eoQqafig/EkdfIE605uFbD28jqcnbuNx6uK4SBVlnbxLaYjawjA4Bzg4gJo1uPPJgJU+MHsLzMXHfyyMskxIbeQdqMfptXi1eQWwCqQLLMOL4lLkUWJ3YIlaIbYUK7ZuggyWJIQqZ5lxHxoagh0Avg84jOK5KoKaMICdNf4Ddno1CIlKX4COq1Srz9MyovKvSEOkoShp8c4k4v09MRxBCUJdYUsfxHcvZp4V7vnP22ffCJiU97UWGAu4znYvbhF+Wo5npS5So7DAMYS88OEGdU9M1yexwjsGyD+DKie+U8bMTD4OsA9FyI58opiDA0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RTKf/JCd3PMef1WvYV3AIcy7MyJ3kOl2XOg1WibvoRM=;
 b=t9pOVnGhN/bv4otWDcY0t4F/QTsBtDAMrzvwjJA4JqcD6RrrweiFrF6fQr3sVXA+e+j840nj6k91ygxNKtxhQAPdCyadtvHsB34W+nHLOi26WSG9leoGOfPonGRGZH1vbFdj20mLbrOVvnsFvR976Z6HJuZ17EE/UY4IbnnOhhI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SA1PR12MB8988.namprd12.prod.outlook.com (2603:10b6:806:38e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Fri, 24 Nov
 2023 10:25:34 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::cb8d:dc3f:80d8:f3e]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::cb8d:dc3f:80d8:f3e%3]) with mapi id 15.20.7025.021; Fri, 24 Nov 2023
 10:25:34 +0000
Date:   Fri, 24 Nov 2023 15:55:25 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Huang Rui <ray.huang@amd.com>
Cc:     "Karny, Wyes" <Wyes.Karny@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq/amd-pstate: Fix the return value of
 amd_pstate_fast_switch()
Message-ID: <ZWB6Fb3KcqC1fqbD@BLR-5CG11610CF.amd.com>
References: <20231123082757.3527-1-gautham.shenoy@amd.com>
 <ZWAlXl6MP20khEwB@BLR-5CG13462PL.amd.com>
 <ZWBRVlxBxb6DW+3P@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWBRVlxBxb6DW+3P@amd.com>
X-ClientProxiedBy: PN2PR01CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::6) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SA1PR12MB8988:EE_
X-MS-Office365-Filtering-Correlation-Id: 677dd298-94a2-411b-2e60-08dbecd7b15a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oRms6ILMerBc6LcEgXgKwWWwuttUAjf0CPgIH8EysUBnqU2dBIwqTqvm836g4q0Cd2yzbxdK5PIvyPUcyG0n0uAPeSjb639U5OECYoKFwbq19IgqbbHbhRQ8wVv9AkhCEeAJBS+tKkPFR1pobTd29hRf/20Dda1SI41QY52fCtQ0+yz12no2SQdUUAihcWHx4FMQY2ONe/K5e+pqUdH49dAxoJ3DNq7T4F5zvEzRPeCCUs9G8F+pjPBJIBS35l8lkGvP+mZiI8jQap2DO2dKeTyWQjfIpYu3CIanJv94BmUIOSCiR6Pr8EPA7Bam9Jy62GCJPdRrKMHJoNUlX9V+EE3Z5oL3GmVidiwYoqdg/6grOhzU2zKI0s3kZ/2n7cqKJG9WWsLYhWdduXhlR4oVPQFwF27E0PHodFmy9Ixqys6lY3e+A8gZwKm2Ldo0U5euEOlF1Ore5kGbBRecTt6PCky4wQfuFhH/p1CzaqBUuDUIF27btGzs/r70o57hpk1Ca54LiEi1BTLntiQmU/+ksJqxMYpi0FBws5V6VFT1WM4yq6Bj4mQgEoVyGgkyBuIJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(6512007)(26005)(86362001)(38100700002)(83380400001)(8676002)(5660300002)(478600001)(2906002)(6506007)(6666004)(66476007)(54906003)(6862004)(66556008)(66946007)(316002)(4326008)(8936002)(6486002)(6636002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TUaYcRXFLRG4+w7OrHaDYZE9MpZ9L4OjFbasWdNBgQuS7t03TZfarQvr4qE2?=
 =?us-ascii?Q?6HoWfPYiq3DMxXvhr+BMdXuMwwg/tb1sWQbREcw9Ty/HOYLY0qtj5YZH1WSQ?=
 =?us-ascii?Q?7ePvIIQYuMTOldZX2SdwAzhijpPmljjTUxSnkp81328j0ZUIpQknNvissY59?=
 =?us-ascii?Q?PPkrAlY7npayvDk6ukP1qUa+oNDmQZs5Cj0a/Ft+PehaQXi6VI6yfelIkLpE?=
 =?us-ascii?Q?17jAxChru5P3PyWtfT2D385SrYJQ8c5O9uw6M/DOwP5m9J9zn7hkVYZRVUT6?=
 =?us-ascii?Q?Dr8g71d4ZEmT7GRWvYC8VnSa7aKWj+OoyEZad0Tgxc2wDPq9d04Ybodx5jm8?=
 =?us-ascii?Q?JpyPv/2DR+GKwuQ4fMXQh7LQwH5DOCwxdC6KosjGIkxwofB7eD+3ye7lj7Oh?=
 =?us-ascii?Q?Q5A/U8XxmgAOkxVKKmExHkt+WMinBA9L0MVP1guSeT4KO0/X0gbdSJOQ0/hA?=
 =?us-ascii?Q?ERXRdwVtSKHzF4z0dOyqiOu4h8iqypKhjCM083mO5JfDyEOyV20QpbInnn5i?=
 =?us-ascii?Q?MO7K/E/6/PNAfHUpjHt/9KCJhCqHEYiF/Dp2Uw21LRe6JgrpfpHVha7kgZgp?=
 =?us-ascii?Q?3nl43nsNauxbIt9diAaRQjN2TLvUoi4PWlAE4XMvRMd2c2QbIRKkjxV0GPEw?=
 =?us-ascii?Q?yn3Ws0/ZkU1LwFB44v/7+xW2T8k5RQIiJ+c+EF6udb4LEb3rdb5e1CApAY43?=
 =?us-ascii?Q?0eObMv6YanXwZw6cBxQG2pVvhfH5dyUB2OYRaUuYWDhr2Ce0lXmx1+QEYTna?=
 =?us-ascii?Q?0LfXB3IKdZKkpojWk0dHbgPHqGzCSRVSmb2wjEYJ9wddoOYPBKFpa1QKuooh?=
 =?us-ascii?Q?9UJKBTTfjZJo5s5ovK0P6tMWG20whuoGvsKLghOMrgmUjDwCXbOZtIbsLV5S?=
 =?us-ascii?Q?waYVBiOVWu3+t/oRvtBzJRiI8NSZE1XeyP+xT+H+Q+pFBc8sMn8GLXbKgDBO?=
 =?us-ascii?Q?5ggNDy03+mT73gt2CycBbsJh+0eVHAEyHrb3eOzwq7LN/eY+jYZLgSsEPYAR?=
 =?us-ascii?Q?klCDuvaKYhlqQ0UxYZMXp9hb8PisooCTgqZDq3xH+QeGSnKhi3KEHDt/wENB?=
 =?us-ascii?Q?VVNvVtOAG4Z6l96Pr6gusTk3IR5VzBfiiI5M6QWLnO1OcoqKEv+s5KfjHrfV?=
 =?us-ascii?Q?z4ToRX7gi4LIZiL7tog1Tytk5N8I5bT+x4+XlFies2eNBVfAWDEmx6qiZqVj?=
 =?us-ascii?Q?rUm75e6kpXLHWAmgJ1uDxQdpybe0LAK5Wdv7/G95Qq3sbqY2ZAkp6UYbJl+Q?=
 =?us-ascii?Q?S99XcqIVGkgcQwdsZHN6vfh3DydmwiKhOCNMrRsPbYlHBasSOoJEUuN/ufig?=
 =?us-ascii?Q?vtV1OFANIb+db22qaezY+cQXZ0m4EjsitYPk2aqAixH5OblNdk2Bruk3OZCg?=
 =?us-ascii?Q?MZh7qfeFP55dom7VEQtNGC+hhV0jwTdg525u4gxZOCCsN/rPwp7t6CVCZrQC?=
 =?us-ascii?Q?jiBxya1EMXWfeXHBqUO6NpicU5juWrFOoyQHp/4IwK9FyDuifYiju8+QM51Z?=
 =?us-ascii?Q?x7/RKP07V9R2qGnaCgfLlNO5uFpYEZdslhQXQ8X+y1OnecxdvRgbC+DWteWG?=
 =?us-ascii?Q?skqwusOtL1c7P6YUbO9fPVa2rnqQBVbQzbdVYN4o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677dd298-94a2-411b-2e60-08dbecd7b15a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 10:25:34.1881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SwLHtPUagDusg29EDl4RwbwvTXDJp35u1Qa0+uPoiaC3QDLmj92nQ+GOM5tSMI50L5sZmDt6SBRNI1pf4e/krw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8988
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 03:31:34PM +0800, Huang Rui wrote:
> On Fri, Nov 24, 2023 at 12:23:58PM +0800, Karny, Wyes wrote:
> > On 23 Nov 13:57, Gautham R. Shenoy wrote:
> > > cpufreq_driver->fast_switch() callback expects a frequency as a return
> > > value. amd_pstate_fast_switch() was returning the return value of
> > > amd_pstate_update_freq(), which only indicates a success or failure.
> > > 
> > > Fix this by making amd_pstate_fast_switch() return the target_freq
> > > when the call to amd_pstate_update_freq() is successful, and return
> > > the current frequency from policy->cur when the call to
> > > amd_pstate_update_freq() is unsuccessful.
> > > 
> > > Fixes: 4badf2eb1e98 ("cpufreq: amd-pstate: Add ->fast_switch() callback")
> > 
> > Reviewed-by: Wyes Karny <wyes.karny@amd.com>
> > 
> 
> Acked-by: Huang Rui <ray.huang@amd.com>

Thanks!
> 
> Do you want to cc stable mailing list to fix it in stable kernels?

Yes, I forgot to do that. I will send a v2 having collected your
Acked-by and the Reviewed-by's from Perry and Wyes.

> 
> Thanks,
> Ray

--
Thanks and Regards
gautham.
