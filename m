Return-Path: <linux-kernel+bounces-84226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D034286A3C5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F861F264BE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8222C57884;
	Tue, 27 Feb 2024 23:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZqYFvKo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02B75733D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 23:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709076800; cv=fail; b=tQF4yuzJKHDehuPdz/oCpyA9dvIi+XujzWwsFe38JJsBC6+DYNCHBLeE9FhA6tDajL9netZayhLrcswOx/UCjkTUKnjctMuQUrewFl4e3041LHXRhk5xnYCGM+s+XtZDRooTjaVNK8L2FBNhCutD+/316eSd6bEw1xvbTi1TgJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709076800; c=relaxed/simple;
	bh=N8ZT1EjW7xf/O43e1+e2t4wgB1rpKKTSIiMTYp5AEz4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f6wn9uT5eX2UXlDlSDzmt5untjkG6ufi8ELSCfcjbfTbRIs6nhr2wpyy5J/j2XO6KMELStDd4+nj+rby5HqiLYWXtnBTpOnnP2W9FSNPXMSkoRDZHEuCoA1qqzkkWGWSYgZAu21SFa8rzOGEFeSmnwIndKLUZAX6ba06gult0Pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZqYFvKo; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709076798; x=1740612798;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N8ZT1EjW7xf/O43e1+e2t4wgB1rpKKTSIiMTYp5AEz4=;
  b=nZqYFvKoTVUnsO/5bqYW6Ywy9x6nnL+iQfCAOs7THPq4Amwnpg+9sYVS
   9il/fWS6IW/tEAtvkbw82vDjt1UYlxdiRn986dOVl5lV4Csc6YVxsU9Na
   UHzCB70fQcmnAC/ovnbnXCQMembcvplYqQ/Mi8SMokxM6m8inB7Jh8eU4
   ULm4yMVnRgCVbiYxDhL6G/wY0IdGX+44a3+Rm4rS0DMluApFs4oilLXXr
   6rOCw5Ky06dmx13uRWcd2HvqFKzK/P29FQN6RltS90k1T463nXKHDxZv6
   7mhuD1WjN/TKfDKMg2EeIOhrV+y6l/8ayZD0PNEQwdnNff+uwPvkuiHzI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3310640"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="3310640"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 15:33:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="11779772"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2024 15:33:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 15:33:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 15:33:15 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 15:33:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPBREcoHJDZnN6Lbb+ElkaaFRqtRaeMJVYLwQVQwLYKLgauwFay1n/WOavIoCKUp4vM7VJe2BduVZ+7oUcdE9iysQiX0ihiGBaB/3ersbb/uehMYM+1s5ArGR9cHIC+8qr9Q65gzD4PhdwX7CDimTSK/Cg6Efx2fQ5i6bkM8VOlKR/KTMA/CCNsiZ//l6/xd5gSQHh8ICZGaitu6DsZt3OGTfO1vyzek1DGgYUYTc2iYNSmxcM1S5o19NCtGOQlZDRKODoFUUTcBoV52V+beYxGYQZHM4NLYSoxh3hXaJ17yggNfLWqQUR6f7qXuEcN/loH3h4XJC6l70xNBiggEog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wM4xYFr8BmrXXpxqSe8uFI4yEaXeaAoTI86fK3A+we0=;
 b=DzdTGg6x1kcpuJVSNsrZESflowY1F0jUmVKknnsirllgGgSyxLvIZbILC5pSHDdmZU8WA67NVt1U6PhHL+hxHIMFx8bPhZFNVDqFhZW504bpnHyRZC36Nmao0sqynAUqeCznsPjF64E1DEQ/SVEZCJNeWrsvb2p4lJvte0Im1WL0nflN9eW8O500igLjv3xnmMVkJPHrKPMA9/R0xW9V+I/ldZi+F9G7AsHJhz4CTVn4OpxnrZ/OK3txbwzskuo4Ycjq6UQxkQSnrnREpoviSfJqsNCOFJIi4RBfq24y9LNYMF8Otv30Md0EG9b4lyPa2YU1S/qSorwThnwPEyRq4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA2PR11MB5084.namprd11.prod.outlook.com (2603:10b6:806:116::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.24; Tue, 27 Feb
 2024 23:33:13 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7339.024; Tue, 27 Feb 2024
 23:33:13 +0000
Message-ID: <b5045aac-e0d9-4ef4-b06e-0e7c01c2d63d@intel.com>
Date: Wed, 28 Feb 2024 12:33:02 +1300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv8 06/17] x86/mm: Make
 x86_platform.guest.enc_status_change_*() return errno
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena
 Reshetova <elena.reshetova@intel.com>, Jun Nakajima <jun.nakajima@intel.com>,
	"Rick Edgecombe" <rick.p.edgecombe@intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, "Sean
 Christopherson" <seanjc@google.com>, Baoquan He <bhe@redhat.com>,
	<kexec@lists.infradead.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Dave Hansen <dave.hansen@intel.com>
