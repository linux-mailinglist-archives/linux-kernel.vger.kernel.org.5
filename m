Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4CC7DFD43
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 00:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjKBXYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 19:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjKBXYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 19:24:48 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D02181;
        Thu,  2 Nov 2023 16:24:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2szcN9OmhgEUHl2wwPOcqpKEq/L93XrJyzfFzysfiDj2jIHt1gP8Eo48dhYhRhneBVWJKYp7fDMd5/PuCxchIPSDAsL2YZcMf5RRL9xZb9GaFXOXsZwM4CQqEpYzUWJby46aNH7bYpf4oRzZRurAg6Ih7PRUzY2YJ/pXtPgLcyfp72ui4ZMxenPMD4S0ecOZ2rDW6MS13ZIZIXvjC0auBad6w8xDIO11mU2ZO4AQkKf+l5Jx7StuFSe24HKwTzomq9+PTbd41Xyw1fePLelMkXXR7os/NcWXL3LeKznYfyvJgErKFa/rKDqUN+5QlUErXvlf4LyLXOhtzfXkuVSmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xNgSfBiWzbNCo6hlYSN7xAwGmYkgo3Rys3TjuSWhXU=;
 b=ZiC/NymAE1e/+bxYVhHw18AjJJ6qJlwEm86d9zA/Zk9RFTiwaQp7dC9E+TGri9abn1SrbdnSe6bdQX7uINXQo+BEUAfoxzQsSPH0wbCugrWMAiZP/s0iuUfGlk71V8rw1PgT+wOD21/hbUmOygbVMGkEJ+vFBk3dZeGxIQ1zICv5PM0aRTU3BGqzSWj+TA9WfGNS3vylIIU3+ld7kdE8pZVCH3PST0ZS+UwlacPEnspPQHDpfHY9Jj9BDiNLMpkKJT+k6+ULtlS4GjDLWJ7cMTJHG26haLriEtp07J6RYtQtUa41pUgElSVM7LM2/NHKSphfpQGXZvjKYVP+ki6Q+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xNgSfBiWzbNCo6hlYSN7xAwGmYkgo3Rys3TjuSWhXU=;
 b=wzmXsm32H2v61A72nKk1L6NZ3WtxJ63s8+t0i1SiLyvMPq4pvBbDZvLqe7qspaMguy3bUAuEmdSfrim+KdDLBIFXpLAlUXqWNUcRP6vsfBWvB2Q2NnxDrY+/2j+PthRUs4WKsuTZyxpSdd4PInyflwwVQL+chk2EUBMA6vPT9js=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 BY5PR12MB4099.namprd12.prod.outlook.com (2603:10b6:a03:20f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 23:24:36 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::26b0:6759:d910:2dad]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::26b0:6759:d910:2dad%5]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 23:24:36 +0000
Message-ID: <81376530-ecc7-4457-bfed-2e8b65f69f4e@amd.com>
Date:   Thu, 2 Nov 2023 18:24:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/pci: Change CXL AER support check to use native AER
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Cc:     vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dave.jiang@intel.com, Jonathan.Cameron@huawei.com,
        linux-cxl@vger.kernel.org, Smita.KoralahalliChannabasappa@amd.com,
        rrichter@amd.com, linux-kernel@vger.kernel.org
References: <20231102155232.1421261-1-terry.bowman@amd.com>
 <ZUQEa1q/R2KBF/3W@aschofie-mobl2>
 <65441103b3b1b_44d229485@dwillia2-xfh.jf.intel.com.notmuch>
 <65441514c8494_244c8f294af@dwillia2-xfh.jf.intel.com.notmuch>
From:   Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <65441514c8494_244c8f294af@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0169.namprd13.prod.outlook.com
 (2603:10b6:806:28::24) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|BY5PR12MB4099:EE_
