Return-Path: <linux-kernel+bounces-76747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B478B85FBDE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAC2EB220B9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF43714A094;
	Thu, 22 Feb 2024 15:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fZFuiScZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J1rOJ07C"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC11E1487EA
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614448; cv=fail; b=C/OFjYr1l2beo9T28fTAXY0CGXX2YDu+BlxbUUlRTHYTdil8E4rGjXiwCeQzaeMvhWmD3QebVp1fOGuiKtcukBgjLr2H+Z2KrFInFQagszF9kJb+RbCA70CwIXVBQQDaVnEBJaIkTkWNDH6a7VfvTRdl5/5afi1X3E34K/fJ3vA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614448; c=relaxed/simple;
	bh=FJTXnRyCU5Cy3J2Mg5Wouh0GYtPUY0wfFx+y8va3+D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ooW0K2AGIWWGPPCmyVg0LifDt/7kwXnlZzli1iz/kv0WZytOuHR+fDnY7T9U+lnw45Cyv8+7JyhtGQkq6sGw+EahWRDjepDu+5xPl3SMqqcG8dgyunEoQ1FrktQ0aNuuz6elCKNWAdlrYciKl9oueaiazD3GtYcj+vpIPChPEBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fZFuiScZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J1rOJ07C; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41MB8j6r031006;
	Thu, 22 Feb 2024 15:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=GcH9v6Ww3NgkhwdANf0QhPk5rTB/fdTp1nBrmv6170E=;
 b=fZFuiScZt2+cnrLBhJU5UvCUhYMMpL5Vy9pyyuAeAjalYZX4gqkeRD+Hb1UxIvPisYyZ
 PZCkgFLAnV64ZPVkdxcH9vljicun12Zs6eIEnNhXXgdqkjmsrpjTzqh4eUtlLNhCEf09
 l5/0Wh13S7kC3CTcQhfCrIl2rBtTc1kAWcLAVhPrQS+6yTPNsmvcWHZ1KgcV7eO1SdkD
 HV2KIahDHmN2ZgXcrDsUq2q+YhudouAQ0pUroyWhRJTR9hUlmfoWeKTkoiRrKeFvAoaV
 JBmE4ioacsscIHJCYqzlEzYcNmkQ9tf2JDB2qvIcnuWyZ+N4lEsMSUuMh7eG9VZ/xy6z dw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wanbvmuqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 15:07:11 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41MEoeoX024458;
	Thu, 22 Feb 2024 15:07:08 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8as85e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 15:07:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPsUC0wPV8SuUVqcf85lDkK6AJHgN4Cc5eOZRZzXdLmjvepj61ih+kPJo2ewUFx4uK+Rgxh/DJEqcVbVM5fJzUgEkaOTTyNHVf5GLvPm86EohDap2qbudT6AsdOgoZJb6J/CeZM6GLUsXoX1jfm4C4Zr5rXCQoipdt+d4wX7ST5/H0MdEdnESj4qSFmnNFlSECNYuf47VJq4EWvi3hnQMWaBPLvsVPeUkXh5/MVObyxZH2q7P/8zZrymvDGTwLhuW20GgZvAJ5Fam6q3MCrdE31Vm+I1POiA/OXh0xg/wCjmW3Vq2nI6sQZLMQDaAEyW4Jn3oKirz4tBwyNs33dz+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcH9v6Ww3NgkhwdANf0QhPk5rTB/fdTp1nBrmv6170E=;
 b=a3G0Ti3FRIuvBuxQ9pT1KQRzBVDJOvi0q0u7nbpEuVbwNJGNC08FPkK6VXZYwiKaQj6AV0F7oO+H04WnmNjS3bfRsyoqpn23fdF9Kv4fXnDOUqrkcVyzvT8x4K3ZePWvkTMBMElJhDsyHaIBgQxyugHMd+jvms2+vi8sTFRLUWanyNwq0V/4S129iubYKNS3mBPb/JShc3LQXFCpzil3JmkMzKwtbWLdt68oi3HpNRIs5VMc2qPbJNv+kz1FfjsPeDothb6jpasdq0ykLMSyRae52Yx+nCihnytbFVMcEmTH5Gfm91/TE1PJ0UzAB49OMse928oLV3hZc/EUozTdHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcH9v6Ww3NgkhwdANf0QhPk5rTB/fdTp1nBrmv6170E=;
 b=J1rOJ07C4hL2z0Gkr9gDJWi0vHIHsGqLZW8dSvzjLcKbiivMfYXIJMe1QrDo2gm5Jj+QtCZInerdY7lPIOz+9UdLXdUx/LXZvYK5wE81DvWq3lYo+i4UNOJ/MAiUdL1ZMPIdVpxra6hsiEIHluRNq2MI3Qx9tWOpnfN1HgT0LLQ=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS7PR10MB7277.namprd10.prod.outlook.com (2603:10b6:8:d8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.26; Thu, 22 Feb 2024 15:07:05 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 15:07:05 +0000
Date: Thu, 22 Feb 2024 10:07:03 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, lstoakes@gmail.com,
        surenb@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmap: convert all mas except mas_detach to vma
 iterator
Message-ID: <20240222150703.u55kpmdlog5hrld3@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Yajun Deng <yajun.deng@linux.dev>, akpm@linux-foundation.org,
	vbabka@suse.cz, lstoakes@gmail.com, surenb@google.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240218023155.2684469-1-yajun.deng@linux.dev>
 <9f76ce23-67b1-ccbe-a722-1db0e8f0a408@linux.dev>
 <20240220180603.dhnthx2nk5455opm@revolver>
 <0ff93990-b8b6-89ce-0174-4023599059e7@linux.dev>
 <20240221143103.bkhewpq2wirsoyqw@revolver>
 <d9b4624a-214d-2f49-3883-4d62f60a9de4@linux.dev>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d9b4624a-214d-2f49-3883-4d62f60a9de4@linux.dev>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0037.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::19) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS7PR10MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: be4017f8-be58-43d4-c2be-08dc33b7ee38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	b4jOsbd0luOyqJUOlA+XqtR+0eExTGaI9/a4LtkYLG46hBbvMX8zCu6JWTdgnsSJMEp4tEZNMLPuPjgLW1egbhZ9YudBexgRy3jYtlPqALI8U+nUo89+qjD5cKJbMyF611l9vFKKpTOntCZ4hZ12YdfybgrSNw6ReQJBE5olYlP5UFVSuru9ej/Gi30stBNbxTO9GyLL5lV7nIo5UvL/qBf5cdq1+4VyuGcjSYosYVr1l94rJOI81+Vo/sv+wVZJk83copHTJXsvZygv+S4M7gx1NSClDMqhZEuCYC6kPGcbGyyckzCQDtSJBDalhEKgp5+E1bVAgRP3WrbAjJmCbWMWc88rQPhUZXxy+F9mBZH6391BKLhqh4/StUkb6EL5lW/31KZ9ZLqLHEKK2/kvHr1yCHFndhuWtrKM7w/+15L/g7wzfhPbFDWJoCPlNRQ3amN0q5vioDe2k9V5IWEZD30nIv+1p94sctAYwsKPYzHo1Zi8wNre5i6MRl4O7HWo7USXPBm5tl53G66iRBp+GxzQgFlIoxcGWgHm+/fodqA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?iso-8859-1?Q?KaEvAmFdWe7OET9zq47pVfh1Ca7mU2loTCv9ZK00xtvLXqbcEqCMPFQKmH?=
 =?iso-8859-1?Q?7slvj1jmeMo39VWGM5YkUyyPGJDJTZu3S3YbbT7v5dBgxz/dLIXAcSdE8F?=
 =?iso-8859-1?Q?bRniKEIIRE1Af8Uvh0/qNRneq03wVvPMSANEwR5P7BnFpLlf+G90mWwbdT?=
 =?iso-8859-1?Q?O1N/zdi6eOtoGfm2+ZAk+arH+IYyFZ43btLziNy21vdpcymjrPMzuACEuE?=
 =?iso-8859-1?Q?BqMA/p5LJ1jf6QBfjZM7ubTPuGUwERc60gOlYE5XuOk7imKjukfABVQe7u?=
 =?iso-8859-1?Q?ZRY4lhfQGSMb1Cr2zoTAao/I4wHSl1o4v3Ae8PBOYkII1cmh+5plOvtwGr?=
 =?iso-8859-1?Q?mIbsNuIRyDhznPbDlRVnHmrDaZ76MuJbZRG8BSpjXE+g/HOs499cmApcAy?=
 =?iso-8859-1?Q?o0h7LD+u9nreu1v9H3nHwF0+21Dutpun9gTSDyhM+jEU4g3NAX6n8kz6PY?=
 =?iso-8859-1?Q?rBthWXCoopR+/qwx8aLjePBZi6bULu8x3lz6VIau+lzckw/YPHPXq9hW5e?=
 =?iso-8859-1?Q?Ol2O9ArK1tg/SMY8qjjZugLXbf54ohvP9UK/eaMd8MVPjT/Rp8vkFmUOze?=
 =?iso-8859-1?Q?GKw0uM+BMDDqsJDEgT8ZKUFT5JCEt1YfzA1/YAMB7KYcShm/UXg4PTvZpv?=
 =?iso-8859-1?Q?HJPHSouI5WYYKqww+cmcW+/FKqfVmhDvgsffJZfNaeOIN+6Dhrwd/lFfFO?=
 =?iso-8859-1?Q?wIKV9vbBsYmLi1PbGyOzC8uLDgH+0ZxcTAmLxPuzbLeoHsHRn8APYIQVrP?=
 =?iso-8859-1?Q?QQeu97HD551Rw6Y21IW9u5U1pdOgg4hCPGiImP04qaFDC7GcbnOzJLvv4w?=
 =?iso-8859-1?Q?bOyw+t57OuIwkA9J39NrlW3ay84bIUdmlQ/AsgutGTIeeeKQUXvVvyHa+8?=
 =?iso-8859-1?Q?ddutmg05WROvU3KEXS7btYAWx1dGf29BiwjbkG/WVZF4sFABpEcZeZ7hRw?=
 =?iso-8859-1?Q?OzXOJuaTCoGIeZmo2C4m/YK483rqx0vGr+yL1/CzLZeFqCJGKN97Mp5pFP?=
 =?iso-8859-1?Q?zBs4/BxyfTWVgTgoRiy0SzjuMewa/PRlt9BRnDNAUJbJwhwGfjmJ4EpZiX?=
 =?iso-8859-1?Q?EPXRwB9xe469SzwI9Z7GN4fbrO5FnT5mcgvO93VrpB2iyql3ZWTTeqlSqu?=
 =?iso-8859-1?Q?kMvAv6f0FwsIqpCEzhP9lJSBTlG0uv7Tksp7v1EhO0nA7+2P5UpHDMdRHJ?=
 =?iso-8859-1?Q?8XrnhehsMQscPNIh8wOAcp03AVQfx297+dtop2UABD3U127x45HYXR/Jx9?=
 =?iso-8859-1?Q?twhA6UFXAZ1sQb9VYVBVm7SDx+mtMqONc8HFjilrdOuibVYwZBm0nWerFV?=
 =?iso-8859-1?Q?yxTX3Q+idHyxEDjUBNtriucddPzXFYRn2/TEWZ1Miw9CFkYZwdxtUB3q2/?=
 =?iso-8859-1?Q?Rypo/ywgnaZ3CKZw+92uPEc8aCMAPlNY4OjfkonYkZMPtMPVGH0EHbnDMg?=
 =?iso-8859-1?Q?QbAC8qa+evtK5Ekek9ejZWABOUMdquOcrLKzm3zXkjFK3Kinr6aQA8XQQb?=
 =?iso-8859-1?Q?Jk0xJ9QzALUcj8TtDAAn3Rk+kqzSvIyhf10oXJfN7kMELUCrLJg/eMo8eZ?=
 =?iso-8859-1?Q?FyJmUMw9NS1bbgFkiEurslu+jcAJe5dceYb+Ego9FajW7Lcj7zxRXJ1wOo?=
 =?iso-8859-1?Q?aOV8R69XdAcIoto4HqVjFMll/Klc0tl9hJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GtnrhgxiXE4GaE0TU+IZyFk5d2pMmgJmWzgcq6g56VZ73ZSkQLw5csrCT+71gtQoAKxEYm8dfDcaeZ252YDES/tlYPeXuanUdoMm0QW0qVPLkKiytR3NP3WTOJ21PFgvKsdoZX6W9s0PJUZzwBTCWfBOevzbeMikP48d/B303U+NF81OMaa9QzWY0aVTjdCNu19Df00PzSbRX6uzDQOYvekoINrIbdqN6zHjkyRNWp5HJbyLKVQj8Lu1Mh+ZeJI7O30jtwkh7zIQbVcCKodZ0P2/OzQqZ7XYUXFAapPGeZZAil/B2uStCF1X0i7XN2DhrLb1Ka+AvXKy1Wrwyi2ptjqXbBZ/fYh9F50B19Q2cZoOvpYtN6JjrP/mBWg65TRCduP5avHh2HBoUqGkbw25BSXpXJZpbOJ27DmOE4WEPYa6+d52N6UmCPW9A5pRSqg/6mS+u8BQrjlBzi2tRkQhBTJ5FxYH0MoOS2aiLqNHt1kSeWsNjHl4uV+L2IIhCDMKb9BneXiyqoE2iMSOVDa6T9Edyz+/x8W8mE8B6kthmosSG+zS+IMBh5oGscBPcvplaOfUEdyUeg3X7S2ovX6XXXlL0KUhp77k5V3TwPsaezE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be4017f8-be58-43d4-c2be-08dc33b7ee38
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 15:07:04.9938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LiPzRaAYyjxaAJFpjvSPvjhEhb00X7HpTPgo4rBkiGCt2zAtLlEEXGfPMK7NY1A4zJwFtZ/swkkQsuc4sqFmPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7277
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_11,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220120
X-Proofpoint-GUID: veZ0LG3zZLTkT18JZWyvnvEXUNMx3zNp
X-Proofpoint-ORIG-GUID: veZ0LG3zZLTkT18JZWyvnvEXUNMx3zNp

