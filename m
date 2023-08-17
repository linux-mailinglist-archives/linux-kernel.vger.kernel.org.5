Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA2877FDFB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354499AbjHQSim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354508AbjHQSij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:38:39 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D852D59
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:38:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIvT2YHa+p9LTLXPc1UR6sA/7z0Cj8aXs44Ksd/+wrgfPGFeOdiW8yhZZ2/OJGy9CLNzP2wN3nztCyV1cl09PDv53ra9nEUWvy3w45u4APsTn+JQd36fG9Zvfd+Z3MeBL8m2xMXDt977gdCd4J7Gi41da/t2VStAIExyTpx6tX2EgszU6h8xG/FFoPnFvhsJ2g/4MDxupppnLVIB9FkHQYwTnbWfey+ZOptC1m/JGz8o2Zfzl23/c4wuioKaUYKbOEuMpPNLDee0zWusB07PjejI794nv3BYAs3xBLNzcPQHNy7w7vYHkX9wOpMFn+cOwMXnMw24NWccADUUF7016w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6zrnhuLPcLdfmVk2xcup/ygAkuT3Zk3izlTTm0AOg8=;
 b=D1+cWSYXFipQtSoYnAh6vVvRT+LrzJF/6nef7/SQ0kSmhBMlVhG2gOqIRbX5/CKfnMicyY7XAamO8x0t9YOe2NLI5M44Oo6j6GNgF93WKytSPEC25enH0nmRIaDiLXp2+j7vMwHaV+p2HNFnZK1VeIbyzuOcfDkckT+euzA6nZWQb5VyqzLxjYYmbCxx34VvGdFOhEoznnNqhTe0YZixuKl8SbWE2/Z+XobOmBS36seoTh7/hq2tw6jfnepW2vhRI9WqIae9HlH6BShGFYMv6zDiRIaMgMrh/TaEbK54OHRJDx7Z9Vknho+1bZhmdWsUvk0rziEma8T0Ba2vZNF/pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6zrnhuLPcLdfmVk2xcup/ygAkuT3Zk3izlTTm0AOg8=;
 b=MLZEvge8tr+Np1XlKK2qRqw5YeiNncpjK5vpEJr/7P6GfxILwZYdR0B6clz3AXGPve5Khs97g8K+8gH31FtDQOTMUiPfRTTYtzPrrTAkPWdyuizRUA5CsbCkPx/m6bUcOGJ+XZsvew3igOwMYC34FTKRkDJySS4geXlIEpUIHUXX+No6g7iwHrIt6qAdElnLKG9UuFLRM2/4yX7yBqhr4/55RNYRwqaN7p9IPUqOskZmZs6SzrMh+5+W4Ny9rCYoJJGk6zPgCZikT24k99N2++xfEs7XCTHHvj9oMH8uAY4kJBeSihqHsXY0LUstoewefvNRnMtuWxoiYbMAc2ZUHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 18:38:36 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 18:38:36 +0000
Date:   Thu, 17 Aug 2023 15:38:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org, nicolinc@nvidia.com,
        tina.zhang@intel.com, jean-philippe@linaro.org,
        robin.murphy@arm.com
Subject: Re: [RFC PATCH v1 3/8] iommu/arm-smmu-v3-sva: Allocate new ASID from
 installed_smmus
Message-ID: <ZN5pK03Drao/egeF@nvidia.com>
References: <20230817182055.1770180-1-mshavit@google.com>
 <20230818021629.RFC.v1.3.I326c62dc062aed8d901d319aa665dbe983c7904c@changeid>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818021629.RFC.v1.3.I326c62dc062aed8d901d319aa665dbe983c7904c@changeid>
