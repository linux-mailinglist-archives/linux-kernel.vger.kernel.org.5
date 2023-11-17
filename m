Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A327EFBF7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 00:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346275AbjKQXBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 18:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKQXBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 18:01:06 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09E4126;
        Fri, 17 Nov 2023 15:01:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhTI6czb+Sw7STlGCcRu3HvYVP/3AaWemDy3RRNKynqoemQoT/VA13fvCccKYQ6EtNjB+l8qLZ/xRkaqaAOg5fXCU/oVG9FkASny6fblf+T5KPWv45/KXYqT6/clx1yPir1HTJ5gqdhF1dR7aCTFfrHdexBnOe6t9WQHqGp3TiI68vxQWYqZJpAKxki6z69+ra+onox+fxjTUrhXkbpFsI6dwsvpJZH4lDucNTA3FpJYy8IFQ14Fq6c1N2zIHA5KFZXIJGsVUDO0cy/IzYKv/25vP7+7/gWq2/M1AllsU56ru6rOrgnQ4cVs/86VAx7C10h8o27PmO3LoeCStq6YSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ie2TlFXNVUI7oRtk4yWqr7FJyh3Dbsor20S8fDC+1Gs=;
 b=YzS27OZcbvYTL6+dhRxi8geSRz+8BrM5kw5HJNyBq+4QEKDC0dgmlbjNREhwmOlGKbJeB2qG1sq+rUEUfuKiVm4m/4h7eOC1PZkQmJGD35DVqYMeHy6ZjOGafj0caOnr4F7xY96yIeLYxXTBCNUOJnTnEi9TNMgk9/iCqBQPcpQcD3PeOcuurfkPjrkAZX6KH7dY6uD0HhfWwiHlRLChTeKViiqmTIjociNSG7OjRJaFv0GMNDfwKMm4DOsimesx9bj/xsmcwQM8q4z9nMC5I+lcWKmzf2JtS/F/q4WqRs0vTH04E0SvjjsQoobmsC+752HytNfayazndhBnJfsY0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ie2TlFXNVUI7oRtk4yWqr7FJyh3Dbsor20S8fDC+1Gs=;
 b=QBXb7OoFDFgQ9kVgUAVkA+cVFc/dyRzx6FlaT2lucdC0FPISEbt3pLca0ZspW8P+sqf3SQblff6eE9lIUMOU2NImvErxzdWxL7Hci+Fm0HXziY5ukDrtLRYW6jjYKfjYT39uHFDI/7DAFtf+yjFBCCymp4Ct9RLbquKU8rZEJ0c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB6006.namprd12.prod.outlook.com (2603:10b6:8:7d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Fri, 17 Nov
 2023 23:00:59 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7002.019; Fri, 17 Nov 2023
 23:00:59 +0000
Message-ID: <c43b59bb-b073-497e-a9c6-c9c98e6a1fdf@amd.com>
Date:   Fri, 17 Nov 2023 17:00:56 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rtc: cmos: Use ACPI alarm for non-Intel x86 systems too
Content-Language: en-US
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Alessandro Zummo <a.zummo@towertech.it>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        alvin.zhuge@gmail.com, renzhamin@gmail.com, kelvie@kelvie.ca,
        Raul Rangel <rrangel@google.com>
References: <20231106162310.85711-1-mario.limonciello@amd.com>
 <CAHQZ30DP8ED4g3bib-tZ53rm2q2_ouEEL3TxD-SgK4YrCe3bew@mail.gmail.com>
 <d55a80f7-ca4d-406f-b2c8-b2bba45e3104@amd.com>
 <20231113223819fb469198@mail.local> <ZVM4nFaDTwrKMr8K@duo.ucw.cz>
 <2023111422283827b2a3f2@mail.local>
 <5029e355-6fe8-4d48-9bc3-20256adfbdb7@amd.com>
 <2023111722570552652970@mail.local>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2023111722570552652970@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0167.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB6006:EE_
X-MS-Office365-Filtering-Correlation-Id: 999d1e15-85a6-4cdd-4770-08dbe7c1101e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TgdwZ1HQSpw6tZXtNWyc/5q9SSdIeKIQwrdvOTC5AxWdLPjHZRqC0/PN94ZRL7N2EUHkGsu4tfFZgUhGOER/EcuOwW2o1iA27CiTYUMP+EMPHEdpdVKFphoadVNNlq39Od3MQrAoymSEGjVjGv6q2zxneqndnCRepc4cpJ/gC5n1NuIKLJzHeuZ6fILIzsbL6Ag31+86aAAEoL7B/5GNqw5G9YFrcHtlMCoWi/2UlnfQIMu4Z42FH3qOgyHb8IZVFkKsFSJx3IwC2jVfp6y6YXvy+71xx1ZqXh3+tVFwRTkQLis7NDppQE4h6t4GZFPVSDAzrhZsOowfps2SVCZVZIVAO1KKing9P2RnESSEUFUj/GUH6rc0R9mahfFOb7k6rBP7xPyYrNwoIcCFwzIcaWC292cLrakbbQPV7JXEJKm1GR9Htau3P4lOKtEcofs3say46tjmaWSRbaSBm4uSVecwwQSYz6L8tPCNlszlcMlU448crFJPg6YqClgrrsDtwUoQl3HL9iH0Ex90JNFzflX4lWB0Cae53d1HHGmptgUAXRsiZxvCfKYX8XTquDVcbl1GfdJzuNSHruWQlzq9hNIqK7jiL4CL0lEzDEC0Gr+ocKszpflVUHm/O/wke1hZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39860400002)(136003)(366004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(86362001)(5660300002)(41300700001)(4001150100001)(31696002)(2906002)(8676002)(8936002)(44832011)(4326008)(36756003)(38100700002)(66476007)(66946007)(66556008)(6916009)(316002)(54906003)(478600001)(966005)(6486002)(31686004)(83380400001)(6666004)(6506007)(53546011)(26005)(6512007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEJQNjdNVEdxOGhrQjVjUGhNZEJPRjVRSG4xU0tPZEVacCtxNFBvY2w0Wnlx?=
 =?utf-8?B?OFlTdktzS0ZkMlQ2dkFOWnp4bTdHb2MvOGhLOFhoeHJHeFhud2lsemo5bnAx?=
 =?utf-8?B?R3BoVWh1dUdCd092VVVTZVBBR094eWdockt1c0JPRFlkY3NDWmlYdDQ5RTBj?=
 =?utf-8?B?eGtxM2tpVThCOWVUa3RlQ25XMVc0bm9HL08vdTFsTDRrWDdvZW52bnROYVlQ?=
 =?utf-8?B?TUNIUkZOQ0pQRFE3bHJsSEU5M2NRTDNpWGZWcENzbUt1ZFh4Q1NJMFpXOGFz?=
 =?utf-8?B?UlhDK1B0c3EyOU9QakVteklTOGlaMGhSU05oQnB5YW1xYngrMlpSQW80VS8x?=
 =?utf-8?B?ajlXQSsyOWFlT0t2dkE5cG1KQk1nZXBSMjVST0srQmFYNUJtOVJYOERZVGh6?=
 =?utf-8?B?VnN4SldDMlEvUlNFMTJVcVFjSjlxd0ZUVytlcnhrazRMV3lCL200eGloYmpC?=
 =?utf-8?B?UUxJSU55Y0hSRzBkbVB4OXhpM0dwakQ3TTRoNzZiK2xlb0M2VHB0UE04K05D?=
 =?utf-8?B?TmxXRjZ4N2ppN2E5YnRVM2pTS0diOG95V2J1bDN0SnRkamhCK2lVb3cwY01U?=
 =?utf-8?B?VFlMeGF0aWw5KzN2YkpyZFNBMU0wRW5LN2htak1QTE80aEo0elN5amtUbUhD?=
 =?utf-8?B?OUVIQTRUMmpoenBQSUl4RC9GTlJtRUNvTWdBNzNFS1NLZ3pqUzJOUDY0MGJU?=
 =?utf-8?B?aUlxOFlKUzB6QVpxWE9YaEFqSXliTWdLNmxJR25oL2gvTmxqVHhsWFVYUDkw?=
 =?utf-8?B?Um94bWxHQ1NPL3BVMUZhRkVXc1diQ2ZFMDBZVVQzWWhwV1RLR3VCR2Y4SWx3?=
 =?utf-8?B?RjVCODUzYkNwVUhBT3U5V04wcHZQRVU1bFJwRWRPdXRZQXh0Z05aR1FoSisz?=
 =?utf-8?B?WCthdW4rams1YUp4STl5RWNDcWMrMG5iNjNCdjNoeVN4aFdQa2pMSVhLS1px?=
 =?utf-8?B?SHYvWGt6dUw3SHVsb3p5WTJHeE00MXRoKzYrbDdFbFBoMDdZNkhDblBaTUFG?=
 =?utf-8?B?dFpLVVByNFdzZ3k2c3hNWU5lWWxRN0Q1c09vMG5XaThsQU1MUzRGYWpBekZr?=
 =?utf-8?B?VFlGUWpXQzlwTzZhcGR2alVrd3JaVjZLSGo0VG53d1EwSFRicjNpU3l0aWlT?=
 =?utf-8?B?dU9rWjdxZFlza2YySFh5NXJlYjBIM2luSDNhSGlXM1kzS3FvMVRGR2VlaWhv?=
 =?utf-8?B?ZXpqS3dIUC9ESWtneGVuZ3NoTDRWakk1NCtFaWJ5RGhqQlVobTh2c2VHWGY5?=
 =?utf-8?B?aW9DM1hYY3M1Q3lVRVEvcmU3SVRrdUNkQ1FXUVNoRko3SkI2RjFFLzJUcWR0?=
 =?utf-8?B?eGZBY29kc2FyY1dPVWlRcEhCYnluS2VqSGZ5V09NYVY0SEJDbkR6M1JmN2Ns?=
 =?utf-8?B?ek1UM21YQWI0Tyt0ZDFiMXhVa1BEOFRTblNpa2dvZWtxQ3J3Y0NUalJxR3FD?=
 =?utf-8?B?K01LS0RhdmNiNmYwYmpEMURJNUl3Uk51TUVHUnQ0ZDhEWnR5Qzh2N3N5aHdJ?=
 =?utf-8?B?TDhtU21VeFVnZFRuUHNvTjJhWFEwcWVtMFg3U0t1bWhvZTZqSUZweHJoR0lx?=
 =?utf-8?B?UjJxZEJVVHdIc00wSDFoQXZqOE1GaHBpWTQrQlNFUnpVNEViekRCL3BPTVdr?=
 =?utf-8?B?Wm1aWWladnd2a0JpN1JDa09kZEdPTVlqRWRaSldMeGRKY3dtc3lOeXAyakZ6?=
 =?utf-8?B?OGpoVG4vQ1k5YWg1eWxvclJQOGdESkh2N21vYXAwd0ZJbUZvY3ovUGUvZHlJ?=
 =?utf-8?B?RU1zVlBBQ0tnNk9mdjFOMWNXWkpCdDJWaXRhV0dZTXNVMXp2b0tJRTdJMTE1?=
 =?utf-8?B?N2dtd29aOExXVis1amF3aWJFV0pxODJvTjJUQk5HbUVuVEYwc2NHNHhZM3ZG?=
 =?utf-8?B?ajk3ZlRORDBjUkpMb2IyakE4OWxhNUJjMUNVUGU0bUp1c0NuSnpaUHd3Uncz?=
 =?utf-8?B?amY3MVB1TDNuSEkwcW1XTklVTWkxRHJoaEdGYVM5RlNNbnNoSHJhTEpaR0hD?=
 =?utf-8?B?ai95a2crZHNueVorcEVEMFk5clIzbENxc3JybWlHVTRrYzU2TGpEcmltRDl5?=
 =?utf-8?B?RTQzMnRlY2pLSFVsQ1RWQWFycTVjeEpUTGpjVDZTanFreTFyS1pTYUR6eVhy?=
 =?utf-8?Q?tGmEA+1Hrero7RHi0O896S+uX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 999d1e15-85a6-4cdd-4770-08dbe7c1101e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 23:00:58.9471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5UoBLCjusi81aHSp68+EahXorGSmewtDKvmKe94XBU8CaVr51d4nnsgjw4jqgLqahHrLsoAAhlX00Sk+np5bQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6006
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/2023 16:57, Alexandre Belloni wrote:
> On 14/11/2023 18:15:02-0600, Mario Limonciello wrote:
>> On 11/14/2023 16:28, Alexandre Belloni wrote:
>>> On 14/11/2023 10:06:36+0100, Pavel Machek wrote:
>>>> On Mon 2023-11-13 23:38:19, Alexandre Belloni wrote:
>>>>> On 13/11/2023 15:36:28-0600, Mario Limonciello wrote:
>>>>>> Now that the merge window is over, can this be picked up?
>>>>>>
>>>>>
>>>>> I'd be happy to invoice AMD so they get a quick response time.
>>>>
>>>> That is a really bad joke.
>>>
>>> Why would it be a joke?
>>>
>>>   From what I get this is an issue since 2021, I don't get how this is so
>>> urgent that I get a ping less than 24h after the end of the merge
>>> window.
>>
>> It's possibly longer; but I don't have a large enough sample to say that
>> it's safe that far back.
> 
> Would this help this one:
> https://bugzilla.kernel.org/show_bug.cgi?id=68331
> 

The BIOS cutoff is set to 2021 in my patch, so unless they have an 
updated BIOS for that system I think it's unlikely to do anything.

They can certainly try with the kernel command line though to see if it 
could help.  If it does we could add another case for it or adjust 
boundaries.
