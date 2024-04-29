Return-Path: <linux-kernel+bounces-162369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3FA8B5A12
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32666B244C5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9286E61D;
	Mon, 29 Apr 2024 13:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+BUAKZk"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB2656B6C;
	Mon, 29 Apr 2024 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397291; cv=none; b=jBIb7/9ehAZmVfKI8e2pUGq4P8Wr8YNDjIZQ32eXL8EKRMxVpgAdFu07XahUkuhpaw8cphESYIIPExBkgDLvYKGTIkpbu6VbYgAJNaVzSBSRcoeTvtasPWvkih2MclV27ubDttFiH0n6W6IqLYKdtwIlnVZU4quV9Hum0y8CrxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397291; c=relaxed/simple;
	bh=pR7/a0by9yBxrfh6k79m1vRnSAYmPWUcYcwe7V2g0kE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ouIcnosTv2lfiHWyp2zwe5u6hEz7XNDIyY+lRqjoaG0KJBo45HJsrOFnVnSpA3ijdGyQ/ckTpK8n1bXo0v0qIkr6WeNR8x4OUDCeEQUBOjaKKTwZE/1nBLnG7RXk0NdjlHR7SAeOWzO0ouRZnsSUGVzxHrj3krQrRyT8joHrU0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+BUAKZk; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-790e7c02430so144627885a.0;
        Mon, 29 Apr 2024 06:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714397289; x=1715002089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zvb50xK6t3u+mnfQxJVlidFaDH9bNsJDchVJ2caNt0c=;
        b=g+BUAKZkDBnVLDlbz6wiUWlDdDuOukfJYBAjC04CBEbMz7enTPF3BlyhO8THuQ1x9q
         e8R983ReNKFUlCrFDUOwwAXLdh1Mw3VhJPPnVYJZ9cSUGaEVylLMwHJRKzAZ+EBYBpWn
         hVQcZmpamnihtMgNMboZ9TD8B9vDoD1aY0CieeLcPZ0qJRzppurrYij3qhQuX1+y2GXK
         aOb3Gh68KI5Hj4FPHWjlD32/7jWlSjO7xitI5c6WM9kiT4jhyO79M2c7lYPCjghJ5bCU
         cNMUqLuII/9qCwQxWa1X7hmaWyWVhv2oHxtYwzyU1fSdjCtYKPVw/qXLMRN9KTMpA2KY
         3Lpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714397289; x=1715002089;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zvb50xK6t3u+mnfQxJVlidFaDH9bNsJDchVJ2caNt0c=;
        b=EnbKfApxs6PhusYQXeE2K7/d6Gm3wCTLYnR11w/Kp2dehPHbCa9qOYxmZme7d4MhrM
         ii2lp7LSwwdnLdr5Gu6iXASXSMLRNVC1xcCNlm47EjZSQnKXjHZ7KbuY1qBaAn6HMXUa
         +Xrnh3fvR4ErbxPXzwy1nSVGwn9O20XUQ/CaD3oUgfG16lp6AZcxRmw9gMTKv7s6c7ZI
         TqrcYLpFUstpO/EonFTN0sJdOyHBzlOJaDrFIiPwupO30jzTiy3iihfmX4UFIJw1G4oK
         Z1He7kL6qMw7d5G+t5E2NGl2PCeRjfA8kd7sj5Ioa09ykj9F3CaKGzlWq7hlC0eLYxEp
         Kraw==
X-Forwarded-Encrypted: i=1; AJvYcCXitax0o+ZasoNS/arW2nwNU/bt+/+mz29ms0kNd3T16SB98dbXcNZC+nZ+bwoS50cWF00IdthdKUxzXSdPm/KPN9e71fZs
X-Gm-Message-State: AOJu0YyXizo+7M91thmK7t1kz7S5kLR6U+JI/ZgUTI63/pk+bHgXI7TF
	8Lc3kQzjUWp/KW+2HAVWLis36vOhW2qVwtE7PEjr1xRuZXLnnNS6
X-Google-Smtp-Source: AGHT+IH2Vufgr8rm7sw/n0lcdtaQaTzClaMd6bA1+jrR1BRGGyolktP24UxusELVdcvcf2HlYYJbYg==
X-Received: by 2002:ae9:e915:0:b0:790:fd4f:3daf with SMTP id x21-20020ae9e915000000b00790fd4f3dafmr1316897qkf.67.1714397288602;
        Mon, 29 Apr 2024 06:28:08 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id pa2-20020a05620a830200b0078ede2e9125sm10353067qkn.57.2024.04.29.06.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 06:28:08 -0700 (PDT)
Date: Mon, 29 Apr 2024 09:28:07 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: shiming.cheng@mediatek.com, 
 willemdebruijn.kernel@gmail.com, 
 edumazet@google.com, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 matthias.bgg@gmail.com
Cc: linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 shiming.cheng@mediatek.com, 
 Lena Wang <lena.wang@mediatek.com>, 
 daniel@iogearbox.net
Message-ID: <662fa067c7066_2e2f1d294a0@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240428142913.18666-1-shiming.cheng@mediatek.com>
References: <20240428142913.18666-1-shiming.cheng@mediatek.com>
Subject: Re: [PATCH net] net: prevent pulling SKB_GSO_FRAGLIST skb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

shiming.cheng@ wrote:
> From: Shiming Cheng <shiming.cheng@mediatek.com>
> 
> BPF or TC callers may pull in a length longer than skb_headlen()
> for a SKB_GSO_FRAGLIST skb. The data in fraglist will be pulled
> into the linear space. However it destroys the skb's structure
> and may result in an invalid segmentation or kernel exception.
> 
> So we should add protection to stop the operation and return
> error to remind callers.
> 
> Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
> Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
> Signed-off-by: Lena Wang <lena.wang@mediatek.com>
>
> ---
>  net/core/skbuff.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index f68f2679b086..2d35e009e814 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -6100,6 +6100,12 @@ EXPORT_SYMBOL(skb_vlan_untag);
>  
>  int skb_ensure_writable(struct sk_buff *skb, unsigned int write_len)
>  {
> +	if (skb_is_gso(skb) &&
> +	    (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) &&
> +	     write_len > skb_headlen(skb)) {
> +		return -ENOMEM;
> +	}
> +

Most callers of skb_ensure_writable pull less than headlen.
It might be good to start with the write_len check. Before
looking at gso type.

>  	if (!pskb_may_pull(skb, write_len))
>  		return -ENOMEM;
>  
> -- 
> 2.18.0
> 



