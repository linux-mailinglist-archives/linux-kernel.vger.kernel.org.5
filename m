Return-Path: <linux-kernel+bounces-157729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 186EB8B151E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B66D2884CD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E32A156F29;
	Wed, 24 Apr 2024 21:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y6NOQ+Wu"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D57757F5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 21:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713993435; cv=fail; b=kpDVQ+Ab7qSTNmkZ7CmtflrtrBxscL6LCq63bgHvbMRiP+/SrLb9wenFxNH3RwxdikkmQulkWIFH4u3B96igmwNksy94t/laYWTaMeaZ5QFT9OjgvfWGyDnm8BJyFuGe6noL4m++R4l1xy6RUrvgl5wuPHixhxC5yL9Evn1Lg9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713993435; c=relaxed/simple;
	bh=6cbHVGR+Ijq+573HMR0itNmFKXJe04WEbpp6zg+xKHE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rWYQZDncf74E9vjwIq5X4gOouEJ0j3GLVOIusaECrb1erZjev/iTWi8rpYuB9KBMbtT6Pc/bE6F/cATczW4h/5xv7JoyKtgK8csSAYLPv4Ol5CDjUnWyWPglRiInSTrAT99alqxfeREsKzm+1bW5ti5+NmcbCImOR84hY5l7Fj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y6NOQ+Wu; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avg5j9fOfWSpat/86lTLAkioRZbvvj8vIm/pVva9JmOh0SXKCGwQ9JDScNPw3xXbH4cyxwO88W834f9socNdrKHdxtTo4fM4vB8XfQPD6DGecla1fXXLYb95lmgaY1ozsiQJSwESEGcii3apgrRbNuohJcgVRJslwvXuCubPHrHk+xzy6c7Eb/ekbB6meDnZFsUqJzw2JowBf1kWKSnJmG5FmmbpODrxUvvBD4boFVBbSFX/RIa4TSz7ETwF7BzYK8ismJRhyYXBrJZ2geAVV7c1mf8nwA4TpHrmY3i1/EaYplEZGdE04hY+WZasTbZ4iJr7qFvAdOF1FsivdzK5wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DiyARM0NHBxR6APBiLa50VY1YNPkRseQgs+vIJmrME=;
 b=WHUr/PJjDZnmS9zUt0DDiEDtYN+MXvxiaedhbp5BmEc3Qs+UpOj3mfPQTpgcqriaeZXqYxffZcMy5uczSAEi36FoDLAX+UECqWoajJSThFOl+QXkr8D+uWUKxiIPeyfj7WRjZxKtH3AMefxvzZKPPDXLAH59Jx7c5orPh8uHEnKio75Gu5C246YCdVnCCToHHzMPy0OWkpF20HNRdoHeLYItoWHqdCIUk6fLIPtNsr5TvJ4VmQMoV7Fr8OWHsfMTooqop08ZvpvthMD5F/VNeXSReLnwnJgqS6Ro+3PvNh6MB1RCgKFRZ9Z+xsdurcQB5ZS5mErJ1E9MViTVxpDhIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DiyARM0NHBxR6APBiLa50VY1YNPkRseQgs+vIJmrME=;
 b=Y6NOQ+WuWVdkb6K501ZM7ZIR76aitMDSkpkit1FhdPQPGu0xUdXWL4sjMlDg0veEL5wmv9Xh5x9jp6EJWuC/KkeSzDqX0ABF4G/TYsKy2E5G+WdoSJbCPAAjAiD6SZ3/dOXOj/Yomp4jdr2Yl/rf/pzH6IvUXOFUABdc3K4lqS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SJ2PR12MB7848.namprd12.prod.outlook.com (2603:10b6:a03:4ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 21:17:11 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 21:17:11 +0000
Message-ID: <16b34494-7e5f-4feb-8a21-58e7b8fa97e2@amd.com>
Date: Wed, 24 Apr 2024 16:17:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] efi/x86: skip efi_arch_mem_reserve() in case of
 kexec.
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, rafael@kernel.org, peterz@infradead.org,
 adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 jun.nakajima@intel.com, rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
 michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
 bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
 vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
 jroedel@suse.de, ardb@kernel.org, kexec@lists.infradead.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1712694667.git.ashish.kalra@amd.com>
 <cover.1713222642.git.ashish.kalra@amd.com>
 <a3032e4b7a5406c26aeb66e9380043c410d07e3d.1713222642.git.ashish.kalra@amd.com>
 <20240424144807.GEZikbp0NjFP5AM_ms@fat_crate.local>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20240424144807.GEZikbp0NjFP5AM_ms@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0192.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::17) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|SJ2PR12MB7848:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b5e7646-04a0-42be-bd16-08dc64a3e7de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmt3UmdJcTU5SmZBaG85cGVrbnBOSmJTbEhjQU50NmU1UklPU3prV1ZEMkZG?=
 =?utf-8?B?V1labFhUcjRLd0UzbFdFRk81VTVVK3RrbEJJRGtBQjdtV253eWNvTG80NzQ4?=
 =?utf-8?B?eDlta0Z1dWhNbk5vMC9XMG92djM2OEw3U1ZSOU1XVURFV3RKTHZuZ21CMkFa?=
 =?utf-8?B?V0pYU1JFRnUrekpxMEQ0UzJxUTNCNkt2OVJNN3JEWnlqRm9lVXpLRlBWYTJK?=
 =?utf-8?B?UlZJNnprbzNtaS9oNkZKZE5uc2xlYzdockJHTm5VRE1KVUJkSkZVVmIvSUJo?=
 =?utf-8?B?WWs4cmpheG1MOUZJWjR4azFoOUorVHZtM3VvK1FFbFUrREd4Nytpa3VtMWho?=
 =?utf-8?B?Szh6M3FXUURSTUcyaGpJVWNCYkx3eFhFaTNTMEh3d3h2R2F3cUJZeUF4K01K?=
 =?utf-8?B?TzQySTA5bHdvQms0NWRNTkQrUi9BSytOem0yd21aWDNqZTY3cFZlbGY5djlJ?=
 =?utf-8?B?cGJQb0pmT0Vxd0kxdXVIbU13bHQ1YSs2eTlqbXRybFc2Tm4yenBpT3dNUGFo?=
 =?utf-8?B?bTJDbExZanJ5Q0JxaUNxdWJ4VVZPVGoxNE8zL0tXVDlKOEtIWi9JUnZXYks2?=
 =?utf-8?B?WEpad2pPOHFWQ253YU9kMWlJRWoxdkk0VDJ5OHpNRytFTjkwZEgyTTBCTzV0?=
 =?utf-8?B?UXdMcHRMRHZwSlFxUDhHZ1pyUGIrVHhMSG9GR1dFakdjdVpLYzhaUldlR2lL?=
 =?utf-8?B?SWQ3eUVyQ2xpTUxxR3FoQURvRENLOHYrVHUxamxFTjFhbHdySGVVRTlQc1FG?=
 =?utf-8?B?SkxycHIraXdGS1VGVURBc1k2OWxPV2ozeklIN0F0S2JrVjMvSUtOKzlaMUhh?=
 =?utf-8?B?anFqUG1sN1RXZ0NNVERidG5NMlMwZEM3UjhremlNaTlWalVVK2JuRThoYkdH?=
 =?utf-8?B?RTdUTGMrWE9tNmM4NnpYaGd5c2RrMldtZk1QREJjRm9ZbE1XMnpDY29TN2JB?=
 =?utf-8?B?d2VSOEZ6TzlBcjVhVTgyK2FXQU1RQnltR2hlamEwUE5ycTEydEQyYVFlalJY?=
 =?utf-8?B?Qjh0blhWZlF4Z0hhOStneVJ6SzlGRTE3a1ZlUzB1bzZRTVZYWjVvckFJY3I3?=
 =?utf-8?B?VWdUQVdKc0hIRUY3djBvaHk5MUN5bFNjUzliMGFUYnJJZzRXSDRPRGh2RlZP?=
 =?utf-8?B?UkxPTTlOR1NITnBJemN3Qk8rM1BMV3laN0lMU0p1ZHlkQTlyVjJoVVNjMSs2?=
 =?utf-8?B?WmVCcjBtelFiVlh1TStsQ005M09yc1JheTFxdEh2WXcySWJaYU4vV3ZLQXc1?=
 =?utf-8?B?MG91c3IvK3Ftc1psNmYyL043SmZVeFVNZWZwMzJCVm8wY2RhelhWZGFjczB0?=
 =?utf-8?B?TCtCMC9zVHk2V29YbE5HM2NBbjI5ZVRDUTdhK2RZR3pXeWJCYzJ1V010QjA5?=
 =?utf-8?B?Q3NiQWpvWWN5ZnVwVHVoS2JTaXEyVDhxbk1zWldQc0hRZE1QU2gzbzlPVVNs?=
 =?utf-8?B?MWVaUkpCVnMxbVdlZmd5eVlVVzhRM3UyS1hJamJ0WW90OENxUFB0Y1ZYeitF?=
 =?utf-8?B?RDduN0FGbVZxMUFrb3FlaHM3NWpSbVFrb2xORVBJdUl1aGc5eFhWdFV0OVZG?=
 =?utf-8?B?c0QyVEFTYldRZ1pyUk0yd25iWHl1WVhLVkdxeFdWcDFuWS9Wbkpsa245RnlK?=
 =?utf-8?B?UHFOZUlxcnF0SytOUjNzRER1cUEvRzZEaExINFo0c2FmNDR0dkpRd3RjenVy?=
 =?utf-8?B?ZVFYNC9PMlpZYUhTTUMvREI3TTd1RDVzVDNMMzlvSGwxdmx5TktndDZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ck1nYlNZWUlPTCtERnhvUFM0aWhjenhsQWdxZmUyNWs1VzJDb3lIcVNSZDlO?=
 =?utf-8?B?NnJ6ejlmeXNMK2pHekhvYTMvSkdGRmpHQTZMWjZUZGlhUndQRFdhWFo5QXdv?=
 =?utf-8?B?a2RyR1VQeWVwblRST1h5Z0tvcGpvekVNeEsrc0hzSWQxWC9ScnZZeVVnTlJm?=
 =?utf-8?B?c1FSd3ZuR3k0SlBhWXVrWmVxblFXdVpvZ1BQbVk4V3RLTmdFdG4rTHNvZWRH?=
 =?utf-8?B?c0RBSk1Ga3JURjlqcnl2ZXpXREEwMFAwd1Q1TEpPTXJXQXFZelZEaTRsNFI4?=
 =?utf-8?B?WEIrV0ZVRkRiT3NORExzdXdjbkxFYlhuaTBXbnFJcUFPUG1aNUM0eExhY0or?=
 =?utf-8?B?L0dLQ2tBaVE0YzduV0tpSWVMQmViRThScE04bEVydG9CWjdYTk9ZZVZmcGRm?=
 =?utf-8?B?blhiQTdsQkIzWDdHMGFmRmQ5MVl6MCtodE5xbEhEbC9ob3BXdmZkZ21Uc2Fk?=
 =?utf-8?B?dWlZckNOUVI5am8xQ0JrNDRRdXJ1TWdSSVZvZlVmSHZmcUExbk1Cc0ZTc2FB?=
 =?utf-8?B?UnExcTNDNU9ubG41eDc4T2ZIOUlJeWUzbDVNMFErSmp1d2NrTlh5Y0ZQQ29m?=
 =?utf-8?B?dWY5QzlkdVVkUk12QmFMSjVHNGVkclJ4WUtUZUNQL3k2K0Q1RDE1WDBYZGFp?=
 =?utf-8?B?aWh6TzRSb3UyQTBTTnVkalZyUVovYnlYZzRmSmRSL0tvZWluVGdFNTllWTBK?=
 =?utf-8?B?NThOK3NmU1JYK1dqd2dLK3NTRWtFOVVqVy9rOTBGbDVWNmhmTHJvbDhNRzJ0?=
 =?utf-8?B?dmVlYWpsWWk1RE5ibkYzUXdUN3pZTEpHWUFGTURvVkFoakdUazJka2NiWU1I?=
 =?utf-8?B?V2ZuVHhLRlZ1aHRMOTFSWUhpeFg1Y2NLT1loSVBzcVovMUNYenhRdlBtTzM3?=
 =?utf-8?B?QkFIV2hkVUZ0dzhyQmk5Y2tvbzdjVnoxQ2JNUGxraUxWcGMxQXUyVExzeUdj?=
 =?utf-8?B?NDk2cHF2Y0VsNGxFSUx3L3MyejZtOGNwZnlFUk1vMVNXNWZvUlFuSmpwU2FG?=
 =?utf-8?B?NnQ0NmZ2MlBSUllJNHVCVG9WbTRxYzFKLzM2MXBSWFNPMEpRQS9vdmJVQkFx?=
 =?utf-8?B?VjRQYnpWQ2JZQURHSk9weVJZUXpqS2cweXNkSjVMUjJQUmRBb0dIRGFZbk5G?=
 =?utf-8?B?c0NWV25PcTBEQlY0cXkyaGYzV1NlQzIwbjVGVVQwTjJ5S1dIMU9GNjNlWFpX?=
 =?utf-8?B?alg4Yzc4MVpvb3dnV0tXZ01MYU9QeE41TWF2cHhTQjZodzFoZ3JJRXA4MTF3?=
 =?utf-8?B?ZFh0eW93Z09hVUo5VWt3SHlvdW9wM3ZvcE56NVZ1aU1xRWxEY3A3VTNhcHEz?=
 =?utf-8?B?WHB4R2VHNHo0YTVLdkEvckkwaDk1ODRNUG91VGdLL0k5ZHJuZktLU1krbE40?=
 =?utf-8?B?L2lrQys3Qk5CclRVdmVaNTdqbElIL3FwT3o0WmRoZkxHbHNDc1RWNlN4ZERh?=
 =?utf-8?B?clNJbHNlWkNhWVNzUFN1SGQwcm1FWHRFTXc0TEJNbnBsTzlLV1J4MFVxQVk4?=
 =?utf-8?B?RVNIU2xzQ2hNbDBlNHhweUVDSHNLTzNKL1RNY0F1S2xrdmdMbitiR2JvRG5k?=
 =?utf-8?B?cmV5dG5wNW5mT1JSRHQzUGhmdnBvWXNnamEzMVRBUmtYZXd6OUJXb2cyb3V4?=
 =?utf-8?B?QlBEL0NmRGRJdnY4cW42QzNwRHdqaTdLbjJQLzlUN2lwRjR5RGNUM3hxM2Zn?=
 =?utf-8?B?eFhuRTdZM2U4cDlJOVRYRHpUbkU0WDdoNFBjZmQyaGVXajUwM05WaEZ2aERv?=
 =?utf-8?B?WXFyaXEyOFExRVRmYTRhVE4wMmtuTGVQTzJXTzloTis1bVNjZFdmcjNpdkh2?=
 =?utf-8?B?ZE4xdm53R1pMUDVPUFExMGRSNkZZVG42RXIwNFVPR1dvNVM0NGNpRHZuWUkv?=
 =?utf-8?B?V3RoM2ZpVUN6Q2krYUdySk5kS28vbTh1ZlRKRXB6OUl5VWVZU0N6cWhuS0d1?=
 =?utf-8?B?OGh2eVZCRFFZamcrakNTN0M0UXdXMXZxY0pUU0lxWXJhZEJLV2pscEgzREQv?=
 =?utf-8?B?WjROOUZLSTRBdzRPUlhSWmVMeUwrUnN4M0tqV284V0s4VHVUbVRZSU9UM2Z5?=
 =?utf-8?B?RXFwS0VkUVZocEZnUVgxWHpHQVpSTGhUQjRvc3hhclFNTDRzUjl3ZmdqMFM4?=
 =?utf-8?Q?o1xLU4JZ/VIHSf2MFFR+gKBJA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b5e7646-04a0-42be-bd16-08dc64a3e7de
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 21:17:11.3431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJSJWYtf8ezpeBAQwhYodHaNIqpPunQAqcBIM5YeykczS4xb8Po6rbV3YGzkC/rAiG0FCEI5RbxNnwn7Le78sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7848