References: <20240227212452.3228893-1-kirill.shutemov@linux.intel.com>
 <20240227212452.3228893-7-kirill.shutemov@linux.intel.com>
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <20240227212452.3228893-7-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0295.namprd03.prod.outlook.com
 (2603:10b6:303:b5::30) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|SA2PR11MB5084:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0c4f77-106e-49ca-9567-08dc37ec773b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t0kIu2/JIQxK2F4V73xcTN9bCo+ieQttByau/Age8FI0zhCBfE1J/8nE1p8OILBxy5SJHAp2BjXpLKVdlil2SMsy8q+yGc5Plv99jQOWwweajGxUZCYO6vYuVX27r2DBAJS/qpK4/dLLGJbecNZriaJVBUqnShTHDNlzRNdqP2V2/IwD0vBDgAj9CalM7oMPduKgZvm28rB3IZC4MTWk90Ya0DdnEjgrT5u1ZtEQU6lo9IU8ZfUSt/T8XrX1YWmgqzjko60ad0+9CDZTvMQ6xBL7STOFyoLTEymgtSW24k4+9Zwa64T+Nw30rqVCG4+igd4CxO69xB7MnJ9hxGmh74dCF3GcrMqGWuw5NkGxbPNwaLlpA//gnPHxg302i2W9kB/WUN6WI/DXYOJM4rdW3tvo6uU4bBrISCUnBYsoUB4snjOHI+VkwPVRfNgztYs4nmIMJBb3QPIHSAowodnXI2KYcdRZgmpYD8RJNOUEVSwiIsF05S0if4U/hl64tu/mwiu84vCmUn/x1x70aYMPoP4tn2NTPYC+LcmUB8KvC+Elb5s8wExZaEMHT8+WgUmxr+j6RlmAV8gtOZAlMZvD8pzdlApSvyx7zr7dJFMdirmfzkMw3K6Re7MabBX49CL42py1GN1PdYFsPbDoc5mZWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d01kdVovVUdlM3JkQkhwdHY4Q3Z6eTk4TnQyUXRJSkVETWU4ZFE3MFZSdzhO?=
 =?utf-8?B?SzlGbCtrV1lsMzdVUmV4cDlMSWJJWmdZTmdkWWkxVEQxNGZjUnNZNnN6cWtw?=
 =?utf-8?B?WWpocWlMWTVvQ1A3VVVQSTBCY0lReFl4czc3azlBc2pzekp2MTFId0l0SUVl?=
 =?utf-8?B?RkxUSjVINlBsUC8wRGlTRFFpOU10T2x1M1BPaVF2clljK0ZpUWppWG9vVnN6?=
 =?utf-8?B?NlRlbm90QjJrdHM4Tk9oT2cyT0FwOE8wU0JuYVMyYzdQLytsTHNYa0VxWUx4?=
 =?utf-8?B?M2gxYmtmSGJGU29rOWkvSENUSHkvVHRsQzFlZUJoMHkxeldSSytwMzFGQ1My?=
 =?utf-8?B?dExLeTVERHVNSEREa0RoU0tIVnAzQWtIbkZUNjBMMDg3aFdFTmRWRG9lYjU2?=
 =?utf-8?B?T3l4M3VGWGNnRGZHVUxqUnJ5SC95V1N0b2ZWSnRxVGkyVXpwdVlLbVo1SkJ6?=
 =?utf-8?B?WjdqalovSXp2UzJmODZuMUN3NjdjUlZEajljZ2FRdGNmREU2c3Q2bVN1VytO?=
 =?utf-8?B?V3pGQWJoVDNQWDMzNjdnemtzUnc5NUExUExmd3Y5Wk9udDBQejhRUGlXRFJ2?=
 =?utf-8?B?ZTFiVVF1VHBLNjRnZFh0N1VvTmMzTDhvZGg3WjlrQlJtQVdzdVMyWmhtYUFz?=
 =?utf-8?B?TGNEaVhHWFpvMElYVFAzMlVvOHJhOTRVOXlGY2hZc01rRFRuRUVTT1pZMmJx?=
 =?utf-8?B?NmZsa0xlZjBwNXdNczU4WTlnRGNmTFNOMFVyN0pSd1lQc29YRVVhVXVmdEky?=
 =?utf-8?B?OWQrbWQ2WDFwUU40QmNtUW9RYU1PWEcwbW9Jbmx0dm5xdVVqZC80d3dFNjNF?=
 =?utf-8?B?QVB1TXZSbExEbnZOeWxWb0IzQVBtVkNwZzUzTFlnbnZTZzNRSzVMR0EwajU5?=
 =?utf-8?B?RkJISy9aQmRmU2FMUFFKOWlCVjc1OWx4K3hadWpnaEE5eWJpQ0FPN1ExTDhy?=
 =?utf-8?B?MWZIcUNQNUhVOVMzTkYxbG91b01DVGtNNzh4YnNnY3QwOC83Z0RxcGkrZEM1?=
 =?utf-8?B?MnZKa3dobHZBS2lQMzNBK2w2eEtWOTVFQ1lnOU5uMVFGdlZNZmdBSW1PRkkz?=
 =?utf-8?B?VmU0UElSRVpZaU54MUt1YnYvbDdzaFBQQ0FLQVlXQloyMXpTYlE5TDE5cVBM?=
 =?utf-8?B?WTdQdjdBT0JPZGxFdlh1c0tRSlp3RFZ2U0dEK1ZrTkQ0MnpRQ3UxUUR1a3B3?=
 =?utf-8?B?VjJITjZCaG5iQko2YXFsYitNcWNDWmxVeFU3T2x0cldDZ3g3OWcrdHZ0cWxn?=
 =?utf-8?B?c094czdsbzdCNVVNaHJHRkNPM2kzVElma2tucTB6SFRoRDdBeE5FNXdlNmpn?=
 =?utf-8?B?UlZlcG5NbExkbjkraSt6WFYwTEFOWmIza0dtNmVDVnRZeENBR2UxWkxwV0hZ?=
 =?utf-8?B?dkovdCtrOE5lYnNPK2huZEx3bkFQWFFvWThuY0JaS3cvK1hHc2VGN0paN2ND?=
 =?utf-8?B?VEVDMEdzQ3NGbXBXZFM0NTZWTWpnOU9zY2NyZC9QS2IwWm1UdXczWitlaDBu?=
 =?utf-8?B?elBtWnh4NWxUcEl5cDBQeU5wV0N1anhWTko0Zk0yMGJtU0FFbjFBd0I1czFS?=
 =?utf-8?B?L2xXUEo3Rjlhd29rU3RFYnIwbmx5OWVLQWlRNFpCUXd2UkpHL1g3MzROMVFk?=
 =?utf-8?B?cjN2ZE9HcmZwaWF0L3V2R3lmVGFzcVZKSW13NmxtcTR0SXBoejRFWUtoZS8y?=
 =?utf-8?B?QTY2UlRDUUQzMXo0QURMY1U3SzlSVkkyWmJIc01zWDA2bTZwUmpzaHFSdFNj?=
 =?utf-8?B?VFY3Wmt4UlB0azdDMytPOWJoUjYvck5QWjMvQjB4OVlhWVBxYjZmRUZJYk1t?=
 =?utf-8?B?RWg5b3NlSHJtYWRJNnZjTVYydnhEdEYwVGtRVS8yWWxGZEk4cXA5TUM1YTly?=
 =?utf-8?B?bzM2Rnk5NXQ2dlZiLzV6a3VNU01hMnkzbTIyb1o3MDhRSUJqR1B4M20rbkxD?=
 =?utf-8?B?cTN1MjlYWTZhWkhWS0dJaWQvRUViM2pITFlmNEx1TUVPN3RkSGRIY2R2dFg2?=
 =?utf-8?B?R3pVMHJJcE1yd2ZFak44YmJwYzB0MGJoODh0Zk9obzdBcFF2ZjVpZW5IY0Uy?=
 =?utf-8?B?RGpQTithZWNWMGNiQWZsMW1BQ0dTSEN4MXFMSHYxWSt3aEwxelJHUDEva25B?=
 =?utf-8?Q?A92Nf+0RHHBJynAeVO0yCMKAJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0c4f77-106e-49ca-9567-08dc37ec773b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 23:33:13.3495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ibvxqTcwZsik6yA+usxEEk4bKLIwRMM9sQLJvvO6ybQ9C9UX3MHs5U9+bg0iZQnfsV7AX1XxfghUqnrqybyhFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5084
X-OriginatorOrg: intel.com



On 28/02/2024 10:24 am, Kirill A. Shutemov wrote:
> TDX is going to have more than one reason to fail
> enc_status_change_prepare().
> 
> Change the callback to return errno instead of assuming -EIO;
> enc_status_change_finish() changed too to keep the interface symmetric.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@intel.com>
> ---

Acked-by: Kai Huang <kai.huang@intel.com>


