Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70863758160
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbjGRPws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbjGRPwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:52:46 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA91AA9;
        Tue, 18 Jul 2023 08:52:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQvbySimm4ozrLa2Ap54F4HKPbhL0QXbfMQAHhS2LDQ/eg0liiD+hrccDAL4fc+rqa7wEWmQJOr17GF10iuKYrbJR3cPb07hub2juibczHHkKkAD7JewzRhmkkuoyKEYvogMlLqbQfsB3ZwRCvCBSdFHlBxfND1Vss9O68mewfrJiqY7NeWMnyErKDik4uHipX+1m6D+SAl6x5kPxnQ6ipYlp5Ksbc475rkH4Dy5XLbHIrhW0gZUMpTOFvI8XUtuV07k156XXyMAZB0n6Omr09iiZxt1m9xqzKyG/VHn9HDH7Ys8M5CuwM73JaAVV36Ndn354YiPXJLmZ8zg91R6DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOuOI5gEimn2gqRyh2Fwahv9AFDv6OiknE53UTUXkUA=;
 b=mw6BcVo3kMzfjEX881w4dm+eR7xkqPE0dXV0SCOd1sh4SM223ntSD1kwFovP6JFz8hlQx747WtznyjWnCuAz3JYy0lTblan2Mcyfuwj0AX/GPaqWde1TgrejjIaX6NhPkwOS5bbqkjwgpr5kzTnEkbz37ovgx5DHmfnou5np4yxuNPP9jERE18MeeFB2o2GvGieJVDJccklfl9xDrLIxlLDylBlGKSp1HLqr0iueB46YgWdS4ecg7cn2wu9XAcQvAyuWW6KF1ovFbjCCPUt3YHEbkZOExOBJJe8RhLCDMQG/aGQCO7yqyqp19XuWAcCugq4iXCfp5NN6Hm6ou6ttjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOuOI5gEimn2gqRyh2Fwahv9AFDv6OiknE53UTUXkUA=;
 b=ACwv4mKvBbktdNgDyJkO6LnHDdDv9ccTphGGJFmHy+5N/mshMek1unXcBBFwMa8xBzD0opV8azB4kmj827cHfQr3o5uWL/j1SLQM2Px9LPC9VtXwK0zH2GpSar0gd8WZstlyCHCBKlG2Ihtj/UnMNByFAQj2VYymMn6Hll7sLao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by CYXPR12MB9442.namprd12.prod.outlook.com (2603:10b6:930:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 15:52:42 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::b7a4:9183:7942:5936]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::b7a4:9183:7942:5936%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 15:52:42 +0000
Message-ID: <c196f8f9-3d2c-27c6-6807-75a6e6e4d5a5@amd.com>
Date:   Tue, 18 Jul 2023 10:52:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tg3: fix array subscript out of bounds compilation error
Content-Language: en-US
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, mchan@broadcom.com,
        netdev@vger.kernel.org, pabeni@redhat.com, prashant@broadcom.com,
        siva.kallam@broadcom.com
