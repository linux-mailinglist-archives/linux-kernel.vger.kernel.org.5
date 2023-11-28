Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5917FAFE8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 03:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbjK1CKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 21:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjK1CJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 21:09:59 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9ADC3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 18:10:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIn0jUfeLyCLNncUHWIAY24Ks+U0RLQlSsn/IDwoHF1yYROioAzVOsSBIp0OaxoUT4VPtRhHQkDG7skPCvNQJy8Nei/N8Fe72FLsUuBE7QWCztiI2sxtFFcHrpuqgMjM0SkjE2Spco/BrU3VykvfHlzWwg7t0GL9Hs4dS8D7hEEg2pn2yTwne8cLF+OWzlEIDv1OvVXLtETzOMtsUGdvtAERVkqx2CsvdgrLdzhehi/gtHD+2ALvahGGMiMbOp14Q/5v8qrsxrzNZ26GxVJgpfgYClZJWdqgey/465jt7c1ATSRB1plQKCJiS7aTWrhaRcTLs1rAKp3D1dVkeb/pjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubmcznw19qene2kxfVuKrRYrUJ8fw5+RBKani9eIaVk=;
 b=i3AJI6qKzipifFiAnQhvAnuKU2Br/8xjcWDm6AB6GNDWMWhQHYQkR5sBQ35tsZIiRM9q1ON7Z1TNpAsVY2+UXVd5oXOhYQNvJMtg7VK3UoBA4aYeqkfLUqwcxGTot4qKfUeFoLzeNMw+vWPSQPTSKrzKY1KJpYbiuO1iRIMqRXVMZoYmnEuWckh9F//zEGHI5Me+S35T5E8gidZdTJVyKqS9hCgGp+o6dOf6veAk6VWMVk1++MGVpiHBd0ImRD3lsXwzspL0IR64Lpb6PGFp1R1w+GuLR5/CAEzJZ43FGKnpa/mdNaSz7a95x/TFDF8FsEzXGzI/JQaF3Cwd9WT74g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubmcznw19qene2kxfVuKrRYrUJ8fw5+RBKani9eIaVk=;
 b=jIjqguRIFCUK9i4YGxjAiOilereHRzBLRD6OpnRNsH6ySaVPlK86xHlPawhrmkr3LWOV3Bl9qQfVij1HhGvPLJQARKmOLQQtl0KCMCPmdkVs9k4+1CrBStZW4lWkrDceNInQxqKrQPU+ec853Xn78palYCvvsa4YsWjmUv2FxiOrrHvfRKxSsrWny42bt4BQ+PLL++ir93l/7/R/CJzyNBGy2kfK+LoPNWtOpTB7qdYlU4X6RWBZO8BCCyZmunWwBBsAnzM19xoiCILIQZiuJysyla4IynxzohyrM08ADGmHrUU5WrQx6hFxJLrIIqoWD+o8Ol+ke84stpGXU/jECA==
