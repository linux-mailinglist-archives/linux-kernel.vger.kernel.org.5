Return-Path: <linux-kernel+bounces-153572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 291E58ACFC7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93385B2507E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55687152172;
	Mon, 22 Apr 2024 14:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="O8co8mw6"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF461514F2;
	Mon, 22 Apr 2024 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713797018; cv=none; b=DO5NPttBLD9DY/k9FKSdPc91InCNQ5vKVMXw+9iLJxwEvcE92zZ18ovaQkjy4p+kSXLxdA/0C9aQd+WvdwZaAJL4sGgnOWidTLazs/lTjQM6jnv56+M3kx15WdHbv1lONW94YYzIr28WY3DTh1hzCF1SOz95x2v9ZUr9rSnZgFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713797018; c=relaxed/simple;
	bh=JHAVx1UbHScmt4hvKoeDlVoViBT2sv86G8QQ6y0qpBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oNZm0of+UAQ33lZw6v6cXHHY2coh8TXZrrZol8U0n3PbmjxttYxVXDqx1wwC7ZaivDn+Zw3kGBYPxkcodJfrvPiotJ0EZO2AkpLvLLH1G3buQTmOec56UxLlTeNkvTqh+hRDU8UIyNbF2CKxVbC/XBjQ6+l3luFwWKijwqEt3as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=O8co8mw6; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4VNSfs25kcz6834;
	Mon, 22 Apr 2024 16:43:33 +0200 (CEST)
Received: from [10.10.15.10] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4VNSfr5rfwz6835;
	Mon, 22 Apr 2024 16:43:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1713797013;
	bh=fYnT2ay+ckJZ8vZiWjb4Fxs7tz4/M2KnGcKHzTgKOSQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=O8co8mw6WFTRpuYqa+LGFwiaOyxN+TQwfvumh8MAZgZf1IgIA9OVs2/HR9v3MiGF1
	 9qpGdJhfmfU6cPc6VVJqzQGzZl+ji+VLRxI4ajoQbvy5jbDEPf1Ae8yeIi8Ju4+6t6
	 USirjvqdfMI7mp0fsi49B5FOejY+UN73HybcNcPE=
Message-ID: <e9dbc4ac-7724-4565-a1d1-ddf19a6488f8@gaisler.com>
Date: Mon, 22 Apr 2024 16:43:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc: Use swap() to fix Coccinelle warning
To: Thorsten Blum <thorsten.blum@toblux.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: Rob Herring <robh@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240404112313.11898-2-thorsten.blum@toblux.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20240404112313.11898-2-thorsten.blum@toblux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-04-04 13:23, Thorsten Blum wrote:
> Fixes the following Coccinelle/coccicheck warning reported by
> swap.cocci:
> 
> 	WARNING opportunity for swap()
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  arch/sparc/include/asm/floppy_64.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/floppy_64.h b/arch/sparc/include/asm/floppy_64.h
> index 6efeb24b0a92..83decacd0a2d 100644
> --- a/arch/sparc/include/asm/floppy_64.h
> +++ b/arch/sparc/include/asm/floppy_64.h
> @@ -704,9 +704,7 @@ static unsigned long __init sun_floppy_init(void)
>  			ns87303_modify(config, ASC, ASC_DRV2_SEL, 0);
>  			ns87303_modify(config, FCR, 0, FCR_LDE);
>  
> -			config = sun_floppy_types[0];
> -			sun_floppy_types[0] = sun_floppy_types[1];
> -			sun_floppy_types[1] = config;
> +			swap(sun_floppy_types[0], sun_floppy_types[1]);
>  
>  			if (sun_pci_broken_drive != -1) {
>  				sun_pci_broken_drive = 1 - sun_pci_broken_drive;

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next

Thanks,
Andreas

