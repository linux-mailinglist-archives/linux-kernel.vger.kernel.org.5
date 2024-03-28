Return-Path: <linux-kernel+bounces-123832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD59890E9D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45961F241E1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373581386A4;
	Thu, 28 Mar 2024 23:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="M7SzFza5"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2132.outbound.protection.outlook.com [40.107.244.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F5A31A89;
	Thu, 28 Mar 2024 23:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711669268; cv=fail; b=RGnFmKvZN7P9y+YhCnq2IcBkx3DCvXKBMJFUq9c+DS7T2TnB0CLJq9CJL7we8xj25u5fYaoUIzaIvgU9c5rGGvyDXvfgJZjmA0QhwC8jKDcVKfiwC5/t829D1nMWJS7K9O1KjOjaJbz+3yDtHXKjBs9jTh92YbA3QUZgLpnRzKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711669268; c=relaxed/simple;
	bh=M42AXlrYoWZPlZrmnTbyWvcvUcF3z2XTxddrFK8UFMc=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LttwwYSbhVfTmSrx3ut5y6ow4W78/A9t9KOpYqhHRPTcyWhwhqcYk6d1UYRAIdUco89KFaOULfyjj6IKb9HksB83PNqAJno3rrYOLR4pby1esm0sqWiAHfNNbVJLnzo3wS8QK2S2yft+aJKz9Bp6yB1L0tKXw8R7lTigpcDolwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=M7SzFza5; arc=fail smtp.client-ip=40.107.244.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKcXWm9PFUczcLxegPJlv/4ny4H64FxAAvLdSs6hMo7f+Bcc1zKUIk/9Zdqgut6sQtSobqq8quqpYx6NDDpOmsqMcARWAPZEU2GIdHQ213NTjwpdg+6aTTZ+V6IaulSqoWsoKAYYPJV92MvbkeKYHX3+L749Hoa7s2g5N4Rq0u9drJyDruy6SKdhhUfLjAVGDsXR69tEnPecqAyfNWAWGq3jOfyENeMe2Yq/yOY0oHMCoTzMq8OWxJhKykJtsD3Yzvq+I8lcGleHMWJ2Dcvrqd02w3tiY7e+1ZVSLWzA9uT7IhCED0/naJq38A5sEW6rkGQMMaftNDzZ2TPvTcvKxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifdDr9Pm/vCS2faiLvXwMKlUrOVmpwk2L+9S97LuZOM=;
 b=NWdJpqnJeH82XsnIXR4gGIpo9uESKFF8+o4SDzXL4plppw/Ofe8grYND+I+s3ptKd0QglGAwDrvKLU5R9/WIyMKOKzOKcI9UxEwIFV7g9MZbjlf390UrdrGZ4byEnWsRIdIs6qZYnJQC2mTCYX3uts7+5OHee/HO/b2zMIeeldGNdVb6f4OuOXwp3SI8qRo9BfLxxS/veJgM3nKiTEzfEgliCNYGvGzIR4Oy60bujnyDfQntkws/txNrBo0XEX4AdJ0tNS5mbI1vdt8CF8SkSB8mvvTDgM+0WdJGnxAOl+fCu7KZm3yX7VRwLNRIfyoEa64ne0KqEpD21ROUxGu2bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifdDr9Pm/vCS2faiLvXwMKlUrOVmpwk2L+9S97LuZOM=;
 b=M7SzFza50WnPNBBysi9LJAgYUVwUNygpELCwoWjMnEB04JzoF85Q1bsVJFPw4GTrPn7TU21DcXF2OzpKYFYfgIeT377W+sSBLXEQ87q0ldJQ8QUUMUvif0eIe4ivUrrFKiKUpaxkqSYtKrkU/ifaclaAAQvC+sygfU9JH5T2jHU=
Received: from CO1PR01MB7370.prod.exchangelabs.com (2603:10b6:303:159::16) by
 SA1PR01MB8180.prod.exchangelabs.com (2603:10b6:806:339::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.33; Thu, 28 Mar 2024 23:41:03 +0000
Received: from CO1PR01MB7370.prod.exchangelabs.com
 ([fe80::994c:4200:8a4b:6882]) by CO1PR01MB7370.prod.exchangelabs.com
 ([fe80::994c:4200:8a4b:6882%6]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 23:41:03 +0000
Message-ID: <3fa20038-347f-48c3-814c-0dc1ed109244@os.amperecomputing.com>
Date: Thu, 28 Mar 2024 16:40:58 -0700
User-Agent: Mozilla Thunderbird
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Subject: Re: [RFC PATCH v7 10/12] ACPI:RAS2: Add common library for RAS2 PCC
 interfaces
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
 <20240223143723.1574-11-shiju.jose@huawei.com>
Content-Language: en-US
In-Reply-To: <20240223143723.1574-11-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:610:e4::6) To CO1PR01MB7370.prod.exchangelabs.com
 (2603:10b6:303:159::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR01MB7370:EE_|SA1PR01MB8180:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x9U8wRyPi+zxslJVSyV/8r7cszUcc9hmYG8s2UXPgYz9wK+G8KIosxFpHeZATJCPEWDQderhmH4/RBvi+Np2BKebfpDFe8xrnfJDoOzVj/cWJQcnoraIOBnGvQ2TE3eWnbfp0kN04ArsliTD0/S7YEbSSeZiqfa0f1CI+YUPqlUE1E+Oa+lBCu5xPwWTDq/1H6SpCiFouGe/ATzK7rLSQw3uT6N/Mv7loi0bm6BqzKnhfhH6pKJ9wuwSDSPvdndlvp37+qPjErkcOXnxlC+SqVkXB5o5Ate1VsYdKA/xpyDijrsa2bj591KyrufIXsF7VhzEAbEmaFQ6i6l6H+FqU/XNEAF7iNMkI4A0NisOqTFQawzZjaZ8KsHm50uA5qwqUh8mWtTCjbRrFzm1S+LFps4Tgg06x4xmQGKAFopr4rFFUqfcMYNIDe0lf1i+gipJQ4/xmEUQNnotx/pZMaF0OUJf+eFW6fdUrD0gRzPLT+VyB0USj59IaEmX+t1iB6SMmvBwphfpBzALFL2FXNn3d2t3xVzHJbB6d+9K2xv6ozroryHz7IXEPbdnhcI+lmGDLhCMfPD6sG3LIfzSJxxaJQ+3deXipPEj+AkSw7+NbeEWxGWUrKdxmnPmgel/OH4xW9Q8tzjyYySQTYr4JKEeFrGJd3LYl8O/ra4+5g+CMYopVeyc7FfcjdNnQ2fqQ2DB1LnI2emzzDIYJGeTkAN84YoMLA1aONLGtUm9sLoOD4Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR01MB7370.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(52116005)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1ZPQmF3ZU9LVkdiZ3U2bmcraFZNeDZoWHhwVjFpZWp1WldyZWlTTktibUVy?=
 =?utf-8?B?VERqVGsvMEJ6V1JwVzNpSG04c0JmL0oxUXE2RDhxOHFSWFdvUjlnbXQ5SCto?=
 =?utf-8?B?bHBjOUtxMzBBTlI0ZlRqZUIzOTdVem5rcTNETU5zaFJQVEtvL2FySHJNeUMr?=
 =?utf-8?B?QTVhUlFlZnA0TVVjTGhiejFuUFNwS2NoYkRKb1V3MHpFUlZ2K1NqZzE5WllS?=
 =?utf-8?B?aXI3ZG94b28rTTF5MHdrZEVDT0lSQ2JJd0RLL2RoNTJBOG1jUXNKV1NLYWla?=
 =?utf-8?B?M01OUUxiRFY5L2VxWHdJbkpSdzZNU3kyaTZRNU1OWHd2dU43MXREZy83bGoz?=
 =?utf-8?B?U0g5OVM5NC9DSnZzT00vNzVZTFBiTVVMNzZreHZIUVB4OXVhZVNHU0dsZW9J?=
 =?utf-8?B?WFNvM3VmWW5ZMmQrYmhLVm0ycTh1c0tmN1YxRHYwL1BtM3hSRW1ESmZTZHdC?=
 =?utf-8?B?d1ZWb3c4L1A5Y3JMUE10ZGJiZm5sa2R2QVZHYm04NUdMVnUrckNIUjVNTk1i?=
 =?utf-8?B?Y0RLSHcxV0xKemhoN3FyN0taeFZ4VFp6eUxpTnhTNTVNT0IwN3lvVE5GTDk4?=
 =?utf-8?B?T2hOUnBkTVdtUVpUVG5Dend4OFRBdTFiK3dhTmNkU3VydWs0SnpUZDFZRzFD?=
 =?utf-8?B?WjhXbE9hUnRLelF3Ry9TWkxlTFJaSHZhdWNQT3VldGJEL21jN2VKOEI5RGs0?=
 =?utf-8?B?Ry85eUc5U01DUjI5SjV2VlVKMWt0SFErLzNNYy9sWC9rRXJZREVPdFRsWjZj?=
 =?utf-8?B?NGhkRHBNeW8ybmxMQ29qcEMwK1RzQTZvT1Z6T1E0QnIrbVlNQTBvWkpxZVJR?=
 =?utf-8?B?aVVseW4wUkdma082VzNtNkh1YzdvUWIxMldjb3ExSGRpUmQ0RDBqeGxmdTZU?=
 =?utf-8?B?OG5zSndJSmpwT1dEV0N0ZitNaUtQaEtEckQ4aTdodnY4S2x0d3J2Zis3V2lr?=
 =?utf-8?B?VWxqUWwwQTZTZWFUamQ4N25iUVNPL3l3TEZDREo4NVhwZ3pnRnlzTmpya1gy?=
 =?utf-8?B?TmIrYjJQSWQrTE1lNHRxamNGZzFKSk85K1NUL0hFVDBtNVl2V2xpUjUwQlB3?=
 =?utf-8?B?cTdwQzBCOUd2aGk1ZENzNmRiWWFEVTVwd1o4RmJLaGRDRDZrdmVXV1BYK3d4?=
 =?utf-8?B?MzVBZGtTSHdUM2h1NkNqVjhJRkJYdTJRK1FxcGpkcDNOSnU5ZDd1UHJWeWRo?=
 =?utf-8?B?dENURkQzV1B5R2tyTVZyNm5RRE5zb2dUek1TR29BZ2tFSm0wdEQxMkEvd21l?=
 =?utf-8?B?Qm5RZjBTOS93aTlIbHRwb2MrY2VPb1liWWdxMVdQcFlvOStEQkVOYzE5UTJ4?=
 =?utf-8?B?dFZoVEc0NjZkNmRWTGROWUNPMU05WHg1QXFOcm5WL0VGMElNQUdZbnlHZ0ll?=
 =?utf-8?B?SjlyNzRZN3VVYXcyMGxTVm9LRk52bktSUmcrZWs1dGdDVGRXZzFUNkZTdHFG?=
 =?utf-8?B?RHAyT0FKcmpXaEtQL3dma3ZsNXc1UEF6RjZqR0FxdkZqbWVTd0FTYUZSRWJB?=
 =?utf-8?B?REFrLzFUWWJMOERnOThhR0lsTmNGWWd1NE9WL0ZpNkJRVDlhYllLM1VXbEJj?=
 =?utf-8?B?cXdMWlFPZHpkRWhNUVBadmNabVU0eDJxckx5cHJwWWZKRUtBZEl1TUhpVmlL?=
 =?utf-8?B?aWpicStBcmo4TE5UQTQrRFh5dEtDNWo5bURQa2ZOR21zZFhwYkNuQllneDVQ?=
 =?utf-8?B?N1RmVU9pS3ZCQTBjaUMwZU9pemJ4aUtic1JTazFWN1JoY2JlRzBhK2NDQjNN?=
 =?utf-8?B?b2N1d2kzU2l2dlZacHZ2eVpRVFpSdnlMS0Uza1Z2WkNpbEdXOU1aL3JsL2Jy?=
 =?utf-8?B?SnZUYWF1UDgvczlEVUMvSGZ0bTR2OXpEdEN2a1BCMmVTNlNNZmZRd3RQY2xU?=
 =?utf-8?B?S0hUYm5CM1lpbGRFY3UyTmtQbGU0MUVnSWEyRWJQUFFIeFdic01zZzdvNHln?=
 =?utf-8?B?eFBwZGJBSUljci9wSkRPUTZQRDVvaGorVGh0MmlGdjV4U21XKy9PaVZUQXVS?=
 =?utf-8?B?ZnJDWVhMaWhtcWNMYmVFYktFaVBaOWsyQnQwVTZyWWFhZjM1aW16azFSaHEz?=
 =?utf-8?B?R0U5YnBMazRueUxiL0pyWXoyS3I5L2ZKc09TZUJnZUp5czFJRHJYZjlVNXVY?=
 =?utf-8?B?RmVrT2JiK0wwQWMramZYbDh2VVd4Szh0VGhtaldKdEVpcmNKRmJ2WGFyZFVr?=
 =?utf-8?Q?ScWHCD6mRsCMYLf8MKO9LAw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f6dbdc-47d1-423a-3a02-08dc4f8087cd
X-MS-Exchange-CrossTenant-AuthSource: CO1PR01MB7370.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 23:41:03.4497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UD5iQSivVZDHIqDm83n1MzCQAm1PXSlT/4mSH989GCOSZ9P43Udlt7KUfR+6Ed+Da9mduu6dVnGL9JOb6uK1DEIgTv0Z9UByPXxHEjBa7vtuxcAfhfizAsvHBOxqKI8s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB8180

> +static int ras2_check_pcc_chan(struct ras2_context *ras2_ctx)
> +{
> +	struct acpi_ras2_shared_memory  __iomem *generic_comm_base = ras2_ctx->pcc_comm_addr;
> +	ktime_t next_deadline = ktime_add(ktime_get(), ras2_ctx->deadline);
> +
> +	while (!ktime_after(ktime_get(), next_deadline)) {
> +		/*
> +		 * As per ACPI spec, the PCC space wil be initialized by
> +		 * platform and should have set the command completion bit when
> +		 * PCC can be used by OSPM
> +		 */
> +		if (readw_relaxed(&generic_comm_base->status) & RAS2_PCC_CMD_COMPLETE)
> +			return 0;

We should consider adding error checking here. In a modification of this
driver in our enabling efforts, we are checking bit 2 in the status register
for errors. For example, in our FW, we will set bit 2 if you try to 
disable an
already disabled scrub.
> +		/*
> +		 * Reducing the bus traffic in case this loop takes longer than
> +		 * a few retries.
> +		 */
> +		udelay(10);
> +	}
> +
> +	return -EIO;
> +}














