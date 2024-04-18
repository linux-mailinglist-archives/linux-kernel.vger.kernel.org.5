Return-Path: <linux-kernel+bounces-150545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DAB8AA0C9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225B21F21826
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4FC171E45;
	Thu, 18 Apr 2024 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z8TvCLUm"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA5515FA72
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 17:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713460146; cv=fail; b=oWMxoh+L3aqSBPhRITX4Ga0OYHD8O8OWwiynyFVqYlfEMXFgQlB4L5sTbZdhVq2zADCbIL1999hnowu+YGuq45urnaB+E51uv5pB1Qlbkine3yQjDqCEyW40gpg7iPXTSs+OiqH7RcAn/Mb4i3C/9zxy2ki/xaRKioW0jNN/sQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713460146; c=relaxed/simple;
	bh=U9YJXhpJs3K06hYqUD9P1wgq/Ymb6O2ydNNDpe3hf+M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UYnFDJoU+fScW/4yTK59miK20vOCHUS2PnzhQ8lW1S/+cxABpbOmlOO217iGlb1psl86IB7jGvqHH4ZjfvVTUaGIJtYDycrvCbZq8kJqtQAr1NjtYajJ51D1/o4zXtA1KnIQlezVs0RiEydyJBjUQq3jg7vqIzb6fcrSrfo1m3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z8TvCLUm; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a63UxrcN0BrDYo9n8gtulHbH27zEBbMWsQKXsMdzfqAF9/fx7DIy8a7MkhqH3uPnNw7CZgBdPvxwpidG7wEjnoZ8/fQHrPIaHGyuXvY2JWp0yuhTgJwo/Uo2RDqzTwz4EBqiH5EMPuRNkNhJzI5rTlyoP3j/oT88QbwdFz7JAWsbkQq/LMsaQFGOaaSRLhbBEjZoxnByLbG8AemnDN9G21rckBrjpdUVQwW8ZXuo12zFPN+53dgLe+iHOR7NWOkq5rqio2HnvgaGczKR5FFAWq1rHS+fB3e7mUwOwPcZNavTf8XDY9AvV5RKiIYalY4ZuiIOLOJ900LEGBQC/eDxKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/QetJiw/8SoyJg6B0Z4xsnDRavo0zW5d3jguSlEyo0=;
 b=Cf3E6t+Vkd5+7oBGzLUl0Yd5NtwLqooB2eUDC/Jt7sNq2dO+ItsUfTLKHuZi+m9nMmTvZ5jJk9VknyEYT3RbVsqya6GVWQUAUGI/OZlCPT3vWAhYY3xWKzAliojGBV3a01XYf7RAVUn9VjPecTNVklQNAOMrZeTTKhKmr8Aat5Pk7gDs4lyWhakuZ3q3rYhCJM3UtFX9jsmC/AhozhCMNniIDRbeUeDio2ESKmvG4iX0g2Kr9fzQp9kGGr9p5oQn6ulAE3UnPsvuGILmUWEAKTtGEMBSjQCWorxMKk+zZ9SvvM25sPyzZe+Eue7Yl0E8LybnSzU4dpgvL1RTnmKqRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/QetJiw/8SoyJg6B0Z4xsnDRavo0zW5d3jguSlEyo0=;
 b=Z8TvCLUm/6GNJavI+aP3gm4hgcJX+PDukv68ZA7CaIG0wkpbU+1HkbBrKOKGkwYGZl8G9U6xyWFV3FdIBSv48aHvammKPtBYpnWEkO/4qoUU1dnt3TlPX3cbWGz72NoDS5dflcbGUyGMrapCmekMm5GcRSsIYjH8uMjKx84DprA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.41; Thu, 18 Apr
 2024 17:09:01 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::494b:99e2:884a:dca1]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::494b:99e2:884a:dca1%3]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 17:09:01 +0000
Message-ID: <c2c9e554-7a2c-ebbd-ab4b-659737caab92@amd.com>
Date: Thu, 18 Apr 2024 22:38:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
Content-Language: en-US
To: Mike Galbraith <efault@gmx.de>, Peter Zijlstra <peterz@infradead.org>,
 mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 linux-kernel@vger.kernel.org
Cc: wuyun.abel@bytedance.com, tglx@linutronix.de,
 Chen Yu <yu.c.chen@intel.com>, Oliver Sang <oliver.sang@intel.com>
