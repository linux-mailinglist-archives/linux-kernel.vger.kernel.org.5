Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69337A239E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbjIOQaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234780AbjIOQak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:30:40 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2130.outbound.protection.outlook.com [40.107.244.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCDD199;
        Fri, 15 Sep 2023 09:30:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/urbbwp8lGtXs3s/1AEv3sx6+y9WtxvunYiAVtGekgSxPLAvugPeYr+qizC0GWuCtx8K1m9Ps19dbXcuOm9F4wLSPUs/NPa2nRgI/qjL/JBe3GSP++ZejTpmjfiSOkyuVD4RJLU237AuzQIaVBT6yhKzDgILg0PJOWvd+03hiZfuNGqB+dsZbDCcibf/k8EiycAyZZLmjwP+D3drHNFsVxqbxwqfMjrf4DSzfhNwJfiROxBA9qfblaSdLP5mG/OI2dNXq4xZcTmkRAwd9fvqmoVQVJUDeIdbrwgVgY0ApHpUzQBKBEdG+Hse8biTa0ZzxrPr8C6RdPw0QQ0gfqY8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjREtO9mVWZXJMBzL9FOV6grTzcrSR6wzQ33piVUmoU=;
 b=cD5rloLF+TCo0MtHUZkKkr50RmYHe+2/tIFWIcZIoArW34Hr89AgwlfLUN0zfSzTGNKHOyUTcyBJzt/2u/7++tK8NYbg7jfa00ul7+Mk9p1HiFQrcu+yhZs69mriATMJZ8CtXlJgVjUwRo0+cpPZ4uMbKI7fAUSgmNVPdm4n3k9m3xQ6OOpfSVE4UCL+d9Ip4T34EaWrwg2OeWWpWKoT0gxD+Spzd0eAfpLa2bm5bS/bfcGtmXthK6/uKAt3Yqb4E5CcXckHMRq++E7MyiT8nKB6vUi3D/R6iQa8wHcMRB422ipr4C1n+rT68yZ9Y0rAZ5ePrNiHw61bHYDdYZ2ibQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjREtO9mVWZXJMBzL9FOV6grTzcrSR6wzQ33piVUmoU=;
 b=jj5H8kBvA7BN2v36qjR1zmqWppPKflAvccrRzg6jIQwP+1jfcgT2KsKRQeFyok7vZ+mlFZjPv+MFT435bzz8OXtozk0rizXPxI21To/aI7zHvcR2HU966S8kDfRoY0YEtIs27jpRMk8m97CLZy0dEw7bqCPTWKgMxziByAJ/v10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM6PR01MB5259.prod.exchangelabs.com (2603:10b6:5:68::27) by
 BL1PR01MB7579.prod.exchangelabs.com (2603:10b6:208:387::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20; Fri, 15 Sep 2023 16:30:31 +0000
Received: from DM6PR01MB5259.prod.exchangelabs.com
 ([fe80::66e5:a568:4a5b:c19a]) by DM6PR01MB5259.prod.exchangelabs.com
 ([fe80::66e5:a568:4a5b:c19a%6]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 16:30:31 +0000
Date:   Fri, 15 Sep 2023 09:30:26 -0700 (PDT)
From:   "Lameter, Christopher" <cl@os.amperecomputing.com>
To:     Dave Hansen <dave.hansen@intel.com>
cc:     Matteo Rizzo <matteorizzo@google.com>, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net, luto@kernel.org,
        peterz@infradead.org, jannh@google.com, evn@google.com,
        poprdi@google.com, jordyzomer@google.com
Subject: Re: [RFC PATCH 00/14] Prevent cross-cache attacks in the SLUB
 allocator
In-Reply-To: <7a4f5128-28fd-3c5f-34c2-1c34f4448174@intel.com>
Message-ID: <1d7573c0-ebbc-6ed2-f152-1045eb0542f9@os.amperecomputing.com>
References: <20230915105933.495735-1-matteorizzo@google.com> <7a4f5128-28fd-3c5f-34c2-1c34f4448174@intel.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH0PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:610:32::28) To DM6PR01MB5259.prod.exchangelabs.com
 (2603:10b6:5:68::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR01MB5259:EE_|BL1PR01MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eaed984-0eab-4a57-35d4-08dbb609140a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RA8W6Mn8UCgIjYrkvfYOukYuEdxErnYmYPZIECmUUzaj4c6MBueheDhO+Lv6ubW1Igs1dxc6dVtAhHcnXAyNE/NtPan09TfBqR6q4YlnqjeRyCFVTjF1JfykOP33hRkzT68OoWMagPO96uJkP5gQzXn93y4hT9cc5rwSLX8MhshyvY4o4yfkU6LmtbOW3PU9S2V57R1OeELH66+oSqtq+mBU7GbRSt9yobS/kJR2votNbrnMXah0g//gu1UgUiyUQAT0Li0D02D9ivMfFMGtW0bKEW6dLpVoUOTLz9nm175h0B+rYRztzMRTz1EvJk8fwTtESNmE39oA/XQwE9lwlrw43MLR7OeaoR5A+R91pevQyh4uz7rEQdW+B7QHToJo8BE27Zyx7byPTAlBRdxLJb+klzjxI3al/ZYTy5zKa2X1FTAikoDzdFSZPFjx4f1LVBWaHRJxcWEsUB11T0Fdf7yGAvY7hyoubjFzUXo6hwe5/ii5SkcRO7OlXBARCPNhqwLIJ1RNvlfzrdVAK0U0y0fXQRkjr3yKgtMjeNA1WAbhzCAoYH9cfTorz4iSjfc0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB5259.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39850400004)(366004)(136003)(376002)(186009)(451199024)(1800799009)(8676002)(31686004)(316002)(86362001)(41300700001)(66476007)(66946007)(66556008)(4326008)(5660300002)(31696002)(38100700002)(8936002)(6916009)(83380400001)(478600001)(26005)(2616005)(2906002)(6666004)(6512007)(7416002)(6486002)(53546011)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G2r7lrgpm/CI6m+x++qxCM9zlHemjeqnOG1/9ra/jEusXScgKRlkE7dmjfsJ?=
 =?us-ascii?Q?y8Dgoq92sM0WWXLUy9HP9ER58Z4OKbQHhcrzJ9rSLCcLfESOqFPw41jB6g/a?=
 =?us-ascii?Q?F/IjsQc0I4RebWC3Rh0O7VK/m6g2NFdOn/3UJF/jUEKQWIoiCVk/rUoQh7Pp?=
 =?us-ascii?Q?DS+jnlar1D9bkZCnXxC6Z20ZWewUOjTQ7NTvbTk5krhOlNHMxjMOgexdh4WT?=
 =?us-ascii?Q?5H5oiVH+QVnEeQlB4oQ0frx61SYxEB0pDZV5gVdNePU6J7Ja4VwuGIVNpW/7?=
 =?us-ascii?Q?iNbt03pw6uOSm8BA/uzaBKNdSx743aY+lQa6vdjd8xA2Q/Sn083AGVqkgYmP?=
 =?us-ascii?Q?loZ+IF3WN6S3AKo6MlhFZTVu3ImLwjoGx9uH1QsY3UMHd1nR09jUejEndjLz?=
 =?us-ascii?Q?fMh2D2QcidU1/zkbZJ3eAHQ2qJyZTAoGODBgtO0vlPb5b38XvhW+KcPgkKUl?=
 =?us-ascii?Q?I2N2HOsDBCdm0VNxvSvnPzmseys/SOCcFdiHyShqNYZ55+VWY6G37L7o7sc/?=
 =?us-ascii?Q?Hu3lgFpP5hpWSu0WW9TuVmmWHnbsElVI5YV2V3fVctwyf0yShlcjMUHN87ot?=
 =?us-ascii?Q?prvvVZQNzYAdLmHZvzLP3OVynvys8LkkZ/z5SnagC9EdKp2x9CgXGC+n+s3Q?=
 =?us-ascii?Q?g7ZenPHzPzPmNLr72o+ZtYwTIk2K8hxz6XbP7X8ywfRJXwEiYDxrBi99YX4X?=
 =?us-ascii?Q?stNpE+qa0LCsG0VEPWdtstfTXUcgRT5SxoJ1YrgNonT+8YRM6v09mCLwCnJi?=
 =?us-ascii?Q?8T4cZLh135OzK5I4h5TlRAk4c97mfeqZa7dpJbfgLnT16xs1fRsGJMWa0D0j?=
 =?us-ascii?Q?LWZr8N7VKIE6J59KWESDfhAUfLTti9UoVokGMS/L9XpcQgvnIpQb78TcXlxF?=
 =?us-ascii?Q?uRNE01rqla6GVlgXzxUwHiBQuR0w/pSPe8ZkEl7NAs5g00sfEQAfWRf3E9Y9?=
 =?us-ascii?Q?edJtiK3co7yPISPzJtIoU8HOYyAVGl2nVq0kpQLBjoRlzUl8KaXkR6cka85Y?=
 =?us-ascii?Q?prTfOGVakJhZInULyPI9Me1oypevXU8lAkSHhfKzMm1XmDAdm0/84Ra53Gk2?=
 =?us-ascii?Q?jstd+DMstFEBExMVT/zL7FKGER+UyyqXikuLTWYtk/MF2C5qa1CXkLwrbw+3?=
 =?us-ascii?Q?AqxDTuZRItJw2veXmoOXXcTHjWZPv2Gr63rNDRVHr9Bkhc3Be5FUUsdEJJwy?=
 =?us-ascii?Q?3zsnw+Ty90/pDslin35m2xfHLnM7AazeIOuMh8/24GXNtOkwARkJWLEULWW4?=
 =?us-ascii?Q?lAKYfLe1ULZu1duPcaDNqr0pokxSOMseAMEybMXfpm/OMJlUKbsXfhrfUrYU?=
 =?us-ascii?Q?0o+SsUC1jQn3G0e6G7k1Wokm8a+9bUH5mwOo6MFh3RkvFC3nDR/AzpNJZgQl?=
 =?us-ascii?Q?0zeQRRhQkedHXcCFoMENbAqNlNcmOLX8xyxW6Bb20CgCVsoADdEXEnVY1T6O?=
 =?us-ascii?Q?eWJerBMST+YKk2MYkWxbf6/PykFsZe9Z7tTZrNxG38KKfNrCLEZkshFJpK/t?=
 =?us-ascii?Q?dKwhSgl22Loec4b0n0ob+ThJuZnpzSxxxXsJCWKGepPkVqhxJqOB1c+RnohP?=
 =?us-ascii?Q?2L+/ysMa6ZvBnHhmhkxn5Ra7nYhlLIgge6eQzNw7G5svDDtF4ftDJhrpL1ss?=
 =?us-ascii?Q?xzY8LIDnAZytZ968asKL7GY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eaed984-0eab-4a57-35d4-08dbb609140a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB5259.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 16:30:31.1406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y2jBadSYONd9qD6viJlyt3RWp9/Da+a7d/2j1gPB/CHOgwkwtH6fDjeM5GfjVNdLymwg71xOlf35uQfgIoYkGLIgiQFf1xnmvOrIrJaxJ9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR01MB7579
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2023, Dave Hansen wrote:

> On 9/15/23 03:59, Matteo Rizzo wrote:
>> The goal of this patch series is to deterministically prevent cross-cache
>> attacks in the SLUB allocator.
>
> What's the cost?

The only thing that I see is 1-2% on kernel compilations (and "more on 
machines with lots of cores")?

Having a virtualized slab subsystem could enable other things:

- The page order calculation could be simplified since vmalloc can stitch 
arbitrary base pages together to form larger contiguous virtual segments. 
So just use f.e. order 5 or so for all slabs to reduce contention?

- Maybe we could make slab pages movable (if we can ensure that slab 
objects are not touched somehow. At least stop_machine run could be used 
to move batches of slab memory)

- Maybe we can avoid allocating page structs somehow for slab memory? 
Looks like this is taking a step into that direction. The metadata storage 
of the slab allocator could be reworked and optimized better.

Problems:

- Overhead due to more TLB lookups

- Larger amounts of TLBs are used for the OS. Currently we are trying to 
use the maximum mappable TLBs to reduce their numbers. This presumably 
means using 4K TLBs for all slab access.

- Memory may not be physically contiguous which may be required by 
some drivers doing DMA.



