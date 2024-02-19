Return-Path: <linux-kernel+bounces-71359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0272185A3FE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844111F24665
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A16360BA;
	Mon, 19 Feb 2024 12:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UpPC2RyS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A911334CDE
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708347589; cv=none; b=C5Y7nTMdpDzxcKVZRsBjPb04H/GRnc13m/9UsoxJL34us8n+zBeIQxPhBSGLvEstMOIMDQ0zC1DSrRNmNUpQku9MIEwHDyLnzwgnLRvjLRdwvdWq5943po9z6MX1B2fq/FBKzsvtcXQBRz7L4ppEcY9BW0Bi7bdFvV361gNeI0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708347589; c=relaxed/simple;
	bh=3Fi65QIGXfdHgZ04kFVl3weeoPhyvqfKbrI6gyowmVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sPEFTmp72LMAkkZOrcHEdLT8JdFDbiEMEBfUM5PzgYAt5NAnwKH28KYUzid5zMnuV51a49JgABHxu4tXdORLAYkNzPVFEGtfegHP6QfDSGQx8hZq4nR+3SsUI2e8qmzmbH0z6xNRESMQzI9R/JyQUcHvgtoIzJEhhTy465B1bYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UpPC2RyS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708347586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nMxKeQCC51WbQZLbi5a685VF0mibFkff8D67rJw7soU=;
	b=UpPC2RySwdQtHBpFs58kkNvzz+EDP1k97tfaOaKRyfEQXjd059wC2Elf6xcq4g3uhBZgJP
	74YY27x0SE1xcRKnOM1vU6uh/ilPpHh+kAhqYMAjuN7qIui4bEHpgvGZTuesTzrQbGqsDR
	52q3/CVoyHUfzUsvm9jNR8ydkhZQEns=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-EzM1hemWOQOpSh1QDP-PiA-1; Mon, 19 Feb 2024 07:59:44 -0500
X-MC-Unique: EzM1hemWOQOpSh1QDP-PiA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a3ecd8d3a8dso29595866b.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:59:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708347583; x=1708952383;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nMxKeQCC51WbQZLbi5a685VF0mibFkff8D67rJw7soU=;
        b=XEItN3oU9Pu+VgRDqyUlQPpwv0N+75wDaYTd7AAPLdSuERQmq/6uJ21x6h7X77X9he
         v4d6w7RTDD56xtbtx1G1eMjoQfNNgWjnk8XLRPBi4XQn1ynCMfp4W3kY0ViFaCfK93ud
         c+h7NlYrmDdoD5fuUITv4xU1xM3BVeQZXmxdjCbNmKmnECXi8l0FHPWDGmt8XNDNq5PG
         7MU65ZkGHT+aa123oeiQJzjzFklXVbMSs8j2suKMzzTMQgM2cWFvVbWdKUrU3l9x97X3
         qleIIBNy4jsilOIFnK8u/RiTT3asXu4An+R5CMGdDpTYKIAT9Cq8uB/Js+hzcJcIG5FY
         78bA==
X-Forwarded-Encrypted: i=1; AJvYcCWhPGV+RtzcWgITqecs1mK9Y5svvUgziwP7JxJquMq8iONBxqM1NruJEB6Zegdp/Xe6Wo2Bv2UULey/fcSVtEiv0BqMxiupuxviVZyd
X-Gm-Message-State: AOJu0YwoJld9EqgyOLYFbdGXzPqQ6AzdLO9QZWiJFrGBTaMpWHSRssO/
	Cy0K+72bqQrLWWrUQaK3z1JbFdnyInZXR5g2takXdPwC2jHFhWBx953Dn06fcGQQGQ/bJ/ufw65
	I0yP7ohKWrk5PeBMWDZ4xMlP7OhELmH/qjjazMwmpWhXZxYU51xNfBpek0JDOXg==
X-Received: by 2002:a17:906:718d:b0:a3e:7cd8:3db7 with SMTP id h13-20020a170906718d00b00a3e7cd83db7mr2495942ejk.68.1708347583633;
        Mon, 19 Feb 2024 04:59:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0lzjx1aAmMTv/0aa0dQdKzvgpfGRNniCzHwLJhmH2u8A2FduKGrk8NWgLHabH3q9tu/SZwA==
X-Received: by 2002:a17:906:718d:b0:a3e:7cd8:3db7 with SMTP id h13-20020a170906718d00b00a3e7cd83db7mr2495929ejk.68.1708347583325;
        Mon, 19 Feb 2024 04:59:43 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a19-20020a1709064a5300b00a3e2b0799e0sm2404226ejv.4.2024.02.19.04.59.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 04:59:43 -0800 (PST)
Message-ID: <f0f64e2d-5e6f-4a3b-b57d-e617142eb08c@redhat.com>
Date: Mon, 19 Feb 2024 13:59:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Only update profile if
 successfully converted
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240217022311.113879-1-mario.limonciello@amd.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240217022311.113879-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/17/24 03:23, Mario Limonciello wrote:
> Randomly a Lenovo Z13 will trigger a kernel warning traceback from this
> condition:
> 
> ```
> if (WARN_ON((profile < 0) || (profile >= ARRAY_SIZE(profile_names))))
> ```
> 
> This happens because thinkpad-acpi always assumes that
> convert_dytc_to_profile() successfully updated the profile. On the
> contrary a condition can occur that when dytc_profile_refresh() is called
> the profile doesn't get updated as there is a -EOPNOTSUPP branch.
> 
> Catch this situation and avoid updating the profile. Also log this into
> dynamic debugging in case any other modes should be added in the future.
> 
> Fixes: c3bfcd4c6762 ("platform/x86: thinkpad_acpi: Add platform profile support")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans




> ---
> BTW - This isn't new.  I've been seeing this a long time, but I just finally
> got annoyed enough by it to find the code that triggered the sequence.
> 
>  drivers/platform/x86/thinkpad_acpi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index c4895e9bc714..5ecd9d33250d 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10308,6 +10308,7 @@ static int convert_dytc_to_profile(int funcmode, int dytcmode,
>  		return 0;
>  	default:
>  		/* Unknown function */
> +		pr_debug("unknown function 0x%x\n", funcmode);
>  		return -EOPNOTSUPP;
>  	}
>  	return 0;
> @@ -10493,8 +10494,8 @@ static void dytc_profile_refresh(void)
>  		return;
>  
>  	perfmode = (output >> DYTC_GET_MODE_BIT) & 0xF;
> -	convert_dytc_to_profile(funcmode, perfmode, &profile);
> -	if (profile != dytc_current_profile) {
> +	err = convert_dytc_to_profile(funcmode, perfmode, &profile);
> +	if (!err && profile != dytc_current_profile) {
>  		dytc_current_profile = profile;
>  		platform_profile_notify();
>  	}


