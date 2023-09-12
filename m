Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E3879D88F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237233AbjILSVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjILSVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:21:40 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA735115;
        Tue, 12 Sep 2023 11:21:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lC69xclRV6rNnrvG+3DV1uGMVCE0ZkSxzOzl6PRbk0I7g+VWaKWtwCqNrn1dsowz8VJ0r6FjNN1zMA061fq6+rOxGE7Dzkq6XKl9dyj7uFi3//RZIVtcRwnTx9rZF2gzITdn6fV/CTpVguX6ACeYaY3upd2/U/f6JgDI2738PUmshDZwBoPf7K630YU9+3Pp6zxo86vHKDBbGq/YbJByud+VA6mk8xZBM61K8Milnrk+FFA09AQWx4BqudtTIZdQY5VuFawOVvks6bTUOFYo7IAE3ynBgPUztAU1FahGLUB8OhTOJO+ZUyC5Gm/aSt7FNI7CL5pLHLW3T0rfs0gc9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsv5dUtXUXWWtqCwy2qxROCcjm3Vxyenv+a5wm2OltE=;
 b=QC12s9X4gWAvJbk1pV2bmOt4uL3fdd3gvAjb/NqmT7zL2zMgLCcn3nk6VAUmLsyj0Nlfn2qswP3NmnQxGEL0poogHCWAGEJMTrxx0RZ9JPkYBizbRxRFCM5Xgd+pER009+hy0lgCADr8TE4Up0wAtcxrvmuCeJyR5kXNCAyCBEj+d49wkz/c4In9DNyLA7nUAZAvDYoZj3no19DgVUjcSS7AFh6GYhvgEoJE53lN8zTYXTrnITTNB51HDDKijZ4NRiFsyIyTRvw4nxQlBvLcBL4JtCDOJQ2TBMSx3Xs2t/hZDuYibG5wbGgnBSUaWNr4C3uzslyBNYG4XpXt+3K8Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsv5dUtXUXWWtqCwy2qxROCcjm3Vxyenv+a5wm2OltE=;
 b=C5h33i2Na4rZu6DyjOFShoalsIVevCfuBZjW8WlkjrqrxOfNuFPKJp5AVhMguKYvBxo0zheYbuGqZb9LiC9Kc14WcDYg2ETi52vBWXxZTaYMrshdRArE6p2RkhSL/hPN/mGuI0hga+zckg74+OByldJjHMMVVhrmo8Ug3HMTWf8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB9123.namprd12.prod.outlook.com (2603:10b6:610:1a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 12 Sep
 2023 18:21:33 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 18:21:33 +0000
Message-ID: <b9f879d5-55b8-401d-b154-8066cb66d20f@amd.com>
Date:   Tue, 12 Sep 2023 13:21:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] pinctrl: amd: Add a quirk for Lenovo Ideapad 5
To:     Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Shyam-sundar.S-k@amd.com, Basavaraj.Natikar@amd.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, lucapgl2001@gmail.com
References: <20230829165627.156542-1-mario.limonciello@amd.com>
 <20230829165627.156542-4-mario.limonciello@amd.com>
 <1d891d34-053a-368d-cf47-bcaf35284c79@redhat.com>
 <07353676-bad0-44f8-a15a-4877f1898b6b@amd.com>
 <811225f8-c505-7344-ac18-882472ee0348@redhat.com>
 <d232c11d-901f-4ebc-b408-bed042ed8da9@amd.com>
 <6734c409-89f1-89a1-3096-4054be29faf1@redhat.com>
 <f0ceff1c-ba5f-4c6b-ac0e-c4195f477500@amd.com>
 <CACRpkdYGxreyD8NVuKs2G44htR8EixdvGr3+ma=HrxHUP3NDQg@mail.gmail.com>
 <4246946d-40e3-7df7-3fc4-9aa10e1dee10@redhat.com>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <4246946d-40e3-7df7-3fc4-9aa10e1dee10@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:806:20::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB9123:EE_
