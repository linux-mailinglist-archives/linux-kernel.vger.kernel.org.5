Return-Path: <linux-kernel+bounces-158235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6048F8B1D5B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C57DB25FB7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643B882D9D;
	Thu, 25 Apr 2024 09:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I+4wfCmm"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8ED81AA3;
	Thu, 25 Apr 2024 09:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714035838; cv=fail; b=TU8YdbLaUEPJqL6muZE9CD7eNTkWc3od0Gfi31NG4RR7fleCD4wJEAwPOBjc7Jo/Nqznu2zXhSWQMiu0cQeu9BTT8fCK8HiLNbX283vjNs+h1vrpb3sCgtzQGim4qI7DFZcELiKZy7EGZrJZmAZFDMR6kNbKLv98ug8P2XhqrYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714035838; c=relaxed/simple;
	bh=TA6ToJd+FM6JzrizNdFZ1yOu+D5za/5ipOyr8oL8cQI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ELkFnTFQjP5kUvGOg1rfru4gUpXac+lGNndrTojk9xlnUJfltusdmHN7HAE7Y445zylGfxqJz8WS7bvdDlu1N1nnKcJNdNKKlfDDMVUNjaCBCBW7mdxmTgAjvt49muYC5UWiLtABhBunF5w3f2qT50lgXgo3mI6Dpo/3mHy8Y2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I+4wfCmm; arc=fail smtp.client-ip=40.107.244.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmGV6fiwlLget/LYRk42edanXfCBmzc0Y6ag97D1Ao1rPgs1+3EJ53JmoSs0tkw76LigCj/fvOaur4UZwT3XOdgQEFgxArF4nZYOmGKFgxVmaDBE1qKrnqim/5R5xjjAT68JNeA9eTldpiez3Kz3TBg/GHRE7SVXjeBqmXUCmbeAh8M7i6/cQCZzteqYs4V2EFICxqVF101urURiNENsvSDo2m7nJhL/UVBfeX66I03PY7nu6ogSNMunXF7UwE/Ejy3obhqU3WIVZ7YyASoidamQJBBtdpWSxZfGFthSfABJUnaUYenqaNNRHu6ltTRkOYZQ1h+zBZ+frSL80xgWow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blD5HvApqe8oQVP/CfEZVObUUPARKMxaax8jIUsuXHU=;
 b=mxQi8xjW2uE2LV4ceE8egziqOLVEb6DdGRHYKBEGAWcPnHg3KeFK8makr+nsFkIgXnmSTBOeJ5JYfc9BggH0RKiOfFBD0ZvHsTtaFYPZZ35XXXZpAArAaqYb5TpgLJdt0zIA4530xGpoArpQXeyvbwVzUOXlKv2fMZdDAvW0YrV4iU8pmN3LpTFFaRTM2Xw3fXhznyapvoElinnJuUsP8hDghTbO5eDvIUE1xDR8rxl/WHSIDg3Dwq9AN4n+/CFtP5Bp8I1yxMAMKaZhqobwV2vFtBIN0t7Y9WCgBkKBtR+HN4nT7eTRuLpP9wh2MGDWsn/gYePIpKAm04eS/zYrJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blD5HvApqe8oQVP/CfEZVObUUPARKMxaax8jIUsuXHU=;
 b=I+4wfCmmRATRJ2SG1op50cxz5N4DLSIk10O/TUOJWH07OJLiDOb3BKpRKCNuYIDDm6jLhYYAGs1584HKkRuudAfT3+G0xL4tFbaJ0eIPrD2evnBBId/6VQgnzriwI8Ya0c/k1cHsKQBp1eqrvls7p3cOrc9xBiCLV/MBpJpfr+MacfF4e/EqfCYrphTFuurID+GH6AP65JZv1bpSXF+Eo63YIAcBz4FXwwe9yHheM0olV3mxNm+oE8LqlQBehjZF/gqZURTU7k2GFw4cNmjjACNpggStj+5wTYaPky852ThkKUfo078roVMtugLRnXkbOPNoGb4y3WfmpzWw3bGT/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CH3PR12MB9022.namprd12.prod.outlook.com (2603:10b6:610:171::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Thu, 25 Apr 2024 09:03:52 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3%5]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 09:03:52 +0000
