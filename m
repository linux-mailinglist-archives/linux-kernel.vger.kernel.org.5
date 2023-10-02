Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E486B7B5493
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbjJBOFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237452AbjJBOFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:05:10 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA12BD9;
        Mon,  2 Oct 2023 07:05:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdvr5s0qWWj4f1V0LHBWu5C02H8NMzR6rUIuCLh4iDGvAmqq9EyNgIEEasKbGUgCKJVxdclFjoT/x+AW8BGz9xi2aOTVZ67ShXJTs29uFmRmEogYFSJz7cmFhjGTHV0b2Hg9aJEV2QHvfFWYphkyBlPAv85axLxftUwqm4Fe3gCgrAiKUiG523ZgdCpSYq8lXAldqalJ6hOUKfLABDqtwB5ZgSZaKSFymeWJ5bJsF6JMTR8hPUh78qLnthwfbTLdZpY484sQpB18QW9cIdu9HeAXjIEp8F/Ji//Tb2qNagaSc6I+kYyrK68UEjJTj6fduAte3li5IjVfkFrDUBXZ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5m1Kfsjf2QMLy2vTxDBfiBVN2R8gU44D8SRgH0zsjak=;
 b=m/BNcEITG9fMAPPOkDA+ggavHiHd6a57D4I2SLg7sSheXbfYaBfb/WUBV2J23+MibUOBcQ8JdtMkDmV3yRLlkNrbX4+D6Y9qQig1N1jOVWYBkxtxYuSFdft8tXsJkLZE+kzK+d1WESBcpj+MkHtj87iFqA+w9sorR06z09YPOKDhCSRCDAC9qlXlTAG3xt5DYSHMPdb9fqRy6OLj9fO5yzlGA9UANbkwoK0jo7JOnMsMUlNPHzwack7pEv3n3O3dWAfXD6vuL5kXZ0QiMUxcTIiY8wUlW7Cc2VOkNmkoMXlxEdVUxNm1ltOymBSL/JmDUDoy8DXrLNOfxZ7pPZZStQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5m1Kfsjf2QMLy2vTxDBfiBVN2R8gU44D8SRgH0zsjak=;
 b=POGkgWfO/UecheHJtdSvLbZeJ91B0lSUMMO0MMV8bDwmOrKVF4kbtQ1/Gmd7woNTeCgVwz//h1GQuqKkn7DZzRsccbz12BIiTjdMApatN1O3TvbWZ5Mx+53mGZECMMRbrYGx3uVOjiHJ9H4Go5kAaxuWLY2jbmXPPGRfLwNwRYA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CO6PR12MB5458.namprd12.prod.outlook.com (2603:10b6:5:35b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Mon, 2 Oct
 2023 14:05:02 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 14:05:01 +0000
Message-ID: <29d92a79-cfc5-41f1-b930-8789ad17fdda@amd.com>
Date:   Mon, 2 Oct 2023 09:04:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] ACPI: x86: s2idle: Switch to use
 acpi_evaluate_dsm_typed()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
