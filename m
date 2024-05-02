Return-Path: <linux-kernel+bounces-166308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A80B48B98DE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ADC4282A5F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DD659B4B;
	Thu,  2 May 2024 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jMpGB1TA"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D63410958
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714646016; cv=fail; b=NpR/g9+93tTK7f+ZOmpUQc3kHHbPxgH7mjZGuaOTJbaiqn81P1t+R7h0hK/DYN7HyP9OnMm+6HZuVQjCvDGpqhmcNqT1em0Vt7SMiJkJ6cLzLRhi8D8VNIrtW0IehLmVtkU85ps8kJuRs89hdPv/zTFnSy50ruGCfAAUa9cKx7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714646016; c=relaxed/simple;
	bh=KdSycHd7/YaCgC5dz6rmjrBDfS9jb32hRPSDrtTDTx0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bgs5JBlZEmiYdUybShtYamB1q0B4qcqd6aBNs7rDcBTNS86z4L1HPsVu6hF+gNiycRyfxZy6LapWgKnrS4Gbg90OHZTUpN5bXs59ZJhDbulpoSAjj1laicETHfHpZVW94xGio+sx5KbKh152JWWFGXgZRGh4nzvGqJ9AxZOvOpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jMpGB1TA; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bgvp6YbMo6+p30llUIxeGr+sDLEiH7Dxs6LVgEAy3HSIobr9O9napRNsvyS1Loei/jwsLqixkBS49ndvVxqcmhaqJBwIqqakZPFz1QV3lNYDR/PUoh9+uukQLXWKIAQbR+piSyvBspsAKzMPMmei4ZQiCg3ymTDDB0ZzI2bPSfkxiC3+1BFTvhEfDnl7+Qyt60d42/QVfNL9OPQ2It0SfPIGn7aCwFi3T4zDcDdB23BDljCQtRZsO3ZmCJXBhiE4BhrxEplTFAlXJHeqHDZWVCwsUkozCrQELoUpfaq9wxo5Np53J9UjRE8/r6pXUCHpZzLF1MvptQbMZnJ33Rd7cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwMQMxZklRwJw6x7KIGi+A2iGng6oYihm8JKXCYbJ3U=;
 b=oJDBjg8GLbU3AnWNsg4gIwOzWLr+o2zjWPMbkiSNe5o6ShtwrZ5uNcClsGpYp85OVh0ffzmxltoMR/AmNcYIieD3ZN7bEK8eOgnW3BuHIzC+rQV8vr6bjO3KCWdZ6fSTsKiccjv8Pcu8frphtq30EHQKW1m6J93yADhl8R60ltToLGTk5edbk4pl5eHYHIu6gSv35QnA+RwDIsPbDC2L293PbZfDuy/lmWcA9dnuV+XABQGGNVgrEddKnKXZkbvc/pUo1C3uWGo5qoPfUMnwLI9R/Lc11ErQ5YeWwrN7k9/+QQuE1BMF3KA7bp3rVGAQPpfJBbbaYiGlrtOVvd5vvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwMQMxZklRwJw6x7KIGi+A2iGng6oYihm8JKXCYbJ3U=;
 b=jMpGB1TA1u1/PjzVrDzzZjctHzrQ1PNYCusX8xcfAeIlRF11gJA4RJSdf+01Ezysatvb9ToUAVVgulYWMnLMu40ST546mOBG6WccH/5FCnxFWRcO0ylCL/bIhxyv8okzIBaJHthYV2X+/TaR6oyYFUUR1KMX17aFss7Ca8Tx99g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB6942.namprd12.prod.outlook.com (2603:10b6:a03:449::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Thu, 2 May
 2024 10:33:31 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7544.023; Thu, 2 May 2024
 10:33:31 +0000
Message-ID: <016902d9-3858-4c65-b3ec-f7a5103af63c@amd.com>
Date: Thu, 2 May 2024 05:33:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Early boot regression from f0551af0213 ("x86/topology: Ignore
 non-present APIC IDs in a present package")
To: Thomas Gleixner <tglx@linutronix.de>, Lyude Paul <lyude@redhat.com>,
 Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
References: <3d77cb89857ee43a9c31249f4eab7196013bc4b4.camel@redhat.com>
 <20240418082703.GCZiDZVyra7qOQbyqn@fat_crate.local>
 <fd040809d95b3e12b2fdc78a2409e187716bc66f.camel@redhat.com>
 <87plumxz4x.ffs@tglx>
 <abbb7d7ca781f6c664e4c5b1dffc19394ac79691.camel@redhat.com>
 <87le59vw1y.ffs@tglx>
 <3a0afe545747e5314a9cb6bbaa9ce90b259ddfac.camel@redhat.com>
 <87edautcmz.ffs@tglx>
 <3b1d16e357c1f9badeef405366492f05af26c085.camel@redhat.com>
 <878r11t8zu.ffs@tglx>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <878r11t8zu.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0079.namprd11.prod.outlook.com
 (2603:10b6:806:d2::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: 16a70b46-4538-4c46-9a8e-08dc6a934ff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1ZEZFYwVmpNTmZ1cEhrQ09zMnZjdFdDcWtoM3ZGZk5Jc1ZDTTNaZTVWdFF1?=
 =?utf-8?B?Q3ZrNEJZMmtNT0pVQVhKNDlPQUwveVRySmp1SWIzVStJaitkQ2Rsbm9uR2Jq?=
 =?utf-8?B?bDUwbms0WFkwME12VG1HYXhkTFZSTUxWNW9ON1pmcFB2RHQxQnBSZjBqK0hP?=
 =?utf-8?B?emlIRTlVbXNad1BvUVVWV0J4MkQxYnZraDJRanRxRXFsaGo3WkZ1TUJ0bmha?=
 =?utf-8?B?cmUrSFovN3dPQkNnaVRQemlpd2JYeXJvVEFKNkQzeFNzMDBVU0JCdVNndTRP?=
 =?utf-8?B?ZWNvMFJSYnR1VDZMNG83a3Baa3R5eGhGbDUxQm5vNnhlZWhVekxBdVNmUHpE?=
 =?utf-8?B?U09WK0FoZ29BRm9zTkZSdGhscU8xY2RrR3NBN1lFYVpMRWQyME41YWtIWnJP?=
 =?utf-8?B?MEU1QmlEanhVQlFOYnhLRi82UTZkM1dncXNmZWRPdUZQMDBaTWM2QW96TTIx?=
 =?utf-8?B?RFFrT3FseXZYRG9Bb1hXWEh5N1FidGtIRWE2dTNmanlLRXRTTFJyNGpRU2RT?=
 =?utf-8?B?azlyUlJWS3RWT25EdVpNcDEwejRJMU1MMjIxelpnUm8zT1Y1Z1Rnc0R6aTVZ?=
 =?utf-8?B?bXNtZUx4eTZHdmoxSzZiVWFKU0FNN2xDZUhJTVNrRHRBWlNLRytTcnFEeWIv?=
 =?utf-8?B?Zzg1S2ppNTMyald4ZmZURXpFSCtRdzlnVlhITUlWMGNXdFE0OS82N2syUG0z?=
 =?utf-8?B?QnBXdFB3bHc2WC9KLzhUVW43R2NnM3RWd0ZwYUdTamswTUg1aytuSVpLVGRK?=
 =?utf-8?B?Z1BFY1oydzN0M05DTGU0S29kejVxWi9WUXBQK1hPTmhLKy9RSTBNV2ZNYVBZ?=
 =?utf-8?B?YkRHVzB3WlVFS0UvcDJaNlBWWGZNOHM0UHV5ZGczRTBVVXVhL1ZPL0hrWU1n?=
 =?utf-8?B?V25lY1JpdUR4cU9EUGtIQzRMYW9qNHhYbEs0RE41dzNUNHd0RzllNG80U1RK?=
 =?utf-8?B?QzlHYU5xNEdNbnNKdS9ncEdhWG5HUVZiMGNoUnVRUWlKVFJnSkNNeGdCdXRs?=
 =?utf-8?B?R3JJazFSY2RGN0tRMWV1YXBDVCtQMjloVXdVMkcvQklIVDkvOUtOWEliQXJv?=
 =?utf-8?B?UzJQdzkrQ2EvU2hrY3pXckpQOUlJaEtEZ1NET21LVEpnNWNqczR5Yks4QXlU?=
 =?utf-8?B?TlVQZG9DWGQvMmNJcXVSTDJCYVg2OHM2a0NSWGVYb2x1QURWRW1MSTV6cFhG?=
 =?utf-8?B?NTJIWWVydlVXSk9zUkhPNXM3MXduTDBDaGxzaHVUY2dmZ29uL2xLTWd4Z0Qy?=
 =?utf-8?B?YkhHZi8zUnlpNlhpNlNHNDRBdDVXV1h2dXFmK0d4STNlM0UyeWpQVU4xVmpI?=
 =?utf-8?B?RVAxTWZiNTNQZmM3alZSdXYzdlBGQlI0ZDEyWU13bDl2eDBER0FtSTRNQ1FS?=
 =?utf-8?B?ZllNQkRXdGRNTWlBdWxhVmdlbDhWZkIzb0V1NXlYSWJIUDFRNzNaK1dSME8y?=
 =?utf-8?B?YVpiR1M5YTNoeXhsdWRYQ0Y0UXViR281OURjb3E1djBLSW5rZmhGbjZEUWJC?=
 =?utf-8?B?UmxlZnJpMExEOVUxdGIzcnRCYUp1QS9hdGd3c055WkpwSFgvWnc3ZWh1QVAy?=
 =?utf-8?B?bWx4MmVESThJcTJYd3BFMzg2QzhUZUljLzRzU213aEpPdWJjeC9nSGRCd05Q?=
 =?utf-8?B?Q0hrVjRhSXc1ajZDS1pLOERUSnVmQ2ZWcUhPMEpWQkM5TkUwbHltZFJDN00x?=
 =?utf-8?B?aGlrK2dUOXdHWkUyS0dvaUFMblFhVHEzL0d5bkQ0L0dkZnhLbCtUNTJnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UjdwOS9GQWVVS0c2cXZjR0NCM04zYkVZcFRxOHhUQ3NPTkg2c2RjU080K0Q1?=
 =?utf-8?B?MUZWSzdwc01NZ0lTdzVXVUlJbFlWanBrbmlQR3BHVWMyZXdxQmJ0dVB6cDVB?=
 =?utf-8?B?SFNPQTlsMTJXUXRDRUNDN2ZQbTh0d3RULzFXbGkrT0xGbmJyTmxRTWYzOHYx?=
 =?utf-8?B?Vm8vbGltL1krbURlZ2lKQThHd21HMzR2YTdvRGxEV1NPSndJT2cyNTBiTndi?=
 =?utf-8?B?SkhtTGJQb1N2TXprVWQ4Y1E2UFJlVVpUUTQwMVZRZkoraE8rYldERlQxVnA5?=
 =?utf-8?B?YXBoT2JZWFVyZ3Z6ZkVkSU1QMjloTEZUYll0cTBaL010enRJM0I0YWc5dk56?=
 =?utf-8?B?bWs3dHZFOUNGQ1NsL29zRGhHTnI5bDdIVEdKYWNuRjBuU0R4MDRjRms4SG5s?=
 =?utf-8?B?Mmd5K3hwbnNVK2NZYlRuRmI4Y1hxTlgzbFNaaTBZSEl0d0dYTFJrN250b1JY?=
 =?utf-8?B?NXQ0KzRkZWNoWFBkMWRIdGNac1pSZndDSUVJeVUwdXY2c2JNKzF0M3JUbm9x?=
 =?utf-8?B?b1VSYzF2OWVWUWhuY3M1ZVRWVUlUdkcraGhoN3BKMUlyTDhFdkhvc09kWFhC?=
 =?utf-8?B?T3gzQXdybERtZWsyMUx5czQzb1J6M1pQUWFMdzA4Tk15RWxqb0RUaENLUHA4?=
 =?utf-8?B?RDlla3pSVDlYVDlEZzlRSlJOL29QdmdNT09raTRKUG5oa0xuYXhYT255V0Na?=
 =?utf-8?B?V3dNZjhuakJRRUFReFRqV3dCSVNVTTJnZGZHMmo3Mm5DZXgzQkR5WVVoY29H?=
 =?utf-8?B?S29qYlQ2RktXNmwwZExkdXkxbHpDS25ZTWlyQmllcHJ2RGxVK0pjU1J3MlhP?=
 =?utf-8?B?OWVZRkRPd01VVG1YUVlkK0s4SzhtVGd4VU8vUzZFYnhvZ2FFdVR6Qk5jNmQr?=
 =?utf-8?B?aCtMZ08xeTdrdlBXdktPL1M0MENYdXlNSktla3gyV29xM3lyZVU2T2cvN0hD?=
 =?utf-8?B?Mys2ZUVDRVlDT2tyeENmczkxbWJJZ2tIdnJUbTlNbjhlbFhOYjJnQTdhc3dJ?=
 =?utf-8?B?N21QZ2kzS1RZNnMzQmhESEJueTNXVVRnMGlkNGJvaHU5Qjh5elBXV2Jpd2pY?=
 =?utf-8?B?RHZkYnJmb3JLVFg5QVJnNmI0aVhnN245N0wzNFRyaW94aUhBSituME55elBG?=
 =?utf-8?B?b3Yrc2VRSU9WdUdxajg4N1lQNGF1WUdoSTRjR3FTL3llQjMvVko5NVZualJ3?=
 =?utf-8?B?cXZSMEJSSHMzOGhnYlZiVGJucG83RE5VTy9iSXFQVmVXZVpFODZUdmNzcGgw?=
 =?utf-8?B?REhFc215eFRUWU9zZUFLZk5oOXpya3hoVmNxM2tzM3ViUVhmV2I1cWtuQjUz?=
 =?utf-8?B?cWxibGtSM3NtSmxSK2lHbHZXSVFBdVRMczYxVmw5RlZVL0NlZUJZajluZ09u?=
 =?utf-8?B?ZnN1S2FFbjdEczkrM0ZJWnVjUzA0T2l3RjROYTdZVVNNZnp4bm5Fa3E0YWRZ?=
 =?utf-8?B?MXFiZ2VzUGhwY0dnWDhXcHFqNGNycnM2WmJrTk5xcGVSMkZWakN3dU9zMVJD?=
 =?utf-8?B?RnNFbXErTEhjTXF3RVArUmtyZnQ4dGh4WGFYVHo1SXM5bmQvdW8ydGFPVWsz?=
 =?utf-8?B?U1NLcSszM3laM1N1dThMUlhucEtiSHJGQ3ROeGJVOGU3aU9ZUG8yRlV6dDY0?=
 =?utf-8?B?amp4WWRVU1ZkanBLQURDRElGR2Y2d0RTVFRSYVNKbjFLRDBFYitkc3YzcEFQ?=
 =?utf-8?B?TjB5c24vQ2t1Rm01K1NiTTNnY1ZmMWhzamFHOXB6N293UXFGSVpuSnlLcjBq?=
 =?utf-8?B?aTRDNGpIaVhkRnVEOVB5NGk3L0MvUUREdW51djl1UzRUaXBnZk9PaFhBZ2JO?=
 =?utf-8?B?NDJDa2laa3pqVWtXTG9DbldadHlRbGNrZW9ZSWc2QnhyVDhZZVZYT1REcXJM?=
 =?utf-8?B?VTltNTI2dVg4dkdHMmxrajQyWjBwN0hYd05qS0dFMzlOd202R3J6RndkTE5D?=
 =?utf-8?B?ZDJ6RlNORml0S1I1RnAyaFhTUGlPbStZeEMxR284Tm5kblg1RkVpejlTZG1U?=
 =?utf-8?B?WG9Ib1l5VG93WXVmR0MrejFGWHdreThsNUxWYlAxNTRDcE5wTkEwNmxHTUd1?=
 =?utf-8?B?eGFpMElrSGpTcFpDQktYZHRtN2RxNmlGQjBQZEM0ZEVrUjlxcVYwL1hhMlcw?=
 =?utf-8?Q?4ShLhLqfEmFxkZTu2oLD+Bwqz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a70b46-4538-4c46-9a8e-08dc6a934ff7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 10:33:31.5771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IwiRyIx6G23VFGofMc0kKsXoh+ZRABRfksKGSziRl8qlJvnmmUHByn1emFSRSn0OhwjX0fWrFSDYAeVwmpCwQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6942

On 4/25/2024 16:42, Thomas Gleixner wrote:
> Lyude!
> 
> On Thu, Apr 25 2024 at 11:56, Lyude Paul wrote:
>> On Thu, 2024-04-25 at 04:11 +0200, Thomas Gleixner wrote:
>>>
>>> Can you please boot a kernel with the commit in question reverted and
>>> add 'possible_cpus=8' to the kernel command line?
>>>
>>> In theory this should fail too.
>>
>> Yep - tried booting a kernel with f0551af0213 reverted and
>> possible_cpus=8, it definitely looks like that crashes things as well
>> in the same way.
> 
> Good. That means it's a problem which existed before but went unnoticed.
> 
>> Also - it scrolled off the screen before I had a chance to write it
>> down, but I'm -fairly- sure I saw some sort of complaint about "16 [or
>> some double digit number] processors exceeds max number of 8". Which
>> is quite interesting, as this is definitely just a quad core ryzen
>> processor with hyperthreading - so there should only be 8 threads.
> 
> Right, that's what we saw with the debug patch. The ACPI/MADT table
> is clearly bonkers. The effect of it is that it pretends that the system
> has 16 possible CPUs:
> 
>      [    0.089381] CPU topo: Allowing 8 present CPUs plus 8 hotplug CPUs
> 
> Which in turn changes the sizing of the per CPU data and affects some
> other details which depend on the number of possible CPUs.

At least this aspect of this I suspect is caused by commit 
fed8d8773b8ea68ad99d9eee8c8343bef9da2c2c.

If you try reverting that I expect the "hotplug CPUs" disappear.

> 
> But that should not matter at all because the system scaling should be
> sufficient with 8 CPUs, but it does not for some completely non-obvious
> reasons.
> 
> Can you please try to increase possible_cpus=N on the command line one
> by one and check when it actually starts to "work" again.
> 
> One other thing to try is to boot with 'possible_cpus=8' and
> 'intremap=off' and see whether that makes a difference.
> 
> I really have no idea where to look and not having the early boot
> messages in case of the fail is not helpful as I can't add meaningful
> debug to it.
> 
> I just checked: the motherboard has a serial port, so it would be
> extremly helpful to hook up a serial cable to this thing and enable
> serial console on the kernel command line. That way we might eventually
> see information which is emitted before it fails to validate the timer
> interrupt.
> 
> Thanks,
> 
>          tglx
> 


