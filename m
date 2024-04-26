Return-Path: <linux-kernel+bounces-159853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DBD8B3528
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 968F31F21E71
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D845E147C63;
	Fri, 26 Apr 2024 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sB0Ebvk1";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sB0Ebvk1"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A009114389A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.50
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714126567; cv=fail; b=FQPGbq3wOd+7JDfdhvWsk3nF1kAOsn5/rxuvzD1LgHmutmxyZrGcOoVHLEm88m2SsufrLrMPMv9SaO8Rh5XRnyu1brBfEGD6C17W8Q0Mw0ecB4VUkLgIVfQnUM2ZXsWHzzz4rMT+loAlayDs7wxstc869N3SEkNTBLqnBA+05VA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714126567; c=relaxed/simple;
	bh=EILrIuxOCxwpo0AebgUaaGjn2P/o7zILg4ZNcmD/RW4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U7zLpXPf3RQfS+ODCedA/zVlOh2uoH4pFIxeXbwyQLQb/i5W8FKgzhnippLH3TmKT/lUH/YF8/sU612/QvpAGr8b1UjyKhTLnED33buz9CfTLeEnlYNYJHyvAWYK2kGJW/OUHBDGvUD5o6z44ktosJSePViQeGy1Oy11+rcK9h8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sB0Ebvk1; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sB0Ebvk1; arc=fail smtp.client-ip=40.107.22.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=Ez1B5yEnRINpZCpOkyXDqitVtRWmaZpiQwyxDq6fBcsUEhy1692BG8Ukzxj82ZY06jeIPnAEd2ub4aMf2ZKi2kWxwYfsXKESCzDUO0R6CgYMNhK4Dy+w7P4ZshZ6pSs/7aom6yJEyFjo5TUXwGOW9+eEWkMOWXq6BP6ew08FlPGjC8viJ2Y8ZLOf5jbEZdetOixwZ5GjMspjstcs4yxIGo1MYKw0SEqZuCyBjkdc8seb4i9suEcROf2T7QWhGE7gfRA95MMoYg9V87h0e+G0yknksKg4wwRp4zD4cn7RvHBix2hemZ4Uh5Ult9sUxQXYerQ56/6kh5xpFRrfF0Jtwg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maXL+5tCsw9U/iMY7zCjsV6mjKKM5Gg3bS73CTa0knU=;
 b=jOFRA9xXZA47dV2+pAS8s7QCnLdrZpg2wzItBm3lkeQi38vTg130XMkslrnHx/Q5gGDD1jK03Ceo/GuS9M9is3cllAsuL6Z3oi/ft1qxKbmOP86a16HtYae2h7AX9Ylzh2flM5CIPa2fD9TOhQuc5lUcy2sabAxzvIUpufx1ndLXFAbd5bnMs7GIvGY/zfhuVyx0lxjfVemlgLyXDMKN70+6vs4K44okc47//r7pxhGZaKqtfibC9/x4i4Igu9GhOGZduZnihOqSpG8a39xpJqdkLFZ6pnGdt/PPTsTjWruYbF81yxX9MtEzshB2ojG6GoTJ3CXP424oqg9p/cQQ1w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maXL+5tCsw9U/iMY7zCjsV6mjKKM5Gg3bS73CTa0knU=;
 b=sB0Ebvk10THyS61T4PT1gSQsYq1wIU/pszDd6WcDIomEpnkmV/3KRxUe+RzHxOgeMIWGPwip68icvvpdVVliuuuWsDlcT3t3s7IXo0PbwtjZcnUoDi5pOCUg12tCHusEx17rwKgWC4B+WTZcy3f7cTZo79EXt6sAGrvI48SqBFA=
