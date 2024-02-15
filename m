Return-Path: <linux-kernel+bounces-66311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8435D855A2E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 06:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48666B236F5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 05:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F198BA3F;
	Thu, 15 Feb 2024 05:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3/oZTxB7"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D681923CE;
	Thu, 15 Feb 2024 05:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707975841; cv=fail; b=u5AVbVC4beCPjeKc+9pPnDjUbmDwosHgV8S00xk2cF/xgZ+SIs9NA3hJUKdc+nDlV9v7UH16My79IE6xA8QzYixUlgSoeadcifdKaENGvZnfoKVXg+Z+ne7EU9NwVp9q0pwmdyRPRROHVZuIT3bPk5/jX5sHBZOH0rVgMJA0IoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707975841; c=relaxed/simple;
	bh=B4vXT2bXj5lr76UAeT2Fvs3quf6D4wUZZfVJWAlA4Xs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SBaHFLxojy6ndJ0G6aA3y78k2o59nGbiOQsjiWcs80SmmxkMBHXs7WlPksJLMZB5NabWe5AEwD69pOiAkjOOjebWaK0QjGysLdcL3rj6bokt31js07Z9oZPB24pQZxcwGy5bs1Nhv7VetdJQcfAc4lxNiED3RJAytuSHWB1nG84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3/oZTxB7; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLudgX5lAHK/7y7hsp1rKKFe9MLSs9QzvxAUUrylqNxgsPwOlK1nn7/OKkFyP58ziap+ZaJ/PZNJ35n/FEpBlsGT9PW/ftG+HpJ60NoBHIJw2Of3EyqHZK10zvKP4J+ua3Hgvh4RSW/IaMq3C/oLvUbVBzxGz7HspFcG0AdxrZZpUGmMpz1F+ejVOKzLPj+YwVb7kjxI9+08FHynATDIKccWJc/zYoB115n5EHehSyt0Cm7wm7tvcL38VK4ScprDSwjntgErWVaQ9FQzaSwptCCqsjBbLFMwGErZQetlqFZfltrTHZ5gQpTIQ+kEMg20fYr+xXLvUNCLzKfIQxKPhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QY3saeXHBbPSgf/WJm53pvklYN2EVZeow0PGjT/qbOk=;
 b=jIfenDEYSoQADB2i1ftspONAY4OeD8HrO9d4Qiugxldg2+yCdEUiYskY1e9wu0iCz96d26h4u88ksh9A32yWl/SqcDx/m3k2bqiXJiY66S8Lch/GqjFtxYjucH6XhFmyuuTp+CGkoMSpdnQ8F4QbnRoTmxdArUAJa1Y5kMXAaPMuKZqcrkYt2Dwi5qvMOMc/pXOKY5ewDfAeZqYuPLr3wediBJwUGZ1hxlsADMWuTYH86QR+Ec85/0+k6FGRVxhauG0DS4PecXBDhf8hu42V7hBqTKPEv3Ea7Ms8CJ5utGnSDfSqkpWpP6x2iqjhRxHSzP8gORN4BWLJ3xVFUW4CnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QY3saeXHBbPSgf/WJm53pvklYN2EVZeow0PGjT/qbOk=;
 b=3/oZTxB7Zl2rvF5BulpYMjNE8YL9jm1y03OQxTPQtyYA2lGta2hL66ehiaNhW0K7Qzpr/JSE1WDPnUX6hky8QKmeg+gZHNNUoG5TAB6hu/NbmjXSN757tV0ppQPXAxQuHerKbwcU5ybN3r0hfimyWJeelP7N3/AQAWfs9HjkTbQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 by CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Thu, 15 Feb
 2024 05:43:57 +0000
Received: from BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::1602:61fd:faf5:d6e2]) by BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::1602:61fd:faf5:d6e2%5]) with mapi id 15.20.7292.027; Thu, 15 Feb 2024
 05:43:57 +0000
Message-ID: <6a8d100c-57a5-4c92-b744-453c106352ad@amd.com>
Date: Thu, 15 Feb 2024 11:13:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: macb: queue tie-off or disable during
 WOL suspend
To: claudiu beznea <claudiu.beznea@tuxon.dev>, nicolas.ferre@microchip.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, linux@armlinux.org.uk
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, git@amd.com
References: <20240130104845.3995341-1-vineeth.karumanchi@amd.com>
 <20240130104845.3995341-2-vineeth.karumanchi@amd.com>
 <d8c48839-8b22-47ad-b270-e96a1ad1adee@tuxon.dev>
