Return-Path: <linux-kernel+bounces-56429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DDA84CA0C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44BCE1C2296C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D0A1D535;
	Wed,  7 Feb 2024 11:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L82nF6DA"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41451BF24;
	Wed,  7 Feb 2024 11:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306998; cv=fail; b=ZJA0YVE2YCpoj7HouRJgPmqCTgHekji79wnY+ZCkzTnGtIP+n3rq7DBzxb/Nv2cGn8MpbRpghSrLPe428JI4cNWRVICBYzrBspeLCqoypiVvSF9hft8vGCtnaM24oZfOziw2y/UhV0Wi8LIHj12hB3r0eDILTaSWZpIG/835Ttc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306998; c=relaxed/simple;
	bh=RC6XTHldkY93z+M8mqt5cdQIdkSpLOlLOt9irQVSWG8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sqV+r8pYLA7gP//AtOZiUn7pEUp4dB5IywVcx5l9pgBxSk+QItPZqIItAxCLAweVfgc24ASIzEl/NVH91pFhd80YNMYOWqFdav6jd4saX7MOMqJJas0q6IdfHJKA7mPDhBirwT0s1yMlsJBbLCMi/kvykBVb57AO7HnrsAvX2iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L82nF6DA; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0HKM7xrK2R7mX4OHSzj9CHbEXeQhX5U8wjhiQIudtRKlTbfpf1ZhtmEsaHQzJU2x3sl3lji1nvRn+wCnQLs1xi5aPYHsKqmFPQKkaRIlakYg8l19ou4EJ58upu5zgonEM9bat/3NJs60BX+Neukfj6Xji1nhk7BDCqyz8ir3HtudeGj4uoKERh3wJXlGk3L5i0adANhoyJXMD1FETjT07ZhABFCiwJOSSj1X8t7iJT9h7TvOV5B4kMlToHx+HNp8nMDMzf6mW7Ec3lWByQaZT48LUTMMGO7yMuMAFyZLNtwYlvq68AzyiAT3suxALVrJOZbRtE59W8hWTmN+2+9dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpjZibRKgiBCeEEc5IiM/1bSP1xe9iLDPC4lU6+4wcw=;
 b=Ijw3M6udnO9Paee9Kz8WpNweecn3R6ccGA7KIox50RNfFHAcKU/U3IrghufYL7guoJQW51S2XIlJquZPu0Miq0WN7PDEdyH2VGZ1y6cBXTw0qvp8ffBTmqIrrKpoQJcVBwe8ROkKOVwEQ72OZUu0RGudQXY8r4a5F/N+PceOYMkGyff+D3vY7V+gXmAjzHELuodTrgQD8ZYjBkzP09opViy4pwmfTWFZhRmvqEu4/upGm1NekZVnsJQ3Za6Inbq9XaHApsIzgoPfy0of99aleOwq+XGSSFSg4JBiBKVcdkAjmuBxeUekhCii0hdpG96yrWNo1SH7PxREn+s09tgFmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpjZibRKgiBCeEEc5IiM/1bSP1xe9iLDPC4lU6+4wcw=;
 b=L82nF6DAWQGDKLFOjrBM3viWI6rprQXvwHrJ5BnI2YE+HxbTMMeEA8d1h61GMjTq8F186OPJ9IvYz3FkwBaZY5427aTLszeGm76wX5JkCAoSBFnjJuuh/of3Bp/zIxfmmubo1cBVVigrEvsbz4ewI6WTUucF+0jCOQ9RfMFYmIH8jbMJJfbq8F8I6sdVwLIH55A1yTJd7hrVBayYJhdb7gQByBrag5u4Q2TABjNF826poP2NspHRGyBi0NEGs5rOBJzNLkK3KkSiKjWo23pmg3lYAZH4ivyLHZazzZjCdRnFZKpy8ZlGWgsl1wK6L8I11E7wCIp1I14sca4vySmq4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM6PR12MB4450.namprd12.prod.outlook.com (2603:10b6:5:28e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.10; Wed, 7 Feb 2024 11:56:33 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::acb6:8bd8:e40b:2bfe]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::acb6:8bd8:e40b:2bfe%3]) with mapi id 15.20.7270.016; Wed, 7 Feb 2024
 11:56:33 +0000
Message-ID: <c25eb595-8d91-40ea-9f52-efa15ebafdbc@nvidia.com>
Date: Wed, 7 Feb 2024 11:56:26 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] net: stmmac: xgmac: fix handling of DPP safety
 error for DMA channels
