Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928057FA397
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbjK0OxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233485AbjK0OxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:53:15 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380D099;
        Mon, 27 Nov 2023 06:53:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yo1XjYwidduNtw1bBZFfKZhNyxvHa/nrDiGkpjf34fiw8nZE6GtUied1B7r1dCTfB+MA50MUR8AkRXnuSA9gTY1LqoFus+TwBJjhjppKl39NhNFzC9TYTtMoqQR+/5bCDDmtTK2aAJ6UvBqs95VpfEQBHoOb0Jqj9kCff562Qw+CG657Umdc7Z7IQqxUtluRZ7oGlIq5KiD59c3IUWSSdU+HLplf7p2wQBznyv1bOvEtl8x7J/ouCUoPRObFth9d7j52I2XUlGt6fQhKCcm7NM1/Gm3BDu0/L58sF/5J489iUMEZmDNn6AvskPKPm1Eh2ThZonvp4xl75itYKG6hnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hImGUN1O63dEaxXud1NH1r3lOdODOx7LPyf9iooXcw=;
 b=Ono8iVTuOSHD0E9t6gb5G1bGnJBiW10UTFMO1yDc5uD0GnaKbPQ5UsYTsNngkQ87E/IUiHORU2LS4MfCRoIOnrNzRwswWMoXtw9leWRXROcqlAbG9e4VbJIkWZCpXkcz6gKPM3JQZxzSv6c4glD4Bu21VY0D2p+c/VzoIjR7nCLA0oJdMJV8TwHOfQeVzo2olJEbqu1zi0hfHnG4Jyc8pzGNe0wWGTl8ukGkls8i0gUoFTWntk88WL93u/lL1fPzGAENKA8nOgLUeUA4QVOP2V92gXg9vv4d0USXKDOSMVUl3wW3zh701vLHhsWBpMa9oXO9f38cMxoCnaTFMVOqTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hImGUN1O63dEaxXud1NH1r3lOdODOx7LPyf9iooXcw=;
 b=U+8Zlqel3I4Zk6vEE3fUCMu1LwWlM00M2SsbTZbxcOhYHfOsrdr6B7xNTg0g5q6hA4IzQwm2eEsPOfzGKdTCpML/e6vcrvB51tlTQvG+G5k3nfIRYAiKxLlx5ECI83TTy1McMgAxJE7svOY2Qh/mAll0+2fl3fyMqBa+KhnVe5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SA1PR12MB8644.namprd12.prod.outlook.com (2603:10b6:806:384::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Mon, 27 Nov
 2023 14:53:18 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a9cf:f8b8:27bd:74d0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a9cf:f8b8:27bd:74d0%3]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 14:53:18 +0000
