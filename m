Return-Path: <linux-kernel+bounces-79326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4F98620CF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50F5287068
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D55C14DFED;
	Fri, 23 Feb 2024 23:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dW6V8r1W"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4E614DFC6;
	Fri, 23 Feb 2024 23:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708732322; cv=fail; b=rTNcbaGiXtWIA40VTszAAyony5K5hJoLIltnUOWFgscA+erFy3U1ubYUvcTos1VNs3AmRj0KRvRkb6NfZoM2IngQu9A/e94STGeyjAsWP4wzZ3PbU0naeAEjg1ZH9vQoHBLca5F2Rs1RiH6vKxCFawHwazDNNI89uZRAvfxes/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708732322; c=relaxed/simple;
	bh=aNvVl0AkA9bOzjQFkhsXnTTDNkRwqtQ4x9MOOMV8zeU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=eOGU3kIn0Z3T6kPW8dCjoE71VtE/cJF60RtzrRD0dMg2/VEQwQOEdTXwLRYNtpUAge70qhjbAvxSoZF4iB0p2czSqT4yWk0GEcaMBu5oVU+W341O7eF1TP52vPxR9G8uAd5dyur025YOALjqKsGu2ib8YW2AXCiIJhZtVUZbCPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dW6V8r1W; arc=fail smtp.client-ip=40.107.100.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lq00l8yO+QDIK0sMGQcvp/J2XNLgK1fT5GwJAm8MUeN8QmEz1zp05eMUGLCUVmwL0742w4cHwAeQqFxPOq5trleLVffnITdBTt6viNSuLJyUV6wk7jWMnDmmBlttjIdCMk4RF9Ah1aX8e1xkR7eSexMCmAxdABsvYAKPIr5DLRit3Q7cw2tdineigsmf2aQx0K7YUH4uGU47+EMwvW/pjCbN0SW643bqdB0VZaViFdElAArD8Mvr778ndWkBzYnNSJldN8Wo3k/CWfHzPMYi3t7JBJPjjWKpiUgXeyazE+KOOLpenDaF3KwAM40+DBT5Cn4tLvAY8Yu1D2iWpV0FqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXu2zT5MslkdEF9lplRU59+7rwhrNFDNRvsvxPmuWJg=;
 b=PKvqJP1CvEZ7L+rTeURekZah6fdxMXMVX3kVi9xbiaJY44rTwBOUAR1yQ92/idWAUDKj8GqMwaTThBRYcM4whCThimusxJSxAYzhxiSccqvDuYqSAVH6IR1CHMbeqaHy3SFHvZb2baB0iWRVja8BpjpGMKXcb2wnVemAZZMbGYhwmULcy0AmX8lYkxIsXDQ8O7XocrPSBCYIdON7qT2h0IydXDj0VAbhH1b0o+K7eUBTG9nURQaHWkB93ekibaFe1WdeJ3qfxXHMgtdB41uv4TSU+sPy/2jAPYX44sGjKqmG56WnOBmz2s5v1ECImg+FFcv8Y7hfCZs1pG03BGlIOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXu2zT5MslkdEF9lplRU59+7rwhrNFDNRvsvxPmuWJg=;
 b=dW6V8r1W9QF6cmid4+/6/fq9jWyag4+d2Bn1pMrGxkR8h9xBtyJ1RIT272g14f+jHemWgKXVZt2QB3rp1jeALtozzlCTyXuX5USAG8TJr+HwCBy5ZZLBauJ4W6UDreiAtaQKyhlUoFNh5eBtatb9CC0anjWWy0hf8UJCwexqp6gorAIDX2QypkxC0Qx/dRjj8a40EQDqbGKjsG8aHtALkeGei/+gfBkf+4tzm4fXQI7xmq3hICnZaMbYPLg9Q4agbQWWNI2Gsr61yYP48yRD+E8o3+gZEesNjtuWFZsJNHREkYao6K1sY3DjjRtXGdQoJcWg1IV3Cqo1/kf1dd1H1A==
