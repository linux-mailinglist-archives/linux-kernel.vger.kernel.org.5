Return-Path: <linux-kernel+bounces-37885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C833683B70A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BA4CB21F76
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5AE612B;
	Thu, 25 Jan 2024 02:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="trB+c5Uz"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3C61877;
	Thu, 25 Jan 2024 02:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706148879; cv=fail; b=ph/6UST9F/qW1CzXrx2x+2tkvNdt6+nUNKgGlQhnCHHBXGTrBjx77huLOvn8CudKUcFS8Tjd2b2bMm8/3AON7CUW7aWNBjBoCWmyuxtSY/qWSk7kVOiAD+c0XRxAqVkL8BJIOGmppa1oGNe45CTONRsB32hNceEsWQ5b6zwly4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706148879; c=relaxed/simple;
	bh=Hk/brmOrcPk+u5Qd5aIGGIhu7NWwsDqmv5VLT+fZyOk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VbRtAfHQXBESB0uWf/PzwK+EXtWOEMFna9NsDV5Y32tvzzMUTkQM3Uorp0X/6gj8qcX8bTD23kJ2JRbIbVz401v//FTPjT9sraOf2Tjk5zQFGo6paaA/D5afsbZkCRwJ4vJMxPcRwtSWwWly9TK/EA3NbYlDGhYCxMOyUCvXRLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=trB+c5Uz; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msD6saVVKWBgfmYfhFCtNnczuRTWewiMhVqdzw2PQ/tr0/Ex8KmD1XUTHo9GFgsfGGwobx4s9i9CFGk7MUPGN7y1yn2/U1zOeZdhGNU2QCRwe4Xo17S8bC79dQeQBwaga70q82QW8l1zfHBZLrQsuL5KcEB4pymSOpDXAryI4fYscZKDo+90HcevYPZQdZzyYrX7ciiNgi7cEQwO1Qs9rJZ2QtgFLmtDE8ycUGuoxsH/y+No8MWu9JSBfE8pRtZuBcQsilVLoCsWece7RYJDLwxF0K++JEn7tTlrVshp2Qb8FipahQVac+3t+wzNdPqJ5r/+H/zz0IqrK59AWWjNCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQebkHJzOaJ+dPdjpqOwUXn/Maf/0CpAi7/vlH+EwPc=;
 b=EMq5bN5FGRAAoRzvubbi4UWybxmO5Yh9+/BXjdNsL20yU0NkyEqq4MCrtKHMMjDOqEypC4kB8f+9t1ROS0SfbUNZXMN1enamEwhENUmxKyaZBxn0EPfMBilyiYScZv5GQMR9FjCOYKDb14BSAD27x3XcqS8pT6hzJSv0RzhaXX5Eq5gxksWaRWZvF/F4RO0B2DbccJAx8X9QkGppeB27NwH6chqQOYfEbQswcUl+9NOOM054W29fpyAZj57fC2FYXvbRINzE1m00SYfcWBMWD8ohfZhBcBJWO8hMsd/s33zCTGOcBHwbaUjFWcivE4D4PG6jTpGPBf9TP3R+E6ZTzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQebkHJzOaJ+dPdjpqOwUXn/Maf/0CpAi7/vlH+EwPc=;
 b=trB+c5Uz5r9QrEHLd8Toi4NSFNIBxHzPtT2lI71niLzp9s6aZbbucFbNWmTtZ2nAIfEWli2FpvmvsQVpnxG7KnXX8jGGx3XixgHlSwCEVgPopuYijHQjmAEOTfal0rWfgxBBp6SIcc9BfVWDU+WfOEeMvohxebE5oLRnEErRfZ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by BN9PR12MB5337.namprd12.prod.outlook.com (2603:10b6:408:102::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 02:14:33 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::e9c7:35dd:23f8:74a1]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::e9c7:35dd:23f8:74a1%4]) with mapi id 15.20.7202.035; Thu, 25 Jan 2024
 02:14:33 +0000