References: <20240405102754.435410987@infradead.org>
 <20240405110010.631664251@infradead.org>
 <557be85d-e1c1-0835-eebd-f76e32456179@amd.com>
 <ec6f811b9977eeef1b3f1b3fb951fda066fd95f5.camel@gmx.de>
 <14330cf4-8d9e-1e55-7717-653b800e5cee@amd.com>
 <747627a1414f1f33d0c237f555494149d6937800.camel@gmx.de>
 <2b9f7617f2b2130bb6270504ec3858f15d463f1d.camel@gmx.de>
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <2b9f7617f2b2130bb6270504ec3858f15d463f1d.camel@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0164.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::6) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|PH0PR12MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: c68badf7-3126-49fe-432e-08dc5fca3df1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVE4Y3BoSytSNkFjT05EU2MxMm5CSnhzL2szR2Nsd2lMRyt0NDhpa0xvVnJl?=
 =?utf-8?B?SXhkV2pMbnJVNmg4ZlFQN1ZGeTlwVmdEb043OXkrUWlLYnhNTmg4V1RsWmVz?=
 =?utf-8?B?YU5LYkdoYU9iNVFSdHhUeVF6MmhBRy9pVmZwaUJmL2FEVFZzQnJPMjN5b2xk?=
 =?utf-8?B?djRBbTR2OFJzVmVvejdKWVduWTBtR2o5bU95QmJscVNmUGRYT2xRc0s2VTlq?=
 =?utf-8?B?U2NuZzhNdUJIejR5enhRNFZrWmM1RklJWWZScGNFRmdpT3V6SVZNWGhTdkIr?=
 =?utf-8?B?MnRROWJJR3grY2lMK05WOHAvMUdtdXh0b3o2MGRUSkl4TEF6OU5NMnV4RzZO?=
 =?utf-8?B?YytFR3hXNHpoR0VSWTlzZ2dKYXIrWXI4Sk9CMURXbXJ1T2NZUjV0dHJtajZn?=
 =?utf-8?B?NXVEdW9KSjB2U0ptNkJjZC9ucXFTV1BjT01aTENDem1SMCtZaGpwcDlRWE1y?=
 =?utf-8?B?aHErZDJWTGxCY2VIQk1qTkdBNDhkclppbUZQM3lLdS82TVU4RHZxNzVUcnVx?=
 =?utf-8?B?b01MWlpvdXc4TDh2TmRPYWc4TC82alYvYTJCVVJUcFRYZlRHRTJYb25oTENV?=
 =?utf-8?B?THlrR3JKc082aHdqaUtrcldtdjhsT2tQWjBvUHgzSWtIWWJUdlBYMHdVZWhy?=
 =?utf-8?B?bEVYTU5BVlh4OE5iRFFpZlBURnRHU3cwdW0yMCtHSTdRMjFoSWpZbVNLeWY5?=
 =?utf-8?B?SzJqYllETy9ocW1IOVBYSDd4UXRXdEQ1UENwTzNDNVhSRmc0OS9RYnlWTkFv?=
 =?utf-8?B?UDNrWXVUV0hPUTVqb0h5R0NMQnV1QTNtaWRzeG56dUZEejZFMTBsY3MwRWpM?=
 =?utf-8?B?YW9XdS9hdTh1cjhyQ29lMDZIME9zODl2dDZvVnRRWFBTZlRBOVg2c2dXdGlT?=
 =?utf-8?B?MmZFL2lJQUpSMmtzSFNxWlo2bFBJU0ZIbVpPRHRkRXpDNTJaZU9DVnJDSk5W?=
 =?utf-8?B?aFBubW9DdG85TFJFTHA4c1hBMjViTEx4dWwyd1o0Nm85WWVXL2kwSHdhbW5y?=
 =?utf-8?B?ZjNLUklRY2lqbG5ZZWM2UDI2dFJrRG9FSmZDNHNKN3BFZUlzTGgzYm8yNU1W?=
 =?utf-8?B?bm8wNFRpUzBCNmtjc2RQSnVaWHlhaTZXa3dKclVyY1FQaDdQdklmYzUvNkM1?=
 =?utf-8?B?UEdndDRpaWFWWXNtNFFlLzEwMm1kcktEV3JTZVhoZzIzZWUranBOeFFZdVFt?=
 =?utf-8?B?cks1YjdUODB6bVpCR09xaTRXZGx4NXBNazhTa1M4cU9NWEQwS05ZVHJwQlZv?=
 =?utf-8?B?U0ZGVWZVZVBTMXp2V0Z1TWxYenFDem9ST095WitVbmdMaXJZaXN6TURTaFB6?=
 =?utf-8?B?WVV4QS9VWVgvemxoNUdZU3VsR1V1UlZWdUpiVDdFSXo1WGJkNjEvZUJKTnRH?=
 =?utf-8?B?bXhPT01OQnhjSE9Rczk1a2cvTVAvdTRCRlYvVFZqNXJiMlZNZDIwWHdnNm1x?=
 =?utf-8?B?S0cwTXFjRmhESXNsTXN3TVIzUW4xWEhnOGNTVHAvUElWNkNXd3BlYTNpMWJq?=
 =?utf-8?B?VmhSV0tuNzZtTU9NSS9NZnVmNGQ2VTJ2STZSUEl3RldXMW9nTG1vZFFVZ09L?=
 =?utf-8?B?aWpTSjV0S1p0b1VNcElCYmMyUFo2K1hCaS9yRmlhSCtjeHFTVlZqOWNHNUcr?=
 =?utf-8?B?YnFsQ3dTbXorRitpNFRhNS9YcEhYcGw4eXJwQklwaUNva3huWWI3VTM2SCtF?=
 =?utf-8?B?VmdVMDRPb0drTHlycXNhRkcvTEdaN2krOWZRR2Jwd3hFcDFBTjZWWDNra1Vi?=
 =?utf-8?Q?AXEI8MkYn3cYVsXux5y4wnzGIkucda+di6gZ3ui?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTZDVDAwVkpSSEthWkRhWG1RNjNHN2ovajFhUkZxT29IK0VlRUkvSjhvZDlk?=
 =?utf-8?B?YkZVREFaY2I0NTJlQkp5Sm1YeW0raE5jaWpLL3pUVC9tOWUxSzd0YnpkelhL?=
 =?utf-8?B?b05uNmxaQlAxaHU5R0JhZjI1QXY3azhPQ0pLUzdKMENkRitmZy9BWjV3S0JP?=
 =?utf-8?B?T3NWQ0cwY1VUS1gvOUU4ZFNaM0p0NVVpbXRyblB5OWlTdENsaExXT0F2QmM4?=
 =?utf-8?B?dHZXQm1EaFE1ak0vWXBIaWhOanY0L01kNTkyalRYN0FQTm9PRUQ5UEJUWjJD?=
 =?utf-8?B?VVNMazd1MGw2eEFWMXhtdzZqRU5FUlBpRHdic0JtcHBTL1BleGNibitabnFx?=
 =?utf-8?B?Wms3VHI1TFhSNXlDQ1dGT3F3K0FXV3pBbDVhaWRxN0JFVHhKWS96L1dQQm9Q?=
 =?utf-8?B?MzAwV2pZVFVlWFNXQTFxcDJlTmpHc3c3Sm1pZHNlMXp2ZmFORFBmRW0wZmhQ?=
 =?utf-8?B?a3VWN0VyOWNrdjRHdElUejBPUDFiU0RuNzJ6SWZyYVBOQVRJakxEa2xxTHVS?=
 =?utf-8?B?N0ZKTnI5b0xHZUQrUUZhZVdlc00xL2VEK3h5RkxDb1BEeHFSeWdHSnBuKzJJ?=
 =?utf-8?B?VGZEOGlaaURXcVNTdFd4TzJJTG83OXFIZ2pLak0wdDVoeDRpNW1PWEdZcG9t?=
 =?utf-8?B?Mm9GQVMwTG5qenNiTzc5UkxHUHVNZkM5YWFhQXVLT09XMXY3YTZxeHZidGxv?=
 =?utf-8?B?WVpmS2JJUGYrMERhc1pKcHIwTGdhSzh6bnE3S2xhdjNld2ZSeW1SRWhSYWtL?=
 =?utf-8?B?MjdFWWxVZmlScmlrRW5mUmJsejVXVFdkMTNGR0NjK1RYVE4rK2h0Sm1XQm1w?=
 =?utf-8?B?czNyd2VodUxzeHJ0ei9OendMMVVRQTErVkhRY2pzdFNnYnNFYjc1RnZ0bVV5?=
 =?utf-8?B?QUFNNlFtS0pTQ3JGTEh6U2R5TDZUOVdhL1BES3prNmZjV21GdkdWbURLM2x5?=
 =?utf-8?B?TkltQjAxL1ptSUZoNDBjWjQ0dnk4Ui9kay8xM0VxcHJXUFF6bndRN3MyOHZv?=
 =?utf-8?B?d01rY3JNRVlmN2VqNmRWYVRiemY3M2crTG90WU9YbUxTdUxPYVJWd2xQTUNh?=
 =?utf-8?B?SDhqZlBnTHVRSjJVR1dEUlVYSFNnVGxPZllLcTNZOTBoYjlpL2UvUDZtZVht?=
 =?utf-8?B?cDlWZE05dG5aY1l3RnVIWjdPQkZtV2hrYTc1SUxydnFCU1c1T2RGOWVaeG1M?=
 =?utf-8?B?L2lqOFJ6V1BCUlg2QkFHQmdjc2t3MWFUUTM4MTQyNVFoLzJ3TXZjYnVWQUlV?=
 =?utf-8?B?dWVCRWtycmQzT0M5SG5kcFBlOGJCV21wZUlGakJtUEpIZUpLQnJ0QVRZZFAw?=
 =?utf-8?B?ZUFTSStEdUkwUytjWDEwVEhUdUV6QmpBdEwxM2FiVzBDaDJub0thWERqaHV5?=
 =?utf-8?B?YysyZFVidlpYKzRReGlRQW90SUttWGZCWHVyRENSL3VqYXpadmNpWVB6VmhR?=
 =?utf-8?B?T05SL1hiczNaYm16S2oyUUErSG5qYjg5OWduWitab2prZGtmV3ZOMFlUTVEy?=
 =?utf-8?B?dVUxb29IYlE3Wll6aldVVTBqQUpsc3BsQk1LZnY4U3VoMkFKSXQ5aFZqUG5v?=
 =?utf-8?B?UFg1Y1BISTBLYkM3NW1XcFhSUkVhVFV4YjZBenRnbjcvNVpLbEpaS0tKM21h?=
 =?utf-8?B?YW1qaEtCM1JuZEtkTkVwSElzekltajd3UG5Oc1U2RERwRER4cnZlNWJzckcy?=
 =?utf-8?B?VWF1T3NoVkVBUFIzelBVTHFhUGhHR0JJbkJWYjlxbkJ5M1pRNnlsSTMwUGs3?=
 =?utf-8?B?UmhLbmlUek5XazlRYzh6anFxQ3ZnT2JScUVaczlveDhzTGpvTnhXcE1PNTlv?=
 =?utf-8?B?NDBIQllmY3JDU1pCTmJQZWs5MGhRQUk4TDIwS3lTaWh2SEFBNTg5R1N6Zktu?=
 =?utf-8?B?ZS9Jc3hBdGF4V3FUSktUL1Awb3ZmQ1E5ZmY5ZENuejJrVTlxUlBrbnE2QWdu?=
 =?utf-8?B?UUNIRGRRSXg4RGdKZG55WldObjJyeDdFQnVqM0N6SFVSby9YSjNnY0ZyTEZO?=
 =?utf-8?B?UUVheVowejYra3ZRUzAzTkhOU28vOEtOY0xSSFQ0SnNLWFN6WmxhY0NmNFN2?=
 =?utf-8?B?WStMQmJCR0dlR3duV3NONm1oU2wvUVhkS21ZMC9jUFQrcllNdmFrVGRFZDNI?=
 =?utf-8?Q?xleZy6kinOGDSJY7HW1HS3A1e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c68badf7-3126-49fe-432e-08dc5fca3df1
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 17:09:01.0595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IpTM9Ty3a/IZhmLfOjzFXzoCDHNIv8PUbNzUoxF66jF/xKQOw6wsC3wZvFOHkVRvhcLXZd6Y33s5E8Fxn7whaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5607

