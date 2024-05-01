Return-Path: <linux-kernel+bounces-165734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A878B905B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 22:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D7128426C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60846161B53;
	Wed,  1 May 2024 20:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Dst0cKx"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58746161319
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 20:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714593856; cv=none; b=LiaVnx6qTdNzdDXe9F7NhEUuyZ41rxktcMoho/jUjXyOAGyBJrKgmT1lMKyQI9q6NNeDSNmwS/0SZUFcxoGWvQt8Fvz+2b7bObZCPRglB0qY8PExeq3GXsBNPtSzspYlWpixG7hCMH/JwVMgfvgn2yGKgK3Y1g5HnbsHMvZka2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714593856; c=relaxed/simple;
	bh=goFmT9k+2JBPJZfg9ckRb9nR9k6bSBMAukkNNw6B6Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTkI5LK0Vs4mWXNPoO6h5aZT25rVWL8K7cgDrirNyp6FMY0fUZ+sWLDJZG8MDV6UP1Q0HIPxbHlm8GNDpMY44ruXVD1xqOqxnp/zKPF/MP+97wW2Cefk0mxs2IFMVX+w0XwEjDpamDdQU3J46OLnUXxCSKyf+HnHEvw1RQSpaXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Dst0cKx; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7dee8d177e1so44395439f.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 13:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714593854; x=1715198654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=la4DlPMR/LfwCzRSAUSsTV1pUfLPTBPpS3kAQ67eY88=;
        b=0Dst0cKxRAN94eQXZsEOLg8krWQz3TQsYZ1f/u6n9FX72Kl/C+L5A1/y9GDu1SZLPl
         rKD25k7N7AU6YwQjJjyKazefqadIwmW5C8dRG1j/oh2ner+lT4EuO6bJVZRYkp49Wutv
         9WrAflyCslzVnf7Pmhp28ohqVmshCfKWPT36Y4Impy2XrgNlDh9ILVhyCk9mdw+ptrc/
         CwGsgTYPE43vgaaebaRzpzWda+p8i38QafhBEvqbmqt0lqZq6+7K3pMSYSNrhaMstgSw
         VDhmt91s9FmZZ7pjKEokcAo5YToLqKC1rfGJ6Rd6/123ROZOD8luy9TfeCYHIcmEwnEW
         RB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714593854; x=1715198654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=la4DlPMR/LfwCzRSAUSsTV1pUfLPTBPpS3kAQ67eY88=;
        b=GouKuU0ArSG/dEKtRFgA68M5Ur0wjsN4QxClmnFaoA0YMw2MOt4ZFDthFBi9DU6JQy
         9bxiTevqzrGs0CssEuvl48yIxhE+EW7SAvvT7kh60K64WLm9mfd781gTEUi9d7UGvAK6
         jaVnl/rdhkaurd1AuHR9g4kAFdsxjztxdjwY54aCuRCqw5/KdMGV1++Cu0rPtk6vJH7w
         Br+OJtbB/gSvSs+7t0hSkZ38wHWHkfUA76NOvbdoswxpY/3fjWVYR9QRopbgN4Bcm80b
         IVMpmjXrqsmotL/uZWHtyvMfv4Pa7FpL7NzAG2hsT6yLX+JQGrmGIu9lq6Gd5w85YBzU
         YSgA==
X-Forwarded-Encrypted: i=1; AJvYcCW5oB19BGjwP8s5AV4c1WTEZSRtCeMqm/7XKhZ3g8VYtgjkDhg24dHTajmprFPqLzw2TNh14C9ksZnr0t8i0pdhEsKHzXC5jdLoYHga
X-Gm-Message-State: AOJu0Yx8BG25Z2NQMBVgYOvMyi/PdW/B3xgGpeCaNY95gzVQgiHV8r9n
	GguVuFeLJkMILFufmy8XSNHWOhu7NzxFYUk4pRQK5rkZ5p5bagv0Tu4tUa1RIQ==
X-Google-Smtp-Source: AGHT+IEEEQZDWGpMnb8dlVbqbwAhZplRKDs07yBgDxjFH/4t0U8l/v9WICZttfLVrjYYi7DRpJYwqQ==
X-Received: by 2002:a5e:c80c:0:b0:7de:ca48:4fab with SMTP id y12-20020a5ec80c000000b007deca484fabmr4120481iol.2.1714593854425;
        Wed, 01 May 2024 13:04:14 -0700 (PDT)
Received: from google.com (195.121.66.34.bc.googleusercontent.com. [34.66.121.195])
        by smtp.gmail.com with ESMTPSA id f3-20020a056638168300b00487bf7fcf5csm1925536jat.179.2024.05.01.13.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:04:13 -0700 (PDT)
Date: Wed, 1 May 2024 20:04:11 +0000
From: Justin Stitt <justinstitt@google.com>
To: Erick Archer <erick.archer@outlook.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Xin Long <lucien.xin@gmail.com>, Kees Cook <keescook@chromium.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, linux-sctp@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] sctp: annotate struct sctp_assoc_ids with __counted_by()
Message-ID: <jtcun2xb3ekurqekt4ckgvu2a2hgqyidkno5a5wwy4br54cqdo@riyxzf3kxtn6>
References: <AS8PR02MB723728DA244A82D97342D6498B192@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB723728DA244A82D97342D6498B192@AS8PR02MB7237.eurprd02.prod.outlook.com>

Hi,

On Wed, May 01, 2024 at 07:01:22PM +0200, Erick Archer wrote:
> Prepare for the coming implementation by GCC and Clang of the
> __counted_by attribute. Flexible array members annotated with
> __counted_by can have their accesses bounds-checked at run-time via
> CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE
> (for strcpy/memcpy-family functions).
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Erick Archer <erick.archer@outlook.com>
> ---
>  include/uapi/linux/sctp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/sctp.h b/include/uapi/linux/sctp.h
> index b7d91d4cf0db..836173e73401 100644
> --- a/include/uapi/linux/sctp.h
> +++ b/include/uapi/linux/sctp.h
> @@ -1007,7 +1007,7 @@ enum sctp_sstat_state {
>   */
>  struct sctp_assoc_ids {
>  	__u32		gaids_number_of_ids;
> -	sctp_assoc_t	gaids_assoc_id[];
> +	sctp_assoc_t	gaids_assoc_id[] __counted_by(gaids_number_of_ids);

Crucially, gaids_number_of_ids is assigned before any accesses to
gaids_assoc_id[] are made.

|	ids->gaids_number_of_ids = num;
|	num = 0;
|	list_for_each_entry(asoc, &(sp->ep->asocs), asocs) {
|		ids->gaids_assoc_id[num++] = asoc->assoc_id;
|	}

So this looks good to me.

Reviewed-by: Justin Stitt <justinstitt@google.com>

>  };
>  
>  /*
> -- 
> 2.25.1
> 

Thanks
Justin

