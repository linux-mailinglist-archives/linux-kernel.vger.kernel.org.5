Return-Path: <linux-kernel+bounces-162246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D918B5877
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997891C217EF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F88E5490C;
	Mon, 29 Apr 2024 12:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="bFFAk7gJ"
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11020002.outbound.protection.outlook.com [52.101.196.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5593754743;
	Mon, 29 Apr 2024 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714393464; cv=fail; b=sl5cKxG72d5BqAKn/i3zgMosayKnYuLm3zDvzzPZJAo78i+l9/sEs0GpYHHg6pDGFMLUanwL5Y7b/7gbIOqVL+O8qwuQrF+e4dZO+ZmznyibrhBgnafq59x3Q0zATdL3nisFRTugiyy0jYBGskFED8sEdSe15hrJyL0mng9xpFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714393464; c=relaxed/simple;
	bh=b5bjTb/A32yUhU8OdsQsM4ffPfJ1WF0MJd8vQV8VT6s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U915E2VgPbN3pri8VpQrVX5RYV8IaoXleIqk/lEAOMkiVbBzxF3b0ppBxgQiNcigR07Ak1HLY20N1NJ3cfg+unrHZzh8KOh+VuM8G3ifNwLABjzytFEyrBMoQk4AEXI5/4E4j8ENysYjQ3j7zXcHe+4+P96Y98UApsWf0yZlgJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=bFFAk7gJ; arc=fail smtp.client-ip=52.101.196.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+aNnhPC/LhEPM6zz+R7vWIgpnT63QPjFOVgU48GWpYAbk4tAmRmeStePXjHnFYt8p5PGlP0dMmC+svSyA8KnI14USDm0iIzcTMgqomRTUmPkEC7yRrwuk+bNBFbq9DM29rl7DhQH1MpNlXphZSIkmxA6augqOsISIUYb+1tSjYMcOpNQBDPXMhimghpB+ZK39mPl2Khpic0OymnKVazZrK1pU5yFxMwTKP38g0JKBPFqLeDt7XXG80FAYP+gYOmPCYUff7gIoxSZVyd/iXCutp/ZgHvKJXaYBWUPacuRBsX/SRm0z0m+9lP5qRmQMyi3Foe6TFgIkCyPqHkmsRdCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jMQyN0LbbbZz064ZdtXIzr0cLADfmjVzx7B5fQ2HCo=;
 b=Wx7wTzqfvK3VB1/zjt1iX2PsyM56pXzyVLCmkUBfhan6qGW9DpA4gHMRJpEkrAgKBRf3XmyxjwceDfA7lICXbWtq0hr5okgjpSz2/X6lyOnL6JUYCs6LnppcrR98HmLMTJ6XYy1+LsglGuQA4+XS5Wakjg/KbZgL79ojknUBvY6QJVHQJl6VtgiT7NcK1x4DRAwD/sjoMV6Uqy2Fm70NNOj6OzXroPzXOINKvwoPXTq67IkaIV8sm3Dr20Z34IPIyzbsGlebVZkb6FYNEPTGusKBDE0Ew5fy/8dx+YDUkcRIPtxpVmKePc0ziLsbZPk8LE9FSbnAaG1X5LuYlOFVSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jMQyN0LbbbZz064ZdtXIzr0cLADfmjVzx7B5fQ2HCo=;
 b=bFFAk7gJVCl7A/NI3zr6CRnEsZZ4+sXQYHPkBaW3TWjm9Ad81TCqc10CiAs/QfopzlFKV8NEd8x2ETRBAXftwvfhIL6uvBNEl5cZzVTuAhtmZiTV9oTJkZ63nXUZkz8SiAjBgapQSBArNblHzDYUnUmvuPcLb3DV3TYcExJ57A8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB3070.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:179::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 12:24:19 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 12:24:19 +0000
Date: Mon, 29 Apr 2024 13:24:15 +0100
From: Gary Guo <gary@garyguo.net>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>,
 Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: init: add re-initialization functions
Message-ID: <20240429132415.3039940d@eugeo>
In-Reply-To: <20240425213419.3904105-2-benno.lossin@proton.me>
References: <20240425213419.3904105-1-benno.lossin@proton.me>
	<20240425213419.3904105-2-benno.lossin@proton.me>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0256.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::9) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB3070:EE_