X-MS-Office365-Filtering-Correlation-Id: 2946139f-8289-48fa-dc4f-08dbdbfae042
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pmRKQBtRufaDzMc8o6VfHU7ZaG6V//gqSxeaDqskhdkflCr5PZ75dr8IRiQYg7Yn/prWz0Df3TaBicPOvs3XMwAaXB92kl0aAIhURZf1SIevmZaWSdnEp2kwXX4/X80I2R8oETPeFNImRk0nc3grkhtxGHSux+/Aim7Gg0DtB2gC/Ugfs6S8YAIOIgTVhM5F3Uz9c3eruTgLFywuHhvjVH2cml5TfsIJBLqMYvGFAx9YqgjDyZpC8gprk+Mofi+ITbXGwoAhlZfafsOgHaeBCg/9REMpDihVW1Ri4UOUtDaQ8KBWOIq7fCNchbkyKu3g3VlAa0mO6mIB3gIWTSrA2ahYwoJeLzm29gpRlN8WqCwROdRcp6Axi0sR90BuIScO2Uf9FAPaW4daQ8Jn2Lag1qZ+B7CX5AsnokCbfgv+ymSpAQ7Jj3KxRUGsxSXH1NmAApcxFZDVsawqVTaNMQEIxm3OfG8R7Ow4K8Au9hC3TyDO374aCy2ei1Lon/iXd0paZyK9b7TNfS8fhnRLuNd8QMNwXo34O5JktjT1ycPav64sy1loO7OUGwQTm2Ra705KN3Zi/x6eBAMZPSCAzrgmtmKI/hFg+c973dK5WjyX6uC+qdipKNL+4C9Mv1+dxTi3Z2sd5TLUkeFeR/mXA9SfIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(346002)(396003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(31696002)(36756003)(31686004)(86362001)(316002)(110136005)(66946007)(66476007)(5660300002)(66556008)(2906002)(6486002)(38100700002)(8676002)(8936002)(4326008)(478600001)(41300700001)(6666004)(6506007)(6512007)(53546011)(83380400001)(2616005)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG9NM25xdllHL3loZ0RoSi9TdVEzZWVFRDV5QlBjRHgvM045Y2JhOVJvNGkr?=
 =?utf-8?B?WVBBODBrT0NBWlh1dTVQL3VXVGk1M20vTEpXYTk0M2loN0k3R0UvdW1QRStU?=
 =?utf-8?B?ajlRY21RQTVubEpJL2tEVm9aYjMyTzBXUTloMHlQK05zY2JrVEQ4K01zR1Jn?=
 =?utf-8?B?TlJKOXJrZ0lmMnM1SlNaQ05oMnhMQ1hDSkk3aW5pbDUwT0FMdVVFQXk4djZX?=
 =?utf-8?B?REpTUkJpVytNL0pzYlNjTlJYQlpjdnBQSjRoWThvc3poZSs1N2hQWVN2QjlZ?=
 =?utf-8?B?WUVjemRsWGRSTlZvSkhVWXZKanY1TkdCVFJ6UDRRT25odExvQTZDVXQ4WHE1?=
 =?utf-8?B?Y2lmZWRiMEFucGVTQlJEWFN4dTJXNmRlSnJIWVNEa0l1WlltUGJPUlBUcnlV?=
 =?utf-8?B?ZDhHcmxOV3YrcFNBMFFKR1haQjlZY1QrS0lmTUgrTEoyNmtmcWlOMC9NMEc0?=
 =?utf-8?B?VnpLaFdabDVWTTdHTkgzeUZVYzlYOUlqQWlrWHc4VGVWVUVDL2k5ZjExZXJl?=
 =?utf-8?B?SGJqUnZBZDFiYmdEc1RZRDhuNVlQdXJHelNQSTRNelJBdHV1WXpzVkplYWdz?=
 =?utf-8?B?bTdzWU1xbmpyYjBHM3Q4UXZwTm1KcWExcFExZjZKUmtRcUFvUEhjSjRnakNC?=
 =?utf-8?B?SXFFemgzaXlmNUhjNi9ZY0RsZjIva1ZEMjBESzhhSkpCT244NlFvSkU1VlFV?=
 =?utf-8?B?eEJ5M1lPMU9MMURDQjQyRTVLaWNyb2pxZ0d5NWxJK2dIYVpaT1RuOVN6bHVH?=
 =?utf-8?B?N1o4LzE2RktaVjJqMjViWWhtRWlRbUdGVDUwK0R1bEtDalRDMCtaa1NKSU5I?=
 =?utf-8?B?RSt0RjNxZ1I4RkRwQ09oMWRueU9JdU5hYUVYc3llRXNzQnVPNzNvUVNOZXVG?=
 =?utf-8?B?SjhRR3plQWp3SGV1TWxlN1BqTnk3Z2ZVVjN4N1Zka1I5Q1lIUDROVHg2NEtZ?=
 =?utf-8?B?bzdHUDdRaU5oZ0p6SGVVMjVtOUFKWUIzUkxmN0tGSGVRYnBLV0trWWNIeDkr?=
 =?utf-8?B?azRqdGc0ZXN5VjM3cW5mWnE0V3N3UW9jbXlFTXF4QWZMbXdJY0s0THNrdUkv?=
 =?utf-8?B?REdvWCtYMHNJb0RVY2VJV1RhWVpGV2FHOUtoanhhQVZjTzd4UGVNL0p2NWoy?=
 =?utf-8?B?NzBvckJlcnZOdlhBUG96SW1JZ2tmSStQVzNwZXhlOGtlRVpQcjNxaDNaWERU?=
 =?utf-8?B?YzNPSFc4SWZQMU9waUlBdFFTcjFsbzNFRU01RGI4d043YVNNSkJmSWZHb2hL?=
 =?utf-8?B?WlF6Qi9tLzdtNFRUeTlURThxNCtJeThPWUdxbjZvZHBxUTc1aGFIT1IzdENl?=
 =?utf-8?B?WFp6bUFqNnkrSDRpUWsvSkg2NnhkRkhVMWJkWllzZ3pHTTJuWDhlWEtDZHMv?=
 =?utf-8?B?eC9rbmVMN2k1cWxjeHhBeklFR0RFYm1yNzlacTB2T01KQnlwcHBPYkhNcE5a?=
 =?utf-8?B?TURmZXg5d21pTEpNWXgzaldmSGh4THJnVGtGU1Z1VHlGakVSQmt3ZmpmR3ZU?=
 =?utf-8?B?SC9vUGVQNWJUdWhlOWI5bCt0M2NnNm5WaDY1UUJJdHB5VmJienZlSlRnK3lR?=
 =?utf-8?B?bTlGNVF3QUZHOXpmNFhvTUdTbXZmclhOTzdvMFZ3SmpUaHVScytEYTlDZGhW?=
 =?utf-8?B?ZTNud3poMFlTSHVqNnhRVk05T0FhK0RDZmNaYWxzVWszUkJtZ0FNZU13YkFF?=
 =?utf-8?B?R0F5dTkxWm5WQXJpMFpYSy8zRzR5V0NramZtdjVCT3lqaVdnd1I4TXFVZ0p2?=
 =?utf-8?B?SE02NTJyMHJ1NHcvQjAzeUs4b05PNkF2eFpUVHBDcUppZGg3dUFHMW4rcm9N?=
 =?utf-8?B?U1IwRCtDY1RiVXNOUElNMFJ1NTdvbmo3cG0reWlKc0RWY3dwTFdXZlQxUlNX?=
 =?utf-8?B?aDlLQkpJclBIOFc5VXU5K0Qzd2JKWWVzN0VxSkZwc3dkakZ5UzVYRytFWHNh?=
 =?utf-8?B?S2hIek4zWkRNaEdldjRFZTQxR2loY1F3SGRlWFBWYlpmaUloVkhlU2ZCZnNS?=
 =?utf-8?B?SytQdTVkU08yUUN6ZldTTlUvM3h1QUFPMEMrZ3pSRDdUZ3ExZ3BVQ0lYeWNJ?=
 =?utf-8?B?eGVzcjRBU2QzMXI0UG1LNjRaSnpXWlBYb3dlL1h3SHZtSk0xdGozcDU5Z3hk?=
 =?utf-8?Q?JWG5qe+g6YY4fN8BS4iC0lSDb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2946139f-8289-48fa-dc4f-08dbdbfae042
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 23:24:35.5737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WmJsqVYfrqHa4aOkY9ZZoCKmrHlbPVIJt95em3esUHUeMs97QUkiD+op4Bp3Ove/Q+KnB+YJOenitobIfSMZoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4099
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan and Allison,

