Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8FB760CF3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjGYI04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbjGYI0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:26:44 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F094E66;
        Tue, 25 Jul 2023 01:26:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNFVufOSmLSjzOPw5fzYSHZrHAZmyDz7HyDNQW4Ly1m1SeVPKaZnHBJlfVrW1BQqEKtS98UZNhW6az8gcgyeajj+Cp6OZa3VAOfthidwf0n8IH7McNWA25i1EeyA+4/lCiKsBINwZAOarp1wYPBGEbJhuZUFHhq4hGKktkWY7Ndumlffk3lXV8WySpDzQQwk6FsO+bNEiee39TnMNTvOAD+h2sebDdj/lc3HDZxwGY2o3ikoA2Mi1udxGAAFdnG+QijycMRlY667YLi2Ox9RG21YEqIUt4l+/FfiMm+299z0fhppJ1VQwrROADKDVgb4iU+3pCULxKjJvbHpl3vxdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mL+wS0JMxmWjb8oDX1q+GUX5YeM5tB+twsw7HeFaRME=;
 b=ejcNKpgcyE6XDy1mpeem0f5UWYfvJGb2MnyJ27OyNaAz0kkGOmeOK4G+td3l3RcZvwKmtBqx0cTlpNiuUw+0jVfXbf+OmRS5pyUAZhwiaVAAaHe9FKNd+veCvUI/9YHVpfjAhInHjgszlJLGYC8kLjZktGlu3k8e5ttkVciacKAEQ4EOURHOc9eDOCZ5+zTdCOCO0tDjDdJpjrVpHjO+bO8BGin9xXvwnVekvSkJOIXB2HbJlSORxyzWghCFAdw5TFI0+6WcSPxSQmPWBAtuuqL4kxlt9hGwgyCsUvm7J426nkYaZmzailDtxMCekT80y5/Via4Io0BLlimRII/VAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mL+wS0JMxmWjb8oDX1q+GUX5YeM5tB+twsw7HeFaRME=;
 b=dC6lKvxKgZbLaY+WeB4V7zgX8lcb5bbxJftoKWa9/SHLbh4SD5453C++qxtx68GJCXR1hIgIVETFi/Nxrw/2kDATPTDflB3islchUGuaW67+aXnR4yugooHMWsZgE5I6RmmQ1OyllF5SzsKN4C2ulKLJypbD89MZ+yslDvMCI6SjUJ1aNSRLaTCOEOuKgoOBwJszBtRWa8sQEt5v8L+r0QaF9UFQc7gxMDT/qrP2Bu1C6r4anV9lZOj6m7R4MUBTzlZ8ZJNqS/hGmOMIkFOzdjs3gRp7KpENWJgPx8Vxg0phDf+Tsw+KH+8qqloAi4wBZ5XhOy0zJvHDuZcOAuMEMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 08:26:38 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::c833:9a5c:258e:3351]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::c833:9a5c:258e:3351%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 08:26:37 +0000
References: <20230721012932.190742-1-ying.huang@intel.com>
 <20230721012932.190742-2-ying.huang@intel.com>
 <87r0owzqdc.fsf@nvdebian.thelocal>
 <87r0owy95t.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Alistair Popple <apopple@nvidia.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH RESEND 1/4] memory tiering: add abstract distance
 calculation algorithms management
