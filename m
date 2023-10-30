Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFC17DC31D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 00:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjJ3X0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 19:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjJ3X0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 19:26:00 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345DAC1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 16:25:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJcswzQrNkyMIUryy6OTrzGZu0OB1fZ6LM61lWtwxL2paVxTwOXRHUoCunnn79fKzig9QzEPELjh4Vj4uBQlgOnUsDYSGTqmf4eHr1lTkBzj6mVBBJ75JJYSpUffjLooRwSIS+pwolfgoCeCzpYMaPoyZzaeTIsh0fNy1JcqtmemWnNMH0fnhwBDuxXrITFA9E7LaHulXZY4Dzjh9pcwxTFW66DLpY0q3O3Fjts3RIt344BC4NEXi80JwFeT8uThLWsTiJRXDGYKXljeILLDL1iumX6U5HOG65r3QDnsJMdHXhREUWjZykZ3IdADjj06TF/RCBtj8hfnowsDrBmRGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qk208FfNxjQYIQ3LDU7DMNTnKqmQQZhWXoXwPCK7548=;
 b=J63SRRSbQZUhG+1BbbOK8KUSxGrVpCHuM5mRJRAyA8kQMQQokxuwPBAsrj2b/xY71rkyqreMQmnRrIZIGwCC7C7GX/NmNJqYgSZ7pUAgCY0snLM1ZNgCWmmm8Nk8ED8jcAe7cpvHiZhKBlnX2kDUnHAoDMq/O/Kauo8F63qWsdLekODFUJcD5btC6uTgTf/Hr6GoiephizD0k+ZvAyVZLxFZ3/ZLbnFtz5Z382GJNhaZ+rE3cuu0Vduq8oO8vvXnfJsCCwPtO9sKQVRAn6YzWVAmbuoMVrsnq/Sj9JwFFvvb2sLh6jJCwM0FdRxMyELdEvhOF6UEMh8GFNDcrrdT4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qk208FfNxjQYIQ3LDU7DMNTnKqmQQZhWXoXwPCK7548=;
 b=BdF/PmWQBLjlIqJolGzPXM1fdcP8oojp73tv7S9mbQCJ2x0nBfO8Y6MZy4yhmmGidmi3vPKKA6q4J9aoRSBM/wwjO1Kp+TXDVkzoBzKddtLhEbGyI5Xoedt6HtmKP6LIAPDLPD+VGrdhzcXgw45l4C23NIlyc2M0v2XF1EZzf/bqP3yqXieVgVcYXacaI1Cwsk7q5lVlHaaVLCLF9ojE+QNzgzg+kLDzVakysw4+54BRZLcQejHus9hh0lEFOJTrRUnTXMX5l0gQSZO2TDtQ9WZilM0IoqQ6RK+AbBoh5n0gApf4OcU7FOz/P2u2UXIq1rbVV9Pc6pnwjn0/S6sftA==
