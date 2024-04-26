Return-Path: <linux-kernel+bounces-160196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 997728B3A73
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5076628C453
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47EF1487D9;
	Fri, 26 Apr 2024 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dawcHHsB"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398631487DC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714143391; cv=fail; b=Nsqgz5sEvCyEjsQwaB+2J75XUnqhAlvB9IOjVsoXtMhsDDhC5+HL859cfuAGU/rLxBof1NCot2p6VcP77cIDD8ImKb8WdwATHUHzBRU0OlzDzMG9o6RTxRsbSP5enjbr9K7j0eokQRk4+c9RcwxAsF7+gES8uKxISkTgyw+PxEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714143391; c=relaxed/simple;
	bh=xZPaK5L4JAjoqzYM1+MIcqWY/qj8TcNtURPAyUQydRM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KLOlj3kyHoNdbYReIri3JBny88NDkjY6riRNbsT+/pHMFOJ53RXMVeIjKI8BoiDHd0kF4rQ0B0VNDEyBcTmZWixzndY/kQ79NIr9lYX4xSHAiJN50mT3s/ikDC8b0PCtG5pq6ZUIz4g931JieoONeSnbtLk+dpQEdQnbdxdWYsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dawcHHsB; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Snnoz8aYjVRixlVJfS33vbLJ0pt9dJjv4fMcUiKH5Lyd0QHCp9rfj6uRhyUyjB2b/ZT4Xikp6jFL6TJUE+ydXcIBtJsMr+nJx7bHmYHPl84EH7vDICzkKGARp0pMKFq3MQYUxyvHyEDugJ7//VeNxslC+DymSLLgdayy7ldLqNM/FhDlscE1BBlPM1mN/1KzooiGFzPwB17wNASLa+EYxnFJnu3K1AVAQMZMwr6maE6naiikPecWKdZwci9HCYkpU5PG12HB95aTAZc07/OwLwzUwJKv/1S3Qa78ZRTQo/2Iyq5PX/CO+Q9ttl4H0FZQaF0XegOyz/pR23ap9oXKvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVrAT6YUdz8k1Me7lbCfuWoJKBZToDF05sREq8qAsrs=;
 b=AWa2NkxEzvHXGm8nfylrpd7e36KKQ64ZT2s0g73s6FsjXqgrMMj0s/OW+fVkqeTCUSC4+NqQgKrh+poJpBPk/6ni94NGR3Oo2fJ3Kycs39lrV+tZp0swvk15kSdRHFT699Xa8LWi+clb0QS/eflegB3uSAjIvcu/IDg0fGTauQArNjnQ5/JMraV9nqgm5/Eg1F58gxKODi1WdVD4u/58q10OwG5gE05RH+VLMId1Ak9XRBkTU/f2l/wRH6NcQb8ud+OB/5NFNYVMeIwZ4OTSrTJVvTS+MferIN7ldlawe4Uw+BXJi6SSaUXRImXFFbUNYjV7oQLYhvXvWm+BI8s0EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVrAT6YUdz8k1Me7lbCfuWoJKBZToDF05sREq8qAsrs=;
 b=dawcHHsBNS8nnkNAkXMH9OxZ0JyXiTItaKJ05CM8j7VwdPw8GsUgxxv8SOpwZhwYu7+cu2As0Woi5jCztY+hv48TmkG93TxZ9iIrArW6ajI1sB5vVecwwuQKO/sakx/VacNDwiL+FF6pYv1WM3lkj0jZLr7KqaiOasiBXZnWSl0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by MW3PR12MB4473.namprd12.prod.outlook.com (2603:10b6:303:56::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.46; Fri, 26 Apr
 2024 14:56:27 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26%7]) with mapi id 15.20.7472.044; Fri, 26 Apr 2024
 14:56:27 +0000
Message-ID: <5d515e4e-5db8-4840-a200-a67e7df8043b@amd.com>
Date: Fri, 26 Apr 2024 09:56:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] x86/sev: Add callback to apply RMP table fixups
 for kexec.
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: thomas.lendacky@amd.com, michael.roth@amd.com, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1713212104.git.ashish.kalra@amd.com>
 <96b2949cf225501d686b47070c7bbad341e160a3.1713212104.git.ashish.kalra@amd.com>
 <20240420130533.GNZiO9nShSxjxB-FQn@fat_crate.local>
 <ed4cb373-e626-4b79-b692-df5ea2ca8899@amd.com>
 <20240426125803.GDZiuk2-YonyodvSbi@fat_crate.local>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20240426125803.GDZiuk2-YonyodvSbi@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0037.namprd07.prod.outlook.com
 (2603:10b6:5:74::14) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|MW3PR12MB4473:EE_