Hello Boris,

On 4/24/2024 9:48 AM, Borislav Petkov wrote:
> On Mon, Apr 15, 2024 at 11:22:58PM +0000, Ashish Kalra wrote:
>> From: Ashish Kalra <ashish.kalra@amd.com>
>>
>> For kexec use case, need to use and stick to the EFI memmap passed
>> from the first kernel via boot-params/setup data, hence,
>> skip efi_arch_mem_reserve() during kexec.
> Please use this or similar scheme when formulating your commit messages.
> This above is too laconic.
>
> 1. Prepare the context for the explanation briefly.
>
> 2. Explain the problem at hand.
>
> 3. "It happens because of <...>"
>
> 4. "Fix it by doing X"
>
> 5. "(Potentially do Y)."
>
> And some of those above are optional depending on the issue being
> explained.
>
> For more detailed info, see
> Documentation/process/submitting-patches.rst,
> Section "2) Describe your changes".

Here is the more detailed description of the issue:

With SNP guest kexec and during nested guest kexec, observe the 
following efi memmap corruption :

[    0.000000] efi: EFI v2.7 by EDK II^M
[    0.000000] efi: SMBIOS=0x7e33f000 SMBIOS 3.0=0x7e33d000 
ACPI=0x7e57e000 ACPI 2.0=0x7e57e014 MEMATTR=0x7cc3c018 
Unaccepted=0x7c09e018 ^M
[    0.000000] efi: [Firmware Bug]: Invalid EFI memory map entries:^M
[    0.000000] efi: mem03: [type=269370880|attr=0x0e42100e42180e41] 
range=[0x0486200e41038c18-0x200e898a0eee713ac17] (invalid)^M
[    0.000000] efi: mem04: [type=12336|attr=0x0e410686300e4105] 
range=[0x100e420000000176-0x8c290f26248d200e175] (invalid)^M
[    0.000000] efi: mem06: [type=1124304408|attr=0x000030b400000028] 
range=[0x0e51300e45280e77-0xb44ed2142f460c1e76] (invalid)^M
[    0.000000] efi: mem08: [type=68|attr=0x300e540583280e41] 
range=[0x0000011affff3cd8-0x486200e54b38c0bcd7] (invalid)^M
[    0.000000] efi: mem10: [type=1107529240|attr=0x0e42280e41300e41] 
range=[0x300e41058c280e42-0x38010ae54c5c328ee41] (invalid)^M
[    0.000000] efi: mem11: [type=189335566|attr=0x048d200e42038e18] 
range=[0x0000318c00000048-0xe42029228ce4200047] (invalid)^M
[    0.000000] efi: mem12: [type=239142534|attr=0x0000002400000b4b] 
range=[0x0e41380e0a7d700e-0x80f26238f22bfe500d] (invalid)^M
[    0.000000] efi: mem14: [type=239207055|attr=0x0e41300e43380e0a] 
range=[0x8c280e42048d200e-0xc70b028f2f27cc0a00d] (invalid)^M
[    0.000000] efi: mem15: [type=239210510|attr=0x00080e660b47080e] 
range=[0x0000324c0000001c-0xa78028634ce490001b] (invalid)^M
[    0.000000] efi: mem16: [type=4294848528|attr=0x0000329400000014] 
range=[0x0e410286100e4100-0x80f252036a218f20ff] (invalid)^M
[    0.000000] efi: mem19: [type=2250772033|attr=0x42180e42200e4328] 
range=[0x41280e0ab9020683-0xe0e538c28b39e62682] (invalid)^M
[    0.000000] efi: mem20: [type=16|   |  |  |  |  |  |  |  |  | |WB|  
|WC|  ] range=[0x00000008ffff4438-0xffff44340090333c437] (invalid)^M
[    0.000000] efi: mem22: [Reserved    |attr=0x000000c1ffff4420] 
range=[0xffff442400003398-0x1033a04240003f397] (invalid)^M
[    0.000000] efi: mem23: [type=1141080856|attr=0x080e41100e43180e] 
range=[0x280e66300e4b280e-0x440dc5ee7141f4c080d] (invalid)^M
[    0.000000] efi: mem25: [Reserved    |attr=0x0000000affff44a0] 
range=[0xffff44a400003428-0x1034304a400013427] (invalid)^M
[    0.000000] efi: mem28: [type=16|   |  |  |  |  |  |  |  |  | |WB|  
|WC|  ] range=[0x0000000affff4488-0xffff448400b034bc487] (invalid)^M
[    0.000000] efi: mem30: [Reserved    |attr=0x0000000affff4470] 
range=[0xffff447400003518-0x10352047400013517] (invalid)^M
[    0.000000] efi: mem33: [type=16|   |  |  |  |  |  |  |  |  | |WB|  
|WC|  ] range=[0x0000000affff4458-0xffff445400b035ac457] (invalid)^M
[    0.000000] efi: mem35: [type=269372416|attr=0x0e42100e42180e41] 
range=[0x0486200e44038c18-0x200e8b8a0eee823ac17] (invalid)^M
[    0.000000] efi: mem37: [type=2351435330|attr=0x0e42100e42180e42] 
range=[0x470783380e410686-0x2002b2a041c2141e685] (invalid)^M
[    0.000000] efi: mem38: [type=1093668417|attr=0x100e420000000270] 
range=[0x42100e42180e4220-0xfff366a4e421b78c21f] (invalid)^M
[    0.000000] efi: mem39: [type=76357646|attr=0x180e42200e42280e] 
range=[0x0e410686300e4105-0x4130f251a0710ae5104] (invalid)^M
[    0.000000] efi: mem40: [type=940444268|attr=0x0e42200e42280e41] 
range=[0x180e42200e42280e-0x300fc71c300b4f2480d] (invalid)^M
[    0.000000] efi: mem41: [MMIO        |attr=0x8c280e42048d200e] 
range=[0xffff479400003728-0x42138e0c87820292727] (invalid)^M
[    0.000000] efi: mem42: [type=1191674680|attr=0x0000004c0000000b] 
range=[0x300e41380e0a0246-0x470b0f26238f22b8245] (invalid)^M
[    0.000000] efi: mem43: [type=2010|attr=0x0301f00e4d078338] 
range=[0x45038e180e42028f-0xe4556bf118f282528e] (invalid)^M
[    0.000000] efi: mem44: [type=1109921345|attr=0x300e44000000006c] 
range=[0x44080e42100e4218-0xfff39254e42138ac217] (invalid)^M
[    0.000000] efi: mem45: [type=40|attr=0x0e41100e41180e0a] 
range=[0x0000008affff5228-0x4702400e53b3830d227] (invalid)^M
[    0.000000] efi: mem47: [type=1107529240|attr=0x42280e41300e4138] 
range=[0x300e44058c280e42-0xe0d049a435c728ee41] (invalid)^M

