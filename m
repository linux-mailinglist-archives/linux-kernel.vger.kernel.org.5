Return-Path: <linux-kernel+bounces-162469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A42B78B5BBD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AA771F210B5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130EF7EF18;
	Mon, 29 Apr 2024 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XoTbJsi4"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458183D56D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401929; cv=fail; b=KXUtyoxlyU6sEVk0+XUbuMVNUVOYXxAkEGHTbOZ2SfAVTuBshwiW9qbxYpExGF0ZTiqD60bSXYlYjlWbYMGWC0AbkcNfkNr8HcSakMmRmI3OWaEH2GzfWd18Ld55esc9GTd+K7lhkzKBAOJZHLMUOeKLHpnTEbNmYlyTAkMzYOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401929; c=relaxed/simple;
	bh=YTic5itKD3wQhZ4BCMdbHxWfnkmw7y2dtp7rVBUlm6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=htIK7igqFxPCWUeN3xdQ8DXt9et6kvcoX3NZtjUTYVeXVC9tGbx47CPE3JNxk0BIC/DpFatcjKhapJghyaufIS7Eh8/M42lVHKSuJ8MOE+tk8g3g2bZEEvqIYChNaDku4+VzHrM1MotNV0jfmRSksclfZo8UjPLfsDtDfIqFug0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XoTbJsi4; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMBIIbe1HkJKh7kl6TYgFqu8UKgJBn6TrJygbD6D+T4bEmJdsvJ24vwHf+6gEwziRDLnVi37fWEDX6IcqWtq6Fza9x0HEtCFqbz+v1gY2zVQF/p7G4tdvGDJe+2u9rq3iNhO3WUoncjQtFLXOsoUVdA3pzENTHdcZDaTEkeYYr6Owig//SyOMJmsonyPi2yuA7ud34aQJXT9hOWohLOx6Fw7+nz5pzo3JsJnG3twmRn6oG+Ps03BDtBQ4/SUMOskMH8r1dqRA1yhK4vGarXMtg765mEVp7mJ420TkjAsaOrxxmEweEMT3+4LylYnaEpi5PAPk/u48u6i1/WZX7fD0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mm4lpMvXys1aQFTk6ShGkiQ15xiWGnnqbMIftBLN3K8=;
 b=Nt/fx6QSkR+f6snManZgFEDaqIXX4urNN1qQD2NXxwTWRbHktN/ztapgg6ATy1FAYjsnxXrq2VGvMVvPHMjAQM3xAAAqQEYPkYo4PEMmVxxjc4OknArNtLGC4acW8xvVelBle1ERhbE1NFW1Aa9QBqFWSYb04a+0yFnKpm9Ya+ij5uHsTuDODn7NqEAFoQdZyBoRL9ao3WP8SJg3OI78SHFUL5gvkGkK3PZmUwrInr3Tu3oEymsNSXEt7ywB5bC/N/h61y+hIwM6gAJWPbmH5qey4VcMqGbBvLr8dPlTOkteiZzfl44O0hOeizC6VOU0FABjezalvCrp5sjJAwsbTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mm4lpMvXys1aQFTk6ShGkiQ15xiWGnnqbMIftBLN3K8=;
 b=XoTbJsi4+99I/7ETyrWlcYcn/s/+9hv2A8I65dhaXdVMvhFRPwx8TKR+ypi01BY7ws1Wz/x4tvWVZrbVxFv/iEDqZhddozdoJj2Mu/sGXQhJnR0bggCt91lrTP3gXMAcuo5xdn81hoYivfkgzayO/gQSd3dz3zZ9J/m8++A0DPcGzxSpGIyjyY5zYJM+6nSSSK4giy4p+q8HTEc+FZw4nbWW2BYkk2HtYOMvl3xrpyXG5VKhutVmC3DDLoDm8kvhUopmXbXl3dP4Rw2PVytSDKQzP6j9uQUghV90z/a2ptmvPAQtGDd4e1rmcxVT3Mm9OrbAtHyu4iOgvmgAK559Dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SA1PR12MB7173.namprd12.prod.outlook.com (2603:10b6:806:2b4::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.32; Mon, 29 Apr 2024 14:45:24 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 14:45:24 +0000
From: Zi Yan <ziy@nvidia.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: John Hubbard <jhubbard@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <zi.yan@cs.rutgers.edu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm: Fix race between __split_huge_pmd_locked() and
 GUP-fast
Date: Mon, 29 Apr 2024 10:45:22 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <64037B35-3E80-4367-BA0B-334356373A78@nvidia.com>
In-Reply-To: <23fbca83-a175-4d5a-8cf7-ed54c1830d37@arm.com>
References: <20240425170704.3379492-1-ryan.roberts@arm.com>
 <17956e0f-1101-42d7-9cba-87e196312484@nvidia.com>
 <2C9D897B-0E96-42F0-B3C4-9926E6DF5F4B@nvidia.com>
 <328b2b69-e4ab-4a00-9137-1f7c3dc2d195@nvidia.com>
 <23fbca83-a175-4d5a-8cf7-ed54c1830d37@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_23555A3C-255D-4C75-9BDF-7BCBE4832D88_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR02CA0096.namprd02.prod.outlook.com
 (2603:10b6:208:51::37) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SA1PR12MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: 6558a381-9a49-49bb-78b3-08dc685b00ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjQyRk1JTnFvUWdDT1VzcHlqd01DV2ZGdzlQQ2g0dm9keWs2M1U3dGJ4b0ZZ?=
 =?utf-8?B?M2pocDJZZEdpaE1pQWl3N1ZkNmxkZlVsWm1GMm9NbEIxeDYybnZFREZJMElV?=
 =?utf-8?B?VU5zUFJvdjlYTyt4WU56MFhoNlhrWUx3T2RDa2VTZUl6OVFJY3pjUGU2ajhJ?=
 =?utf-8?B?OHVJREtqeldlazlSVG90WmplQzFTdUVKS3FadUFBTTZZaEhkem1OeGtYNit3?=
 =?utf-8?B?Njg2K1dhRGNKbWJIOTZZZEVrOFhmT1dCNDZ5VnkrditORnNZMFBGWVhKS2Rk?=
 =?utf-8?B?dDcycDQ2bGx2UHBWcXhaNFA3VmR0dFRyMy82Q3B2d0FBV3RLZzN2RjdueUtp?=
 =?utf-8?B?R1A1dU5mYXZFaVYwM3VLOThzVkFseFR3b1FQNktMMDRrK05oNFh1SDVuaEd4?=
 =?utf-8?B?dlhsMmpZRncyV3BTQ282UDRoVExYcUtGd0h6SURQNk8yUTlaVzg2VnREdUcv?=
 =?utf-8?B?UmJuaUVmRFJGcTRiMFJ0R1lHbFZyeGRUQ3l0bmdRL2Q2cy83bVRxTHpxYmJj?=
 =?utf-8?B?dHgyYUVEVHNXdkFSZkd1U2NsVDI5aHJOOVlrUnQ1cmtZeU5Wb1hyOXhtNlpq?=
 =?utf-8?B?YW52NWRrbzl3TWpiRFVDRDByWkRRUFY5L3l6UnEzaU1tKzB4RXpPYXRuU3ZK?=
 =?utf-8?B?Z0RHUk1FSUF6ZndPZCsybWJzRkVBWjV6dnVsTmpPeWE4dFIxdmw5UmRDUWdZ?=
 =?utf-8?B?UHJQUFV1V1orZ3djY2J4U0FlNGY2bEpWVEM2N2RXT1pzOFo2bzhkM3FxZnJp?=
 =?utf-8?B?UjVkb29wWnhpdmhxeUljNlhlaE9OaXV5clF5MlE1aVNzb284WHo3Z1VsVFBn?=
 =?utf-8?B?OWhuaEdhNE9oQUVydkV2c0lFK0xqSDlRVnIwMjFGRTNaV0tKVUQ5dnBnaVFM?=
 =?utf-8?B?NCt5YjlyNjc3L044SUtJaEM3Yk5kR1ZaVysyNExYcXdiRXMzc1hCK2Z1N1Mz?=
 =?utf-8?B?b2hZSnZMT1dNaWQ1NUVESnlKNGFRdUZyZC9RMUkraSt1WGlHTFRYckFVcXV1?=
 =?utf-8?B?b3V1MjVWVlo0VEw0bmhxVW10SG9mbWZFenZaK2VOVG80NzFmcnRqOCtCRXE2?=
 =?utf-8?B?Y3BmRi93Ukp0M2p4aW5OVndyUHJhdHE4aWowV0ZTZlNqYTNsdkk0dUx3REhy?=
 =?utf-8?B?a0dWSWJXVlNoTktVT2kvaEJNTUJxdlBsVlU5WE9KeXB4Y1lSZlhCTElnM2Rp?=
 =?utf-8?B?UHVJL1BWVk01eW4zWHRtZXBySlRRZnUvckFIWU1sWkJFMytndzNvOUtwYTQr?=
 =?utf-8?B?QVM4d2JLVFpqQ1h3OXBhTUg0NGtid2IyaFdpMVZ4cW9DREQ0MUtUeTdELzNj?=
 =?utf-8?B?UHBjeFdkUFNaN3FhS04xai8wcWE4WUZGTEh5N1htYjAwNExKWXZtdmF4RUlr?=
 =?utf-8?B?Wi9ua1IrZHpBb08zaW9rZEs3ckFJS2VYd2JFd29FbHg2a2pwVTg4M2VGdGhE?=
 =?utf-8?B?anJHTlRnZGxHdFBWS1E0Q21zbERBWDVSMnZSczAxQ09ueDFoclUrNzgySWpE?=
 =?utf-8?B?UFZpZGtHbkY4YWtOa3FFMjU1Q0FFcVlsRU9JaDhGSHVZckF1MTA5K0t6TmZW?=
 =?utf-8?B?UFBjcU1jOHNVVDhuTnBWaUdMZHpDdXpCb0htUFl1aHZmdW1QRWN2eU1uc0ZP?=
 =?utf-8?B?QW8rV09XV29aL1RhaVZkS1FQSzdLM1hVQUdVZ2ZPdWhmUU5WOW1DY0dNdXlT?=
 =?utf-8?B?VUFqYzVQZGxRdUc4Q1AwTjI1TUJrbUxJeVZSRnMwMVNZTjZJWHZyY213PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGhpVVpORm9DQ05Ga2tPQW9ZTndaSzgvSzh0d0hQdFNWekxnRDIzczdWY2lu?=
 =?utf-8?B?QnRrNFdBbjJVemhmb0t5M3Q0R1pMQVhwSGRONXNDYTBuMUhiOUsyVGUxcElt?=
 =?utf-8?B?RVBXbDJPTTJzeEJYUTVDZkp1MUNjSzdFL24zYVhKY1p1TWJGL05xRU5iU1Ex?=
 =?utf-8?B?TkpnUGhFbWhmK3FEN3cyWUpNRktOWnJIRTJSVVg4dk9na3lSWStJaTFCQ21E?=
 =?utf-8?B?bGk1a3pXK0w2MXpZZUZsWEwxZkFtYVlhTDJFNnFUVDNFUVF1WFB3R3lrWm1m?=
 =?utf-8?B?ZjdHdFFhcXJPeDhIRW5lVFlmb1BpbmovdEk3TXc0cEQzS0hyME16cFRHL1dX?=
 =?utf-8?B?dHZIWUFxUXR2SnJLZk85NlhLREc3cVoxZmlmbGlKUUplL0ZTUkFuRDJUZGpU?=
 =?utf-8?B?OGhXWkwxWVptOU1KM2t4bXRrQUdxSnZMSGhlNHJqU01heEZHZ2xqM2ZLcVB3?=
 =?utf-8?B?NmJUcFRucEtLakhEM0dBdUk5ODdpbnpjMGswVmxvZ2VSZ2hxRDBQUERkYnlq?=
 =?utf-8?B?S3JyZUt3SGZPc2Jyb1NQSUllNFNhdUo4QzFpSVNnM0Vtd0ozNTY5VlJLQVB1?=
 =?utf-8?B?NThyNS8rRlkxRGl0S0JlMHBNZlh4U1R3eW9CU0Q5OFhSU1BJWFlMMDlqenNX?=
 =?utf-8?B?bU4zeDBwSCt0WDJ0aHVIN0MybUgvVDBFTHZKeXNVTjRYeUlOdlhFc2VaRisr?=
 =?utf-8?B?czd5TE8wKy9CRDg2cGJpaXhzb2JZc2dHYWJlSzZOS3pmYW9WVXNBZXVNMXZo?=
 =?utf-8?B?SWVSL0JEK1dXL1E1ZWZiejYvdmlLNnc0cFlpUG5HSUpGQzNTeVU3YW9vMk9T?=
 =?utf-8?B?c3orVXVyZ0QyY1lWVzcyeHpzMk5hS1RTMGxUZnhiM0VnYVlEUUszSGllM3Iw?=
 =?utf-8?B?Wmc1cFR5dm83amk5cXQ5dklHL0lKT1d1TUJ6cGNNaFRWS2NjQS9DSS9WSzU3?=
 =?utf-8?B?M3NucC9SVGJBdS90UnRzcHlTZzVhYVRtUmtTRko0Y2NLUzc1b2VvcUErRTNK?=
 =?utf-8?B?U0hJZUQyQm5ZeWdsUVdBKzM2NFNBc0J4YXl6bXV4dmJWd2JSWGVHcVo4NEcz?=
 =?utf-8?B?RmxRMkJtOUUrNnVDNG53M2J3Z0taamtlak9uV0x0VytZZTZJSlJxUDU1VjhQ?=
 =?utf-8?B?ZW1QdnpIRFhtcDh5MTUrOW16SVlyVjkrK2JGRzlObktpVmR5b041d2h2TURE?=
 =?utf-8?B?bG9oMlNPZFFXRGhkdjZIM3JGV2NsVU1Ka1N0by9HakJzSFE4UXlqZnZJWXZm?=
 =?utf-8?B?Q0ZaVUdKMVczakUvbzIzSWFKaWorWnk0dUFjQmIyQVZrUzRqR0JyRERxbDB1?=
 =?utf-8?B?WDRseDUwWGhNNkNWZWhXMjNkc0wzb0RpR1VSR3dvbnUzcXR0THQ4OUdQaEdh?=
 =?utf-8?B?emdscVhJNm1vZ1pUc2lPZC9NenJNekNPenNiZzdBNzREbzE2L3lCcHB2UGhh?=
 =?utf-8?B?MENNVmJsekVwTWdPejFBRHdFdzRWSnJYaUNPQkdzMGovbFhzZXVxbTVPb0hQ?=
 =?utf-8?B?TktqSGxjckMrU2hreFREU0F0Z2pLYzVrYTZsMFhPdVNOb09SNmtoNzBGNjEx?=
 =?utf-8?B?Zm9xb2dCVHkvbXo1cUZERjZGbTJMMGlaMUFONEtBeEZzcHdkMTRhb1NaaVUr?=
 =?utf-8?B?TWtpSDNoVHJwWGN1R2tDWDRTQXJwTlU4WXRHQXpMYmR0bWJ1RXd4M1dtUUtF?=
 =?utf-8?B?QUNsYjNKTUR0QzJVUDBCdk5xa01YQS90K0d4eFA2YVVFSjBuWkd0Yy9sUVM4?=
 =?utf-8?B?Z1Z2c1lOMFJmN2paazQ3MklXOE9YMmxmaW9RV0NzcC9mUWVlY2kyQUxuMk1S?=
 =?utf-8?B?VGZSRS90NUNvOTN5QXRVd1djZWozcmJ4dER1UW9iQzZBalF3OVJYNGpYTk9x?=
 =?utf-8?B?SEd0TnZuOEh1STdwQUVvcGRWUUZHLzZWYlgzcUwzOXZYdUw1UDJOYytFdWFv?=
 =?utf-8?B?ZTVNVjJ2OUd3ZXZkK0N3MjBlU3NvRU96bUNXaEg1TmQ0REg3ak0yaHgyWERt?=
 =?utf-8?B?ZjlhS2pNMWFQRmE3ZjloYnhFOWdPWHN2UFZpVzJHa2pBOXZ1UFpPR1h1UUtV?=
 =?utf-8?B?cGlPOUJIK3YybVBYQzk0TGQvS0kxWkJzN2Nicm4xcFhRQ1QzaU9YTUtiZTUz?=
 =?utf-8?Q?Jcud4MYWQTcnjrV/ZzOlkQZt0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6558a381-9a49-49bb-78b3-08dc685b00ce
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:45:24.5553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3wMjrPnm22z9H85U1YnKnsq3MA1a8u10GS02EOm+cwlTp03gD+b/Ey1YObspqJY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7173

--=_MailMate_23555A3C-255D-4C75-9BDF-7BCBE4832D88_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 29 Apr 2024, at 5:29, Ryan Roberts wrote:

> On 27/04/2024 20:11, John Hubbard wrote:
>> On 4/27/24 8:14 AM, Zi Yan wrote:
>>> On 27 Apr 2024, at 0:41, John Hubbard wrote:
>>>> On 4/25/24 10:07 AM, Ryan Roberts wrote:
>>>>> __split_huge_pmd_locked() can be called for a present THP, devmap o=
r
>>>>> (non-present) migration entry. It calls pmdp_invalidate()
>>>>> unconditionally on the pmdp and only determines if it is present or=
 not
>>>>> based on the returned old pmd. This is a problem for the migration =
entry
>>>>> case because pmd_mkinvalid(), called by pmdp_invalidate() must only=
 be
>>>>> called for a present pmd.
>>>>>
>>>>> On arm64 at least, pmd_mkinvalid() will mark the pmd such that any
>>>>> future call to pmd_present() will return true. And therefore any
>>>>> lockless pgtable walker could see the migration entry pmd in this s=
tate
>>>>> and start interpretting the fields as if it were present, leading t=
o
>>>>> BadThings (TM). GUP-fast appears to be one such lockless pgtable wa=
lker.
>>>>> I suspect the same is possible on other architectures.
>>>>>
>>>>> Fix this by only calling pmdp_invalidate() for a present pmd. And f=
or
>>>>
>>>> Yes, this seems like a good design decision (after reading through t=
he
>>>> discussion that you all had in the other threads).
>>>
>>> This will only be good for arm64 and does not prevent other arch deve=
lopers
>>> to write code breaking arm64, since only arm64's pmd_mkinvalid() can =
turn
>>> a swap entry to a pmd_present() entry.
>>
>> Well, let's characterize it in a bit more detail, then:
>
> Hi All,
>
> Thanks for all the feedback! I had thought that this patch would be ent=
irely
> uncontraversial - obviously I was wrong :)
>
> I've read all the emails, and trying to summarize a way forward here...=