Received: from CY5PR19CA0010.namprd19.prod.outlook.com (2603:10b6:930:15::14)
 by BL3PR12MB6596.namprd12.prod.outlook.com (2603:10b6:208:38f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Mon, 30 Oct
 2023 23:25:55 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:15:cafe::fa) by CY5PR19CA0010.outlook.office365.com
 (2603:10b6:930:15::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28 via Frontend
 Transport; Mon, 30 Oct 2023 23:25:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Mon, 30 Oct 2023 23:25:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 30 Oct
 2023 16:25:39 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 30 Oct
 2023 16:25:39 -0700
Message-ID: <d07c45bb-4eba-484c-bba1-b586136f8cdb@nvidia.com>
Date:   Mon, 30 Oct 2023 16:25:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/9] mm: thp: Extend THP to allocate anonymous large
 folios
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Yin Fengwei" <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        "Yu Zhao" <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <20230929114421.3761121-6-ryan.roberts@arm.com>
 <8a72da61-b2ef-48ad-ae59-0bae7ac2ce10@nvidia.com>
 <5993c198-0d27-46c3-b757-3a02c2aacfc9@arm.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <5993c198-0d27-46c3-b757-3a02c2aacfc9@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|BL3PR12MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ad3013c-3984-4902-8b3b-08dbd99f902e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WX3161uWqKYtVLg00A0iuSESzwj/B9W0hwk4KvLsbbDP8OYJtmTMSLwi844U7xTsMMg75jJg3gSQHFEgpG/GeWL24nqLPkDVxVCQP4FPw3KsvS0bGzeZcZBwuNfVNHltLVhDv6lavG5s+mhrNsHLG+2TYLdALyVY2OtwDRfwy+dYvRXigc8HGPhTwFEl3TRWR+A6SJch9qy45evZ4GO70srXEJuDJsy0m1DT3/hMhG8QtLlswgjLIagotdH3Ssco4VesjO5Xkjy8JIXwNob9bH369GpGBQDHpMDReOtgmVCBmzTMfZ7VygPXRxMt9EMx0Ao9REbv8TAyXCetHrEvPkRFvmXb+qMN/TjJQfKQmxRq69DVbr61LZD5YRAtYcHPmqVS5zdlas2coLzYkClUJ0eHGr7JO32sIi3UUndcLhdRHdCwL3UCsQWhAF1BcpD6t7uJQIR2Pvw17xWwPS0E+vKAsJ9SD907NIwByt65SiEiBWyIXd6wCK8fDiXpSl+PTfMtJ20yPrzOYV9/0XbKTWkOMnyuZidu/Y8jb/RVdo62KF/6fxx+OoVPiV8oZNVSDsMyihrSqFxPdw8CQD8bjNgksQYJWU5eF8OUuxANact3T2SRxcTvKmJ9CMWUVlE2EezOixxI3qL+Nw+kiU+Y4Aeg+Qa881vhpO3oJvMK1CixlaNC+k7FbXRC2j697sd5wFShqYYPDuARJhHIjgTH2c06eoRi1RLBe7e2uLs2y1qS1oTVEZtpgHSmP7BEbJQO20GoEpDQldFwFE2UPGjM/AeFNARtEsvr5MoyfHXDYZlQvrR60h5yXWmQ9fWny4QK528hiWMwPZIU+cC8PPtcqQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(82310400011)(64100799003)(451199024)(186009)(1800799009)(40470700004)(36840700001)(46966006)(36756003)(86362001)(82740400003)(31696002)(921008)(31686004)(40480700001)(2906002)(966005)(478600001)(41300700001)(8676002)(8936002)(4326008)(53546011)(83380400001)(26005)(47076005)(16526019)(2616005)(40460700003)(426003)(54906003)(7416002)(5660300002)(316002)(70206006)(110136005)(16576012)(70586007)(7636003)(356005)(36860700001)(336012)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 23:25:54.3960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad3013c-3984-4902-8b3b-08dbd99f902e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6596
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/23 04:43, Ryan Roberts wrote:
> On 28/10/2023 00:04, John Hubbard wrote:
>> On 9/29/23 04:44, Ryan Roberts wrote:
...
>>>    +static bool vmf_pte_range_changed(struct vm_fault *vmf, int nr_pages)
>>> +{
>>> +    int i;
>>> +
>>> +    if (nr_pages == 1)
>>> +        return vmf_pte_changed(vmf);
>>> +
>>> +    for (i = 0; i < nr_pages; i++) {
>>> +        if (!pte_none(ptep_get_lockless(vmf->pte + i)))
>>> +            return true;
>>
>> This seems like something different than the function name implies.
>> It's really confusing: for a single page case, return true if the
>> pte in the page tables has changed, yes that is very clear.
>>
>> But then for multiple page cases, which is really the main
>> focus here--for that, claim that the range has changed if any
>> pte is present (!pte_none). Can you please help me understand
>> what this means?
> 
> Yes I understand your confusion. Although I'm confident that the code is
> correct, its a bad name - I'll make the excuse that this has evolved through
> rebasing to cope with additions to UFFD. Perhaps something like
> vmf_is_large_folio_suitable() is a better name.
> 
> It used to be that we would only take the do_anonymous_page() path if the pte
> was none; i.e. this is the first time we are faulting on an address covered by
> an anon VMA and we need to allocate some memory. But more recently we also end
> up here if the pte is a uffd_wp marker. So for a single pte, instead of checking
> none, we can check if the pte has changed from our original check (where we
> determined it was a uffd_wp marker or none). But for multiple ptes, we don't
> have storage to store all the original ptes from the first check.
> 
> Fortunately, if uffd is in use for a vma, then we don't want to use a large
> folio anyway (this would break uffd semantics because we would no longer get a
> fault for every page). So we only care about the "same but not none" case for
> nr_pages=1.
> 
> Would changing the name to vmf_is_large_folio_suitable() help here?

Yes it would! And adding in a sentence or two from above about the uffd, as
a function-level comment might be just the right of demystification for
the code.

...
pte_offset_map() can only fail due to:
>>
>>      a) Wrong pmd type. These include:
>>          pmd_none
>>          pmd_bad
>>          pmd migration entry
>>          pmd_trans_huge
>>          pmd_devmap
>>
>>      b) __pte_map() failure
>>
>> For (a), why is it that -EAGAIN is used here? I see that that
>> will lead to a re-fault, I got that far, but am missing something
>> still.
>>
>> For (b), same question, actually. I'm not completely sure why
>> why a retry is going to fix a __pte_map() failure?
> 
> I'm not going to claim to understand all the details of this. But this is due to
> a change that Hugh introduced and we concluded at [1] that its always correct to
> return EAGAIN here to rerun the fault. In fact, with the current implementation
> pte_offset_map() should never fail for anon IIUC, but the view was that EAGAIN
> makes it safe for tomorrow, and because this would only fail due to a race,
> retrying is correct.
> 
> [1] https://lore.kernel.org/linux-mm/8bdfd8d8-5662-4615-86dc-d60259bd16d@google.com/
> 

OK, got it.

...
>> And finally: is it accurate to say that there are *no* special
>> page flags being set, for PTE-mapped THPs? I don't see any here,
>> but want to confirm.
> 
> The page flags are coming from 'gfp = vma_thp_gfp_mask(vma)', which pulls in the
> correct flags based on transparent_hugepage/defrag file.
> 

OK that all is pretty clear now, thanks for the answers!


thanks,
-- 
John Hubbard
NVIDIA

