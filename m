Return-Path: <linux-kernel+bounces-79322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4358620BE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B38A2875AE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE80B14DFDD;
	Fri, 23 Feb 2024 23:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ho0Jk7Bq"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1D014E2E4;
	Fri, 23 Feb 2024 23:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708731864; cv=fail; b=KBaeUUdPeVH6qKXgA+rGolr9lHT2Ym4ZGGCPwn9iPUjBdmOdeEFn4h569n9Fc4ctMAiCSsvMe9Yleb8uvKnZDplCZEGBnMaM7FYF+lR8NP4R+Rb01eBS+3536jAj/x8V+LW6beS3NBNYrHCncJ+LuV0o6C7/wEakU6iY8ck8UM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708731864; c=relaxed/simple;
	bh=JzmVzH9/eHZZcpxHE4lvM8Ja0oCO0dVjoFdugW+Vh8g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=qO0+X40m5EojXYNgWphn9PeJoZSo3UkxErRD/XlMEraonXjDZC3SsuiBzSbazVnyjhOJ3MAcPZaA6LOFAT036KlRugz4ik2XmRTqTxUS2XTCWgkpUiAZSwhCaDiuXCQtS8gv2c8CKt/uj7zjxiwcoYcwofUUc+kHyvtPM+EoSb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ho0Jk7Bq; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxYwPzY+3Xek47RxaDMEIZLAaOrOlA4tFcNRxw0wxfwFk+rILcPGgAuz9/9ii3BsUNgPHWu+01tDCRUoRu9PoWeV8QIa9ekoXqVBzNdAfQOUd8kV6ExoS0A2Xvm7OXuE1jndro3pSMzj85B0fToO6AoD8nv4z+q6qjJ95QBS5Swqq7hAEg16/rodbQy26y0Tr7uYiEdrM7UX32wUV2z7eDi0UMN996XyxtPBtQ0gJ/p/fJHFBatO06WuWIqiy/BH7NMMjeE+xuvhmiLeCIkydvXA1wq8YAQifQo5C+5nC78gbNot+1+J1gR82Yz1+mm4SPDn7VNZPWHX9cqDTk4RBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIXtxpfnsq/h02wkERp7yYj3whkmvcqio/Q7xnKXanQ=;
 b=HLI0FpToXNgYJfm+C8fiUeFsvV3BoPgczAP8V7nfE/UqVkNxv1YMTEC+Rc4Fxz1SOO2joludp/KWmzlVPagEPdWRVmJ/wgfSbRxT9q1pg5h3c+OrstkrWKedg1Tx2yji5xrhmGDH+WfTZbQf4YmXKFVYuCvUGwaxghnYyzwA3k9dSDAMKs7nkpzfnQh3NjvmNeIM/9QL6msUoGCtfujqm5nZr6gyuHC1byV6fZAWMFaKMhgMKt/KOR4JZUBKcto9Xs0lJmi7Qo7Pg7ECrI9WGleqBTt9azHfEDhnJcBHhRNrmDixjYn4xJAxpoe/g1dTWmgRzixTG5cXlBQBFXKyQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIXtxpfnsq/h02wkERp7yYj3whkmvcqio/Q7xnKXanQ=;
 b=Ho0Jk7BqiQbodPc8aIly4YkL474mDSIdxIT4cfeYhjieFlsUuUiDaECF2DI6hfEnhrmWd1nBfWDI9Zn7bus60Z0Dqw8ird4PGoDZyZozfRfjrBnK1mytBR9oAh2DMb5VGixl9nTmpEtoh7ljDXoclnin/YSyWoxMLRA4tGKKXJMMeOd3zTgWioLJKYyEZoTvG20ak56JKZjZ95M2lxdV7SqoV8qWP+hMLd6xaL5YZmtbHwjR1axb6SqqHpW8uQ6p77zV6hS8AGa2tV1FJQYBdNlCCXIJtcyO0gmvidsRdmoeln/UZrwJmSa62ZZfrQCrEqXkskkf298UuDuQdK05rw==
