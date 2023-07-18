Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482F775883E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjGRWI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjGRWI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:08:27 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2062f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2771995;
        Tue, 18 Jul 2023 15:08:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTGj6boWtohwKdzCbgbOwkwKke5C4RIvs9pp6iPtYsvOCBUh1CBzd/+QFLy0wPB4tsRi5sZB8BQu+C+gqY4xKB847qzj7zz0w3nP5UXRiiz+uW6+/yefrICrgSJrQs72mVtFLU/bTrx1UZh4q9H/BTEx8l1r+08cDKGuWY3NA/MXfRd3yUinICuYMYasqBTPZlh30EYcIQeZ3qytYJlDAS6GHHXE+my8nJSKT5z42LCGAnnJDaXryTeEmlllgd9XWbXKXK090sqoaeT3cUn5MRxJEAWbWNVgiALDK4gRmDrxkL6H+4dV6p4ZSJJxei1T+zOksvWObItJtVYd4+iMTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6EkvlD6DT1Qqjvk1idF2CjRc57WMh/Jy1dwlmh3GVc=;
 b=jFXrbthUiDdNjD6uCGfoNWqre0vAgFg3kizV/TR5xrwHWbP+0f2pzcImtazVkgCBctWgCJOzzCKNYhP3S7mWbPeighdieG56xfiOHNBOk2h3Y3S7D32WAnU5H80PeD5++SZ74TViOtH5aiLxtnRrOs4UEjScF5qTYWXvB4pC1BzPm/uKNh8GguvQVWYA8U+uEzbsWRpZbBsMjywvYqVBUIFOuBjzbj2IXHsCUCkeP890+5OnHQf33gzdKzkqmx5J43zkyX4fGVa5La3mPQbm9hhV6AodhFMOmOhivY9mRyKtwthZSKFoMZK0zuyR1boHzJYzfzXIph8lOW5KO6RtUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6EkvlD6DT1Qqjvk1idF2CjRc57WMh/Jy1dwlmh3GVc=;
 b=SlWbHo5uUukEzKD6f2+pZAimQOr4TX8GTuq9ALdg+JMuBn42Yrx4FysgcCxk9jKB3Kv6nDteDdyIFE5rV3gz+NFCrBW0IdxVlq1ttf1PjbFwKHKV3QrNj41DheOn+6s/bqMwH2AMGCj6lZpa1OHRA2e81y35xejU3rd8VyM6vIw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 PH0PR12MB5435.namprd12.prod.outlook.com (2603:10b6:510:ed::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.33; Tue, 18 Jul 2023 22:02:23 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::bf76:da18:e4b4:746b]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::bf76:da18:e4b4:746b%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 22:02:23 +0000
Message-ID: <8ab6e3ec-7868-caf2-fed9-44c08fb751bf@amd.com>
Date:   Tue, 18 Jul 2023 15:02:19 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH docs v2] docs: maintainer: document expectations of small
 time maintainers
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>, corbet@lwn.net
Cc:     workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        gregkh@linuxfoundation.org, linux@leemhuis.info,
        broonie@kernel.org, krzk@kernel.org
