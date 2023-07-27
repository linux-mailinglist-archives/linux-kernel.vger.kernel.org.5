Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A98765B8D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjG0Spl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjG0Spi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:45:38 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DA72D5D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:45:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZPkiTNm7lzpTgX2iaXwAC9b9XBdbY+56uyx2efWfaov5Iczvkc9ugzQqhFozoU1itUsv0LFi2y5mm2ZUi+ZEq2K74VIgQgl/55XeL1lcgtkdr2uVzticf9qGKrZYrEjestqHQZ4hHr69614k11XZqEiBSWAWJ2qb4y0MZdmUDprXN66EkiAsxCp7tkj96JCD3vXMUAxNPgGEKtPNU9joXV7OZxjA1NeP1q0LeSK7xmGaUUqeUru0WMWnqpORpYEHbDg2ySBReHSc4sOfOTMiQOBy74ZeJBNSk3G9mAm3SIHmKogGS3y25GF/WQvTVv+d3YSmUpT720Ml69+6CvZCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuq7oKGB/KTSy9zUHBajpxnkua91KrnwmjoItcsaPQo=;
 b=Nf90VE8MGd4BEW2YnHIqKAs/3OhJiyHqOF8ZZEWkpeWW7M+7CqExchojQ9ulp0qI0+KBNbHUmAM6o32hd0xpqwiP0yeZtVdNpahXjB7vnnDE5QJJXAlqlDG3DaeNFlfiusRzRwH5bLtZ0QUzURsO7aun7ESgDOwDrbEKgoBWRSJpS3fE9gQoKe30gWE874zt0/kcmPHO9gbtU9g/9dFlIPD9+aulQ2MoMNPG408fSB3/TmMzPSMJIsmcKvKnrJ+NBfVI6nA9lxcj+2eKJhP1ePotO7Kw7A5vi3kHi8kosgRRf9z1Eos7m95JgS7E5pN5myLGxYx+Z4/1od3TOisbwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuq7oKGB/KTSy9zUHBajpxnkua91KrnwmjoItcsaPQo=;
 b=IEs/jbfki7z+DZd80sLuZ2/RbEOO2yVDLOnDTgoGt5ddzmLJKud2tyDVhhHdNMCKaQixJUTTOFmO0pnT3c4fKVcjF5syqKj6VCaB6SOqi92Donxp4AsMB8vLI9CiZC21y7diw7h7rfczB3sp6tEK7RW9oqeMWuEbvXKwzGyvgwNXxynrwNMmz/2N9ipFbv38QItokHbvLXkIVS+85WUKESGr0/zkGPfQYLKte3kNeJip6sqLl11wOqvATxeHANArUFKdR1BiUKRCFYgHG1OzU+lYJPL/9THh+D0NaEnmCIMm4Wd0TWjmRyr9vIvqGQLWCCd3keJiJ70kTVdmCo22Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB6336.namprd12.prod.outlook.com (2603:10b6:8:93::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Thu, 27 Jul 2023 18:45:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 18:45:35 +0000
Date:   Thu, 27 Jul 2023 15:45:32 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        nicolinc@nvidia.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/7] iommu/arm-smmu-v3: Move ctx_desc out of s1_cfg
Message-ID: <ZMK7TMA3BvInUx+l@nvidia.com>
References: <20230727182647.4106140-1-mshavit@google.com>
 <20230727182647.4106140-2-mshavit@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727182647.4106140-2-mshavit@google.com>
