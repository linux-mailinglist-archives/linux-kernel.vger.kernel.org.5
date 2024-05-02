Return-Path: <linux-kernel+bounces-166078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3F18B95A4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A5FBB218E4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C15B24A0E;
	Thu,  2 May 2024 07:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SRXVx60u"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304391CA96;
	Thu,  2 May 2024 07:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636343; cv=fail; b=rdrTjLS5iFlQ3ZB8ewfUiAGFpS63Hte4KKcttUVlmj52TqN/qniB50mKGe2h0GJma5dfTqEhlq4FnFJghNslmQ/rSJNwq/JRI9Aq5nYpTkgW9aCC5afZyOVJ/Uumo4a4hvX4NxI+0rWx60ykwwnlQQdQf+onLwaGEAVQv/qMeqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636343; c=relaxed/simple;
	bh=FOkBg0pV4/kC0zZNAYFfWHyuFMIUGhCwcEUlLnGnRQI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=asQwOozWIB8g7nnlWBAMgF+R43j5g2hUVFnHuLhArmteSpZcKgNYEPH0ie+jbqOOFyX5pYSDNu1nWyMFaLflcbk8fdflCn2xa53o5tz4MJTGsCXR7Ab4GmNvm6dxkIDSq5qYBXyLnLGLdcHb0Q93zzM84RvNagX1Sc4CD2M8vNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SRXVx60u; arc=fail smtp.client-ip=40.107.94.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wu1y/1h8Gc7OKqt1bTVjq7CATvw+aFBtTHgOOUI53OVml/bf0hEMSt7OIrJWrqiPOIPpammukSm2+pFHrOjhNlqucOmEpLYz8p5nSaKO6qSxsvS9YVoa21HUyYkHymw27Gke6U3ThQVlsSFQLwMHl3vk0xkaJLIY2JoKD+o9w59Dete2LdMCb/cMdsuRAb9EkyLUVUV10CoBw8nBAQIEQitcbC6rfzfwDlGovErn1PikAtW1ehZn8N+L2wUMG/+G7Ccriu3jAG7wDNrdopLv9YOH413TiE70lRRMevvuBhi3OHthPFEq2Ch1PpTwFBKfM8n1t/BV3tvxwLSPtDzPSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r01Z1aNdEjHW5JYEGRR9MtlM+U8roH/M60jzq9Q+xiE=;
 b=ZuicAdobpzv/hjoo9BBu6ZeAEjL11hUUXyyvG64A2N56rcCe4/h2V2+opb7go1HPGxlLa/YTakoJJZQU9jN6lDCeI2J3t9Bl2GylhLod+kUcXvXPpMXinMK3QFPUL3cqKqAWr8lLjEIrtoYkDoAGmjq/zBDo44zFa0EzJQs0M5OZRrd0zNlgXPTb3q3kyZyMG+rP0IQkLla68wj5BOh4ekkyUg9h9Tk3CWRpMj3lETeg6/caEVxKv9Atr6cJGP9+PdYUmvtLkIDl1aD2NF64ixTdXdKDHEXs7xHe3zl+MhtayiwJ0EPeK6uJZAJu4odqhINpbSrtIQ/5wzAz0JjrLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r01Z1aNdEjHW5JYEGRR9MtlM+U8roH/M60jzq9Q+xiE=;
 b=SRXVx60uNDP9f3AVA64Ph+j4EaA/sgL81Leouz8zd2lJgTHUQFzzKom+6pnO1ACnBtK4v0woCsHTcqwn11MSMolEnIyw196T44M8b1WjSsZRtAiodCRqbjkxq6J90bSqe5WC4Pcmco7dlto8SxQFJ0UWIoYMKgkItcf/NnMm/2Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Thu, 2 May
 2024 07:52:18 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f%7]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 07:52:18 +0000
Message-ID: <1ef49f0c-02b4-4f8b-b220-cea74a4b8d29@amd.com>
Date: Thu, 2 May 2024 09:52:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 3/4] dts: zynqmp: add properties for TCM in remoteproc
To: Tanmay Shah <tanmay.shah@amd.com>, andersson@kernel.org,
 mathieu.poirier@linaro.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, ben.levinsky@amd.com
