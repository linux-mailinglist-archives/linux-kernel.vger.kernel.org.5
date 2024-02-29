Return-Path: <linux-kernel+bounces-86164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F8386C09F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A731F23526
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0B03CF4B;
	Thu, 29 Feb 2024 06:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="s6MWtBdM"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1953C082;
	Thu, 29 Feb 2024 06:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709187681; cv=fail; b=KJe/2bDR7nsBMfEv2s0/TAluk3KaPgilwS9C9eX+nA6KGj/J6NigW11gJymH+atNaayo21YYvruD/vih2VMedU16iuL5f2IhQNDb8DEiYULxNZIuQ2o9a5RcJYa2r5lWqGeeMhyLs8UI8O+x1k0TTBhAVbjEofpphRhfJDEFbgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709187681; c=relaxed/simple;
	bh=ctY//bObQWLoTnnmI6nEj0F3mggYqvr1fPOLW6wadKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O/sD4KsSb6n9YvUuat6aWH9l08EVi3wpD5CrCI57qcRWOK+jcGYtgHiusnnhwATNtj72W9MZBfyT7R5Mh6ch7gm3OnkotiQ7+ak8faHqYuc0QgvZvJtZjCnyvu+UjVcDgUgrgJrnHm3wundfDwiE0EJN4WwJnYEQ9Q+9VIHxO+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=s6MWtBdM; arc=fail smtp.client-ip=40.107.22.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QddHIJKA1GntAWvtfi7+lWZUy+sdmxtWYrt3zMS51jJ/6VNrx3603k3IlzNbzHksOXPqSF5VGUdNbZahJZHHEcE8fh2RqTm3Z3ytg5QiMCY1LDN43kgTZPhP5wpSRKcjdcDar9V4dJgESFcnlYM1FvzXozLUGJAZcHwL2We3kzADZOckvwNQqdFumraYTa3S9YnsFlpz9Eazo3DwFy3VyD8hD16ybE7Qek8hWgolj0CG2Zh7cb2bNPJ0G5SJcm9ql+eHwwmjzyqaajp6PRLRK8417ceuV8ZqP1akN6cVb/hGnMMJ73rVvrZztrfAqMVJvAq3S7efYEU438l+upodtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XTEvQTEsjymUj0tk035YIpbk98YR/cFKyNzstRqmcc=;
 b=S9+j77ZSEf2ZlZ+Zg2GdOsuG1/lx9JNgFEsFwW0A9Du/iVhX94N9o2a5oIKl5mOdq+p4KXdH2OgKPKdj8Ev9DehdvQJAxWPQCli+zYWDEXk9Z42q9E6SHrcLwuc8yJS9aempd8in2NVM3o+GpKonML87nokGbgsOYMYc9SBGFXoLancS5/mEq+SRGaAxcXFHf1C5ujPzjGD8lM+o9elaYfnp4hnkwyZUsA8ZBhtE18grdCbDKlyFuIuf6ox3snfqe56MOiNS77KZ8RX9RUJVCy2BX0LhWtQMwtLdmO0efqSZ8GMT4YeqQDaCv+5y5EQK21TfLEKx5yzfoHdvCMYhww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.203) smtp.rcpttodomain=sang-engineering.com
 smtp.mailfrom=de.bosch.com; dmarc=pass (p=reject sp=none pct=100) action=none
 header.from=de.bosch.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XTEvQTEsjymUj0tk035YIpbk98YR/cFKyNzstRqmcc=;
 b=s6MWtBdM8Y4Rq+Xh1Gkx5WSlDAknMwRhSeolBdyiZMiOEWHaMZcJmzHYWKqcoW9HqQO5mnXlX2LkshoYa/ZLylqxhS9tMF249VF0+EznbLWmwau3hSWqhFlIORy6OtoQ94Ie8qbUBSFk7VkXqS6g29Jt/m8tMZJg1HzE+5cL7PJNQnAG72DTLu1QQsb6tMc/1T78m+rLGpFoaAijSsGz5xPqf3PpqSGod9rb3vnQyED0dxzXEDpxhgM3sBX4yRUBtohsMaiJN0BL3CsHRV07uym/NOTU5pcLhvZaCYJExGBEP1mkTbzaPOFXY/edGiTkYDA9eHRP/8BXokuK4mWyAg==
Received: from DB7PR02CA0003.eurprd02.prod.outlook.com (2603:10a6:10:52::16)
 by GV1PR10MB5985.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Thu, 29 Feb
 2024 06:21:12 +0000
Received: from DU2PEPF00028D0B.eurprd03.prod.outlook.com
 (2603:10a6:10:52:cafe::bb) by DB7PR02CA0003.outlook.office365.com
 (2603:10a6:10:52::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.29 via Frontend
 Transport; Thu, 29 Feb 2024 06:21:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.203)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.203 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.203; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.203) by
 DU2PEPF00028D0B.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 29 Feb 2024 06:21:12 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 29 Feb
 2024 07:21:15 +0100
