Return-Path: <linux-kernel+bounces-156706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F08D18B0718
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6854A1F20357
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F99159594;
	Wed, 24 Apr 2024 10:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1WYPpYzt"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BBA159590
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 10:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713953794; cv=fail; b=GtryFNqB20W1w9S0MrZXQVODxFZNHHUxItTIdnx6O8RSIjyR4NNWldCBuU2xaF2Jf2sKEcx68/sIaM8nhM9j+jlapnP75Uf4AtjqBTOiCOa1l+3rVp4B9ZfrLQRtyb0nY2YZXm3r+XIUcaxEoj0+ZczyMt3GSGukyDIPFk5+BOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713953794; c=relaxed/simple;
	bh=TY5uItwCKVdfNbVO2d6ua82n/TbDaSgO5nJz0Yawd8g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YWDcrpW3XyGxKRotzHIFo0N2G5EfwdNIfF5P5ijlHnLZeIbNOJbcQZg4pxGs4OFene5IDypgy3+e3a/UA7YlkMiR0B6ljMgWcyKZDO8BMIBqWVx62UqLZp7+lhgGINLzSKLiwEKBwQBZPgzXpxqHc4Npw15//5oeMcZqYammnKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1WYPpYzt; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjVqPyIeHtyLvV/E+SHntmj7sBhyGI/lyzrl31wOb4oQZ6cotvHJ8F17b6IPZ11ZmCxZuBCHjZ9GhZOHDn7L55JSNrrhHCdEgTzfcRehib7S7TS6WJaB+zln93NdmlNt4jYgKfFpdeUlIjM2rxttLWap94ek4rBVPTqOKwkkV/2FSrbkNPxI2ifttE741WEo/phXQ/4KlB7gx/DYyfK4JmHucCit/ixpfnGKMfWlvUnW+uWz6rioIfnlcryb84WqxS7gjJX1g4dxfb3W5PHQqvgoG6NgpWNrrxBo5TQYe8VbgCWRf8kKbfrQ4h7rPs7eglZUeT9L0WIHfyoTmeBXaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9obZrlka3fyKTZMFwolnLlX22unENpCmIHtzodi1Rw=;
 b=WrV+5zjSpGnG4RssjquBgt+boARcCUBQHR+N8zePBpWXU7Ozr1z91+DPu71JJnDNZFMGbYNDk87fqRHCoj/4uFQz5j9IOlzXXJgMRlL5aUJ2zRgKYAbmaGmOJicx2QvPqEYSQxWKK6nQtiVRzS4bFlh09mOQqHoHpAp/LnJ/gRuCtgYbcAoqdIdpY8Q+7yOlhytTLqXUrq+4uOLKuF/bDe1kbQrc4d5FrCPS4EDld4Et++zh7g+lzgjPI9ktkpkRUFqoivXYTIEPRuViMcc/yoxar67aWHAE6kKGu9PMFbQ9s6Mtv6g+BvABV4tJhpO4qIFvlsgCKhCEifDndnBxng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9obZrlka3fyKTZMFwolnLlX22unENpCmIHtzodi1Rw=;
 b=1WYPpYztYpl/m1gfey+lA3dlPtVfVEmGf4uefmV4brdUnUwukDrG4eoBOBeS/xxoc+p+PMyG90URVqVrfzwI58HG0d6vDR/h1TH2tlZ8H2oN9SHr3ILmq+30C5ul8Yi2ve0opbFSQzl7ObeET3e/gn/S6E6dr3xaavkxLwFM16A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MW4PR12MB6804.namprd12.prod.outlook.com (2603:10b6:303:20d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 10:16:30 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 10:16:29 +0000
Message-ID: <f19dfb12-0f11-463f-a64c-2e81324e6e61@amd.com>
Date: Wed, 24 Apr 2024 12:16:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] microblaze: Remove early printk call from
 cpuinfo-static.c
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com
Cc: Rob Herring <robh@kernel.org>
References: <2f10db506be8188fa07b6ec331caca01af1b10f8.1712824039.git.michal.simek@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <2f10db506be8188fa07b6ec331caca01af1b10f8.1712824039.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0054.eurprd09.prod.outlook.com
 (2603:10a6:802:1::43) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MW4PR12MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: 3448be26-7db4-45f1-64c0-08dc64479b8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmhBSktTbHNxTkhPeFNBdEdsbkJqcnA0RXRKV2lNcEFDa0hZWm8rUi9qVmE1?=
 =?utf-8?B?NlRhYktQZndMa1d1bHFRd0pWdi8wZFBqQkd3eTBQYm54VU5pbjRncWtOZTdP?=
 =?utf-8?B?SEhEenFYcGNwdnJGK2hFN1dkalZYSTlZZVdzbmFQVnIveHFMazlhMUVBbDNo?=
 =?utf-8?B?aG40ejNQeHAvY1p0WjljRmRIOEJKVVZET052Q0FpTFRTNG9ZMnF4Ung0V1VV?=
 =?utf-8?B?NUMxM1lyZXU5UlpJU3dXWlNDR3JSWFQyUmZ4cXZBYUM4WWxycnFWNmppY3lr?=
 =?utf-8?B?NWJ4Q2V6S2FzcVJVVTUvbU53Y0dBb2NzM3FyZko3aldvb3c1RWlxeER6M1Rj?=
 =?utf-8?B?cWpFb1NnMm9VbVJjTDNTYmpTejloYmMwNDlEeUlhcFp6aWVvanBhM2M4d2F4?=
 =?utf-8?B?K24zS2Z0NHRtQkJieU41ZmpzTkVCR2NHWnFxYnE2b2M1VHVSUk4vQmNNWW1h?=
 =?utf-8?B?Z0tJa2plamRtTzRYUHgzVmZxdnZ0NFlaODZRc3R6anRxeWZ3SVRhWmhUK0FK?=
 =?utf-8?B?SzBOQ2ZibzRGTGxtYzg0RkJFYmQyeGVxZGYzdFV5aFRNdEpUOXBVWXdrWVRv?=
 =?utf-8?B?bFFpNnlwY0tRMmtFeFUycXJFWGwvcGpjVHh5cVBWVHpxQWNsWDhCT0d0YXZH?=
 =?utf-8?B?YTFCTlk4dXdHN1FPMXJDYXljY1F3T0ZrcHVxeTJrYnhlS0h1Vk16L1FSMXBT?=
 =?utf-8?B?bnNaUVRmbFRwdUcvelhqNXZrS0NQN0lRZ1pMZ05VNytrVXVVcnVQZXI3UDZM?=
 =?utf-8?B?N0YvZzVlQ1FYakp1NEgrYUk5MjRYZjV3QXFCdnJBN244STJIbzBHMGpPaUtE?=
 =?utf-8?B?V1AwTzJiKzAxWEg0eXl0UDZZYXpSV3NQSGRyZSs2OFpGMkdFblpwalpzV0tK?=
 =?utf-8?B?Y0JXZmFQOUdmNEdzVlJZUnkrU0Rjd2NsN0NjQmsrc0xRcEJTZTdLOG9aMjJm?=
 =?utf-8?B?Z0pRYVN2TTRvSkVFRUJQR04zbXprbmJ3c1ExYVNMM0ltWmhrYnBxdnoxd1pj?=
 =?utf-8?B?YzdzNS9FcDAzMTFBZ2NoM0E4QWJ3bUtkRENUNlFwQlQvNkdwVTE3T2pOclRK?=
 =?utf-8?B?MkxCdGpNN0N1cDA0enlQR1dzenM4MW5tNWNFK2tUdEF1N3g1Rk00OXhsc2JP?=
 =?utf-8?B?UUxKRlFyZmRmQWVZWEpoeVVxN21tOVZjRCtiVVRhS1l1NHVMaERZWkhWU2tY?=
 =?utf-8?B?amczUk0rbWVaL3d0a2VxdnZlTUdxc2JNVis1SFNaTTFkWm9aSkJaMlhtNEJD?=
 =?utf-8?B?OTJXYmVHOVNFREJ5ZUpsb3c1bi9uVU9tQ1JhUVpVc053MzhSbEZtK1NmZGtK?=
 =?utf-8?B?ZnpzY1FnN0tIZ3hxNHZ1aVptVGIxODVIRjk5Z2ZTa2xXZy8yZDVqYVlZS3FV?=
 =?utf-8?B?b25kUkJNTHFRbnhYM25ldDZpckRBZkVTamVEUVVyZmJJSTl5VlppWklNYXpu?=
 =?utf-8?B?RTY4SlgzWVlpZFBZSlpLQjZ0MzRZREEyUk1RakRpS0NXaGZod2hqM0IvUHMw?=
 =?utf-8?B?YVpHOVFBNUFHcmJndHRNblYrK1hLaWd1ZmJBQ3pzV0I0azBBZ3JjZHpzTlI2?=
 =?utf-8?B?dXZIZGl4ejBydmorT2pJaWVOWEdWcGZNMHBzQWhLYTZzaUh1VGwzWmw1YXZz?=
 =?utf-8?B?b2YwYnVpOXdUNWN6aUxna2pKZXM1SDc5NkNjd0h0S1ptUTBTclJlU3IyUHp2?=
 =?utf-8?B?ZDZ4dmFhZ0NEUW8zV1Q4Z3ZIa1Bha2JFS3hXRE5LU2xhN2RIaHdlemxnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1JoMEhBVkdJTHdOa3BjT0xpc0NtQ05tR0Q1c3BwZENjeHo0Z3BoSnArbWZN?=
 =?utf-8?B?RzUyRDJYWVJ1OFN5cmtVemZPK0F0akV6cUVWRUErL1B5UkZLSXBlU3NpaUp1?=
 =?utf-8?B?bTRZQ0JuRE53QjZYamtJVEk4dVlaWXNvSmhWMjR2a29vRTVhbHR2MUdQRmhG?=
 =?utf-8?B?K1V4L3c2L0NhMkZUbXpXZlo1eUxEejdvdWRpRGUrcWNlS2I1L1B3b2s5b0JH?=
 =?utf-8?B?aWR0VUM5bEs4Uk9RTDBOMjdFSUhuNHVuSjFhRTZ6YnNTRUl4UXUrNVFreTVX?=
 =?utf-8?B?SkVrY2IwUWhQNDBLa2tpZ0UwamRzQ0JTemw1citBekhIQ1hIZWxQNTdVUkVn?=
 =?utf-8?B?aHNueWxTOERHRElLSlVMYmxGdlk0SDRCT0RmU0J5dlE2dzV1WFlPb1lnUXRu?=
 =?utf-8?B?VnRrbldaUE4vY0xYWTdHM2xEMnk4TTNZYU1PL29CWjE0N0xnaFd1cUNYLzRW?=
 =?utf-8?B?SCtpY1RCS3JBVklGQWxoUDhNcjl1dGlYR3dRTzNTQTZSNCt4WGVieklNTjlL?=
 =?utf-8?B?OVQxVGdyRWhvbUw5YWtmUjBFSG1Cb0tuMXVHK0hDRFRyNVBlckhsRmJYempR?=
 =?utf-8?B?eXVPZnYxOSszR2xFYjZuSm5qTmdXNXFSWi9uQndORHlrOXE1dm9LWEVSOE5F?=
 =?utf-8?B?Mi9PQmNBSnN0ZzZIUk05UUNSYm5GazdOY3NNZDVmaVh1S2R1TTdUUHhHNVR6?=
 =?utf-8?B?UUVVUlFwODFQR0YzclpXOGdKaDhBcFpiY2ZKcEFZMUdtcy9vbUZKRHV2VVJX?=
 =?utf-8?B?R3dQMFdyK1FLVE9YbUdybmdSSzQwWnU2TjJGWlc2cHMvakpPZ0xHajh4cTkw?=
 =?utf-8?B?OForQ3dCd2dZNk0wU1ZFcjhHQUZNb1UxQXhNay9OU0JNR2FBbUtKRU5HcWNW?=
 =?utf-8?B?WkQzanRnMDVRb1piS1cxVGkyZml0TWNTSFNYZVlpdURGL3owZ2I4SUl2cEky?=
 =?utf-8?B?NHlzODZ1SDBJS0JyM1VNSk9BYXZGcmVEZXJIN3dwaGJIMVNpdklLRXR6bnJl?=
 =?utf-8?B?VkIyQmxYRTBEb2psUGgxa3EwOE1HSi9ITk5YeGRjb0NKWVJQeVJ2UEpFWmFw?=
 =?utf-8?B?LytZUkxadnhiUWx6anNhMG42MzhrSnc1Sk9wVW82eXBRMVdkeXBGZzFQUzRa?=
 =?utf-8?B?K1pCOEhWbHNwbm1zK0lQVXJLbVIvWEZ2VDlrQ3h1TUc2bWlDSEZDeWtYTkxT?=
 =?utf-8?B?Y0orazRqT1VPTDRIU0JWVk44N1RWNStlQVBUaEQxb0FIeFMwdWIwRmRZZ1pG?=
 =?utf-8?B?UnhjaUtrQkRiVExQSlNSNXVITWJoVWtyM0RabEdIOFk3WGNtMzBPOXJYMHVw?=
 =?utf-8?B?NTk0RmtHZGVPTzBMWjdNakRZZi9QdTU3bTVLNk40ME9JODc2NFd6OEk4M3Zl?=
 =?utf-8?B?SUs2SVpyYzMxbU02Q08wbERSTVRyMlREbXFyaGpFYjRrNm1zWEU3WnlqQTNx?=
 =?utf-8?B?ZmpaY2FBTGxMa1ZwL0tUbWI5dkNid2Q0dEJTL1dUWGRYa2UwQXZ6RG5CNHJX?=
 =?utf-8?B?YjQ2aG9hdlhMZDBENCtleGpUdFh0OGVxT1B0amxyWGc5V05XdjZVNmpvWjNU?=
 =?utf-8?B?eTA4SlI0UGJWbHpOaERFOElSMnJncXpwY25UUjRoQlowS01YV1BGSHhZRDQw?=
 =?utf-8?B?ME1OdjQyMHpoVUl2a0NBdUVkc3V6Vm1sRnNiamVndG10V3ZEdmFidUFOUWJR?=
 =?utf-8?B?Y2d3SUlCWFdjK2kyYUtYVEpra0c0L0U5MWxEejBqdXlvT2RVbnpyZzkrczBv?=
 =?utf-8?B?SkhZSGpYZGQzaVh3RG1FcFgzZVBJaWMxZWdIbytYOTlGUSsya21Xd0JzUVZW?=
 =?utf-8?B?UWZpVXBPT0dRSDhxOXl2UHFYRm9pYlh0S25BRHBCMk0zY3JOL1FNUXI1a2tn?=
 =?utf-8?B?MWhLVUJIcTRDeXl5U01EeHVYOUpDWUVzLzRsTk9WeGFDclI4VDdVY2ZnaG1K?=
 =?utf-8?B?dUFYSzE5ZEhpQkxNQlNKQjcyU2xVK0pndkhEbXR2M2Q2V1hhbFRBM3VXOUJ2?=
 =?utf-8?B?VGFjTWppOGMyQ2N1a0VNUzNpakY5eHBHY21EeXF5NWNDelNUekllTkpOTlZy?=
 =?utf-8?B?THNra3d0UmdJSGNRNzNvSkxKQ1UzV0ljUDM5NzdlRkZZZmR4L0x1RUdDWU5N?=
 =?utf-8?Q?MZHBtN+hrGtJDnMqyHbRltDFu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3448be26-7db4-45f1-64c0-08dc64479b8e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 10:16:29.7729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7DrpOqZ7P1QBAgXTY8TJak7LLdmw0/iV+rCM9rIEJky6r7zfUudXuuGjslUzG5f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6804



