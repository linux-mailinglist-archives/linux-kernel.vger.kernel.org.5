Return-Path: <linux-kernel+bounces-151092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEB78AA8F9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C20AFB21CD0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DAC3BBFE;
	Fri, 19 Apr 2024 07:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bq7OSu+Y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB67B3EA8C
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 07:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713511009; cv=none; b=qeg7/dfkISro0SGS+ZiStAeuZ33OXLVcenjPjMzxoC/FFIrUAh1FNTxL5OI0LuGFt3bqFKE0cMWKyuu2KHDQPkqnerVCIEh930iuEZE33pkER5/Gb3sl2wQxlRlShvTWiYgSYF2mmQw92QOETooNw6woWw2n9tXVL0QEYpPDVlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713511009; c=relaxed/simple;
	bh=xerZNlBWOzwvaD0cTeYN+wpQI1ET37j4sqVZ9UBtwfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CA/kIHevKWoeaZRH53LPUILCH38x3jxWkDZc7pqUbT/qz+l8t8YPkmVIQhvIxnpminlvgtQmW9MrrMCw7S8rIz3qCV3pfUJT6HZzo9MRI02rcma0jkKPDNarTGAqmGy4wtxIezAGVpxcpuFJ+pI84jWkPNg3X+5LF+U7NL9IbpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bq7OSu+Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713511007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cNdMyKJtZkJVADCLrbvfI61n/KWQQTgh0VRSN/5FL9U=;
	b=bq7OSu+Y9tk3UM7Gb/n0jzjkAuBO3Mg2TOxyoJE2VKnXfmJ6h5UtsvW+eHYdr0xF3uxjAm
	tfe0wYe++HzL8K6WvWAek1Sk3qUPHzWhutfFC9uL53y788M133oRafKoNOg82balnALZap
	UN0RCp/GZ4i83sG8asGDOuAsOyb7xiI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-GrMm-Ao2OHesbAY1IpPP7Q-1; Fri, 19 Apr 2024 03:16:45 -0400
X-MC-Unique: GrMm-Ao2OHesbAY1IpPP7Q-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d884b718f1so15397531fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 00:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713511004; x=1714115804;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNdMyKJtZkJVADCLrbvfI61n/KWQQTgh0VRSN/5FL9U=;
        b=gI32ZlTtIEBe26S6tgfbmXXWPoQEU37vVIhBDKxPUHahrUeJdq0tKh3a83iSrR4lz2
         wxA5ej8S02DODeX2mxZbBGy4QBWtPwow1FH1XbfRd05GNniiW7VaV4LxDikJay4IuxRR
         nk5ZBEfCsex69Nazd1ulOBcRmnUu5HmPPF1V/lWrLya5c+qv6QuEV+RDgGmLJTRG8jLa
         qCetplEoiLqmOfXYwbGU7NP9OoSnDt4Xv13uTgiLpp6EXuALJKnjRSnXhTzo7V7fqcx/
         jrM9GmW1Q1FZe6QhTWOi/gla3RTA1dvIbIPh//R0wc966GllXVUlog1ap/K2wgGmQEbY
         tGOw==
X-Forwarded-Encrypted: i=1; AJvYcCXLaAtaFWs3U1Qm+gkfxR6olqbSLzsg0BIz7Ba0peRcLAMjxLxTWlweADsljQxtsSo8eBjAvN62BhUMNjAnvYazJAZcOXuLNOekUsDV
X-Gm-Message-State: AOJu0YyDIT9bYS5A/IqZp1dh2nlafwW+JfTGKPwAtM6boGdBwoCn7nD9
	CQAJQ3E/sZRzN4JOIkaa+kVMSxFjSIi2Zo/Rk+AQ+aJvyJhMRO92a29/056abSA5OxBLfaNXMp9
	NMQhPzXPKTsLCd9JGea5gGmVhN/C1IeAA45bWvDjyxLTUNAjZbh1v8zrjPBJbRg==
X-Received: by 2002:a05:651c:1031:b0:2d8:6104:f95a with SMTP id w17-20020a05651c103100b002d86104f95amr677610ljm.23.1713511004035;
        Fri, 19 Apr 2024 00:16:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzp6BC6iIIJU1Fu2PqXxEWL3FYmVn1VEc13lIuo690UE73CWmvjK75ugnF+s1hz50brkAD5g==
