Return-Path: <linux-kernel+bounces-123148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBDD8902FE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3491F294B3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB4F12BEA5;
	Thu, 28 Mar 2024 15:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0UY7/iBw"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACB883A1C;
	Thu, 28 Mar 2024 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711639430; cv=fail; b=DTCThtIBv4/+dTFEWWnP38WNVYuY1U/W8Jex3SJSQNhzJLVWWgLdQtpvu8TQvKgMazNgCCyWIHXkHdSSAWeWjejbizu+tDtWHpjRXOe3d4vKoE6nAzbprHN2+dsgKIT2EJBWO/Z1gs4BHdQrmzVDukWPclyh6Ls63Lk8QA3nqdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711639430; c=relaxed/simple;
	bh=eg9z9FlPwWIyPLSfNVOgcFRlrrr5PQsu7PXQ7zpQdqA=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m+U76ww3SXsn/1i4aCk3yBHoMvEqEa2zion0TUNdDifbfqUQYgIpeP9H4QMBUnHASJxI61NXS2OqT1ugj06N4Y/0clSWowZJeRwgxNsU6KSbI/CVjMhjuV2Y1+V173n+r7N56w+yGzMv9lg+4e/Q/QxjWVgmpZJMR37xbNS22og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0UY7/iBw; arc=fail smtp.client-ip=40.107.101.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcayof/77NFYdvGlMLNV0Q73wIDd0T9fEBYJesuxQ+dZv+tQCAPwH1NLKmjShJnd8rq5Wz4bvarVeeAUfUwgNb3LdosMkbX5nbiJiqy4vvIZKFahHBunJRLdLIpreiG7SeYCWf4F2c0PhKDqBVVC4xh8MNFJyneBG35+RJyfJPvbiaPs6+i9jhtoZuyQqUMRTELeOSu22vNGlJJS9dWHZsCQ7rCfycMLnMD59uDPnlPVW999FP0Kk4Jydu5jvt+3t4XPwV7xWbF0dMWTTcGSB5fTrM5ePkMUB+ZqRU8LoKRbR2ol2d6QGMEw413qfqt8yqxxqQb48aHx6nMKiIO4SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEfXySuwTdOLIgv3Kn/rdQcMtjZuP4sP3SGzGbfpAro=;
 b=mgfjj2q5JPZSv8NJs7DqGY7yw394S7lYAopC1pw1iDk47dDLH4zoy8NL1fxXhZaLMzZjUiTZRQDzgwy+2yGCDqSlEk3CjfcKP4aFtvqbJvPVuaJoEozhP9c4opk9nIHfEKCqdwoCvdsloQ9g+tgTfTYjYKPqlcSyjGT4XsOi10TgPPpZnxFCgQCkqftU/cKw4ywixrAJOVtWLpcQC3SCAWLNiOY8eZ+J/FmfnxQX4Be2RyuKxTBPm3eSEM9gdxWTl7DWvnlwd1pfFDnhbaabkS5YRE+HNZ2V0dYVYLaEIWwY+y41mPcjaBPM07n78wSHBfK4TufxdtPBkNInWyiX4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEfXySuwTdOLIgv3Kn/rdQcMtjZuP4sP3SGzGbfpAro=;
 b=0UY7/iBw/9DdRKmK7a99vTvhIXYGuW8trZlE/GLwgsR82uoyyZXB6DHcg4tUxxt1ovNNQVl+rUOhSLp1cOlk54eCOc8355Ba1t1t3tjYn+4lwD0fChQ0cbz2NG3tJnNMcqftNQqkAYqQF6ddtKfEBua7l6HG2HLzJ4NyKjs5w/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3109.namprd12.prod.outlook.com (2603:10b6:a03:db::17)
 by DM6PR12MB4076.namprd12.prod.outlook.com (2603:10b6:5:213::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 15:23:46 +0000
Received: from BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::b2b4:a3f1:a86:d6bd]) by BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::b2b4:a3f1:a86:d6bd%5]) with mapi id 15.20.7409.028; Thu, 28 Mar 2024
 15:23:46 +0000