Message-ID: <cf035125-d7fb-4423-8f64-a5be7505243d@amd.com>
Date: Wed, 24 Jan 2024 18:14:30 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] octeontx2-af: Initialize bitmap arrays.
Content-Language: en-US
To: Ratheesh Kannoth <rkannoth@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sbhatta@marvell.com, gakula@marvell.com,
 hkelam@marvell.com
References: <20240123051245.3801246-1-rkannoth@marvell.com>
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20240123051245.3801246-1-rkannoth@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0119.namprd03.prod.outlook.com
 (2603:10b6:a03:333::34) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|BN9PR12MB5337:EE_
X-MS-Office365-Filtering-Correlation-Id: ac1ea373-ee4e-48f8-e0e5-08dc1d4b5ed5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/GQp/8BrREBhlMHXdRwM5dJbZVBJ/rrK4qqztnvYTLSN75omKN8pNNytsyVDLeNzpl6ZDCn7vaoehP+810gf+0zzO3K5c3tXmZq9E9tv1Sqi8B4CX8XMDtlWu62YFQ8LMttWUYsLzOU/MGzuu0WSWsLbQWHgz86sayAUtuvzskN7MmVgtq0fq6f9i84zxG4buX0+EnPp0snKNKkE+cPF6fXtlVbeB8nk4cnwZ9oAOUr7APj5y55n0DbzxoR6pTTgsWVvwoPfpVmk6s68CMD0BzD4b0MiXWxB00PJxHp2L9EKs8v2LI7/iYv2fZSe/+Dq5tgkPGfd7G4TuD1rVfkbx43QviWTHe8S6YkGtCa8LXIKRN76dLAGzgLbWftTSlS6R4HS0wcuKpXGMTXfWy+dZb3rYs6KgLXuK0HtSSUWBBNRK7Z0IZXhB2hUaVOrl6U3iaDDFh/H3lSmm6ubhBdD6yjiA8cXwaoRQ/qmb4WPOKR+RcnhWMXEmjoD1hFlYF0C30t4PQky1G7zx6674mh/GkbVYX27ELJdAMexPdLLgcd8YmdQEOYvOPBElVjkdTBBb3DDzc1Zl0Q8zY9/VFC+fIwDotNwjDyNkOdo8X65AbIBQcWfk8Sbbds+HgjVvhaT6mlPrH4Sn/Dyxv5Vea9yxz5PZgo1pszPVPEhL+2W3Qz7v6fnrlDfZ7ES0NFHccnf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(376002)(136003)(230922051799003)(230273577357003)(230173577357003)(186009)(64100799003)(1800799012)(451199024)(31686004)(6486002)(478600001)(38100700002)(83380400001)(53546011)(6512007)(6506007)(2906002)(316002)(8936002)(7416002)(8676002)(4326008)(5660300002)(36756003)(31696002)(66476007)(66946007)(66556008)(26005)(2616005)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWFJdWlIR1FuQk9nTnhVNTlVRi95VG43NFVwenZxVHZLZnN4UnlQQUNCL3NB?=
 =?utf-8?B?TEhHdThPRTFuUkxRTUN4V1dGRHdzSm02QjRUelgyc0Urdy9uNWtnbmc0dHRU?=
 =?utf-8?B?SUFrbkZ2YXJ0WnhpaW9EYnZ4SjZXbDExNEhCSEYxbVNJQkRrY1h6OTVPS0dL?=
 =?utf-8?B?OUVkOTRmaHhRMmd1UU9vR3ZwTzNwWE5zQ1JHRVN1TDZON0ZLK0tDelBlUmtU?=
 =?utf-8?B?S1VSdm1va0xXUEhVam55aFBNZE12cWYreitLUGdUY2lKdU1HK2lQWklBOTEr?=
 =?utf-8?B?NUM0UjZtUjJCajZ6R2NaVVRRak5BUWhrNytJcVg1dVpZeW5GWjE0TGFLZ3lr?=
 =?utf-8?B?K05PMVlCYmRzNVVrM0YrNWpZMlZoemI3ZDJPbkNiU3BpMkl1ZkFobGJXNDZN?=
 =?utf-8?B?SEdoVnVEZENGQlc5eGlOeVRJQUFJNGp1dng1OHJ0VEVUK3RhWVRvb0wvNEYz?=
 =?utf-8?B?MUtoek9rd0prRWZGaUc5eHFKR2dnb1NoZTBWUFd6VTluakdWMlpyODlkNHdk?=
 =?utf-8?B?czhXMGhoSHdXN1dzOTl4eUd3REdGVG93Y1BqT1UxWVBnN0k3UHVlbzE1TkRs?=
 =?utf-8?B?U052b2d4MUtQTXJjcEVWbWc2NHdRdG1CYkt1dExlek9IcC95T3NvZXoyeVBw?=
 =?utf-8?B?M2pMMkg4VVU0eVdtNWw0WTE0T3BVNjlaWnNBejdOc3hRdXI1MjhQaTFqcThq?=
 =?utf-8?B?dld0eWZ4RVkvZXpLajU3ZGE5SmFOMi9CSnEyTEQ1VjJxcDFIckFJa2F1bGxG?=
 =?utf-8?B?dFpqTU5sazI2LzQyR3lxVDRTcUV2R1Vkb3pma0x4a0hTbThMVDQ5T0tqTytt?=
 =?utf-8?B?dkYraHhZV2VCS0hROTZ4N0t1SkhxTG02N0VibUQzQWtTMk5jaWg4WmdUbVNz?=
 =?utf-8?B?Y1JianRTUFZVSUV1TU4xTmpBVnY2V0hEV2hEb0FYcDRSOVZDSTJiQ0Z1c0Nv?=
 =?utf-8?B?RWxIQmc0YXRBVDV6bUlyeDJQSHRjZDRaVDAwYUVnQUlpUEM5cVdTeTNrRnhB?=
 =?utf-8?B?V1M0a3FSMHJiMjNnYzM5b3ZsTjJRVDFXNGUwT1ZidE9tVEFZVmIxdjg2SVpu?=
 =?utf-8?B?WUpFWDgrclV1b1F1UnpvUUdvTjNrRFp3cldCanorN3ltWHVXSUtadDFPRHdz?=
 =?utf-8?B?b29iYThxcmFNUFNacnFxT0ZKOE1ncTA2MFl5RjhzVEZVYWxkR3RnMElhaUhM?=
 =?utf-8?B?Z1pndFB3SVRZWVgxUzdjNE9ZNkR4M2NieXhVcDlQZTFmZU5zNjhIbi8vZ0Ry?=
 =?utf-8?B?TitlODN1K09YNmFuVUNUMU1XUjJGRXplR21CenYyRkkyODRuYlpQSXM2bHU3?=
 =?utf-8?B?WitTbDF3aDNBTXVUSkpVTm1id3UyMXpzdXowZ3VVOHZTWEJsTXY3K3BSNXZw?=
 =?utf-8?B?dXBTUUtOaWozZjZDQ3ZoWXpWRXptMGRMQ25rOVpVY0hCdGtIcW5PaFNxWHBn?=
 =?utf-8?B?Rk9QMVFmUEhLYUgyQ2ZNOGw1a0NGZ3RhaUlRNVJNSklTem1WeUo2WkQ4LzVY?=
 =?utf-8?B?NWprRWJuU211dGVVeCtWWUU3VVFMMFljQm5oN1h5T3FYZGFlbjhTcDJJK3pD?=
 =?utf-8?B?T2pHVjUvRFJrYXJmRnFDSFFJMHc3S1RRYlh5ZkdSTm45c2dtUUU5VGk1QXND?=
 =?utf-8?B?cXhsUVg4OER6OGdpV1JIcUZUcXNxVUdiT1Z1MXZHZmF0QXBsSGo5RXFPMFhN?=
 =?utf-8?B?Wno0a2hIN1pxNDUrWGNLaWtlQWZBMWVNcDFvajhqN21KS1NaU3R4a2JJVnpv?=
 =?utf-8?B?VlhIa0poMlhjcTQvMzRPUHRUV0JZSnZ3ajVxVlFDWHVuaHA2QXJ3Y1puRStR?=
 =?utf-8?B?NUwvaWtTVjZ2Sy9reitUYjJaMWFvUWlUWVhpZk9QeDFDaDJhSHRKNnlmK1ZL?=
 =?utf-8?B?WlE4MUYydXVjbFI4R0E1ZzBnanQxNXdQSmxtMmIvZTl0VDlXTWlRenBWd3pr?=
 =?utf-8?B?MER4UDQ1NncwZ1ZHdDlvbGh3ZTMwNWtRSmE4UU9qeXhYMXpHZWxzTW1xUTUy?=
 =?utf-8?B?T3h0UE56SVhPSEJiczVtak51MVJWTzE0MXVNRlNNL3R6aE5BdWYvVHEraUJm?=
 =?utf-8?B?SWI4MHRwZjIyM0xVczY5ZkZGOStjWVhiKy9HQmUrcDJ1ZUI1UWttWDRzYzlC?=
 =?utf-8?Q?+va7bJlqLUVru3UtuzS5lVFCq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac1ea373-ee4e-48f8-e0e5-08dc1d4b5ed5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 02:14:33.1588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xBOKyBg/fXMMpgt6FEVaeFhaw/LaxoJpyKket2L2A3bwi05GTxNwKZj1SWDenzoMP89wVI8wJIAMOToGlCKKSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5337

