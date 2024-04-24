Return-Path: <linux-kernel+bounces-156391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BAE8B0249
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B65F6285893
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BC8158D9E;
	Wed, 24 Apr 2024 06:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yISv3Nca"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DD21586D2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940747; cv=fail; b=IjEhLnaADHErEv8y2IAZKuAWXrpyuMRoy/onDWFw6wXoAfOiWpscT9soEQ6g7sBJcE1VNlQxGg1vL8uzI7xAOQ8RIA/g92zU1dhHQhj6A3nxRmxG7GT4IdnmRED8CUjb688N6HMwkjLQMr77rdhS3lxu1UKH+BuoGHJIYtuhMLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940747; c=relaxed/simple;
	bh=3SXKQGCNpcOlrNJa0h7Hq7camXSFyfeVUCD1UvfXqHY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CbKHC1JqEzFuS6VW9JFk+G+MC3UubfWZ6RMpuvezd1AYlgmunHw8VEDGdvfRRqYBSJFkkqJ3H5j+st/Cw1u0PmqBiZLQ55NHDdTeG9o/sEk6umN8G7K0MJDyxiGSHBr5YJ2smC9qqZJ930NlZJdjB9unTJbPKztWtmxRC5tACrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yISv3Nca; arc=fail smtp.client-ip=40.107.101.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jyXoRhjfVZEcxivjTZjKmgNNdYF2qF9dnDlzBcIdjlxR6jxiNoQ1y9orVU6NpAq/dgvOM1IA4JI5DkGlFVDx1/bVaRet6og94qufNh8Ts6uBJP0588eRJMznxKbnO7RQjhBUDOqnvp0DtclCaqTav7c33v0HRRGkYNZwTL2RMqj6CnJx2sdXkqEL9TSKRaPSZjEPbrBrD9d+yYaSuq2jV4j0dg50mS5uxp/pkNtAyFwSAWQfGLs4tGrNv5dfmYOrtEvaYtG7PEfH+HDPLcu9cMQp+wnHuFqZ47G0Dn8aegCKFDnRju9Yk95Jxj9fxYsCvbuJecdt3T4L6ktB4iPAWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ce4zAsgNTEgEnQ++bnhknhE7iXptKSnlhe8k9PONYWo=;
 b=Y2R3S6+XEYUFRxwIyvbbruuMmdIDurQ/2F+hQgRQVSTaSTErkyIKAdks9YmCowoKN0XpJ1fMPpbdhcjNrYjwRZu/X0gDJ8vSRnqrJpZUXXiiRC/BTI9ejnbUN9TYaBBmJxlo9l+6PXeqFYwKWPEFyvg6jtAYDaJa1xqEFr0EDWd5mvzclQYMFnyYmaoNo6xQjS8KC8Q3f+h1P2lTEoiAdgrEA446B+bF5683JR6btneZdrxTjGP0SDFrvCdFw0su+gwo8cGD9F9MPqjUhIVVc4AM9kUAkdR/m7mYm0/Q3i80nfWZ1iuy23GZvHijUWH+F1JZAqfEOsMCvUhL5sxGYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ce4zAsgNTEgEnQ++bnhknhE7iXptKSnlhe8k9PONYWo=;
 b=yISv3Nca+HvGH1rSrJhQnXEV6Qe1n52+dB0hkG+XHZyN7W5IuncMQ2L61JqSPYv51QNcseSH2X4ZOZk+jWmwBeTkChRCMkHhASgj9J0axrUa79hosncRjNvXVmPSMdZH6bPhz3XFO+XLd6JuMJL266jIduNoKgf2CEAIQ94b7dg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA0PR12MB7477.namprd12.prod.outlook.com (2603:10b6:806:24b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 06:39:03 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 06:39:03 +0000
Message-ID: <4c625bb5-4f2c-4cff-9d65-7b6aa26a52c4@amd.com>
Date: Wed, 24 Apr 2024 08:38:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] phy: zynqmp: Store instance instead of type
To: Sean Anderson <sean.anderson@linux.dev>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 linux-phy@lists.infradead.org
Cc: Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Kishon Vijay Abraham I <kishon@kernel.org>
References: <20240422185803.3575319-1-sean.anderson@linux.dev>
 <20240422185803.3575319-2-sean.anderson@linux.dev>
 <702f0ca6-7edb-4328-92e8-1853ba010910@amd.com>
 <0a57a33b-62da-4a8c-9f07-52c45cd5c57e@linux.dev>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <0a57a33b-62da-4a8c-9f07-52c45cd5c57e@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0003.eurprd05.prod.outlook.com
 (2603:10a6:803:1::16) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA0PR12MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: 37802e34-8b0a-4a89-bfb6-08dc64293b9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0x2ejF0bElXRDc0ajdRSEZ4NXk4MWNOLzk3c1pBUVozZEYxR2liWDhTSEZw?=
 =?utf-8?B?bXloQ2FLaGpROXpCeXBWUUtaWGU5ZGpsRXhFbjQyVm9kMTQxTEdDbjBNVGQ0?=
 =?utf-8?B?ZW0rVXF1UmdUcjZtR1NQT0poWmdIeThVNXQ2dnl6R3o4R3N2OFdyOVRjMjYr?=
 =?utf-8?B?WmJZdmN1STY2enJFYXJvcDZaTGZMVEFJZUFWNThVZkx2SGRGYVU4anZ0Nmt6?=
 =?utf-8?B?bkdKbmFqTS8vb0JJZUNGN3UzYTdxd2dXM25LUFdGYTNISlJIOHZIOXlDR0RS?=
 =?utf-8?B?QVh4UFV1OXFKYUx3LzNhZWJSQ0tneVpkZnJueUhBenFlZFRlRmJCRXBWakF4?=
 =?utf-8?B?MEJyM2VMN3FQYUpIZmFWeXlRc0t1UnZ2VUFJOWw4YVlBYThTNXdSUjNMUFY1?=
 =?utf-8?B?aHl4T2I0bDBXREs3VDQvQ3dEd3RpVTAxdFI4VVFiUGNrcU5qZjJBTWZGTXpo?=
 =?utf-8?B?aEJGRUtYdnhhc1ZTMDdrYmhXMGFaL29lYjN2UDJzYWVvY3JYK3E5N0tEUWY2?=
 =?utf-8?B?dkRrc1RQeHdKU0ZLdEhCNFh3Z3g1d2c5Ry8rNEVRVFpsWTJqc3lCSy9IRWht?=
 =?utf-8?B?VlhCc0Y2MnVEcEdlampVeHF5YUR6dDZ4Mk93NkxWcnRkNWgyQm1oY2Jjc2l4?=
 =?utf-8?B?S0tGZFM1QSt5a0E2d241QTZJUmJzWi9jQjJ5UXBaL3NpVXhLVGN2WVJuQUYy?=
 =?utf-8?B?T2o2dlNKNVoweWlQM05ldkxqS3A0bmlTcjIyaVV0YWZIaUJWdDFiVGlYbkV3?=
 =?utf-8?B?K3ZaOTlRVCtLT3dsMnhzS0xSV0RyNGtvTmZvb2IvRmZxdStoMnVKTnQwcjdN?=
 =?utf-8?B?cFViSjZ1TmZJcUxVOThVNTN0Y2ZTaCt2V3VjY3RQNkxyTTlUQndMVU8ybjc3?=
 =?utf-8?B?YXlhTG1la0JIcG9nUjVsbjdQS3cyTGd1VjN5ZVI4UkFoN09wVlgrSkw4K00x?=
 =?utf-8?B?TjN6UWI1NFN0NEwzcFhKRWprZjBEaHlxaEpwSnVlV1NlRHVheGZNazdqeG9r?=
 =?utf-8?B?WDJVWkpPMlR0ZWlZcVN6VUNGVmltSXVIbE1ic3hXZ25UVExkUjhEeXJQeDZ2?=
 =?utf-8?B?UGJxYmxzVXBUNGF4WDN4My9oRzZCUVN4a3NFQUdQZHJKbWxPOGJhMms3cDJJ?=
 =?utf-8?B?UEo2RTdSQTlZSTdCVzF5cEtYYkw4R1E1OXZ1UGprU291dkdrSWZjemxveGF6?=
 =?utf-8?B?dlV6STBXM0x5dWQ3c1lKTFFEcTd1bjd0NkFWYVE4VHlqSmpNTUgyU0NBR3Nh?=
 =?utf-8?B?QzFTdnViMUwyQ2cyME9QTlVaRUdtTWNCMnRiaERkM2dsT1JqM0phY25KNjc1?=
 =?utf-8?B?VEtjeElZYXdTTmx6bTBldGVOd2tpMlNOUUpLSU9hNmpmVEJDZ0NPdVpGbFRr?=
 =?utf-8?B?WWxmS2o1Qkd3SnZRQjI3dnNZTCtialM0a2JFb3lRcjhIRVJXR3lOSGNRcUpi?=
 =?utf-8?B?ZmMvV2s2bW1HRW9yN3k4Z0hWd0RCSU9wdU9BSCtDUnQ1cGpDQlhZZXA3QktN?=
 =?utf-8?B?N21iczNRMXh2Vjg1cjZXemluNXNWU21QT0huUTdndkFySmRvZlVSU3NaTjQz?=
 =?utf-8?B?VHdiUU80YVJoTnZjV3VrQm4wV3RudGNKNitRMXJ6TjZ1YTY5d04zS0pkV0pP?=
 =?utf-8?B?alhsa3p2WVBlVjFxTzdZYUZMYk9rUUVMRWVKdENFZHIvaUxwaFlYTUhQZU1m?=
 =?utf-8?B?RjlNTnMwZmY5WWZhYnoyVUNpRE44Uk51TFZ6YWd6ZzQwbFRrNUJhMnlBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N09sZFNHNVpsZ1NCUDNhRVp3ZThLVjJQZkhGZUhPSlcra2QzQ05GRlNVUjVM?=
 =?utf-8?B?a1psVlZ5QXRsYnpIUElDNVRyQzJVc3h5VXRMVDZEeFJKczQzKytPUmtFMzhq?=
 =?utf-8?B?Smt3OWtmQk51bmVkM3JFTU1VNXNYZjMySUtvOHhqSzdJYWRDL09kUTY2eklH?=
 =?utf-8?B?eGJQakZtRVo1WktHZnlTcnRWQUNQYVdlZVBjMmQwN3cwSmlZTkVEcW1qSzdF?=
 =?utf-8?B?VEo1SWE0dVFSSzJPMnpBdTlDQld6UTAyemdxeVBkSzJhSlJXVE1Bcllzdzl3?=
 =?utf-8?B?QnlIbW9XWGtnTjI2eHhlNUwyUUVqeUNGdFpIZlUvZDhueFZZQUVEUWtqQ3hS?=
 =?utf-8?B?Wmkra2x0eFRYZHQ1ZVJOVHdUMWg0NTZJUHg4UnpCMjhCRGQyUTJ3VUtkSTFB?=
 =?utf-8?B?cG9vbm5VVzJSU2x3ZEx3dVNtNjJTZ0p2WlRwKzhCNmt3NUFOaWszMUxJRFlS?=
 =?utf-8?B?UWJtQk1MTHA4dWtHOVZTbTJMMi9OME9mQURpMENGWmdnQTZlcS9ObVVLQ0Ur?=
 =?utf-8?B?MG9OZk85ZlpmSGJsQUxiakl1VjhER0lsZHllZUtCMkkza0taaW9nZEZkRmpv?=
 =?utf-8?B?WE4zYkQ2MUxuNUwrdlBicktSN2JnZDRDRnducFhSRFY3Q1FyMlF2eDZPS2tI?=
 =?utf-8?B?QzN5YjNPUnN3ZnVOZXVTQXh0Wk1EUVJoU3dNd2pCbWlUQ2ppREpsNVFCTU1j?=
 =?utf-8?B?OW1oeWJ1b1lhZ2xLRklUaTNCRUJGRTZZWVQrOTFNQnVmSEFCT1NwcVprTWlP?=
 =?utf-8?B?NjVhUXphblorVzJ0STJNanJBdEhJQkxLMVN3alJOWmtSMFRIT055d090UTdI?=
 =?utf-8?B?M1hNQWludS90MzdrQU9MOVFxZlZlUWFTQzMrcEwwUVdKUEYzRVJ3aEk0ZnpH?=
 =?utf-8?B?Z3BFSDZ6MjJuRDdpaWVVVGRRanFHcG12Q3JicmFFVmttSHdtRGxlWHMveDY0?=
 =?utf-8?B?bm5NOUJxS1BERFNlNDZZUkpPVGlzK1pqSVBvVnlXNDQ3RURObmU0YktHMVJR?=
 =?utf-8?B?Y0srRnllM0VmZkUrZWsvdU52OE5qUUV6TTFTYkpZUzFJM3VFUFhTQTV4bmNT?=
 =?utf-8?B?NDZtOEd5T3hIc0xCajB4L3pEMzRLYk1PWmU0T2NPZEZwUDZlUkhpQ2ZIc1hG?=
 =?utf-8?B?R1cvTkZLMXlYUFBVaGNlS0d3Y1hYN0haang3VkwzaGdwajBZOVEzdndyZmhh?=
 =?utf-8?B?eTAxVXdyQ0U3clVqME4zUSsrWmVTYTV6QWhvNlIxVHlmeFd0c0xiM0J6OXNM?=
 =?utf-8?B?UTRsUkJIMklyUjNFU21BTThaZnJMYWs5SXZ6QmtTUjQ2V3RsTUZTdzlkR2tu?=
 =?utf-8?B?MklHcmNqaFAyVm9EM2lzdEcxWDBUNE43WUR6YWNIUUt5ZkhlbGljYyt4dGpy?=
 =?utf-8?B?NmMzYjhCcFFnMWlkNG0yajh1T21FVHB1dFZ2NmdCQ0FXS1pPMkZ0cXZPekcw?=
 =?utf-8?B?TGVNaEFmZTkrWHRPdWZxV2cydmxKU2NUYmVobUVpV2ZJSlVKeFp2N0RmRVEx?=
 =?utf-8?B?RFQ3WnJTbVVERjhhdG1haWMrS2JaWnJVd0tlYzJEa0NWODZIT0xkMGpVN0Rl?=
 =?utf-8?B?UHhvVUFaYVQyYWJGNjlXUk50NlRHc2NXYkpkdC9QSHhJbStIN3RNQ2lnMG00?=
 =?utf-8?B?ZFRlZUQzRy9EUklyK25RRithZHorZnVtbFNMbWdROUZRb2tuVC9BYktMNTNO?=
 =?utf-8?B?SDJSYTA5eS9QdzUwWVJ1bk1KSHlSU01VeWlZS1lweUs1VkxxOFh0M1M5aDJl?=
 =?utf-8?B?Sno4c0pjaVdEZmI5bnNIaUV0a2IxeE11RElZdlBjVVVwMjdlL0FiUnZxbkFG?=
 =?utf-8?B?V0p2NXFXNjlhUWRLMUlHNXpJTVducWFDbkhqeFhQcWkrNEl6UzVocWEzMlIx?=
 =?utf-8?B?UURIbjAxSTNkMEdia2ZGOTk2Y0JOV2dOZ0c2dnBibkYxcThmWUtBYWhDcm1I?=
 =?utf-8?B?TFNqaElOOGdzYVZPbUdadUIySGJpQmVoSFVzZWFKbWRWZXZ4aVRNWkxkYSty?=
 =?utf-8?B?cVU3bE5YVHp2NVpPd2tyQ3R4VnJyeEVGeFl5Nm9QdXRaUzAvYTlBbS9sdEdo?=
 =?utf-8?B?NGF1VldnNTNHcUI2MHNWNmxGbDlFNll5WjhHV0VxR2pjcUFVRkRMUUVYM2ht?=
 =?utf-8?Q?u3EaIlPhvLtYYIUpSVaZZLGYB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37802e34-8b0a-4a89-bfb6-08dc64293b9d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 06:39:03.7248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XgpK8VMFeHBrXD8/5Lp4bo0LVpGCqllGUAKUXI879ufrxK/PnZEFyG8e0AU6XkCq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7477



