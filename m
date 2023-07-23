Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289A475E1B1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 14:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjGWMHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 08:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjGWMHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 08:07:37 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E340310F2;
        Sun, 23 Jul 2023 05:07:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0jj3N+fkZRUllGHzO4nzasRKyOMrYDinaCJLSJarqptTWZO4Oe50uU0U6FVceUN0GZ9U+8tn9y621uo1l+cz3if1a0MLq+N6M7yryVyuNczSIyICS7PtgVKI/LWC8mvop2s0R5XF1tghCFXcejYFAhK+Kr8fxzvZFO86Zupk/AeSh4JMKiX62il6dQZym0r6axbFshPhop2FLJOL/ntX/luNfxBb9NppglOp0HanBVZzDJMOmGokT7ag6sff/dXbf+ssRxbVNwN2xP8U7k8PzZStw2ULJYV/w76RwAIPKFX4vnb5vejIWsjKNQpHddZ6YKMgZiRd1LSbZ8txb6Uhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNxzL8V20kQoVIfw0BAEpTYkIyl6R6R3HUcV5MzsMgk=;
 b=IIxHWWZirow5kYv+yUmwZckSNdtvmMxmuWfk0Z1V7mSzJJIQq1+OiJI74aMC1euYpjjJ9fOWPsnQ2UiCLdv5xoT69OAVOs4EMxzoXq2QMttyeB+a2NYVHFmznKXyO0g08dd2oXd7st6R5ctgkL2oNM2E8kZHhKbaqdClIpGPlbVESnborD7OaacMUZAXmpPeLDHwaIFOQOYP7CmNMuf6wpqVcWIXOr79VTT75kv6EzNgX/0I9tvHRJmriHgsCk1Y2AQrqcnqPaiir1VGkczWLPn6oik0R4WezZV2cubkjguRiqVppx48/ZJLZC3zRTezByp9IFIQ48nHsORcWbJ6cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNxzL8V20kQoVIfw0BAEpTYkIyl6R6R3HUcV5MzsMgk=;
 b=I5zV4VQesozAQ2pYzMe5ZXUEKzshwzzyKZtN2Yma2A25zecEsqbvg+aJzAbrR6W0HWhVwiOIRJiLS23hYuaVInsESlVeTwH9Vb93rZWmxYwoIB4rCzUKAUM+5fMjCX81tOl+hCTDJaFc3mFeJ4HEHBFrakwcBMIPe6uBO4sAM8GYr7u3wyvAOnLi8rsRLN3Eq5WozBzSg8TRPYx4SbtGso47aYTKYO8t5jS75CZr7Ea1x+eyFIXBzkOLFrerI1O1SOP4uVqeyM/PvMb7C5Mfydirj3Xgg7xiVIWhSmEFS5LxrPU14paLGPGrP9BiVNjxZG6i2KOYV0xSLegk5JltDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 MW3PR12MB4506.namprd12.prod.outlook.com (2603:10b6:303:53::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.31; Sun, 23 Jul 2023 12:07:34 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::2666:236b:2886:d78b]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::2666:236b:2886:d78b%7]) with mapi id 15.20.6609.031; Sun, 23 Jul 2023
 12:07:33 +0000
Message-ID: <9c0a3c64-2bcb-9b82-1805-a29cb7b7e617@nvidia.com>
Date:   Sun, 23 Jul 2023 15:07:24 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/1] net: gro: fix misuse of CB in udp socket lookup
To:     Richard Gobert <richardbgobert@gmail.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        willemdebruijn.kernel@gmail.com, dsahern@kernel.org,
        tom@herbertland.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nimrod Oren <noren@nvidia.com>
