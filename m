Return-Path: <linux-kernel+bounces-153451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFA48ACE42
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8DAEB23E36
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5DD14F9EC;
	Mon, 22 Apr 2024 13:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RlPTTE1m"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E0714F9D8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792698; cv=none; b=OfEjZj4KTtl0ukqdJRmkjLDMqb2J2DNXzEKW0lNdTUiIG/GsLpSVtv2Dj6Qx744Ny8TH4WrAUHUKs93N9sHEseQoO/vL9RdT+p0O74oCdfOL3eJSikqxAa/ozAiwMorHiT520JPTFHUC4TXsU4/Nw8Z0zTEj2BFISh76ayb2x5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792698; c=relaxed/simple;
	bh=ev/31B2OZtxrY8N9FP0SG9Dm3wjCKTeMhKJJbJnoogg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ScrgPG0jRHthb/Ontpxvn8V9Jyzq0DvCRmtL+HC/FnM7XsNaa3rpLn1FSV+7HmM2jqk350GmkewwawGLUdk/h4l5VC5gq6mJp7rHE+I1J/DAiKaqglLL+ZyC7iMH6Fkh49YXAcQtzG1ji6vLFdeGsYVMfZUnbz4frJjVzY1CnoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RlPTTE1m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713792695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rhXisW7GfhDn4x5RJVdbAZG0rJy8YwZlKBxKJjOJou8=;
	b=RlPTTE1mQZxV/L7VxvIW8ikoEw35QquGwjtG7vRm/z6FyTPmnO3mYNX/TY44Xlk9bbJTUx
	V4eFQ3SXdBEeaIE6ggLQEXR8Qp7NojdzX1VUxg/R+MUa56E9VYe9SAzNbfJo0VHgHxKOw2
	MItZlPjz0kxUDIaTaKE6V59cqaoJ8AQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-Df8sqXrsODCfA6Du0fQ-DQ-1; Mon, 22 Apr 2024 09:31:33 -0400
X-MC-Unique: Df8sqXrsODCfA6Du0fQ-DQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a5238ca77adso629481166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713792692; x=1714397492;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rhXisW7GfhDn4x5RJVdbAZG0rJy8YwZlKBxKJjOJou8=;
        b=YtriVTCoiyXnTIOqJR76AxMOexDZQaO8WVLM6yi5mXwDxI/F5h2r5JDsAfe/iHmY6U
         gRO+HTJb9PadIEyZUutIBvqT9SBGkAOU1l5A5FF6NKU+vB1yUFkVStIIzT/JCZ3P2I7R
         CaW5kSPZ18X4eOZGJCuvgeBwFV+JNqHzUB85KG4zptmLmQ6HA77367ygMEE/RDUXjdwO
         kgMvbIzleEv37FcWqepYBZ+uXjm6upZVJvwHT8qvGL+U3ETocD1dBEUK+WgplfLLZzJT
         CyYWSw3rLFT9o6rOUsHR824B7FgLNyajrqfKb/+K8uyXZoNhaugMBQ9D6IBQj8QmKb+z
         fONw==
X-Forwarded-Encrypted: i=1; AJvYcCXw69Uf4TcofyiyHr8tYVtHbSZUQ47fIfAG34RMjrKthrE1+UmNHmYGDwKPizru2FUg9mvJakFnm6O8wmHve4Xv0tJcPxLyFiAVylA9
X-Gm-Message-State: AOJu0YxkNIGjtdKE8xvhMCWMrBHYHWy8/FWjnU0RpcjBc8KjW2ljDffF
	o/58nIpaYS1sazDXxj7ZjQLTlv6LCozjLZU2v5M7RIUUchqsryOAtgq47E1PccFgqC98a7u5AQD
	P0YkSvq2VGP7IokJSTZxAN1AO8Cw/kfIz2hWCqTbEDnBGASJOvs6emYTFXSR0zA==
X-Received: by 2002:a17:907:6d0e:b0:a55:b8b7:1971 with SMTP id sa14-20020a1709076d0e00b00a55b8b71971mr2973325ejc.32.1713792691933;
        Mon, 22 Apr 2024 06:31:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv+CAd+jKJmbYplnSb+CO+1kk8F9HG2LzTTaPgWqJCM4DePE5aNvLf57b/UE8XefZETs3ExQ==
X-Received: by 2002:a17:907:6d0e:b0:a55:b8b7:1971 with SMTP id sa14-20020a1709076d0e00b00a55b8b71971mr2973291ejc.32.1713792691543;
        Mon, 22 Apr 2024 06:31:31 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id w25-20020a17090633d900b00a51cdde5d9bsm5741921eja.225.2024.04.22.06.31.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 06:31:31 -0700 (PDT)
Message-ID: <e2567d94-6280-42b6-acd0-bf4aba90883b@redhat.com>
Date: Mon, 22 Apr 2024 15:31:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86/amd: Don't allow HSMP to be loaded on
 non-server hardware
To: Mario Limonciello <superm1@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
 Carlos Bilbao <carlos.bilbao@amd.com>,
 "open list:AMD HSMP DRIVER" <platform-driver-x86@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20240416182057.8230-1-superm1@gmail.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240416182057.8230-1-superm1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/16/24 8:20 PM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> If the HSMP driver is compiled into the kernel or a module manually loaded
> on client hardware it can cause problems with the functionality of the PMC
> module since it probes a mailbox with a different definition on servers.
> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2414
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3285
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans




> ---
> v1->v2:
>  * use pm preferred profile instead
> ---
>  drivers/platform/x86/amd/hsmp.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/hsmp.c b/drivers/platform/x86/amd/hsmp.c
> index 1927be901108..102a49c3e945 100644
> --- a/drivers/platform/x86/amd/hsmp.c
> +++ b/drivers/platform/x86/amd/hsmp.c
> @@ -907,6 +907,17 @@ static int hsmp_plat_dev_register(void)
>  	return ret;
>  }
>  
> +static bool hsmp_supported_profile(void)
> +{
> +	switch (acpi_gbl_FADT.preferred_profile) {
> +	case PM_ENTERPRISE_SERVER:
> +	case PM_SOHO_SERVER:
> +	case PM_PERFORMANCE_SERVER:
> +		return true;
> +	}
> +	return false;
> +}
> +
>  static int __init hsmp_plt_init(void)
>  {
>  	int ret = -ENODEV;
> @@ -917,6 +928,11 @@ static int __init hsmp_plt_init(void)
>  		return ret;
>  	}
>  
> +	if (!hsmp_supported_profile()) {
> +		pr_err("HSMP is only supported on servers");
> +		return ret;
> +	}
> +
>  	/*
>  	 * amd_nb_num() returns number of SMN/DF interfaces present in the system
>  	 * if we have N SMN/DF interfaces that ideally means N sockets


