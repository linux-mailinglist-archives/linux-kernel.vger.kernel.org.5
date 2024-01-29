Return-Path: <linux-kernel+bounces-42532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C948402BA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D539E28308D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5A458AAD;
	Mon, 29 Jan 2024 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jIjw8Njt"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C5658AA3
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706523856; cv=fail; b=DQ+MDdW1PwTjrCLfrgTYnG16IhQyn7HgfD9W6v3o8OpUIMGTvPe+difdKbEu54DIM5EWklmVVbz/qNWhKpbOFOh2mqVZms+3bDYsjWrSc8Z1+hBVISABfAPuU4GsZQy1KqZK+sn0R8py3BNiGfuszqkUgyb2/loGUsukIZ7+eXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706523856; c=relaxed/simple;
	bh=WOY5lI/r4I/FK9ich8jSo1BD/8ZeKGXrON8ibTijwKE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YjvExxeTleUck02RNbEbLO372uVFpv+4Y9iuVJwx8SnFWuq+fgspOWnCM7TytVOdhP4FqhApkMvXGIA7rZSKSE89IG2NMbaWGEb23a9mHLxpto3XC3G2EK0C7S+zCZku33ry3IN6SJ/WL/5EewmVzTaE4FUhwcBmrv3VVYgLrQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jIjw8Njt; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDmrWSm8M3z2ZiifH6BKFRlWsoOhsBV6O2eoz+J7qHKFxh99hTugyND06nkZhQ1tFwYeS3CUlB7uJI/50hUpxdddWRGKTv6WZpywVnRj++5wV9eh5796t1vhqEvVMYWanKSMEvjL9j2Ei6VxzupJ7ViRy2km4zFwdqMMkWptBkDnM9F22Fcieyl+vauKyIR/CFqRQOinaVGATBJkADIsMihW6nQdVtp2kAiU9raM1nPaVkqVPszp+pxhyyrOHBGjQ0rZyNuc9hl+5SPiMOFDLaT8/rs+UOkjRg7A3C6fKMVptwlKmfmbAsNDnOiEQM/3ZmPgUd/ReP44xVXiUzkcYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLmLwIRFyS4h5qcwgaRTxQL8kTZbjgMle00XB/ZGvoM=;
 b=VQuGAoFrVx6mMN9ppmKSOFNzZKBWHB9ClyO2o8JlXHx+9VVS4XIZE4UFj2JcVGEADizQ0KFvJffAiv71ba5wtfMGnJrKIzlkhXoCG1e89s5++gjHbNQIRHIaKCQBpubGwlY3h042fA12Upt6ciZ+teDyKQ0bmoZqrFw6ed/rC3uur1TtuV1V1No/lou19SHkTgZrT0twrJMIGdAZnDUaj1uGoUoH7p6vubr7gljaXsBFwyfl7W8xjMmHcW6+7YBEchl6wcHcpFsBAZ+2XdMmArSC7ye23rTwqQcElgf1FIOs76bpzzcYq4MK9IAdAkiwBaP4OXghuGLgbdMde05mzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLmLwIRFyS4h5qcwgaRTxQL8kTZbjgMle00XB/ZGvoM=;
 b=jIjw8Njt8+A5R52/WLRcUsRZWV/Ms/h3+OoOpVoaJx1GYZj3A8QEgWycpmgbDD+m1OSutRf8zlLxfvZ3bRrjlkqK0eRn73HkLaD5qAWx5f2cbHQdr27vajPE3OXX4UUO5T+z2nrJBn5ZG8n5dJlhwJ6JCUvvbdKOt/fXM6yzudc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by DM4PR12MB7648.namprd12.prod.outlook.com (2603:10b6:8:104::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 10:24:12 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::afdf:5f2a:ead9:622]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::afdf:5f2a:ead9:622%6]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 10:24:12 +0000