>
>>
>> 1) This patch will make things better for arm64. That's important!
>>
>> 2) Equally important, this patch does not make anything worse for
>> =C2=A0=C2=A0 other CPU arches.
>>
>> 3) This patch represents a new design constraint on the CPU arch
>> =C2=A0=C2=A0 layer, and thus requires documentation and whatever enfor=
cement
>> =C2=A0=C2=A0 we can provide, in order to keep future code out of troub=
le.
>
> I know its only semantics, but I don't view this as a new design constr=
aint. I
> see it as an existing constraint that was previously being violated, an=
d this
> patch aims to fix that. The generic version of pmdp_invalidate() uncond=
itionally
> does a tlb invalidation on the address range covered by the pmd. That m=
akes no
> sense unless the pmd was previously present. So my conclusion is that t=
he
> function only expects to be called for present pmds.
>
> Additionally Documentation/mm/arch_pgtable_helpers.rst already says thi=
s:
>
> "
> | pmd_mkinvalid             | Invalidates a mapped PMD [1]             =
        |
> "
>
> I read "mapped" to be a synonym for "present". So I think its already
> documented. Happy to explcitly change "mapped" to "present" though, if =
it helps?
>
> Finally, [1] which is linked from Documentation/mm/arch_pgtable_helpers=
=2Erst,
> also implies this constraint, although it doesn't explicitly say it.
>
> [1] https://lore.kernel.org/linux-mm/20181017020930.GN30832@redhat.com/=

