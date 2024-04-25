Return-Path: <linux-kernel+bounces-158883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4D98B2637
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F01C4B27D34
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C84A14D2B2;
	Thu, 25 Apr 2024 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="PFkC5eKS"
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2138.outbound.protection.outlook.com [40.107.122.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B541F14D281;
	Thu, 25 Apr 2024 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062025; cv=fail; b=IY2U+B+xyiTphkon7rzOEedus8Pn56H4WZukGbfVTXhG/vxHaceW4Z6scDxmfdPFpTD+Otu3A4gY+m/LdEHBRNcuqPHX1GHV5bCCxX/ZJDSn0+HYg2/Sz1BkImP40mFzk8AWL0Bram/qduNfJVqrUqNfbRv7B1YKE0x/FnUWA0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062025; c=relaxed/simple;
	bh=V4TmXVZe06bVg3MxGuPMPL5PUad6wJoIOFu5bIErTic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i+rkXwIfxkRdMJzhX4+PF2Q83VWvZJYJAmRuZfhaf0L3bJu29z+uKnojTU023elmzwVz9jsGL5l7UZCNnR2YyuP2b39SQyOrRsLrBSPsrzqfRiH6ID3EapooVZ6zpirdt69EPEyj8fWYtTkBnEryxL6G+7wsxGWK/pi/o/J0jSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=PFkC5eKS; arc=fail smtp.client-ip=40.107.122.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWnrXqsAvKfnZ3ySC3pucBvorc4o7SoAXAicdV4mRefK5JMIMH++b0w4m+Heiuttrbc9TxE3YMxJQX3wRJmukP6j/tIaTUH2k15isVq/Xf9Lkfo+ntEgqBhfEoYxEIIrnh6dBUzcAyeQDEKm6X5tdVa2GGLLSaOmF+1rcAgl0WLIwkKHrCCsVZcpnBVuK9RJXrewZGxbl0Ymu8miBSNHgHxMGuzxdCKT4dsUGWL06IaeLwOZJJFoThe8CaDdazKY0TjlH+IcKxB4px133g7WmcnFIRA2N07+q+fZoqcAaaK4UdfFjehWYif4Ei73aeAtDIbMoRJFl9TjdVJtATTQYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyoZazaRhnkLfJmtW0hIX7Gjev36GnuHZyUQrVpuKk0=;
 b=jWRD6BA79CnvEE8wStl++0FEA2nWji63W+h5qGJAXr1C+xgD/MaLnQRQncooxvme7Z7UbQiDSqdBMRHK1W9rR+OiYoIFMYGuE+1gKbJWVaP6z4YzvtEopRAT4Q+P48tnceSna8ipUOtQAG4v2CmlGSbk9gl9we86Ee3WYBCIF0rf60SyWKPxYXd9x9cacjQvwxRV6iVbn5pcZt+0+4ADPTQ9v27YTnsKkzvToDNx9eVkJEjoQErAj2pCucHdGn2StC/Ef7umWt53xLVT+IK08lRyB3O7MHUedPyMuyC5oHWX7U6/JmNq7tSjoIp0ArQXdz1Z5GH1HaJpOTuoKxBMkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyoZazaRhnkLfJmtW0hIX7Gjev36GnuHZyUQrVpuKk0=;
 b=PFkC5eKSoZ21NBU7qFw+cATzrzy6/tGZtUQihlZ6QZ2vAmxdpTYogxjddyv3rF+xYrkkUT/aRVReAiXK7JzIaEi9dgiwlpYSHAJIUt6cQal9Zx8iMvwVo3Gi4Dq71sMnPNZcM5S8Ap0YicqKgI4etYBhMBatyw5opd2Yd5YGiFw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LOYP265MB1872.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:f2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 16:20:20 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 16:20:20 +0000
Date: Thu, 25 Apr 2024 17:20:18 +0100
From: Gary Guo <gary@garyguo.net>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Alice Ryhl
 <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox
 <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton
 <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>,
 =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Andreas Hindborg
 <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arve =?UTF-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Todd Kjos
 <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes
 <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren
 Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, Trevor
 Gross <tmgross@umich.edu>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Christian
 Brauner <brauner@kernel.org>
Subject: Re: [PATCH v6 4/4] rust: add abstraction for `struct page`
Message-ID: <20240425172018.015e1afd@eugeo>
In-Reply-To: <ZiGlC5AtRRikE1AI@boqun-archlinux>
References: <20240418-alice-mm-v6-0-cb8f3e5d688f@google.com>
	<20240418-alice-mm-v6-4-cb8f3e5d688f@google.com>
	<ZiFsCLb-BZWbBHsu@boqun-archlinux>
	<87dc4cdf-ccf6-4b08-8915-313aad313f93@proton.me>
	<ZiGlC5AtRRikE1AI@boqun-archlinux>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0184.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::10) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LOYP265MB1872:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a6bba20-5763-4867-4808-08dc65439a5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0JXJD7d9vA3WU51OmTdGDbR8i6JSRNEdEFvecg7QZgKPKQoaHGzvdEaugTDQ?=
 =?us-ascii?Q?cVrIQVLTasRuuaEQhFtYwZf57KblPBe4oO3TyeolbUXqzrczAc3uLDehkvAo?=
 =?us-ascii?Q?IbFFr6hyszD4IGyZYRo7YUErfQn2nsjRxq/ymSx6oLZ59N7gfmSkEqov2zSN?=
 =?us-ascii?Q?ai9BKzTg39gi1c1Sd+Uuj+RI5KHFWTsrA1u789ADLktU73gJNIZqwwshDQKx?=
 =?us-ascii?Q?+YUiuzjHQoVgJYirdio4vTv3hitxW/V5iVRUI62R8Unh8HG1xCfIKwY/BOxC?=
 =?us-ascii?Q?fW3atFHDFt+oA2g7oT0xsWh+foephjtvZVS8+wOkW1gVm2saWtT5Gw48YLBS?=
 =?us-ascii?Q?3m+/W2Fedu6MvhiKZhLNJO+D5AWKwOuBOjk33o15CKF+lQMklLJx+NdADdE2?=
 =?us-ascii?Q?nzyfwXaUyxbk0UnRsGfL9HKYiCHSK/NSDEhD3KFuZ+K632Db+/JrdBBZNXE2?=
 =?us-ascii?Q?mvspa+EIMbMf90o/zB4bFTTAsnLekjLEVhGsDO3mo9WGFiW4C0u8JxWhOzeR?=
 =?us-ascii?Q?MmEf4CrfFszuJj5+8Gs0N+72SuHmwPUZqEEPi6PxF5p4zwA7XHV1Dk8eLjKh?=
 =?us-ascii?Q?/BKM3Wyi7bOm/VUbvwBtcsPO3dq4I3R1yLFwc5cQlruMe1R2skgvU3qQeSBM?=
 =?us-ascii?Q?a8OEWjZF3XxR7o9v8q4AP3eT/WPLCXMH6jg53ZJUWHkeetYS28/zHI7TD6UG?=
 =?us-ascii?Q?+ejM6oibsgvDoxT69TefWi5owCg0064r/MkwN5j3D98ouuCbq/QTcVhG2UC5?=
 =?us-ascii?Q?5vylqkQCgLGhyE2guocXWIEk8ntSOSGijcqcQ78PKiKcI0O8AjtstuOYXUh3?=
 =?us-ascii?Q?TiqdMKL5KCiYNR3d+SO9TbDXe8K84+LBrLnu5ZTg7SH+Vm61cNpAB+mgrpDD?=
 =?us-ascii?Q?L2YhRJF/zk1IizKN98XeKIpzFnfLgaTVhMbrZ+C/a8rMTpRclMEamrsQjMKR?=
 =?us-ascii?Q?4qVZUwqLQXDMs4gIQylhfGKR9YEN8cDieH4oy2QiPKitXozVb2UazB+Ey3ns?=
 =?us-ascii?Q?futL/Y9GsGUWtaJcbbNpOFFSzPOeQjOBVFzg4s5w7KPVV/F8fZEXrd7E2aBV?=
 =?us-ascii?Q?6CHKl5WldIq9BA4xHvpySKRC0UGO8DBj09xXadR4tGfJsB197WLKKf03HzvN?=
 =?us-ascii?Q?oQIshsYyNBF8GH3W9D0p+/TWwhgef7HADwkEMLxKXEOi9ktbDIp8GzggbFRv?=
 =?us-ascii?Q?4LO4WboenSEiVFTM+r609nSTvxvzo2IfuuBe8OH1P1XNzFqWzNmns19RSR5r?=
 =?us-ascii?Q?jKfywmZidR6Gs1vBRVgcKooMPmusDWyN44HQYOZGGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0bplDmqb9JLh9F17Q2BmWQzSJIy6tUqtGNm972LLzx3cTLY4bJCMatJJU4VX?=
 =?us-ascii?Q?qccoRAqNHyLHObQ3RvIRuAfVO5/TBFdF6SPOauqkvPBy5RTS+8igZpHE6QxP?=
 =?us-ascii?Q?AjrXt6O+taxsPjaQ/0qDLYZabuz6Mugj25rQ9xpW7dy1Evc01HIPamCMZBoi?=
 =?us-ascii?Q?9srtwYI+9dn6w0oaV+F1kgQNbgJOM1ZZ+6S1P4rvHHzes2xUsvNOxixepMCZ?=
 =?us-ascii?Q?HJ+OX6AmsU24HZKmTkn/07W1txaF909/YfRjOZTIupszNYxYiLVPaohnylfu?=
 =?us-ascii?Q?6IUAY0+a3c5BF9tPRjqicb0bEMC8xDnz5yTHFse9k7OUmuzHMS5JDqVUpqU/?=
 =?us-ascii?Q?mjKIkSTDZ/4Q8R3GyhSYJ7EXYEYhoql0Sk/U+3isJZGxUU6SRw8OJxZuEXc9?=
 =?us-ascii?Q?FDPSYC1p14FKMKkFpShTNpuhVOLy904HQL3SugXjCSyIqykhA+FtxifRBhVZ?=
 =?us-ascii?Q?5DMveBr+S+FO5EneE1DGGaZ315uzzw3Pw6INScD8VzFrvQvbdxPTlNTYjqBV?=
 =?us-ascii?Q?SyChcRRgaLKRCEzLMrti7sBICfLxKthZIHCQIlmtlFSvh2rb8eJcuRr+/Grz?=
 =?us-ascii?Q?t6mu+GTrbN35SExk+hwGD4Q5Q24vJHYDnJU4a6nbOYE7AGDUeUy9zN/CmzZg?=
 =?us-ascii?Q?RU+sQ9xTmQx7UnP0Vhd3623Zt7UThKJm+cT84xccq7Hvvq1fgDh7a44kaFcX?=
 =?us-ascii?Q?SU40sHwBym1gcVzkVqkAruOp0i2b5z0d3xav5JRy4mMkyqpG/h62OsGvHzUp?=
 =?us-ascii?Q?l8I4DK2L1YIsvwkBxx9lB8Zi19Fp66tUpWzONEyY5JIpNcoAuhI0hDwcZnM0?=
 =?us-ascii?Q?FBE+Q8fpBj+rLqM1asryh5hERNEKCg3sHN2Mr1lWR1DbpxqEOWy44BgbqmQb?=
 =?us-ascii?Q?Oe8gMSKIk8iWZuRkUqk5hW8HfA/UwPaqN9ikUDFJwbC/jq7b35zHMzuPZ1Uh?=
 =?us-ascii?Q?ZMmVDmr1EQa7PYhOKRwScJOkiEYXjl8SJloNTD5/BoG2ImQ2++LSZxIvWRf4?=
 =?us-ascii?Q?JbfFtlzOw1MuYTZnf32l7lLM5QCFBChdfO9U1VCFS27faMU8yknNVXt/hWVE?=
 =?us-ascii?Q?UcmAjyvwpvo5gLwQIRdGQJxoUcwHwDFGpR4IWzBZAvY50pGKW1pdvT4BUpy2?=
 =?us-ascii?Q?Xd0pfT33SJHyWv6Pw9UO9PT+uRX9tRSz4CwNJPQLuFVqfWWp9AvgpVVZTXyM?=
 =?us-ascii?Q?IsSd1I2VVrDNa8TFw0GBuhYPLRT3rgjhPchdg6Y7MDfjxcZZ3SGxhnYO3hb9?=
 =?us-ascii?Q?Me6UKOyQTRTr6dXXvE6GEfWdM8AARB2WxbwrRh6EQl++yavWQxZritILNWyZ?=
 =?us-ascii?Q?mY8irwXturpa7wGdyt8hmieo0dwL0wdNIeoyqj0WugdCFh9FvZCqucmts3AO?=
 =?us-ascii?Q?IYGKyzrG7LjfgpzuexGryYB+PBEERdjCBvCMizlaffLhWiqI8Q5bGZPwKQp8?=
 =?us-ascii?Q?TTh9H6eXU57+oz5cwfQHJW4F7gWBeaA2oaeKRzgYVayAjueTcrVNgz4PwLgG?=
 =?us-ascii?Q?gCO9yZVa0Xz5+2e4CUJBY6x64+gtVkp1UwxFahlRfn6IPHsvgOc53546k5nA?=
 =?us-ascii?Q?l3j7ap7x+zUHwBbl7CP0Ghd922IoMz4tELwG/viO?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a6bba20-5763-4867-4808-08dc65439a5e
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 16:20:20.8212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jiQ8ftvZnnrUtMReH8auCDPUcCpPjL7c2oKFp8HUJUHvJCsVIbKcu9lbUYaxQ3rmyEjhtwzJa6po4taXagN3rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB1872

On Thu, 18 Apr 2024 15:56:11 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:
 
> Hmm.. here is the thing, having `&UnsafeCell<[u8]>` means having a `*mut
> [u8]>`, and it should always be safe to get a "length" of `*mut [u8]`,  
> right? I haven't found any method doing that, but the length should be
> just a part of fat pointer, so I think getting that is a defined
> behavior. But maybe I'm missing something.

You can just use `unsafe_cell.get().len()`. `len` method exists on
raw slice pointers, gated by the `slice_ptr_len` feature, which will
be stable in 1.79.0.

Best,
Gary

