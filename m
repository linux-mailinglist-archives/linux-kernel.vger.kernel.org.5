Return-Path: <linux-kernel+bounces-150839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E8F8AA576
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1C18B22495
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D719F1EA6E;
	Thu, 18 Apr 2024 22:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dqr0v/gR"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8A317D2;
	Thu, 18 Apr 2024 22:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713479633; cv=fail; b=BZmOH5Umc5GjVEIk6+714aTV8L2/CZ8n427l1TitjXYATbrKy9uzt3ivvppGKCW8+ACERBpeemg9+Mhbaf2ip2wd2weg8JtQ8bDj9Ven0SKQ8er3wSsLh2sbiJiwcgHKK/GQA/M4+kZM/iqR9YexB8zP7KNgu2+PohpLed3J4+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713479633; c=relaxed/simple;
	bh=YZ4smW1ZSi26v/jXc3HHiWjd9wmZ9X3Kh6R/uYpcdpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BIQdZN6eDnT1RxirPmcDIIMgB85XgQC7DZ03ERKTRvDoifoTMJJhhtdap0+BnOmxUoDqwU7J8tCAuUhJQ4BMRdvhepBULJUXVs+MUQvGGlKgha09DdFSPvfhU/jNdeefOUgZFzJokAy3pAv/pHqYZLN1wLXF+zg0xNkZYd2da7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dqr0v/gR; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DE8hmUinfAd2wA/VV55Ug4oGTlLq0A9RwkQF3cnQGX9dajU3vhQ9Ys6Ts6028uQ8ax+coYxPaGzFMLIvWLuJlmQDKeoEYGCrTyO2xzQ5h8xjPiC3MHDi3y2BxQY873EKpasGM80P9nD7YfSur+DCg5Fg0C5vQA7s5Rrta0Y3opWT78cH8nxev76GCf0R4MwFOqJssD5yD/Xi6OCF0AJv+FEmnnK0plVJ7F//ctrLqs8unf3zl0+lIJrPVOCqtqx815bqG42jJTYX1rljseH4gftRRgqQOHnl9assQwVUBn5BZeQpnqvrNNb7dI10tchqwXOIVlzRH13Cy89SUlaXbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ml2DOiG9QdROq95LnfHa0LdOaopTDiTB119ItD6r5Uc=;
 b=N04VkHvHXGItryvmI3e15YNQ88UCyC5yrq6iFLH1rzjgB9yjGKCQktaHEuxLoy66xJRrMoy+E9943D58rtjIXM893h5yqf3IR+k4gd+Lt2XsHqXWMki/m1dOcEYuOk9mZJnLx2WIzD3wbrOZO1dPohCOjaiA5j+ZKjqMg/x7/nhQZaMY/78DrStrkxJ1QXWf3kRR0G+5O11OY5HkohRhaDaIODxaQw7GbmPAVCxVAQ1VbOv7P80DRNLhxOXLaMb5UnY3iZiNfG0kk3pjfxWF4wn+y2t9X8CGQpDz6BHOIkgwDIFyDrSYVzgsJ3g7ET0txfdzrmSPcl5Llrpp5AKakw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ml2DOiG9QdROq95LnfHa0LdOaopTDiTB119ItD6r5Uc=;
 b=Dqr0v/gR1UhtSwcTRAhX8TP1V0LevfgeUEki8hoBAqZbwBr5vvpO0bANj6BqNT/GWthtnQ7nqzMLFg7i/39tepJxHpxocWsMqktFVk33IDXe5mcmccN9mxSHxTn5gdbsmEc5/kgfvTU7ldgpf5CsdjfEJ3gfCmA3I87Up67TvCi+C2NtZ4CYwVNi4oQtgxbuvdEBSlL1fdpqUrcgRqiChoLlYfsv3b58afhEd1L4c1rbOz1+EqkhURguTakXKd2pjwPdbx3Kr7RhmpbklDSX5uXSBCdY0ZS83iyQCF729ZTP9dJntaw35zNa28z0gCUHyGtgYYxtEDzdr+Iryo+XOw==
