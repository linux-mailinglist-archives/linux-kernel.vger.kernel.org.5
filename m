Return-Path: <linux-kernel+bounces-108161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 942338806E6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC241F22EB4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97CD4C626;
	Tue, 19 Mar 2024 21:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YzKnAYJy"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0963BBD7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 21:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710884690; cv=none; b=rfpolcgqUmiq89lbvVo4YgdMn4IxvQw7puIvX2sj0y94z8ew22YZme63jmtCiQ1fby2ObyL/N1ZV/Ml4kPsDIZC73Mqi7BOuq2beIwepgbs/GOfIyBPt59Ta8EeCGe5S5JQQtmi2eooozVgv2LsSleHSMnSnYf57U9o+YQnkZBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710884690; c=relaxed/simple;
	bh=eBhcJkjdIZMXWCWXz9E2KeEXBdZhRhMUhqzS5PYUx28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaMj/+d+5wTqDhat+dx2IK5wHBx+cMe/ukbhS8jxjjRJb8E0pgMOGoTy5kEZYMqhDGke+cHEMmzbNPQbGdNYT7VUeLdm+bnK7EsjhSVLFAR4AIP1cR6BC9lTLmBNw1pfaJ7Yq2d8pvnRkXhIUMRKhpmdQMIAhwnY9atuOwIAp4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YzKnAYJy; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e00896dfdcso19342615ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710884687; x=1711489487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b4jDMTaEh9Tmc/RAOO1DLFWKOQOj35T+6qA1lIMjBb0=;
        b=YzKnAYJyPyVU1ZCnmtblJF0iSVjoOegMvXZv5uJdE5tGlCUpSq9fSosZODrT0BrFtA
         BNJyDJ3ZRFeM7tOEc8yYO9Ri3BmzEOG24FlyszeEf52QJnOnY0yV9p+ufjFkeyCLckHT
         R5mETtg1wGOQD2d1RoqrZRjoabeT5gxDbM5wY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710884687; x=1711489487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4jDMTaEh9Tmc/RAOO1DLFWKOQOj35T+6qA1lIMjBb0=;
        b=BRV8yzl78rzmSDOmhjugsOAkP2ulG5Hkxs9h6iNza1NbHmpAucdR9HRAx4wiNWL4Zv
         stMOSRJRoPfQhXylBuiO7RQneac+Mm/TPdMSIUBpZaoMLUUpwx4mby67rnLNpWkTFEOs
         uVuSdy6jTurFlML1jkUCaJ4PWEj7tU4raYilXcxYdl6BmmYJzUO/k5ot3eWiVQ0n96NP
         cLhJ/CQw3FVRWt2Lj9UGtgZygSDiuVgxT1lHzRB0O90a/DlDt5VTQPRBX1QYpSsMlc9I
         TanG2L1lJJet1qvPrqVCGNu0LrgAQaD4rhxIcUw1UnbrGpebHN/WUsAa6vO0n96RAgUH
         ljjg==
X-Forwarded-Encrypted: i=1; AJvYcCX09H003E60qGupQvayGAfhgj8AcSH/kuGjI3xVlqbH43j+eEH2kdERL28+FXo2qStug+eS2I+xYlz/T7iL/bJ9bCOpVtAqc/4cTvXc
X-Gm-Message-State: AOJu0Yy03HQZZLLMN5QwDe7CCg213JsMJDAW2VDNN+QthfzljDKauFW5
	mJFEF6qSrlPprLgGX/CUmJK8sQzIIDNGvllFcktCwQ60rleLehDtvNpSpKiNng==
X-Google-Smtp-Source: AGHT+IE5OC8LzVRzLn5nTU5QYo7UeQmmxs9m35kXMJwGMfexxRccoDwLT4tRF8BNtoPmHD0tgyYoGg==
X-Received: by 2002:a17:902:d549:b0:1e0:4aac:e543 with SMTP id z9-20020a170902d54900b001e04aace543mr2800312plf.38.1710884686935;
        Tue, 19 Mar 2024 14:44:46 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902ee4d00b001dd7d66aa18sm11873034plo.67.2024.03.19.14.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 14:44:46 -0700 (PDT)
Date: Tue, 19 Mar 2024 14:44:45 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] tty: n_gsm: replace deprecated strncpy with strscpy
Message-ID: <202403191443.0E396FCA@keescook>
References: <20240318-strncpy-drivers-tty-n_gsm-c-v1-1-da37a07c642e@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318-strncpy-drivers-tty-n_gsm-c-v1-1-da37a07c642e@google.com>

On Mon, Mar 18, 2024 at 11:02:12PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect nc->if_name to be NUL-terminated based on existing manual
> NUL-byte assignments and checks:
> |	nc.if_name[IFNAMSIZ-1] = '\0';
> ...
> | 	if (nc->if_name[0] != '\0')
> 
> Let's use the new 2-argument strscpy() since it guarantees
> NUL-termination on the destination buffer while correctly using the
> destination buffers size to bound the operation.

We may need for -rc1 (or -rc2), depending on when subsystem tree re-open
for landing patches to use the 2-arg versio, but, regardless, it looks
right:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  drivers/tty/n_gsm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index 4036566febcb..f5b0d91d32a7 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -4010,7 +4010,7 @@ static int gsm_create_network(struct gsm_dlci *dlci, struct gsm_netconfig *nc)
>  	mux_net = netdev_priv(net);
>  	mux_net->dlci = dlci;
>  	kref_init(&mux_net->ref);
> -	strncpy(nc->if_name, net->name, IFNAMSIZ); /* return net name */
> +	strscpy(nc->if_name, net->name); /* return net name */
>  
>  	/* reconfigure dlci for network */
>  	dlci->prev_adaption = dlci->adaption;
> 
> ---
> base-commit: bf3a69c6861ff4dc7892d895c87074af7bc1c400
> change-id: 20240318-strncpy-drivers-tty-n_gsm-c-ab1336e0e196
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
> 

-- 
Kees Cook

