Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4757EC44E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344072AbjKOODg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjKOODe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:03:34 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AFBAC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 06:03:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOlGSsqSdhXOeaznUONz8a19uB0xSI5uMmuEUWmQ13hIXZHuD3PbhNcGZG0XyoxITtXF2gMdUXGqGoYeBilbFYpIk5cXSryIym5RZjsk5yewoUOcR+UfQyvARnpUu0DaiM23JLEQ2qmTZncI0F9YBdIrFFcP0WQ+ECZCaw8zCX8O4wdh0S0T2FvaKsxAhig/M4nhMDIMfJhKP6olOTPNWksQX3H0YFgMFMTcecWF6PJ6z/y8j9qinqQ2MTZwhpZz7wLk4u0If6wkepa+lTrFOnSJpFr/VqXfdH9nm70WmT7dMWNFab6qFUOLqk1Y8I+A105pYJZuZTtSNDkwMPiSZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+UT6HRegxr902JXdAvHTpRrTK6EKWUMoN9nZPKLshA=;
 b=fAgC+SwcxRpcIpztVeBhKTfPCm/xT0xSaEfxfRxN+S6Nd4B/QSYk16gZhLJVYg+MtnM9Eedftehqe8ZzeTpaY126EugbAeVh0T/YLpsBFWOXNYhoErEy9/HfIbU2+SC3f819d5W5Z5/uKpP9kCQUCv7kNJkLbVRsLzcY5qb7bKiSYJO4ehaVqecGTksd7C7xXukQxddf31wXk2UDZFPHc4zZBcCaVR/+buCbDCBW8hL8w7y/atTQ7nCmCkMchozOFWApSsr0Vm5MydxNWE0mqtUDJJTJdDdw1ZJ987SN071hTmnOsFCVj0Se1BcsZS6inzFVpIdtEPyk6qaZSf/I6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+UT6HRegxr902JXdAvHTpRrTK6EKWUMoN9nZPKLshA=;
 b=4A+WQiWBN8OWYtoajlrui0ayyv6fCW3/X9M/PqKQDjNKoCx0BPO1v9Hl7Gl730eAfO2HLlFyo0D/i8Yl7ncDQMNXf7neicg1Ld4TMsWM1erP3lAdxTorI/ZrqQzteoBbbaJtKFOZNwgZNXW6BmjNefUAZSLVNskndhbXghIEMzA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by CYXPR12MB9277.namprd12.prod.outlook.com (2603:10b6:930:d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Wed, 15 Nov
 2023 14:03:26 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%4]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 14:03:25 +0000
Message-ID: <ae327757-11e2-44a8-8711-dcde7bdedffc@amd.com>
Date:   Wed, 15 Nov 2023 15:03:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: xilinx: Fix for call trace due to the usage of
 smp_processor_id()
