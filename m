Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8450877F8C9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351847AbjHQOYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351858AbjHQOXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:23:39 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F311D30E6;
        Thu, 17 Aug 2023 07:23:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpE1gqVC4z+PDq5CKeLTO16QLF6jSSLHusqCkxEqr/m0AIEZ0dR047pzkTPwnu1lLjKpldvNujWX/3GqWXwO1qYTuJS+zTRsgjahWhS97iPTBgJUfot/knzE1lkgzw9GXOjxG2v7Gl+jj9rRrStLR6AlkzYJwqvzdmOoJNMMIROQSt3z6M6dELmNkt7tTrItdcx+6RECWNwqf5pwhtR/KhRbRFvaQVlCKdFR+H34ujWY6ckL/ckZrOYW2PGt9rTA+tW/fth8xSQNpEJBu4gan3jLjOQvj5WfFuHgNoLpqaGZXhXCHbdy9v2t/3np1oXVcu55RsOJf791vL6OTkWSaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slhYnZv551mS0LWVDZJ9ug6PoZXO9pPnSmKF0fFRPtE=;
 b=Y8COYzVDpytoiP9p/rfAlzWJvykort2sUtMhKXMdOBAHwi3GPUPFt5Yk/afrDxNHFr9MrDX/9C7gxOieJyM4IUYEW7iVnXAm2C8vyPAKj3LIe63DtsVcK7dLfCeyPmClNFDPqogi0nHozwQuvkc32TSgcDBYQvi1IObZ/hzonXH0//+ivUNc0qH/ck0kxksCnYCn/gRO7EeQBNcT3/o4v6ABtXrh+aHRRH8IZHF25n4L8LTLOFqZmdK5p2Pd0m6ozN3ZIHXzUqRT9sWO+FgIYSE04bBttdALSaOtXUs9awWtBh1JFFjo7SEsFk/4lsZWRubvunG0+/U3JQq3f5HeBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slhYnZv551mS0LWVDZJ9ug6PoZXO9pPnSmKF0fFRPtE=;
 b=rgqrX0bXJACrFSsdUH+/X6VTSp5zAwbWKqwFoBum0T/vJjJ1juajzf7hdSoytlTheHECina6muHnjjid2kG/8rwe+5rOEEwOagB02wXq2A+FE1vgRvizm/Emrnc5Bk+0f6+uvcZihwSqQBXg9hpGqUsks2gses3jz2iya60d8cI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by SJ0PR12MB8089.namprd12.prod.outlook.com (2603:10b6:a03:4eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 14:23:28 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::93bd:7d4:6a9a:45ad]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::93bd:7d4:6a9a:45ad%6]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 14:23:28 +0000
