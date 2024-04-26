Return-Path: <linux-kernel+bounces-159452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F6F8B2EC9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62577B21BFB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D18B1C3E;
	Fri, 26 Apr 2024 02:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o2zF5wov"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21449EBE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 02:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714099831; cv=fail; b=fklFB2JFc3lK4Pw6/jwWA2SisjadeqS/C6ZPrH3pCrfQzbpaPuWsM2rAjQ0iWnxARZC8c+scILeTiYtU7jdX9e97S0iF1LchqcbFnsON2puflAxmEpkcK2Arw9DSdOkHmg7lPKrdoVG3JnMoEJARp5WkyervHqunXifUIGqaV78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714099831; c=relaxed/simple;
	bh=geCJG19xx+nrBs4ArJibGQV4jCVoFmgI/fk5+dB1/1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H4q/hdt00mgXY6jg9dXbzI/cD14U4W3+fgcYbeUqgD+OMXl/WxEF/ZGrGalxS5bTDlpz+klCO0q5lX4fFWBrRw1ZCSRwHmwsAJpyTx1JQkjsT8eQcUsSeadSmeXMRcuTG3eBCgibcDMbQe7lbJJnRLmkdP+UmqqMDlSd8dfJ09s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o2zF5wov; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fu6KNlGIRIhg+5XzwAzjfaRwustcuq8x/Hh9Sh7YfwJ5h3sXJuieDbJlB/HGpWylHJz2DJQdKZ++Yljp8I5dxcAaIXRLTWl954NbCPfplAJkfOPJepzS4EcJjPwk4jPRQiT3Q4XRk+clpAU+P1LPBUfhS3V8K7QfQ3nsXbm6hEq0PlYT1X9iqSc1iaUVaEUq3M9vVv9+5HD4Nj53gBBoZkjZKZbRCmpWsZ6np7RZYCiiEnPO58IZD0//iRbQg2za+uhyV0BnZhZ5HgBsYSTqvXTih5U2sWgHuwGyNS97mwj2oWS1qhjiiHO76EhpDorI4VOeuqG7RQVTfZcYENXhoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+S7w8OTF3YsE9emHsa+7DBgxFQzzobVqOYIiS7Pckc=;
 b=lqCNUPN0ZhbYuoOO2dAML6bWp9GSCp16/Al2IAFHC02eufHi/xB77exJADkiuY0QZ8QHnkaZFpIeSJcc052INhfHXwQ3wDzOUYGCp5wvS93Qg3DJqXeaY0JsqDQA2bIJWwPWvDhREbBgiFhJJ8MtGla7erAsS21CKFQ6pz3vi34CyVqJe6if8vJkD7Kb1wrvD1sLkN3mOEdZZeaBU3cM5P2NO9YGOhbcIpBVGmshKSyCXkDyjLrsUGxo9/2RZaPd2DNwcciTejnbHEW/thRL6kGPtN4W9H//YAmbQotHhCi4lQ+LVqv6r3CaF4i/kgTwBeZs9vrlSM3abzI05OjGwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+S7w8OTF3YsE9emHsa+7DBgxFQzzobVqOYIiS7Pckc=;
 b=o2zF5wov2prUoQrXGzgE61zTEs8aOlrlmBmqTXBCDCXLrXcr6rwOaPlxqf5p9QJDoS/6fDTw3A1eXdki2qbCskzwtfd7mmC0m3F/1v9M2UwOj1xPD1B906iO6UvbstNtUXo6ZO629fB+7JX4YG7qQDQpp5TBYXMB9V4f+UOgahvXRSzc2AAaTOAZf6fv4csYxL5LTWXkqN7UBFm+4baCpvb67uCTrZKw4dOLFRgGqGvs+bTbXItugURLglDPX1jHWVyNCfNi3Q4sPKbw6rXJ25xufDAf88RMMvfTI4vdeN8ymnVyVMMLBabj7t1PJVAlwVDQxD9F7g03VP8Lmx6ARg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Fri, 26 Apr
 2024 02:50:23 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 02:50:23 +0000
