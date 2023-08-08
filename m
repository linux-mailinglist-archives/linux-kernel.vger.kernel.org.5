Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449FB77355D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 02:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjHHA36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 20:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjHHA3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 20:29:55 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B0110F7
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 17:29:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcgvjWnzbAtKzXZX37WrW1xkstwQNVnojak1hNhRLKrfZ3FqQFpQf74iZk4SHBYp/oJbsXFFkKbxSHFaT5H4mLEx55vvNCFlVeLavjQFD1BrElgXZgMpUhFiattNEOhjPdLVKpK+du1znlB3ZMsIsyNFnjQcCMGJjAk95gneqREKgPq91xu3odH1Cz9l8NchouoFo11CrGSq9VAsbJvtiey0N8oYAHBqjbS2CoaelOGoWdxT3tZ3Gg3cC5c+CMzVLUQByVVUGC16pexvu7aCK2EO6F/UN4wK9il6ninhhnu1xKbHlb6xbtKXceSJGcHDXDiqPQCTCsdeJjARSuVMyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQCYAf2GHWfMYiZEWRyX+8EtwJ1150SxaRena4BiZvQ=;
 b=S5qih8jDxMRQw3lVyaLt8k69SZE6ct2Qu5C0jAWdsEtDkdTvLCwyxyBih8YnG+KiQ4Ksi8DX6xpxMs9hphFHsGRTjO2DGoMZQGXqRmXGFJ/0S9J9LLk74xktaADB+PjnAb4U9Ve7NlIurkBCHYH8sUIkwonq+uKkMhMKh/p0enK0DufNTq45ZLIpKIxZpBQhU9Q4MmgZbf3RIgZ1+3d7uGv8vahON+uDaVaVL00KbtKXY1gAdff4xu6Al8g3JwqsyMODL+upGDTYRnG9LyZonaNoPfl/9K+qS+oOPQkFUWELuApCs7Ix0AR/BhGhtDfnllwGwTnK4Bm+N4+YIQPPpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQCYAf2GHWfMYiZEWRyX+8EtwJ1150SxaRena4BiZvQ=;
 b=DCSFCxw6motkq95gr1l2xzDYfYCJmwqefyd8U1tyBv+6Urji0fLGqelJkGRZ5K9HPjFbQEc+uS3Xo+M0atwUcVpnRXDmauuZfl0Qi/05SNlXaoBsPNjngRTfCg2Dgss0PBXpx84w5ZlyTjwF/WlAijVV8hj8sZ+ETUu/axoB0Js6tATD1hfpJ4JeoPGNH63A48HOxS89lFgclwSud/631WPAQGMjaBNlbSgw+9p728GrAZdf5X4hDTZAQrPA5GSV6D3arOL1C6a+rbeiFn3V3GOZbPl65n3AmU8AFtArLUZH+X6UBuXQClrKAbqmzTQyqtq42fE+in25k8xpR6Bdgw==