Message-ID: <3562458e-a1f7-2019-5fa6-11ef647322b6@amd.com>
Date:   Thu, 17 Aug 2023 09:23:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v7 6/8] x86/resctrl: Move default control group creation
 during mount
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <169178429591.1147205.4030367096506551808.stgit@bmoger-ubuntu>
 <169178463637.1147205.7411319721706077266.stgit@bmoger-ubuntu>
 <b84a9ec3-5b65-9334-becc-0d90bfbbccfa@intel.com>
 <b9eed930-1a8d-7cf7-0515-1f9d33089953@amd.com>
 <f7d99da2-7ba6-fafb-e90e-4164fda43f07@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <f7d99da2-7ba6-fafb-e90e-4164fda43f07@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0114.namprd07.prod.outlook.com
 (2603:10b6:4:ae::43) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|SJ0PR12MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: 90228b22-b0c3-4547-80a5-08db9f2d8691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WwKvvpWeh1WEZ6jgdJXLg9XvdWkqxI4s2eY7PzLql5e4aFkwL+5V1UgEMbLivhZboVTa0+QxBtbWJf6RJrno69BW2R4q7BCw/zf6i9et90jGH2sywAIJTEtIb3ZPMn3almkt/4d0zYajaTR9Cm/4h3Ik0A6TelbEPaTEImzEk+lVQtY8Xmv9xFb7QCiGN6yk2tLtMXQsg4jMYDJ2WUlPhdQhpoSp/X63gz62mfL4gTiIdhEHQhtXyeAGRmWj19gDXoNk4nXur0Tua+KJJoogeKQN88DSfA3hV3a8tky0n5/atwnMMjOW1YuZ7vr0xtqctTCbuMLyi2j+kgh0bM/7QdmCUczhld+vjLgd3rUnkVdvb8AcB5NJAGUB/YrD5dlnovdBJ87zslRKG9aAwq/JJDKBPkv/OhK6S08T/9F1vDJPLQdIG4pechniCG6IT0BfiWXlCIef6bZbNGlNqf/1MGgSj8R2NmNHRGZy3cQKC8PXPhKBG6nhAGVPwCb07w7wAaOpH/MgRrxU2QUd2Od8cwyVhZTv5QY/jL7MS1oE8C/SFlkSzGKqYCkIFcDsqSy7+oCtWQ4tyNp/KArT4e85fZHLWDW/HBPfNnpoehQAM79NHLO8Xy6xzJ9Rtfa55mUpFnfyw5enFVOEoh1Ztt3QcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(31696002)(2906002)(3450700001)(4744005)(26005)(7406005)(86362001)(7416002)(478600001)(6506007)(36756003)(6666004)(2616005)(6486002)(6512007)(53546011)(5660300002)(41300700001)(316002)(66946007)(66476007)(66556008)(31686004)(4326008)(8676002)(8936002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3gxQ25FQVN0bjZIM1lhc01tMkdHYVBGWEVsN0FudkRHODNRTnZoYUtjTlhQ?=
 =?utf-8?B?LzQ3blh0R1IrRGRQR1k2cXZnZGVzdlY5K2pUblg4SmpyckwvbmZFYzl2NjVK?=
 =?utf-8?B?cFVRQmZ6eS9acUZjRDVlKzhzK0pRZWpobE50NC8ybUdHYlVyVVhXN2xkdlN1?=
 =?utf-8?B?ZUY2YmRuS2pFd1JhSWx2dUxjd0crN0FZUTdFcHVkRmZUUUVaQ1ZWNCsva2J2?=
 =?utf-8?B?dk9wbjkrZ2F1djE2SW5GaUxhaFEzVFRrMzRLUFYrcGpsa254TjRsMmNlVDRH?=
 =?utf-8?B?N241WkhWSk1CeGMvV2RNQ2s3ZEd2OURYU3NzYkVLcHh3cStCdktXS1JiRTIr?=
 =?utf-8?B?UGkrNmtYb2Erb3dCRkNNSFZ1a2NYcWJ0NnZQaVhPcEtDNHdBdENDMUpQajN2?=
 =?utf-8?B?UUtvUXJlaUVpcDc1cWhMZDJXTzc0NnhvM2ltT1NEMkg4UHVMdS9SM2FuOXla?=
 =?utf-8?B?MDAzY3dnazN1eFVDVkNXalM1RUdOUWcyUXB1dmp4YnNZQ01lZytTRkl0Tkx6?=
 =?utf-8?B?Y204NXRmd0dmTlV5YlVQVlNnaVBDSE5kTE9HY0RNb085bVB1MldQZXNPUFF5?=
 =?utf-8?B?L1dUS0V6R0R4NzJrVHpZRzUrZUVmcFdLcEFaczFhMW5hMklFTEZJbXl4UjQ4?=
 =?utf-8?B?Q1d5c3drRXYyUnR2RHQxbGR0S251bDZFN2xVNjlJSHpEL3NxZnpCWVR3bDJF?=
 =?utf-8?B?SFE1ODc0UFdUMkhFUk1ib09lbHZUZVJSeHY1S3R5bVRPYVhqdE1KVlRvaTI5?=
 =?utf-8?B?dW1YQ2J5RlpWeTRDSFRBZTJjcytvMWtNOHNCb3c0NWdlTTQyN0NRREQ2aHJp?=
 =?utf-8?B?TXBWMFZTMHlrTnZ3VUlIMWNGdzdpaFJHVTNPbWpsNVBVRFg2Vk13SEovVkxu?=
 =?utf-8?B?d2paaFFQdHYzd2d6SEpnN0VEUmNMREE4bEhqNmtjTmpicGdpSG5velRxM3Rt?=
 =?utf-8?B?MHFKaVQ1YllCNDF3YUkwVy9XM2Zvd3VDTHNuYjNPMDYxbUc2d1FLbzNLZ1JT?=
 =?utf-8?B?WTB0aTFEeUl6RlRnOVFxY21rM3BMZVpnYTBPUjlDVGNOdnY4Y0lZeGZ3RGFE?=
 =?utf-8?B?RkR5ZXFFcnkzZDlUODlHdURsVXEyL0hMRlZ5YTNCL2RvTkp4K3luQ3RmUEc1?=
 =?utf-8?B?aU9HOVMwTncvM0JrL3V3b1cvRDFlNzJBR1VLRXNFUWJXS0l6MW55Z0hxQjRD?=
 =?utf-8?B?ZTg4bkMzdnhaKzJqNm1QT096cmxOT01BMG1CeHVic0Q0OXh3UjdLV2x5Z0x5?=
 =?utf-8?B?NUlubUZCbGpJeXhLOTdCWUJEcWxmUExsLzVzQm9WbVAxVllFVjJhakxHVWpT?=
 =?utf-8?B?UHQzWWtnQVFkSVhYdlVreGVFNW41THRIbHFRNmJoZmdqNzR1WnpYdXYzaHpk?=
 =?utf-8?B?ZDJFQVpYdlRZcm5vOXp5bkJDWEFSVVBKYUN1aEpmdUhWZjBNZ2NvekpFRm8y?=
 =?utf-8?B?dmtYcmo0eUR4bGk1ZElCNEVBVjRxczl1YnByNUx6WnNXRnpxaVVJb094QmtD?=
 =?utf-8?B?RlpNZHc0NWZ3NzdZYU5SSFhINEFQeFV3eFNINGVjQmxUMWx1OHNjaGJJS2o2?=
 =?utf-8?B?dTNlZS9yVUd3SVA4NDBKSzNJQ2h6SHFCSHcySjMyMGVkWmJ2aG9VWWxGUGdL?=
 =?utf-8?B?bi85dmZRVTdoVHJDUHNGYXljR3g3bTArMGQyZXNOSW5SeXE4aHNmdDNOa0tj?=
 =?utf-8?B?Snk5YUJ0dW9iOTVLQ0kzS080eWxoQzhxN2RLeEtuMk0raGhVZnpLK29COGM2?=
 =?utf-8?B?V05QMlZyS0NhQjJRT1FBaGJtOWk0Z1oxeGg0enUrUWVQU3IrU2FQS1N5bnlN?=
 =?utf-8?B?MlVuc2NiSVhWM3YvTmFzV2liM2swUG1kZkhvdVhoNEpqb09Db3BBZmJBaUFN?=
 =?utf-8?B?M0FVVjlVYlRDTmI2QjQ3aUZrQlk0VFVuSnpERVRyNFd0dXl6NnlrVG13b05J?=
 =?utf-8?B?ZE1CYnlrL2daNjNvNFNweStmTU9ISDdienN1RGRpT0kvcHpQbG13S2lZb2pn?=
 =?utf-8?B?bzBVMldTMjduTE5aTzZsTUFQRkF5K3RMeXcwYXJQOHB5RjU3UUlYekh1ZG9W?=
 =?utf-8?B?YXpTNzNMTEk5YkFKTThQK0pqblFXV0tKUm1hRUhoV3AySlAvbTc4cHZ1dlIy?=
 =?utf-8?Q?UlNk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90228b22-b0c3-4547-80a5-08db9f2d8691
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 14:23:28.5229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBDBjciZHzWSQsaE/+heb5bbBj8fs3z4Bh4durCFdX3kGLob1siNvB4puYennXCy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8089
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reinette,

On 8/16/23 18:02, Reinette Chatre wrote:
> 
> Hi Babu,
> 
> On 8/16/2023 12:14 PM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 8/15/23 17:50, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> Please do note that the subject is no longer accurate.
>>
>> Changing to
>>
>> x86/resctrl: Move default group file creation during mount
>>
> 
> How about:
> 	x86/resctrl: Move default group file creation to mount

Yes. Looks good.
Thanks
Babu
