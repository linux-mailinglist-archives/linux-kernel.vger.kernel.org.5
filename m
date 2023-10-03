Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2E97B5EC8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 03:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjJCBqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 21:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJCBqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 21:46:01 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAAEC4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 18:45:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lxj3Y76lHPX4sFaqdq/HcMNV6oeJMwbhpuLWEoCoJQJFGPn8Xd7IApJxERC0SeLkOAiOyELd3dSQyhE9yLW9FWeGW+yDjN1+UuSa37GzjItDWkGXBwd/GeCW/nk+3UIButjvUeCunNicea/x/QAkTsb0jX9wYUHgkEc8fMLstS24DXU5HMLXfloPJDHVPYSrUZvPxcRwI8RzJi/zKuzu+8I8VMtDAkcJOsRndkiKA8lER1YIX2LmaE6J4YrTGspnIn2UgD7Dw5uIOBf/BvOgiicEViB+LlD813PHt5WyVuM4ipnKGjbyJU9abIuTJnivSJvL8VepJ4DfUc271v3cEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xpdpYOxpx5bVJy/OQ9EjGkL0EwCSkOVPpa59UlV1Dk=;
 b=U/GkcSeuF9OGrj3T/VLNiv3MTShM3lAHTIxJJW4O6jj7YbQ9z5V8ii0FPxkY+eiCr33+gQqo4+K3taIQyxKv4q+/f8syyYCa7VeW/nHD/j9115RT+dx05mwNJkxPnCuNRqPwfsS3WpHuWsIZAqzOmr/8JPoXdqIqyXduqTSiZ6HIGEVl5xln3f9Q/NxrT46p63mA51bWPi3CrcuDiQd2ufeG6sRabksFF2IcBvXK24ioFJyVhkOxfiVYzlkVbSmyc2+ZKr/UyVa36WcaJbqouyrF24thwXPotwu1SeKfCoLLi364eAuArPgO7ksa6r8ckjJtLzsRH+5Qa3xNlXTpjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xpdpYOxpx5bVJy/OQ9EjGkL0EwCSkOVPpa59UlV1Dk=;
 b=SphHUFmg1u8efQB57y50bJ+Tznm9VNPFjWAWebRXyMXnM4IHmsrwiN+uTKZIDG3aeqHMAQnC7DQz6jpMcT/Y75ewQmbuCiKQL/6aQFP2tX7EqZknEXiJwe3kGvYes1/0GQMekJnPWPxWxNBSlYOb8K7kMJ7GmPUph+xFpyEHAnY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV3PR12MB9213.namprd12.prod.outlook.com (2603:10b6:408:1a6::20)
 by CH3PR12MB8582.namprd12.prod.outlook.com (2603:10b6:610:163::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Tue, 3 Oct
 2023 01:45:56 +0000
Received: from LV3PR12MB9213.namprd12.prod.outlook.com
 ([fe80::36b5:a641:237e:26aa]) by LV3PR12MB9213.namprd12.prod.outlook.com
 ([fe80::36b5:a641:237e:26aa%7]) with mapi id 15.20.6838.024; Tue, 3 Oct 2023
 01:45:56 +0000
Message-ID: <6917dfcb-651b-45a0-9dc7-c42f765dea02@amd.com>
Date:   Tue, 3 Oct 2023 12:45:48 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kernel v2] x86/compressed/64: reduce #VC nesting for
 intercepted CPUID for SEV-SNP guest
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20230926040526.957240-1-aik@amd.com>
 <20230930071759.GAZRfLpz38AAITSZzW@fat_crate.local>
 <e009f70e-32fc-404a-8560-f059b8999895@amd.com>
 <20231001095322.GAZRlBkle6JC2rfM6u@fat_crate.local>
