Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E43178EBF9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 13:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346118AbjHaL2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 07:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjHaL2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:28:08 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6213CE4;
        Thu, 31 Aug 2023 04:28:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8GnayPVEtR/Sj2N3YgrAFMOHQvrxSznR/VVL+fICQh0dw8SVPN2EBfWRzvK+O2+1vjqTJphG+vbabBYB/+o4mo96u30QFEnu5/LzN6B5PUlKkt34iz17Pr+mquyicqM961/cJ/2ZanfPIaakT/QUGv9envcNfyTzdzD3SMkUNiAekHuP4sWOkwX0BUguk7FKzBB2znmQGRFu4LdQGeIsfNqs430qg4cv6nIBAGp1YOsIid6UvO/aaY6M+8c+4TYqtD2TrtlLU92bMAdE4VKFDGRmCO+hM23RVkFUtrNhxoy5eThUM0UGMwt3V8suj9ifJVnmC/XKkPtYbvo88CjOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6JbPnQ5WXKyJBqYifVJAqdFQwZtxh4rP6S2wZBYvaU=;
 b=MDaJObCgv5kfZgJs/hb5l3PtgH2RILttv1NLEaPoY6jEwiUqMv+c+CQe46RJpuxqeoM9/iaD2PfsNhI/+aUo9ULXv9xjl5p+1L1GgiWibx3inFF+9j0sUdzkOnFsw21TOn7e0ovy1XLdqMtyb8JIsUFPKq4bvq/Xaae/W+dRQ2MUIjY785ycm1/4s1azNi0LL0ZucxpbnIHVK7hsXqc+F58vGTZHA3gISm/tuMJxfKSlwcGUXE3cjnbR5rWffxKacayShsXikmqVygEMLlvze47IRONoXTABM+ylr9oRzjTdK7vDST2WDZpsKhs62wfIkhCTotCp2PCfND2YkFqHiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6JbPnQ5WXKyJBqYifVJAqdFQwZtxh4rP6S2wZBYvaU=;
 b=DknbmurIuXkVu0ceE7J6h1QSdJ+bbaDHJUO1RvUOP6kzPE3njUf3YvR1xjX/b1OaguVdSQL7ziyHNcFYtolSISSHREgCKTVPNLtUXwiQeQyc3cMTA0ooGvLXaJsdC5EPlZaq8tla4ddgwsDO3ng5z/fCZmCEVynsaGWZxxs6Sg4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL0PR12MB4852.namprd12.prod.outlook.com (2603:10b6:208:1ce::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Thu, 31 Aug
 2023 11:28:03 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 11:28:03 +0000
Message-ID: <2e7637b9-0f84-41e3-bc6e-d22a74b53c74@amd.com>
Date:   Thu, 31 Aug 2023 06:27:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Fixes for dynamic boost control for 6.6
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     thomas.lendacky@amd.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230829150759.156126-1-mario.limonciello@amd.com>
 <ZPBXL0OVXMpp/BUb@gondor.apana.org.au>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZPBXL0OVXMpp/BUb@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0066.namprd05.prod.outlook.com
 (2603:10b6:803:41::43) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL0PR12MB4852:EE_
X-MS-Office365-Filtering-Correlation-Id: c5603179-1f25-4cd6-347c-08dbaa1556b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lrEeD2o1viFyfRbd9amvJfEXN8uBezMTNTup+3LsiU9tFpxvWnB5cv3sT0BnC+1UGWlP48uFjdbk+jOqaqd2J2QXtMgwyYra/Atgh1YnXU6jwgHFwHrqZTwPO6yEML+1QJkhuQyZn7Lmc8EKA+HaIDqB08w7jlAj9UItHyTZoaALDDPaBNXv8GbzRZAOEHrYXFeYFkHUARW4+t3i1gsk44/W/BmjEA4WVCN5nKo9VACzfUIxBUfzLkKRprhER/U/6d9luc4a8Hoy/8WULvciUfHNjr2feJL9FDQW7N02ef+pALpe+FXtWe5JPPOHzNTlv+eZMxJx8y0R4/S7xGuD4INpU7ySiKUnle/gCC272WGAt4cujYy5co3F3zCICogu7FEwvp2mqM8svoTeloN40F0Yp5Ee6u94dvcJ3805luZ7zpXbE7yFOUVRCcLlCYFRZWWXSekMqrv+7Q+Ok73k7NgkiBB+vZ8rtkPDIKKcMJdfY0l6KJUGtjwQLN9A0UovYLmMyRRD91ccNNLMMqWQpCKN95hGfJz2/Nowqvz4XoVqJhKCUxjY2i14lavCQsP4o4qTOQMyt0BrJ83wpf52Yb1v+4TQtFdqkmJ7jRs8knjxWULYuV+DBMZjCT1fbIB+atO2Et+jI2nnPyXeZABR0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39860400002)(346002)(136003)(186009)(1800799009)(451199024)(36756003)(66899024)(41300700001)(38100700002)(26005)(66476007)(66556008)(66946007)(83380400001)(316002)(6916009)(478600001)(6666004)(2906002)(53546011)(86362001)(5660300002)(31696002)(44832011)(6512007)(8936002)(2616005)(8676002)(31686004)(6506007)(6486002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFYvR3Vic2ZOcTBBSnlxQVNHSytRU3k3UE00Z2NmNU8zdXJhQVlHWXVuZDZp?=
 =?utf-8?B?Wm4yTnFGYks4ck9oTlVyV1IrVCtCS2htVWNlbVA3anltRTdzc0JyNkE3V3Fo?=
 =?utf-8?B?YnZ2STFrMjlsK2xEeGRnaWVNajd0bnJuN1hkWnhQNS8rWVZPcG1wWEpGd2Er?=
 =?utf-8?B?MkwxMTd3ektoWHI1KzVtekNWc280SVo5eW5mdHRnRElNc0h2a1VRa3NtMk5s?=
 =?utf-8?B?T0JjYjBZcFd1R29QSk5hSFRhUDFrd1AxbzdyTm5scmhPM0RVWjRycGZEUHY5?=
 =?utf-8?B?VDliWm9zQml0cjFBU0JrZERWcGg3QkZFNGdqMlhYdmpjSTNUWCt2TStsejBT?=
 =?utf-8?B?UXpNeHcrd2k1NHBXdU5QQ2oxVVVOdDhOS2FCa054N0QvV3hjblQvWUlHaGhO?=
 =?utf-8?B?Yk44RUluTWExc3NEU1U5S0ppUlJpVGZxNExyS0k1cUJrZTJLUTRHRGF1M2Zk?=
 =?utf-8?B?SnpaeC81TDB1ZjJXRk96Tzk5dGd2TVNXcVVRY2R5RnI0eVBLZ1ZGZk1GOUNE?=
 =?utf-8?B?QjZRaEl0MVlScW1KUGUzaCs2Ry9YeGk3aU5nUkRiNDgxMnVCL3VWYU96S2Jv?=
 =?utf-8?B?amExSTR2c2JadkwxREhjWktINklkN1dwc0ZyTGFpTzNKbEVPYjNjcDI5OER1?=
 =?utf-8?B?R2gvR2s4emM1UXdNMlBiMHdod2ZVT3VKb1RZT3U5eWFHaE1EZU9rSXBzeUE2?=
 =?utf-8?B?UHBsYlN0QVkrQ3NrWGkvcWZCWFc3RG0ybEJxNWRmT2Vxc0hHV1ZWdVdEMGFa?=
 =?utf-8?B?d1UrZE9ybERISDc0Mnc5cHZoMmJMNXdzN0tLaXE1bTBUazcrZ2JtYlliVldI?=
 =?utf-8?B?SmhkZEpncHVVYUhibEVlNFI5dGtZYlhxZEJZNkM5bmhIcjR4bU9DVHprN2FB?=
 =?utf-8?B?dUg3RGhKZ3NGMVlwQjRvYnUxTUdXb0ZoeVRKbGNWUXlTV1p3SklRWVhaV2Yr?=
 =?utf-8?B?UDhvNDJqekJsVDAyTnA5TEpXdUk3N3JzMzZSQTFCNTlRdWl5NnZGbWhNMG1O?=
 =?utf-8?B?amc2eDB4R25NcCt2aE1YQzgrb2V6SVNNY3ZsUnhDRm1lZitzVjJoWC9jL3FW?=
 =?utf-8?B?M1hYcU5WUVl5emhLQ3VweE4xaTJBRXpMT0dnNnJCRXlmMjBzblhhblR2S2Jt?=
 =?utf-8?B?TktuTW5EUmQ1d1pTcTE4aWNReHo0TThuOENVdlZTanhyMmpsQnBHN3psUk14?=
 =?utf-8?B?QS9lRlZhYkUzTHlGbkJlL3BRZkRqc1BmSUJkL2p0aGJjZ2VWaUdkQk9DSHR5?=
 =?utf-8?B?U0V2L2dtblNBbkNOaGtwVUhGSFV2MTZSRHEvV1dRcjllVFFPekZGSEQ5MnNa?=
 =?utf-8?B?QjRVNjJtTnNJbVRCek9mNjRTanBrQmVtWmhPNHltQnQvRjZhaXhMeTk0K1Rl?=
 =?utf-8?B?MmxOZ0FNaGxjanlmM2VyNnBwZ3lQdXlienVPZ2dwNldlQ2FDai9pU3M3Rmhw?=
 =?utf-8?B?bXNZRXhIWC9qODFJWDlodXpHeUtURmx3ZzRDbDdPR1JnM1V0TTRSdnhSdG92?=
 =?utf-8?B?dXJDZzEzOGlOUmRaN3ViWUFjTzV6dllINHFnN21CZkZLQmF3dkVXZklFRlU2?=
 =?utf-8?B?dmlLRkk2TGlDck10cVExaE1Ycmk2ZHptYmpTaU4vU0o1aU1ycTU1QnlTQktM?=
 =?utf-8?B?Z05KUkN1ZG5LT1pVUmhvamU5eGpxZ3NvbU5rTXJJNnIxRkJqWUszM0lyMFZ3?=
 =?utf-8?B?T3BZS24zQWhNbSs1eHUzUThFTk9YUnNYTk42Yy96REtKVXcrZ3BIeXMxcVlP?=
 =?utf-8?B?cWx1NmhwdXlxS2NjV2s3TEdSak5YUkZQaWZRcldlL0pqUURVSVFMWHVoUFNy?=
 =?utf-8?B?N25laFFnY3diOE5uLzEvS3dzbDFTZzNxem9DUmQ3ZUN4R29nTzlGUEpoVDht?=
 =?utf-8?B?c1o1REUzUFl0a1RkRVBGYlNoUEg4K1JmWnpHMDNRRXo2SUFHSlIxN0ViTVR1?=
 =?utf-8?B?WEk3ZkFOZWRtZnhRYVRIcFR4cll1UlJLT28veWVvazMwKzZKL1hFYUVES0s2?=
 =?utf-8?B?VmpBOUFkNHl3MlpDM1NzWlRxZ0xMREZUVkVRdG9RNWY5R3hNM1BxdXJGN2RN?=
 =?utf-8?B?SS9wZHM5RG9EelNNM1FhT2NteW9qQmlYWFFySXJWd1dSSzRTdWt6M3NKcElt?=
 =?utf-8?Q?JxIlQmqL3jikfXu6wj8HaQHJh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5603179-1f25-4cd6-347c-08dbaa1556b7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 11:28:03.1548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SM2W/gHxo0uwjgttHYIfry+O0zEVqu6gh4yyR0wT7uW2oeQdWBBAyeduwljjtrrRUg4uLqsrWUZYfTRwF5Zjrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4852
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/2023 04:02, Herbert Xu wrote:
> On Tue, Aug 29, 2023 at 10:07:54AM -0500, Mario Limonciello wrote:
>>
>> This series fixes all problems found. Ideally all patches should
>> be submitted for a future 6.6-rc, but, the most important is
>> "crypto: ccp: Get a free page to use while fetching initial nonce"
>> if the rest must be pushed to 6.7.
> 
> As far as I can see it simply means that the new feature of DBC does
> not work.  If that's all then I don't think it's an urgent issue and
> this can wait until 6.7.
> 
> Cheers,

It works; but it's a failure rate type issue based on what is in the 
page it gets.  I didn't reproduce it when it was initially submitted.
I only noticed it when testing from Linus' tree.
So I suspect it's related to other completely unrelated code that now
runs before ccp is loaded by the kernel.

So some boots you see the character device and can interact with it, 
others you can't.  If you start with 'ccp' loaded and it working, then 
unload/reload it might not come back.