References: <20230718155814.1674087-1-kuba@kernel.org>
From:   Shannon Nelson <shannon.nelson@amd.com>
In-Reply-To: <20230718155814.1674087-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::24) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|PH0PR12MB5435:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a89faab-bd1e-4919-b4c0-08db87daaa0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oMnqbjiNh+jAqj41oXV+//XWLug0vltssPNwjCmF6x8F90iQK/7/NSkROYxJiqCQHHwQ9Gp27vZ6QszOEgkZmNScRcm8cCu1fGRCY+BgfKtq53wHWF6Hf+FoWS3X6LcOglJWMeD21AwRPeY46FR2d7LXgGvbBKrDI7QR8VKNaOFGNdXzypFiEz5K0MmB7MUnMjI6tMpLx43B1fhA0LuXHecRydTPEXYfLMRvvr7OnjM7OhlXGoH0WxvQ7zhStriGxwUlAW4/WNVNWklLZzsf0yC/WA9qNVG/88smhmVVOy3yjIq3X/8DtfF1Egyd4SyaFDgEta9wES5JeWo4QhFzDtn/ror/AHF/UjSW2EI7m0Chb18JqMyeep2kuAe24qosp4oVFAgNfPMUrLNyEWwyCFSyDZfpR30vJ2AzPpjcs/wk8aC1gD4up8EwSWhagyCW5qbmUjP5yHC/+tXCQVaL6zDxwdSMd4q456/oXyxxGFSeyP1g1FEfIKCqXBr4K+PnMfHUHZZwfteCuZKfQwA2//fKKmPcipnWxepXMS0JC1zjmlRHRP5aA1k7VsRIchJGhVGSqhsUJoulIskJ2+nSquDfRHh7IiH8Mxjaq1j5esmTYjFIjgJ/JXNelLi52gOOp0/4btuRmwFJPBziCGD24g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199021)(478600001)(6486002)(6666004)(53546011)(186003)(6506007)(966005)(6512007)(26005)(31696002)(2906002)(41300700001)(66556008)(66476007)(44832011)(4326008)(7416002)(8676002)(5660300002)(66946007)(8936002)(316002)(38100700002)(86362001)(36756003)(2616005)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFFHQk5UMmNJdzlpN3RYZ09aR1JIRlI2N3ZpakhVc0VSM2w3RldWUjRWK1Ux?=
 =?utf-8?B?NE1OUko4UlFxYjdJdWhsRFUxenJUcmhlWkFVVnNLc3p1Z0hqbk9KelErNVBK?=
 =?utf-8?B?dXl4N1o1RWdNZXlKcGpNQW9xcHJwNjBhUWxPR25TZzZtbXh5dmsxVUxqVyt5?=
 =?utf-8?B?VHJXRGh0aG9kd3NJdnozeWZTYjFTZ2xhVXYwMG9MUUtOS2NSSkFqQ3NnajVF?=
 =?utf-8?B?ejVFdzNkSjBhZnNsdHhYL2lSZTBMSmU3cE1pemFVMHVkcjlaaGRKQVhBZmZt?=
 =?utf-8?B?SUhZajVHT0ZwUHQ0a3ZuazlPeFNQbUtFRjlGc1l6bWtrUzhKeVJ0bEFUVWFX?=
 =?utf-8?B?ZDhaWGxGNGc2REtIalZMV2F2NnAyUEJSOWJmZkF1WFR2dnFIdXhtRG5oWFU3?=
 =?utf-8?B?SW5VekVBdjcyVDEzTGFPMGZwVFg2Vmo3SlBtZWNkTnJRQ1JjcmZSaUlGSU8y?=
 =?utf-8?B?blJpZmNHN3BmR3J3R280VEdkbnpNdS9Id2pucG5nZEZyVTRmeTlLYlk0ekJC?=
 =?utf-8?B?Sk1XcVRDYVNjNmx6M3h0SGtHR0FKVzJpUFY2YnEvVlNkZTl4VU5raldibG83?=
 =?utf-8?B?RG9pbVlPRVhpVVhINkRmZ1cyZzVxaU1taVBkUkl2akNjQjJwTVJUVWFzdHlY?=
 =?utf-8?B?N3pNUzhwdmpmTTU5bzRMZDl2UTZaRlpFU3BCcUdEbHdURHBOV0IxdFRXTVVN?=
 =?utf-8?B?ZzBnM0hTV201U1ZmMzNVb2FkU3ZiK0pGMVNmT2U1bXppa1pvRHVPWWZOekpk?=
 =?utf-8?B?eWR1bGs2aU5ydVErT1lFNkw2Vno3Ri9yQnpyOHJOdVQyTWUyVldCdFZabDZr?=
 =?utf-8?B?cDEwUVV1TytqanlJSjQrVVBwNGcvWlkyTENBMTVFazlSNkt3VGtocy9XbU1u?=
 =?utf-8?B?Y2ZxNnBXQmZNWkx3OTBKdzM0MVQvTmdDK3Z6VFFpc3NrSTRWYVphT0t2dUZt?=
 =?utf-8?B?YU82Sml3cE9JWmNrMk1vZW1Ccm1KdThpbEdVVGxOUnNjcWJUUUordVcrd29z?=
 =?utf-8?B?MUNGR1JlazFEYVVwTGFVUGdRSXJMbm1QS21TZk4zM2p0cS94ZExDZHI4enE2?=
 =?utf-8?B?UGIrcW5UWUExUis5U3Q5RUoxaEpjM3lLcFUrWUp4Q3VZYmJYUWE5d2ZFYjI4?=
 =?utf-8?B?akVzREt3cEdZVFhCVm4xTDB6dWRZL21NUTFLdWl5ckhEYjFHcDRuNFp0WjJu?=
 =?utf-8?B?REE5V1E3VGV5K1dwWUtVaHhjeVVIcGZ4TWxZNXdlOUtYaWptTHRBSnV4WXBw?=
 =?utf-8?B?SWlzRitLY1J5cDA4N2VpMTRVQmhqcHZkYlUvUDRhSDkwMHdYcmtkYjNpZlM2?=
 =?utf-8?B?Z3VnbkN5Vm8zczhpZStieDF3eTlsQ1JGb1I4ZXMrQXcwQ0JnVU0rU1FSRzh4?=
 =?utf-8?B?d1VVbkc0QmNJcENUbVd3cVM0Y0MzaVA0MzBXRzNML0QxUExFNzVpYzJ1VXVr?=
 =?utf-8?B?azJNbU1obXZUQjAxVlgxQkFGdXFGdi9BbTdRSkJUSUJBTTQvdFJEL2YyQVZH?=
 =?utf-8?B?YkFVNWhoQ0VyNnJlRWE4SUpNdG9FNVhpNERPYi9NSlRvV2NDMTBsZnY4K2lZ?=
 =?utf-8?B?TVF3R0ExbmcwbVlDU29NTkFtZC9jcGdpQUVQTERQWmRKY0JjMlVTK1dWYjNm?=
 =?utf-8?B?dXhKdG9HbVRhRVRaTlhhZEFmQkNPZFNGZ01HZ0hqZWt4WHRRZHFFSGxYTUNo?=
 =?utf-8?B?VFlmeFdCR2JEUDcycFJaaEI1VGVkN3gveThpUVdqQStiZHg5WEtQMmNDTGli?=
 =?utf-8?B?T0M1ZnJIT0FiNCtGOElsNXNIVWpHM1pRTS9Yb282cU9Cb05SOWp6MjJCai9j?=
 =?utf-8?B?UzFZSFppZzNEYVU2Qkk1b0Q4S3I1QXE4Y1M4dWVncjVUaXN5ZDl1WTVxblpy?=
 =?utf-8?B?bTFmQ3hjZU83dmtZUGxoaENIMDh2d0JselM2cHYrbnp1c0FPbUZHR1JJQith?=
 =?utf-8?B?SGQxMFRFTFM2RzRGNjBpYkU1cTZrMy8vK1V0bGI1di9ST3BOV09Xd3NxTUNL?=
 =?utf-8?B?UTVVaDROQWJXajlCVXAxcHdldzVaQzNzM0hKVnNBcSs2YmZqWUtHdlRLRTN0?=
 =?utf-8?B?THEwR1JZSTNXTzBqNWhwbnRhNGQxeUhVcjZNYmp3ODJ4VWF2SWxOU3p4cGlE?=
 =?utf-8?Q?k5wX/2+HlmNyEZRztSSm8ZyI/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a89faab-bd1e-4919-b4c0-08db87daaa0d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 22:02:23.0330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vDTRlv4yhokPu8p28xbMfvGuZlVAgmIXcqBiqXXMTNNrxpu1BiAhcYxOCajfQUPZZLavHxDKqLT0h3MMGOJz7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5435
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/23 8:58 AM, Jakub Kicinski wrote:
> 
> We appear to have a gap in our process docs. We go into detail
> on how to contribute code to the kernel, and how to be a subsystem
> maintainer. I can't find any docs directed towards the thousands
> of small scale maintainers, like folks maintaining a single driver
> or a single network protocol.
> 
> Document our expectations and best practices. I'm hoping this doc
> will be particularly useful to set expectations with HW vendors.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>   - use Thorsten's wording for bug fixing requirements
>   - put more words into the review/response timeline expectations
> v1: https://lore.kernel.org/all/20230713223432.1501133-1-kuba@kernel.org/
> 
> CC: workflows@vger.kernel.org
> CC: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: gregkh@linuxfoundation.org
> Cc: linux@leemhuis.info
> Cc: broonie@kernel.org
> Cc: krzk@kernel.org
> ---
>   .../feature-and-driver-maintainers.rst        | 155 ++++++++++++++++++
>   Documentation/maintainer/index.rst            |   1 +
>   2 files changed, 156 insertions(+)
>   create mode 100644 Documentation/maintainer/feature-and-driver-maintainers.rst
> 
> diff --git a/Documentation/maintainer/feature-and-driver-maintainers.rst b/Documentation/maintainer/feature-and-driver-maintainers.rst
> new file mode 100644
> index 000000000000..7064b5de076d
> --- /dev/null
> +++ b/Documentation/maintainer/feature-and-driver-maintainers.rst
> @@ -0,0 +1,155 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==============================
> +Feature and driver maintainers
> +==============================
> +
> +The term "maintainer" spans a very wide range of levels of engagement
> +from people handling patches and pull requests as almost a full time job
> +to people responsible for a small feature or a driver.
> +
> +Unlike most of the chapter, this section is meant for the latter (more
> +populous) group. It provides tips and describes the expectations and
> +responsibilities of maintainers of a small(ish) section of the code.
> +
> +Driver and alike most often do not have their own mailing lists and

