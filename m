Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399697CAA50
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbjJPNsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbjJPNrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:47:47 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6CD194;
        Mon, 16 Oct 2023 06:47:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Al7WGIjCXExiiAT2Eu3a7zsw7faTQACiZMDvZY2jGQmxblRl6CC4Neo68EJUi3ldJnSaaI/tGWJSveJS5dCsz6XR/+UlsWisAYLywjnDhO/eArlIKnrU4ecKtg4r2DAnCh6jvVB0pGgAN2E5XaUMs5IxrL6GIj8JMkZioC0oYj9QfIfm0O447+OWjM5yITCGn2eDrYyummFvtQtTWgdVZY33++MfxYBYvlZcY5Zy6NzHaRijqhy/LrC+7lVWgEgJx4aObdyvHGHVrMTsQsSmIUROyLeA3cIBNJFjvjeo0/ppD1IDl4GHHnElJf47KzR69SqBHIaXCdt2e+WpOYVgug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7vOHdMWYFGo6aT+mpV5moR1D5VvVoM2cwMXgSPg0tw=;
 b=d5N4cq1YZRjk5D8nERVVODwoOOguSfyPnZqQcCgXXV6lzDOesiWTVe+NfPr9EZManVz6YTZPGzmQ0x9CEp3VftPScSK0xyleCa4uvhbUdPJC1Purm/pkloxDi0IMuKL+Egm1VntQ016a71iZ5IQmzb6Zqvc+wcnnBwr2xXe43XlLBawfjnZ4320AjqfMp9Hm3SDewZVm3IQMuwTZdumoCMsR8n+6nelr364YqVVLiP0Leq4CV3KwjPdDsxXN+9pJE38n8vyU+WP2orbOL4XJ/oBnOKy+erWtZdN6ns6JGizBn5Nea2fXFaZNHXXWXkdNtVP6WRP4FFr4J1lGlg6lFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7vOHdMWYFGo6aT+mpV5moR1D5VvVoM2cwMXgSPg0tw=;
 b=oPz7FmsPPK4hTC8h0Yv6R6S1lKEHg+6x5mu4npTQLlLxUHO8lm6SrWehEMlxMwk2TerbyU6BR/PlT87Y9aUUUgk4EhqQiq8HzX34KDMFJU1XQRx41NhienEa8C6I1Fyg2JHUqn8rymAJhOOsJ0s2YeSn7pE7EXUgHWQbSqOWDJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CH2PR12MB4293.namprd12.prod.outlook.com (2603:10b6:610:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 16 Oct
 2023 13:47:12 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3043:e5d2:42f4:a231]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3043:e5d2:42f4:a231%7]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 13:47:11 +0000
Message-ID: <f65db953-ebf6-488b-94ac-2bf65d2a982d@amd.com>
Date:   Mon, 16 Oct 2023 09:47:09 -0400
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        avadhut.naik@amd.com, john.allen@amd.com, william.roche@oracle.com
Subject: Re: [PATCH v2 1/2] RAS: Introduce AMD Address Translation Library
To:     Borislav Petkov <bp@alien8.de>
References: <20231005173526.42831-1-yazen.ghannam@amd.com>
 <20231005173526.42831-2-yazen.ghannam@amd.com>
 <20231011173528.GUZSbc4Ag03d9Xastz@fat_crate.local>
Content-Language: en-US
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20231011173528.GUZSbc4Ag03d9Xastz@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0598.namprd03.prod.outlook.com
 (2603:10b6:408:10d::33) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|CH2PR12MB4293:EE_
