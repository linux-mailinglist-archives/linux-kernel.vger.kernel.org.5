Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75D9792BE0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345919AbjIERDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354554AbjIEMhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:37:08 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEF71AD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 05:37:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrcPy1d55e13gus4sqXl7nxXmBecsWoIXrMVnGY0vMppwVHQPKdhtVqIbnKgeciilponxOludXw/a4KKuq+yG8892uMj0C5v2jwbV/7IlaMBqOA4igGSfTUFjsejOeW8Na7NXqVTeA6iTD9VHgM8uwiaxT5uQcPQuvS9nR8LwXtQrOMRUBO5HKaLIk7fV5+TuLZQ96bW0EeVZ/qHXmXn5v+1Ycc4CvgE+hwjzswIZT6CPZYW7M+lh0bQx6+oTjcdigY+HJJggoHvIN8RzOadxh7ZTFJmQiZN0JMvuvXUI7O2DKLTfdpHyf5O5X8QMa2VqiopedK9vLMLI1XfIa3Y6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJAd4wVWpW5r5lToEKwCMKcYNuauHIFWYqp1rZstrLk=;
 b=X6C+jkPcYnUMcx5kOFG12G9HWLg5yvWRDJh0+oKhdFsNzQaX2QFeA+8qjqRmztnU8YwT177MXQDBVkwXS4QjKljcbE45o84kbzr2W4I2lmgTOZLCIL7U6mMhpiVl8w5NkM+0W4yADmldhCqM/uCm85X/6zi3hG7bV2NfnQTw5Sv6zUTIExUhBBkzSRJir2gAur6JdRUR35A5TOO5B0nOJzEZ5tuIZSAca53I1OgQ7dYTDEmKuE1qz48LuY+9NprWW7iXg4Y1sjrk/dgVDge3OK0xxv2b36iL8tnJ0ADEOVTZ3CvS0KPrljK2Ony545kcbpNM9FCC3Em7PUgUODuDgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJAd4wVWpW5r5lToEKwCMKcYNuauHIFWYqp1rZstrLk=;
 b=IVNLbwzYzLXQaDWJc8A4DrGZtUcb2J5isBJjlVXckeFvW5rdwhUqRCwdutFGfj0QHwQugEsffo6Zl0fADeeVQkMpkALJOa5UvKgqWYDfR6Sejx+jGKWyZB/AVldxaKQH4hhOcOLaGV8jhUecmw5yvx9Q5MGKm7tF7v73qbJHwWjx0KAvRK61lK3CGuLclZ5wpbp7ofn1vkLqolezpSuK9goWBC/FkQTT+oT9iKKP9Acemw504T0iwa/VkXg4l0cHBdMHkj+zj6dDaMwb4wDHl8iDhh3Ff6NUEMOoKUcfkBm7cEzwVc4o2D8hWXi7Kib/EB61BgHECTBwNf3YnESEmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CYYPR12MB8854.namprd12.prod.outlook.com (2603:10b6:930:b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.28; Tue, 5 Sep
 2023 12:37:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%5]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 12:37:02 +0000
Date:   Tue, 5 Sep 2023 09:36:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org,
        robin.murphy@arm.com, nicolinc@nvidia.com,
        jean-philippe@linaro.org, tina.zhang@intel.com,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Tomas Krcka <krckatom@amazon.de>,
        Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: [PATCH v1 1/3] iommu/arm-smmu-v3-sva: Remove unused iommu_sva
 handle
Message-ID: <ZPcg66LNhIPK4+vU@nvidia.com>
References: <20230905115013.1572240-1-mshavit@google.com>
 <20230905194849.v1.1.Ib483f67c9e2ad90ea2254b4b5ac696e4b68aa638@changeid>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905194849.v1.1.Ib483f67c9e2ad90ea2254b4b5ac696e4b68aa638@changeid>
