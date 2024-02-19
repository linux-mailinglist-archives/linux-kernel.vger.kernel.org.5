Return-Path: <linux-kernel+bounces-70806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5623A859C99
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 785BF1C21967
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA42208D9;
	Mon, 19 Feb 2024 07:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eckelmann.de header.i=@eckelmann.de header.b="TCdgYp3K"
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2133.outbound.protection.outlook.com [40.107.135.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B5620335;
	Mon, 19 Feb 2024 07:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.135.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708326665; cv=fail; b=QxbQZ7OvJtwY1BB/MncMBtAopf/yPG8ctePaor9fwqzkfC2lpFgvKI0dJc1aY6Adzn7rwzs9iGMRSxrzitm5/juA/4pp7L5ONNfRiA70dsLTbTfKh4jLQTFd7exAC8IA65UdF02QDB6iJqrbGH1KVOoonvD+LL2dWXPtVv8K1AY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708326665; c=relaxed/simple;
	bh=ziSAKrd6W9VWYgte/DJxt3DQc33RxSdjOFRVd6pFgEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DbtjKRgLRh3K5IsFaLfrC6+mH1fkYxr5Nb59H0Jl5Z0yfTu55jnJs0lNRX/S9hL937v3M+XXiMp1S55BjmUowhnqE3ipPtSP6suU5lEKGeESgbwqaZt5t63SZZyrXE6y+VAbLQ/8qBZrydWYa/ZXg1vjtxwudxXpQPrPM2RBidc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de; spf=pass smtp.mailfrom=eckelmann.de; dkim=pass (1024-bit key) header.d=eckelmann.de header.i=@eckelmann.de header.b=TCdgYp3K; arc=fail smtp.client-ip=40.107.135.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eckelmann.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TisPRHNzDCtGwi06uehxnUmL4NH6Pxl+bmZHykPCxy0rieGxpzwqQMXwOhBaU/HTwDOxSQWhzT67AatZomB6b+xV4s9GS+GqZ11GLUP5IXiu/XNa8kZMujoyKA3T+XjWkMQm0WcxTYYLc2dNYyXbN6fbb1sP/2s5CB9CvW3zSNPvBhYUIa67nZRm/Z4H6jQmIQARAY23fQFaMKwehossKombWHcSTj6avT31wHyKn3cthlbFW/Q2oKDRfRVVqVEjwZQQ/URlrTq5FaQLD36cYFex6RlYuvI1cndNplB0lSSks1M4EGovsg2MdKcymd3nfa7ja/oU1zzWvTZZErwWJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yM7/C4NfEQxkZIWy0MsZbbJlet6FwGMN72fJSqiPsik=;
 b=J8+O7NbiNVL+NQ2YdVAX4fV9C2Tr1qXNuZGMXrb9EDHXklJA21lDNHhpHcFLg6SX6fpClG2x16feV/kj0AMeuDCSiuT9W1kWpw911YFj7dAQW4fd6PUMqhzjC2MSqAEL9WtOfDz0JaEgiE0bOH0LZkMqdOXHUCT1BUOoG+XRnbuk1i3i3pEdXxVWRcDT1q6zexDrS20dPkSjSwOp6mzCs1m9CfL1hUZfoJlRnbTqhHOH3z34dBgAp5e3VfuWf28CLfsOa6WCRwYruZyhB2AwFhrLZnOB/zPtK8trQjacFunzSYRdSQpQK4MwPX9+nxueIDpWcALUYfgWBBlKN4PhxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eckelmann.de; dmarc=pass action=none header.from=eckelmann.de;
 dkim=pass header.d=eckelmann.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eckelmann.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yM7/C4NfEQxkZIWy0MsZbbJlet6FwGMN72fJSqiPsik=;
 b=TCdgYp3Ku8DxMQcin+cgENT2LfAwpy5MQLK73f5vjvpa3qBVBvowUgKJlTH6o79UYSyfKNbQqMuyHzGc41DDDV47oFTT7uP4XYLITejk9idN5ZKGJjO8cjKYeMCVeh3ifRkppaln/HD7SsJQ6y4rjhW7A3W+I/7Mm2rgpL428ZQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eckelmann.de;
Received: from FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:da::13)
 by FR2P281MB1853.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:3c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 07:11:01 +0000
Received: from FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 ([fe80::a175:dc81:cb6b:2dd8]) by FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 ([fe80::a175:dc81:cb6b:2dd8%5]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 07:11:01 +0000
Date: Mon, 19 Feb 2024 08:11:00 +0100
From: Thorsten Scherer <T.Scherer@eckelmann.de>
To: Raag Jadav <raag.jadav@intel.com>
Cc: u.kleine-koenig@pengutronix.de, jarkko.nikula@linux.intel.com, 
	mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, lakshmi.sowjanya.d@intel.com, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] pwm: dwc: drop redundant error check
