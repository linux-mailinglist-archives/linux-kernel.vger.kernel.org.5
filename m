Return-Path: <linux-kernel+bounces-157003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E6F8B0B77
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7441C1C214AD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCAD15D5A5;
	Wed, 24 Apr 2024 13:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ILc4bfp8"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AAD15CD53
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966576; cv=none; b=Vl6wsEp4+KQVOWZwmMl3PoypJ/D+93Ud56h+/YJw6OecADb3MBrZm0bqBeK0ZWnARHMBBgvxpyGXFGdwK03WW+32Lmu5BqGJ9aoj0v3UKkL5c2HzO/0GWuIghn90Bbojiym3+EMW1DbBI0jqwcDmMJmXVzgUDK6LaKYU/yz98kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966576; c=relaxed/simple;
	bh=BnENuuyvSSnIAyXgtHVPeaIV5FuuSZ0qrZUG3zD7EJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fhejNB3f35GsdL5nmPpkUBK+Ac7doVrdDz2nCDk5JUttODevXpdN6jkOdkC5Ucs5pyZHge6slLRakbMvlv5ZP5kMunOUNCRulvxN5AjkUP8twvLpegcmyMQfnadNiWs9SDtlvG/p+wbID1aGOLZCAsGNDUBX2ppZ1vQLTVyTcTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ILc4bfp8; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e2be2361efso1614075ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1713966574; x=1714571374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JCs36F0PWzr7cYBSvNxUQg6C6ceYxo7oYx4QjH9HBWk=;
        b=ILc4bfp8fUrmB+qMM2c9nlvnNBFqIbkhrCEgX2YFwXXNsTL91XDTDGAK53fhHBsf9G
         UUdmj1Xl8+D1HoazinJIsNm4qZyJiCBtM1SnX7zVFDOPlmNqdYphGzuBoELhKQxhmnlB
         ubU24Wk2X4BQDrefkCPFSt2Ow7Y9EI28TdudM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713966574; x=1714571374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JCs36F0PWzr7cYBSvNxUQg6C6ceYxo7oYx4QjH9HBWk=;
        b=khzgodbW9+POLJGyzp3szQfeeX154Cjt8Ws9HMd4QTF2FRn7Hdm/JywkIYEk+7qFky
         WEtWTsTZkubCMnyDjLgBOgkIhK98b72QqEwZO4sbcrSFv5MeU+u87oQ2BRVLbYoKDMdU
         Toebu8uuyd2Uv4doW92E/ZfCIEqupQGiInxtMfOD03qFu1XoY2lk1BTUqWAwjjb3atnm
         zH+lzsMp0Ny8V8w0V6IYNk13Dp6yjZrjlPaEaeSYbASoxt+0CQKMVz2/1XagmDBia3qX
         oYLjBcOy6G4iY+h3O8Bn3PUEPQCl0jjVHUDLCQd6UmNsw+W/SfGjDLxLLxS5/gAbf5Hj
         FI7g==
X-Forwarded-Encrypted: i=1; AJvYcCUmmDXS9EdICM/lNVlPgHdn0dYK+633AOszK7ULT2Xed03MQquNxWliMek1XoL+Ucf7Yl900yxIWH5ZZVEQPLu9M4pUvICcUNAGQMOI
X-Gm-Message-State: AOJu0YxHNCAidVRWcbuqGmaCBmUJUfLQOLLsxcI7ErPKTDyhtSTaG2OK
	iUPjEs+TCQhAIJQsPEzuq4ZbH3aeB8upcecyYFhkR9hMeWj6xxFIjTTeclPCPl4=
X-Google-Smtp-Source: AGHT+IFiRaCL23pbSU0/Yn84eBCvHp/itg92YZttsTK+6l+gegZ0L2tqoYX/jbPAg4iNh82grdXwqw==
X-Received: by 2002:a17:902:8495:b0:1e9:9ffb:bab with SMTP id c21-20020a170902849500b001e99ffb0babmr2583007plo.5.1713966574470;
        Wed, 24 Apr 2024 06:49:34 -0700 (PDT)
Received: from [192.168.43.82] ([223.185.79.208])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902780300b001e7b8c21ebesm12087790pll.225.2024.04.24.06.49.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 06:49:33 -0700 (PDT)
Message-ID: <cc46c002-c771-499d-96f7-38db978ae975@linuxfoundation.org>
Date: Wed, 24 Apr 2024 07:49:27 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/16] selftests/resctrl: resctrl_val() related
 cleanups & improvements
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-kselftest@vger.kernel.org, Reinette Chatre
 <reinette.chatre@intel.com>, Shuah Khan <shuah@kernel.org>,
 Babu Moger <babu.moger@amd.com>,
 =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240408163247.3224-1-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240408163247.3224-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/8/24 10:32, Ilpo Järvinen wrote:
> Hi all,
> 
> This series does a number of cleanups into resctrl_val() and
> generalizes it by removing test name specific handling from the
> function.
> 
> One of the changes improves MBA/MBM measurement by narrowing down the
> period the resctrl FS derived memory bandwidth numbers are measured
> over. My feel is it didn't cause noticeable difference into the numbers
> because they're generally good anyway except for the small number of
> outliers. To see the impact on outliers, I'd need to setup a test to
> run large number of replications and do a statistical analysis, which
> I've not spent my time on. Even without the statistical analysis, the
> new way to measure seems obviously better and makes sense even if I
> cannot see a major improvement with the setup I'm using.
> 
> This series has some conflicts with SNC series from Maciej (Maciej has
> privately agreed to base his series on top of this series) and also
> with the MBA/MBM series from Babu.
> 
> --
>   i.
> 
> v3:
> - Rename init functions to <testname>_init()
> - Replace for loops with READ+WRITE statements for clarity
> - Don't drop Return: entry from perf_open_imc_mem_bw() func comment
> - New patch: Fix closing of IMC fds in case of error
> - New patch: Make "bandwidth" consistent in comments & prints
> - New patch: Simplify mem bandwidth file code
> - Remove wrong comment
> - Changed grp_name check to return -1 on fail (internal sanity check)
> 

I can apply these for Linux 6.10-rc1 once I get an Ack from Reinette.

thanks,
-- Shuah