>
>>
>> 3.a) See the VM_WARN_ON() hunks below.
>
> It sounds like everybody would be happy if I sprinkle these into the ar=
ches that
> override pmdp_invalidate[_ad]()? There are 3 arches that have their own=
 version
> of pmdp_invalidate(); powerpc, s390 and sparc. And 1 that has its own v=
ersion of
> pmdp_invalidate_ad(); x86. I'll add them in all of those.
>
> I'll use VM_WARN_ON_ONCE() as suggested by John.
>
> I'd rather not put it directly into pmd_mkinvalid() since that would se=
t a
> precedent for adding them absolutely everywhere. (e.g. pte_mkdirty(), .=
=2E.).

I understand your concern here. I assume you also understand the potentia=
l issue
with this, namely it does not prevent one from using pmd_mkinvalid() impr=
operly
and causing a bug and the bug might only appear on arm64.

>
>>
>> 3.b) I like the new design constraint, because it is reasonable and
>> =C2=A0=C2=A0=C2=A0=C2=A0 clearly understandable: don't invalidate a no=
n-present page
>> =C2=A0=C2=A0=C2=A0=C2=A0 table entry.
>>
>> I do wonder if there is somewhere else that this should be documented?=

>
> If I change:
>
> "
> | pmd_mkinvalid             | Invalidates a mapped PMD [1]             =
        |
