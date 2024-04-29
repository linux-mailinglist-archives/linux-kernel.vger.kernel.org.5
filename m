Return-Path: <linux-kernel+bounces-162097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E148B55C9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE2FC1F23634
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1954139AC7;
	Mon, 29 Apr 2024 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUur3TSw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36483715E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714387800; cv=none; b=lk81vIeLJKITZ1dijYXKobUHJLOzJ5YEv6IhUQZEp3jbaqure5qFrkaX+s3OCoBIJbZNET1IgfSkzVgbYjLI+GWtwK/4h8r+KE4/5LP9jHxmOWGXnzo3/BJEE/GW4cTBdGtFus0BoOlzB23bGgXBUuYnjYJdOO3Q1cV3BPK4T68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714387800; c=relaxed/simple;
	bh=UGloWyBZuHazCTnA5JUy0JL498lI4VHlVYFtMASdMdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mz790Uq2hKn4ifAa74sageY1kZg6/BkKegq9DjXY2iLPwHmjZlngmrduzxRT0/AXnpA9IJtkL7eNpJH5P5AKHL3j8FW1jnfKHlx0C6CP4Ty9F7fC0gpd75kLMjOIgfQJfBO5XhGAKJLvPdABa1nz39G9AM5hMxmf5k5SuvdCx0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DUur3TSw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714387798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vcd2JWrf3E7vjtQeMf6O7h0qouO2cxaE02l5lL6WC20=;
	b=DUur3TSwicT1Nhu4HczvPlGQF78yXt2mcvYkb9T8VgpSNL5cfRUQUO+TmAYKV08qGLnsZg
	NIAKVQC2bd9fcSWWhMNL1PETPYq47gN+UZKDQoAHjf4W1sxhchocbPNHA/sdkF62JLoEPC
	ra5wCSmiRjeV5HFavlWeIdhTbYxjj0M=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-tnob1uCLPZ-Tc_A61INPjQ-1; Mon, 29 Apr 2024 06:49:56 -0400
X-MC-Unique: tnob1uCLPZ-Tc_A61INPjQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a58bcb4aec0so104700166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 03:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714387795; x=1714992595;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vcd2JWrf3E7vjtQeMf6O7h0qouO2cxaE02l5lL6WC20=;
        b=opokUndZm/pZGUk9DyfLUFvXdlLlcZ5ef84AoU231sQC/PKdydP6jkt44iNeEt4+NH
         HR9LGvIZPrhS2sCOaauq2bOnFE2pPj78WNdPO3K1XOF9YwDmf9fFa/Uk/cbb+2uL/GQ3
         NYC9BkFJuI+d6PSvcN+9zcfrToMoZ+ecKvTwiobNGqYpqpTOyv8Z9RaYr210/oWJ1oxU
         jSe9HoXrs4lsfL0JSMrhmtdPd/7f4u/XF+kbla4b5czsrMpGzgDu/gRnETTpKNieeAR/
         tLw1CDmcekZYoVGpFPpDiUPEVzn540wMQbLWDoVEmGz7L8wFlCaaA3e5eTAbjXfAZL+y
         ZBIA==
X-Forwarded-Encrypted: i=1; AJvYcCV4GDxovB1vXbrtKZQ60lPe3lN5QMV9xFSiWJ+bFF7tJi35VKj258ktxBQa/YWLRYwbTDR8rUlMsw1oMg82ybAVZqL+tu0RJQROa55r
X-Gm-Message-State: AOJu0YyAF2FpEQ6szs5J5L42z3i/NQ3Uij8X7AXEKd42zFcwufvcIezT
	b6m3oERC5uuGZmQ4Lmcg0IXp6io/tSVKSCT/aGYSlysbfhGDyCm5GpnusFof4p7fe3TAe0XhACn
	uEjRRZpUbkDfmj4/iXM+iy9xNiferPeBoJT34+1xmwthKQV6wCITkvd/s1Wpnow==
X-Received: by 2002:a50:bb2a:0:b0:56b:829a:38e3 with SMTP id y39-20020a50bb2a000000b0056b829a38e3mr8133366ede.16.1714387795497;
        Mon, 29 Apr 2024 03:49:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxaAk7ujYaxXYwlydlAdtfXBP2naI+GbOYOjO3PpgkOZlewZ6TuzGpHbbXbtuUhFpTirBPew==
X-Received: by 2002:a50:bb2a:0:b0:56b:829a:38e3 with SMTP id y39-20020a50bb2a000000b0056b829a38e3mr8133353ede.16.1714387795219;
        Mon, 29 Apr 2024 03:49:55 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id er25-20020a056402449900b005727eb1ed6asm1219115edb.68.2024.04.29.03.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 03:49:54 -0700 (PDT)
Message-ID: <f7ff317b-f91b-429c-ac09-61b338264890@redhat.com>
Date: Mon, 29 Apr 2024 12:49:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: ISST: Add Grand Ridge to HPM CPU list
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 markgross@kernel.org, ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240422212222.3881606-1-srinivas.pandruvada@linux.intel.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240422212222.3881606-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/22/24 11:22 PM, Srinivas Pandruvada wrote:
> Add Grand Ridge (ATOM_CRESTMONT) to hpm_cpu_ids, so that MSR 0x54 can be
> used.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

This looks like it needs to be applied on top of the fixes branch, or else
after 6.10-rc1 is out.

Ilpo, what do you think ?

Regards,

Hans

> ---
>  drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> index 30951f7131cd..1accdaaf282c 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> @@ -721,6 +721,7 @@ static struct miscdevice isst_if_char_driver = {
>  static const struct x86_cpu_id hpm_cpu_ids[] = {
>  	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_D,	NULL),
>  	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_X,	NULL),
> +	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT,	NULL),
>  	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT_X,	NULL),
>  	{}
>  };