On 4/23/24 17:02, Sean Anderson wrote:
> On 4/23/24 02:25, Michal Simek wrote:
>>
>>
>> On 4/22/24 20:58, Sean Anderson wrote:
>>> The phy "type" is just the combination of protocol and instance, and is
>>> never used apart from that. Store the instance directly, instead of
>>> converting to a type first. No functional change intended.
>>>
>>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>>> ---
>>>
>>>    drivers/phy/xilinx/phy-zynqmp.c | 107 +++++++-------------------------
>>>    1 file changed, 24 insertions(+), 83 deletions(-)
>>>
>>> diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
>>> index f72c5257d712..b507ed4c3053 100644
>>> --- a/drivers/phy/xilinx/phy-zynqmp.c
>>> +++ b/drivers/phy/xilinx/phy-zynqmp.c
>>> @@ -146,22 +146,6 @@
>>>    /* Total number of controllers */
>>>    #define CONTROLLERS_PER_LANE        5
>>>    -/* Protocol Type parameters */
>>> -#define XPSGTR_TYPE_USB0        0  /* USB controller 0 */
>>> -#define XPSGTR_TYPE_USB1        1  /* USB controller 1 */
>>> -#define XPSGTR_TYPE_SATA_0        2  /* SATA controller lane 0 */
>>> -#define XPSGTR_TYPE_SATA_1        3  /* SATA controller lane 1 */
>>> -#define XPSGTR_TYPE_PCIE_0        4  /* PCIe controller lane 0 */
>>> -#define XPSGTR_TYPE_PCIE_1        5  /* PCIe controller lane 1 */
>>> -#define XPSGTR_TYPE_PCIE_2        6  /* PCIe controller lane 2 */
>>> -#define XPSGTR_TYPE_PCIE_3        7  /* PCIe controller lane 3 */
>>> -#define XPSGTR_TYPE_DP_0        8  /* Display Port controller lane 0 */
>>> -#define XPSGTR_TYPE_DP_1        9  /* Display Port controller lane 1 */
>>> -#define XPSGTR_TYPE_SGMII0        10 /* Ethernet SGMII controller 0 */
>>> -#define XPSGTR_TYPE_SGMII1        11 /* Ethernet SGMII controller 1 */
>>> -#define XPSGTR_TYPE_SGMII2        12 /* Ethernet SGMII controller 2 */
>>> -#define XPSGTR_TYPE_SGMII3        13 /* Ethernet SGMII controller 3 */
>>> -
>>>    /* Timeout values */
>>>    #define TIMEOUT_US            1000
>>>    @@ -184,7 +168,8 @@ struct xpsgtr_ssc {
>>>    /**
>>>     * struct xpsgtr_phy - representation of a lane
>>>     * @phy: pointer to the kernel PHY device
>>> - * @type: controller which uses this lane
>>> + * @instance: instance of the protocol type (such as the lane within a
>>> + *            protocol, or the USB/Ethernet controller)
>>>     * @lane: lane number
>>>     * @protocol: protocol in which the lane operates
>>>     * @skip_phy_init: skip phy_init() if true
>>> @@ -193,7 +178,7 @@ struct xpsgtr_ssc {
>>>     */
>>>    struct xpsgtr_phy {
>>>        struct phy *phy;
>>> -    u8 type;
>>> +    u8 instance;
>>>        u8 lane;
>>>        u8 protocol;
>>>        bool skip_phy_init;
>>> @@ -330,8 +315,8 @@ static int xpsgtr_wait_pll_lock(struct phy *phy)
>>>          if (ret == -ETIMEDOUT)
>>>            dev_err(gtr_dev->dev,
>>> -            "lane %u (type %u, protocol %u): PLL lock timeout\n",
>>> -            gtr_phy->lane, gtr_phy->type, gtr_phy->protocol);
>>> +            "lane %u (protocol %u, instance %u): PLL lock timeout\n",
>>> +            gtr_phy->lane, gtr_phy->protocol, gtr_phy->instance);
>>>          return ret;
>>>    }
>>> @@ -643,8 +628,7 @@ static int xpsgtr_phy_power_on(struct phy *phy)
>>>         * cumulating waits for both lanes. The user is expected to initialize
>>>         * lane 0 last.
>>>         */
>>> -    if (gtr_phy->protocol != ICM_PROTOCOL_DP ||
>>> -        gtr_phy->type == XPSGTR_TYPE_DP_0)
>>> +    if (gtr_phy->protocol != ICM_PROTOCOL_DP || !gtr_phy->instance)
>>>            ret = xpsgtr_wait_pll_lock(phy);
>>>          return ret;
>>> @@ -674,73 +658,33 @@ static const struct phy_ops xpsgtr_phyops = {
>>>     * OF Xlate Support
>>>     */
>>>    -/* Set the lane type and protocol based on the PHY type and instance number. */
>>> +/* Set the lane protocol and instance based on the PHY type and instance number. */
>>>    static int xpsgtr_set_lane_type(struct xpsgtr_phy *gtr_phy, u8 phy_type,
>>>                    unsigned int phy_instance)
>>>    {
>>>        unsigned int num_phy_types;
>>> -    const int *phy_types;
>>>          switch (phy_type) {
>>> -    case PHY_TYPE_SATA: {
>>> -        static const int types[] = {
>>> -            XPSGTR_TYPE_SATA_0,
>>> -            XPSGTR_TYPE_SATA_1,
>>> -        };
>>> -
>>> -        phy_types = types;
>>> -        num_phy_types = ARRAY_SIZE(types);
>>> +    case PHY_TYPE_SATA:
>>> +        num_phy_types = 2;
>>>            gtr_phy->protocol = ICM_PROTOCOL_SATA;
>>>            break;
>>> -    }
>>> -    case PHY_TYPE_USB3: {
>>> -        static const int types[] = {
>>> -            XPSGTR_TYPE_USB0,
>>> -            XPSGTR_TYPE_USB1,
>>> -        };
>>> -
>>> -        phy_types = types;
>>> -        num_phy_types = ARRAY_SIZE(types);
>>> +    case PHY_TYPE_USB3:
>>> +        num_phy_types = 2;
>>>            gtr_phy->protocol = ICM_PROTOCOL_USB;
>>>            break;
>>> -    }
>>> -    case PHY_TYPE_DP: {
>>> -        static const int types[] = {
>>> -            XPSGTR_TYPE_DP_0,
>>> -            XPSGTR_TYPE_DP_1,
>>> -        };
>>> -
>>> -        phy_types = types;
>>> -        num_phy_types = ARRAY_SIZE(types);
>>> +    case PHY_TYPE_DP:
>>> +        num_phy_types = 2;
>>>            gtr_phy->protocol = ICM_PROTOCOL_DP;
>>>            break;
>>> -    }
>>> -    case PHY_TYPE_PCIE: {
>>> -        static const int types[] = {
>>> -            XPSGTR_TYPE_PCIE_0,
>>> -            XPSGTR_TYPE_PCIE_1,
>>> -            XPSGTR_TYPE_PCIE_2,
>>> -            XPSGTR_TYPE_PCIE_3,
>>> -        };
>>> -
>>> -        phy_types = types;
>>> -        num_phy_types = ARRAY_SIZE(types);
>>> +    case PHY_TYPE_PCIE:
>>> +        num_phy_types = 4;
>>>            gtr_phy->protocol = ICM_PROTOCOL_PCIE;
>>>            break;
>>> -    }
>>> -    case PHY_TYPE_SGMII: {
>>> -        static const int types[] = {
>>> -            XPSGTR_TYPE_SGMII0,
>>> -            XPSGTR_TYPE_SGMII1,
>>> -            XPSGTR_TYPE_SGMII2,
>>> -            XPSGTR_TYPE_SGMII3,
>>> -        };
>>> -
>>> -        phy_types = types;
>>> -        num_phy_types = ARRAY_SIZE(types);
>>> +    case PHY_TYPE_SGMII:
>>> +        num_phy_types = 4;
>>>            gtr_phy->protocol = ICM_PROTOCOL_SGMII;
>>>            break;
>>> -    }
>>>        default:
>>>            return -EINVAL;
>>>        }
>>> @@ -748,7 +692,7 @@ static int xpsgtr_set_lane_type(struct xpsgtr_phy *gtr_phy, u8 phy_type,
>>>        if (phy_instance >= num_phy_types)
>>>            return -EINVAL;
>>>    -    gtr_phy->type = phy_types[phy_instance];
>>> +    gtr_phy->instance = phy_instance;
>>>        return 0;
>>>    }
>>>    @@ -756,14 +700,11 @@ static int xpsgtr_set_lane_type(struct xpsgtr_phy *gtr_phy, u8 phy_type,
>>>     * Valid combinations of controllers and lanes (Interconnect Matrix).
>>>     */
>>>    static const unsigned int icm_matrix[NUM_LANES][CONTROLLERS_PER_LANE] = {
>>> -    { XPSGTR_TYPE_PCIE_0, XPSGTR_TYPE_SATA_0, XPSGTR_TYPE_USB0,
>>> -        XPSGTR_TYPE_DP_1, XPSGTR_TYPE_SGMII0 },
>>> -    { XPSGTR_TYPE_PCIE_1, XPSGTR_TYPE_SATA_1, XPSGTR_TYPE_USB0,
>>> -        XPSGTR_TYPE_DP_0, XPSGTR_TYPE_SGMII1 },
>>> -    { XPSGTR_TYPE_PCIE_2, XPSGTR_TYPE_SATA_0, XPSGTR_TYPE_USB0,
>>> -        XPSGTR_TYPE_DP_1, XPSGTR_TYPE_SGMII2 },
>>> -    { XPSGTR_TYPE_PCIE_3, XPSGTR_TYPE_SATA_1, XPSGTR_TYPE_USB1,
>>> -        XPSGTR_TYPE_DP_0, XPSGTR_TYPE_SGMII3 }
>>> +    /* PCIe, SATA, USB, DP, SGMII */
>>> +    { 0, 0, 0, 1, 0 },
>>> +    { 1, 1, 0, 0, 1 },
>>> +    { 2, 0, 0, 1, 2 },
>>> +    { 3, 1, 1, 0, 3 },
>>
>>
>> Do you think that this is more understandable than was before?
> 
> Yes. This better matches the documentation. And now it is easier to
> programmatically access the index. Before we might have
> 
> protocol = ICM_PROTOCOL_USB
> type = XPSGTR_TYPE_USB0
> 
> and the instance is there in the type name, but we can't access it. Now
> we have
> 
> instance = 0
> 
> and it is easy to determine which instance we have.

Numbers itself means in PCIE, SATA and DP number of lanes used but there is only 
single controller.
In USB and SGMII case it is one lane per controller which is different 
information pointing to controller ID.

I didn't look at this driver for a while but at least for this array I would 
prefer to extend comment above to describe position of controllers and connected 
lanes and explain what that numbers really means.

Thanks,
Michal


