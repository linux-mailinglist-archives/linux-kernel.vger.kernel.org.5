Return-Path: <linux-kernel+bounces-71328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A099E85A395
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3117CB25D6E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021CD2E82E;
	Mon, 19 Feb 2024 12:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpwyCPvX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D1E2E62E
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708346274; cv=none; b=Wy0Y5iai8U9okXKhIBngAUTnJhwe+t69nHR9NQAyytKCOzOTgW7FcC7wv8Ysa3NcwChVRBrz020/Y6hhsOjnqdVkVqiD9K3x/4X9nYPFw6EFpphXFnVjBiqR4BE9lM8XKWh8ef2ukMYV+A6hX2OXwcK20411DcD/NsIQ9eaHXWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708346274; c=relaxed/simple;
	bh=GY8KIVqzsOKGT5UsEsAg9niPyy7MPrFyGo7zraijhPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fnkxJx6jdJ8G0G2wnA2Dq33pgCYsZyCiviUoNQSy8DkYMF0smx/zJ6ORPIn8P3aTQ149PtSaFaQAKCur1GBcYqrXt0IXQowdZnGekEsCdZB9aGkKGXYfCfRWpovjZ+YTxx6Fm1Rc43me6Cx2DrQImbWyOPXppt4+u1SFz/iZOgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dpwyCPvX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708346271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9NUbNB6aBViIXTgaODmTHiYaijHpW84fTtczd3qM8yE=;
	b=dpwyCPvX80lWXOlrgC/uEa82AG8oE0oS6MjMgtG9rwhV/sziiX5bhzTelIJmZ5P7c84WId
	GaHF/nYjCz4p4B4lB6CBk4joyhpJNfFVK0D1/VaZOdYq5fG9hm30CFcva8arwXyuW87SL7
	4TiO1UAcUdDlqRZ6UMrK6pHmA2K3Ti0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-b4d6cy12MfW9fc8I-t85Xg-1; Mon, 19 Feb 2024 07:37:50 -0500
X-MC-Unique: b4d6cy12MfW9fc8I-t85Xg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a3e42733561so80793766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:37:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708346268; x=1708951068;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9NUbNB6aBViIXTgaODmTHiYaijHpW84fTtczd3qM8yE=;
        b=IYkExVa/0Bc+LDQTAmj8tPyCs6OY9x9fgBZuquLISY47oSyV1QGD3fM1DP8jXcN0Xa
         Kk1QK/UUUof5bjBGe3Z/DzHXPXNDlm8P6/EDRsYtIi+lykIJasSinr5SXqQ+s0jGK9hl
         +pUz+DjFYn7KoZ+uKqy4rmncRjqPfiW+jtWwzZMYLj0GNUzbONnPjIvsYczxpxDSM86l
         V5c6wGzTkDpdM9gyctkYI4YzZXur/3U21ftofSUUHV7YOlNorAlTv8FTYTsV4eX7KJd+
         v/otmxc9CA2R4Ddhvezwh8kIe/8eQbU7Nhy/wg6OkwMJ8xpzAxOI2ugog+sNYDga2fCP
         +PYg==
X-Forwarded-Encrypted: i=1; AJvYcCX06MvgMIvYzlMtU32WRcbblr92G9lLYKOMJIrjUN0QCT315b7zaByD/c35n7vl/n3pC57tAeOrnitLNZPvfICWxz0TY9aoFkRvYN/J
X-Gm-Message-State: AOJu0YyZAasDz2yLt6UuiqC5oAItDlWePfwlpV+0yv9KfszylwugujEG
	wD+B3vUKgeL2MavGnMXfDUPAlX6UJ8VgDchOmBiJn2r8b2BLe7mc5fkufDrsLQHN4b9QcMdvZBv
	o7sRjJOHYH9/9W4NM86djeysmYHVjkWkar4PJsNMJ/VAHTYha9hWIlAk7vjyqqA==
X-Received: by 2002:a17:906:69a:b0:a3e:a8e9:9662 with SMTP id u26-20020a170906069a00b00a3ea8e99662mr1196626ejb.63.1708346267911;
        Mon, 19 Feb 2024 04:37:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqz0b4HLJ/9PQmyPbkskX7AkRoz5aMO+JB6bXzgS95r0pkYly3Y7zosh6lr80y/WHlAvfrxg==
X-Received: by 2002:a17:906:69a:b0:a3e:a8e9:9662 with SMTP id u26-20020a170906069a00b00a3ea8e99662mr1196618ejb.63.1708346267564;
        Mon, 19 Feb 2024 04:37:47 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id wp1-20020a170907060100b00a3e2e03c155sm2363377ejb.155.2024.02.19.04.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 04:37:47 -0800 (PST)
Message-ID: <8c5e67e4-9625-44c9-9f1e-f098d38018a6@redhat.com>
Date: Mon, 19 Feb 2024 13:37:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/amd/pmf: Fix a suspend hang on Framework 13
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>, Shyam-sundar.S-k@amd.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Trolli Schmittlauch <t.schmittlauch@orlives.de>
References: <20240217005216.113408-1-mario.limonciello@amd.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240217005216.113408-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/17/24 01:52, Mario Limonciello wrote:
> The buffer is cleared in the suspend handler but used in
> the delayed work for amd_pmf_get_metrics().
> 
> Stop clearing it to fix the hang.
> 
> Reported-by: Trolli Schmittlauch <t.schmittlauch@orlives.de>
> Closes: https://lore.kernel.org/regressions/ed2226ff-257b-4cfd-afd6-bf3be9785474@localhost/
> Closes: https://community.frame.work/t/kernel-6-8-rc-system-freezes-after-resuming-from-suspend-reproducers-wanted/45381
> Fixes: 2b3a7f06caaf ("platform/x86/amd/pmf: Change return type of amd_pmf_set_dram_addr()")
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
>  drivers/platform/x86/amd/pmf/core.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/pmf/core.c
> index 853158933510..4f734e049f4a 100644
> --- a/drivers/platform/x86/amd/pmf/core.c
> +++ b/drivers/platform/x86/amd/pmf/core.c
> @@ -299,8 +299,6 @@ static int amd_pmf_suspend_handler(struct device *dev)
>  	if (pdev->smart_pc_enabled)
>  		cancel_delayed_work_sync(&pdev->pb_work);
>  
> -	kfree(pdev->buf);
> -
>  	return 0;
>  }
>  


