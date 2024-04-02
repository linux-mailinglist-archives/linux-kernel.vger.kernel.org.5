Return-Path: <linux-kernel+bounces-127276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED3089491D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E611F22D2E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0A6DDB1;
	Tue,  2 Apr 2024 02:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="ahChOB9A"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2127.outbound.protection.outlook.com [40.107.104.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7F2BA2D;
	Tue,  2 Apr 2024 02:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712023479; cv=fail; b=QeO5ojd1D15zYiUBAPb0Y8uOnzm6grLNwRDosz7+LwCnhisyKtkFt38rblCCeiVYHoSQNk8Y6upBxzxojGvY1PCnaB7nxIl7CQXJt7t7Mo5pMmODg1Sg9c+Az4nJnsPj6LFCQA+/2eb09hVZFFENcjaVYQ6maHKcrm7fqxXjnKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712023479; c=relaxed/simple;
	bh=l2SCVOOvi/G/VvjbDfHPFl6/y+mq0yaKjT5ZHDmSlSU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GlahKmPWsQxjrPfRJVV5fCRZY7KZAeK4ORytjh7xUJVG9UTT3fljMa22ScBM+8A3ep2FXnZVkzVqVWap3gR03ICaiLoFdNcoBEPUG6iEah5SIfYLF2bqwAqun8R5Ugv3h0J7r39bNXLgSiY4WC8/k0KeBeRMwsdcwfC/7UR8MQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=ahChOB9A; arc=fail smtp.client-ip=40.107.104.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLlNsmebpp395YI5B4lbfic7P5dfphwUTqdXaJID++05LOWbS0O0zCUVFyuJDYHNzKzcw/oFG5pLRhuh/XaYv6R+FMqa+NCaryx6YVaper9q1QwJ74UTnfPuu8wjwn2Vb0xZC7aOTej0kVaow/dRqYxJFt6sSOra5wTWQAG5bMCCahoiHAAPIp5TPA/OTZFOfvlD4ysLzkR7F62ATfuUSKoy54r1zvyEYS4lh2ABkoHuFyMlaLv6Wx4TZ29w+9005GZ4kGj3DDKRD9Okag1ehO2P4x8LmLVxQJ46An5hd3j8/S/Tjs8kM6NtgtpzRPvq7wFXNdzfzUWnasQIaP3k6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARigA/9RSsuHal5GS5YXeZRq/QqORgOuec2CEPDnVoo=;
 b=lWmeRpSaYLAQTBNZ7L2Mvp38jW3EyZahjojXtl0IXb4hNxiJESbBKuq+4Lv1n+Waodq/MUmW4MUsvHVRCiMnOJv406LSofpbTDAqJO0ZZRQTX2GTmJUz6hmSmI8ZWq0pFtiP8ljnQHui4frUPWjFfLx+VRn9FQKWk+S9oLs7J5URNNuC07ssGhVkGKjDFUuPsq7k+pp0H2ksC6u17SsQwz1fC8HaBN1vSxKbMazoMvd3aYlhaEpFMpOX27B+3wiBM0HotuCHDsciDKAmcYPrg27cVrJU20l/WhcX7rff6GxBZQX/gJxrlv++AhUY/mmGFYP6CxkPdEaXtn4xFjQgTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARigA/9RSsuHal5GS5YXeZRq/QqORgOuec2CEPDnVoo=;
 b=ahChOB9AeIeIYKmT2qxliO8uIgLX1vJTwT6yIG/kXV214l0AoqjVchHPq+lnzbD05sWXwqG+61mOjQIZZb5jH7VbXKGRyPwQRd1Q0sU89+UHkIn3mHEtHpRkBXdZd4EqBLRW+G87+sVtp/CxM9Oab3sx71Sy6S7k3uI9iziTw78=
Received: from VI0PR02MB10536.eurprd02.prod.outlook.com
 (2603:10a6:800:1b9::14) by DB5PR02MB10235.eurprd02.prod.outlook.com
 (2603:10a6:10:4aa::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 02:04:33 +0000
Received: from VI0PR02MB10536.eurprd02.prod.outlook.com
 ([fe80::8baf:bcd1:cc88:2e09]) by VI0PR02MB10536.eurprd02.prod.outlook.com
 ([fe80::8baf:bcd1:cc88:2e09%6]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 02:04:33 +0000
Message-ID: <ff34e22e-702f-acc9-469d-33f092bf20bd@axis.com>
Date: Tue, 2 Apr 2024 10:04:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] power: supply: bq27xxx: Divide the reg cache to each
 register
To: Andrew Davis <afd@ti.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Hermes Zhang <Hermes.Zhang@axis.com>
Cc: kernel@axis.com, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240306100904.1914263-1-Hermes.Zhang@axis.com>
 <c4u27576oazfrlcp5avy3ect3i4jlsmdvi7nlun5qvez3ipti2@ue5jxbydmevs>
 <c3c219ca-e126-42fb-8f20-5df0dec58d7c@ti.com>
From: Hermes Zhang <chenhuiz@axis.com>
In-Reply-To: <c3c219ca-e126-42fb-8f20-5df0dec58d7c@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0175.apcprd04.prod.outlook.com
 (2603:1096:4:14::13) To VI0PR02MB10536.eurprd02.prod.outlook.com
 (2603:10a6:800:1b9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR02MB10536:EE_|DB5PR02MB10235:EE_
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Kpvn6gAYPfHgyJq4oM/tyaEX+ih3z/MJJqtXoCzAlSEwvOE1ax1X/y4zuimCXSnBS2RA8V/Kdspt9ohLhFIghb+I5ujRx7ZldAEnt4M1EiXbpWokk0iSZxRcxHGcYGgahnoEL4EjP7LrZ4AgA26rIZWeP+by5i3CQ6G2uR5EIRHnS72lEqyGvSLdhHETd6+q2uJ9ckvvXKBgJj053CYmBAa4t+26k9LkxJfR7s2oa4gkoJLAYcBaGBaGB7sM0CCFr896paeeT8VeDZEaFYYEj/iodf625OOp5CXHXOwCXdZxJ+teeI5MGdFQHtkvrxlQzM42x1nqAMnwzgEaT6RENQiWIFiu8r8088CqEC86XLM9FstzXqOb7xONuSJGS7rIUAnrrqdbKjgjwct3lUKSNltVjHuGYMQqdolCq8tbYKiWIKRfHKjM8BROSfLuRELsDKdEmYUIJJ/fXX/ynfOKxegOfnEX5w5MWbpcCwmpd6kQLA4zp9fA3AyYk5gQcChV1I0ru6dURpnpiIdoLK6KOXjP8MuHkdZgfBniTzbjFomaiP8cP3e+ut+kgHn+TNoLy3wleS15zckqxFwpcFDbxw0/XxwkU8XbDNIlNKhTv04aztncaeD5vTbcLMUpPNC2qovx+1kdL+J2vUyNBC6xxBGD88q0CjsVRKzMGck75h0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR02MB10536.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmtnR3BQVzZleTJEdUZSQUg1YklqNnZpZ2FhZkFwa00vSDdTRFpDSy9lVDBr?=
 =?utf-8?B?OFJBYisvUU1LdkhwdDJDcnlUbWdOazdRNWp0UEhYM3JzY3VwQ1hCYUJQWVUv?=
 =?utf-8?B?YU5HZzliV2NmeGtzTG9kcHhuNEZZbnFDSlp3cXhqSjN5ODE3cGZiK1dIK1Fo?=
 =?utf-8?B?UXMxMTFYVzcyNTUvVnNnNmh6WENnanYwejlqdWx0ejFGR3FPL2FITlp3U0V5?=
 =?utf-8?B?Y3UyNFFUa1lOd2h6ci9BM3lHQ29DbU4vWXZPb0RlTlBnSGoxeEpxVER6ZUNl?=
 =?utf-8?B?TkJ1NUFOck5CTm8wY3JMYmxiTlRCcGJqdEJJaXVqSzlSMVI1TEUvVWd4ajNU?=
 =?utf-8?B?NUZFK0UxT1RJK09EbFFyT3pzaWRPUFhGcGdjU2JHNk0rK3dFWXd3UCszNXRE?=
 =?utf-8?B?YXBUQkFlYzZsWlp0dXNteks1N2ZyUHRjWWx5WXBZZzVSWWl0eGNQZGxxM3l6?=
 =?utf-8?B?S1FNRzEvTTJDY2s0QkRiRisxNm43cjkvbENrelBvNit5emU3OHprdnNXeWE5?=
 =?utf-8?B?YUFXcjB6SHI2eDVTbHI0dGg1UHQ1Qlp3WlVtUDA2ZnlJSUFpOFMwZUZOVHBO?=
 =?utf-8?B?UjhnQWtackVEV2h3K2xDOEZxMmlnVElERkgwMWRhQjVSYlJEd0liNVkrL3dV?=
 =?utf-8?B?Mmk0S0tiWlZFWFdzdmFxNEJCbExIWmc1V3RoL0FGN0xBbzhuTzVBQ01yZS9R?=
 =?utf-8?B?dlVveDRjYW40ejhGSXM3QzNiZitmbEM1OUtNTS9jSytpRCs2eVFQTE0zNXlj?=
 =?utf-8?B?UDJEYStvK1E4QWJJRk5seFd4YUl5YmZZTnhaaHowS1hrTTVGbUZidjdTcjlp?=
 =?utf-8?B?TEwyKzNlNUUxcWNQRWlCbkVhN2ViOXo4UXlQelU1d1pjZEF0SVFSdktqUmEz?=
 =?utf-8?B?bE1GZEhKQ0wwT3Z4L1hoWFhudGtHOHhDcGJkUG1OTUUwb054ajlmVzdqeDlp?=
 =?utf-8?B?cjM5TTczOTN0UVYwbkkzNWRlZURPWE5IV3VqSk5qb1dFejNVKzFHNUp3VHU3?=
 =?utf-8?B?OFUvUFVWdjRRbUN2VTY5dHNSVUNtY0VlaDlkSFY4dnJ1MGFvR0F1Yk5xV0Nz?=
 =?utf-8?B?emlGYnFNa2JnYWJyRWRaT2M3WXZLNGg1QWQ0UDNmMXhEVjZ2bENvT3pPOWxG?=
 =?utf-8?B?czBybndNNVM3VGp3ZjROZ1c4NHR1enUzdnYxU3krWkN2bUpVUkVMeUdlK2Q3?=
 =?utf-8?B?Wm9hT1N1NEVZVHR1SHdjdDduTXpCZzF4UVdZQnczM1NSN2pjU3RZVW42dEds?=
 =?utf-8?B?SjhFdnBxMjJpbks2ODRRdU1ZVVBHVU1WU1ZtUUFTTlBhNzcxV2hINWZqbnFL?=
 =?utf-8?B?VXhlcmo0U2dQN2lUamRpblp5Ym05d3hSWVM5VlpqR1pVV3EvSTcvZTcvTFlP?=
 =?utf-8?B?S3pPNFppcUs0RkNBaTRrVGJaUTVPc1F5SmtXV3I0V01qd3pyVWFjYm8wVncw?=
 =?utf-8?B?MnFNZ093OG83UE1pNi81Kzh5YnJKYXBVTVk1ZzY0SzFJOTBoUEZJTU5ieGZO?=
 =?utf-8?B?bFJsQzZxc1h3ZlFISXNjMlMzbFhhZ3d3Z09WeFBQbjVDVGlsYTZFUEFMNWVV?=
 =?utf-8?B?dUh3SmtNYXFoRG1iSEtHUnlGSTNwWnNCTGpkbm9KSGpKZkZkaFZabnZVODVZ?=
 =?utf-8?B?R2tMUXhVdTRYekxpU21GWWdkekhXbEEyc3RTN0VmdFhZY0lwOWZTaTlsZkFk?=
 =?utf-8?B?VGkzVmF3aWxZNkM5OHpkcE1pRzB0WGEyY3NIeFpyOE9zNEtBdEFBY2ZmdHJi?=
 =?utf-8?B?N3pjaVNLOWNHalRSVFc3L20wNk9ZeHhPaytXSlJ2Wk9QaVprTVJYMVU2TXU5?=
 =?utf-8?B?enI3YzZ4ZHAwLzhDdk12VzRRSXQ0ZmJtRlgxb2NBT0RqQ2l5YWFRQ2lOemc2?=
 =?utf-8?B?WTV1QXV2TDVxekhSbTIycUpCZmh2a1RMa28wNFMvUTZRY3VxWThoR3Eyb2hm?=
 =?utf-8?B?NVpNTko2UzMzanhJQVVFd0VvV04rL3Z0Qmt0bGYzM3hoVlZvQmVtcXI4SXBp?=
 =?utf-8?B?VTMydks0WVNlbTlYZ0czMytSRXVuTFZWTVdSKzlHR0tDYnNmVG9sbk12dzBY?=
 =?utf-8?B?cHRsTDRMNGg0bFRRVFBXeWVLT2xnRVJ2ZnBoZ1dkeVNjUk10MzhNSFFMdGVs?=
 =?utf-8?B?eC9zWEx0M2FjbUhBVTYvSUZDRDhFY1daRVpJMmNsY3VhcHhuMHk4ZFJkK3lM?=
 =?utf-8?Q?2MubxypGdtQuwpe5RSH521S7Saac57UfX+Hkbli0SM58?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8c7ddf-e221-433d-43a1-08dc52b93d28
X-MS-Exchange-CrossTenant-AuthSource: VI0PR02MB10536.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 02:04:32.9559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4cx2GZsadN6E4MorY5oRJ4WlgHS6Xy0Hb79D0iYzLfmP9A1ZQTDP7UC/WBTY/UpNimB3eXgJYhNvrZlb9dXLVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR02MB10235

On 2024/4/1 21:57, Andrew Davis wrote:
> On 4/1/24 8:15 AM, Sebastian Reichel wrote:
>> [+cc Andrew Davis]
>>
>> Hello Hermes,
>>
>> Sorry for the delay. This arrived too close to the 6.9 merge window.
>> I had a look now and while the patch looks fine to me on a conceptual
>> level, it did not apply. It looks like you used a pre-2024 kernel tree
>> to generate the patch against. Please always use something recent base
>> tree (and ideally use git's --base option to document the used
>> parent commit).
>>
>> Other than that I just applied a series from Andrew, which cleans up
>> the register caching in bq27xxx and removed most registers from the
>> cache. That's something I did not consider earlier, since I thought
>> the cache was introduced to fix a different issue. But that was
>> apparently sbs-battery and not bq27xxx.
>>
>
> The original BQ27000 device did not have an interrupt pin to signal
> when important updates to the battery occurred, so early devices
> using it would have userspace poll those values. As the kernel driver
> added its own polling for updates, it seems the early driver authors
> simply decided to cache the values between kernel reads and return
> those to userspace when it reads.
>
> This is a problem though for two reasons.
> 1. If no one is interested in these values the kernel will still poll
>    them anyway, wasting I2C bus time and power.
> 2. If userspace is actually interested in some value and so checks it
>    often, it will only get real updated values when the kernel next 
> polls,
>    which might not be often enough for some use-cases.
>
Agree! Also good to know the history.


>> Anyways, there is only two registers left in the cache now. I'm fine
>> with having a per-register cache for them, if that is still needed
>> to further reduce I2C traffic on your device.
>>
>> And... re-reading your problem description, I wonder if we need to
>> reintroduce the caching for all registers (on a per register basis)
>> to avoid userspace being able to do a denial of service by quickly
>> polling the battery information.
>>
>
> Preventing a DoS of the I2C bus is not the responsibility of a
> given driver. Userspace has plenty of other ways to spam the
> I2C bus if it really wants to, no need to try to predict what a
> system's admin would want and block users from those actions.
>
> If we really do want to reduce I2C accesses for registers we know
> cannot change often (which are few), then we should use the
> existing regmap_cache mechanism, not roll our own. This driver
> is complex enough without re-inventing the wheel and adding
> our own custom register caching scheme.
>
Yes, actually for our case, we have already reviewed the access from 
userspace and optimise it, then we found the driver also poll the 
registers quite offten and some of them are not really needed. Now if we 
think it's OK to remove some of the registers from the cache group, then 
it's great and much simple solution than mine. Thanks for the patches.


Best Regards,

Hermes