Received: from BN8PR03CA0019.namprd03.prod.outlook.com (2603:10b6:408:94::32)
 by SJ2PR12MB7918.namprd12.prod.outlook.com (2603:10b6:a03:4cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Fri, 23 Feb
 2024 23:51:57 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:94:cafe::46) by BN8PR03CA0019.outlook.office365.com
 (2603:10b6:408:94::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Fri, 23 Feb 2024 23:51:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.0 via Frontend Transport; Fri, 23 Feb 2024 23:51:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 23 Feb
 2024 15:51:37 -0800
Received: from pohsuns-pegasus.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Fri, 23 Feb 2024 15:51:35 -0800
From: Pohsun Su <pohsuns@nvidia.com>
To: <thierry.reding@gmail.com>, <daniel.lezcano@linaro.org>,
	<tglx@linutronix.de>, <jonathanh@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<sumitg@nvidia.com>, Pohsun Su <pohsuns@nvidia.com>
Subject: Re: [PATCH v2 1/2] clocksource/drivers/timer-tegra186: add WDIOC_GETTIMELEFT support
Date: Sat, 24 Feb 2024 07:51:26 +0800
Message-ID: <20240223235126.31004-1-pohsuns@nvidia.com>
X-Mailer: git-send-email 2.17.1
References: <CZ96NM6U8O59.3TXG2WKAL7L8F@gmail.com>
In-Reply-To: <CZ96NM6U8O59.3TXG2WKAL7L8F@gmail.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|SJ2PR12MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cec64d3-7780-400f-b749-08dc34ca6ba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vsaYMUg8vcJsAibptvGLFUqizSCXjVnSsrzT7rhpoMHWMeqRKgyaqm0IeR/qv3qivh02FjEqkr+Qed/aPfO3BnhmO+rLvDbLpYRnSd/ifBD+c5XL5JfOqK7LaWRZqLILnPpL1UIh2mpgtKF+cXhwJv1qKCvSQ9cQS8oim44kPoKLayXe6ZLukuiOkvJnvsHmsJnzxlY7xHk818LiFwq0o0yZIoKnvb7fbPyKcQ76dKYw0jpbsLKnV7ggPhcklr7U7F4+wfmSIHHQ5aNNd5hNIM5i0yb5CWceJTnMOniyAwBU6+TFU6HxkjkgZSJPA2snq6Rj4hFwwXpqkhFaMIlIljWWXum8WyDRomjTdoT9qoRozLeP6mTc5pxZRc9heVo7zHQq8nXHRJNXH2iWyF+LhHHlck3OC5GEDbtWVRUfRK8MMdSEPymp7caqDW+sJT912MelL2eSQ0hInOHK/dWmpXYkIjbkIB7ZT3yA1xF5HGS1qLQ2BBeIsN0nOhFgxjowKKvlJr8142TnXxiTrv+SrHuGH943JyhJ84q1P2T28YDrXt9maWjHujLayLNxf+KzTPSnBOHSERsFBcLi4pVBUJyWWzwsmCtTBrl1W7OteICu2GejMC/YP0KV9w8sOhsi/JNIiGMudX5m5WC6Kjul/Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 23:51:57.1066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cec64d3-7780-400f-b749-08dc34ca6ba1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7918

Hi Thierry,

>> +static unsigned int tegra186_wdt_get_timeleft(struct watchdog_device *wdd)
>> +{
>> +     struct tegra186_wdt *wdt = to_tegra186_wdt(wdd);
>> +     u32 timeleft;
>> +     u32 expiration;
>> +
>> +     if (!watchdog_active(&wdt->base)) {
>> +             /* return zero if the watchdog timer is not activated. */
>> +             return 0;
>> +     }
>> +
>> +     /*
>> +      * System power-on reset occurs on the fifth expiration of the watchdog timer and so
>
>Is "system power-on reset" really what this is called? Power-on reset
>sounds like something that only happens after you power the device on,
>not something that can be triggered by the watchdog.

I will change it from "system power-on reset" to "System POR(Power On Reset)" in next patch.
AFAIK Power On Reset is used for decribing resetting circuits and initialing whatever it needs
when received a POR signal after powered up. This term should also be applicable for
hardware watchdog reset since the system is already powered up at that moment and 

>> +      * when the watchdog timer is configured, the actual value programmed into the counter
>> +      * is 1/5 of the timeout value. Once the counter reaches 0, expiration count will be
>> +      * increased by 1 and the down counter restarts.
>> +      * Hence to get the time left before system reset we must combine 2 parts:
>> +      * 1. value of the current down counter
>> +      * 2. (number of counter expirations remaining) * (timeout/5)
>> +      */
>
>Can you wrap this comment so that it fits within 80 columns? It's fine
>to occasionally go beyond that limit if there's a good reason for it,
>but this comment doesn't seem to fall into that category.

Sorry, I missed to check the line length before submit,
will wrap comments in next patch.

>> +
>> +     /* Get the current number of counter expirations. Should be a value between 0 and 4. */
>> +     expiration = FIELD_GET(WDTSR_CURRENT_EXPIRATION_COUNT, readl_relaxed(wdt->regs + WDTSR));
>> +
>> +     /* Convert the current counter value to seconds, rounding up to the nearest second. */
>> +     timeleft = FIELD_GET(TMRSR_PCV, readl_relaxed(wdt->tmr->regs + TMRSR));
>> +     timeleft = (timeleft + USEC_PER_SEC / 2) / USEC_PER_SEC;
>
>Same for these. Maybe make an extra variable to store the register value
>in to get rid of some of that extra horizontal space.

Thanks for the suggestion, will do.

>> +
>> +     /*
>> +      * Calculate the time remaining by adding the time for the counter value
>> +      * to the time of the counter expirations that remain.
>> +      */
>> +     timeleft += wdt->base.timeout * (4 - expiration) / 5;
>
>This doesn't quite match what the comment above says. Shouldn't this be:
>
>        timeleft += (wdt->base.timeout / 5) * (4 - expiration);
>
>instead?

Here I made a transposition on purpose just for keeping the precision due to the integer division.
e.g. If 'divided by 5' goes first, the equation goes to 0 when wdt->base.timeout is less than 5
 no matter which timer expiration it is.

But the number will be still inaccurate because I made a mistake that
the number should be calculated in microseconds all the time 
and be converted to a nearest second only in the last step.

A new patch has been made and I will submit it after verifications.
Thank you for your time on reviewing this!

Best,
--
Pohsun

