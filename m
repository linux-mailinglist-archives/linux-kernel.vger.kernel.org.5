Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7D97EC9A9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 18:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjKOR2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 12:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjKOR2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 12:28:03 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F1AB6;
        Wed, 15 Nov 2023 09:27:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlZ2lNezt1F3ovWyYQDKDo7AOPOxaOjCEtk/xLKqdTOJCH3uT4hhce2WGVb/vUxrdT3SFMb1WZF0FiBXpzAzHjq/XrXdW/zmqs0lnnmVrTHtFEH66gi4WyP1a+K6sQnVwrZr7UuuFU+uvIp2HyXA9aYRKR6+mNnQ2m5JfVMnd7Y1JaZBlPmI+JhKKztj+ndUjcL5B4d2Lzm2PGCwwCaxhdaBpMTCpE3Oz4Hkdre+kCY5SAAmpM81V828QjMX0zFRqDuL9W0sBFd0Yzp++L3KNHIapYYThlEvklObw/8HdWqQdmUShxTqPZSWOetaJJATb2GinjpTNvvrw18zEdbogQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUOzckBBgim9xTcASjcOFrZoTpwa+q6z3mFgf/3MhPY=;
 b=KTBkLIZsOadODdCO5p9Z3BYzS34oTbcgzQJ1BD08XpiBNMFyL5UYwZG3mLObUWrpUKpO+IMgau0elCw8iMecsV8pwQzFUz01ER2C2yJvIf3GEg4VnmKBA30Ds9dRoVlQMdiPtxUzpeu5JnS/ojvZtzibCcIrj4S2dOOsfXyddxqwAMJ9DS/wRYZWGWUm1EYP5kjZEgEUsAoCtFuLORv/ek1Nhu1tdPf7ZYfbt2ktWASUo5aRrpjPfaF8tzqxnYgxfilM3AKDdkll8wbdgUy9FY7FwAucafillZ+V+YE0EwDRJWrq6Ah5J3GYLN0OA3Daaz2avC7OIWdDQKE73meyOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUOzckBBgim9xTcASjcOFrZoTpwa+q6z3mFgf/3MhPY=;
 b=stZtO3LN6Osf4yKndx/Gwf/GbMuNF017y3Dr6p4vBfbDGKojBBdpQCR6zMn3ZAgfUSGYHVpXL2trMKD+jbpqEQ8OLRsymzI9P54347QNZTp3rTGXGbM2FHEYNGdQ4CjwfCE6WNJw3eSPZgiGk6qRLhk428kjxSPTA1IfBcZRRws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by PH7PR12MB9204.namprd12.prod.outlook.com (2603:10b6:510:2e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Wed, 15 Nov
 2023 17:27:57 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::59d1:c9f5:2c67:1da6]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::59d1:c9f5:2c67:1da6%4]) with mapi id 15.20.7002.019; Wed, 15 Nov 2023
 17:27:57 +0000
Message-ID: <5729c613-182b-43d2-a2ed-caff046b68e7@amd.com>
Date:   Wed, 15 Nov 2023 22:57:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soundwire: amd: add an error code check in
 amd_sdw_clock_stop_exit
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Su Hui <suhui@nfschina.com>, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
References: <20231115095407.1059704-1-suhui@nfschina.com>
 <3e461bb5-fa6b-4729-8ff5-ccc1d2887066@linux.intel.com>