> "
>
> To:
>
> "
> | pmd_mkinvalid             | Invalidates a present PMD; do not call fo=
r       |
> |                             non-present pmd [1]                      =
        |
> "
>
> Is that sufficient? (I'll do the same for pud_mkinvalid() too.

Sounds good to me.

Also, if you move pmdp_invalidate(), please move the big comment with it =
to
avoid confusion. Thanks.

--
Best Regards,
Yan, Zi

--=_MailMate_23555A3C-255D-4C75-9BDF-7BCBE4832D88_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYvsoIPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUnOAQAJILpwZal3+OXf+nlVlsToUHSW0w59IizgWO
EW6ZVuwOmrkVciIG2VyBGy56sAVXjS2Hpwm3eoLYWQg56C8j3SyAM6GqM4FplxfT
aJwejSLCB5es+XQ3YdmUZvuZodSfgJyGfxreqI4uJFnqROVAvXrcmvc9saMERS17
XDajRW1QUkr/gpVDvb4sjO+EeG7l37X0zRRN6khBWIXd8zdpzWjpjd3vSO9pePXm
o/uI70Urhsydqm2pzW4Aw/t8bBr8tj5gBkQkARnMk7l0vXoFR3UmL7j+lM0w6xlC
fKGBvryqwIe+5B4Ed27ESuxUkkBQk5vToirw9sEHehjeonkOOFj7UeCsiEHHrHFy
cAy+pajdJ4NSf8lYMDl7Ex+TiU/Mdspqq6hUN2XpdbEKrU9jkXtzPucbPBjddReQ
2n/f2oEiDKVTIDZE/XcKVosbPHfHCbfmsDbFAY1GRHXOvhJcEH1245cRQK9T4NDT
IaLkVz1tPh06Q43Xy0iJtPuzRz3HEHtJF3TRfIUsp3zF0ZKnQ7hV0rddzr2th+PO
MpZ/PGBAk+Z0GxARLI1ZpgDs7PoqTUAvDrCrJ2ksamEwx8cDhwfz6HSHElIHL+iP
CCO+SMRbrrJ6J7f5tyo0D1GxRyttOP1tA8iDE3Uvpk5E1q2Isx1tIWRtNfl1j6yL
xJsg6dKc
=GMop
-----END PGP SIGNATURE-----

--=_MailMate_23555A3C-255D-4C75-9BDF-7BCBE4832D88_=--

