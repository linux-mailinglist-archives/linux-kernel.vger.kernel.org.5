Return-Path: <linux-kernel+bounces-161057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA448B467E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 15:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EB151F231BA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 13:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880B54F616;
	Sat, 27 Apr 2024 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Z8L6Xtlu"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2071.outbound.protection.outlook.com [40.92.90.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5BA4D5AC;
	Sat, 27 Apr 2024 13:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714225686; cv=fail; b=O7X9L7MKhSdEev2Y44DSp6B75czTh4f6YRHTkxIjRnHVeYxEvbUaV/TER5QxpNJ9CkUY5gL4dReszyeuXC5sn9Nbzw5dKm33cR1EDf9BTVcenvTC+Yc81nwwNkIufARd2QcdjaGdG/WxmfgaPymcdCMT0EjilHpRg6J3eE4yzLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714225686; c=relaxed/simple;
	bh=o47XltJlQDmFSNvSHULmF7lh/D75shUp0ue62dTz8Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y/u/E2MGLKdkaOxBatpcrApj6HKNioUaF6bw8hU6wLURNLZ8NRMiN1lbaFyHPGDDHMGwxIqg1JntTNWdeVd5zZtekXC6ayafmzd05WhmUiA/1UQVsziPk40Ywe6/u8CfSNOgvhlG5zv9JZqubtQdF68ucplM6Jmh7s9nURWi+l8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Z8L6Xtlu; arc=fail smtp.client-ip=40.92.90.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWmTlqVrpEgjlOzX+K8HsJ92TVKw38wtNazyWG1WOZgGDQHhUlB1o5nrydK7aDzHfUQNnXnAXltmA7g+ji4mP/XH33g+qUU0d7buEUvheL7s2aMlCNgNHzn4WxNE0IRVcyZUTsMmW/WfXuWDi8/X4gwG0WRXsVGr5m9UCuJef9vcbgYB3brPnvpvQOkHVt76OfKstujSKDnX2l9zDe+om8lZOlaIbhXG4NeXUwocNgLMkUliHWkSni4xSj+gwPATn5/A+vP68p1ULBxUMHpA7+kTuvc6ULvkQZ+yt6Nd95qYjvDwSGxfzc2N7Km4HUGJXF2YretiZ9sVdwxRjsX0xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8EivwSD21Y6PH4ZYZB/K414e3hqNm4AP78Om/A6Cb0=;
 b=JdfXaXO8FQ+9gJexeNYMMXTRjhEz1MDMX4wtrrT5Fzmof/eMCEJ3ewS1+nUJKooZqNeilqhr6kT+KVrgiCT0RbqHnO0Fo9LeMhhCFkGAO08RMTUnSy02hNxiL6xlvmwcyXUsh004IUhyKA3dML3SG4N+EqsPdz9TGwzgesMB+SJBetrj2n32+UhAQ4oBvfbjPY8zpuOXOslFbTqW5fKpbHn8Mocwtr7D3mzJP9eVOQGyGKjxUnDj/araS4gMTBywa4cZrLvEakjAacsBFXFNeTSjXLlguU3rhimCV3vIM5NehHYaKAVlseYD5yl8zFBY44cwlpoJqadMEZwbI59GTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8EivwSD21Y6PH4ZYZB/K414e3hqNm4AP78Om/A6Cb0=;
 b=Z8L6XtluRPAmZQM9Wmst0HrtTHPC1M7C7RVlQ14ekXKzr4czKb6WNNi3vPAUUJ6N7ZjqpiLHG+F/WHRTlAvJ9DEoBOwme4qXjoNHDlUXhKOTWNGXePzVcENA1HxhZoEuSQNwSQ9QgAy0+crY02b+GIoycKCMHzib6ApksQd9/bvdzD+LfVWUTz0Ls1FHgJ12VuruLiqrmr6BmRoc3SKSjrG0nbS8qn/8rhMXhS/KrkUyQoqkb7BfL7cLVCHK+uoAiEVXBBnUQ0QGd0+SQgGPmnrcolh3aFQ47RgGpdjP0t9kqxXzwFfWomMu79Xhb0qFFk7slTkJpUCeWoTxbHrcYQ==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by AM7PR02MB5784.eurprd02.prod.outlook.com (2603:10a6:20b:de::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31; Sat, 27 Apr
 2024 13:48:02 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7519.030; Sat, 27 Apr 2024
 13:48:02 +0000
Date: Sat, 27 Apr 2024 15:47:50 +0200
From: Erick Archer <erick.archer@outlook.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Erick Archer <erick.archer@outlook.com>, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] perf/x86/intel/uncore: Prefer struct_size over open
 coded arithmetic
