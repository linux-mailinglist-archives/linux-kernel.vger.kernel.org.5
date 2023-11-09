Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9987E752D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 00:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjKIXee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 18:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjKIXec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 18:34:32 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D02449A;
        Thu,  9 Nov 2023 15:34:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/2NWuYOpNUi1ZU7CM9Zf0lBl6x8d8uw9x3/UAHFFel8lQhwhk8C0FHfhMFxKvQ/zMqIeiugCa9P2rYRFRTdM1rpaQUVT7TeUZ88KoJUS7kE5z9WE5ok1f3CfHFd25sFfmLO8kuApbRhuQgaVFi5QR7T/PTHf+BDMpAaq0fS+vI0gRXu3+oOMegG4QrNtfawqVjBG58qbzrws3b8lF6g2VrYnCFaAxgrFLyN96EjR98Gxbu/KUMEDOHH45yz/leFrO9eTy75EFfZQXV9SxZddbSjQP/yTK7vXA7sWH0OHBnHBZy0QK2wpulWVWgksaTQLwvJe37WZsEeJTW2SMA2/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPj1KM094ljkmL30UOHdEVtJj4TZQdR/aGoxgaaozkY=;
 b=WW5DVKFYLLZoZv9WGW2Lx3u90PYHGWizoSGkCYaN1brovVDuLULUeCpPvD6XpoOMV0NNjGnDuAsMAueeV7Mb5Mx8eJV4+tO07cSEfgCNsnhzUCjEninz88IkaaYlV9y00mU8FHImRoEdf21Ir8RXw41DiGLkTlQ0tXDkwVLdOEuvuu2NrM7RTG4xyvZjP1+g9Ts+37KhgYqhMPodYbS4HSfrfQwRbbMLMr+AP1KLLeiZ2bt74gJPMSrdXEg054KGYCohq/fAB5ZJK8zb54KSFpPqMzn3IicUlzqSc5qXoyd6GmMl+hQki9Wea+w09S8af0bheb4+lk20AMZglE1uHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPj1KM094ljkmL30UOHdEVtJj4TZQdR/aGoxgaaozkY=;
 b=sFrXRfuQ3+fQgVAQy3hpF995Y+jZY2L+uliTe9yQWNlbO66qg3FS6pq9lkW2iMn98DG7BkrnmiNMijBREYcITbo3TISAB82WyP65dOZUzqn73mOfy0Lv44FZPSnc8G9E6eW98R8sMGmNyzcfm69q/OisJ8JPCaI+L91IdmZaqwaH/ZD/VDG6a33MWFAe5vjGssErkS9TmDsu29jC5MZUcnfPHKcVrPOGM2qGzQZQllNpFik6HDmHdaGtBD9KAAwYkdl53hW/nQ6kg3YDpWUa5Bc97WaoG+UxzvNP09wPwrxvAs8F7kZD8vhYb+InkOs/o1xKR+182RP7j6CW/irgfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SA1PR12MB6725.namprd12.prod.outlook.com (2603:10b6:806:254::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 23:34:26 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::a24:3ff6:51d6:62dc]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::a24:3ff6:51d6:62dc%4]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 23:34:26 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Min Li <lnimi@hotmail.com>
Cc:     richardcochran@gmail.com, lee@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v2 1/1] ptp: clockmatrix: support 32-bit
 address space
