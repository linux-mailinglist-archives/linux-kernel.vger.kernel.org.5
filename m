Return-Path: <linux-kernel+bounces-70335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5E2859638
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 11:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 403A9B2243D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 10:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD1D374CC;
	Sun, 18 Feb 2024 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMqS9LIh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25B92CCA4
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 10:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708252001; cv=none; b=icY/9Rwr7NzYjNvDN9IzMfR//R/Kx/yTXmhSpGzGevfpbD4rcGNhTQKBup4GF/zc7/AFXiFJydRc10XEXF+2xxlQomzhGJMrSMfFbRhlMd2a7daS1PgavWfk7IBs/a6u7a5eQn5MmdZE6MREEJD2yF2vB1Cs/F4YHL+WktYLeEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708252001; c=relaxed/simple;
	bh=73xM8HfwtjYvZeQh6N+9c+UZ7gdRDzATR9UR06S7DOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Br32hJKwFbjCpiu3ss1yHrZgPLtPGj+boc8tthURO0m08k65QJbmwIgLUhdMqGH/6ATwTq2BPYQOKcYnv11WdwCbBR29IuncbNjRvPlGRvEqCpNVUCwvvNcy/vSy8VMgXNT4VjYJOReBjlpFciG94igCj4jjTFAkCWrAyckA8mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NMqS9LIh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708251998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3iL7cm/0gzvphX08YlG1pTdWcKTR7vjKbJ6kYFx0SGQ=;
	b=NMqS9LIh8lz+mQ5x/T0c9otWlelejywmjnmSFEYwUH2RXT4UFEe34hN/YbyGz8C4xaS3rn
	HPGKMCyC1WYqUvJvjO7hcjRDLUIYcqBprQNDkmTRsnD4hWgH4d2o0tmFvo2MMXt1OXYYDu
	D53/kKGlFikzE+EUJDv18aBdTU/8Jw8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-VUWF6pB4NfKmWa5KIfRXKA-1; Sun, 18 Feb 2024 05:26:35 -0500
X-MC-Unique: VUWF6pB4NfKmWa5KIfRXKA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a2b068401b4so391042666b.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 02:26:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708251994; x=1708856794;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3iL7cm/0gzvphX08YlG1pTdWcKTR7vjKbJ6kYFx0SGQ=;
        b=SG48PcoYtUsOyWZESX73askl3mCdYUdyzvgNnkQxY+o7t0SSXe2uysXoC0zu1YNIxo
         4wXaEArPG6LQNMXq/L3D3hLZVqkGPp3EVLKACa7P/8PEifvfaKGUuVYiFJIdkwb0pVOx
         eLdwxEfEycRYwJ/kmMEl2fKaUOjlpnkqRWpcLzY1EGxhHehflYC5lJRTLj9E3rLDbp1N
         g6uHGPoTrLWUcAjkaOnRo7aFVk4KgP/rzsFG+yH5mbascT/wFUEl/wC2EWNRmpHmdWWC
         8H7R8ZAZveieHxNmdqpbwumsojoyW6rmyABaY6Iv2ZZ5Qy0fEjIrldSGoTex1/MxCZMN
         kQyg==
X-Forwarded-Encrypted: i=1; AJvYcCWTmIcQ1H5S1e9VDzGIwdtnXo0ScEM+QpA6MufJuBAjyD6Vb3oFqnsBjCSDhc7uJllUozaRvuXzfkoZwAiQYON93uNO+cmSSnrhSgtR
X-Gm-Message-State: AOJu0YyXpXI+mbupZ/5dCf8kTZ7t5wYhix7IsH13f5mk16iMAQLufgSH
	cxhLCtr3Zk4CUAjPQTyBWZrMu/f1Ms8/XvU9ciF1YSI1TSCKEBsCz4CAuvcwdlERif+6d+65P+1
	mBA6eQZH3J01209Dj+jsm/9AuKZvIjpUHnLX5kF69fm3BEuhFNVR/E2qyVGgvaw==
X-Received: by 2002:a17:906:d293:b0:a3d:df97:47be with SMTP id ay19-20020a170906d29300b00a3ddf9747bemr4945772ejb.1.1708251994454;
        Sun, 18 Feb 2024 02:26:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2LPWogWqNaTO56lcudkdC1bbE+GHPBOzFooj4aTxaOOb4vFusuX04kOGUJ+8ZKLqElym9FA==
X-Received: by 2002:a17:906:d293:b0:a3d:df97:47be with SMTP id ay19-20020a170906d29300b00a3ddf9747bemr4945752ejb.1.1708251994129;
        Sun, 18 Feb 2024 02:26:34 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id un1-20020a170907cb8100b00a3d5a08ccc1sm1812528ejc.191.2024.02.18.02.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 02:26:33 -0800 (PST)
Message-ID: <f6cced34-087a-4593-b510-a8a728deab97@redhat.com>
Date: Sun, 18 Feb 2024 11:26:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/amd/pmf: Fix a suspend hang on Framework 13
Content-Language: en-US, nl
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

Ugh, I should have caught this during review. I especially asked
for the alloc parameter to amd_pmf_set_dram_addr() to be added
for this. Ah well ...

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

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