Hello Mike,

On 4/18/2024 9:54 PM, Mike Galbraith wrote:
> Greetings,
> 
> I tossed a couple rocks at it today, and seem to have hit the little
> bugger.  The root cause seems to be doing the delay dequeue business on
> exiting tasks.  Hunk #1 of hacklet below seems to quell the explosions.
> 
> crash> bt -sx
> PID: 21722    TASK: ffff88815710ee40  CPU: 6    COMMAND: "hackbench"
>  #0 [ffff88822773bb90] machine_kexec+0x156 at ffffffff810642d6
>  #1 [ffff88822773bbe0] __crash_kexec+0xd7 at ffffffff81152a07
>  #2 [ffff88822773bc98] crash_kexec+0x23 at ffffffff81152eb3
>  #3 [ffff88822773bca8] oops_end+0xbe at ffffffff810329be
>  #4 [ffff88822773bcc8] page_fault_oops+0x81 at ffffffff81071951
>  #5 [ffff88822773bd28] exc_page_fault+0x62 at ffffffff8194e9e2
>  #6 [ffff88822773bd50] asm_exc_page_fault+0x22 at ffffffff81a00ba2
>     [exception RIP: pick_next_task_fair+178]
>     RIP: ffffffff810d8d12  RSP: ffff88822773be00  RFLAGS: 00010006
>     RAX: ffff88813cb780b8  RBX: ffff88840edb0e80  RCX: 0000000000000000
>     RDX: 0000000000000000  RSI: ffff88813cb78080  RDI: ffff88840ec30f00
>     RBP: ffff88813cb78000   R8: ffff88815710eec0   R9: 0000000000000001
>     R10: ffff88822773bdc8  R11: 0000000000000013  R12: 0000000000030e80
>     R13: ffff88815710ee40  R14: ffff88813cb78080  R15: ffff88815710ee40
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>  #7 [ffff88822773be28] __schedule+0x10d at ffffffff8195865d
>  #8 [ffff88822773be98] do_task_dead+0x3e at ffffffff810cc00e
>  #9 [ffff88822773beb0] do_exit+0x770 at ffffffff8108f0e0
> #10 [ffff88822773bf00] do_group_exit+0x2c at ffffffff8108f64c
> #11 [ffff88822773bf28] __x64_sys_exit_group+0x14 at ffffffff8108f6f4
> #12 [ffff88822773bf30] do_syscall_64+0x57 at ffffffff8194ac37
> #13 [ffff88822773bf50] entry_SYSCALL_64_after_hwframe+0x76 at ffffffff81a0012b
>     RIP: 00007f4f2aa76136  RSP: 00007ffcbba84748  RFLAGS: 00000246
>     RAX: ffffffffffffffda  RBX: 0000000000000000  RCX: 00007f4f2aa76136
>     RDX: 0000000000000000  RSI: 000000000000003c  RDI: 0000000000000000
>     RBP: 00007f4f2ab86970   R8: 00000000000000e7   R9: ffffffffffffff80
>     R10: 0000000000000004  R11: 0000000000000246  R12: 00007f4f2ab86970
>     R13: 0000000000000001  R14: 00007f4f2ab8a328  R15: 0000000000000000
>     ORIG_RAX: 00000000000000e7  CS: 0033  SS: 002b
> crash> task_struct ffff88815710ee40 | grep sched_delayed
>     sched_delayed = 1 '\001',
> crash>
> 

My machine too survived the spawn test with the below patch. Thank you
for looking into this. I'll resume testing with the below patch
included.

--
Thanks and Regards,
Prateek

> ---
>  kernel/sched/fair.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5374,6 +5374,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
>  		update_curr(cfs_rq);
> 
>  		if (sched_feat(DELAY_DEQUEUE) && sleep &&
> +		    !(entity_is_task(se) && (task_of(se)->flags & PF_EXITING)) &&
>  		    !entity_eligible(cfs_rq, se)) {
>  			if (cfs_rq->next == se)
>  				cfs_rq->next = NULL;
> @@ -5495,14 +5496,14 @@ pick_next_entity(struct rq *rq, struct c
>  	}
> 
>  	struct sched_entity *se = pick_eevdf(cfs_rq);
> -	if (se->sched_delayed) {
> +	while (se && se->sched_delayed) {
>  		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
>  		SCHED_WARN_ON(se->sched_delayed);
>  		SCHED_WARN_ON(se->on_rq);
>  		if (sched_feat(DELAY_ZERO) && se->vlag > 0)
>  			se->vlag = 0;
> 
> -		return NULL;
> +		se = pick_eevdf(cfs_rq);
>  	}
>  	return se;
>  }
> 