X-MS-Office365-Filtering-Correlation-Id: c44f1318-8862-483b-6a57-08dbce4e659c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tw1MB1QOrggCFfKBDEPZ2A4tNuAEicrftxZT/HOFbrrpWshnBpOm0CPuf5z4/0IOqdGQx1kfzz7FINxaGYpFt9UOz3kFHqwFZYOQnSvXIhqMGk589GVBk8x/Eb2TaQV+OpPGX1ri1v2Z4x2eChLljkUk6ey2MPDltVU+JFsKCiipy6R35a+vOJeLtKL4f8GlN/oXvhqvjoCMVbqkHoqwYT/7p0OX9HhxCAgFhyE/+Vu9PTScSp/ImKhqJReyO6EWExmhZkKUlk8MAftzFOrNISe5bb64uTlsLI0X1CsyKa/0KetODLQd829vm3y/D/iWqweZOvA+bzZ+IUU9comWWuI3LuZ1bhsZl9PFG8BGDnGd0G29gGGEZK4GyBxnRmpbabdmIukY3ThF/JUysR1sEjAblnHO+rRzfTWbmmR9WWJOmlYNAM/BqteYa8zpQsOOVV+EzEwd6Kjia+KaosnfAM5s5isBuAZIYTbwZwo2CkAR/MpuYy9nYLL5H1ngLGcFna1KAiaVAvp11IQd2clbFWXGzCPJYQVkuOSL867IHqG9YlCE5KPgeJBCEqEKaqJKk3Th6uMDCt/sCXlCJrKCV0NqqP9i8YpxBOIIZcw2sc7VPIWLdsJK8ssbgz1x1R605DGFa8EKVe80TcI+fFvCAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(136003)(366004)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6506007)(2616005)(53546011)(26005)(6512007)(83380400001)(66556008)(8936002)(66946007)(5660300002)(478600001)(8676002)(44832011)(66476007)(4326008)(6916009)(966005)(30864003)(41300700001)(6486002)(316002)(86362001)(36756003)(31696002)(2906002)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHFteXhPaDhVRVNIcklpZEhxWU13Z0hiRU9NVis4QXNtMEQwS3c2NmJyY2lt?=
 =?utf-8?B?U1ZyVTNoWFFPT2V0RWxWVlRtYWhOZlMwdlErYnhVUGlzV3JTbFFROXViTjZV?=
 =?utf-8?B?aWNyRnZhcUE4a3pWdXhlaUZianptNU9ISnRzQ01UZ255bk05WWVNYmxtSG9L?=
 =?utf-8?B?cXJJdUQrMVZicGdOd0ZNdnNQWHdwRE5xdFBPWUZiMUM0a0FRWHd3SEZWaDdB?=
 =?utf-8?B?Zmw3emZjTzM4ZUptcDFKYys3d3R2Q01PR29aME1DcTBmaHFtRWxsaU43MEVW?=
 =?utf-8?B?b0hBUGlGNDF4TEl2YXZra29rK29UTDNLNzVRcGY3dUU1d3Y3QnFQNFVKWDl2?=
 =?utf-8?B?bUh1YUVvVkI1VXE1SHVwNFc4S2owQnoyRktkdlFzNFdjVmM3NEF3NjlvSGJI?=
 =?utf-8?B?c3RHVndUUC9tdXN5c0FGS3FLV1lLVDFGYjlRMnJGV0pxZ01VYlU0MndLQXdx?=
 =?utf-8?B?a3dZakI3ZldwV3ZYbE4rUks5QndTYXhlYW1WM2kxU2UvRFBjcG8wWW4zSGxV?=
 =?utf-8?B?T0NMUGpoVk82NUs0QkF5V1B2Z0lBSzBFSGNEVDYzTTR0Yld2My9Lb01OYzF3?=
 =?utf-8?B?SEtIanpid1lFWDlTMFZZa216c3JwbTJ6MGcxNU9qUFVuSy9MUTNWdDZZbzg2?=
 =?utf-8?B?bG9ad0dWWHNUSDF5RGZRSDB3TllWSEJrck5tTmhxZWptcHZMai84K0t6Zkk3?=
 =?utf-8?B?ZkxNVnJWV2krNGdLUzFOYjlTRFVMQWlVcTZKTEtSK21IQkRZeUg2dDVzZmdy?=
 =?utf-8?B?TnpRTHczWWt2THpuOEh5UWRpakRkRUlNTFJZVnNQcmlzcU11WWRDczlRN1Jw?=
 =?utf-8?B?SmJ5MnJEZEVJd2tMbENXNnF3NXJLTUVBc0pSbDFFVkFDM2FHcW9TblhLcTFW?=
 =?utf-8?B?YUNIWnJrVWVIaS8vbjJFeVlrR2x6SDAwejB5dm9PbE0zNytnQmhGcHUzQXdn?=
 =?utf-8?B?dlJ5QkNWZ2c2RHFBWlBLblhwbS9NaERUdWhhaG5UeGRhanoza0tkU2p1emla?=
 =?utf-8?B?ekdJbXNwRnJxc0N4RGJPY2FDV24zdzZBTWpxQWlaUFZiSkFZR2ExL0txRzFI?=
 =?utf-8?B?VmdYWHZaSXdnbCtOSzdPbHJhYm05OE13Q3AxOThtRm4yRFFTaXdwelJsSitB?=
 =?utf-8?B?QTZmb1VnbE1FREZ2Q0dlM1lLa2U0UU1HY0VITmc4V0NVYllXQk5hMUVVUVhx?=
 =?utf-8?B?b0tZbGRzbE5xTy9NMnNmNExKSFdPdU1ISjI1KzkzemFmbUVaWGdBcVkweXlt?=
 =?utf-8?B?dGRpeTBkY2lvS3VvYzF0UER2K1pEMzlIREJ4U1hSbkhRZ1oycDcxa2NYU2N6?=
 =?utf-8?B?dllNWG1iaWR0aFRIUFBXeUV5ZW5nUUFOSyt4SDBRZm9ZSTZHWG4xaGxvUDdG?=
 =?utf-8?B?Y2lkTjBTNlA3QjBWdjZRazJ2bk94QzgvdUlyYWpDM000M3h6MURSdUlJeXYx?=
 =?utf-8?B?TnpGSDVyZnJGQVlHMjlBQ3VxcVUvMW00OXUxV2UxTjVoVW9NbFQwdHc3VkhR?=
 =?utf-8?B?Q24rWXBYQWFyUlNMWExHZ0EybXZvMThYUm9teGtvWTkvS3ZWNVN1a2hjT3ZI?=
 =?utf-8?B?Um0yTEVsZnpxS3I5UU42RDdQKzVCeTZWbDZwTlhWa2R5dVNkRnlUU0t5ZjdG?=
 =?utf-8?B?UlZpeUtSYk1tTkxWeWFYZnpCajRnQ1lnRVRWRU02ckN2TnN0QTJuaWJrRkh6?=
 =?utf-8?B?Y08vYUhVMGh1SHhENXQ0Q0FwZ0grdm5LRWRsQjNsRGFuZEZyWDZObjFYcWRy?=
 =?utf-8?B?SkVRSktvd3FKendRTkpISHpIanBTaGFaTXRsa2JNbnkrV1dySVVOQWZ5eEl1?=
 =?utf-8?B?V29NelVxZDZrNkhoS3pvV1Evb2I1amVyTFZuOE1qZ0RFQUNkT0NYNEwrajQ1?=
 =?utf-8?B?S0RMS0FTQ2ZhKy9CVFlNOU82YmY2VkZ6QmF0UlVhSzg3NTcvVVdhWUwrN1I4?=
 =?utf-8?B?RXZuSDVrclBuRmJreHFxZ05UVXRJUHZKejNBc2FzeUVjaU5yd2plRytmek9Q?=
 =?utf-8?B?VHdicWVHeGF0ZjVxQUtKY2o3bkNIWGl2RkZ3UytMTTl0TGhjUmJxbDI5YVpZ?=
 =?utf-8?B?NUU1ejljUXROTHZIUkFHU3ovblo5TDY1Sk5zNmpTeFZNb2kxSzNWRzBTSnEv?=
 =?utf-8?Q?ljnWXmXYPlAN9cu5SDTQjLzeD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c44f1318-8862-483b-6a57-08dbce4e659c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 13:47:11.3057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ixVGL+Y71WFAfLMjKZE5yUD8tWEgQRhjgRVN0K+J+AmbcM7ShioYLJJ4CwhkKh8DiPsOgtAoN3UK2Lg6FZpUTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4293
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/23 1:35 PM, Borislav Petkov wrote:
> On Thu, Oct 05, 2023 at 12:35:25PM -0500, Yazen Ghannam wrote:
>> AMD Zen-based systems report memory errors through Machine Check banks
>> representing Unified Memory Controllers (UMCs). The address value
>> reported for DRAM ECC errors is a "normalized address" that is relative
>> to the UMC. This normalized address must be converted to a system
>> physical address to be usable by the OS.
>>
>> Support for this address translation was introduced to the MCA subsystem
>> with Zen1 systems. The code was later moved to the AMD64 EDAC module,
>> since this was the only user of the code at the time.
>>
>> However, there are uses for this translation outside of EDAC. The system
>> physical address can be used in MCA for preemptive page offlining as done
>> in some MCA notifier functions. Also, this translation is needed as the
>> basis of similar functionality needed for some CXL configurations on AMD
>> systems.
>>
>> Introduce a common address translation library that can be used for
>> multiple subsystems including MCA, EDAC, and CXL.
>>
>> Include support for UMC normalized to system physical address
>> translation for current CPU systems.
>>
>> Future development to include:
>> - DF4.5 Non-power-of-2 interleaving modes.
>> - Heterogeneous CPU+GPU system support.
>> - CXL translation support.
>> - Caching of common intermediate values and results.
>> - Leverage UEFI PRM methods as alternate backends to existing native
>>   code.
> 
> That last preview-of-things-to-come paragraph can go. Not needed here.
>