X-Received: by 2002:a05:651c:1031:b0:2d8:6104:f95a with SMTP id w17-20020a05651c103100b002d86104f95amr677586ljm.23.1713511003506;
        Fri, 19 Apr 2024 00:16:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c716:f300:c9f0:f643:6aa2:16? (p200300cbc716f300c9f0f6436aa20016.dip0.t-ipconnect.de. [2003:cb:c716:f300:c9f0:f643:6aa2:16])
        by smtp.gmail.com with ESMTPSA id y18-20020a056000109200b00343300a4eb8sm2732998wrw.49.2024.04.19.00.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 00:16:43 -0700 (PDT)
Message-ID: <10af93f8-83f2-48ce-9bc3-80fe4c60082c@redhat.com>
Date: Fri, 19 Apr 2024 09:16:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: coding-style: don't encourage WARN*()
To: Alex Elder <elder@linaro.org>, corbet@lwn.net
Cc: gregkh@linuxfoundation.org, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240414170850.148122-1-elder@linaro.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240414170850.148122-1-elder@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.04.24 19:08, Alex Elder wrote:
> Several times recently Greg KH has admonished that variants of WARN()
> should not be used, because when the panic_on_warn kernel option is set,
> their use can lead to a panic. His reasoning was that the majority of
> Linux instances (including Android and cloud systems) run with this option
> enabled. And therefore a condition leading to a warning will frequently
> cause an undesirable panic.
> 
> The "coding-style.rst" document says not to worry about this kernel
> option.  Update it to provide a more nuanced explanation.
> 
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>   Documentation/process/coding-style.rst | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 9c7cf73473943..bce43b01721cb 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -1235,17 +1235,18 @@ example. Again: WARN*() must not be used for a condition that is expected
>   to trigger easily, for example, by user space actions. pr_warn_once() is a
>   possible alternative, if you need to notify the user of a problem.
>   
> -Do not worry about panic_on_warn users
> -**************************************
> +The panic_on_warn kernel option
> +********************************
>   
> -A few more words about panic_on_warn: Remember that ``panic_on_warn`` is an
> -available kernel option, and that many users set this option. This is why
> -there is a "Do not WARN lightly" writeup, above. However, the existence of
> -panic_on_warn users is not a valid reason to avoid the judicious use
> -WARN*(). That is because, whoever enables panic_on_warn has explicitly
> -asked the kernel to crash if a WARN*() fires, and such users must be
> -prepared to deal with the consequences of a system that is somewhat more
> -likely to crash.
> +Note that ``panic_on_warn`` is an available kernel option. If it is enabled,
> +a WARN*() call whose condition holds leads to a kernel panic.  Many users
> +(including Android and many cloud providers) set this option, and this is
> +why there is a "Do not WARN lightly" writeup, above.
> +
> +The existence of this option is not a valid reason to avoid the judicious
> +use of warnings. There are other options: ``dev_warn*()`` and ``pr_warn*()``
> +issue warnings but do **not** cause the kernel to crash. Use these if you
> +want to prevent such panics.
>   
>   Use BUILD_BUG_ON() for compile-time assertions
>   **********************************************

Did you even read the history about that? Likely not, otherwise I wouldn't
have to learn about this patch on lwn.net.

I suggest reading:

commit 1cfd9d7e43d5a1cf739d1420b10b1e65feb02f88
Author: David Hildenbrand <david@redhat.com>
Date:   Fri Sep 23 13:34:24 2022 +0200

     coding-style.rst: document BUG() and WARN() rules ("do not crash the kernel")


which includes links to relevant discussions between me and Linus. Most
relevant to the discussion is [1].

All that's written in the document right now (use WARN_ON_ONCE() *lightly*) is precisely
what I still think we should do. That's the case *1.5 years* after I documented that.

Clear NACK from my side: "If you set 'panic_on_warn' you get to keep both
pieces when something breaks." [1]

[1] https://lore.kernel.org/all/CAHk-=wgF7K2gSSpy=m_=K3Nov4zaceUX9puQf1TjkTJLA2XC_g@mail.gmail.com/


-- 
Cheers,

David / dhildenb