s/Driver/Drivers/

> +git trees but instead send and review patches on the list of a larger
> +subsystem.
> +
> +Responsibilities
> +================
> +
> +The amount of maintenance work is usually proportional to the size
> +and popularity of the code base. Small features and drivers should
> +require relatively small amount of care and feeding. Nonetheless
> +when the work does arrive (in form of patches which need review,
> +user bug reports etc.) it has to be acted upon promptly.
> +Even when single driver only sees one patch a month, or a quarter,

s/when single/when a particular/

> +a subsystem could well have a hundred such drivers. Subsystem
> +maintainers cannot afford to wait a long time to hear from reviewers.
> +
> +The exact expectations on the response time will vary by subsystem.
> +The patch review SLA the subsystem had set for itself can sometimes
> +be found in the subsystem documentation. Failing that as a rule of thumb
> +reviewers should try to respond quicker than what is the usual patch
> +review delay of the subsystem maintainer. The resulting expectations
> +may range from two working days for fast-paced subsystems (e.g. networking)
> +to as long as a few weeks in slower moving parts of the kernel.
> +
> +Mailing list participation
> +--------------------------
> +
> +Linux kernel uses mailing lists as the primary form of communication.
> +Maintainers must be subscribed and follow the appropriate subsystem-wide
> +mailing list. Either by subscribing to the whole list or using more
> +modern, selective setup like
> +`lei <https://people.kernel.org/monsieuricon/lore-lei-part-1-getting-started>`_.
> +
> +Maintainers must know how to communicate on the list (plain text, no invasive
> +legal footers, no top posting, etc.)
> +
> +Reviews
> +-------
> +
> +Maintainers must review *all* patches touching exclusively their drivers,
> +no matter how trivial. If the patch is a tree wide change and modifies
> +multiple drivers - whether to provide a review is left to the maintainer.
> +
> +There should be multiple maintainers for any piece of code, an ``Acked-by``
> +or ``Reviewed-by`` tag (or review comments) from a single maintainer is
> +enough to satisfy this requirement.
> +
> +If review process or validation for a particular change will take longer