Ack.

>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 35977b269d5e..5a286cb8e7f1 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -891,6 +891,13 @@ Q:	https://patchwork.kernel.org/project/linux-rdma/list/
>>  F:	drivers/infiniband/hw/efa/
>>  F:	include/uapi/rdma/efa-abi.h
>>  
>> +AMD ADDRESS TRANSLATION LIBRARY (ATL)
>> +M:	Yazen Ghannam <Yazen.Ghannam@amd.com>
>> +L:	linux-edac@vger.kernel.org
>> +S:	Supported
> 
> "Maintained" right?
> 
> Otherwise
> 
> ./scripts/get_maintainer.pl -f drivers/ras/amd/atl/access.c
> Yazen Ghannam <Yazen.Ghannam@amd.com> (supporter:AMD ADDRESS TRANSLATION LIBRARY (ATL))
> Tony Luck <tony.luck@intel.com> (maintainer:RAS INFRASTRUCTURE)
> Borislav Petkov <bp@alien8.de> (maintainer:RAS INFRASTRUCTURE)
> 
> I'm not maintaining it. :-P
>

Of course not! :P

I do mean "Supported" though. From the top of MAINTAINERS file:

        S: *Status*, one of the following:
           Supported:   Someone is actually paid to look after this.

>> +#define DF_BROADCAST		0xFF
>> +
>> +#define DF_FICAA_INST_EN	BIT(0)
>> +#define DF_FICAA_REG_NUM	GENMASK(10, 1)
>> +#define DF_FICAA_FUNC_NUM	GENMASK(13, 11)
>> +#define DF_FICAA_INST_ID	GENMASK(23, 16)
>> +
>> +/* Register field changed in new systems. */
> 
> I don't understand that comment.

