Return-Path: <linux-kernel+bounces-78107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5292E860F01
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF9F8286ADC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81B65CDCA;
	Fri, 23 Feb 2024 10:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="FUjhw4VW"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2067.outbound.protection.outlook.com [40.92.19.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1EC5CDC8
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708683395; cv=fail; b=MSH1fOiQPinfIlT+pddlBJHqO1IS8OR9bbLz289mxfBxmzV24P+HaewgiUIqbTeMGu/NEaTOaaBjO+ifRFYkZNtec8LeZiS2aS2vbqM2P0MT2rnHbzXlAgs0hvq+OTLvYRksgiOglZ+pDtEfc/0tiyJnQ4AQkKoj35hJholcQTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708683395; c=relaxed/simple;
	bh=LOGOduzQS813CtR8IGRefQHeK2pRIbwvgVgTh9p9aMM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WAse4yJiZu3bnatHfzleRolNxPwkgG1qhc/5U1T31aCZanbgpN/1VHidG5tpTLPwf6Sbsu+OWJUfjhlLhD4NuLAN3JhH+NpEFtowzWThMTItnHrFbFMeYS1IARJq/tTOMYQY+7BB1SfD8oskXe0woAGtgsJSpnx1ghiKmkgoyM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=FUjhw4VW; arc=fail smtp.client-ip=40.92.19.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjDBkq/fEAiw84Ma4ZGHIBRCROPzZ6P6YxreLjtcF7rJk2evdXYML3owBJkRpCupmXoLPIVgXdzlsl2Z8qdK4wrUxMYc4mh6K7hreR4jVOO47tAhwys9e8ck+cUf3TpcIzQe54x12zugsDX8w0AIhEWcSin/2ALwdSkviNDx1b8mpK0MNVDQXcgYBhzUixzo67zlhLF5Xr37xhsvueIQp261rZv12dYNtyerA42UGR1LkPQjJM1MOdw148ZJHV+GeR0cqSaMsu+AjLGKE8WXYU1yO0YhMpaLmMjFEE2RlNjltOaIRzUgVUqOg6jmP2d4aVK7dUKMkDuUFdNRqyF8Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkTsJe/DFyZ8pw5ypT/bm5vuGg9mWmGOlvzrF0YRc9w=;
 b=WJ/Cl8/AJS0QfXg39drKE2zC2OWeVG6XdAttvhvFLV6gASkZOR+LS2/gEVcjsGZUBAXY1/woKZCbIx5umUvYePFbFW/TRJHyWvYjgJPr7I7slR+KXSvHD325MqbapFK34w0yKfmGsEWdL1UOfJFE+abhoOFwnmel6BO0L83FBsq6r2gOc4bebvOmZqj6+ZUo1+FWI1zIh2sC7UYsznZF+lPgFpr/divFDlJXhMTEYOoxKoqzxFLqru3/0GKMDUQSfYNu44RkNflViZRbct9Vpmo5C89MmMzib0+M6VLAWW1lM5QeQ7ui7LUPfFmgEzXI8XycJY2BQfpo3gBUcO46NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkTsJe/DFyZ8pw5ypT/bm5vuGg9mWmGOlvzrF0YRc9w=;
 b=FUjhw4VWHQqxtSbwyYlLbFM1X8Gd3TyL7/gDLh0rR1SvjwkTogk3r1FvQxK7Wo/wgWwGaFBcAZCZ0WTPuG6+Y2DpK1NpHD6eq5+APqlMkYp8BhruJQls5b+DmfeoC5voeBnvl7Yw0P+Pa5heWfiSg4+33riWEQPpU6aG+YV48MQqk07BpHXKvvsdcbawnchArYxiQvoZt2K2uWKWRXL3DsFa+dYGhDOmUIzvg5qUUv5Cpp5h9mofQO4IxbtmoSuoR2nohVmXlM1/I1n5jnWim98gYBDlCpTfTrUfuunt3Hg/atR106OD8tBNAMRmTOm7jAD3eaYZA5+Bi/Y6mI7YuQ==
Received: from CY8PR11MB7779.namprd11.prod.outlook.com (2603:10b6:930:77::22)
 by SA3PR11MB7654.namprd11.prod.outlook.com (2603:10b6:806:305::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.37; Fri, 23 Feb
 2024 10:16:30 +0000
Received: from CY8PR11MB7779.namprd11.prod.outlook.com
 ([fe80::3ca3:fb4f:d0d4:974]) by CY8PR11MB7779.namprd11.prod.outlook.com
 ([fe80::3ca3:fb4f:d0d4:974%5]) with mapi id 15.20.7339.009; Fri, 23 Feb 2024
 10:16:30 +0000
From: Kunwu Chan <kunwu.chan@hotmail.com>
To: axboe@kernel.dk,
	paul@paul-moore.com,
	elena.reshetova@intel.com,
	chentao@kylinos.cn
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] cred: Use KMEM_CACHE instead of kmem_cache_create
Date: Fri, 23 Feb 2024 18:16:12 +0800
Message-ID:
 <CY8PR11MB77794B8F64015E2D2D606CE097552@CY8PR11MB7779.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [KDG57K2J7KMwBiJKQOE/X5E2z1lEbaMJGq53oTN9fLI=]
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To CY8PR11MB7779.namprd11.prod.outlook.com
 (2603:10b6:930:77::22)
X-Microsoft-Original-Message-ID:
 <20240223101612.446013-1-kunwu.chan@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7779:EE_|SA3PR11MB7654:EE_
X-MS-Office365-Filtering-Correlation-Id: 269fa482-8e3c-4bec-feb1-08dc3458807e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VxTfTYPq9q5dsRX6C9DIADxtTVlhYNabL+rNPIJ8oniS62bOAeetEZg+HsskpKnqUW6FFOpJ/lVLKKxSdk+w9Yoj2/Us9PisMyD/cOQsmOvVjIfcR4b9PrhUkfA6Q5V6D9g4isu/qaAWXoi9S47yYTeIWXIyE8PJl7lWTp9OsxEeNZtxGKXHIvmSn9+kAmkrET3OwNWqm/C+QZBU0jwOxiWdipzK5lY34U+CiMu7x9AQGa8QtsvJsRVZ4m15g9mONsTJOIBczhncea3sGnzjGLU+iIdl6JhWYb1FgX4X9ILWPXdW81dwIhEa3x4hk6hawVbX9051fazin+0Z6sdMkIo1tMJrykJJiFuy7039hAjHRrH37XThM7c4W6+bHz+M4wMa/FQW0s4HazH4obhSgp5S3/l1LW5VmglloQk4X5F9D+NYYpcYbLP1pfTo30OeRzUIlec03ukL9HOTeUqS6+AzHVg/UZnTxtHsz1RHTHLlk84FkhQIFqrvmqMbpTmsQp3zlKdzYpCfwQqLeF+sjBGSSps94BOt4DzXbpAnL+ZdSDzbYVe11UtAJD9HA6L4
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YawfSTW+xDPPuHCGDks914I4M8Gxz+MIPkmQ66Q8Ds7hEfc+Cfu/LmI8/+Ve?=
 =?us-ascii?Q?tQFhzdoaglAgQMse01Q6k9BTCjfoeXyWEPbXRR9j55eJ6NsOH5hTQKvoZbge?=
 =?us-ascii?Q?Q3WeyprFWlD9S63+fDZyXekItee9rktHryvyh3n+eoe8JFKkuMEITFDdZhMc?=
 =?us-ascii?Q?atfPMaFwphxg85tH3U56umkRfluxJqmKcGc3nYD8mmd/w/jotWAsdt7XwQiC?=
 =?us-ascii?Q?FKsHb/5RyRqSzUyLSwm0xz07iLI04JJRlaznwR4EZ6MOy3/RK/agvqpWj4aV?=
 =?us-ascii?Q?SlcCVpi31OCU50MZP6sY5IXmu9osxW1T1o1UAHTUinAnvVSbIMGboLh8p2vK?=
 =?us-ascii?Q?ViyS7TUm3+YzWeSwa1qo4N9lasrw5oDFh8vQ6/JCaA1/gX0040QszFAERe9o?=
 =?us-ascii?Q?wb1bsr8B4YypHhPQ3k+l0qzqGQheqMpcKMZZuaqysNUfRYaFNwZkRPFXDWWv?=
 =?us-ascii?Q?F5GAG1rqPOAseFOWGl8FblishNq9Ld9/aXk2UxsdQW+zsOLUjlbNh8Jl2z4M?=
 =?us-ascii?Q?ozZqJK0RQPA7aJT24FAtaxobMsCAUjF0d/nzhT1Jr9y2bdQOOHc+EtxPAfU5?=
 =?us-ascii?Q?dulNpy0h5CAMmDz2QlWxv72kLwmosWXawWHZEMUshdSqkU9hLGNg6u7vQ/+Z?=
 =?us-ascii?Q?eKqnKpbiJQhxLVc6z6MlSRXQWR1mIMDB7dGWF1oMQeK3Qj2eGfATSKYLaFTx?=
 =?us-ascii?Q?J0czW/bV9bS8FnRBLCUrEUblJoEPrSyxoUsYMNTopXl7sD/WAs1s5PVrMYKm?=
 =?us-ascii?Q?ElVvXu7HgrGdsXi5HHVwlX3UR7xkHNTAT97mDqU0YsfhvN2dbbd6brRRsCxA?=
 =?us-ascii?Q?/orf2chmAnSE+H1eCuklsfOoVNV8tN4CFQ1leXGPSQJ1x3RmbXAvANLMHT84?=
 =?us-ascii?Q?wJNcv33DgQBhlWpDAQx8CEhWOwo367w/N+0MaN6tXn5D7H1FAtcEVuDQK/DC?=
 =?us-ascii?Q?kna/dYYlU6VJuXw9ddz0y4Fgf+kp9I2Thbdw6tWA8WkoXynqyu6+NP4/t2oc?=
 =?us-ascii?Q?1AT7r/xa9aQOU6dY/jhsoUxy8mj0uny63mhkG6pDUoRAzAxxkAoKAUcZpjAb?=
 =?us-ascii?Q?IVwUgLT+l2EueEKCE6nKgXOgvq+15sW0qP6UAu/EU+BpGEemLD6C0dSfZtNp?=
 =?us-ascii?Q?D/9rBDEzsTMAbExabVZyfcc2AC2w2xxdk8Ash9WVR+FUciKgxE3duT0eAOqH?=
 =?us-ascii?Q?GhnriRuhDziqK7SjijnTXoaIef9PQmY/svZOTfKuffFtUPnjnY/ZzLI9BIra?=
 =?us-ascii?Q?uwpjFwyQJMiDK3tmGRMW?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 269fa482-8e3c-4bec-feb1-08dc3458807e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 10:16:30.0812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7654

From: Kunwu Chan <chentao@kylinos.cn>

commit 0a31bd5f2bbb ("KMEM_CACHE(): simplify slab cache creation")
introduces a new macro.
Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
to simplify the creation of SLAB caches.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---

Notes:
    I'am Kunwu.Chan, the problem(https://lore.kernel.org/all/CAHC9VhTJXfPztz2W_V6sp41PJW8dzvZH0YdnRXd7tUZOF1Q09Q@mail.gmail.com/) may be caused by my email server.
    I change the email and send it to myself, the raw email seems ok.
    So i resend it.

 kernel/cred.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cred.c b/kernel/cred.c
index c033a201c808..02a96e9d9cfd 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -606,8 +606,8 @@ int set_cred_ucounts(struct cred *new)
 void __init cred_init(void)
 {
 	/* allocate a slab in which we can store credentials */
-	cred_jar = kmem_cache_create("cred_jar", sizeof(struct cred), 0,
-			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT, NULL);
+	cred_jar = KMEM_CACHE(cred,
+				SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
 }
 
 /**
-- 
2.39.2


