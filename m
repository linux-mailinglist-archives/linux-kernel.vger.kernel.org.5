Return-Path: <linux-kernel+bounces-160380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799138B3CE2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 823811C2244F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D57156C6A;
	Fri, 26 Apr 2024 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="omDnYmpO"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B2B44377
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714149147; cv=fail; b=Q/+wi82J3wibUbPp6bVyS0iPgh03Jgkq2ua6wT0OKSK3OslB/m+nwZUafb99frKOxuL5PFlabBiWdlpNLq92VIyOntuhgWc736Uh12guHoPV37ab0waXwUnjHcpbaCNUR/yrSS3KU0xrgpDLlxmTjf66zr/ZTuAKZTjrrCHvxOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714149147; c=relaxed/simple;
	bh=EeVnQJmi9ZsWs1HXXcPWMKTre1MWOuVSp/rKzZ7KPl4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l65OAPlWwjUW/GYsP7ZE5RBcd7ucu+YTnr8bdTyXDGzUehWsKjJt5Y8cWdPZ1pv/tPQ1YtAhth1K3KrRhPe7trLO82w2G4gZC6Bfn4dF0nye3cvr68y0wD3LBuvuOXkOTdzUDCBEBLuza/PmAPRs9pSR5kzEsN/Sy1wOChpgYHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=omDnYmpO; arc=fail smtp.client-ip=40.107.92.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dablu6ju3aFhieMKvaJNEFxs7xkmvpixc80HXYoHFvPz323LOIkeeM+DS0pbTd5inAIYSEo3Cl+P5UeULWd83/nzh3nVh1zOz+MzObLdWM/APjMzbfNDxB9c3wwRb5Y8KdSv2jaQWhy9PC0ZIaNqsw2mrzP69hKEgClSc3dWEhaYmdhCxrvqZj1syoV6HvA7AyzADehBCeWjyCGstnie9PYz24OCggB06bC7GzTjoHUtzEbAQT2KDZgdnaQNYXCbNy9//90932vykzHK8+YjBunAcqWP1VUDGDTMzUcfZe8CXSOwHlb3+x9gsp9op8K4JB7elU1MYkeyl/ZiqMcrvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USDu9ZXyQh0PaeOqxxZZhcigWM4UuCufdjzOJlTCepA=;
 b=YZfAu7KuReBcG7iMxYejAUBlZDz/sYyRkB77Q02xJ7KTjUcFISSBT41jmJX6qc34BM2/gneCHe22OX0DqJDQq+31G7XdyRDf/4E5YqNg7zxDBl9PzRwNaF43U6r3cs/ilC824vzvBY6yRp0p+oDXJXlWgNXPXvpWuAh/IgA+nOJbowHkNF2utTX9cRiy1z6ysftXLC73w4U8tzzcEsVBm/mveHgNBQIB8D/hJG28AlTc0uJPIxR/F+dpRnjXktmS+Qz5dv4zMbGm/iTKmPeH3GcEfu1R+Oi+hF8BEjwAWIX0bDEN//WeIw6QjgZrlPSTsXNq87Uau2XauKH/Knpj+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USDu9ZXyQh0PaeOqxxZZhcigWM4UuCufdjzOJlTCepA=;
 b=omDnYmpODTFb+uLg7p9ZP7hwCyV4oY1MEC64+8qUfxUOw0Hg7YJeEkShRzyTVEZYzZwIYlzjUqRRjk7mtQExoKoFOQP10/rfVSWke+x90PMhi53tKC6VERNOogCOoNXZ5EQK7CTQUNSdbGPKhlKe3QoUZTU3IcgZCa2/jF1mMsw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by CYXPR12MB9443.namprd12.prod.outlook.com (2603:10b6:930:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 26 Apr
 2024 16:32:23 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26%7]) with mapi id 15.20.7472.044; Fri, 26 Apr 2024
 16:32:22 +0000