I'll make it more explicit.

The "REG_NUM" field changed. Please note the slightly different
bitmasks.

> 
>> +#define DF_FICAA_REG_NUM_LEGACY	GENMASK(10, 2)
>> +
>> +static int __df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32 *lo)
>> +{
>> +	u32 ficaa_addr = 0x8C, ficad_addr = 0xB8;
>> +	struct pci_dev *F4;
>> +	int err = -ENODEV;
>> +	u32 ficaa = 0;
>> +
>> +	if (node >= amd_nb_num())
>> +		goto out;
>> +
>> +	F4 = node_to_amd_nb(node)->link;
>> +	if (!F4)
>> +		goto out;
>> +
>> +	/* Enable instance-specific access. */
>> +	if (instance_id != DF_BROADCAST) {
>> +		ficaa |= FIELD_PREP(DF_FICAA_INST_EN, 1);
>> +		ficaa |= FIELD_PREP(DF_FICAA_INST_ID, instance_id);
> 
> Dunno, this is understandable to me:
> 
> 		ficaa |= (DF_FICAA_INST_EN << 1) |
> 			 (DF_FICAA_INST_ID << instance_id);
> 
> All that FIELD_* macro crap not.
> 
> What's the advantage of using them? The additional build checks?
> 

Build checks are one advantage. Another is explicitly defining bitfields
so it's not just shifts and masks that need additional comments.

> The code is a lot less readable with those things IMO.
>

Fair. It took some getting used to, but I've come to prefer the bitops.
I'd like to keep them if you don't mind.

>> +int norm_to_sys_addr(u8 socket_id, u8 die_id, u8 cs_inst_id, u64 *addr)
>> +{
>> +	struct addr_ctx ctx;
>> +
>> +	if (df_cfg.rev == UNKNOWN)
>> +		return -EINVAL;
>> +
>> +	memset(&ctx, 0, sizeof(ctx));
>> +
>> +	/* We start from the normalized address */
>> +	ctx.ret_addr = *addr;
>> +	ctx.inst_id = cs_inst_id;
>> +
>> +	if (determine_node_id(&ctx, socket_id, die_id)) {
>> +		pr_warn("Failed to determine Node ID");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (get_address_map(&ctx)) {
>> +		pr_warn("Failed to get address maps");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (denormalize_address(&ctx)) {
>> +		pr_warn("Failed to denormalize address");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!late_hole_remove(&ctx) && add_base_and_hole(&ctx)) {
>> +		pr_warn("Failed to add DRAM base address and hole");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (dehash_address(&ctx)) {
>> +		pr_warn("Failed to dehash address");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (late_hole_remove(&ctx) && add_base_and_hole(&ctx)) {
>> +		pr_warn("Failed to add DRAM base address and hole");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (addr_over_limit(&ctx)) {
>> +		pr_warn("Calculated address is over limit");
>> +		return -EINVAL;
> 
> All those error messages do not dump the address they failed to process
> and if you have multiple failures, you can't know which address they're
> talking about.
> 
> I think it would be better if you have the respective functions state
> the failure and also dump the relevant address/bits/etc which can help
> the user debug this further. And remove the warns here.
> 
> Then, if the user can't do anything about the error, then you don't need
> to say anything either but simply return -EINVAL from this function and
> the upper layers would simply report the error.
>

Okay, will rework.

>> +	}
>> +
>> +	*addr = ctx.ret_addr;
>> +	return 0;
>> +}
>> +
>> +static void check_for_legacy_df_access(void)
>> +{
>> +	/*
>> +	 * All Zen-based systems before Family 19h use the legacy
>> +	 * DF Indirect Access (FICAA/FICAD) offsets.
>> +	 */
>> +	if (boot_cpu_data.x86 < 0x19) {
>> +		df_cfg.flags.legacy_ficaa = true;
>> +		return;
>> +	}
>> +
>> +	/* All systems after Family 19h use the current offsets. */
>> +	if (boot_cpu_data.x86 > 0x19)
>> +		return;
>> +
>> +	/* Some Family 19h systems use the legacy offsets. */
>> +	switch (boot_cpu_data.x86_model) {
>> +	case 0x00 ... 0x0f:
>> +	case 0x20 ... 0x5f:
>> +	       df_cfg.flags.legacy_ficaa = true;
>> +	}
> 
>> +}
>> +
>> +static int __init amd_atl_init(void)
>> +{
>> +	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
>> +		return -ENODEV;
> 
> That thing should use a MODULE_DEVICE_TABLE with a
> 
> X86_MATCH_VENDOR_FAM(AMD, X86_FAMILY_ANY, ...)
> 
> in it.
>

Is this so it loads independently?

I'm thinking it should only load as a dependency for other modules.

>> +	check_for_legacy_df_access();
>> +
>> +	/*
>> +	 * Not sure if this should return an error code.
>> +	 * That may prevent other modules from loading.
> 
> Why would this prevent other modules from loading?
>

If it fails to load, wouldn't modules that depend on it fail to load?

This is what I thought, but I'll double check.

>> +	 * For now, don't fail out. The translation function
>> +	 * will do a check and return early if the DF revision
>> +	 * is not set.
>> +	 */
>> +	if (get_df_system_info()) {
>> +		pr_warn("Failed to get DF information");
>> +		df_cfg.rev = UNKNOWN;
>> +	}
> 
> No, you want to return an error here and not load the ATL - it is dead
> code.
>

Right, but this goes back to the question above.

EDAC, for example, can still function without this code. It will just be
missing the correct "pfn/offset". This is true on many AMD systems
today.

So should EDAC not load if ATL fails to load? Or is there another way to
decouple them?

>> +	pr_info("AMD Address Translation Library initialized");
>> +	return 0;
>> +}
>> +
>> +static void __exit amd_atl_exit(void)
>> +{
>> +}
>> +
>> +module_init(amd_atl_init);
>> +module_exit(amd_atl_exit);
>> +
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/ras/amd/atl/dehash.c b/drivers/ras/amd/atl/dehash.c
>> new file mode 100644
>> index 000000000000..e501f2e918d7
>> --- /dev/null
>> +++ b/drivers/ras/amd/atl/dehash.c
>> @@ -0,0 +1,459 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * AMD Address Translation Library
>> + *
>> + * dehash.c : Functions to account for hashing bits
>> + *
>> + * Copyright (c) 2023, Advanced Micro Devices, Inc.
>> + * All Rights Reserved.
>> + *
>> + * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
>> + */
>> +
>> +#include "internal.h"
>> +
>> +static int df2_dehash_addr(struct addr_ctx *ctx)
>> +{
>> +	u8 hashed_bit, intlv_bit;
>> +
>> +	/* Assert that interleave bit is 8 or 9. */
>> +	if (ctx->map.intlv_bit_pos != 8 && ctx->map.intlv_bit_pos != 9) {
>> +		pr_warn("%s: Invalid interleave bit: %u",
>> +			__func__, ctx->map.intlv_bit_pos);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Assert that die and socket interleaving are disabled. */
>> +	if (ctx->map.num_intlv_dies > 1) {
>> +		pr_warn("%s: Invalid number of interleave dies: %u",
>> +			__func__, ctx->map.num_intlv_dies);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (ctx->map.num_intlv_sockets > 1) {
>> +		pr_warn("%s: Invalid number of interleave sockets: %u",
>> +			__func__, ctx->map.num_intlv_sockets);
>> +		return -EINVAL;
>> +	}
> 
> That sanity-checking is almost identical and repeated across a bunch of
> functions. Pls carve out into a helper.
>

Ack.

> ...
> 
>> diff --git a/drivers/ras/amd/atl/denormalize.c b/drivers/ras/amd/atl/denormalize.c
>> new file mode 100644
>> index 000000000000..fe1480c8e0d8
>> --- /dev/null
>> +++ b/drivers/ras/amd/atl/denormalize.c
>> @@ -0,0 +1,644 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * AMD Address Translation Library
>> + *
>> + * denormalize.c : Functions to account for interleaving bits
>> + *
>> + * Copyright (c) 2023, Advanced Micro Devices, Inc.
>> + * All Rights Reserved.
>> + *
>> + * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
>> + */
>> +
>> +#include "internal.h"
>> +
>> +/*
>> + * Returns the Destination Fabric ID. This is the first (lowest)
>> + * CS Fabric ID used within a DRAM Address map.
>> + */
>> +static u16 get_dst_fabric_id(struct addr_ctx *ctx)
>> +{
>> +	switch (df_cfg.rev) {
>> +	case DF2:
>> +		return FIELD_GET(DF2_DST_FABRIC_ID, ctx->map.limit);
>> +	case DF3:
>> +		return FIELD_GET(DF3_DST_FABRIC_ID, ctx->map.limit);
>> +	case DF3p5:
>> +		return FIELD_GET(DF3p5_DST_FABRIC_ID, ctx->map.limit);
>> +	case DF4:
>> +		return FIELD_GET(DF4_DST_FABRIC_ID, ctx->map.ctl);
>> +	case DF4p5:
>> +		return FIELD_GET(DF4p5_DST_FABRIC_ID, ctx->map.ctl);
> 
> You can put each case on a single line:
> 
> 	case DF2:	return... ;
> 	case DF3:	return... ;
> 
> and so on.

Ack.

> 
>> +	default:
>> +		ATL_BAD_DF_REV;
> 
> Ew, this is ugly. Make that and ATL_BAD_INTLV_MODE into simple inline
> functions which you can call.
>

Ack.

>> +		return 0;
>> +	}
>> +}
>> +
>> +/*
>> + * Make a contiguous gap in address for N bits starting at bit P.
>> + *
>> + * Example:
>> + * address bits:		[20:0]
>> + * # of interleave bits    (n):	3
>> + * starting interleave bit (p):	8
>> + *
>> + * expanded address bits:	[20+n : n+p][n+p-1 : p][p-1 : 0]
>> + *				[23   :  11][10    : 8][7   : 0]
> 
> Very nice!
>

Thanks!

>> +static u64 make_space_for_cs_id(struct addr_ctx *ctx)
>> +{
>> +	switch (ctx->map.intlv_mode) {
>> +	case NOHASH_2CHAN:
>> +	case NOHASH_4CHAN:
>> +	case NOHASH_8CHAN:
>> +	case NOHASH_16CHAN:
>> +	case NOHASH_32CHAN:
>> +	case DF2_2CHAN_HASH:
>> +		return make_space_for_cs_id_at_intlv_bit(ctx);
>> +
>> +	case DF3_COD4_2CHAN_HASH:
>> +	case DF3_COD2_4CHAN_HASH:
>> +	case DF3_COD1_8CHAN_HASH:
>> +	case DF4_NPS4_2CHAN_HASH:
>> +	case DF4_NPS2_4CHAN_HASH:
>> +	case DF4_NPS1_8CHAN_HASH:
>> +	case DF4p5_NPS4_2CHAN_1K_HASH:
>> +	case DF4p5_NPS4_2CHAN_2K_HASH:
>> +	case DF4p5_NPS2_4CHAN_2K_HASH:
>> +	case DF4p5_NPS1_8CHAN_2K_HASH:
>> +	case DF4p5_NPS1_16CHAN_2K_HASH:
>> +		return make_space_for_cs_id_split_2_1(ctx);
>> +
>> +	case DF4p5_NPS2_4CHAN_1K_HASH:
>> +		//TODO
> 
> As discussed offlist, pls fix those.
>

Ack.

>> +	case DF4p5_NPS1_8CHAN_1K_HASH:
>> +		//TODO
>> +	case DF4p5_NPS1_16CHAN_1K_HASH:
>> +		//TODO
>> +	default:
>> +		ATL_BAD_INTLV_MODE(ctx->map.intlv_mode);
>> +		return ~0ULL;
>> +	}
>> +}
>> +
> 
> ...
> 
>> +static u16 get_cs_id_df4(struct addr_ctx *ctx)
>> +{
>> +	/*
>> +	 * Start with the original component mask and the number of interleave
>> +	 * bits for the channels in this map.
>> +	 */
>> +	u8 num_intlv_bits = ilog2(ctx->map.num_intlv_chan);
>> +	u16 mask = df_cfg.component_id_mask;
>> +
>> +	u16 socket_bits;
>> +
>> +	/* Set the derived CS ID to the input CS Fabric ID. */
>> +	u16 cs_id = ctx->cs_fabric_id & mask;
>> +
>> +	/*
>> +	 * Subtract the "base" Destination Fabric ID.
>> +	 * This accounts for systems with disabled Coherent Stations.
>> +	 */
>> +	cs_id -= get_dst_fabric_id(ctx) & mask;
>> +
>> +	/*
>> +	 * Generate and use a new mask based on the number of bits
>> +	 * needed for channel interleaving in this map.
>> +	 */
>> +	mask = GENMASK(num_intlv_bits - 1, 0);
>> +	cs_id &= mask;
>> +
>> +	/* Done if socket interleaving is not enabled. */
>> +	if (ctx->map.num_intlv_sockets <= 1)
>> +		return cs_id;
>> +
>> +	/*
>> +	 * Figure out how many bits are needed for the number of
>> +	 * interleaved sockets. And shift the derived CS ID to account
>> +	 * for these.
>> +	 */
>> +	num_intlv_bits = ilog2(ctx->map.num_intlv_sockets);
>> +	cs_id <<= num_intlv_bits;
>> +
>> +	/* Generate a new mask for the socket interleaving bits. */
>> +	mask = GENMASK(num_intlv_bits - 1, 0);
>> +
>> +	/* Get the socket interleave bits from the original CS Fabric ID. */
>> +	socket_bits = (ctx->cs_fabric_id & df_cfg.socket_id_mask) >> df_cfg.socket_id_shift;
>> +
>> +	/* Apply the appropriate socket bits to the derived CS ID. */
>> +	cs_id |= socket_bits & mask;
>> +
>> +	return cs_id;
>> +}
> 
> Those are some good comments above, cool.
>

Thanks!

>> +
>> +/*
>> + * Derive the correct CS ID that represents the interleave bits
>> + * used within the system physical address. This accounts for the
>> + * interleave mode, number of interleaved channels/dies/sockets, and
>> + * other system/mode-specific bit swizzling.
> 
>     * Returns: ... on success.
>     	       ... on error.

Will add.

> 
> ...
> 
> 
>> diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
>> new file mode 100644
>> index 000000000000..f3888c8fd02d
>> --- /dev/null
>> +++ b/drivers/ras/amd/atl/internal.h
>> @@ -0,0 +1,307 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * AMD Address Translation Library
>> + *
>> + * internal.h : Helper functions and common defines
>> + *
>> + * Copyright (c) 2023, Advanced Micro Devices, Inc.
>> + * All Rights Reserved.
>> + *
>> + * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
>> + */
>> +
>> +#ifndef __AMD_ATL_INTERNAL_H__
>> +#define __AMD_ATL_INTERNAL_H__
>> +
>> +#include <asm/amd_nb.h>
>> +
>> +#include <linux/amd-atl.h>
> 
> Is this file in the linux/ namespace because of CXL which is somewhere
> in drivers?
>

Yes. The intention is to allow any code to use this "library" including
arch code like MCA.

>> +#include <linux/bitfield.h>
>> +#include <linux/bitops.h>
>> +
>> +#include "reg_fields.h"
> 
> Include namespaces are in that order:
> 
> 	linux/
> 	asm/
> 	"internal"
> 

Ack.

>> +
>> +/* Maximum possible number of Coherent Stations within a single Data Fabric. */
>> +#define MAX_CS_CHANNELS			32
>> +
>> +/* PCI IDs for Genoa DF Function 0. */
>> +#define DF_FUNC0_ID_GENOA		0x14AD1022
> 
> Genoa is an internal name - pls use Zen4 or so. Change "genoa_quirk"
> too.
> 

Genoa is a public name for a particular Server model group. And the
quirk applies to that group. It doesn't apply to other Zen4 systems like
Client models, etc.

But I agree the names can be more generic. I'll change them to describe
the quirk rather than name a model group.

>> +
>> +/* Shift needed for adjusting register values to true values. */
>> +#define DF_DRAM_BASE_LIMIT_LSB		28
>> +
>> +/*
>> + * Glossary of acronyms used in address translation for Zen-based systems
>> + *
>> + * CCM		= Cache Coherent Moderator
>> + * COD		= Cluster-on-Die
>> + * CS		= Coherent Station
>> + * DF		= Data Fabric
> 
> We have edac.rst for such things.
>

Sure, but I don't understand.

Should these be moved to edac.rst? This code isn't part of EDAC.

Or are you suggesting that this new "library" should have a
Documentation/ entry?

> ...
> 
>> +/*
>> + * Make a gap in 'data' that is 'num_bits' long starting at 'bit_num.
>> + * e.g. data		= 11111111'b
>> + *	bit_num		= 3
>> + *	num_bits	= 2
>> + *	result		= 1111100111'b
>> + */
>> +static inline u64 expand_bits(u8 bit_num, u8 num_bits, u64 data)
>> +{
>> +	u64 temp1, temp2;
>> +
>> +	/*
>> +	 * Return the orginal data if the "space" needed is '0'.
> 
> "original".
> 
> Run through spellchecker pls.
>

Ack.

>> +	 * This helps avoid the need to check for '0' at each
>> +	 * caller.
>> +	 */
>> +	if (!num_bits)
>> +		return data;
>> +
>> +	if (!bit_num)
>> +		return data << num_bits;
>> +
>> +	temp1 = data & GENMASK_ULL(bit_num - 1, 0);
>> +
>> +	temp2 = data & GENMASK_ULL(63, bit_num);
>> +	temp2 <<= num_bits;
>> +
>> +	return temp1 | temp2;
>> +}
>> +
> 
> ...
> 
>> +/*
>> + * Some, but not all, cases have asserts.
>> + * So use return values to indicate failure where needed.
>> + */
>> +static int get_intlv_mode(struct addr_ctx *ctx)
>> +{
>> +	switch (df_cfg.rev) {
>> +	case DF2:
>> +		return df2_get_intlv_mode(ctx);
>> +	case DF3:
>> +		return df3_get_intlv_mode(ctx);
>> +	case DF3p5:
>> +		return df3p5_get_intlv_mode(ctx);
>> +	case DF4:
>> +		return df4_get_intlv_mode(ctx);
>> +	case DF4p5:
>> +		return df4p5_get_intlv_mode(ctx);
> 
> Put each case on a single line.
>

Ack.

>> +	default:
>> +		ATL_BAD_DF_REV;
>> +		return -EINVAL;
>> +	}
>> +}
> 
> 
> ...
> 
>> +static int get_dram_addr_map(struct addr_ctx *ctx)
>> +{
>> +	switch (df_cfg.rev) {
>> +	case DF2:
>> +		return df2_get_dram_addr_map(ctx);
>> +	case DF3:
>> +	case DF3p5:
>> +		return df3_get_dram_addr_map(ctx);
>> +	case DF4:
>> +		return df4_get_dram_addr_map(ctx);
>> +	case DF4p5:
>> +		return df4p5_get_dram_addr_map(ctx);
> 
> Also on single line.
>

Ack.

>> +	default:
>> +		ATL_BAD_DF_REV;
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static int lookup_cs_fabric_id(struct addr_ctx *ctx)
>> +{
>> +	u32 reg;
>> +
>> +	/* Read D18F0x50 (FabricBlockInstanceInformation3). */
>> +	if (df_indirect_read_instance(ctx->node_id, 0, 0x50, ctx->inst_id, &reg))
>> +		return -EINVAL;
>> +
>> +	if (df_cfg.rev < DF4p5)
>> +		ctx->cs_fabric_id = FIELD_GET(DF2_CS_FABRIC_ID, reg);
>> +	else
>> +		ctx->cs_fabric_id = FIELD_GET(DF4p5_CS_FABRIC_ID, reg);
>> +
>> +	return 0;
>> +}
>> +
>> +static int get_cs_fabric_id(struct addr_ctx *ctx)
>> +{
>> +	/* TODO: Add special path for DF3.5 heterogeneous systems. */
> 
> No TODOs - you return an error for unsupported systems until that
> support comes.
>

Ack.

>> +	return lookup_cs_fabric_id(ctx);
>> +}
> 
> ...
> 
>> +int get_address_map(struct addr_ctx *ctx)
>> +{
>> +	int ret = 0;
>> +
>> +	/* TODO: Add special path for DF3.5 heterogeneous systems. */
> 
> Ditto.
>

Ack.

>> +	ret = get_address_map_common(ctx);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (get_global_map_data(ctx))
>> +		return -EINVAL;
>> +
>> +	dump_address_map(&ctx->map);
>> +
>> +	return ret;
>> +}
> 
> ...
> 
> ...
> 
>> diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
>> new file mode 100644
>> index 000000000000..80030db6b8a5
>> --- /dev/null
>> +++ b/drivers/ras/amd/atl/umc.c
>> @@ -0,0 +1,53 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * AMD Address Translation Library
>> + *
>> + * umc.c : Unified Memory Controller (UMC) topology helpers
>> + *
>> + * Copyright (c) 2023, Advanced Micro Devices, Inc.
>> + * All Rights Reserved.
>> + *
>> + * Author: Yazen Ghannam <Yazen.Ghannam@amd.com>
>> + */
>> +
>> +#include "internal.h"
>> +
>> +static u8 get_socket_id(struct mce *m)
>> +{
>> +	return m->socketid;
>> +}
> 
> Looks useless.
> 
>> +
>> +static u8 get_die_id(struct mce *m)
>> +{
>> +	/*
>> +	 * For CPUs, this is the AMD Node ID modulo the number
>> +	 * of AMD Nodes per socket.
>> +	 */
>> +	return topology_die_id(m->extcpu) % amd_get_nodes_per_socket();
>> +}
>> +
>> +static u64 get_norm_addr(struct mce *m)
>> +{
>> +	return m->addr;
>> +}
> 
> Ditto.
>

These are stubbed out because they get expanded for the GPU code. I
originally had it coded together to see how it all fits.

I'll remove these for now, and add them back when needed.

>> +
>> +#define UMC_CHANNEL_NUM	GENMASK(31, 20)
>> +static u8 get_cs_inst_id(struct mce *m)
>> +{
>> +	return FIELD_GET(UMC_CHANNEL_NUM, m->ipid);
>> +}
>> +
>> +int umc_mca_addr_to_sys_addr(struct mce *m, u64 *sys_addr)
>> +{
>> +	u8 cs_inst_id = get_cs_inst_id(m);
>> +	u8 socket_id = get_socket_id(m);
>> +	u64 addr = get_norm_addr(m);
>> +	u8 die_id = get_die_id(m);
>> +
>> +	if (norm_to_sys_addr(socket_id, die_id, cs_inst_id, &addr))
>> +		return -EINVAL;
>> +
>> +	*sys_addr = addr;
>> +	return 0;
>> +}
> 
> PA 0 is an invalid address, right?
>
> So can this function return 0 on error or the actual PA on success so
> that you don't need the IO *sys_addr argument?
> 

No, PA 0 is a valid address. The physical memory map (at least on x86)
starts at 0.

We can still get hardware errors for address 0 even though it's part of
a reserved space. These could be found by patrol scrubbers, etc.

>> +EXPORT_SYMBOL_GPL(umc_mca_addr_to_sys_addr);
> 
> That's an AMD-specific function so:
> 
> 	amd_convert_mca_addr_to_sys_addr();
> 
> with a verb in the name and so on.
>

Ack.

Thanks,
Yazen
