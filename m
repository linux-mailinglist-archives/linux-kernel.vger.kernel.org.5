Return-Path: <linux-kernel+bounces-61254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6113E850FE5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5385F1C2123C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E9017BB2;
	Mon, 12 Feb 2024 09:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="KBoUIO/j"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF3A79FD
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707731154; cv=none; b=h9hLHHgG3mYTLmobOjPUNEN7W2PW4/waGUERriWUOJAycnM93VPoknvZfZsVwFNQkRGbuLqKOFG20U8OHd0s/scpUQGRlPLySTbJ0Uf3gWgwHQlVDQreluovxGB0GClY+CRkHbbc8bFY03ysLr17so0HKwD5xiK19fI3ViLJw6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707731154; c=relaxed/simple;
	bh=ySzI4UqQbBVOuOIh+dhwbC+4pxWMgESHX4phVU8ddd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=np2kT4z+i2cSV2UGC8PnSHbAhEBdyA/mMasvMYa6VW6QJLqkd+qiPgp6/Uq4rhm1/fNTFnJJoN+J6uevuJpHcVZ1EUdf3kuCGge+GP+x3djqvy4p4M9Z5pGZ149Vm0okzJtzLlJABefolNWB8+De/IotcOVc5ZMvZ0QGsFJwpJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=KBoUIO/j; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3ca07df603so75490166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 01:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1707731151; x=1708335951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bV4cEl8eqJocUFlkfdXuhYFIA23ZZfBFtqghyorQNs8=;
        b=KBoUIO/jx5jnW73D8Bs1uH4xWh+I5SrXkkgoni+2MJ6D4ZzUyVopckfIeyfzUAQYQ7
         CASxQioh0sKMlOc5KWDwmNHaBB+sp/8X8FEOH8CFb0X1EempfdD66xZVXxzDWC1Oph1W
         BoooGIriaYHYTS9w6sxo7g8769m+AwZiyx044=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707731151; x=1708335951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bV4cEl8eqJocUFlkfdXuhYFIA23ZZfBFtqghyorQNs8=;
        b=dy+5UOKBy+ksVAcaZ5Pr7DJnO/8/WDhB0L8kRqcBfpyA+DPDXjIJxzRjqDSf84M+Fz
         yNpnM8dP9KTpwgjeTdC/Qz/cQEuvj4EqdtHBxodAxFHNkeIw7WOagemZOjjqygd9424v
         j8IGEk24cemVtFEuzgwrubhv4OK67tI8W8ZIK89dFTdQcDDcUq7WlSUT14wzX3wJgjY2
         IKH+u6h48h6/fGTlCP96pCbvvfpyXkSPUkdrCDiP3E7QsAIS6KJ99v8oBHIvuR+PqEL0
         AtQNyoUkTGdaGs0uuajAC6sC/6Y5IUS5fTW076p+kU8eJq4+47dyL9cQ6EriVN3vllLG
         2Xsw==
X-Gm-Message-State: AOJu0YwEMeErc7AwvLzDl+R/2tmfrppSzgIwnvdDCWTg2U7un8NnLYhC
	Z/VGnpFLdmZunZXdnwEgFQP1ARuFTgkh2gSrezpHcSTIiqEaz/EL2QFkin9psvZIRtulV7AHhWt
	UEaY=
X-Google-Smtp-Source: AGHT+IGg9tRYxHX2ne5RUejoxgjNLuWm7IJuXq+jQGsYUF/UDKsC1BWQYq73kligtx67FdufyYx4ZA==
X-Received: by 2002:a17:906:110e:b0:a3c:23b4:e99 with SMTP id h14-20020a170906110e00b00a3c23b40e99mr4875586eja.75.1707731150654;
        Mon, 12 Feb 2024 01:45:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX8131LLFKVmnd//P84XQZ4TM3k291SAAr5rlr+aco+GyHhalP2yDZ1FrvesS0LRgsXOn09QwIfxlhScddCcjYvkngXXTOfhuspMdVUvXq5xufRSNAaU2icj3vLIenGmg44+sk3x86knnboiKUC6O+H+nQzsZ9o2vB+xvMst/X1kofo2PxdYqPXVcWpskkhFoV4nhgDvyNs01vFZNPvhPOGzypnBXDwHJIDG4jDEAGCT6TPBwTg/PfWxIFSUDxm3+tYS03x/DmDEmXkzpuwxRr/YKWqN5MT46T/a4toJ1kUubKmj/nKfAyZXhSXRITXqnExPhPvEz1WECP1l7fGf0ZqHYjwzEBDEb6QCjsIVV4oV3vlNnOqYzuzSWYkRDVR9SJoqkTXFNpVJHtGHArgforDW2IWOXc6J3OquXKzDc0buK0BnUT/l71jW5epBmJLOSXPjvnUTAUwmd9g5ORIxe5JaCTnhVY7
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id y7-20020a170906558700b00a3bbf725080sm30312ejp.55.2024.02.12.01.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 01:45:50 -0800 (PST)
Message-ID: <4ed6af49-610f-4df4-ae06-22a85e052dbb@rasmusvillemoes.dk>
Date: Mon, 12 Feb 2024 10:45:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 RESEND 4/6] bitmap: Introduce bitmap_off()
To: Herve Codina <herve.codina@bootlin.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Yury Norov <yury.norov@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>,
 Mark Brown <broonie@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240212075646.19114-1-herve.codina@bootlin.com>
 <20240212075646.19114-5-herve.codina@bootlin.com>
Content-Language: en-US, da
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20240212075646.19114-5-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/02/2024 08.56, Herve Codina wrote:
> The bitmap_onto() function translates one bitmap relative to another but
> no function are present to perform the reverse translation.
> 
> Introduce bitmap_off() to fill this hole.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  include/linux/bitmap.h |  3 +++
>  lib/bitmap.c           | 42 ++++++++++++++++++++++++++++++++++++++++++

This patch, or the next in the series, should include a diffstat
mentioning lib/test_bitmap.c. And please make sure that the tests
exercise both expected use as well as corner cases, so that the actual
expected behavior is documented in code and not just in prose (which may
be ambiguous), and so that behavior-changing refactorings will not go
unnoticed.

Rasmus