Received: from CY5PR15CA0055.namprd15.prod.outlook.com (2603:10b6:930:1b::18)
 by SN7PR12MB6791.namprd12.prod.outlook.com (2603:10b6:806:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Tue, 8 Aug
 2023 00:29:48 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:1b:cafe::a8) by CY5PR15CA0055.outlook.office365.com
 (2603:10b6:930:1b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26 via Frontend
 Transport; Tue, 8 Aug 2023 00:29:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.20 via Frontend Transport; Tue, 8 Aug 2023 00:29:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 7 Aug 2023
 17:29:40 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 7 Aug 2023
 17:29:39 -0700
Message-ID: <118d69d1-f70f-4f55-afbe-e3fc940de805@nvidia.com>
Date:   Mon, 7 Aug 2023 17:29:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/32] mm/pgtable: allow pte_offset_map[_lock]() to
 fail
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Yongqin Liu <yongqin.liu@linaro.org>
CC:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport" <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
 <2929bfd-9893-a374-e463-4c3127ff9b9d@google.com>
 <CAMSo37X5GzFmqNAtABuibmMAF7t=_5SYCipMPZ-TB+uEMYkSUA@mail.gmail.com>
 <ZMPLFqJ192j0loCV@casper.infradead.org>
 <da591261-26f1-5cf7-1435-a98ae21f5141@google.com>
 <CAMSo37UxxZ6dc9cY=TArOP01jTuBHuLT1BGv0d=y_hJA1_7Zvw@mail.gmail.com>
 <ZM6BuZ+hNkhwkJn5@casper.infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ZM6BuZ+hNkhwkJn5@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|SN7PR12MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fd9ea6e-f2a9-452e-4b35-08db97a69454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9fRF0wjQmlNCSDFo/pH220x3PES1EHZ1K6npMKv5KMw52Qd1FGHe/1Sx+N8VJCbbcwLwqf3uWLz8SYmqNsiAdHWN38zV+T5vyIy17YP8AirTOCNeE0wBCfypo2JXhCsl2SmcuZkiDQ6OgaXLRBrSJ46Hy5Gko0H1m6JPpDDSmzTXOjF4N4gwZgdbs+6t2slOaIXcy/UzZQUMvy+lsrrMOBNB/kYQpUOa+K5/XJNtCfKV+ERGss6vGEldbnFOHhWFQVJ2lrWgHdS7RWQkRizkU6p8pP6ouiat/7AcnUcYIz8A4N+b4ob+CXK1UfGSzHAq2HOpQ2Yc8+T9ee2xyQT8F1G7TFmF55ga/5360Oh42eejyzRcIpPRORnmJqh81wlNtEQXQ5lYfgWLF/hlDruN2+7QiH2A3wT7A1qTNuGSB/GxujPqmcWoLY8v8lMShHO6qnTRayh/rREeY/GfP6PRQTrATY/WlXp3TqgDmn17ZyVDvWJlVUVZgj3oZiRxba4/8/sbZmQJvPF+/GwC1s18GHu+Uul5mAcUVVQlsnsJEYKAhAkPyPoDItAwHxrMeSlrfdDBgL63mCmvg3Ao12YBRVNnUF9NS79PgyT5aPVVSM/AxbzcU6ghsjSIQY7nXf2BviZqIizUf/VPdpF8e8gVtZyEmmKRSvdS8uyhygLmyJOz8wStbXmJ9YgDLokj9OaFUrgAAB65DyETWrsPlxzzHBUcLFED2ZLVSLupTkmfCWyoLDyGXqzsDQ95W8Bv9RAlmG0xTntWAwhskFVZArbyQ3keDpwWtwB5s3m4EVd1zBbClsLQnMkOHO7Hl7mpb/RGciomYDB8RFCL3pBRTgi+GXAwd4sCRZrRlCxQ0+Qbwxuos2J6wTwuT7pbKMVbl6hH
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(90011799007)(451199021)(90021799007)(186006)(82310400008)(1800799003)(40470700004)(46966006)(36840700001)(7636003)(40480700001)(2616005)(40460700003)(86362001)(966005)(478600001)(82740400003)(31696002)(26005)(36756003)(53546011)(41300700001)(356005)(4744005)(5660300002)(16576012)(8936002)(316002)(7416002)(8676002)(7406005)(54906003)(110136005)(2906002)(4326008)(70586007)(16526019)(336012)(70206006)(83380400001)(47076005)(36860700001)(31686004)(426003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 00:29:51.1037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd9ea6e-f2a9-452e-4b35-08db97a69454
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6791
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/23 10:07, Matthew Wilcox wrote:
...
>> Sorry, I am not able to give any explanation here,
>> I am not familiar with the pvrsrvkm source, I just use it to have one
>> working AOSP build.
>>
>> here is the source file where pte_offset_map_lock is called,
>>      https://android-git.linaro.org/kernel/omap-modules.git/tree/pvr/services4/srvkm/env/linux/osfunc.c?h=android-mainline#n3508
>> in case you could know something with a quick look.
> 
> Isn't this just get_user_pages()?


Or even just follow_page(), which looks like a nearly perfect drop-in
replacement, especially since that android link also says, "The page in
question must be present (i.e. no fault handling required)".


thanks,
-- 
John Hubbard
NVIDIA

