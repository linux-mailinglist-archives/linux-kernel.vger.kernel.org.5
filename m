Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708A17A90C5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 04:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjIUCF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 22:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbjIUCFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 22:05:54 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BE6C6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 19:05:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmEQ754dxlyzq5jv27pnqq64H6dh0hboSp4PkhDCPWOcFmDJr2F9llFVk++xMYYbZ4X7czCXupW6YEhdS2euXQj6WjMSuABIa2PdIGOM9FIknICTDzY1oP26OHwmlK8HvmmbnbEsxyzjAuKVKlDEWRs/GDXfOFiMz1tJMBIu/kbfeQtIPxC/bSsx7lFfzNwiq81MlhxtzAISo+SuMgM8YciMC9fkETe0PTKnTH6x7uBohB65M7cYcl74dFcSZc7/DxJQfjgAEzxLCnbtwIzdmoQTQ0O8swA0RKzHaZ30UxPuXixqlWnmjv3upd4a1sGbypG0c+iJAeUBgMGTRawcXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJUmvuyqLl4xXHH6IgNR9QjdZp+TMuybsMSZy3AZi9I=;
 b=AFskUOQ9MfuYCU6zPDWwlzSFJzkKHzU5T/Vz/NY8W4cVk7hxo7MXGX/RiPxVk0cqWApxT/Ckrf1Z9ZDXsdK25rJ6u0gK7BbzyOUOnmXSNoL4Ks1BL9I+MDAulWC7wBTbQpPdcHSF1T/az5Hp1TR6bpgpOK5qOJ+3Wk03hEUUoPX0wxJj/KwzOWZyg/QYghkkO7S3ZjCMGCVrSyHda6RZNfGjmKP6XEW/F6gSMFk/OYAxCuyw66ingpSS+69m2x9nMXUkhmR9u4sXF9A7S4hq6fhTKBm5ajFjas+8ocIOl7DcweT/cMfk70YbEPPvLu4zsoaDLFwsNvz/lYM5DipvQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJUmvuyqLl4xXHH6IgNR9QjdZp+TMuybsMSZy3AZi9I=;
 b=Yz+ZDm5swP6iZeSohV7jwQsbSMkIDDFmAASTpfOgsp9b4ko8gpWEA45EAOsUvS1e2QFzIlfbBivq5fMsG/7SZFkQAQQGScX+RyR8+FE/+f38Sr5w1JIO5eKhISzaxOxmPS/+Z9YvLZlt1G77Lzye7FtqMSp2xI5CyArqX9Fvk39aWRbKWYNFRaOzRu9zJjWL5CKvSo/hN0q6W9wJ5Om/6NHLNTlO3PcwoQnNl6Y6+hq1XnTj7piJt6ZU9DZjWkxzl4Kufr8UR9/reTbNYV+XeLpWANbvga8+pvxd3BYKL/FA/5nni8NcU0iypX/1kyFr6+p7pDt+7d/TDd4SkAxc/w==