Content-Language: en-US
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <3e461bb5-fa6b-4729-8ff5-ccc1d2887066@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::18) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|PH7PR12MB9204:EE_
X-MS-Office365-Filtering-Correlation-Id: bd11c071-bc58-4898-2fbe-08dbe60034b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OOIOwznjKquhW9/5dq1eYJnuso0k1AFDwB1wQKe+AuHh8fWmKk1srLxfMmO9ewgDnq0W6BdvT9vniTMUmbyXz9PxJhfJeLkmwuziDt2a4NvPewJtMOlJLFQZFcisBGKJ6eb1XwGTr3gPU9IEQjKUyh0/lMhiPQA9C0en1REgvq6LsAGkVKoZlPyzpurgDtAfxNnMkEGLA5W/n/qUuZwbiyKTB0mE05sbkzr6bfTUZQCZWAVCGkgxv3tRmntk2JYY4V9kQZOt0K2PBIkTL1G3fDsW1/u9lCbnMQP0wUU7dC4u/sGQ7Qs5U1VBtIAb6G6l39Ek7Xl9CPyIX4ILKR8zh/Uj43Qsu/joIWQORCZv/FyTEgp7gXTHwpIxl8b91T6BDMf4yjc7SA2GoFB9UegE4u7Zi0C2FARHcmf0QA9YAeFtovbS5vVK+IRNGyJd+3WC0JW4XvDB/DsspQ6M10ba5S5b4e/vpL0bnHTkfCldqOU7SQSAgm2Z9McwvETGUjOa1gJk8Z3i47LUfe00fqBTESF4RDEKl4h6nq8XgRZMX1FUAidPWCfN5M8M+gn39Iv3ql+14FRrsNlNuv+CDgpJ5Cm/2VEBoavywc++694uBL/1cTPjeV+GshYIjzEfsr4/V/+Kxhob6pWkOHK+8lgR5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(366004)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(31696002)(86362001)(110136005)(316002)(66946007)(66556008)(36756003)(66476007)(4326008)(8936002)(8676002)(83380400001)(6666004)(2906002)(26005)(53546011)(41300700001)(6512007)(2616005)(5660300002)(6506007)(31686004)(7416002)(6486002)(478600001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ak5PNm5WYXZ5YXdGb3JZUE85ODE5b3g3MjNjeC9MbVBPVWd3dXk3dFZ5Wmhj?=
 =?utf-8?B?MkV5L0lxeUlSY3N4UTFueVoyd0RFQS91QnJzK2JZZTJ0ODVOT2lKOXJGK0NJ?=
 =?utf-8?B?aG9LRDdQcGFxYmtxeGFjZ2hNb2NPWHVtUVF3aXdqdWY0UXliMHhaQVhrMUQ2?=
 =?utf-8?B?ZmRUT2tQcE1PdThmMTZHS2xDUzlFbUt0elhWSkdCQnl0U2taSkRnRHFuK3Ax?=
 =?utf-8?B?V2lnUDJPc2R6NXJCeWxTVlhJdlp3WDFuRzlTcXc2QXlIK1Z0ajNGc0VqOXlK?=
 =?utf-8?B?OThaVlJqYTgzZFNPVEZUTUc1TG0xeFl2NHNMdHhEelYyNVBDeFh5d0tuellU?=
 =?utf-8?B?Vzhjc2lJcTVOMW13NWlRMlhMVXQwU0FXZWFWMXdEMU1VeE9raVFHbFFvWmxB?=
 =?utf-8?B?M2JhSzVjUFVWUUVzYmkzRWJiYU54UUUxZXhzZHNIR1J4dFhDOU1GM1BnSXBs?=
 =?utf-8?B?eDRpV241dEpxUGdTOXAyQTk5RVBlN1JXT0hmcHVzejgwMHNPblp0Z1lXaERu?=
 =?utf-8?B?UUNQc0xlenpheXpJdmIxWFJ5RVE2ODRzdmpDeW13TFduYlB6VzNpKytrVzFv?=
 =?utf-8?B?SEhodTR6cXZFRlhodUMyenY3QjVRYmRKdmJ3dEtkdWlYb0ZUQS9hN3FSVTRn?=
 =?utf-8?B?Q3Q3ZWhPK1dwV1c2eUlhdnF1VlNjLzRNamFnMjNhNWRYdk5wQ1FEdXNnSVo2?=
 =?utf-8?B?KzRGdXA0akM2aG5iekdYYlhjM21NMVhreUl0WXovNktYbGlnUTlYTnhLeWd3?=
 =?utf-8?B?aUQzNmhmU2VKQVJ6bHYraDRmZXhEZ1VTMXAwYUZXYjFSWW9SUHQwR1YwdnF0?=
 =?utf-8?B?eDNDWWtld21LQ25XdnZiRTNnano3YUhBMm94SUQ5VktLWWk1ckZuZFZlaUN4?=
 =?utf-8?B?M1RFdS92K0FER1kwS2xBRlpSdTVDbElPNFJZOXFXWHovZ0dzSnExY3J3bnZB?=
 =?utf-8?B?WmJkTzMrYkpwaGFtZ3Y4THRmdyt3Tm4zOWFpaDdOSDVmVlVzbldTV3ZmZmJQ?=
 =?utf-8?B?K3RCRmRBS0svbmxRaG0yemNJWEJ2b0h2bDJLWU00Q1lRNlFDKzRUUUFnQjRH?=
 =?utf-8?B?TVJSZll4aEpNMUNpaUhnS0JwbURnSEZacVN0d2lLZEFzeGlxak5Scm1wd3Fz?=
 =?utf-8?B?TklESDJMNkhNVkRWdkpPMlVPNWVLTnJMTmdVSE9BSHNqbUlnR0NZODVPSkw3?=
 =?utf-8?B?TGtENU1WeFV6NEZ1ZEUyU3g5Wm1OZEM4d1FvSlB0a3dSYkErM0lKaS82QjlV?=
 =?utf-8?B?RnVWWW11Q0tNVlpaV3p5YlZNOXVOUTArYitWd0srR0s0eHVHWjlVM0VrWWxa?=
 =?utf-8?B?YVdqU1pXamVVUXNaYU9HaTFKakJzbEtLeXM2SjRRaVdXdjNpcUJuOERkeEF5?=
 =?utf-8?B?TklraW1lVUFDQm4vL0xOQnZDWVNDS0JSS3BNWmpid09EOXF6VElqQk1Jbzhv?=
 =?utf-8?B?NzJwSnhKOTlTUUpLYVBFb0tYbVhXeTk1T2Y3RGlaZ2FjVjQxMVdmOGdiSkli?=
 =?utf-8?B?NXEwamx4b2xaZUVQR2YzRjlHUzNJT1plcXNXdjQyZlBnSWFCamw0SUFkL0Za?=
 =?utf-8?B?MWRjRlhaRG9VdmpEclV1czJ6R2RacUVkaVhkVE1QcnA4U2tFY1ZvdUlKVUZ2?=
 =?utf-8?B?Y05UcUIrbGIvSTVXalkzYkJxVEJsMWhQZit4dklOa3J5b1JYTGJ5VDQ3K0Q2?=
 =?utf-8?B?bFdkTE5hQ3hpM2dzaG1kSWNyUzkvaCtLU1lnNllMSWZ6S20xbDI2STIxUVIx?=
 =?utf-8?B?elJ3VURKSDZsOE9QRVdDZXo3Qi92c1h0RTNpY3JTak9DRjJaUWVEcVVQR2V0?=
 =?utf-8?B?MGJDbC90cnh0THJqSW1rRFk2MklscVVCa1c4a3BEazZ6WFYrWVZUZkdkaWdp?=
 =?utf-8?B?Lzg2elY2NjJ0RUNZOUtsaXJpS0VpWjNoN3g5elNQYmlrUlNXNUs4TnNNeXZB?=
 =?utf-8?B?Y256WmxDZVJ0NjBtdGx3SVJBZ0loVWdmK0FPdjE0Rko1UVBGVVdYWVVQd3JR?=
 =?utf-8?B?d1Q3MWlqSHlYY0hBbncwQmc4S1hzbnNBS3hWanhPbmpwalo5bDlSd1pPTE1o?=
 =?utf-8?B?QmFaZVpaa1NNaGQ3QUVQMFdkWVkyVVNOdC80WjJ0bGZrWU50b01VQm52dlBz?=
 =?utf-8?Q?gDpkb9FlojE2nt5YsDZaJMvO/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd11c071-bc58-4898-2fbe-08dbe60034b3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 17:27:57.3566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D46yoj4lJ39eDpcBrFyoDQxHooj8sZV/htvRvzpA0oCZZbjPH7u0M0U3lhWpQyV2gJz8LlTIBxE6adH3R5QLpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9204
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/23 20:14, Pierre-Louis Bossart wrote:
>
> On 11/15/23 03:54, Su Hui wrote:
>> Clang static analyzer complains that value stored to 'ret' is never read.
>> Add an error code check and print an error message if 'readl_poll_timeout'
>> failed.
>>
>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> ---
>>  drivers/soundwire/amd_manager.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
>> index 3a99f6dcdfaf..f391b541f4b7 100644
>> --- a/drivers/soundwire/amd_manager.c
>> +++ b/drivers/soundwire/amd_manager.c
>> @@ -1029,6 +1029,10 @@ static int amd_sdw_clock_stop_exit(struct amd_sdw_manager *amd_manager)
>>  		ret = readl_poll_timeout(amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL, val,
>>  					 (val & AMD_SDW_CLK_RESUME_DONE), ACP_DELAY_US,
>>  					 AMD_SDW_TIMEOUT);
>> +		if (ret)
>> +			dev_err(amd_manager->dev, "%s: timed out: %pe\n", __func__,
>> +				ERR_PTR(ret));
> Is this really the desired behavior?
>
> This patch fixes the static analysis issue by logging the error code,
> but does it make sense to continue resuming here and trying to exit from
> the clock stop mode?
>
> At this point a bus reset might be a more relevant behavior...
As per earlier discussion, when we sent the initial patch series,
It was communicated that even clock stop sequence fails,
return '0' in suspend/resume callbacks that why we returned
status as zero.
In this scenario, it's not continuing resume when clock stop exit
sequence fails. Even In Intel's case, if the clock stop sequence fails,
just code is exiting from that sequence.
>
>>  		if (val & AMD_SDW_CLK_RESUME_DONE) {
>>  			writel(0, amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
>>  			ret = sdw_bus_exit_clk_stop(&amd_manager->bus);

