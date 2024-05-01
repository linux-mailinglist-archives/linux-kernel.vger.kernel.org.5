Return-Path: <linux-kernel+bounces-165640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463948B8EF8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 687911C20CDD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C057B18EB0;
	Wed,  1 May 2024 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Yc6/UG44"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2065.outbound.protection.outlook.com [40.92.90.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055DD182DF;
	Wed,  1 May 2024 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714584210; cv=fail; b=nkR9685iOXgKyU+1K7Qx84kSCLEq5FXon4eWgvOQG/nsqEkvYXO3lCgN2pW5RBd22VNFiF4HurBJrgGi8sQMI3p629TJ62jdQ9fL+ckvoYcCuTasO6czCj335VM2nfp4bGjXX6Syy4pWFJKXibu5tzFEU5B9auB1C/XMFX4r0PE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714584210; c=relaxed/simple;
	bh=TmwpVJ99AIxirytNYCVxO7YZB0W1wc2eGI5rruDJ2xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tom6UWJyucz4I5DKgY4/x5bwRt2KmB3naCZG3LqrM7m9x1tvZrBZNqhgpAPGSXAehmm54s+XLM6F6Vre+wmVfye+xP7231RC0xfafYvmaq1t6B/NWdnwGn9ajy/2d6vrWEROsBuPAnWE6Hj7BA7rZAVQEWqQSi+5w1yoGWl1bjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Yc6/UG44; arc=fail smtp.client-ip=40.92.90.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jk5nqF4TYAcejJfkfcPJgv20wBbKo/LbxxmdwzMIqgaOTAdfCuNBN3Tfx5PMPbPCFZV6oKJ+lJXNEjtHnJgY7j4I8XJgn9EaTQh9mb39pKJDEY6a6BwDWGTHSVkdQu8MH2PMs9aQPRy1pa7b3kR2A4euIg/UCUPOMxkK/Br+euDFbf0eJv9TohDSGRl7TVaslpQQRelc355rGAPTAInuqtRopmH2i9DdLVuVbDoD0H6SuHqPdQe9ZUb42xU/J1sj4puwyDw7ciqlyp0zrQ+PNllhcrlS3kb/Y0hEoq57S3KXhOUez3RoHwmhykhOOEg52lkT7qRBEetcBPJ8gFKLEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5L5iVfIZf/D47VfmLbuMnFPYH+LR66by4sa0YNzq1sA=;
 b=TosY+m0z7wftZ6hIFct0IkTItx7WUn815T3Zb4hmTFe1XeHzESU8DU+1LQsZRcnfQ5dI6V89W53+bNSyHake2DJP44wfSG8PwMCBLB5Lp9WIfb1zHleEjSY5bsHu9dVmn71QkFE4sNeQ1BnyxvrmPbbbMRqrV3lbXyRYV2WJFv/1pHL7y/coaAiF5/ntYNgR+GoueM4XAxhQb2SndHRMwuJp1hFxk5IOUhr8m+1fWAwkIKMH5b7k8kRKBe53Kd2qiNfcY4jGFRD1SoYlxoOn+DnlxygMLpD7RIQGIWngwndCNlzxSoJBEGalRLQt03L9UHQ6eEyntNaQ6YH9FKOVDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5L5iVfIZf/D47VfmLbuMnFPYH+LR66by4sa0YNzq1sA=;
 b=Yc6/UG44hgBDad2slc8NC5vlFKkJICHScTGhxUTakJSAtPWsVXXxSGVBh2gbbSokzsVodRJx2Fx4MdB3pCeP6Bx2yfyHgO+8pIyh1XWUG9Q6OBAbJ/0MWRG8NLYrx27VabdG29aDchyX8iTn+rL5hRXbLBb0I8gsuV2Oc7v3bXIWOXAcI3DKMd+z/ovsWVO2tEvPgL12jiPCJJ7neXkWfen/Qk57Wb0Vn/MCsWG+Cm7bHcSi88JheYIpqX3Yp5h9qWM3JiwL/KaIN0c74GwhxZBYCqccLz5m15Tndxjyq94t44fAF7NvGkr0BdbohVkGjFy5a/VJZWWRZn39zLsQJg==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by PAWPR02MB10396.eurprd02.prod.outlook.com (2603:10a6:102:343::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Wed, 1 May
 2024 17:23:26 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7519.035; Wed, 1 May 2024
 17:23:26 +0000
Date: Wed, 1 May 2024 19:23:23 +0200
From: Erick Archer <erick.archer@outlook.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Erick Archer <erick.archer@outlook.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] perf/ring_buffer: Prefer struct_size over open coded
 arithmetic
