Return-Path: <linux-kernel+bounces-70336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 335B885963A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 11:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D0241C2168E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 10:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C52F374C2;
	Sun, 18 Feb 2024 10:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dLYvGi1P"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1501D3717B
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 10:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708252027; cv=none; b=rY3mzQ9NGjxmUB+ujQDf15eIJX47HlTYp5g2xW4C1oRQiPtsT2qChJTW7rzI38/VTRZRjSb+zeXxNNDgq6wK72zhMx/QJmwfxwUIN9Q2U9Vtkmj5NIG32Fe26MmbK1dozOe0gPgNF1Ut5aexhMvJA3EEYYbFg4j+81E61D4HmMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708252027; c=relaxed/simple;
	bh=aePQbG4b2G+c+SGyhxjzdhxz8DnTmdOIk4xi7+UtVtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ATrt915dNOdBP7+ImBnRohis+HpOdeSfWNOuliNYldGCgt0YJtY2DIVC4gc5pPEQ0WvkxbtmfyvgCzzIepEw3cSFO30I+rOTPqBTlRZ540Ve8FFVmlZStprb8qpe75goHbKd8osM9CS4w3mrwiCtuop9e+Zphjc0nNSygjLZJHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dLYvGi1P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708252022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FSTWCWfGDb+Ca5J7proRAWQQgeYhikCAseb6RpZTm70=;
	b=dLYvGi1Pk6wKzbOWW4+CTc3EKw6zcu1J0OxGMWcRXs8EFPuRXP79oTr6mUDTpq7yfalm71
	CJ9WhuTdAUNqL94HSajbhrF+6eIp38/tMf78CAdycMxzrjPci1qv5Z5lic6drPevUnYEN2
	Q3rwO0eLl1S7/kuH0bRFPkrx+M0km8I=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-AhhD3tM6PkyfYTXGbsH66A-1; Sun, 18 Feb 2024 05:26:59 -0500
X-MC-Unique: AhhD3tM6PkyfYTXGbsH66A-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a3d7b6e42b9so156360166b.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 02:26:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708252018; x=1708856818;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FSTWCWfGDb+Ca5J7proRAWQQgeYhikCAseb6RpZTm70=;
        b=hbsbCZKib2fBK4JX4wPmZqFQbfMh/qkQeqH2x+P6ljOYzQWOGR6qdHciYrIrykFTxK
         7UvzYWVE5urBPzj211nB7LZpHrxiSy928Ai9vNLliTW8z9a1aTzxFtEAo0h5XvQ9KyZU
         upiOa3oVS14/+aOPbiKN6IaQuDLMONr31CuzklZ1ioWJBvXj+RpUgZ9APpckTZpY478u
         KT6ENc0X8fEOFtl/4/nVqs47lAtMO3xuYf7pBTLuxyXZTebUc2LtvyfQydmPYfnF+P3k
         uIVRwJRp64+RA37ieMO4dvZYDOwRQljf9pcwCsnQ+DUBeVlYeQuqiN/8zKd+k1uxJOAA
         8Uew==
X-Forwarded-Encrypted: i=1; AJvYcCUTcDLzmNqSRciiR2lmuS5nmR7BZwt+OrGg1StWe8cxz6q+86xkeEulCq9PykNFfoqMJoaMz7cUhwDgwAHuzH0kZizat9/zBZNq7Ewv
X-Gm-Message-State: AOJu0Yx2SP4mP7FxpOmd6JyQbj6YO86GJiKM05NMuCTgUY5BYFYa2edJ
	yAfvReGbgv0RYx2ENV+K/FPRGmg9hE72co+v+V9iUjuBfD6cWg0EQTXBgFCP/bzd5dHrSikUp34
	qB8ZIt0Jf1OTes2+PT/otC4I7p7482geh/KWUQukw0j9piHIR4OX9wNHLnoJDWw==
X-Received: by 2002:a17:906:397:b0:a3e:62f8:bbaa with SMTP id b23-20020a170906039700b00a3e62f8bbaamr870530eja.17.1708252018385;
        Sun, 18 Feb 2024 02:26:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgCRADRrQGCDfG54ZJZXr20hXS5ma+vll0yT7H/0sZvUFC/raicvFnaxOU/TOeWhwkUgsQjw==
X-Received: by 2002:a17:906:397:b0:a3e:62f8:bbaa with SMTP id b23-20020a170906039700b00a3e62f8bbaamr870521eja.17.1708252017997;
        Sun, 18 Feb 2024 02:26:57 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id un1-20020a170907cb8100b00a3d5a08ccc1sm1812528ejc.191.2024.02.18.02.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 02:26:57 -0800 (PST)
Message-ID: <3e81d005-663d-4c80-b9e9-5ddf56600c56@redhat.com>
Date: Sun, 18 Feb 2024 11:26:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] platform/x86/amd/pmf: Add debugging message for
 missing policy data
Content-Language: en-US, nl
To: Mario Limonciello <mario.limonciello@amd.com>, Shyam-sundar.S-k@amd.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <20240217012205.113614-1-mario.limonciello@amd.com>
 <20240217012205.113614-2-mario.limonciello@amd.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240217012205.113614-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/17/24 02:22, Mario Limonciello wrote:
> If a machine advertises Smart PC support but is missing policy data
> show a debugging message to help clarify why Smart PC wasn't enabled.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/platform/x86/amd/pmf/tee-if.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/amd/pmf/tee-if.c
> index 8b7e3f87702e..1359ab340f7c 100644
> --- a/drivers/platform/x86/amd/pmf/tee-if.c
> +++ b/drivers/platform/x86/amd/pmf/tee-if.c
> @@ -252,8 +252,10 @@ static int amd_pmf_start_policy_engine(struct amd_pmf_dev *dev)
>  	cookie = readl(dev->policy_buf + POLICY_COOKIE_OFFSET);
>  	length = readl(dev->policy_buf + POLICY_COOKIE_LEN);
>  
> -	if (cookie != POLICY_SIGN_COOKIE || !length)
> +	if (cookie != POLICY_SIGN_COOKIE || !length) {
> +		dev_dbg(dev->dev, "cookie doesn't match\n");
>  		return -EINVAL;
> +	}
>  
>  	/* Update the actual length */
>  	dev->policy_sz = length + 512;


