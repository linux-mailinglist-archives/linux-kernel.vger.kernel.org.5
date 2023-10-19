Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEC27D0322
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 22:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346535AbjJSU03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 16:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346397AbjJSU01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 16:26:27 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C161C124
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 13:26:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrx9VIuMciJZ7ZmkQBEH5icsBya8EsS2PNWcNttVoSiVsUB9yRZloiBU36/Ytddug2Bir3ytEzl2Ehva+Ue+FG3pOinOZ6zPbaSIp+9fgKclr4r8P/TawAEqImYT2EY2xhGYAriWRDGO2ggCWuJFUE8BCvtTX2DC/dzJl/pjbwD78NnFGaz/bGQdUC0EurvgygxjN5S/wNMRo1ubwpamoEL0SGp0/GeZhh5re9DV5YIONEywIp33DOrwsqGGw5GpK7iHRav6TxnaGFvTAfl75wiTCIdFmLKAeNJApHE3ING/gYlHFhhIHbTozMCHxn3ianLrrKD0gF9OVDAwEUU7qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGbuspQFTvZlqu1vedPItV4EQRrWV1GnlQmhigIGeE0=;
 b=lQCh8qebi2fKui1mFbfF8664L6rHoyiS72RKhNpAs7VsCxO/9kUUaAKGwEJRdvdmBwlS6Tbfg42DHHcHmq1VHtaH9WLaMgrpDVblHWLMNVZIN4oQQly3qZ7Ix1ijcx6+TKa/0oECRwVxPlnAOQ8ZKQ6vLMQFq3/DP0ykoO3yS685/0KEhPoy8py1C9fOSPY2Qg1J4/Gzopo2Xkm01iCd2TWK4OBcOfYLAxLRtefl+T2o2+RQYXsUsIRjMCeaEDSujk6mOZTxpdarDSm9gbUzfKq5Maq59xr/ZgtX5V+cfQUcxCa6iL8kYg/zFHVw5jz56oOW/cji+ZXOjs2PZIE/LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGbuspQFTvZlqu1vedPItV4EQRrWV1GnlQmhigIGeE0=;
 b=2EMPEehHktID2o+1FEAdkbNQg5Nz+/4+na7e080sWAiqyj1xi3Q87PFWv06x67O7IESIy2B+Rk+caMxqS1/QOcVLivYMEiLx2Dr2mUPSaM2R//LghC6nT5cs69nkQrxYRS2lr7UEawqtGtQVjbFOPnsKbmv4Cde+cuqWGgIfQwY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB8279.namprd12.prod.outlook.com (2603:10b6:208:40c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Thu, 19 Oct
 2023 20:26:20 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 20:26:20 +0000
