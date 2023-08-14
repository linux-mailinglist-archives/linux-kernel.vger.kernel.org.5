Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5318F77B05B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 06:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232771AbjHNEPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 00:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbjHNEP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 00:15:28 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95148E5E;
        Sun, 13 Aug 2023 21:15:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+1bMYDq1doyllk6PkespwgouPGR1iwkwSIASdeGgw0zNepWr6DiL5Mm5PE0ehmq9IHRHWFOkdudqL4FWCP61MPPeY7fuAS69k2X+S3V1gsKxuLp5zVv4Kltvcs/plHThVMaxH2hj6+mknqcOGTwU3QEF7FCwshQ/FAGEEw9V4EBbtoB5SbtNs5n8ooQy7PlsOdNDzuEZOE6w9sl7e2lH0XMK/NI013n+WHGrr4dQh3vTa8MkkUyt2HLq92DPKFWktAN6KRCortqDuJ9clsDyEDidRB+eFe9DZsTR/h8cDpxhMwiIZeCvo1ge6XIeclyVoAUIGMYVpDIb9bqkeiBlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPbhsL8PH7DAQnSNn/CqLVbyEdCNM4a7x8YCLh7zlCQ=;
 b=Kui7oVyQPWZSNzAsrD831wOom2Dcf0wJhcr/TP81e+rZ6o4pg+7J5BEh8Ljlg3YGtEW24d26GwOJjBZs8KqLcN9hIAZjFKLik1edcnB8i8ixlVRIhNmoHoCETHjn472xjwDJFSVENP9Tw7vzyiXzLCG2oFTjv5fLPrIRya6jws4YXTnqSK92fHAwocO5aexqQ33bEuCNBoA7p8uS11HfPTwEv2byuoab9lehas4QbT3n8XoZ/50iWj/hWX10XVIdWaguU2ojz1wD2IJDekw26w3XM29K4/YRVMkcIcTkBJpXZTLJrdqJskP8mEb19ClNjUWHYjtkoJYjQBIirSEFLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPbhsL8PH7DAQnSNn/CqLVbyEdCNM4a7x8YCLh7zlCQ=;
 b=tyQc2QsL7/aE16IHdAa4bUXrwQcljeMYIvtUgxil/kII3/R8dWobv1Z4ot2YhgI4CXP+dW7m7J5x3131ZoGbq5PJOeAENkfelsJEDvemcCpiTdG46pwr+XsyBiYBNcRYPLNALkfEfp68TE+oswIM8f9pmo7Is8QG7RU5KSQmRT4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by SJ2PR12MB8737.namprd12.prod.outlook.com (2603:10b6:a03:545::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 04:15:20 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::da13:5f6:45:fa40]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::da13:5f6:45:fa40%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 04:15:20 +0000
Date:   Mon, 14 Aug 2023 12:14:58 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Karny, Wyes" <Wyes.Karny@amd.com>,
        "trenn@suse.com" <trenn@suse.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chenhq2005@gmail.com" <chenhq2005@gmail.com>
Subject: Re: [PATCH] cpupower: Fix querying boost support for amd-pstate-epp
 mode