Cc: linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240412183708.4036007-1-tanmay.shah@amd.com>
 <20240412183708.4036007-4-tanmay.shah@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240412183708.4036007-4-tanmay.shah@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0245.eurprd07.prod.outlook.com
 (2603:10a6:802:58::48) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA0PR12MB8374:EE_
X-MS-Office365-Filtering-Correlation-Id: 63c03574-8318-47ba-41b6-08dc6a7cca1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1VCRDFmOGU1azI1TUsvdkJWVlNUemdSZktqV2tBdS9vVXBoN0VpaUhQdkcz?=
 =?utf-8?B?ZHJJYlFqNGpvWnpDZ0tpVGU0ZGZ6TUNsSi9HT05WTzJCbVpyTGllVmdyRUhy?=
 =?utf-8?B?T0RraTNnYmo1dXZjQkw2UUxnSThPSU9PVWpQSW1qa09XYWZ1RmtOVHQ2Nit4?=
 =?utf-8?B?N3d6TEFCell0cGNTRDd0SkRPT1hZUitMczBlT1Q0ZkxaZkN3OWxqUkNnNWdD?=
 =?utf-8?B?dC9RQkpDM1daRzcyRXE4cHV1QWhROUFWUE5DWVF6M3ovbm52UkQzWGpBZ0hy?=
 =?utf-8?B?WFdLT3RXK3grS0Z1UmVnWWNZaTdLTEI2cGFISXM2SVZwOHFscUx4UDhUWGlU?=
 =?utf-8?B?LzhDbmVzQnJORjVMSXovV1NJK0wwSHVSWktqeFgxaFNjZFdvZFJ1UkxpcmVV?=
 =?utf-8?B?NmlMbENuTWFCYmxxRGFVQzFsWlRKSWZxd1J3ZEo4anBvd3pvQUVUdndmelor?=
 =?utf-8?B?cmlZNkoyVkF5WUl2SDM1UGVCWEhEVEQ4aURmVHdVL2JDQjl3RlpLNDBaVXNG?=
 =?utf-8?B?K1FsdzNvOERkL3NEQ3ZHRUdVa2xPRm1BWDZBNUc3WlVHUGZvcys0MWhOZUxr?=
 =?utf-8?B?QTc5QjVscDAwSTRya0xvczdVU3VRY3pOMDlSQW5mN2IyMmhDcmpxajBDekF3?=
 =?utf-8?B?ZENqNU05SWV3bXVVZmNlVWNWemErU2xGWU52bnZmV3pneTRGNUZQOVN2Z1pM?=
 =?utf-8?B?TG5oaXJzWm9uRnc5Ky9ZcTVaYm1WMTBPaTBYd0N6TWlucUFqNFoyd2ZVYjFV?=
 =?utf-8?B?UlkrbTFYS1MvL3gxVGh1bDNlSjdCK3dXVWt4L1BiRjVwend4WlVDY2RGS1Vq?=
 =?utf-8?B?d05jY0JkVjZkUTJjbVVmWkprQmU4dExEcnN6QlFFdDZseldWRmJUOEk1RXJm?=
 =?utf-8?B?SHdwbGpCVjBRMjV1dWJMNnRlYWd5T1hzTWw2NHVaWG9tZ29tZmNUT3p2RWEw?=
 =?utf-8?B?UHhDUkM2S203SDRRcGlsRm52VnE2WkQwbjdRelM1RUI3MDRIbWtZU3VvdmRJ?=
 =?utf-8?B?VnFsYUVkQ0xlejFOOFo5b1dkcjZUSlY1Tlo1V3NVaUsrZEpIWjdoNE1JK2dQ?=
 =?utf-8?B?c2o1aVNhOUVzZEJ3YWVoVU5ubUJ3cTAyditVNVlGQ0NuNVZrOFQzTks5TGJl?=
 =?utf-8?B?dThMMisxSExuYytrVWRsS2N2amlBKzBKdC84UVVwczRJWW84NHBqVnpNTUpU?=
 =?utf-8?B?NHQvbVVkdVpTZDgzOG93QUI2NXBPVXkwQmtWVnhVOTNpeTRuNHBCcXpRUDVN?=
 =?utf-8?B?ajBCbndGTHhzWUVqRitGNTRkRXZwU28rL0pIZDY0Nkl1OUx3bjlpNGFPQzlo?=
 =?utf-8?B?NzhQTzREeEJ0bzUzQmhjSzRQdzRDbWxhcXdjdCs4VXhaek5YdGhsREZsTGFh?=
 =?utf-8?B?RllGNTE3NXI2dDFiTmh3ZGJpTFJFSVhjdDBnNW83SUJMZG9sdW5oQ2ZVT1FH?=
 =?utf-8?B?eUtEbkdsVEJCV2JSVjZob1RtUVo3TlFCV3NkMHR2SWQ0TzM4ajlHZHN1c29C?=
 =?utf-8?B?c3A4M1NzMXRiMmYvMXQwaGRCYzF1UkhaVFhjZkMxT0RZdDBOaWR0clVTN21w?=
 =?utf-8?B?dXFPV2ZhbUU2L0FHcHIyQzhRbjgrOHUreUhWSlo2Ui8rQ0E1YXAyNmZxNW5p?=
 =?utf-8?B?Y3c5Z0R4U1dlVHprK2R3UTlPcUEyL1dGa0pTQUNiQmhNVFlPdEJUL3pLTjQz?=
 =?utf-8?B?dEhlSERwZWlGbjc3eWkyVkNyTU1GcG9yejh1N05jQnZzNVdUZWlkS2pBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1AxVGNvTFN6eGpwT1RPeHlmbnV1NllXbVlpZnlLcm1SKzcxd2ZjcWlzRUc4?=
 =?utf-8?B?Mk9yUGJIVFlwOXBJak5GSlh4TUQwa1pZTklkTHlhMTF4NitFdnNkZ0xaM2tD?=
 =?utf-8?B?QkRITDFOTWVyYzE4T2pLeWxvOHlIWG0yOHM1TTUvalRoSzFFdEZCNkdicGQx?=
 =?utf-8?B?d2ROVHhZK211S3huVVhwRm44dGlnSS9hRDM0V2VyM1hJaUxhWUd1OG4zckI1?=
 =?utf-8?B?dGRidUlHOUtqMkJNZHBlSUJmbU5sZWdhZHE0Tkk1SklySzZCU1FOM0VqdHUz?=
 =?utf-8?B?eE9RcUwrS2ZSN0puMmRyNW5LRERUQ2Z6VFFBMlBZVU9nMUNJczFDU0ZxWFc0?=
 =?utf-8?B?QW5hZUhCajZ5V1hKc2p1MWgrbTZhSnJ0NmFUMkpsSzUxZHdKQzdWRTVjaXoz?=
 =?utf-8?B?Uk95RjVuR3V6WTNKdlZNMGxVL2c1bHdzWk5GRGRJc1ByWnQyb1lDSlVUR2hS?=
 =?utf-8?B?R3hjeURKa2krUFF3RDRPdWF2UVpYcHZJMTRJQ3dwRThwRU93R2JGRkxvRjlN?=
 =?utf-8?B?a01SNjVCdlRTWVk4OWlhR1NHZGNyR0UwdXNjN1lDejYvVnVOTFloZ2FxcDZw?=
 =?utf-8?B?ZTNNMHpmUjU0RkVYTGI4cHRWK0YySHl0bkp3SGhsNEg0Qll6ZlNFNFByMmZ5?=
 =?utf-8?B?eEZ3c0o1R09zZ05JR2ZhSGp1Z0MyN0pHQlloSzB0dGNzM0xYcXFLTFltdFFI?=
 =?utf-8?B?STRxdDB6ZUxxeTNwc2hSMk52eS9zdUVjRmJqYnQrOG9td3M0VW1EYVdkRlVv?=
 =?utf-8?B?VGdYZ0luMVFBRjZMN1VSTmVickhFY0UxaDlHcGNCRXF4RUE0SHdvUUU2aHpp?=
 =?utf-8?B?T3hkeWxyTGRSdGpvSlB6eWxHTHlCaGs2RGM1bVV2aS9KTlprWlRHcHdMMDZu?=
 =?utf-8?B?LzFEL05JekJVVktpSHBPVkszeUlFcHBHUS9IL2tZZERKemE0aHhnaFB4b2Ey?=
 =?utf-8?B?YlRPOWFqMmZITzRVMU10NVZpMXRsY1ZtNHlsblBPNmgzSE5KQ3A3YnlZWGY3?=
 =?utf-8?B?eXZiU1M1djFBU3ZMZzhhUk5OR2ZWSGdJdFhDMEpyMjl4Q200L2R5M3h0Q3dr?=
 =?utf-8?B?TG1vRGRkVzlSQ3B4VXZpN0c2NkJvZDRyTUVYTm1HYjNZVkdoamlITmpkdjh3?=
 =?utf-8?B?RWY0U0ErMFZtek5SeXNYc3hUY0RLQjdoNkpsREhLa0lFWTFtMXBET0NlaUg2?=
 =?utf-8?B?eTlVYXQ2MG55RmduaTIyT0ZldSt0MzBpbHZBWW5nc2loV3hRTCswcDB5U2F3?=
 =?utf-8?B?UmRoM3luajVYQ1pnbHFuTlJQSU9VbGJYT0JlNTJROGExK29IMys0UkZWa2hV?=
 =?utf-8?B?RzEzV0I3bzlFaVgrYnE1bitUdUY1blZmMmlFR0o3eSt0MTJjKzFydFRGZkZM?=
 =?utf-8?B?WHFDL3crcHg5TzFGZzhmeHdGbUtRK1dqLzU4emFiY1ZpZUVLRC9xQXVjc3o4?=
 =?utf-8?B?akZCTEVGSWE5eTEzS3dVSWovZ3pyS0lSKy9CWC80T3FDN3g4bWozMmgxelRS?=
 =?utf-8?B?c0xxeTVIOHhTQXQ3UStoS29QQkttY2RNZlAxSTYzdjlmWHRLTnlMWW5aaTl4?=
 =?utf-8?B?bTM0RHhLbFE0bjAyL1N1em9kWUVaaEY4TElKcG1LNEVjNU5WYTNaYnovR0FI?=
 =?utf-8?B?RlRUaTQ0VCsxZzJ1RFBLSlZjRXllbFNqd05wZU1SWExUalpSZ0pqcWVkV0dp?=
 =?utf-8?B?Q3Iway8vRVpoOUhtRUhsR2xTODNpVDdFQkthU3JKMzk2VFc4YVpMQWJBOXJs?=
 =?utf-8?B?eWNZRVBOMHczaHJiQnQ5WFcza05VeVNiS0k1bWFYRDR5RVVzV09iZG5PWHg5?=
 =?utf-8?B?R1dHZ2xkV3RCcThhWGNGdkdoeE5FeXdsUmdLR1JTZ3VyYUlpbDkrcDZXVlRZ?=
 =?utf-8?B?VWcySHhUZjJxbzhmYkY5UFBNNXIzdG9vaFVYTFRhd2JoY3NkYysyRUs2UnBO?=
 =?utf-8?B?WGtJMGhvZ0drejV1c1lpZWhkUm80UkpkNkpXVGFqUFI5Q1NqZmk4aENCMy8y?=
 =?utf-8?B?K09HWWZEaHpZY3RiWlJBbkdtS2VhQzNOdmx6SU1MNWt2YjQ1RVIyYzhTU0Z2?=
 =?utf-8?B?SXhtU2ROYkdsS3lVdXY1MU9yK3c0MDRuck1HdW9ENElGZS9OM0lBajZmL3cr?=
 =?utf-8?Q?E9Sn7fpQQKa4tBM0MwbgWzT5i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c03574-8318-47ba-41b6-08dc6a7cca1e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 07:52:18.2038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bcUlv2nhyMFBwS4DHk7fIAJueMT2OD3aBg60XmHZgK4CW+8xjgOfj7+Mdp+48SLj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8374