From:   Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20231001095322.GAZRlBkle6JC2rfM6u@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0099.namprd04.prod.outlook.com
 (2603:10b6:805:f2::40) To LV3PR12MB9213.namprd12.prod.outlook.com
 (2603:10b6:408:1a6::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9213:EE_|CH3PR12MB8582:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f179d81-a959-4403-a037-08dbc3b27c56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W7GLcK3SkmB5WngukdC8ovgfABWssSAXq7p66Sn3v91w+7IWlD5J5+jhDjqfGM6PmwdzmM5Fi32kfGEF0c5H8tZXgOXFA8D+FEzLaIQkIBGGHBMHmxAy8cArOiXAxRaGFne7x+WO0sNJDHDmkKFp0mnmjuorRPqYzrH1GK5srrv64YD7MpFh6qcEC01sEVkJ45FxPfCg7iXOaFsQcc1fTmBD+78M+IH4T9giJ9DK+Dd/McPVp8VGVwQRCEQ0V2+KnqhjGa3gocbh5bvfDgh85QjOxtKsUgI+RaU+SWs1SWot9Sa6CiUnhrAhAP+Q6Lz5i6WNl9CPmOJlZEuT+ZicLi+ZHfQHdFGnQwrslIeHCB736li90hRP0a66z3PVx6atNHkZlSdE34IkTITTRRrrE7WoXWABOEBcaAxRAWI1pT5dHVcMWem+BFoNxSvGgp8zN2j2grHPcBrXVZ07rLZDzkUFRntM7/hfAcqqfCGrk/Q5KRF93aGE6BIKtA3OsvPWHlP+sBMdCSFmkRJPgsHGPpFnWrnn8bz9NvPUSJ/TjpctKprJkNS2TfnaljMJ4qCi3HdiMzRu9WznlIadTgPt8H2rNqEXk/3jn2WOjUGqAfs2VNVdcRiAWWxoV3+/NBQW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9213.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(6506007)(6666004)(6486002)(53546011)(966005)(478600001)(83380400001)(2616005)(26005)(6512007)(2906002)(41300700001)(66556008)(6916009)(316002)(54906003)(5660300002)(66946007)(8676002)(8936002)(4326008)(66476007)(36756003)(31696002)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2xkOWlkMEtrNEM0OHk4OVpJbWo1ejNuV0drMnkveFpSZmszVHB5djJ0VWFZ?=
 =?utf-8?B?am5uWGJQZ2poUzNVYnZiVHZsTUp4Kzd6cVhHNG1wYThZcVBVQjdmLy9KS2d1?=
 =?utf-8?B?enNGaFNNK2pmUkFYVzl1U1RNR1N5UGVGb3RVTG9mWmw4dzJ3U0Qwd1NySjAz?=
 =?utf-8?B?dmFJcTZqYnkvYWNVRVVkN1EzWWQzbnRud0Q4eFRMOWcxVzk3a0tvS2gxRkpq?=
 =?utf-8?B?cjlVdG4ydktPNGtoc3cwcmxscmxkTkh5OHhqZC9LcGJrMThyL2RVbmgzYzE4?=
 =?utf-8?B?c21QNTRieFNmdEJVY3Y5bW1HNFdpWElRUzIrWnBOV2JENVZwY1hjMVA4Uk8z?=
 =?utf-8?B?N1hsNmhSUWRkSEZWVGRLU0pOcms5U2lXdFphZ3RIb25SeWIwcEh6c0dweWZD?=
 =?utf-8?B?dEhJMHdjTHBha3k2YnRrLytJYWVQMlNWeVc0RkVxRG5QbkFna0ZOM2Vpc1dj?=
 =?utf-8?B?RXJIL1VYdjFYMGpqUXNtcFlpOXpSaWdOeHkyV0ZwVVVBajJjYkFtRHlaQUNl?=
 =?utf-8?B?VThTSTY5cXFWSU13ampacitrSFN5aElpT08zMVMrdlBuY0VKM0RGU2Q0Z0dE?=
 =?utf-8?B?RHFpM2d3SUxNWFVoWWt6MStNN3Q0MUx3Q0xUSWI2b1lNejFUUGdJOG05TGFJ?=
 =?utf-8?B?cDdCemRveDdicUlqdVFJL0pseEVYazJJcHRUMjJCSUJHZHBUQ3ZxOXluMFdT?=
 =?utf-8?B?ZXJzVTlOYmx0MGhSUFNDamFycExPK0pDY2xIZVYvWXBWU0VkSWZibElBYTZu?=
 =?utf-8?B?WS9DbjVVemVGOXlidHdxckdER3ltUGdSd1VJdm8xaEtBSUdrek41TXZSMmNB?=
 =?utf-8?B?TVpheWVid1dlM3picXd3dTk4OTBxQXkzS2JSQUxUOTFsMVlEc2xrUTRIcXMr?=
 =?utf-8?B?QWw3L3lNUVRZcGdCc3A0Nm5xdDJHUkl0UVhQSjVmR0c4azZWRVJpdGhCZnFh?=
 =?utf-8?B?N2ZTZDZCK2RIak1VNDh1cjdFM1BrU0d3aThGdEdUVWRXNFkzNU5LWEoxT2g5?=
 =?utf-8?B?RVUyeWhxUElMVzJRUGYydzk3Vi9RazBDUlVFUDl5dFhVMkhOZVo1MmlNbFYv?=
 =?utf-8?B?eTQwMWNFQnFoWSt3Zlpwbkg2TnI1Z0hGR1Y0VHVrTmpOeHA3VnlvTmFHMW5y?=
 =?utf-8?B?Z01aM3YybTFsZlBqR0pUUm1VRm9Da093K2NTcHJST1FQZmQyQlUvenliZzh2?=
 =?utf-8?B?ZkphLzZncGxMbE1FeUNodHFCendCbHUwVjhkcDB3ZTNZaFgrNC9Fc0FIblYv?=
 =?utf-8?B?TjRNMzM5Y2xLMkQrdnBaNU9iMmNhRksySG9mRlVzeVREOHFDaGZWNmI2QTdv?=
 =?utf-8?B?UjZUNnYrL2FFSUlOYVJrTUhHajRDY2lyV25KU3pFMGhibjFnZnVzUmEzRDlO?=
 =?utf-8?B?SVZPci93djl0TlFvei9vSXRsMXU4RUgrZ1ppZmx2Wll2c0NSVkRJZVEzVFBu?=
 =?utf-8?B?aFVYQWlCWWpsYkJyTzJxVDZUVnlYUW1HSGZjMG1RY21WUndSY3BGZjhlWnZ0?=
 =?utf-8?B?MDB4RlRaOSt4dDlVaFA4dEZSOERsaTVORHl3OWw3MEN1blY2TVozTWMrOWlH?=
 =?utf-8?B?c2tPQjV1eDlDdllYOHVKWWpxTzFxUW9oVDZLRGdnWkFwQ3ZGVDZkS0ZUZFFh?=
 =?utf-8?B?K1daNXdCSDN2VFhqSjE4UUM4TzBraVBsd1ZBenY5MjBMN3RUNjRDbUV6WDIv?=
 =?utf-8?B?Tlg5dlVuTGZSNDVPcE1KTlhsc08vejU4c0k1Y0Z3SGx4OVdSUDl0RlhBaUtU?=
 =?utf-8?B?eSswMi9uR2xTTit4VUhvT3F6NXh2L3Y4cElRUVhLZHdOa1pvNVNneGNwVzBS?=
 =?utf-8?B?bndlNXk3WVh2WjNScVY2TEwxTHNTT3NwN3cva0pNL1RnbjZMN0gzSE16SjQx?=
 =?utf-8?B?YVEzekp3eTB0QkF4UGhDKzBib2YzL2JTWVVGMGkrbnMrLzM4ZXhOWWZQYjlZ?=
 =?utf-8?B?eUs1V2ZIS2ZXSGFvSWgrbW9wZlFFNU1RRWFYNWFBVmJ4cjlrUURuV2xhOUov?=
 =?utf-8?B?NUEza3loZSsweEZSakFIVDMwYUt1Um5WZGYxaFQ2NFhPb3hUMGxSUmZGYUda?=
 =?utf-8?B?d1ZPSTUrdDNRL3lpeStTRG9KZnhtUk44eU02K2dTTEhmQlRnTnBZNk9sQmlv?=
 =?utf-8?Q?zxVyMHbrgzb+QxuHMK8NQSHOf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f179d81-a959-4403-a037-08dbc3b27c56
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9213.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 01:45:56.2148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +R/BB2VIpHvy7VyzQTRA0ASMo6AeOXWWivD5ezdJivbVA8PM0KqUB5kytGLFlu8ieaEUYjtrVgShBzVybYPqqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8582
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/10/23 20:53, Borislav Petkov wrote:
> On Sun, Oct 01, 2023 at 08:40:30PM +1100, Alexey Kardashevskiy wrote:
>> Ingo says different, who wins? :)
> 
> I do: a function gives you type checking - a macro doesn't.

