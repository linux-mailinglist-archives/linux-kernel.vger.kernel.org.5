Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33ADE78A3AA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 02:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjH1AfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 20:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjH1AfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 20:35:11 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F4611C;
        Sun, 27 Aug 2023 17:35:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvbClXiStc+yD5FGPju6QPmHjoENUpV3tVz4WlD2l3XSqH+MqojgMBkAzqb2i9QEaz8yxuV4xxEsJoKUIMtTEOIywtL0fuUAxi1kGxclX1xuQq3A6hNksjtFtPeJ9/GCsQxf0zpa5cZzXObValCXBIdB7YPtIKnA6Tpcwj9c8Y18X5neTZqeHNoUvzdClr/bQg3xpZwaGqykjeJF/t6jYaryErxycV6G2M32jqnukj9C9oTJlv1AbJSSNYPfZdJLb75XSLJeFhHatsOsAT0CmmMwT9oobOecnb+O99mzfyDVqWI59ALzl+8OpBt84AezWwcNNMPWiZlMQeuIsopi+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqUhjxAnxwE3Bc4oxRRlScQoqfultbb++6EaqdLWbYQ=;
 b=W4UCSk3I8EjZEYdw1xBZGQiy32fIsQFAf70Wyal/1Y3SVAbIjXUMwMV54406xHLHLMCJ6yYNjCqOYj2WxFjGApaITT1wKb7bNcsvFlrWRgLhYmbjK8TBhi7mWFXPoxvC+0CE968vfJjJbEVdcK9tX/lhhzyWplfvgRp5b2rFs4EWWRMTc7K1ZkbUXIxA1wfdYm/y2la2XnFU/wh7pfjp13XmUIw3fV2voJjdefZ2gwVZM94VGhMn7p24zR5nM0CORCHKh2L1rOmcUj0OHGdGeLelluQRdtgItdKC/cgTCAij/u8G4/w22GARiZhPyk96z+HHhBtZXG13U3hsSuikOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqUhjxAnxwE3Bc4oxRRlScQoqfultbb++6EaqdLWbYQ=;
 b=kXAfy88M9Yftt6/+zbK+Xp6lqcV2oLbAQSUYjFjTqOcJWWI2l0WL+9/orKwn5kZ6kEvhGcgSjAqZh65Au5D5va9Q8ZTGF2VFXu+vOENptVYva73jVcc5wqVR3f5X5quhrDEBkfNZZdr5v0mRJIDuk81nAEYSGPVv3Ik5z1g5BzA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL1PR12MB5972.namprd12.prod.outlook.com (2603:10b6:208:39b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 00:35:03 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 00:35:03 +0000
Message-ID: <f6d75cac-2556-484e-8a2c-3531b24b1ca5@amd.com>
Date:   Sun, 27 Aug 2023 19:35:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tpm: Enable hwrng only for Pluton on AMD CPUs
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-integrity@vger.kernel.org,
        Jerry Snitselaar <jsnitsel@redhat.com>, stable@vger.kernel.org,
        Todd Brandt <todd.e.brandt@intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        Patrick Steinhardt <ps@pks.im>, Ronan Pigott <ronan@rjp.ie>,
        Raymond Jay Golo <rjgolo@gmail.com>
References: <20230822231510.2263255-1-jarkko@kernel.org>
 <705b9769-4132-450b-bd47-2423c419db2a@molgen.mpg.de>
 <CV03X3OEI7RE.3NI1QJ6MBJSHA@suppilovahvero>
 <1eeddbdc-c1f0-4499-b3d1-24c96f42a50b@amd.com>
 <CV3J3TCMB74C.1WA96NQ9J593U@suppilovahvero>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CV3J3TCMB74C.1WA96NQ9J593U@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR2101CA0013.namprd21.prod.outlook.com
 (2603:10b6:805:106::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL1PR12MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: 5682b475-9d0b-43ff-67eb-08dba75e9e8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4menZ73oRVZnnEXSVEUTsZ/7eSdqlLcPbZE3+7bccQdiy5PaJEVPNNIqep3uLSbrAI5eBSrfVQ0ofSkRqh7bv7I9x4SFTShX6gE365XW3j4Uk+0K2E6JZqzWhra3z/oaC9O+HIm2yx6BtDGSr2z584F4G1XAFcEVwg+PFoDWjQnocsMPnFSP8OhDNeR3n2fvMM5GghvijciXySEodnPnJLTgBI24chfo3vJiBARtqVu8/JqahdkqiXI3lPWgjRbt3buPwXvTwIOfxh/TczOEXLu7zgO1y2GGs0QGLzTHjrVxSkuB82kKSNiDwURS+TlfZ3axE/gs0xVpDFHl4ATDGxL7oLHKVAGkvcSYHu/Qu8Qu5xp473ZsUa/54JMKSSz0nTGsqc15EM2duThVcRizez4S8QLCNtHZaoJju2gA7dup6vC+7JRYLc5Uyf4lcOpj8axo4ZWnk9J5Q3mC9Tx/Kv4gGmvDj6E8nUQ5UGRpAykeanAIJlmNz4sp0x/5S2G5g3P6/FBkkxlEqjVxpjdG5uD6C/YqElizAcBXljaJTS5viCiIrQ2qEcwu8Tv4fIS+zcwU42KCW7iF7a3hmIr7NF+0MBcouzYlfQWBKEKbLdWDjsUEvGz+49mFeqaGje1zAvZhg8qpCDFPPKD3ENltnanc8QwhCrzq2LsX8RnvKlk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(136003)(396003)(346002)(186009)(451199024)(1800799009)(31696002)(53546011)(6506007)(6486002)(2616005)(6512007)(44832011)(7416002)(86362001)(5660300002)(2906002)(54906003)(38100700002)(8936002)(66476007)(110136005)(66556008)(36756003)(4326008)(41300700001)(66946007)(8676002)(316002)(45080400002)(478600001)(966005)(83380400001)(26005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTNHbDloS0pnWUlVR0REWXpKMElNdzhKTzRuNEZpNDh2VTVYdktHaTRCT2dq?=
 =?utf-8?B?TjdDM1JicDRhVXpheGt5Vm5rMmRvK2dVWEN6d2tNWUhNRkRGaGtLWHJxQWk3?=
 =?utf-8?B?QnpCbitlUmFzd0RiSGt6Y2NhZWE3UVNpSE5KN0dnbjEyV1lYQnlvQ2Uyb2FI?=
 =?utf-8?B?clRwNVREdkJKRG1ZWjQ4c0kzTFVoRmFBSE1hWXg0dnJoYVVlckpXZlU4bms3?=
 =?utf-8?B?Z25oZit5M1c2RkRyckY0NFdEZmZmek1BcEJZTmc4MmJHc0N0STh0U2VUL0Jo?=
 =?utf-8?B?akJzVDZ1cHR6QkR4QzdhdlNKTVVIRTZmTWQwR1M4ZmI4QXlUTWJDN2Yyclkw?=
 =?utf-8?B?UWg1RDg4MWoyY0g0emRjNlNQaWdxclFNYmlkbFNBYThPWmdYemxvRnlwa2lO?=
 =?utf-8?B?V3kxNG4yNTJpeDk1S1laZXI2N25YU0NYTDkxRE5UYzZNM1lDSGt5dU5BeGVa?=
 =?utf-8?B?SGpuSWYzZU4yNWFFcHNLSThqam5YV1ZRT1Z4YTFaWjhHSnJzbWV3ZldPeHQ4?=
 =?utf-8?B?LzlsK292czYwVk04aTFhUW0zZ0kxdUdoR0tsQW9ML1JYTTBzd2p4WHdNSlNY?=
 =?utf-8?B?ckVsNUFDY2xiNnk4K05PNGsvRndjTjBMQXlocXFxM29ZbGJsUXI3QUdsTU8w?=
 =?utf-8?B?bnF1Z0hkbHRWNUZINEZ0RVpacHJlQ1VoaUJBaDVuOTJXdkFZNXR1bW9IMHlj?=
 =?utf-8?B?WXUrVlpsQ05xM00wMnZLRUp1OXlSUm95TTZ5MHRpd1dkUzY1R2VRQmt3YVRC?=
 =?utf-8?B?ZDIxMXBHdERPNndUU29TcnBsWVoxaFcxTlNIeHJVTW90NWgvT1NlNXpVc24v?=
 =?utf-8?B?QXE5emwvTG1GSzR1cWdsenIydStWSElEZTJWRnM3bXhpWTR4WGRNRlgzV2I3?=
 =?utf-8?B?eG4xVmNiV1U2RUN6cGFnSjljL0pwTERrMDFuRHdrM0V6UzRtNVNySUUrZWl4?=
 =?utf-8?B?N3F0dUF1eTRETFNvY0NjMDlTY2M2TmcySk80M1J2c2dDbURKU21yZDdTYktL?=
 =?utf-8?B?QS9CblpTeXRWcHNHbGdJZzlORHVSOGdaVUVPZTJ3Y0RTVWZMb1V1S2lKY0Jz?=
 =?utf-8?B?dFNpRDV4TFg0bHpaQUQvQzJaUGJXb2thT09rTW5ESnRmUGdEUlB0dFZBOXdt?=
 =?utf-8?B?RldheUNoVVpleHVXQ2tlZHhUdkZsMi9pbEUyeXY4SklDT0w2dytmdzRsc1hq?=
 =?utf-8?B?Z1hyazk1N2czNFZ5NTFQZXE4bmtFb0dzcmxhQ3o0WmFoZ2MvZEVPNTJiQWFF?=
 =?utf-8?B?cG5teHg4Wnl3SFg1Q0RqUWdtYk5uQ1FOZWlpUTd5OEEzSytjT3BwYzJxK0ln?=
 =?utf-8?B?OWtJR2l6bXg1OWJyR2pGY1BBM1g2dndYK0Ftb2N0NUo2RUxQZ1FOK2RFcUlw?=
 =?utf-8?B?OUQ5eFhtOEdBSVI4MXNidmM1TVVmS1RUY3Y1QSsvQmNvaVMzcU1SR243SGI4?=
 =?utf-8?B?MmxOemJJclAxa3NZaTZyS3ZwTmppcWRTdk1DYlI1RjRKZUk4VmNpOUhTMUhV?=
 =?utf-8?B?V25RWVVpTi9PK3ZIckgwanVRM0xCYkpVN09sWnVEVy9Xb1ZOcFo3YmdwT2FO?=
 =?utf-8?B?OVBPeVFqQTRNbFA2aGlBL3VKcGt2cXZDcnQ3V3Mwd3Z3RzBIcXFZY1RkSFRp?=
 =?utf-8?B?ejRUSk1KUW45eFR2My9sOEFCVFJ3NnpGZXBEczZSdGNjSEQwTU14ZXBPQzI0?=
 =?utf-8?B?ZTBuZUhJby9PL1hQTElmNDlxei9Fc0VyelA4a2w3WG5ueEJ0ckRPeTBBc1VV?=
 =?utf-8?B?SXJzTzY4ajNRNlNyNCtzZ2ZzN3ZDRER3dGsxNlB1NTdhV1BUK2ZKcTNmK1kv?=
 =?utf-8?B?dHNveitDdVVpOHR4bHFHczEzMmRxdkd4bFhUd1RlZHhyeTBzQnZCRFF0YW9s?=
 =?utf-8?B?bEE5cDJPc3ZwYzlwNWR0WStLKzg3Y2NFK2wvTVJYckxpVnRCaWpydHdzcVpB?=
 =?utf-8?B?eWp0dnpaZ1V4TXZSamRUNDE0R0NnaEl4YTF4cFlPVmxNOEE1L0h2ZWhNazhj?=
 =?utf-8?B?anIwaTAvdm5tWndxRTRPZWZ1R2hHK2tGaGhOcmErSkN3WHY3ZkNoZDhnandp?=
 =?utf-8?B?UlVPZFBwdVFqaHVEMU5nY1BZZlNDRFJXQnk5Z3AvRlNtcEV6eWVILzgraUo4?=
 =?utf-8?Q?X8dCHeYbECx+9HtgqbC6DKYuO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5682b475-9d0b-43ff-67eb-08dba75e9e8b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 00:35:03.3867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VKULsA+e+3ZFJlYHvSVngJFDZdEDnmGcwkG6hDhiuxUMKXwiO4fA9afR4vxGiy9iM03+5ZZsXPo9Dqt3boIw+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5972
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/2023 13:12, Jarkko Sakkinen wrote:
> On Wed Aug 23, 2023 at 9:58 PM EEST, Mario Limonciello wrote:
>> On 8/23/2023 12:40, Jarkko Sakkinen wrote:
>>> On Wed Aug 23, 2023 at 11:23 AM EEST, Paul Menzel wrote:
>>>> Dear Jarkko,
>>>>
>>>>
>>>> Thank you for your patch.
>>>>
>>>>
>>>> Am 23.08.23 um 01:15 schrieb Jarkko Sakkinen:
>>>>> The vendor check introduced by commit 554b841d4703 ("tpm: Disable RNG for
>>>>> all AMD fTPMs") doesn't work properly on a number of Intel fTPMs.  On the
>>>>> reported systems the TPM doesn't reply at bootup and returns back the
>>>>> command code. This makes the TPM fail probe.
>>>>>
>>>>> Since only Microsoft Pluton is the only known combination of AMD CPU and
>>>>> fTPM from other vendor, disable hwrng otherwise. In order to make sysadmin
>>>>> aware of this, print also info message to the klog.
>>>>>
>>>>> Cc: stable@vger.kernel.org
>>>>> Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
>>>>> Reported-by: Todd Brandt <todd.e.brandt@intel.com>
>>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217804
>>>>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>>>>
>>>> Mario’s patch also had the three reporters below listed:
>>>>
>>>> Reported-by: Patrick Steinhardt <ps@pks.im>
>>>> Reported-by: Ronan Pigott <ronan@rjp.ie>
>>>> Reported-by: Raymond Jay Golo <rjgolo@gmail.com>
>>>
>>> The problem here is that checkpatch throws three warnings:
>>>
>>> WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
>>> #19:
>>> Reported-by: Patrick Steinhardt <ps@pks.im>
>>> Reported-by: Ronan Pigott <ronan@rjp.ie>
>>>
>>> WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
>>> #20:
>>> Reported-by: Ronan Pigott <ronan@rjp.ie>
>>> Reported-by: Raymond Jay Golo <rjgolo@gmail.com>
>>>
>>> WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
>>> #21:
>>> Reported-by: Raymond Jay Golo <rjgolo@gmail.com>
>>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>>>
>>
>> FWIW I observed the same checkpatch warning when I submitted my version
>> of the patch.  I figured it's better to ignore the warning and attribute
>> everyone who reported the issue affected them.
> 
> OK so:
> 
> 1. checkpatch.pl is part of the kernel process.
> 2. Bugzilla is not part of the kernel process.
> 
> Why emphasis on 1?
> 
> BR, Jarkko

The reason I submitted it this way is because of this quote from the 
documentation [1].

"Check your patches with the patch style checker prior to submission 
(scripts/checkpatch.pl). Note, though, that the style checker should be 
viewed as a guide, not as a replacement for human judgment. If your code 
looks better with a violation then its probably best left alone."

I wanted the patch to capture and attribute all those that reported it 
not just the "first one".  Like I said previously, it's better to have a 
collection of people to ping to notify if something needs to be reverted.

[1] 
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#style-check-your-changes