X-ClientProxiedBy: BYAPR08CA0047.namprd08.prod.outlook.com
 (2603:10b6:a03:117::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB6336:EE_
X-MS-Office365-Filtering-Correlation-Id: 66e6fb1a-3ad2-43d5-c4e8-08db8ed1aa01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n8s2HHq0YXnng+OVqY2xhZqETFbKluIaVVvUt7fkZN1IBQO5OT0c/9BJase1CJuXdlK2ZFXt7hQf3PrdqNp5kORCdoDHjp121HF9v6qMpa6sQYsz+3p/vFwdQkgJheFvolG1cFKUs1W3P6dNk+4voWiRbGzNgnlJhIwjKnhRSm+jYF4re89Jsyur1cj5cSIbWYXjhzApbMveLoPb9QiIp/UWuvjxsXp1kDLhkw3wEjKihQPqebCgRr2tf4FFDYSpg/Y0bME8TKwxCwnSh1ghHYuT8AQ3IOjPP6++4a9iljXeiCLV+F2r1xyoLDOVsOGqJ34WYsOi33XUR4zrJui3dMFRS5giW2JgwwbeZyf6k9fY/DPXJMJQ4MJFbxq4LNGNqBYgfYNQSgT+MiMCW++/sGZPl2aEqm4oNuvFJvsB87zidMKXFJNwr+6jq4meYe4CrjGKknHGqGerJAFIL3eGRfpq1uStzbcfXKgKmIiCM3XDCuovDh7SRITI6hoQpqbhAcUjv5+/xPybj+hNIsTOqMX8PIJb6FoKPc7DKEiKm1Avs9/nTJ3TVftffLfOwWuvEv5mpi91CA08adA+3PzRmPLgZAimTcI8h3QZ2q8tQ6k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199021)(316002)(6666004)(6512007)(54906003)(6486002)(478600001)(38100700002)(8676002)(5660300002)(41300700001)(66556008)(4326008)(66476007)(6916009)(66946007)(8936002)(2616005)(186003)(83380400001)(26005)(6506007)(86362001)(2906002)(36756003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rUR6Ckb1W1w4OYvSnh3aiD97RTzol8/1qN3FcA7oSA8BC88Fk3y0PBh72qt4?=
 =?us-ascii?Q?YMRuoteUgZeLs8fPnBjeSUSjPcw8ZRgOKTPmkhpL543N0xg4qUUz82sRLc2t?=
 =?us-ascii?Q?8pbnVfww6Yinm4XP0lR3J2kbfT00T2E68OTVYqgj0Tbrh23vrJh9C5EkT2Be?=
 =?us-ascii?Q?ZdjiQ650njFJGZMGQA20r3RkGfJ4qwumfk32yDF+2mml5wqfyLzieNfOvoFj?=
 =?us-ascii?Q?fS6OPm3igzUVxrhB2kAeQPvNDgZq9oOjzax7OKoagrlH0do0N/muOmDQ92tP?=
 =?us-ascii?Q?kV4IG7wQMZAH6bmjGZsujTNKdCLvwT8P1+TYRfiwayHKFM5FRDiLdCtD744e?=
 =?us-ascii?Q?3c0qm0crGrJ8Hxyh6vRy3d2RWD7i66dS1YmjJsUKY2Tg+D7AS9ic8BL3xeGj?=
 =?us-ascii?Q?LflOL716fs3Xl4c/WmnDq/IOvOOsl/Hjf1X2V7t8QgBL407ts7u2zLiIh5Ij?=
 =?us-ascii?Q?24hl7kYI6nCcvz3e50Ns2/d4wC/Xfyn1Bil2HYvmEnP8SASOYpc+88A9tk7r?=
 =?us-ascii?Q?ZCG4E6XbUeJlQuMhgk7rDqoG55nvFv0IoD7CUcL05b/XKvwrgqSWsCaueozb?=
 =?us-ascii?Q?wwY9sTj+eVvCo7bqlCt7hfGW0GeGJASeNfCiD9rsxJhKq8/Qej0m3CSAJzAR?=
 =?us-ascii?Q?O4n+1/bBjktpInr1L62c+mK9aI6w64TecAGK30UAgEXsmNHt6Abr0xnZuYS8?=
 =?us-ascii?Q?LF3p3FXijD+nL9bKOWlSe+oVLV7GcKz7YRSwokw+XIXyIjJ8wJAoS6sSIRbS?=
 =?us-ascii?Q?gICE/T0Y6HCI/YPnx7QUsc4a/GjB7+iDK6SV4rm8ELuCC9+EjPQNQYPH4CP+?=
 =?us-ascii?Q?4eHqx6Bnb4dVKfcka3TipxfKFJcsopak5F4IUbimpEgGj+IoKphP1b3ARbN9?=
 =?us-ascii?Q?cX+bBxU1fCedLNSPnwNqtyI0LKN0+8iza9ZWmb0PSVUP/2yiNjpnUnM1iTLL?=
 =?us-ascii?Q?WtJSTFKP2qbGVvJMZW7fEvsyfpZREDrVHKIXDUC/hB3EeYZj8Z2jlU4CWTwb?=
 =?us-ascii?Q?4o1HQdNeRdjbBsRgf8XgjinTcQKo1o0ASF3MuKTOgcOMqwqTuc6mYDCbU0sB?=
 =?us-ascii?Q?e0XMjfy1ZigdOWBKdecubqdEtkYPhJcCwNv+iRhbOHAF9bPuCRs7E3tWYIUs?=
 =?us-ascii?Q?yuOOW6rrN+o1LTh6VvAAAyi0t8z6/AiMSiak79TQQvL0YRubVwpillTgcy1t?=
 =?us-ascii?Q?Z837ZMh7+NuHdMLWqhoHYb+H690Is+Uhg62yQiiOwb6aEewUpAJmPyTMAHJW?=
 =?us-ascii?Q?HNzJOzQcASGTKImJQvXavhlzfYTVSj0fYFHNH21V96ltsAvOtt1rRCE2nsOQ?=
 =?us-ascii?Q?MrQMLtUwVg39dPrH1RVrjRsA3sR5NLVNAiL6/SHIWWMXx+0ZCj2OmW0vfJrD?=
 =?us-ascii?Q?QzgOyoVCnqGrbxdKDz2L45w97LUEEsS9cRsI/lYF7rqFhBcSfYPlRNFQ1ERA?=
 =?us-ascii?Q?XrEGapBwvyUyqEPxg1V41bGoSafuVMwlrZHzh/Y8LMmP72LFO/YRRhQZSIlN?=
 =?us-ascii?Q?vjH452Tkr5eDZBcKYssO70yCjG0NYcnMkn6Eqi5U/+vd8aUgCl4ZHF1H+on9?=
 =?us-ascii?Q?uoxN9vl/PQL+5CpLijjnTMUUuZ0zYGXINkv/JGDH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e6fb1a-3ad2-43d5-c4e8-08db8ed1aa01
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 18:45:35.6268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QqIN1CpU6SLQYaLRSpy//7yym1VRhKaH6MkCKVD2rawCzdiLxDwJcuQoJLXcBI4D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6336
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 02:26:17AM +0800, Michael Shavit wrote:
> @@ -715,25 +714,28 @@ enum arm_smmu_domain_stage {
>  };
>  
>  struct arm_smmu_domain {
> -	struct arm_smmu_device		*smmu;
> -	struct mutex			init_mutex; /* Protects smmu pointer */
> +	struct arm_smmu_device			*smmu;
> +	struct mutex				init_mutex; /* Protects smmu pointer */
>  
> -	struct io_pgtable_ops		*pgtbl_ops;
> -	bool				stall_enabled;
> -	atomic_t			nr_ats_masters;
> +	struct io_pgtable_ops			*pgtbl_ops;
> +	bool					stall_enabled;
> +	atomic_t				nr_ats_masters;
>  
> -	enum arm_smmu_domain_stage	stage;
> +	enum arm_smmu_domain_stage		stage;
>  	union {
> -		struct arm_smmu_s1_cfg	s1_cfg;
> -		struct arm_smmu_s2_cfg	s2_cfg;
> +		struct {
> +		struct arm_smmu_ctx_desc	cd;
> +		struct arm_smmu_s1_cfg		s1_cfg;
> +		};
> +		struct arm_smmu_s2_cfg		s2_cfg;
>  	};
>  
> -	struct iommu_domain		domain;
> +	struct iommu_domain			domain;
>  
> -	struct list_head		devices;
> -	spinlock_t			devices_lock;
> +	struct list_head			devices;
> +	spinlock_t				devices_lock;
>  
> -	struct list_head		mmu_notifiers;
> +	struct list_head			mmu_notifiers;
>  };

Don't re-indent a whole struct just to get column alignment. Do
a few lines around where you are touching.

This is also why I quite dislike column alignment, aside from being
unreadable, it harms readability of diffs and increases maintenance
costs.

Jason
