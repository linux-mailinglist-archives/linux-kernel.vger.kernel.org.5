Return-Path: <linux-kernel+bounces-159428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D9A8B2E7B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A2611C222B7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 01:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24BD17EF;
	Fri, 26 Apr 2024 01:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F9wveOoF"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2064.outbound.protection.outlook.com [40.107.212.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8C6812
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 01:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714096561; cv=fail; b=WMUgrqkz6gi4HVHPsFjx4wPZ/9p0eXwkh+9p1vqgOubYzu0aCE7hm5aHjTOqsRzfEd2aCr+dFzvW7o3OvqJvIAkans7hpko7pis09aSieGxeDK8l6XHco16HZfccgvMA1RPZpqxv9jZxQQZaCHsKkftXRs5CboZJ/nz80NKIN2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714096561; c=relaxed/simple;
	bh=wQ7SiuBhIG1PMCCQORf3a2qXjDi/PsOmB1og7E537eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mTV0CTJqPOrPJSCuBfvPUqXgTzr6gAbT1MrYPZAyoQhvI/Y0e6TSprXUm+kGPwuvTtyAp0DxUAv9MbS0l/idB7mvWZzMIAqfbp94jLqBlzlu/7AlT+vhvthjwIpJVw4sibpm61CJELmtj8mFbmNAMd1Gp15muT8BA1/cRtX3EZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F9wveOoF; arc=fail smtp.client-ip=40.107.212.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c84Ssbd4dVYpQUyv7HVwoPh3caSMZFpfycWeulEaSYKdT2rRqATqoiGnDTBqnL8mBJkfj/w9INq2Lxoha4slCuey5UdChBVIEs/0s6zZBod9tlLZhB2aw4cB5YDd6FrxZxpi7BTwRWRv1qnGfvLdBxwpYCN5ef7eB0MT5DnrsnLrkyyiTZRffLQwdjyZS2Ek/RhcEgACKDYwzHmfCzclyYMJlCxlhXQkgdzcjdxZGVXL49TFoXJwN6fDjO27pc7C030PF6rUDd0AeRWwPuKga6KGNhuS8KeeLqklZVizqKC/t3Zupm3ZNSUsRbjpuUxPi6ui2bDZZ1CxrsRHVXcmsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Vu9cmUIJWS7bftCA0L6/+xe6dpq9Dc82pGuc8T56XI=;
 b=JpogxaQT9Z69amrmHfiOn63CyWl+tXg736rr7IUb93pnwLWbwOOx77vjwrwyxHwIofLqovtGV7RXgAO2Gq267DSnuek0TtmAum0EWJY1tP6U6fHpJQgT/FHBk1BDPgcP6h4MNpxNZW1jYCFj9h8f56uPt0u+XHwAQdlC4rKIkf5RPJOlUrW/Uk5VeSl4fnjXu2VZAR4co+T5PVy/b73iIe4ogEAMG1AFUNf3x6CSy5vBsWcal3Ajj6miEkF+W/F+BrWJ4nzYwFEiuOk2GqXnhqd9Hovy43/VLdkLgxBhYJUEurS1xZz6GCq1+i7IZE6VNo/SDG35drZ3jHP2o5JVsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Vu9cmUIJWS7bftCA0L6/+xe6dpq9Dc82pGuc8T56XI=;
 b=F9wveOoFDzccUH+2VC5A6ZUWs80U8qUtnBxD2LnnOVcid8x50TvLSg7V7lY7u8K/DRyIDJsYSKipzMPLBqdVNy4ysuvljYuKCrXtBwACDqqOYoEnlgd+BOVuPtLXzPmHmBPmnxXh1zCuZTrTXLJ9s7VP35UcQ7fzUuTd0TXSv5jqfFFPox3NZoSRmpHuFJrZ2zs5+xtd6rXBP5p/P5NZGTQXNM58yDd/fXsJ5ihTFo64pUad1qVcIitLSZrluZGy98GIQJLaF2K29UOV0o9ZHhpcn9a3uFTBsl2xTbPmhKJoKfwqBoUjQlUx/QVnr+rHiff39sBdrnFVzSEncH6pmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 IA1PR12MB6236.namprd12.prod.outlook.com (2603:10b6:208:3e4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 01:55:56 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 01:55:56 +0000
From: Zi Yan <ziy@nvidia.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>,
 David Hildenbrand <david@redhat.com>, Lance Yang <ioworker0@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm/rmap: do not add fully unmapped large folio to
 deferred split list
Date: Thu, 25 Apr 2024 21:55:53 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <6C31DF81-94FB-4D09-A3B8-0CED2AD8EDDB@nvidia.com>
In-Reply-To: <CAGsJ_4wa0LskQkoZf9r5bG5+wEkyfCYveMBSTbuDe0=t1QetTg@mail.gmail.com>
References: <20240425211136.486184-1-zi.yan@sent.com>
 <CAGsJ_4wa0LskQkoZf9r5bG5+wEkyfCYveMBSTbuDe0=t1QetTg@mail.gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_5B2280AB-7499-4B5A-95DA-0149144A2252_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR06CA0007.namprd06.prod.outlook.com
 (2603:10b6:208:23d::12) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|IA1PR12MB6236:EE_
X-MS-Office365-Filtering-Correlation-Id: a8c5db43-c686-4fe8-b59d-08dc6594033e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWtIQlFqSU4rNXI3bGtEdWt2anM0RFhuNnAwV3FuMG03ZW1nTXljTHRNVlA5?=
 =?utf-8?B?ajFkRUpWUUgrd0Q2dE45S2dTRkFuYmc1SFFZcDNWSUFzaUpyeU9kbnZIRDc3?=
 =?utf-8?B?MEx3Z2xhdkxscWpkYTYyNXd4aHJkKzUvMkN3Yk15akVSbWN1RUV6QXFBR0tl?=
 =?utf-8?B?b1dUdDg4Ri9VdUtNM2hvYTZnYjNIL2lGbElDWE1wcXYrUzNIOFhjekg3OE5E?=
 =?utf-8?B?SXhSaDl5eGFjdDJ6VVhoWU90aEJMcW5KZUFWdFJFRkhiZEJsU2pLTjJRSnd5?=
 =?utf-8?B?UUkyRnoyNVkyOGtReE9PMUZ3T3JjUHBKR3Vrc0NaVWxxb3Z0YzhLSTZPT3dM?=
 =?utf-8?B?YXVYbzJtbWM0Uk00VTdUZmFYQnBOaVhiM1hjWU0yUmRzV29lWERTVGdBZ0Fz?=
 =?utf-8?B?TlBSSkVlUmhwMzdSRnAyanoxY0dHU0lMN3VOYVJOZlY0Q0JxZWtLSzgrRWlY?=
 =?utf-8?B?WitHK1FxcVEwL0ZvN2N1U0t2ZkFMQ3Y2VExiRnVvR2dZNlVPYTYrS1A3Uktn?=
 =?utf-8?B?QTFwblJlL0RzWmJSS3JRenArTjRTRkpVVFcxYUd4SW5rVmJqZWdHVk5MM1g3?=
 =?utf-8?B?Y2IxeHdXeldvUmhjbGlraHlWdkprbU5aUDIzYlJENGpHREhiTUgwMTlpYWtp?=
 =?utf-8?B?STh5ODd3MU9QWkxJZTdYVVROMThIck1UVksyTG9KSnNkWU9pRGlOOVFZZ1hT?=
 =?utf-8?B?OStWdGN1WGxCNGJUZEE0MnFkaW40MjJ6dmdWem5rY0o4bWxPMGZKcTFXa25X?=
 =?utf-8?B?Q0E5dklScjdzSWEramQ1ZGVLc1lhdTdwTGFxb3RKRWJlQlBTeU40RXJpUnZu?=
 =?utf-8?B?VzFHZkMxczNsRGFOVUNtVjQxWUhyRGQrZDZ4bldYOWZRVWFnL21QQTlGaHE3?=
 =?utf-8?B?b1dNR3RCcVA3MnZmVWZFSzZEeTJ3eGM5cW9PWkZjZHBBcWNxNnk4dWpNVnBP?=
 =?utf-8?B?QVFvdGxMZUVFTjlBZXozdVI3bHRTZXRKdENLenBoQzFKdkVtTmE3TnFYc3ZX?=
 =?utf-8?B?MWw5Zk50NWVQcHpqNWFBVHEzNVl2aUpiYlZHOXBRMmo5RytpbUpIRzY5OWcx?=
 =?utf-8?B?d0lPenRmdHRyRmJLTStUYXprNGFJVWRqRldOaDBRdkpxSzNBZ3RpTW5kbUJJ?=
 =?utf-8?B?UFVnYjdkVnFTczc5N2ZBN2NyUmtpdXJqL29CWkcra1o0QkZpbzJucFUwZmJJ?=
 =?utf-8?B?V0dONkpmQ09iOVdwc1NoRC9uSCt0SjVnaEYxMm1RdFlpd0VLS1Ava2tIeHYz?=
 =?utf-8?B?cmZhRHcrTGx1Zm9SNDliRWlHdmtJNW5yRXpVTjE0NENFT2twa1VwcEZZOUlG?=
 =?utf-8?B?T2d3TWtmREZYZlBlMmJjRG1nYVFMUGhnQWl0TlJBb20yN0tLak9kazZWWVd5?=
 =?utf-8?B?Y29BdnJCRm5hMFFiV04yV2RMeFZpRDdibkpCeERpMnR4VmVzMVY2K0VaUnov?=
 =?utf-8?B?ZXB1bmcrUHZmZ2h1ZWRJa3B2c1M4S0xKZXJST09vbFJrSGtvN1ZJellnQTl6?=
 =?utf-8?B?RTZYTlhUSzVldTA4YnFIQ0VqendjdTR5aThRT0d2L0RqaTl3YlE2UHEyanZy?=
 =?utf-8?B?S2h6L3l3bTJMRCtnZWcraHhqNGdUOU1oWlZPclg0VmZqL0Y1T3NmQUxZNm5K?=
 =?utf-8?B?aThlRWoxeExmVDVkeTdadjRZMy9mVXQwdmtuR05HQlQwMjJjZ3B1clpNRm83?=
 =?utf-8?B?VTJtaVU2NURQQTR0UGtPcExoWkRSSitpbmNSejdlcWFkTWJ4RHVLZDZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHpuRmlkT2dzbjE1R3JJQU5KTGdzMm43SktwUEltNTI0aUZNdzRPVkVaWlQr?=
 =?utf-8?B?Njh1N296by84RjFTUVpka1dqWThDeVJxVXN1WE5VYXlxVFF3OUJjNk90eEt5?=
 =?utf-8?B?YmVMTDFFWVZkdWxFL3l0WTAzcGFQcTlIaEs4aDNnSVNNUmxsMHpRcVpFUWZm?=
 =?utf-8?B?QUU2czEyTnZBVFU1N0ZuYTJDTXNsZVF6USsyVTc2aklVeDNWaDUwM1VWR0dD?=
 =?utf-8?B?YUNwcFpyNTh5RHZKRGxyVUxtbVpaK2NnUWdpUnVhTDR4RXFKRWV4YUNkZHlj?=
 =?utf-8?B?RmMyb2FtSTZvOGhQbHY2SGU5V2k0cFg4bWtJZVQ4bnRJM1FXalFwUkpHQWU2?=
 =?utf-8?B?bGpRTGI2aDMxY0ZmcWVaVCs4YXZsRlVzbnRiQTNvN25xaVA4a1A0N0xnTnpG?=
 =?utf-8?B?d1ZTbWlraFE1NURWeXVOdmNEYXUyRW9kdDJrcUkzQlFNSEUzajNoZmFZTHVH?=
 =?utf-8?B?RG0vQ2ZIQ0VBcmo2RGY4NldiZlF5YnhhSUhCR283dUROVHFpQlc0K0loeVpy?=
 =?utf-8?B?VFBjUkVicitQVmc3MG1NNStjZ2l1RU1JYldHZmQ2RkkzMnFuWXd1RWpHYms4?=
 =?utf-8?B?VFFTeDZMR2V6eUtadWR5YkxOZ2ZUbDcvVGYrd2tUeENTZVVkbitqUXFRTUdy?=
 =?utf-8?B?OTQzTG84Y1ZVZ1VSeXhlQXIrenZ5b2hxSktJNTRrcjJKdHNseUhIK1RGclJX?=
 =?utf-8?B?cVZCZ0orREI3QzVOSldvalBETUhFbTFQMGF6K1FiWGN5eTlpS3dOREtBMWtj?=
 =?utf-8?B?Tkg0U2xBN2VmZHIxRzU3dk1mOEYxb3NQc3RkU3F4alJyZ3RGS3BVaFlwS2pa?=
 =?utf-8?B?ODRqQUJVMW9SODhBanFPRi8wTGNrRVVReElWN0dtN1ZrbVNBNXd4QnpvYmdt?=
 =?utf-8?B?UnMxNHg4Z1pOc3ZtRlh6b2tTVjA1aUpFQW1xSlA2OU1xd3NjWjN4Mk9aamVj?=
 =?utf-8?B?V2ZPTkR4M1ZQemU2NUF5MllrdnF1M3E3K2Q1T044QnVLV2lwUGZ6OWJXelRL?=
 =?utf-8?B?YlRJeFJISW9FYmI3cmlYS3VIMGw0eUpIaG9xZkV5Z21GSjQ3dHdLVDNhN1Nr?=
 =?utf-8?B?cklHVlBZam5WaDZobVlvMVNnUnhDK3c2Q2RtZ2VWdU16SUR4RnVCa1c4U2pi?=
 =?utf-8?B?WENjT0FJRUlQa2w0d0RJWFp2QUFPY0R0R1o3eUI3dk5XSTZoMlFKTzRFdk9s?=
 =?utf-8?B?clRPeVd6TlY4NFNnc3l0MWtUMnNxRXo2cVltcDUwazZkcGEvQmg2UmJxbGs3?=
 =?utf-8?B?ejF0L2lISHNZdzV6M3ZDK2lwQmhXdjY0SjhMcitQRzJSTytJTEtLNEUyUjB3?=
 =?utf-8?B?MlFJU1VZQjdEMVNLWlJlUWp4bCtkWVdpTGo5amt3dzJzbDFHUWZIRjZUZ0E4?=
 =?utf-8?B?MDN5d3lUSG0wZHFuNE5FQjU3ZGFBMFliSWNXZXJpSDE4dWdIRkxqbk1tUFk4?=
 =?utf-8?B?WFJ1N1o4Tk1xOGwyUE9wODBMQnE5Mld2QUxjSSsvQ3hCTlhxTE5BN2R4Q3Jn?=
 =?utf-8?B?VWhlcnNhanNiMVNreVQxbnlndzQyZmwvcGFmcTdUQWJqb2Rxck1DZDlTY0NP?=
 =?utf-8?B?Tk1UektYSHVTVDhrYnRXTnRJeFBQT3RiR1R1eGlWQ1RUWkJXRVJNWnZLMytH?=
 =?utf-8?B?ZjZZL3VwQ1k4R0pVZ3pTUko0R3p3SXZsV0ZnV0VXL1oyWkFPaG5hVkxrc2RV?=
 =?utf-8?B?dlNEN1dnbTYwT3kzTk4valMyRjUyUUFwT2doSHlFLzJROTI0RzdvVFIyRGtI?=
 =?utf-8?B?MXNZTktFeG5GbFRGT3A0c1h5ZzNWRmRSNFhrOTg2QnY4SnZvMGFXSGdMd2Mx?=
 =?utf-8?B?OGFod0xJcHJYZ05qSnpQY3dCZ3Exd3NKZXl6WFBwYkkzeW02SGY1QWJIVkpC?=
 =?utf-8?B?YmdpaEdtd3ZJNkxrdU9wdHZaOUF0aG9LT0lKRnJ0YXRJWGFxWlhNMGZHQWU3?=
 =?utf-8?B?NWJhRUdzYlBNNXBGYzFoUGlqUTVuc2pEVGxYU1N1L1dPK2o2R1k0cWZ2S3Nv?=
 =?utf-8?B?T3BEaENDS1RHR3pNMG1rTEg4djRpSm1XRko5enlDbUphd3FWN0ZTOEV6NWIz?=
 =?utf-8?B?V29CNHFuSWVianpFOFNOU1NHSGZabWRmNFloUWZLWGRrdkdqT1FpOEpPcEZB?=
 =?utf-8?Q?EDak=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c5db43-c686-4fe8-b59d-08dc6594033e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 01:55:56.4767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ryK0p1Kzz2iZYPs3NtWR15ThkNxPIWcPudMy80xQMnOzXXhnJoDn7/t1XE+F6xmj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6236

--=_MailMate_5B2280AB-7499-4B5A-95DA-0149144A2252_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 25 Apr 2024, at 21:45, Barry Song wrote:

> On Fri, Apr 26, 2024 at 5:11=E2=80=AFAM Zi Yan <zi.yan@sent.com> wrote:=

>>
>> From: Zi Yan <ziy@nvidia.com>
>>
>> In __folio_remove_rmap(), a large folio is added to deferred split lis=
t
>> if any page in a folio loses its final mapping. But it is possible tha=
t
>> the folio is fully unmapped and adding it to deferred split list is
>> unnecessary.
>>
>> For PMD-mapped THPs, that was not really an issue, because removing th=
e
>> last PMD mapping in the absence of PTE mappings would not have added t=
he
>> folio to the deferred split queue.
>>
>> However, for PTE-mapped THPs, which are now more prominent due to mTHP=
,
>> they are always added to the deferred split queue. One side effect
>> is that the THP_DEFERRED_SPLIT_PAGE stat for a PTE-mapped folio can be=

>> unintentionally increased, making it look like there are many partiall=
y
>> mapped folios -- although the whole folio is fully unmapped stepwise.
>>
>> Core-mm now tries batch-unmapping consecutive PTEs of PTE-mapped THPs
>> where possible starting from commit b06dc281aa99 ("mm/rmap: introduce
>> folio_remove_rmap_[pte|ptes|pmd]()"). When it happens, a whole PTE-map=
ped
>> folio is unmapped in one go and can avoid being added to deferred spli=
t
>> list, reducing the THP_DEFERRED_SPLIT_PAGE noise. But there will still=
 be
>> noise when we cannot batch-unmap a complete PTE-mapped folio in one go=

>> -- or where this type of batching is not implemented yet, e.g., migrat=
ion.
>>
>> To avoid the unnecessary addition, folio->_nr_pages_mapped is checked
>> to tell if the whole folio is unmapped. If the folio is already on
>> deferred split list, it will be skipped, too.
>>
>> Note: commit 98046944a159 ("mm: huge_memory: add the missing
>> folio_test_pmd_mappable() for THP split statistics") tried to exclude
>> mTHP deferred split stats from THP_DEFERRED_SPLIT_PAGE, but it does no=
t
>> fix the above issue. A fully unmapped PTE-mapped order-9 THP was still=

>> added to deferred split list and counted as THP_DEFERRED_SPLIT_PAGE,
>> since nr is 512 (non zero), level is RMAP_LEVEL_PTE, and inside
>> deferred_split_folio() the order-9 folio is folio_test_pmd_mappable().=

>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> Reviewed-by: Yang Shi <shy828301@gmail.com>
>> ---
>>  mm/rmap.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index a7913a454028..220ad8a83589 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1553,9 +1553,11 @@ static __always_inline void __folio_remove_rmap=
(struct folio *folio,
>>                  * page of the folio is unmapped and at least one page=

>>                  * is still mapped.
>>                  */
>> -               if (folio_test_large(folio) && folio_test_anon(folio))=

>> -                       if (level =3D=3D RMAP_LEVEL_PTE || nr < nr_pmd=
mapped)
>> -                               deferred_split_folio(folio);
>> +               if (folio_test_large(folio) && folio_test_anon(folio) =
&&
>> +                   list_empty(&folio->_deferred_list) &&
>> +                   ((level =3D=3D RMAP_LEVEL_PTE && atomic_read(mappe=
d)) ||
>> +                    (level =3D=3D RMAP_LEVEL_PMD && nr < nr_pmdmapped=
)))
>> +                       deferred_split_folio(folio);
>
> Hi Zi Yan,
> in case a mTHP is mapped by two processed (forked but not CoW yet), if =
we
> unmap the whole folio by pte level in one process only, are we still ad=
ding this
> folio into deferred list?

No. Because the mTHP is still fully mapped by the other process. In terms=
 of code,
nr will be 0 in that case and this if condition is skipped. nr is only in=
creased
from 0 when one of the subpages in the mTHP has no mapping, namely page->=
_mapcount
becomes negative and last is true in the case RMAP_LEVEL_PTE.


--
Best Regards,
Yan, Zi

--=_MailMate_5B2280AB-7499-4B5A-95DA-0149144A2252_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYrCakPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUGDQP/3KsulRt1LZDlngj5Ml/Zs9sN8F2IyJrBhMe
px7IDX9JJ/8M5PrKwzo18xfTjvWLyf+9TLtf0+rFtSH2ewsW1JcigXsul/T+Del5
wXeybrKPvbfQOIf6uMZtgAgsB3abhbGeusqjCUryQVM+HQIwLq1tJ0ukHnLdijAZ
mFgPb4OAi8T5ocuiC0jOPH//5xkAbat9Wb7Wt+ovjNkGlAssmp3BUSFIWPCTWEYO
swZc4GKyWhB2xz6gOCF6qdqmrGPcKA+XEVwCXgMX4zPAZaIK5ERv2KWJ8qaj3ggh
ztap+jayjEbwmIAeOo0yg/v218ue0x5sRbAqHKwD1vujwpuOvdtBRPsowowSTrJm
mMkNtTQP8uULE4HlzB0T4F5RnSck2iK8pUF8VKT0JijP2EQ/QQ8p0uoffNrIdSiF
IuwgfAwFtOz40BzzMQR67EFLkOvKgJ2ykStl/Ix6NTCYHeeAlEKxh+KkfeLlJcRo
RpUz1qC7WgYryu+QknDkIYzgdij7mtXl9SyCSlB3x/MGoJ04COLZx3TeHBIp2F53
1/vHUedx3HpIh8uRleFlX4+198lqZuNNLHCP+KnGvXfqnwKeAOQUqTHs8lZVpZ+S
jK2kf7/hj0tWtLRTHzA1lVrovawmRAVyehq9Qa9102LtYtQWe2OVnXZzTYvlUkHT
V1NtIdfS
=lI1h
-----END PGP SIGNATURE-----

--=_MailMate_5B2280AB-7499-4B5A-95DA-0149144A2252_=--