From: Zi Yan <ziy@nvidia.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>,
 David Hildenbrand <david@redhat.com>, Lance Yang <ioworker0@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mm/rmap: do not add fully unmapped large folio to
 deferred split list
Date: Thu, 25 Apr 2024 22:50:20 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <730660D2-E1BA-4A2E-B99C-2F160F9D9A9B@nvidia.com>
In-Reply-To: <CAGsJ_4xzb8RrEuPEbnvR4GbDWuoGCYL4FsC3TObOifAZ4CHGOA@mail.gmail.com>
References: <20240425211136.486184-1-zi.yan@sent.com>
 <CAGsJ_4wa0LskQkoZf9r5bG5+wEkyfCYveMBSTbuDe0=t1QetTg@mail.gmail.com>
 <6C31DF81-94FB-4D09-A3B8-0CED2AD8EDDB@nvidia.com>
 <CAGsJ_4xzb8RrEuPEbnvR4GbDWuoGCYL4FsC3TObOifAZ4CHGOA@mail.gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_AAC7DC85-3691-49B8-8AE2-2FB09CD15A3D_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0141.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::26) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CH3PR12MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: ff74b5a7-b871-44be-a788-08dc659b9e79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjFxWVJuUjdoSS85M1BIOUg4NSs1YzBTcXJBRENTaFMxYUZCZnlhNDNITldo?=
 =?utf-8?B?SnhRMjBINDJBREFIVXZ1UFd6Qy9sMno4RG5hUWpzRUhRcThnaEZCdXB0YUNP?=
 =?utf-8?B?aitXZkZjMTAyY2JPU0EyNjZyZ0J1bXl3QmkyemZmak5BclJKQkFyWHJPNlVT?=
 =?utf-8?B?UW01dUU2R1hiTWlLQmNuWk9EVWlXcGI0TDI2NzFzbFIxSXRXR2ZZS0NBN2pn?=
 =?utf-8?B?QzdqYlV4VzZmUHIrVTluanRpbGpOQ1o1bW45QzZ5N2x3QUVaRXhqK0pWOWNR?=
 =?utf-8?B?bFRZUm10Z3R3NFg2LzQ2RkRnQW14RnVjdGFIc2xPMjVzMWxVcmoyU0dLMzls?=
 =?utf-8?B?NndSR2VoZUdpUkpjNGY1OVlyM0hKSnB5M2ZwMHM0cjNrdnZyazRQV2gyTDl4?=
 =?utf-8?B?VHJoRnhQNTQ0N2I4OC9QQ2hZcmI4STl5MEVHOUMvbTkvR1ZhbWs3RE90VENx?=
 =?utf-8?B?aS9UbmdIMGR0ZndMeXpON1VqWXRPSk9PWlc2SkEzMHRaV000SDNpblNBWWlM?=
 =?utf-8?B?ZDlSOVZZYzB6bktrTVh0TkQ1aWZYMGUzWnN3WDJIWWhZYkZjRnU4OGxiS1Ev?=
 =?utf-8?B?aklyVE1PamExSjBpSXpQRHE2Q2VLM3kyaUZLSXlsZjRvSnhMbmJzamhHRmNT?=
 =?utf-8?B?cFBLVkpIVXhjUWNoUTNiQytBRWZ4TjNDYzdEa3dkTmRvazJHRnY1RkZyLzhR?=
 =?utf-8?B?ZjkzWTJzRW1NbFI5RHd5NUQyNTlQZ0Ftbm9aSUU4OUVZUVVjcTF1KzhRL2hX?=
 =?utf-8?B?TFgvMnFWaURldTVjUithTGtBV3FqdG1MZzZHNC9oQUw0TzJPelZMbDBIVTlp?=
 =?utf-8?B?WkFZdnR5OVY3bCszUHQ5Z0dEUlY5YlBTNkFxOTFqdUJHY0R5OFdOQ2U1Kzl3?=
 =?utf-8?B?c0Qyc2Fmems0Vm4yZmVGYXE4YVIwNzZENnVRUTFqQ2RjRGMwdmRpaFV1dFc0?=
 =?utf-8?B?VU1HTmlmUW5MaTRtZ3VSOUxjTUdURHpTQ3NSRG1IK1hKWlZmK2Jabk9BVjhK?=
 =?utf-8?B?ajZNUWdmT0VCVlNwa2Q3RVRkMHJzSGVjcnA2VXN0QzgzMUdFbFNlczRFZkdS?=
 =?utf-8?B?MndrYS9HN21JV0o0UVZaNkJkL1VRWm90a2t3YXdSTE5CN0llVjg4dnVVQVJT?=
 =?utf-8?B?ekRlMkdLVVAwdEpkcXZLVSt5YlF5Q0ZNZGpsNUdPdWVLeHBOMGVSY3ZTZUFZ?=
 =?utf-8?B?TC9oa1lVYXc1ajZaUE55YVlkbVZaT3JVdXNqODRKRGljVFBMMHgzR0l4QnBS?=
 =?utf-8?B?Q1NxTXdHbFVyalk1L1VrQkxHSm15VTA1QTRWV3lsSnlnZUc5R1lNNDJtcTBS?=
 =?utf-8?B?RG1neUdsVXNyMndzN1JKQ08yYk42NHJPb1FSekJKcjJORXordE02UUE0Ym12?=
 =?utf-8?B?dHFuaXUySnpSUUdpL2ZxOUtyYkplVHFxdlBGQm4xYWpndGJvUFlUaUZWOUxp?=
 =?utf-8?B?K2g2UjRzL01IbDdMNVhEVkkraHo0Y1pqRzIyRy9GSXIwRVBqUCsvckc0L0Nk?=
 =?utf-8?B?VWltWXF2MEEzbUorTkprSXM5YU9aVXNwOHFGV1Y3RnVIOUMrVGxDUW1IYzNy?=
 =?utf-8?B?WXVUdnV5NXYzT2c2Z2Z5eWF6YkkxYjIwaEJwWjIrNDQzbWV0bTd5SUYrdFhs?=
 =?utf-8?B?RzhFNTBHL3NLeUFZOFN5KzZvQjFaZ2E4TWJmVjhxMnVVcy9VMERiV3I4dGE5?=
 =?utf-8?B?MGhqcVAwNnZRNVhscE16UGhyRjlKd0NxOUk4NkFjaXJPRnhqdHRiRTdnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3c5N2FkOHp2OC94bGZDNldBRm12ZG42UUVtdHJDWkZGLzU5cXp5K2s5SFdH?=
 =?utf-8?B?bVdZejNOUHh5ZzRDVzQ2Rlg2N2t3NFlGQTBoamxvdXcydklPNnFuZC9iZ2cz?=
 =?utf-8?B?T0VGaURpTndVK2ZkRGRreUlmRXNITnZSNk9VUVJvbUNwRnA3eUtIaEhiYWl5?=
 =?utf-8?B?UmM2c2x6dm5EL2dIV0RMdUhBRkNFRHBVYWxKamlsekNwU1c1cS9sbWNiM1JC?=
 =?utf-8?B?QTZLS2hHbnQ5WTNBd1JzWW9sR2dEbGZPVmFteU5BNjNaUDh6RGRqazRTdjhX?=
 =?utf-8?B?SzQ4NFNqcGRDSUFJV2F2Yi85cXhYU3ZDLzc1dGtJRG4yd2xQOGRwb05FaWxL?=
 =?utf-8?B?a2lDbVNTVTRKbW95bXoyVGYrZXdpVXFXNjlDbys0enY3NCtPWmxyTlB0SUpz?=
 =?utf-8?B?SUhYd2NTMnNGcTN2Qk9oL2dCc1p4UVNlY1VFNXh5eitzM0orSXRkLzVGWG9o?=
 =?utf-8?B?RjFiNzR6cUFzM3o4c093NGV4b1I3Tm0vcUduS1F5NVRtNG5kaTZ1Wjd0K005?=
 =?utf-8?B?YkFBY3ZmaTBVVGdKN2hPckZaWC9TNUdrODFibUVPbFZaWUJyU3hiM2xqcmtt?=
 =?utf-8?B?eVhTUDFXZXBzV0k5V0trU2s3aGF2YjNVR2J3bklWY0liemV0YnVDbFFWRUlR?=
 =?utf-8?B?WExyYWJabU1rK09uMHdLVTRaWEdGUE5uaWlld3RBNWN6SGs2bFk1bFlkYi9V?=
 =?utf-8?B?RG51ZSsxdHovWGtJbVpRZEQxQnNxWDg3WFloRVEzYlE4ekVvYVUzOW0wK0pJ?=
 =?utf-8?B?QXNJMTJFMzk0RmpER2hEcklDZ2ttbmxoWkNaV3V4TFFxNVJpM2FxMTJIQ1Rn?=
 =?utf-8?B?SGJVQnMvWGdvcFpxZURkRGd3MGpYUkZVN0RRb1FVQStTbkJUblBIc2MyMjhK?=
 =?utf-8?B?VUxwQnVSdHU4dGhHYytRdGt0cURSVmdXZWtVZlpvRHBVdUc2VEpEdTNZeVlE?=
 =?utf-8?B?OHZ1akRHV1BMdktER0FQMnZTeFVEQVZHQWR4eXEyRVg0a3NqSzhPb0p4VGhp?=
 =?utf-8?B?NU9NODk5c2xHMnhrWGp1TUs3VUdkK1FUOE5Fc2ZvQS9oRnBBS3FGZ3ZnNmZs?=
 =?utf-8?B?UkhGYlpLRitscElEQkhjbzFmU2dtb0tCcVkwWXVuc2QzbnMrOCtVMS82Vm9Y?=
 =?utf-8?B?QllCYTFCZVVpWm10L2tmMzB6SFgwM1ZrT0NnZEg0ekRpUUFqT2JmZmRTeDF1?=
 =?utf-8?B?M0NtYTdaVG5rK1EvQUFYY1prODNrYi9pdnova0MyYkRjejJNbW5qQ3dFVWlP?=
 =?utf-8?B?QXcyTVoya1N1Qmh5UmE4azBvNmczNHJWVnNobzVWZnRGVFU1bzgxMHZjd1g5?=
 =?utf-8?B?U25MR2laV2RlTVBTLzJqU1BoMzdjMkQ3NGJDWDZSTWxIeDN4b1JNSG55d2J6?=
 =?utf-8?B?d3JyczdFNTh0dm1SWmZKWEhLVDY3WWRpV3NTbkxFT2QweXFxTVoyTEVpYXcy?=
 =?utf-8?B?MTd1S0U4MG5ZTjFlZkQzUHc2UlEzbmQwUVJneWlaNTViLy94NndSUUNZUGp2?=
 =?utf-8?B?VVliZ3Jva0lQRmxuU2twTWF4YkoyMEpZQ0lFNTJjMXpjTnRsR09KWExUTXlH?=
 =?utf-8?B?VDh6Q2ZhTFlBNTFuMW1KNEF6NHRZT3dTOEhUeTdOMWJGZWU2Q0RSSGhlTHJB?=
 =?utf-8?B?YXJ5VUUrdkg4bmkwQStmcGdqWEVZdi9JemlKM0phR2tTcnBYNDUrWFI3U1Fr?=
 =?utf-8?B?eHhNUGh1dFNmRlYxNGhITFBuNjlqRW1ITHFiSFErSWx6ZXRpM2RtTVh4dGFS?=
 =?utf-8?B?VExiUEdlK2hpZW1sMDR1NUV1TUEvR25Bd00ySDcyN21TcG5jT3lOTVdiM1Vk?=
 =?utf-8?B?aXhOcXY2QkdLSXBNL29Zd0szM292VFhyN2xJaEhzbzBWQ0JZbmg2NTRNckJL?=
 =?utf-8?B?Y2Urd25VT1hlSlF6RUFWKzlHd0JCK2Rkd0Y4NncxS2tFQUhBMFl1d2xRNkEz?=
 =?utf-8?B?alg1YzZRaTJzRlBwNm4wbWE1cDNQdXRZTFg3NUdmUzIxWEtDMFIvbTBSUDRF?=
 =?utf-8?B?Y1lxbVU2bS9kUkxYc3FGMlZmTCs2WlJHSndPYlNreFphNkEvV1lxRWlSU2Ni?=
 =?utf-8?B?aTFLQS9vNmw0ZkxrQlpxOVFXTlpHVDJzN2NxY3EvMG01bG5NMjNncXhZWFdG?=
 =?utf-8?Q?DQG0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff74b5a7-b871-44be-a788-08dc659b9e79
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 02:50:23.4007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VQWqA3OLyf6+Xy+J6WDlTl1wtr9y3uDUdJSJ7xiLNeuFhusrKTa80iOS/W8Vdv0j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8535