References: <MW5PR03MB6932A4AAD4F612B45E9F6856A0AFA@MW5PR03MB6932.namprd03.prod.outlook.com>
Date:   Thu, 09 Nov 2023 15:34:18 -0800
In-Reply-To: <MW5PR03MB6932A4AAD4F612B45E9F6856A0AFA@MW5PR03MB6932.namprd03.prod.outlook.com>
        (Min Li's message of "Thu, 9 Nov 2023 13:13:52 -0500")
Message-ID: <874jhua4cl.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::20) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SA1PR12MB6725:EE_
X-MS-Office365-Filtering-Correlation-Id: eabe29d0-0c4f-4cfc-469b-08dbe17c6922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ha7ke/tzEszCBZ7HA7vB5iXJLxdRBNs4ywEmUVQP7ClSCuQhpDPXKnWE+1wkVm9l1cCSr5Vqy/6Dp4ymF/CsquwHeA+dwB+qLfgp0ldsAivFcKGxXrZIlWZlE0hOSM4ooZSNACmtBh4juBhZxI2WoUX8yJTsLIqX0k96LGCdMSWCpIbxquRMQHxONwBQcpqcnnCxDs+Omn/QDR86o+7ioN0fuMwyJXsiyF+RCvRl55imR+Wy9XHDhUQ0vJ+ibfo1CUDQlSoqBUNAquJZKat/tIE2dfg3BLclXfXFofjC95xJoeMmKq1zUHqix2gfvrMifSA00Sa9GD5pVaJdpI25/M8ro2htANCbAO2NNCnf7ptasbrY1GNLUIbN/56TSotWOpQQtyAcYIxuns2KxYhrYImJHTHTjJSZBcYU+eYqEecI7hcBVtjX+SHnbhj+4ulWA9RzGFqrw3I6SV8VScYUHjTcmg+aNKHQQJ19I3dV72uq4RAV0/3HQGlnZ6vldvMYbF2diJugbdKg6rK4YMyHy6cjtmqH1mKx6qgGz+N4iFAQMfopBZoFCwBc2Bcgs0r+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(376002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(66476007)(66556008)(66946007)(2616005)(6512007)(83380400001)(316002)(6666004)(36756003)(6916009)(38100700002)(45080400002)(86362001)(478600001)(4326008)(8676002)(2906002)(6506007)(26005)(8936002)(5660300002)(41300700001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IOV7QEPH9TGL0NvPWmXVgnTWHEdF046Tjl6ynQjryax9+f91x/yRuobMsUlm?=
 =?us-ascii?Q?hdTS3+/3+HCSQtYDW/e6DyWZIdIaxPU9sSInIMCM5EVHLfrK2nk94Qvx/oGO?=
 =?us-ascii?Q?z0kcv+V+yfwpqYZF+SgffSwGXqorQdSq7c4DlmBohZWr9oYK7utg0ptsJDqo?=
 =?us-ascii?Q?SkFGDmZ2DtyUagye41IX38ObkDMMzqqrSMYfjDjQ6y0diveOoxPxAz8D6q+T?=
 =?us-ascii?Q?S3WUbt3b+PUPm2k3GkUld0hWUcyLYtbpccCbijkF3cMj/R7UO3Oyx5UQQe/J?=
 =?us-ascii?Q?aGEKcJADpSvbMbJyDS/pq99ZWMuMI3pszVi8Guv5E2W6aLfsaPcVq9q5ksOw?=
 =?us-ascii?Q?6Y3Na6nSXegv+8Q8BPRU3aoW/isupn4lSJ347ssZt73+xaJBdiculBWJrZkx?=
 =?us-ascii?Q?YtpDuaSwTK06ZkLGpHxBiKygSTsSaCBtMhrisPuPd8pHBVgdRLqv73bGxVvr?=
 =?us-ascii?Q?SsUoiKeDISA8ncc/77/of/o/9WfCnHP8Sahv+C53Vk28V5fF4BoLPHMeOibg?=
 =?us-ascii?Q?9Xgd/oyxeEIvTFGzc1uceZk5KLpKF00b6TdfnxVk9A1LvrODnaVh9pz09W44?=
 =?us-ascii?Q?RUKr6QC8qq3PEw6EefGfJywFW4FIkuwxgOI0Smk1pL///Jqr3c5hVZWxr0jF?=
 =?us-ascii?Q?qQCTf8RXYEmM3yVpV0Dko703DKDj84DVqTI3dlRvgrRVrEVY+bbY7PnTSaUe?=
 =?us-ascii?Q?GZ0XEQhED1seJoL1I6w1HRVFMgM9FPa0D3GJmDDvav6Pijmel8PcKcd/ee9+?=
 =?us-ascii?Q?hPlKlQY0KHzDjhNsYDeBk1vrkWicMyjE4IIbJ7R5hvjmqt1bEz5ACI99KHXW?=
 =?us-ascii?Q?ysxLJ60O/1tTNEK2mD8ZHncQbUTez0Zus5ZtF0ZoahsJ7w9cjeSXgfAFMh7V?=
 =?us-ascii?Q?UwoxEZGE7Wy7HcTQnglGrDdzBnWASRktQuEfm4SrVdMYbKuftNgKKkC+EDej?=
 =?us-ascii?Q?mebke33Arvso86skjtAiVySMtnGULlubfxo7rt1Iio4/c1s1bXFZyw44aZCA?=
 =?us-ascii?Q?2W40Kr3386aGEzTzvTcouc093rdYulitqOApdbBWbHiFwfzbrhxeGaGN6a+g?=
 =?us-ascii?Q?oLMaG6ZLH3PNdOa424rMKRxvolHs0T8YKZATozD3A4DQZDGhqs9cta6CEqy0?=
 =?us-ascii?Q?WQIlJJ0roCmzx74OD3jYBsp4f/wT7ovNK4Lyiir0jmX4XLZJJvG0VIxBBaPF?=
 =?us-ascii?Q?aRZ6WfJA+gUl65FNd2mo0FKL2BPs/9RInDNH6Ptx/loL2KnFCos+v+pIqB5b?=
 =?us-ascii?Q?NsGwWmpM0W9Ret1Tkuvs5wbejy0kJwj3sk8ChNiK7ow7SxwkIQLOs3SSo1iZ?=
 =?us-ascii?Q?BIMv2VfduML/W/o+tmNlnyS5zxAIX5Ujf8mK2lqt3YRQcSStzMpAfJkCk8rr?=
 =?us-ascii?Q?SPXmKclHwTDSzaBL7XjefUFz2/gheiajHRhfGlxq7jHlS/QT2bk9v8P22xIK?=
 =?us-ascii?Q?DOBMICGSNyJ7OaXxDaOCMTfxj86XFVDj1GKg494r4l3anVu9U2p4q5cQpuwG?=
 =?us-ascii?Q?xBT5uLZ57oZWyeEXWko37JCvyrXKL+P+6suskb5zsVxmjwbQMAlBAx9QbG20?=
 =?us-ascii?Q?wFSARltIeVi/zAg5yUPR9QAxjQTCJHJ9Ac/hexhqr9Kg8HD1Bal/lTnsleMy?=
 =?us-ascii?Q?YQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eabe29d0-0c4f-4cfc-469b-08dbe17c6922
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 23:34:26.1128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QgJmCAMtpuxCzWoljvHH9suWNcubBc+Zb52pNhpIKqNIu25xIHOBDBP2uTsKBEWnIYiwTtwOsYnv5wT2bdzHXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6725
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Nov, 2023 13:13:52 -0500 Min Li <lnimi@hotmail.com> wrote:
> From: Min Li <min.li.xe@renesas.com>
>
> We used to assume 0x2010xxxx address. Now that
> we need to access 0x2011xxxx address, we need
> to support read/write the whole 32-bit address space.
>
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
> - Drop MAX_ABS_WRITE_PHASE_PICOSECONDS advised by Rahul
>
>  drivers/ptp/ptp_clockmatrix.c    |  61 ++--
>  drivers/ptp/ptp_clockmatrix.h    |  32 +-
>  include/linux/mfd/idt8a340_reg.h | 542 ++++++++++++++++---------------
>  3 files changed, 328 insertions(+), 307 deletions(-)
>
> diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ptp_clockmatrix.c
> index f6f9d4adce04..ff316aebff45 100644
> --- a/drivers/ptp/ptp_clockmatrix.c
> +++ b/drivers/ptp/ptp_clockmatrix.c

<snip>

> @@ -1705,10 +1720,14 @@ static s32 idtcm_getmaxphase(struct ptp_clock_info *ptp __always_unused)
>  }
>  
>  /*
> - * Internal function for implementing support for write phase offset
> + * Maximum absolute value for write phase offset in picoseconds
>   *
>   * @channel:  channel
>   * @delta_ns: delta in nanoseconds
> + *
> + * Destination signed register is 32-bit register in resolution of 50ps
> + *
> + * 0x7fffffff * 50 =  2147483647 * 50 = 107374182350

You would want to drop these comment changes as well. They were moved to
idtcm_adjphase.

>   */
>  static int _idtcm_adjphase(struct idtcm_channel *channel, s32 delta_ns)
>  {

--
Thanks,

Rahul Rameshbabu