From: "Karumanchi, Vineeth" <vineeth.karumanchi@amd.com>
Content-Language: en-US
In-Reply-To: <d8c48839-8b22-47ad-b270-e96a1ad1adee@tuxon.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0187.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::14) To BL1PR12MB5946.namprd12.prod.outlook.com
 (2603:10b6:208:399::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5946:EE_|CH2PR12MB4326:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b7cd3e-a0ff-4dc3-731e-08dc2de91a26
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yc6Eh3yB7qw2TswAbBYDLbzpxhIJKshtnFf55hKtclqc8jkRzn0qLGkOS7DATM/h/Ar0iunPItcO6pd8sFCUZx4uzQ6/TJCSrCOoEN2MlgK05LY8MaMloxoMF23CR+QRW0UCo81uNwf+j1dgxJaoNoI4BS4QDJ5d93aa3au92307IScfDtjhUJDn9RkIHNkZz2o7DCBM5wAKYPGAGNK6fd2ryfipPQR+NPW4JanfwFA/Y2YEOTN3jOLe/CTcSxpTdwYXmhzDFR+RNsCsiTOaq8OAjCaGW41380PdnvRvEaXnJ615DYPzC7vX6Oyx7/ND+NQB+32J0fuGWz9gR8mtJSYdWqmar+8ryK+eSH30ncCVgtprghjc7fr3X4bnYGbRohC7xDiwSifPQaKawX4/IEdWCDMSblLbyYwW+7vUVuAc3MsRmDftY4QFXOsqeyy0lAqnUx6lHP0Jo+IgLCHy4j/rkF3xz1XXCC7UiVMOCi1A9+Xh59uh85r6gIAJWi8Rcx7ckFmt/tGxlFIvrjgr40q0xcYd+iSePtSd+tM59nZn91+4+zm0+HZdqJxUgp08cidw6itxuhTy4KIGCYAQc+fBT2N6krjUIcs21NKdP0A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(396003)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(921011)(8676002)(53546011)(2616005)(41300700001)(4326008)(6512007)(66476007)(8936002)(66556008)(6506007)(66946007)(6486002)(316002)(6666004)(36756003)(38100700002)(31696002)(26005)(86362001)(478600001)(2906002)(4744005)(31686004)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tnlnc3FxRXZ0RFpXU3YwaTFTTitWWG9tb0Zpbml2Ymo3eXpVQ1VtQjdUVTQr?=
 =?utf-8?B?azZ6dVFFenFQY0ppdVRXY0o1NDgyU2ZPYU1iUERaMU91YzQrcnliSXlOZTdx?=
 =?utf-8?B?cFBiMFNVQjRkWkYrcDMreGZvZy96cjFNNENRbXl4RDErWCtYYzlOTlJvN1hG?=
 =?utf-8?B?ZUZnSUN6MlJEdlkvZnpYSHp5a0l4M3JWUkpyNmRlbDFvT2x2K05HS01DbFdn?=
 =?utf-8?B?YXFNTExrNk1vZEwvYVN6RGE5aDJUZFJpbTNJaThBYXFlZGRwQm13ZFNNbGJz?=
 =?utf-8?B?TnNSUlViQWJ6OGtuZjFpUnBJVWQwenYwcy9mUzR6Zk1xblBNQ1pJMHZvdDRV?=
 =?utf-8?B?bGhFcnAzRTVudlNyK1BkeXY4TFcyOVpFdWpXRDB1VTc4cUpqRnhSS2wxVlow?=
 =?utf-8?B?dUJBSm1SUjRlVDdDclpZMVYzWm9QWXc3VWpXeGc2dFZUbk1DVW1nQ2VaTERz?=
 =?utf-8?B?M3hBZFJVSGNmc1FTMTFLbUJqNktHSnRMamlKNmZhTGV0UEh2U1pxYjZwSHRX?=
 =?utf-8?B?RE4zVjJNK0wwTnZNa3lPMjRiK0g1eURySVYvZzdUTjdRRHpvSmtBakQ1L2w5?=
 =?utf-8?B?NzNTSU9TWXhJTklXSFd5MDE0Wk0zZEV0RUk5MXFhMS9GQUh1bzE5S3ZEMjNO?=
 =?utf-8?B?WlFaR2ZmSWxaaHVyM2E1YnFSUGp4MG84WUwxN3hmNlNmZURLZ3VmdVZaNFJC?=
 =?utf-8?B?TTFQNUlIMkhkV0JjM0hTajBrL0hPcHl0L1EwTDhXSTF0eWRNbUlWTkNDeFYx?=
 =?utf-8?B?d2ZwakthWjdmbXkybnJFSzF0bi9RTWMyV01TVlYxQ1JrajFtcmtGdEZXUjI2?=
 =?utf-8?B?NGlDRjVaa09RYWhqQkMwUXhUVXB6Zllrcmx5MHFzOVJjNWcwQUhDcFI3bDBU?=
 =?utf-8?B?MmZSRmg4UGhMRXMyQm1KSE1qa25QS0c2NG9hR1RIS0lWRnFSbTh5K0pWM0ZV?=
 =?utf-8?B?aUxhL3VOVFVGVTZJNC9JR1Q1Ukdob21MUnhkUEtWeEsrZCt3ZUVvQUVBTkV3?=
 =?utf-8?B?amhKWDNMQThzSlVHVncxNXBhZzk2SzBHUzd6WDVQcU1mc0FCc1ZuenRMS3FI?=
 =?utf-8?B?YnNqWHZHRzVnY21zZVdqaDlIUG9Rc2pEUmZMYWxqL1Yra3RpN3QwaW80ZUV2?=
 =?utf-8?B?L1ZRSXhKZUh0S2g2SEVaRktUZUJzdjk2YUt2N1hxSXFoWXRCczB3ekFYWHVO?=
 =?utf-8?B?WWI2Rmk0QmJJYkdNN3dBcE5YaFhUcDdCMHJIeld0N2xEWitmaHhUcUdQTEVT?=
 =?utf-8?B?NFFMcHMwK0lvWjhtVXdPOTcvRk9aSVRLc0VIZzhXME1vUWM3VVFxc2RhSkI4?=
 =?utf-8?B?S1pFTjU4TFdTUitXTGxuNDFsMnFFd01qNlBSbCtXNjJjOGRiYU9QS2JFTnQw?=
 =?utf-8?B?ZnJ2eHU1N3hoQTV1VXFXVEVLZ2VOQ25vOHQ4b2dWOWVkczlFUkQwdUp2OEgz?=
 =?utf-8?B?bG9uekRmWERMdTNWN2NWbERWRWJYTUZRWE42Zk9QMFlqa1FtVnNUa2VQdVRu?=
 =?utf-8?B?S0lRVllXd0ZiMUhvWXJ2WHRFK2lQZG0wS0poNHN4eWtkSldnZzJtWVdYcDh4?=
 =?utf-8?B?QkNYd1pVMFBiSENhYTNOdjlqWlIvcnNHVHRSMThDb0ZtN1hHcHQzUEtUZ0ww?=
 =?utf-8?B?T2xnQzJkdDVnaVI2czc3akwwVDVCMVBpUnAzRnRqenpqTFhSSEVTUks1UEZx?=
 =?utf-8?B?b2hlMWhDdXZWeE1VOVJxbUxzL3ZTYWJPUW1OQ0dCZ3lIMDV4QVdSaEgwRFBE?=
 =?utf-8?B?VCsxQ05zdmVtQzJRZUM4QjZWcFBUYk03QytEVkordGFkWUJuNEI0SkY2M3ln?=
 =?utf-8?B?bG1ncEM2T3hQaFkzMDlDdmpLVis2SFJyekJiTmpUQ3BrTDNBblRFV0hQTGJs?=
 =?utf-8?B?NVZrUkJIREpkdkRycEhuVEFSZHl4MTB4YUN4dXQwZjdQRnRseUVESUhNTkNG?=
 =?utf-8?B?ODBPbW1sUnJyRWRLdmxPalBkeXJ3WTZLTWFLZHZ0blVMRW8zNVp3aHNJQzRP?=
 =?utf-8?B?eUlRcG91V1ZMbW4zOUg0MzdBUy8zaE82UTN5cEUvSlpGblpIK0ZtV0VzOGFD?=
 =?utf-8?B?TlpuZ0lEcmg2clZ4N3krUHIwRkV6d29jb1lXTnlqNWNiWUhieWgvam9Sa1lv?=
 =?utf-8?Q?KoYtzqhKcYwdqFIIOwtjMVfpS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b7cd3e-a0ff-4dc3-731e-08dc2de91a26
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 05:43:57.0235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FaDz5HdRDvUKvmJZHow2QbK5iLXe7X/6CwbAtGHc49WDRIRqSnd9aKvhItSKeXjH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4326

Hi Claudiu,

On 2/3/2024 9:08 PM, claudiu beznea wrote:
<...>
>>   		queue->tx_skb = NULL;
>> @@ -2568,6 +2574,16 @@ static int macb_alloc_consistent(struct macb *bp)
>>   	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
>>   		goto out_err;
>>   
>> +	/* Required for tie off descriptor for PM cases */
>> +	if (!(bp->caps & MACB_CAPS_QUEUE_DISABLE)) {
>> +		bp->rx_ring_tieoff = dma_alloc_coherent(&bp->pdev->dev,
>> +							macb_dma_desc_get_size(bp),
>> +							&bp->rx_ring_tieoff_dma,
>> +							GFP_KERNEL);
>> +		if (!bp->rx_ring_tieoff)
>> +			goto out_err;
> You also need to free the previously allocated rx buffers.

Are you referring to (bp->macbgem_ops.mog_alloc_rx_buffers(bp)) allocation ?
It was freed in macb_free_consistent():
			 ...
			 bp->macbgem_ops.mog_free_rx_buffers(bp);
			 ...

Please let me know if you are referring to different buffers.


> 
>> +	}
>> +
>>   	return 0;
>>   

-- 
🙏 vineeth