Message-ID: <5309cda5-2629-4bff-be25-ee289373949f@nvidia.com>
Date: Thu, 25 Apr 2024 10:03:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 000/158] 6.8.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20240423213855.824778126@linuxfoundation.org>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240423213855.824778126@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0020.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::14) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CH3PR12MB9022:EE_
X-MS-Office365-Filtering-Correlation-Id: 58b5194d-9101-4fb6-db78-08dc6506a0dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjdwTTMybWZ2Q1ZNcjdkcStpZHV6c3lhbWlGSWMvZ2p1SjkvVVB6OEJuVTF3?=
 =?utf-8?B?MkNjRUN1eHNSSlhOMk5XK0VWQ0VhazVjeHRHa2pWTjNoZS9RZHZhbnlKTmJU?=
 =?utf-8?B?RmNValhhblpTWnoxWXZDQncvQjNrVEI5czRobFV3K1ZZYysvZXA1ZlVHOVBs?=
 =?utf-8?B?a1hYaEZLb2k2Y1RkbFVWL0oybEtDNUgvVFBhNDFRNkdWUEVxbGM4eWxXQmxp?=
 =?utf-8?B?ajRWSzRCRFZYMXZtem93RnFIL2d4eXJtVGhobGY1eUpNRndrcUg2d1R3ZFJz?=
 =?utf-8?B?OWg4YlI3ZUJiZnV3SHlwMjdGczhoZGIzV0k3T0VHdWNrSSsvbVJHQlhNRzlI?=
 =?utf-8?B?b3cwNXMvOFExZ2xTZi9uTXlHVFdjeEFieDZRRU8yL1ZzSkZWZTBUOGdSZUI0?=
 =?utf-8?B?cVJyUFE4MDRBK0tiSHdZWE5VbnBZZGNsUDcvMG9SN2Z6OUVhVUdTVG9BNzE1?=
 =?utf-8?B?bHJWU2krY2JEUzg3TDRwcjRTTVJpcjVrbGxrVEdLWTZ3K1VES3N3WWtUNHlv?=
 =?utf-8?B?eHJnQXVMNEE1WnJNOElReTYzQ05rRjc2eHNVV3FaRUV4eG80RVdqOGVHaUFE?=
 =?utf-8?B?Z0RBRUUyb3NnK3dvcURkZzdIQUFWenlpT1RlQWkvZ3c3UHVPRTY4MTRQVmdU?=
 =?utf-8?B?U2NHY04vRnRIY29KUjJtN2toUjVKWUxZVmJBem5JcEpXMURBQ2pGejdoNnNy?=
 =?utf-8?B?aW9BYkVRYitPMXhkVUdHbkNhdzhFYmdCLzREYTI3Y0ZYRFAxS09HNjZXVXVp?=
 =?utf-8?B?VXNqU25mVWExVVRjVHRXTlJERXdXdXZtQmJFZk5LZlhtNnlhc0FqN3YwMUlZ?=
 =?utf-8?B?c0hhV3Y1MEQrenl5QTJHYlgvVjdGQm1NQ0o3N1pVN2M5TnJNeWdTWFB0aHpS?=
 =?utf-8?B?WE9ZYlRBNXd5L1dOMUpZekQ5MG9oeXY5Uk9LMnFZZnJpUVZFUDI2ak9KNFo1?=
 =?utf-8?B?Q2c2dEtINVkrS2M1K3pmejJHSlpObXdWYURISUMyTCtUcWExeVNDYjh1WXhV?=
 =?utf-8?B?OU1BZ0pkSW1LcU5ubDhVTEp4a2RqUmtBdUR5YnBFTEQveW1VV2NwK0RUTVpG?=
 =?utf-8?B?K0pZNmxQVGVnOVFiRW5HcjE3VEZlY29BZHJLeU1yS2ZLazdUU0VqVUIwZnVa?=
 =?utf-8?B?VmZQQjFmR0crYjc0cXBRZE9XZXh1cWFNR0dPUWVtcWtJR3dwamQ5clJicXhM?=
 =?utf-8?B?SzZidkxISjdKdFNWWmFtczVVL2hoWW5SRlJNZ3paTVVqeGZESEdoV1dUZmJY?=
 =?utf-8?B?enlScWwvTnd2cENDTHBrd3pFVVg2K2RQNVNVU1FiZXd5NkN5NEpsSGpheXds?=
 =?utf-8?B?MEtIdkRjbkVLMkQyN29xN3hPLzJiT3laMVVLNG1PdHNTbFFBSkNkakVrZS93?=
 =?utf-8?B?dFk5Y3hld2xJeFlYVVZkYkFzamhONUliOXlTK0pBc0dPUk9MWitadndKcmwr?=
 =?utf-8?B?OUdianlKSW5OSUxyMU1QNFJmZXcxQ0xRUitnWkVNdXZDYkxzTmhpbkQvL29J?=
 =?utf-8?B?S3cyTHpQRWNLRUw5MFUvbVZ2WW9XWVFRTEtnZXVpNVlkRFJZaURHSUM4WC9t?=
 =?utf-8?B?eUQxYi9OaU5zakIxMUM4K25vem03S0FEcVVlb3ltUUdvdTRBTTNEU21VQ2xn?=
 =?utf-8?B?RnN3V0c4Z3lsWUwzeHFxQ0FnTWE4YWh6UFlrNzkxaFhGT2pkZlBicTZ1dklo?=
 =?utf-8?B?bHFGTmFNU1BhWUtJVlRvNFVJT3BOWnh1V2RzT2lESjB6bUpwUEJDQXV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGtjWEhWQ3NjS1pnaXBNb3RaQnY3NHJDa2dWNTIzZUdxN2U5Tno0eFgreHhI?=
 =?utf-8?B?blVYT1dFVm1tWk00RE1hUHFXL200eUhZUnNLcUZXeS9qL1pDbVpOeVNNUUlx?=
 =?utf-8?B?WXd4SHVzU2Q2WDhvZmczaDFyWWlVN1B0V3pXU1llM2FJSVRjVjZrMmFTM1JQ?=
 =?utf-8?B?Ym5jOXNqRlNZU1B2YlNjUEFmK2VKMnAyUHEyTG12T0E2NklIUjBQUDgzRDN0?=
 =?utf-8?B?NGRObmNhOTZUdlNLWFR2cU1FNjEyTlQ0aVNTbGFYR3gvanFmU0RFeTQ0NjlD?=
 =?utf-8?B?WHBIRmFLaFJPRjFjQXdjRG05RG82cHJHdm1ERDFGOWpXWlkwYnBSTjhIWU1P?=
 =?utf-8?B?eGFxcXJMUkZwWmpCRW1MMi9NNmJQTVZQNTNEZFU5eGJmSm11bDdCR0NEMHJR?=
 =?utf-8?B?djFqS2V0ZUNxcHErSnFwY213RFhRMjBXZndnaCtGSGluUk52UGpRZ2NVcUVi?=
 =?utf-8?B?RElJWVovWTNTUFN4Yy9aYmNMWDNlMnE3VEZKUTJjTjF4b0xya3AwbU5oVVdn?=
 =?utf-8?B?dkZSejFYcmM0Z0Z5cmxnRjZkdDhnK2RxeUV6TE50QVE3d0RvMXVCN2EyK0Yx?=
 =?utf-8?B?a1JEOGxZUmRDc28zK0VLMFM1alFqWlJPRnFDNDJPZSsxb1BlZXd1NE51T1lH?=
 =?utf-8?B?ai81NFVHSlB2SXNhM2JaakRFU2kvZW91VWsyaFA5a2xLbXVHcXlIb01tbDZD?=
 =?utf-8?B?T0R0SThTellBNWZqV3VUa1BUR1dqT2Y3aUF2WXJjMFJ6bXorSXZuNFRHR0pj?=
 =?utf-8?B?b0xUeEJBbGpRM0RTckdKb29ad2xwdTR4a04xcVNvaDdmNEtUNUVjWVNJNlp2?=
 =?utf-8?B?RklrazJncjVDb0RwQk93QlBxa2hrUVdDTEZWRHN4WmxOUzZzNTFldENITWpr?=
 =?utf-8?B?SlpGdWVMVTMycU16VDFiY25vUTdUcWk4ZVdtVVNKckIxVTJzSXh6NUovVUJF?=
 =?utf-8?B?VGFhWDNGSW82cnZWTzhhdjYybXZUcU9CTnFncDBzS2hsaDN3NUtEUThobHFT?=
 =?utf-8?B?ZFdMRFhCUlErTUJnYzlrUkxqcE9YeE96R2x3a2JIckI1QVBLRWkwcjl5Z3JX?=
 =?utf-8?B?SG5CQ3Z3MzM5d3BVUUVNdUI5ZXdOOTFQclMxRGJCWkh0UlV5azBuTk5iTXlH?=
 =?utf-8?B?TlpaSTlHR0xWY3lHQm9QcXR5YTZJdU4rbGN0VWlqMEIxSFJySHZKb28wNmk2?=
 =?utf-8?B?dDhBcHhUZlZTWVFYRkp4SUdMRDZvUUJmZkhSRkpETnFHMWUvY25CcTl6elNI?=
 =?utf-8?B?WXp3bVZLRjZCSVp5K3ZjT1dnejBXc0ZrZkI4dUF3RUJ5WUM2UFVqZTJZMVQ5?=
 =?utf-8?B?YXlvNHdUY3pnYnBZaEJCbnBZMi92R2JDUThGMnZHS0xyTzQyVUdKeUZWWFJL?=
 =?utf-8?B?QTFJQUxSQk9KN2wzMDArZmp5V3R4cDBhY2hhT1N0Z0tzcGRYWmpIYjVMWW5m?=
 =?utf-8?B?Zm81eSthK0EvODNxNU5VZ3JRSWpnVjgvWHcxSGtEaWdNdFY5WmY2OFk5NHhp?=
 =?utf-8?B?NDNZSTJ5bHN4Rk5vVmp1NXkyaWZKYUw4OG8yMkxnM21rVG85QlFkN055ZXdo?=
 =?utf-8?B?UjMzeFRIWjJPTHlhbG1XcDRBVG1SY1lQejhmYmRNWTBnRTJ2aU1HaTVYeDcr?=
 =?utf-8?B?RkNZM2hBTXBaR2l3UWZaSkM1bTJMT0lOTGlBMCtTVXRpNjNVODF5NkxrT3Nl?=
 =?utf-8?B?b2tJYVRJNlNxODRmU21JZ1BQUmNjT01LTW9HY2FJR1Vka0RNN0QwbDNYQ3hh?=
 =?utf-8?B?aW9yR3crYWRRbE5RTitCMkRuVHprU1A3ZmtwU0pKeDRHWkY4NXZKVEdBQit4?=
 =?utf-8?B?NTg0ZVh2bWVvUXkvbGkzMEFFNWtnM2F1M0RuNllwRGZEcTdlZFhoKy9nR3li?=
 =?utf-8?B?NlI3dkJvaWVoNlhMc1FIdHZZT3dSRTZrdkZTOVVtY2h2R21yc0NxYVduQmhJ?=
 =?utf-8?B?SHBGNm1KWTZsak91blNaelo5TVhZZ1c2RytSKy9USS9JcjluVEVjRUgwNldD?=
 =?utf-8?B?K1FSV2N6cGlMRWZVR2s3Y21WMXgzN0VjYlFMZmRvb2pNYU1Rb1B4Q0FjN2o4?=
 =?utf-8?B?Yi9YUm8ySUI5WGZ3Vk5DUGErcFl6ZGtrZmpBNG9ZdmxVZVJoNXhIeFk0QUNj?=
 =?utf-8?B?RlQ5NEhKZElBK3NEb0xFdEZBTEFFTXBEc0F1TFJsVjlmbitoOWpIeUFhNXFI?=
 =?utf-8?B?TXc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b5194d-9101-4fb6-db78-08dc6506a0dd
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 09:03:52.5011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxnckO3LpWwtvSgwt4y5C4ncFfAmJlS3uchzMoy63jxIGiIynp7XVD9WWJUENIVAPP3t7hRe49NYPpvxSR7NTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9022


On 23/04/2024 22:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.8 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Apr 2024 21:38:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h


No new regressions for Tegra ...

Test results for stable-v6.8:
     10 builds:	10 pass, 0 fail
     26 boots:	26 pass, 0 fail
     106 tests:	105 pass, 1 fail

Linux version:	6.8.8-rc1-g9919cd9ab988
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                 tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                 tegra20-ventana, tegra210-p2371-2180,
                 tegra210-p3450-0000, tegra30-cardhu-a04

Test failures:	tegra194-p2972-0000: boot.py

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic

