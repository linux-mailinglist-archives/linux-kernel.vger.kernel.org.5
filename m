Return-Path: <linux-kernel+bounces-51327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EF78489D4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 01:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16BEC28464E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 00:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CED41757A;
	Sun,  4 Feb 2024 00:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vFy5j/8M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B7617552
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 00:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707005001; cv=none; b=sVepxdd6y1yB0sME6yQuVdlmKDESbicXpOJQrFfnvBxX1ob6+LAg2Za+sfq2j+XYjQg1uQCQO52+ZOYu2WFkNB0lCcezxsSJT2EHuTrUm7qhV0jWC9Obir3DcgQg99Q5/amIMn8/rKQRbTjFXY5atCFP4m/+3We6++bCNEoF9zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707005001; c=relaxed/simple;
	bh=9uVwmaAM5huZqY4gBzfXm38+EPR1XsAGt+boomdDfEc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=secYxdBHYanmgd8sdCq8oTjq4t4CgMpKStR2PfRERR6UmXZWCfCn7/jmN8mdfUPzxhyfD+nBeOpI6YXf3q8m6xqd6QWEb4c7LrUAsY7f+3XP+ueJGA+B4f9AV56jg0jVseG68ou66XkDGLizVKevxYUsvPVmiZf6VaQOVOj6ZmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vFy5j/8M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AFFC433F1;
	Sun,  4 Feb 2024 00:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707005000;
	bh=9uVwmaAM5huZqY4gBzfXm38+EPR1XsAGt+boomdDfEc=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=vFy5j/8Me95krpa51lUwEG6igVB8sK6ytXjiIKocN65qddwTW2tbU8YY4US9oGc+B
	 KvNeD79XDNtgVUNs5lUUgo377JfRk5EvOrs8/WYYlOGtABy1lXmVZBHxzl4okONCcP
	 v25zVQxnh7tq0p6CvOZDjsXWHFc7TJiv3HrDvQ+w=
Date: Sat, 3 Feb 2024 16:03:20 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: Re: [PATCH] speakup: Fix 8bit characters from direct synth
Message-ID: <2024020308-until-overact-a7b1@gregkh>
References: <20240203233600.gu4qci36fpnro3ui@begin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203233600.gu4qci36fpnro3ui@begin>

On Sun, Feb 04, 2024 at 12:36:00AM +0100, Samuel Thibault wrote:
> When userland echoes 8bit characters to /dev/synth with e.g.
> 
> echo -e '\xe9' > /dev/synth
> 
> synth_write would get characters beyond 0x7f, and thus negative when
> char is signed.  When given to synth_buffer_add which takes a u16, this
> would sign-extend and produce a U+ffxy character rather than U+xy.
> Users thus get garbled text instead of accents in their output.
> 
> Let's fix this by making sure that we read unsigned characters.
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> Fixes: 89fc2ae80bb1 ("speakup: extend synth buffer to 16bit unicode characters")
> Cc: stable@vger.kernel.org
> 
> ---
>  drivers/accessibility/speakup/synth.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- a/drivers/accessibility/speakup/synth.c
> +++ b/drivers/accessibility/speakup/synth.c
> @@ -208,8 +208,9 @@ void spk_do_flush(void)
>  	wake_up_process(speakup_task);
>  }
>  
> -void synth_write(const char *buf, size_t count)
> +void synth_write(const char *_buf, size_t count)
>  {
> +	const unsigned char *buf = (const unsigned char *) _buf;
>  	while (count--)
>  		synth_buffer_add(*buf++);
>  	synth_start();

Nit, I think you need a blank line after the new variable definition.

And why can't we just change these to be u8 instead of "char"?  Wouldn't
that solve this issue overall better?  We made much the same type of
changes to the tty layer recently.

thanks,

greg k-h