X-MS-Office365-Filtering-Correlation-Id: a4e5f42d-a517-4b91-44c6-08dc66010cb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWg2ZnZrTmJ4S0p1Qm1ldTVEeTM3RmJFM2tYY09xUXZkZklKQXUxTGtCOVJB?=
 =?utf-8?B?OXRaU1VjS1R1WUJZb0haVDlMYS9aUWZIWlZXM01Ua3pXUzN0R1JEOTAzV1dE?=
 =?utf-8?B?R2EzTGVWc1ZxZW15eGNKWERNc1RtSWxoTWJZRnAvTlY0NEE1STVUY0pvVS9x?=
 =?utf-8?B?WnArblVyZEt2a1Z1bkRRbFlGd0d4NVhYdEY1c0hjZndvR3V6UVZvSm5ORFRS?=
 =?utf-8?B?TUxMMXlqSFFPazhQY1F4WU5aSlhWSlRtZW4zREM1MGxrN1lMclgxYzZLQ2o2?=
 =?utf-8?B?czZhY3k1NFRzeGJuWlNObWh2WEFpNVVnQjR2VUpxSmdOY0JTbjV6V1pOU2ov?=
 =?utf-8?B?K2ovOW9zK0xlNXY2NkZmSzNqazdDOWJaYzdNUXNOczhaZkdFd3pGSlhRRDhO?=
 =?utf-8?B?MnlXU05LQXFJelVCZlJiS1o0b1FEdkMydlJuME5ZTzFzY3RuaUIvRmQzNXpT?=
 =?utf-8?B?eXZEN08xaTMxRWV6SHNFbmpodTg3RUd6bmxZMHliNVAzV0V1bk1DNXhFSzlm?=
 =?utf-8?B?SDR5QmNjYkp2NHNRVWY1N3lMVzEySU9JdDZVZWl2TGFkVzlDRlFwSGpkRlhq?=
 =?utf-8?B?VGRPUlE4ak1vTGFjdkt4ajZkYkF2Qk8wbWd3VXNham5qZlZ1YTZaUWNWQUhs?=
 =?utf-8?B?VkpDNmlhdHNGanhYWUVaY1Zld014ZlorNDVLVE9HUFlDTTNYUDYzRlZBK3dw?=
 =?utf-8?B?RWJ2QzY2Qm41dlN4YTBqNHNXcWpXV1Y5dzRQbWQzL213WGM2TTlDRGdvMFo0?=
 =?utf-8?B?MGs5ZTFodkswYnBiK1BuNzZhd2l4bWpWLzVyODhzd1p1eEdIcmdvZmx0Tjgz?=
 =?utf-8?B?MWxNMnRPOHJMVjIxV2g2eE41QTlLNkxmaDFHb3VjYThWbXRUR3M5ZkxYaGZn?=
 =?utf-8?B?ZDhSczJPTUpia2dOYWNkSEZSNU9RSlhDVWxGV1Y2L016clA3RnF3ZkV5SjZT?=
 =?utf-8?B?TytoVW13ajJ3cjR2WWUrZmROS1ZqTldQTVpyK29oMXVxOGJ4L3E4Vzk5MFVl?=
 =?utf-8?B?dFpWUmdCRnRtejkwUlg0K0RWelhuRzZsT2IzQTQ0SXVzaW5HaXN2OFFoKzdH?=
 =?utf-8?B?M0dyb2RpMVhtL3dUY3Y5cHExVVlJZXEwNmY1eE1ZQTd5QlJnK2lCVncvakxw?=
 =?utf-8?B?VW05L0FaQ2E1MnRDRStmNUtNeHhhaTVVcll3amVFNmZ2VEJxbDJZc2JJM2Vy?=
 =?utf-8?B?ZFI3NlpBU1BHVXBPRE1yTFJiMVgrQzJEaWRDTU1ZVzVXQ2dGcEF1Sm56akVZ?=
 =?utf-8?B?NGpmZkJadjNtc00yOFlNT2VVbkZVaUlRSUcyTFVoQjd4TDZZQlVpajBCTEI0?=
 =?utf-8?B?bldIaTY4SU5nb1hlY1BMQmhBVW1yekZoRzJ2d0VzT1RjMGszZmh1MTNnT0V6?=
 =?utf-8?B?VnZ5ZUlxRVJZSUoyOEpYa0xpMHY4UkRJSjJOZ05ndlhhTGVYVENCekRFbm5E?=
 =?utf-8?B?ZHdtRk9XMy81S0N4OFBBVk9ldlh6RjI1bUxHUExBU08wZmtXZFNuV1RyTHla?=
 =?utf-8?B?SGEyZkMrakU2Y1hwU29VNWtsQXNRWUlXT2pxaTBhaGREZHBoMFVJZnJzQklu?=
 =?utf-8?B?ZGpYbktKaFY3UUtqN3IwRlZZVFloeXN2QlFFZjFIaWxDaGdzSVRlM1luRm1Y?=
 =?utf-8?B?amw3VFh0NTZOS0k2Vmx2cWVNZzJ4RTJqVlhKeHNYTmJ0QWRFdEFXTUtBSjNq?=
 =?utf-8?B?VHdvNHFhNmVhcVgzY2pYb25UVWdXOFBsd0plRi9zL0hRNWZwd0VWcVV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0hPaEgzOHlmVjgyK1VnSkE3dG5LSmZ6SDR1bDNuRUNmNjRoTGZxWkVpZTA3?=
 =?utf-8?B?cTJ4SFRtOGZQd1I1SVpWV1hheVVSQ1pZcEk2ZmdDZzhZNlRQeTIwTzVlUmky?=
 =?utf-8?B?ZzJ2THp5YWxxWVRWWi9pT1ZLYmZWL0FoNmFjTmNWZFBYOVVTQlJFZG5GU0RT?=
 =?utf-8?B?cno0ZDhBbklkQW9qZlFWR1JRSytHZHMrRjJ0QjlUclp6MFQyVWdwbUlQdGVk?=
 =?utf-8?B?ZmFhTmRaUFc2Q0lXMHl0VnJFc1M4c0tMcEwrbE5uaTFIbjVwMTBNUW5YaFJ1?=
 =?utf-8?B?dlY4OTE4Mk5nQlpmMnN0Nk85ZnhvTmtuWVc3OG5MU2pYdkZ6WGUzQTY5U2lU?=
 =?utf-8?B?d1RFUzQ2cXRNSzhRMnZJU1llcWt0ZUJoay8wRC91MTRqQ2xuYXNyRFpSVjZu?=
 =?utf-8?B?ZENwWUNIV3JXTXdyazBveDJFZkt3ODNhbktiOHc2d3pIVWRrYnJmRlVwR1dC?=
 =?utf-8?B?Vmw3SXZ5TzI3QTRHVk81KzU2aG93d2QydG1OdnVqR2llOTJyMEgxbFI5eDNK?=
 =?utf-8?B?YnRRb3BtZW9hVzRtb3g4ZDRYWG9RMWJnSGJGOVNvek56aENjRGFYTnFsZTBD?=
 =?utf-8?B?d0J0a04yWkxqcTdmWnFDRmowZnpndVQ2a2w0WHFzd2dZcWNvMlJNREk2aG4y?=
 =?utf-8?B?elJIL290cDBLa0kySENkQVMwQ0lpc2lDODlwTkg3Sk9zYXNlQjkwU0VYYWxX?=
 =?utf-8?B?Uy8wYWZmKzhBTXdsdnliRzVob3FRMFYwejNDdVZIdXd5YnptZXF0RmUybEJm?=
 =?utf-8?B?YWhWK3JtTWw1V1ZIRXVhZEVleFhkdjhzMG5OVUFJb3pzbG44Q0lrOHNpMGNk?=
 =?utf-8?B?dVpEWExIVndjT3hzVWNEVkhlbWhFTEZYVWRsb3RUMzNINVdZTjl2R0xGZ2VZ?=
 =?utf-8?B?aTdWSWRwemI1d1dQREpzaW54ejBjcHJyQjZaT3dQS21KYjUrcUtySFhERHRP?=
 =?utf-8?B?L2lHWFhWd0huc1JJLzJTUm5USDJZbmFmZW40RzhKV2VIemk2N0FyUi91dUxv?=
 =?utf-8?B?aEZ4OElvNTA5UUdZYW44dDQyNXRYeTVVQ3JFWmd4NEg0Uk5nQnYwcTkxeW5S?=
 =?utf-8?B?THRwcHIrT3FUQmJZYXdPZ3ZHOVVWUElXR3lCSitpdzAyVmhLdFI3WkNxTlhF?=
 =?utf-8?B?TlBkM1BIYWEycHZMSlNxcDhYZ2VHLzA1WjNwRUZXYnI5TXBCTlJ2d1NMSTdL?=
 =?utf-8?B?RnVxQS9NRVdRZXpWQXRyZTlmZHUyeldIN3dqLzZ4T3UrQUpmSHBGVkovZi9j?=
 =?utf-8?B?YTh4a3kzSnMyVVlwS3g3NVY2Y3dwMGpHWEZ1TUxwM3dpN2M5TXpFRnBKNmdC?=
 =?utf-8?B?M0thNWhtdU9mSG81Wnk0M1lBKzZxTWxjNDB4TG9qNzJvSHhZazRFenIwNUla?=
 =?utf-8?B?TkNVbnlTNE5ka3RERkhzTGtOWlB2NGloRTQrZGJHNTQ3S2cveDB3UWxmSHpT?=
 =?utf-8?B?SE0yWEMydDYwQjlEVWYyZm81VSsxOSttQThlMENGMGJGS0xJUHF0VnpOK0Fv?=
 =?utf-8?B?bHUwNHFSZlA5d0k3TXl0dUl4dWJJQlQ5RWdpbU96YzBjN2NMZ2R1TzVKSzBX?=
 =?utf-8?B?aVlCaDNPYW5rVUhnYi9scUlHcXFFbWNoTVdpQ2FqMUhVV204QUdKT0ZKeDVt?=
 =?utf-8?B?VWhuWGJURlcwcmh2VWJkMXlvbEdUNWFGd0tTUkl2WEg0ZmZycEl1d3ZLbEVV?=
 =?utf-8?B?QzR3RmZLQmE0SG5lVzFjZE83dVF0N0U1eVV1MXVZM3pDU1FKOTJycE9zell1?=
 =?utf-8?B?U0o3TlB6Qzd1RWRSTzFrMGc3eHlCK0F6eWQ5Qmx4QjRlWUdkTko4emprZ2VO?=
 =?utf-8?B?NlYrNkpkZEVaYkxHMnQ2RXVVWDBZeWtwK2ZTZCtuak9Pa2JORVRIRUhZV3Zt?=
 =?utf-8?B?N0dQWURVMVB0azRmSUVORU4yOXUwRVBOVjFBMk9yNDFaeW9ldTZhOGRzcG5U?=
 =?utf-8?B?bEZhZVREV1VSUW1OYWlpUzQreS8vNmlybDZmQjBJZGdzdW5EMDhSODRLbDhR?=
 =?utf-8?B?bCtTQzFaQUZObWlJcU9HZzI1cks0azhibzFmWEgzUy9DdVZWWmlqdjVhYXhT?=
 =?utf-8?B?eTJxVFRaV1dKMjFSTEREN3pCK2lXeW1nVVY3a2kwclJtM2NlZGVMSVNxaFZZ?=
 =?utf-8?Q?Bw4pf+0W1li/UmmHsO9AjA7fR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e5f42d-a517-4b91-44c6-08dc66010cb3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 14:56:27.4864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cv/oa1A36snAiwRqnrn1O5DxrBn4UPGpA3VVZSkOW+Qx98HrsgZOSe+yHfZXENsxvLiuRbHb8NHLSCamG7XvnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4473

On 4/26/2024 7:58 AM, Borislav Petkov wrote:

> On Wed, Apr 24, 2024 at 06:48:08PM -0500, Kalra, Ashish wrote:
>> This callback needs to be invoked as part of setup_arch() as it needs e820
>> table to be setup in e820__memory_setup() before the callback is invoked and
>> snp_init() is called from sme_enable() in kernel/head_64.S (startup_64),
>> which is much before start_kernel() -> setup_arch() is invoked.
> So?
>
> snp_init() still runs before e820__memory_setup(). So what's stopping
> you?

As i have already explained above, snp_init() runs before 
e820__memory_setup() so we can't invoke this callback in snp_init() as 
e820 tables have still not been setup. Again to summarize, the e820 
tables are setup in e820__memory_setup() which runs after snp_init().

Additionally, RMP table also get probed after snp_init(). So this 
callback cannot be invoked in snp_init().

I have added this comment to v3 of this patch series which i posted 
yesterday, so please look at those.

Thanks, Ashish