Date:   Tue, 25 Jul 2023 18:26:15 +1000
In-reply-to: <87r0owy95t.fsf@yhuang6-desk2.ccr.corp.intel.com>
Message-ID: <87sf9cxupz.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SYCP282CA0005.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:80::17) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|CY8PR12MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: 41a31c78-53cd-42c9-59ef-08db8ce8dd2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b5O4+BBDCotbjAkHk44zHmtiCdMEa6sbhuyZVavapNnmgvtyH0gsy1nX/UObk+qcIxKDw5B6mXC5AC750TKUE+gSoP7e0QAWkMS907j8Ebr1yoIEEf9HEqz+8t1HMgWcwVpyZNbXsLrNYbzkPNhWS2W+G8kMaSWTiM2iqsr7CuBrQKkwapQcY54n7qGINMlvSde+DRKezzX6e47YvhBd3MCnUXGwcOwTLnUXRIHTPcM5bBURI1ZXnyCsiNHTvAdsh4zxSQT6lpylPHH7whjn9eeUlKyw+Hq9UUgpXZffztCN0dcNrmMQmQeCCmXvzzIRJQtKyNjls9uEyMnRKVCKZ21RDA7OHUq3QpGaH71QubIWoECZNZGX7GuUHlKKzlJyz3ZuYngtHS2C13L7xzMGImTtweD1OYNyRZ0kqC07ghMRaS4g6wOclGOx2KXPjoQ/m9uPndTY6sw7oq6xyoDkoYlzZgTIjfrtr0zGN9QFFL7GOgtVdaCpPU0geU1LIJJcOa4So60JKJRpgUFiB56QTWKQv3sYq3Y6G/PLo7a2m+WTg2Bo+FmOjJ5YXc28C0qm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(451199021)(186003)(6506007)(26005)(83380400001)(6666004)(86362001)(54906003)(478600001)(6486002)(316002)(41300700001)(4326008)(66946007)(66556008)(66476007)(6916009)(38100700002)(2906002)(8936002)(8676002)(5660300002)(7416002)(9686003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kPJ2hOsOyPe+uZJceUn+YTwOI0Y2w6JcHachYeYOmYNTZfWMfzvSdDXAv6DH?=
 =?us-ascii?Q?MmovqCenjFzZ3WVdGTDZ0skauZ+5WaIWfX0J3/cpfWTqPHPXBbQ4l+FxGE2K?=
 =?us-ascii?Q?aGfurb5LM5GVDvWsOlXBG1SyC5L8NJr3SOpL1K+7Ph9uMHZK7Fqum/X96u/7?=
 =?us-ascii?Q?j/A7jXnj96LhdjbHSjm9CSzDeAEBk0ibmKgFvsHZvsSHs5Oo9khzuMKfN212?=
 =?us-ascii?Q?GzNNOITsipfHTRqMSfYn04nvClCYD9Nm9jb4NgISx2NpLZmaKrzzZgQH5yWY?=
 =?us-ascii?Q?B2oBNv7l+RCbYhvwEf7L/r3t68zbWL223PXpB3pA0uABm4lf5xYgpsyeDyIf?=
 =?us-ascii?Q?BKfglCpCCccPclzsKCqUF2KcyczxnuizPEPyVmMH8vnn6VZMu5edG/7Ftg8D?=
 =?us-ascii?Q?joN6bUaE0nWjCmbwh2AKLpkGVSrmyb3Yb7B2l8paMH4AXHit+my5WHOHm/J6?=
 =?us-ascii?Q?KJch1w95hJKKpJlJc+GEb6D5o1M/Az7QzmX5MrHBP4obohEw7V2Fckm2UapJ?=
 =?us-ascii?Q?W6/+/Tak4KMC6u0zR1PLDDOP95Klv8cfMyJDA2lbSGyjFWLna64qAzW1xe6J?=
 =?us-ascii?Q?l610NpJd21E6sLKGBIZYRBM7Cxa0+pgs1VbWE478WXb4neWh8teXdTvF2Q7J?=
 =?us-ascii?Q?5pVEk13tMBL0SfbfQb5bZa7CAdSW1LX6AQ05JPlyLVxczVmMb4Bpo9ehaYB1?=
 =?us-ascii?Q?rNQyr8/EHJ2O2gTo8p0GB0ae6TaH0PRs9uAV+RI/B+uCDYXeggYuWHRjjU0b?=
 =?us-ascii?Q?MGkkNPELTbEDq9EKEY5FhBrV/HfJPN4K4fFYkhDDFf8i1gsXOInxiT65hFsR?=
 =?us-ascii?Q?yBumKY3fHGtWQ61j+p8CPWvL2L/BsqGAzZi5AApTgEupvuveANOtaUBYyIM8?=
 =?us-ascii?Q?b9Y2ri6ZQXW9GR7v5ccfVp4gldEXrIaVLAaDJnVU0QamUd7Dm6/eFZpsjRkj?=
 =?us-ascii?Q?tSG1KIzE5vwDIy5/NXucciKToNE1b8Kvlz9ulvEdYjiWx6Ef46vYI0CmKY38?=
 =?us-ascii?Q?pSTWuqkbfIycgNL/MVp7DZUYDPIZjGlH3lLPxmIevk8N+zMS/VQidmOadpBH?=
 =?us-ascii?Q?b5hIHeHXkKRLCABIxXEO3WRdGl6WsCuuZofFcLvsCShr+QowNkkdYrbJ5aoU?=
 =?us-ascii?Q?rb8dqAWn4V5E7OT0jpE5SW2D/Mn9AkFPMjJyjApEOSlhx0TPjdnwnSeXHaKL?=
 =?us-ascii?Q?imBW+VkgyZQB+rhi40OxgDP9ch1RFb4FPIUEZSNmx2KWGf5D5Bxap9Gn92qg?=
 =?us-ascii?Q?xV+vPN22ME1wyHH0qTGd8bXIKxyjthSYYa13iEkRHtoU7FlwgOmB4kzaV+uR?=
 =?us-ascii?Q?gc/OXMp04kbrS6PdkPdv23gapQeHVAxAetArQC3/HNGH4wSsUAlN2jjIOK6t?=
 =?us-ascii?Q?FqSwJE2i5hAIBYw4jsNdCNmU1xBdYHugjdhyN+RqyoJbxE3za3jgdfvbmfHa?=
 =?us-ascii?Q?i0vVjxI9r9S3gVqFdXTSB9L/yKop10ebp5esLHkv2PmqVL/c00h59otKx0B/?=
 =?us-ascii?Q?IncqfUtTzFWr1cazMFoawSLHSnpxqYIm6zH8K13sMK9OEFgvkVrSrI7zfAFL?=
 =?us-ascii?Q?Xh/aGwfSCb+FtPCzbrDdyyEWkWW3T+KD4mBmcY3Q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a31c78-53cd-42c9-59ef-08db8ce8dd2a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 08:26:37.5777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4sxLAUGaLq1H/tsTefkrc0dbR9O5xm0rT8tQjUDpWkky6A8+bSlm9lmsK8VHRpp/qrMfCRRjML9G98+jm2aZBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7435
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


"Huang, Ying" <ying.huang@intel.com> writes:

> Hi, Alistair,
>
> Thanks a lot for comments!
>
> Alistair Popple <apopple@nvidia.com> writes:
>
>> Huang Ying <ying.huang@intel.com> writes:
>>
>>> The abstract distance may be calculated by various drivers, such as
>>> ACPI HMAT, CXL CDAT, etc.  While it may be used by various code which
>>> hot-add memory node, such as dax/kmem etc.  To decouple the algorithm
>>> users and the providers, the abstract distance calculation algorithms
>>> management mechanism is implemented in this patch.  It provides
>>> interface for the providers to register the implementation, and
>>> interface for the users.
>>
>> I wonder if we need this level of decoupling though? It seems to me like
>> it would be simpler and better for drivers to calculate the abstract
>> distance directly themselves by calling the desired algorithm (eg. ACPI
>> HMAT) and pass this when creating the nodes rather than having a
>> notifier chain.
>
> Per my understanding, ACPI HMAT and memory device drivers (such as
> dax/kmem) may belong to different subsystems (ACPI vs. dax).  It's not
> good to call functions across subsystems directly.  So, I think it's
> better to use a general subsystem: memory-tier.c to decouple them.  If
> it turns out that a notifier chain is unnecessary, we can use some
> function pointers instead.
>
>> At the moment it seems we've only identified two possible algorithms
>> (ACPI HMAT and CXL CDAT) and I don't think it would make sense for one
>> of those to fallback to the other based on priority, so why not just
>> have drivers call the correct algorithm directly?
>
> For example, we have a system with PMEM (persistent memory, Optane
> DCPMM, or AEP, or something else) in DIMM slots and CXL.mem connected
> via CXL link to a remote memory pool.  We will need ACPI HMAT for PMEM
> and CXL CDAT for CXL.mem.  One way is to make dax/kmem identify the
> types of the device and call corresponding algorithms.

Yes, that is what I was thinking.

> The other way (suggested by this series) is to make dax/kmem call a
> notifier chain, then CXL CDAT or ACPI HMAT can identify the type of
> device and calculate the distance if the type is correct for them.  I
> don't think that it's good to make dax/kem to know every possible
> types of memory devices.

Do we expect there to be lots of different types of memory devices
sharing a common dax/kmem driver though? Must admit I'm coming from a
GPU background where we'd expect each type of device to have it's own
driver anyway so wasn't expecting different types of memory devices to
be handled by the same driver.

>>> Multiple algorithm implementations can cooperate via calculating
>>> abstract distance for different memory nodes.  The preference of
>>> algorithm implementations can be specified via
>>> priority (notifier_block.priority).
>>
>> How/what decides the priority though? That seems like something better
>> decided by a device driver than the algorithm driver IMHO.
>
> Do we need the memory device driver specific priority?  Or we just share
> a common priority?  For example, the priority of CXL CDAT is always
> higher than that of ACPI HMAT?  Or architecture specific?

Ok, thanks. Having read the above I think the priority is
unimportant. Algorithms can either decide to return a distance and
NOTIFY_STOP_MASK if they can calculate a distance or NOTIFY_DONE if they
can't for a specific device.

> And, I don't think that we are forced to use the general notifier
> chain interface in all memory device drivers.  If the memory device
> driver has better understanding of the memory device, it can use other
> way to determine abstract distance.  For example, a CXL memory device
> driver can identify abstract distance by itself.  While other memory
> device drivers can use the general notifier chain interface at the
> same time.

Whilst I think personally I would find that flexibility useful I am
concerned it means every driver will just end up divining it's own
distance rather than ensuring data in HMAT/CDAT/etc. is correct. That
would kind of defeat the purpose of it all then.