On 1/22/2024 9:12 PM, Ratheesh Kannoth wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> kmalloc_array() does not initializes memory to zero.
> This causes issues with bitmap. Use devm_kcalloc()
> to fix the issue.
> 

Is there any reason to not use:

bitmap_zalloc() and bitmap_free()?

> Fixes: dd7842878633 ("octeontx2-af: Add new devlink param to configure maximum usable NIX block LFs")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>   .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 55 ++++++++++---------
>   1 file changed, 28 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> index 167145bdcb75..7539e6f0290a 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> @@ -1850,13 +1850,13 @@ void npc_mcam_rsrcs_deinit(struct rvu *rvu)
>   {
>          struct npc_mcam *mcam = &rvu->hw->mcam;
> 
> -       kfree(mcam->bmap);
> -       kfree(mcam->bmap_reverse);
> -       kfree(mcam->entry2pfvf_map);
> -       kfree(mcam->cntr2pfvf_map);
> -       kfree(mcam->entry2cntr_map);
> -       kfree(mcam->cntr_refcnt);
> -       kfree(mcam->entry2target_pffunc);
> +       devm_kfree(rvu->dev, mcam->bmap);
> +       devm_kfree(rvu->dev, mcam->bmap_reverse);
> +       devm_kfree(rvu->dev, mcam->entry2pfvf_map);
> +       devm_kfree(rvu->dev, mcam->cntr2pfvf_map);
> +       devm_kfree(rvu->dev, mcam->entry2cntr_map);
> +       devm_kfree(rvu->dev, mcam->cntr_refcnt);
> +       devm_kfree(rvu->dev, mcam->entry2target_pffunc);
>          kfree(mcam->counters.bmap);
>   }
> 
> @@ -1904,21 +1904,22 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
>          mcam->pf_offset = mcam->nixlf_offset + nixlf_count;
> 
>          /* Allocate bitmaps for managing MCAM entries */
> -       mcam->bmap = kmalloc_array(BITS_TO_LONGS(mcam->bmap_entries),
> -                                  sizeof(long), GFP_KERNEL);
> +       mcam->bmap = devm_kcalloc(rvu->dev, BITS_TO_LONGS(mcam->bmap_entries),
> +                                 sizeof(long), GFP_KERNEL);

