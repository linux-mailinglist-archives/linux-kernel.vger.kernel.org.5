Return-Path: <linux-kernel+bounces-67485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2E0856C4D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B3001C21ABA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF6F1384BA;
	Thu, 15 Feb 2024 18:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KSi5pbLG"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1053A135A40
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 18:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021138; cv=fail; b=VAyp0Nru06DqW1VpgaNCLu8mCGHnvSPHL7y7ZMFprR1+PyvE1kZZ8CFks1fxivKcGTaortHcbnwnXLVfNOB2ttEceGDMlrQw071H0XWoeagNutDj8VjVXJrALhxpd+JDhjNZc+qhCEaazM/miAxdgY+7jfl/JFVaKQbAHjypLJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021138; c=relaxed/simple;
	bh=VHF28u2V1At6oilGxbz2jfkiEMqXZLaLy2qApOxhEF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iSKMPMITrGcCrEQN+hIbZGkflZvFyZ35GUm1Yc5ktRWX3kAHIQM9PASHeI48WoFlW41JwVh8N230EsrVtWnKOM6Sp7f1G+zCttvpaO9pk6+ASQuRZAYARoDEG5GCvIMC3fungu+fIxZ5RvHHkULSp7tDEhmMBMZanVppKyvWUmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KSi5pbLG; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrEFtc2fcxN4z5bxoJX4SMzBqxklBk2VoThhOug0wxBvhGhhu9/fkW4nWH2ynBZt0UtvuWtwmhobfqY3PXtBmEaEobUr2XFsFDYn94wszyVKJDney2kJwdDIh7Op1x0Fdt4LbElyo1i5GSAym5seTU8VS2UtKzBfe1u36xKaBke2IDJGt/7Lb1nfkXwZ/XaBbVLrCByq2GmGsXrBrydLeEqtiStSsDrF0CLCl1hMEyh+4uvFIMBotzAZ4LD4X603HRI4GBJ3qChHOQ+c94CPpE6LpeGmb17SUUho4u/C3Yied4cFqNSceWcstZ/GgSuoL2ZP/2VMl7l1Oy+j5hkGgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Xj9hRhHJK07+H4lEBwGdzue0CSnP+3zgMlano0Sca4=;
 b=dKnBXZa9dU2NedFfhvP+OC++ymYEkvF+zhA1RGUcHV9Qll/PG5eqt+/p6Vvxx5C+cZ4rsuuQaukRaDWY6KojAdQI4bwhIMNPPGmEO5k4YXT0yfKs77Njm3pAc6jd5hjUZmoN58ENs6bLSFoHYnodP2J+3yzY4BeMLYmq4C5V1pR42GFZ1ClEN1D/AD0ibECMoUR7fWhHtmntecTifb2nTII8uO++fSpOSL41zT6xJEifCSF8i3CPq5g9uLTycNltE5fY/HStqrMRXfn+WkyCdVipRp7J7koEkae9kM/t6G1I5SKYXOVPtcgBw75NUNnYNss9rtKa/GL/udzPkhWvmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Xj9hRhHJK07+H4lEBwGdzue0CSnP+3zgMlano0Sca4=;
 b=KSi5pbLGCtV22hY3E5janeihgxt0A7IngCHPJP0dV3xDg6e0TZA6Uqgx4KTkW+dFfCj8tKG2e01pmj+bqAe36oQlDwJ7v7jG/tFG3iRNZxs2HQn2Tc8KfwlmK+1M7+Jngkl3eGcRZvuXs85L+JY521bpmkCdxGRGTz6opcTzdIQoTq7ZAeQ7tz7fYm6FzGJE32q0XTg2GzDJgoctEjQp5sv3rF1KR00gqLH/evMKU7whn8cTM1HSMLjXIj+88XReZcbCd69ePnEaIV+jDXEa0yDY705d+YGh5CWoG4HtNCG0YxUnjKb04CW741gpCcNfgNbi+WYY6k2E6aIeQZDkAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by DS0PR12MB7703.namprd12.prod.outlook.com (2603:10b6:8:130::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Thu, 15 Feb
 2024 18:18:54 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::4bc3:496d:bc47:a63f]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::4bc3:496d:bc47:a63f%6]) with mapi id 15.20.7316.012; Thu, 15 Feb 2024
 18:18:54 +0000
Date: Thu, 15 Feb 2024 19:18:50 +0100
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, si-wei.liu@oracle.com, virtualization@lists.linux-foundation.org, 
	boris.ostrovsky@oracle.com, leiyang@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] vdpa/mlx5: Allow CVQ size changes