s/If review/If the review/

> +than the expected review timeline for the subsystem, maintainer should
> +reply to the submission indicating that the work is being done, and when
> +to expect full results.
> +
> +Refactoring and core changes
> +----------------------------
> +
> +Occasionally core code needs to be changed to improve the maintainability
> +of the kernel as a whole. Maintainers are expected to be present and
> +help guide and test changes to their code to fit the new infrastructure.
> +
> +Bug reports
> +-----------
> +
> +Maintainers must ensure severe problems in their code reported to them
> +are resolved in a timely manner: regressions, kernel crashes, kernel warnings,
> +compilation errors, lockups, data loss, and other bugs of similar scope.
> +
> +Maintainers furthermore should respond to reports about other kind of

s/kind/kinds/

> +bugs as well, if the report is of reasonable quality or indicates a
> +problem that might be severe -- especially if they have *Supported*
> +status of the codebase in the MAINTAINERS file.
> +
> +Selecting the maintainer
> +========================
> +
> +The previous section described the expectations of the maintainer,
> +this section provides guidance on selecting one and decribes common

s/decribes/describes/

> +misconceptions.
> +
> +The author
> +----------
> +
> +Most natural and common choice of a maintainer is the author of the code.
> +The author is intimately familiar with the code, so it is the best person
> +to take care of it on an ongoing basis.
> +
> +That said, being a maintainer is an active role. The MAINTAINERS file
> +is not a list of credits (in fact a separate CREDITS file exists),
> +it is a list of those who will actively help with the code.
> +If the author does not have the time, interest or ability to maintain
> +the code, a different maintainer must be selected.
> +
> +Multiple maintainers
> +--------------------
> +
> +Modern best practices dictate that there should be at least two maintainers
> +for any piece of code, no matter how trivial. It spreads the burden, helps
> +people take vacations and prevents burnout, trains new members of
> +the community etc. etc. Even when there is clearly one perfect candidate,
> +another maintainer should be found.
> +
> +Maintainers must be human, however, it is not acceptable to add a mailing
> +list or a group email as a maintainer. Trust and understanding are the
> +foundation of kernel maintenance and one cannot build trust with a mailing
> +list.
> +
> +Corporate structures
> +--------------------
> +
> +To an outsider the Linux kernel may resemble a hierarchical organization
> +with Linus as the CEO. While the code flows in a hierarchical fashion,
> +the corporate template does not apply here. Linux is an anarchy held
> +together by (rarely expressed) mutual respect, trust and convenience.

