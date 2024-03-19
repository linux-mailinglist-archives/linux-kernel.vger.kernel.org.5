Return-Path: <linux-kernel+bounces-107114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6694F87F7A4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4F3282C0D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F62535A3;
	Tue, 19 Mar 2024 06:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nIpdHF14"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A78D5024E;
	Tue, 19 Mar 2024 06:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710830415; cv=fail; b=ZPOAgD6K7bAhDKY0DENiUI09F3xbA1dbEBZXozEAWwyByhoSPFjx3duj+qYKY8rQClW9KZ+pIhS1MiaI/fW/9wUXZmrUt7uzGURP1fExBdOiulYdsY4vHZdgvRBI0kE6QXdDb6li2/2hRGv13WqtpceKjBw4H5zCOCgzXeCZqzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710830415; c=relaxed/simple;
	bh=aS9jbTQtREgGFwGzGVRT9ww0Oc3dq/dThuKWhFBtS6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uMw8lsxPVkqaqd7Ne2+0Q7DtrN5X6KN39pKnJcDOOO2f2+813nz8AzFCXj6bLcMHuX6K70EVTIHtvanliroKBXedDnA2wK+zILFt//5eaRZXbybh3Carg//GPWspAz2NhEosU94etgvMjxP3hNi/QgpuAMXY07R7UESvDZcOVdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nIpdHF14; arc=fail smtp.client-ip=40.107.237.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfvbcjVyvUBFtvG9/uPRRLgZwejPT1lyCSx39DCYBeKNNt9Keu5xyhN+WGXX7A+qKFsx1MFOO18uZddNXfieRyUYSC0V1Rc1JIRutK0G8PEQmjJmYT/QP6X/YheHdxwxPOCWHnRbhESw/qVi49wQTJTP/9MAFcuA3NCM0HsqrFjcykM2fEqMd6VTy3ZtmMfodXglgYz18eF3FnUh4zvywfdTFrnRTtSpQ5gDkJbT5R52XHHX4xe+5TIaORsS98AVqN79ktVHuUQyhydJJm0diBRXlm92eDVf0M4oR8T/pvD/tLog6h2QvGtFV7NgkflCTbXdf4rZEQpE0l3woM6ZsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqmji+BZDXJ+pmBhCkJa63YYHlPhtcyhQ51mgAXAzc8=;
 b=dYkvkPLeyV2smZNnkMhLeqK7wBMXddQD7XhA+lJUKT4AfnKlEeAUn9d+yzzEDghDiL90nR59u0fWM7VwUfjJkev1yHzyMEWiJ8aXuEPxScM/T/oMcu9dySJCxCfJjj4BExUSrdUzi6KSKLtQUhjMVu7ojscTrnOCUkYmzpEJmwW59trN06XAAXaoCyBgXcwsOLnxbUuj6ZhjtlYuxm4tVwtNNRHNvndg9l9416jUaCnRlIS7v5Ltp2V1cy4qf5srCRoYRB3wUNDJnuIXEP6SGfe4SVrM8mIOKgMkolyQ++ba4eHKLQEbmq338WYmWpqITOKfNtQ0b8BHvODMOB9RWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=purestorage.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqmji+BZDXJ+pmBhCkJa63YYHlPhtcyhQ51mgAXAzc8=;
 b=nIpdHF148LHiPFJgG9CiZG9j6WXHsCx5TbAaL4YncbVipB9mrtOOaqum25SU2Y7UblRZ29bPRY//bzvGc/6/x+OXmWWWI+9fr036FIiwXrHVIGLjVl9kRkuvUczEKk7X44HgjeE8cCcqw8eUl8VcVgxXSYoFERjvagmMv9dUVtO5jfuThrFj+SuarAxR02gh44NT/bcxOQOVBOD/38Thn0XRiwQvwb/0phoQrVs/GDOCUTNvDFs5PYLPYJhBzvDdFTaltQUHI3C/vWSNFGPYzrpYhleQCDbYJ6nlW5+gAhDMZXhikzW9G3rw2SVq57vK9E+D34C4pbpxKJueIKajTg==