Received: from DUZP191CA0061.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::16)
 by AM9PR08MB6115.eurprd08.prod.outlook.com (2603:10a6:20b:2df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 10:15:46 +0000
Received: from DB1PEPF000509F4.eurprd02.prod.outlook.com
 (2603:10a6:10:4fa:cafe::ee) by DUZP191CA0061.outlook.office365.com
 (2603:10a6:10:4fa::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.29 via Frontend
 Transport; Fri, 26 Apr 2024 10:15:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF000509F4.mail.protection.outlook.com (10.167.242.150) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7519.19
 via Frontend Transport; Fri, 26 Apr 2024 10:15:45 +0000
Received: ("Tessian outbound 85e363419cbe:v315"); Fri, 26 Apr 2024 10:15:45 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6ebd8979ec459412
X-CR-MTA-TID: 64aa7808
Received: from aaa76d87b372.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id D1D69105-2708-4617-90E7-5043B839D730.1;
	Fri, 26 Apr 2024 10:15:39 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id aaa76d87b372.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 26 Apr 2024 10:15:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYx1mt4x6GPFINrsD5lP7WP0P3J/Khb9ojgpYvWcQl4iCY7pm6KLC13XTbXX8DUSsX4OZsDt5Oif4uK4Nr40twXwYRuVoSG2kK0szWP//coLD6fyYGvEWOxa9Nd4w2Vy2vmTHK42XwVn6CZZxwcWfdc1DCcXJgu4c3PNacp5Dg35VAnYTNiHhimmDKTWacMnloWgmwRm0q7iCVKQoeuW+eBKsrzg1gKzpJsjeNUApkI8s6KhAkJyC7zLSzKU4nKS6YVy3UsDJD7vy5XgtLkmky5El+AmQ+dBxx2a5KcpHkMSg+VDBtcFuZFQIjMR0pd2IasEP2xfvAOGEXSvrykC1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maXL+5tCsw9U/iMY7zCjsV6mjKKM5Gg3bS73CTa0knU=;
 b=ZTrj+Da8QfWpjam6gMIJ8bjrChNSlGYxeNIVQXBOByc0BWC/ToxGhvIDl5F2ueXz5A7V8p43XR8rfQM2G4vTJ17OByhH4eN/Qb5WV3AlUfBnENI/HGCZbF56dc7WOGEa4Sq2IzLMvWf8SeCNs40c/G+pk/RNF3CHvHVgcQWZl1MDYxaSD2illeaUTPvkcELn8Ax6uoeG7oLcXhFX6/BerMUVsypKFtBldJulp00d9TPmFMlLmNPx+ASZOE9bddh+heZXYfqGgVahzyWXh5O7NsbZv9PC8ShSS9VEqK9Def3Ke+EVcDPK0WuVAIfkSx21G8H7YZJjtzI5olDyl0YUJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maXL+5tCsw9U/iMY7zCjsV6mjKKM5Gg3bS73CTa0knU=;
 b=sB0Ebvk10THyS61T4PT1gSQsYq1wIU/pszDd6WcDIomEpnkmV/3KRxUe+RzHxOgeMIWGPwip68icvvpdVVliuuuWsDlcT3t3s7IXo0PbwtjZcnUoDi5pOCUg12tCHusEx17rwKgWC4B+WTZcy3f7cTZo79EXt6sAGrvI48SqBFA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com (2603:10a6:803:c4::31)
 by AS8PR08MB9193.eurprd08.prod.outlook.com (2603:10a6:20b:57d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 10:15:37 +0000
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::77d4:d040:b19d:6472]) by VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::77d4:d040:b19d:6472%4]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 10:15:37 +0000
Message-ID: <afc5b30f-8540-4fc9-a271-af3c5ee55340@arm.com>
Date: Fri, 26 Apr 2024 11:15:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com, tglx@linutronix.de, efault@gmx.de, nd
 <nd@arm.com>, John Stultz <jstultz@google.com>, Hongyan.Xia2@arm.com
References: <20240405102754.435410987@infradead.org>
 <20240405110010.631664251@infradead.org>
 <3888d7c8-660e-479c-8c10-8295204e5f36@arm.com>
 <1461277e-af68-41e7-947c-9178b55810b1@arm.com>
 <20240425104220.GE21980@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Luis Machado <luis.machado@arm.com>