Received: from MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20)
 by PH7PR12MB5710.namprd12.prod.outlook.com (2603:10b6:510:1e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Thu, 21 Sep
 2023 02:05:45 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:160:cafe::de) by MN2PR13CA0007.outlook.office365.com
 (2603:10b6:208:160::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20 via Frontend
 Transport; Thu, 21 Sep 2023 02:05:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.19 via Frontend Transport; Thu, 21 Sep 2023 02:05:44 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 20 Sep
 2023 19:05:27 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 20 Sep
 2023 19:05:26 -0700
Message-ID: <5ac6a387-0ca7-45ca-bebc-c3bdd48452cb@nvidia.com>
Date:   Wed, 20 Sep 2023 19:05:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Enable >0 order folio memory compaction
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>, Zi Yan <ziy@nvidia.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Rohan Puri" <rohan.puri15@gmail.com>,
        Adam Manzanares <a.manzanares@samsung.com>
References: <20230912162815.440749-1-zi.yan@sent.com>
 <ZQuUl2DdwDlzKoeM@bombadil.infradead.org>
 <ZQuZdkxm/GMyS6wY@bombadil.infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ZQuZdkxm/GMyS6wY@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|PH7PR12MB5710:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e1788b6-7bac-4dfe-a37c-08dbba474402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WFqBBCUcemIRPHgydIVKAgIdV49xH/ZwMsSgf5WM5yXko/2MDM8VInkFtp7HoAz9uqnUEy7Ae+WHYz+OVIDfSIv9pJOVukHtE9Eh6qScM6HMC+HuUlu/Tccd45ql0IKaI1ONTTe2vvNPx01pigdonTh/+mvAY+vMehh5VjA/BT81HRlsESixpkuP/Bn2tO04yvpOenY46wbTTqPqACqqsQlYGe/I4aOq7NTdJRihFYEbAWC3kS+E33cWhYiCpJmF3cYk0gVeLJlna4XyrmBJ5ONmHO4hGz8W7qzjNNWiGVoNvby3DZX9Iw0t45nqNe3PTTmORBcksEVWDahsuauECfRDWAviLIxAkNIHkWWjzRbocdBB+JYgfAn4/u0tQbYcZWHFwb1QOKFTrmofX92XeAqABnsT625SOqmXyrcQHfN8m2rHVwGsKG1D0hJElJUKYzu6N4dasJPhSUMAHT1aMuNtbJ/9xKTRy+rmIhzyWHC5VEzvKHM9lE4XuVGah98R/xlAyqcXMkIlpiYvewDY+rOIEHa+I3/s9fty73JsyVCMvpWGwhg/TUaK6QYLqTKguwNwYezLRubX2cLDNcY2Adlvk8Bc2dhlHscFFKfQJX0piGwKoOabDUtXmh4sQIWv5QerFjKkb9oyDJI0nHvnoHxchtR32rNUptBb87qrUo2tI5KAaiV13GPAcmJGPZ5OzPEi74/ZON4RDd30GQimfZgnG0YqMrNKm0Oh9q13E1fZz779od+3QrYrDvs/e9OUYwO/OZxUzwZSl15hSyIkBg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199024)(1800799009)(82310400011)(186009)(46966006)(40470700004)(36840700001)(478600001)(7416002)(8936002)(41300700001)(5660300002)(83380400001)(16576012)(40480700001)(2906002)(70206006)(54906003)(6636002)(70586007)(8676002)(316002)(4326008)(110136005)(31686004)(26005)(2616005)(40460700003)(16526019)(53546011)(426003)(336012)(36860700001)(47076005)(356005)(31696002)(7636003)(82740400003)(36756003)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 02:05:44.7181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1788b6-7bac-4dfe-a37c-08dbba474402
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5710
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 18:16, Luis Chamberlain wrote:
> On Wed, Sep 20, 2023 at 05:55:51PM -0700, Luis Chamberlain wrote:
>> Are there other known recipes test help test this stuff?
> 
> You know, it got me wondering... since how memory fragmented a system
> might be by just running fstests, because, well, we already have
> that automated in kdevops and it also has LBS support for all the
> different large block sizes on 4k sector size. So if we just had a
> way to "measure" or "quantify" memory fragmentation with a score,
> we could just tally up how we did after 4 hours of testing for each
> block size with a set of memory on the guest / target node / cloud
> system.
> 
>    Luis

I thought about it, and here is one possible way to quantify
fragmentation with just a single number. Take this with some
skepticism because it is a first draft sort of thing:

a) Let BLOCKS be the number of 4KB pages (or more generally, then number
of smallest sized objects allowed) in the area.

b) Let FRAGS be the number of free *or* allocated chunks (no need to
consider the size of each, as that is automatically taken into
consideration).

Then:
       fragmentation percentage = (FRAGS / BLOCKS) * 100%

This has some nice properties. For one thing, it's easy to calculate.
For another, it can discern between these cases:

Assume a 12-page area:

Case 1) 6 pages allocated allocated unevenly:

1 page allocated | 1 page free | 1 page allocated | 5 pages free | 4 pages allocated

fragmentation = (5 FRAGS / 12 BLOCKS) * 100% = 41.7%

Case 2) 6 pages allocated evenly: every other page is allocated:

fragmentation = (12 FRAGS / 12 BLOCKS) * 100% = 100%



thanks,
-- 
John Hubbard
NVIDIA