References: <20231002135218.2602969-1-andriy.shevchenko@linux.intel.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231002135218.2602969-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0064.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CO6PR12MB5458:EE_
X-MS-Office365-Filtering-Correlation-Id: 64395cc4-5481-496d-414d-08dbc3509205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5AeRBW6q5nF7gFghzcfrHSw/s/u2gvI4EH/nE8+3Ja5gj7a/yzreeTTRn68wD3lDmdsKfKuYBvrVtgmEaz17+GkKsbmolP1cvBugCCu/Z2j7MiE1Xky4Ndb2YoQ7muVxYQi0zTdMzVK/65sPIU/bTKfqfrER0IveN7k5rYYUy2ObnVo8ahQMNz275ep/P2tew3xq9Tyh0iKYnTykJt+H/yHiiHIGv8dE7d6WMExX4zgvfyVdCJytPkmsNSJ3sVWAIrCY14y45uvrNCuQSYDAwdwuS10wVAucXlztCkqkE+Y8u/Fu5ZdfDLxwtRKgpyfZspakDt3hkhEk+1SJ+AXI6REIU0SOUxnHQv2u00AjCN1hfEd6xIyFLfoccCoE/Y4bNjY3cMryFN6dOG+VBeHuowp5l7G9GPfmcxHXMz/iDoCpi9EiJqD+HzASTJK1jfCwoy5YC6jvkTXPbFR3+GfLphOZgSvJLM2s3iythFTT+ckAWbZcsg5m+5w90zOxUCfz9Qk+smFDfP0kM5EuoV0Utz0NDNmv1EuJfGTbT+xl3LN/AQzYDvw3312IKaaHZCX4Ph01B/AIcyQZDF4TS6FKeJFasyVjCPaoHe2MU3QY3XQVAefRzooio50UEPyfipmyz/R6J2rXk6O95GP2ZziNYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(36756003)(31686004)(44832011)(5660300002)(31696002)(4326008)(83380400001)(41300700001)(26005)(2616005)(8676002)(6512007)(53546011)(6666004)(8936002)(6506007)(6486002)(86362001)(110136005)(478600001)(66556008)(2906002)(54906003)(38100700002)(316002)(66946007)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTFQelpubG1yTFBiSFhrMHFoTWJUWlVxdEFxNHdGOGJrZENSNEJaMzZGOTRL?=
 =?utf-8?B?TTBMclQ0MTQ3WjVmZlJpS203YXdMbTF3NWpUanRRSWM0ZUIwNkRUYWgxYm9N?=
 =?utf-8?B?UTZOcEZxNlBtMklTc29KcXNmYVdOYTJuc3ZSMWl1S1JvV2ROMm52dmRhWEt2?=
 =?utf-8?B?dm1zK1BZVEVOM3ZJZ1dVZFNacmRWRGdMNzE5QS8veWs5ekxPVmp6d0c2cFN5?=
 =?utf-8?B?a0lGK1NibEIvWUlJSm0vRk9xa1ZYN0JnQkhpMnVhOTJvaHN6d3VyeGtkbU9I?=
 =?utf-8?B?UGFqSHV2eWhYdWJ2cnFJdE1zaHhwRjZlT2Q0aFpsVnNubWpya0d2ME05OGY0?=
 =?utf-8?B?YSs1bUU3MEJFRkRFZDA0QnpydnMralVQYm9xb3VvZkFsR2ZKQWNaSm9Oa1VR?=
 =?utf-8?B?M3NobEtnbFpFa3FPeEFKdDFUMGVFT0xVTHZ4enlweEVTTlhXNmtSaUV6UmZH?=
 =?utf-8?B?UkRVN1FvMlBGTlBlVEhBTWNqVDdJdVZkNm5VeHRxMWkwK2ZYcEhSQVNvd3Fi?=
 =?utf-8?B?MmJ0djAyeTlveFBPVFQ5TXNReXlHQTMwdHR1ZndNazNlWVFMbzcxZVNINVhK?=
 =?utf-8?B?d3ZOem1iNVhPVTZrQmtBY3gyRHFXZGVOb29HQ1N6OUVuOU1jZ0ZZRlpSeGs2?=
 =?utf-8?B?cHFSZXZMdDdQWlM4K0N4OElBUnJhWlowdDh0S0ZYSU5iRGhzaWxxY1J5dlNj?=
 =?utf-8?B?QUVrdVRHM08yWXZEeGRPVFFINTgvYzdyWjVCUElmTTJHRmJtd00vam5EUUdL?=
 =?utf-8?B?ZDNVT01lbnJ3WmxjS1Y5Z09Xa0ZmblE5SVhjL2RPM1lpNnRNSFd0L3M4YWhE?=
 =?utf-8?B?emR5YVY5VUZybE1nWWVtUVk5Ukowei9oUEpTVm5zM0d5NU5QdG90dkJYYXEx?=
 =?utf-8?B?WXVLUnkxc2FvNi93Rm1samM2dWFLSXBEZ1lSUUVacnl0R1ZCVFdMNElYckEw?=
 =?utf-8?B?VjZuOEJxa0pUQ3RxVjA0aDdvTTA0aUZTdkh2QVY4eDhCbDRVaG5IMHVNMkZQ?=
 =?utf-8?B?TEpDaU53aU0yVlg4ZVNHbzBWRlRSMnJmd2dDUlVWd2VkWVRoYXRCYXBjeUha?=
 =?utf-8?B?UEg0c2NMVzlnSUhmMHhTUzc2UFcrTHJiV1lHZ0dvdnRTeXRrMFMydmhUcklx?=
 =?utf-8?B?UVZOeU9nd0xuOE9MNTJIamdEMDFXbjk3VlAwMmIrWVpwckxUNkIwcS9mR2ZL?=
 =?utf-8?B?Wk8rOXJ0WFBDZTVCU0ZNYUxnOGhCdkxHVzVpeXBpalE3djlUUCt0YXE2N1gr?=
 =?utf-8?B?NWRSV0U0OGtNVGNCSUZ4dlkweHhuR0QrOTVNK2c5NXo3MnRQSGd3T2k1MDR5?=
 =?utf-8?B?WmVJK0ZSYm1YSnhrMW1ZZVJvR3RvZ0ptb0NNamNkczV0aTBnQkcxS1RoaTlK?=
 =?utf-8?B?N0dvandwaUpTZUpyVlR0MmNtRHpuK3NjSlJoeEFqUnYwR1hJbzhlVzZ4TEMw?=
 =?utf-8?B?S3hzQ2gvNDIrN3R2Rlh5K0ZYb0JOdDcvUlM5UytGa3FzMzkrTW0vOVNNMUdt?=
 =?utf-8?B?bE1KZ2x0T1VKYS9ORGFkRzdHOXVOYUJiYXNEMzB2V2JzdmVXOG85T21BVER6?=
 =?utf-8?B?emdaK2ZzMWN0QllLNU9vVUN2WXBIaEtZSVUvWWJRWExDeG9KeU5hMWNhWVpa?=
 =?utf-8?B?Z0NnRmdRajRMUUdoQStpaEp5dFBtWkUzUWlqR0VLQlp1L3ZPdU9BWmNiOTlW?=
 =?utf-8?B?Z3NXbDdpRUNXaktJOStrR0VrbENqdVlOR2NiS05SWitGRWU5amhyaEdtYXRL?=
 =?utf-8?B?azBnczh1WmU1MkJTZXFaa09RV2UxRDhNZElES05FVUg4WDNFN3hUUVhsWVBF?=
 =?utf-8?B?bUMyU0l2TlordS9aMno5Y3k2QXJqVWcxYXJXRGVOK2NreVZlYVY1bktIU1FT?=
 =?utf-8?B?aFV5ODRla0RpemZURHJWN3BCeWozemhxYlVrVHpkdUprRk41SkJLeXpVWXNm?=
 =?utf-8?B?VVZOMUM5N05yajlrYWVLck1ab3Z6WUErdm5aWXArME5MQ3lKRGlpTFdueEk2?=
 =?utf-8?B?QXlKMzk1S3A4cU5YaHVnY3p1TzRKbGtleTFSaTR0TDk3UlVwMDVURmd2dStp?=
 =?utf-8?B?NCtqcGlJY2hQbjBpZUFyaVEvMUNnTy9YSkt4bVNScWxqN21KclU5cG5SczQ4?=
 =?utf-8?Q?hvj7aHHhb8SGT/AHbzNG/k91l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64395cc4-5481-496d-414d-08dbc3509205
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 14:05:01.9412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wcgln3EDOCv87DEldX/k5ymGC3Vkl37jkZzhT9RxHlNB/BMTxy7ikU6zHw8X8xG8jckAfDxfmU3Ej8vaz13eQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5458
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/2023 08:52, Andy Shevchenko wrote:
> The acpi_evaluate_dsm_typed() provides a way to check the type of the
> object evaluated by _DSM call. Use it instead of open coded variant.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/acpi/x86/s2idle.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 08f7c6708206..7d64e655f1b8 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -417,11 +417,10 @@ static int validate_dsm(acpi_handle handle, const char *uuid, int rev, guid_t *d
>   	int ret = -EINVAL;
>   
>   	guid_parse(uuid, dsm_guid);
> -	obj = acpi_evaluate_dsm(handle, dsm_guid, rev, 0, NULL);
>   
>   	/* Check if the _DSM is present and as expected. */
> -	if (!obj || obj->type != ACPI_TYPE_BUFFER || obj->buffer.length == 0 ||
> -	    obj->buffer.length > sizeof(u32)) {
> +	obj = acpi_evaluate_dsm_typed(handle, dsm_guid, rev, 0, NULL, ACPI_TYPE_BUFFER);
> +	if (!obj || obj->buffer.length == 0 || obj->buffer.length > sizeof(u32)) {
>   		acpi_handle_debug(handle,
>   				"_DSM UUID %s rev %d function 0 evaluation failed\n", uuid, rev);
>   		goto out;

