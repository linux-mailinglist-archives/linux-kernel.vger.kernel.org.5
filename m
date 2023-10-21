Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A877D1E2F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 18:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjJUQRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 12:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjJUQRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 12:17:14 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D791A4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 09:17:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8sE6gwdz6Ci7L1XItgZxstXyBV+Z5ubVBDlitpfLVVUq5w/y9b6VK8utkNUULgLfNj/Yq2aPray/y+nD1+NSeGzXgzD/Bw4U24w3AEmB7hewCm7kp5Ljk8yJUYjgkTX5+Gx0Zvy1vHGHOHHgD6tkLHF1flg5t91eNrQ6Nk8pHIEUTNKAIeleR6QxH9MPiKLWBcoiqKRDrMuuczN0pU1mTNzOu46V2bNaKyEPLoJqCRA0gHi7Fz2YaxeY2viTHPe9z0gw3wpLObSFqoS1X+lBAA+RvbxOdBfHzOGJNRdfkNF9Q2kh4q8SBR8M8MVUyRizQzummXqhEcE5/Q4O0T9Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HGDuIHDwg9qL/LOn4ut91Wc8F9/a78uzdBEpirLGCA=;
 b=Bu8HLL4LT7zGUedd3xVsoWvy9TmwXAMsWFh3BBPkWeuIiA7fi0iuDDhWp7+SmqZyIAtJaqspLe3obv37J2Cfi+DDJnnwK9UpRLZBi9aNCn+EZg/WM9rQoyxbXZQ697W7kKfvkfiWpz7fjDZhNUy3l5qyDqbDQLm4nqtRlaUCm7zG5IeyA4g3rAs0GrRihJWRW9p1vSjet0WE7KUh36L3itNPCV4VcmWXEAgBLzTQ8q88veJJtuMTKVY/cgStnYADR9c0zQSdcVOfORaFYKqTC2Jva/ek2NyMLdO4Jnbq4y2AbrgjDj7EBs4iBYmLCsCTtyYyo7qOtQOLDVb6dBnPIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HGDuIHDwg9qL/LOn4ut91Wc8F9/a78uzdBEpirLGCA=;
 b=iUOogd7C+8wo30I4DHjT8k+9jUoOXBM+YovU3qfaXq79NfaTNHkaYtaHEFb4HYdJA9eRfz3CtyDqMuh0FMlLUnQcss09zq2uzvMgOR6TOUaNnmtkXFJJGS3Ne70djYM5A0dR/fDCN6cW1yNvG/z7WTqbIJGtzKITgrna6YfOYadybI54OtfnJUOZ6YTPMgWQ7h2mdfDT2w024RcDIvXBrYNOTFisQcI89DXe5I6g/dU/7QI1+S9jWF4nDQHb/k9T9N4RloNpQQ/bpksevissM7a3pONm+Q1bQi2xnH/v14RHbhlv+0jPUuiv1spEeCQgkv2NaDiwXfGIIOE0rJxAIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5386.namprd12.prod.outlook.com (2603:10b6:610:d5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Sat, 21 Oct
 2023 16:17:07 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Sat, 21 Oct 2023
 16:17:06 +0000
Date:   Sat, 21 Oct 2023 13:17:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     kevin.tian@intel.com, yi.l.liu@intel.com, baolu.lu@linux.intel.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommufd: Correct IOMMU_HWPT_ALLOC_NEST_PARENT description
Message-ID: <20231021161705.GJ3952@nvidia.com>
References: <20231017181552.12667-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017181552.12667-1-nicolinc@nvidia.com>
X-ClientProxiedBy: SA9PR13CA0112.namprd13.prod.outlook.com
 (2603:10b6:806:24::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5386:EE_
X-MS-Office365-Filtering-Correlation-Id: 1181db7c-724f-4d22-1a14-08dbd2512b8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bbPdO/PfUVJojuJ/2Mk0aFV1kp2fjXuLaJ1q2MCFctpSSieLgciqkAj2Dh9+PiLqt6SJqT/WHrArbbPTZhZwW50lAGAEsPNrqolxJVyrze/KxZd9Rha3IuUrFzUkvex02M0hhpGWHFQk6i35DsyFGB8ffsBBi1zpGovOT0gxwvxeUJfyupZo4P42kp6xHPnpln54ptHvtctv3JSGMUtf5LNlWLqIbXs2TUB1DV02IL8wTUOIintJj7Cebuq0HEGgaSpS1JtlJUjmGX9A9/yXY45eokjE1pLidYjRhZ+yTppODKkZlBbow+8AQrUN00nzxC85BgK+IOejE7YYCM4uCbAlwUkScBalig8qfP19JQopvMBbDyVUmlRUyHQ8Bv0tbF49R3bwYDZJYmPfa8kAA0UMDJKkypPGEXdYBDxib02qfhGTKdln2voOLARgMfAaAJWzG5Gq1oOj0neT5gph1rPBB1/aghbrKf4lU8b8FPXVwIbXtQLQKRCxVGERAX3KTuCwG6ZFOdu3UWsxKP1P/+GqfMemyMcsHhSNXFvjck4+nYsrXDaTjYgzCKYrDJAV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6506007)(2906002)(478600001)(4744005)(6486002)(8676002)(4326008)(6862004)(8936002)(41300700001)(66476007)(66946007)(66556008)(6636002)(316002)(37006003)(5660300002)(83380400001)(38100700002)(36756003)(33656002)(26005)(1076003)(2616005)(86362001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EhYdCSmD4PHBd9K5dIg2lXEbQbieZlVlcFNwH0FzErUUK1bw1HdQJc7DNkm7?=
 =?us-ascii?Q?Puf5PFY+ESSCybPvQW0wKFiaiiqcE6ISAmm9wa8Jjph0wH8Il+xhTwlPGrlu?=
 =?us-ascii?Q?ZD5fKzDuvixlmI82wJLn5fbIUiTt3fNcbZhztUrksGFkLtgnIJSOLykAERgV?=
 =?us-ascii?Q?dqJA6F3bg1qBSzfgYQ0ro6wUBajgfUaIhJz93sQBvpNVI/AIdGpCP8NzStDj?=
 =?us-ascii?Q?TfBn1DEKSfRPc2VMfI1vhivueA8kxyxmXqGmChUXl3SGEb8Xuw1JzGn7z3hw?=
 =?us-ascii?Q?jpHZazEkVyrJgdvXOadjDHe0EZaQxTUAmlSgBx2z2/4qYep2m/VvdBMBaSY5?=
 =?us-ascii?Q?qwFPIRL/QK3+K+3tCnemNK0yVRUKkIE61Mk0Vjl++XU+mkWdnnj+llDKwaN4?=
 =?us-ascii?Q?76//290QpDBEYI7IwhHy5vv22ABerJ9/9+E6ojU5VVrwof1E5KObepK680E0?=
 =?us-ascii?Q?kObPZqw8d4LhOfoeKTYsP9ciehzFEu9t+5GGQqx1ea2of8b7oGJ1+xxa9YHK?=
 =?us-ascii?Q?U8JVwYsiq/qzzQ4FdlGWcHrRC1fE4+XjmWKFuSObTV0s1Bm9KUXHs3QjniDv?=
 =?us-ascii?Q?oZQtPtij9wKcPWcxq0qWo+FMfpKclj6VSzQTynxxhPFmK+k5SCghMKXQS7W9?=
 =?us-ascii?Q?0hzfr1HqclHLtuOj+V+FjObFVXT/VNectdkBFBjKdFlOKuDNOlAO/1jwhc3Q?=
 =?us-ascii?Q?kbFoRgINYaDuZwfTbpp0ptKFWSlQTwCXudB5VQoOguZAn6olYos4LbXcrA5S?=
 =?us-ascii?Q?Va7w7JU/EaFFpVaJboSq10edQRc3kwV+hdPwT9srXTbACIPSrOFFw/99rU3j?=
 =?us-ascii?Q?XNH/3ylVwsOF3JM9HdvevSwzccjIasXNBUVmm7WIO2Z469bTxo5Ak1vT/58g?=
 =?us-ascii?Q?pKBAAtF6MApbbWw0mQfQ2xHD2fW+jeHGsAfKhWHn61i/lrX4E3cC1siJSayM?=
 =?us-ascii?Q?80IegFi/lE3NR/cGqqPqxb0Q9qbe/2I1972JB06KUTspjHhl2ixSAj6Y9p3C?=
 =?us-ascii?Q?/4xkMVeHOmj0Mz3Yglnq3XsWxuX0kEvCJlxtSNv9skCr+cN4kVRD5zolXPdX?=
 =?us-ascii?Q?O+gXNeJHsr+yoxhIJcaNyVtDQyK/cTSbjdIuSw6BnPIXxZAqaa2jRI7G07UH?=
 =?us-ascii?Q?2br7pdHlTrqucOZjiUvLXv48gT8eY0W15fnokRFP7xAo1zrpzuxTVuZBHfJP?=
 =?us-ascii?Q?WajU5YqkYEgxmlK7+WRrtoXN+IhDdYiJYcqyOZkx7LzY85QelPGWj1I1Rx+i?=
 =?us-ascii?Q?Jzgwj32uyD/IgVrgMLoweMotE2Hnt1NIxo0WoXPkFkVZ9FKTFJiHXsn/KA4H?=
 =?us-ascii?Q?U6il8sesg7lFS6rnvtTbw6Fsw6HWUIDhYdZND/CtGyZ2fMQSy3a3vNJktTU9?=
 =?us-ascii?Q?U/jEPbF/J9lJOnR1E0c6bvs8q0BaJaOBGAXkXTTuTepz3LAkQZwotiK58tO6?=
 =?us-ascii?Q?N9erTWWwsyGZ/m3Dp2Acd4I8f2O8A11Z0ZcYH/hDVeODTWSlGs0l1HeTYa+W?=
 =?us-ascii?Q?ayQa4mm/eieB9sElgPQN2Nx7RlWgH3R8mmsCl9ssDo7jVtVcpIz7iYRaicOy?=
 =?us-ascii?Q?JDNZAtCjOpKEH1YukLo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1181db7c-724f-4d22-1a14-08dbd2512b8a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2023 16:17:06.9030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fV+d3onTyyRpBQYZcem41Dcksax04TK+gDtwGUnVC1pf95JvB5EAc6HEQG2sYZXD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5386
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 11:15:52AM -0700, Nicolin Chen wrote:
> The IOMMU_HWPT_ALLOC_NEST_PARENT flag is used to allocate a HWPT. Though
> a HWPT holds a domain in the core structure, it is still quite confusing
> to describe it using "domain" in the uAPI kdoc. Correct it to "HWPT".
> 
> Fixes: 4ff542163397 ("iommufd: Support allocating nested parent domain")
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/uapi/linux/iommufd.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Applied to for next

Thanks,
Jason
