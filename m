Return-Path: <linux-kernel+bounces-34877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F8A8388A6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B663D1F271AB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF1356760;
	Tue, 23 Jan 2024 08:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="C4oD7ht1"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2132.outbound.protection.outlook.com [40.107.7.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5BF56B79;
	Tue, 23 Jan 2024 08:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705997669; cv=fail; b=Ha4wSQpO0JPyqn65G1A3DkWBx38EjxNwkm7pIadb7K0gJEa0rX/+lhuqjirkN/xzEfVn3aKGVeKdNMtIwPYJNJOrv5TeMOagB399ErBWNcf+D7KfEpY1SmAZxmLQ5GMwZq75QLrFnuQolPFyOtWwrZQdOF+40UMTBmCxbAH1BNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705997669; c=relaxed/simple;
	bh=qFqby92xeE8wkh4ftZvP+sr2d9aDJ6DFu4WIkpyv8Yc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cjAhFSt8rgFFSyMwRKZ/Fl/uFVExCc9cIiIeWV5AsdhyIJN45OcKuM1Y915T9IQlU3E3WReiRBs4vB98UPcjWk6zFWSyEq+u4uz/dTSGVTYfLZn7KQSndD5mPXD7wmBHo6hsHftD2Bi6IAnEO3FahhJQ9Gkfj7t49dVoa4snhwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=C4oD7ht1; arc=fail smtp.client-ip=40.107.7.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OK2iWVlbxKjtua0pOH0aru4sapEff38Mda6kbZIQgxcwVnWHcy3ifprYue1qEvZRmw4KuSQfeHHbhPUnTt+UosGYghlplpRV4gp5jG5uhA59SVxJkDEOn/zKUYLvZyb1TnNttk5ZAW5Oo/7CXCCghJj9q1uofnqFci0xTw9ASjzJYI17hM7BCgnbHyUW6pCsQWK5kfxSCjODcfDvpHXbFnuh7Q492KyrAkWnNR2nKOx6K9lUSJ8vI6pJGa6w8cMxMVIRSEuclojFtvQhCAzeliXpE7mYSRvnSR9D8Oy2weID6lulKFPZKt+GfNR2JFgli6Pg4bR9IJVkXRUYzLIMXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4FmK7FfNVswVpwX/WAphlLZuqaPmiUfyPSpoeK1IXA=;
 b=RIMxxpx3tpnq0dIQ9Y3Est0/PmhQUVPfLywKpes3J6qeSPtWWAPE0ND+Wj7ZFOET/P36Fkbc+0TxLArD/gU255Lrftziub66nrAJ/jxC4ux2Az5ryWxUX2Kx7ujaAVISdjKwIq8bTbOxE4eAqfL9okItvYS4++CIlkhY86Ht0zhoX0T9yGlWSkH0KWuBAGPC5Q6oCnk3ucXPsxkVTsy2kGZ0X8Myldwbo6KO/32tDL9h3xrdJBryD4vUMsod6GV+/gWfSwsgtme5WXKKfY06/yeQOfK7YyKthblADNwE/yaLcK0Ovgfg2SuHd2+cumLJTU/mrqwQ6+n4qlWdrNZRSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4FmK7FfNVswVpwX/WAphlLZuqaPmiUfyPSpoeK1IXA=;
 b=C4oD7ht1Ab3V/LCufe6FWF/Q+mlSJwRspTQxa/CRVNfXfoOIoDjBSfH9Na2P+7lfSFF3o5evtk9YJn5N0p9qge5WmxEt6R0OmYmMFBL1qQOTHbviZMO/MwKE/hqpThncHgQWdrHDPJfHbbIdud3ct+SUz6GJYyW7tNU/TxCB/RM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DB9PR10MB6617.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Tue, 23 Jan
 2024 08:14:23 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f059:23ad:b039:15de%7]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 08:14:23 +0000
