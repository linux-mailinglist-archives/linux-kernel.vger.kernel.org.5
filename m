Return-Path: <linux-kernel+bounces-90738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539BE87044C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780BD1C20CFB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C51047A79;
	Mon,  4 Mar 2024 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k+7hjm+W"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B29446549;
	Mon,  4 Mar 2024 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709562937; cv=fail; b=ZkR8MQgEqCeOPJiFprUyMtQqshGgEuVEVal/30Cp8vlFWPyrrTBABEQfepUAq2aq8Y6gYdjC6fMtlPLjMNw8Vl0Mgf4IYYnvP/P7+fYpdOnOQkCQWvbKzKvsZPi7XcgCvQNshYMc67Yoi0Q1ohijgDJfgrMZ93BWRb4Shq5SI1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709562937; c=relaxed/simple;
	bh=R/F0YJAof3qBIfALfYzfQ9DREpJ0InKgxJywKTdRmvc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NaxodNlSkaUs4oNXylVnfH+KZSOclGRr7fCFZnMdZMFYRx56hePBkQ47uHhsfOi8kya/t/qM5x6FYRK+wuu5Vz5APMZSTxWUg1NBu9jJ+wHswcDUnyGxymas0km+NBvNVcv4l+ZNPzNwxiEtV0bhibN+fQtkn2XSVLceFVBhJQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k+7hjm+W; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709562935; x=1741098935;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R/F0YJAof3qBIfALfYzfQ9DREpJ0InKgxJywKTdRmvc=;
  b=k+7hjm+WvGxOhT7ISxIrJheKzwN59FOVC1Ekp0oaQP30VSKVtGJkQVDC
   NqgrrnJj3gxESyphIqQnJM5TMo35iUHMUOPcHgyyZTMXSaGF8PwI1pc44
   6dyT9DpyaKIWePdy/+oeekjxLrolcrQ5TOSPxd4Z1SfJ1WQSP9W+4f2W4
   +cPZiTjK6UU2B7EpcuZyhZ9o4QLZW2HQwiZKT42Kz2o2RDllDFSzCsMUA
   m6NvfwpfrC3gYQOWzsH/7LPVOBTLR2gM+MhRMLy0Al0Wau0CICBUEDdO+
   jkT4Gg6vCIrSsfuXY8M5suKuE0MugxfmL867fP+4zcj/IpmTGqF7vdOCn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="21517029"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="21517029"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 06:34:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="9399109"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2024 06:34:00 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 06:33:59 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 06:33:59 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 06:33:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jh3TO9vL3p3DtUlZ9vlM9XL7EmDuWPZ12Fw7PrRyqTqEPFbYDYOMK3VbZ+13tXDkywOpukOMOfEPMYIx+jtkWaTcTntZX/QFV1/svrfECWfYfgWfr3VZYBIEcxb5GK+IxvqCgZPU3Djbv71wJzASi+8whZDw9GgqloIuVJmyCDbmJj70Uq76FTXiH5hGCYpi8hEKjXRQaz6JZXEW588FB4F+ldu34SgUGrfWvp/19LMJrMqUzA9gV9g2nhQUVEvaG777B3oZhfpoy8R9PRRFSwHAxEgoTD+8kIsNi8LeeUUiJMf8WNTvuFiBQndSrm933uGxi0qZAE/VH9O0AsKwrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnKgNTXk1pjM5SHpKP5/Q6eIveIamSiVHUYxUv+WTus=;
 b=Yfh6Z7IrnDvd/MbWosKb+JtLFOV14+M+oaHnFRa6D/J9bqtbYiME0ijbRJMIUSVO2t12hZ/inXMCIgypTi7oHx1lEa4/EAJczrPPyo0BPHXGBpbDN3TRGaVJaBtL662VHJPnaPSUXvQrxOwNBENO3EYdh81vRxpZb/TrE+uSAtjrQAZVvnYgd2eOMrfFRLh8FOSqgqHpWGjgnxpRp2qmyw6g4j7VJo5qBG9VQeWMVtPiWp6/puzDDwHGkOr7KRLJRJxm37I927kVmIWrWFbvrMmde4o7JN8mAKl2rb6Mm4gz57bncGjjymMqNF0zW9BiFxne/cH1XLQPGPnkiACmkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB6906.namprd11.prod.outlook.com (2603:10b6:510:202::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Mon, 4 Mar
 2024 14:33:57 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::f082:826a:7761:7aca]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::f082:826a:7761:7aca%2]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 14:33:57 +0000
Message-ID: <ae6b1114-1c71-46f0-82e5-23b9f05df1bf@intel.com>
Date: Mon, 4 Mar 2024 15:32:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netdev: Use flexible array for trailing private bytes
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: Eric Dumazet <edumazet@google.com>, Kees Cook <keescook@chromium.org>,
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, <netdev@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, Simon Horman <horms@kernel.org>, "Jiri
 Pirko" <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, Coco Li
	<lixiaoyan@google.com>, Amritha Nambiar <amritha.nambiar@intel.com>,
	<linux-kernel@vger.kernel.org>
