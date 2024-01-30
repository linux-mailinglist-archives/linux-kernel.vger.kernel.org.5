Return-Path: <linux-kernel+bounces-45236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A84842D73
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0DE21F21E83
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5078771B36;
	Tue, 30 Jan 2024 19:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tMG0M1ZP"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F5E69E00;
	Tue, 30 Jan 2024 19:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706644763; cv=fail; b=DJomgCPGF368zC0ZwxySHw5rkPdagFeSmTZiFR1l5iVHM+GgWAdbivk1N+sUVl8qp7xHohmEQYjPkYaN2JOqIB5O6HNINu9eW9gy+0fW262bW6FSzwcVbja8mx0gF0YIlU6n3faz2JbNDcZVtp0/HUlNGwAHdxiWi8pnRnjzOGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706644763; c=relaxed/simple;
	bh=hHuaJC4fNifHg5zQXe4EQIbpQsldScNXCjAu5daa5g0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tqALOBM5/c9zait+C6ukNNMFHInDLpaUxSMRdy0/F5lLG1i94wyzPqTfjqPLvnMU3rQYIR4t8+XDXWL8/YGmYEhxASVUoUuCTUSP14G6nbyKmPsgNd83S5p91vKlvkJHOylkY4hApwYidid/TlTkpi+z9tr+6tNC4N9nqoNb2h8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tMG0M1ZP; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnkLj4xFI3Qu5s0rhtTlWFLYCRblN07MHQN9Naj9u6FS/NZdZlX/dPVVtj87YPSsJfrwvBzitBxbqJmDgjRssh+ZhSym2EbglVEL7HtlQ6ZrxqgseWrcH+FzJHyHi8tLHQZ/KGEQle7yqnTIBK7p2K0LvbMvRl5uLu6mlgbdTdYEDOeib98MjfUZGcmIsgVsRiGs93EtC+cvgBE7kwGTJaEbaBOJSgSFWh2XlDok9wT1u/mfe5ocQ91qWKQBWYWh+Hf1l20hL9jOdt13TjiC171I1hGHNFIQyKOyVtwkX3V2qFrAgpSmgMduevYaFfWaAg2I3UahfrKNtqyoYNvn7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9RMXAbsnFVu7IoRx0r6W88mA28Va9yTDsQIZm6LYhM=;
 b=ZShj1hEEiL8z65/GIxeYgLda1MsXpVN7pBs3Zca/nDSmHFCoygucY26tSZwkfE48sLEqgYaKpDL3KuE40zk9gc33kzJxJ8/vyOnYncpy3N5PSn1nKoDoCKwhIikwPHyoq4BlUgdiOtFmYAFr9lhVWZu7KSazbOgvVqfvUnNypmEAy4M/lrsDt1XpwZP+/iFOA9R06Ik0vsdc1p+C1yijKNb8YyhWDgTKE3gSfjcs5IorA4Wm3kCyr4raryHuoZ9jqCK91NjdGVF/cNE9X891vqn6LBnZ/4EWEQa56xG1L3FcVl9rLabo+4DpmWg0rp0/odBPn9o3pTkyzpFkh7wW3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9RMXAbsnFVu7IoRx0r6W88mA28Va9yTDsQIZm6LYhM=;
 b=tMG0M1ZPjdO/asIU3DUvaqUeoEkW5VYwx16pXSySPXDN3rX2sCC7B84BIFDUE9M9qsb8OsV708a8hxiyVeJiYub6v0mh0KkoJ1t2NqBUlprZUoIJmA01vmFdPj41ufqq9J9O5ot+XeUthlu0WR+NUO/Wu3DWrHvTipTyEHUsbUY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DM6PR12MB4138.namprd12.prod.outlook.com (2603:10b6:5:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Tue, 30 Jan
 2024 19:59:19 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::251:b545:952c:18dd]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::251:b545:952c:18dd%7]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 19:59:19 +0000