* Yajun Deng <yajun.deng@linux.dev> [240222 03:56]:
..

> > > > > > @@ -1959,11 +1958,12 @@ static int expand_upwards(struct vm_are=
a_struct *vma, unsigned long address)
> > > > > >     	struct vm_area_struct *next;
> > > > > >     	unsigned long gap_addr;
> > > > > >     	int error =3D 0;
> > > > > > -	MA_STATE(mas, &mm->mm_mt, vma->vm_start, address);
> > > > > > +	VMA_ITERATOR(vmi, mm, 0);
> > > > > >     	if (!(vma->vm_flags & VM_GROWSUP))
> > > > > >     		return -EFAULT;
> > > > > > +	vma_iter_config(&vmi, vma->vm_start, address);
> > > > This is confusing.  I think you are doing this so that the vma iter=
ator
> > > > is set up the same as the maple state, and not what is logically
> > > > necessary?
> > >=20
> > > Yes, VMA_ITERATOR can only pass one address.
> > >=20
> > > > > >     	/* Guard against exceeding limits of the address space. */
> > > > > >     	address &=3D PAGE_MASK;
> > > > > >     	if (address >=3D (TASK_SIZE & PAGE_MASK))
> > > > > > @@ -1985,15 +1985,15 @@ static int expand_upwards(struct vm_are=
a_struct *vma, unsigned long address)
> > > > > >     	}
> > > > > >     	if (next)
> > > > > > -		mas_prev_range(&mas, address);
> > > > > > +		mas_prev_range(&vmi.mas, address);
> > > > This isn't really hiding the maple state.
> > >=20
> > > Okay,=A0 I will create a new helper function for this in the mm/inter=
nal.h.
> > >=20
> > > >=20
> > > > > > -	__mas_set_range(&mas, vma->vm_start, address - 1);
> > > > > > -	if (mas_preallocate(&mas, vma, GFP_KERNEL))
> > > > > > +	vma_iter_config(&vmi, vma->vm_start, address);
> > > > The above maple state changes is to get the maple state to point to=
 the