In-Reply-To: <20240425104220.GE21980@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0049.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::12) To VI1PR08MB3919.eurprd08.prod.outlook.com
 (2603:10a6:803:c4::31)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3919:EE_|AS8PR08MB9193:EE_|DB1PEPF000509F4:EE_|AM9PR08MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: 28a99361-b2b8-408d-2dce-08dc65d9d642
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?c2xxcG9halQyRWNQN1JtS3d6SEp2VnVqeEt2SXB2MzJlSmRGbTBaamJ6NjA5?=
 =?utf-8?B?eCttViszOFhyVVlEMlg3UlRYYno0WGFlQzhCTjNobUJ2Mms1Ylk5WFVqUmdB?=
 =?utf-8?B?YU9GWURUUnZCcXdGSWtqQXBIRklpRGF3cVY1RVZGall4a3o3ZVNDM09nWHYw?=
 =?utf-8?B?c0o0VFpPNlY1ZUl1MVdMVzNPOXAzejkxOHdUbWxIcUcwUjYyQ05UYTFFZWdQ?=
 =?utf-8?B?d21iUExET0c1OEJjdGxNUlRDcEFJaW5nUUxWSHQvb25qQ1UyZWdsaFpTZmpE?=
 =?utf-8?B?WWxkS3dpaXZtVjArNVZjZEZLcjR6Zld4aktaNlBUOUhXRnpOMElVQVorQ1lo?=
 =?utf-8?B?cEh4Y21MVVpRR2laeXNpa1llOEJaMGRIYTlEMlFEY2NjN1l6cnAvNnBZbVJH?=
 =?utf-8?B?UzRObWgxSWVSVHplV3BuRTJrYWUwd3c5bytmdmdpUTlkdVkvSGJqbiswMEU3?=
 =?utf-8?B?MmFnU2ZqQWRWOVBNWGZLZlpMYWtra0dlTTRLZkdoakR6VHY0aXUrRUtIUVBp?=
 =?utf-8?B?MkRmTXJHMjFld3E3RTlZUHBrNmQ3emZmY2xhZGZvOURpMStNUUxGcGJ0YTBm?=
 =?utf-8?B?NzV2d1E0T09DRkVDU1VZUWJFbjBCZ1BraTJTZ1piRkpqMlpkOEpSYkRGQkVQ?=
 =?utf-8?B?ZnZIUTA0VzhZVFVnSmFINHZlQmtSRFpXVmpHZEJ2Mk9CZW1pSEhHc1NRWkM4?=
 =?utf-8?B?bjlvVGNocmhpdDB5Mm5BZ0NsUGQ1eEs0WklJdEpRMWFGa2pMN1h5cERxYm01?=
 =?utf-8?B?NTVtNkd1a2gwKzdyWENaN25Kc1YxbUtqZ21wWmxjRTBpVVp2a3JvMnBKUjV2?=
 =?utf-8?B?aHEvdTV1d3dvNUV6OElreFBab29iMDVpL0kvUTNlYXNnWDhWSmZvYzNQTlNx?=
 =?utf-8?B?cnExY1NXVE8yU28rN3hvaEQzRGk4NGxqMlRJcDBpMDE5d0tsZTcrbUpnWGFM?=
 =?utf-8?B?S0p1V3R5WTNHQmNFejFUVDdWRTVTYlRtQmp0R1VRaTJjZ1dva01RKzFiSFZL?=
 =?utf-8?B?TE1jbXFML2ZUR3FvbXZCZGtnRjdZdjNlSG1QMzRSbXZTZytRT1NrTVc3TjhG?=
 =?utf-8?B?ZHU2NG80REZ6RVkwL1BVRlBIQVhHd2w0RFhTc2xodG1VS2E3aWdEZlczU1cv?=
 =?utf-8?B?cFdxM0Irckg4NS9semhSZUNxS1RMRjVOU0NxaHFsQTJUK0RtelMzc0JZcUJx?=
 =?utf-8?B?TkxldkhlWUVYZzJNb2hWKzJhUEJydVdBMFZDbytwZGRDMnlZUmVFNzIwSEMr?=
 =?utf-8?B?cnlhdVMvWUZDYVJvWGtuUlFoYVNaYW5zeEtFbVhhUkl3QkFVZitYYnc1Ykda?=
 =?utf-8?B?ZTZJK2J2ZXErbDFhM2dER2ZOVk11a0dIU2tmRGZ0K1llZWs3RTZ0bDVLaXpt?=
 =?utf-8?B?d0hadzVzYjBvTUpyWVN0dWtRSE92eEdPc0pzTGJyNitxVWQ0ZkswbU5FVFI2?=
 =?utf-8?B?ZUNqRjlqYm44MDBYTDBvU1BqbExiRmkzQWtKRzNSckloUXlEanhodW5mUmVB?=
 =?utf-8?B?ZG5EZDdvY3QrT01xMlk5UWJKWkNwUUgwSUVQNnIvYjNKY3I0N0l4U2ErdWRB?=
 =?utf-8?B?Y3cwOUNSbit4WEZTQU4wRWJZVlp4bmkwTmc2dEpBeVlYZm8wSDR6NjJabUJh?=
 =?utf-8?B?QVNJT0FuOVNveGJ5QzBWZWxCSUNVM0tCcHZxRHIyOWJ2R2dhTm5wL2ttNGtS?=
 =?utf-8?B?NHFFcjlIQmVMRlBBQWFRVThZU0diajV6dnRzU2lCUlRlNUVzaUhWWGRRPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3919.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9193
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	3adbe5a1-36ad-4e39-6a8b-08dc65d9d113
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OElqc291WUMzUGRaVmhaelBnbVRUWFBZNmVsMjBCeTJYRkluTG5PNFRoNHlE?=
 =?utf-8?B?dUJ5OVczV0phcXl4d0h5bWNPK2RuTTVsdWo1TDBPSkJJazY5VS8zOTlNblpp?=
 =?utf-8?B?R0ZXL3JGdzlhbTZLNU1GRXJxY3ZIY1J5YjlrenJ6aWdXRjZjc2tIVW5YZVpD?=
 =?utf-8?B?RVlQQmlLeWxmZys0L3BPY1FsMGtHN3RxTE1jRTBMUGFqSHRTUzhXdkdMNkFh?=
 =?utf-8?B?azdSem4wMTFweHBEY1hpVHo4WEw3Z0JFTzRjNXQwNmVsRFd6eTB2NzFXdlZ0?=
 =?utf-8?B?WERoRlhNWm1DcE1RVHV0Vkg2VVpMR0hyL1l4dzc0UWM3T3BVczZWWU1ERnRu?=
 =?utf-8?B?c2NpcDBnVDRlSnFVcnl5cG9yb0cxQXJWT2JzRWNTd29CQ3hVU3lTTzlQalJN?=
 =?utf-8?B?N0NlbnladUE5blVRSTdBWXkwd3pwMS9tQmcyelI2ZmNVUnBPeUp4d1ZMWEQ5?=
 =?utf-8?B?b0doYVdWcy94M01aQkl0MVRJdCtHa21HTWk2ZTlrdWRvWFdBSGU0TEdLMS9Q?=
 =?utf-8?B?anA3cjBmWVVSNlVMbTJibjhqMGFqeVhRMnRxMHhSRUJSQU13NHNLdHhURWkw?=
 =?utf-8?B?alkwbjRjQi9JWi9jQlpWVUVWb1pLNzFEei82bmJ4RkFmODd6am9sZGFZVjl2?=
 =?utf-8?B?bnBWOHE4WDdEMWpJandqMEZsOFZ0alRFUld5MUlyNS95b2UxOUc3NDJxbXdy?=
 =?utf-8?B?OXBYd2ZvS1pSYWswUy9BdlhXaUFmb3NOUlZ0bHNlMEdBWTYwSEQyN3RzQWxh?=
 =?utf-8?B?V2Z3TGg2MkJST0xZTngyVTVVTWZ4YU9RMEV6eXczSDlySFZNSmdHSUtQWXJB?=
 =?utf-8?B?V21LSThFcTh2dGk3TTBmTHJld2FkejQ4MjMyVXgweXJBOXJyODgxMFE4NGRz?=
 =?utf-8?B?dzVTc2Qvdi9LTk5GVGZTVG5RZ2VNMDNLYWd3dm1FQmh6TmdtQWEzWi9zdFZl?=
 =?utf-8?B?cWFYNnlQdCtoYk1SaVlmWC84UjZ1aHZVYldUbnRQQzZDR0F3VU1kamtCMmpl?=
 =?utf-8?B?dE1sbHBRZTBvN1Nra0RmN25COWFkVVZuMTV5OHZqVFJIVjNrbVYycThPd3dV?=
 =?utf-8?B?aXdyZ01qaXVXSDJibmkyRzZFMGZCRkZyRFo5K3RicllJUWdHVFVCZUs3VC9z?=
 =?utf-8?B?YzE5NUYvbitXU0tWUEZpNWZ2MkNGN3M4TElnbUM1VWFVNytIYWxCamMrZ3lF?=
 =?utf-8?B?STlrTlNEOEN3MHVkUnpIZ2VZVDZkMHpuaHNTNk5tRDNvMlA1d1c4S3huQnJN?=
 =?utf-8?B?Y0RUWERvR0xIVFVUUnpXUUYyMVhYdmNxU3pGT2xNczN5L0pyTktkcmkwWUF4?=
 =?utf-8?B?R05uelNsYjZlR0xzb2g2QUM1b2R1U28rOFZwVGlnV1VlcVYxc1VWcEJoeFRT?=
 =?utf-8?B?ODYxSFFMVm9KNmFZOVU4VzhlaUNiRE1TaHhReVZoRzg4d0YwKzBHaHFDNzBq?=
 =?utf-8?B?eTkwdUg3R3pteTlXdjMwaC9OZkJVWjhRYzZTT3RlWi9JazdTSHQwOGl6UFpr?=
 =?utf-8?B?VnlFVkFhMmEvZExxVTN4ZGRsbUcwSnZMWVlnb0V3dytQdlpHc3N6dnRERC9Z?=
 =?utf-8?B?NFI3aUhuQ29nSGlVKy9oY2U0NWhXeDZqOHJSTXRRWUFNRjJaSUcvSEFoMmxi?=
 =?utf-8?B?UStYSys0aXE1UzZ3SDV6cTlnMUVwRXhJSWV5TkxIcExVZ2Y0S0JqNVE5MHc2?=
 =?utf-8?B?MG5WNUJRTDZYeHZyK2wwaFNjWDloSjVEOHBEQzRRRDlPdnpDK1VrczVwWDIr?=
 =?utf-8?B?NXRmRHZSZEhVRldJbHg2SkRnd213MWRpeVlHT3l1NUpmbncyR3kxTkFOT3R4?=
 =?utf-8?B?VEVodnJERlM4NHh1UTBxcDVXeGE1NmJnWEhsNkRFMmFMMDJxTFlNcFZUL3h2?=
 =?utf-8?Q?/fK+J/WZoB7E1?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 10:15:45.6737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a99361-b2b8-408d-2dce-08dc65d9d642
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6115