Message-ID: <f0677a02-72ea-49e8-9499-18eca6b5e8d7@amd.com>
Date: Mon, 29 Jan 2024 04:24:09 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 10/16] x86/tdx: Convert shared memory back to private on
 kexec
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>,
 Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
 <20240124125557.493675-11-kirill.shutemov@linux.intel.com>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20240124125557.493675-11-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0167.namprd02.prod.outlook.com
 (2603:10b6:5:332::34) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|DM4PR12MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: f49f9a85-3874-45e1-f9c6-08dc20b46fbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r3nVBqxFZjKd0b7cO1HFpbf/KEk1hlr1Pj1eTzE0QhOZQ1e4kCdRncQnYFlWil3eF0I0P913duq4JkC/F2WwLSHXq22hE+GUOc7HlUCUuhzo/fHg2oCbd0XoGPPs5zt348PghlskIICC0mJVPhDuILieuuJJjkHY3PDcEdKjvEKoZPqTcaP5BXvVSt+yPFOAv2/kTzO2S8x+jy8rdYwq6enOS0L63luE9yAaFCHdkMEwRSVAuHvy3tyYJ6gEIfJkec9HnCBxTSb5aPbuPsgO3WrZgJ0HYQMXz3m5NaBiNZFqv5VHE0KuyFr07BoIs4OeojnPaICNnAWF3F2LwNwWfu26h9WWd80+nQ/QRtliG4CC9GAcYGKKN9SqrjFLNdOsJhlnl99yd3A0RfLMll4EY/GOHUdL0jnRqk5IMXryYIu5LnVV62mQf38ORdDs/6G6ox2ECysdchPJjdPBaCVoLfxGuhL2MS0f/lQcKZqbaZNVhfqrw82zsUH/0eKOT2zYi/xlrVvQfhK0V+oxE2KgP4aIpgocsorTYgzJ/xayAuwy3iJm/iMJXq2NSqb5oZT+uPIQp0VMdp/UHxdndHDdjRHjVeepo6ces2PLwTg1bdLOwLLOgFSq9gASL3rh3DXp1vhn3YQfW1WGYTV/35Qhag==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(366004)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(41300700001)(2906002)(7416002)(5660300002)(36756003)(31696002)(66946007)(66556008)(54906003)(66476007)(316002)(110136005)(86362001)(6512007)(83380400001)(2616005)(6506007)(26005)(478600001)(6486002)(6666004)(53546011)(4326008)(8936002)(8676002)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkNyc25oNHBNTUVLZzk1Q1hIeVhuQm85cDZZcVpsTjl4K0ZiVGh2eXA0UUhx?=
 =?utf-8?B?a2U0WDg4VkJCNWdWNDh5MkhWbkNqV0FteVFubTFzVDcrelp5T2h1T0ZrOFZo?=
 =?utf-8?B?dVNQTm9MQ3Y2eWNLYjBYWGVqaFY2c2pKZ2N0Qi9NYy81RDNlSnRYclRmcnQw?=
 =?utf-8?B?RmtjbnJIVjJoWmZ5U3dpV3cwZU5tbDM3MTVrYlpSeHpJYTc2MGp3Uis5eEhv?=
 =?utf-8?B?ZG1ORTVjd3Vra1BSdGhqWEZyL1JQVnNjdGFhSzdpRzQxV1V1MFJtNi9OUWpD?=
 =?utf-8?B?TzhtRlgyM0ZFM2J6aitaZEFRSWNMc1M1V0N4d1cvUm41R0IyOHcvYjhiVVZo?=
 =?utf-8?B?VFMwWkdKN09GVW94RGh0bm5LYStacURyY0dPZnRCOUhicUl1b2hVU1VCY2dI?=
 =?utf-8?B?enA4RkJ1YVVpQlcxd1NRM1VvL3lxRk84SFpIMHRVQkRMVEVOWno4NXprVFF6?=
 =?utf-8?B?aWpHbU5kdFU3a1dpVU5XVGVQdVZPQm9LWEpjd2JuczcyVnpkc1N6Q1RYVEJX?=
 =?utf-8?B?czVuVG9RZ09LcXZEVW5CRkJkOGdUMmUrcFlnU2N5OFZrVStwRUVVaStzSW9r?=
 =?utf-8?B?SlJrdjVqb280dHNzMEtIUFdLaVRUSGJiWWdrRXRXM2pNTExvZUhwZzBvRHFo?=
 =?utf-8?B?MUF6K09KRmYxNmVYTlU2Yll3WXNNR3NMRW5CaEl0RjlsQWpoNWVkNVYrN00x?=
 =?utf-8?B?anZFMUM4OStIRXlQUHZYMlAxSTdWYWFYNWttVlpNcDZ3bHJtWFQzUnhGYVV4?=
 =?utf-8?B?ZHFaWUhhajRzaUpWNEp4UUZCcEVwLzRDTWFQU1UxTVlOZDRCVmRoMlVMckZs?=
 =?utf-8?B?c2I4bS8rUithenJmUDRNTGZpVmFzZ1RRV2hVYTNFMVFsUEFnbHZWZnRLN0c3?=
 =?utf-8?B?NjYxWEtuTStEYkZDekRGN2ZlRlFZcGpUalZKcnBZY0Z0THJ6bHk2UnhHa2pn?=
 =?utf-8?B?bTlZWm94SHRZNDliTXp3OEk2UXE2VHFMOG1SV0JjVVpqbS96c2hkYzcrVVJw?=
 =?utf-8?B?THV4T2J1T1lkUEVXOG1qZk9mUG12MFJxZVFBUzl1bytaMzhPNHEvTFY3WlNY?=
 =?utf-8?B?dFJianF6WGVsaTd5c3kvM21XL0RnTEtIK1I4Wk8vTTNXdWtvSmVsNTR0MGpP?=
 =?utf-8?B?Yk5mQlVFb0hRNWducWJOY1UvNGRrMlI1eHA0Z0pVWmhxd2l6ak5SVG1JanJG?=
 =?utf-8?B?MkJlWTAvZVp3SlY5bFVuRmx6eTJiMzdwSTE2QWp2SmVsaGcwcVVFMUxHcHll?=
 =?utf-8?B?a1ROWjVJRVdJVXJXbW5LYXE2YW8vQ0pGTUZ3cjVabzB0Y01pZFlVVFAreEkv?=
 =?utf-8?B?bGU1THNyenNFU2pkakl1Z2hMVUpsaG1iWnlCTHNGVm5xc3B5bVRJRkNoT3Z1?=
 =?utf-8?B?aHlPb1ZNckJ5cjNDTFFYM1Q4eElEMDlSYUZwTHN6d25LZ1FjODBIY3Bha0wr?=
 =?utf-8?B?TXJ0cGk4Lzk1N2VXR1dOTVY2bE5iMzNmeEx6azVjQS8wWXdFUEtpOTNSL21Z?=
 =?utf-8?B?bHd1MVl0bk1pOE5xREtTdzVxdUp1ZER2TlE2R1QvN1RMbVk1VnRjSU0zMzBk?=
 =?utf-8?B?Q0c3a0hqMFdvWmZUYjU4YU1TdlN0UVEwZFpMdnRxWDVocTEvR2ZBZE5Yb3lV?=
 =?utf-8?B?ZG5QU1ZuWnhqSGNOSDZqdUNwRmlJOHZKb3pKKzBFaFlkWVRkUTUyYjArYnlQ?=
 =?utf-8?B?MldvSjN1MEJXY3lFT2lOQUNXRUFlclI2V1MrWnJtK0Z3WC8xNnRhNnpoTnRT?=
 =?utf-8?B?YnhiYlhhS1dldlU1VXlHbkdiU3g1VGo5QU1ybUtpUnhDYmhVaDhSQ2JkaHF0?=
 =?utf-8?B?Vit1MWkwYXRhMit4TFVBWHRCQnFTMjFNdjJQRVNLdFhXY0psL1BqT1NRR3RF?=
 =?utf-8?B?Z0dJMkY5SHR1bmQ0OXFqVHJHTGo3V0V0a1FkaEZCbktxWkp0Z0UwdXVMSEhS?=
 =?utf-8?B?SVIvNXBieUl6SE1yZGJ1UnJVcUZNVVludlB2VVZvcGRiZkFneTlyUjdZTi9O?=
 =?utf-8?B?ZGRWb1ZTbEI2NWhMUStmcVp1TG95b29zd2VyajliQ21pUTBxSCtBNjZQU3Rr?=
 =?utf-8?B?WUlvV29JclBOQ09GbGRNeWNuRVA1L2RTL0hZaVdKWkJOMVRMYkYxMExKcTc0?=
 =?utf-8?Q?ajPBz/FiCb32sNpAtMIh8svid?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f49f9a85-3874-45e1-f9c6-08dc20b46fbf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 10:24:12.2543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z8irIUsZn7sFimv+8Th+afqmRNlkr8CdDAqVGhicpaSO1UcAGpzAKRUFoPxoUZSfV8QZp7urGmKwTO7L7BcLcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7648