On 11/2/23 16:31, Dan Williams wrote:
> Dan Williams wrote:
>> Alison Schofield wrote:
>>> On Thu, Nov 02, 2023 at 10:52:32AM -0500, Terry Bowman wrote:
>>>> Native CXL protocol errors are delivered to the OS through AER
>>>> reporting. The owner of AER owns CXL Protocol error management with
>>>> respect to _OSC negotiation.[1] CXL device errors are handled by a
>>>> separate interrupt with native control gated by _OSC control field
>>>> 'CXL Memory Error Reporting Control'.
>>>>
>>>> The CXL driver incorrectly checks for 'CXL Memory Error Reporting
>>>> Control' before accessing AER registers and caching RCH downport
>>>> AER registers. Replace the current check in these 2 cases with
>>>> native AER checks.
>>>
>>> Hi Terry,  Does this have a user visible impact? 
>>
>> Saw this after I applied it. It is good feedback in general.
>>
>> The reason I did not ask for this clarification was that this is fixing
>> brand new code and was just using the wrong flag, so I had the context.
>> A backporter will never need to make a judgement call about this patch.
>>
>> The end user impact is that CXL protocol errors that could be handled by
>> AER will not be handled if Linux failed to negotiate memory error
>> handling. Memory errors are strictly related to memory-error-record
>> events, not protocol errors.
> 
Right, end user impact is RCH error handling will require using native 
memory error/event _OSC control inorder for protocol errors to be logged.

> However, to that point the "Fixes:" tag looks wrong, it should be:
> 
> f05fd10d138d cxl/pci: Add RCH downstream port AER register discovery

Correct, it is f05fd10d138d.

Regards,
Terry
