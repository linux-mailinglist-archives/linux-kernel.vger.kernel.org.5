Return-Path: <linux-kernel+bounces-151349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 395478AAD4C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 902ACB22AAD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBB6823A9;
	Fri, 19 Apr 2024 11:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="glzH7MHu"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2041.outbound.protection.outlook.com [40.107.104.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A2581741;
	Fri, 19 Apr 2024 11:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713524682; cv=fail; b=bjAK0mBJjeTv6Ymb0+UV8FB3bwW2lJzSZGO34IVkSka1G90bEvYoGQj/Ha1QyQev8dEDpWDfHI+ycRDj0Ze/Q16BZjg437VvyvjTmLtfEMQ6T4InMOcT8BWIM8A7QnVbz7rRTef9ioMNEiE6umPOmfmXW+CV2sxphNMZmDbKfAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713524682; c=relaxed/simple;
	bh=+NMzllU1Ih/P6Uo5cJB4oCGVUYQVX8mRsbLoPvbn+68=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rZ56d/7yWhmYknlXzjoAu74ht7s22yc/44+ULBWWHBHs/r8WmyAiexPrF7FreKHUzU9boWgy7XFwlqYAwWys4UzSwAvh2OXRBIT9gai69M9IPhbqnGZd5ssjv1vPNuHbSz4HUm6N78lcRcYYQx5Ft4N8oCieayU3pA7R7T2L76Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=glzH7MHu; arc=fail smtp.client-ip=40.107.104.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYuJEs2WbKI8tyf1RIpK2ni4Wd1FIhN7fuayNpEWoIUPxiwbbX72TxGDz5VnBPghI5OIPPOuZXHPEybG8YApvTv0AnJdQdCrfKbzUCKixuKXdW+b9LCUAqKiEaBn29IDTMMlJYwEeaE0EKCes2+xHrqtWVdrPBFec+h8iGLG0kgnlDkLSvXOw0MR6lTRF5Gupi4NKrHBJVabmTDzvGCNbGEKZZPIcbRWfEW6QA6mXS80YymsXg+Lf6op6DZJ71PSNnHWwEROsfufRbZJXKxfNmn4YIJpEdomXuvk9XoJew5Mb6zmo7VsJpWlDcS62o9/R8XJ2h+kT77abKK5kcVfFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWlXJkyHiagNZOaKtxq2/DnTaGvgp/A9NOXHSqOA910=;
 b=Mm2tob0hXovHJeHsppgNKrji+5zpdfP3SMw/VCTvRHAnaHrKWmUKt9wURpOusvYhLnpR+Fl7LswsjRBdPom5ycuxu09f6oLYTpA6De50ndgUD3aCA9TONxRhP4cL12cut7t+DGH7QEc1YTRDqqzRvN/5POuSA4vQN8SGhhiL3v+Ilrl1DHGeZSF41B5X7FGqc8kNXicuO1tIx9Bn3GZX4P4wL6fJ/6RlcTjvISlmc71wwBEeEN5L+kI7mqYsu3hFXd+dC2B+EHwZL3jds314rtxrMVov7hGAcvVoN2jVaTqOQ996hCstVufB7uz6rg4JBmnWXSZfxpcyOA0Ll7YYUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWlXJkyHiagNZOaKtxq2/DnTaGvgp/A9NOXHSqOA910=;
 b=glzH7MHug1E9I0zpfkeDDJ/EOfCpn+0Q+5r/7BHn+5irNCYXU4oGVWlzkyBPLwSnmWTWafvWZaH1xZ14t6L4Y+NALEhUVnqzctmTgEkFbCYDE8oKbl3ayDBIeKBlrMbP17IzPebT/7TlE/ioXQuPc5lwffPWFwN2qalx0St4NtA=
Received: from DB8PR03CA0016.eurprd03.prod.outlook.com (2603:10a6:10:be::29)
 by AS2PR02MB9143.eurprd02.prod.outlook.com (2603:10a6:20b:5fa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 11:04:36 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:be:cafe::f3) by DB8PR03CA0016.outlook.office365.com
 (2603:10a6:10:be::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.30 via Frontend
 Transport; Fri, 19 Apr 2024 11:04:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 19 Apr 2024 11:04:35 +0000
Received: from pc52311-2249 (10.0.5.60) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 Apr
 2024 13:04:35 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: <alexandre.belloni@bootlin.com>
CC: <linux-rtc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] rtc: rx8111: handle VLOW flag
In-Reply-To: <20240417191937.33790-2-alexandre.belloni@bootlin.com> (alexandre
	belloni's message of "Wed, 17 Apr 2024 21:19:36 +0200")
References: <20240417191937.33790-1-alexandre.belloni@bootlin.com>
	<20240417191937.33790-2-alexandre.belloni@bootlin.com>
User-Agent: a.out
Date: Fri, 19 Apr 2024 13:04:34 +0200
Message-ID: <pndh6fxmx4t.fsf@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9B:EE_|AS2PR02MB9143:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d138189-877c-4374-285d-08dc60607fc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xyRuidlXrGbkVY/HTnHxF0J1YXwJwjIY+/DLE7MPHuW1UKEJasNFPxyhFgEGwdTmCOZ5RkKTsZvVxKS8dMZJvSsUO0To1XtwBR6swvVzQQ3/N/7Yrpz3Imxx00mSvOKR06dOCM4GV+9xu7s1cCBIawkDgo5Ff69qYyhJnvOGVGJ5PCMp3brvf1nsPME3g+XKJVrMh7nPd4URpxBBTQVxBe7RX6dn6+r+zju5Lz7MZoAl/xqTTpWlnOoR2jsxUMk4RGJ9ATB3XhcQrasd4gfSkPxpwW1yitziiwEiEdlDpo2YulUfrK4ugR8EYY77+9hRYqkoVUJpkpH0Mclj5hWi7H7ex7Wj+aZU1HP5uKEXnRIz69LX0olzAFXQQzLRVvzE5goNNesYCmqeMbBvXFZtaUOT0M6Q+psVlS5lzGpqgULKg3mwf5XmJmoJwE/MOg0O9XhS/VdKaGcUCoikVTlbtzd7yxBRw7utPQf2D9ZDor23uQGrVFTBZmSPCDP19AVuIsvozquBBdBeO5Zzwhs9jZu2StzWQ/3vAR2TbXds+/yJDIb6W/6s2aRbuD3EZLYa5mq23WzhiK1MV++RKg+LrusXIrimVrgtKbX0UNJt3t+g8qkw9uYWfHmHa6V0D8r5G9yPwHnO3gLAqjYGZS0dIoBXvjpEoUu1fQGbM8wBgYUvDuooN49zV2XWdF41Tx9MvzeCxcq3nJ/XOTHlbVpcY0RKFkUZxkd3HLHJFJ3qZgspVSZeYO+7mVlVhOeAy9Fk
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 11:04:35.5806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d138189-877c-4374-285d-08dc60607fc6
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9143

On Wed, Apr 17, 2024 at 21:19 +0200 alexandre.belloni@bootlin.com wrote:

> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
>
> Allow userspace to get battery status information and be able to warn when
> battery is low and has to be replaced.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/rtc/rtc-rx8111.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/rtc/rtc-rx8111.c b/drivers/rtc/rtc-rx8111.c
> index 4a35bd921b33..8450d9f0b566 100644
> --- a/drivers/rtc/rtc-rx8111.c
> +++ b/drivers/rtc/rtc-rx8111.c
> @@ -95,6 +95,9 @@ enum rx8111_regfield {
>  	RX8111_REGF_INIEN,
>  	RX8111_REGF_CHGEN,
>  
> +	/* RX8111_REG_STATUS_MON. */
> +	RX8111_REGF_VLOW,
> +
>  	/* Sentinel value. */
>  	RX8111_REGF_MAX
>  };
> @@ -129,6 +132,8 @@ static const struct reg_field rx8111_regfields[] = {
>  	[RX8111_REGF_SWSEL1] = REG_FIELD(RX8111_REG_PWR_SWITCH_CTRL, 3, 3),
>  	[RX8111_REGF_INIEN]  = REG_FIELD(RX8111_REG_PWR_SWITCH_CTRL, 6, 6),
>  	[RX8111_REGF_CHGEN]  = REG_FIELD(RX8111_REG_PWR_SWITCH_CTRL, 7, 7),
> +
> +	[RX8111_REGF_VLOW]  = REG_FIELD(RX8111_REG_STATUS_MON, 1, 1),
>  };
>  
>  static const struct regmap_config rx8111_regmap_config = {
> @@ -276,6 +281,13 @@ static int rx8111_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
>  
>  		vlval = regval ? RTC_VL_DATA_INVALID : 0;
>  
> +		ret = regmap_field_read(data->regfields[RX8111_REGF_VLOW],
> +					&regval);
> +		if (ret)
> +			return ret;
> +
> +		vlval |= regval ? RTC_VL_BACKUP_LOW : 0;
> +
>  		return put_user(vlval, (typeof(vlval) __user *)arg);
>  	default:
>  		return -ENOIOCTLCMD;

Looks good to me!

Tested-by: Waqar Hameed <waqar.hameed@axis.com>
Reviewed-by: Waqar Hameed <waqar.hameed@axis.com>