Received: from CYXPR03CA0082.namprd03.prod.outlook.com (2603:10b6:930:d3::10)
 by SA1PR12MB8888.namprd12.prod.outlook.com (2603:10b6:806:38a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 22:33:46 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:930:d3:cafe::b0) by CYXPR03CA0082.outlook.office365.com
 (2603:10b6:930:d3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.28 via Frontend
 Transport; Thu, 18 Apr 2024 22:33:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 22:33:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 15:33:21 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Apr
 2024 15:33:21 -0700
Message-ID: <4149777d-d8ab-43aa-8de2-f240fee2ba2b@nvidia.com>
Date: Thu, 18 Apr 2024 15:33:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: coding-style: don't encourage WARN*()
To: Eric Biggers <ebiggers@kernel.org>, Alex Elder <elder@linaro.org>
CC: <corbet@lwn.net>, <gregkh@linuxfoundation.org>,
	<workflows@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240414170850.148122-1-elder@linaro.org>
 <20240418161430.GB2410@sol.localdomain>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240418161430.GB2410@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|SA1PR12MB8888:EE_
X-MS-Office365-Filtering-Correlation-Id: b325d0fe-5246-45a3-4e41-08dc5ff79c29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H+HI3/dH9cnKM5HjEL9WdBoXePNLLRPmCVa5fSzVCDtElnrg1wYuoWUGowTw9v2vsc76/NbidEeRDtE7UnVyURP+jPJby45e7LSgm4LLWjFFuFt9coKSk+UdcGpvOegIlk+sZO/weox087ZvcCssVfc4VHpZqusNTwu/45FabtVt29n7uasdCO5RbFDSHWMPnvWwwdHU4Wdr9pUeU4jJjq/qXovA/f0qWrep3hS+tnZX6wXOByUaZNNajaBbuUL4UcSPaVQaZLSfdOtCmS21bCbokbjvLqJCB8IMZE6l5o8EBuvbj1MMr2+jjzxqPsdHuyWKu+/8M9v22S9pdXFyBqvy/RPgL36qmlYV/BmMMkkYawSaIlQ4JPu4kPc7vd3QDjZRxJeLXkV5zFmEVMxtn88AUzKZs7FwvhY/HNjKgPa0FbaUhP4TU78Ng4itMfFIMmJh09rPdH4zmYKodo2/LZKP5EkPW54m3Qhll5ZuZcelVRXCBSxAhDC+OtpMGnisoAcJMEragoPlVfs+yKzsOOrzrrSP+yF8Ptg0hhVph5GdapQe2OBd02DB2xVUxJD8CP5rZQg/Ju1EfxKsYlS7mCQxqSJJQRC3/O2OcwcwsLtj0SjqeTmEQ9RDSM92nvIM5AqcRSIEV8+f/SnFUUqviSujI/mIigfeEiqdR36kqRjMBkk/U6Dwwa/ot69zw0oXd1mZYVuKe20IOppzS5TwWjCj/rVWL3tYnRPquSjz/9848lltodLdnFjMnaNkVSNj
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 22:33:46.0187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b325d0fe-5246-45a3-4e41-08dc5ff79c29
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8888

On 4/18/24 9:14 AM, Eric Biggers wrote:
> On Sun, Apr 14, 2024 at 12:08:50PM -0500, Alex Elder wrote:
>> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
>> index 9c7cf73473943..bce43b01721cb 100644
>> --- a/Documentation/process/coding-style.rst
>> +++ b/Documentation/process/coding-style.rst
>> @@ -1235,17 +1235,18 @@ example. Again: WARN*() must not be used for a condition that is expected
>>   to trigger easily, for example, by user space actions. pr_warn_once() is a
>>   possible alternative, if you need to notify the user of a problem.
>>   
>> -Do not worry about panic_on_warn users

This is still[1] good advice. panic_on_warn users have made a
trade-off that works for them, but that should not mean that
all of the valid cases for WARN*() suddenly disappear. In fact,
without the WARN*() calls, panic_on_warn is a no-op, as someone
else has already pointed out.


>> -**************************************
>> +The panic_on_warn kernel option
>> +********************************
>>   
>> -A few more words about panic_on_warn: Remember that ``panic_on_warn`` is an
>> -available kernel option, and that many users set this option. This is why
>> -there is a "Do not WARN lightly" writeup, above. However, the existence of
>> -panic_on_warn users is not a valid reason to avoid the judicious use
>> -WARN*(). That is because, whoever enables panic_on_warn has explicitly
>> -asked the kernel to crash if a WARN*() fires, and such users must be
>> -prepared to deal with the consequences of a system that is somewhat more
>> -likely to crash.
>> +Note that ``panic_on_warn`` is an available kernel option. If it is enabled,
>> +a WARN*() call whose condition holds leads to a kernel panic.  Many users
>> +(including Android and many cloud providers) set this option, and this is
>> +why there is a "Do not WARN lightly" writeup, above.
>> +
>> +The existence of this option is not a valid reason to avoid the judicious
>> +use of warnings. There are other options: ``dev_warn*()`` and ``pr_warn*()``
>> +issue warnings but do **not** cause the kernel to crash. Use these if you
>> +want to prevent such panics.
>>   
> 
> Nacked-by: Eric Biggers <ebiggers@google.com>

Yes. I agree with this NAK.

> 
> WARN*() are for recoverable assertions, i.e. situations where the condition
> being true can only happen due to a kernel bug but where they can be recovered
> from (unlike BUG*() which are for unrecoverable situations).  The people who use
> panic_on_warn *want* the kernel to crash when such a situation happens so that
> the underlying issue can be discovered and fixed.  That's the whole point.
> 
> Also, it's not true that "Android" sets this option.  It might be the case that
> some individual Android OEMs have decided to use it for some reason (they do
> have the ability to customize their kernel command line, after all).  It's
> certainly not used by default or even recommended.
> 
> - Eric
> 

[1] https://lore.kernel.org/lkml/0db131cf-013e-6f0e-c90b-5c1e840d869c@nvidia.com/T/#md6836102150ac1e6265569aad55a692e3af75f34

thanks,
-- 
John Hubbard
NVIDIA