:-)
I definitely respect the amount of time and effort you put into the job.


> +
> +All that is to say that managers almost never make good maintainers.
> +The maintainer position more closely matches an on-call rotation
> +than a position of power.
> +
> +The following characteristics of a person selected as a maintainer
> +are clear red flags:
> +
> + - unknown to the community, never sent an email to the list before
> + - did not author any of the code
> + - (when development is contracted) works for a company which paid
> +   for the development rather than the company which did the work
> +
> +Non compliance
> +==============
> +
> +Subsystem maintainers may remove inactive maintainers from the MAINTAINERS
> +file. If the maintainer was a significant author or have played an important
> +role in the development of the code they should be moved to the CREDITS file.
> +
> +Removing an inactive maintainer should not be seen as a punitive action.
> +Having an inactive maintainer has a real cost as all developeres have

s/developeres/developers/

Thanks,
sln


> +to remember to include the maintainers in discussions and subsystem
> +maintainers spend brain power figuring out how to solicit feedback.
> +
> +Subsystem maintainers may remove code for lacking maintenance.
> +
> +Subsystem maintainers may refuse accepting code from companies
> +which repeatedly neglected their maintainership duties.
> diff --git a/Documentation/maintainer/index.rst b/Documentation/maintainer/index.rst
> index 3e03283c144e..eeee27f8b18c 100644
> --- a/Documentation/maintainer/index.rst
> +++ b/Documentation/maintainer/index.rst
> @@ -9,6 +9,7 @@ additions to this manual.
>   .. toctree::
>      :maxdepth: 2
> 
> +   feature-and-driver-maintainers
>      configure-git
>      rebasing-and-merging
>      pull-requests
> --
> 2.41.0
> 
> 