> > > > correct area for the preallocation call below.  This seems unnecess=
ary
> > > > to me.
> > > >=20
> > > > We really should just set it up correctly.  Unfortunately, with the=
 VMA
> > > > iterator, that's not really possible on initialization.
> > > >=20
> > > > What we can do is use the vma->vm_start for the initialization, the=
n use
> > > > vma_iter_config() here.  That will not reset any state - but that's=
 fine
> > > > because the preallocation is the first call that actually uses it
> > > > anyways.
> > > >=20
> > > > So we can initialize with vma->vm_start, don't call vma_iter_config
> > > > until here, and also drop the if (next) part.
> > > >=20
> > > > This is possible here because it's not optimised like the
> > > > expand_upwards() case, which uses the state to check prev and avoid=
s an
> > > > extra walk.
> > > >=20
> > > > Please make sure to test with the ltp tests on the stack combining,=
 etc
> > > > on a platform that expands down.
>=20
>=20
> It seems something wrong about this description. This change is in
> expand_upwards(), but not in
>=20
> expand_downwards(). So we should test it on a platform that expands up.

Oh, yes.  Test on the platform that expands upwards would be best.
Sorry about the mix up.

>And
> drop the if (next) part
>=20
> is unnecessary. Did I get that right?

Yes, I think the if (next) part is unnecessary because the maple
state/vma iterator has not actually moved - we use
find_vma_intersection() to locate next and not the iterator.  This is
different than what we do in the expand_downwards.

Note that, in the even that we reach the limit and cannot return a
usable address, these functions will call the counterpart and search in
the opposite direction.

>=20
> > >=20
> > > Okay, I will test it.
> > Testing this can be tricky.  Thanks for looking at it.
> >=20
..


Thanks,
Liam


