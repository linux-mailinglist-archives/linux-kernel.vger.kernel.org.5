Return-Path: <linux-kernel+bounces-161059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9758B4687
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 15:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 310DC280CC4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 13:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1214F8A2;
	Sat, 27 Apr 2024 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="r1Ti42JI"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2084.outbound.protection.outlook.com [40.92.89.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E6244377;
	Sat, 27 Apr 2024 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714225950; cv=fail; b=f53MGHGvMD+elhEXOaRMKze2mu2SOEt35G1X6Fhs0nEg3jpVj8TYPFtFwZLJ8xDuoeserGRxxJ6kXCEZicmyHQMAtnN4zXbwZpH73rrVGBL6LttWcwmGaEdqfjir6WASBB0AB50WYCy/mXG1dhrC3p6vbLHDV2q8LV1xxrllM5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714225950; c=relaxed/simple;
	bh=AD0Q0EFjh63Tm346UD3xQROme9sfAi3fOOCNcZM7k4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=goC89vw5ONDIFdXVHaxXI8h9qwwOh6bDRI/dfA0kBU9+8BOm4J20C11JLwtZSflnyMzD2g2bxsZbdVQsla2b5DQyGYz0bXMuF7hOgZZ7oWmpXb0adnxRK7cjFlJQgFtx7TbCgQYGwFWqpGhq1Ef7/Kb9aW1fMp8hnPgvqHbQgg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=r1Ti42JI; arc=fail smtp.client-ip=40.92.89.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6lAMRdaGWx93TvkCfwvI15Le4LU20/mfE9PISYolmeZC5hIq4y/ZYC8esfJ42rgUkHvHu+gLSinbKLzJQ7+nOuPrjED4SrneXciYNFnVtN79XsASZYur625KOCbcn3FbYDiu/XdZHlxWz2xGFjQhZK7eFcAaV+88if1GnFweM69zAd7Rx2Zql3MCXeRXozl85ZdlIBQlUhstw2ulMNqow18/VpS/8eBusPU0wvEqs09T/2mlQFlabqwl8T5BCjzCY0VX2b5AYYGeGA4ifO9PDLs4uqKNjoyQCBIKlAI3ku1hjhmUo/oeOUnvgk94lCJP/FFt3JdB6XECIj5qhrheA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUTTs2vEF6DR95KtLa8AIDXC4PlB7/XCmK4qwx6rjQ0=;
 b=oWEmV7Dg4/d+rzbDrU8gBBUIkeYIXh8C5ppiz6bTSogrnyXH1GcsRRn2p10Eq5ApsMXbb/7fomsVP1nE7eEPTn5XbMaI35V0qRtWQdtYDAlv0yhsCxMLF3sEcTOH/cH8jJfAxO9JFXSjNvaZNCpOLfhlFMy1f2IoBAQErWqPWUdTY+Lb8zt+QCcWUWglhrWdLlvQadkJPO18nGFpwf7gt9QNC5Bu42IHEa1rCvR5/jggxnR2gxRVFtX/ZIGZne2Qx2RhrF/575pN4DQQvhBszV3tmdwlaxe8zAACCCVmanD3sUp3MVymMCYO1iED3otziBtDyRgNaBfSP+eg+fHGIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUTTs2vEF6DR95KtLa8AIDXC4PlB7/XCmK4qwx6rjQ0=;
 b=r1Ti42JI8pj3c+1++R60nvq1Vh1mKQV1iKCByR7n/PqDeeFzU+G8gTaoWeWNCgIKmHm20qIsGMOWfM9dHgmwFiYjOWQX9NTMGdX1Eojv2kGmzx2C7a925a7yKKiEJ2HK4N1TECSKWXUW3UrlKl1aTuTuEIkma0kKoQHTnYoPq8I7dxlAjdYjJWwNe6BNRJzJR8zoREwvc16WiEmtsZT61/KIVz127GfIOf+FooRRugBe4SK0BMIoNAQYYS4IwYsgHRhlAmfsrEMBqyRSeMcOCStbNsKoh/E1Hm+MZFKyUsdTndfgVaRTNkxT8kaDd139/lFz2eNH/YcZqRuVfAxQpw==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by AM7PR02MB5784.eurprd02.prod.outlook.com (2603:10a6:20b:de::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31; Sat, 27 Apr
 2024 13:52:26 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7519.030; Sat, 27 Apr 2024
 13:52:26 +0000
Date: Sat, 27 Apr 2024 15:52:24 +0200
From: Erick Archer <erick.archer@outlook.com>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <keescook@chromium.org>
Cc: Erick Archer <erick.archer@outlook.com>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] scsi: csiostor: Use kcalloc() instead of kzalloc()
Message-ID:
 <AS8PR02MB723700E21C64258BFFD4CBDE8B152@AS8PR02MB7237.eurprd02.prod.outlook.com>
References: <AS8PR02MB7237BA2BBAA646DFDB21C63B8B392@AS8PR02MB7237.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB7237BA2BBAA646DFDB21C63B8B392@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-TMN: [PMoAlUzBUnr3yZAESm/SePWQzISMx7YF]
X-ClientProxiedBy: MA3P292CA0007.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2c::13) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID: <20240427135224.GB2476@titan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|AM7PR02MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: 35880fa2-f564-4e44-f91d-08dc66c145cc
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1602099003|1710799017;
X-Microsoft-Antispam-Message-Info:
	W4AG6SOMMs3M2NTu9SGbtLAVeJ8OEjgWhGytp3ShRL5oH9P4AWC6dHMviQ/iM23gwg5p6Yg/ItBylu3iMOs/uFWrkX8QOVg/gka6l+MO72CqgyW6sDjKvLm9jjj1ygbQZCXCl7eO01czA3NQVNzSRBLdPZQrUcz7GeKkcJwGo4l2WxT2Mb1w94l0/jAED2+gx/Yfd1KAFjnpC6wIjBFgEF0hZkAfSS0z3HZ6q/jV1dd2UYHttYfRKmyB8Mcge1JSSEVo3F63o7PvixduVuwBQ4/Bkat07ru4fgg13+1x5r6ImSf26vI5oFmUEprNQ7LLY3A3cOdCyE+uszdYg3d63WdzaPDY3qzDoVSlaHXnlB+sWju3ntJ+Me2lB6tSeAcxIwu0CsPX3yRnCT1/YfTKaW6mibr2m5Am4BCE5uZMdG/hSdUj4shmWm/aByeg6EXXkypk+PP3Qb9riqmj5zONx4HhePoCB0M3u/fX8TQqi2EWuLuBVm5j45otFdJ7t9kCwV7hnQDmLnU0TfY/Is1BxTB49R4c8PrciY4lANto3RfXC/R9AElYLkRpDAtACcAzWtEfSkMDKvQyj7hmjI+HsaNX8+zhoUx+1MwSjy+6E7KQ5Mb9ldvWmbWtAvZ8WaziF0KhmECyQ/kI6IzRK5kq26qy5d1nizwBTxIsQOemvdFtZfm9RWtHTc+vHNA36P9W
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pZ2iNSUgkp2hTz7u4Qna+fnsd6KIAy23nUmp6yh01ySbfz4EqqpHJpOlpPdf?=
 =?us-ascii?Q?T7a/fBGQkG+uWnVdTe5YsZ2L714QHohpcGTe56/6Nb1wRTGe5WBF1nCmB5OD?=
 =?us-ascii?Q?N+Ar0/cKR4PbPxDIS2vAVYEXACSKCw8C/i7drzhAaaDLqx939JfFm0bNT9Kb?=
 =?us-ascii?Q?fTE8KAL3bXVKHDF3N9gnXRkymGNL3PBJDOhox1mDvexbVIsZRXo3f+vHvIIV?=
 =?us-ascii?Q?SgPgV9FnR8eE9uvjjVHBSUw9Qz0Ty6gWxjbrQvk3aShJM4/pgotIhN38yMrH?=
 =?us-ascii?Q?g4pWmQm0FJAVBNX0MRaGNBIoIJ7mJVWh69H5eXDTxmz9me/xf469/k5+uFMW?=
 =?us-ascii?Q?yqqmqC7BluXfhW3fA6n6Gp+nWSh242hztrzK6qdjBlM6PFlu3ZmotLFWXztp?=
 =?us-ascii?Q?a2N8B7hTcTdvfJ6Hru4tdCvx7wPP11kCeIZVRGI5RIyFgibQpFAHlpmbLoE+?=
 =?us-ascii?Q?5TbgVda1y4AdCsP8CgEB/w5cektI7acCO1dEeiQf9YF/JvcphV7JPZ/hINWW?=
 =?us-ascii?Q?bFRhCNxPjJoJM/Nk/3x4mPxD4VLEui0RGDP+EUSs7v32xiNEErCHgKfRk8Is?=
 =?us-ascii?Q?XpFlIfCFDR/u4Ew9Im+4WWNL6ymcvSNrYRJRq/Fda4bgFAK407AuWzVv86S0?=
 =?us-ascii?Q?4WoCyZOM02Z1D754rTLXdIqTB6FEXFiYudeT28h+6tu1LH2A2knaw7nuHSYL?=
 =?us-ascii?Q?sm7tAbEsxSyYWDG7YFhRFFUuajxHBxo+dmfoFyaiPDt98gtSL/90eo0UW6LR?=
 =?us-ascii?Q?vcmwSM5zYL1kDQQbfSgJaUh6J9ewgbwr/2pIQrXjKSlLktDeuq/2j6SxQpev?=
 =?us-ascii?Q?DiX9CEni6+w+Bpwj+5CIexAXrQK3n0U6mZ0dnUfQGjy7XCz89WwgNtG/y6FA?=
 =?us-ascii?Q?AZSkf7EaHODFEK36cP2PG+k9cv07Rktu0pbfjl8lPIPVca24gINe1xwQ2tSo?=
 =?us-ascii?Q?RNFT1iSvAN73q/BQRzhsCQso1+5FtIrUdtPjR6TgeWMzNzc3OZCXwdtuanJb?=
 =?us-ascii?Q?pmWcM5EXGTNslgjL/FEjircaYFOeOO7V3AuuyGzB3egi8OOhDOk/9SlxMoMZ?=
 =?us-ascii?Q?++IeCz512BgpBZboBZsKyZbtzDUPtvK+UKknlzxkHk0ufG3nwKjL3vFK3OZJ?=
 =?us-ascii?Q?cVhKtp3wA1WqjMieTD6RcJNkctCrbbCVZUSkL+aL8GXYoDvPTIuEf8rBOElo?=
 =?us-ascii?Q?UljepjUrXh4fd5ZX+3Xwwo0kXokoIPFJ0CRUOp5wQv1q/PXnB0nFJ6twU3aI?=
 =?us-ascii?Q?R35IdAdTdvdxHt+kzM87?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35880fa2-f564-4e44-f91d-08dc66c145cc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2024 13:52:26.6740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB5784

On Sat, Mar 30, 2024 at 05:17:53PM +0100, Erick Archer wrote:
> Use 2-factor multiplication argument form kcalloc() instead
> of kzalloc().
> 
> Also, it is preferred to use sizeof(*pointer) instead of
> sizeof(type) due to the type of the variable can change and
> one needs not change the former (unlike the latter).
> 
> Link: https://github.com/KSPP/linux/issues/162
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Erick Archer <erick.archer@outlook.com>

Friendly ping. Any comments?

Regards,
Erick