Hello Kirill,

On 1/24/2024 6:55 AM, Kirill A. Shutemov wrote:
> TDX guests allocate shared buffers to perform I/O. It is done by
> allocating pages normally from the buddy allocator and converting them
> to shared with set_memory_decrypted().
>
> The second kernel has no idea what memory is converted this way. It only
> sees E820_TYPE_RAM.
>
> Accessing shared memory via private mapping is fatal. It leads to
> unrecoverable TD exit.
>
> On kexec walk direct mapping and convert all shared memory back to
> private. It makes all RAM private again and second kernel may use it
> normally.
>
> The conversion occurs in two steps: stopping new conversions and
> unsharing all memory. In the case of normal kexec, the stopping of
> conversions takes place while scheduling is still functioning. This
> allows for waiting until any ongoing conversions are finished. The
> second step is carried out when all CPUs except one are inactive and
> interrupts are disabled. This prevents any conflicts with code that may
> access shared memory.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>   arch/x86/coco/tdx/tdx.c | 124 +++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 122 insertions(+), 2 deletions(-)
<snip>
> +static void tdx_kexec_stop_conversion(bool crash)
> +{
> +	/* Stop new private<->shared conversions */
> +	conversion_allowed = false;
> +
> +	/*
> +	 * Make sure conversion_allowed is cleared before checking
> +	 * conversions_in_progress.
> +	 */
> +	barrier();
> +
> +	/*
> +	 * Crash kernel reaches here with interrupts disabled: can't wait for
> +	 * conversions to finish.
> +	 *
> +	 * If race happened, just report and proceed.
> +	 */
> +	if (!crash) {
> +		unsigned long timeout;
> +
> +		/*
> +		 * Wait for in-flight conversions to complete.
> +		 *
> +		 * Do not wait more than 30 seconds.
> +		 */
> +		timeout = 30 * USEC_PER_SEC;
> +		while (atomic_read(&conversions_in_progress) && timeout--)
> +			udelay(1);
> +	}
> +
> +	if (atomic_read(&conversions_in_progress))
> +		pr_warn("Failed to finish shared<->private conversions\n");
> +}
> +
> +static void tdx_kexec_unshare_mem(void)
> +{
> +	unsigned long addr, end;
> +	long found = 0, shared;
> +
> +	/*
> +	 * Walk direct mapping and convert all shared memory back to private,
> +	 */
> +
> +	addr = PAGE_OFFSET;
> +	end  = PAGE_OFFSET + get_max_mapped();
> +
> +	while (addr < end) {
> +		unsigned long size;
> +		unsigned int level;
> +		pte_t *pte;
> +
> +		pte = lookup_address(addr, &level);
> +		size = page_level_size(level);
> +
> +		if (pte && pte_decrypted(*pte)) {
> +			int pages = size / PAGE_SIZE;
> +
> +			/*
> +			 * Touching memory with shared bit set triggers implicit
> +			 * conversion to shared.
> +			 *
> +			 * Make sure nobody touches the shared range from
> +			 * now on.
> +			 */
> +			set_pte(pte, __pte(0));
> +
> +			if (!tdx_enc_status_changed(addr, pages, true)) {
> +				pr_err("Failed to unshare range %#lx-%#lx\n",
> +				       addr, addr + size);
> +			}
> +
> +			found += pages;
> +		}
> +
> +		addr += size;
> +	}
> +
> +	__flush_tlb_all();
> +
> +	shared = atomic_long_read(&nr_shared);
> +	if (shared != found) {
> +		pr_err("shared page accounting is off\n");
> +		pr_err("nr_shared = %ld, nr_found = %ld\n", shared, found);
> +	}
> +}
In case of SNP and crash/kdump case, we need to prevent the boot_ghcb 
being converted to shared (in snp_kexec_unshare_mem()) as the boot_ghcb 
is required to handle all I/O for disabling IO-APIC/lapic, hpet, etc., 
as the enc_kexec_unshare_mem() callback is invoked before the apics, 
hpet, etc. are disabled.

Is there any reason why enc_kexec_unshare_mem() callback is invoked in 
crash case before the IO-APIC/lapic, hpet, etc. are shutdown/disabled ?

In case of kexec, enc_kexec_unshare_mem() callback is invoked after the 
IO-APIC/lapic, hpet, iommu, etc. have already been disabled/shutdown, 
hence, this callback can transition all guest shared memory (including 
boot_ghcb) back to private.

Thanks, Ashish