--=_MailMate_AAC7DC85-3691-49B8-8AE2-2FB09CD15A3D_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 25 Apr 2024, at 22:23, Barry Song wrote:

> On Fri, Apr 26, 2024 at 9:55=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
>>
>> On 25 Apr 2024, at 21:45, Barry Song wrote:
>>
>>> On Fri, Apr 26, 2024 at 5:11=E2=80=AFAM Zi Yan <zi.yan@sent.com> wrot=
e:
>>>>
>>>> From: Zi Yan <ziy@nvidia.com>
>>>>
>>>> In __folio_remove_rmap(), a large folio is added to deferred split l=
ist
>>>> if any page in a folio loses its final mapping. But it is possible t=
hat
>>>> the folio is fully unmapped and adding it to deferred split list is
>>>> unnecessary.
>>>>
>>>> For PMD-mapped THPs, that was not really an issue, because removing =
the
>>>> last PMD mapping in the absence of PTE mappings would not have added=
 the
>>>> folio to the deferred split queue.
>>>>
>>>> However, for PTE-mapped THPs, which are now more prominent due to mT=
HP,
>>>> they are always added to the deferred split queue. One side effect
>>>> is that the THP_DEFERRED_SPLIT_PAGE stat for a PTE-mapped folio can =
be
>>>> unintentionally increased, making it look like there are many partia=
lly
>>>> mapped folios -- although the whole folio is fully unmapped stepwise=
=2E
>>>>
>>>> Core-mm now tries batch-unmapping consecutive PTEs of PTE-mapped THP=
s
>>>> where possible starting from commit b06dc281aa99 ("mm/rmap: introduc=
e
>>>> folio_remove_rmap_[pte|ptes|pmd]()"). When it happens, a whole PTE-m=
apped
>>>> folio is unmapped in one go and can avoid being added to deferred sp=
lit
>>>> list, reducing the THP_DEFERRED_SPLIT_PAGE noise. But there will sti=
ll be
>>>> noise when we cannot batch-unmap a complete PTE-mapped folio in one =
go
>>>> -- or where this type of batching is not implemented yet, e.g., migr=
ation.
>>>>
>>>> To avoid the unnecessary addition, folio->_nr_pages_mapped is checke=
d
>>>> to tell if the whole folio is unmapped. If the folio is already on
>>>> deferred split list, it will be skipped, too.
>>>>
>>>> Note: commit 98046944a159 ("mm: huge_memory: add the missing
>>>> folio_test_pmd_mappable() for THP split statistics") tried to exclud=
e
>>>> mTHP deferred split stats from THP_DEFERRED_SPLIT_PAGE, but it does =
not
>>>> fix the above issue. A fully unmapped PTE-mapped order-9 THP was sti=
ll
>>>> added to deferred split list and counted as THP_DEFERRED_SPLIT_PAGE,=

>>>> since nr is 512 (non zero), level is RMAP_LEVEL_PTE, and inside
>>>> deferred_split_folio() the order-9 folio is folio_test_pmd_mappable(=
).
>>>>
>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>> Reviewed-by: Yang Shi <shy828301@gmail.com>
>>>> ---
>>>>  mm/rmap.c | 8 +++++---
>>>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>> index a7913a454028..220ad8a83589 100644
>>>> --- a/mm/rmap.c
>>>> +++ b/mm/rmap.c
>>>> @@ -1553,9 +1553,11 @@ static __always_inline void __folio_remove_rm=
ap(struct folio *folio,
>>>>                  * page of the folio is unmapped and at least one pa=
ge
>>>>                  * is still mapped.
>>>>                  */
>>>> -               if (folio_test_large(folio) && folio_test_anon(folio=
))
>>>> -                       if (level =3D=3D RMAP_LEVEL_PTE || nr < nr_p=
mdmapped)
>>>> -                               deferred_split_folio(folio);
>>>> +               if (folio_test_large(folio) && folio_test_anon(folio=
) &&
>>>> +                   list_empty(&folio->_deferred_list) &&
>>>> +                   ((level =3D=3D RMAP_LEVEL_PTE && atomic_read(map=
ped)) ||
>>>> +                    (level =3D=3D RMAP_LEVEL_PMD && nr < nr_pmdmapp=
ed)))
>>>> +                       deferred_split_folio(folio);
>>>
>>> Hi Zi Yan,
>>> in case a mTHP is mapped by two processed (forked but not CoW yet), i=
f we
>>> unmap the whole folio by pte level in one process only, are we still =
adding this
>>> folio into deferred list?
>>
>> No. Because the mTHP is still fully mapped by the other process. In te=
rms of code,
>> nr will be 0 in that case and this if condition is skipped. nr is only=
 increased
>> from 0 when one of the subpages in the mTHP has no mapping, namely pag=
e->_mapcount
>> becomes negative and last is true in the case RMAP_LEVEL_PTE.
>
> Ok. i see, so "last" won't be true?
>
> case RMAP_LEVEL_PTE:
> do {
> last =3D atomic_add_negative(-1, &page->_mapcount);
>    if (last && folio_test_large(folio)) {
>        last =3D atomic_dec_return_relaxed(mapped);
>        last =3D (last < ENTIRELY_MAPPED);
> }
>
> if (last)
>      nr++;
> } while (page++, --nr_pages > 0);
> break;

Right, because for every subpage its corresponding
last =3D atomic_add_negative(-1, &page->_mapcount); is not true after the=
 unmapping.


--
Best Regards,
Yan, Zi

--=_MailMate_AAC7DC85-3691-49B8-8AE2-2FB09CD15A3D_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYrFmwPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUm4UQAJ0aWBln5/8UqROLl4+DY5ruik7J6kqv5U4e
sRutUToZX07er2ou/uaYXzq7fb0jsvrqOZuA0StrKsE3YeKQ9DyILAoPEv97f3j6
QkNkpMzmgdJ69LGeohjBnIP5WOE7wyE+dwmMgNtITd9W6GDj5U5g//EKVs8ufvuG
27yq672HvNzFIEVVsTD+vjT9nVenyymzg93NW/MaU4esmHeur5DNvF63qavuGr5D
RI6MmFZSeASfDf76rsUEJrYYUpdzyCmlNIhuynDOe1+WV2RZXDtT8cvoDTqp2X8l
J1VYYABTL5u/TbQOgOiU6daua5pLtX2fZ1SkrM+U4WDVvzrsErTtmUDjzZGEEiS3
x1f05ODyBNoMWhW9ov3S2GmjPqFqLQrMhcJ5w4GE+SmdtrAkG2s7lt/+tL1NHh/R
ZJAYjiMfxZI+Xa4e0TqBIGJ3PyOLLMjZAEGdcHpPDqNj6TDFD04t3vsFLUGTMKNv
VqIPMxb3tgjRN/CnwkcsKvZFMrBeT0Uxh5IfxreVO09gcThoFrvIdT9WprJq5zi5
tELq1NtbU23fXA2tljYhtDRD4IN41E53pQJ2aW0x2TslWzfiqZIJn1LMQ12E0A8j
8B0BEkVd84E0dbSUaw/j02jwWSJ+U2kMtcpjV9gdigorFN82hKvMgL9ai10xXw0X
oLAXNonZ
=457H
-----END PGP SIGNATURE-----

--=_MailMate_AAC7DC85-3691-49B8-8AE2-2FB09CD15A3D_=--