Message-ID: <916951f2-46d6-48a4-b29f-6a5084e1f176@amd.com>
Date: Tue, 30 Jan 2024 13:59:16 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: prelude: add bit function
Content-Language: en-US
To: Christina Quast <contact@christina-quast.de>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240130-rust-bit-v1-1-ed2ed6389a58@christina-quast.de>
From: Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <20240130-rust-bit-v1-1-ed2ed6389a58@christina-quast.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0188.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::16) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|DM6PR12MB4138:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b8c206-ff3b-42d0-854b-08dc21cdf208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pRuy0d4+DUmAsw8JjhMdGskq3QZKIJ4YiEmYbFpibCCOOHznC2ztgxXC6jqeyFqa0MxvJ25wy8PO2+DswBV9LM+cQBbk8NraqDsF4QaSxPDGbpHjJnfaUI/gi+H+LUG+Omdm21esFeiPHSBEQr38y3kLK7k/Z55I/PuR1jZvcdBsWhJmX3rRdfNWl/wpXbvHkca7iulNn3hcTqQ4i8UjfIhglkNBFOVaUTrZvI/sS5JhkUH3KVniCHX6WMTsOmrwacTeeyNjS24P6gs4D/Ty9Ust4FWVFw2sYXSMPAqj0t/bBw6hydAaXozD8uekdKw50lOlv0gxLo01WFvqX2xiBZsLTfBK9mJLEj0E6o6dEo77Uafp20scfP+E2ZuxWmVYw0FhLJh5RauQ7IyIHGeG3gOzyHO9fzZQDRxPVoMJP9hTKF1+zNzZ8OmIMYholyDXhjDDJikfIqpWvzFBcpKPzqG7ZaE1dH8kJcoX62mAgG7rVEf3XIOY4VhSUJ6eaIetyzbl6mGTy+gAocQJc0rka5Z8SzHO273Hg+qNaVog7ML1s9DnClpaETq2lcyUWyfPbi+a7a3gg/HIqGqq6Qf11STst2tjI0dqzYUWyTOj/RSY164vhiSI6ERxgXdoNqv1wUYmw+Er97ERQdA/SSXkQJ1SlA1GkbKwpfAsGdH4acU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(346002)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(921011)(41300700001)(31686004)(2616005)(36756003)(26005)(6486002)(83380400001)(478600001)(6506007)(6512007)(6666004)(53546011)(38100700002)(86362001)(8676002)(31696002)(2906002)(5660300002)(66476007)(316002)(66946007)(66556008)(110136005)(8936002)(7416002)(44832011)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3lObDRRcmREU2RlaXkxN0x3TzdSWm9YT3kxSVRnZk5rV2ZKQmRZdjhJb1Vk?=
 =?utf-8?B?aS93RHZGQnVRUlhKSFp3Ym5NVEYwcFp0c1dURGxJMXFKUUovRDNPY0pQTXNH?=
 =?utf-8?B?ckgyWndKZHg2Rm9qeWc5MXJKWi8xcmwrUFhpdWcyUlY2cVpZdEJUTUVhUmNF?=
 =?utf-8?B?dVJoRXg3OVRkTmcySUhOT3ZUTFdDZ3BMSkZpS0piYlQwYWRKQStmZ09IZ0F5?=
 =?utf-8?B?Zm95UUYrbDJSSDFZbk8rQ3ZuY2pUdnZGd3Y0d0pXa2Q3enRNUXdxNm5HWjVV?=
 =?utf-8?B?Y1FFQzlhNzZPS3RGOC92NlNHVXo3cm5YUGdVbU9mdXlDc0o0ZDVGWll1VW9k?=
 =?utf-8?B?cmFvUzhNNWg5aXM5T3h3NlZmWlJvSlNxL3R0LzQwSXdRUGJFR0FFVDloY2lt?=
 =?utf-8?B?TDUxVXQ3S055WVRGTHd1UTZnTFJrMWhMVXFnR3kvYnY0eEsxWlRaVEo2bXFR?=
 =?utf-8?B?RlBZYjFtb0puRWJMeWlBaFcrNVdKajZjcXkxdDYvWUZwVkIyWTNjNFdtWGFI?=
 =?utf-8?B?bmZ2TXkyZkRFNncwSk5TMWtmRWEvL25yZHVKczJTd1JFa2RCRjFoTkJVcUs0?=
 =?utf-8?B?WDhCb2JLL3FvSG9aN2N0QndpY0hNK0hQZE5SMmpJcHlyVUx5Zlc5YUhwQXdK?=
 =?utf-8?B?ZTRpT3AvRUdNUDdEeVlISVdHbU82YzBzS3lVTWtKbzBYVnozTnYwT0pSTW1D?=
 =?utf-8?B?SVFmWUdiNEYrMExxMlVEUUhzL082VjdCOWtIWFUyaC9yU1hCejJLeklGdnlK?=
 =?utf-8?B?d0tSU1FscWlCNVowcEh1cnB0ZFdFV3FZcGNrMVhpM1NYM1ZDYVRDdS84enRS?=
 =?utf-8?B?QkJvdDFpMXpUdnFmNCtzbEVNNWlhWlJzemtSWTYwdEFSZG93cEdzVzJGYmhW?=
 =?utf-8?B?ZzVUc3owaVJZRnl4TkZNcVhiWmZNNHBMYW05eEdFUDBtd1NkckM5aGxBWGdD?=
 =?utf-8?B?RkNFenh5TmVNZjVQWVB0WEFsYmhUWTQ2OEFjcFlwY01aMUZzYUF0SEM4d1Jl?=
 =?utf-8?B?bzJBdFA2SElia0FwbHpnNC8wK215VjcwV2hQVkNDV3pJcGxEOTFnNlNmY3VK?=
 =?utf-8?B?ejdic0loWWRKdWE0dDkrYlJ5djZYRlRwL0ZUKzhqWkcrVEYxVDg2MTFrZVZO?=
 =?utf-8?B?R3c4SWJ0ZlJGSEtxNmw1RlF3ekw1RUZkT0pyQ3BTZmdkSXV4b0FwSDdKeXE0?=
 =?utf-8?B?WFZoOFZJNDRJb1RsS0g0blNhM3lYQmVzWm4rVmZDWm5zR3VmNlR6cGRFb3ow?=
 =?utf-8?B?bVFsMEtYdlNqR1BaWEh1YkJ4TlBhQWozZ2dMVHN4N0hzbVFyQ0duRW1iczJl?=
 =?utf-8?B?QlhoU3pKbTRSMjFOdTZCdnd1Vy8rNG9mQWhBek1zUzA0cjRjd1lwVUZOem5I?=
 =?utf-8?B?YXhxc0JJblQwT1pQdFZ1dFdaU1RNV1ZWUGFuUSt1WWhVc0pHWktoZ3FicUZl?=
 =?utf-8?B?R2svRDlrVnJJTTBnenQ4bDBLSGlVeENyVktFOTVoYmwxZGtybjFKekhCLzg3?=
 =?utf-8?B?MWMrQ1dUMGZjVEJnbkNWWTdrOC9jUkdTQnlzbFNJYmM5RnRvYThxNzJDdTAy?=
 =?utf-8?B?RFJ0Q1pwSTF0R0ozNnR5NTFLa3hnbTEraCtuRGw0bDJrejhXSFhyejlNVmZT?=
 =?utf-8?B?VVdvZnA5LzZvSFRCZkJpeEVBWktBTk1ad2xnNXEzYm1xRVVkeWluVVNiYzNk?=
 =?utf-8?B?VkVYU3dlYzMxU1dFLy9JN0huUVVKRENZTjh0cy8wQzZhRzdyZG9lZUFkYjll?=
 =?utf-8?B?UFR2K01LTkQyeE56MGNPaWFNZjhzQlFlTkQ4SU5tY09UMTczMHR5RlQrZ2NU?=
 =?utf-8?B?ZjdJYnJBcFRiNzlVc0l5dVNRQXRSWVZnNHpYMzNZK25PSHAzd3VQb3Q5aGlQ?=
 =?utf-8?B?RHFuTGlrTEJDb0Nkdjludkc5UytpcysvWnpnbTFkdFhKWksraXVOWnI3QUpX?=
 =?utf-8?B?RjBwdXF3MjBTbE5wT0MxRnFZL0Z2SzRZQktQK2pwVjkvOTR1cnVrbko2RUlj?=
 =?utf-8?B?cmVhTU5GcXBXNXp0SUVZVUw3TUJYb0pZRDdLQnRvVlBXUnF6U2JpdU1kM1RP?=
 =?utf-8?B?MldsSGhlaFZvZDZpc2hpaTZ2ZFlZN3BTYTNJNjRoWURQQW4zS1BnSkRzcE85?=
 =?utf-8?Q?yxCPvCOkzxylR5dOxyoGjhlCF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b8c206-ff3b-42d0-854b-08dc21cdf208
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 19:59:19.3772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31s4r+m3HyrX+7vgg6S58cQaZCW4fpg/ilvomx3ZG/TpIDsJ/4KJWkaKtrTykoISk1eXjwamiypWNS0uufOrqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4138