Message-ID: <71d41ec9-17ed-442f-8d68-a6cb9bcbb4b0@amd.com>
Date: Thu, 28 Mar 2024 11:23:38 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, david@redhat.com, Vilas.Sridharan@amd.com,
 leo.duran@amd.com, rientjes@google.com, jiaqiyan@google.com,
 tony.luck@intel.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
 rafael@kernel.org, lenb@kernel.org, naoya.horiguchi@nec.com,
 james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
 erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
 mike.malvestuto@intel.com, gthelen@google.com,
 wschwartz@amperecomputing.com, dferguson@amperecomputing.com,
 tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
 kangkang.shen@futurewei.com, wanghuiqiang@huawei.com, linuxarm@huawei.com
Subject: Re: [RFC PATCH v7 12/12] memory: RAS2: Add memory RAS2 driver
To: shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-mm@kvack.org, dan.j.williams@intel.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com
References: <20240223143723.1574-1-shiju.jose@huawei.com>
 <20240223143723.1574-13-shiju.jose@huawei.com>
Content-Language: en-US
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240223143723.1574-13-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:408:e6::21) To BYAPR12MB3109.namprd12.prod.outlook.com
 (2603:10b6:a03:db::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3109:EE_|DM6PR12MB4076:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d0a7ba7-9954-4727-c834-08dc4f3b0ec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+UoNphMplPg2CG01laOq2FKVqNqjMD5g9dOL4zPgDTVz9jDNvb+5w1dmRcP03XYAf3TfNNh/w2HpYyGxI4aKPr3IJEqyD8l7HJRbP0DwZauUOoODHYpWbJQZTt/TXxI7Lr8Pw1AWGcpqIInhd155FAseN0+VI2OGXJXCiZlSdwE7EeNMlWZOPXUz2W9NxxCMQ2PiCo1/qqqUzJkfXZ6KOyS7bNivmVhoUkPO0RIFFzrmUxDOEv2k/6X3XERJa7ivj+TKU2n+schQae0EZcDiQfxsprAlXLx13uexx4VH+AMQnWdVIFHidt9AefXfOQVtwnd64UWnA2Beh7wSnQ/Hwdy3TkYQW39oPOz8+rSLl3/4HkYPjpm7Hd2leFldVwO+Xm7oSpWkYUKhdRnrhUe6DXyNxo/2i5S0aqyLLoUP9SEsJefGnAfRU+XD+v35TWaA7jCw8WCcg29Bqu56ioEEmjQSl1MTNxN1M3YSiX8woxOQd8VIO9tzQs/ZZEg7Xyij1D1zjSWQbdvexOHxhqrXxkrNS/2LT0F6Ounf1iEoxb+KWWZZi2aYK1//F21ny2030CM08QDdScy20Fghk2EYB7g+Nop/WgUWqXNqUq8uDC1uAyB/4rGI8UVVPEtvcZhGtOVhVdjKQ1QYpoj1Ypn5klEW0l9cjyN2doBkKX5gRAiiK64XPZoEHPMc95nrCvdkbRD3Cko9kYS+MAIdQOZ4jw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUt2S2l1ak9FZUpPVlUxOHVBOEwxMktlK211SC9yUmZjREY5RkplTXhNS0Nx?=
 =?utf-8?B?M1VUVW5BZEJnS0hEbXpRdzFyK3lsNkgvemptWTRpVyt4RDFIb09Gdk5CbmRl?=
 =?utf-8?B?eCtSbnduSFVHVzJ4ZXc5aW1sV0ozbmZaK3pSV1Y1RDFPbEE3N1lXY2R0QllZ?=
 =?utf-8?B?ODZOaHdYQ1lJUFl4QnByR0tqK1JWa2ZyUVNSWXRwS1Ayb3F2dGZGRTVFREhI?=
 =?utf-8?B?RnRqWS8xcmZBcVBNdFF5ZXVQd2xib01PdXhiSjlEL0tPWWNINHdFeHFCNEpK?=
 =?utf-8?B?SmduKy9DNFhHYXRpSzVhWGhtK3FicG1Qa1I0ODA5ZGRlT2E5UEFsaUQ2L093?=
 =?utf-8?B?MGJRMHlpOEJKUndEWGNkOXBQOFJOb0x1L3JEOTNtMlB6b1NyczBBd1J4TEZy?=
 =?utf-8?B?VXhzTTNGdVNpRDRodGVRZ0RSS25ZejdQTDltSHpISERYV3RYa2VsMis1RjV4?=
 =?utf-8?B?Y3RzQklIS09LeS9NdTlSdkRYQWtwckRZUzNDUnJOWFJnMENxMWxvZS82YkR3?=
 =?utf-8?B?OFRVZE01ZXB4Ni9JcXdxVENYZXJ4NUI0cjlzSUVjMG1DYVlFMnpIbWNJWDcx?=
 =?utf-8?B?Y3h6aDBxMWZpNE1hTzNtQ1huVzVEUEZsOEd6U1lJbVZuMEs2NFBUU3o4NmZW?=
 =?utf-8?B?Qk13ekJwb1BUL1VlNkxnb25rV2lvRWprRHdjdTJ4VE16eWVXUk1Va3p2SkZv?=
 =?utf-8?B?MFBpc1dybk9GaE41N2p2TlA0NEZzcVovTzB1S29OTlRJQXF0RXpSU282WFZ4?=
 =?utf-8?B?dTFWdXBqN1FRWStmOU43V2JuNXp2bkJnMk42dlFzUE41bUFLWmRXNUdUWmM4?=
 =?utf-8?B?SUZSWXZMbGM2a1pVd214bnNIdklOUFUxNDhQcDhHak1wUVhyelFvbkI0eENK?=
 =?utf-8?B?eVJCMXhXRlNrZk1NUDNFb1BVWXQ2NUVvdElNaFpQa1ZoT3llOTFYSzIraGlW?=
 =?utf-8?B?UjNyV2pjdzZlWlZPMzJZQjMzM1NBT3ZLcVp3Nzl0ajZFUDM2eS80NnBmdCtQ?=
 =?utf-8?B?RTNyYk96MHh6RDJFU0htVkJsTkRCV3ArZnpkTm9xWm93d1p1SWh5MmlYN1Bu?=
 =?utf-8?B?Si9HN1k3WlNwT3hibDk1cFMzdTBJbG9xamtQQVNDRUlDaW5TYmxxcjgybjR5?=
 =?utf-8?B?byt4Y1dCRjE4cy9qSXRpRjJHZFFsazBLc2xURnl6L1pKUVIwL2Izd3ZRNENn?=
 =?utf-8?B?L245eWNiaUdlQVMyNmVYRHBETlZWM3NWQ1RFWWM5bHJuNUV2UW9FV3U5eWxN?=
 =?utf-8?B?U29HaVYxdU5JRkNqU3NYaTBoSTJqeU5kQUNWSkN2Q1lMVlcxK0E3cVRnN3ZV?=
 =?utf-8?B?NTZZYld0ek1XalZVaXY3NmRSKzJ2MU5MeEFNUWdSQXAzeVNESGkyV0E1RUtI?=
 =?utf-8?B?M0dIRElycFhpdkxJWDRocUswTEpqTmd4TUZSeEU0NWgrWFlMMGU0c3RpRENF?=
 =?utf-8?B?b3BROVdyQmIreXZHcnUvVENVckowWTZmZGJXZmpPeklma2ZEUVJlMkViNjFs?=
 =?utf-8?B?WFAvM2NaZFlHYWEzQkNLNjNyUDRKdzJDUFJ4Y3BXR25CcEVEdzQzUVBMWTFv?=
 =?utf-8?B?Si9tb0RuNE9oMGxocERzY3JCaVVYQmlNN1VpT1BYaW5xK1AvODhKMVNYYWtn?=
 =?utf-8?B?K3NzMVloWjIxZFFEbXN4MzdkRXVYZDVCbWRzS015RzdDcUppR3NmckhZdkxN?=
 =?utf-8?B?OThEK0ZzZnRvL25aWWJFaDFzSTh0SGwvSDZhbEYxUEo0UEFlWThOTXovQkcv?=
 =?utf-8?B?ZWdKQ1ZrUSsrNEU0MHVlVjU0UDdqMHAxZjQxZmRzeStwUCtwWk9PNWY5eHVN?=
 =?utf-8?B?Um1McEc5aFlMTSt0LzFyU1JCQ1UrUVRING82dGV2em5pRXc2ZU5KS2pXWCtv?=
 =?utf-8?B?cmg4clJnOGZmZGxLVklzMmF3dmxPOHU4ZytWNGErRS84K21IQjRWTEd2Zklx?=
 =?utf-8?B?SUFFTW1lSDZuQSs1bU5QN0c5MEM2RkhIdzJEbkh2TkRMMXVWK3I1ckZYdTBu?=
 =?utf-8?B?N3BxcHYwYVdjbVU5ejBjdXZTVENiaURjYnB2TDkwVjF3UUJMOVdZNWxZWlJD?=
 =?utf-8?B?YVpyRE5hUUVyT3ZJVHpTTFljS3l3N3FZV1p2QkNFWDZIelExQkhocGxKekIr?=
 =?utf-8?Q?EplYsj+hSJ9LsOWkTEAOS6sh8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0a7ba7-9954-4727-c834-08dc4f3b0ec8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 15:23:45.9083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eTRTkkTcfKInFLKtq0xfZtBR5mMN8bLub66IgWwurrYzdgPelaFY78Hd8cQXmQ7yA7V0S3GYxmTL6AhG3U+rSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4076

On 2/23/2024 9:37 AM, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Memory RAS2 driver binds to the platform device add by the ACPI RAS2
> driver.
> Driver registers the PCC channel for communicating with the ACPI compliant
> platform that contains RAS2 command support in the hardware.
> 
> Add interface functions to support configuring the parameters of HW patrol
> scrubs in the system, which exposed to the kernel via the RAS2 and PCC,
> using the RAS2 commands.
> 
> Add support for RAS2 platform devices to register with scrub subsystem
> driver. This enables user to configure the parameters of HW patrol scrubs,
> which exposed to the kernel via the RAS2 table, through the scrub sysfs
> attributes.
> 
> Open Question:
> Sysfs scrub control attribute "enable_background_scrub" is added for RAS2,
> based on the feedback from Bill Schwartz <wschwartz@amperecomputing.com
> on v4 to enable/disable the background_scrubbing in the platform as defined in the
> “Configure Scrub Parameters [INPUT]“ field  in RAS2 Table 5.87: Parameter Block
> Structure for PATROL_SCRUB.
> Is it a right approach to support "enable_background_scrub" in the sysfs
> scrub control?
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/memory/Kconfig       |  14 ++
>  drivers/memory/Makefile      |   2 +
>  drivers/memory/ras2.c        | 364 +++++++++++++++++++++++++++++++++++
>  drivers/memory/ras2_common.c | 282 +++++++++++++++++++++++++++
>  include/memory/ras2.h        |  88 +++++++++
>  5 files changed, 750 insertions(+)
>  create mode 100644 drivers/memory/ras2.c
>  create mode 100644 drivers/memory/ras2_common.c
>  create mode 100755 include/memory/ras2.h
> 

Sorry if this was already covered, but why not put the common scrub and ras2
changes under /drivers/ras/?

Thanks,
Yazen

