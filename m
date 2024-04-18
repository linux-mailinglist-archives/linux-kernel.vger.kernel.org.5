Return-Path: <linux-kernel+bounces-150835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A09C8AA56D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3660E1C20DF9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B19199E9D;
	Thu, 18 Apr 2024 22:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="aMQQSSrj"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E262E168B06
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 22:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713478740; cv=none; b=NRU0gvfg+FGPu1pYD0ugig7rOQwu7awGtoMUmZs4xJ+TyUAZNFcljuZ8I3zyePxNFOG+Ot9gnoQlfkSvpC/uNEzIp+nVGSWxiFDnJvoLwXdVColl+GGIAyjTdBD+vQxrYANj61DyB2fcbCTJG+12OTkAai/Uw8PjvnkSYKJoaps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713478740; c=relaxed/simple;
	bh=k7LEn3ZS9uytq21g8fUoSUFEnhUO17gn7DkU7QS3ZEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fG5UxVC28/6B3micpyWwKpn8gMIxgJfedorZoiwQo81zD9+y/X7VVRyuUNe1+Ous6pjo3FLdgLyaH3+E0m2cQqClPALpLLWRB7YkNYXffB1QT15SnbVfvk38LOiPbHamY1LzizCdzOmOAT9YMPOvu8fNcevnl86+uO3GLCOi0ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=aMQQSSrj; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5a9ec68784cso733282eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 15:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1713478738; x=1714083538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EjSNVaTp2CK2a3BXhVXbAXtv2UmAERGwn5Hrch+E7CU=;
        b=aMQQSSrjs6dWxIQkHiy1M5IXNn8/sNtGZy7fLnHM6Egpvwu6NLdevPV7SNzerFjDj2
         Ncd90Dst/M1eID4SibgdQHxniCd88qMRQCn+YX/w0qNFv4LgXshl0W2J9Sa+UI7RExTQ
         EFmFOFInx+ar481vIw/CdUFmTG+pnVLdSgSLf2u8Uv2iy4gYamYAvgFFynJLvgJ6yuFy
         HjpEebZwMvTA8upUizn7HlGv+Gydi0d9+BAPY3O/rmw9NewF8HEm9J/7PUrlQWc1rrND
         GzxIoHywyctTutUlJfSeeIfwwt4o59dcM2hpLqEDbqIOFnPoKJcKksv0ZB2QXAA+YLsf
         dePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713478738; x=1714083538;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EjSNVaTp2CK2a3BXhVXbAXtv2UmAERGwn5Hrch+E7CU=;
        b=mY/270PvZMO2s7yrBHYpJ21//+H6htV4+Letgez9+zzUmtaMKWdgJuU3MmheaifcKR
         Fgf4qYxi28TLCneCoiZ5E0hYgwyS+7qR1Ld7dnux7mH88SSumsCUeGSfE5F8b9f0LU/g
         Px3b7W99NpKDtNHjmhJ0YsBm8Qo1W9S0vhGqMvD5GedV9FcchL/IrfZn1rkeLSWx0eTy
         /RuWhCsyJxVqi6rgtdHdyCGE+R3dFhsYDNzXdMMvlS4zv1WAPYRQqUwc4y2KXW6B1JcM
         SZdBBLr4X8jdaDk7gxdbS10i//WXS1yH3gOaBnyQbXo4g9P47iGdh7KWYlzp9Q13LetR
         k7Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUwBg/b441tMtck0WOqnV3CUsBOXuxcKxlJ25u4VmuwN+kqwLC3zd1SWgZXqSz6Jn2bPWLgh4EYG6ItXCepu+Dd3ORiBG311fAt2XVk
X-Gm-Message-State: AOJu0Yy0/0fQTovtpn0YYAv5Tp4aEdGGVV8Z/gvmDJKk3xQ9sBBTPzIc
	/lSV6maYUi+nikD5czeUYYzDNJoXhLU3pU3v8ncxO3p5g9yX4C+esQFPJexb5Jr6LmnjTPtKbCM
	K
X-Google-Smtp-Source: AGHT+IHy0fL7lXQuzGDsR89q1qBuUYQhGBkh8xPVh4GAWuHmBlphok2cL4joZuVDX6t12N8GeqlFGA==
X-Received: by 2002:a05:6870:32cf:b0:22e:9792:97ed with SMTP id r15-20020a05687032cf00b0022e979297edmr521699oac.38.1713478737800;
        Thu, 18 Apr 2024 15:18:57 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.197])
        by smtp.gmail.com with ESMTPSA id iz27-20020a056638881b00b0047ecd14e8fcsm639381jab.130.2024.04.18.15.18.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 15:18:57 -0700 (PDT)
Message-ID: <979139a9-3f87-4c42-8849-4909311f0891@sifive.com>
Date: Thu, 18 Apr 2024 17:18:55 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] RISC-V: clarify what some RISCV_ISA* config options do
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Pu Lehui <pulehui@huaweicloud.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20240418-stable-railway-7cce07e1e440@spud>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240418-stable-railway-7cce07e1e440@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-04-18 9:21 AM, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> During some discussion on IRC yesterday and on Pu's bpf patch [1]
> I noticed that these RISCV_ISA* Kconfig options are not really clear
> about their implications. Many of these options have no impact on what
> userspace is allowed to do, for example an application can use Zbb
> regardless of whether or not the kernel does. Change the help text to
> try and clarify whether or not an option affects just the kernel, or
> also userspace. None of these options actually control whether or not an
> extension is detected dynamically as that's done regardless of Kconfig
> options, so drop any text that implies the option is required for
> dynamic detection, rewording them as "do x when y is detected".
> 
> Link: https://lore.kernel.org/linux-riscv/20240328-ferocity-repose-c554f75a676c@spud/ [1]
> Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> 
> Vector copy-paste-o fixed, correct spelling of optimisations kept.
> 
> CC: Samuel Holland <samuel.holland@sifive.com>
> CC: Pu Lehui <pulehui@huaweicloud.com>
> CC: Björn Töpel <bjorn@kernel.org>
> CC: Paul Walmsley <paul.walmsley@sifive.com>
> CC: Palmer Dabbelt <palmer@dabbelt.com>
> CC: linux-riscv@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
> ---
>  arch/riscv/Kconfig | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>