The macro is a wrapper for the sev_es_ghcb_hv_call() function with type 
checking.

>>> Then, it should be defined only in sev-shared.c for now.
>>
>> sev-shared.c makes me sad. Including .c is not ... nice,
> 
> There's a point in doing things this way.
> 
>> I would avoid adding stuff to it at any cost.
> 
> Care to give a technical argument why or is it just general sadness?
> Because I don't care about non-technical sentiments.

No it is not technical, it is my ignorance :)

For example why inat.c/insn.c are included and not linked? Cannot linux 
compile arch/x86/lib/ files twice into two different .o, for compressed 
and running kernels? Is not more logical place for sev-shared.c in 
arch/x86/lib/sev.c?

>>> Furthermore, it should not be called "rdmsr" or so but something like
>>>
>>> ghcb_prot_read_msr()
>>>
>>> or so to denote that it is using the GHCB protocol to read the MSR. I'm
>>> sure it'll gain more users with time.
>>
>> What is "prot" going to signify?
> 
> "... or so to denote that it is using the GHCB protocol..."
> 					       ^^^^^^^^
> 
> it is right there.

Ah right. I am used (after some grepping - not just me) to "prot" == 
"protected", "protocol" would be "proto". imho not needed here but alright.


>> And what about Tom's "x86/sev: Fix SNP CPUID requests to the hypervisor",
>> are you taking that one or I have to repost this one and the Tom's patch?
> 
> Yes, use this branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=tip-x86-urgent


Oh cool, thanks!


> Thx.
> 

-- 
Alexey