Received: from BL1PR13CA0314.namprd13.prod.outlook.com (2603:10b6:208:2c1::19)
 by BL1PR12MB5221.namprd12.prod.outlook.com (2603:10b6:208:30b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Tue, 28 Nov
 2023 02:10:03 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::41) by BL1PR13CA0314.outlook.office365.com
 (2603:10b6:208:2c1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19 via Frontend
 Transport; Tue, 28 Nov 2023 02:10:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Tue, 28 Nov 2023 02:10:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Nov
 2023 18:09:48 -0800
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Nov
 2023 18:09:48 -0800
Message-ID: <b2d19306-0d68-4aef-9b68-15948ddc8ea0@nvidia.com>
Date:   Mon, 27 Nov 2023 18:09:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v7 00/10] Small-sized THP for anonymous memory
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Alistair Popple <apopple@nvidia.com>,
        David Hildenbrand <david@redhat.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20231122162950.3854897-1-ryan.roberts@arm.com>
 <ZV9267tQEhoPzCru@casper.infradead.org>
 <f8e518f2-fb15-4295-a335-bea5a8010ab2@arm.com>
 <ZWC9lwDAjMZsNzoG@casper.infradead.org>
 <9c8f6d2a-7ed8-45d2-9684-d77489bd99b8@redhat.com>
 <ZWDG6BYqmZVpyTLL@casper.infradead.org>
 <26c361bc-6d87-4a57-9fae-ef635c9039c7@redhat.com>
 <87sf4rppuc.fsf@nvdebian.thelocal>
 <51e6c9f1-e863-464b-b5f3-d7f60a7ebed6@arm.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <51e6c9f1-e863-464b-b5f3-d7f60a7ebed6@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|BL1PR12MB5221:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b26f015-e33c-4c46-1829-08dbefb721e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XvUYKAHxwtQ/WC9nzui0EKkqB3dJ+A0sruXuJwulUNS5Hh4uVn6ARh4palToxEvGBxXug+XHVzzA4ZDRmglVRgHvNilh97ahAaGd3e8ALwsZQVhVN8beHrVmA/jS3YX6gnleFir0ufvQoU8WqFNV/I2ASv9DA4zD3nC8fJomuJHgNlit0CweK7iPyaIWod+KiBKN7WUTpTse9fauFEQB+FxNgb5VDUaYYSYSNcm/vt9fCU0l8QWrq535iPEX4SUto9IhkFg0+04dDkgGdebLBQQmOa62XB625A1WPCqnt2FuJswn0jUL9lf/GuL82EjIwz6Is29v+QpbbW/Mr1cFT8l9xffCHV32GHITGNOIgwHkqXVLruBMQChrKX2wsl98Jsd3TGVXWLCtcs4OHxlShIx0tZtYLMEAJ8USH3c7KNBBHffFAvyQwD3BMd7Jmucc21E7shNrwMfgRvcwxXRX4OmIveS6L8Xqp32q+Lg8ke1Br3xHDES7nzvhI9J5dvqicoIXX/a7ykfVQv8r0IQsZEiukCl/6znd7t0KwlIPpRf6glxZmrU+c3MMZPJapdI8OJAuo6mgPVYJI6W6dcY9YNggXSxwaQDMY3S4tHklIi7/QTT+NBxuXDPz0aHP7PyPUUg9Q2fdKRQvfFOeo2MbJvYgrxhZjDOfZRqyVgXfZxGAYUHKz0+v7eqdyknOATE0f0CoPSLeJsnTPppE7MCHKiJFkfrbnTghPPg45fzSfhYG8gknMoHh2qkJaMEetJNpsmYcRwWrZjDedtmzO0JdDA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(186009)(1800799012)(82310400011)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(2906002)(7416002)(31686004)(70206006)(70586007)(41300700001)(110136005)(53546011)(8676002)(54906003)(316002)(8936002)(16576012)(4326008)(478600001)(5660300002)(2616005)(336012)(16526019)(426003)(26005)(83380400001)(47076005)(40480700001)(36860700001)(86362001)(40460700003)(31696002)(356005)(7636003)(36756003)(82740400003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 02:10:02.7479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b26f015-e33c-4c46-1829-08dbefb721e1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5221
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/23 02:31, Ryan Roberts wrote:
> On 27/11/2023 08:20, Alistair Popple wrote:
>> David Hildenbrand <david@redhat.com> writes:
>>> On 24.11.23 16:53, Matthew Wilcox wrote:
>>>> On Fri, Nov 24, 2023 at 04:25:38PM +0100, David Hildenbrand wrote:
>>>>> On 24.11.23 16:13, Matthew Wilcox wrote:
>>>>>> On Fri, Nov 24, 2023 at 09:56:37AM +0000, Ryan Roberts wrote:
>>>>>>> On 23/11/2023 15:59, Matthew Wilcox wrote:
>>>>>>>> On Wed, Nov 22, 2023 at 04:29:40PM +0000, Ryan Roberts wrote:
...
>>> Maybe that's the reason why FreeBSD calls them "medium-sized
>>> superpages", because "Medium-sized" seems to be more appropriate to
>>> express something "in between".
>>
>> Transparent Medium Pages?

I enjoyed this suggestion, because the resulting acronym is TMP. Which
*might* occasionally lead to confusion. haha :)

> 
> I don't think this is future proof; If we are going to invent a new term, it
> needs to be indpendent of size to include all sizes including PMD-size and
> perhaps in future, bigger-than-PMD-size. I think generalizing the meaning of
> "huge" in THP to mean "bigger than the base page" is the best way to do this.
> Then as David says, over time people will qualify it with a specific size when
> appropriate.
> 
>>
>>> So far I thought the reason was because they focused on 64k only.
>>>
>>> Never trust a German guy on naming suggestions. John has so far been
>>> my naming expert, so I'm hoping he can help.
>>
>> Likewise :-)
>>

I appreciate the call-out, although my latest suggestion seems to have
gotten buried in the avalanche of discussions. I'm going to revive it and
try again, though.

>>> "Sub-pmd-sized THP" is just mouthful. But then, again, this is would
>>> just be a temporary name, and in the future THP will just naturally
>>> come in multiple sizes (and others here seem to agree on that).
> 
> I actually don't mind "sub-pmd-sized THP" given the few locations its actually
> going to live.
> 
>>>
>>>
>>> But just to repeat: I don't think there is need to come up with new
>>> terminology and that there will be mass-confusion. So far I've not
>>> heard a compelling argument besides "one memory counter could confuse
>>> an admin that explicitly enables that new behavior.".
>>>
>>> Side note: I'm, happy that we've reached a stage where we're
>>> nitpicking on names :)
>>
> 
> Agreed. We are bikeshedding here. But if we really can't swallow "small-sized
> THP" then perhaps the most efficient way to move this forwards is to review the
> documentation (where "small-sized THP" appears twice in order to differentiate
> from PMD-sized THP) - its in patch 3. Perhaps it will be easier to come up with
> a good description in the context of those prose? Then once we have that,
> hopefully a term will fall out that I'll update the commit logs with.
> 

I will see you over in patch 3, then. I've already looked at it and am going
to suggest a long and a short name. The long name is for use in comments and
documentation, and the short name is for variable fragments:

     Long name:  "pte-mapped THPs"
     Short names: pte_thp, or pte-thp


thanks,
-- 
John Hubbard
NVIDIA