Message-ID:
 <AS8PR02MB72373EC62275356B5FC03DAB8B152@AS8PR02MB7237.eurprd02.prod.outlook.com>
References: <AS8PR02MB7237F4D39BF6AA0FF40E91638B392@AS8PR02MB7237.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB7237F4D39BF6AA0FF40E91638B392@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-TMN: [kyLYUGfwyyr3H5IPHF0bO7S04yoch820]
X-ClientProxiedBy: MA2P292CA0018.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::8)
 To AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID: <20240427134750.GA2476@titan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|AM7PR02MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: ff9d9b4a-924d-4d13-a78e-08dc66c0a7e3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1602099003|1710799017;
X-Microsoft-Antispam-Message-Info:
	zi3HcDV0SnIx/8R5zCQIvDMdBdUfdbr92drDkTUw8NiSmP+cFTjvuT4Mrry9mVpUbMX27Ezk+d1ZYDP1Txoz5/Z5K48BZSQ6miIr7cLYtZ9YEVxmD7k2W2p2Gv03IvWy0QZt8+1ZhQr++XGhJWE1gHqDJ+ewT34j7twxBHDy0gCK462qb2trlPota3TehOaLj/O0cjgwdEw7C56guSNCWI9DtmQ5xdSyyIHapalXfHsE9TVskzxRQ/0ohQijls2n0u2L4RZ2708rpPgTR/9BiaI9xDBJoA2USiqB5LGFzHiRLwVFbbQ4iaA9AFfcPf+tPiTNHATuMW3CPr8pazsIflfSha3MTn2F92qC9iHjQ5HhWFNDZ+34oC/YrNZu7ZgownzekeSBr9gCyjovhW5PrA7SUkyGHcLNiY9GAaBzdH0vUZVOYkb4b8Gu5ER4iWMdOL2DlPaYMTgoZvHMif8lU2dW3Ey7gBt5TtWK7jrTqoPBIADaym+EPe+q2BBiPz6bxxbfxIysNy15KQb26TMjNsqkE0Q4RDwaYlfju6t0LhzFhB5SQ0w7g2Vl7IlNIobmDfK58UBL+BxDVyBupKukiuc9LqTQpIiBjKEHBd/l4WLwJu8I/1sqzGZq4Vr7Hmj+Jwli9inUdYNxT7AmwBUGIFts3Dd2ppq5tEM0VjLFmDCfGGOA137jgobrBJS7cJi9YXvPsI/XLoBACwtoJ/kw+g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?trYTtSNTwmrMpgOaJihzdUtNJq7BnWS9kIUYuUPjP6Ph9svRvPdz58JRoXxC?=
 =?us-ascii?Q?HIh8JDwLm+7cHJzSiuB9pE+2wN5hKriJ4LVYXtf9qtenW033Ivr5kOJ/b/Rp?=
 =?us-ascii?Q?KTa116sQKmYuwiz1vuITnkRXr1e7vw92pHgqvgb6N0mf/9yHgI0ObWWxEceD?=
 =?us-ascii?Q?7C3ztLthR4HrMHwBzWyxuvF/1vGi1vP1GH+y5Yvu57B0ViUyITI4ZwApqxml?=
 =?us-ascii?Q?YNLydkok5mkrR/1isb0J7ypXcObMAQlpRgdv/3+yXP07XUx92h9SzopkPIET?=
 =?us-ascii?Q?c7+B45bS1Q0PHWJxWiydnHXW8L91zYwh342Jv7sXj1uAoVonqGbaMytCmNy2?=
 =?us-ascii?Q?lzwQLNYh6WaR0UIbztzALv3QBvVYv/SzZ6V1qMECAWfJn/RKlWSvvYuTp4mL?=
 =?us-ascii?Q?gQDis56HwppLs4AWqHn8GfRTAjlMeUZS/eisD9TJs/wa6dVfsl8xk4jU8Wne?=
 =?us-ascii?Q?oERQ8d4wnyBK8A0Rg/6Hp1Cen/rcKl3s6sUB/WMuXp2tjnLWHezYzLL8E4Qq?=
 =?us-ascii?Q?wZCSORtmto2lvcSa8t74opDqc+abVqAfNQ7BOl5GQnlT7n1iFVysaRjG8Ul1?=
 =?us-ascii?Q?hxptK7Fl8x8dspFLKS1Po08RRuY508GdHI8QOrH7TIVjqewvB+WJ0S561cw3?=
 =?us-ascii?Q?CsiaDQLQMLYoMFHkfEvdPHKu1yh1/D+VoedQ/ddxm2f6ytdE01kroXW4PzG+?=
 =?us-ascii?Q?JbkaORIjSfDXgpob7OextEUeEp2knaurXVPeZd8O84CVKAm8vuHF+EJV078p?=
 =?us-ascii?Q?AE/cQEL96c9CUP7GHm9NgSUC4giLoRhHbxA51qmXZkf/S7wonmuniQHQdrON?=
 =?us-ascii?Q?UjArztSV5tyCKBbxeqHuWAFi7i6KtlLsHap0lusRMhGCXL4SeTLbUD6NR3vo?=
 =?us-ascii?Q?IMI+N1Wr7+xemEsKJztm9fhAWTUeDofblNUgQqbfXBNBaOiKu64yCXisXVe0?=
 =?us-ascii?Q?hNXaruiKWyel7rJDB9vApTD+MGQSPyT2X5+YE8BODir4kp/mNtpat/H66f6H?=
 =?us-ascii?Q?t4VHGwRVLIIhYK0nXVqZKyVDIzqEwWEW8z9TP7WtpWe0ShcWXm8VapcRfn+b?=
 =?us-ascii?Q?S2UCBBgK9wYSerGvINjaEhPybkt2RVfsmCn4wmEFWSgqVOSW0Bi8s/YkyWl8?=
 =?us-ascii?Q?T7ziKE2IcUCsflhNvZw0OLaH5Ng2lbt2l1TxHQlaFbA4WpFo0pg2FreQ+Mvy?=
 =?us-ascii?Q?xf0FoeRJrkQRfxX7JZuk1E/e1YWD2aVkWoPrR9cIyj0jH9/FukwHbZQCDiK5?=
 =?us-ascii?Q?Q56JRGzJ3C6sLrWilLeR?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff9d9b4a-924d-4d13-a78e-08dc66c0a7e3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2024 13:48:01.9438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB5784

On Sat, Mar 30, 2024 at 03:32:59PM +0100, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1][2].
> 
> As the "box" variable is a pointer to "struct intel_uncore_box" and
> this structure ends in a flexible array:
> 
> struct intel_uncore_box {
> 	[...]
> 	struct intel_uncore_extra_reg shared_regs[];
> };
> 
> the preferred way in the kernel is to use the struct_size() helper to
> do the arithmetic instead of the calculation "size + count * size" in
> the kzalloc_node() function.
> 
> This way, the code is more readable and safer.
> 
> This code was detected with the help of Coccinelle, and audited and
> modified manually.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/160 [2]
> Signed-off-by: Erick Archer <erick.archer@outlook.com>

Friendly ping. Any comments?

Regards,
Erick