On 1/30/24 13:47, Christina Quast wrote:
> In order to create masks easily, the define BIT() is used in C code.
> This commit adds the same functionality to the rust kernel.
> 
> To use it, include the following into your rust file:
> use kernel::prelude::bit
> 
> Signed-off-by: Christina Quast <contact@christina-quast.de>

Reviewed-by: Carlos Bilbao <carlos.bilbao@amd.com>

> ---
> This patch is needed for further patches porting the rockchip phy
> driver to rust.
> ---
>   rust/kernel/prelude.rs | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> index ae21600970b3..16e483de2f27 100644
> --- a/rust/kernel/prelude.rs
> +++ b/rust/kernel/prelude.rs
> @@ -38,3 +38,19 @@
>   pub use super::init::{InPlaceInit, Init, PinInit};
>   
>   pub use super::current;
> +
> +/// Returns a `u32` number that has only the `n`th bit set.
> +///
> +/// # Arguments
> +///
> +/// * `n` - A `u32` that specifies the bit position (zero-based index)
> +///
> +/// # Example
> +///
> +/// ```
> +/// let b = bit(2);
> +/// assert_eq!(b, 4);
> +#[inline]
> +pub const fn bit(n: u32) -> u32 {
> +    1 << n
> +}
> 
> ---
> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> change-id: 20240130-rust-bit-99dd6d3a0536
> 
> Best regards,

