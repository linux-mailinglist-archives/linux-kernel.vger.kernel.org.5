Return-Path: <linux-kernel+bounces-158399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 112B18B1F47
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99D511F22C14
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCF51DDF4;
	Thu, 25 Apr 2024 10:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="zHHGQKhc"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2099.outbound.protection.outlook.com [40.107.244.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9AE1CD23;
	Thu, 25 Apr 2024 10:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714041238; cv=fail; b=gtTv4WWjognvdHzWnOZ/FIow/UWMSdCGCn2DGBfSP3/JUtijIEC5Jiel+E4b/7LGFXrMZ8K3w19MXwu/WDBqWEZfypwAbuVH0ZnRJNq7sCsrUfqtE92IiHdWbDWq43B7hfpksshBEPVmhg2guEa5a/M7xGnQ2bo+lgrcOiB+y1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714041238; c=relaxed/simple;
	bh=dZATtCd49cZxCGMGwjKplynDYaWT7HYtM/YkD1scZPk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=THEmFoMA9HrW0J+/d2xfXpf6i32kRiHeTz+1v7pTr1kgrdT3OPPQTnZD3JhPgKa9x9ZJMP1NqJjWqlZImDLPDO18pjAAz6Q+fmLDBIb810lFsvQgBsDxYyB/uJqGzwFQZp5y22SICkMKiZ0ElDUqeKLHA9RrCpGVuNcl5g+xWXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=zHHGQKhc reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.244.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yc2+7Us/D/rS6ssDQSvLDXnatcOoUfMByz5HjxmfXMc4uh99ra61pYs0a9bph214sIi0YJzEyfx1RCwxTeQzVFVZdDe4IoeqOGdNDw815n/Xq27tx16VXXg+EQZjMFu7w+vsOIuQ7FwMVkZksguoexQP+2rPukJFSB/UEIwsQptEgV7FVDjhD6stOc7D1EoViqMQQGWC5kR8rcMV88znAZIQey1pWFnmMVY+ER62I7SO2vExqYk2kfHQVeBxmLGiLBo9CNdhV9Y1DHw+2Xug4rp5uw3EWkW5B8NVzZZMD8DlmQ5QL5ZNchOUbf60zSexStOy64LESL6sl6L/VpjK7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZI+bf0kWcnWgxNFXbiMstJyltN7bmNlIJQ9bhzftue0=;
 b=lTqMBziI6VG+fQ29yxecc/LGZN6zgUyv1AZ05IGCAQFPOc4sn0sV+sYGb4zIsvGSWMLo3kuL/ojXNrJByrZ9yfqqtOM/cd+nQccW/P/LgyMCla/KZLoVI/1OtdrwoHG+c7kevSUNJND0nCOeF9pWVVAOBisqtpbv1dx3bXja/+IQ+ie2Qk1HOrY4jgLAx6qMw/9g/02czSTVuimfkBFG1w3wMr2wKidx3vP6uo/oCi0tofIiq05OtXYPhGoIv7mK8BBSMOrskIBaqW3u+cx+WHOdMY7oCQJwKDfEn2GNqw/pBkjJ1eXM7rgDX9g1E4hCeoZkalfgDDj/14DpcjwNcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZI+bf0kWcnWgxNFXbiMstJyltN7bmNlIJQ9bhzftue0=;
 b=zHHGQKhcGTZpM518Z9pWQSvjZRPSq8pLo/W9shjaoaCwp7DC3dSmYp4g+zz/QOOmqQDAHAQoGWioFWQAlePbG9HFsYAroin/gCMj67hPmAr3vmOVU/7ouojKyNFUUmQUrAtGkyPE4dFYITskTf7vq7pwL9aL4lAS4e3NkRZX0RU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from DM6PR01MB5947.prod.exchangelabs.com (2603:10b6:5:1dd::12) by
 LV2PR01MB7600.prod.exchangelabs.com (2603:10b6:408:17b::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Thu, 25 Apr 2024 10:33:52 +0000
Received: from DM6PR01MB5947.prod.exchangelabs.com
 ([fe80::b557:13cd:8a29:ae08]) by DM6PR01MB5947.prod.exchangelabs.com
 ([fe80::b557:13cd:8a29:ae08%4]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 10:33:51 +0000
Message-ID: <ab5cfd8c-0e88-4194-a77e-5ffbb6890319@amperemail.onmicrosoft.com>
Date: Thu, 25 Apr 2024 17:33:38 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] dt-bindings: hwmon: max31790: Add
 maxim,pwmout-pin-as-tach-input property
To: Conor Dooley <conor@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Chanh Nguyen <chanh@os.amperecomputing.com>, Jean Delvare
 <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Justin Ledford
 <justinledford@google.com>, devicetree@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 OpenBMC Maillist <openbmc@lists.ozlabs.org>,
 Open Source Submission <patches@amperecomputing.com>,
 Phong Vo <phong@os.amperecomputing.com>,
 Thang Nguyen <thang@os.amperecomputing.com>,
 Quan Nguyen <quan@os.amperecomputing.com>
References: <20240414042246.8681-1-chanh@os.amperecomputing.com>
 <20240414042246.8681-4-chanh@os.amperecomputing.com>
 <13b195e6-cbbd-4f74-a6fa-d874cb4aaa45@linaro.org>
 <065243cc-09cf-4087-8842-bd4394fb324f@amperemail.onmicrosoft.com>
 <d549cf2b-a7fa-4644-8fcb-3c420503ee01@amperemail.onmicrosoft.com>
 <20240423-gallantly-slurp-24adbfbd6f09@spud>
Content-Language: en-US
From: Chanh Nguyen <chanh@amperemail.onmicrosoft.com>
In-Reply-To: <20240423-gallantly-slurp-24adbfbd6f09@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:196::22) To DM6PR01MB5947.prod.exchangelabs.com
 (2603:10b6:5:1dd::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR01MB5947:EE_|LV2PR01MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: db8759cf-795e-497d-f799-08dc651332b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzdReCtxYUFwTTcwbFlHaXNEV0wrNGlZWGFscUZDZlVYV21sZ0xRb1hOeUV5?=
 =?utf-8?B?c2tQenA3cXRQUUFONk5qV3QxNDVZYXRLQUFsTmhsQlgvOVVLZnBZeVNPeUFH?=
 =?utf-8?B?eU4rVlF0RnlkYzJYd2hHTFZudGlSVnVxSFBpd0F3dFppcnR6d1dobzNpUk1V?=
 =?utf-8?B?ODJhZFVQY0ZOOERPU0xkN3RuMGd4Y21tdUF0RTJDTjFYem9zUnJTTjVNUE5n?=
 =?utf-8?B?Ny96OVJxaVo1S3RmWVJhNzB2OGdvNzZ5a2ZMSVZEMEVvcWJNbWtnU01CTldi?=
 =?utf-8?B?b1JQV3c0Z2pNM20rdk80UE1zcG1IRVNBTlFBdTBpMkcxVTNJQkhPK1lKK0Vk?=
 =?utf-8?B?SW95ZnFoTE1lblp0WGtHL3M2cUlhaVE0bWJuUXFhSmhja0wydngzRjMxaFd2?=
 =?utf-8?B?ZG9TY2wyUi91K1o2bjBhMm9JZzRsZGRwYmJoK2hsRGdHSE1uUEhoMFQrRWNn?=
 =?utf-8?B?R2psdlFBS0dnMkFnVS9RNmJLVXVJNHB4MEkxZ29IOXNtN3drY2NBdnlxWUJL?=
 =?utf-8?B?SWIya1J4WTZlZ2V5eWJGSUdwb3c3Wm92WmxuLzNBRG4wck9lUXlHSVpzUXEw?=
 =?utf-8?B?eUhEVFBNZ09HMG8zUVpVRzJ2eHdrY0crdTdjZ0RKZVIzck81MjV3L0tkRTds?=
 =?utf-8?B?d2NHSTE0dzRMazN0TU56SEpSZUtzbXBDRFRRbitMTHc5blYvWDJjdk9zSkdI?=
 =?utf-8?B?Vm5KQ0kyRER1M0NkOVRRTHJBZ2pGelNYeFBJbmlFY1dQT21SakQ1UmNTU0pT?=
 =?utf-8?B?N2crc3lFbzEyV1hIWEkvZ0NZR3E0K3RtdzBQMW9hNFl0d25UUWFScVZNdEE3?=
 =?utf-8?B?bW1mcFhFS1F4TU15S01ZWTJlamd3eU5MVzVUcmltYXhiMDQxRUoyeHhXTWhW?=
 =?utf-8?B?c21HdHc4aWtzK0VSMVRxd2lYM3Y2SjcvMEdvV2tLU1FBdUxYWis5b0RvOWp1?=
 =?utf-8?B?bEw5cE9RRTJZb3BPNCtKb2Rlbys2K1VGNFNsNVA1WEhqcWZWeEp5Tk11b2J1?=
 =?utf-8?B?L3RoNm9MY3pkeVBRdXNZdjdibElCUm5UWmlPUElJQ2xlbk95MGFQZmJCekJ3?=
 =?utf-8?B?Qjg0cjRhalMzclZ5ZEVxYXEwN08vNk8xR0M4U2R0SXhKT1NvZnFxUVVkNnRp?=
 =?utf-8?B?bTA3ZCttME4rVkRITC9UQlUzaGdwakxpdUpVZ3NpY0tRSmF5VnRtSFBnOTJq?=
 =?utf-8?B?WkdrNmIxelRscHZDQ2ZwUGh5V0lLa2prbm5lSlRYUVMrNUJmdHBORDVSZENa?=
 =?utf-8?B?aGZNdTIrR3VXeGtIMllKem1jNzdxVVB0ZGNzZG40ZVM0K1Z6SzVBWmFVc3Zw?=
 =?utf-8?B?TG9jeVpZY25PaFFIem02ZHJyeFFQelY5Z09TSS8vb3dvZmVIUFBqaEpkdWNo?=
 =?utf-8?B?VDg5eW1jdG9MbVhhbTA4LzhrdUZrbkRCc0Z1TEhKQjFKbkZTZlNJaUh5Vmpz?=
 =?utf-8?B?RVVHOW5pRlZlbm52L1NFTWQ1dkFBUVRqYzA0eEQ0WXJubDhta2lPaDVYbnk1?=
 =?utf-8?B?WFdUMUhialVpaWlKRjRQWFhaZFUrQlhoMlJWL09rVUp3N1BIQ1NQeWRwRFMy?=
 =?utf-8?B?cUlXMlE4S1lMblY2UjBHSGNaRUJTNGhpR3RNS0FjeDJ3QkpRYmNoc1hUSlRw?=
 =?utf-8?B?QUpJRWZxQ3M0ODBXMEt6YWNvK0QyQW5KYnVjaGR4WGpIeDQxYThnMHZ2Kytn?=
 =?utf-8?B?Q2pMOXpnNUFZakJTTytFRm8xMS9VRG9hdjVhRGlGaXRhMTgxOVBHUWpRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR01MB5947.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3diR0RRWU05blFHY05VS01uK2EwTjNNcTFsa0Nublp6ZGJCTnpCRUg0b0JJ?=
 =?utf-8?B?MWFpeXVFQ1hLMitkaWpFM001Y0FZbmRIL0hubnpBQlFUazlRbG91eG1BUjZI?=
 =?utf-8?B?eXE5ZjAzTDQ1azlsa3FyTnVGN0VxSUlVclRpN3RtdGxqRHpNYVVHVGxyV2pE?=
 =?utf-8?B?UStQQnlNeUcyT2tmelpiMnBmbDNCeU9sWVBJdXp4WXRzUVluVjRrYUJWRkhL?=
 =?utf-8?B?anhJN21MbkhqUlBSeE5lMUxaSnc0ZXl5WUxRMU5hd0wzVm1hRlpIRk5LT09S?=
 =?utf-8?B?UHRaVHpqcjgweEprZTRmRlFOcTNVWU5zZzh2SW55K2dqSG5RdEYxb21OZXVF?=
 =?utf-8?B?YlluNmxybTVVd1laNDRrTHdLNkVLK241VEdHc29EbEtzLytML0JpZjFsSEN0?=
 =?utf-8?B?MDYvTndMa0lOWU9sQzZzOWViMmZkSGlFb1RDRDFMVVVPN01DUHBJMll0cDhC?=
 =?utf-8?B?MVpaSzh4MjFzdnVyb0wxSmlNQ2QzaG5hbnYrZVh6SWlvQy9oMmt1NnhCMjNs?=
 =?utf-8?B?WFJzbnFJNG0rS2tXbGgvczZNcFRKbnNIaEIzVVBLNU90VUFSd1R2N2N5cXdO?=
 =?utf-8?B?TGtNSWFQRGpiVGRIKzZkcmVQdUlZbUlZYVNTZms0bzVGbDJSemUxeGJTQzNv?=
 =?utf-8?B?eGp4TkZYRFp0TkVITGI4ZndPdjdwUnNvMkZmT09wK3U2MHAzcnBLOHVUVFNr?=
 =?utf-8?B?VXdxYTFWUEkwWXJ6V251RXhtSHdpQ214N3ZrYUFISVRJemI3UjR2UmVwK3RJ?=
 =?utf-8?B?Y0U3MlFQWXNLM1U5eElqb3lxaHhrSVFPQVlDbXphYTc2M3VFR2xOK3pTT0Q2?=
 =?utf-8?B?TElIZ2w3OVlndmpMQXBZWGIxU0N0SWI5U1hNZ2dQOWVCeGlxODBBZ2NzQWhq?=
 =?utf-8?B?M3FOMFRTU2RvUnBzdUJQVzYyWDNBT1hLczAxb0dzQjNpMlEzbmlaSklhYXRw?=
 =?utf-8?B?WksyR1NaL0FoNzI0WlJKaVd2WHdVOU9YQVpSdEl1YVpza1E2WWthZkZJc1Fu?=
 =?utf-8?B?TDdKaUtaMDJPaXRtYnFQSXJ4eU9jMmxNVXhpblF1bExpOU51QkVLU21ST0RV?=
 =?utf-8?B?a1lHakFmREM5RFQzZ1BYR2hRbmFnLyt5a25pSStYRnNoRkNZT2RiYWorSHFi?=
 =?utf-8?B?NUxsWktUdWNIeThlV0swcWxwQlVMN1Z4U1pYclJaNVV3N1Q5blk5aE9rNmIx?=
 =?utf-8?B?ZVNWdGpzdkU1K0R3SmVGSDhvUk9TandZQ1F5NWltYmdoRVE2emJNc3RlT1Nm?=
 =?utf-8?B?eW1XNG9ZRmJuRXVuYktWbGFLZzllSzNjcHpIWmdEcW1ZVVlCMjNlMGkzMEI4?=
 =?utf-8?B?V2ZxTmpVaW5BQ2NjWGFINzZTdHYrTGk2eVprMGNiWVN4aEpIeFp0MHhINnho?=
 =?utf-8?B?cTQ1bi82WXd4cklxejdjRVBIR0RRMDgvREVFMUJGZjVoOUd0N3VYNXc3b2M4?=
 =?utf-8?B?MVZ0aHl5MkV1ZlhtcFIwNlNXZDBPTFAzQTlta3YxdVI4VHZOelk2YTd2c21k?=
 =?utf-8?B?WVA0cEM1VnZKOW5rbU1PWkhOdHhZck5HOXFvanFHM0pYeWpFeWQwNU1ZOGRE?=
 =?utf-8?B?OTFvcGlwRzgzZ251a0trL21XYUZhTHRhS2tzYThHdTE3ai9hb3VCaHh5TldK?=
 =?utf-8?B?N1N0S1ZVTzJlZUsrOXpWTFhpZ09oNFJVRWVvNmFGOWlwSmVQUk4wN1FidWxC?=
 =?utf-8?B?ZkxKZEpPUXozV3d0VVhNUkNuQ1RyNHNwWnhJUmJ5Yk9Ub2Y1aWtJOERpdW1E?=
 =?utf-8?B?MXBSaHMzNWhnTUdNZGVWRW5sbkdzemxQdGtPWWxTZ3hMSythbTNZeDZ5aVdj?=
 =?utf-8?B?MEQ4MldFeVFzQkRUczlFUXlES1lEbXBiODllV2hXQVI2ak9TdVdSeE5PMDdm?=
 =?utf-8?B?aHlsSGt1djNlaTR1SDY3c05uWlhHSEhSVUFIVk9aUXovdzhuU1MwckI2U2RR?=
 =?utf-8?B?RmREWnpSZHFnS0liMVJrMVZUejFqSFZmcUgvU3Nsb1dPcnpuT2FIZ0huSE5Y?=
 =?utf-8?B?dzhVYXZqd1J0ZDZDRGZHTjFyYTNqRzg5WUtrOWxoMExJT1RqWTRWNmR2alow?=
 =?utf-8?B?SHh5azFCZkJwYndTcEFsd3FFTnZiZllPeTZaeVROWjZ2VllxUkZxcXdNdHZF?=
 =?utf-8?B?TXA5QXNSa3ArRmNVbmVuam5LWmtjQkk0MElnT2xrbDgyT0JJYjlPc09IcjFr?=
 =?utf-8?Q?8TWvXP1vUOcCazY3CBnag5w=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db8759cf-795e-497d-f799-08dc651332b6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB5947.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 10:33:51.4939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kxPyNfo7cMTxnl1SNdzS2QJnb5S7DQ2c0MxhE2ZPP6VwT50GZl+pMfEEyqm5e2d/pDucTJT9wN3fGaVWtZPVEclWlB5XbD4MKDuze8ildkUYrB8sGFr9gAAUpCFL02+l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7600



On 24/04/2024 00:02, Conor Dooley wrote:
> [EXTERNAL EMAIL NOTICE: This email originated from an external sender. Please be mindful of safe email handling and proprietary information protection practices.]
> 

Sorry Conor, there may be confusion here. I mean the mapping of the PWM 
output to the TACH input, which is on the MAX31790, and it is not sure a 
common feature on all fan controllers.

I would like to open a discussion about whether we should use the 
tach-ch property on the fan-common.yaml

I'm looking forward to hearing comments from everyone. For me, both 
tach-ch and vendor property are good.

Thank you, Conor!

