Return-Path: <linux-kernel+bounces-153747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA9D8AD2AA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F6DD1F21789
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4006B15381E;
	Mon, 22 Apr 2024 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="WGgVGHS5"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2106.outbound.protection.outlook.com [40.107.22.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6851B846F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713804406; cv=fail; b=a9M+6CXIND4u0t6Yjsh3GBbQxTS4LH+HZFPLJ1JYQVWJr5mwUdAAz6R/HeYPO4/KwtdP4GL9QTtG103jJefAhWY71Zh2MGL+s9ZXpqQGWPAXg692OWcEyGDHHcs8hUQXmLIyEoe5z366T7B0B7wDI7w1BzZteDIO3dvW55scpZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713804406; c=relaxed/simple;
	bh=bB2BQn5+F9ClRu1Ezpq9JvLWjpEj4I7jFj1qWbgrkzs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZbOorxtXPqqpYZCiJIs6Y/k4qWhDFLOb02Gis3KmYnF+LxkRt9e7+8y4gEG6TY0/CvZFwOjiQgdLfPrdArtYDqMl7hZ6nfAjri0+YitrB1m3mb23TBIPY9ouzRsxzqwE+/enxvscX1ImciMAmZSPn1yow4Xnhpfhvpm3bm80h3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com; spf=pass smtp.mailfrom=theobroma-systems.com; dkim=pass (2048-bit key) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b=WGgVGHS5; arc=fail smtp.client-ip=40.107.22.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQ4/nAkG5wBOQui86qGpLYjmCsqeSnH9MaZ+h5l5kAtSD4XHz5ue4/8yaBZbEqdZfOc6Fxl8GrWpJm3cGqIO/uTi3PQdZu5RRe1X/g67RdI6nhMlh6+3cqe1ldP0tooHoYX+eQFKHJlPRqUNRZb6iFMp+jwdBPVbDb9QoTarY+UT98iXpr8MNNJhs39MZLg46hfq5aEm8PA2ntxOYyX6eUeqA51f4CDqyGv2K3yW5Ijz8n9VmqyIW2YDW7sfIBJx10CUz9pmn/XySaN1V7XUxW7tM1w7yZWNL7DqGYyfFrY6GGtPn8MLhD/r5XWMAZVBOsVuhavYsRpVMQXhiG4tLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o28qwuglf197eIzwApfLkDNM2qKZO9LaW1eoNeB+jPs=;
 b=bBJgCHlfEW5DiWAg2FVCfl6Vac4vIdppmOd/dOhtVhzdNVnicZvV6JMYT1qIxhyZBeNSjYElEg/+FIcbt1IuEJpuKaODSed7Kyu4yLGONGAge93iG8FHa0wxJEStE9Dypi23gk7rSRvwAWRMJK1OZOK3ObftaCsHdITXpjhtjo9VCqxlYm3L0HwVYSdZIXCqYGO8TH6Vx+1tPIIuAiair2JihhcHvIDsTnaNAgmLcvcjcTUAopV9x9RJ+UJYt/c6rcbvRBMsKxoExwjuyug0olS8wVcYrlW4l9AnohsPJrICy6I4QxaEHr65//NAz9qkf2c+6Klu0GkZ30za2L4drw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o28qwuglf197eIzwApfLkDNM2qKZO9LaW1eoNeB+jPs=;
 b=WGgVGHS5NqzYmudvrJV/98LEGPLbmYZ/Njh1ZPIKrU3q9rD0cJ6vFHSIhrBmrgOU4kfq2yIWHRIgJFmx65H/KP00R0DYz/jL1Xi6UCxwGKZwGt0QDP1FvXmTs9d41yEd2j7pGv1JPkE3sQQj55YRKdjxSFucoOoWg80WZ5MIip5Kmmpwa490C6oUNHrquSDn02MXh0CZ3TUTKubkHcxQJVxvQHzsDDobGWklgZEwvN/5Y3YtcRC37oRK1lRet4GyHTmf1rVZT7QTgk6s7BH+MXCbEghVBujltWR8gIMx6gvY0JoxAM5ZaIHj0gE+hNWMiZO3GPL4D4cKhGUjkZ6IpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com (2603:10a6:10:1b::13)
 by PAXPR04MB8704.eurprd04.prod.outlook.com (2603:10a6:102:21f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 16:46:42 +0000
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504]) by DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 16:46:42 +0000
Message-ID: <533fef17-87dc-4af4-8080-d0f3dfd68722@theobroma-systems.com>
Date: Mon, 22 Apr 2024 18:46:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add support for the dual-role dwc3 controllers on
 rk3588-tiger
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240422163951.2604273-1-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240422163951.2604273-1-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0019.eurprd08.prod.outlook.com
 (2603:10a6:803:104::32) To DB7PR04MB4842.eurprd04.prod.outlook.com
 (2603:10a6:10:1b::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4842:EE_|PAXPR04MB8704:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf7af66-3ca8-4881-9b72-08dc62ebc98b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUN3YlhGNVNZcDZ2OXhUL2U5SXdJdi91Mk16Vi9GQ2VNS244cjRkc2wxYlpw?=
 =?utf-8?B?TVdFT0x5aUhpcUFhaFpaNXJpYXFPazlSRUNEZXhDMmZJWGRqNHFrNHlHSVFF?=
 =?utf-8?B?TkZodjA2dXdzU3BlWnpuRmJxUHR2QVNnY2o1SFJvNzU2NWlJZzR0cjArTHY1?=
 =?utf-8?B?UkV1WVI3MXlKNFRkN1dVK0ZyWktpMVdtRkN0SDFjMDR5QXNLTTc1dmtzcTdL?=
 =?utf-8?B?ZkNkVU8xdXpZUDRWTGIyTUEzMmZTZCtPNENFNFZDRHRwVWtsSHZxYmozbXRw?=
 =?utf-8?B?cmVOQXhzd1VGQzNtNWExbko5MVR4cGkrZm9IVlMxVTMzRmtLMGJweHJUNkRY?=
 =?utf-8?B?ZVVhL2dGQzJLOXEwWDRHYmdMakFaR2FkcW42Mm1BTFZSS2hzTkVGb0JTa0hw?=
 =?utf-8?B?V0VwaCtXNkpSZE1KNVJnMVFRYWNua2JTM0t4d3o0TDJnZ1ppTFFRN2phamZ6?=
 =?utf-8?B?Z2tRemsxR2FjM1ZwS0VDbmZETkx0ZUdHdTNaQlZTOEg1aHJrMGF3UWtPa1o3?=
 =?utf-8?B?TDlrdVJ6YWk4TU1FS1lvVGthTVdPcHcyZ1o5azB6UDdsN3lIYklDV1JFVEw3?=
 =?utf-8?B?LzhQV0kyam5mSUFPbDVLTHovalJFSGt0ZHF3NFE1dVFhMEVoN0c0ejBsVkZY?=
 =?utf-8?B?NmpMbmMvOVl3c1cyR3FqUThpSjdFR1BqLzFwaXN5M2Y0UmdmMUhqSWZwMGw2?=
 =?utf-8?B?cVUwaVgvMkhRSU4yV2JPVnJaOGZaNHRMOGpmWGNZR1JiVW9Eb3JMdnZXcWxh?=
 =?utf-8?B?MWNtOWk1Z3pOZWFUOHNPb1dPaHBxNDFGRHBpcndRM3VwTWoyeEM0SmhPczBF?=
 =?utf-8?B?ODFPODg0UHpnT2VsNjhxc0M1ZGRVY04ybCtwb1VZcm4wMzBEQlZZQlc1dnMy?=
 =?utf-8?B?bFRCYXI4MytmancxcXdOL2QxY2tjL09HZU9xUEV1NmFhM21zdlpVQWEzSnR2?=
 =?utf-8?B?bHVIMDBzZ3dHS290SU1PWjVVMm84S1JRY0JEY2cwOERuZkgvVkdiMlpSRzRk?=
 =?utf-8?B?Um43L3cxbEgyUTJMaTJxZUhhY0JGeUM0U21DRXdKeEdtL2NNWWFFVjhoMmtn?=
 =?utf-8?B?L05hUmVEd3NNL0czT21hblRSZHNIZFZWWHBFQTZrSDYrbUFNVi8rN0d4QWlY?=
 =?utf-8?B?S2JCUnhqL3AxRHdlaCs1VmVSSmNkU29OSGxlbm91VUlPSXZveVJFdzNsemVz?=
 =?utf-8?B?UUlLWEk2bUhCUnpJQlNGNHhESG1EcHlKSDVNeW9POXRqbFJKNFU5L1N0T3ls?=
 =?utf-8?B?OUNBNEsybnlYdzRGOGlCUGU0c09ISlpYaTYrV2NmK0JCSS9NSnAyN2U0VDRI?=
 =?utf-8?B?bHNIRHFnSVpISTBZeVlUd2tEWUdUd0kyTVJDZFJadjhpSXh0TitaRDRRZkpt?=
 =?utf-8?B?UzJLemdHT3J0aitmc1lJdFgrU0dReXBUdTBKeDlZYXJGbTBYaTJweG5UY0F0?=
 =?utf-8?B?ZWFjeFBYemtxZ00yYVhiV1IrY1N6cmtiU3VNUXZOdFljRlBwano1MlNyMVpt?=
 =?utf-8?B?YUw2QUlkRmQ5VGplS0tvUjdJSFNaQXVSTlBCdFJWd2hpZHUwcTBQMVN3UFM4?=
 =?utf-8?B?T0ZnMGlTMVhOQ3pUMlVPMjVYMjhZNWZ2L3d2V2Y3d3R4cHg5RDVVdDZXMEJh?=
 =?utf-8?B?TE1aUUJDZ3pqQWlYM0hzRlB6SEw4djBQNWtUTEg3ZFV1a3BSRWZIZWUxcFVC?=
 =?utf-8?B?czJQejJKQmJoT3FKakI3bFRCQ21VZHNuMWs3RkNjQUNPd0tMVGNLUEJRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4842.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDJlNTVzN2FpbUdBRnpEMFNvL1Z4TERrSEVnalQxRWFXQnU4YW9YT0xvYU9u?=
 =?utf-8?B?bGZjTlZpb2ovZ0w0dzc1VG5rQXd5bUltN0NnTlBMUkNhRk1rRHFOU0dFOHpw?=
 =?utf-8?B?eVNPMjF6bTNoQWdmR0UxbVJNZENaRXRxY1RXSjRncXVyNGVVVis2ZHpHZUhz?=
 =?utf-8?B?bXI3NHhiQ0RFR3hBMHlWcTdzazZTNWdmRWZPNGFCV3BxcnlJNXJuSmdkekZQ?=
 =?utf-8?B?amFyMzRHbVdIaVI4VkEyUkdLSHRUdmNOSXlENTJyakpPMFU5UXFWc0ZldmVQ?=
 =?utf-8?B?MWllVWJ1NjF1Z1QxUmsvVmpPcVJPaks1VkxQeDc3ckg3TW8vZjAzSkhSMjlK?=
 =?utf-8?B?ZTArdXRLMHExRStUNGRSbGhucFk5REdOQ2VZb2hRNkE5MkQwK1U3SEFNUGVv?=
 =?utf-8?B?QS9BTmtiNVdyZmVHZmFOamRjVnVxNmJtbTQrb0FycnRZU0VyUkhCMzBNTEE1?=
 =?utf-8?B?MTdlbEFpZWtRclliQlBkbU45RVpHeU0rQ2dXaHdTTEI1cHYraHJzZXpGQlZt?=
 =?utf-8?B?a0tLMDhac0ZGdDUyVk9oRC9vSkRsaHh6T2RCQ3cwY20xUWFMRThXUHNia2ph?=
 =?utf-8?B?dWtHSTkzaDBrd3I4MEczR3ZuUkc4b3RkWFdlVncrbjJpa29sUDJIREh3R2dw?=
 =?utf-8?B?RVE4U25ZUHM4b2hTKzd1bmhKRGc1T2Z1bG1mTk5TZkNDZUdTTjZBR0gwNTYy?=
 =?utf-8?B?bENORndWeXFURDQzVlEvVmhITjY3cUFJOVNkdDFqaW15aTNtSXkvUDFrYWl5?=
 =?utf-8?B?ZnpjdWhjbHUzbUowbkdJMVJnc29PWEZvSW4yQWFaVGorbERaWVJLNGtVVjh0?=
 =?utf-8?B?M0szRHVWMnRYaXRjektUUmc4NmdML3NsR2xhcUNFQXk2M1RRM1BnSjNEZy9m?=
 =?utf-8?B?cDdTTkNwYXNxUHljOTZ5NmtXY0tqQmh0bUFCMmxIMHRYVEY3K3FVLzJvbml3?=
 =?utf-8?B?ZTRMZVFKUkV5QUFlK0NwSUxSdXhkYVNqS3M0eVBNakJ1aG54QWFtOTJadXl1?=
 =?utf-8?B?NDNaclNDenhJS0NLbU15MUdCUmRkZUFIVVlyNjFqZkVIQm13eGJZaUNWVUFm?=
 =?utf-8?B?Vkd5dHRFZGNhVVhrWnlzaVhSb1YzTVJsT1h3YWdES3hjbzdoajBGcG1EQkVJ?=
 =?utf-8?B?TVJUSktNWm9lTEpxZG84V3NTR214RzY5WFl4QkYwNWw4TGcyQzFJRXpsZWlj?=
 =?utf-8?B?RWZRSE9Fam9oc0s5VSsvMDI1ZExzbHF2M1cyQjNad3BISUQ5SE1ZYlRpWGZV?=
 =?utf-8?B?NkVMS24zVHJoZTBYTmpKODRQM29tcjg2SXhnZnViOUIzNGNWbXduZmpwT0lQ?=
 =?utf-8?B?MTJuT1MxY01YSmxMUzQxQ01IN0JLeDI3a1VXb3JPRWZaYmR1anlyZU83Qnd0?=
 =?utf-8?B?OHlpeXlvU0loSmZuZllwZXluUFlPQm1pQ3ZVcXd1K0JoaUk1OEEwbXQ0Q3pJ?=
 =?utf-8?B?a3VtVFVhMFRodCtlRXVzcUY1VG00Z3FFdUhwWWMvWS9weXlKMU51ZlFaa3lz?=
 =?utf-8?B?STg0MlM2V3RwK2gwRTBrZ1pOeFgvaGZSKzVlV3BmV25sN0JKY3hFdVZTVmtw?=
 =?utf-8?B?R0pYcDRjZkVDa2x3UGJCL3plSjJJM0F5VEZPNUl0WWd3a1JiMnU4eHA0Tmdr?=
 =?utf-8?B?MnY4anZKclVTcFVJbkRiTitsbU5GT3RwVklXUm9HcTBGbkNGbi9BTGFoNmI1?=
 =?utf-8?B?RGF4UEhIenk3ZGdUUVpBMmh2cU5vT0Z1Uld0ZUtVRWdLeitFSGRaRGhBVE9k?=
 =?utf-8?B?VmE5SkxHMEhqUmhXUS9SYVBBdDFzNjAzUzhheUs2RnpLR3VIL3puSkFZVmpE?=
 =?utf-8?B?VFZqTWJqVjJ5akhNWmk0QmZncWNOWER0dnlmVXJQRnprT3h0WlBSdWdjVjFR?=
 =?utf-8?B?MWxDbUxJWEp5QzZhL3g2eWdEckVPTndVL05IbFhTb285QVdqUUxsMFZMdEh4?=
 =?utf-8?B?TkNBNk9VREtlbE9PRGVJbFBVMkVpOWhlWHlKRC9sNVBHeTNydWI3Y0R6U0pQ?=
 =?utf-8?B?UExKVlA3T2pnZkVVcmk3NlJ2N09WeXZZRVN0bFd2Yjdldm1idkxiYmZZMThx?=
 =?utf-8?B?NC93c1hQQVEvMGlVMEg5ZmRZbXM5Nkx0ZFNWK3BDRVMyQS95cEp5U2JMdnlZ?=
 =?utf-8?B?SmZaZlZzaW5ubkNXQTNVbEw0eHRVYXhtMHlpa05SZHBuK2xRL082VFI1TkYv?=
 =?utf-8?Q?UhViYs1E3lng9L8Q9d0+rAA=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf7af66-3ca8-4881-9b72-08dc62ebc98b
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4842.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 16:46:41.9618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kA8iYa6qgmZfTXd3ncohMkjGwM16WsinIA7QYyVBWlyBVIFWW5WXuLp4S9fQ8Ac9a+Zq9frK2vtdG4a5XfTMMjwArea4DdQAqbe5SyY1xpAeFLxu9cYQNQ2UGB4gHINK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8704

Hi Heiko,

On 4/22/24 18:39, Heiko Stuebner wrote:
> A comment fix and then the addition of the nodes for the dwc3 controllers
> using the newly merged usbdp phys.
> 
> changes in v2:
> - split out extcon addition into separate patch
> - fix comments in patch1 to cover all affected controllers
> 
> Heiko Stuebner (3):
>    arm64: dts: rockchip: fix comment for upper usb3 port
>    arm64: dts: rockchip: add usb-id extcon on rk3588 tiger
>    arm64: dts: rockchip: add dual-role usb3 hosts to rk3588 Tiger-Haikou
> 

For the whole series,

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks!
Quentin

