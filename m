Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB5B7D836B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345040AbjJZNVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344950AbjJZNVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:21:37 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D368D91;
        Thu, 26 Oct 2023 06:21:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7AFm+wwwlmdFE55ArFdJjy9c8sywqF9iCMiC1PamViPUCzbL9UXkssTvPibqAerREM/P0Bd7Q5R2UjpBra1BtnYqlWD2jDxsxRTcWJwFqd63AT8/G99Kii9T7CJunS/MisSRarjXVHfj9k695GV+tAfWhxA2gqiLb1h62vvcmlxvT4jGJMxdCMnkggsNjA/RuSlVdsFG6oJ3Vh6KH5004CqYnj80WkdrwJMEm/rJsS3USnKmE4+4d4KBsZLZjF7Ez1HQJlgTTGCpa1Qd92oGcG+14Ef0mNAHlukPbbH7O1YzAZOpkH4Mc9HUGz5bYnJ9UAIVz64aqTyJ8ijWIZziw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVgt6reCIz9emC0mNBLoJ2DMXxYc9itsOL9G/kP+Lew=;
 b=feCTNeW6LPT1zUULT7DCGao2wel95Qa2nR/LbL1MAwK7zzkD8U8iPkngE1CndzjuwfXKLXb4p28Jz4p52E2BBzl/QqUrDjqPvIvGZMyKnrGapPn0Rl6Cots1xTg3pr3HMtDgUV5SocBHI3qEdTfQadKFsDdJPEPN4jM1oPRcHowzOB2LLv/+/M7OHmBlXOq7gT5cREA8t2OXvFtbD6K8mlhZp3f+uFdjVbhMdmmqbCzH3q8AOfN8ucJorD389a7OCk6kG02/BRwe+pdu5ozR5QEnRpyKuX+MOiYPgYCC97uTMHGsKQbTStUKlb1yW2hUORrUdhm7rbjwDle68Gy1YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVgt6reCIz9emC0mNBLoJ2DMXxYc9itsOL9G/kP+Lew=;
 b=yb1DAw41yc+hlSsOufS3vPY/ci4GGcXcPyb/ZF6y4md88C216+jKlH8HPvnTS5qV7SHMq/5hKyUipvZbprcuM2A/zSdXAN55q36daP+W1euayZQ9WnB0EwQiHsuFaMCU/H2ZFULGspHUjR3rHmyEb+wgtlLUR+uaiyF6hwsosKw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by IA1PR12MB6308.namprd12.prod.outlook.com (2603:10b6:208:3e4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Thu, 26 Oct
 2023 13:21:32 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9799:80fa:a7de:cbb1]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9799:80fa:a7de:cbb1%4]) with mapi id 15.20.6933.019; Thu, 26 Oct 2023
 13:21:32 +0000
Message-ID: <04a9185e-070e-48fb-ae54-65bf63dd1ed1@amd.com>
Date:   Thu, 26 Oct 2023 09:21:29 -0400
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com, linux-kernel@vger.kernel.org, bp@alien8.de,
        mchehab@kernel.org, Muralidhara M K <muralidhara.mk@amd.com>
Subject: Re: [PATCH 0/7] Address Translation support for MI200 and MI300
 models
To:     Muralidhara M K <muralimk@amd.com>, linux-edac@vger.kernel.org,
        x86@kernel.org
References: <20231025073339.630093-1-muralimk@amd.com>
Content-Language: en-US
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20231025073339.630093-1-muralimk@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR16CA0020.namprd16.prod.outlook.com
 (2603:10b6:408:4c::33) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|IA1PR12MB6308:EE_