On 4/11/24 10:27, Michal Simek wrote:
> Early printk has been removed already that's why also remove calling it.
> Similar change has been done in cpuinfo-pvr-full.c by commit cfbd8d1979af
> ("microblaze: Remove early printk setup").
> 
> Fixes: 96f0e6fcc9ad ("microblaze: remove redundant early_printk support")
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/microblaze/kernel/cpu/cpuinfo-static.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/microblaze/kernel/cpu/cpuinfo-static.c b/arch/microblaze/kernel/cpu/cpuinfo-static.c
> index 85dbda4a08a8..03da36dc6d9c 100644
> --- a/arch/microblaze/kernel/cpu/cpuinfo-static.c
> +++ b/arch/microblaze/kernel/cpu/cpuinfo-static.c
> @@ -18,7 +18,7 @@ static const char family_string[] = CONFIG_XILINX_MICROBLAZE0_FAMILY;
>   static const char cpu_ver_string[] = CONFIG_XILINX_MICROBLAZE0_HW_VER;
>   
>   #define err_printk(x) \
> -	early_printk("ERROR: Microblaze " x "-different for kernel and DTS\n");
> +	pr_err("ERROR: Microblaze " x "-different for kernel and DTS\n");
>   
>   void __init set_cpuinfo_static(struct cpuinfo *ci, struct device_node *cpu)
>   {

Applied.
M