Received: from BN0PR04CA0149.namprd04.prod.outlook.com (2603:10b6:408:ed::34)
 by MN2PR12MB4189.namprd12.prod.outlook.com (2603:10b6:208:1d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 06:40:10 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:408:ed:cafe::f0) by BN0PR04CA0149.outlook.office365.com
 (2603:10b6:408:ed::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Tue, 19 Mar 2024 06:40:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7430.0 via Frontend Transport; Tue, 19 Mar 2024 06:40:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 18 Mar
 2024 23:39:58 -0700
Received: from [172.27.33.225] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 18 Mar
 2024 23:39:54 -0700
Message-ID: <805b1189-db3a-4763-87de-f55e94c6d8db@nvidia.com>
Date: Tue, 19 Mar 2024 08:39:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/mlx5: offset comp irq index in name by one
To: Michael Liang <mliang@purestorage.com>, Saeed Mahameed <saeedm@nvidia.com>
CC: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <stable@vger.kernel.org>, Mohamed Khalfella
	<mkhalfella@purestorage.com>, Yuanyuan Zhong <yzhong@purestorage.com>
References: <20240311223018.580975-1-mliang@purestorage.com>
Content-Language: en-US
From: Shay Drori <shayd@nvidia.com>
In-Reply-To: <20240311223018.580975-1-mliang@purestorage.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|MN2PR12MB4189:EE_
X-MS-Office365-Filtering-Correlation-Id: fa1b5965-fcc1-482b-7ab5-08dc47df6cb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8v7M3XWN+sIFXCdRM/6IQw00x5T/LuQnzPsGrknB+ibWoQgsJNjVzr5dR3AG4jroz9sZNz8gQFBkH11o24InZnz+k+RivrRMh/HI839HYGT8OhQIEtUG9/x/rHsy27oMesEamciFaG8dKaoSlKSa/TJh2IUe53Chp6mptnDV8/cInpPKZGljeUkwbyc/iY2YcSmi3CSupMZ8/M2t6mcta/LRYjWFRRjbTBOLWeg97xFNnB3XWJj+1Im9YJglT53bZ9rcKPHi8D4UL7mWzWuAH6q5emhKe4S38Hrql5TL5Mb7gxjDCCPLyD+RC9cFf27Rkpnj7fVRsVKSayCOhGHh2qFI3eUityuZtlXT3uy/bMk4+0rr3EFggG6HlV3SP2Z/TYoz8kP9eEJfkDanCsGrLqfujJb5FdRd28cCKolFiiRe/acb4GSw431IIt+OmIYd02XHKK4W1KDMAiL4NX8lh+5wL0tmCnDD+pmJYchwrZR8VbL1248DQpZ5VH4sVto7CedkR+NquTb8WB8BVj7CEZLW4ZI3nRPOyyyMpbmROadxje2hz/vyxOuxgyph7dXNmrhO8l+89wQ3xjcoT7EpDNPbdEUUctEAV1iPqys6fBZo6OfekheB6Bue4Bbb6BuASLETJUpZKKeo7dl3NxbUr5zfPmOoqAsrGwmVXmQSKQLUCgZMmYNLA93gZLdrJ80zNTfLeYxVG62sQUbpC8nZdLSBJw2IPD8/RZIBKJvIAV2qSurmKWfcH6hyeQTXtDBJ
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 06:40:10.4782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1b5965-fcc1-482b-7ab5-08dc47df6cb4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4189


On 12/03/2024 0:30, Michael Liang wrote:
> The mlx5 comp irq name scheme is changed a little bit between
> commit 3663ad34bc70 ("net/mlx5: Shift control IRQ to the last index")
> and commit 3354822cde5a ("net/mlx5: Use dynamic msix vectors allocation").
> The index in the comp irq name used to start from 0 but now it starts
> from 1. There is nothing critical here, but it's harmless to change
> back to the old behavior, a.k.a starting from 0.
>
> Fixes: 3354822cde5a ("net/mlx5: Use dynamic msix vectors allocation")
> Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> Reviewed-by: Yuanyuan Zhong <yzhong@purestorage.com>
> Signed-off-by: Michael Liang <mliang@purestorage.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> index 4dcf995cb1a2..6bac8ad70ba6 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
> @@ -19,6 +19,7 @@
>   #define MLX5_IRQ_CTRL_SF_MAX 8
>   /* min num of vectors for SFs to be enabled */
>   #define MLX5_IRQ_VEC_COMP_BASE_SF 2
> +#define MLX5_IRQ_VEC_COMP_BASE 1
>   
>   #define MLX5_EQ_SHARE_IRQ_MAX_COMP (8)
>   #define MLX5_EQ_SHARE_IRQ_MAX_CTRL (UINT_MAX)
> @@ -246,6 +247,7 @@ static void irq_set_name(struct mlx5_irq_pool *pool, char *name, int vecidx)
>   		return;
>   	}
>   
> +	vecidx -= MLX5_IRQ_VEC_COMP_BASE;
>   	snprintf(name, MLX5_MAX_IRQ_NAME, "mlx5_comp%d", vecidx);
>   }
>   
> @@ -585,7 +587,7 @@ struct mlx5_irq *mlx5_irq_request_vector(struct mlx5_core_dev *dev, u16 cpu,
>   	struct mlx5_irq_table *table = mlx5_irq_table_get(dev);
>   	struct mlx5_irq_pool *pool = table->pcif_pool;
>   	struct irq_affinity_desc af_desc;
> -	int offset = 1;
> +	int offset = MLX5_IRQ_VEC_COMP_BASE;
>   
>   	if (!pool->xa_num_irqs.max)
>   		offset = 0;