Message-ID: <1aa10410-3d40-41c1-a2a4-1ac20de6ed21@amd.com>
Date: Fri, 26 Apr 2024 11:32:18 -0500
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
 <16b34494-7e5f-4feb-8a21-58e7b8fa97e2@amd.com>
 <20240426142119.GEZiu4X8VPK5He4zH1@fat_crate.local>
 <a1d80cce-28d1-48e8-bc38-8960d8c90774@amd.com>
 <20240426152221.GFZivGrY86svE0RZ00@fat_crate.local>
 <debd333e-6897-476a-97fc-02246e97a24c@amd.com>
 <20240426153425.GGZivJgbBxzo30ja8V@fat_crate.local>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20240426153425.GGZivJgbBxzo30ja8V@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0100.namprd05.prod.outlook.com
 (2603:10b6:8:56::23) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|CYXPR12MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: 26520e20-4347-4018-5ae2-08dc660e72e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHVKU00wYzIyQUJxTVNtcnVjRXN0dUFKOE1Jb3BhbFNVZ042emFOSkdkV2lu?=
 =?utf-8?B?WG5DOUNVN295NU9XVmNRbmZIcG4wOGppM2VXQjBTeit6NHdFSWZUTDBIeUhE?=
 =?utf-8?B?RWVrUlpPYXNMUFFKNWtHZWpOL2NhNE50b01MVFhIb0pvYWMvbjNSenBMNXJL?=
 =?utf-8?B?YVZkZjNOR1Z0S0Zwb0NEV3oyVGF5QlNibkdnN2hES25PbXpoeHFYZGVoU2JH?=
 =?utf-8?B?RmRZS3V6cWt1d2ZVRXY0dGNBaUZPSEJ6QkU1dXJsNHhwYTJEM2QvT2doTkV0?=
 =?utf-8?B?dWk3SDNpMXRlZHhSMnFnWUlxUlJjYWZUTVNxbjFZSExaQkcwU3hmbWJhQ0J4?=
 =?utf-8?B?ZGZHcHVoc0hBTHVjNERvNEpDaTJidWE0akdHekFTSyswUmNWUncxdzhBUkFE?=
 =?utf-8?B?K0hnSEViaHBIcUptNy9Kak5MbzRYc3RmSUIrcUNvVmxwUFdKMmxPQmhaVVNw?=
 =?utf-8?B?Q3JLN3dtMHREb1cvcGNsTTYyaGpYOFFmcmY4V3E2TW8vc2RiaFdNMWFISkM2?=
 =?utf-8?B?ejdvRkpBZW02ZUUwZFNnb0ZPYk5lVitXV2ZXYjExeDRVdU02Qjd3MG56amtE?=
 =?utf-8?B?MWlGenRiaFdVR0N1eWUvY3NmWEtod01kT3VHbnBUTDMySXVEMXlpWnZkZFhj?=
 =?utf-8?B?b3RPakJPTTdHVmZLQTZ3MUgyblgzaFhjRThqdEhTcFlZeEp5ZHduUHpQdGoy?=
 =?utf-8?B?RlpCV1Exem5LZDVKbnJYMXlhMXRYTTVZRkViUE5xYkd2NGorWFJDYTU3eXN2?=
 =?utf-8?B?WFJnK2F6YXBHU3VETlRNTEF3NHR5U1Q4aGx0OWxPZFdtRXB4Z0MrcHc0Uk9m?=
 =?utf-8?B?WDZ1a3EwQW5yeXZhaWRMQnhwQTRaalZQOFN6cDRFRldnbnViYUpNTm1zL3lr?=
 =?utf-8?B?bjdLN0h0Wjg3NFA3MmhzZkFJT1JiTDNsb0t6alFXUndYOHk1dVNzTElabm5R?=
 =?utf-8?B?NWpJZW4vR1RseWJuMXZyaXdVRW5IOU9wamJTaVdzclBZTGNNTmdGL2xUdmJa?=
 =?utf-8?B?Zk5SS1k2U1ptVzRZQ1B2dHh4ZktvMWZ4MHhUMXV2dWl0VVpTb1laQkpVNnVO?=
 =?utf-8?B?RHNqWVROTFJGTWM4V3U4SXovZDh0aUlnNnVQcFNPMlZzZkFxWXR3c3FpNGRM?=
 =?utf-8?B?Q1FxeFBYSjFRcWhYaXFjdlJGcU1DdnAwWkRwS2Rnd0hpTmYvTXBxK1FpQmpS?=
 =?utf-8?B?U3NPdjljSjc2YkpzMnJPRkVvNmxHVjhBdmROdVByaENUSm5pRjhqWGRoS2Rl?=
 =?utf-8?B?eGFkSmpqS0laZFFTTXJ4YlVKWUxPcURjUzE3Um9kU0ovWUJZbmkycm1rN3N6?=
 =?utf-8?B?SWg1MGtWYWRiQ0RXUXVROWg1SGpOZVJER2lhUWlIdGlIVDliTG1tTHorYk1p?=
 =?utf-8?B?MTJzRk9sY1kxdDR3Y1Z5SmZMbEtaUFY4Z3QxSTFUc3ZqeXJXcVZMdUl5SGl1?=
 =?utf-8?B?Ym4vMklXSlZRTzBwK29Hdmo5TFhNbVZabVQ2SHo2cTlxMWVtVlBPMXNIaTJx?=
 =?utf-8?B?OGVTc1FpWmtDa1BwMjlGUk9tUnFGTElVWkxJZnZFd3JtVHJXQnVSaVJoMmtB?=
 =?utf-8?B?SUpUZ05GMVU4bk1YcDU0dXlzVU8weVN6UzYrRUJFWFVuQWRsOFVRaFlMQUEr?=
 =?utf-8?B?TWczbUJTOWxSUVc3cW8zeGRmNWpqcXdxYzFIek1RQnU4SVlwM2ZyTXJuSEJw?=
 =?utf-8?B?U05KUEtnalhURUJMMDdJMHdzUXVKRC9OVkI1U092QW10MlFNclI5RjBnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDdPemp6M0N2VVFlTGZKelZ4d0ZkM0FTUXZobXRhUnpLNnp0akdFaHQ0MmVY?=
 =?utf-8?B?QXFnWExKZlJIVGc2Y0dYVGlLTzMwNllWbmtQUGZsYVlTS2lXVmhPNmRaQWJi?=
 =?utf-8?B?b3Y5SHFkOUNoU0Z2aWZZSnA3SFVJUUFTMFpsQ01YdFBXUFE3d3lrTUZRR3FO?=
 =?utf-8?B?bG5FQ2Y1alNJWlBtUzRocndwZ3p5MVpEZ0NOUDBOWlA3Q2pJQ3JMRW1yMXov?=
 =?utf-8?B?UTBmRU5lcU9qQUh0MFlZRDRtTm5qdlBWT3N6UE5lM2tHNXBFTFhSSzdCSW1K?=
 =?utf-8?B?ZXVaRHhVMHpHTmV3ZmYwaVVYUmQya3NiWWdPbnV5WStZaW9kK21IMlovSFZ6?=
 =?utf-8?B?OGFocWNCRmZ4Nmw3dzRHamFKSzNMcFdTY0R0OGFDc1A3VzdvUGt4NDZPb3gv?=
 =?utf-8?B?RUdLVEo4alhCUkwwK2lTL1g5UWJ3d2RSN3lwS0g0M3ZKRkEzTmNNZWxUbzdm?=
 =?utf-8?B?RUN3NDAvWFhpaURBdUt4YTVydXhtdUdEcEk5VGFWK04rRE9NWk9ZYlpMQUJH?=
 =?utf-8?B?eXc5M2ZDUUNqaWdsdlY3Rk9ZaGxnUTRYZTd0QXJ6bnB3TW9XQ0FKOG9rbTFE?=
 =?utf-8?B?U2JVTmRjOXlVNldIcnYxNThpWHhIVGNjeXlaQ2djeUtqY0J6TjBCWnVEQ0Za?=
 =?utf-8?B?YVBLbjFjTTBEWEQwc3l4US9uK0RmdFc2dGJpYXFnTGE1OFJ2TFB2NGpoVmc0?=
 =?utf-8?B?TGZMdHFpbEd4OFJmcnFVcGlNb3VPVUt2dzNJYlYreXJVYTE3QW1tYml3OFlL?=
 =?utf-8?B?Um9QNnVqdzQ1KythdStGTm0yRE5PSWU3aWlJZEN3TE50MXdNWU52ZnJTTlZ5?=
 =?utf-8?B?TDQ1YXhYMGtuTlF6bmp4U2R5dEdQOHkyOGRhT09BeENsODNRNWxVWDV3N2pC?=
 =?utf-8?B?Ui90ZlFiMy9hc2h2ak5ZSFhuSUZuVzh4WTB6c0tOQUhGSlVyaDExUUJuZUVV?=
 =?utf-8?B?TkxTWHlJaDUwbzVVTWJnUHJWaGgvcEFXdDdEQjVUTjEwTlhHWUxxOXJCOWJB?=
 =?utf-8?B?Ylg1Tld2NHdrbVl0TGxrUmFvanJ5dWNra0xPQUxLV1dGbDhUQ25xUHFVK0J2?=
 =?utf-8?B?TG5rSjJ2ZFhHRGxzNDJYMlgyNGlqd2xBVEtnWmN6eXJ4aXp3V3VjU1M3OTBH?=
 =?utf-8?B?dXI2cnY5UGRkbmRUWnoxOHRMNE9vOGpQV0Y3Y3p6TEp5STNSdVY0a0NmWkhM?=
 =?utf-8?B?S1h0UFpxRy9KQytRdGM1czBxUGsycG83OWN6QVc5NFhkNFo0Rm4yUC9DVjZ0?=
 =?utf-8?B?bCtMYXJEbjhmM3FTMGJuYm9kWmkrV0VsZDJiNys4Wjh4U3F5a3JxZkN3T1RC?=
 =?utf-8?B?NFh2QzFyTFppU01ZeDlqZzF0STNCS2hWRm5pZ3hkM0wwamcvb0poVGVoQk5S?=
 =?utf-8?B?SlZla1V4Rk1SemJVWDRyYS94dUQwa3RwYTJ0TkUrb2E3djViWmJWTmpLYlZB?=
 =?utf-8?B?MWpzYmhzd0g0bjlzYlRvSjBvVnUrdzZ6Nys5QVkyMEovUHY3d3RuNlpYMzg5?=
 =?utf-8?B?M2dHMUZwN1dscUNDK1cxdm1uNUtkMVBicXdUNldPMlcrWWpSbEJWMkRaUDEv?=
 =?utf-8?B?WUg4NCtaSTc1NjhTcmJLV01jUFJKY1lBdmtDNWxGL1FWbXNqelV3REc1QUkr?=
 =?utf-8?B?enoxY21xdHlBOG1PSE5vdEpRVkdpT2NXOXdWU25oTGoxUjJYNStJWXVPdUQ5?=
 =?utf-8?B?VndsVnFBWUVobVJPUHphTzduV01pbDQ1endMYlNyNkdWMWUrZHh6T1lBbnAy?=
 =?utf-8?B?bHNKSzBscHhqWHZ5ZXdkL3YvQklHbmpJZW1zbzhNWVBxOTZZNCtJU211cDdS?=
 =?utf-8?B?QzErTWxHVTJVUnZGOE01OXNzZFRuYmF0RE5hVnQ3Qm9uNXRzNnJFT2E0WXl3?=
 =?utf-8?B?ejl5cTdLZTFQT3RBaVdJMnU1WnlrelJOUWMrODErRys2Y1RTT1VlWjRFMi9C?=
 =?utf-8?B?WHBuRXVYMGJsZFdqVEZUcWVVNUErZVN1MGdQYzlJRXpVMWI5Nm1aK3N6bm4x?=
 =?utf-8?B?Y3R2MTVRQUtZUGlmVVg4Y0lLcWR1WlVlenZqUHl0MittUys4RGpQK0k1bkdN?=
 =?utf-8?B?U2R1d3ZJN3VmL2c1cVNSSlBnVEFYQkEva2Fzdyt0akRaQks1SFpzU0hCZ25P?=
 =?utf-8?Q?o2aMwdpHEqBkQvjEKDXyn18IT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26520e20-4347-4018-5ae2-08dc660e72e4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 16:32:22.9417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HaYlp+EbI9JKFdDrsTIHyXA1aOgqPVSMsLRkWPW50UAUXM7BPVE6/p3Pufw2uUBILhySriRPYSh3nYr1DASVxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9443

On 4/26/2024 10:34 AM, Borislav Petkov wrote:

> On Fri, Apr 26, 2024 at 10:28:41AM -0500, Kalra, Ashish wrote:
>> "Chained guest kexec" is when we are in a guest and kexec-ing into a new
>> kernel and then this kernel kexecs into another and so on ...
> Make sure to explain your terminology:
>
> $ git grep -rE "chained.*kexec"
> $
>
> and there's nothing "chained" about it - you're simply kexec-ing in
> a loop.
>
> Please don't make it sound more complicated than it is.

I have posted another version of this patch series (v6) with 
restructured and updated commit message for this patch, so please review 
this v6 series.

Thanks, Ashish