Message-ID: <3d96c70e-da3b-49c2-a776-930a9f1b815d@amd.com>
Date:   Thu, 19 Oct 2023 15:26:12 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     x86@kernel.org, David Woodhouse <dwmw@amazon.co.uk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Gong, Richard" <Richard.Gong@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Michael Kelley <mikelley@microsoft.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Helge Deller <deller@gmx.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
Subject: X86 parallel bring up regression
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0051.namprd04.prod.outlook.com
 (2603:10b6:806:120::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: a7af2e4d-8c04-470e-f33b-08dbd0e1a497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cBTpqTqVYRqRgepWo5lDoK5qTJyuGTGP68BWTJPt4p+BatKDeUlkiFV8WdVLq1TK6x/dL/hhsVz0No5vfnuKDwsA/eYMk70dNDMPOKRJyr9OXxgIpJYq7ECbvHiSh4e6E2F3MoRvzp5gk1sWSP2fwpN0EEWLgZCzX/7e7ByHM/yOjpGh0ZxIiOHwzP63hXp/rYpCrGTpRkY1Zr+kmhyddyjip9g5T3oaRdik5vHXJOh3Tyvuh4AudhlKGxX7g3dK+jqxibbmu2a/omebfU5LH4H6xxxPpctnV/lr5/OQMD6cWa2pFV/iwZiMwRx3kEmfKhZB0MZXSadLNVtmQzBvMcFWVrsYzI5KPG6YDo/lEpWvYclTivtXWyKKyol6gxhdgbLylDrQa2LaU3MdlshwKSeHACVVLQdxZtINMM7k88ie46giGSTeKXhzb8EM57DN2rqGrkXBd6v/3ykoLXH5B74snopMDdKOsklTA9KC9m2WQlGuqu1meAHHBjZbWT7FImJYrR2xHDQ+402021Ewz2K394fw32jp8ue9HZkOqjF1Cb6BkiL4m1LXzxkEwqcaYGckSZ1EwpmPg+SjGOJuVIyYEJawPNepWVSDQaik5qzZeY9uVjwuilNgnRh+dhBENOvVCBGTU+Ea0Ru/92huXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(376002)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(31686004)(36756003)(54906003)(66556008)(31696002)(38100700002)(6512007)(66946007)(6916009)(86362001)(83380400001)(966005)(316002)(8936002)(2616005)(26005)(6666004)(6506007)(6486002)(8676002)(66476007)(41300700001)(2906002)(5660300002)(44832011)(4326008)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnFnSUtTVW04YVlkcUtDanNlamNlbnJFT2tydlBlZEpEODZoMS9mQ29WNW5B?=
 =?utf-8?B?Z3E5ekQxdFpGNlgyWER5TGJFelgyQnRvQUpOR3FrZHJZZ3loZmhrVDBtRUZq?=
 =?utf-8?B?a0gwa1NQZGd2ZE9jMXdidUhrNHFaL01oMW1Obm1EMHdubmpaYi9MQjBOTGFh?=
 =?utf-8?B?N3gwVGI0d05BQmpaRWtOS2lPejhtbDRwa0RnSmlkK3hURVgvVXd2VytRUXQ1?=
 =?utf-8?B?TU1TVHRzdHVuQ0FvTTFlN1pRaHo2bWRmOE13NWNxY3EyeWtlZndUdFd1QlFn?=
 =?utf-8?B?QUdPRkxzSjkyNHRpVnloT3VuZ096MmVTUXNMV0VCeWdaL05walhwNUg2bFo4?=
 =?utf-8?B?dGJEZWRTeXlFMkVXaDdjZTkvRzM2SmNTMy90ZmU1YmdvQzhQeWNwNDlSbXg5?=
 =?utf-8?B?QVdJV0ViQjhuZWdsNHpFcnpjYjZkY3hQWUlDY0dkREdPNVZBdVZVSFVGdUd2?=
 =?utf-8?B?ZklLZk9RUWxrc01KcUJIMXNYQnoyL2FVblZ0NUtIR0FoWDVMbDRDd0UrUUZH?=
 =?utf-8?B?NDVVK2lyNzRLblpRTTVQK2lDV3dGRFBDRVU4NEZnY0Yxb3pLTzNkM3RnNEdn?=
 =?utf-8?B?LzRVYXNEUzloZ0FmQ0hKTFFzalpQdDN0ZEtGbUM1b1ltVGNTaGViYmIwUFNK?=
 =?utf-8?B?RVZSNFBaSzEwK1NZTWxrYTZoWkhMWmZUOW03U1BKNFJXVCs5VTc3V0xRZHVp?=
 =?utf-8?B?dFV1cDRuQmJMNVVoVkNKZUdabHpTME0wbGVYamJVU3VZdHIzUjY2cHhxZTI4?=
 =?utf-8?B?WHpVRS96Szh5d0ZrbFQ4b0pVVzdxczNIUUxEV1d0dDJ0K3BXZkFrYXpQbEoy?=
 =?utf-8?B?NkRENkFKZ3llZlBkQUtrUDJCc2RVUUk2aUxZVzFYeHpYeVBkR1kySExJR2U5?=
 =?utf-8?B?VG9NdjY5OVdZeGJ6T1N2V2hYOHdSQjdZbGROTzJ3S0UzdTZxb0kzQWZqYnhM?=
 =?utf-8?B?N3F0WmM4bVo0Z1g4elQ4OU5yUk1FWWdsYXo4MkdrRjdQalFGMnRpQzdnWHVH?=
 =?utf-8?B?dkpxZ2ludEpuSWpCZFhjbWZHbGJKWDU1Z0oyTE9hVjN1RFlSekZTa0hVSHVW?=
 =?utf-8?B?MUZqNDZvZnl5UFphb2Zyc2tlb0JmUldINkRFYVJpaDdUVTBHalk4cXE1Vko2?=
 =?utf-8?B?L3lBbi9FdWY4ZGZDZTcwekMvcUZVT3pZWElzRmhrQUtHa0NvaTREN3IyWDV5?=
 =?utf-8?B?T1pNamx4a21VNWRxYVdHdlBFYmhIek1TY3VXTUdhRkVmWGNSRHp1dHRtNEEv?=
 =?utf-8?B?WVBPeVV5cWJDRmpjbmhDd2dwcVRBNWxYd1FvYkQwZ21FSWxaZ0gyWVFJYUxB?=
 =?utf-8?B?RWNKV01kK3hCK0ZrbG5ORDg2b2JXaTVNRkRFWjlxT2UwWEl6U0c3S2swNDBE?=
 =?utf-8?B?OGdrdFl5ak1lOWNNc3pGaVZjV2t4Z2UySzZwU0grcHk2d1RaSm5teW5UUDdx?=
 =?utf-8?B?dmJKeG4xU1JhUm9MOUFxc2NQdGJSa3VzaTl6eCsrSmI3ZmxFSmhUZ2lJMWhL?=
 =?utf-8?B?bkl5RTJVcUpqcUtKb254UXp3Q290ajVsRzIvQ0FaQ2lDd1BTclIvZ0xUb2NL?=
 =?utf-8?B?WEhhT3BwUWVBSEk4OUF1QThxcmhsRSt6TGQ2VHRzcXdVQVRlMUlHZmRFL2Fk?=
 =?utf-8?B?NXk2Vlc3djl6cFJRanBhUWlTem5pUFc5aDQ5NTBid29YSlZYVU1aRlo3ckx4?=
 =?utf-8?B?bUw3aU9HbXlOQUIrVkxmTHlyUDlGWW01WkNsYXVtVmwycitwVExZVXdYT3cx?=
 =?utf-8?B?ZThXZ3hVRUlPRDRwS2NXV1RQUkk4L3N5QUVrV0RqbW9qWSs1Y3ZSazIxdW90?=
 =?utf-8?B?TzRnK3pkSEdYbDBlbDl4YXZJcVc2blhQam9aRmx0bjJkbkxqTnQxdHV2Q2l6?=
 =?utf-8?B?Z2JralMyYUkwMUtaZWRhNGM0d2o4eDRsaUhTdDRNemlNdTVFSDd6dFltWSt2?=
 =?utf-8?B?NWFyU3RwaGc3ckM2a1V3LytVNVdXOHRoclBVbUlQRWxIbWhtSktyeGd0dkJ3?=
 =?utf-8?B?dUFmdndyZVBOQ0JVQzh1SW9jdGloV2pQa2F0OG5DSkJxeXNyN1dSUVVJQzVN?=
 =?utf-8?B?d1duUjRLS2RGaWh0Nk1vMkZiWkFhVUhmditqTUtEbEY1ZityVWpNTzhVQXI5?=
 =?utf-8?Q?GwM0AqzL6enyJBDmCMuHTocJD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7af2e4d-8c04-470e-f33b-08dbd0e1a497
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 20:26:20.2697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdMDz3JYdxluE3rDrDyZe/mQXKfVOUcAovDdezGnw8c5KAjulAFRsj7AfonPLhA+dURvbU3aM5K/pLB6370ajA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8279
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We've recently found that there was a regression from 6.5 that broke 
resume from suspend-to-ram on some AMD platforms.

We bisected it and confirmed it's introduced by 0c7ffa32dbd6 
("x86/smpboot/64: Implement arch_cpuhp_init_parallel_bringup() and 
enable it").

Furthermore; we confirmed that on 6.6-rc6 adding cpuhp.parallel=0 to the 
kernel command line avoids the issue.

Here are bootup kernel logs from an affected system at 7e75178 (doesn't 
reproduce) and 0c7ffa32 (does reproduce).
https://gist.github.com/superm1/c251c0849956b8389309f03871fba091

Is it possible that this is caused by the system entering S3 with x2apic 
enabled but leaving with it disabled?

I notice in the resume path on a boot with cpuhp.parallel=0 that x2apic 
"explicitly" gets turned on again.

<snip>
smpboot: CPU 127 is now offline
ACPI: PM: Low-level resume complete
ACPI: PM: Restoring platform NVS memory
x2apic enabled
AMD-Vi: Virtual APIC enabled
AMD-Vi: Virtual APIC enabled
LVT offset 0 assigned for vector 0x400
Enabling non-boot CPUs ...
smpboot: Booting Node 0 Processor 1 APIC 0x2
masked ExtINT on CPU#1
ACPI: \_SB_.PLTF.C002: Found 2 idle states
CPU1 is up
smpboot: Booting Node 0 Processor 2 APIC 0x4
</snip>

I hypothesize this could be caused by .Lread_apicid finding x2apic 
disabled but then trying to read from apic_mmio_base which isn't 
initialized because x2apic was used (AFAICT apic_set_fixmap() never gets 
called in this case).

Thanks,