X-ClientProxiedBy: BL1PR13CA0368.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4885:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d168e21-273c-4a35-bf36-08db9f512a95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Wu2u9+ijfbkOCcMt5FnrU24hgaP3KZXvH28jUF7L/2Psg86jYniTI9ZsSQr9qfcFaair6PU30TZaH+H2bSls51YtQ5ZEU1dz5SfdwlBp7KIlSUbO2erqqk1uw9esM4DL1Z8CM1nMKsviHMIHM27HQdkMqDnXLtSizjnuQJLwuzNjkmRhOSPP/xrUiMa/YvZPKB2nSnhVHv3qurF7aOIODhZ2kOn/dZy1DFxHWJsCBtKKjgzq6GWN32XIkP0RXHZf3/QYo3e4FAuhtdZAdC726rOmgJb5eF+t6/8b0KKNUZWgJgTKPx1wC+ANTBrNN0Z96mquwVAE/nwYsRoo23wOXgBM9cUex1J/SnNz8O96MxhFZ1IgqwKt7EIwk+BaViGt/LpYsEsXConnnmteSeH9YEtpFKnt3Pw0uR3whaQ40gKS0OSVEU3v0daAqNOzIZXFC0Z964Sy7p9OZX/DK5HtOq67GGjGqCNRUoMZENWasqxayo7MdMKP43IHaW80t2nObZLVRnDZ9BP7clmx2hd74AIttx2N0ntd0sbvipSzFVSEKgK2HWIDjtrnKVIZU+d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199024)(1800799009)(186009)(66899024)(66556008)(38100700002)(6916009)(66946007)(316002)(66476007)(478600001)(4744005)(2906002)(41300700001)(8676002)(4326008)(8936002)(5660300002)(6512007)(6506007)(6486002)(26005)(2616005)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/6IVbZv+fZlYDbn2bYYfOIiY9CxCwZRZMR5wHqqsfUxNkkfClmNXmaxGKZxx?=
 =?us-ascii?Q?LRZqI6H6oktQF8wMnVx5ASuL3hGb5rErXGqgKdUER7C7AUaWoMpI9PwzO0vw?=
 =?us-ascii?Q?vJc3mxVs9txC51yqDCR6mmdoO2l9dc/g5JIc4lZ8WYGiBQvlj/vHJf4oxg8T?=
 =?us-ascii?Q?l/jwOYMf6rsjxLpm5oN7CcIW0lUlaly3RXIC8E7Ql+T8cGiRHMuTSbw2N0/j?=
 =?us-ascii?Q?rulZzlxWKatOc337rl0tH8ZEQoI/BV7BDhJcm2qegY0JWFhNPNt7quhii/JM?=
 =?us-ascii?Q?ujbtigcDB9czzfYSI6x4irzNVC4nvhEsE5uDEPMMeo5hO11pBMPeDDHC6sZc?=
 =?us-ascii?Q?PcbKcM+xIkQp167gvHszJO+nO4JXwEIe1IuJ0OxFZL24e+YMP1fcRiWwAsBt?=
 =?us-ascii?Q?2gliHt33pjvKT1XciZxhRfKto8JQwRb9jjnzERFmvCLuvdOgaGUUpYiQ4i+b?=
 =?us-ascii?Q?XW3BrY8qD7/3RfCPrvqnWUBC/1tzFHgAJF7B+x0m2MwMcTKC9EKAAgFKv3t1?=
 =?us-ascii?Q?Ut4mI3rY6BAALIszIL+uxbGE+0RLHVNHElGMze4SwZavnFK8k2R12Oro4na0?=
 =?us-ascii?Q?D8hbAyJCPgPcItk/lZgPD2T5p5VoQeTGPTKws8UmsUmzIujr4BDFoWhqXYF/?=
 =?us-ascii?Q?jd/m4gn4hua7eI3QtfiX8RFPDHOSOJT542JYkg8DSBkP7D8N8OO/NpN/vG1+?=
 =?us-ascii?Q?91mLkpuiqhN9XOV40pR1m19JbU87vgt9jNPsvgAV0nN+agb2EhuCaqer+PQA?=
 =?us-ascii?Q?zdZG+MnVa41WrTX1NR8GN+hL0kgozdy5U8nYmRt4rdRZujUfd2+t1ny9GjHj?=
 =?us-ascii?Q?jFJzLd+hbDB4SFE1pQKZl5GqOr12/XhQVO+HrmABTcz5uSw19QwnKM4rQj7W?=
 =?us-ascii?Q?pFd8n39GCBaox4nYthxlteZifHwQKBdU552QsDBHkqA1SYlZpYjaAVXmz/au?=
 =?us-ascii?Q?7lczwXzYMLZJzl2nFijtBHn17M4g/1qejT7+v4P9n40twZ5HPx7jm9OQa9cx?=
 =?us-ascii?Q?JgDMZakOc24j60v4KVz0eT5QnqClmjm7lr0o1rdx0pqPTegNnz5jppSzH+Rm?=
 =?us-ascii?Q?PsqIoVoEFCvJ3pRHwwCncyUt4XBf20nMMWWgxNyGWMSrEf+sDGj1xkGeJa/i?=
 =?us-ascii?Q?mfbPsY5/eOK7/XxQgtEvUw7+yvgZPAagtrqBs6jsOoRnsiedzQVYWBUCL8Ee?=
 =?us-ascii?Q?yzs15p0KksnCO7u5152IHSRCuz/Yv2eyosMYTWbcp3edGv2h71K6nMp6KI8X?=
 =?us-ascii?Q?XQdfFvgQeNVj7UCBR4jCRm/UswPAeGOuaTP5BGeny9XV64cTrCJyi3a0TEGv?=
 =?us-ascii?Q?53YoJVMfmIlIMW2gxAVTnRbB6MIlK8/l/lWksvrbPcN002vMCLouhTT/IO/k?=
 =?us-ascii?Q?aUlmMVsNfr1TBhxJcQGK8dBoo+gE23NY3Ti8+uN3StDj3H9lWRdsEdEXAohW?=
 =?us-ascii?Q?aABk9imGhicwW0fxq+U8VYjl3USbYCq+OPknKlLaonv68+R7UsLMqcmtyxTm?=
 =?us-ascii?Q?kZjRPqRegjVsmBUgYLCzWOo8a594T01gLuZeMfNo6iKDDJiVYTGq4AFIBMzt?=
 =?us-ascii?Q?iuI1LP277jBSJUE+VuMHNZPBJzxR0PI8RzRaPqL7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d168e21-273c-4a35-bf36-08db9f512a95
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 18:38:36.0038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/bIPCLGCCNCpAHwRQ7Wp+TfpTSpUJTLbv3POe+XQAdXwIqdRFMUFveV7LliRG9W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4885
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 02:16:25AM +0800, Michael Shavit wrote:
> Pick an ASID that is within the supported range of all SMMUs that the
> domain is installed to.
> 
> Signed-off-by: Michael Shavit <mshavit@google.com>
> ---

This seems like a pretty niche scenario, maybe we should just keep a
global for the max ASID?

Otherwise we need a code to change the ASID, even for non-SVA domains,
when the domain is installed in different devices if the current ASID
is over the instance max..

Ideally domain ASID would be selected at domain allocation time.

Jason