..

This EFI memap corruption is happening during efi_arch_mem_reserve() 
invocation with the previous kexec-ed kernel boot.

( efi_arch_mem_reserve() is invoked with the following call-stack: )

[    0.310010]  efi_arch_mem_reserve+0xb1/0x220^M
[    0.310686]  ? memblock_add_range+0x2a0/0x2e0^M
[    0.311382]  efi_mem_reserve+0x36/0x60^M
[    0.311973]  efi_bgrt_init+0x17d/0x1a0^M
[    0.312565]  ? __pfx_acpi_parse_bgrt+0x10/0x10^M
[    0.313265]  acpi_parse_bgrt+0x12/0x20^M
[    0.313858]  acpi_table_parse+0x77/0xd0^M
[    0.314463]  acpi_boot_init+0x362/0x630^M
[    0.315069]  setup_arch+0xa88/0xf80^M
[    0.315629]  start_kernel+0x68/0xa90^M
[    0.316194]  x86_64_start_reservations+0x1c/0x30^M
[    0.316921]  x86_64_start_kernel+0xbf/0x110^M
[    0.317582]  common_startup_64+0x13e/0x141^M
[    0.318231]  </TASK>^M

Now, efi_arch_mem_reserve() calls efi_memmap_alloc() to allocate memory 
for EFI memory map and due to early allocation it uses memblock allocation.

