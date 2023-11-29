Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744757FDF4F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 19:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjK2S3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 13:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjK2S3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 13:29:18 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6A3111;
        Wed, 29 Nov 2023 10:29:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmy6V29JecQjH9DUbBWLFUwI3+XBmYzjrGy3y1Ky0E9q0h6k5QXPDqW4jfiUxsGpXnDTybllGXDXXKGjfkUsRGCOrA4tiK4AqkyoV1sC8k+acX24QtUU3cuLeYTFBnLJonK2gReadiqwfGIWkx5We//Ha9dDsUrddVSZcT2IuWOx/5iSd9RknPXjGzJ8bPQiN2oeK61CruxypRTBJedekLi9jZ7dyw8FguYlaWRysLMgC1Ou0/skz7E9F3s+BjTlxw18vBgIQU8NWWuKzAVfxGUtL23PjefMhsutO5vB6k4L8nygq+eYuYGkWqUKcZj0Maij7GPN/pPAQC/r6xuILw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAj9A0pS/RN3NxF/wWzy6OWBsZQlJ6qt/eNQBJIg5go=;
 b=GV8QzsJZkj+9yjPtq22V1yM8B50SrMQMBJp4OTjexP8NlHG2mXeDsA0gDCmN51UI07HyBurtsucneNnrRs05NJ1nf9eDJuQD0gB9NiPr4NczdFemHHTlsFAldt+a+IuvCQI7hqPS4FoqhGEcpYTfFQ8llxeWzy/oau1D0HTlyF7ANxgSC0tQbeCeBTJAoscg2ee6yRj67ZqSZpomAYRoaDmwbAQyYkSVlRT8CP5zM47AcKox/61Mopt/JpWXeSXMNpJ+nJxbvC2fiV4UrBZ4DGqci6ztdPXFo1MHz9zA/nCUd18FF4SQD3BS36Oib54+IcCRco7OJNTlHrpHXNxFTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAj9A0pS/RN3NxF/wWzy6OWBsZQlJ6qt/eNQBJIg5go=;
 b=qEQRHdvtGQzVBIpT0zDdsx5wHi9QpjH3a1KYz0VLT1rNneRhyJplrrum9LiSK9ShCBpZdrGm5BACOTrGpoKHavaKbSRyzvLb3paE2476J49g8TMIzU0bqYtqbTxfpEOTtV1b+s2bBoYS2xuBDPrSnB5VHHxeDVxQyHdXg3J8QpY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by SA1PR12MB7295.namprd12.prod.outlook.com (2603:10b6:806:2b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 18:29:18 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::e2:9f06:b82e:9a0f]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::e2:9f06:b82e:9a0f%3]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 18:29:18 +0000
Message-ID: <c09243d9-b725-49b0-a6ac-163d015ff441@amd.com>
Date:   Wed, 29 Nov 2023 12:29:16 -0600
User-Agent: Mozilla Thunderbird
Subject: [RESEND v2] ACPI: APEI: Skip initialization of GHES_ASSIST structures
 for Machine Check Architecture
Content-Language: en-US
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, bp@alien8.de, linux-kernel@vger.kernel.org,
        yazen.ghannam@amd.com, Avadhut Naik <avadhut.naik@amd.com>