References: <20230717143443.163732-1-carlos.bilbao@amd.com>
 <20230717192403.96187-1-kuniyu@amazon.com>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <20230717192403.96187-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0192.namprd03.prod.outlook.com
 (2603:10b6:5:3b6::17) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|CYXPR12MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: 993ca2f6-0739-49df-68a1-08db87a70566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MJcrdXoWoihq0M6MnVC9iZJVCiucmaKDF8wfC7fDBcq6BRQfA7ulu4lWFhM77kTXV2qMGBaFdMkOTlunxOPaRpJMU57rRVKVwr5XOAaOhrtuNSO02zqYuq4w8KYgPvWeCLhMvD48QyXVkrojLaqash3km2+kXsLe55638aWOaWgnp/QD8k5yNwwgt/DbNR0SNJesLgnj2kpcJePxNu5j2WCS4cxSYmtbvgQPh0xaMiOI+k3ZWURrO5ZVTLW0kZ7/glKiKDD8qiSFQHco6E9n2uQN63nfXkKiAakbp708t75ZAdjUOy7yLeNwJoju1bd4uUGS2XPgMz6JI9ZvIeZA2xjlOEGg5bDZidqbHlSo2G0Al4DKUzdU/if7C43W4DJlPgfTMVW15gLR0zIUr25OHZZ0tcyYs6YgXFc6OE2bZj29co6H7UTOM0M3kXWD8UlN1vtGHglBRsCUVfjaJ9YwDVqr5p8/trs8Eg26opZRCQSdDFCkTiJsSqN11Yb5KEjrZsRh2exmpMvpQWppmMqRENz3nwjNXtTpBHSIY9kCXcOo5Zb10vAOHmLvB/fqaSatzkzkOQ5yvahdTDGlCwNAgNcwPrd4c/+4/rxF+ma5JipF2ZVKOz9Pznn/761AlCcf+AErVLlmjmLk6jl4SawykQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(451199021)(38100700002)(31696002)(83380400001)(36756003)(2906002)(8936002)(478600001)(6512007)(26005)(6486002)(186003)(53546011)(5660300002)(6506007)(7416002)(41300700001)(2616005)(66476007)(44832011)(8676002)(66556008)(6666004)(6916009)(66946007)(316002)(86362001)(31686004)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHhPQllnaHpDT0VkTlVYNG5qV0w2WlM4SXczcmd4ck1jUit0dFc0RC9JUVFG?=
 =?utf-8?B?OFhMQlRxdUowSW1Xb0RyNGJZWnpQTDR0SVh5NDZkMzhXbEI1SXpHUDJUcHZl?=
 =?utf-8?B?N1BFSlZaOWpKbEM3K1lJenh4dzR1WmRoYnRXa3lyT0ZqMnVTSmhRQUQrVm04?=
 =?utf-8?B?K2F5SkxoaTFFcTlpUVdsRmYwcTFxbm5YU0R0eEZtQkhuQzhJR2NJRWx4WjZ5?=
 =?utf-8?B?cVllVDRyM3JiNHRERzg0dHFUeEErbTNTeXdrY2lYcHczYmxnaDI2eUVxZmth?=
 =?utf-8?B?UUEzZkIrQ1V5OUkyeGFENEVDV1cwblhZTk5VQjFpQU52Mm1GblorTU11OWkz?=
 =?utf-8?B?UVA0cjdseU9yV2ozWGVQUEx2dDJ1WWJ6NzR2M3hHRFhxRGdIY0dBRFRWem93?=
 =?utf-8?B?Z0xPWnZyMTBzMzgycG94MkFJUTB5VjZkWDBnSmg0RWxiNEZqVDlrZ0pyWUNh?=
 =?utf-8?B?enRORkhMME1IdXBGQjNvc1dEOTVCcmI3WmtCL0dpR1dJWTBOV0l5TmVUckxZ?=
 =?utf-8?B?SjdhNEdYenZmeXJtOENrYkxaSlUzNkdoWU01QU5YamdnVHAyL2VjeGEySkhy?=
 =?utf-8?B?MUZQTVd2eXdOcWp4blRWSGhVMkgyN1g0NDNTdUVaRFY3UVVLRTBRemJmeWNT?=
 =?utf-8?B?QmVZcE1NQTZ0NmQ3SUhtNHh5eit6cSt6NFJwVE1CV2VNdnhObVkzM2FHeCth?=
 =?utf-8?B?Z0loRDl0YnAwSlBpLzYrOFBLek1yeHpBbVEvV01saEU1QUJ4Qm5mNTNDVXFC?=
 =?utf-8?B?NUc2d2pyazFkS0hsSm1VcXlnZXExdTdZWlpTM3hzajlDT2RuRDhia3NhVThE?=
 =?utf-8?B?WWhBK0p4VURoMnNpUkk5SURMVG51OTVDZVIzVWczUkpmMHVPck5jN2w3Umt5?=
 =?utf-8?B?ckdQL2E2NXBXWVB1aTB1TE01d1BaaExIZEVqN2pwMkUxWDBmL0h5cXFWNEV5?=
 =?utf-8?B?Q251ckF4VEYyS1dmRXRuamZlVGM4bXhLUjZKOUkzNkhvYTNoa3VwelZHd09o?=
 =?utf-8?B?Ty9ob2w5ZGwxVXY5NDIva1gzVnBBOURFOTlUM3RZallvRURmNTFlS0wyTVIy?=
 =?utf-8?B?UEIyNkJmQzJFc21VODE1aStTK3I4Y1Q5MzNxRUxhblJVNWFjQ0RCKzduSU9p?=
 =?utf-8?B?YXNaUlJENm1va0x3ZW5OZUtLQkQ4N0UxTjhkdURCMlFkakswMEx1bC9IQ0J5?=
 =?utf-8?B?NjR6NXhLdENlNmplTXMvSEQrcUw5b1g4N1pHWXZaSUcxVW1hZGt0RTA1SWhO?=
 =?utf-8?B?MkZEMUhyVkZ6VHNLcWtNek00czhCWmtwcUphd1hhNlcvOXI0akMyc2NoS3NN?=
 =?utf-8?B?SGNCdTFpVThmemU3MUF2MERIYkQ5RjVwNFRwV3hnUCtYR0J5NWNqeExKTVhV?=
 =?utf-8?B?bEJndlNSb3Y3TWFCc1Viekp0aGZ5S1c5RytUTzdwQ28zcWNNWWFDcWlSdjNo?=
 =?utf-8?B?VXJwdUpOQXQ2T2NCbGNBb3lkNXJhQTBmUnVlbjNNcjVFeEZhVWhrQlhGWUda?=
 =?utf-8?B?UnJHcVp6Yk1ZVUFxVnEvdHNhZGs1Q3VIZWlUUXBpM1JmVlFJU3Q5eG5yNEcz?=
 =?utf-8?B?SUpKYVd0dzZINTh0ZXQ1UWFIVklzUEl5VHlXeDNVT091RVB6N1RKVms1TmN6?=
 =?utf-8?B?SFo4OWtvZmdJMVpaT0VSMHRSRGZ6M1g3YzZIOE5iQWVrSkJxQm82YlpwU1Zt?=
 =?utf-8?B?bGcvd1NxakRQOFF1Vk1meW5sdzh1K0xMaTlMYURDamxEY1h6L0tXbW9idVhQ?=
 =?utf-8?B?R0dHY1EyOWxDTi9zOUpNVmhSQjV1K2d1Zk9PdDBHM0E4R0lPd0M5ZkE0OXl1?=
 =?utf-8?B?a2RjRjcxeXZsWHRrSXl4dm5VQWxNc0paQTR0ZHZsWExBTlV4eXVlQlh6dkJS?=
 =?utf-8?B?cTFzUlN4V0hITlNXMWs0MmtBMWZQV1ZXUVc2WTFrRGM0OEcrU2VCM2EwZ1Yw?=
 =?utf-8?B?Rjh5U3NuZk9RSkJweXBBVHFxdmtvVnFRbytmZy9JbVhENXBLZGJkTGlGNFEr?=
 =?utf-8?B?TldiakF4YU1sa0VCeXp0NS9maklFeUY2U1NLQ3AyeTB1YzlWQ2lPQmdRS3lE?=
 =?utf-8?B?S2xTZUNnaXgzWVRpRzdTSmRyL1dEalgyQk0wS2RuVUlXR2RjUzZIWWtLeFNk?=
 =?utf-8?Q?kKpX0UqGwTFdM/hpB6pnTyExb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 993ca2f6-0739-49df-68a1-08db87a70566
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 15:52:42.4666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MBNBJH+/2p13/ftFQeS/95MwqAlZdceVitOi9Yq6a66Cpe6XBfgddker5ParCyfPkKomCKZCSgNplvVnytEzCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9442
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/23 14:24, Kuniyuki Iwashima wrote:
> From: Carlos Bilbao <carlos.bilbao@amd.com>
> Date: Mon, 17 Jul 2023 09:34:43 -0500
>> Fix encountered compilation error in tg3.c where an array subscript was
> 
> What is the error ?

