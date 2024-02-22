Return-Path: <linux-kernel+bounces-77386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C20368604A4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70368282069
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F46373F2D;
	Thu, 22 Feb 2024 21:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b="dY1I6vGF";
	dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b="cIqJsB97"
Received: from esa.hc4959-67.iphmx.com (esa.hc4959-67.iphmx.com [139.138.35.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C77F6AF97;
	Thu, 22 Feb 2024 21:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.138.35.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708636744; cv=fail; b=KIHwX85En8d6vd/lpuIrgUkehNNr8aFisBg+UtbCMzGy1RNSnDTv8gE3jpx6YhFZyzeGO0blHm7oZH0Z/5XUZSOgj78kYw0jAgz3iXdOdsqwDywlWm3hVsztJ/4YQCuIJMR4RPZnEzc/LRfShSIE4E5nFRqprx38Tah981UbRRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708636744; c=relaxed/simple;
	bh=JNVVi396xa2NT0d8ZYJ2mo33jD9euRVOh7oeAnHzPq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oy65GT8bQM1mpqnE1/U2r0/MbcravHTtGz2CBSmm5J+irNLHqiWhjqYsy4GWxH0N85pxxki3tuumRHbSHbC5ETYob7WEPb6W2wiHLQRfB8nVrlm2I5Y6eOElpiGoLHAjni9alIRs6ykRM7mgahTXHcLbzUV8/8RKEkNxfzlGD7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seagate.com; spf=pass smtp.mailfrom=seagate.com; dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b=dY1I6vGF; dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b=cIqJsB97; arc=fail smtp.client-ip=139.138.35.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seagate.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seagate.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
  t=1708636742; x=1740172742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JNVVi396xa2NT0d8ZYJ2mo33jD9euRVOh7oeAnHzPq4=;
  b=dY1I6vGFy6FpzX65CVOpsQ+iinqqTRBpynWpuJC5L9nxE6YqTWtV6TRH
   WFJKvwiCQ1EwQsVaI/E8dRgoh9zuMoW0g+beHnVEF0uWX7DILSdS9LuZN
   YK1tstFo9j8dsFn9IQa3foz0y+gyWFH50YQYoBZ99huKMNGFVCPNou9A7
   A=;
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 13:18:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdCKYn+YFOPfBGCvyAO0gx0tErqpuDiRyaHCmjYCQa0P4gzvu/iyPaVEXaTVA/WLfUcj2wrHtswhskWxAN13Oaub56Nwz7ORa1s9s8pcxatMDHiuPO+idMWlbe6Bg2ljj6V8sNQHi2uzuC6mQ2lHDP0Aqc1koq+XR1PMR+7Kb//+XPxbQIK0ycYc7G1zgNkoQph4wtPAMW5bfc/0eNhaDUZF6RhvltCpK2qswiAQ9w2m7XEAb05/8/M7DME9SxOU6XUbAKU+LA6k7/NL/GcQ8GOc/3/41rCupsB2SQJmn1QD34WlNh6f0r+36y6NeD3l7Z5tBeP95CN6CEDSJksXvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbTru4NpSzd4dLsf2NWBCpxiTGNnAhW2bzL5MXGRl4s=;
 b=USsV3NZuuD17ATWToEooE4EAM/eTjVh8eQ5mkCS+LFXU/Bhi22/IpPoogpzX3R4DaXsBkua+cG5kMsplgE51txB5ltd/WbN2fggdQv4S/+CkTMgyqpLQOxj51lQ1Wnim67opAf49QdrHVMsp96DGEhCALMI5wCEnww2JY0FxCr7rRxQ7tDMhBgwQFYjZY8cy/Bf0FqNwE40c8/dmscOKbWm6S78l1EdWhg+VNn7cS5cqkxbEjhnc+Kd9MbHdDYymQA6WEwHyJSFUjwT72sX4tabQgMJxrw3echhVLoIZBGijX7xjYL2Em9F4C0K24OUtOpbMYgnCwaiI9KjJJLdCSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 192.55.16.51) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=seagate.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=seagate.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbTru4NpSzd4dLsf2NWBCpxiTGNnAhW2bzL5MXGRl4s=;
 b=cIqJsB97ast7Au1ZsttSzKFAuBAAlIKlPsfn9EEmaSCxmgacBxcyDHo0jDssYdDYcInPYnSYn62XKxk8HhMMXdbbrRnZZFg5mqsDsELsKRlfX8+e9OeuceJLzVTLCWKX2+tWg7MsdpRZb9jOpF0ccMdWMygOBFmfF3t0AASsQrY=
Received: from CY5PR15CA0158.namprd15.prod.outlook.com (2603:10b6:930:67::20)
 by BL3PR20MB4922.namprd20.prod.outlook.com (2603:10b6:208:3b1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Thu, 22 Feb
 2024 21:18:51 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:930:67:cafe::69) by CY5PR15CA0158.outlook.office365.com
 (2603:10b6:930:67::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Thu, 22 Feb 2024 21:18:51 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 192.55.16.51)
 smtp.mailfrom=seagate.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from sgspzesaa002.seagate.com (192.55.16.51) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Thu, 22 Feb 2024 21:18:49 +0000
Received: from sgspiesaa001.seagate.com ([10.4.144.52])
  by sgspzesaa002.seagate.com with ESMTP; 22 Feb 2024 13:11:41 -0800
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="114056584"
STX-Internal-Mailhost: TRUE
Received: from unknown (HELO nick-desk.colo.seagate.com) ([10.37.50.20])
  by sgspiesaa001.seagate.com with ESMTP; 22 Feb 2024 13:03:50 -0800
From: Nick Spooner <nicholas.spooner@seagate.com>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	allen.lkml@gmail.com,
	conor@kernel.org,
	f.fainelli@gmail.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@denx.de,
	rwarsow@gmx.de,
	shuah@kernel.org,
	srw@sladewatkins.net,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org,
	Nick Spooner <nicholas.spooner@seagate.com>
Subject: Re: [PATCH 6.7 000/313] 6.7.6-rc2 review
Date: Thu, 22 Feb 2024 14:18:18 -0700
Message-Id: <20240222211817.24480-1-nicholas.spooner@seagate.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221125951.434262489@linuxfoundation.org>
References: <20240221125951.434262489@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|BL3PR20MB4922:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 01a32c59-c978-41bf-ddd0-08dc33ebdd97
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Kq/k5AlsaMfBaXukzuJswda4dJt3igv7Nc+pBINHNpGjhU0m1dMSoXqSM2L03FMSC9mRNlM/qe957kvz7H0IMTf6hBzEO1YPqmzq6G8TWzokQwBl8vmswZMycEJfFKhiN3pDgciVfNWGB9MqtSodm6kGxkrxzMsOwIHJNqe/1uc8SV9TnaV5GyeuGarCFuwkFGj32Aued4ClM31dXtMbklNhR1hfssqfMvClFAojUwA0DNNCDD7k5h6cceZClue/PJftgQGqGUPmJAoOzL67Tejv4gT0hPnoajkYNXWb2/Ndk7+EvYnRU/4c9a6FpWKLGe8UX51rTjQPdkB1ZMI1OW3Wh91cHdP5yCxkP5JKYUcK3KcjXN9cYc9RIhEu6BX/9H+gt7dFWTssf9yDj85WtojF0zoHCki4KM2ies9dghMGDm1c3zIR/rKG29j9DvUKhXBvh6koZeIbdN3WBB6iCNzp6YC2EU932T84khhPVBLNJ9ElehVYSS3xOC501gbljl5CK4mtXedPEy9ArWAbf+qcfOiqywl19CFc/YPahTcScPlbQ3CTpdDlhLzVezA7VowXKbR0O5EdVssW8WuD+Dss4dJ/MthGu3sIIvkcX8xLKhVUsYM+zFxHtmj9TCJTJ/r8uHL1kI1Mme7yQi478Q==
X-Forefront-Antispam-Report:
	CIP:192.55.16.51;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sgspzesaa002.seagate.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fcqIkdSuodgUiAPVjs4bAHo0+7F5VJsfGSDGPo4WE5d8ZCuTOuAwdzCpVHGjNXS4Huu8r5TxbUSkwkfRQv8vgAStm0Oig46poStDDyZxUTZ5gA1i37WcPCAJ8Ni5e/t+Vn7FjeJTgQOdELlF0u4RITa9PajFLHSXOktq2cXGShOfGEagUC2Lj/bUkXuILMjQOMlgirgaOLHsJcs+hK9ssjBGfMPCVx6el269PaxSUC61mHadPYMPbnVe+qryKFJ5hOOmMbfjnpwIUMc5D7BVLIRo7HIdYnEo1YW+C1o/BV+O8vM7hhUCvCB3+3ng1TQvSnInU+XFt3BlR66CBQi60D1ucALJ2b146QF8xQ5gz52m7P9fdRjubvFUjO4m7SWAqrEW2+TqrD+1oqakQY9H370icN9CWjgt6ksu3pXdGIC3KCpfh2lqQAWW8r/8n9ga0ap8F6b7oGSsdyhbZ/u8lkzWg1M0pjT3mpPYk7TvOSSC3LcqTijxbAcgCM3Ig9dmNXSZxGadoen4zsKIQvsfwEQeLNxa6B5CDYsrGqkiniQX8AkF/lwmMKStSGIDWSHB353mS/2/RkRY4BKtaxZZMbhxMUnTX6mge8k73VA2UZ9YKF6xzfwuShw3Ck+f2sgF
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 21:18:49.7972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a32c59-c978-41bf-ddd0-08dc33ebdd97
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe;Ip=[192.55.16.51];Helo=[sgspzesaa002.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR20MB4922

> This is the start of the stable review cycle for the 6.7.6 release.
> There are 313 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.6-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Compiled and tested on my x86 machine, found no regressions.

Tested-by: Nick Spooner <nicholas.spooner@seagate.com>

Thanks,
Nick Spooner