Message-ID: <psyjxz3jk6qqj3xiqlrl6dkmmrhuxu6te2pveko72s7zkdn46v@w6uthanhjhnr>
References: <20240215174647.3885093-1-jonah.palmer@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215174647.3885093-1-jonah.palmer@oracle.com>
X-ClientProxiedBy: FR2P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::20) To DM6PR12MB5565.namprd12.prod.outlook.com
 (2603:10b6:5:1b6::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5565:EE_|DS0PR12MB7703:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bc26c83-a4c6-49f2-600c-08dc2e529148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8Fyr3libVPXmwVnSASFfVRe2pZVl5LgSYpc9Akw9ieRcjN/lii0u/dbGRaE7yRPwjIgUuBcxv4VDmy3Tkj4YSoJgZUirNcxNxSLgo70sw6CO/S+5VKYxkDwpl4dpx1c5YQd8oNb1MqYISKHW5Q6lsqI14nZT+iTffdGCj66OBM99LwLo7J5L20fKfdr5PSk8TRF3O4Bv8p5CGjjjxJC278pZMniyW/5vXqUQcfsOJdo3zzKcgFpR47rL8Ii2TMEOGURT2aZ7zS47iIhVu0SH7H3/LcGGAeM8CjSitNvyCOxgJc4GzeCyPvPxuP3IJfOSR+p1hlQo/YEd5R/tmTKCycM/gebBe7Fx1JK3ZBJ2h9l/Z7QZczoc/ubuAyzFInli0UolJqYDJ1skEM5jAvvk2i6ovhYbG3+deYPVhrZE87r9ae6OOV1mXClajyxa9NqNlTqmtoSntVY7+pOFszU0WD2ot6nxXeWgtxxMhfm1Fsi0B5Y08956f9eNs3MLkSftcdMbaHYdIdatQMwdp0AONiaz8Dfd/CUCjS7b+HO+urj40Eg0Aqoze6Nh28ZXVNQR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(39860400002)(366004)(346002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6916009)(66556008)(66946007)(66476007)(41300700001)(33716001)(2906002)(7416002)(8676002)(8936002)(5660300002)(316002)(86362001)(6512007)(6506007)(6666004)(9686003)(478600001)(6486002)(38100700002)(83380400001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lLAcdbuLPzmHy/HSGbKQP1FnVftiVSwKBTji1DiLcpSz0pVft1yqs6UgwsgJ?=
 =?us-ascii?Q?hcV/dmA+szgW3PcUh9loWzHhIrJk/GZfhPNpfnBmUwyBaKeFW3kwvbofojFA?=
 =?us-ascii?Q?Y2xqWPDvl/Um4c0UHCVHMsMtuz7jDLjKkPVFd+h+LiNW8Hk902FkPlBdz2Dm?=
 =?us-ascii?Q?s5sr4NPep4bEpKA+lTZ2Mi/Nl9BSoGn6gFM6RzsJs7rDt7pVGSYgdBLXXndW?=
 =?us-ascii?Q?SvRyBM9ofBiPjXvCYaCIRYaRzmOLm3dJ+pDAYCegXm6qJpRjbWs3aWz+bpcK?=
 =?us-ascii?Q?xU3qKCSOfCHSPUj0Rd04UsMfTV0+zF8Gf8t0cr6F+cJTswT09lrayEcUe1dR?=
 =?us-ascii?Q?2vzBN3qjR0/eNBP2o8qy2MOAkwaVIXbHb0H1riQ82yKNiv/1tG5grVZCffJV?=
 =?us-ascii?Q?bSgg7noVMHYdTzDBhPccMc3yMogri4tAbzXQenFfsHUYFqp990tlru+vX10W?=
 =?us-ascii?Q?6apDzbEEuAGmNrQRRnowJjJWyLsNlm3TD6t9ecd4AwsWKnKjo2VaT3vn19fk?=
 =?us-ascii?Q?SczHlRLPQb6mFwOwAtaIe6/FWnPB5QBi36rQhqr00lnRLVVQ4Oj6EV+COCJn?=
 =?us-ascii?Q?W4yi2S5eMpBGa+qzv+jccL1ZmFjRZnN7DBxKKjZ8Bc10GZW28VmUPl/+3hRC?=
 =?us-ascii?Q?Fp0ebI3TdQiag3pwmJUiI8zFU2+isoGVmCkS9tB2UhpBjr5XfU8AflaKDRVv?=
 =?us-ascii?Q?iDO8oQhRljbkv93qvGOheLQ2F6yqdNbrP0Fl6xK1EfEIFRCxypaA91jL+znq?=
 =?us-ascii?Q?nnayY2laMYxbg5gEOwA4U9oHGslo1xzsDoW1SYU36CUsnHVAjdGY4fva/+zA?=
 =?us-ascii?Q?Pbwz2nmWQzL+xEESZq77Yw5aPVOUIXogcmv8RyNLuYWuW8UBLXHa5SsUNy/Q?=
 =?us-ascii?Q?LYRVLG8/Ymc0O6dy9bvzIIjUnyMU4kPEi9yJALKIY2/PmMTJijox8JiGC6nH?=
 =?us-ascii?Q?PjAGqG2eP6co0E0ElJuuhmZkSKtbUP4SeAYxvU0cHZtwmdyD4UqkYsAdTYaA?=
 =?us-ascii?Q?lMTuKAi6s65zQeO3Xr3/q7NtNInzjuDNCpyk0RpCy5J1/mLrHwkj2ZeqfiKH?=
 =?us-ascii?Q?XeP71GDnahK/1Pyu3ke39GWG81hfu2cLYVbOw9O41fL75wmqdk6zBNxgCYtt?=
 =?us-ascii?Q?2/4i1TudL+5KPQxTVFMr42U7JYY4GznqBczZSb3kDy8de1RvwAyh5dRhjhuV?=
 =?us-ascii?Q?0gZZYcmIshjazL5UOhaoB8ZdOz3O7IdSrBRDd5r9T8jAzeavqOtSaFdn28Kr?=
 =?us-ascii?Q?BbhIt9wo66vb3Jjt9FMAcLUpyurDZKMSD47FzqCFXMOh2E5K0QEt+I3e69ts?=
 =?us-ascii?Q?A3wmQKpG0FRl0X+Kvpxc6oYnhyqgq9QoCTuVqlMV6iRqvptv7KbsM5OtiC1C?=
 =?us-ascii?Q?jLOnpK08SVj4UBMBTiRDKYBInvOAx3LX6U1KvcpHOyGBelZ9QcVZkp3ZHouk?=
 =?us-ascii?Q?Sh47v9bwlNDZOyvUQsMclHMvLY2OR4Q2/EUnVZFcn1I8tysBvxSsUADx+BlD?=
 =?us-ascii?Q?/AQzR8/iH6UsQaFNkjh+y2gXH/qFUqLgPBgggcy/2A+XapHw80ki23ZcWJZ1?=
 =?us-ascii?Q?YbfX1ho8lCeZc1ErpsDeRtslDnAlWo/T4JJ/PFh6+cTRc2MNpJX/6audwTHg?=
 =?us-ascii?Q?2lBmCgwvTpC2CtSdbQHxPt8mjQ/l1Qpbbd+0puV7x0/j?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc26c83-a4c6-49f2-600c-08dc2e529148
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 18:18:54.0789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eG0BAQ5cteA0bwP1Y/rUGgqesra9c8gK9EH98T01nYZ8kdAIbrxW3Ue4AFq82LPumOmGhR32fZKGp1NGLn3t2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7703

On 02/15, Jonah Palmer wrote:
> The MLX driver was not updating its control virtqueue size at set_vq_num
> and instead always initialized to MLX5_CVQ_MAX_ENT (16) at
> setup_cvq_vring.
> 
> Qemu would try to set the size to 64 by default, however, because the
> CVQ size always was initialized to 16, an error would be thrown when
> sending >16 control messages (as used-ring entry 17 is initialized to 0).
> For example, starting a guest with x-svq=on and then executing the
> following command would produce the error below:
> 
>  # for i in {1..20}; do ifconfig eth0 hw ether XX:xx:XX:xx:XX:XX; done
> 
>  qemu-system-x86_64: Insufficient written data (0)
>  [  435.331223] virtio_net virtio0: Failed to set mac address by vq command.
>  SIOCSIFHWADDR: Invalid argument
> 
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>

Thanks for the patch Jonah!
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 778821bab7d9..c74de1fe6a94 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2276,9 +2276,15 @@ static void mlx5_vdpa_set_vq_num(struct vdpa_device *vdev, u16 idx, u32 num)
>  	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>  	struct mlx5_vdpa_virtqueue *mvq;
>  
> -	if (!is_index_valid(mvdev, idx) || is_ctrl_vq_idx(mvdev, idx))
> +	if (!is_index_valid(mvdev, idx))
>  		return;
>  
> +        if (is_ctrl_vq_idx(mvdev, idx)) {
> +                struct mlx5_control_vq *cvq = &mvdev->cvq;
Nit: add a space between variable declarations and usage.

> +                cvq->vring.vring.num = num;
> +                return;
> +        }
> +
>  	mvq = &ndev->vqs[idx];
>  	mvq->num_ent = num;
>  }
> @@ -2963,7 +2969,7 @@ static int setup_cvq_vring(struct mlx5_vdpa_dev *mvdev)
>  		u16 idx = cvq->vring.last_avail_idx;
>  
>  		err = vringh_init_iotlb(&cvq->vring, mvdev->actual_features,
> -					MLX5_CVQ_MAX_ENT, false,
> +					cvq->vring.vring.num, false,
>  					(struct vring_desc *)(uintptr_t)cvq->desc_addr,
>  					(struct vring_avail *)(uintptr_t)cvq->driver_addr,
>  					(struct vring_used *)(uintptr_t)cvq->device_addr);

Besides the nit:

Acked-by: Dragos Tatulea <dtatulea@nvidia.com>

> -- 
> 2.39.3
> 