On 4/12/24 20:37, Tanmay Shah wrote:
> Add properties as per new bindings in zynqmp remoteproc node
> to represent TCM address and size.
> 
> This patch also adds alternative remoteproc node to represent
> remoteproc cluster in split mode. By default lockstep mode is
> enabled and users should disable it before using split mode
> dts. Both device-tree nodes can't be used simultaneously one
> of them must be disabled. For zcu102-1.0 and zcu102-1.1 board
> remoteproc split mode dts node is enabled and lockstep mode
> dts is disabled.
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
>   .../boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts  |  8 +++
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 67 +++++++++++++++++--
>   2 files changed, 70 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
> index c8f71a1aec89..495ca94b45db 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
> @@ -14,6 +14,14 @@ / {
>   	compatible = "xlnx,zynqmp-zcu102-rev1.0", "xlnx,zynqmp-zcu102", "xlnx,zynqmp";
>   };
>   
> +&rproc_split {
> +	status = "okay";
> +};
> +
> +&rproc_lockstep {
> +	status = "disabled";
> +};
> +
>   &eeprom {
>   	#address-cells = <1>;
>   	#size-cells = <1>;
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 25d20d803230..ef31b0fc73d1 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -260,19 +260,76 @@ fpga_full: fpga-full {
>   		ranges;
>   	};
>   
> -	remoteproc {
> +	rproc_lockstep: remoteproc@ffe00000 {
>   		compatible = "xlnx,zynqmp-r5fss";
>   		xlnx,cluster-mode = <1>;
> +		xlnx,tcm-mode = <1>;
>   
> -		r5f-0 {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +
> +		ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x10000>,
> +			 <0x0 0x20000 0x0 0xffe20000 0x0 0x10000>,
> +			 <0x0 0x10000 0x0 0xffe10000 0x0 0x10000>,
> +			 <0x0 0x30000 0x0 0xffe30000 0x0 0x10000>;
> +
> +		r5f@0 {
> +			compatible = "xlnx,zynqmp-r5f";
> +			reg = <0x0 0x0 0x0 0x10000>,
> +			      <0x0 0x20000 0x0 0x10000>,
> +			      <0x0 0x10000 0x0 0x10000>,
> +			      <0x0 0x30000 0x0 0x10000>;
> +			reg-names = "atcm0", "btcm0", "atcm1", "btcm1";
> +			power-domains = <&zynqmp_firmware PD_RPU_0>,
> +					<&zynqmp_firmware PD_R5_0_ATCM>,
> +					<&zynqmp_firmware PD_R5_0_BTCM>,
> +					<&zynqmp_firmware PD_R5_1_ATCM>,
> +					<&zynqmp_firmware PD_R5_1_BTCM>;
> +			memory-region = <&rproc_0_fw_image>;
> +		};
> +
> +		r5f@1 {
> +			compatible = "xlnx,zynqmp-r5f";
> +			reg = <0x1 0x0 0x0 0x10000>, <0x1 0x20000 0x0 0x10000>;
> +			reg-names = "atcm0", "btcm0";
> +			power-domains = <&zynqmp_firmware PD_RPU_1>,
> +					<&zynqmp_firmware PD_R5_1_ATCM>,
> +					<&zynqmp_firmware PD_R5_1_BTCM>;
> +			memory-region = <&rproc_1_fw_image>;
> +		};
> +	};
> +
> +	rproc_split: remoteproc-split@ffe00000 {
> +		status = "disabled";
> +		compatible = "xlnx,zynqmp-r5fss";
> +		xlnx,cluster-mode = <0>;
> +		xlnx,tcm-mode = <0>;
> +
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +
> +		ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x10000>,
> +			 <0x0 0x20000 0x0 0xffe20000 0x0 0x10000>,
> +			 <0x1 0x0 0x0 0xffe90000 0x0 0x10000>,
> +			 <0x1 0x20000 0x0 0xffeb0000 0x0 0x10000>;
> +
> +		r5f@0 {
>   			compatible = "xlnx,zynqmp-r5f";
> -			power-domains = <&zynqmp_firmware PD_RPU_0>;
> +			reg = <0x0 0x0 0x0 0x10000>, <0x0 0x20000 0x0 0x10000>;
> +			reg-names = "atcm0", "btcm0";
> +			power-domains = <&zynqmp_firmware PD_RPU_0>,
> +					<&zynqmp_firmware PD_R5_0_ATCM>,
> +					<&zynqmp_firmware PD_R5_0_BTCM>;
>   			memory-region = <&rproc_0_fw_image>;
>   		};
>   
> -		r5f-1 {
> +		r5f@1 {
>   			compatible = "xlnx,zynqmp-r5f";
> -			power-domains = <&zynqmp_firmware PD_RPU_1>;
> +			reg = <0x1 0x0 0x0 0x10000>, <0x1 0x20000 0x0 0x10000>;
> +			reg-names = "atcm0", "btcm0";
> +			power-domains = <&zynqmp_firmware PD_RPU_1>,
> +					<&zynqmp_firmware PD_R5_1_ATCM>,
> +					<&zynqmp_firmware PD_R5_1_BTCM>;
>   			memory-region = <&rproc_1_fw_image>;
>   		};
>   	};

Applied.

Thanks,
Michal

