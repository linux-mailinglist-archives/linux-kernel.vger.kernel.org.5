Return-Path: <linux-kernel+bounces-153573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E97588ACFCA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79E4DB251F9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB01D152DEB;
	Mon, 22 Apr 2024 14:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="PkVdyipG"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8440152185;
	Mon, 22 Apr 2024 14:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713797041; cv=none; b=sYeLjtYLCnHy3rOF7Z1p91U0+nEhaQCrXtT2aWoRHBJRUprM/vX6SXnupnAeCcyNXVen6nyLPQ7AMARXWgdIVISll/oL7OFXI1JXokPXXX6+T0BrDOD9yjB7sLh5hVbzWWvXmFZMC8BaT1ftQnvzQtGIBjNj2LxK8QI5azkXiqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713797041; c=relaxed/simple;
	bh=yMovu4U6dwLgJL6CC1aBYeE54TAOy5NOEuyjqme4oBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pYiutxoPBnFhJgpPhKt37tQoke/gvuDJDzuwbwE+rpFvi9kx+cLjJzSrnb8o4Uwl2qvT4YY4gUWdN91qS2Q6B3GkbiO0TvkVLOSxEcopOwgNq0YRbSnVlqaGCuQyUorlKjYg9MhuxI4Uf+W3/pjzlVgUvnXDpOKv+S1mACp1Dsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=PkVdyipG; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4VNSgK21Lvz683S;
	Mon, 22 Apr 2024 16:43:57 +0200 (CEST)
Received: from [10.10.15.10] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4VNSgJ6rSDz683R;
	Mon, 22 Apr 2024 16:43:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1713797037;
	bh=E/VQrc1Wk46yNt/v9gfE9nC2UOnA5UyTQmxjteQRhhY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PkVdyipGUROjU9tlrSKwGdUnOqYyt4wV5NyhYM9aKUS0wJsW9YjeIVTNBjpTYcz/Q
	 C9D/DVX2Abv0thUNFVW+n/8L4HBX0P28NJJetVpQu7gufk0OdiJWjM8Vyz7OQSpWSI
	 BAW7QYe8hi87W5/s3exJzbEBl2ur0DahH7KNhnoU=
Message-ID: <be681d47-81d4-470a-bdf2-d147d0cd4789@gaisler.com>
Date: Mon, 22 Apr 2024 16:43:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc: Compare pointers to NULL instead of 0
To: Thorsten Blum <thorsten.blum@toblux.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240404192932.13075-2-thorsten.blum@toblux.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20240404192932.13075-2-thorsten.blum@toblux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-04-04 21:29, Thorsten Blum wrote:
> Fixes the following two Coccinelle/coccicheck warnings reported by
> badzero.cocci:
> 
> 	WARNING comparing pointer to 0
> 	WARNING comparing pointer to 0
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  arch/sparc/prom/tree_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sparc/prom/tree_64.c b/arch/sparc/prom/tree_64.c
> index 989e7992d629..88793e5b0ab5 100644
> --- a/arch/sparc/prom/tree_64.c
> +++ b/arch/sparc/prom/tree_64.c
> @@ -332,7 +332,7 @@ prom_setprop(phandle node, const char *pname, char *value, int size)
>  
>  	if (size == 0)
>  		return 0;
> -	if ((pname == 0) || (value == 0))
> +	if ((pname == NULL) || (value == NULL))
>  		return 0;
>  	
>  #ifdef CONFIG_SUN_LDOMS

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next

Thanks,
Andreas

