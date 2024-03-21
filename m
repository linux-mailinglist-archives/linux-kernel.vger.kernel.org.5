Return-Path: <linux-kernel+bounces-110585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9498860EF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 999171C21D11
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21631339BD;
	Thu, 21 Mar 2024 19:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKuqgayI"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E945482E1
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 19:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711049106; cv=none; b=LwXX2BgczkLn3O4PZ96HD0o3Flpw+eHREDs4huB6XEue2uAJgfxgWl32ipgwgYqq3YPDII0i2rLaxhydcdJauWjnXTmXi13kPXGndEpdeoF0sZBmyx5qAMKDM0vm+5ehy0+XN26LTj4U77IczdSKn84k4SPpYP0YXdT5PuKCKXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711049106; c=relaxed/simple;
	bh=W99325GdKfC5YwKQk0YzLebK3NG4WBX8uL80xpBZGz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSihAQUWA+PUu7IjQO3LYjNbw+net96nX6gEIOOP6QiOHDYgGf5wN7iPUGbvJAgNkQapHif0tc3dtRJyEOeJnfJtIEHzVEOVCSBfjOUezUpC9iOUR00XY7m2qLskFQoDsXOiejxBuX0lnixvDaz7AzB0+4bgEt/RxGkWHfCASmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKuqgayI; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33fd12a06fdso803298f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 12:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711049103; x=1711653903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gUDZmuPfNKcqUPQoOA+qrGdJPHB9UPsm7yCMUHTdytQ=;
        b=bKuqgayIeTXLgO/Q7YSfc4SKQYnWA2g+LGoXkYahypCcVLRJVlMdT0cS20jJ2fm9V0
         y/mezJnDXmqgLZ1NT/95vSpYUJDzXZKvV41/1PjV/I4+cm6Yh9GGrQSFHkkNFxKPXgCJ
         2kkR815t2cUSB04W69UIb9UoDeGCH07wh979CrddkbvaYneuv8zqqynjVTNKFLE7RNlZ
         7QZ0mrMEaCxzid9EmRHzobr5NwQmKldKiV6tqwBCZlt7zIrNsxlg4JCZ/oyBfP3Aisg/
         /7oC1WFmTga9zqCVUHBoc0yIMN/dYRZFJkQCSGsd2F5r5rgRuYxInpUKuuF33UifN05C
         4F9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711049103; x=1711653903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUDZmuPfNKcqUPQoOA+qrGdJPHB9UPsm7yCMUHTdytQ=;
        b=sh7S7v9vbyJiiudqvQQZJm0J7p2G3Xy2g93nPaOhaEOOvHoSuLrDHqPf7V9stc9raa
         uQqoHWiBlz7tRjS3oMAWaq6+uy0ly1MnKEh4IKNA5//kgtc4CIbItAzgkujlDaH8GWP9
         IszU3NKo0xh539rXAkqK7hnxUvUWN3IlsPOcKv4DGR9SPPxTvLksfT5YXhnJc76DtB6g
         LOIM5o+Y/o9OQtZq6M4txYmcLXeuuiRTGFFa4lATCsN446DlXhDbgwahbeFzVFitpVh0
         EVJaGX8t0ChsBBVklv81PYam355MZJ1vOnkC6REgCu3D0oaEKC9ugBNk4KlOvmp+RnXw
         frdw==
X-Forwarded-Encrypted: i=1; AJvYcCVAX40oQcSlmC9OYzK5N8+C4c+byFD9VGx9kmV8Ntscv6XPnCfQHRdH2yOhKudYOBUp7zAYV2RE1OFkMohcvgo+PhqqSrBWqOYJnj8L
X-Gm-Message-State: AOJu0YxTsjyJZAjgG08q8axmJ+ifC1EeGCUEkMzkgqhbUt/Up8RvLf4o
	rI2RzS44PPZuSJ8wewZWTAp4FP91pyNJ9rBSIYxkMw/yT2YfLwex
X-Google-Smtp-Source: AGHT+IECBwVzKgNAEAgXlaTkkPeBGq1N9yUzojcZrE4rubz+ZOx36PjUOV8oSpZu5RYBUJneqMwzLQ==
X-Received: by 2002:a5d:610d:0:b0:33e:34b7:895f with SMTP id v13-20020a5d610d000000b0033e34b7895fmr79695wrt.24.1711049102497;
        Thu, 21 Mar 2024 12:25:02 -0700 (PDT)
Received: from gmail.com (1F2EF04C.nat.pool.telekom.hu. [31.46.240.76])
        by smtp.gmail.com with ESMTPSA id i5-20020a5d5585000000b0033ed7181fd1sm301503wrv.62.2024.03.21.12.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 12:25:01 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 21 Mar 2024 20:24:59 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	John Allen <john.allen@amd.com>
Subject: Re: [PATCH 1/2] x86/microcode/AMD: Add a patch revision number union
Message-ID: <ZfyJi2xFbxqyNR/G@gmail.com>
References: <20240321120548.22687-1-bp@alien8.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321120548.22687-1-bp@alien8.de>


* Borislav Petkov <bp@alien8.de> wrote:

> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> Add a structure which will be used to split the Zen generation of
> microcode revision numbers into its corresponding elements. This will be
> used to match microcode patches a lot easier and obviate the need for
> a equivalence table.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Cc: John Allen <john.allen@amd.com>
> ---
>  arch/x86/include/asm/microcode.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
> index 695e569159c1..c1de0a6aefbc 100644
> --- a/arch/x86/include/asm/microcode.h
> +++ b/arch/x86/include/asm/microcode.h
> @@ -47,6 +47,18 @@ struct microcode_intel {
>  	unsigned int			bits[];
>  };
>  
> +union zen_patch_rev {
> +	struct {
> +		__u32 rev	: 8,
> +		      stepping	: 4,
> +		      model	: 4,
> +		      __resv    : 4,
> +		      ext_model	: 4,
> +		      ext_fam	: 8;
> +	};
> +	__u32 ucode_rev;
> +};

s/__resv/__reserved please?

Had to look twice (ok, I'm lying, had to look 3 times) whether it stood for 
'reserved' or some source of 'revision' / 'reservation' thing.

Thanks,

	Ingo