Message-ID:
 <AS8PR02MB7237ACFC7FF6858CF3C513238B192@AS8PR02MB7237.eurprd02.prod.outlook.com>
References: <AS8PR02MB72372AB065EA8340D960CCC48B1B2@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <20240430091504.GC40213@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430091504.GC40213@noisy.programming.kicks-ass.net>
X-TMN: [IrwAPLolCBEFwVCyn/bJdR0iM8sjJ/QS]
X-ClientProxiedBy: MA2P292CA0023.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::18)
 To AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID: <20240501172323.GB2735@titan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|PAWPR02MB10396:EE_
X-MS-Office365-Filtering-Correlation-Id: 5710c5d1-425a-49af-855f-08dc6a036915
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	ZKTkosxtt3VSbkee5kqeFfwRjOWTEhx2lYpmmg76VAKQL1pcfuWBstUR+GnCcwiLU80HvqRvsp/PhJftcCub8BXtaEksc7zY0vjVTgjT/7UVG0ALgnYeJSsSlRSXPi6DMVBxXnXgYRqjuWksr2z5H/Tg/0Zm//YqIVpfXGtUifrOZXIQLA/ePOI2tbGKLUtC+1S5CtCD6m/VfnqNu5hRuCqxnq5X3Ifi6UtrNlATdoNlwRBVzh/6QwYp8Hj6QBxv8CqW4AfzInWTtPNNAJGtBZ1LJM7EYq9ntYmsz2XRjysw+IPCkuQn06hMqsfQC5QuBM7HZjl1HrV+Fg5E9w43NgQQpWJpRMQvB/DLNKgwrPrgEitmwdXFLKxALzXNDMdIkECjSMO1NyeEJGcqMDP8LUM7aWliW0rjSq8IJxJL5A5F9REVMdoBxXThL/c9AgB0Y9odqJ492FFDv1HivDHjdYlkBZLttlDjY9c+DZAr4INt/5oWdtIaH9Vq8hBzA83G2ORctCtSHIsUxfy60Ijuzx/vPisnrjiD12tl1Vlj0ZpkIPaR5EUIgaObQ75nOTljEEJkI2keNScSnMIxlO3i1Rj/Int6bki6yAqRHACuVJHzCu099sINzlkPJijwq3aY
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nYMQwuQIzz+RlBg4w1nIGtR42aDB2hJzX2o/nq1Jz3oP+IGooXKuBdmTcVtd?=
 =?us-ascii?Q?je4drHKJSrlMWEMLlBGdQhq5KhDlQ4VzsX0kw3cyXJ7JnRnJBPCwgowGAzpJ?=
 =?us-ascii?Q?sAowHOBkfqmkvwmpgxXF21Qrgg5lD0w26JWHbZ/TDjFMc5AXj0MdPEhPFHEe?=
 =?us-ascii?Q?QD0oVFAO3a6mmO2AT9/DhnllwKqMR+egKrqoAnSohWuexlb2RRO1YRZK40tt?=
 =?us-ascii?Q?WNWc/pBSYJLw76JAVhLVlZG8fLxdaLl/myvhIulu4bp6o7ApCfFbEifYWC82?=
 =?us-ascii?Q?/ar6A6RVMrSphBDpGohFL+rRv3mKZQOAilccG8oWI1vTVZi7xBVr4F9Px9TH?=
 =?us-ascii?Q?WIyhsNIn1gjXiSpdog9cGB5TSNvoZfSKPbfFjJvI3WxypRd9rmO4UYz8W6WI?=
 =?us-ascii?Q?0ENC1VGQA/ngIfgSwr1JSCRJI4AF8uBJQnmK/qfRj226UouSCrFb5YUs/2Hr?=
 =?us-ascii?Q?z7BwrEJewDtFVMBZ/mivllJXES7TlynSxiPV9XxFIionMv0GyvWGYn9UtcrM?=
 =?us-ascii?Q?mE3gO6zgBD3SNgGI53wZS5mIdoldhzd9ITCMrFvPvpqavdLtoGqOxmvrZdJr?=
 =?us-ascii?Q?OYH4UxCsD5Hs5/2A05kZb2rXf+3oTWxyUgyJZOnGVyhww6vzTZ3AKqhMX96/?=
 =?us-ascii?Q?MZUXlZDH7hEV2nJvofKrFfUBGxQ3ZU80eW4WEN/GsZpl4HuCUPGhDJAuyNk5?=
 =?us-ascii?Q?IP23CDC9V//8DoIdFgF1ngXfGHxlI34xTJerf+KGFxfDntiK4ew4AFPAQ/Ak?=
 =?us-ascii?Q?HYbu1ebRfLEVo5MkCv4nuBC9Kbd2g3K4iRzSlHa4fKBBuozY0MuKuxXqu9xT?=
 =?us-ascii?Q?LwT/+n2Abfk89CwdKooFfvWgyYljuPf/3rkRMDJeZuib6U0JsxgGfya+9tfM?=
 =?us-ascii?Q?sHlEj/xhmFPWYXKZ6WbTDLwpL8zEAHrwBl0FS6ECvPP0uuKwzFoTpw+fmTCi?=
 =?us-ascii?Q?JmfG8UJI91G2UW/TJYwbV+kR+bgvbU0lh/WnEkGh2yt9J/ZJsLn5JbuXueod?=
 =?us-ascii?Q?DTrpbMyvRFnCBEe/LCLeUQGFd4hkyKOzuuY18Uks54R3P3PaXuwykQgvuD+2?=
 =?us-ascii?Q?O3b6FtadbipDSk0yEuONQDCrScopxMUgT5609YV/wqQxVJ5b67EtuJorJ8UF?=
 =?us-ascii?Q?ELAtkn4gOLVBtkfGS7C79cscR8Ax2xD8Jeuc9dqr48w4KP6P7UqfmblVyr3n?=
 =?us-ascii?Q?/bMjjul6DvqHtaqFwVFzBV06KzVH8v8zYk3aizOxIDP+G3HblhxKGGpew/D5?=
 =?us-ascii?Q?MaA6GxclkQ64sNLkziho?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5710c5d1-425a-49af-855f-08dc6a036915
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 17:23:26.1737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR02MB10396

On Tue, Apr 30, 2024 at 11:15:04AM +0200, Peter Zijlstra wrote:
> On Mon, Apr 29, 2024 at 07:40:58PM +0200, Erick Archer wrote:
> > This is an effort to get rid of all multiplications from allocation
> > functions in order to prevent integer overflows [1][2].
> 
> So personally I detest struct_size() because I can never remember wtf it
> does, whereas the code it replaces is simple and straight forward :/

Ok, I accept what you say. Anyway, I think it's a matter of preference ;)

If I prepare a patch with the changes suggested by Kees to gain coverage
of the __counted_by attribute, will it have a chance of being accepted?

Are there any guidelines related to this attribute, such as in the case
of the struct_size() helper?

Regards,
Erick