drivers/net/ethernet/broadcom/tg3.c: In function ‘tg3_init_one’:
drivers/net/ethernet/broadcom/tg3.c:17795:51: error: array subscript 5 is 
above array bounds of ‘struct tg3_napi[5]’ [-Werror=array-bounds=]
17795 |                 struct tg3_napi *tnapi = &tp->napi[i];
       |                                           ~~~~~~~~^~~
In file included from drivers/net/ethernet/broadcom/tg3.c:72:
drivers/net/ethernet/broadcom/tg3.h:3203:41: note: while referencing ‘napi’
  3203 |         struct tg3_napi                 napi[TG3_IRQ_MAX_VECS];
       |                                         ^~~~
drivers/net/ethernet/broadcom/tg3.c:17795:51: error: array subscript 5 is 
above array bounds of ‘struct tg3_napi[5]’ [-Werror=array-bounds=]
17795 |                 struct tg3_napi *tnapi = &tp->napi[i];
       |                                           ~~~~~~~~^~~
drivers/net/ethernet/broadcom/tg3.h:3203:41: note: while referencing ‘napi’
  3203 |         struct tg3_napi                 napi[TG3_IRQ_MAX_VECS];

> 
> 
>> above the array bounds of 'struct tg3_napi[5]'. Add an additional check in
>> the for loop to ensure that it does not exceed the bounds of
>> 'struct tg3_napi' (defined by TG3_IRQ_MAX_VECS).
>>
>> Reviewed-By: Carlos Bilbao <carlos.bilbao@amd.com>
>> ---
>>   drivers/net/ethernet/broadcom/tg3.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
>> index 4179a12fc881..33ad75b7ed91 100644
>> --- a/drivers/net/ethernet/broadcom/tg3.c
>> +++ b/drivers/net/ethernet/broadcom/tg3.c
>> @@ -17791,7 +17791,7 @@ static int tg3_init_one(struct pci_dev *pdev,
>>   	intmbx = MAILBOX_INTERRUPT_0 + TG3_64BIT_REG_LOW;
>>   	rcvmbx = MAILBOX_RCVRET_CON_IDX_0 + TG3_64BIT_REG_LOW;
>>   	sndmbx = MAILBOX_SNDHOST_PROD_IDX_0 + TG3_64BIT_REG_LOW;
>> -	for (i = 0; i < tp->irq_max; i++) {
>> +	for (i = 0; i < tp->irq_max && i < TG3_IRQ_MAX_VECS; i++) {
> 
> I'm not familiar with this driver, but it seem tg3_init_one() calls
> tg3_get_invariants() before the loop and initialises irq_max as 1
> or TG3_IRQ_MAX_VECS.

I'm also not familiar with this driver, but what you mention seems to be
the case, and also tp->irq_max is used for loop boundaries elsewhere just
fine. I don't know why was the compiler complaining, maybe a false positive.

> 
> Where does tp->irq_max go over TG3_IRQ_MAX_VECS ?
> 
> 
>>   		struct tg3_napi *tnapi = &tp->napi[i];
>>   
>>   		tnapi->tp = tp;
>> -- 
>> 2.41.0

Thanks,
Carlos