X-MS-Office365-Filtering-Correlation-Id: 852f5cfc-edfb-4960-0ea4-08dc68474ad7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tHg8AIjITtHll5JBKdkDoj0agXzuxqjb3+h6HOUrjc16jb37pQzGdL/DYe0m?=
 =?us-ascii?Q?cAgeH6b5+bgyJr6aazelv5d8Poz4MgCoPfpr1d28sYfBYVOYwGN5cGzt0ujt?=
 =?us-ascii?Q?JzamOLpMtTkM6Ya6Y5eTbqwNmR2e1N3GpyU7j1citKz5dcO2KZj5ztPXx+wK?=
 =?us-ascii?Q?dCrUr52D0tz8peGUyNW7Fmg8UpPVe0P6qXevGOnFG0B5Nzy7SpoSXpaYMZQ5?=
 =?us-ascii?Q?MDNaU385kOriafpRXf5/+PEeM3S9XOZru7WuGnUCOQ6rhhXKBxGOlYHSqVdf?=
 =?us-ascii?Q?QEKVJsBKaFAPvc7JwGXCs2SG6DWtbcOZk76n/hptA7Mi7Aco449EfRqJp+8p?=
 =?us-ascii?Q?icSR0nELtUEdmDUNLOle6KNqkDHsSjwzU/4i5YnC+oq2E8lDaGmK8hgQBCb+?=
 =?us-ascii?Q?/kBYClCMGDTczs217MLG2gwLPDdfKFqLkFS/eNpNbpge0o02C92wL6PhaKgN?=
 =?us-ascii?Q?j1DPJw/Ri7wdAusW7Kys1mUCIzZVpd/oRWEMGiWEw2CLcKxAw7OlRf+cjabB?=
 =?us-ascii?Q?4hckfkHcNKo3Rk0Da4od3oZEdbI3ru/xlK4v1FTP6g+lRC0PKj+AtUgJtoNB?=
 =?us-ascii?Q?WE1bjumPlpwbdmAH50aPNhCrbiGzJmjeFyOsCp0OOMNtZwv99gcaCvCYxGOe?=
 =?us-ascii?Q?QX3XdutVqC4Jami2uW2p9g/B9Ne46nafg6SgdUumF7yTdl4ev46/ll04E5Lp?=
 =?us-ascii?Q?V63LwC7BYlADywRiMBtgwI7OTIEUVgYu5T24KrfcWVr91HYc/XltejizdBPJ?=
 =?us-ascii?Q?0dKE7UWXagFgHq41fw83GzAkX6QzmijUO8wpu7cCju0RuzcrBsj2m8XWuyYm?=
 =?us-ascii?Q?hB3uROjxwbzDP0l1Z9xYEwiFfQNl9s/egM1/kfuWLn3gGX0oJ4PnTrJEJcUx?=
 =?us-ascii?Q?X4DPwD2pPwjTK9va2WGV3gVCUiQE7XCYVedfT+BRjEsGBMLoh+D4VFHsW8jA?=
 =?us-ascii?Q?fJLn08d8qkbHBejIQzCEolJ2xf6Z6bLsXy8aqcDm5mspwxE+s7XwIv33FM/B?=
 =?us-ascii?Q?6SuZ4dBw9UhgKVMT+bHlZIhh/QZCZA3IuCNV0fN5N/XkvIx4e50i0hgv+ftj?=
 =?us-ascii?Q?okVvClEv31fP+OoGRSZkJt/fabbYpabi0Ky2lPg+uTS0i6NDV+667gdW+BiN?=
 =?us-ascii?Q?x3zMBxa4SbySl6jINrY38Aa60cII0voQeioH2yUxel3EwG5jZAGkJjlBdF/Q?=
 =?us-ascii?Q?JXuOCwPkT84F5T6pHTG92YaZOLD1wfmbcEYGg/55c32AkAuUDIwv+dDFoSD4?=
 =?us-ascii?Q?QGGlnDYXRPCHgRGgnEiPLyVP5IH6PfRUeknmli3EeA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MN7cL+YSGjEMi2mMRIdoblRdOGabtiT/sffQM7w2BfDAwkCjTWOQPAv0F4at?=
 =?us-ascii?Q?CHpklDmNhlrGQSZhvFc1qzkXW3772DiEHxqGFGaaKtXvjFH9s061yiZf4TcJ?=
 =?us-ascii?Q?8B55GjV4IjNAzMm4u7wwW1LB3oV5sy23obo1MWBwu2vPbNSRm99ms573VmL0?=
 =?us-ascii?Q?0cyXJ+cVuxKeq/whrysrFIY2zyvl89lNhYtvpXn7auC2pqi6cNNoiKze9S4/?=
 =?us-ascii?Q?9EZNJgW2Qy4lt/3USVPgbYllCA19cKXXZSsL50toDYyBL3HSduOTZ2oku6gz?=
 =?us-ascii?Q?BYAYmbivkVQKbBgRcVUfgHCD/479KNBEQKg1ZOd7aM068y7Q6HV6iHuqiDFR?=
 =?us-ascii?Q?bVq9kr3ahbtvURHzuA6urtv0DPJwDZ1GuIyL3M2kEDOY5W9Z3mwPHjWHHVQO?=
 =?us-ascii?Q?/8uMh08Wdi098E9A2voFLw85LT75E3CCQR44OUBMhoBYGGVvGUWS90snmlwu?=
 =?us-ascii?Q?9idk2xqzPhqifpt3wQP/QlgtM6qU4x80w1WkaC8y16omEMJ8IjrRpr+kcXki?=
 =?us-ascii?Q?ycfWxKqNhr0Qq9VvohTsB2x1YfMR4AWZ6Yofd/8N2f1v0DjOHZGbtpM2OO19?=
 =?us-ascii?Q?TFZSsXPBP6v22I6o+vS7PsC4i8DHKEjW2ThC3Rnvz0ukGRS+VRok3nCiGVtk?=
 =?us-ascii?Q?HBKPQIO8slCItiqa2+DcZaApSl19mG2CHF6A9BWm+c85TC6DquYCVXpSdWJm?=
 =?us-ascii?Q?zB0D04AJkGnrAOssNGIqB4luZ2OngbAHahd0QhCbB/gCUkXFaxYWOkBM6LoE?=
 =?us-ascii?Q?CTqnxV0YnhmU96ci1j5OB/Qk0HVfNdpOQYqSGhkWLq45e4eQrVGrfoSrQDwG?=
 =?us-ascii?Q?8N4j8Nef5XA+hzIKRINCo2am0Dtx6TkLaCVrVFKhGkeLL97nG6m5nUhhbsO+?=
 =?us-ascii?Q?LHTIoQzFO2F9XQstJ/G4sAfxnnJhz9nUUhF3ryR2ZiBTaKVQzGywAopxLdT8?=
 =?us-ascii?Q?C9PRMNsvlqR9oiKxBWJ1n7Muu+HAXnaSBmOxJoHAsPzeKVDE0qrQvE+SGFpy?=
 =?us-ascii?Q?jzl4vltTO4PgAU3Yhkh7pKSY5X2SKVaOLB45ksNOUFxY07LDSL1atl/OxPnD?=
 =?us-ascii?Q?yaiXNfP4TD/59ygj37orvuE2su4YyZ4zZzClcMMp8aCts07JfZ0atIs0i0GH?=
 =?us-ascii?Q?450WRtCGGZSOUK8/kzRdl2vfpqksOIl2wV2YZUGA0ipSZDCg5f4cLlqXJyhL?=
 =?us-ascii?Q?FDExYmIq+QVlqz8ZGEWYHLintuCCdgpH6/qOld8ILneL4SwaGOIcecNycZjH?=
 =?us-ascii?Q?4XX3aAY12tuFZZzlNkfYaeTbnxLCKhYw4EQ/FlmscZWhyXpW/AIbQjmqPNhx?=
 =?us-ascii?Q?96qMgXwt8V3yvZmV3pfeG8vGCgh7BQ8Fs/Xyxr6oInDZPQWg9VylM+x57c3U?=
 =?us-ascii?Q?L9bP6DlOO/6bc7dJtJUCVfyiWLWc9z/pxFd1bSeBrFKmeiI93TmX9irWECNd?=
 =?us-ascii?Q?FcvHcCWUqV36ET6VTWdQ/NCeWFM1IkI1LCEhRg/dMYohuwRKFgiPFPAdj5G2?=
 =?us-ascii?Q?WMBcwY4rXI8PDq+nIZrlzgspZGuapiSvKWPl+tUznriYskNnzn1xIQwD0IsD?=
 =?us-ascii?Q?/02t+VSyITvEwilnEPx0rejY0hVfDRTFxm0BxAnY?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 852f5cfc-edfb-4960-0ea4-08dc68474ad7
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 12:24:18.9424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJP4OYn2t9YqTmjU4YmNLoi4IoDplOil7EOa+inm/7YjHg/cvomqDHGezS5mIf5ib211MnrBJdIkD25gV62Ivg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3070

On Thu, 25 Apr 2024 21:34:44 +0000
Benno Lossin <benno.lossin@proton.me> wrote:

> Sometimes it is necessary to split allocation and initialization into
> two steps. One such situation is when reusing existing allocations
> obtained via `Box::drop_contents`. See [1] for an example.
> In order to support this use case add `re_[pin_]init` functions to the
> pin-init API. These functions operate on already allocated smart
> pointers that contain `MaybeUninit<T>`.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://lore.kernel.org/rust-for-linux/f026532f-8594-4f18-9aa5-57ad3f5bc592@proton.me/ [1]


I don't find the re_init name very intuitive. From the name I would
imagine these functions be taking a `Box<T>` and a `impl Init<T, E>`,
dropping the content and produces a `Box<T>` again.

Would it make more to rename the existing functions to have `new` in
their name to indiciate that they allocate, e.g. `pin_new`, and have
these functions that only does initialisation `init`/`pin_init`?

Best,
Gary