On 4/25/24 11:42, Peter Zijlstra wrote:
> On Wed, Apr 24, 2024 at 04:15:42PM +0100, Luis Machado wrote:
> 
>>> Bisecting through the patches in this series, I ended up with patch 08/10
>>> as the one that improved things overall for these benchmarks.
>>>
>>> I'd like to investigate this further to understand the reason behind some of
>>> these dramatic improvements.
>>>
>>
>> Investigating these improvements a bit more, I noticed they came with a significantly
>> higher power usage on the Pixel6 (where EAS is enabled). I bisected it down to the delayed
>> dequeue patch. Disabling DELAY_DEQUEUE and DELAY_ZERO at runtime doesn't help in bringing
>> the power usage down.
> 
> Hmm, that is unexpected. The intent was for NO_DELAY_DEQUEUE to fully
> disable things. I'll go have a prod at it.

I'm running a few more numbers to confirm this situation with the feature switches.

> 
>> Though I don't fully understand the reason behind this change in behavior yet, I did spot
>> the benchmark processes running almost entirely on the big core cluster, with little
>> to no use of the little core and mid core clusters.
>>
>> That would explain higher power usage and also the significant jump in performance.
> 
> ISTR you (arm) has these tools to trace and plot the varioud util
> values. This should be readily reflected there if that is the case, no?

Indeed we do, but I'm still in the process of compiling those numbers into a meaningful plot,
so I'm afraid I don't have those handy yet, sorry.

> 
>> I wonder if the delayed dequeue logic is having an unwanted effect on the calculation of
>> utilization/load of the runqueue and, as a consequence, we're scheduling things to run on
>> higher OPP's in the big cores, leading to poor decisions for energy efficiency.
> 
> Notably util_est_update() gets delayed. Given we don't actually do an
> enqueue when a delayed task gets woken, it didn't seem to make sense to
> update that sooner.
> 
> I'll go over all that again