X-MS-Office365-Filtering-Correlation-Id: d6f2e35d-2ee8-4961-28b2-08dbb3bd17be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wRlgTl6jeWqB8/95Jvblp2CjB4EglOyTDsgTfm+UoRtEvtJeRIlioWaEvgXQC2klsczpykLXnAIruCYR+P0q9UPXn59rGObzH1s9oZg6Y48cewUyytmjTTo6DlKGy8XmKxsvXdABfP87SeHcoEvnMPTm4F74SvQqeZnitDkvZ2F7AohWLUMDxlgVB6mdSm2oMB8qkL6Ok7eiOT3eTDr6yY+18/bXb5CU7Bbts3EIcHLmKjsXJC88fCeD31j8zU1vFIiASH9fdIbEfjrqfD+dqkklBg4Yr7gL4gYNZE0aWVqgN4CwoVgTMz0VygAhHe6rVdurXbTzyTls96V3XWBZZM4Vb+onq7UKzDrkbOPa2ww27YvH0eGVZu0HlNetes0RATD43NrMs3kE5BPr9Zesju2uf8coP+Vxcynd0gBM7G4QNo5U7pUxERr+ha9e4wZLvnuZGmmVJSoB1ukdYhs8E5S7Elj3w17TVM11IThEtOlpzKJHYAU73EQ0n8lh2fowYaXnb5G7+iT3jvuc6UbCk9sDoiURNCSuGiVz06Ne7DqoyXQzPxh13MIULsWDRLwRYLjfWYqfctf5RoPcCO9dazpVr3+iiV5GHkfBTRfrHm2SirCwSJ5ZGL7wAND8ZthhjU+QiaEeKQ+xXPVos+zaQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(451199024)(186009)(1800799009)(6506007)(53546011)(66476007)(110136005)(316002)(5660300002)(6512007)(41300700001)(44832011)(66946007)(66556008)(2616005)(4326008)(8676002)(8936002)(26005)(31686004)(478600001)(6486002)(83380400001)(2906002)(4744005)(31696002)(86362001)(38100700002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVNRZE95V0RzdWVtOUd6dmtYaTZxUjhIY1NETjZRM21Lcks4Y2pRakF5V1Qr?=
 =?utf-8?B?THJhMVBWNXNBUkltZU53NmN2OStQNTY2emQ3cm03dWlMdk1ZdlNqL3BiTnph?=
 =?utf-8?B?S1FkeitMSk9LSzVLYW1VbUtaS1g1YTZKa1Zwc0tIWTZ0UFZVYkdPMnJRVFE4?=
 =?utf-8?B?K2ZmNGRpUUZ0ZkxSU2dOK0JKS1ZLa1hFdmgwOHJhUXVxK3BwUmRqVTFDZVFh?=
 =?utf-8?B?UWJHMjJPazhQWmkwdCtHbW56bU5MWG95MlRaUWNJc09iQVZveEY3VUpwdWRt?=
 =?utf-8?B?Z1RKUGkxUngrMTFkSFh4MHhuR0NRak1HNm5jdWgra0hLTms3bmZ1MGg0Q2FF?=
 =?utf-8?B?QWZYWllKVDR5aXhEVkU0a09TTTlCSCszQnkybysxZ3l1MWpiMUU1ajdMZHBv?=
 =?utf-8?B?NFgrczhQS3ZiQmsxZ05QRGpSc3RVS29mdENEc2dJcVpVWTR5RmU1TjNiTTRq?=
 =?utf-8?B?YW53OVFQdGNjVEdMN2c5ZjBKdDRhMWppTGZ6VGZ0RElHREQ0VFFZUWNlUEl6?=
 =?utf-8?B?OFI5MkJmaGVjM0tDSGhwV3o0WEtYNU9DK1R4K0FQWE51WDVGcHNzK0Z6RlJx?=
 =?utf-8?B?NEZkU1A1OVMwRHZkanc4MGM3dWU1MkhTbkRNMm1TS0tuOU9NVi9mUFZGVHV6?=
 =?utf-8?B?S2I1bGJJRTAxLzhnNDU1bVJGNTdJQ0ZicE1GU1ZyczZmNys5WnhseUoxTkV5?=
 =?utf-8?B?dVBSNUsxWlJPNkVkbXM2RzVPdkh4bklHbmNxVzFHZk9YekdUa29uUTFTK0FE?=
 =?utf-8?B?OTBzWHRuRGtwMTBvZ1ZkU1UzSmFudTczcWUxcTU0QXJkeCsxWDVEbzdjVmNQ?=
 =?utf-8?B?cnNYaTh2UjZTYXlvTk9VUEdYWVhhbWQxVy82eE9IMHppWXZxamhnWnhUMWlZ?=
 =?utf-8?B?T0l1MGthVnE4b3cralMvQTBtTkd1NDJDVUZmWkh0Mks0U2dkRnAvL3k2NU1G?=
 =?utf-8?B?aHk2aGVaRk82ODJSN0tTa3g0T09mUFRQSGNjWHg0eXBPVDRxcUozc1hJTzRp?=
 =?utf-8?B?bmlvNG1EMkRQMkRYRWpsMkJDbGhmSDNiaEFaSnBrL0ZndURoUGNzSW9JNGtz?=
 =?utf-8?B?cHRlTko3N1JWc0lLd0x1VlpHc3ZkNnVCcGIvYUZmYXluRDEzNFM5clRIWFc5?=
 =?utf-8?B?aVJtV0ZhQzFkY1o5eTRZU1VwWldMUE1XV2RqZVRBeS84N21pUm40dlVONkwz?=
 =?utf-8?B?dHNjeVNXR0lZd0lKV1JJcmU2RGQ2NzZpUlJHMjFhQkFxMXRoOG1DdDMyZkxk?=
 =?utf-8?B?d01ha3dscnBuSVozSzFsL0hRNkloMW5iakVBUkRQS0U0cXhRUEtkdFNmOVAz?=
 =?utf-8?B?WENlRjFadnB5Qy9XTThpSFhZUWt0VTdxZmhyMk5JU0x5akJGTEx6WUp1N1N5?=
 =?utf-8?B?bEZVZjZZMFAzaExDT2FZV1lrM1BzSjNLaW1tVS9YV1VQaGhPR1BtVmtHSWRp?=
 =?utf-8?B?Yy9iLzV4T0RLdWVBbi9OQlRYOTBiWXMzWmZGTktET29MbVQzbnQ4eDMyYnh4?=
 =?utf-8?B?UkpldXlqMnNKRFV1ejZGSkdkenRGZStBaUNnbWtZM2Q3akZxS0tBSlFnS0VB?=
 =?utf-8?B?eGNCU2hHdTNFR3ZQcmd1NDJrbnFucnFkcit0bzhkZWVOcERwWnZob3loNkZK?=
 =?utf-8?B?bWxyWTlDcUVENDdxQkZ6MkJsN3h3QkhsZVlIM3RZSnU1ekF0YXJUYkJBZ0kv?=
 =?utf-8?B?MXNDWi9YSkNPMzg5SmRiWFJsaWpMQTNxWU1Nczh0L2VkeVVpODRiWVdvekxL?=
 =?utf-8?B?a3JKV0IxQVZYeUdZTGROU0p2VDF4VDdmVHBDTWtkVDM0Vkl4V0FrNDIxZzl2?=
 =?utf-8?B?Rzd6N09Wak1tK1ZhYmpQTTQyandjTVFYZXNmSnJ5NUxvUjdVenkzME5ibDMy?=
 =?utf-8?B?dHNMRDJoTThLNWlpL0F0ZTU5NENQbTVOQitFRkp0T1pKREdKRlF6WTFueHVD?=
 =?utf-8?B?NnBSZUNTV1dXMG5OdzJjQW8vbmc2NGVBUll0a3lXQW1mVnlXQkNaaS9LRGpO?=
 =?utf-8?B?Q0JIT1kwcjFhcEMwQ3EzS1JnaWdwVTA2WFFpYzJELzIzcE5vbnlLV2t5TXZ0?=
 =?utf-8?B?QmR3NDhDNFNUVGMrTWIxM1pOL09lODNTVkdQbmwwN3hNOWc0dmpQd3BJTWRl?=
 =?utf-8?Q?97CPcYwgX052e58ucQ+7tEI5E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f2e35d-2ee8-4961-28b2-08dbb3bd17be
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 18:21:33.3640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4IyKJBacMod7xg7TjoJTUfcWhmLUKX4XUB8wvULxqqqyhu5zSjvAd16PVz2NU8wiWlqOWIyEeecN1GLchfRFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9123
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/2023 03:58, Hans de Goede wrote:
> Hi,
> 
> On 9/12/23 09:08, Linus Walleij wrote:
>> On Thu, Aug 31, 2023 at 7:53 PM Mario Limonciello
>> <mario.limonciello@amd.com> wrote:
>>
>>> Linus - please disregard version 1.
>>
>> OK!
>>
>>> I provided Luca a new series that implements this approach that Hans and
>>> I discussed and they confirmed it works.
>>>
>>> I have some minor modifications to it to narrow where it's applied so we
>>> don't have needless notifications and will send it for review after the
>>> new modifications are tested as well.
>>
>> OK standing by, I'll wait for Hans' ACK and then merge it for fixes.
> 
> AFAICT Mario has not posted a new version (yet),
> so there is nothing for me to ack (yet).
> 
> Regards,
> 
> Hans
> 
> 

Yeah it looked like we were about to have a new version to post last 
week but there are some inconsistent results that we need to understand 
still, especially with comparing to Windows.