Received: from CH2PR18CA0026.namprd18.prod.outlook.com (2603:10b6:610:4f::36)
 by MW3PR12MB4363.namprd12.prod.outlook.com (2603:10b6:303:56::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.27; Fri, 23 Feb
 2024 23:44:18 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::29) by CH2PR18CA0026.outlook.office365.com
 (2603:10b6:610:4f::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.45 via Frontend
 Transport; Fri, 23 Feb 2024 23:44:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Fri, 23 Feb 2024 23:44:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 23 Feb
 2024 15:44:01 -0800
Received: from pohsuns-pegasus.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Fri, 23 Feb 2024 15:43:59 -0800
From: Pohsun Su <pohsuns@nvidia.com>
To: <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
	<tglx@linutronix.de>, <jonathanh@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<sumitg@nvidia.com>, Pohsun Su <pohsuns@nvidia.com>
Subject: Re: [PATCH v2 2/2] clocksource/drivers/timer-tegra186: fix watchdog self-pinging.
Date: Sat, 24 Feb 2024 07:42:55 +0800
Message-ID: <20240223234255.30235-1-pohsuns@nvidia.com>
X-Mailer: git-send-email 2.17.1
References: <CZ96VR54894Z.TIAQI1OXCH2Z@gmail.com>
In-Reply-To: <CZ96VR54894Z.TIAQI1OXCH2Z@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|MW3PR12MB4363:EE_
X-MS-Office365-Filtering-Correlation-Id: 10dd65a0-491f-48b4-ebb5-08dc34c959a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3SXBkh/ivxuIfL1qhn+gaMuZBEBZAgDAIuW7q9KdWdq32TDUpivksKrc59Pp0ofpKr+xCzCUT0GT6GgYvkps+BEAEoyxR1dLQl9Q30BYKioDCFfv+GJoyMBw9tHoxuOfjmwlWSJftfHmEuYBLsQNq7B4e4YPWi/6Ou/M8MWOgKTH1IDlV7XPqM8YIrLpZe2vqlrvPJBOxgZ5oSPHcJ1UmEY7m76qdYUbw2GY+X6SHWv6l1/7IS7ux1fMo4zcjkSPjChLtYpuSaUJ5a4Ct06eeMj86nxYCFgAUOtB4p288YxbyMKptXi2HMIL21wHSUiYotiPWtLraFh4GbJ6VSPPnERxFLxuczC+YnYTYM9eWCe/v1Swkvh/+3zc+4mIFNqPb31BF0WUbC1J4sdsMXYb4nS/6LocVaBf21iOQDnWSWXa30fuqIhwbS7mq15UuwlxYH0ALoHuK4LxuLPHikywhoGg9a3uSpzXpk/MLQEQO/q/C8WEofc9gVdNZHPy3vyXO5zrmnzQecKfq2mdf4azDeGJ2oeXR1DBI9X/EeRlT5WXJk2Zxmw8h4Ry39ycgEsQvUcXI0PwudbMlyO0utq+27S5/kfW/7bE5j9DcbMgt302IK+6Nt3qBSrXiW7L6rqTn+vBGf5GtqILX7QZNJrtG9dgEa731phwhN3O0vC0Rbs=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 23:44:17.5009
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10dd65a0-491f-48b4-ebb5-08dc34c959a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4363

> On Fri Feb 16, 2024 at 10:02 PM CET, Pohsun Su wrote:
>> This change removes watchdog self-pinging behavior.
>>
>> The timer irq handler is triggered due to the 1st expiration,
>> the handler disables and enables watchdog but also implicitly
>> clears the expiration count so the count can only be 0 or 1.
>>
>> Since this watchdog supports opened, configured, or pinged by
>> systemd, We remove this behavior or the watchdog may not bark
>> when systemd crashes since the 5th expiration never comes.
>>
>> Signed-off-by: Pohsun Su <pohsuns@nvidia.com>
>> ---
>>  drivers/clocksource/timer-tegra186.c | 27 ++-------------------------
>>  1 file changed, 2 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer-tegra186.c
>> index 8f516366da86..acff97da138a 100644
>> --- a/drivers/clocksource/timer-tegra186.c
>> +++ b/drivers/clocksource/timer-tegra186.c
>> @@ -175,7 +175,8 @@ static void tegra186_wdt_enable(struct tegra186_wdt *wdt)
>>                value |= WDTCR_PERIOD(1);
>> 
>>                /* enable local interrupt for WDT petting */
>> -             value |= WDTCR_LOCAL_INT_ENABLE;
>> +             if (0)
>> +                     value |= WDTCR_LOCAL_INT_ENABLE;
>
> We probably shouldn't proliferate this scheme. In retrospect I should've
> removed the two other similar blocks back when I submitted the driver at
> the time since they don't really serve a purpose. The intention at the
> time was to keep them there and eventually replace the condition with
> something that could actually be toggled, but it's been almost four
> years and this hasn't happened, so I suspect that we just don't need it
> at all. So perhaps you could remove this line along with the comment in
> this patch and then add another patch that removes the other unused bits
> so that we don't carry around stuff that we just never use.
> 
> Thierry

Sure, removing both lines and the comment above.
will add another patch to clean unused bits.

Thanks!
--
Pohsun

