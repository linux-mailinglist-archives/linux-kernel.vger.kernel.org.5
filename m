Return-Path: <linux-kernel+bounces-99820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EFC878DDF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 05:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB811C214C7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21F5C121;
	Tue, 12 Mar 2024 04:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mJvl84Yp"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E6BB642
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 04:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710218096; cv=none; b=mZgvpJOVhm56Ev1SXR41IF3UNtsP9tToRT/WBCeXq2oDhzn/xy8hsMDl6N+iWecznwRP1SmkACwDZaZo3dlAghnTJzTSOEi/nxG5ryrC6LTv7GLuVCPSNv/hWXwD+anma5aKU4bjeHIkeNzBUFvcgRy7X0Y7acIQXi8dMdtTN6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710218096; c=relaxed/simple;
	bh=xBRHOQ9tBTOdRG+qo/FlMjcMMcMVC9ui6W9rEycYINM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CSV7WPWc70Htu71Z1Frxqao3N2eG+J+81f4Sq4cWalHeknA2CjX6wV1Fqw+GfogJB+cDPUGVBCVoEteFTJrfr582NG1V1FUY7esgrXNZzWKJRnmMHBjveECJjwbiQYEWMdulQR2lNofkO5PJJ4cgVMcpXhIaoOFz1Hgdj3Pxx1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=mJvl84Yp; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7884a9a404fso274160285a.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 21:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710218093; x=1710822893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eBI/dZHSCZMDcyRVph4NOafsCczjFoHj8zNVJflhhr0=;
        b=mJvl84YpMtO3PFZP9ScAOmn36PnRAXasP63LOqp77DdHTLDyvQ3eq52VbyQjgrQb6M
         eOvZz5Oa1uBPVaFpe58JKW+QcA7STDraOSZnjvB+jG+Vgyx/5pM7eW+GXwORcKnY2U5F
         gqRj6y1c+qIKIp8OBfvd6WkcI0/CfZu1lpiFfOK7PNwxD4ucyChuOIGFdzOqFDeLAlO/
         RU0fHxjbIEr+yZsJEw6HMc1YGQrhZyHC7stS+cPeDyI7cJk4nzfvF0LHMqvvwTUIdDyq
         kr9CsvWbuEgrsdTMy8vMnECqAr/MqtfeMo8WdyMjQ2ouZV78m9n9kw6J7lp6wHge+mv4
         qHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710218093; x=1710822893;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eBI/dZHSCZMDcyRVph4NOafsCczjFoHj8zNVJflhhr0=;
        b=vGF/W0ykdHoP60zTSjwr+kOb3r0woNx+kVn4PDf06DVH5pOa606NkqC+DMUUJo305Y
         IgwgPvYk1K+ulVorGz4O9LAhcWjjf8MP3256reyraO2MYlGwX3vIcL3t/gm5pmhSmDry
         8uUVFgJu1x8Uks4uilIHY24gGeSrt4I8ZMdr/wX/RA/3m0qBFXkKKv96BIxlU2miJY6D
         M/1D/GYX0SECDFjvg0d4A42fmJjYkDdpBaqM2XIodx4gQwPCjIkvAm+yYPGt9qgBr2ll
         OlkEUV6y5FOIyvPTIV8GNJ9wgnuaTkIu8/exqovQAJPym2ziSXtqhil+EfFuyOaI4YRZ
         b9yA==
X-Forwarded-Encrypted: i=1; AJvYcCW5GTY6ltefSL3pxQTklntLFVgwyhTfzhFdz1jiXiEhzOC3vWO+LhWa2K4gvOnQxunGC+kS5EbKE4XA/KbTUiweQ+07ZFbsZlK9oFNL
X-Gm-Message-State: AOJu0YzjDdjFfmegGfhM9DuCJtPEM2LdnGsOzfKvJ7OpaufYPULuYB16
	ArNtc2z+bUoUh0KNwiW6wC+5qbAS+QLXmsDXzECaTqT/eM+QkZOA70Kal0+I+J8=
X-Google-Smtp-Source: AGHT+IEvAxfmoGYasfTCC3MevqLlFLMvT6Ykp4r1Djy2Y44F7dYNoJPlKmKQBlkurAImzdTXYRkxeA==
X-Received: by 2002:ae9:ec04:0:b0:788:2f37:e7ff with SMTP id h4-20020ae9ec04000000b007882f37e7ffmr9628392qkg.32.1710218093312;
        Mon, 11 Mar 2024 21:34:53 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.8.176])
        by smtp.gmail.com with ESMTPSA id k25-20020a05620a07f900b007884003f9a0sm3342359qkk.122.2024.03.11.21.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 21:34:53 -0700 (PDT)
Message-ID: <a4a55e1c-a7d7-4d56-936d-2cbff0fb2f20@sifive.com>
Date: Mon, 11 Mar 2024 23:34:51 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] RISC-V: drop SOC_SIFIVE for ARCH_SIFIVE
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-kernel@vger.kernel.org
References: <20240305-praying-clad-c4fbcaa7ed0a@spud>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240305-praying-clad-c4fbcaa7ed0a@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-05 12:37 PM, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> All the users in the kernel are gone and generated .config files from
> previous LTS kernels will contain ARCH_SIFIVE. Drop SOC_SIFIVE and
> update the defconfig.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> CC: Paul Walmsley <paul.walmsley@sifive.com>
> CC: Palmer Dabbelt <palmer@dabbelt.com>
> CC: Albert Ou <aou@eecs.berkeley.edu>
> CC: linux-riscv@lists.infradead.org
> CC: linux-kernel@vger.kernel.org
> ---
>  arch/riscv/Kconfig.socs      | 3 ---
>  arch/riscv/configs/defconfig | 2 +-
>  2 files changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>