Received: from [10.34.222.178] (10.139.217.196) by FE-EXCAS2000.de.bosch.com
 (10.139.217.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 29 Feb
 2024 07:21:09 +0100
Message-ID: <331084d4-2802-4d1d-b978-6660f546ea2d@de.bosch.com>
Date: Thu, 29 Feb 2024 07:21:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT] mmc: tmio: avoid concurrent runs of
 mmc_request_done()
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	<linux-renesas-soc@vger.kernel.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240228100354.3285-2-wsa+renesas@sang-engineering.com>
Content-Language: en-US
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20240228100354.3285-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0B:EE_|GV1PR10MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: 38bd4641-d60d-49a0-bbdb-08dc38eea086
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HMuJhOaiTBwgOGsFpbOrhMDN+ha3CSsjuPZZtsSBAtdxh/9JbHGscJ1gadFZ1ExjwBsn5fZzxvgPURC7O66F82TAPlNDu1dNUuUpj5AqL9LozQlU5CibP7QyTxhQuGdsgxXImPlVY23U9OcbKqXYx1zwhDxEpIRweLxFpFJQa8OODS3A6fkavzbEnNg1DiH5ScO/nGg+xy1Q+TzQ14vlce1B853KMG6MoL0LG/sozCFKAAEpdfBMD87iX4pvuVYaUWQ7o+F0D2BK4EArt0tPFbtjZTA7fpHHV87cLUk/IsRBk666ov/mW+UL2bGuRE/MWiHh6q7lGHQlZpntZm6eUgruvGQsTPzOdyEB57M+QSiGGP+CLYv0G1YYxxz6I3CHYfLmeHPW2YjSPEknpACkB99uiXyROY0uGhxOr2/qZIAeX/Kh/Ph4eeHLC9ZnF6nNYq4EX+jK7dMVUs1bmFIGN1yHLPGoEk5WweA5aFgDUuHOmVG7WPl6hm0ZYnvEbEA5qBRHGJqa0SMuILntsXSVOJuX1AFD/Je2vCN9ElnEzDASU1qRQZDnWpSf0KSmemgD/a+DLdo34COdRA3DcsaA9+6Q9jDdLx190zeaf7gMFvdkEYuxcQby732SSaXpZtAyZdtGUIbLbAdcV2m58GH7S0ilD+EAfik4Qgpk0usmkmeTfl7oFUAp9Y+5ODroX5HDl3sivbRyZITv9Pn+6kijZtDdeUbGuF5rPku4+qo67P0=
X-Forefront-Antispam-Report:
	CIP:139.15.153.203;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 06:21:12.5074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38bd4641-d60d-49a0-bbdb-08dc38eea086
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.203];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0B.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5985

Hi Wolfram,

On 28.02.2024 11:03, Wolfram Sang wrote:
> With the to-be-fixed commit, the reset_work handler cleared 'host->mrq'
> outside of the spinlock protected critical section. That leaves a small
> race window during execution of 'tmio_mmc_reset()' where the done_work
> handler could grab a pointer to the now invalid 'host->mrq'. Both would
> use it to call mmc_request_done() causing problems (see Link).
> 
> However, 'host->mrq' cannot simply be cleared earlier inside the
> critical section. That would allow new mrqs to come in asynchronously
> while the actual reset of the controller still needs to be done. So,
> like 'tmio_mmc_set_ios()', an ERR_PTR is used to prevent new mrqs from
> coming in but still avoiding concurrency between work handlers.
> 
> Reported-by: Dirk Behme <dirk.behme@de.bosch.com>
> Closes: https://lore.kernel.org/all/20240220061356.3001761-1-dirk.behme@de.bosch.com/
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Fixes: df3ef2d3c92c ("mmc: protect the tmio_mmc driver against a theoretical race")

Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
Reviewed-by: Dirk Behme <dirk.behme@de.bosch.com>

> ---
> 
> Dirk: could you get this tested on your affected setups? I am somewhat
> optimistic that this is already enough. For sure, it is a needed first
> step.

Testing looks good :) Many thanks!

At least the issues we observed before are not seen any more. As we are 
not exactly sure on the root cause, of course this is not a 100% proof. 
But as the change looks good, looks like it won't break something and 
the system behaves good with it I would say we are good to go.

I think we could add anything like

Cc: stable@vger.kernel.org # 3.0+

?

>   drivers/mmc/host/tmio_mmc_core.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index be7f18fd4836..c253d176db69 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -259,6 +259,8 @@ static void tmio_mmc_reset_work(struct work_struct *work)
>   	else
>   		mrq->cmd->error = -ETIMEDOUT;
>   
> +	/* No new calls yet, but disallow concurrent tmio_mmc_done_work() */
> +	host->mrq = ERR_PTR(-EBUSY);
>   	host->cmd = NULL;
>   	host->data = NULL;
Thanks again!

Dirk