Message-ID: <1c36c4bc-b3ad-4a8a-834d-241d424dbe65@prevas.dk>
Date: Tue, 23 Jan 2024 09:14:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/82] overflow: Introduce add_wrap()
Content-Language: en-US, da
To: Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kernel@vger.kernel.org
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-3-keescook@chromium.org>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20240123002814.1396804-3-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0054.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::24) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DB9PR10MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: d1243bf1-2642-4d97-e767-08dc1beb4ea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4hwLdczxO5/ObW/jtdE+wXg0lv5LUadcrpUyxbmDBWZYGz/yLkmiJm+Qsj9btjuhX4cDRUXFZyONlvXArHnWaffLruQZqA+KYLqcC7tqQ4olSdqLwgBV4AG+OMd272R6ez3jKER9btWZpPFVhrlo42QzFY4xWuN/UCgrI36JQn9q7h0//x/33ju2fXmr5OGz9nXXSHrrpvYR8jd7ackHTSJyNikv8pFuYzvUSuATfa/QeGu0rrKit7U4UqBGOsW5KCtWJV4laGoPRsJn8gtwVnV+2ifnVVrf84iLt0Zi9idzk7fooTHRHBI34aVY/f9yPW3XHwTTxf9l/rm+fG3Xvbuf/oW+60m+UT5OnmwCI69lFZpvi6V6XbWmRc6wW9UD1fj5vbEl/5jbPLB5F+RBeorYnXvBMYn0373l4DX9mqk2tMQcRfZVYS0ftvXbloCpmRL727KPVni/8l5L9/Hw7gwDICzSBU8gF7kQCbRtOZK/KK3AswBtDtBWOQXr7tC6MAdiqutLc1cJEreDFi4AmPZlEeGj+n0eyjwX42WF8A8ZATP00Cm9+B5i//hJB8Hd10LRzZJVmjagfv56X3/4vpiVaEsmRvdP3t9dgteRRNlaDHwnwCiLFg/CRRyESpvBJO+phVOByx38MTYra7TQhA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(39850400004)(376002)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(31696002)(41300700001)(86362001)(36756003)(478600001)(6486002)(26005)(2616005)(5660300002)(66946007)(2906002)(316002)(6506007)(54906003)(66556008)(38100700002)(66476007)(44832011)(8676002)(8976002)(6512007)(4326008)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWs4V0JlM2l5QzFJNUZzbXFHMi94aVBoUFA3cWlzN0tzdWYrMU1zdDlIQXpo?=
 =?utf-8?B?ZE0wSTMrY0k1cmJZcGNnVHFlL21jdERDSE90OC9WVkUzUmFoL081TFdUbHhh?=
 =?utf-8?B?cmtJZ21Ub1VuNWtUc3pvbHBmb3g4ZnJFcHR1aU9rU2x0NTRIZ0VMemdQSkFt?=
 =?utf-8?B?cW5EK25ONlltK1dzUjRaNTJBOVh4c1Z3NTBXb2ZMTTZBeG9RV3dLQVRvbVVJ?=
 =?utf-8?B?emdvVjNPVWVTUWQ2TmpOUFlNd0VRbmI4R05IUFVyQW1LKzdzQnJoRXMvaStJ?=
 =?utf-8?B?T1BKT3BDdXdTM0hpWk82YlhDMmpnQnJFbWdjTkcyeTdtcklEREd2NFFEMzJO?=
 =?utf-8?B?RXQvOXhiQzMyRnRleWZvbEFRaFYvSkRxQ1JTNlZXWTVVS1Zndm5VZjNxQTZE?=
 =?utf-8?B?VW1PMFZIVk1XZnE4VDVQeDdnMHBrSzlnTG9ndmxvemI1ZVYrSnZNSjcwckN0?=
 =?utf-8?B?OUU1RUwvMzF5NFkzc1dxMjJRbHJ3MUNFa2sxK1dUUzFBV2Q1c3AzeG9GVWMw?=
 =?utf-8?B?WGVEUlJrcUw1Z2lzVlJrZEFoOUlpaUtJVnNEZjFsRnQwNzl5aDBxei90Rytt?=
 =?utf-8?B?bnVaUG1raCtGOFZQd3JPK0xkSEp3bFNQMXJ5NmFjL3ZhNzBnZzdkSzE0N0Q4?=
 =?utf-8?B?OGJHZ0lJQ2pLRk1xVDh0UFYrQjB2dFVJK1BlNlRZbkk5aHl5R3dUVDNvaTla?=
 =?utf-8?B?dlJkNWJkSVRjRXZTckpBRDVDK3lzRVdUbjh2TWV4TUt1RXdpN2xKUmZIdFVJ?=
 =?utf-8?B?MmpEM0JyNjJJdE5TWTdsaVV3QUtYcEhZQ1crYlpWV1EvVXlZU3lSZmFYaGt3?=
 =?utf-8?B?SHhSaFNzUUZJQkZ1eGRNelZtYkVwSFVnN3BsOFRuVlYyVit3cTN1amZkRHBO?=
 =?utf-8?B?bXRTNm9YWUk2REwvU204K1BsUER2QlQ3MzM5Q2V3N0VWM0pVd1ZKZ3MxZzBm?=
 =?utf-8?B?UWFHcVpyTkY4MWR2bjlWOTlVcVhQeDZKMmFWalV2YlRaQWFvVTk4Uk9IZzA5?=
 =?utf-8?B?QjhTdUZPKytYTk1QeUgzNnF1eFpTSitLNGJJRHBZdTFtT0tsbzVscVk4dy9C?=
 =?utf-8?B?clBiSS9WSk1yeWhHYXBZV2gxVGVXZ0p1dWNlLzRxU2M2YWY5VWdEeC8zRjVW?=
 =?utf-8?B?UExNajdtUnQvZ1lLaWF5TkRUNHZKRWE2cG1rdWpUY2Fnb0QrR1YwQmRWZGpS?=
 =?utf-8?B?all0ZnFJOVJ0RlY5WnI5SDU1M0Fibit2d211T25scjE1UVFKQmZMWlU3OWhI?=
 =?utf-8?B?MzE3blBNalV6MjUxUUYvUFhvMm5wOXE3TWhLc2hMWkpVbFp6T1cyTkF0Smh6?=
 =?utf-8?B?UktTWGQ4U2tKcjU3QU9yQjFoRU5IbU9KaDdIY2RhVEwvRTE2dzBWb252OXVi?=
 =?utf-8?B?aG1Ld2hEVEFtM3ljZHVZODZnVzgyalNNbkVYZHp1M3liOXVpVVJMVlVPaW56?=
 =?utf-8?B?TTRtUVplRDVoNUtVb0h0aDVEektNWGg1Y3BqbjhnWER6eXhpN3RYUkRZQ2JH?=
 =?utf-8?B?OG55YjdCaENXQ2JYWTl3dDE5Z25aUWw1M2E4aFJuL0dyaG5sSzFBWURMODNE?=
 =?utf-8?B?LzJXUXJaQkpxc0JMNDJLK21STmlEYkRjaSsrTEUwcW82QllLbWR5b29Jcm9W?=
 =?utf-8?B?TUd0N2JOUXBBbWtmNXVJeVFrYnA1ZVZYMXBpTW0wVE9HMGZtWG5IdVlzMWsy?=
 =?utf-8?B?bEZ5c1N2dS9HMlY3WEV0eXhNdTYwK0laK1lZUURxRGFmNkxJVE1hRTlmbk41?=
 =?utf-8?B?b0ZVeHpFOUtjL0pydUNVTFRodE9WcGJxdFc2cU13K2JqbTJvaGdyaVFsWXkw?=
 =?utf-8?B?Z2FIVGd0M3BQSWUyeVhzelBaZW1VZmxJV1hPaFRwQlpMb1ZQNWk4NHpaRXdQ?=
 =?utf-8?B?akNVRDFhRVZQd2JuZ29DYUFwc3c4d2xhdm5zZisyVWFtL1NQKzMrSnhtVVpq?=
 =?utf-8?B?RG5NRnFxYzdPdEQvRmNyVUFqcTVMTWJMemNyeTh3Zk56ZEJxSEJ5ZUdSMEhK?=
 =?utf-8?B?dTBQM2ltRmprYjZIWGNnYy8wMTYrbFgvUmY1TDMxOXkwcGRqY2EvNEdQbm5o?=
 =?utf-8?B?cnR2NTVCekVrN1J1S2VWUVpkVHRWLzAwZFNQMkU1TjN4WTZXSFRYQ1licUg5?=
 =?utf-8?B?MUptZkxlUDYwblRRQUNqSmpoTkNXOUhPc1FTc2kvdWtSb3d4dStuL055QlY5?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: d1243bf1-2642-4d97-e767-08dc1beb4ea2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 08:14:23.1392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +fseUI4hGjws2pDInFtwExmIV4KCmcLFNGFI+dnhNxqBNBaPM4ih7N4u3biYeMApFSbtjxPAES/D2YBxuP467LY5sw721GYkEp68j+cQCfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6617

On 23/01/2024 01.26, Kees Cook wrote:
> Provide a helper that will perform wrapping addition without tripping
> the arithmetic wrap-around sanitizers.
> 
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/overflow.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index ac088f73e0fd..30779905a77a 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -124,6 +124,22 @@ static inline bool __must_check __must_check_overflow(bool overflow)
>  		check_add_overflow(a, b, &__result);\
>  	}))
>  
> +/**
> + * add_wrap() - Intentionally perform a wrapping addition
> + * @a: first addend
> + * @b: second addend
> + *
> + * Return the potentially wrapped-around addition without
> + * tripping any overflow sanitizers that may be enabled.
> + */
> +#define add_wrap(a, b)					\
> +	({						\
> +		typeof(a) __sum;			\
> +		if (check_add_overflow(a, b, &__sum))	\
> +			/* do nothing */;		\
> +		__sum;					\
> +	})
> +

I don't know where this is supposed to be used, but at first glance this
seems to introduce a footgun. This is not symmetric in a and b, so both
the type and value of the result may differ between add_wrap(a, b) and
add_wrap(b, a). That seems dangerous.

Rasmus