Content-Language: en-US
To:     Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231027055622.21544-1-jay.buddhabhatti@amd.com>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231027055622.21544-1-jay.buddhabhatti@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0094.namprd07.prod.outlook.com
 (2603:10b6:510:4::9) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|CYXPR12MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: 518de906-b8b3-4834-adc8-08dbe5e3a2d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IumCU2MTim81/IGIZ8uOphvpm3bwyhHGh7wXCch6nOLxTxI2SmNTJo3RscRkb6yBwVAlWbJRpucc/LGA2FIyEQm3dmmt7puvFksOiVLi1WSZHV3Mj2/gl2xxa7Ns0B/qo5NCHCcOf3y+AggQTEXATK0m8qYt52JAzn28AWmRJjjDwRxQ7EukDbrte9/TbpF1fsYBiLKz8XHkFmqb/97Sv9hz3La7Q67lkQSq5+Y/B+KOL7lOHL4vj5+HypzLoPRWMJmqN6ZBuwdTjVWsb+d+IIFPEpEQH9MHlXn5QcwG5fuc9EEuJXm+PEKipQ45XOWhlHF7fBm2AtHZhSuuglMLf9Qj48Lzyi4M6kJwMowyKpK2ctqRS3LIhssbH6gHpbP6Plnij+95njuej8Ei4xPbTFiss82okQsxerDHVQPF5gYn7oBFDudkbIrVtG9Weee9RMUp5TbZ6BB+aOWGsSiBqUSm7I5amyZuMhLPe00ttXcwpE9q7FJ53o3sTQBPSH2TD7cudubpYko+w2i4DFfZZ2xerFh/fvhsZkbtamfyAOgGyykvGQJYskJ5XUbXnf/wl3WAGnXTuLkOZpUenrl6q2qVj5cYYzqHq5P0+vt93Yr3gCyYJgRbft7umGsibymfMqnWDLRJBOoQxpTMdbIJbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(376002)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(31686004)(38100700002)(2906002)(31696002)(5660300002)(86362001)(44832011)(6512007)(83380400001)(6506007)(53546011)(26005)(2616005)(478600001)(6486002)(6666004)(36756003)(41300700001)(37006003)(66946007)(4326008)(66556008)(316002)(6636002)(8936002)(6862004)(66476007)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUJkN0FYMjhMcTZtdE1TTGxpOEpqZWJpOTY2WUhYL25janl3eWpnYTlqODVB?=
 =?utf-8?B?cjlEdUduOXAxRTRWaVZDSEoxaWxBdzcrSzJCTFhUNXFKOGpTWkhGOTU5MWpH?=
 =?utf-8?B?L0MyNzFjcnZOd25xU1JvVkorQTZpcHc4UmkyWkxxV0hBQW9QOE5jc2NDWEYr?=
 =?utf-8?B?VDJJTDhSc1VBVUxrdHc0VEJ3ZkF3TUIxQVRlcmNRSXBuWlVzVjVBUlg5U01p?=
 =?utf-8?B?MU1IdGhTYS9yVTdHY0k3OVJkUW1VcW9IREk5OEVZR0F5clY0NUF2N0FEYTNa?=
 =?utf-8?B?S2N2LzhOaWErQXBjVVdYOURtU1UvQTFKVjl4MkRFWGRhNHI0U2xRQUsrQ3o2?=
 =?utf-8?B?VnNMb3lZa1g1N2x1ZDRZTzA1eVRiZ3ZhaVdTZm1FSjl2RUo0eWhOTmMzaEdj?=
 =?utf-8?B?eTFQc3R3M0NFZXlZR1FNS1ZiaVNGOTFCTWtTTXRhc2c1QUhpZkJTcXM4aFNT?=
 =?utf-8?B?a3QyakpVU3JEQ0p4MlArcHN0Z0VNUkJVMmsxd3VXZk5VS0pvYjBKTm9IYnBl?=
 =?utf-8?B?bUxNYVVNSUFkZ1Qwd1ZGUHB1aURvcWh2dDkvcUs1SkFzdjF6cFBEN3BPNStv?=
 =?utf-8?B?L1V3R0VvdUNKa2FKeTVtYmpGL2ZQN0ZkUHF4SVRXM0kzZzVTR2c3Z08zSm1W?=
 =?utf-8?B?alFvMk8zdHg1ZmRoMlFvemhPVURza09UYnIvNkJSQUJBYVBkbXgvQ2xqQlk0?=
 =?utf-8?B?cGVFMmh6eVZoOXdyK0ZZZEdkK1dsN0ZVV3J3cE45WC9ETVZ6TmpoVVJtREdL?=
 =?utf-8?B?MnN3Yk8xaDg0MkkrL0N6d3c2dHR4NmJ4V0NUa2tJWkNzVWVTTDBhTHE2aFFy?=
 =?utf-8?B?dmtGMkpsc0hWTExCdWNCYldGV2R4M2RLZjh1REw2b1lwLzE1eG03NUd2SHNv?=
 =?utf-8?B?L2IySE1qVXZSZXlsTFdOQ1krUTFMbkJ4Wko0dVhmRnFzd05LNWVCUUt4anls?=
 =?utf-8?B?NnEybFEyMnNyZVRPc0FkNEtQYmVrL1d5cXV5TzUxbFl6aWx1eE5Wbk8rMUt3?=
 =?utf-8?B?eFJkajVwRVcvakZ6cHVrNDdWRXpvQkJ2ZHY5cjBocmw1WjlMWk51a2lOditU?=
 =?utf-8?B?UUdTaS9SYmZaZno3L3I0UGJvdzlOZ1BraFZGQW5zTjY1VlhtU3FvQ2pYSVJv?=
 =?utf-8?B?UkZEdzNVc0pHUWs5Vm5vRTlEUWQrNjZ4TlUwUUtrVUN3bmZrbk4zMGVRM2lV?=
 =?utf-8?B?azdZM1cydjNDZmVxbG11TUYwUTdTblZ6UGlKRHBBbnVkTGJkUGRxZ3dpY3BG?=
 =?utf-8?B?d0xxUzhUaU1wR0F4V0dUTTlSMHVjcU8wcm4rWW1QNXNrNnpwSnloRDlWeEp0?=
 =?utf-8?B?OVlEaTc3eEhVUjg5aEM1STJFY05MY0JUM0pKbCt3WSttN2Y2RjRoSEV0dDZa?=
 =?utf-8?B?Wkc0aGZZQmlKVjM3b1JwYWtxMFhPN0hGUTduOEtBWnkvejIyTkp0R21KSXRM?=
 =?utf-8?B?L3Izd0MvNkpxbFduaWtXQzVqNGFtcWZ1TWxEQlR5RThnVC9QSHJIN2VXdjZz?=
 =?utf-8?B?dHAxajNBYUFkRlJEVGoyWHJMZDc3d3FPVW81clI1QmMvblE2KytvVUFFUTBF?=
 =?utf-8?B?TFNxMW1Dc3lvNER1cEhyMmQrWWNBc1BqNmpHY3FUaDZJZDFrZ1h1L1diWWdC?=
 =?utf-8?B?N21VYmkrT2MyTHdPVFArc0VaekN0VFZ5TE0yVnFuVlF1djRXVlVYaHBJVmww?=
 =?utf-8?B?SVpRNVV1ekVlNkk0N3FybWh5ekNDUDRnTGlQNExVSkd2dXd0bEJ6clRaYXY3?=
 =?utf-8?B?am15cHdIRitkVDZTcHNnUzA3V1ZHQlRRNGVDc0VLekt3OVlPWnZ5M2JOQUpS?=
 =?utf-8?B?MnFNREE5dnE2ejBRdVJKVGJMbTd6MHJacVZTN0U4ZUYrNStBZG8wMENyaG1m?=
 =?utf-8?B?SnF3Ukh4NUk3Q1RNRnd2cVJYU0VyTXNodmIwS0NwTThSMlpmNC8xUWZhQW8y?=
 =?utf-8?B?OWRwNUx3RVVOb0hpQjZlV3VXbHc0WDZmOGFvcFRqUzMzVGJuZGh4anB2WVBP?=
 =?utf-8?B?QlF6eEU3bnRhbGFnb1pwbzFYSlZJUmxremdHZ250U2pQOXYvc2xrQVZQQ0ZW?=
 =?utf-8?B?ajNXNFg4c0IySWVhSy94MTJ4TEc4cjhqNElsYUd1dEpucFRCNUIybnFxQUdJ?=
 =?utf-8?Q?BWNOBEr1i7pi8oOuuIvvwLv35?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 518de906-b8b3-4834-adc8-08dbe5e3a2d6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 14:03:25.6642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r14jsoq146pNSTR0Dub05kwYWpUeDV3fovogMSkeM0U9ZaS/eqc8oEd8J9ApVAsT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9277
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/27/23 07:56, Jay Buddhabhatti wrote:
> From: HariBabu Gattem <haribabu.gattem@xilinx.com>
> 
> When preemption is enabled in kernel and if any task which can be
> preempted should not use smp_processor_id() directly, since CPU
> switch can happen at any time, the previous value of cpu_id
> differs with current cpu_id. As a result we see the below call trace
> during xlnx_event_manager_probe.
> 
> [ 6.140197] dump_backtrace+0x0/0x190
> [ 6.143884] show_stack+0x18/0x40
> [ 6.147220] dump_stack_lvl+0x7c/0xa0
> [ 6.150907] dump_stack+0x18/0x34
> [ 6.154241] check_preemption_disabled+0x124/0x134
> [ 6.159068] debug_smp_processor_id+0x20/0x2c
> [ 6.163453] xlnx_event_manager_probe+0x48/0x250
> 
> To protect cpu_id, It is recommended to use get_cpu()/put_cpu()
> to disable preemption, get the cpu_id and enable preemption respectively.
> (For Reference, Documentation/locking/preempt-locking.rst and
> Documentation/kernel-hacking/hacking.rst)
> 
> Use preempt_disable()/smp_processor_id()/preempt_enable()
> API's to achieve the same.
> 
> Signed-off-by: HariBabu Gattem <haribabu.gattem@xilinx.com>
> Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
> ---
>   drivers/soc/xilinx/xlnx_event_manager.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
> index 86a048a10a13..edfb1d5c10c6 100644
> --- a/drivers/soc/xilinx/xlnx_event_manager.c
> +++ b/drivers/soc/xilinx/xlnx_event_manager.c
> @@ -555,7 +555,7 @@ static void xlnx_disable_percpu_irq(void *data)
>   static int xlnx_event_init_sgi(struct platform_device *pdev)
>   {
>   	int ret = 0;
> -	int cpu = smp_processor_id();
> +	int cpu;
>   	/*
>   	 * IRQ related structures are used for the following:
>   	 * for each SGI interrupt ensure its mapped by GIC IRQ domain
> @@ -592,9 +592,12 @@ static int xlnx_event_init_sgi(struct platform_device *pdev)
>   	sgi_fwspec.param[0] = sgi_num;
>   	virq_sgi = irq_create_fwspec_mapping(&sgi_fwspec);
>   
> +	cpu = get_cpu();
>   	per_cpu(cpu_number1, cpu) = cpu;
>   	ret = request_percpu_irq(virq_sgi, xlnx_event_handler, "xlnx_event_mgmt",
>   				 &cpu_number1);
> +	put_cpu();
> +
>   	WARN_ON(ret);
>   	if (ret) {
>   		irq_dispose_mapping(virq_sgi);

Applied.
M