References: <20240229213018.work.556-kees@kernel.org>
 <20240229225910.79e224cf@kernel.org>
 <CANn89iKeJGvhY0K=kLhhR39NVbaizP2UBk0Vk0r_XCe2XMBZHg@mail.gmail.com>
 <9050bdec-b34a-4133-8ba5-021dfd4b1c75@intel.com>
 <CANn89iLSLPn5PyXNQcA2HO0e5jGYvHKhTh_9_EMmfbTJKZPfbg@mail.gmail.com>
 <77d3f074-8cb6-466b-ab31-a7b0bac659d0@intel.com>
 <20240301093517.428e5b5d@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20240301093517.428e5b5d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0208.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::18) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: a7ba5a97-62e6-4110-fd33-08dc3c581ffd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kJ7DogRHmJoBeMeQm6uD7zXi6pPdBYRivghnOemWEPn2V+xR2ZSeLvFsIBaTz6G7p7jBGyHNi1VZ5WFGU3r3GHd8c7I+yFarUUPXeyqRUdKqlnXT0Ny1iFoMacj+4D9l+xEhM4WgGV8iLs6a5hBN4/JxlDGr81m/JwC01gRWuTIQMrgB177qFtr4DA068xgUaBbkTtXB6aGZRWOriW+P8N3ArDn7S9dOn8uqLDEUhukXzuPUn+MNsjnN9FJ41h6MZ9oF6n2Q2yNulikXX9MIMJRx0JX2VliIpSdXD6nBU8FH7LMW6cxVvC7mBF7PpxR5VguGhe3OVonU29U+vFf0rbMPduRn8mCEwFd9M23A8CDdMqdBFwjxDOxnxiFPNpmVddtCWcwuJGdy/Gdcz+3cd9gMAMn2xdtmZ4cyz7IILjC08U58rq31CaVKumERy9ZDoDFgP3b0+d0egw/BnFC5B0/JiRJApQaZARawNIIuUKleIC67KVEZYCPGf3kGYuSJs0IAKCTXqRmboNDnC+YyleyYR241WXMCih3wDtJADu+FZVFlCNNH1qKGwn5zIkUltgHUMK5BVEQu6Xpiwaokx9xSXF7lKwr1bOoMPCeYftdOVBGGZJ27+4QUbh7k8rMZNhGtv/4HUIeni9IUf9dD9QB6/MVJgXiOnnqvYIcww+Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1h1d0tkZUdWa0txZVloeEZmQnYvMS9KSXBWMFFXcmoxM0VNVWs0dFkwQ0VI?=
 =?utf-8?B?RFVva2VHYXh3NVJMNmtsVTI0cTI5b0wzelF1MFZDYnJHNjZWaUVrVW9QMklP?=
 =?utf-8?B?cDc3NXZvSDlURHIzU3o1WTVMdXRjeVRHNW03YmJTZDFnNms1dTZlY2FlejJZ?=
 =?utf-8?B?VUpyd1hPR2pYcGp0Q0RUb2E2L0NCblVCZVBiZm9EOWxmQnFldTdEYk1UVHMv?=
 =?utf-8?B?TXR0dXludlFtU09iVlYvblZKcE9zbllFcWdoTjA2QldpVTdnTnFSSUhGYkZO?=
 =?utf-8?B?YndMSHpUcEt2c2F3b3Y4WTVsWDJhYzVUbmlSRkZiN1diMG90S25hMnpHSGl4?=
 =?utf-8?B?cEo1VTA3WWZKRTd1TTF6ZTVtSDRyQ2JQYkQ3TEdIaFl6RjNuUTFoUmRFTEFJ?=
 =?utf-8?B?Wkx5NytQOXFNQlNaeFNtdUdobVBxZFpZcjNNMGsyTnpDL0VrQWV5QzhQd3VZ?=
 =?utf-8?B?M3A0VjdXZWFNMTQ5ajhKa2Y0WkViRDVZZWI1NUxublMvZ3dYTTNabU5ZZTBw?=
 =?utf-8?B?QkJYazErS3JFVmNLc0ZBMk5tL0pFNDhCeFdjbEgwY0IrZTNUdldhVWdIRnU4?=
 =?utf-8?B?cU9IZ3A4cGI2QkNOeHlkNkZJMC9jb2ZwNFc2SHcxa3lSem9QTGxLbzYydHB2?=
 =?utf-8?B?eGFGcGpjdjRGTlo4MHVleEpZb2hZZWNCVGxzL2czSUhENFdZcFZ1bFp1TG9u?=
 =?utf-8?B?Vmo0Q0JJcFpKQ3EzM2diandmc2wreS9yT3ppR1ZYbDRBZVNoUVVIQzJ2RFhF?=
 =?utf-8?B?S2V5aEo0OGRZeU9hcm41bmdHRFI4RlllUzVzNzJvNmliblIyWmFiTW1Wb3F3?=
 =?utf-8?B?VnZPR2dpbzNDS3BPOWM3QzJJV3pGN29RZ2FvTTJZcTZzL3J4QUdndDZkdFJL?=
 =?utf-8?B?bFg1Q00yR0RZRjhqOHFQcm8vc0Zoc1o3VndTWnlacUdsaDlOdU9FcVpXUy9P?=
 =?utf-8?B?d1pFNFlHTlhoMk1HdTE0dlo0V24xRHZzNGQrSDRsTWVpMmNpcVNXVWN0WUM2?=
 =?utf-8?B?YmRqM0Q4bjR6dkl3aEMvOFFTMndLZVMzT2N1OTJJeFdkMkZDV0ZCY2QvTFp3?=
 =?utf-8?B?K1hNbUxQYmVsN2tyNUFqem4wUUVNNWxOYy8vckl2YVVpMjk2NXRIaWVScHM0?=
 =?utf-8?B?MVpRejJKZUVaaHBQSDNxam5rS1BYOUFOVTVnc0xLbzRMSzJua3dwdzFvTDBn?=
 =?utf-8?B?ZzNCTk56U3ZtTW9HZnhXV3BKOUNYWUptYmpnWExjdXhwbHBicEpkTjdvOXhq?=
 =?utf-8?B?WVptL2NndHVZOGJRbW4yTmRSODVVREhEdWh4eHA2Q09hQm81REQxbGJJdzEv?=
 =?utf-8?B?SEJVM2hFN2w1ejQ2OGVmakR5MlJRemFpUDVuU1lBUVY0M24ybktsV2MvTkdu?=
 =?utf-8?B?YS9hSm5iWXlaMWtHZ3dONHo3b1BQTVVFYmc2Y3dqcGZQQktMMmcybElNanJh?=
 =?utf-8?B?Nk94VXc2SERIZ25wMHFKbUlhemRjY0MrQ2V5UVFNTWFzWWlLK1piT21VTS9P?=
 =?utf-8?B?UkUrTUZqWnJ6WWoyeVFUa2pNK1BTQ1dEdUxhMFN2dFEyNVBzWHBUdHNQTkg3?=
 =?utf-8?B?UlJrQXY1bXFGT3VRVkhzQ1pVNWNncUNNajhKZEV4cWFPd00xaC9YelRrYThF?=
 =?utf-8?B?NzRKeGxWNm94SVJPMmQyK3V2bHpaLzZRSktnWU9NbkZwcnRqelZIV3J6ckZu?=
 =?utf-8?B?V1Fhd3dpN0R2UGx6RUIvSmgrTkk5MDQ4RHVtOUhZYTVFZHRDRHVuSGc4VmI0?=
 =?utf-8?B?NWtlYXQrS0ttYThHM2t2UXRjTmRxMmlodHlkRUF5Y1Y2d1RZTHRycHFUL00x?=
 =?utf-8?B?VmlxbW4wYnpHak9Bb2wvVTZoMTQzMXlzaTkzbmRzM25pd283Wnp4ODRadGg4?=
 =?utf-8?B?dWZGSUhYVDBYSHphM2lvUkxJdXQ5MERDUnNxSmd6QkswbFN2TUlTRVdXTVhm?=
 =?utf-8?B?dW5JbFRjSjR6dmlCRWg0VE9OSjFzZGY2cU5QNms1Smthbm5RN1lyeFI4UGNh?=
 =?utf-8?B?SGRaNG9ObVJhKzVEenB6YllHTyt4ZGlBRGk5Ukxwa1NVaFFyUGlaS01DcHlz?=
 =?utf-8?B?NG5CNE01b3lGdWdkL1Z0Y0JuSFdiYXRMaTd2WHBtRzhlbVdkRDVHUjg0aldy?=
 =?utf-8?B?eWpxbXdCR1VRd3NiTzJlUTUwKzNaemw1RDg4OHBpbGJRTUVGS2tod3k4K0J6?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ba5a97-62e6-4110-fd33-08dc3c581ffd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 14:33:57.3960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E1ECCZrC49g1UqobHA9f5XFC4nxu/bZgBjlBtnWSAmuB0+7cE0ISkXnyez+P2irAfCSm7sbu03buY3mV/JBTAmpDYziJgwO9ciiMgMh1XiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6906
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 1 Mar 2024 09:35:17 -0800

> On Fri, 1 Mar 2024 15:30:03 +0100 Alexander Lobakin wrote:
>> I like the idea of declaring priv explicitly rather than doing size +
>> ptr magic. But maybe we could just add this flex array to struct
>> net_device and avoid introducing a new structure.
> 
> 100% I should have linked to the thread that led to Kees's work.
> Adding directly to net_device would be way better but there's
> a handful of drivers which embed the struct.

I think it's okay to embed a struct with flex array at the end as long
as it's not used? Or the compiler will say that the flex array is not at
the end of the structure?

> If we can switch them to dynamic allocation, that'd be great.

It's mega weird to embed &net_device rather than do alloc_*dev() >_<

> And, as you may be alluding to, it removes the need for the WARN_ON()
> entirely as well.

Thanks,
Olek

