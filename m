Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD82B7D73F4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjJYTKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjJYTKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:10:30 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2086.outbound.protection.outlook.com [40.107.101.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCD3194
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 12:10:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LaI2qnqDlPSKeteB0VagiFiGckQ8u1upSOe7tVrkUtA4AhxnJkEErteLk9ccUd03vCu3vjwYryqmoUTOGXYeGR56zvE/F6xLmcsPuhI2T+KGuhTHYH41eQMK5bpWtBUelnkkfAcHAsac62YE2PjaxRePro2skzsP6sPW2Cy1MHXN3IYTmsgiKr7f8WweQQD6TknYBjOWqqh4HzKs5woe77Dh/1tHU2AhBVWdMj0Xpp8Mu4dgDgyb9sLSxhA20Bh1iehHbiSIAvNgbQJtvpBzZZpQ8hP8RfhLOddyKPQo5BupxPUnqwzfWBRetz2xrcqAXXYTWkVAIf2N/xa2dX7dgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuTPu+aINgKmryMTaJbRTRbFTHGQcLtxUC44PrjuAaY=;
 b=lFKoqrZpd2Ie6ZHt0NmZce6LqNQ1/67g/7tKFQnrjWvq24xxa5n7KyvW9tJB9Iup9KiRlYot/dTwo6MoKkmFuzR8niM+W/M23hzody9kda8LKSeW6LCMow/PTGEahA6xzrbtf6YmGKZfhRlMPUqEysRncGRKx+6fY599riLoassqplR3OCre0fvy/C4idMo/jtEWPS7fo+7loOl6jp8nwJh+dbtFxISMHjXL2BJZtGtKuZEZPcGmEFayh0dqolGBzRDKr3XaMSXn/E/YUyKyjhMV2zKQsAvmIWTOW8oxFBVrMccZZUmDiQ8Zc+5rguanyBdU0+i6+gl9FeM7+P7yNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuTPu+aINgKmryMTaJbRTRbFTHGQcLtxUC44PrjuAaY=;
 b=CGMCOI9ZDUJEIuHFgz0FtXfYekLMzqGHOxEwMLaIi4SQfOhXP66iYRgH24xYT1RDDF+0vAsu1ExuXA7q9Q+212//kaEs8qufnfLylVXf/Y4O+qpzFnlRyxGONEwLsYbgQ7ZR23FcjXtvhgkR0FMXYBgfO/CUldec6Lbpdh3jEFT3Smtlod4HoRvio0mx9v52DbbTKpQ4JzjxRviICdGDZBf4fBBRwYuZgeswXCpMsji8j0eKt8ZZuXnE6RKc/Wv/qoVQuvX5TEAMWHE/vfvx3YLKqOP7xNit9vc5fm8cL0iGYJNT+mOK7aCp0rLeJN8SwokvlUd1EZ9w9rSxWU8e/Q==
Received: from CY5PR17CA0003.namprd17.prod.outlook.com (2603:10b6:930:17::11)
 by SA1PR12MB5670.namprd12.prod.outlook.com (2603:10b6:806:239::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 19:10:24 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:17:cafe::9b) by CY5PR17CA0003.outlook.office365.com
 (2603:10b6:930:17::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Wed, 25 Oct 2023 19:10:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Wed, 25 Oct 2023 19:10:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 25 Oct
 2023 12:10:13 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 25 Oct
 2023 12:10:12 -0700
Message-ID: <197819d2-d7fa-47ae-b893-ef2fce25b2be@nvidia.com>
Date:   Wed, 25 Oct 2023 12:10:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] variable-order, large folios for anonymous memory
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
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
        Hugh Dickins <hughd@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <6d89fdc9-ef55-d44e-bf12-fafff318aef8@redhat.com>
 <a7781f13-21ca-48c7-99c4-22beef0400f9@arm.com>
 <fcbe9179-dcd9-4bf8-b1d1-82201880527e@arm.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <fcbe9179-dcd9-4bf8-b1d1-82201880527e@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|SA1PR12MB5670:EE_
X-MS-Office365-Filtering-Correlation-Id: 360b3130-1c94-4245-a403-08dbd58e0a6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kYsjyIz3VFnMW1EnGOoxNq9mplRZlFCbQzOZ0H6eiN8JpmYPBgR9V2uFyCnBmVzR2PP/tm7HWFN+CLcXR7q5x1kPx5gqXuVVXJCIDlYAqNkDDhQcNM6a+amMNUBP2Qy4aSCOj4OzGIeodLnfLoP7N3VPVTHd/VqBj+bj7HZFXaSYeFHobiKEIzCCIRvjrC95+h6KK4TxDhFdlvhKJ5PlG0x0OsX2zm30TrQVzPFo8Z+21W3KGHpzjcHzm0X4bw3YgVmGhmnUoYCvS86subgsNFRRxBKijkwgrtTrumIfdf+5/+yJYMW7GZhpWm2HaxbtKNeOq7vEgKHAPWHHuiFEyOdLslSR7ytUPjEfwQH94HuJHrskUJdux+OwzURGtUTKaw6HcDNZ3xDyA25OTHyd8nglDIDFm5wyywlUczAaHNZjxSDN3s/5fBeW901h7AspxN9KzKMScqRV6FShTG3vTBMcH6alWYEqy2z0Tj5hJgtUS2Y4EZDRBczJqEZvn+Z4Hk1PgMM0hRqvpWRozIMaqGG70R75WGjfd8ZDWY8tXByTj0rTjSujZMP+dBoAH/0a/geR9nT8gVXepIzQSAyavYXj5GVAJZt0udVgNILkkn8TPdXKNLP1n2TBHaczFx1IgovlHVLjH4FsSDzf5sVViwo6qC6ih/vmjdvcnheu617x5pDUuNzgjlo9A3MIwBKJh5qYrIpABC5736PEy6T9p13yvcyYe3CtdKl6dRSALXumauDIg8deBOVgJfgVV94t1iDXqj9ehVg0Xgoamdum+/bDURVIs75xJyHCpZlbrJE=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(39860400002)(136003)(230922051799003)(1800799009)(82310400011)(451199024)(186009)(64100799003)(36840700001)(40470700004)(46966006)(2906002)(4744005)(5660300002)(7416002)(31686004)(41300700001)(40480700001)(40460700003)(8676002)(8936002)(4326008)(2616005)(82740400003)(336012)(426003)(921008)(110136005)(54906003)(70586007)(70206006)(316002)(16526019)(16576012)(36756003)(53546011)(26005)(86362001)(31696002)(356005)(36860700001)(47076005)(478600001)(7636003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 19:10:23.8993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 360b3130-1c94-4245-a403-08dbd58e0a6d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5670
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/23 09:24, Ryan Roberts wrote:
> On the prerequisites front, we have 2 items still to land:
> 
>    - compaction; Zi Yan is working on a v2
> 
>    - numa balancing; A developer has signed up and is working on it (I'll leave
>      them to reveal themself as preferred).
> 

Oh yes, that's me, thanks for providing an easy place to reply-to, for that.


thanks,
-- 
John Hubbard
NVIDIA

