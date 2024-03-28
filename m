Return-Path: <linux-kernel+bounces-123834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95ABE890EA4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9200B229AA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DE713958C;
	Thu, 28 Mar 2024 23:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="F4LLCIkZ"
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11023019.outbound.protection.outlook.com [52.101.56.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB6C1DFF5;
	Thu, 28 Mar 2024 23:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711669309; cv=fail; b=puXmp9kzXhRDt5/zLo/TX2c46PwtZ7kh94kecKeA5QEFJFVeiwDr7OM8hAAMubZdBrmpMKVenMkobkYfOsINnBGnqcEWdRZKGivdIlJBLd8HMD+mJYeD+Pn5f3Qtl23ATydUdplvMNAMa37WqtjBhIISRWYMgxFxChY/Bhs4Li4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711669309; c=relaxed/simple;
	bh=9yKHJ9B63AEBPkTpFw3vGvcL1gJrvmyjlao/9H1pOVA=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FvxxD0luPZayEVfAmqXdkeLw5a2vEYxmFqYEFBmy/kNs2fA7LObfRoSgYpuVWf3SrS6zo0VqnHYCrkzuT4zu5XeA2rPfk85C1VuQIN1Vd1MohuLRlRpRDHFUEXfRfMMLOsdH93se+f3P4/3SPwEdPoRVg9zhjr6BRdikWnxxAR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=F4LLCIkZ; arc=fail smtp.client-ip=52.101.56.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qj8OiJj4zt4M6PXeI0M2n3DmNUizHabwpa8iZOPJh7YEHLeq9HPBruqczfV1DD4aFIsa9EXuvrCQAucud3irznJM0pgmo0WurSfxhTdMWY6rQ8c8puNLjPDn7GEJ5Yo9no0FszwZAlguIy01roYm1r8ITSCcDWVVd/V+J3sIXYKZthe9aIOZMg888L00tEVZRkt360YEx/KIhZdF7jGMCeGLOo/3aoquOMGSCnZX/Zhnj3h9/S+Jz1neBbPubI6wj47QUaNiPO8zDaldad6l2vOiMGklXgAw1o0dC/Q+HBdEljieG0VWsZf/Ccd+i9wtIpX/GR1M+Lwmyu33LTxfzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8QPhe+BU0s3uMP7YryxtgGR2g/P0au8w6M/3Jc1bLM=;
 b=OaRARyyrO5aHpbWkQUqj7t1EVBkOXBjTljLdcgu+FO21KtB2nW8Ix0bQ10CE8NmIlP+FK/LY6H3iSQ0JLgbvHijGZ3EiIrSSyKotqDmK5AHcz0Pp1BW3H6crx9cFtcN3qSyLDqgKtGGBUq9D0yeAYDdztyClSIs/kotSjWI/4yZbfOkdZzWpPbOL5tN3fvFDqPui/ciyJaZ+ipiWDD41lj32gydDYxKFD5FDR4pept6TtT15I/Kdw22yv3oDpOunB0WQbVzuficjrwnIcLu9ygs5oKYntj9HMFqjsjXP3JkscoRX8BRq72ggA9IfSe2RQIRDPRDUjsv3HAxMcAVveQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8QPhe+BU0s3uMP7YryxtgGR2g/P0au8w6M/3Jc1bLM=;
 b=F4LLCIkZ4aLsKVmrURnthJYpuUsVrKa54eM0JBe4XSfv+TQzY05Pb6iQNnJQuanemQuCYnQ9MViZpw9Zuaxs3n2EJprV96tVGbDCPRX6topFPjvT+QaAEO8uR8888c11siu22vh/ExmLgF3Kuk8z0ZTqkH5ZvFN4OyyJRlM4X7A=
Received: from CO1PR01MB7370.prod.exchangelabs.com (2603:10b6:303:159::16) by
 PH0PR01MB7399.prod.exchangelabs.com (2603:10b6:510:10a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.38; Thu, 28 Mar 2024 23:41:41 +0000
Received: from CO1PR01MB7370.prod.exchangelabs.com
 ([fe80::994c:4200:8a4b:6882]) by CO1PR01MB7370.prod.exchangelabs.com
 ([fe80::994c:4200:8a4b:6882%6]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 23:41:41 +0000
Message-ID: <78d11760-bb43-42a1-a302-3e2d3bf40c48@os.amperecomputing.com>
Date: Thu, 28 Mar 2024 16:41:36 -0700
User-Agent: Mozilla Thunderbird
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Subject: Re: [RFC PATCH v7 12/12] memory: RAS2: Add memory RAS2 driver
To: shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-mm@kvack.org, dan.j.williams@intel.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 david@redhat.com, Vilas.Sridharan@amd.com, leo.duran@amd.com,
 Yazen.Ghannam@amd.com, rientjes@google.com, jiaqiyan@google.com,
 tony.luck@intel.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
 rafael@kernel.org, lenb@kernel.org, naoya.horiguchi@nec.com,
 james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
 erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
 mike.malvestuto@intel.com, gthelen@google.com,
 wschwartz@amperecomputing.com, dferguson@amperecomputing.com,
 tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
 kangkang.shen@futurewei.com, wanghuiqiang@huawei.com, linuxarm@huawei.com,
 wbs@os.amperecomputing.com
References: <20240223143723.1574-1-shiju.jose@huawei.com>
 <20240223143723.1574-13-shiju.jose@huawei.com>
Content-Language: en-US
In-Reply-To: <20240223143723.1574-13-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P222CA0022.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::18) To CO1PR01MB7370.prod.exchangelabs.com
 (2603:10b6:303:159::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR01MB7370:EE_|PH0PR01MB7399:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0OqT0FpemKT4yv1fW7Art5+4CxYqAk62PV4OyUX0V1EosLb4WtZSau8T1df1Ya3SigLUvH1GbKna1LvssnuMEAbSONMeAsU42WgVW5bn1IQVzOkq9Iae8sGPkGe72/d143NkJF+aYtYseazeRANjsvGS2zRyw4U2WLf1mDszYnEUOrqVxuRjaAEPBd2t5i63phUBUSAcWo627G7ya+IyILKt90Z/zDFAEAOWOslIDkpyXXvkAsJXxrx9K+Si2anUaxm9kyEYdM1pwM1Py32+CgEeSfm4vsmxhreOcIHcPgIIYr1ysT5iSyUpHwGhZ3C8v2LzsSqCEKkKa8Nn3ibdN5YYhbILxCAemqiw8cx8+ibNL7KVLblNS+ugNxIAX7ooBBqKZL9cFN9C4Q6j5VjFUEofnM490P3FxnjwNfqcy/l5Y4/PUMBiWIr5bnDMbMXBIu1h2EGwLFVAy3KIVj9qE7WhVKk1mqHn3uW5wEF++2opOv8uUYFaIqLTJQTCm93XzsgVhAHxDe1UeNyWYyo8y3hKmNHkUIjrmJ/JwCDok4XSG4gKSMwjMxwpBu4x2P/0p/Kc7XZJIhH/tw95lQADf8XLJjK2B5jr2RuXy282BIuWFEh3KvEFMEHWkmsX6KwK77ctEjbBQWkWBPKwE8kTtyNPAuTpXvvNILDLBTEoa34ol2acHxmMggkv+ltSPKDs8IrC5XK6EGyP1oLuQtnjFPjnOWZzKqJJyhcETknU4+s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR01MB7370.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(52116005)(366007)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1RFRHYvZkVuWXRJV2N1Vk1HZXdZc3VxRkprV1JSNVd0eDM3NTVMN1cyWmEw?=
 =?utf-8?B?R3IyRjg0WFZjSHFFUVBYR3NPMHdHa1RDL2pUSk0wUVorSmlPU1pNdWZxSEZD?=
 =?utf-8?B?b3FZNEoyYUQvNzEwaktaVlVreVY1UXRQd1dnTGc0RWd0aWE3VkxHMEo5T1lv?=
 =?utf-8?B?SUF2d2x1YThnWGtpZGxQcUd5dXIxM2JCTWowbjMwZm5ZS2tpOEF2ZHBXdDVP?=
 =?utf-8?B?VG4rSDR6MG1yRk56YU9uRUM5ZzFwR2ZZVEhyK1JCMi9UazY3Wm9NVURkMnB2?=
 =?utf-8?B?LzZHVlB5U2NyZ3F6aFpmTkN6aXQ5VWFORDhOL2hrYTRRY2J5ZkNxamtYSG5L?=
 =?utf-8?B?SE5sNUVteDI5WGdjTzhMODRmTWNWZzMrdlE0aXo2RDJlRVVWQnJnMVpFMm9D?=
 =?utf-8?B?dGNPMDcvVzI2WE9LbTRLRS8yS0dwanFPbitvcjEyaGRwK29sRkdYYjFQRjNw?=
 =?utf-8?B?cmdkK2I0VU81cWJaTkYrcFprcndzZ3EvQXJjOHZvZkpJWHltM0xXTkMzb1Bh?=
 =?utf-8?B?MEwzdkhnWU1PZUtlWVZtOGxFOXFZTTR6UUd1bmY0RW1Ia1E5YU14eStjaXBV?=
 =?utf-8?B?Ti9BMFdtY0dPbXlaR1V4RlplL1QwdytFR3NhMHZ4ejlqcWxNSkNOUG9pcy9w?=
 =?utf-8?B?dzlHR29XQWc5UWY1bU5WVkJyOWFzRXRSNndMSHJWOFlNQ3ZTSzR4aUV1blEy?=
 =?utf-8?B?WU9hbTUrSVVMa1hwaXIwTCtKSVNiTzB4NG10WGZHbVR0eGhvMk14V2pHU3Jn?=
 =?utf-8?B?L3VyU1JzS1F3YkkvR21TMWtMS0k1aGRHT1ZHNEFuTVZqQ01UNVBWZi9qcm9s?=
 =?utf-8?B?RWVJY1YvdDVMUm9jTUFWSGJwV24zaE1nZzlYTndLS1NBRTRxYnJmMjIxMWx4?=
 =?utf-8?B?YkdqTFdrWTExYm9XdFdDMElYWmZPV1c1QVBqRTJ0bmdmc05qd3IrQnp4dy81?=
 =?utf-8?B?M1k0bElONGhLdkp5VlhZcURyeWtDZURvK1cyVFZuY3YvM2NYSnpONDdzOU1C?=
 =?utf-8?B?RytOTTNTNzJ5WWtLUzgrdzdGYlZHb2NGYnNlVnJveWo3c3J1ZSs3MkNzUFUr?=
 =?utf-8?B?ZTBrelIyUE5peW1jSVVsRGdUaHFaZ3lQdlc1OEdkenY1TDJZRnFOcFQwRmJM?=
 =?utf-8?B?TGhrVldQd3BKZzFka01acGVZODA2NE0vb1g2c3hsVHV4U3JWTW43bmprNXMx?=
 =?utf-8?B?WTlWOTJTWkFsVEtYRDBuc0JLVXZ6dmcybGxoNE1lYXozNVJLeDZQK2RjQVlR?=
 =?utf-8?B?V0FITmo1K1h5czlnRVJ2dXVRdDZiTVdkRmpONXcrUEtEdXhxRTVybk1pa2t3?=
 =?utf-8?B?ZkgvZ2FueWVST2NnaXhwVTRVZ3ErMDRCb3VSaWdrQnI2azBHWEZmclAreVhs?=
 =?utf-8?B?YzRXelVkSVZjR08va2dHbjc4L2tHaXRjQnltakdLaXV4SUpFMDFnajhOVWg3?=
 =?utf-8?B?c2duK2xLdHlPS3V2WGlERmdtWkk1Um1nRDZEbmlBdEFEMnhFVjkvZUtRd2NU?=
 =?utf-8?B?aHk2clk2cmlMRTJocXFDZTJUOUc0RnhWMW9HRmV2VEpxUnJIY0NBdmF1NTJX?=
 =?utf-8?B?UHU2SS9CVGEzTmJVREpaUGVFdVNCZk5RM3JHOElhWkkvN2d3Vk1DNFFtRHY1?=
 =?utf-8?B?MWQ4Q1N5aUV4Y0pkOFRtdFNYb2NQM2RETmc2S2Y1MXAwRFVPTEpka0ZnaTg3?=
 =?utf-8?B?QTZuSkZEMXVkakkzdVluaHh4enF3RWVEVXUrMW96c2lhNVVuZm5FbElXQ3pk?=
 =?utf-8?B?UStUTk1FZXZWWnZBVDArV1VWQm1yYis0dVJhYW96ZXltblUvVDB3YUxtTmdv?=
 =?utf-8?B?L0E0YVNad2FZckY3ZG0rclV3czZHTTRhYTdhb1ZjRVNnWlY1TXBSdkRzTlQw?=
 =?utf-8?B?UlVKQ2JDOU5WWTkzNUIzWk81Nk5vdlh1K21INEVxemM5bk1kVkFhQk5lSngx?=
 =?utf-8?B?VFhjZnNHVWVGMEF6UXVRU21SSENRUXRpZlJ1a1dibkxYdnBrWFpRWTZEQVNp?=
 =?utf-8?B?TUpZZGVWVHBUNERLaGtOMGFaSFdJMlZydUNIUDg1Z283NmhJMy9MSW9wNy9q?=
 =?utf-8?B?S004UEl2QVMrblVuZXpQQkxJSnp1R2FFQkMxdFdxT2tZai9oa2FOMVhDR01F?=
 =?utf-8?B?T1pjV29LN1F1cWhaTmdpL2x0L3IxM3BzV3I1REV4ZW16UWZyaXROTTUveWtv?=
 =?utf-8?Q?vq7s+tsJWT/45mT6U5aIrgo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a32e4bb-597d-4985-c408-08dc4f809e81
X-MS-Exchange-CrossTenant-AuthSource: CO1PR01MB7370.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 23:41:41.4796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aeFEioJKwpn9UnLG+6QKPTi/uHWX/1rJ6u4sn5uflDvC8XivuK+7jZXkGy9BSDuV3W+mS7wLeaf/SytML0USq2G1bpfF4rOm4mbtOvZoLQjWJsmN2IWNjjfFmrwAWAG8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7399

> +/*
> + * The below functions are exposed to OSPM, to query, configure and
> + * initiate memory patrol scrub.
> + */
> +static int ras2_is_patrol_scrub_support(struct ras2_context *ras2_ctx)
> +{
> +	int ret;
> +	struct acpi_ras2_shared_memory  __iomem *generic_comm_base;
> +
> +	if (!ras2_ctx || !ras2_ctx->pcc_comm_addr)
> +		return -EFAULT;
> +
> +	generic_comm_base = ras2_ctx->pcc_comm_addr;
> +	guard(spinlock_irqsave)(&ras2_ctx->spinlock);
> +	generic_comm_base->set_capabilities[0] = 0;
> +
> +	/* send command for reading RAS2 capabilities */
> +	ret = ras2_send_pcc_cmd(ras2_ctx, RAS2_PCC_CMD_EXEC);
> +	if (ret) {
> +		dev_err(ras2_ctx->dev,
> +			"%s: ras2_send_pcc_cmd failed\n", __func__);
> +		return ret;
> +	}
> +
> +	return generic_comm_base->features[0] & RAS2_SUPPORT_HW_PARTOL_SCRUB;

Since firmware populates the feature bitmask on initialization, it would 
seem
that we do not need to send a PCC CMD EXEC to read RAS2 capabilities.
> +}
> +
> +static int ras2_get_patrol_scrub_params(struct ras2_context *ras2_ctx,
> +					struct ras2_scrub_params *params)
> +{
> +	int ret = 0;
> +	u8  min_supp_scrub_rate, max_supp_scrub_rate;
> +	struct acpi_ras2_shared_memory  __iomem *generic_comm_base;
> +	struct acpi_ras2_patrol_scrub_parameter __iomem *patrol_scrub_params;
> +
> +	if (!ras2_ctx || !ras2_ctx->pcc_comm_addr)
> +		return -EFAULT;
> +
> +	generic_comm_base = ras2_ctx->pcc_comm_addr;
> +	patrol_scrub_params = ras2_ctx->pcc_comm_addr + sizeof(*generic_comm_base);
> +
> +	guard(spinlock_irqsave)(&ras2_ctx->spinlock);
> +	generic_comm_base->set_capabilities[0] = RAS2_SUPPORT_HW_PARTOL_SCRUB;
> +	/* send command for reading RAS2 capabilities */
> +	ret = ras2_send_pcc_cmd(ras2_ctx, RAS2_PCC_CMD_EXEC);
> +	if (ret) {
> +		dev_err(ras2_ctx->dev,
> +			"%s: ras2_send_pcc_cmd failed\n", __func__);
> +		return ret;
> +	}

Similarly, since firmware populates the feature bitmask on
initialization, it would seem that we do not need to send
a PCC CMD EXEC to read RAS2 capabilities.
> +
> +	if (!(generic_comm_base->features[0] & RAS2_SUPPORT_HW_PARTOL_SCRUB) ||
> +	    !(generic_comm_base->num_parameter_blocks)) {
> +		dev_err(ras2_ctx->dev,
> +			"%s: Platform does not support HW Patrol Scrubber\n", __func__);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (!patrol_scrub_params->requested_address_range[1]) {
> +		dev_err(ras2_ctx->dev,
> +			"%s: Invalid requested address range, \
> +			requested_address_range[0]=0x%llx \
> +			requested_address_range[1]=0x%llx\n",
> +			__func__,
> +			patrol_scrub_params->requested_address_range[0],
> +			patrol_scrub_params->requested_address_range[1]);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	generic_comm_base->set_capabilities[0] = RAS2_SUPPORT_HW_PARTOL_SCRUB;
> +	patrol_scrub_params->header.type = RAS2_TYPE_PATROL_SCRUB;

header.type should already be populated by firmware. Is assigning it
here necessary?
> +	patrol_scrub_params->patrol_scrub_command = RAS2_GET_PATROL_PARAMETERS;
> +
> +	/* send command for reading the HW patrol scrub parameters */
> +	ret = ras2_send_pcc_cmd(ras2_ctx, RAS2_PCC_CMD_EXEC);
> +	if (ret) {
> +		dev_err(ras2_ctx->dev,
> +			"%s: failed to read HW patrol scrub parameters\n",
> +			__func__);
> +		return ret;
> +	}
> +
> +	/* copy output scrub parameters */
> +	params->addr_base = patrol_scrub_params->actual_address_range[0];
> +	params->addr_size = patrol_scrub_params->actual_address_range[1];
> +	params->flags = patrol_scrub_params->flags;
> +	params->rate = FIELD_GET(RAS2_PATROL_SCRUB_RATE_OUT_MASK,
> +				 patrol_scrub_params->scrub_params_out);
> +	min_supp_scrub_rate = FIELD_GET(RAS2_PATROL_SCRUB_MIN_RATE_OUT_MASK,
> +					patrol_scrub_params->scrub_params_out);
> +	max_supp_scrub_rate = FIELD_GET(RAS2_PATROL_SCRUB_MAX_RATE_OUT_MASK,
> +					patrol_scrub_params->scrub_params_out);
> +	snprintf(params->rate_avail, RAS2_MAX_RATE_RANGE_LENGTH,
> +		 "%d-%d", min_supp_scrub_rate, max_supp_scrub_rate);
> +
> +	return 0;
> +}
> +
> +static int ras2_enable_patrol_scrub(struct ras2_context *ras2_ctx, bool enable)
> +{
> +	int ret = 0;
> +	struct ras2_scrub_params params;
> +	struct acpi_ras2_shared_memory  __iomem *generic_comm_base;
> +	u8 scrub_rate_to_set, min_supp_scrub_rate, max_supp_scrub_rate;
> +	struct acpi_ras2_patrol_scrub_parameter __iomem *patrol_scrub_params;
> +
> +	if (!ras2_ctx || !ras2_ctx->pcc_comm_addr)
> +		return -EFAULT;
> +
> +	generic_comm_base = ras2_ctx->pcc_comm_addr;
> +	patrol_scrub_params = ras2_ctx->pcc_comm_addr + sizeof(*generic_comm_base);
> +
> +	if (enable) {
> +		ret = ras2_get_patrol_scrub_params(ras2_ctx, &params);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	guard(spinlock_irqsave)(&ras2_ctx->spinlock);
> +	generic_comm_base->set_capabilities[0] = RAS2_SUPPORT_HW_PARTOL_SCRUB;
> +	patrol_scrub_params->header.type = RAS2_TYPE_PATROL_SCRUB;

header.type should already be populated by firmware. Is assigning it
here necessary?
> +
> +	if (enable) {
> +		patrol_scrub_params->patrol_scrub_command = RAS2_START_PATROL_SCRUBBER;
> +		patrol_scrub_params->requested_address_range[0] = params.addr_base;
> +		patrol_scrub_params->requested_address_range[1] = params.addr_size;
> +
> +		scrub_rate_to_set = FIELD_GET(RAS2_PATROL_SCRUB_RATE_IN_MASK,
> +					      patrol_scrub_params->scrub_params_in);
> +		min_supp_scrub_rate = FIELD_GET(RAS2_PATROL_SCRUB_MIN_RATE_OUT_MASK,
> +						patrol_scrub_params->scrub_params_out);
> +		max_supp_scrub_rate = FIELD_GET(RAS2_PATROL_SCRUB_MAX_RATE_OUT_MASK,
> +						patrol_scrub_params->scrub_params_out);
> +		if (scrub_rate_to_set < min_supp_scrub_rate ||
> +		    scrub_rate_to_set > max_supp_scrub_rate) {
> +			dev_warn(ras2_ctx->dev,
> +				 "patrol scrub rate to set is out of the supported range\n");
> +			dev_warn(ras2_ctx->dev,
> +				 "min_supp_scrub_rate=%d max_supp_scrub_rate=%d\n",
> +				 min_supp_scrub_rate, max_supp_scrub_rate);
> +			return -EINVAL;
> +		}
> +	} else {
> +		patrol_scrub_params->patrol_scrub_command = RAS2_STOP_PATROL_SCRUBBER;
> +	}
> +
> +	/* send command for enable/disable HW patrol scrub */
> +	ret = ras2_send_pcc_cmd(ras2_ctx, RAS2_PCC_CMD_EXEC);
> +	if (ret) {
> +		pr_err("%s: failed to enable/disable the HW patrol scrub\n", __func__);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ras2_enable_background_scrub(struct ras2_context *ras2_ctx, bool enable)
> +{
> +	int ret;
> +	struct acpi_ras2_shared_memory  __iomem *generic_comm_base;
> +	struct acpi_ras2_patrol_scrub_parameter __iomem *patrol_scrub_params;
> +
> +	if (!ras2_ctx || !ras2_ctx->pcc_comm_addr)
> +		return -EFAULT;
> +
> +	generic_comm_base = ras2_ctx->pcc_comm_addr;
> +	patrol_scrub_params = ras2_ctx->pcc_comm_addr + sizeof(*generic_comm_base);
> +
> +	guard(spinlock_irqsave)(&ras2_ctx->spinlock);
> +	generic_comm_base->set_capabilities[0] = RAS2_SUPPORT_HW_PARTOL_SCRUB;
> +	patrol_scrub_params->header.type = RAS2_TYPE_PATROL_SCRUB;

header.type should already be populated by firmware. Is assigning it
here necessary?
> +	patrol_scrub_params->patrol_scrub_command = RAS2_START_PATROL_SCRUBBER;
> +
> +	patrol_scrub_params->scrub_params_in &= ~RAS2_PATROL_SCRUB_EN_BACKGROUND;
> +	patrol_scrub_params->scrub_params_in |= FIELD_PREP(RAS2_PATROL_SCRUB_EN_BACKGROUND,
> +							   enable);
> +
> +	/* send command for enable/disable HW patrol scrub */
> +	ret = ras2_send_pcc_cmd(ras2_ctx, RAS2_PCC_CMD_EXEC);
> +	if (ret) {
> +		dev_err(ras2_ctx->dev,
> +			"%s: failed to enable/disable background patrol scrubbing\n",
> +			__func__);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +static int ras2_set_patrol_scrub_params(struct ras2_context *ras2_ctx,
> +					struct ras2_scrub_params *params, u8 param_type)
> +{
> +	struct acpi_ras2_shared_memory  __iomem *generic_comm_base;
> +	struct acpi_ras2_patrol_scrub_parameter __iomem *patrol_scrub_params;
> +
> +	if (!ras2_ctx || !ras2_ctx->pcc_comm_addr)
> +		return -EFAULT;
> +
> +	generic_comm_base = ras2_ctx->pcc_comm_addr;
> +	patrol_scrub_params = ras2_ctx->pcc_comm_addr + sizeof(*generic_comm_base);
> +
> +	guard(spinlock_irqsave)(&ras2_ctx->spinlock);
> +	patrol_scrub_params->header.type = RAS2_TYPE_PATROL_SCRUB;
> +	if (param_type == RAS2_MEM_SCRUB_PARAM_ADDR_BASE && params->addr_base) {
> +		patrol_scrub_params->requested_address_range[0] = params->addr_base;
> +	} else if (param_type == RAS2_MEM_SCRUB_PARAM_ADDR_SIZE && params->addr_size) {
> +		patrol_scrub_params->requested_address_range[1] = params->addr_size;
> +	} else if (param_type == RAS2_MEM_SCRUB_PARAM_RATE) {
> +		patrol_scrub_params->scrub_params_in &= ~RAS2_PATROL_SCRUB_RATE_IN_MASK;
> +		patrol_scrub_params->scrub_params_in |= FIELD_PREP(RAS2_PATROL_SCRUB_RATE_IN_MASK,
> +								   params->rate);
> +	} else {
> +		dev_err(ras2_ctx->dev, "Invalid patrol scrub parameter to set\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct ras2_hw_scrub_ops ras2_hw_ops = {
> +	.enable_scrub = ras2_enable_patrol_scrub,
> +	.enable_background_scrub = ras2_enable_background_scrub,
> +	.get_scrub_params = ras2_get_patrol_scrub_params,
> +	.set_scrub_params = ras2_set_patrol_scrub_params,
> +};
> +
> +static const struct scrub_ops ras2_scrub_ops = {
> +	.is_visible = ras2_hw_scrub_is_visible,
> +	.read = ras2_hw_scrub_read,
> +	.write = ras2_hw_scrub_write,
> +	.read_string = ras2_hw_scrub_read_strings,
> +};
> +
> +static DEFINE_IDA(ras2_ida);
> +
> +static void devm_ras2_release(void *ctx)
> +{
> +	struct ras2_context *ras2_ctx = ctx;
> +
> +	ida_free(&ras2_ida, ras2_ctx->id);
> +	ras2_unregister_pcc_channel(ras2_ctx);
> +}
> +
> +static int ras2_probe(struct platform_device *pdev)
> +{
> +	int ret, id;
> +	struct mbox_client *cl;
> +	struct device *hw_scrub_dev;
> +	struct ras2_context *ras2_ctx;
> +	char scrub_name[RAS2_MAX_NAME_LENGTH];
> +
> +	ras2_ctx = devm_kzalloc(&pdev->dev, sizeof(*ras2_ctx), GFP_KERNEL);
> +	if (!ras2_ctx)
> +		return -ENOMEM;
> +
> +	ras2_ctx->dev = &pdev->dev;
> +	ras2_ctx->ops = &ras2_hw_ops;
> +	spin_lock_init(&ras2_ctx->spinlock);
> +	platform_set_drvdata(pdev, ras2_ctx);
> +
> +	cl = &ras2_ctx->mbox_client;
> +	/* Request mailbox channel */
> +	cl->dev = &pdev->dev;
> +	cl->tx_done = ras2_tx_done;
> +	cl->knows_txdone = true;
> +	ras2_ctx->pcc_subspace_idx = *((int *)pdev->dev.platform_data);
> +	dev_dbg(&pdev->dev, "pcc-subspace-id=%d\n", ras2_ctx->pcc_subspace_idx);
> +	ret = ras2_register_pcc_channel(ras2_ctx);

In our enabling activities, we have found a challenge here.
Our hardware has a single PCC channel corresponding to a single
platform-wide scrub interface. This driver, following the ACPI spec,
will create a new scrub node for each NUMA node. However, for us,
this means that each scrub device will try to map the same PCC channel,
and this causes an error.
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(&pdev->dev, devm_ras2_release, ras2_ctx);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ras2_is_patrol_scrub_support(ras2_ctx)) {
> +		id = ida_alloc(&ras2_ida, GFP_KERNEL);
> +		if (id < 0)
> +			return id;
> +		ras2_ctx->id = id;
> +		snprintf(scrub_name, sizeof(scrub_name), "%s%d", RAS2_SCRUB, id);
> +		dev_set_name(&pdev->dev, RAS2_ID_FORMAT, id);
> +		hw_scrub_dev = devm_scrub_device_register(&pdev->dev, scrub_name,
> +							  ras2_ctx, &ras2_scrub_ops,
> +							  0, NULL);
> +		if (PTR_ERR_OR_ZERO(hw_scrub_dev))
> +			return PTR_ERR_OR_ZERO(hw_scrub_dev);
> +	}
> +	ras2_ctx->scrub_dev = hw_scrub_dev;
> +
> +	return 0;
> +}










