Return-Path: <linux-kernel+bounces-138067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF1C89EBB5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BF691C210C1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFE713CF84;
	Wed, 10 Apr 2024 07:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="glE+bTZG"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2109.outbound.protection.outlook.com [40.92.15.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BC23A8CE;
	Wed, 10 Apr 2024 07:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.15.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712733581; cv=fail; b=Cdf8Ghn73oKTcaMfi1EJOv9IK5EN6e8IS1obw9EkWmL15go14qYNxKjbGtTBkaynjzyGLYnX9BafhRqZpp0Ela/a9L0qupYMLHRlt7eaMJhpptrT6RNCWpRJ5cOoC3TUkmreXOYb/z4nfIf+05cPJaiMyRU7cyHm8B1xtyHd5PU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712733581; c=relaxed/simple;
	bh=QxJV+JNxElX/k015LEfWmZRWkgQyjkgln8vdo38ti00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BOocEAKQhNldQ8EYQ4aU3glo6zV/lbC14Hjftc6PaoUphUulyPbiMTbGM5RklM0iExea3taiux9v6arFdRI7TWeYpnZJLncaNxvq33PKNYsOkpGqG+iJzIjFVrTCwkm/FrKOGUVkUwoMUOIaFhEgYj1m6Xl8nA9ad1FAKbEOr1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=glE+bTZG; arc=fail smtp.client-ip=40.92.15.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YD68bC96R5zI1e05jD6GrCQcnskajNg4FTMYYvsAIoqoZnSR1kRajuTSCrwSbQGVlENYwzlde+D9zPKtfU4UYOmAfkpZhnQ8nYqaEY2HwnIRWw18xFvUOKMx+bofG5Eqm9nptBy9sLZ+aYIga+6FPyVLQYNGLxPMRZN7tbsdzCYgabrjvjb2NQQ4+mhxelSHD9cXweacbmd1hKLehvXR4B+vR6bR5cfMAnFiwWrczdT5qGWV2hOqe1A1rNLpgvQEuRj9PUUzvLMM0NQwfLHWmAbqF2V2odgFCvpv0bCxKoyWjzK0kTXwjhUcs6SD5j1j2/EkEWxjAag+KOw/PvppdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tmIxntKVyXCWEUQbUFIm86AGlOufizjEKeBCDyGFew=;
 b=GKb6AyS+kO2yRrBY2s00c9DCszjQnYO/yDOmT56uQovlg07PzdE/UYT05xpxWyoEx6GMAwdC2w/ZRPLXYB/fELLbBJsiyW3pbeLwbwktswKbvKwE2KJTcIiCGJ/IQmrhmak/LzAXVgNUySAEWhYJ/INnlNjb781Jd2ppgUOq3OeiPeL1XvCCx82pmBmDTNLer7uO+/x8c9vdAfGpUcSGQDplZEoAV8L8aK8H1lUQOBkVgMSXRfCW7u5rzC0jYnMJTRavxi62RImzdcoPGMRg/grcSNz6J1cHRmmgQBGMOWYBKBNMv+0D1IszdmE1qvg4IgXpeFC+ERV0XS6WZlabJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tmIxntKVyXCWEUQbUFIm86AGlOufizjEKeBCDyGFew=;
 b=glE+bTZGT4iiJk7PWhpVEPJbv6R3C5jm1F4W+Xu55T+EGJhDJZWwbJFoastYcPBlo7mfA4tzZghbyHLtjhUraymqC3NfnluVAqYFSp/BBM1jCasJRHnJn/ejimcfva7AuXKzR9Gr9N5kVDJWf5L8/hVfuTF6Q7UwfucPu5mNT8h0lyxOBzvmIWWe2jjR7/o0dtoBQKSIZ8/OEsvuGMw9pGU+s4A/wtsjDWAR8pzqQEGtJQGGV5d3MxYccjdd3sf2N4z/hgNf5RojIg1tHQofUfluY+6eNdELQibeS1+FkMeGySuxsW193kMZKy1VAFPlDDF/44GVx0yB2i/7420guQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DS7PR20MB4623.namprd20.prod.outlook.com (2603:10b6:8:76::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.54; Wed, 10 Apr 2024 07:19:37 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 07:19:37 +0000
Date: Wed, 10 Apr 2024 15:19:55 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: michael.opdenacker@bootlin.com, Conor Dooley <conor@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Chao Wei <chao.wei@sophgo.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: riscv: add Milk-V Duo S board
 compatibles
Message-ID:
 <IA1PR20MB49532EC9B654B5B1C2538851BB062@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20240410062254.2955647-1-michael.opdenacker@bootlin.com>
 <20240410062254.2955647-2-michael.opdenacker@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410062254.2955647-2-michael.opdenacker@bootlin.com>
X-TMN: [PGeBsyDnOtRbTZl/RHP+21QeL6BiGobyqv/jQnLdXSE=]
X-ClientProxiedBy: TYCP286CA0080.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::10) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <auacphm6yb5vt52xuvaj3mo4o5eh772nalkmsyl2mcrzyuzhjk@22ge5uxa6p25>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DS7PR20MB4623:EE_
X-MS-Office365-Filtering-Correlation-Id: 32e3da83-b68d-410c-8b03-08dc592e9454
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	smlfF9c8mXQAwbrB/AY2skm5KBIy7Gx/4jpi4pfDC11vzGI4f9QIVwQmaRwgl342mjcjEs/S7mBYrwVuGo5wUVUHd8NDyE3b0YcIBUuYq8H3wVEKT7oAO6rQZCrWXanZ5jY2g1/yYOIB8yphobEGtPjNTPwCkpiUDlXEaiekjA03n+5AQ+GTck8/2q3k5tw+1pLl5Szpx/A67kYwOhXmgyoCFlysLzGo0BO8mQuhH//vPnYoziFhfJbgvUCIlBCuipxhPg47fV5j5yN6BQrdeWTUATiKaR16FhlpQRQlopm76hpLoLtH7DC7pvqaY5ValyGvKBMCURCilaF4Q7s7l0XBnoefXywgLhohfE9x6xw44Rj215nr54R/xh4zrsF+DF8GFEkrpkAmaDlJZ8+FOjbuGk969aE7pzYewDaDfUvBCHRkUFB8pWZg8SI4H4fdWNV2cajBMwoGoXf4MVmmvmC3oTTkUPBbAMRXTPyr4GRF3Ad68UnXWPWQsws5qTsn3z3+bavr7zPJ9YP8uHtRGbHffAcMByduZ9khUVXupydI+7mq5mv/nWvNqV5F+9twOOnb68upL65Ad67OxEiYKTFQddPEGFmq+c1aQ7oWR/1rE67avueTi9w5ljEQ8ju9H/9wyFMaf+UR7v4TrlVmdc9nIRq1r72LjvnNp+6NqX8FQzuilNbAlHv2p11dpu9t
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7nBBh6DobxSHry1H8iG0De6LfXMaAOek1ISneIkkf4dFf8JU2XJ8ztxOnWWC?=
 =?us-ascii?Q?hp9QWB8t08Kwr1rLABCkMF2WpE9sn1NcwJIZMCZT7mwq4Jne13qYZ4mL5PoO?=
 =?us-ascii?Q?IYQBVldqPoxJ+yXalt36FKFJhnfekplwEqmEocbLab8bughSwfSyXOacFWoe?=
 =?us-ascii?Q?teBaeF3EfjUbp3pWyMkZymiTJ93/RlkNLEWuqfXhUqXvVsAEdgrSPIcw9TXH?=
 =?us-ascii?Q?cQ/GPySnFYL5paRkWwDp7ESxBodDt3jsGXx5i2zX1En6rR43nAieONA73LS1?=
 =?us-ascii?Q?JajYWrxUuAXEx0LkEYuB90HYKmKO+0b9KLW/ZjbBfEzZgfSeCOCVTJQTg9a7?=
 =?us-ascii?Q?iwcs/S2ZN/wxfh2zwAs/NvI/bw7sOEuFt151rCCYO/fj/x9AxWQLMEf2jNsL?=
 =?us-ascii?Q?thJ1yDCco7SQhMCKXtbetQMVedxVltRuH9yxiV48mc02D6sVtiL0UpdIXeIi?=
 =?us-ascii?Q?Txyd+cU1sD6Ky16OtIOhgz5olRpNOz1nBTSv0YAuCqHZpIZX8VVSavK1w+JT?=
 =?us-ascii?Q?VTZafBGqB9zNsY/WVPGg8frtw7GHyynFkh+ncVPi6/JIuCDb520eWRaIJkww?=
 =?us-ascii?Q?UsJBuGiefwldq3W/tvp3gOK51P4ZLnFaftuaCkfvU09bj+TSE5gOu/Tyh3gB?=
 =?us-ascii?Q?aUS1EWGT9Sl9OW5XyGkfmc+dhON+1o3H/6kHlAsO4t3EIf11ajjCoce1Iysx?=
 =?us-ascii?Q?O8thA/V0T7zo8It0vB/9C/KPSwV2w4wNb881X/7yMz5hK6nV7+xKRfmvjk6F?=
 =?us-ascii?Q?8A+lXAFUpZ3pQ9q1gWnWb0pOyEpOh21L8xUyjh2L+uBwCVvOXb4o8Wn2HNrT?=
 =?us-ascii?Q?SgbGDWGk+futD74kGOnR4eos9IlZO84VJDuU150TVPJXWUNyw2vTysTvBYra?=
 =?us-ascii?Q?vkQFVD4z1I7fICGl5iZyDak8IoMoQ0vpGKKGu7S/Fzn3hcfC8BXKvPVPsj7L?=
 =?us-ascii?Q?m7w5utsi3enBvh2V0iMtTUH7RDXtWk6MY3XrJwWRwh1HkwlQ0YWtRwVcV2YO?=
 =?us-ascii?Q?6MYHyuvMq3+uCkjvm/2S3ng+Kp9NLWgOUKqjG5n9wBEGudQIsv32CibdXoml?=
 =?us-ascii?Q?eZIG6SAn6CLQSlDGtIO/1adWmz4sA7/yZEP+fUes4+pvzP1gCXOFqM0Xq+OF?=
 =?us-ascii?Q?JXsN/JkrjtBphjWJ4dOHNXVO9JIjYDdemPKhhLU+chUWMHuaAAkZkYGirEKt?=
 =?us-ascii?Q?lVOSd5SFFmWGRsAZnbndKRsfr4lKK4BAUZuhS3wa3zRjBIaDUQbOB4bpAUBA?=
 =?us-ascii?Q?3unfAb54iBdEtRJDKqxr?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e3da83-b68d-410c-8b03-08dc592e9454
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 07:19:37.4790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR20MB4623

On Wed, Apr 10, 2024 at 08:22:53AM +0200, michael.opdenacker@bootlin.com wrote:
> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
> 
> Document the compatible strings for the Milk-V Duo S board[1] which uses
> the SOPHGO SG2000 SoC, compatible with the SOPHGO CV1800B SoC[2].
> 
> Link: https://milkv.io/duo-s [1]
> Link: https://en.sophgo.com/product/introduce/cv180xB.html [2]
> 
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> ---
>  Documentation/devicetree/bindings/riscv/sophgo.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/sophgo.yaml b/Documentation/devicetree/bindings/riscv/sophgo.yaml
> index 9bc813dad098..1837bc550056 100644
> --- a/Documentation/devicetree/bindings/riscv/sophgo.yaml
> +++ b/Documentation/devicetree/bindings/riscv/sophgo.yaml
> @@ -21,6 +21,7 @@ properties:
>        - items:
>            - enum:
>                - milkv,duo
> +              - milkv,duos
>            - const: sophgo,cv1800b

Why not adding sg2000 property? They are different series.
IIRC, it at least a cv1813h not cv1800b. I suggest checking 
the vendor SDK to get the right board compatibles.

>        - items:
>            - enum:
> -- 
> 2.34.1
> 