Content-Language: en-US
To: Furong Xu <0x1207@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Joao Pinto
 <jpinto@synopsys.com>, Simon Horman <horms@kernel.org>,
 Serge Semin <fancer.lancer@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 xfr@outlook.com, rock.xu@nio.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20240203051439.1127090-1-0x1207@gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20240203051439.1127090-1-0x1207@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0181.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::8) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DM6PR12MB4450:EE_
X-MS-Office365-Filtering-Correlation-Id: 34f248cf-7ba1-41f5-b463-08dc27d3d444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U3+inSCB7dtR0JM72UHlQlnJUTjyN/l6utqFMgfM6uXNA6qK3mCcwKeviTA944CNiTygg2ZAT1zU098fjsu81J7hwrMXCdQry33ZzmOiyovmPt+TTSblqcHcev9NYoF4XZ3YWa3IlCNdtjZKHiab+OdYLc0amhC3aVNjoq8q5kzgsmvUi+fSPVxv3o6v/264N6F0qGLzCN9mAjSNDTp+ytZL/WDPcMx59lNrvvDO+WyYeC21+TvWT6adFGc5W64nRc+NmUg77C0/mOzpGuU4dWplNlEKe01VO6elasDkqWy+72L7ZMrSX62bh1rlmAtxRJjNu0TAqVbPCrvzSe9W8bspcgX7b/HJh76lU4wyIwftPm5cDNdHgzZTWM97VUFoxHfB5G/4bAMAWMm4Q5+TM8I6flGsyuTXfpU0I1WPrtMLuNlDLTsroLVlBwh5+Xk9oCkTBc9xlqIE1Jw5D8roG3xi2fO6xy2kTG1GuwTjB8gbt6eZhVAhL97smArgzK9bDehOBDsO+i4Hw6narvtf9PZV2IgLB7jUqbLP6mzdoWVwIGXJTKGHICV9fYKqZwFb408dHfHgBN0jzG6WTm62b7a+57FnYbH8hA0qLBKu6MI42vjXrFYjoHBlZ0Ao6D/mDTG7/smprYLJIYWYQQoPK77yWFB0TYe6aywZn6lAn1rHvJMCQfT3qlcMW4ov1M0+5WFA4JLZoLwfTXdRq7ftxQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(36756003)(6486002)(966005)(66946007)(110136005)(53546011)(6506007)(6512007)(66476007)(478600001)(6666004)(66556008)(8676002)(4326008)(8936002)(316002)(38100700002)(86362001)(2616005)(83380400001)(31696002)(5660300002)(921011)(2906002)(7416002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkR5N0hHWkNjUmo2STNoUWJSN0RXTTNSMnVLeitCYklpaURleFZRNTRvS0xS?=
 =?utf-8?B?V280TW93VTVwaERiUGV3QVVGT1VFRHVtVWlVbXorWDBsajJ6Y3JDaWlvMnZU?=
 =?utf-8?B?RlhRaHFWam1yU05KbG9hNUEyUXpvR3FxWStXVldQUVRzYmNhNURaZnlkd2pj?=
 =?utf-8?B?NWhCb09uM2dRak5YQnlUSVVCT2VSOWdRUVVjdDFValNxQVUxV3B5b0pweW10?=
 =?utf-8?B?UU5MZklnVEtuUS9yaTJIVXJPNVpUckYzSXlmamVTQXkxZ2Y1aXV6M0xmeXBN?=
 =?utf-8?B?YS80SThuY0dOeEVTZTJWYWpmWlUzMUhYc0gyQTdjS3JYUGRCcVBuZ2wveitY?=
 =?utf-8?B?L3BBM0lKSUxtL0hzaFFuYkVISEFjQ0VucUpmUHJaTXh2ZUdwUk5rR0F0OHBo?=
 =?utf-8?B?cXRwUWsrdVNYeVpDb2NqTitHS2luTTl0RFdIalA3QTNQMjN4cVNFWkNqSE1X?=
 =?utf-8?B?SFRyaGxJR01hQUhCbzF0NHJoTVo1Q041OUhpQTZpYU9NYmI0NVgvZEJvMnkv?=
 =?utf-8?B?T3BWWGJ6SEQwUWJyOWlnYnlzN0NqeTEvb0lWVXlJbjhJeEFOL0lRNnNML0Jz?=
 =?utf-8?B?VTNRcU5VZUJYT01UdDlCZmJtTThqSGthVU1lbHFNb0xSOEtCMkxCTGYzYUM0?=
 =?utf-8?B?cjZKQkpTckNIajgxbytqRDJwZkZiRXdYcHlDNUJya0I1alRaSnQyU0dPU01t?=
 =?utf-8?B?N0NDcmRLNDIzL3dOSEpuZm9CK0NpVTJENHd3NmRSbldNWDR5UFY4bVdZSEp5?=
 =?utf-8?B?aklPTDJIbHV6V0VJREtGRmo5bTZwUEVFTVJDY01uc0tGZ3ZlOUpqNzI1enBI?=
 =?utf-8?B?dEJYeTNRTC9yV3ZPUDNOelptNWtIMzBPSkpsNUdhTVpoRUwyamNLSnJyeUtr?=
 =?utf-8?B?bE1uMU5zQytCc1BZSDRZZE0ycEcxWkNvVzBkYUlpSEF5ZDZlVWIwdWdEM2k1?=
 =?utf-8?B?c1N6eXNNTlJFRmtCQktUa2NqVGsxUjg1TnNTdGl1NVpnK3JtRXR1TitkRTE3?=
 =?utf-8?B?MVhXU1ZyRU1pRDdITGd2U0FLdFYyNmhpTVNFNHl0eWdlVnRKYk5hTmhUSFBS?=
 =?utf-8?B?MDVRdGx2Mm84RzYzL09BcDlsbFdaNUU4QjdtUzVTREdDRVFJZUdIbGxlWUdn?=
 =?utf-8?B?ajBiVTdIQ0gwaGlWdlZaQjVqTDhDTWlJN0QvdjRGRm9ka0M4NTYySGVIcjJC?=
 =?utf-8?B?ck83RjRpK0dEZ3B3T0pDN05RM1lWNUM2K3NRd1A0bGZPaDRjWVlZTmhBSHZY?=
 =?utf-8?B?N1crZ1loNDBtVTFiWUVjVUwvTlFrNHVKZmJRKzhOd2xvbzN3aHpmd2ZwZisw?=
 =?utf-8?B?Q3g4eXVtTVRYRzNwems3dWNsK3NjK0l5ZGNHWE9TaWdjamJSL0tZdDNLdWR1?=
 =?utf-8?B?WExKekVISHJFT3ZieGNhYmxMQ2lxdjg1WVc1S1gwdnFtZU1IY0VJaTh4Y2lL?=
 =?utf-8?B?VzNjYjQ0Vm5JcTBscHcxYW9wYXl6dG9UYTZnY2pGUGV6aGc2VU5MVTkvNEVz?=
 =?utf-8?B?Tk5vQWY2TU1XNE95Tjd0TlNCd0hzWkUrQ01vSVU1cC9YZllkWkxwdzB5RlVl?=
 =?utf-8?B?d3c2R2ZlVGxPVU03bCs3THBta09FUTV4bXNtM1UwU251Y0t1bXdxaWM0YVB5?=
 =?utf-8?B?Y3VGS1BYTTNZSjdCRUkxVlh5M01ZWEZxUTdZeiswUWhPeU9tWGo4ZTB6NTJj?=
 =?utf-8?B?R01PQXpyRWVFblNsMndabTBEYjJCV3lDMERxRERkVjRJVTA0emdMc2l4eEVi?=
 =?utf-8?B?SnNBMVFBVkVFaWthVHNWZzJWVlk2d0FNVzl2SnNBV3MwWFBGa1JQWmg4aFBB?=
 =?utf-8?B?R1BxVzAvVEEraWdFYVFpcEgwRElQazNNdjdJQXBoRStMM3RwQnVlaEFzRFpl?=
 =?utf-8?B?VjBnZDNxUGJHZU5FTlF1RTRSUGZEYmxlL0J5NXIwWEhJci81YVNGdDNKN21L?=
 =?utf-8?B?cmRzTWhiOGkrdHhnbkdQeXpNOHZ4bUNxZHVJVkM2eHVYcDdpNVU1OGlmSGxV?=
 =?utf-8?B?N0NxRGE1RlB5cWtQbElvbnJIbm12aFMvWUI0RHNBZW5SZC9ITlI2ZUxUc3hq?=
 =?utf-8?B?amJGcXB3elphL0tobndYYTVIYVMvcDRLdm9xUkZudzVrUVZMbFgvTy9SS1hE?=
 =?utf-8?B?QWRidHM3eHBhTytpVXZQbmdDQSs0YytLbWlxTUR1bEQwbFNTb0FlaDFvMlo3?=
 =?utf-8?B?OEc2MmxKNG1FQWRXWUU2dlVMWFFtTktFUGx6UjV2eGZGOWcxM0djMmpQR01u?=
 =?utf-8?B?L3ZlbGlZaDFpZ0JZRUNDNEJSaVFRPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f248cf-7ba1-41f5-b463-08dc27d3d444
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 11:56:33.4608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E0OAF3AJMGb9X7qntPtkTbA41S/NHyvz4FQV0XPWO/sE9mAe13Ge8Ou3qd7juY6OqYxmPqO3IVFT3enW03cBdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4450


On 03/02/2024 05:14, Furong Xu wrote:
> Commit 56e58d6c8a56 ("net: stmmac: Implement Safety Features in
> XGMAC core") checks and reports safety errors, but leaves the
> Data Path Parity Errors for each channel in DMA unhandled at all, lead to
> a storm of interrupt.
> Fix it by checking and clearing the DMA_DPP_Interrupt_Status register.
> 
> Fixes: 56e58d6c8a56 ("net: stmmac: Implement Safety Features in XGMAC core")
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> ---
> Changes in v4:
>   - fix a typo name of DDPP bit, thanks Serge Semin
> 
> Changes in v3:
>   - code style fix, thanks Paolo Abeni
> 
> Changes in v2:
>    - explicit enable Data Path Parity Protection
>    - add new counters to stmmac_safety_stats
>    - add detailed log
> ---
>   drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
>   .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  3 +
>   .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 57 ++++++++++++++++++-
>   3 files changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
> index 721c1f8e892f..b4f60ab078d6 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/common.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
> @@ -216,6 +216,7 @@ struct stmmac_safety_stats {
>   	unsigned long mac_errors[32];
>   	unsigned long mtl_errors[32];
>   	unsigned long dma_errors[32];
> +	unsigned long dma_dpp_errors[32];
>   };
>   
>   /* Number of fields in Safety Stats */
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> index 207ff1799f2c..5c67a3f89f08 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> @@ -303,6 +303,8 @@
>   #define XGMAC_RXCEIE			BIT(4)
>   #define XGMAC_TXCEIE			BIT(0)
>   #define XGMAC_MTL_ECC_INT_STATUS	0x000010cc
> +#define XGMAC_MTL_DPP_CONTROL		0x000010e0
> +#define XGMAC_DPP_DISABLE		BIT(0)
>   #define XGMAC_MTL_TXQ_OPMODE(x)		(0x00001100 + (0x80 * (x)))
>   #define XGMAC_TQS			GENMASK(25, 16)
>   #define XGMAC_TQS_SHIFT			16
> @@ -385,6 +387,7 @@
>   #define XGMAC_DCEIE			BIT(1)
>   #define XGMAC_TCEIE			BIT(0)
>   #define XGMAC_DMA_ECC_INT_STATUS	0x0000306c
> +#define XGMAC_DMA_DPP_INT_STATUS	0x00003074
>   #define XGMAC_DMA_CH_CONTROL(x)		(0x00003100 + (0x80 * (x)))
>   #define XGMAC_SPH			BIT(24)
>   #define XGMAC_PBLx8			BIT(16)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> index eb48211d9b0e..04d7c4dc2e35 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> @@ -830,6 +830,43 @@ static const struct dwxgmac3_error_desc dwxgmac3_dma_errors[32]= {
>   	{ false, "UNKNOWN", "Unknown Error" }, /* 31 */
>   };
>   
> +static const char * const dpp_rx_err = "Read Rx Descriptor Parity checker Error";
> +static const char * const dpp_tx_err = "Read Tx Descriptor Parity checker Error";
> +static const struct dwxgmac3_error_desc dwxgmac3_dma_dpp_errors[32] = {
> +	{ true, "TDPES0", dpp_tx_err },
> +	{ true, "TDPES1", dpp_tx_err },
> +	{ true, "TDPES2", dpp_tx_err },
> +	{ true, "TDPES3", dpp_tx_err },
> +	{ true, "TDPES4", dpp_tx_err },
> +	{ true, "TDPES5", dpp_tx_err },
> +	{ true, "TDPES6", dpp_tx_err },
> +	{ true, "TDPES7", dpp_tx_err },
> +	{ true, "TDPES8", dpp_tx_err },
> +	{ true, "TDPES9", dpp_tx_err },
> +	{ true, "TDPES10", dpp_tx_err },
> +	{ true, "TDPES11", dpp_tx_err },
> +	{ true, "TDPES12", dpp_tx_err },
> +	{ true, "TDPES13", dpp_tx_err },
> +	{ true, "TDPES14", dpp_tx_err },
> +	{ true, "TDPES15", dpp_tx_err },
> +	{ true, "RDPES0", dpp_rx_err },
> +	{ true, "RDPES1", dpp_rx_err },
> +	{ true, "RDPES2", dpp_rx_err },
> +	{ true, "RDPES3", dpp_rx_err },
> +	{ true, "RDPES4", dpp_rx_err },
> +	{ true, "RDPES5", dpp_rx_err },
> +	{ true, "RDPES6", dpp_rx_err },
> +	{ true, "RDPES7", dpp_rx_err },
> +	{ true, "RDPES8", dpp_rx_err },
> +	{ true, "RDPES9", dpp_rx_err },
> +	{ true, "RDPES10", dpp_rx_err },
> +	{ true, "RDPES11", dpp_rx_err },
> +	{ true, "RDPES12", dpp_rx_err },
> +	{ true, "RDPES13", dpp_rx_err },
> +	{ true, "RDPES14", dpp_rx_err },
> +	{ true, "RDPES15", dpp_rx_err },
> +};
> +
>   static void dwxgmac3_handle_dma_err(struct net_device *ndev,
>   				    void __iomem *ioaddr, bool correctable,
>   				    struct stmmac_safety_stats *stats)
> @@ -841,6 +878,13 @@ static void dwxgmac3_handle_dma_err(struct net_device *ndev,
>   
>   	dwxgmac3_log_error(ndev, value, correctable, "DMA",
>   			   dwxgmac3_dma_errors, STAT_OFF(dma_errors), stats);
> +
> +	value = readl(ioaddr + XGMAC_DMA_DPP_INT_STATUS);
> +	writel(value, ioaddr + XGMAC_DMA_DPP_INT_STATUS);
> +
> +	dwxgmac3_log_error(ndev, value, false, "DMA_DPP",
> +			   dwxgmac3_dma_dpp_errors,
> +			   STAT_OFF(dma_dpp_errors), stats);
>   }
>   
>   static int
> @@ -881,6 +925,12 @@ dwxgmac3_safety_feat_config(void __iomem *ioaddr, unsigned int asp,
>   	value |= XGMAC_TMOUTEN; /* FSM Timeout Feature */
>   	writel(value, ioaddr + XGMAC_MAC_FSM_CONTROL);
>   
> +	/* 5. Enable Data Path Parity Protection */
> +	value = readl(ioaddr + XGMAC_MTL_DPP_CONTROL);
> +	/* already enabled by default, explicit enable it again */
> +	value &= ~XGMAC_DPP_DISABLE;
> +	writel(value, ioaddr + XGMAC_MTL_DPP_CONTROL);
> +
>   	return 0;
>   }
>   
> @@ -914,7 +964,11 @@ static int dwxgmac3_safety_feat_irq_status(struct net_device *ndev,
>   		ret |= !corr;
>   	}
>   
> -	err = dma & (XGMAC_DEUIS | XGMAC_DECIS);
> +	/* DMA_DPP_Interrupt_Status is indicated by MCSIS bit in
> +	 * DMA_Safety_Interrupt_Status, so we handle DMA Data Path
> +	 * Parity Errors here
> +	 */
> +	err = dma & (XGMAC_DEUIS | XGMAC_DECIS | XGMAC_MCSIS);
>   	corr = dma & XGMAC_DECIS;
>   	if (err) {
>   		dwxgmac3_handle_dma_err(ndev, ioaddr, corr, stats);
> @@ -930,6 +984,7 @@ static const struct dwxgmac3_error {
>   	{ dwxgmac3_mac_errors },
>   	{ dwxgmac3_mtl_errors },
>   	{ dwxgmac3_dma_errors },
> +	{ dwxgmac3_dma_dpp_errors },
>   };
>   
>   static int dwxgmac3_safety_feat_dump(struct stmmac_safety_stats *stats,


This change is breaking the build on some of our builders that are still using GCC 6.x ...

drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c:836:20: error: initialiser element is not constant
   { true, "TDPES0", dpp_tx_err },
                     ^~~~~~~~~~
drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c:836:20: note: (near initialisation for ‘dwxgmac3_dma_dpp_errors[0].detailed_desc’)
drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c:837:20: error: initialiser element is not constant
   { true, "TDPES1", dpp_tx_err },
                     ^~~~~~~~~~
drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c:837:20: note: (near initialisation for ‘dwxgmac3_dma_dpp_errors[1].detailed_desc’)
..

I know that this is quite old but the minimum supported by the kernel is v5.1 ...

https://www.kernel.org/doc/html/next/process/changes.html

Jon

-- 
nvpublic