Message-ID: <m57yqdldszy3s44p5rdxd6kwii5tqzqa44aaevpe7bep2yyeuo@wls3ad3gcl7y>
References: <20240219033835.11369-1-raag.jadav@intel.com>
 <20240219033835.11369-3-raag.jadav@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219033835.11369-3-raag.jadav@intel.com>
X-ClientProxiedBy: FR3P281CA0188.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::20) To FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:da::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR4P281MB3510:EE_|FR2P281MB1853:EE_
X-MS-Office365-Filtering-Correlation-Id: acd817f3-6742-4813-a63b-08dc3119ed95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y1ul2pH2vWoBJmfk0BRnSPDh6Hd4agtnBjEQ/JeVtQkuT+w6ZewlhZ3YcJMCkh3toGk1H64qLnvjsH0I6bcm7XZfhGUxnV7bsZFiUSbnVoaa5pXQxnmfBP8eEKI2FiZMiq3Pdxb+HRVJ3cQv+1c9hUw7pJTwUnuQBaQ2o5wboqjhBpQNMwviYbKbAR3rgk+WXVjJLjRZmxWmrQPNLImceUFhw8d72nfcHsOuLp6sAD8+qI1snnjxqvcgSWhRq5Lv5LrolRzXND6wQ2y6D7WgcbNkpL4krDb528AcSEq4nZXs9JP0LIcnRaHgIa2JPYsRPDuZ8DBbw+sjW7HY8Nml/T0r/g/cgfTbRn1u13cFiy4yT7J39rEJSd9NADMB3OAxMm9wtB9Rs8HFXZeYutDHin8UBhZ7jOTyj4BgWog0n+ryIxc4C0ti3w7VsX4k4a2syXm211ijtL1yzq4gSbavS9uHKU10dmDkEUYpxKHaLuzpilYCM5w33SUB1CAHPzS4B/1oo+BSAPeWJYA9MW9yAZPwoWD+N4QqOys8/dCGkwD4D1/ZJ/vQ1MAKmIbRxG/i
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39830400003)(376002)(396003)(346002)(136003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(83380400001)(86362001)(41300700001)(316002)(6506007)(6512007)(6486002)(9686003)(2906002)(5660300002)(478600001)(66556008)(66946007)(66476007)(8676002)(8936002)(6916009)(4326008)(38100700002)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fJmohRM+HEuhJ58/c/GoMHNgqV+Bqp1nNPfKx3bqet35zlJyW5DzhdVs8gGP?=
 =?us-ascii?Q?R4UpDcDH5Wkq37w3awHNegdlZHjwJx1hKJ3tuCxCnYelhtP8uN1FzrFN0PR3?=
 =?us-ascii?Q?U0E8tUroi8vkJ/x++Ku/zyTh682ErTa3orAMaA3zHaPE9rMy4YiTxkEmTwas?=
 =?us-ascii?Q?xSy4De53svJf8YG6TXPAi/2Cl45kXypnHXm8w5UpWOzjD/a/508i1hMw0uN6?=
 =?us-ascii?Q?AtfaV3121sy4BCaO1TLskZoVniLnPhDf+FHL3N9GDemtVF6QOQtTxLF99r2F?=
 =?us-ascii?Q?z4iU+L4da7IuWpj4bCUe+yfQuKZZSVYuxKn2vxwQWcxaG4NQZ6bKWqM5oLsh?=
 =?us-ascii?Q?Llx+9wpiY0ne1O3wTb6ydYRdXqcATYn7+94JpaKaG98kyk2f9RSarZVBucv+?=
 =?us-ascii?Q?KiouBYapwTdsX/2cr4pAIld/kT+be4oV/VH5bmaulprecnuiMcVzlaT0HswI?=
 =?us-ascii?Q?Ux4NmzlAPBYkDwVBCnEg+A8YUP33HcD+uTWLNZ8L7GCZWaGCHda1uYbNRNJT?=
 =?us-ascii?Q?+I6uqcGb0sy2KtUhGKnygRO7xDNMML3C2yrXamkAIzMMmPzD39ZB77UJuSLN?=
 =?us-ascii?Q?Ff++F6N9H6Sk44LsMDTU7voER6nV22r/4bRrSguSH3F0/5ZMGzwWZYlJQnbv?=
 =?us-ascii?Q?QYRzB6Uaee9ze2mRosHEQy7z2X4/ar+0ZFmPIG5Y6mfFxdcpgqBr7BnhFRDV?=
 =?us-ascii?Q?45m9xvBp4grhmNcGW3exRPxupLj8skkhAMQTCrUEOeHRGv2gpHhIWyPgweOM?=
 =?us-ascii?Q?YaQKC5iTyPEF4+Usm/xu0hB5LKvPzxhqpCdnBaWQoxDAcYQYCYKK9VQFxS9C?=
 =?us-ascii?Q?6INww/6y61hJqLafPOczZPwfvBneMElFJGE7BdNM7suu5ejh38pLT6oF1wEn?=
 =?us-ascii?Q?nVN+n2js3uWB8MAT6j8vybVbOb2/sZIppeXehQe4HrICbDpZh14p3vcThm9f?=
 =?us-ascii?Q?AsOh6LpqztvZ5yaDEbdtDXigYFNyQX58Mx/WtIaDB8FL/1s2VCxlDYzc8UVQ?=
 =?us-ascii?Q?mxH5TISFcEE82060rrFNNLn4x9JwMrdQDvqDEH1mbligJUfINylKtNQvEdgJ?=
 =?us-ascii?Q?8JJN5uofopuEJSxsjafoUsJCFqyjKewIVC6vsUdQBuv2NWYHAwv6vy++r97w?=
 =?us-ascii?Q?tY+x76Tw7TMXBwb2gziq3Om67BvDoMV9E/qJzeGHsAeIy3+ZoWa3aTXWmujl?=
 =?us-ascii?Q?kBZMmYtvioOydpTf9KpgtvBDFjdA082/ET/foihk3nCU4HhfTF+WeDao2Iuv?=
 =?us-ascii?Q?IJdVHbmDfoh2AriBPkRAgupyjuEgtxMTmeUc58Qd3RqjEFH361zTeYIzQKOT?=
 =?us-ascii?Q?esNR06EjSSnWBx83QHgS5E15zBLZHRF+WHgsvo9hrBWPmA63TTsShhHO5fJP?=
 =?us-ascii?Q?qyD+mqUA/HM7Ah2g0jiK0YZwXLMmhsSzzxiX4+euS/lv3rbeYfvckF0qcZEE?=
 =?us-ascii?Q?0eCsyXfdcF1DjgGRewnA10EMpeInTqy6CC0fnRrYPef9Zkc+pyiYq310bZto?=
 =?us-ascii?Q?LxIQGhXD5W9iWNGvBXc5JbAADeYM0WJiHcB0QUeMt9TOMzGYnEl8C4o5vK6P?=
 =?us-ascii?Q?WarUvTL5Ky2KChVxo1x/NEEjVnVaFig0Q0urYkTok5MFhK/wfSH5BfVk+49I?=
 =?us-ascii?Q?lfdwY54j1+Yh9EW87RCt0xcKyLcrYUmulHjGRCOCW1vagyvnQyInn/dmZXPX?=
 =?us-ascii?Q?Y6vZ3w=3D=3D?=
X-OriginatorOrg: eckelmann.de
X-MS-Exchange-CrossTenant-Network-Message-Id: acd817f3-6742-4813-a63b-08dc3119ed95
X-MS-Exchange-CrossTenant-AuthSource: FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 07:11:01.1215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 62e24f58-823c-4d73-8ff2-db0a5f20156c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owZn8EPZm+pGsYYyMrqx86nnJiJruGTJ0riEOesZGE+JWekrzPk7zbUzpQsDB8hW8qNV8erjFs04KQ4FS4Jkuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB1853

Hello,

On Mon, Feb 19, 2024 at 09:08:33AM +0530, Raag Jadav wrote:
> pcim_iomap_table() fails only if pcim_iomap_regions() fails. No need to
> check for failure if the latter is already successful.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
>  drivers/pwm/pwm-dwc.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
> index c0e586688e57..7dbb72c80ef5 100644
> --- a/drivers/pwm/pwm-dwc.c
> +++ b/drivers/pwm/pwm-dwc.c
> @@ -51,11 +51,8 @@ static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
>  		return ret;
>  	}
>  
> +	/* No need to check for failure, pcim_iomap_regions() does it for us. */

IMHO this comment could be omitted.

>  	dwc->base = pcim_iomap_table(pci)[0];
> -	if (!dwc->base) {
> -		dev_err(dev, "Base address missing\n");
> -		return -ENOMEM;
> -	}
>  
>  	ret = devm_pwmchip_add(dev, chip);
>  	if (ret)
> -- 
> 2.35.3
> 
> 

Best regards
Thorsten

