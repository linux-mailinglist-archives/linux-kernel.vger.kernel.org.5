Return-Path: <linux-kernel+bounces-41491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E2D83F2B9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 02:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBEBD1C21035
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 01:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFFA15A4;
	Sun, 28 Jan 2024 01:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9KKIBt6"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC541113;
	Sun, 28 Jan 2024 01:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706405314; cv=none; b=Qwt8xtXah76J5rS5bxF3dQeUEzJ12zmagObSJmyPF2e1AQYG90UOxjPrlQp2LaL5oY98BfLw4VAh2dX85CzYdi26fageoStOcjUs5GB3Q0q7cNGs6M07ED9TN21mhoXsztaewgxZSqZ8ZD6Tg4bFc7yatLFrgDuwtRjCDODJ2i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706405314; c=relaxed/simple;
	bh=+4n89C+gEBtsQDw1jUm0K1mb6NFfpf8Q6IFymcXODF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BD7z5VTrQGkGADBhcms8mLrH38xzj+VJXarU8unfKhl491nSTJVz7SiYFV26dKH/XKaZC/b8s4gEMhncFDuadBSoqNsQIh6qqCgyiCFthoZi+fHcAw3dmauq3L7YKJVJfg9Co6EGx0P+t6hQDVE86iKGiljl9zUgEjfZ/JLnSVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9KKIBt6; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40ef5316e01so440655e9.3;
        Sat, 27 Jan 2024 17:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706405311; x=1707010111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oUXUIxIBKb7yXVS8ERVW4fwa4sKRyx0T69mWwoqQkWg=;
        b=R9KKIBt68sXTqDQdUnwHKECV9ZMWozyiVb7XXW5420kXxWdIzYkMOJXOAf33tRzpnY
         2nxRsPCAXY4Us2zG9F1Y0Gv+8DyOYU3vJrm5sLUK7zwZEgF32Pb84HZ6Wno+QZBbfZEX
         ORCIQ+AXkbrlHJUU7uRdeW3skVzO884z8tPGWBdG9AZ235fcldjkFg+Y1ZCeQ+29dh5O
         HYCzYvVhZrKFMqjuCyOCoFKtY1HZfFp3Q1TmFUd8uhi9GrFak+2eIxwmWjU4M3ssOoHm
         i3JQxc041y+srtxPxAm1Ta8EKVWwnJ6thMHB9Q0aCkqJKWmFTnuUCp7J46ELEvxOHXeo
         REQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706405311; x=1707010111;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oUXUIxIBKb7yXVS8ERVW4fwa4sKRyx0T69mWwoqQkWg=;
        b=os7HCsgWA1WRker45HgFcyo+icXLZ8rghjM2giGfN/ZmxI1VuVClVIX2qhTokPYPBK
         RGEm0Slpm2+KL3s5qeDYMotOeExsz3WaTmYbJnip7CJ51AW/OzI2RMyruWOgYE9mJpXP
         bPTTo00Csm0Wxf3HBTfF8AsidqDcc8KjW9JR/Ie3OmWQaeWSaXvFpsYrG9OGvPEThgxh
         opoqLfXF4wPeHwojdAZaJcKeALenw0QjoiDg4iP1vO0GPnJt+1U/pzRjHus667AeKlGm
         xznQ6BVtem7M1gbi4NqfkYmGos6JFycABCzzVDxJgzuBWPEzni4TrxQWCooQ0ja76mxN
         ATEA==
X-Gm-Message-State: AOJu0YxMfFLdQY4v/Ui3/I0odvaqKUyDIHTDR/7CE22buAAaETuNYhUI
	4iUxEmSB3Cpmk3bNUyihhwW7TmpYY4+FLgljzHx7/dAEo5/YDjs6P3EUTfHjaHMBkw==
X-Google-Smtp-Source: AGHT+IHept3nMUj4LCYzYJiT9LNHHbS9INXuvww5u4glPmCjjXCtKxmvIBnhSwXHbRZoEWgm1HAkmA==
X-Received: by 2002:a05:600c:1396:b0:40e:a569:3555 with SMTP id u22-20020a05600c139600b0040ea5693555mr2037091wmf.35.1706405310998;
        Sat, 27 Jan 2024 17:28:30 -0800 (PST)
Received: from ?IPV6:2001:678:a5c:1204:db7b:6df3:1a86:f66a? (soda.int.kasm.eu. [2001:678:a5c:1204:db7b:6df3:1a86:f66a])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c1d8600b0040ee76ae773sm4537228wms.19.2024.01.27.17.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jan 2024 17:28:30 -0800 (PST)
Message-ID: <0b14826b-9373-4458-919d-1da2a62d4226@gmail.com>
Date: Sun, 28 Jan 2024 02:28:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next v3 01/14] kexec: split crashkernel reservation
 code out from crash_core.c
Content-Language: en-US, sv-SE
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
 loongarch@lists.linux.dev, akpm@linux-foundation.org, ebiederm@xmission.com,
 hbathini@linux.ibm.com, piliu@redhat.com, viro@zeniv.linux.org.uk
References: <20240124051254.67105-1-bhe@redhat.com>
 <20240124051254.67105-2-bhe@redhat.com>
From: Klara Modin <klarasmodin@gmail.com>
In-Reply-To: <20240124051254.67105-2-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2024-01-24 06:12, Baoquan He wrote:
> And also add config item CRASH_RESERVE to control its enabling of the
> codes. And update config items which has relationship with crashkernel
> reservation.
> 
> And also change ifdeffery from CONFIG_CRASH_CORE to CONFIG_CRASH_RESERVE
> when those scopes are only crashkernel reservation related.

> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 502986237cb6..a9243e0948a3 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2106,7 +2106,7 @@ config ARCH_SUPPORTS_CRASH_HOTPLUG
>   	def_bool y
>   
>   config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> -	def_bool CRASH_CORE
> +	def_bool CRASH_RESEERVE
>   
>   config PHYSICAL_START
>   	hex "Physical address where the kernel is loaded" if (EXPERT || CRASH_DUMP)

CRASH_RESEERVE is probably a typo and should be CRASH_RESERVE (with the 
former ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION isn't defined in my 
config and `crashkernel=...` parameter has no effect).

Kind regards,
Klara Modin