X-MS-Office365-Filtering-Correlation-Id: 56499a20-3f6c-466f-1139-08dbd626787b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9TCILGajS9t/m+ViyDw66DRs1v4WNykg3wkmmQ7YzeKkZ2EfJ5Xd8E8QbD6rlbZrzjNmtvi7Cru3UOWjmKgxckJXKCLu8TrUJSPXhlwNkpYPGyZILZXGTk0ebGb1m7Svr8n9dNalFwfa+5q7/4NPIAN/A51tIqAhC/UQOR4h7Ax0PyKafeQcErn5oXHyQ+akY3e9n3gjjRLkSKUCL7qjbSF7Th9Agz5jDx0+WTXG1gDDfC8/bjC7N0mkaeZzGWKlWyhWWjXyKzsed32FDOhTDR83JHhraVugfj5nhhfefrFBC459DCY/OysE+m6XvVJc1SDshlXjFooZbw970RQCqdruxw8k1kKBZSf/iMjgS9ApvWNxS8tmWuhjPRyALVVtKpu5g3xZoopQZn6NYfsL+cUuE94omA1gMvhaHd+veOq6DtEpUQtACoujty7MdNmOwX9XZu1XqDRXI5juS4R0zZW+gkTpmJ0D9QzonUnoRW0C4yh1MV2gIpu4OXEnkSqmsUR5T8QSOnIL57JF5H8UfD75UhVZ+yQvyUhFghlb9GRHCiwRBu+0e0IYizSK5x0duyMRwDqCb/21fAiRRpa70WEOhadLL322QwqU3H6RXWkWOCI8sToJImUy/ZU5cT+dgoEkR8YgwvVPeuiGp49z/hjQ/Db7jx86CpuN2qoUU9w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(366004)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(966005)(6486002)(4326008)(8676002)(8936002)(53546011)(66476007)(66556008)(66946007)(2616005)(6506007)(478600001)(31686004)(6666004)(83380400001)(26005)(316002)(6512007)(44832011)(41300700001)(5660300002)(2906002)(38100700002)(86362001)(31696002)(36756003)(170073001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUlTbG03K1I0cDNON1Z6bi9vOUpKOHU2cGNVdHJYaWw5d0w1RUU5NVNkdXlP?=
 =?utf-8?B?ODJXRFZ2UFFzTmFZNGNjQWVYdzZhVXdvMFZqQStPNEoramdXV25QRFZhT00z?=
 =?utf-8?B?WFZsQldQbFVWMWNWV2tGSmJoeC9NVXZlSElhSEhYbmJqVzdmbkNEMzNJbGx6?=
 =?utf-8?B?eUxMVC9hdDV6U2dFU0VnN0UyczJ1ZXF0Q0tMRFFLZ245WUdqcTJxTXZhdGpU?=
 =?utf-8?B?aWNwU0tPMzBEVjA3SlhLdGVEYytMMEZpOVRaU2N5aEQwNlF6NkpyM2Q0alFG?=
 =?utf-8?B?U0FPOTA0dFVLdFJvUUpJakpiRlNmVFRmOWtDTitTSmRsSWh6dU9DeEUvNU1w?=
 =?utf-8?B?K3hzbXlFR29QUkxXYTZBMGtoU08vUEgrTm0yUVE1R0U0c1BVcTNRWldqNmg2?=
 =?utf-8?B?bmVwbVViVUUreG14OGZUanNLOWt4Mll0TS81SnExbVpMZThsRnE3OTBlUE1F?=
 =?utf-8?B?OHZWeFJPMVFRVmNTckVpZGZqZGQvYjZaWGFMTXVxbWdWT3VyVWRDWDY5SlVr?=
 =?utf-8?B?em5rRWUzbWlyallxc3hlblBoaS9pT0pDOEprMXd0eGlMVDJidjYyOWFaMVpa?=
 =?utf-8?B?NTdhR3FmZDVIWDJtTXN3Qm9OTDJyQU1rN09FWmZRZTBRdXBKbGxEMVA0STRT?=
 =?utf-8?B?aTFYVm5iN205elNjU1dscHNHK044RWE2aXJPVzVlZDIvR2dKNDNPc2tPYUI4?=
 =?utf-8?B?dmhCMXR6TkFBb2thV0lCYlQzdFJuQk9MT1dYaUlPamRJS1VUR0R2SnRTTnlM?=
 =?utf-8?B?SDdjNGRRbEh2RVNPUXhKTXhaQUx6VmUvbDRaMUQ4NW5WUzFFMktXaXVFUWZ3?=
 =?utf-8?B?TjdSSnRMbFU4Q0IwRFBkOUxBT3F3SmpnV0h4eUF0eHVWVTJIUExjNDZIUmFG?=
 =?utf-8?B?c2djeFZNYzVuM3FNam1YWXJXblJIdXYyanlWTkY0cUJqVDNKU3Vuc1Znek1B?=
 =?utf-8?B?VDVYd3c4ak1aanBpT3NsTTE5NEdlQ1ZvQThxMzArWjdVcHlrbjg5Y0g5VkRk?=
 =?utf-8?B?UG0rempzNDdVTG5KVjZGc1BIUFRLdVdrVGxsM3BoejVnejFBWm9kUXJKbFUr?=
 =?utf-8?B?VkRGUDR0d3dhdmovSW9BVzhoTEhTOHNLSDhjSnlPUVJuM284U3hKMTdPaGRZ?=
 =?utf-8?B?Zms5NjJ6YXZlNk9RV003b1lZZHExSHpTcDVyQWxMWTg3NmxrNVJzSUkwNkZ3?=
 =?utf-8?B?TzJ5SENZTU5ab0U0UnAvNXFNdHUzQll4U25oaFpQVzNBa2Q3UkxRTnQzZVBU?=
 =?utf-8?B?NEhyZWdBU1NuL25HZDZpcWVxbHkyK3BCWVhQS2IySVNFOU5FdzdTS1NrRVQ3?=
 =?utf-8?B?M3p0RWpPTGVnTU04Q28vS01tZjVidlZNbTE3RXMvL1BDd1BUYjhYZzJGdnFv?=
 =?utf-8?B?aGgwelNqK0dSMnZ3aFZzM1IzK0FNUVFMdndhWDFZRzhnb3hTdUhsanRRb0Mv?=
 =?utf-8?B?MVIwTUVFdEhBc0RFWGo3NUVTUUk5L0E5S0JWS3lpa3Y1a3hiQTRWd3MycFBO?=
 =?utf-8?B?YUdKM1BYK2M0WElpMlJyMFlOSDhrdUNiZWxRY1JPeGU0K0ZmNHB2TitXL3VH?=
 =?utf-8?B?NUdsVWNZMW5UMTVScG1vb1d0U0kxSTlIVnc4UVZSamJ3dXlpSktiaytOaXZm?=
 =?utf-8?B?U2NobDZ2eDhCNllEYzRiNGkvNzlrMi9RSDlZOWk1djRyNFpwK0Y2bWxNSkFK?=
 =?utf-8?B?cEJnSDRaTjA5aUdIVGxiM3dYTzZyMGxpc3NGMW9zVWlwU3NZQ0srSkxhR3I3?=
 =?utf-8?B?YnJkWTdPcUlORHVIWEpJTmUxMjNuZkFXYXhSSldxQnVVNmFMbVBmVGJzcEEr?=
 =?utf-8?B?WWpOS0NzUldpRnUxcFZzZmYvSVZOVWJXQTNpZjZIOFpuZmo4bm94WnlMcGJH?=
 =?utf-8?B?N3B4RXh4NXc1SzNGeTZtVWJmbVdIRUpLenUrZ0lCUDBFcXNWWWlIdUticVZX?=
 =?utf-8?B?cjRmc3Aycm1QRDRzSjRKWHBmaEQ4UWlhcUtHa0hXcHM4b2pYQjhQYUdBQTFW?=
 =?utf-8?B?bXl5bmFkVXFuVnVDNDlnQlFSdnAvdXdKYlNZd0lIMS8zVFJqTnVKemtvenJS?=
 =?utf-8?B?cUtlemFPWll6d3lZZlJ0aGNhTFFsN2FCanE4eDlyOU1uYTNNQTZSSWhyWlNO?=
 =?utf-8?Q?dxRUVvFBhmVI7CTQ5bpmKY/K2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56499a20-3f6c-466f-1139-08dbd626787b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 13:21:32.4052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VIS/UQkTHo8xgvchqv1a4IoOEB9LHqk068t7hUjl7N0dBPaphfsKeLsaaUk4R4TskLu+EMlttm8WGl7vVRg+CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6308
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/2023 3:33 AM, Muralidhara M K wrote:
> From: Muralidhara M K <muralidhara.mk@amd.com>
> 
> This patchset adds support for MI200 heterogeneous address translation support
> and MI300A address translation support, fixups on HBM3 memory address maps.
> 
> The patch set depends on the Yazen's patches submitted
> "AMD Address Translation Library"
> https://lore.kernel.org/linux-edac/20231005173526.42831-1-yazen.ghannam@amd.com/T/#m4a9ddb63b334f367219ab0002a9a133e891f6aac
> 
> The patchset does following
> 
> Patch 1:
> MI200 heterogeneous address translation support.
> 
> Patch 2:
> MI300 heterogeneous address translation support.
> 
> Patch 3:
> Convert HBM3 MCA Decoded address to Normalized address.
> 
> Patch 4:
> lookup table to get the correct cs instance id for HBM3.
> 
> Patch 5:
> Convert physical cs id to logical cs id by static lookup
> table.
> 
> Patch 6:
> Reading correct bit fields to get cs_fabric_id.

I expect some of these patches to be functionally out of order.

> 
> Patch 7:
> Identify all physical pages in a row to retire all 8 columns
> of pages when the error is injected to avoid future errors.
> 
> 
> Muralidhara M K (7):
>    RAS: Add Address Translation support for MI200
>    RAS: Add Address Translation support for MI300
>    RAS: Add MCA Error address conversion for UMC
>    RAS: Add static lookup table to get CS physical ID
>    RAS: Add fixed Physical to logical CS ID mapping table
>    RAS: Get CS fabirc ID register bit fields
>    EDAC/amd64: RAS: platform/x86/amd: Identify all physical pages in row
> 
>   drivers/edac/amd64_edac.c         |   5 +
>   drivers/ras/amd/atl/core.c        |   5 +-
>   drivers/ras/amd/atl/dehash.c      | 149 ++++++++++++++
>   drivers/ras/amd/atl/denormalize.c | 110 ++++++++++-
>   drivers/ras/amd/atl/internal.h    |  27 ++-
>   drivers/ras/amd/atl/map.c         | 158 ++++++++++++---
>   drivers/ras/amd/atl/reg_fields.h  |  42 +++-
>   drivers/ras/amd/atl/system.c      |   4 +
>   drivers/ras/amd/atl/umc.c         | 309 +++++++++++++++++++++++++++++-
>   include/linux/amd-atl.h           |   2 +
>   10 files changed, 778 insertions(+), 33 deletions(-)
> 

This set doesn't have any changes in arch/x86, so it's not necessary to 
copy the x86 list.

Thanks,
Yazen
