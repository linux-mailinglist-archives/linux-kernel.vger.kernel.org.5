Return-Path: <linux-kernel+bounces-124094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3BC89122C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 04:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CEF828A099
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A6F39FD7;
	Fri, 29 Mar 2024 03:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MDx+ur1e"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5108E2E3E4
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 03:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711684140; cv=none; b=Y8ml09k1YzXAtbtQ8ydpUxVTAuVrGL+FTV/XsFLlEkuLTcN4/MW3F84bKbcmma0J/tJwffwINV2uSx/stodIQrIIp6npDUbiWckQuU5Dy7Z7hWMGLR+KtnmSdM5kgiKeSTnx54vFQAxXwIQ8K2/AwCKan4/JDnGevStJltXgPIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711684140; c=relaxed/simple;
	bh=iYpyGSKz67JfOWGPXQAIeOlsiBo0FH9Kf4YBYEJJw6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8Le0x8FxjNL2pTabW+Ka6Bi0bEFOL1Gaezi09OYrNu8piLcoC5cHLp7mp24K0IWCOzivV/IvDMZ1Zd1oKlH9SUo9L7wjFWxW93E+CcEWTC0JtcYtmHLPphZ6J2ZlQSN+klWOR5Ylm8f69BszWd315V6jLYP/TG6xAUyuJLpf4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MDx+ur1e; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-229a90b7aa9so817143fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 20:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711684138; x=1712288938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9NF1vh87Z3mwXJDlnEmyzUpBERWIz9npu85xKfyBrrY=;
        b=MDx+ur1eKD3xF2h3SIYuVNRbtsDEGxYhTiQbkOEOaV2LbF6U643n16NIkJ/gVbxr6E
         WDbAfrYJXqFdgaJRFOXNYK5KYJObGOOsxtj0VHKuRGqAdqlspkW4iKeab6PfE9nDFD5n
         Vy6wf58oc00JtCbTGVxOViVEIgFRMQDGJ4fZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711684138; x=1712288938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NF1vh87Z3mwXJDlnEmyzUpBERWIz9npu85xKfyBrrY=;
        b=Owwp6GB6ctASRMp9rTRSk2LTb1YiIxX/COvQOZeUgjsjc7PCEw+o/0vjoCl8rCVr6O
         ZDsC0crcpzQ5xiak9/xuZOsux0+nkjmSVDrEOS7ThNN+o5S096K1LvSL7Pp6gXJweVTD
         DnrLnr/SrfYZZ85xRjQVXGbF1acekL7KyCl5BaWIEWhV/l0NN1Nd6DsspQV7mM4SPnEo
         FlXosGW9yuHBOt9qSY5QdWyiNjxt9r1MCRg6XhprhPDzZvr+q/WMZtOBO0k3h9eDVkNy
         tsoT2W7UaNDXHYOUf1slKsiUCAdyw8e1j7P7gJL+KD3dxvQLK/PQ7GWemMwMTP97xduq
         3XHg==
X-Forwarded-Encrypted: i=1; AJvYcCUDcrLNur0aUYu7BPs02mfH/X2f/VvUi/eLNtiJg9I8aMP7qxztjtTU/p6If64v4ShvblnThEV6XUp5OtBsBfGv0S2/BZb1S5Z+Mn+t
X-Gm-Message-State: AOJu0YyPqNWjkX2EndWi1dLqADT98N7LYREkeHQUb875gXHPTEClH/8P
	Ao2mD+b4yCdK/K9QuaAbYHzO9dZFPcL0IPv4o6MQ2RsuJ5TeIPRSMIvqSEeBBg==
X-Google-Smtp-Source: AGHT+IGQs8fjf0+Vmp4A35QFugKx0uuEDSNICTAyKaS9T2G734eBLS/S51FKX5YTQJDDiK+jnuUQ8Q==
X-Received: by 2002:a05:6870:42:b0:22a:8443:45bb with SMTP id 2-20020a056870004200b0022a844345bbmr873513oaz.47.1711684138431;
        Thu, 28 Mar 2024 20:48:58 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y12-20020aa7804c000000b006e6b41511fdsm2221794pfm.94.2024.03.28.20.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 20:48:57 -0700 (PDT)
Date: Thu, 28 Mar 2024 20:48:57 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Phillip Lougher <phillip@squashfs.org.uk>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Squashfs: replace deprecated strncpy with strscpy
Message-ID: <202403282044.30A82BA37@keescook>
References: <20240328-strncpy-fs-squashfs-namei-c-v1-1-5c7bcbbeb675@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328-strncpy-fs-squashfs-namei-c-v1-1-5c7bcbbeb675@google.com>

On Thu, Mar 28, 2024 at 09:52:59PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> The previous code took special care of NUL-terminating the destination
> buffer via a manual assignment. As such, there is no bug in the current
> implementation. However, in an effort to rid the kernel of strscpy()

typo: rid kernel of strncpy. :)

> [2], Let's instead use strscpy() which guarantees this behavior [3]. To
> ensure we can copy the same number of bytes as before, add 1 to the
> length argument provided to strscpy().
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90 [2]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html  [3]
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  fs/squashfs/namei.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/squashfs/namei.c b/fs/squashfs/namei.c
> index 11e4539b9eae..6c4704ba8f42 100644
> --- a/fs/squashfs/namei.c
> +++ b/fs/squashfs/namei.c
> @@ -80,8 +80,7 @@ static int get_dir_index_using_name(struct super_block *sb,
>  	}
>  
>  	str = &index->name[SQUASHFS_NAME_LEN + 1];
> -	strncpy(str, name, len);
> -	str[len] = '\0';
> +	strscpy(str, name, len + 1);

Otherwise, yeah, looks right.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>  
>  	for (i = 0; i < i_count; i++) {
>  		err = squashfs_read_metadata(sb, index, &index_start,
> 
> ---
> base-commit: 928a87efa42302a23bb9554be081a28058495f22
> change-id: 20240328-strncpy-fs-squashfs-namei-c-9d01b8975e53
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
> 

-- 
Kees Cook

