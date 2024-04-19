Return-Path: <linux-kernel+bounces-151342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C358AAD3D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94081C20F4F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F74B8061A;
	Fri, 19 Apr 2024 11:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="cPN6Bvv6"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2055.outbound.protection.outlook.com [40.107.7.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC258004B;
	Fri, 19 Apr 2024 11:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713524585; cv=fail; b=GwLdrzZnPUWUJ5qwEn/Y9rhWR14HNe8tZD8ZP+MiuoFs7Ockgt9WnnJuFKniTzVgRmwBhLsIdmxFfdurQvp1ik5ZRDb/fzx6VWMD2ObhKRHAFtMu1Oe6kRwm1xoqpYdC2vTPPXsfeeuj9tvZmQh/UFUQeTsjyJDc2KbDCYP/Tmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713524585; c=relaxed/simple;
	bh=1/d4ajeHnpyub1f35GljZZB4tbyNXNHRkJDH3/RegVc=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U6pJvr7SV+y9GHw9qs7Purg/42hXe8r+7O92ibM7Y+UCitOewmLW0etQh+hFC955ZQjoi0uKpv6thRZ4S3duausqnNa0lcIQTs62a4ptS0GLg+bvWf+V0B0L5YLDjWyZZRvZat1+sw2/p/RMWukqNzV9oNcNvAX+KpJHR8QNiEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=cPN6Bvv6; arc=fail smtp.client-ip=40.107.7.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5rprDiNbQT+7PSfz99lve6mGnPzsyfFofsKVU3zPen8u69Lc7q/BbGvt/LX2gg/wxiRk3JSplf0GskDlPkmSVqjLOjz7KmTgNxIItGMIXnaG9yxUZPoHHhiPEj+fkVwAkfQBYuQTgYiPJdsmMyXFoXcBYUg084fk/IZeBFpgYIkL6OVUjtIz0rPVpNwdmnrKGIpNtpq31IT5HOVEdnHvtJBHdh7fqVQNUd5hk5uXWxTJwgUEde8b+CUBhg9QW4G9cntKvIQ6DbZu4Kcv+DIw31lLAB/NxfGQ228w5SdaN1RYfFY37ejLU7xaTUmKYg322TQ4OoBkuYeGdosLqPLFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAMZVekFpfoYwUlZO4uuWRrSi2Qj6dwaFSiO9POZdSI=;
 b=DmCwv+QEFAFeBEi1uVDY0mDEKeyV9pN7hcuiI2kRr8+6XSqnUjLcLXyGzxh5otPdMT5M8f4V7EwtbSzQyJ+IIjUA6oSqBXq+rr5NDLOJVdtoGMBJc6mbiGsdCGlI0ZoSuEhY+vpBBydnwlZcPagOsskVohDTOyvZQzpg7voXCSfavhFmeDrLYcmn791dPKzM9+1aFbhTB58CwaPorZ/VCZu1zmy9957po4oKYsQyghM57B4pNhs5r3XqPqN4gF/KhFG38am530zp+g3+LOPCQvv/tQuyuHwZCZgydGYoxsRj2Sqq/LSypcqM3256Hy+fPIbobezdUehNzsA6nAy2Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAMZVekFpfoYwUlZO4uuWRrSi2Qj6dwaFSiO9POZdSI=;
 b=cPN6Bvv68TdriBBCgP1Q19gUp21/VfZ8rmiRvYIRbPidZk0pkvZSIIfDYHj1y9ykibgUQbh6BJNyRK1BWkhd9okip1lOhTI1Zuv6K3DgDPtbp8u3eYHMTROPTtvyPXONvQ2VzZiFeWTnalxiDPDzowkpxrGnBM763VUYu3P440I=
Received: from DU2P251CA0019.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::26)
 by GV2PR02MB8601.eurprd02.prod.outlook.com (2603:10a6:150:75::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Fri, 19 Apr
 2024 11:02:58 +0000
Received: from DB5PEPF00014B9E.eurprd02.prod.outlook.com
 (2603:10a6:10:230:cafe::aa) by DU2P251CA0019.outlook.office365.com
 (2603:10a6:10:230::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.30 via Frontend
 Transport; Fri, 19 Apr 2024 11:02:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB5PEPF00014B9E.mail.protection.outlook.com (10.167.8.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 19 Apr 2024 11:02:56 +0000
Received: from pc52311-2249 (10.0.5.60) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 Apr
 2024 13:02:56 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: <alexandre.belloni@bootlin.com>
CC: <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] rtc: rx8111: demote warnings to debug level
In-Reply-To: <20240417191937.33790-1-alexandre.belloni@bootlin.com> (alexandre
	belloni's message of "Wed, 17 Apr 2024 21:19:35 +0200")
References: <20240417191937.33790-1-alexandre.belloni@bootlin.com>
User-Agent: a.out
Date: Fri, 19 Apr 2024 13:02:55 +0200
Message-ID: <pndsezhmx7k.fsf@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9E:EE_|GV2PR02MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d950649-ee1c-4bd8-3840-08dc606044c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ChbaShvPbfP2HcCQ6OZzfJ8nSiUUviHsX/IWcSJg/7ArWlzcaKpv1y3FoHxikyXB9QUVkUgDIBvvHlD3B2M+l0TdTPCexlioP6x858+uLBYr0oylh3KfUdHZszz+436RHvQ/0+LhT6dKyy+ZrQSM/reClIHC+8SGahsoT941bZiUq+QThQjqjBawWE/nN+2kcRrUMmIh2Xs1RBAzMWBfTwaCwNXrsfGJIj0bGtbU7q2YkpY2ack8UzR2E9geTz2A1UrH6aBzPUbtPp8WI3N7vIFZ6++RyuyXLXF77ueghou03Y4AARV9f0QE+BvKlcjfxNWpBlAzJpWfOmiIsMZdJRdhH2oIJq6coR8sP0/3TZCQJuvRzljfRVe1xZYPeSKtju5fQ7FoieT3af5QJvWeJB82Fya0iWmTNpvJunFpuIjqEcILiZscjO+5uWrPzoi4zTI7gPp8gixoOQHwAfSCEVLVs7HJiyWRoSStu/YgJjJGhHNkN2uHGgYrP5wWdfppo1N8Nerz1H5mt5f0Ykrg+aBjHFsLcq1fhQ2mzF6JufZZciCKMqgPnAJ0RbL13bDYmPQzs5lQycvFxDAz1ejyPNJufLPeXzZJvI7qF7ZglR5s1ljL61b3HRIc1/QlqvJzQFqPdmsFRuZeJJhqdZWAeBPiJgFg4Ii6o2+B+yKX2Q6c4bxpT3O7NeLBmGEdEnh/2ugcQnHVk4nTnUXn/plQ4UjghkEfalKOwwjkkMKQZNq+wAC9rlipqxlixtADmFwD
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 11:02:56.5626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d950649-ee1c-4bd8-3840-08dc606044c1
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB8601

On Wed, Apr 17, 2024 at 21:19 +0200 alexandre.belloni@bootlin.com wrote:

> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
>
> The proper way for userspace to react on a read time error is to have a
> look at the voltage low information. There is no point in cluttering dmesg
> as it is often not even visible to the end user.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/rtc/rtc-rx8111.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/rtc/rtc-rx8111.c b/drivers/rtc/rtc-rx8111.c
> index 62d2352de102..4a35bd921b33 100644
> --- a/drivers/rtc/rtc-rx8111.c
> +++ b/drivers/rtc/rtc-rx8111.c
> @@ -170,14 +170,14 @@ static int rx8111_read_time(struct device *dev, struct rtc_time *tm)
>  	}
>  
>  	if (FIELD_GET(RX8111_FLAG_XST_BIT, regval)) {
> -		dev_warn(data->dev,
> -			 "Crystal oscillation stopped, time is not reliable\n");
> +		dev_dbg(data->dev,
> +			"Crystal oscillation stopped, time is not reliable\n");
>  		return -EINVAL;
>  	}
>  
>  	if (FIELD_GET(RX8111_FLAG_VLF_BIT, regval)) {
> -		dev_warn(data->dev,
> -			 "Low voltage detected, time is not reliable\n");
> +		dev_dbg(data->dev,
> +			"Low voltage detected, time is not reliable\n");
>  		return -EINVAL;
>  	}
>  
> @@ -188,7 +188,7 @@ static int rx8111_read_time(struct device *dev, struct rtc_time *tm)
>  	}
>  
>  	if (regval) {
> -		dev_warn(data->dev, "Clock stopped, time is not reliable\n");
> +		dev_dbg(data->dev, "Clock stopped, time is not reliable\n");
>  		return -EINVAL;
>  	}

There are several other drivers that uses `dev_warn()` in these cases,
and it was just followed here as well. I agree with you here though!

Reviewed-by: Waqar Hameed <waqar.hameed@axis.com>

