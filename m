Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03E87F6CED
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 08:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344572AbjKXHcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 02:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjKXHcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 02:32:05 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF69DD4E;
        Thu, 23 Nov 2023 23:32:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kt76AfUwKjrYk/+XpdlwUaGgt4RlD8R9kh2e0axkPDn5Z96O3fXBYD6OQoePVoT4SAdwJSVUwmDSmMakQo0k56m9kTtRL1ln89HQeeMH7nvsS3Wi+1EPfMx9MGtYUwDXDDz4y1YZ6Oz5MCq8hiAPtSAi+1Ve1A+GLmq/1ARw+Hl9T/TKxnHEgQfdMW95XTgjTrKb/QmHXEIFc+dDiX97lrXClTMcE9jVy3nbaSPQifIsSQikE/G5gGYTfi8dr0FiEKk+o+z0y92AW+6GNoOMFFZe1SfjDO+I4LGYpOIfe381R0LbKkTtNzy7WhbjIhozvAfitj5tezwMfuyoUZYqsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYBq+UVV98zI3POXNp6hoWM3s0oqJdPzJOWJmrt6UXI=;
 b=MUwWe81xGsLe5KHRFV87DPp07nBA9ET/q8u7iW1Tbl8GCeUURu40bBri9gHq6CbDmWnsDgE2jENma7BSTDhLqnqNt4o7QYFZ/CK4DfhxebjrFNKNVKFvaSs5KmhS+BtXZX0a0ov/TNlkM3JeShnf61DRN84K9nqjrsrYj/VBPNxgtHVI4fmdnDEHXnC7bPpeIxCdCv6RoT44FSShKtgCRhk5JShvMpUvMiCiLw8sW8R5FsKOMsjJ3/p1QEEU+xjoxNMgVCKM2nE6Mhkh0MZ8iQG3Y0LGiA5/eOBktS08tw2sla1BNLBfrd7Qvmk+zTvzImjO1L7RqDe0mn4DDKcK6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYBq+UVV98zI3POXNp6hoWM3s0oqJdPzJOWJmrt6UXI=;
 b=2U3MbzHhIm/NNPW2R8rGOQw8nFywTly3SVMdwVbMatcoXMEKBXvJUm4h6ZjjOLXEGltA6RoAyfOJoU3rMFoY4WPwgkJDmWdwYDCQcrfN3MALUGMsGFuGSGnumxyQ/HNnhR95E11jquIo16vZsKwPG5XvS25ZMadp2NLa2/UvrBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB8706.namprd12.prod.outlook.com (2603:10b6:303:249::5)
 by DM6PR12MB4943.namprd12.prod.outlook.com (2603:10b6:5:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Fri, 24 Nov
 2023 07:32:07 +0000
Received: from MW6PR12MB8706.namprd12.prod.outlook.com
 ([fe80::6d22:b05:8766:e7b0]) by MW6PR12MB8706.namprd12.prod.outlook.com
 ([fe80::6d22:b05:8766:e7b0%7]) with mapi id 15.20.7025.020; Fri, 24 Nov 2023
 07:32:06 +0000
Date:   Fri, 24 Nov 2023 15:31:34 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Karny, Wyes" <Wyes.Karny@amd.com>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>
Cc:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq/amd-pstate: Fix the return value of
 amd_pstate_fast_switch()
Message-ID: <ZWBRVlxBxb6DW+3P@amd.com>
References: <20231123082757.3527-1-gautham.shenoy@amd.com>
 <ZWAlXl6MP20khEwB@BLR-5CG13462PL.amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWAlXl6MP20khEwB@BLR-5CG13462PL.amd.com>
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8706:EE_|DM6PR12MB4943:EE_
X-MS-Office365-Filtering-Correlation-Id: f3f33aa7-d476-4016-3563-08dbecbf6f1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pld1gOlEjLwDrkyDPt880psFljJcGmAe1spNFtjQRfoJ6rqZ1G025CQIIODYxT4IRv9BnhX5u6EhJgUMET84I2wNGaguWQcG/xf3Y19GfHpPNPezKe2cOk+DOgzafrRhrJlr5JPNyrghRt3X+Rz3uj28LacTYbDdjy/KSLOsYVw50RLwf+BL1mpFzxYY3uy0z4BXaNweHJ42p60wRdYuOmK0m2E6J5co3wniHgCTF4Q975ZXhg9ZZQh3ra6Ivg5vsPFFEplSrYYn9OtEup0Z7VL6usg1F3v0/r/zk/c6DvS8xTQDGkzJpnv5IjxN0evKyzAhtnz1A6nSufj9jNEVGR7qJXmVG4++gUlexhOnXDDeDDIceuu1wQwV6/zUCTLIQjhOtxFT7BdGJw/szjsCMlJ2xM6Ko3gg4vf3WuX++1zqNzrWuj68Yt11qm0SxaJB/iZM4nLjzlYlQxx53H4IaHxF8N220QEUqr8CZ46/AtJ18wm6IVgx2x55WrzoEFbXd1166Opbh2CaJqiEZxKCOf0jLGD70J1EgYqpPqDYQhPpkAqZF/evIFMfDqEm/mXoKscS3aIk6Dcmm8exVbsJ8LnYeAEuUNg72/B3ek9Zqvk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8706.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(396003)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(36756003)(38100700002)(86362001)(83380400001)(6666004)(2616005)(41300700001)(316002)(6636002)(6506007)(66476007)(54906003)(66946007)(66556008)(110136005)(4326008)(8676002)(8936002)(26005)(5660300002)(6512007)(2906002)(478600001)(6486002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DFdkiikuZj8J4KezsOGbB11B3zTZC3n/AGFNgDUCcMmhxs2GJHkmQWw8AWZs?=
 =?us-ascii?Q?Ok1w5aZS0Yem+H05QIgxLIILLnz5ocUoPwpWMhstDaMxytDxBTqMGDmKkagr?=
 =?us-ascii?Q?FMLoG4Drbu/jVRxRgffeiKMmgUasV3hyvgAMCqNASDKYFR7QpVYp9T/LAi2u?=
 =?us-ascii?Q?3qbfNY0PKX/452I7kxyAk8aZ1kNDJRwv31v87HiZn0EJutGzZxDicPlEWueW?=
 =?us-ascii?Q?rFmZLIqKv2FG8PS32PaJg7cTqa8szqPUW1tkaWArqyZJW/s/ZjvDwGs5ZtdG?=
 =?us-ascii?Q?+FGzN/0COtG7eQWnV8SCv77H3wPc7OKQZbN3Fh5K+xwdn8xr7RlDu/U0SMGu?=
 =?us-ascii?Q?X6buqunfRmjxwZ4MTD8MMeZvGKTP0thjwSBM6426ZcvanHStxh9FDgXPLHdt?=
 =?us-ascii?Q?oJyvxw1cBZ5UzTbDkmbs6blMJDTJIAgEiKnu0aCRhcAYPuMEh4vtTLAXfc4l?=
 =?us-ascii?Q?zy4h4nFgi7lNPWSIAaj6QKd+F3r/5/xmpmE0yd14ssQao58dK9VW7S7pUcMx?=
 =?us-ascii?Q?5S2pETRjhzvXBCdIG0EgrVCXynCTHJBRAp0sa/Jgzwe7J1IYsRUMEjA7C7x5?=
 =?us-ascii?Q?9nAcHy0kn3bHvyW71bbimZfe+5j9p0swqJYgCcgfYKrUfYEkGfD9pAnbquv0?=
 =?us-ascii?Q?M+hUVqxVzPGWzPIM5p3TLXFKUmTPdl8j4lAnRNkXbVqmCj+O8Xwj88q42Kqs?=
 =?us-ascii?Q?4iQ9K/zJq5Rp11myvn4QtazPm9fd9X/XNmTUE77WseCN4v2t+Q4BtzWUYB8i?=
 =?us-ascii?Q?gC03SEMqDTHtCYJZitKiIOPrHB6PKA0soa6Eb0Q7kSIeTwRwwQT8j0n5iG58?=
 =?us-ascii?Q?93gt0xMRMlxeiNwUyFt5eva83rRDHJWYjNmzO9jC/n0pHpe2FK6f06WMfXif?=
 =?us-ascii?Q?yEZJlFwHoyFHzo067lFsws0QOr2hnghMrR4STJvNSgqHMItCT8u30YuBSgqF?=
 =?us-ascii?Q?ZcnNOvIcsiaquAa5IoO9QVATPYid0locuQJfuUVUXnYuaJ/ga4uDv6MEZ9aS?=
 =?us-ascii?Q?dZuswVMdD3TT0UO0FlRYtiFCvkn3Pz7N8rVvwVfZyllKcokRKIDteFBfz/C0?=
 =?us-ascii?Q?Jyg+sqlyPrHx2c5B3XyxU/+I5B1RhL2gQcni7LWctvVaT51LcjkszXWGgJIS?=
 =?us-ascii?Q?+LB4SrYfRsEevgxzHZqmKdYY0TAgaCSHPDyKXx17VsqzQfCx1xbbqA1xaNl+?=
 =?us-ascii?Q?ZF3JEX1z7VTjA46SE/EF0ECG+H97fOAXFZPw30hhaP2+573dNaYrt8CuL3/q?=
 =?us-ascii?Q?/vR/6Qxl8rbMcpJ2Io4w5eUXowu9xL7cIL7Jp6Sc4rIYFPlBJ0U96TJ8ixQd?=
 =?us-ascii?Q?qlMU614yHnRQk1sQuyfmiF6GY/kw/vzWpAs9fdYqXRdqh0BizdRX/i+Ynoaf?=
 =?us-ascii?Q?/g3qNA6sfXDHJT61kH+/x6ZcOmWP8N/t1oT5AON0op9Hv0pfQCyZzdH8J3r4?=
 =?us-ascii?Q?zIqrXjOZ3C57+MYGdc9x7kK7LQI4wMXdxj5oz+6gcA4pYoQrpstCUPRJfmsy?=
 =?us-ascii?Q?c8zNPVMzPEhtTk8KMVtwnH/b7ngXdOzaduFF0umJRBA/dNWYkYvomGXTVtdT?=
 =?us-ascii?Q?b4w7x/BxELV7lCe9QgqJ6BwpTTvxYTdXyWdmMEw7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f33aa7-d476-4016-3563-08dbecbf6f1f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 07:32:06.5725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rd+QAucK6y9FBdGthZvKt5LDf86Ed54/K1kjVzuVJ78sFCs8cOTzquz8nlzNnNbQx1f319xQaPNbnnuyCNHnvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4943
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 12:23:58PM +0800, Karny, Wyes wrote:
> On 23 Nov 13:57, Gautham R. Shenoy wrote:
> > cpufreq_driver->fast_switch() callback expects a frequency as a return
> > value. amd_pstate_fast_switch() was returning the return value of
> > amd_pstate_update_freq(), which only indicates a success or failure.
> > 
> > Fix this by making amd_pstate_fast_switch() return the target_freq
> > when the call to amd_pstate_update_freq() is successful, and return
> > the current frequency from policy->cur when the call to
> > amd_pstate_update_freq() is unsuccessful.
> > 
> > Fixes: 4badf2eb1e98 ("cpufreq: amd-pstate: Add ->fast_switch() callback")
> 
> Reviewed-by: Wyes Karny <wyes.karny@amd.com>
> 

Acked-by: Huang Rui <ray.huang@amd.com>

Do you want to cc stable mailing list to fix it in stable kernels?

Thanks,
Ray

> > Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > index 9a1e194d5cf8..300f81d36291 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -518,7 +518,9 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
> >  static unsigned int amd_pstate_fast_switch(struct cpufreq_policy *policy,
> >  				  unsigned int target_freq)
> >  {
> > -	return amd_pstate_update_freq(policy, target_freq, true);
> > +	if (!amd_pstate_update_freq(policy, target_freq, true))
> > +		return target_freq;
> > +	return policy->cur;
> >  }
> >  
> >  static void amd_pstate_adjust_perf(unsigned int cpu,
> > -- 
> > 2.25.1
> > 