Message-ID: <27e09418-3201-4908-9ea7-13691f28c664@amd.com>
Date:   Mon, 27 Nov 2023 09:53:17 -0500
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Avadhut.Naik@amd.com, Smita.KoralahalliChannabasappa@amd.com,
        amd-gfx@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 03/20] x86/mce: Use mce_setup() helpers for
 apei_smca_report_x86_error()
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
References: <20231118193248.1296798-1-yazen.ghannam@amd.com>
 <20231118193248.1296798-4-yazen.ghannam@amd.com>
 <20231122182805.GIZV5INdVuBOhbtjOm@fat_crate.local>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20231122182805.GIZV5INdVuBOhbtjOm@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0510.namprd03.prod.outlook.com
 (2603:10b6:408:130::35) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SA1PR12MB8644:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e35cf8b-e242-4705-e0c5-08dbef58978d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FblGqqOxVAC5rsT2o+yyiFTaNVVJtvL6+gHzXbfBoYkjfqNJo85I7oC3s//CFWcGEMAlPTSmQKsWBwbX0yQzZROw8OnOcyjZxkCbVQoTUFyU3iGnzlRpQEqRiM0Kc0z7GF/qIIL3d1u/EvaXjMvtWdFxtF/3WA1dMSG5sA98Jdm8fXiaGZVvLiPyZ94bdw8xxqD0Q7xFYIBCTcL5Qm6GgZJ+NPBEqXOdK8lt2ur2cb7VLB6oqMSVxNafhmWbA4axtJgUl8RArRXhgY8IjmDfquOWRnktIAi3Or5xeKSYY5QRDYIeZUooRbHm6ZSLvZKkILYxe8nB+ZsMcTarC1IlBpZ+9SiqExt0IMc0MjvBkG/aMhqViiSQNl4YbgpWRivNmfJ7dKdzGCMMTCrnquICJt1gsrqt0TsxP0MJjXbampOzOInCrPyHUoC/V+IzxGmPxJNyMKXIJkIzBfqHPr7fYkNOKMXZdyh4BmqKZeRJQUBQUAvHmQf/MENf9VrYy/gj4Ti4OTsjopcKzOELR4ww4ou6mcfp/sYR0NDMGUpM/pdD1jmYlEdffk0OGV90m1nDiXd1yv9hXZXc23rMxmBYCtAYsfDth91/FJ3L3VrwIFYBAbLsv9SqItlzB6ExfgwQ9KFK/HGGQrHcz+fwf+L5Gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(136003)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2616005)(26005)(6506007)(6512007)(53546011)(4326008)(8676002)(8936002)(5660300002)(6486002)(31696002)(44832011)(86362001)(478600001)(316002)(66946007)(66556008)(6916009)(66476007)(38100700002)(31686004)(41300700001)(36756003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TW11YmJKUER6SXVtN1ZCSHJVbU5uN1oyeTJ0YlhzNGF6WEJWODdCTTFhVSt4?=
 =?utf-8?B?SWxZRjY5bUZkK3FqOThML3ZRTFlNRHcvUnhDU2NtTHZPZHNrMDJrTklGVnY1?=
 =?utf-8?B?RWlqQU9XRFErUzllV1ZVcldNWWdNV3FrK0RGNkRIZDM3aFovRXlhc2lTL3dT?=
 =?utf-8?B?NnZPc2M0VHpLdS8zbWF5ejJLTWJiYXJ5czVrMEY0MXAxMkxpK2NqQzVNL3B4?=
 =?utf-8?B?UFBPamFPTjBCTUVBMEhTTHFVbnBJMzQ0eEJ1NjhWcm8xaXpBREY2VDlBUDRs?=
 =?utf-8?B?MnpnOUwrbk1YUHpvam81TEs4bHorYk5jalpHNUg0V1NkSkZnUFVFTnhXUFZ5?=
 =?utf-8?B?M1c3VGdIempHQXN4ejBLa1o1RkZJdEQ0WE9FSmdEa0RlczBhVmVwMnZXenFM?=
 =?utf-8?B?empCSk5TODJqMnRtQ3R3N0w0VWxOck1EbDEwQXB3V1g5cDc4NnFCY2NUcGFs?=
 =?utf-8?B?bFJhdE5iWGdwZDdFNXVmdnFCemN6N1Z4L28rNkozdmFydG5WSFlNK2pySzRq?=
 =?utf-8?B?eTBvWHJMTVFXOFROUTFSZ0hPL3U3MWkvYVZIdStoRWtzTUtJZVRYTzN5dTgr?=
 =?utf-8?B?NS8vQ2U0LzFqTEN3SmkrYjJtVERva3RMWFhwY0lCd29odS82Wm1CM2ZvM25X?=
 =?utf-8?B?d0FhNE5vdWVCRUtWM2tRRHFpL29DczVMeVBwdGEvTlIxUW5CYk5hSWlIWXln?=
 =?utf-8?B?eFdnU1FHdmRXMHk5UFptV2JaVlBzTnNYejRSYlV6OExnbmpuUXowV2FPcnpC?=
 =?utf-8?B?K3ZoNWhjOTZxcGxKNTJPMVFpTGdBNGxoWGtkNHdnOUVJS2puWXlub0VidVVB?=
 =?utf-8?B?M0lVMzFvTXUxYzVkOGZEdFk3THlWTlNSc3B2T2Vxdm9tTTcza210OEpIelhI?=
 =?utf-8?B?eGVkbDZ1YURyaW5sVmNIVkRRZ2N4UkNjTldrd2FFZ2RncWJqelAyb1ZOcjRx?=
 =?utf-8?B?VXBIanIxckV3US93T0NpRG9OdHM3QlZ5TFNUUFd1dFVvYVNvdWt1WnhuNzlR?=
 =?utf-8?B?Q3NBQTRvQkREZUNiN05SaDNBRDFVTEZNYmJaL1pmUEN4NVlQaUlESzJNb2Vk?=
 =?utf-8?B?eU5HT0k5ZG1PZzZNY2JaOGpoQktCQjRjYUQvaVJQdEgzSk02dGluOVZWdk9w?=
 =?utf-8?B?L1MrWHNNbmhycWpQU1NLcjh1VlJpa1BqNzdSeDZmQXk2WnViektlZVRBMWpq?=
 =?utf-8?B?UFBlbk4xQVh0QlZuVU52aitLT2NmK1I2MGh3M3lMbnJHcTU2SmlaM29LYmZm?=
 =?utf-8?B?OW8rQm5IcU9PeHo0Y2FBNUl3ckxLK3RzbEszMnFBMTFLYlg5NWZiMHNUUmlL?=
 =?utf-8?B?VWZ3ZmUwQjdLbW1LTjFVcTVMOHV5QXl5QTJrY20waXc5aHE4bWRhNGtQbEpy?=
 =?utf-8?B?LzNXTndJV2cyMzYzdjdMSy9zRDBPU2pSbkdWS25TL2NDelpYZnpzT3VNdGI0?=
 =?utf-8?B?S1lid2FtQ3BmVG1Uc2IwdzVuSWxOTVNaREtKSUI1a3RaaHZRdFRnVTVKVHdU?=
 =?utf-8?B?dTZMeTlEUEVEbUJpNXJTYmJNci9xNk5wd3BDdlpHN0YvTllWaC84MVNFSi9C?=
 =?utf-8?B?NlJod1M5Vm9HajBYd1lYWktEdVhIRE42cXoxcHVZYVNNN1VXUmNiZ29uQkhk?=
 =?utf-8?B?TjV0ODlXTUZ4YUFHUjE2amg1dWJnMVNSVlo5d3ZWSUQ5WTcwYkJuQjhyQ3o2?=
 =?utf-8?B?RmRXYUpTMUF3aExxMlVNTGNEak9jOWt4c2Y2RnlWYVlOUkgyVjgxbkx1dUVX?=
 =?utf-8?B?RnNTcE5NcktnWm5neG5KWUhMU0VWQTFjTXlOR25hcDhXcnBNdU9ZNHN1QUMz?=
 =?utf-8?B?aEtHTXRpWUZReTBvQ2NCaEJsZnI5L2ZUMjRvVGw3bW14REtDTGF4azZTeHFV?=
 =?utf-8?B?VjNGVVB2UDhvZkVuWDkxNml0QW9OenMvRWwybklsOFZIbWpmK3FIKy95VnVO?=
 =?utf-8?B?bUtQRVh3WEc4ZVlTeXFjY0xLb1B3MUpFSUMzSE9ORDZ6UzZ3bjkzTDU2ZWYv?=
 =?utf-8?B?TjFZNjNvekFKMFRqdHZCVGQyTURhSUpWbDNQQVFCVjQ2amhIWlNxMUlLNmxh?=
 =?utf-8?B?TDVNMi9BRjY4bmFXTUFuUUNEcEYyaVVjMWp1OEswVy9MQ3YwcUFlMUZwK1k2?=
 =?utf-8?Q?Wrn142WBiHmmxxZjiK4fDOqzT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e35cf8b-e242-4705-e0c5-08dbef58978d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 14:53:18.3027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yR7/w7oTv3Cs3BiiL03AZsF/43MZJZ6NengIVt3DGwSlGaMdNEwlIBsx+kTQS/pgW+xtTYMKly8PVA6p/DlyyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8644
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/2023 1:28 PM, Borislav Petkov wrote:
> On Sat, Nov 18, 2023 at 01:32:31PM -0600, Yazen Ghannam wrote:
>> Current AMD systems may report MCA errors using the ACPI Boot Error
>> Record Table (BERT). The BERT entries for MCA errors will be an x86
>> Common Platform Error Record (CPER) with an MSR register context that
>> matches the MCAX/SMCA register space.
>>
>> However, the BERT will not necessarily be processed on the CPU that
>> reported the MCA errors. Therefore, the correct CPU number needs to be
>> determined and the information saved in struct mce.
>>
>> The CPU number is determined by searching all possible CPUs for a Local
>> APIC ID matching the value in the x86 CPER.
> 
> Those below are explaining what the patch does. Not needed here.
> 

Okay, will remove them.

>> Set up the MCA record after searching for a CPU number. If no possible
>> CPU was found, then return early.
>>
>> Gather the global MCA information first, save the found CPU number, then
>> gather the per-CPU information.
> 

Thanks,
Yazen