Message-ID: <ZNmqQkOK7CLa7TNl@amd.com>
References: <20230811213501.17293-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811213501.17293-1-mario.limonciello@amd.com>
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|SJ2PR12MB8737:EE_
X-MS-Office365-Filtering-Correlation-Id: 15b2d072-3998-4717-6320-08db9c7d1277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: arByasH16BqhfWAo6sKhiYi/Y6iaa85hWZ1yjASDFBT5jjOSbAaA0oTVSCRo+YofjdP6yM/zTC+NLB8i8nuQS5W/NO90K9iani+Dj9WHXzYtDcqwCY1FeuO2flc96GW/LMaG1C9mk/rQ7ZLyXCYmcyZbR8V0SqcNhxMXqFnlsSaHPtbJc1V0IT5+SvAv3pbE6lUS7bv1Os9KiJ0Elwhca6/D7fGBR0WZiHRIcpG7BBZw90XcBY1mIsHCUTU7Ue2GISTFra6s5rUo8UuJSizkJ1YqfbMdNhqgVPHrMJF0kzeJkTUqr4uqwFLWwd2AnLvQzZtRUSQW14ruz3kCVjbOt5HNGGDnIeczw+Y9DEE78pcxqRdOLDrLtioPc2o4vhGzT3Wnyg3fcz5B37+C67P3NCmms1o8/NaNLPCUEzhwqfKedh/n6uqeKWgTeWB9vtBsT1Rc3zslTuJX6Dc6XHxPrdJVyvGPDmgiaHESVlEMPH3Pha5uJqmBwxTEGfV+EJEoP8gjfcSUSy6GjI8+ix02AS4V7ckv+yAEEgQ6On8kbK0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8690.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(39860400002)(366004)(136003)(1800799006)(186006)(451199021)(316002)(41300700001)(8676002)(8936002)(86362001)(6506007)(26005)(83380400001)(2616005)(38100700002)(6486002)(478600001)(6666004)(966005)(6512007)(66556008)(66476007)(66946007)(6636002)(4326008)(37006003)(54906003)(36756003)(5660300002)(2906002)(6862004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vWVtZLCVHVUXxMIhWOu+ePyxXDqxzDcItx7RB5XuF2JDG5jjFGJrAgBGxJh6?=
 =?us-ascii?Q?XBg05ZSkaB6DR3x03dXailnIszgT0aCQVTOPwqr2YnCrgEgSnBKaDfQvee2t?=
 =?us-ascii?Q?Pa3DBLqWypqYzN+UYIaxavXQvKL+2GeFFegIZhlqwEpqIGVX8kKT1/HIuByy?=
 =?us-ascii?Q?oWLJvortCd5LnVi5kIPSoRxIKhUqXc1Md12R7PRA+olNN+8AIcPmyU5qNeS9?=
 =?us-ascii?Q?7FdmmpMd/ixjWuj/YTznBe91/8Ge/nAipJ3bHInD6yEYZLKegQRJVJo0nQL1?=
 =?us-ascii?Q?lgoVig8AO2Slp1jMTZuD45kTINxpUSvnj/V7opq1Hn6y01Zvm/1lVUrf0xeH?=
 =?us-ascii?Q?y/Jax8toUgi23gJf0DdjgZ5ELoV+F2f4NP6/sq4K7+GcgZz4vvcoTudmkLIp?=
 =?us-ascii?Q?fHpxtPvvKYZ3Bfl2C5M4UCbEIj4u8SJrU9mBouZtASjxZA8v3hYV10Tb49iy?=
 =?us-ascii?Q?+tNtJuXBNJ0NqL0zhY+QoAzUOBsfUDjpQ4GUE8/R704pAeA770l/S97wpO6t?=
 =?us-ascii?Q?fLWG+5cGzD8EG6lAP+ps2ASxHKEq5y0UE7fLLkAsVPpNpHxpGHAkIJb1+gXr?=
 =?us-ascii?Q?y/+AaEYL/K7wkoLPw9mqmbURu3BgIDsMl69IuYHlvpRv3rMDvFvy7Yav0nkc?=
 =?us-ascii?Q?hnIVPUga4Q8AARNFaZhXytKhw4CVUpjeVGD6LZFoDbotqDrpktksBTYlSOs/?=
 =?us-ascii?Q?tBS9h7WZEO3mPZdHVq098K1z4pdow7O95nUKqh7Mxw0J4pwBDLkhv13CrMqt?=
 =?us-ascii?Q?lln/c3WXKJgdHLwwWk7+53yylw7ySG7ftrZPWa5FnAedsPyDR706w2kTUcbl?=
 =?us-ascii?Q?tqcvwTTLMhaL2YL/CrdGi854Af4Y5W2A1HBNv1rxW6mmYRN3BqapMzVt52Xs?=
 =?us-ascii?Q?AKI7KmxJkWxD9tD6C0J4x4ACirvqKweVihoPmnwbyyemrK3r6AEfaOVX4/DQ?=
 =?us-ascii?Q?b+jgcSB7t5YwuK8FP+FC2WldkvFMnGO5Z0r+H+MsmpRFs5/VDnGbxn4OFpg7?=
 =?us-ascii?Q?LktllSDQUGrhTbnDBcxNbeMKxuAVeBhMzttDTmDaTMufGTamSFpm9MBL0v5r?=
 =?us-ascii?Q?neSHNhXJXlddFqVTYQ+1Avj0HrYG/CiGnlGL8xNWtK1CyZMnG2yDWyki6QsW?=
 =?us-ascii?Q?AVPvGovSJLfrbPPCiym6ozxCDj+FZiFAjbh2xWUlANDrAUx5Mb62dbygowfs?=
 =?us-ascii?Q?/G5XYQE/r1bRTV1X95Bv9/ajGV5upQidsuo/IoLZe1qBnQBg+/z1yMx7dBou?=
 =?us-ascii?Q?KnguIhjZM4jYxnTL+bJF9O1WUEgPuBmocJ3mzdMDYnubjEILJ1uH2ZqiCGH3?=
 =?us-ascii?Q?6S27GPbfo14ccqu2sYsFc2dqb/1/fjXMyeUzjpaV2gmdEXGughhZTyZ362IY?=
 =?us-ascii?Q?rFttZU3OFAIp0AzdFWRZH0y06G5J6jjjQj7oUGEXPb2A0SfNN5S0IkxGaxXF?=
 =?us-ascii?Q?f06uCqHJR7BbpC9Vqg/Ex7I6lEfA0L8/88jAsqVdrNt3wWF/Ee0PWVvc7LHd?=
 =?us-ascii?Q?WRrib4XYQMJWs/gYm5DMScSzDQFPJ1p96sXAApw3RiJMHqQyScyEo0bmENFN?=
 =?us-ascii?Q?66vOx+hBAczzgbO9pJpyDkCQe2wKqTY3TISLwNai?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b2d072-3998-4717-6320-08db9c7d1277
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 04:15:19.9275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QinoRe75Z5UMblUPxbDBOrWZufJ/OqjYhHXO+J3Su3mZiyUDjKox3jV5EohtWMhndYaghnbMK2f8l/MOBcV//g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8737
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 05:35:01AM +0800, Limonciello, Mario wrote:
> When running in active mode the driver for amd-pstate has -epp appended.
> This throws off amd-pstate detection.
> 
> To detect amd-pstate look for the prefix instead.
> 
> Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
> Reported-by: chenhq2005@gmail.com
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217755
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  tools/power/cpupower/utils/helpers/misc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
> index 9547b29254a7f..01c0440efe850 100644
> --- a/tools/power/cpupower/utils/helpers/misc.c
> +++ b/tools/power/cpupower/utils/helpers/misc.c
> @@ -95,7 +95,7 @@ bool cpupower_amd_pstate_enabled(void)
>  	if (!driver)
>  		return ret;
>  
> -	if (!strcmp(driver, "amd-pstate"))
> +	if (!strncmp(driver, "amd-pstate", 10))
>  		ret = true;
>  
>  	cpufreq_put_driver(driver);
> -- 
> 2.34.1
> 