X-ClientProxiedBy: SJ0PR03CA0092.namprd03.prod.outlook.com
 (2603:10b6:a03:333::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CYYPR12MB8854:EE_
X-MS-Office365-Filtering-Correlation-Id: 469cb9d3-3fe6-422c-a6a3-08dbae0cce0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X0ha/L/SutQ3si8uN2VzHRpm2BG+M7VDgS+cL43tp8VqiDId2+Qev/to7ApZWXw96fUmE5I99qD7XE3fBPc5DkeV18WN21BABlxWLxgBAJ9chqNUTxNu+WzI3A8YpfPa4e00mBNPDEoOae76D58GEHlWA2jg2otYOP50XFCqa/qUqnqKp+FzHqFoqlv6VLG7XWTPGTGTZRzy4ucPCVsih2jGb1XZqITL7a5eKSqPwKiZrof7qLSSirVVdr8J0T2lTbdMJTYWQpUH0TfRj9021B2rh+SYAZo6k1W21hYVQOdhB9s+IjiiVkqmm73812zoGSvAZ+TfN0VVdkh5QeCV6a6y0/jgWtTBLh2nXI8Fw2lxZO/EAHa4HcwgnVOj1cN5LwLAnsjPGFuAp6Q4u/KgDR51ab34wgHXxNQe5mHUuXjBNJ0HubvYLToGYuuw2FmP23J81heBgV3wydOyZNgNZC7b3QRznLx/BkJvuPUULrZIdDm8xnPShHj9+Z04/ozsJwvaaehj0bo4EiT3bEeIRxqMTHnsjYZTKsCCHBXt9cizBsRZoONHREz2nfEBHr97g1M5UImM9UYPhXIeHtq7OYgqaeWRlOCgStGF7Fk/Mqk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(83380400001)(7416002)(5660300002)(36756003)(86362001)(41300700001)(38100700002)(66556008)(26005)(66946007)(66476007)(478600001)(6506007)(2616005)(6666004)(6512007)(4326008)(8676002)(8936002)(316002)(2906002)(6486002)(4744005)(54906003)(6916009)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?arMwIgYLhPA2KnQ6nlGB9sUCfi1tliQfqkRlE+dWOqjhjhTpV/zbxtfsptxb?=
 =?us-ascii?Q?UxgRVLB34IXDsVdBhlHX1gRa14dut05pczGOy36jb2ABfXZNUNnVG70YWEkK?=
 =?us-ascii?Q?L6lEhApVz+3G8VaHqKtPaCDq6FP3mdC+s6MC83vVCfmRy0d/aGD0nuJ3OpJ9?=
 =?us-ascii?Q?1OS8MOIO0eS/LL8UdamDv+4ukC/I4MMthXp4dwM87dBtEScpLh88wmaoUWL/?=
 =?us-ascii?Q?qIHJ4pDnML1nUNeg7WkTNEnzR+TrvKJp0G81C3yDurdSMBopc0ZKztOCbYlY?=
 =?us-ascii?Q?xPGqFPSbCOUS7HR/PmokYx2TGYdj2C2UNnlOQshqmAyhH4kEC7ddVvo+prxO?=
 =?us-ascii?Q?/3uG6e3AvFTSe0VnmugwKj8khEdaZ2eL1ovyCDMVQeGCOz1kGOokJbJXQd7t?=
 =?us-ascii?Q?QhRsPYL/SwbE2Qo8/iUrh4kvOX6aneSFjPkm78GNf1uEoL483HxfpwTQ7Q1C?=
 =?us-ascii?Q?hPnhC1GQhEk0BkNKFER77hItUB4DWQuQYupQBNc1SsXkKdka/HMR0Htgr0ee?=
 =?us-ascii?Q?e3lk7b4CHC1kv14HYAj933ax2DQSlV58X7u3Mk8H/juaIWfjMMYBkSZJCecB?=
 =?us-ascii?Q?1F99g5hpOxxJ2m74lusgMHwf0cg7TyEx2lE0UDJeVkJ6oSFjn7ThFzGZZNwf?=
 =?us-ascii?Q?XN4qIGnnZLeywhAcjoLecMz24FsFYxX8MAcPZxH431EU+COOxOAUQPzEGOSR?=
 =?us-ascii?Q?GOQwKun0Nk8fqbnmlXiCVCuiqvW+CKrWoQVORJv1DCP9kZzCChXQ413LVoPI?=
 =?us-ascii?Q?MceS/mEwrc9fJTzpTftb7IYUJ780iRXqZzOgLgf89DKhu0/ARFwo/5CSBiur?=
 =?us-ascii?Q?VmIl3QzF3qz4bGn+I5JfzsQwxqgNpe3W7+dRvOf+AEwG1owPiSd8h7muCTer?=
 =?us-ascii?Q?WPVFSCpKaBNVHLVBed/e0lBsCTTIoYK0YvnFhNIObr4OutZifs3QUdExzxYh?=
 =?us-ascii?Q?dlhjz4CyTpubQBjLRD26IC7SH9nT5HQL/X1AOevht3x5xapIK2eWvqQlfHq/?=
 =?us-ascii?Q?fHrd5JZXAaInp9e6XzVcR8M3Q9zXWnZ2cn6Nfh6HZF9cvtwHc3JMnIf1GF+A?=
 =?us-ascii?Q?kBHV0sSI+q7wqmujia8fW9EGqZpz6bxcr8u7sd1FM8zRfxK3kAICFnu3SaCy?=
 =?us-ascii?Q?sX2mw9KOZBUqMuzpw2Trg7led0ba/WXK4tZmS1ub+8bjapnKrytv+/LtdFZT?=
 =?us-ascii?Q?GEczZFwBmQVEcNJgETW4E/AILNBb5737r4nqVComhjvU6/Ey2OSj7yk1VG/x?=
 =?us-ascii?Q?Y0ITC8cM8dkFlqWaiFcLgg81HLxtlamj9CFFrNlS5YP/lOBZ+U7heLP0PsJ6?=
 =?us-ascii?Q?mdETHy8l0XVxnaSpZjLlVTGvMI9E6J8bPxMReKu5P9/M1I4/N4y8sw957R52?=
 =?us-ascii?Q?XAd5UTSHNV5CBJZ2SNezQtYauS/AcskfQ33PFNu3MhWaXiQJF8YXJLh2uPHI?=
 =?us-ascii?Q?exjODdtcTIAKvGPJLnoo/kpT1V37QMj9xR8Enen5OjWMNhpv9ql4zdcHFC59?=
 =?us-ascii?Q?3rH+ZQJBnpqeZItV+4fAgpXLucSSZ5JLTfyPgSpknBWWG76azkZgLd8PolYf?=
 =?us-ascii?Q?/b6aJRBE5m+4W+rivSftbbICcb0fKVxKHaocFW/V?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 469cb9d3-3fe6-422c-a6a3-08dbae0cce0e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 12:37:02.4238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jSUDK/NVKspLDDkVk0LLcbZ0iSHaCUE4XOYykQnwdMuBB+Nsv5QGz0h92MMaMIVL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8854
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 07:49:12PM +0800, Michael Shavit wrote:
> The __arm_smmu_sva_bind function returned an unused iommu_sva handle
> that can be removed.
> 
> Signed-off-by: Michael Shavit <mshavit@google.com>
> ---
> 
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
