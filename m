Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4B1781572
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 00:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241619AbjHRWib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 18:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241331AbjHRWiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 18:38:19 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806591BD4;
        Fri, 18 Aug 2023 15:38:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wh2dQWLb3M/T5hDFqiubH9GjqOjLmEZLIMcuaPuA/c3OMx4BICspCb4zjto2r9DeV3/7c8MA9aP6v7SkPb/rFK7LmlHjA1ujJxLuldDcX8DZi62i30on37ny23VkMmiOzcSbGWlqgTPLLyKSjHwIY/5YPDHZIieXRuO0HJGz8/SKzsLMYg+p2bTd9N8+gr+j+0PNWzmicZSnATgybCTKLTCIWmfdFLujTwB0WTxDzm2tcyaFL1eiKvF530TE81Bs3osPkdKF53TExenSVbI0fBhJjmwmp10K3yDnhxgArL0zoo68K+vBsXRqwwHldImM9oEb5Jf/1wZvF9knlSWxlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfHsArDfllcJrcAN4Lrjk3DVIDTOZNBv0tfB5vPFb3U=;
 b=YtV77M6Tv/xeP3gItadIQrj1u1lKZ9GZStY6d/aj776ZT0EWg4R141D51uApdFcf8+JvIcIMJmbwfMNd1ywO348nbkHlTr3qtvMoUyfa7jMXFxMF5O/VlZs1ifq1vRMP+svHVYT1WEa6F6s8yAXf55lT5CNg5AAYNXNEt5BE51VyID4uGeqx/yDh/cIah/MBldUE3WIkbgAaIqdm1hD8ZZZ4d1KKWQnomEJQ7P6whYbdUKbqkCS1BLPyD6Xh6a0yrFgc+XCuSgNS9Q3F6s+XB5mRsVqL/a9w7IxV7q4IXm9utYsurXSYEpLLB6BpfnkxTJA9o7jHBjf6DFS2pqDzFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfHsArDfllcJrcAN4Lrjk3DVIDTOZNBv0tfB5vPFb3U=;
 b=mjkCQ4a78H2/2nrcFAIfOES6JMQM7JpxhRS7MVH6DXpZYygUFy4Oq0ofztWTlWldXGpZhV9mO8NSE1t1IzY0X74YYqtpIrFdirb4VVYiFYxfiWzYJjvLs0h8BT4vQ87iHYfdJ+6DluHI+VTkTOUCfYKT7N0vblAsrmJ1UItpXOs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4894.namprd12.prod.outlook.com (2603:10b6:5:209::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 22:38:14 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 22:38:14 +0000
Message-ID: <25a21516-7201-4ee4-be2b-f67edaf97e2a@amd.com>
Date:   Fri, 18 Aug 2023 17:38:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: Don't make vendor check required for probe
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        charles.d.prestopine@intel.com, rafael.j.wysocki@intel.com,
        len.brown@intel.com, stable@vger.kernel.org,
        Todd Brandt <todd.e.brandt@intel.com>
References: <20230818181516.19167-1-mario.limonciello@amd.com>
 <CUW0GZCVHKPB.1W7ESSPE7INHQ@seitikki>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CUW0GZCVHKPB.1W7ESSPE7INHQ@seitikki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::33)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4894:EE_