References: <20231106201340.434878-1-avadhut.naik@amd.com>
From:   Avadhut Naik <avadnaik@amd.com>
In-Reply-To: <20231106201340.434878-1-avadhut.naik@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR08CA0041.namprd08.prod.outlook.com
 (2603:10b6:4:60::30) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|SA1PR12MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b90468-465e-4fad-b8a8-08dbf10918ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pX5a8qrz9Twf0A3Ea6zhYuS9LCnLUtKhz0kuM66sCjNdCC2V/bEpsIB9Htq9fkehWEi125PVbQ4LKW/xppaAzrp69qWsUiasQFYYPPFnSQVnqDHHX7fFZmLWpvw9xjd9JF5EfsmRg/87krvqPRFeBTy8OHL8XCf+r6r3ahMTRXWiirroDqkF5ZbM9nx0q5UmN0Ob8OzG6ST50IhwAJBsPMuHCTTP6Sf8gR4oTE+FHTLmuyY7bHLsKt9mUmnHOUdEGQfP8lBw2XTtDGet6LYcM9KKmKXg8c4jeFiZmdmr7WwOB2ei02HMJ8pCC9eRPL/HNK3tomIey82Pk4gZFOPI+6fR8grsjdVs9kQCwC7BMIssjbDEvOUdcb3/8yI+T+DCra5lX9/cOZ5nwepJvMwoERxz4VhMWRNk+MJzW3iOlWMX0ehbPNI0V2oBtgtg55WtvygOwNxJXypOFJmuxOxzluRXDLN2EOdAXfmKdZKyPP4PfCAKegZRggTwjQMPd7ZHI9HHbzNe19LXCVbiUjlUjzAo3WCa3ne+chpHPmZnucUz+UzofuDcJDV+bM08ZSSFnHfERu92TkzkhuY+recLU0p5f1S0uSCjzhMQY/6sRnhhl34Wogd5u9Q+5QEkpurY1u6usBbFcvQz1oiWNxuphBS0d0YjgmI2t/FJqre1TGdwP4oIDo8Kp6kvgXKg5K9OcAmU6pI3tVZDOpkucRf1WA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(31686004)(478600001)(2616005)(26005)(6512007)(38100700002)(36756003)(31696002)(83380400001)(41300700001)(2906002)(53546011)(5660300002)(6506007)(66556008)(66476007)(316002)(4326008)(6916009)(8676002)(66946007)(8936002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkkrM2p4ejJXS0p5bUxLZzlEczk5QlRsT3h5U3dGOFlNWVNGWk5Gc2JHaW9r?=
 =?utf-8?B?Z1JVcmpCSnlOWExna3ZWVHdXU1dNUk9mNFFPMzZ2REdaa1QyL1ZFZE1oYmR5?=
 =?utf-8?B?NUhCSHQ4NU5RVFppYTU5VUthV2duSDN2N21Bd2hZRDVTcWYrVDZXTVozVDFj?=
 =?utf-8?B?ZnVSQWRjWUFwMVhlZFREOTgrcGRnOC9qUkdUZDdEb3lXdFU5MnhGMnkyUEts?=
 =?utf-8?B?QjY0ZHBsZDNLUGxCaGNYdVJVdysyVlFRRFZBR3k0L0Izc0NqQjdabi9oalRZ?=
 =?utf-8?B?ZjRnV2MzM2JiejNHSFJsOUFzZ1FhNmdTR0twbWhaMFhsOXRvcmpVSGRXZnVu?=
 =?utf-8?B?bE1nd09VWGhKdmhKNnNpUGJhZGhJcGFRUzhkbjdZc2krMFhCNFlUS28zUXhy?=
 =?utf-8?B?cFhyVnZyd3Z1YzRmb3A5dXM1Ym5hdWtWMUwyUFprdjVSWWJVeEF2eXcxUTlT?=
 =?utf-8?B?eXI4Qlp0b3FDMHVqeHF5UEFISEo4bnpHbzl6OHZEYW1YOStKMndpODdUaytK?=
 =?utf-8?B?d1ZRUTh4UmtwUGFqcUhlZTVpaXduTnFCblFRSVNGY0VTUUt3M29vK3ZmNnpO?=
 =?utf-8?B?eXFHV3NlNCtTZ0d1eVN1NVNMNU00NHl5MEFyQ3ZCL1JlTktSc01pODYwTkMw?=
 =?utf-8?B?ejhlTVhtMWVXQTM3Y0VkUEd3OHNlbU1YeHNQV1pXNmNPUjdlYUJIcnU3eVM0?=
 =?utf-8?B?ellGVlFHSTZBNEhjUWJCOWV1UExsOXpVUmkwaEVSMFg2T3dPVFZWbzgrOVMz?=
 =?utf-8?B?OFBDRXV3K3RYaGhBMkxGVk9GS2JoK1U3UXBmNFI0NGZiMFZLWTV5SWIyYm02?=
 =?utf-8?B?L2g2bjlpa05GNkc4cnowcUw0VkdXL0NvZXdZMjlNNG1Pdk5sbmNLWjlPV0dv?=
 =?utf-8?B?MDkrK0hBK2hoS1VkbU1DZm16T1ZGYTE2RVYzMng0TzRDWGhkdk9KQnE5YzZL?=
 =?utf-8?B?Yi9hNEdmWEhiYUIyeTA4OHJnKzI3RWV5U28xMUpzajNQNm5jL0ttTzJTZDNH?=
 =?utf-8?B?TUY1ZVNCdVpWdFpabEJONnB6V0MxNWtrTjVLT2psVDIzN3JqT2NPWmVscjhp?=
 =?utf-8?B?a1ZsS1h5VkdVckl3bWFmVVQwdHRwV3lxSEk0YWh6VkpxNHpOU0Z1MVJYS01n?=
 =?utf-8?B?SHI0b0FMbXluU1RMS2VpdHZLd1ZManUyOWVSdlpLLzdJZzRyWWo3MGtILy91?=
 =?utf-8?B?REFHRzZKNGdoMnFIOE5GTTRDUk10bU9KUnhaVFQzU2daTEsyWVpqdnRFOFpC?=
 =?utf-8?B?dWN6K1hGUldtMjI5REVncmpJZkJCSjA0OWVmYTd3MmlDR3hnRGhvZkIvRUY2?=
 =?utf-8?B?K2E2RU5YbmhVaXVIeERUTURzeHQ3RWoyS2h2SzNnZzExeG05aFNINmtiRENF?=
 =?utf-8?B?WWRsbXdlVkpjdkgyUFlzQ1k2b3UwRlNMaDR0dFV1cmVUV2E1bU83NVh0V0NF?=
 =?utf-8?B?NEMrdGp3Mzk0a0tySGpJTGhWZncwbURQczMxbXVieGcvNmE3MjQvakFHN20z?=
 =?utf-8?B?NVVXWEJVRnBzR1kwQ1BwcXpTcFBqTi93TjhVZ0VPamdyWFkyNTQrTGVCZWNq?=
 =?utf-8?B?VDJKeWU1VG8veFlFMm83eXB3ZHJmS1B0MGowbmdTUVJtL0xzVVdUOFBkeFhl?=
 =?utf-8?B?aDhiK0g5SzVWUEQ5MitRZzJObHRtenJLME1BYkI5dnRobWwvb3dUWE5TSnBK?=
 =?utf-8?B?Y3FzYVdGalk5alZ6dTgvMmw4K1NCT2NNQ2t3U0N4YzBQeGpUUEExQmtrOGlF?=
 =?utf-8?B?WmRtVHlUd3NmYnA3aFJEWkZwbWlNMzliMnY3bHFYMXFTeG1aN1ZCb2FiVFcz?=
 =?utf-8?B?dmZQeHF3U0F4UHVPNE9xOEhCOUtaczYybjliVnZxSHFnVm9RSkQ5QXhOcnpU?=
 =?utf-8?B?SGRkNDhLeTFOVU5LamdvQnJTdTUrQ0NndmFVUWhNTUNxek9lZEgvajJ3Nkoy?=
 =?utf-8?B?TXpDYWFIaGZlSUVFRThqTmRUV29ZZkF2UEhjUEtKR2VDeU5uaGZEWjMwUFhL?=
 =?utf-8?B?aEJIc3kxamc3WFpEcjJzM2EvNG4wbUlQaHpyT2Uvd284OUdRbys0V3l2eGJT?=
 =?utf-8?B?cU5OdGFQbWJNNW1EdXhPeGtxRUJzNUp4ZWtBalpuWXRDaitjWUdBVUVqWTl3?=
 =?utf-8?Q?xRT7+O3Rv7Mi1NxcThXstIVnX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b90468-465e-4fad-b8a8-08dbf10918ea
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 18:29:17.9553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVeGyhoOKaVuMEj+aoHJ2qX5gZHC59b5lxFq9a/tM7x8cOOC3TBUjtlm8gUyem5I6ejLOHErrvgTCMVYscVKcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7295
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Any further feedback on this patch?

On 11/6/2023 14:13, Avadhut Naik wrote:
> To support GHES_ASSIST on Machine Check Architecture (MCA) error sources,
> a set of GHES structures is provided by the system firmware for each MCA
> error source. Each of these sets consists of a GHES structure for each MCA
> bank on each logical CPU, with all structures of a set sharing a common
> Related Source ID, equal to the Source ID of one of the MCA error source
> structures.[1] On SOCs with large core counts, this typically equates to
> tens of thousands of GHES_ASSIST structures for MCA under
> "/sys/bus/platform/drivers/GHES".
> 
> Support for GHES_ASSIST however, hasn't been implemented in the kernel. As
> such, the information provided through these structures is not consumed by
> Linux. Moreover, these GHES_ASSIST structures for MCA, which are supposed
> to provide supplemental information in context of an error reported by
> hardware, are setup as independent error sources by the kernel during HEST
> initialization.
> 
> Additionally, if the Type field of the Notification structure, associated
> with these GHES_ASSIST structures for MCA, is set to Polled, the kernel
> sets up a timer for each individual structure. The duration of the timer
> is derived from the Poll Interval field of the Notification structure. On
> SOCs with high core counts, this will result in tens of thousands of
> timers expiring periodically causing unnecessary preemptions and wastage
> of CPU cycles. The problem will particularly intensify if Poll Interval
> duration is not sufficiently high.
> 
> Since GHES_ASSIST support is not present in kernel, skip initialization
> of GHES_ASSIST structures for MCA to eliminate their performance impact.
> 
> [1] ACPI specification 6.5, section 18.7
> 
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> Changes in v2:
> 1.	Since is_ghes_assist_struct() returns if any of the conditions is hit
> if-else-if chain is redundant. Replace it with just if statements.
> 2.	Fix formatting errors.
> 3.	Add Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/acpi/apei/hest.c | 51 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
> index 6aef1ee5e1bd..99db7621adb7 100644
> --- a/drivers/acpi/apei/hest.c
> +++ b/drivers/acpi/apei/hest.c
> @@ -37,6 +37,20 @@ EXPORT_SYMBOL_GPL(hest_disable);
>  
>  static struct acpi_table_hest *__read_mostly hest_tab;
>  
> +/*
> + * Since GHES_ASSIST is not supported, skip initialization
> + * of GHES_ASSIST structures for MCA.
> + * During HEST parsing, detected MCA error sources are cached.
> + * Flags and Source Id fields from these cached values are
> + * then referred to determine if the encountered GHES_ASSIST
> + * structure should be initialized.
> + */
> +static struct {
> +	struct acpi_hest_ia_corrected *cmc;
> +	struct acpi_hest_ia_machine_check *mc;
> +	struct acpi_hest_ia_deferred_check *dmc;
> +} mces;
> +
>  static const int hest_esrc_len_tab[ACPI_HEST_TYPE_RESERVED] = {
>  	[ACPI_HEST_TYPE_IA32_CHECK] = -1,	/* need further calculation */
>  	[ACPI_HEST_TYPE_IA32_CORRECTED_CHECK] = -1,
> @@ -70,22 +84,54 @@ static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
>  		cmc = (struct acpi_hest_ia_corrected *)hest_hdr;
>  		len = sizeof(*cmc) + cmc->num_hardware_banks *
>  			sizeof(struct acpi_hest_ia_error_bank);
> +		mces.cmc = cmc;
>  	} else if (hest_type == ACPI_HEST_TYPE_IA32_CHECK) {
>  		struct acpi_hest_ia_machine_check *mc;
>  		mc = (struct acpi_hest_ia_machine_check *)hest_hdr;
>  		len = sizeof(*mc) + mc->num_hardware_banks *
>  			sizeof(struct acpi_hest_ia_error_bank);
> +		mces.mc = mc;
>  	} else if (hest_type == ACPI_HEST_TYPE_IA32_DEFERRED_CHECK) {
>  		struct acpi_hest_ia_deferred_check *mc;
>  		mc = (struct acpi_hest_ia_deferred_check *)hest_hdr;
>  		len = sizeof(*mc) + mc->num_hardware_banks *
>  			sizeof(struct acpi_hest_ia_error_bank);
> +		mces.dmc = mc;
>  	}
>  	BUG_ON(len == -1);
>  
>  	return len;
>  };
>  
> +/*
> + * GHES and GHESv2 structures share the same format, starting from
> + * Source Id and ending in Error Status Block Length (inclusive).
> + */
> +static bool is_ghes_assist_struct(struct acpi_hest_header *hest_hdr)
> +{
> +	struct acpi_hest_generic *ghes;
> +	u16 related_source_id;
> +
> +	if (hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR &&
> +	    hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR_V2)
> +		return false;
> +
> +	ghes = (struct acpi_hest_generic *)hest_hdr;
> +	related_source_id = ghes->related_source_id;
> +
> +	if (mces.cmc && mces.cmc->flags & ACPI_HEST_GHES_ASSIST &&
> +	    related_source_id == mces.cmc->header.source_id)
> +		return true;
> +	if (mces.mc && mces.mc->flags & ACPI_HEST_GHES_ASSIST &&
> +	    related_source_id == mces.mc->header.source_id)
> +		return true;
> +	if (mces.dmc && mces.dmc->flags & ACPI_HEST_GHES_ASSIST &&
> +	    related_source_id == mces.dmc->header.source_id)
> +		return true;
> +
> +	return false;
> +}
> +
>  typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
>  
>  static int apei_hest_parse(apei_hest_func_t func, void *data)
> @@ -114,6 +160,11 @@ static int apei_hest_parse(apei_hest_func_t func, void *data)
>  			return -EINVAL;
>  		}
>  
> +		if (is_ghes_assist_struct(hest_hdr)) {
> +			hest_hdr = (void *)hest_hdr + len;
> +			continue;
> +		}
> +
>  		rc = func(hest_hdr, data);
>  		if (rc)
>  			return rc;

-- 
Thanks,
Avadhut Naik