Later in the boot flow, efi_enter_virtual_mode() calls 
kexec_enter_virtual_mode() in case of a kexec-ed kernel boot.

This function kexec_enter_virtual_mode() installs the new EFI memory map 
by calling efi_memmap_init_late() which remaps the efi_memmap physically 
allocated above in efi_arch_mem_reserve(), but please note that this 
remapping is still using memblock allocation.

Subsequently, when memblock is freed later in boot flow, the above 
remapped efi_memmap will have random corruption (similar to a 
use-after-free scenario).

This corrupted EFI memory map is then passed to the next kexec-ed kernel 
which causes a panic when trying to use the corrupted EFI memory map.

>> Additionally during SNP guest kexec testing discovered that EFI memmap
>> is corrupted during chained kexec.
> That sentence needs sanitization.
>
>> kexec_enter_virtual_mode() during late init will remap the efi_memmap
>> physical pages allocated in efi_arch_mem_reserve() via memblock & then
> s/&/and/
>
> This is not code. Please take a greater care when writing commit
> messages - they're not write-only.
>
>> subsequently cause random EFI memmap corruption once memblock is
>> freed/teared-down.
> "torn down"
>
>> Suggested-by: Dave Young <dyoung@redhat.com>
>> [Dave Young: checking the md attribute instead of checking the efi_setup]
>> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
>> ---
>>   arch/x86/platform/efi/quirks.c | 20 ++++++++++++++++++--
>>   1 file changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
>> index f0cc00032751..982f5e50a4b3 100644
>> --- a/arch/x86/platform/efi/quirks.c
>> +++ b/arch/x86/platform/efi/quirks.c
>> @@ -258,12 +258,28 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
>>   	int num_entries;
>>   	void *new;
>>   
>> -	if (efi_mem_desc_lookup(addr, &md) ||
>> -	    md.type != EFI_BOOT_SERVICES_DATA) {
>> +	/*
>> +	 * For kexec use case, we need to use the EFI memmap passed from the first
> Make all your text impersonal - no "we", "I", etc.
>
>> +	 * kernel via setup data, so we need to skip this.
> What exactly do we need to skip?
>
> If the EFI memory descriptor lookup fails?
>
>> +	 * Additionally kexec_enter_virtual_mode() during late init will remap
>> +	 * the efi_memmap physical pages allocated here via memboot & then
>> +	 * subsequently cause random EFI memmap corruption once memblock is freed.
>> +	 */
> Why is that comment here and what is its relevance to the line it is
> above of?
>
>> +	if (efi_mem_desc_lookup(addr, &md)) {
>>   		pr_err("Failed to lookup EFI memory descriptor for %pa\n", &addr);
>>   		return;
>>   	}
>>   
>> +	if (md.type != EFI_BOOT_SERVICES_DATA) {
>> +		pr_err("Skip reserving non EFI Boot Service Data memory for %pa\n", &addr);
> What is this pr_err() useful for?
>
>> +		return;
>> +	}
>> +
>> +	/* Kexec copied the efi memmap from the first kernel, thus skip the case */
> kexec? This is a generic function - what does it have to do with kexec?
>
> The subject of this patch is:
>
> Subject: [PATCH v5 1/3] efi/x86: skip efi_arch_mem_reserve() in case of kexec
>
> and yet, nothing skips this function - it adds a bunch of checks,
> printks and early returns with the intent that those early returns
> happen on kexec and thus the actual memremap doesn't happen there.
>
> So it is some sort of: let's check things which will be true in
> a kexec-ed kernel and thus avoid the function by returning early.
>
> But I have no clue.
>
> It sounds to me like you need to go back up, to the 10000ft view and
> explain how exactly this efi_mem_reserve() causes trouble for the
> kexec-ed kernel so that we can think of a proper solution, not some
> random hackery.

The above details explain why and how efi_arch_mem_reserve() causes 
trouble for the (nested) kexec-ed kernel, additionally, there is a 
another reason to skip efi_arch_mem_reserve() altogether for the kexec 
case, as for kexec use case we need to use the EFI memmap passed from 
the 1st kernel via setup_data and probably need to avoid any additional 
EFI memory map additions/updates.

Therefore, the first revision of this patch had the following code to 
skip efi_arch_mem_reserve():

void __init efi_arch_mem_reserve(..) {

+ if (efi_setup) + return;

But then based on upstream review/feedback, the second revision of this 
patch, updated the patch to check the md attribute of the EFI memory 
descriptor instead of checking for efi_setup for detecting if running 
under kexec kernel and the checking of the md attribute of the EFI 
memory descriptor introduces these additional checks and pr_err() which 
you commented on above.

Hopefully, the above detailed explanation captures the reason to skip 
efi_arch_mem_reserve() in case of (SNP) guest kexec, looking forward to 
your comments/feedback on the same for me to rework this patch 
(especially the commit message) and post it again.

Thanks, Ashish