This is pretty much bitmap_zalloc(), except with devm. As Simon is 
asking, is devm really necessary? If not bitmap_zalloc() and 
bitmap_free() seem to fit your use well if I'm not mistaken.

Thanks,

Brett
>          if (!mcam->bmap)
>                  return -ENOMEM;
> 
> -       mcam->bmap_reverse = kmalloc_array(BITS_TO_LONGS(mcam->bmap_entries),
> -                                          sizeof(long), GFP_KERNEL);
> +       mcam->bmap_reverse = devm_kcalloc(rvu->dev,
> +                                         BITS_TO_LONGS(mcam->bmap_entries),
> +                                         sizeof(long), GFP_KERNEL);
>          if (!mcam->bmap_reverse)
>                  goto free_bmap;
> 
>          mcam->bmap_fcnt = mcam->bmap_entries;
> 
>          /* Alloc memory for saving entry to RVU PFFUNC allocation mapping */
> -       mcam->entry2pfvf_map = kmalloc_array(mcam->bmap_entries,
> -                                            sizeof(u16), GFP_KERNEL);
> +       mcam->entry2pfvf_map = devm_kcalloc(rvu->dev, mcam->bmap_entries,
> +                                           sizeof(u16), GFP_KERNEL);
>          if (!mcam->entry2pfvf_map)
>                  goto free_bmap_reverse;
> 
> @@ -1941,27 +1942,27 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
>          if (err)
>                  goto free_entry_map;
> 
> -       mcam->cntr2pfvf_map = kmalloc_array(mcam->counters.max,
> -                                           sizeof(u16), GFP_KERNEL);
> +       mcam->cntr2pfvf_map = devm_kcalloc(rvu->dev, mcam->counters.max,
> +                                          sizeof(u16), GFP_KERNEL);
>          if (!mcam->cntr2pfvf_map)
>                  goto free_cntr_bmap;
> 
>          /* Alloc memory for MCAM entry to counter mapping and for tracking
>           * counter's reference count.
>           */
> -       mcam->entry2cntr_map = kmalloc_array(mcam->bmap_entries,
> -                                            sizeof(u16), GFP_KERNEL);
> +       mcam->entry2cntr_map = devm_kcalloc(rvu->dev, mcam->bmap_entries,
> +                                           sizeof(u16), GFP_KERNEL);
>          if (!mcam->entry2cntr_map)
>                  goto free_cntr_map;
> 
> -       mcam->cntr_refcnt = kmalloc_array(mcam->counters.max,
> -                                         sizeof(u16), GFP_KERNEL);
> +       mcam->cntr_refcnt = devm_kcalloc(rvu->dev, mcam->counters.max,
> +                                        sizeof(u16), GFP_KERNEL);
>          if (!mcam->cntr_refcnt)
>                  goto free_entry_cntr_map;
> 
>          /* Alloc memory for saving target device of mcam rule */
> -       mcam->entry2target_pffunc = kmalloc_array(mcam->total_entries,
> -                                                 sizeof(u16), GFP_KERNEL);
> +       mcam->entry2target_pffunc = devm_kcalloc(rvu->dev, mcam->total_entries,
> +                                                sizeof(u16), GFP_KERNEL);
>          if (!mcam->entry2target_pffunc)
>                  goto free_cntr_refcnt;
> 
> @@ -1978,19 +1979,19 @@ int npc_mcam_rsrcs_init(struct rvu *rvu, int blkaddr)
>          return 0;
> 
>   free_cntr_refcnt:
> -       kfree(mcam->cntr_refcnt);
> +       devm_kfree(rvu->dev, mcam->cntr_refcnt);
>   free_entry_cntr_map:
> -       kfree(mcam->entry2cntr_map);
> +       devm_kfree(rvu->dev, mcam->entry2cntr_map);
>   free_cntr_map:
> -       kfree(mcam->cntr2pfvf_map);
> +       devm_kfree(rvu->dev, mcam->cntr2pfvf_map);
>   free_cntr_bmap:
>          kfree(mcam->counters.bmap);
>   free_entry_map:
> -       kfree(mcam->entry2pfvf_map);
> +       devm_kfree(rvu->dev, mcam->entry2pfvf_map);
>   free_bmap_reverse:
> -       kfree(mcam->bmap_reverse);
> +       devm_kfree(rvu->dev, mcam->bmap_reverse);
>   free_bmap:
> -       kfree(mcam->bmap);
> +       devm_kfree(rvu->dev, mcam->bmap);
> 
>          return -ENOMEM;
>   }
> --
> 2.25.1
> 
> 