References: <20230720161322.GA16323@debian> <20230720162624.GA16428@debian>
Content-Language: en-US
From:   Gal Pressman <gal@nvidia.com>
In-Reply-To: <20230720162624.GA16428@debian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::12) To DS7PR12MB6288.namprd12.prod.outlook.com
 (2603:10b6:8:93::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|MW3PR12MB4506:EE_
X-MS-Office365-Filtering-Correlation-Id: d068fe99-1d38-486a-80c6-08db8b7565b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9KQMtja0nUA7rLf05BbQ309yA0ltT4jSGNBARLkBYEUmfo1TAiWUYzwatD9CQhqvLp8i2cIsPoqsq5o/JWzDZkFDtg9p9DKsNC7AtKQPrILtpcgC03k3kbdRS4OOz5IDwhuRRINfNkcuw2DG7CC2bl+vUMWNjElcqTjwsMbtHyCxt6CeM1pgvcTAnOgyFbeBmxUSwV0IUqFUe7bkDUxSfDhsohexzQq7GJaclvzZVr0pjkoIeeEU9e1k9ZFTB7031wSkwDWZUnXw1eugwzNsKV6LnPl03evgMmAMfI7L7KnfI323gQHpT0BnE74lEWP9S9lgByVbrbHFgZfFQJNmZcsGG4dqMhzYJyyZ/J3nlz/fNnF12jJaIKszabTDBJc8kSXN9ytZuypgTU0Ql+Z+ZbthktA6fIAlbne1IDE6avBOIVe9oLpSlSIwCXxq3eXOVLV29qml0QabG/5e0ttAHx0CfsTsjqFpdAzvlPcaPjrqNtDnDYrqHNYurGd05XD8K+/toQuf81CnS6M0fg5Zg2AyN+Go81hES5x8bWwCXqcnVB8EeI8sZgCN9HhfSxt0siZkqadw5qlB+XLhU1lEd8UuqbIJ1jcd4ULWtmPCItvfK1prd5y1xgkR3qenTdzMBMKUWCP1Ta2BDPVwPIQnAaZeCvl4Bykna+z+lhV75z0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(451199021)(31686004)(86362001)(31696002)(38100700002)(66556008)(66476007)(110136005)(478600001)(316002)(41300700001)(6636002)(66946007)(5660300002)(7416002)(8936002)(8676002)(6486002)(6666004)(6512007)(4744005)(2906002)(26005)(186003)(6506007)(921005)(36756003)(53546011)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVd1TmFLVTJ6VkREZzlyTlU2VUNzcjNuUjZ3MS9vUmFVdEh2b3pGa01DNG9M?=
 =?utf-8?B?N2dOSTZpelZTV3NhSitsNTUzU2lYekF1MnJLSFZSdmJwZkVBdjdTenBzaFl6?=
 =?utf-8?B?cjRHbFRGT00wdjBZdUN3dUIzR0VjSXhEVTBnVFlYY1F1YUNqV2ZaQ0hrclZ4?=
 =?utf-8?B?T1dFQjIrRS8zQkFlSFE3eGdRTnNNNWwzeSs3SzJYYXdWVEVLVHpSUytlODQ1?=
 =?utf-8?B?dloxSWhxOUpWN042aDg5MThFdnEzMjc5T01xK0t3dzlLM2Z2U0t4YnluMk1x?=
 =?utf-8?B?OVRSUm9jc0xaUUhNemtUNUtQYVFONnpsSzIyQnpITklTQ0dnd0xpM3lXVmRZ?=
 =?utf-8?B?dkM1ZWI3UzhFNGZ6NUphLzl0TUtiMU83aWhEY053ZTNRdWVGdEw4SFFkc29N?=
 =?utf-8?B?N3N1ZzQ0Nktwd0llY05kVEFtdlVoTFA2d04ydzIzQkN4UG4zNnN3WW4zMlNU?=
 =?utf-8?B?OHR1eHl5OEhpZ2pMeWFYVmFISWllbGF2YVVTS01BWkxZeFgvTmNJQkJseE1i?=
 =?utf-8?B?N094OFh2ZGJkZ3NjamZpZUFmWDZrZndzS3dKNUNabGIrZUdIUWE4MkZGdUlS?=
 =?utf-8?B?UlJuN2hQemFHT1dhQ1FWeUgvcVFWSzYzejg3NGxFOUtFOVlTTTdLNGxmU21M?=
 =?utf-8?B?ZDlvbzFVbzhBQ1Y2SXgvZWJlRXVVZ2RobzJrbklNdTI5ajlyQUdxbmJDRFlw?=
 =?utf-8?B?R3ZHNHpvNGlabUoxWDNzc1R6Mjd4SkxHL0F3RzE1WTQ1b0l0aTJUSmJFRitr?=
 =?utf-8?B?T1pMMEpUMzRVUXBWRjFQaFJLR3d3TWJTcEVRZm5FSW81RVlTS0E1V0lON0tJ?=
 =?utf-8?B?c1JJd1VzMm5OTU1tajZNdlRnRDNwaGk1NnhkVk9tYmhGZzJxZ0ZBaitGK2Jh?=
 =?utf-8?B?Z0VDTTBiNVhwWndtOVUxVHZvWG83cDhJVTR4cUhrR2ZWb2dya1ViRUNWMFdH?=
 =?utf-8?B?aVhZeDJXV2llRUlrd1lJMUY4eU9SWnJpd1E3OCtEdzVUNTBzZ0RwaTJTa25s?=
 =?utf-8?B?QTB1MDFkaW9sOEl0bytlMGlTb01lZDJNTUNXcEpDV0kvMmZlWHVPN3l1Vk5N?=
 =?utf-8?B?K3BMWGlMcXJlWkF3LzNxV3RaNjJEMmdjTllIMkMyME5PRE9YYlN1SDRlYVlu?=
 =?utf-8?B?ckZZdE9Dc2hGZ2FUZHZuY3NjWjEvcm1jQXNaVWxWalNOTkNoaUliK0xLN0Yx?=
 =?utf-8?B?RWt6SEFnazNqQzF3RERqOW9YL2dnNGZPb0UvaEd1SkJsUjFlRlhPb1VjUWJR?=
 =?utf-8?B?UFRuQ0lRTWNzWHpDQWQ3ejVZempFYS8zdkp4bHZIVW82dEZ2ZHRhRmhXdWxR?=
 =?utf-8?B?bVM0dlZNcGxIQUJQN2NxVmRKYURibkJBN1BMV1duY25tNDhiS0l5ZEpEWklV?=
 =?utf-8?B?VHlLalFpWkRXODNHbnVxcHcxRVdiMUlBYy9SYityKzhlaTVNZzdKazhhZktr?=
 =?utf-8?B?eXp3WURLbE0wK2lwQkIxRmFoa2dqTEdjb3IxVDNkZ2lRSUwyV0hWSUZ3RHBK?=
 =?utf-8?B?am9ra0FVekcyRjVnd25vY1NOQkIvUHFkSVVENTJRYTBXNmFXV1FZb0JmcCt5?=
 =?utf-8?B?VWFJRDYxSzd0bE0vK0pZTEZ4RzJ1bno2SkZmVmpCeEdpdkpMYW4wYSsrTHpw?=
 =?utf-8?B?VUJURTJSTmwrN3RhQ0RRbS9pTDN3QlBqWEI3QjF5bDVlQy8yYUdvQ0pYaVBP?=
 =?utf-8?B?alhCU2hSQWJYNTRISS9ZdVRjbW15YkpWenNSYWpHMUIyYnlmQ1RwRGtUS2ZL?=
 =?utf-8?B?NHRmRU1VTVBWVUlqWTBCZTE1bjVpWXN4R2xkMWVwc2dLek1hMXFYY0FZLytJ?=
 =?utf-8?B?dXg2VmEyMXpEQnIxcW1zMXI3dGZZMmVHYllxZGc4TUJhdkFEelJyZkllUE9S?=
 =?utf-8?B?R1Y3Wkl5ZFNiYWxWWGlRSU90ZzhFUG03dXFnK2NNQW8xL3VLTzV3ZGVpUk5r?=
 =?utf-8?B?RzRMajVTMDNqR3c2TnZTREppYTl1ekxHOXQyL212OFJnMlFWT2ZuRVdmMFlw?=
 =?utf-8?B?bFdvVW1FL3p2Zzk4dDlaSWc1N0lMQUJkTWZsVktZS3V3WjZVb3BNN2s2eTNm?=
 =?utf-8?B?aXJyQjZCVVVudzQzNE03TTBMWmV1SnNBeEh3dGZUazR4cWhLQTdacWgyclZw?=
 =?utf-8?Q?R8sMPDRg/pe6rGOX8DHPfL22p?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d068fe99-1d38-486a-80c6-08db8b7565b9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2023 12:07:33.9250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y5haIUzdFqYjX8TFbOo18FjB0F3k3C+47r4gJOEtYmyaCfN8Ud6IkP1lvDuH8OVc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4506
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2023 19:26, Richard Gobert wrote:
> This patch fixes a misuse of IP{6}CB(skb) in GRO, while calling to
> `udp6_lib_lookup2` when handling udp tunnels. `udp6_lib_lookup2` fetch the
> device from CB. The fix changes it to fetch the device from `skb->dev`.
> l3mdev case requires special attention since it has a master and a slave
> device.
> 
> Fixes: a6024562ffd7 ("udp: Add GRO functions to UDP socket")
> Reported-by: Gal Pressman <gal@nvidia.com>
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>

Thanks Richard!
Tested-by: Nimrod Oren <noren@nvidia.com>