X-MS-Office365-Filtering-Correlation-Id: 30aa5680-b0ab-4140-dece-08dba03bcea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M1NxupP1nHo+hpw6XwchIL0i/q7jSFUzzZAGQT5W35WcTSoSkGOdjpdGWzgi6ZOFrkul39Zgp93XSyO1PLLpsiWtZAVkTNgahomQvrE6hSqEIMV5ydW2o6dSdJ5AFvW6D/6Swcb9mb7Sp3rs5y8ev8fTsieJBAKuk3ePygMcq67uvG45EPcFtkYKBC9/oTvkwKe+AvX/gqmC/3rjnSY13cPeIYJ4XSGgnb2cNrASsMvy+XeYcNz04x6FBEuwkvkvcTTm3iYudWUYgbA70UOT3vm6s4LrAjQLLdG0JvwWjqmac/T7g1qm5BI0DjmhuNDvtBQFjsdfoB2v334I6974xB8ujFmuzb/cb+XMVYInVrGpdTe+yKicxhe4U0a9XMDb+HFTTDHKN02D1ZoOV/GsAllbtUb0JGnxQW9x55jAPXEjcAa8iNSX3K7WrBspCnhfeLZ7Obac2WKWgmnsxadrBIzmjbiIX+UERfgtjZwmpfOuCOkFa8H43ebemxGdvpu9/9FR3MJV4JhKvskWSMsxGzCcVjaSFku/JbaNrp5yysRmPKPLR6rdgBhxuT+Xd0f4LlyInETDsVUwrvPgL0iQcvw6Eh2dQBplhwfytkrora0zg4AzfZa/BUqksv5YF6TopkKUBUNNcoECLFIsD77M8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(366004)(396003)(1800799009)(186009)(451199024)(6666004)(6486002)(6506007)(38100700002)(6512007)(53546011)(31696002)(26005)(83380400001)(36756003)(2616005)(66556008)(2906002)(316002)(6916009)(54906003)(66476007)(66946007)(41300700001)(86362001)(5660300002)(8676002)(8936002)(4326008)(478600001)(31686004)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkJra0R3VThta1d4R3RBMWs2Y2Y2OXRSeEtEdmphSnQyYzhzdGNWN0w3N3R6?=
 =?utf-8?B?TiszdksxNUhrdkhQaFhwK0d2ZlQ5NUlvZXZPTGN3TnVVbFlUUDNhOENuNDBF?=
 =?utf-8?B?M1AweGpUYkI1T1FkU2hHYlZLK25Qd2wyYStuTFdnbnFtQmhibVF5eU1DSzBY?=
 =?utf-8?B?WlIyUUFMSDF3Ni9xbmpkcG1HcXBlR1p0dGZRV0xrNWdHaVk5MUN2MlhVcUhD?=
 =?utf-8?B?UUlTczlPUTBqWERUNThQVEc5TFRSYzZ5TjVFdi8vOHBBRk5temxuOXgrMFpn?=
 =?utf-8?B?TkNpK216VVlxaitWVzkvdVV5OStmY2MrT0VZL0NrTHNuTzBHUzhsZGFoR29x?=
 =?utf-8?B?S2kwYVNnVnlLWVJ5cUZ0NXY0N0tIUVpWRmhST1BvOXBldVhHdHljZzZ3ajlG?=
 =?utf-8?B?ZXhXZEVhVFJTM05YU09yVlhRS2pZNTBDZGF0c09nM3B4ckUwUk9GcjRwWndq?=
 =?utf-8?B?NEFsRHFIZEtDdXQ0NXU4dEJsMXJOQkZMRU1CWm1Pd3FMeFhMZk4vNGwzS1FR?=
 =?utf-8?B?WldiaWFQbXNjekZkd1BqdjJsYkZNd0RvVWd4UE9RbW93dFo0V21Ca0hvdzZQ?=
 =?utf-8?B?Z3d2UzFvcXdaSndSQjVySmJJZmRIVlZjcFlYUVc3OGxjQzJpdEJsOFNMcDFJ?=
 =?utf-8?B?YXlzZHpsU2dsNWFSUE1xQnlQTWFieE5MOGdMOWtvUmxtZllVampCbUc5RmRP?=
 =?utf-8?B?bTNlS3g1Q2xNUWhUVytOUUhsdEV5MUMzdHd4Y244UFBnMHY2QTcwWVJjSDl2?=
 =?utf-8?B?Qk04SWcwam1qMTh3SUVWRGFKZWl4VFkrS0NyZnFGL1FlT2dvTUFIWDRqcmRM?=
 =?utf-8?B?QTNrMURvdHQxM1o1SCt1UTBVdGJtQ05XU2xBK3YrU2dYTUJDWDhValRyNVdU?=
 =?utf-8?B?cXNUQ3d5cWJFS3FsM3Rkc0lqUDBHb29PRW5CUjhqWk9JRmlJOW5uOHJFOEJ2?=
 =?utf-8?B?VlRxdkR4VWxaQ1BBQS9wN2svVHpFSjh5dEd0T1pjRDVDTkFiQm9wSVNJQnlI?=
 =?utf-8?B?WlJVWHpSSXFCQksveFJNNWtrY21xcDV5VVgxaVY0clpDR1VTd3pWM2JlejZ1?=
 =?utf-8?B?WWt5SWtEaXZJK01PTGV1dExkcExnTmJxMHhrSHN1MUtSMGxqUDd6TmxxMG1p?=
 =?utf-8?B?Z09NdXE1MFZqTXJaTklpN0d3S1lQTVNjeDFBNklmSWdjWUxod1JpckowdE1x?=
 =?utf-8?B?TEtnd3JRbGlNVGFFWFRjUXBMYUZUNmNuK0p1WnV4dHRjV1BhUGphWHlwQ2hW?=
 =?utf-8?B?V08zemIrWTllUDNyTnpBVGlKMFNxUGRCTkp4NUM2TktlYkV3R09RcUNRZ2Zk?=
 =?utf-8?B?cmc5MlBXS2dNV0pIRlg1S3ZXUHNaWk03a1ZzTVMzMlFwVVdhMmZuaThFWlhR?=
 =?utf-8?B?NS9yZXB3WFNEb3FWSW1iakpJQnB3Y1pjcmVPLzFrOEZWdVgyQ1lPVkFCNzVT?=
 =?utf-8?B?YlNhTWpFNmZVb29pUXVQQzlZYmJmaG9sTFFGcWRlajduNWNpYmQyZXNLNXFF?=
 =?utf-8?B?L2RMclZ4V1lqcTJTMmFSMnBsM2RqaTg3TFhQREVGRnZCT1lXTVVyaEhEdDRp?=
 =?utf-8?B?Nk8rQ3lDZTVMSHpvN2Q2WnpjYnFDNTNNOFpvNGJ1Ujl2a2loNCtxTXRkVkli?=
 =?utf-8?B?am9OSFJDUG5rQ2xjeTBNZm5pSW5yeWkvM2E1RVFNa1BxNU5KY2REbmNiMm5H?=
 =?utf-8?B?Qmo1blRBamUybGRJRis4elNta3REeVVVNUtScnEzZ1pHa0ZLTVNkWHdPUFN0?=
 =?utf-8?B?MC9NZzZLSFlzOG5XTDJzb0FlUnFaUDVYVHluNFRLSTI2V2Y0bHZ4cWxudFRL?=
 =?utf-8?B?eU84OGZFbEV2TXpyNjAwa2dDZlVJeE9JdHh1YUNsQTBnR0xrcUl5YmhqU0g2?=
 =?utf-8?B?UmcwYVNrQTlDTTh1WDFUNWZnNHRlNjV4ZDh5RFRpYkRlMTdMM05zSCtTMlpr?=
 =?utf-8?B?WVNOUEhkY1JqR1o3SFVXamdCVGdScUJBSEMxMUw2alBOREhoU2tFY2N0SHhP?=
 =?utf-8?B?RlpBZUNXbnlMdVd0TDhTTlVUYit5UWJmYXoxZjV0TndiSnZxeVpyV0drOEtE?=
 =?utf-8?B?QlhVb1QzQVFCSlpyMldwcDVZWHQ3cEd1UG82SVpkdHJEZDRBdkxsa3M5NTY2?=
 =?utf-8?Q?qC3NHm4bBALxCZxemYFJ33cX4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30aa5680-b0ab-4140-dece-08dba03bcea2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 22:38:13.9807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QRg8ZBfIaMiDzoxLxwU7FpbhGtxbUejrZK553F0i+aClNSb2s03yUpztZwrWreLLHy0m5uUx1hN84MTclU+1Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4894
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/2023 5:07 PM, Jarkko Sakkinen wrote:
> On Fri Aug 18, 2023 at 6:15 PM UTC, Mario Limonciello wrote:
>> The vendor check introduced by commit 554b841d4703 ("tpm: Disable RNG for
>> all AMD fTPMs") doesn't work properly on Intel fTPM.  The TPM doesn't reply
>> at bootup and returns back the command code.
> 
> Is this reproducible with any production hardware? You are stating it
> as it was reproducible categorically with any Intel fTPM.
> 

Yes, it's affecting production hardware too.
Someone came to the kernel bugzilla and reported a regression on 6.4.11 
on a Lenovo Intel laptop as well.

>> As this isn't crucial for anything but AMD fTPM and AMD fTPM works, throw
>> away the error code to let Intel fTPM continue to work.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
> 
> It does make sense not to exercise this outside of AMD CPus but since
> there is no production hardware failing, it cannot be categorized as a
> bug fix.

See above (and also kernel bugzilla).

> 
>> Reported-by: Todd Brandt <todd.e.brandt@intel.com>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217804
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/char/tpm/tpm_crb.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
>> index 9eb1a18590123..b0e9931fe436c 100644
>> --- a/drivers/char/tpm/tpm_crb.c
>> +++ b/drivers/char/tpm/tpm_crb.c
>> @@ -472,8 +472,7 @@ static int crb_check_flags(struct tpm_chip *chip)
>>   	if (ret)
>>   		return ret;
>>   
>> -	ret = tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val, NULL);
>> -	if (ret)
>> +	if (tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val, NULL))
>>   		goto release;
> 
> It would be better not to exercise a potentially failing code path at
> all. This initiates full transaction with the TPM.

So why does a full transaction not work in this case?

> 
>>   
>>   	if (val == 0x414D4400U /* AMD */)
>> -- 
>> 2.34.1
> 
> BR, Jarkko
